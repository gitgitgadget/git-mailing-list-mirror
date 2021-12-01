Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E28C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbhLANhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbhLANhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 08:37:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113FC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 05:34:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so52326982wrw.10
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yeplaa-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=f6otol8/0t2XJwxtOufsf160lXez5JDIBHS1S0f293E=;
        b=aFXhjDL60jDHaCNqTVkrnBenz9vDLKZI7z9m2byCoGbVA5nvpWM7ijo66E68ZtTG0u
         VGhk8fUVi6BsVOndLdvOvbLglMk2Hj4zP0qm6VGJ9eG0URO6ZOcJckjs6paiBcuoortp
         zCJWik3hDw5qPthUv4+3d5Ii0Ax/JeCCYBPvUBFsYvouZ2e/D91O5u/eZrL46Rxb+HFM
         qePhZO2TfjREtTvXhhfF0cWRQThrGuj7eunw4HVwvMYbxN5jIzI4rZEJZ8yAxd7VMrsE
         I89Ohi4e2bu6iE+n3db3QMZmVQL/AmTWZUuzdIWrnoeOiWx/1LfxF4lQLiimsHiVgZoT
         J2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=f6otol8/0t2XJwxtOufsf160lXez5JDIBHS1S0f293E=;
        b=C3sGXtff5MYTYXhMaemnDBSIOuhZa3lTkxVSnNMxCz/DQsoZMSPnxcy61cYREqOk58
         fsbx5m57jWjm+rYveSwafylH27P0VG15hxtAfeZTvCrZkV9hnBIdfGCo+EIlAVOdgUvs
         JdoBw8bJgJXotkLSdTBLVkA7BgEpGeYtrXtPZyjrykYaHLbTFJXgQZj4RHspfIWzrr1u
         emSL+Va4aH8K9ko4r1Xgt0hQl8er5uAiUFTuHubvUr8RJ7CR3X/azYdxk54O39ZCA320
         P4BUuQwUa2bOjza/Qzj7GsO+nlWgGN14ehahelXDriE8A00NPfzkw58Btr19wQBnnW0J
         GkOA==
X-Gm-Message-State: AOAM530ObX/hlCbJr2H2ZVPOtL+AUA0RXnpCHCi5nLFPfClnHPUnaepS
        1T6iTokDZdN5i79d4f6hoTO6AF02U9+EylNo
X-Google-Smtp-Source: ABdhPJzfmxw8LJZMXB6zoXxMTCEf66wiV0n2V5Q7/TdTyZff4uhLyJlT+39b/0K+lNlQZprSIKaR0Q==
X-Received: by 2002:adf:d20e:: with SMTP id j14mr6864508wrh.220.1638365640658;
        Wed, 01 Dec 2021 05:34:00 -0800 (PST)
Received: from smtpclient.apple (2a01cb04076245001dfd98bd1815391a.ipv6.abo.wanadoo.fr. [2a01:cb04:762:4500:1dfd:98bd:1815:391a])
        by smtp.gmail.com with ESMTPSA id d15sm26639166wri.50.2021.12.01.05.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 05:34:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Loic Fouray <loic@yeplaa.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Merge conflict when lines next to each other are changed
Date:   Wed, 1 Dec 2021 14:33:59 +0100
Message-Id: <8E09F910-1D70-4848-A9E3-FA94B60335D3@yeplaa.net>
References: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com>
Cc:     git@vger.kernel.org
In-Reply-To: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com>
To:     rsbecker@nexbridge.com
X-Mailer: iPhone Mail (19B81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your reply Randall.=20
If i understand correctly, you use externals tools (sed ..) but there is no p=
ossibility to manage It directly by git (sp=C3=A9cific options,merge strateg=
y..) , that=E2=80=99s right?


Regards
Lo=C3=AFc

> Le 1 d=C3=A9c. 2021 =C3=A0 13:19, rsbecker@nexbridge.com a =C3=A9crit :
>=20
> =EF=BB=BFOn December 1, 2021 4:30 AM, Loic Fouray wrote:
>> In a file, I have this 2 lines one below the other:
>>=20
>> Repository: myvalue
>> Tag: 8.2.10
>>=20
>> On my local branch i have updated repository myvalue.
>> On the upstream repo, they updated often the tag value (not updated of my=

>> side).
>>=20
>> When i perform a merge from upstream to local branch, i have a conflit.
>> It seems that it=E2=80=99s related to neighboring lines.
>> Could you confirm that it =E2=80=98s a normal git operation?
>>=20
>> Also, i need to automate this merge. Is It possible with git tools to avo=
id this
>> conflict or to resolve this conflict automatically?
>=20
> I try to keep version-specific identifying information, which is already c=
ontained in git, out of my code. This includes change logs/history in each s=
ource file because git is good at keeping that information - it is redundant=
 in the code. However, for organizations that need to do that, I suggest usi=
ng clean/smudge filters so that the code inside the repository is clean, whi=
le things like the repo name and tag get injected into the code as git puts i=
t into the working directory. The code is then cleaned up while being staged=
. This removes the possibility of the conflict on these lines by removing th=
e differing lines. You can script this using a combination of sed and git co=
mmands. My own git front end does this all the time but it is not generally a=
pplicable to all platforms (only NonStop and MVS) so I have not contributed i=
t.
>=20
> Regards,
> Randall
>=20
