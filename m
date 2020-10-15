Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A550C41604
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4A72145D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EelyciIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgJOLtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:49:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:55289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgJOLtX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 07:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602762536;
        bh=U62mrIH0tDvq1yyTwjJpU8STboK4kqDyKz2tqqck46E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EelyciICEES3NXSTsWsUrt928xtlCdacnD5fQhJ+GRYz/ghUvBzG1ynCn/PjbfzLn
         HwviX7uybIqXLiy+ZMPT7ORaLwGe6wrJoqvFuhC9HVU1uP+sJp2DPfNt1bYcMZQG5b
         wfIqBfO4jXtGS4f+3Ox9YIGUyUePr1S/vAygrWlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.213.107]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1kk9CA2Jry-00LSHw; Thu, 15
 Oct 2020 13:48:56 +0200
Date:   Thu, 15 Oct 2020 13:48:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Make test selection easier by specifying description
 substrings instead of just numeric counters
In-Reply-To: <fba0a914-1818-8a24-41b0-35740a7c2d2d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010151347240.56@tvgsbejvaqbjf.bet>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com> <fba0a914-1818-8a24-41b0-35740a7c2d2d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1iX9qJm6sGbAdxQQKnIdGi180t3LJbD+wjQAKEzYK7zUvGbZbXF
 5i4Hy44xkZK4DWo89aknlKZgatC9pI1EGt5p600/BKOsIkZf4ahnT650HWKYz7xgkvQA3qz
 nIvjeDd0gV/QMiUoDSUxkNjW7c5EhhGRBJsBs5bxjpKIHD8fT8SWxiy45txxMd5R5uqeFO6
 D1XHDy5K5UP5+ZILh2Icg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+C0b1mfLnNo=:5hsZIWx9jIV4MY4crme/cP
 uWsmQ337yevMCJmgy6D2gJFCP70o5TMOj3Vi2RPaRQOjZN9ZBhaCT+lxN3IAiiUXmU/dX1Xjt
 OVqlBLq2dlzuXzrbMF3c5vrKS1epmh7qv3ZGIC23gCUsQd7ze/+DjoJ7ASQHOEBC7z4Ly+bd+
 N1S22mN/1Dv/ulC/eGnuQ3PCALyPVreFLbFUkciklvhZ8nwxE3RyWyvQDePpEE/qJh8VIJbOk
 U3JzvgiaggyjBFOuTBHWu/yOq+iJHjqE7TIzxXgLNHt1Lx9MTTTeiZ+2WmRA5fuwva+p9aZ4Z
 NeErmarABCsguiWqx2rug+qINpKdEjLb7R8zGCDMuIEoYN8Sh7v79vyUUKAVfP7UVJoGpAWPy
 RRqjADACW1Prg1JevjLLUbfM2V1WhUKzvyr78BnIwSMo0STtDXAqiweICxfj4+kjlHsy8Wd22
 Xd4iDuWUBjgESyKgmc7iLj+9s7lBhdkM4aIKOlKn+1WpEzIbQaEmj50LQruMe8KYYFYH7TKOb
 75OIKlMJszO1QHpyrp8iwkAuamjUMQNbsf4LX5v1IpzlcHUF0fk0ci7KSQHnVwdFdDHp98osw
 d/ELvjwviy/+gbyppvZz/Ab7P0C4xEZeDgx4cX/VO3Edj72ovXh2I86w7RMNmtat2cOnAb34h
 iZBC9uJM2gUv6z/vbDQAb2R9NL16AICdmlNbonwMFy6+uSBBmhk6l40Vq4bHK+tK1BwIQakt9
 H7+8EfeClT79dlvmle9t1T5924QZB6E+HHGfpzokoFeIUGOUSpuvv8slPzKJYfUzFEX7gz78m
 lyXFsv4Wx4Esrlq1CksudtdKyt9eUVwCf2tb/xOjp/vjzg8NHIkcgMBHizb3H2RhLqrtFxM7t
 wcGVCuzNjmufeTbh8ZQK3crR0lg7d2dH9dW3CZdNU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 13 Oct 2020, Phillip Wood wrote:

> I'm worryingly excited by this series

FWIW I am in the same boat.

> On 13/10/2020 00:26, Elijah Newren via GitGitGadget wrote:
> > This patch series enables me to change
> >
> >   ./t9999-my-test.sh --run=3D1-3,5,17,19
> >
> > into
> >
> >   ./t9999-my-test.sh --run=3Dsetup,rename,symlink
> >
> > and have it pick out tests with "setup", "rename", or "symlink" in the=
ir
> > description and run those. Saves me a lot of time, especially since nu=
mbers
> > for tests aren't readily accessible. The easiest way for me to get the
> > numbers corresponding to the tests I want to run, is to run all the te=
sts
> > and look at the output to match up the descriptions with their numbers=
 --
> > thus defeating the point of selecting just a subset of the tests to ru=
n in
> > the first place.
>
> Yes it's a real pain to have to run all the tests to find the numbers of=
 the
> ones you actually wanted to run. I like patch 3 as well, without it if y=
ou're
> only running a couple of tests it can be hard to find then amongst all t=
he
> skipped tests. I had a quick read of the patches and they looked fine to=
 me.

I learned the trick to run with `--run=3D0` just to figure out the numbers
in a recent Outreachy project, I think it was Slavica who taught me.

But yes, without patch 3, the output looks awfully verbose and you have to
scroll back an insane amount of lines for long test scripts.

Giddy,
Dscho
