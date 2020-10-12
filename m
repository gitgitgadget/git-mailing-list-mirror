Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C09C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66420208FE
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lq8ZfRp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgJLLKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:10:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:60613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgJLLKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602501001;
        bh=1q6CJOZp+txtR5KSt2ZpMIhAWDEXWcyYL3TEONF3d1s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lq8ZfRp1buwZHoWXaBOZqm+jJTRxXA33NnUnfXBJT98TMoMN2Qk2A7SYnT0Nf6o+d
         2X1opac08xFiZqhjtMPyttAFfXCLC1cwQ9Xc14hZroK7jXc+o5wSR3v0/IylMR5F//
         NiEyoeNfDqYcbgfG5nnLv9QAr9cEcITM7lBuUW+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1kyfQc2Wjf-00Z1x7; Mon, 12
 Oct 2020 13:10:01 +0200
Date:   Mon, 12 Oct 2020 13:10:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [BUG?] After 'git checkout',  files deleted upstream are left
 in the working directory as untracked
In-Reply-To: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010121306470.50@tvgsbejvaqbjf.bet>
References: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DzQaWEC4YtwH41GM2VnwsFYxB8GpMAOvuRq70zC8yJUi9LeDnhV
 MOIqvrEf6tBce5RNf16EOZgFsKE5lQVaocxMmwD7Gl7rs7pEAm6KfneuvFS1np/ycVrq5Em
 Ans9qntWu61dypd0mmcFeZpC2UyvOiSiPMQtxbaFCw+fKuYVnsvHvSEhVhje5r5FnB9d9UO
 ehra7wt5Yr5YeaaRhqtBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0XKUaGfZApA=:d9/iE249rimP3AuHc7g/GC
 hCaI+OlOva+6LupB3yoHx4kb7ivUjL4MuAN7Vjjzdq+8HRCgC0PDYZ2ijXiwtC7sv/RDwX+Fb
 ZXCoJsP4Fv/a76x/JgLLlnr1qWtL8kwWXnsT9/dgwcC2Pn9LU5si1AvFYF52GRn5hku/9d0xK
 7xvtDkslQETMj5eNfZtXMwqOCDf9iipV3v3nHxU6YERP4rPOBHqKQZVM/V+APx8xnjcfTlKEL
 eEtQHv8fsrllP4Tc3bWIfb66Qdp0hccnI9uCn50H/0X01/qIWJN88xSZG4qtNBdmwmhUlHLkP
 aW6i9ZpcwYjclm6Ta8q7Vd/i6cf64te+gj/Qbgz6qO24LAff+Rjs74WAIEh2weOib/hMIvGCG
 eTqhI90PfDa82VTX8brc/sRoGVWNvWGNklWQdGCwkn+1xE/BXRR1H84q87VNqi6tN4IowJBmj
 UgdzjMEvPyBcIGkYb8Ve5Jqc/a5uCDdFT9eyKZQk44WhJw5WpD4r0aresb5vw5wCsMOMxm6Gw
 2bumrbZYL2K0Mhb9vOVhgclZN9s84aGeVKF+cpO0pJ655wG6+5jeTsdKxGq3NVU2KFd81wIuH
 kDBvjo+c3Ay5TFCHVMLD2MchJi18SqIIh2XzNpMn8zPOtBKc/kIOfmxVmLsNwxr+Sv828K4ZL
 ILdcLaFulal++15e43GjmNijNoyNbDEdQOCRofpP23epkhy7a9RVKUWv8aNGvEiQ/rq5VbGZI
 H/o+sX/1UWvmFrXSQ1B/oQqduCX45uf5A2Uq1k8lGdV6w2vlMRJ6MnH40ryiXGMIoKYEvFtji
 mCO7UVnv4360elKRvjBjx61Jx8NEZ+RU2DUwMSNlp+HXhg2rTmeR6lN2/VCjt6iUZO550eEFh
 AiLmXAzNp86dT3LLYudVrcf5z4lL5GpfXeTGI8c4j1WtECe87V8OKIAOzmSazA7bxW7D3Wxh2
 4m2d5EcO8AkTwBtXUyEr8ZP78ZBnJBl0zUpPZyVFbELM9L3Zt2b8lcIo3sGRXJJ+9VMMnHboD
 RrPwxKDxcLZj9FJqT9cT0fAgg9HjjK80FJRrKlDd1Hp7Z2v/NgM/8h0FbDung4pPyAgWp+tTS
 ctKl91FYy47Jk2RHsfRoJnXxmCLA0cNA3mAlBmoOz/REGHF1qeli/uKHRyOtK/rY9Y3H1aV4q
 HAGTAd2qZidx/P115YlNEMPo60Z7uQmCw7MlPa60zgKbeO6lT4EDPzrUQsjlH+RCHtjF0Dv8e
 /3Lvvt68yUHwkAZXUKoaCjnjZvE80adoAofNciw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Sat, 10 Oct 2020, Philippe Blain wrote:

> $ git status # the following is what is shown in my old clone
> On branch other-branch
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
> 	git-legacy-stash
> 	git-remote-testsvn
> 	t/helper/test-line-buffer
> 	t/helper/test-svn-fe

These files were generated previously, but are no longer generated
(`legacy-stash` was retired in favor of the built-in `stash`,
`remote-testsvn` was dropped because it languished for long enough without
anybody picking it back up, and the test helpers were necessary to test
`test-svn`).

Since they are no longer generated, those build products are no longer
desired.

And you don't see them in a fresh clone because they were only compiled in
previous revisions.

So this works as expected.

What you will want to do is to run `git clean -dn` to see what `clean`
would remove, and once satisfied that it's all good, actually remove the
files using `git clean -df`.

Ciao,
Dscho
