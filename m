Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6645C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 04:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhK2FA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 00:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbhK2E66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 23:58:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A71C061761
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 20:54:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so33926921wrb.3
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 20:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZ5T6/Br8lCObqUmpwwkb8tljmIEzla7aa+sTgw7rQ8=;
        b=SYB+myTbue2l1Gv/fh226SDXWTn5M/84shHT2/lE93oFov15VGHMCIP1PW9en91rTZ
         OInXaRRR7WM+g4OQr12k9KKJStVgf9mi7xcu1MOeDcQkhdga9WTOHntQwAQg7uGiLjWX
         J1Ftn/mFR0VP35mLMOFRIw8OZslL2WXzjw8X/t11CuwmlJEay6M+2cPTtFxz3XK8jn3h
         sdskBJbmTugSj5e1VEBnKuwgOiw7pQ38mHahk2Y50PyljnG2XX55+clUejbKRztkz96V
         SIwyGsXc3NdvizeRtnzxUN0pGPsFGokg9gn65dxRA4XuyjjgCsF/OkEDS/k8hhUK0x6k
         /qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZ5T6/Br8lCObqUmpwwkb8tljmIEzla7aa+sTgw7rQ8=;
        b=AVwI+7pKZ467/DE4f3QQWe1I2KJ5qNe0J1dZrUunBecaWsdYwLz/aKOtJTZL0Uw1+G
         XeRct+SgYGCUCC88OMwDenzUWLO0FhI4TaPHiUbu/uisQJf9LFLOGS6idsBDy0gSnAm8
         iyGgqOU2xR4C+mHEmSJjwlNhARQq/9y5z0GElZgZt+JU4fVwUxiciuUWRXPiVRR9zrEQ
         RmpA/3SdpMshic7hecKWMDiuAAjE5GyVa9JpELkqJP4mBfdEPcZyxEXa23BqVJPT6lHK
         Z1/kKcjh+ZG5JKNiFmX6TO5epZN0z2AAmwOWZW0nhQN/lc+bv6o/0JEKMa1qwZecFFBf
         MMTg==
X-Gm-Message-State: AOAM530CFqsOqFWK83q92jaOL5m2fmm61QhfbcSRZrWCDRu5o5Xj3OOL
        sna6KtNOEei20QaCaxFUy48=
X-Google-Smtp-Source: ABdhPJzbRdZwsFgBTP/fNK/13W9vJjNlf9kfKPaXCWJezeNmK1SDrVcw5moTWg6kt4FBHlvVeKZeWw==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr31494904wrq.254.1638161664277;
        Sun, 28 Nov 2021 20:54:24 -0800 (PST)
Received: from gmail.com (193-81-61-105.adsl.highway.telekom.at. [193.81.61.105])
        by smtp.gmail.com with ESMTPSA id p8sm12687005wrx.25.2021.11.28.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 20:54:23 -0800 (PST)
Date:   Mon, 29 Nov 2021 05:54:22 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: git diff -I<regex> does not work with empty +/- lines
Message-ID: <20211129045422.fyowpxfabmyahaov@gmail.com>
References: <20211128091521.7ysocurtt4qlgcf6@gmail.com>
 <xmqqtufv50bx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtufv50bx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 28, 2021 at 03:26:10PM -0800, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > diff -I<regex> suppresses hunks where all +/- lines match <regex>.
> > it is useful to filter away boilerplate changes.
> >
> > Unfortunately, it doesn't help if a hunk has a blank line, because the one
> > obvious way to filter out blank lines (^$) match *every* line, surprisingly.
> > This is because for a line "01\n"
> > we have a zero-width match here ^$ (offset 3).
> >
> > IOW, while we succesfully ignore deleted blank lines
> >
> > 	printf '\n' | git diff --no-index - /dev/null -I'^$'
> > 	diff --git a/- b/-
> > 	deleted file mode 100644
> >
> > we also ignore non-blank lines (very surprising)
> >
> > 	printf 'non-blank-line\n' | git diff --no-index - /dev/null -I'^$'
> > 	diff --git a/- b/-
> > 	deleted file mode 100644
> >
> > unless they don't end in a newline (special case)
> >
> > 	printf 'line without ending newline' | git diff --no-index - /dev/null -I'^$'
> > 	diff --git a/- b/-
> > 	deleted file mode 100644
> > 	--- a/-
> > 	+++ /dev/null
> > 	@@ -1 +0,0 @@
> > 	-line without ending newline
> > 	\ No newline at end of file
> >
> > This patch fixes the second example. Is this the right direction?
> 
> I do not know where in the code the breakage in the first example
> comes from.  It sounds like a bug if a pattern is not matched
> honoring the anchor, whether the beginning-of-line "^" or the
> end-of-line "$" one.

THe first example (printf '\n' | ... -I'^$') works fine AFAICT.
The regex matches the empty line, so the hunk is ignored
(but the file header is still printed).
Only the second example (printf 'non-blank-line\n' | ... -I'^$')
shows that we ignore too much, because ^$ (incorrectly) matches,
but it should only match blank lines.

Thanks
