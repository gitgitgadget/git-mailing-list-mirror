Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655E2C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377AB20706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JXtQjFNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgFXM5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:57:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:44689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390686AbgFXM5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 08:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593003406;
        bh=uVgCOzc3tvnzyjXQa/2yx4IMP8MPabtOpxULlsfAAEs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JXtQjFNNyZwtqkRKLjydJx5wMXGDvOa0Fa9aQO4uFYSc1dD47mQGpGuIBfYkLZJ93
         dqDVPtQkYHWytoctnxDSPDBTOlzsyCFBixIuyLJZqI4lyPcXy8SrSW8BRPdj+6o5+u
         C/hKcs49z8+Pu+3KauwR3WEYvh9fhYVE1J29uq+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1j59pi0X9A-00prYi; Wed, 24
 Jun 2020 14:56:46 +0200
Date:   Wed, 24 Jun 2020 14:56:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 5/8] init: allow setting the default for the initial
 branch name via the config
In-Reply-To: <xmqqftal9su2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006241455210.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <a500e0f214a0ea4bf5cf4e26f688ae68a0b84bcd.1592951611.git.gitgitgadget@gmail.com> <xmqqftal9su2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FE5IajDthILzDwTWt3ToZGkJqZwS4sI0k/0jCJL4N4zackDFLy0
 aWEGQM01SeKGR45d8fbUYtF1BdNj85hZ2/mkSakBXK8DufMcKJeTYHuMviB3tdiFdZQ8Y27
 plho2v8czldyHX00ltPBKe2+icAiamgzz2lB+xGd2c8s/X43wjVUtxS63Zu6daoG2vdUUnC
 uL6T/YhqakWYRva91cYeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KybYI4dyYho=:9ZtmUcVmc581MfXkvj5yL1
 Um7tA0uOMNVFeRw81+iVr4MWUL6kXuBRIDEXSEWQIGVlJhagYZm9Id+sDw33E74dfimYTOiIJ
 HN4tKZr8MZCaCOwk62RLT2MDbYvbfVXgFvKMC5hGCGTi9dEAzAur7i1mx4DU+lEfyVFwoceJf
 8zMscfoJ+2Kz2uuMAnZqUShDtdXtMO1Gt17vswW+iqNFMzGGhwlfH+uShmTpTglcKm5bZQapI
 uAmA0VKmUjmMyV+8/owIqR7OknWCm/nT/XyRwSz8f7v11YmytufI1Pgurxutbq6P8blGo690n
 FZU6iVCfzu5lNtj37PR5R6IqTEjeQsJkqZ3BDzkYGvVERTW1dIfK9wzV+5if6cDJFSjUuFcUS
 OyMhxoPH1bkHrPK+Ck2dDwiSw1o/eZ614i73KUPXNQPsmFKz8UGH2xdvMo8yZPAxxKLWVSbhq
 x0jZN8T1ZGQF6VzQAVa9jxcbIYmQY1ABfD0oYgp9bwwBU4yaZ/kWmlp8nF8UTexiE+z9af1PO
 fMq6y97Jp6ZBNDDjCPBTek5/lhL7EKTQ0lkOgqqlhjbHTte/Q/nyrrTlFnbwvaKC+94tD1gQa
 K0f6cyPb2azWesNTenO5ioNBwfp2WhPfdAKrIbmKF4ny67a5lqL9oQaFOTeBuagJdIF8ngB1E
 NejDM8YJ9vI6VBei59uhIHrFhvC18MCFlNhzyUBADC3iIhFaYjxBVVzNs5ls6cyut8a/dYyhW
 wR/JNY7biMiamzQT4pXqrTAAPuRlVOWKKLthxjv+7fKqBNdSzYjGOWtqEIXaV3X/goYlnHy8Z
 dnZN2KGdHOSrpsK4WaNtRIyfpDwdshQBvSJoGFcYddFjKKSjqUHdiYkZ+2di40JbfVwPu4AA+
 3Jq7kifmPiOSk3TprxBWds0vVUNXE5J7T+L/K8f7UAw6iR8/IC4ibttDM1M3j+nVYhErY551D
 7FqA5cz1LnLHzDIHNFvI9GQcAstNNMt4nid1UKjuXwY5813cgXJMnEXg3CpYOqlbCEm5z8Fq0
 vSjOjDAhUEPqN5Eh7WHQdRnsY02N31w7liBybmGdlrJtjmpwfNDX0AUolzZ3G1HefoBEXNk6s
 eB4zM7KnJKkL1NCUqq4YynLoQK/C37t09wz/kuVhhIdy26tDaB2YEc8HBHHudyVxDa8jx02S7
 LRMQJqvWXmDddexric+73SWqVBNeOmGBt7CDhtrg15R23Ra72eZa2s75qD7JIufmJJwxlCoTf
 GwEL4G7yVp07Ui8Lv
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index a898153901..b8634b5f35 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -269,7 +269,7 @@ static int create_default_files(const char *templa=
te_path,
> >  		char *ref;
> >
> >  		if (!initial_branch)
> > -			initial_branch =3D "master";
> > +			initial_branch =3D git_default_branch_name();
> >
> >  		ref =3D xstrfmt("refs/heads/%s", initial_branch);
> >  		if (check_refname_format(ref, 0) < 0)
>
> Continuing with the division of labor between this helper and its
> caller, I had this funny dislike of falling back here and not in the
> caller.  But with the same idea of using "reinit", we could get rid
> of this "if the caller didn't give us initial_branch, fall back
> to..." logic from the function.  The caller may do
>
> 	reinit =3D create_default_files(...
> 			initial_branch ? initial_branch : "master",
> 			...);
> 	if (reinit || initial_branch)
> 		warning(_(...));
>
> in the previous step and then we can teach the caller to use the
> configured value instead of the hardcoded "master".

While that is really tempting, there is another called of `init_db()`
(which calls `create_default_files()`): `builtin/clone.c`. And I do not
wish to duplicate the logic there.

So I left this as-is.

Ciao,
Dscho

>
> That's much better ;-)
>
> Other than that, looks good to me.
>
> Thanks.
>
