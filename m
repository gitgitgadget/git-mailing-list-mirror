Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D60C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4CF20C09
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IG2LO1Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIWUot (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:44:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:56593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 16:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600893869;
        bh=HxZraaZ9GhleFlD3dDZZ+AMTa7gOw7Kg03smBhouD74=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IG2LO1QjKBX0fMn1lOgnzswqOTJR3O4S72z2Hf2wUCJHM7FbKifO4KRa4F0kO4/7t
         AzEEkvl1ho4BTMZocMwDew7sMi/SSxSX6CDKKaAoeQMiB0G1rCKwOH+go0ZDtHzhN5
         nW548m76Dyv8tTGZhQvhi/Wca+xsfmGC/hvL0MTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1kv4fo0fBt-00appu; Wed, 23
 Sep 2020 22:44:29 +0200
Date:   Wed, 23 Sep 2020 22:44:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
In-Reply-To: <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com> <20200918172747.GD183026@coredump.intra.peff.net> <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com> <xmqq363fm02a.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet> <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P/BttjAPp8NxgWjMkYMxt8RLXm5QybAVab3msV1xkyNqdVFBrXb
 +LjLdw98O3MV/p+mtg33t9htRdeluBuKJ0AtQ89Z3ZSM9+XnuDNpLqhUCkeDP//wuxhX4s8
 LNtEbr9BrQ0/t+dUnA/H3wHABglfNew9JZo3fJGzoi9D7wq4EKbulWa/sP2tU0IrrBNdiaq
 0ILVG9gqChJsyFhZbCUKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FuHPqqtC560=:ZROFaIA3f1jEECWBKVYmTf
 HCjAsuPG/+aZtA8q8TsJp6jnCBbmdpR8hhrbEaOpV1Czx/mu7Oo9uNmEYMXCgiojHNxP28jP4
 hr4Sx3wHuxMKC/S7q8X2hb0aYi0RO++LNNidCst178NNDZtargmZXIY90eplNQXlBltMnmC5a
 Aq0eXLtlMfx2nS0tT1WelcryNK8iDMuhX4PxFHmvdRlpXbmLqkzCE9FF6QvRbn7/IZP9+pbCX
 oqkeL7eY4YNS2i+nN2TwF1PicXgdjK/RQX9U7kkKHBg4dGN4im5cLAhojCcZaAH9OWhRZRoE2
 xktBV/c+mwelnRhc4/uDfThkro35J5SO4eDG59GhszSk+ozJVcVYXqIbZ8Pc2MpbXyZ6cLyEg
 w0BprqdKPKrDHaIvfWJSA1LQ1RwfSO8wGp0UnPZHrkf+0v21JMhI1fFa6/AlwAuiTfoSTnZBQ
 NIO8GMluGmt1+GUknKAK7bPRJGdngvmd+L3f520TNNL/hQOZOw8RwBPBunKgbygNTLjQbJmca
 0s5oSX1S0IH+thxotcxqqUxMzyyysR/pRDTOOPPT62UH0hoYHjmCwLHA/NOkTrDjk7+ylvVRZ
 DP+hwb6NtrHzoBWfNaBaykN1MgOl03KCkK8gNPNlFxVLeUWvrU4a58JihBMV3SC8Fx1Sv5yiR
 V7QR4skMSKT2qdDIgvvNFqgiNTJTZJCMZURUUIIKvV9dPS074bncq8Ui39B8pp4DWuZc3VgLz
 fnyq2y+0R+t17BVESdCLklwMgFB4kbU7k0O3Eg/UfeNR25Q5JzwfjTk9f1YlaUPgYCfJd2nmM
 uHz4bG5Hgz8MdJ8mhmuFYhfRjO1DBEdLzd1VhjTqxmmhLTV2Xt5HqJS9Li48zvITmViKXMyf+
 sO7Sh1cm3FsuQtDFWdgSN6WlIJUqKXxR6Mh6H4TcU1Wyr2I6tvzzcsyY3PhUJaIRTkgXyIEoC
 BfCqlUJqFR+Onq572qGQuNIERjqIAHKu23v3DpZ4Qf10gpPBJzgF8sq548Bo5Qn4oP/msfKLp
 xBth7QWfQrgzTuKuJ2gkTo77PgZZnipi5+l7q216rEM25Bedd1nfh0UsSwLAEaDDiBbPR0OQZ
 g0EVm4Kg3rgqI7//4fdhJa1UZQZTiRszhYCfx1DcaNsN/KUJXXWhotJXryzNrj1jmpUF9Qq1J
 NgSykY6wIclH2wenrwT+76GZ35oHQwUhY22XasGYdL5VKHfwg3tG0DWBAEcYBRyYsBOQf98Xz
 FC05w6+3MHCafxySdrjTeW/yHvEI3xyouNkAuIA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I believe that that is exactly the reason why we want this:
> >
> > -	same_contents =3D oideq(&one->oid, &two->oid);
> > +	same_contents =3D one->oid_valid && two->oid_valid ?
> > 		oideq(&one->oid, &two->oid) : !strcmp(one->data, two->data);
>
> Not quite.  The other side should either be
>
> 	one->size =3D=3D two->size && !memcmp(...)

Right!

Thank you for correcting my mistake,
Dscho

>
> or just left to false, as the downstream code must be prepared for
> same_contents being false even when one and two turns out to be
> not-byte-for-byte-same but equivalent anyway.
