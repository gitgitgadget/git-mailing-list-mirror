Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54865C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 16:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352984AbhLCQdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbhLCQdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 11:33:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534AC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 08:30:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q3so6857527wru.5
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yeplaa-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=AInywone1XJK9zRgVVep88DMbN0BvCI9oHTXeg4sbhA=;
        b=GnkXaWIuUVdn1GoyVnTB/RviyNVOR30RaxkA/HZuw14k2I99TaiUv+OwJu3LzLo3cz
         Q19mYvYQ95ITYc+6sWyrhHfa9dgu1dTYWlFO8Sc2Z9/tRevbBuxW/u8waoTEmPftvjIb
         jqLBKPXwBi5wrbmeKB2qhaqKKzFUtksb8x9cAy1ufH7rlD5tSCCzwQSFDRpGAZuYL7hb
         OUCaGbr9veZ8B9PkgeTRiToba1sRw60aKXx8jyauEbhW6w4QS6N5r4SwrIiz3prCJOS3
         axPFU7ZXOjOIuoi5qYLDvu73ZmJEJTN79aMzwqPDvCmPJH3YG4aXj+sNvIABqxNEswzv
         cSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=AInywone1XJK9zRgVVep88DMbN0BvCI9oHTXeg4sbhA=;
        b=ClBNj9CURhQGrkae2K50HD4umldmqSnwi4Xli5AubV85K8BkZKDHM5BobMJihcw1aI
         t9D/U6HHer/RjpgjW+KRkDBN3DYPBlj2Y8qR7A/b8QpipZf8jhKK56ylieRTU5NUFhpE
         6ggkybtBHwfY9FnRbtB12GcdO0o8qmKCFWWvzk3TsXmQ+lhLS2H7FIUbUTUB0ETwwvaI
         EHztAIgMTTl2m5i6TV21VAzo8TDsWn7qDpS27QzHhnJvqcYskclFytkmr9pft0sg63a3
         07QhS2C3+TX8OlK1kbxQD6lsClXL1YUGPZ7ca4RO5WVw/hog+SnT7Uzh5ByPPC/ziG5H
         boUA==
X-Gm-Message-State: AOAM531uJaD0GfmnKBCr+N/hGhml4YZR18Cbu45g0Ebrk0tIeTp0/vAo
        sgYoIU/RNijh6ke/v2musgJ9LMsLsKh4Prr2
X-Google-Smtp-Source: ABdhPJxxBCRbxjXrni2IH9/h6M60cajkt9ygTKrpDuRkXRBXZKpL7rp29ZeXARVhdVS3ERqNe+qXCw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr22887561wrw.621.1638549023410;
        Fri, 03 Dec 2021 08:30:23 -0800 (PST)
Received: from smtpclient.apple (2a01cb04076245007166bfd26b591e68.ipv6.abo.wanadoo.fr. [2a01:cb04:762:4500:7166:bfd2:6b59:1e68])
        by smtp.gmail.com with ESMTPSA id j17sm3687179wmq.41.2021.12.03.08.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:30:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Loic Fouray <loic@yeplaa.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Merge conflict when lines next to each other are changed
Date:   Fri, 3 Dec 2021 17:30:22 +0100
Message-Id: <C1412C97-E67D-44F0-AC40-2FB723AFD017@yeplaa.net>
References: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com>
Cc:     git@vger.kernel.org
In-Reply-To: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com>
To:     rsbecker@nexbridge.com
X-Mailer: iPhone Mail (19B81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Randall,

Regarding the clean/smudge filters usage, do you know if this filters could b=
e triggered by the merge git? Indeed, it would good if the change performed b=
y the filters could be integrated with the merge commit.=20

Thanks
Lo=C3=AFc=20

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
