Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DAC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCVN5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCVN5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 09:57:18 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B730EF750
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:56:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5447d217bc6so339516547b3.7
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679493408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlHafo0nocTRac2dhh7y27YcSpiWsE0cR6z6arGQxDg=;
        b=nyi8R7Y8RRWHYPPXy93y6aGwQ19ln4QpuOhCY3IeVrJchhewZNr5YOGCSVWyUGVq6c
         a7E1+xs38rnftAUv3axkg/OQsRKKAuN1jW0nEe6uoYicagWllNFgEV5lDjOxpIIUikic
         5OS6xSpf++IQnsapEcVkG+383Y0E3whcHuUh2T+TKkdbo6zxevPWj9iajTAgM1185QXh
         lgEFZLLHwkofHjxU3hbswMy9XIYtJMyL8ABegysWQRDvsO/nrwBPjw/WxTfFNYJDHrlV
         8yMgFenfpXs5drwNtO6LeumKM72RsRD0s/Z8OeLnRZi0W/eqlfk6byq2r7XDbgJ7uGwZ
         Er5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlHafo0nocTRac2dhh7y27YcSpiWsE0cR6z6arGQxDg=;
        b=oCQi5Gpv10utapo7BGM/cvTOXxyynF9iB9ax7wwzUeqvuZj7UiK3WdsONGzogfPRW3
         2x2R3+Ueuv+OWLEFo1tXvKCF0FwQMi9UVvGRTFx0ALKzCiotg9ay9F083XPO9tykMZqz
         QSDZ3YN5bjc1LmMaT/ImjxHb9Tz9l4JmMztPTd+st9W/vWiv1WIUwpKZLj1IzCstqGjL
         k2B8OwQMHEiw0pyZyIX+nz2fgHXVTfUbQ08ucC3M3nGdhvc2GCojzM3lUeqdfTre9VaF
         BiZs0MaBnPl9R4179EC5+HpAxnOJKtkRfC+PwSEZNxeJtBH1KhQXQgq2vOHgIZhmUxG6
         PH3Q==
X-Gm-Message-State: AAQBX9c41QY30u3wQj6xQgVrVUxgpKdUSaaZtd4r9TEDTLlSEOU616RQ
        p5kFTitoVXCnkt29OoiPPjQx6AsvJlnYL2Ehhok=
X-Google-Smtp-Source: AKy350bNz4MBjFZt2t9Qx0tysrb26kLjIQ9jXVQ8Pr73LmfNtiDOYQUNJ8arQeY3vZVYjIIWo+vBTl0nnk5grzmJV+g=
X-Received: by 2002:a81:b614:0:b0:544:6828:3c09 with SMTP id
 u20-20020a81b614000000b0054468283c09mr3303186ywh.0.1679493407826; Wed, 22 Mar
 2023 06:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <PR2P264MB0799BA146D27303A72B3EF69F4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PR2P264MB0799BA146D27303A72B3EF69F4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 22 Mar 2023 21:56:36 +0800
Message-ID: <CAOLTT8RfhvDSP-Tq1bFZ39H4YyvLJ5Yv0pCn15=2r4_Ay9ZgxQ@mail.gmail.com>
Subject: Re: Minor bug regarding git-reportbug
To:     "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coirier, Emmanuel <Emmanuel.Coirier@caissedesdepots.fr> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 21:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi everyone !
>
> Here is a minor bug that I discovered while trying to report another bug =
:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> $ git config --set --global core.editor nano.exe
>
> $ git config --get core.editor
> nano.exe
>
> $ git bugreport
>
> > What did you expect to happen? (Expected behavior)
>
> git gubreport opens a template to fill with the nano editor (or the edito=
r returned with $(git config --get core.editor))
>
> > What happened instead? (Actual behavior)
>
> git bugreport opens a template in vim, which I don't use on a daily basis=
.
>

Ah, you're right. I was able to reproduce this small bug. It's caused
by git bugreport not reading the config. I'll submit a patch to fix it late=
r.

> > What's different between what you expected and what actually happened?
>
> The wrong editor, that is not configured, is open instead of the default =
editor previously configured
>
>
> [System Info]
> git version:
> git version 2.37.3.windows.1
> cpu: x86_64
> built from commit: c4992d4fecabd7d111726ecb37e33a3ccb51d6f1
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 12.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Developpement\Git\usr\bin\bash.=
exe
>
>
> [Enabled Hooks]
> (None)
>
> Best regards,
>
> --
> Emmanuel Coirier
>
>
> Interne
> Ce message et toutes les pi=C3=A8ces jointes (ci-apr=C3=A8s le =C2=ABmess=
age=C2=BB) sont confidentiels et =C3=A9tablis =C3=A0 l=E2=80=99intention ex=
clusive de ses destinataires. Toute utilisation de ce message non conforme =
=C3=A0 sa destination, toute diffusion ou toute publication, totale ou part=
ielle, est interdite, sauf autorisation expresse. Si vous recevez ce messag=
e par erreur, merci de le d=C3=A9truire sans en conserver de copie et d=E2=
=80=99en avertir imm=C3=A9diatement l=E2=80=99exp=C3=A9diteur. Internet ne =
permettant pas de garantir l=E2=80=99int=C3=A9grit=C3=A9 de ce message, la =
Caisse des D=C3=A9p=C3=B4ts et Consignations d=C3=A9cline toute responsabil=
it=C3=A9 au titre de ce message s=E2=80=99il a =C3=A9t=C3=A9 modifi=C3=A9, =
alt=C3=A9r=C3=A9, d=C3=A9form=C3=A9 ou falsifi=C3=A9. Par ailleurs et malgr=
=C3=A9 toutes les pr=C3=A9cautions prises pour =C3=A9viter la pr=C3=A9sence=
 de virus dans nos envois, nous vous recommandons de prendre, de votre c=C3=
=B4t=C3=A9, les mesures permettant d'assurer la non-introduction de virus d=
ans votre syst=C3=A8me informatique. This email message and any attachments=
 (=E2=80=9Cthe email=E2=80=9D) are confidential and intended only for the r=
ecipient(s) indicated. If you are not an intended recipient, please be advi=
sed that any use, dissemination, forwarding or copying of this email whatso=
ever is prohibited without prior written consent of Caisse des Depots et Co=
nsignations. If you have received this email in error, please delete it wit=
hout saving a copy and notify the sender immediately. Internet emails are n=
ot necessarily secure, and Caisse des Depots et Consignations declines resp=
onsibility for any changes that may have been made to this email after it w=
as sent. While we take all reasonable precautions to ensure that viruses ar=
e not transmitted via emails, we recommend that you take your own measures =
to prevent viruses from entering your computer system.

ZheNing Hu
