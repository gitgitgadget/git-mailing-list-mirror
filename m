Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E61C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A53F206BE
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 10:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9yZ+vZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJ2KNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ2KNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 06:13:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D54C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 03:13:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t25so2958355ejd.13
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iqR/2TovEBwWMIxufVsVJBXPN3oyX6MOj1sm7g5iFJ0=;
        b=o9yZ+vZlauqR5WeA0Rzy8o+jXpCqkOWBGG8kcleGDwC9jiV4dDiFAHXQU+1i8bTsGt
         EmXn3ogQ9qY0njIur7GXUrIyRHk9eolI8MUYnLlWrqrgi/9deLyBpnaRT0xOSWBZjF7l
         WAmJjfa8o067QHZC8638dk9yCvB53ZRFJEI52te1AsthKaMJgcWM6u0LrqIU9gs2AAUJ
         BKhd67zvEhxJRXVpAVA7o5ua0TZcfTq2SJQiH7G/AMUmuLFjYJHGK7mLwBjLO0SV30yr
         Q5TRIDSQJmmt/ANotm86CwUutuY/QpN8/ZnAvKX50XhS88mPMRr/zFU11N71TunSVO3G
         qDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iqR/2TovEBwWMIxufVsVJBXPN3oyX6MOj1sm7g5iFJ0=;
        b=ETqE6pSh8/Y4p84+yVVqPO5U54G2paCxNixGUejMttVMhxxkE1Aio4wY4yroJw1hhB
         vJmGBps9G0PbqBOTpZ+yGoMHZz7UBs3blDMnbWv28+N07mfRaBS7c+fYh7ZuBkWIInob
         G0WQlqzgAWZ2O0pMtBva6wMZYYRmb4idejGhXIGApA22ffn+fKG2wRNAkxKhCQ/Gj46E
         eV7285oZrsDQkVRfljezriZpAutxbb9kuKaE8mB3CeRKt7ns8j9IMJk1YwrYs4Kgb3IK
         i54inMxROVlv6zcCnLfi/oXkTsFcjQPZ1IF7leR3u6Ac3MdxCW+9eMy3MkX61Kx6eRur
         GOAQ==
X-Gm-Message-State: AOAM532i5HLjyMUvW88BsezK3Y0cTG6kGtgglTOU22RuuW0I4cXUlbNR
        qLegFf3ekfagUmpaxMQ4kiBAKjCYYziGOWaZpv8=
X-Google-Smtp-Source: ABdhPJyHFq+R9VhoqFA/YwCnLtbBlqBSRsn+dAvmPDPJdam8HxugrtmsPO3Cb/xDE4B/aDlaXYWitbVbaYf7dww8rUo=
X-Received: by 2002:a17:906:278b:: with SMTP id j11mr1928333ejc.197.1603966421245;
 Thu, 29 Oct 2020 03:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <c6367303-dc40-e896-4ed7-19f9d75b73df@gmail.com> <CAP8UFD1Qvp010Ugd=CyEpYragy-t_xt0D8JbcB_4VHJMHf9F9w@mail.gmail.com>
In-Reply-To: <CAP8UFD1Qvp010Ugd=CyEpYragy-t_xt0D8JbcB_4VHJMHf9F9w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Oct 2020 11:13:30 +0100
Message-ID: <CAP8UFD2OR0O-1d8bdaevxJWUgJpxYq-uky=eJHq-V=2DnyY38w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

On Sun, Sep 27, 2020 at 11:16 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> In the meantime I have asked GitLab if they could fund one intern.

GitLab approved funding one intern, so we now have funding for one
intern for each of our 3 Outreachy projects. I updated the "funding"
information related to Git on Outrachy's website accordingly.

Best,
Christian.
