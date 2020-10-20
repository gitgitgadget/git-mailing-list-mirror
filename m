Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F0C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF0D223BF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CKyIexC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbgJTCwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390804AbgJTCwx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:52:53 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50CC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:52:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so431809ilc.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3iTpFqGVK8pS4GTJDMNYjMNrsQmXIrh4lJ+ai+TOVE=;
        b=CKyIexC0FqAHHAWFQ9HmOOLiP3AO+ZWg+huHKk901gKEQZqUxCjOR5Ri6H4RQE7m3m
         9CibN5LvHQkH9FJshsrEP0/jeSNabyqJX4rPtJv6ULq/3sYM8vMCdGMn3tOvFGeNMOoO
         KZEh2H9bS3BoHJIW3MPVm12JLjRLOLB4DeNoLcjSrYzdH5Ct8psvCjwghf4YPSgHAIP/
         9TofQrqlYs4xKYIiRbkKLab2kvj38/zxBvn5scqok6lggeUGudG1VcxVoF/K5ueAR5pq
         24pRO1iJqgDiNj//kLaXfX7OHn39fXA2Bzu28WVv4UaHWtjMT7He8GHgR/KVlvjgx0rb
         z81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3iTpFqGVK8pS4GTJDMNYjMNrsQmXIrh4lJ+ai+TOVE=;
        b=eRXznrQcK5+LB8pYqdj/qwpAle5Py9SU9A2nP5VCqMv4tpG+LxO2G2HK/pqxOF+zVP
         Ne/Bet7f5cDYp6qJzf/IqJD8OL0mC6EcWUV9zBzmYJRbu5Ex0q1mKAvRkMQ2kksTxJDs
         xsNwnraEaV2mhKOWhnCjdChsigTmSSGP6rQ1Jfnl8k9fVGOJFMAypcsNd9EbPJaeH4TU
         EsSpKeCpgw4sIx24or8YU7IMbqUf2ltGWZmHCR7EZYlKUZpqPXoFpYn9l64bFh9LdPLs
         5az0Wke5x2pJiQWX1FXSfUOb0uC222LWiE9QZIKBFkAPBVFzm2pJlyjGoBG7O/oesKix
         DbZA==
X-Gm-Message-State: AOAM532zREtlaGIbwpYNxQbctXiDw+Gw3zVTJDYejCTyLf3/y2p2LkeA
        XJ4XUBWnwPN3jm5pe1xDTojR4A==
X-Google-Smtp-Source: ABdhPJyYNNn1NYDzak74dJ2CVXZxPy1O75lnhgsxmL23EYGyobmiFWY4vvUCLaY/fS3cri9mh4bmYw==
X-Received: by 2002:a05:6e02:4c8:: with SMTP id f8mr357864ils.159.1603162370906;
        Mon, 19 Oct 2020 19:52:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id s14sm466598iln.32.2020.10.19.19.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:52:50 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:52:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Forney <mforney@mforney.org>
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
Message-ID: <20201020025247.GF54484@nand.local>
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
 <xmqqtuupd5m2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuupd5m2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 06:54:29PM -0700, Junio C Hamano wrote:
> Michael Forney <mforney@mforney.org> writes:
>
> > I saw that git 2.29.0 introduced a new make variable
> > SKIP_DASHED_BUILT_INS. However, after testing it out I noticed that it
> > skips installation of bin/git-receive-pack bin/git-upload-archive and
> > bin/git-upload-pack as well.
> >
> > There is a comment that says these commands are special and expected
> > to be in the bin/ directory in dashed form, so unless I'm missing
> > something, I believe this is unintended.
> >
> > This seems to be the offending hunk:
> > https://github.com/git/git/commit/94de88c986712e79c20813ba54e797c4ca83137b#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L2979-R2993
> >
> > Reverting that hunk restores git-receive-pack, git-upload-archive, and
> > git-upload-pack (and only those).
>
> Thanks for a report.  Dscho?

I'm not Dscho, but I wonder if something as simple as the following
(totally untested) patch might work. The rationale is that we already
build 'ALL_COMMANDS_TO_INSTALL' to only contain the programs and
builtins (iff SKIP_DASHED_BUILT_INS is unset) we want, so we could
install each entry in that list unconditionally instead of iterating
through BUILT_INS and checking SKIP_DASHED_BUILT_INS each time.

If Dscho or someone else wants to ack that this is a patch in the right
directions, I'd be happy to clean it up.

--- 8< ---

diff --git a/Makefile b/Makefile
index 95571ee3fc..1b2b085765 100644
--- a/Makefile
+++ b/Makefile
@@ -2991,17 +2991,14 @@ endif
 			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
 		fi \
 	done && \
-	for p in $(BUILT_INS); do \
+	for p in $(ALL_COMMANDS_TO_INSTALL); do \
 		$(RM) "$$execdir/$$p" && \
-		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
-		then \
-			test -n "$(INSTALL_SYMLINKS)" && \
-			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
-			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-			  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
-			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
-		fi \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+			ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
+			ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+			cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
