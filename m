Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0894C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B675A2173E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OYX3MVS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFPwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:52:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:49879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfLFPwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 10:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575647557;
        bh=eKrC427ZjE4aHY1pi23TFIFhJNSYNNdiYucfo6KFAoI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OYX3MVS8nS3yLUU2jG6wJeuY4/JR69DGypEhux+fdri52bs2xd23D/OmMNqjngQ1C
         62spmWk7STC1/bRjIAOO4guFa7S+CNEWBJ3sSU1VMW/OEKZ3rJMqdQ+na3xAudvBgz
         IkJ42yxuFQU3Trmkowxi8TifkVfYd1hxuiAIxHmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1hs0ye3K2W-00wZ2j; Fri, 06
 Dec 2019 16:52:36 +0100
Date:   Fri, 6 Dec 2019 16:52:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org
Subject: ag/edit-todo-drop-check, Re: What's cooking in git.git (Dec 2019,
 #02; Thu, 5)
In-Reply-To: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912061651110.31080@tvgsbejvaqbjf.bet>
References: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b/83A7kdPXMf7G/FMbuGPktjexuvEwJXz8gM5ls0Iv38xs+77gQ
 wHfrnFjp+pJxo5TvqFWJikM4DTcjFHOEWB0R9Qlyt70VUXaKOBxjIMCI75KdhO7S8WI1YTb
 wMan0Mfgo8YFtjzj2VtzCS4eoZMyrD7AaxLjG09aW6MEduIEUz4y82bKPQXfLe5eZ9sRDPu
 by2by0MeVI0yf6fzScwYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9g5qzwjZDo=:eMqdxcv1y+OasVfpP7ShnV
 rrPmfKz3hOoYk0UZkhOtu4CsOB2a3FTOwB5Bo5SftGQOOa8HT0xXjfMYgW0ObMocwY7yzpGrR
 tR2C6ebxJ20KGAH2NAoqaf2TrS+LgjHRAQ/atxFG1FVpk90DWjLgiXBbsous3H0TLL+A1nDsz
 +Qf2L7jcq5FBUpqiVHBYKRoadUX2Ahy6E9hO7VfPlFVCKWzWwsCoKtLHajwHb0JWN2958ovCC
 GD0mg6bC8/+3Gg2aDwciz7pxJqONdyRWkBSJRaK0y+Lo4BJRk4ARC+U8QUZptjSimWlkTdrxA
 mSRLfqU9wE/zp0Q2jzqvL26vrENb60fnkSLwaRmuvt2+hNc6eO95MwCN99racvbS9GIw7SAqM
 HvANhU6b0ug7hp2/fe+yHwLwXxBi+29Mysf+2bA5pSC9bR/npOTkFpTV9bD0eWFiIej/Nu+/T
 ylHH7TNmnNOCBV+Y7pwNagt0Zd1pDKmdbKlCSL2dfgEtzBn6wwKZ8Dq8T1/jTVp5vw04nDm3m
 2qO4Vyw4ranQLmPc1JJ5stLvu1YpDuG5P7W9+J8cFpZheTJaZVQoYuF1Mzbrr7RWN8HKYTCwC
 ZHP3NEs8nei2pmDF1JVBov8CEkUwO17e4lBbdwY+/6bBFwgO1qR1O0g/EN7/fzFaYrIrkHRHn
 ctBXpWg4K67QxboRwcThxpN2G/rDN+Mzgy54Dbv6iWvNGPQwWEn1GIhu3WQk78ACRY9CsFisi
 romWBxbEJYiK+q5ZAHasUsMwcnmlbwxOy+HnhUvP+z5XzDUXFOm+6U7OwuNk9NoGIljne91cM
 qPoNO6jv41nVBX0ZvUvs+zV8ZmVdZgW/0fHqbPMkNLmCoVt38ekMXlGYax8E+ggfeUBmobcJG
 4eVJTfZa1er9xvYpJUlH65TqoNaFSu+YsJJfcE9QRxYYZsmzjXCmQmmLc0/VvW+hMMoAWcGvu
 4xO7Me5iJLgXO8ZwoF6aGHIlkqawBRL8yZJcr95fdZO2UppPBdnq1rP0/8U+640jbbcnfwYjc
 61Kwkek4jTvwcb44EbU6CpDniJJWw2jASvW3396Dgpllm6beqCVyrF45npU25ZpsmVOlRHy/g
 TW84IhlrdvaONoplgnpkyfjD2U6zx8YVhfbtlOR0cU1cNvJHY0ERVpe6DtBeAvDJ6c+WtlXGN
 GabB8MMv4DlI2Ya0IGIqNdNfmO7vZDI+QwbLF4tPrPTCdEjSO1m55jSvIzEEHz/RqNLxpfdtm
 GO8n2dzDKvkdoR2yBDDFvx5LFPfRaDZLBeRnEjMVXThWFXm4vT9NI+J9r6dU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Alban,

On Thu, 5 Dec 2019, Junio C Hamano wrote:

> * ag/edit-todo-drop-check (2019-12-04) 2 commits
>  - rebase-interactive: warn if commit is dropped with `rebase --edit-tod=
o'
>  - sequencer: move check_todo_list_from_file() to rebase-interactive.c
>  (this branch uses ag/sequencer-todo-updates.)
>
>  Allow the rebase.missingCommitsCheck configuration to kick in when
>  "rebase --edit-todo" and "rebase --continue" restarts the procedure.
>
>  Seems to break when merged to 'pu'.

I provided a patch that intends to fix up the tip commit.

Ciao,
Dscho
