Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CAC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F892313C
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgLWOYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLWOYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:24:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E423C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:23:34 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id f132so18323982oib.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=B1hCPzqNztvgqNW7ruXSSoHAJ9YSRiwNfYjjpx1ADAU=;
        b=njVs6RGD6fmEdKpUMsMa6EKfH/Lx4t6Q5/aJHLEcWa/GfRNBMpvp26HiS8CxB3gaA2
         NOtHrhHs/LdX/Fxlgk16jeDjaxlq3mI8BHrLob9lTlJdsxwPU2Sy5REJzfi4WFrWVmtj
         ZmAn6rT2k8K1u0AQcYCZajs+P+3QZF3IewM2UDtNdi9U9hBCVRpn+VNx3SDMntTxRmdL
         JbRYRj9joOHbleKtGcoYT7pR+SJBqjdiIMCv14yFNR8UsJLL8NIRv57uoZ60MCD+BqP/
         6UrVyiCaYaZt8B+HML3eFKfb36mNMhhysTzIDYtftczEqXhc2oN91VKWJ1Az4qMGSMYJ
         eUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=B1hCPzqNztvgqNW7ruXSSoHAJ9YSRiwNfYjjpx1ADAU=;
        b=Dua9oBoasWVC9RTM2lwUtABaMce2aw0TLU1mZHdH+5yVv9a0WqDmffrc/nj+Zm6AoW
         LTpruv7cja2UDbtvbFGQ0ywzaqdQQiCFhhVxm22lUJXS5aMyIGMiL1/bpWf3DejILndD
         mlsbtA0d6Df6B/eFedmzgRG2W5D29sAKXVKrbrEF2xMVIrgMydRya4fx+8EJJDOYTbw+
         p87pTXOI9TNwUGHTEWSyQuGbjTpLZuRFjwlSOpQZhcFM4kuaW4CIcUXOmGaQ7AY/9R4a
         exgdj6KM9cArfzxmNSxb1xKoz+JRqmtdzDatTwdIyF0swSsLo9VVbpuyPC+pr6j1e7+T
         1ZqA==
X-Gm-Message-State: AOAM532XeifTX8ho3nlw9Lcyw40JHpo+u5MKIx+0BX5/3WvJn5LNZ2FY
        lGIOfJoSWvOCiwcPdXM7odjen8sDfUUaeQ==
X-Google-Smtp-Source: ABdhPJxTGBrzhejnupsqYwLLtG9OfAlcg80pQ8xN71PRlLsr9bAB+DwrAlIMjbn99lrFReqJJrOSzw==
X-Received: by 2002:aca:4b0d:: with SMTP id y13mr17486814oia.7.1608733413717;
        Wed, 23 Dec 2020 06:23:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 59sm5306788oti.69.2020.12.23.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:23:32 -0800 (PST)
Date:   Wed, 23 Dec 2020 08:23:31 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe352e3968f6_198be2083@natae.notmuch>
In-Reply-To: <xmqqblekabof.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201223045358.100754-2-felipe.contreras@gmail.com>
 <xmqqblekabof.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > +auto_merge () {
> > +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
> > +	if test -s "$DIFF3"
> > +	then
> 
> We do not want to ignore the exit status from the command.  IOW, I
> think the above wants to be rather
> 
> 	if git merge-file ... >"$DIFF3" &&
> 	   test -s "$DIFF3"
> 	then
> 		...

That doesn't work.

"git merge-file" always returns non-zero status when it succeeds (it's
the number of conflicts generated).

> > +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> 
> Does everybody's sed take "\?" and interprets it as zero-or-one?

I don't know.

> POSIX uses BRE and it doesn't like \? as far as I recall, and "-E"
> to force ERE is a GNUism.

Another possibility is \s\*. It's less specific though.

> > +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> > +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> 
> I'd feel safer if these resulting $BASE, $LOCAL and $REMOTE are
> validated to be conflict-marker free (i.e. '^\([<|=>]\)\1\1\1\1\1\1'
> does not appear) to make sure there was no funny virtual ancestor
> that records a conflicted recursive merge result confused our logic.
> 
> When we see an unfortunate sign that it happened, we can revert the
> automerge and let the tool handle the original input.

What if the original file does have these markers?

Which is probably something we should be checking beforehand and not
attempt an automerge in those cases.

Or we could add the --base option to "git merge-file" so we don't have
to do that work by hand.

> > +	fi
> > +	rm -- "$DIFF3"
> > +}
> > +
> 
> "$DIFF3" is always created (unless shell redirection into it fails),
> so "rm --" would be fine in practice, I guess, but "rm -f --" would
> not hurt.

I just did the same as below:

  rm -- "$BACKUP"

> > +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
> 
> $MERGETOOL_TMPDIR is either "mktemp -d -t "git-mergetool-XXXXXX" or
> ".".  Also, we liberally pass "$DIFF3" to "sed" as an argument and
> assume that the command would take it as a filename and not an
> option.
> 
> For the above reason, "rm --", while it is not wrong per-se, can be
> just a simple "rm", as there is no funny leading letters in "$DIFF3"
> that requires disambiguation.

Other parts of the file do this:

  rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"

I'm just following what the script already does.

Cheers.

-- 
Felipe Contreras
