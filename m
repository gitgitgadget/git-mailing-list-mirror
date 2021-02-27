Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2288C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 05:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D664D73
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 05:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhB0E5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 23:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhB0E5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 23:57:50 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F83C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 20:57:09 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e45so11175711ote.9
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 20:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGvrONWlLZjTFOStsO/ywVnOw1oewHdxKxkiGSW1EcQ=;
        b=LqdHSbPTkrTAkuIWLVSlWNW7yBNPSPH0zclscJLwa8SdZu6klsBrFCC2sMxgv0bl45
         7H8Uqeajo8q2eReZ0XdVk4R6vpcOmFqvLZFCCUfSfFpfBZ6O206yLl5pp7yhmIITv/Fe
         aPWry6ksaAyPQoTKkn1SJAJC7ZCtRgNjocMigs4CqkcfcRndBAPnBuANgg6A6dW/9y5c
         GO9S9k7Xcid0PNn6gFZ0eJA+zoWyciLKSnLaMOS8HaL/4j7M4U6zeOFwBh6YJ1dniu39
         ty1sIFi5Qp0YlOLPW+rWBRINB9D0VyGQMwcuzum7AqEikrKVivdaEkBNKqd+30SsL1IU
         LaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGvrONWlLZjTFOStsO/ywVnOw1oewHdxKxkiGSW1EcQ=;
        b=LMdbOU8YBlL8tm6emkO3+oeaZjf9amH07P217yBO85Y0riABEf+s67xUr+rvXenVoJ
         KFCQkH5YiMKTdCLPbFcIh1lFHYbooYMvsBO5hPPwGFRsMXNm6+amaSv8PojWT9poMm66
         w4ohV95UBv24U3PdUfo635ErSzeyZoVm9aiOZgp2AfyuVGIdF7j/dS0nGzOfk4biger8
         hyc1vMqhb6tHWtEeyf5U1wooSnBnp8kfKDlgCsg0YNVEEyERT8C4IDUGbK/ybbQpWisV
         D4vEa//BQk5dRxmkPOHViYO24PDV507zo9Mw7wJYvwoDcFD7mZ6UeRelNoCgdEhl1TAS
         pLUg==
X-Gm-Message-State: AOAM531mshTp0EZBScLrxieMfS67DUaDWjX0z/xrLBLdN//Pf+MuTdDR
        IAVsV1crgQvLePW41CCvn9+4UHpY9AEDQZIkYNQ=
X-Google-Smtp-Source: ABdhPJxEGMdpLm/w8o788UnrJAzOsfLiZ1GBeWDEpWC1uWy3W7zdABX/vZQHfwa4nEG/BLbbKYnN6LeN+VFqLb1iyHk=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr5251662oth.184.1614401829174;
 Fri, 26 Feb 2021 20:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210225100855.25530-3-charvi077@gmail.com>
 <xmqqwnuvsw0d.fsf@gitster.g> <CAPSFM5eKnqOhDrZWEd-c_sDNMbQkqtMwpFM0zT-gOVHvMtcZnQ@mail.gmail.com>
 <xmqqczwmsjzl.fsf@gitster.g>
In-Reply-To: <xmqqczwmsjzl.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 27 Feb 2021 10:26:58 +0530
Message-ID: <CAPSFM5fhaG1fgv30FvOSL-tfpuPiePFYoax_78dvs4Mh8H9tgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 27 Feb 2021 at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> > yes, those options are caught earlier and give the error as below:
> > "Only one of -c/-C/-F/--fixup can be used."
> > and only `-m` is checked over here.
>
> And the reason why -m cannot be checked early is because we do not
> recognize which kind of "fixup" we are doing when "only one of
> -c/-C/-F/--fixup" check is made before this function is called?
>
> OK.  I wonder if we can tell which kind of fixup we are doing much
> earlier, though.  Then we could extend it to say "Only one of
> -c/-C/-F/-m/--fixup=amend:<commit> can be used", etc., and we do not
> have to have this "only -m is checked here, everything else is
> checked earlier" curiosity.  But I do not know if such a change is
> necessarily an improvement.  I guess a better "fix" would probably
> be to add a comment to this function where it only checks for "-m"
> and tell readers why -c/-C/-F do not have to be checked here.
>

I agree, earlier I even asked myself why only `-m`, but this was the
only option that was allowing to write/append commit message in `
--fixup`. And I agree to add a comment, to make it more clear.

Thanks and Regards,
Charvi
