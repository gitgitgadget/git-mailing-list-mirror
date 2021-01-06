Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C37C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2E123120
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbhAFRAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:00:36 -0500
Received: from pv50p00im-tydg10011801.me.com ([17.58.6.52]:42514 "EHLO
        pv50p00im-tydg10011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbhAFRAg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 12:00:36 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 12:00:35 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1609951763;
        bh=hVMpYT0mkSM6ertHycZofo+2t8kbhZsr+r4SwlHWMs0=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=DvfecKUzy/Ld/CZEUoqip341BgXnnGtaTFdKbbTqrdr0R7XAvia5+41johzudwJz3
         BlspP1ISfqphs3CqwaG5GcHwuhmtVGlX5JMMizxXE0Sg+1PPVvhrBjZfo7ryZvWdu4
         kINDI3MBmMDtxpq8KKHXOtjfO9Gbtf5k/apLJX5cXfhuJ8+ITNs52+Z6txstTpy7jm
         dcAKW0w/dKUdS+iFIq13bZ0FfNiLakOfDy34cn6BYUnh2BgoHca90uwwaE/HsJNjKS
         xJWcGSILLq81r3326sVzWUOU/0OuSoHUTgTxHWPTfdniye/2FzsTXVoV4s1fEszCdi
         NzF0Y4Ad5D3oQ==
Received: from [192.168.1.114] (unknown [90.129.214.206])
        by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id D196D66055D;
        Wed,  6 Jan 2021 16:49:22 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Daniel Troger <random_n0body@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special characters)
Date:   Wed, 6 Jan 2021 17:49:17 +0100
Message-Id: <B311BF22-6193-4CCF-BBDA-DE27709BBCC0@icloud.com>
References: <20210106142137.gxd2a4vnrsjj4jq5@tb-raspi4>
Cc:     git@vger.kernel.org
In-Reply-To: <20210106142137.gxd2a4vnrsjj4jq5@tb-raspi4>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: iPad Mail (17F75)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_10:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101060100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thank you for investigating. Here's the output you asked for + proof the=
 issue still persists on the latest version of git:

```

me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git restore -p .
BUG: pathspec.c:495: error initializing pathspec_item
Cannot close git diff-index --cached --numstat --summary HEAD -- :(,prefix:4=
4)[redacted]/paulbrunng=C3=A5rd-springyard/src/ () at /usr/local/Cellar/git/=
2.30.0/libexec/git-core/git-add--interactive line 183.
me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git --version
git version 2.30.0
me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git config -l | grep u=
nicode
core.precomposeunicode=3Dtrue
```

> 6 jan. 2021 kl. 15:21 skrev Torsten B=C3=B6gershausen <tboegi@web.de>:
>=20
> =EF=BB=BFOn Wed, Jan 06, 2021 at 12:35:26PM +0100, Daniel Troger wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>=20
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> I ran `git restore -p .`
>>=20
>> What did you expect to happen? (Expected behavior)
>> git restore to open in interactive mode and letting me select data to dis=
card
>>=20
>> What happened instead? (Actual behavior)
>> I got an error message:
>> ```
>> me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git restore -p .
>> BUG: pathspec.c:495: error initializing pathspec_item
>> Cannot close git diff-index --cached --numstat --summary HEAD -- :(,prefi=
x:44)[redacted]/paulbrunng=C3=A5rd-springyard/src/ () at /usr/local/Cellar/g=
it/2.29.2/libexec/git-core/git-add--interactive line 183.
>> ```
>>=20
>> What's different between what you expected and what actually happened?
>> The main problem is that the command didn't do anything. It basically pri=
nted an error message instead of changing a file in the way I wanted.
>>=20
>> Anything else you want to add:
>> Yeah. So pretty obviously the problem is the "=C3=A5" in the filename. Th=
e interesting thing is that the folder with the "=C3=A5" in the filename see=
ms to exist twice, with differently encoded "=C3=A5"s. But their content IS A=
UTOMATICALLY PERFECTLY SYNCED. And the only tool which recognizes them as tw=
o different folders is git. ls in the terminal shows them as one, finder sho=
ws them as one, even "glob" in php shows them as one.
>> This is what git seems to see them at (taken from git status):
>>=20
>> `modified:   "paulbrunnga\314\212rd-springyard/`
>> And further down:
>> ```
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>    "paulbrunng\303\245rd-springyard/"
>> ```
>> Here is a zip containing the folder (emptied): https://arxius.io/f/7ec7e1=
c7
>> I tried creating a new git repo, extracting the zip in it, going into the=
 folder and running `git add empty` and could reproduce that git sees it as t=
wo different folders.
>>=20
>>=20
>> Please review the rest of the bug report below.
>> You can delete any lines you don't wish to share.
>>=20
>>=20
>> [System Info]
>> git version:
>> git version 2.29.2
>> cpu: x86_64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Sun Jun  2 20:31:42 PD=
T 2019; root:xnu-4570.71.46~1/RELEASE_X86_64 x86_64
>> compiler info: clang: 10.0.0 (clang-1000.11.45.5)
>> libc info: no libc information available
>> $SHELL (typically, interactive shell): /bin/bash
>>=20
>>=20
>> [Enabled Hooks]
>>=20
>=20
> This uses the decomposed form of "=C3=A5":
>> `modified:   "paulbrunnga\314\212rd-springyard/`
> ...
> And here is the precomposed form og the "=C3=A5"
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>    "paulbrunng\303\245rd-springyard/"
>> ```
>=20
> Both are lowercase, right ?
>=20
> What does
> git config -l | grep unicode
> tell you ?
>=20
> I have
> core.precomposeunicode=3Dtrue
>=20
> and that what we need on a Mac (to handle precomposed and decomposed bette=
r)
