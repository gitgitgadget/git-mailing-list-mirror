Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F21CC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCFF22B2C
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgL1T1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgL1T1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:27:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A353C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:26:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r4so336227wmh.5
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSVi8uSjDuSAHMeM01gFmWSBITOG3TnPSvbLTG50w88=;
        b=RaBuSu8ofkhFqa0FUdEo2OH6XaD5nwtdOtd+Q8TH92D0E0kYVuoKO4krefruQnXFn6
         k7KttFD+Fd54fG+1dBXFRpjrEkC/0LeRXro4Y7RfzzTVJagbpoBT7OLzlWoM/MBj0GvQ
         Zko2adxMdNWXtFXT2REikJTpEdYSfDkiO+KHOsna/s06yekRnevJ4CXBiVVDsCZ6Tg/C
         YoiNwIDEYkTybLJCmJcWzk8QWF1kY+SnP4eeB07BCLef8jKOrnuehc73z1qI2elur2mZ
         ZjjA2oSC6UuZ7eAjn53t7pR0UV2S0Ro9upYOgkw1gHPIhgSssMj/9xg5658bYsIasirI
         qzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSVi8uSjDuSAHMeM01gFmWSBITOG3TnPSvbLTG50w88=;
        b=QR5DtRtENqk8mHkOzXaPj2Bw/atg/DU7TGlYnaUL4r4UrgnYTP9h2l5YV9DJ3K/UY7
         bzOEVfn9+/gPWqTjh/3Tkj4ve6EDfCPzzbnL4F+93dnSooZHndv3ik7gDyf2Kj9Ivewq
         PI02BJynXeTt11PYOEHR6tZr4z6O/YEI0xpVAxeBiM1RWfzJnbvHqfs9/ePFxYAGQxXZ
         qQWKqzkLyrdejdOP4ASidfm5uv6jqWRky/W4EAIRoPk0LVLwG4XzBFX1a0M0I4nbAxY/
         41esVK3FK8ntN+l22/XVdwsPZbPENQ09/GKhOP3y1f4wpX9DCXoJWAX07MYbxlcPdg4I
         qN6Q==
X-Gm-Message-State: AOAM530a1JLtdFC2yYKg2qEdDllBeEGPGHws4npevVFXyoUTpb9I6aoL
        sUBparJHIMaoSgHgC9F7abzzq6qmY9OqsbDphRhzIPzEZ9c22A==
X-Google-Smtp-Source: ABdhPJzc7tvsSOU9BHOe6lCpfL+fhDFGhqRWvKN1yEoY8k4kJvhLT9Q1lvIdmiwE8vt+gGbjpGZvQyY8mUYDalR9pa8=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr329840wmg.37.1609183596048;
 Mon, 28 Dec 2020 11:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20201228192302.80467-1-felipe.contreras@gmail.com> <20201228192302.80467-3-felipe.contreras@gmail.com>
In-Reply-To: <20201228192302.80467-3-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 28 Dec 2020 13:26:25 -0600
Message-ID: <CAMP44s1e1P0KEG4O0wrgwK7GatxiufRM1d9b2kFms4-G_3zXOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] completion: add proper public __git_complete
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 1:23 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Back in 2012 I argued [1] for the introduction of a helper that would
> allow users to specify aliases like:
>
>   git_complete gf git_fetch
>
> Back then there was pushback because there was no clear guideline for
> public functions (git_complete vs _git_complete vs _GIT_complete), and
> some aliases didn't actually work.
>
> Fast-forward to 2020 and there's still no guideline for public
> functions, and those aliases still don't work (even though I sent the
> fixes).
>
> This has not prevented people from using this function that is clearly
> needed to setup custom aliases [2], and in fact it's the recommended
> way. But it is cumbersome that the user must type:
>
>   __git_complete gf _git_fetch
>
> Or worse:
>
>   __git_complete gk __gitk_main
>
> 8 years is more than enough time to stop waiting for the perfect to
> come; let's define a public function (with the same name) that is
> actually user-friendly:
>
>   __git_complete gf git_fetch
>   __git_complete gk gitk
>
> While also maintaining backwards compatibility.
>
> The logic is:
>
>  1. If $2 exists, use it directly
>  2. If not, check if __$2_main exists
>  3. If not, check if _$2 exists
>  4. If not, fail
>
> [1] https://lore.kernel.org/git/1334524814-13581-1-git-send-email-felipe.=
contreras@gmail.com/
> [2] https://stackoverflow.com/questions/342969/how-do-i-get-bash-completi=
on-to-work-with-aliases

Fixed wrong address of SZEDER G=C3=A1bor.

--=20
Felipe Contreras
