Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7DC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643EE22CAE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgLDXmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDXmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:42:32 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C1C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:42:07 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id h3so8131825oie.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8GcOgLCd+CuvJRQJDRVZvB5EEXVGXFptWn0pzecPgs=;
        b=gNbTUY9ruHYofmE6za185qwSbLOpIejUFgU/VAMQ6MefGip4iBmvojGZ3/4Y+qKLTb
         xeYYXtrHRQF78zkQq4fVsQnC8bTsMtOLQ9tuTDpJsj7urnp+dEIFfWkQvXhqnDb6yFRU
         Stzqe8C/Oie4FDsz8V2fpQkCB4MDN3g9y57CrfFiOtNe0ri8W/kEm1xrQ41Xj8q23KsI
         MVvh249H6Dkun4Igg5BTV/VGXUSWydDzFQGpw4HQ5jOxtiHNz6xRcIBK2rmrBMYF35xy
         zTHsvbNqQFjAdj7kE87YG7tyHjC/cnCoMEHpKlDfbCyNQAlrYJHWcJuzSmWQoPvopCfW
         Ldpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8GcOgLCd+CuvJRQJDRVZvB5EEXVGXFptWn0pzecPgs=;
        b=Zj1KKhoFOqu9gSvjvywtu4uE4GPSm4SqA14xD7UYRLM+P0+JILX9uXIyZCb6l3ePWp
         3NfmgtZs9sT0EwHROGYuNRs4N80G0kakWIlS1x6yW0ipSrs24BOqFzAKDeObnWq0uc71
         Phcr9woac8aLqd+8qdz5uudmLlwj8FEshFg3DacKyq0R8keI+lmkrmMjB+jHW2pG0/CJ
         rlju7Q+/W6vwJ68a4gsGs1vDeu43PcAHjSgigsOlGBQsP6N7oy+p1cRtg3lioMnWL/E5
         xzFq9Oxui2Nejjb2cXBDgQ051BFeREzSuMSRvsFOHE2UHisNsQThxF4t+3vFJt0YD/m/
         qsEQ==
X-Gm-Message-State: AOAM533lbWUxnnjyX+xIHy1aE5Mpyx0SJaq8PRi7LiiBLYFaWih7ih3C
        yBCRLHI9tzg12/ba8+gXrcTM00OIVW8zbeuxFqw=
X-Google-Smtp-Source: ABdhPJw4b4wniubK8Fxa+eFK1vW1lhv+GXmali8lucBowXatKt0/oPr7KtkBNXfGCzp833rnczmTImMYnbteabujciI=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr4806729oia.167.1607125326471;
 Fri, 04 Dec 2020 15:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-14-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-14-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:41:55 -0800
Message-ID: <CABPp-BFQXV+FdYXqCzN0LtxrK2zYLux66EPKJ8UumBSo5qgJqA@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] test: merge-pull-config: trivial cleanup
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Commit e01ae2a4a7 introduced an extra space.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t7601-merge-pull-config.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index d709799f8b..8a6aae564a 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -33,7 +33,6 @@ test_expect_success 'pull.rebase not set' '
>         test_decode_color <err >decoded &&
>         test_i18ngrep "<YELLOW>hint: " decoded &&
>         test_i18ngrep "Pulling without specifying how to reconcile" decoded
> -
>  '
>
>  test_expect_success 'pull.rebase not set (fast-forward)' '
> --
> 2.29.2

Indeed, quite obvious and simple.
