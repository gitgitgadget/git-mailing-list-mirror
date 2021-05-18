Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E5C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B380611B0
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349370AbhERNKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349453AbhERNKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:10:36 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0439C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:09:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o10so8077964ilm.13
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bgwXVj+ZttAAEydbJw1ZAoYB21h+vT9tJy4UNkGkla4=;
        b=qJNrQMPYd1JICf153Ge8I9UQfnuAXB5iursc+bozfMA4VeyF9YkUyTiZTy7f/c5O56
         eFgciL7GF1wztWR2L5EevtLDQu1DPnAV+6+1dissS/+2CZLzVYtJ2ZOTB2ZkmweUcrbY
         CiPp+c4TStZSjQeGkzt3/vgCeFxsyQXq9Ta7HjQD14p6ltNzrFxP8lkSIlQOJ77JyVyn
         1DznrSLXONejtK0YgAs+gOVn9ILP990ISO6bdd1/JhCbuRfcGw/FsmKShwJ27ACnxQ+5
         mr92TBombFaqXjTRpYR4vVAhcgJZfN+c6jx41NZao5V7sm1dYIeemTa0ZGh/vVwRyebs
         juew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bgwXVj+ZttAAEydbJw1ZAoYB21h+vT9tJy4UNkGkla4=;
        b=Px4eKaSs+urVxltEJBkK5WqE8s2DbvBvecMPaerT/LS8pJ2Ame9o6UUn+Souzsv0u+
         MY9WpbnHVKUzrlGz3su2Nrzxwwvde8Z/njkKzzcT2fVbzqqJA661BOujQM2BaqqkrME9
         tHJKFYU5OGumKNyewjgIhYNY/cM06tXValG2pBg0QO9idP4R4oQ2nNEChOgwRlCMer5y
         0b4PSxY6wFSA90wwQCwFvYJ7BogFjs1rf6ftV2UEtNlf1ipbDyPzKMqsf9u2A+QVNiYM
         XJuWeCizvm+KBR2ahJk4x4RokH2W34/2UR/pO1JtgS1mNSnQUIEJxrssaLUQ/Jfm2r8A
         QtNw==
X-Gm-Message-State: AOAM531SDuiU+7LYJsH5G8EpK69xyFxUJBIyuXHE66epsgb5NQSd/4bP
        m5rPTY5Qp/UFfkMsU7VM0yq1ZTCxN3w4qLdQvqBJiXTdusU+KBiCZYo=
X-Google-Smtp-Source: ABdhPJzQljvQKiO5hz4eXUvDtNCkiNTw0PiS1CQ61YfY3jOvwp7HGFXMbc0sf3uWjPNqoRNfM7bslyzxTE2O05LEHAA=
X-Received: by 2002:a92:c54b:: with SMTP id a11mr4257532ilj.174.1621343358402;
 Tue, 18 May 2021 06:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <740165DC-19B3-49A0-8D70-B78B2BDF4C1D@gmail.com>
In-Reply-To: <740165DC-19B3-49A0-8D70-B78B2BDF4C1D@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 18 May 2021 21:09:02 +0800
Message-ID: <CAOLTT8SruSYY+ckwXGwcqthJtCuDWbEFryFh08f3QN345L6FAw@mail.gmail.com>
Subject: Re: [GSoC] An Introduction
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Atharva Raykar,

Atharva Raykar <raykar.ath@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Git Developers!
>
> I am Atharva Raykar, a student from Bangalore, who is going to be
> involved more deeply with the Git community in the coming months.
>
> I am going to be focusing on converting Git's Submodule functionality
> from shell to C, and I greatly look forward to make improve Git :)
>

Great! This is also my pursuit to make Git better!

> Congratulations to ZheNing Hu for getting selected as well. I am
> not surprised at all -- his volume of contributions even before his
> selection has been great, and quite inspiring for me.
>

Congratulations to you too! We can learn from each other during GSoC.

> I look forward to helping out in any way I can and get to know the
> community better. I'd also like to thank Christian, Kaartic, =C3=86var,
> Junio, Johannes and Phillip who have all helped me learn and guide
> me through my first few Git contributions.
>
> Thanks again for trusting me with this work. I look forward to
> contribute and help others contribute!
>
> --
> Atharva Raykar

At last, Hariom (my mentor) and you are Indians, I wish you and
your country can defeat COVID-19. :)

--
ZheNing Hu
