Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED31C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EDB2070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nagtMtfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETRIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETRIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:08:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD42EC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:08:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so1598602pjb.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vMn/46Tv7eh5s5dl/WssdnfEgyQiN3hsTUOWTcKdHVQ=;
        b=nagtMtfs8sRyRxUHCxGpxL+49XW1zcx8KCPebhPpbJL0UDmFb0IbYhDaEgyyazFlfG
         Z3+8EwrMgCGPUNEDN/t/ItPaIn4cSl84u/0VQIQ/VOnjyp4soWU6SKv90NorDMGpWSZQ
         dFx0gdQoa1xurUVtamnZPIYxjAEeQEMm5pJjwibsXmNPuwXd/4T19Mu7OGg9Y6pydA/J
         s3wamY2+oqC/HIKBmmM6GxhwT+MQjHS0Sa+dSb3OyyCtLE5adGOYsVqA+hyHWEqw9kvg
         v2JoRy4Cw/P6Z5TUooNdDpvo7p9pYg12O30dKxAnEp7PbxrylJbh8KEhE1LG6lMTNh1g
         g/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vMn/46Tv7eh5s5dl/WssdnfEgyQiN3hsTUOWTcKdHVQ=;
        b=lChmBOcmccQhshS/JkYx0TiKBeVHt8oax14DDw9OONejnU7TP9xd6ZECcKXbN6WlQH
         JXo0l3p/5Vq9M6H+qr4m/8WXyoa24Tx7z8RP7WPqFHrjZlL9IEA+isYSJjLzLOKfYTLR
         dF85Ms78NNtengrEjL0pz0ui/ni+rJAV4RSplmS7b0J87yn7t8+jFnUxWX+hkxXTiX1P
         ov0c5nXp2MkeZgQKW9o4WMZL2fHCPaX99zUFWF37y60DsiMagBy4NeSbLbgGYjoiziyZ
         hK/qr4g1TFYFj+hq4EbKb4vHtXGxGfK4KRLj8w5d56t/vKDi1/JmAb1OYlPgPThdjEne
         o8/w==
X-Gm-Message-State: AOAM531+fmlodYWM1xEFwcZQr5kdoABSD9Q8IOZuRyQ+2fGjfJQCxdrc
        RxoZ270tPvb0aBPcDgjIbto=
X-Google-Smtp-Source: ABdhPJytdxrJFR2AGlhiv/dH0n3dks0wIiPiF8Fhvjft/ymPAth9SAgQLIKIbOvt3YI5Jha1xY0C/g==
X-Received: by 2002:a17:90b:ed2:: with SMTP id gz18mr6623877pjb.22.1589994526122;
        Wed, 20 May 2020 10:08:46 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y75sm2561982pfb.212.2020.05.20.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:08:45 -0700 (PDT)
Date:   Wed, 20 May 2020 10:08:43 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com
Subject: Re: [PATCH 2/3] bisect: remove CR characters from revision in replay
Message-ID: <20200520170843.GC20332@Carlos-MBP>
References: <20200520034444.47932-1-carenas@gmail.com>
 <20200520034444.47932-3-carenas@gmail.com>
 <xmqqzha2wt7t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzha2wt7t.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 07:56:22AM -0700, Junio C Hamano wrote:
> As we know that "rev" ought to consist of just hexadecimal and
> cannot be split into two at $IFS even if we don't tell "read" that
> "everything at the end of line is 'rev'", can we do
> 
> 	while read git bisect command rev ignored

that works (kind of), but will cause test t6030.66 to fail, with a git
segfault nonetheless, because we can't handle anymore a line line:

git bisect start '--term-new' 'term1' '--term-old' 'term2' '32a594a3fdac2d57cf6d02987e30eec68511498c' '88bcdc1839f0ad191ffdd65cae2a2a862d682151'

IMHO it will be probably still cleaner to do `tr -d '\015'`, even if the
patch below avoids all current issues from the testsuite.

will follow up with a fix for the segfault, unless someone else beats me to
it.

Carlo
-- >8 --
Subject: [PATCH v2] bisect: avoid tailing CR characters from revision in
 replay

6c722cbe5a (bisect: allow CRLF line endings in "git bisect replay"
input, 2020-05-07) includes CR as a field separator, but relies on
it not being included in the last field, which breaks at least when
running under OpenBSD 6.7's sh.

Instead of just assume the CR will get swallowed, read the rest of
the line into an otherwise unused variable and ignore it everywhere
except on the call for git bisect start, where it matters.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-bisect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 71b367a944..08a6ed57dd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ bisect_replay () {
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	git bisect--helper --bisect-reset || exit
 	oIFS="$IFS" IFS="$IFS$(printf '\015')"
-	while read git bisect command rev
+	while read git bisect command rev tail
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
@@ -223,7 +223,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
+			cmd="bisect_start $rev $tail"
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-- 
2.27.0.rc0.187.gede8c892b8

