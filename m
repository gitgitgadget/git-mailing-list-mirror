Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6589C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 06:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbhLXGJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 01:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245665AbhLXGJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 01:09:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C26C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 22:09:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so7568149pjb.5
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 22:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/8M+cyycGQU26qMfc/1u8ag9cAOLvkt1aoCeQ6bpZmY=;
        b=SNqA9W5B+FUOxWUnblJoE3Xk2e4c8cO7li0o0upsockrqYU40fFg2uVX3v3bA55689
         502mie2R+IbC003kwy5FIsghs8pfrTkIE0qzGjZoazX6PRPB1NJmqdKaHkJORnQoIYLc
         sd5HRWEl0wWUxM349UzVqetQm4FnBPgDdVMNXSm9acmjVq970LS4opBsrvhJXl57br0C
         6mLhPS3hDMNArHE6DKSmNV7NeUqDmc3q2tX0dmQx5DZ4rzpSOxIUA4JMZ4RzBApsdB/K
         omkpR6hRBV3mn4iboLIAo8yQZbRIGZ21oxTb0AQAXBM6hesL8CHeO63GZKrZa1i6sjVR
         od3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/8M+cyycGQU26qMfc/1u8ag9cAOLvkt1aoCeQ6bpZmY=;
        b=LaZjJQ0BqDvdGvUd8jn/13r5hwAmPhxXm/6ZOOjHyMzKTzVxI3h0HWdf5CwIbLz51j
         ZLWoWMz+tDnqcDV6sgIcpcOg8dl64daiIRve10V0RofBBV6FdJoOt/db2BwE3PJUT7cx
         NTSiP5g4QhL01P+dby3gV/Sl7HVq02yVzjyJLXc/7DqlPBfhRqGComr5vIkCevxfk+9Y
         K0iwXXlVmfEaqKQ/x1iVZpEpPsd4vQ/f+fdzMgTQv/zcXR2JK7AnTjCe64JiTbgncvY0
         5YPToi6CRxdFlw/93WfTg8pwaGvJn65hcTaKTpDmaN9Hkie7+s3Z9dDHDLfESW8dlJOq
         6CuA==
X-Gm-Message-State: AOAM530dlQXUdAgfCSH8ILxfSMywaOkrG1aGeouaoHm3TR0D3PblxrnY
        SqKCUoVlEp+W6qmvxOq9mBbTO63TlB4=
X-Google-Smtp-Source: ABdhPJxqOGicQkEKr00p+pLxdFKWkB70Z+ln2i+tsbXS4BupH2b0zb8INaXItGiybMdsR0NLve94YQ==
X-Received: by 2002:a17:902:7d96:b0:142:6a63:c1cd with SMTP id a22-20020a1709027d9600b001426a63c1cdmr5462928plm.88.1640326192066;
        Thu, 23 Dec 2021 22:09:52 -0800 (PST)
Received: from smtpclient.apple ([2601:642:4700:fe2:b8a6:9c03:e911:7f00])
        by smtp.gmail.com with ESMTPSA id rm3sm3623778pjb.8.2021.12.23.22.09.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 22:09:51 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
Date:   Thu, 23 Dec 2021 22:09:50 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D22DF4C4-C98C-45FB-8D26-57B50A44FA3F@gmail.com>
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
 <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
To:     Erik Cervin Edin <erik@cervined.in>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Dec 23, 2021, at 10:39 AM, John Cai <jcai@gitlab.com> wrote:
>=20
> It seems like this bug can be generalized to =E2=80=9Cgit name-rev =
--stdin=E2=80=9D does not work with --no-undefined nor --name-only
>=20
> The --name-only case seems clear to me that we should fix it. It=E2=80=99=
s misleading to return the sha instead of =E2=80=9Cundefined=E2=80=9D =
for a rev without a symbolic name, as a sha could be a symbolic name.
>=20
> I think we can also make the argument that --no-undefined should also =
die in --stdin mode when given a rev without any symbolic names.

While I think this would make name-rev more consistent, I=E2=80=99d be =
interested in hearing what others think about changing the behavior of =
this command. This would have the potential of breaking scripts that =
rely on the current behavior. Since I=E2=80=99m a bit new, I=E2=80=99m =
wondering how we generally handle these cases?

>=20
>=20
>> On Dec 22, 2021, at 2:05 AM, Erik Cervin Edin <erik@cervined.in> =
wrote:
>>=20
>> Hey all!
>>=20
>> I ran into a situation that I think may be a bug
>> using git name-rev for detached heads.
>>=20
>> Steps to reproduce:
>> Create a detached head
>> git checkout --detached
>> git commit --allow-empty -m foo
>>=20
>> Expected results:
>> My understanding is that
>> git name-rev $(git rev-list -1 HEAD)
>> git rev-list -1 HEAD | git name-rev --stdin
>> should yield the same result.
>>=20
>> As well as combining with other flags
>> like --name-only / --no-undefined
>>=20
>> Actual results:
>> Where this fails as expected
>> git name-rev --no-undefined $(git rev-list HEAD)
>> this just prints the SHA wo failing
>> git rev-list -1 HEAD |  git name-rev --stdin --no-undefined
>>=20
>> "name-only" is also affected
>> git rev-list -1 HEAD |  git name-rev --stdin --name-only
>> returns the SHA and not the name
>>=20
>> Tested on
>> git version 2.34.1.windows.1
>> --=20
>> Erik Cervin-Edin
>=20

