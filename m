Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717AAC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D42E20706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 12:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Up7GEGLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHXMr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:47:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:47437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHXMrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 08:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598273234;
        bh=pHg19xZjZyHmyb/e1eGS4CdmxbJ4o2cD1b0ocMOC/5I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Up7GEGLV8szMvaT43qC97xyvc1fv6TyxavKSLY56Ugcj6807FJ4DXO/b8Pk0h7KFV
         EatT4+5ewb9oUvYK8iniasz6I70ktZgxYEWcia8S2N0U9G6e/VQpfZHQTQiLm+k6cq
         mMHGov7MAKarD9gQW76yoi8heNrQT09bACcwIzKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.214.173]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1kEIbr01XF-004iLy; Mon, 24
 Aug 2020 14:47:14 +0200
Date:   Mon, 24 Aug 2020 14:47:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
In-Reply-To: <xmqqblj92lro.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet> <xmqqblj92lro.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mz3lbEfoPAfa6bpJSaS+TgNp3vrN2wjYaVkUM68gNRgpYfZukmg
 9rosQD33jKgO37B6JqwuodBJFUW9oasxR2rctoAerz/xVvPg2cWZwQljmbZ0WSqbllzKUEz
 5Lj2voyM/0mkh532u9DN1oVIUj73miLDSLg23foX9NEyD++Q4JVuGnwaML8Dmncmcc6h2YI
 w/9Ihtz3syoi431UEdCVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTLC0hYTFbA=:igNSkSnqVud7eyJBpfx4Yo
 7/bsm3iR+4UUX3SdfvNe7Mj1EVgBkfbX6w8gEiI2oDSK1cnPEYrHIpg4YNkMEdbn6W9y7NDfd
 vNbbxAfZBN+Muqn2ADZj+A0sRQApbo1gHv9nkO0sQiID+ZzM+5F156d1vUoy1o9AaOWmMAkzf
 Umj0fKVe64LNPaanXDnWlilYMlLYL5F20dPf6yeyEYhjx/0jfZE92LCkknJb1MpbX4+EKt86x
 4vyP3hZDgkS98GEvNfbQY+e1qlIB2llWmtOnMYkE8ZSVitr1sb/gU0GdJc7Qhu3k2mCyG3X/+
 8NZsKfR+HPmmrFKmIZOE/W48HMp/0sHIzAR1Rey5FiNyqD35eLqdt941wy6zgE4yE9qYMTBtK
 zGGsWuiDbqo2qb8TGu5bUjiNqU0si5xhOrOUxmjp3hf/Go1yH6K/Y4DJLsigHCbHlN/K1voNZ
 I1Ob18mEG1YSQ/3UofkzgWhMaoALbzoT7MO19tlYpO8ujFxvOk+AF+JEOgXj076TLeSUTKAyX
 uEi/ZjiImVy8DcGKiF7RW6pK/vR35ShWc7fIdnusdXmZ8ujN/9dtTGwnMGqkkYMuLHnQhAaIh
 tjRar3Yc80454UASa8icIZuVdNq8dgdyrlDl7qFTNMjrBvl+5p0xU+GouGSDBYGb7nn0DqKJd
 PxM0HM6LDq6uWy4ovm5eyduvHHVR3qLI7JF6HiNYmD1qtaGd1f0hcYtHT51QC67SEmRQDHTRa
 c2xUWLj8iSA4tJw9vvCBR9B+DLClX7W7Si6uDvdXJWL5z/l9ch9vB7CADi2uTdNeC08Fcw0sc
 2iq8YIvNXRgcpRcOs58Dr71usI+94MU5Av+gd1J/sVB0VSSU9JesmLsv1HX0VeVrdMUSstfZ3
 UJmy9Z+8LKNvkXS0L9+ssrC0SsBERKKFkBbH5R2qrzF+loZF3cJFSglZoCqlVE4y7ECeSUNCu
 /fEe03GjvUvCIQrzt1dAFe+e5Yj1cQcZFq/G0f5BO/dN23Sv0mdQiv0oUkdFbOWdxBkh635iM
 XKMkWeZEKNXugygvw1NQzrRb+wbWPqa1sf0MLxnNj/rz23Z7hdkncRtJYbdrVIKvMQ1F2h0pM
 5TLqNw37wxi/mDkQYgZjMsNPIvOHS7E4SBhpX1EFV6HODDxOMcv2om7/AMAH5TFlPaZZChmYT
 BSe5M4BDzK8vv6geqPsHgSXlmmuokeix6BLjdp2s4XPqnaaEImCyKe1+Um8OsfjgzI3CVH3r1
 cNxYO3cTSAmq7RoZgjRv9a41sITshnBiCWHeIsGw1WVa6kaqHGhhVREZK3zs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> This addresses https://github.com/gitgitgadget/git/issues/406
> >
> > Please note that this GitGitGadget run did not work as intended. The
> > intention of https://github.com/gitgitgadget/gitgitgadget/pull/296 was=
 to
> > use the actual author in the `From:` headers of the sent emails, with
> > GitGitGadget mentioned in the `Sender:` header, but apparently this di=
d
> > not work, and I will be reverting that PR for the time being.
>
> It is close ;-)
>
> The author name is correctly on "From:" but not the address.

Yes, but the problem seems to be insurmountable, as I _think_ it is to
prevent spammers from successfully sending "from abitrary email
addresses".

GMail adds an `X-Google-Original-From:` header with the original `From:`
header, and drops the `Sender:` header.

There _might_ be other SMTP servers out there that might allow us to do
this for GitGitGadget, but I am wary of undermining anti-spam measures
that way.

Ciao,
Dscho
