Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8CC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKVRxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiKVRw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:52:56 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076988FBD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669139325; bh=GLG7UVwm1ReE8m7J2H2sYVtT+mugm0SrHpBuHCGcPz4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=L79Jl3hmFw2WoKsmQYieIYyYebQNTUQ0RQbaMVXCi+ckdDsfUo9eX/ORQ+6Ey1+Df
         HVuc2fGSR2lnneDBFrQ/Obe6wAbkLwjSdseczIGR994DqHZ/4d3cnxP8lVKJcQtKqT
         ProuJhLPqbmykrF2MhsbsPFo0/OFRnT6hhAmDPZB8geUbwQUGZWwYH1QofCAVwC6RQ
         swCnK16sr3ZDNDSIuDG60l+TVGVv0HkcCPcwVR4OPtzeIcBlyr+yFuRkbb/WYP6QOJ
         lSkcEcvP1hsdYWp5gHAwWlFl7YXezTPAzbv+5hZaaZXZZeY5oLTY5PIuATG83ZxdWI
         nkMstELaoS8jA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2ke-1oiBIT1SeW-00FRMp; Tue, 22
 Nov 2022 18:48:45 +0100
Message-ID: <7386132c-995a-5bfc-ed67-ec6dc2c3e7f9@web.de>
Date:   Tue, 22 Nov 2022 18:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: git tag -l --format results into a malloc fatal error, if tag is
 signed.
To:     =?UTF-8?Q?Jan-Otto_Kr=c3=b6pke?= <mail@jkroepke.de>,
        git@vger.kernel.org
References: <CAAsn9Yxbb3-4iTfD8gf_EhVbE+yKJdT=Vb5ojeFZOHvMutUn2Q@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAAsn9Yxbb3-4iTfD8gf_EhVbE+yKJdT=Vb5ojeFZOHvMutUn2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:erbZP4ZuZ/9QwKULaKwYZGI2b/nO5n5aFB3sF2vxRAeTcClphLa
 Pu3fEbaoHOTdj6enLewi0eyBuH9s4vGhmCs43XC7yYI+UvgvW9ctpPQpmAK7DOhBOn8Z6bz
 k/SwzgryyWV383TTUkMpj6bTEyLuVzYp3NZkcXAEvtWn+E4S69+xROncqZ6niJ4KdwKrV9M
 E6dZyK7rQVnrjf0BXA45Q==
UI-OutboundReport: notjunk:1;M01:P0:1APilZevLko=;39fqLTuDpRVEZ33rmlsnJPpZY1h
 anT7EJfYw45NUB6ngnUpfyvI7qTlQEA7E00vM77VonCV4tgNxNpK/t8EYv0mCYBamnoqxDz/+
 NvSQvMyyOZsJ+3VcGdnrhv8GwW2YoUGBVeNDdAuPjI17pu9dMSyXkn1z3BC92BzJu8D8IsCgs
 B9/7cG5CtUkppbuyZ0vdIt4JT71gLAJ061lPLIdb3SHU7M27piGLXL6pkKi+wcBtMyfH7w2S+
 GXQlCPDf5pOLoeH6ki2X4+BNcpJeZPs8OIr7DfnFX1LOZRz5IVNhL6uI4cTz0aETQTqYLo/wL
 AzwV+H/kz6KPfo0h19hKYVpRBO49rTG5ijRMWE09CJ/XQc8Gmhlxm5yPZagGs+OUbvNoDlZ3H
 EngWhQUEHAKZdLJOVzVT8hKF12cNWP3xCVHiBr4+LydwOqxQAcNRS+gLsvguG2IipkpN25dDO
 rnP63bKe6P1CGoe1G+pKAWZnEy+dLeoniSWA6epa49VNL6Md8Wi6zti2Xbel6IVEbjD8hOony
 VBW43D6t/biEOUrO1uzqYFqxfxQvUtZiE7ux3VUccruvpSuGaw2dJgFRcnzv/b6BNT1IU5AQE
 duaHdu3SmK5R9ctQVMf1agQWF4binC1o3bcWF06o5gXQoTc41DBhpsRO0mfWK6DTqo4I4Y41a
 KCYB6DaOH8v9Vt67xKhZScLXFwKLA5iZTrdeR0eCBbmZbZ7v8DV2xrCZDTdoZTzyJcWXAXJ8+
 WVCCWs0bFBBScm0k8uUacMVBN4QisNVe02d/WsITbwFXMB+d2te6gO0q6y79RIo+HvSxBT9QC
 OKeComwtQdTHdBlhvsYH+yhN7YfvEPCHUltCKtPu8mZQQokChJIjMvZjoMPx9DA7SwBRcV267
 yt13uWXB0/8QPJMb5AL8vY9CVJEHTnz9llOZtZg5i3UEZC9m1N/mVY+d58tbf6qttUvB90q/X
 Y1PCnQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.11.22 um 09:01 schrieb Jan-Otto Kr=C3=B6pke:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Create a signed git tag signed by a SSH key and run this command
> (orginally executed by goreleaser).
> % git -c log.showSignature=3Dfalse tag -l --format=3D'%(contents:body)' =
v4.2.2
>
> What did you expect to happen? (Expected behavior)
> Command executed successfully
>
> What happened instead? (Actual behavior)
> % git -c log.showSignature=3Dfalse tag -l --format=3D'%(contents:body)' =
v4.2.2
> fatal: Out of memory, malloc failed (tried to allocate
> 18446744073709551323 bytes)

Fixed by b01e1c7ef0 (ref-filter: fix parsing of signatures without blank
lines, 2022-11-02).  It hasn't made it into a release, yet, but I would
expect it to be included in an upcoming version 2.38.2.  Discussion:
https://lore.kernel.org/git/Y2IfT0UFJ7H%2FmHMz@coredump.intra.peff.net/.

>
>
> What's different between what you expected and what actually happened?
> See above
>
> Anything else you want to add:
>
> Reference repository: https://github.com/jkroepke/helm-secrets
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.38.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.1.0 Darwin Kernel Version 22.1.0: Sun Oct  9 20:14:54
> PDT 2022; root:xnu-8792.41.9~2/RELEASE_X86_64 x86_64
> compiler info: clang: 14.0.0 (clang-1400.0.29.102)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]

