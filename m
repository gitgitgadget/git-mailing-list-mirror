Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA0C4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA459217BA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgLCQq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgLCQq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:46:26 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E6C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:45:40 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j12so2332504ota.7
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jytjn1GnOzsyWccnFlDu2WjQ+KfNyntugnvqV13r4sI=;
        b=vLGY+WAFJXis5t6pX4BoYShflcWnB9l4sYlyueYJ8sp8xediPVKimN7fwd4wDkQZYN
         4Yb7GyBEsDRSQhu0LiwZIaR8dxZxu0ca8tpvj/wihIdMs8WQYtU76HtiIPdjcGYyI83/
         ba/Lm+892dmI1liqks3NtAwcCcAx+INWPkVGcuTIQYEvndDlE3lyOm9fD2Azt1A/QxSZ
         4mEQXDPNpuz5e7j1r5glbl6C20fTxb7KNCUpJ88IdXYnk66IgUdk4bjrV59DcDw0hQ+j
         CU4tFbcOo8ynwv7iFn2ClwQihYhCBjR2MaoGZ676AqZ4N7vLYhxiXX7AwSlfwatJQXfv
         pg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jytjn1GnOzsyWccnFlDu2WjQ+KfNyntugnvqV13r4sI=;
        b=RQR8rYw727+j8Op+aCCBbtBD6XrAOXZSWGrylGXazq64sbY4jSmPz4gRODOLGrjaFG
         x34QBTlaUfeGONfCXcyaVD1YeWrRJuN5K/BlPEkIDn/qLiAkBG+p72D757b2j2CqFu1Q
         hi9U+23eDWuy04AJi5F3pPLsAQwWeB5d4mFB+WiYFcDZFKH1cshe2gxAGdfcMnm5OSqU
         hsXMhfHuyjlYUf4+EoItItVXbAoiGE02LdfkuIW7fUr5mUyHuokyZmdihfo9YCkjqGSZ
         Trz05mPSHJAscaE+JFpm7Y6CeZVnk6RsXFpAurpwbgbAA0TvfB0N0qzAkV6ujwAViBxZ
         Jc/A==
X-Gm-Message-State: AOAM531vVd++4ZF5eek67LHTlq51IP3mtfTH+ysDW6Qi9oygqkX/EvDe
        Z9qTA7o4ZpwOBIkbN/lDdWdh4Owspd6LV2IUQWM=
X-Google-Smtp-Source: ABdhPJwrvDnonngl6ml7AGxhchpGx5hSQKG+q1yz8fGz7OoTd2a4VFUQZA0NdmhwihYSdoNvvPClYi1fxrxSIcRX5tg=
X-Received: by 2002:a9d:3a76:: with SMTP id j109mr37932otc.186.1607013939834;
 Thu, 03 Dec 2020 08:45:39 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com> <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
 <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com> <CAN0XMOLHM0mFvXcdiXJS_yD59rSTuyJpp9N9MLvcZ5LCC1-yZA@mail.gmail.com>
 <168be31c-f913-4bda-cf05-adcc07c51ec8@nokia.com> <CAN0XMOLdz3bk+wehy-+0_XGLX6722jb71vvzNPXrryeeFuxd0w@mail.gmail.com>
 <5869c005-468b-8686-3022-3fa18f28f96e@nokia.com>
In-Reply-To: <5869c005-468b-8686-3022-3fa18f28f96e@nokia.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 3 Dec 2020 17:45:03 +0100
Message-ID: <CAN0XMOKYKkKPj0rpE-b-6pvzJ7Tcr3Ycpu+ynunge8Yz4yNWcg@mail.gmail.com>
Subject: Re: BUG in fetching non-checked out submodule
To:     =?UTF-8?Q?Peter_K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

Am Do., 3. Dez. 2020 um 16:10 Uhr schrieb Peter K=C3=A4stle
<peter.kaestle@nokia.com>:
>
> I translated your sequence into a bash script, which can then be easily
> converted into a test case for git.  Problematic was the infinite
> recurse loop of the git fetch command, which I solved by grep'ing for
> the second recursion output and abort using -m1.
> Could you please confirm, that you see "passed" for the good git
> versions and "failed" for the bad ones?
>
>

I can confirm that.  It "failed" on current master version
2.29.2.435.g72ffeb997e
and "passed" on the latest tag 2.29.2.

Thanks,
Ralf
