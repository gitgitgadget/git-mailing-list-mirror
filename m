Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E410C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E91613E6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFCFvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCFvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 01:51:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F371C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 22:49:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o9so4442801ilh.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jlUpMkLnPs7dvS0OCWFsBg1NmVKd45TF7co0skz9anU=;
        b=DWhQLGwZvzpztCx4+WNgSWjZ89CZzpG3HnJDtS2pmGrYI7VK9bUrfxRd6AvJ1sk5vp
         lhpVlKsbzToDs3a+Ht/EqJMhnKjbbs+lHMV1950k+IvdKp2OWbUIPq5T2kj1U2tCAcal
         IP3KcDzcDrl4lJIDMXpHh1pVrJCpK5SZksS0Nl1uvCh8U6/hGqxqPfwO4NdsyS8olaSb
         cfonq1BSzv6M/QKQMcgEr7LKngRKmhCf7X9kk43qe9v6OkQULSoP8zN1F876xBM+jL8W
         kKWSTs0Cc0QmC6lgJW7pg79TAf4cd7100pUp8JQdpzNVuHhQm8S8wrzdQi/MoMDE1NbV
         uuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jlUpMkLnPs7dvS0OCWFsBg1NmVKd45TF7co0skz9anU=;
        b=Ph6nHVyPfktMvqNgBJb9r5qHhjGLKPX1hnyDo6uR4t7e3G3lfZcQ5QoBVf5g8pkIO5
         xgbjD7tw1Ca4PHSdN4tTF0em890ItJ8E9Dfh2MCK1eD7+IQnc7UV1GhO/lud+YpuxlIa
         5L1wrhr0k0oR5JFxPlfEI5m4KHFGf80N+yxN9pnE8ex02u+uAzuHpw7lAZANJ2MgaMw5
         o/OuZNMrjqnwUUjwCL3cDYjpmfyUPgZhvFZL8YtZ562Y8KroJ3xQAEJPqTjTSykNgXwo
         BzrOYnDtsJJGGCC8bwCHYb74lLQX9AwkKstF4FxxrvxbNFf9LohBWX7biW8SFTHjXSrW
         K1Fw==
X-Gm-Message-State: AOAM533KT4YTvy82RYCPCaQFXBu+patZ2T8E9lckeZ1E6mSl5zBfGiU8
        TDdR0AokvkTKQ7PRYYmg+RI8zEwKuv/kMvBOlbCjiwG5GE4MWKn2
X-Google-Smtp-Source: ABdhPJzrBKagRhO0TNZD92D9plx1Iu9adjsmmbqbyaHMsi5YokBr/OO68DEYq3avMRQmFaw2X0H4kLzU0P0bzUIukjs=
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr9487695ili.174.1622699347842;
 Wed, 02 Jun 2021 22:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
In-Reply-To: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 13:48:56 +0800
Message-ID: <CAOLTT8TZhuK-Z_1MRrtreyg-jhHkCn8HEPJUOGM74ur8mVgLOQ@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> For most email providers, adding following .gitconfig is enough to
> seamlessly use git send-email:
>
> >            [sendemail]
> >                    smtpEncryption =3D tls
> >                    smtpServer =3D <server>
> >                    smtpUser =3D <email>
> >                    smtpServerPort =3D 587
>
> But for users that use Gmail (like me), we must either enable 2FA and
> generate app-specific password for use with git send-email, or enable
> less-secure app access. That's because Gmail prefers authenticating with
> OAuth2, but git send-email use plain text authentication instead.
>
> I personally prefer the latter because I know that I enabled less-secure
> app access only for duration of sending patches with git send-email
> (that is, I switched the trigger when I run git send-email).
>
> We wonder whether git send-email can support Gmail OAuth2 so that we can
> seamlessly send patches without having to choose either action. But
> however, we have to create a GCP project [1] first in order to enable
> Gmail API. This can be overkill for some folks, but unfortunately that's
> the only way.
>
> If we want to enable support for Gmail OAuth2, should we hands-off API
> configuration to git send-email users, or should we configure it on
> behalf of them? Note that when we go the former approach, some Gmail
> users simply can't afford GCP pricing for whatever reason (even don't
> have any of required payment methods), whereas the latter approach we
> must cover that cost (and Software Freedom Conservancy can raise funds
> needed for it or git.git developers can pay it).
>

I met the same question as you before. [1] (write by chinese)
We need cumbersome operations to allow gmail to agree to use git send-email=
.
I also want to know if send-email can be made more convenient
(to reduce some configuration problems with gmail).

[1]: https://adlternative.github.io/archlinux%E4%B8%8A%E7%9A%84git-send-ema=
il%E9%97%AE%E9%A2%98%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88/
