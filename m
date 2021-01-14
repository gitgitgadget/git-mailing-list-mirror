Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BAC433E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2A623359
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbhANJY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbhANJYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 04:24:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FAC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 01:24:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so4822383ejc.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 01:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7xtTrrj88iEL+DWdSWUBoYmB4+ZsDHuMNcxz+qHa9g=;
        b=SkzIbJj941PPTZXLT4/l4BinAJ58789mMbNdVYVAiunxUiIuDNyATFPgOQxGWJIZ0K
         o3qDRogW5aPmUhkKgnTMcUWjoCbdlu4PqKA8hP0HIPb4d2PBk+kDQ6NW7IC6kTFoLFr/
         /91hWwQicOZ/CXSaiSlr+nsVGkaT6gbHRTRBSpMu4IOylz/XiMJkYWpnunlkrDFcDEje
         1O2vUeBom21xENXP6gETNYPVrZEN85DAHUnm1RO96z1kLwoLuLbcSRIDIa6XIMIzHGxO
         sMMuhxvipT5rFQpb2vixciHoTcScOR+q0yUFX5uHp/XMCFNseFI5AchDmraS/TQEAMkx
         3hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7xtTrrj88iEL+DWdSWUBoYmB4+ZsDHuMNcxz+qHa9g=;
        b=WnQ+063id7DFVRf6DUfdfig/yGa5Nrm5Ye6EVAkSM4ygtkfLgJ5rgpfGpqaIoadQ0v
         x32yBWmv1SVlfeO8vOfO/i2pwc+0Q6PlcCAFcAkH/QW59jATUiEpWVUdALQ8X5dQvpGV
         OOomXxI9WL/VE7AS3o/c92dxao18/Fg68xGVCH3aYnN9JNA21emEYxNcDvRO+Su6bVWD
         Uq6lMeAZR3bSL79EnmfauRn+V2NVfjGInlhfYNtmjdD8K5eiL6fEROgl+7jD7aryYQsB
         wL1+mQJPf/9qoylFB1N/xrbnNwwnq23XsSHRWOIXEQrLBkCf06t6zssEHL+sjLBPjW1u
         IYyg==
X-Gm-Message-State: AOAM531WVEFnpprlfvOxipeIxbqKWamPCFci4kxtH7fD/R+Z1kW9nRzG
        CvrtfWfUQhgljNRrYOq93IriDmtrgmOXH4UNF/Y=
X-Google-Smtp-Source: ABdhPJxwuafkgepZhRviHLBBGFCkqwyt7xEAvIM9h6MZx2KzL2aAv7nBGsfCRGTIZmLJKKR8KiUA8s+jMN83/fIJjMU=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr4666384ejb.551.1610616250602;
 Thu, 14 Jan 2021 01:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-7-charvi077@gmail.com>
In-Reply-To: <20210108092345.2178-7-charvi077@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Jan 2021 10:23:59 +0100
Message-ID: <CAP8UFD2G-2kEbajYpi7kGn=E2HriTuhKJRgs-vEDvHC7WYCGQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] rebase -i: add fixup [-C | -c] command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 10:26 AM Charvi Mendiratta <charvi077@gmail.com> wrote:

> @@ -1740,34 +1746,177 @@ static const char first_commit_msg_str[] =
>  N_("This is the 1st commit message:");
>  static const char nth_commit_msg_fmt[] =
>  N_("This is the commit message #%d:");
> +static const char skip_first_commit_msg_str[] =
> +N_("The 1st commit message will be skipped:");
>  static const char skip_nth_commit_msg_fmt[] =
>  N_("The commit message #%d will be skipped:");
>  static const char combined_commit_msg_str[] =
>  N_("This is a combination of %d commits.");

[...]

> +static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
> +{
> +       strbuf_setlen(buf1, 2);
> +       strbuf_addf(buf1, nth_commit_msg_fmt, n);

Should "_(...)" be used around "nth_commit_msg_fmt" here...

> +       strbuf_addch(buf1, '\n');
> +       strbuf_setlen(buf2, 2);
> +       strbuf_addf(buf2, skip_nth_commit_msg_fmt, n);

...and around "skip_nth_commit_msg_fmt" here?

> +       strbuf_addch(buf2, '\n');
> +}
