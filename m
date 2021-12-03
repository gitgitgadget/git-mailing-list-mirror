Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82AAC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbhLCNeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbhLCNet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:34:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB92C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:31:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so5715667wrp.11
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yeplaa-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xIghneUb1rY5d/WCvngxrzoLJIt6O5BZBYltFhQfL4E=;
        b=J2Ss1fubJtkfI7dE46zXQXDiJDMmd66D6BXbQSTE9TmOrD92S41vRBLM3jvPIkq3v0
         LvungsG9Qd/4gh4TQKuZGBVfz+zMM0zkGXCiSQ0hynsy/K8vyiiXM73YN9oEeX7U0syC
         FcF8EDIZrN8DMsF04FlJubiC3CGMrX8ZOjI02Koj5kP4bLd6wNxwCitO1rXtnRqyBrZf
         TrK0tcCpOr4KnYYvZDb2RFf2TU3LaFSGL2QqsIUg/aWxDZCISOhOFxCF92UulXeC/kyz
         cdHHX2UX0mivfiJVj7tjQZaLSOKJ5RoxyYQ8bw+RQ6a9uANgQFH5IwwQA43B6VylciKg
         dUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xIghneUb1rY5d/WCvngxrzoLJIt6O5BZBYltFhQfL4E=;
        b=P5riZNj5FxY176A4LjfKAQKGaox0nPni9X4Ypz6ckCxKrcJAAYhO2fyQMvmwrIL8bU
         joRE1JeDPWKgT3NiDd9Ccv02kOpFN8/XX5Ve5WuaS+1NjVq1PFNSr8KEZR9GqJ+cjEMZ
         upyw7WXnf+CzJGmYyIOJmQkmcwMZe78dOdSaerYRoAbdUTflElMwY4nIkGmwITd4az9I
         1ih3wanhvdOQi3BCBriXiNmACaaJFAZoeJR65sk+UXKfSyTKKonZ005yTW6UJa+jAWoY
         +Spj7RYhzwPwwBPIgxJzPEypqcMHz7uU0CPD0WOybxMyzJR18DOdiNCNjOYeRTG9DBhw
         IEBQ==
X-Gm-Message-State: AOAM532O7TDuT+jVRgRag1RdGcvw1JRWsLnsB1n8TrLpFzML0MXwwd2k
        +do/NrXSaA+ybOYhGWoZd7+QEUzpvfzHnXCK
X-Google-Smtp-Source: ABdhPJwod/qx47C6MO408Hs68gVJ6WExHVTrF4EG40EdBk2Y5Al7kdlnjWCgbtui+PwIafp+JmjXZA==
X-Received: by 2002:adf:900f:: with SMTP id h15mr22229927wrh.562.1638538283839;
        Fri, 03 Dec 2021 05:31:23 -0800 (PST)
Received: from smtpclient.apple (2a01cb04076245007166bfd26b591e68.ipv6.abo.wanadoo.fr. [2a01:cb04:762:4500:7166:bfd2:6b59:1e68])
        by smtp.gmail.com with ESMTPSA id h15sm5535684wmq.32.2021.12.03.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:31:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Loic Fouray <loic@yeplaa.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Merge conflict when lines next to each other are changed
Date:   Fri, 3 Dec 2021 14:31:22 +0100
Message-Id: <F3B50D52-01B2-4EFA-A107-311E215FB518@yeplaa.net>
References: <78fd768d-6248-556c-4b74-7e35bb09a197@gmail.com>
Cc:     git@vger.kernel.org
In-Reply-To: <78fd768d-6248-556c-4b74-7e35bb09a197@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
X-Mailer: iPhone Mail (19B81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks Jean-No=C3=ABl for your reply.

When you create a custom merge driver on a specific file, do you know if It p=
ossible to apply it only on a part of the file and apply also the standard m=
erge strategy on this file ?=20
The purpose would be to able to identify other merge conflits if this is the=
 case =E2=80=A6
I don=E2=80=99t think that is possible..

Lo=C3=AFc=20

Envoy=C3=A9 de mon iPhone

> Le 3 d=C3=A9c. 2021 =C3=A0 08:13, Jean-No=C3=ABl Avila <avila.jn@gmail.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFLe 01/12/2021 =C3=A0 10:30, Loic Fouray a =C3=A9crit :
>> Hi,
>>=20
>> In a file, I have this 2 lines one below the other:
>>=20
>> Repository: myvalue
>> Tag: 8.2.10
>>=20
>> On my local branch i have updated repository myvalue.
>> On the upstream repo, they updated often the tag value (not updated of my=
 side).
>>=20
>> When i perform a merge from upstream to local branch, i have a conflit.=20=

>> It seems that it=E2=80=99s related to neighboring lines.=20
>> Could you confirm that it =E2=80=98s a normal git operation?
>>=20
>> Also, i need to automate this merge. Is It possible with git tools to avo=
id this conflict or to resolv this conflict automatically?
>>=20
>> Thanks for tour help
>> Lo=C3=AFc=20
>>=20
>>=20
> Hi,
>=20
> This is a use-case for git attribute "merge" :
>=20
> https://git-scm.com/docs/gitattributes#_performing_a_three_way_merge
>=20
>=20
> BR
>=20
>=20
> Jean-No=C3=ABl
>=20
