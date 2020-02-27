Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B7C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D6E20801
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FNTQK/Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgB0Pkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:40:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:58341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbgB0Pkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582818040;
        bh=wWWdLhmbVBBSJoqad4Wm6k8fZXtJcefksmTyli5UwQ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FNTQK/KuzYdQuzqeE092gRVeo/yT3P70UKz1Oy5VyLMH/rXiC55mJUZP2++uIy0ru
         4pDp50luftpA25CNMZGCGMdrGcm2MGSVj4Sz3BwwS4hhYI9YpBL5Rlu5otgUNuSsMh
         t6mryRURmk3KSgpYOkhfZYTBEOIVuxGPkwGFi80w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.114.107.104]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1jRT733zL4-015rSj; Thu, 27
 Feb 2020 16:40:40 +0100
Date:   Thu, 27 Feb 2020 16:40:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ed Maste <emaste@freebsd.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
In-Reply-To: <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002271640320.46@tvgsbejvaqbjf.bet>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com> <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com> <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yzjNlVm6Of7NAwQ1ANA0Pc7RWgk8ND38pnpE8HL5YDLYyIV7HPh
 eJQd3iOfIzmmVo08fLl0R1QHmwRt0CfD2mFZdjnbvDnqnLhVbxdtnp+1ivZ0WjMDVMj/6Sa
 guloTwp7B80PNsYexjeG5I03L+hmBae8XE9K2wnLZlwun5MZBkcneez0YwzwFbCOGhfqo/B
 4B3NLY2vhTLqHHneRmO5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pFN7Q7KmcOY=:HASMym5sdVGv5bQJGx14tp
 mb8eB+a44ohL51Ud4CPoLKbRiTR5ZolqgVVjuH0A6AiLRsgZHLCd7bo3D3vyTsbcVYaDqo1Uu
 8f/1d/IxuXMyFAaqLiSSjB0ZrYiUtPovrZvn4pPveR0bfzb5YDVf5TdIvuQtFKyd3Yc26bx7f
 oAKoFpdJL1hFyPmAnAEjZC6zDZYHfqYl42JGLcw/fZZWDObOXLrhiaMlIbzrMP54CNVGTC5iS
 fqwyFFn/4lwvY5U15OqE0vGC+sOBlc9i/iHewc0DXIhmBq/5+u0VHH9g9jxPvRny+fUQXaycf
 Y0NPVUBs8GYgaLW2dnGzkA7wkp55kiQgyLhI2FFKqjkz3qzw65QNS7Rctxph0jRDam6h9fD4q
 QCob4u6PbFn8swzCPTwpD+ZqFGq1JKc/zSjr0ijcqixSU8Ye+4ObaHKKhwr+3xmDry5HbKJ1H
 PEpcNhDLetZEOfndihxqKyD7wt7lO8+/AqGzrMT6VHsE1nPiMAtkmuIDyOAwgzM8RgUOYY+ZJ
 JYpMxbmlbXbzIPsXIcOxOZw1jDrdgo7nuJutqYoWlxirzE52Gc7fvcMede0dw4cmM8e+impWe
 GiZJJKdQONfbE4+Jy6rdwa6D4G/QDSazw99Qn9ucUqBSuh59urmDm5vhy6YyRZi2uREpqy3Am
 ftCE7FAGF3BXP97uVlK2nPZ6rbnnG3XksKjp2T3rp7lcllbooWeiGHIfADHSKPJC8fOuqTsqW
 UJnupHj8N6asm8TduRl90mH2XmnlXNRoUlWRQNgGgCyQDb4lC7erFMNOrz5mDdiu5HULWaTun
 N/qxpiXkl7LcAP4rL9l2lzI1plzhHSSODsYPrmKdZ5MZYIKuI9SNv+Gq/J63TInIdc1vCXag5
 k2xaK0DhpwcPHOJuVk82JWg6jWoeRJEWQ1jzt8aZMNPpTfcyeNAhuSaCLtM4K5bhn7+u6TySD
 KSuwHFQMDq38soieO4/3cgl/sf2rTvks95m1I64Uh8aFfjPpulGkJL0BuZYBgkJBTa178it6Q
 PUHrdv83U/hcnr6fbdQFCmD3A/cjzfh70S1dcxhGt9kUj3yu7t6V9mLjXPcCG77EQTPQQtzLd
 7tO4pHp0MndPKxTIOAP3/D5MQrXpjmeNmo0OaYq6q5l8LQsbvQJrobMZbpMSbe95tzvyl2ynM
 Sh7q73a7l4onzD1opwmHd3ITR51Y4ck+MNM2DZP3W8eci/DzvrAKc2asRke153ttWH+f9lRVy
 BWrGfejuDYznIRvxo
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Wed, 26 Feb 2020, Ed Maste wrote:

> On Wed, 26 Feb 2020 at 15:09, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Among other differences relative to GNU sed, BSD sed always ends its
> > output with a trailing newline, even if the input did not have such a
> > trailing newline.
> >
> > Surprisingly, this makes three httpd-based tests fail on macOS: t5616,
> > t5702 and t5703. ("Surprisingly" because those tests have been around
> > for some time, but apparently nobody runs them on macOS with a working
> > Apache2 setup.)
>
> Hmm, this is interesting - all tests (that are executed) are passing
> on FreeBSD, in CI.
>
> I tried on FreeBSD and do not see a trailing newline added; I'm not
> sure how sed behaves on other BSDs. However, you probably want to
> refer to macOS sed rather than BSD sed in the commit.

My bad. I looked at StackOverflow and there the claim was that all BSD
seds behave that way.

Of course, SO always lags behind by a couple years (although even such old
threads are often very useful), so it is possible that _old_ BSD sed
behaved that way.

In any case, I adjusted the commit message.

Related, I saw that Cirrus CI offers FreeBSD builds, maybe you'd be
interested in supporting that out of the box in
https://github.com/git/git?

Ciao,
Dscho
