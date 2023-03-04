Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F0C61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCDBUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCDBUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:20:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F71526A
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:20:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so3878003wrz.7
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 17:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677892817;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GatRM+N6KjGs/j0jI58P+joUcdgpY65IVq+NAwtWCw=;
        b=qBQ1d5BrqVDFBIK4aElzaFAtx6MpRfnDR349AY4nmyOdfHDVbroTFkApZX3RmPWNN5
         /AMJudpbRYoOOk8dBBfpimSyVZugqaUn5HrCzMCGS1hR7OSrZGzeqHp5wMFZpu7XsFIX
         QcHGKab/ZtsdS54+iZ+QAwTBY87hjooS8ISlyS+lbV54XmLD2jw6n0jXbkTxtYRmaxCR
         WMygadD/kdfvLkIS9faT6rbF5vwSxS28xKolqu1py+0TTCJEa+zLpfVbcFR1B6tyT50p
         DSClxhSGRen2R+ggnFsAxxFopOStWqKO/gvQchGj/7GPMLLAjscpyjONiCmc2EIjoV0H
         m1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677892817;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GatRM+N6KjGs/j0jI58P+joUcdgpY65IVq+NAwtWCw=;
        b=heejCx8VQhIMPPIpQP6PF/hEGD507ZJ1gbiqGcub0goSV1vDYfpok5F4zUuTOjS4Xb
         y2Vkq/E8rLuZwlQ61V8qlTiCoTMxPtiC18BX4eBQWXiesn52wfAvENKf4iSUpSBv2HcR
         IZC6pLxf58utv+f8wF8MfT4awTjCMN+Q0EnQk7tA5ftfwV8HaXKIa+kGbM+fb+X101y2
         KKz47rXG8un/9QljZWIUn9X7G5Vf6Ko9R8OiPqP4CLH/LrcJCQAwMY8MNWc3GLQybg70
         iX3CuLlgzEoa2Cc6Un6wApK0IZqmGcPswcD0w7gqxdElywwUOH0g4fs4xAr1Eh01IohW
         HeRg==
X-Gm-Message-State: AO0yUKV8uslZEo9DC3E1BC6LG9lTSPIJyPpdyQhLE0r44yv6vCpt8uNP
        KTEa4ZQ1W+4HneOMlSV+OOJDoZCfgPUL666qsfRjGBQulsk=
X-Google-Smtp-Source: AK7set/eCBsts/ailtbvAYQQcxF4cTyfDBSPOQ6RnC5VQ8nbsgTekQ6nZ5Wn8FeYOFChKqPgbJgL+NKVrccBaY8A3Aw=
X-Received: by 2002:a5d:6787:0:b0:2cb:c474:75aa with SMTP id
 v7-20020a5d6787000000b002cbc47475aamr844424wru.10.1677892817260; Fri, 03 Mar
 2023 17:20:17 -0800 (PST)
MIME-Version: 1.0
References: <CACw=1eCKN-saQCbOmoyZ1=ydcwoC0FE0KvE5UQ5ttkkv0OeBcg@mail.gmail.com>
 <ZAJ8vDUeLDH0CZAd@tapette.crustytoothpaste.net>
In-Reply-To: <ZAJ8vDUeLDH0CZAd@tapette.crustytoothpaste.net>
From:   Magnus Asplund <asplund.magnus@gmail.com>
Date:   Sat, 4 Mar 2023 02:19:59 +0100
Message-ID: <CACw=1eDSag1XE7X6OddtA=b+GPCaw=b3Ceo=sNw8UoA1UUJO1g@mail.gmail.com>
Subject: Re: Is xmllint no longer supported in (latest) Portable GIT 2.39.2 ?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Magnus Asplund <asplund.magnus@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

Thank you for your quick reply and directing me to Git for Windows.
I'll check with them about my questions. Furthermore, I didn't know
about these security issues of libxml2.. sounds reasonable enough to
let that stuff be excluded.

Then I'm happy for the time being with your help.
Regards, Magnus
--
Kontaktinfo / Contact info:
Magnus Asplund
asplund.magnus@gmail.com

--
Kontaktinfo / Contact info:
Magnus Asplund
+46 70 718 65 00 (cell / mobile)
asplund.magnus@gmail.com


On Sat, Mar 4, 2023 at 12:03=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-03-03 at 18:10:19, Magnus Asplund wrote:
> > Hi,
>
> Hey,
>
> > I have a bash script created in RHL environment (Linux). The script
> > extracts data from a great number (+100000) of XML-files and generates
> > "row-col" data as output to a CSV file.
> >
> > Due to limitations in both technical knowledge and
> > access/authorization restrictions of other persons than myself, I
> > decided to give Portable GIT a try in Windows 10 environment to hand
> > over the script execution to those other ppl.
> >
> > The script works fine using 64-bit Git for Windows Portable version 2.3=
8.1.
> > However support for 'xmllint' seems to be gone in version 2.39.2....
> > (this one: https://github.com/git-for-windows/git/releases/download/v2.=
39.2.windows.1/PortableGit-2.39.2-64-bit.7z.exe)
> >
> > Any answers to this? Is xmllint not longer supported? Any alternative,
> > besides using to older version 2.38.1 ?
>
> The Git project doesn't ship any binaries, and it doesn't ship anything
> but Git, including xmllint.  However, Git for Windows may ship those
> things, and you'd probably want to go to their issue tracker
> (https://github.com/git-for-windows/git/issues) and talk to them about
> this.
>
> My guess is that this was necessary to build and it isn't any longer,
> and because libxml2 has a constant stream of security vulnerabilities,
> it's not something they want to keep shipping, but you'd really have to
> talk to the Git for Windows folks to be sure.
>
> If you need a more complete environment on Windows, you may want to try
> a Linux distro such as Debian under the Windows Subsystem for Linux,
> which will likely provide an up-to-date version of this tool.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
