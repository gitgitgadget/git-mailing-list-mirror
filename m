Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C9C4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B07207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Avbe/lu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgJGTqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 15:46:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:58953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgJGTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 15:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602099998;
        bh=WnyxdDWlqn7VsCb6M/C4j9VdFG82UuYieamK+7yLuqU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Avbe/lu7Qtn8znxHgoP6gNjHz3ss304S3i7G+S1HLG2eWTQhHOMZI1S93OYF9z2qg
         22AxRufh/mJcR4zCFGuVhMx9wEswFKnjzsjg/1ojo2xR1Js8FngLujIz3O7+LaIJx2
         BseC6CwCDFZWR5ohyfJneUfnaThEUT6XxhtVSoZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1kPy970pXv-000qjG; Wed, 07
 Oct 2020 21:46:38 +0200
Date:   Wed, 7 Oct 2020 21:46:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 0/7] subtree: Fix handling of complex history
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010072143390.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e5mr6/4mgObBSu9//KbP78WnZH4AXa65jb9r2nLL3Q/2tla5e+V
 JPh3/oM9NwcvVaoE3ayTtd7mL+cDYEDEuYpf5AbOA11xuvDLkhUY2oQH6WqNaho5RycmREm
 NMH4wVxkV9/eo8ivmGBCXfvLjgjK48/iHnfm/wCcdQxFX1DKkU09NqRI0CjOafpyXPzObs8
 qY+599NWyJNZMcRKAGl9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xp2GK7WuiJc=:6WaJQmZetRSzrJKjmHiwvE
 frFROhSrNXwQIxQ1Wp9TybQkaPxYkhWFP6VcKNHWwI2coRBvLLLkuCn3aRXYQ/LCckMtnHmgS
 keYKoU0pGhaGhscpTulIR3+N3IaUx9EiTQs5lA8o1MoY49kjYEfec659ixrHmBwgXkSph+OjM
 hlv8xyGC+zfoczJvmSGi6N54bwX3FiRyxqcWQxWZoFj0zSOYJFG37oo9tCoTJFuNpHP93lCMS
 Brg41oByhdK0emyBp+l0+IQ4466myHccNO7BE1EdkcI/z8S6klBvwEYAiZXgphFvezwaA7khS
 IhDsF9fJ4O27DR7bGauy7SNOBZ3nfhgde0tUdTEkTCzkTsge9rBhFl5B9Q+MCeIdgR41EKvZq
 41/kdDVylVZnGtJRYjR63nAKTqg5K6LCMvcI5J2sL5UmXHhf1PStFIinDoFlrwhBdiFFYO3kP
 XrgKWDkMqwjozgxhN7hBPoMvKEdHNrlnqElnWWeNpdRWcITyDsa/Ep3nLT3wGmcHP3fqr8y37
 oB22Sucs08CybnO4nwtLw6SzlNk+2Y2v8AiJ8QdkJn+hsGThbAGNjVrUtgoA6uMb+qFCIc0j5
 qjQ8+Y9aTuahcrZL+HP7SLwLhxm1n+ci7QqqRco+hKyZrs58o6wq1U5UUUeX0D4d2YNBCohG1
 bt4S6jxnWCINZ7qjmy7fbJ5M+gmhY6wY5jq8cumjtLEjsOCMH8MLzLE5p8ESDG4/30hwc/LC8
 K5q6FtL/oYRCPFjlKcAtzJqEI3JQxLv+9lu5JcjjDOiYV1UNKP4rfmuTMbJ2N5QkYmwNBRrwo
 khvAWeES0bPqSHLE45K37tICBqFPYcNVBKXS/+tzlWKHFgNOqWCQkvmtsBlqnhU43+f8eA3W4
 xIZxbVGpN3vX6TPtbMFqFdqdAYsgg2vWAdXT46tjx15ZOfox6LhSUGUr1ztTRCObHuvDegZKf
 3BulqcSf0nDx7S263x/EupLL66SrFiPawQEtJQuR5Xv+7vJL+B8V/2AfDnMxHi7XhEgVapee2
 Wx2sFP2tagN707NNfx/jYcEa8Q4HGfdx7WMrY+b/lGJSAxP/CKOgnB9obBBFUH6sa6SqKHBql
 qWp3QaEe9WxWONfrLsDaLOdi2m7kA3EzxP7a2YUF/U7VymsphtWri6jLkZUm30mRP/PvOJIRp
 YDaXEicW+OfkiuvJ+4oYC8y0LQtu3vsEVCYbKRk+k8o6NgVEOaquhKXPM9Qt4pL7OAgblwCZr
 q5lUf7YgAQa9n2oaUbx8mrFVJy3q3rrCfZQQRCQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> Fixes several issues that could occur when running subtree split on larg=
e
> repos with more complex history.
>
>  1. A merge commit could bypass the known start point of the subtree, wh=
ich
>     would cause the entire history to be processed recursively, leading =
to a
>     stack overflow / segfault after reading a few hundred commits. Older
>     commits are now explicitly recorded as irrelevant so that the recurs=
ive
>     process can terminate on any mainline commit rather than only on sub=
tree
>     joins and initial commits.
>
>
>  2. It is possible for a repo to contain subtrees that lack the metadata
>     that is usually present in add/join commit messages (git-svn at leas=
t
>     can produce such a structure). The new use/ignore/map commands allow=
 the
>     user to provide that information for any problematic commits.
>
>
>  3. A mainline commit that does not contain the subtree folder could be
>     erroneously identified as a subtree commit, which would add the enti=
re
>     mainline history to the subtree. Commits will now only be used as is=
 if
>     all their parents are already identified as subtree commits. While t=
he
>     new code can still be tripped up by unusual folder structures, the
>     completely unambiguous solution turned out to involve a significant
>     performance penalty, and the new ignore / use commands provide a
>     workaround for that scenario.

I gave this as thorough a review as I can (which is not saying too much,
as I am not exactly familiar with `git subtree`'s inner workings).

Hopefully some of my comments and suggestions are helpful.

At some stage, especially given the problems I pointed out with the
implementation detail that is a flat directory with a potentially insane
number of files in it, I think it would make a lot of sense to go ahead
and turn this into a built-in Git command, implemented in C, and with a
more robust file system layout of its cache.

Ciao,
Dscho
