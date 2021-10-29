Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0ABC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF29D610E8
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 06:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhJ2Ghn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:37:43 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJ2Ghf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 02:37:35 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgvev-1n9cUD1brx-00hKum; Fri, 29 Oct 2021 08:34:52 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 50C8F1E01E7;
        Fri, 29 Oct 2021 06:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 500JjMnc7VsC; Fri, 29 Oct 2021 08:34:51 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (30-usr-pf-main.vpn.it.cetitec.com [10.8.5.30])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id F3D871E01E6;
        Fri, 29 Oct 2021 08:34:50 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Fri, 29 Oct 2021 08:34:51 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git
 pull --no-verify"
Message-ID: <YXuWC7zCyVz8s6Yr@pflmari>
References: <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
 <YXrFy9I1KPz3IZyp@pflmari>
 <xmqqv91hrt2y.fsf@gitster.g>
 <YXra5UgxtgVubJL/@pflmari>
 <xmqqmtmtq7dy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtmtq7dy.fsf@gitster.g>
X-Provags-ID: V03:K1:2t1B1qywpOAqdA0283PZhL/Tod7RGntuHBxeEZWcSgXjGCuX+IZ
 krD6PeDacfDcUbv/7EK7v7/LUv4QNgZqVmcCBhygneVMDjAaVDaMibGXrXh2UT27tXHe9Ya
 J2t66XU/9ce837lxWE6kJzTXcW3dOUI7TuyEd5x29rZSomrKA5Xt1mvyL2/c6ULceoDyeKp
 +HvPwKL50yyfJzBNq55lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3yj37bnS0ZQ=:bFL44SGrWoVcSyOgi+fEbD
 3EttuZnfgvrSuOgKN7PBxPBwXFpHXV04sG66VX7jQ0NrEcZU1EeLduLjzcOV45uFDt3rnKKjl
 T7nfKwWE63hsdLRwsxQYr7GsPXBSDfJrb8kaX0mguLXl8qRvHxo0LuMwElRMcGW16YBXsqIE+
 S6ZUmXRA4rai41p4bN1ZwSOKr5j4uKH/hZdMaUJCgnwG6OvGwf4AtwoPfgL15hqrfm32ANo0r
 LFi1cqviZqEcWq+zrY4Wmd4K6dOKVKYR59JwhMyghbh5nFmCeJkPZEMkHo/cajm5lF1R7fxvk
 R4Hnj50cpYnJJrTAfn5gBKa1vPjRNWtF2mDveoz9a5c4L7c/y238ceoVIqqjt1S3b1OCT4+I0
 ylh/JcprpH70QObkwdvEbPYtfpqgpfIYVvpf15g0SMA7QPwAbl5Z/HjQ3rqa2aUOdxszjA0pJ
 UonxdromaXiUA7LyY7Vw0nxfjVNEpI/NuNF3cVwhcfK80noqvp6IVUIpTx1o6Fid69ynK3Krw
 QIrmC1MHS/gcB8PXmzfrIIGPBIyKVT6iM9JwpGWCLLiFHhcUG41JAhy2yaLeNZ16N0M+7gmKt
 dVndONfwXcHGH9zkl4/eXQQ6oYLaGFqOcoia6p8srZ9jfcsf44bNwD8DWR4DeThPFZEoBxq6F
 e9MgcGDXCkPNVnqsPsNzz0FHW9O3WIQT5v0R5Xankxq6SkCTB0gIA/7I/mOpcx3PUEZ8sLnK0
 CDP3oFaOOPi2slbf
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Thu, Oct 28, 2021 21:25:13 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > Junio C Hamano, Thu, Oct 28, 2021 18:51:17 +0200:
> >> Alex Riesen <alexander.riesen@cetitec.com> writes:
> >> 
> >> > Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git pull --no-verify"
> >> 
> >> Perhaps
> >> 
> >>     Subject: [PATCH] pull: honor --no-verify and do not call the commit-msg hook
> >> 
> >> instead.
> >
> > Looks fine from my side. Shall I resend?
> 
> If you are OK with the updated text, then I can locally amend.

Yes, of course! Thanks!
