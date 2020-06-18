Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC3C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C80C20732
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PZQiXP5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgFRKSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:18:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:50773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgFRKR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592475458;
        bh=zugREFCU8wO3yfAT91i2t+iQzIccD1Z7MWfcQiU9kAM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PZQiXP5PgJ5kh4AI34sFeaUojwYXgWw7tgggNyXjjBoH75HQHwTUXPzSbymHq7XfL
         KXkTfwdggTATAgWCAGHE4ib2pLFR66zgc5IJmLs548ed2h/xNMfuUD05NR4sWD1wMO
         RoAy5CvCWrWsOyG4SFCrddIx5TfAgJDUh4gGgy9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.215.12]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1jMayE21xc-00RWeG; Thu, 18
 Jun 2020 12:17:38 +0200
Date:   Thu, 18 Jun 2020 12:17:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <20200616122559.GA666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006181216440.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com> <xmqqwo4di49l.fsf@gitster.c.googlers.com>
 <731205c8-7d4b-d87a-17d1-520fdec7375d@gmail.com> <nycvar.QRO.7.76.6.2006141055510.56@tvgsbejvaqbjf.bet> <20200616122559.GA666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x291fSN/MCrO5RzgIg4dj3sUqHY4IMCebYISGawxxOXPFrFg0t6
 EWWWfMbBxuW82ODKHwO+f+eTJnryr3aZt+mCUZIF675aveg8ADc4O5Qk+IvIQYVlUUwDFvf
 wUuSweH0dCbEdafFTQ/WrA4KygsPXeeeETy56OHvN4RU5F2O2qqjjMacnDT2IzPstCSN4uO
 YszD/rf2PLkIYWUHMCU+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q5LuomXCuo4=:ro1a0VITFn88QZtusd0gWb
 7JwuKgGIQEIc70y2WmGl2EgswnO8bbObIWIcOUmv8p+oNQbynYy7dFoR4FgxVpz8lroTxRwoi
 8R/l41hqHCAwQmVlLsF6xUBx61V5fAVuS88DkMQh/Cs53gC1nogwO7yD5Jtqy+ldcxO97F5W1
 ozIz+AXLoNgjXf5qvldaVn58OURsVBOl9Qn+vgj7fA0fLFoNCYM95SPSikk6Avdl14eps882A
 4PB2q2CQG1uyjXTk7MmimrQ1da2kOC3JVVxHWO0/Dndif7oi87T53ORI5WkIxcQUoQ3Y5S5i0
 +Eyj7hc1cWMeqFIWEIfZfXf03v/k0lzDT57+ySZTgF7RrXcSnKoxRMt68fHauLZ3Rxu/Gy7Pq
 XE6geLbUroE3UH19+PQxK1qNPxgchWrGXeu72f98+ofxEAY2Ia8/kgY8Lo4yJgcgk3h3NNToS
 Z9j9sZKnO23GyNg3CqoVi/NbOXYpDEWyNQsHs802z6bx8BbgncMkcb8VSo+Umkmgwi61NgB0L
 R+VtOoM+UfgEHDWJQPYB/CGEhio+GYvxu+8Fqpd60QSHIbk/v4OW4fwk9za/HLrMujb9AGqn/
 CXIGZPQ2LMf/sqQdCQ0ccb/Z5Ugj6qB+uCKk8gKfZDxuKLGq+JgaCpwy6V8L0nD+GlqvnsA/3
 snpFfnsPgI0apNfxeqN5V9DlLf7ok03UUPAue6wLXhAGjzK6PBlPxfeV3dKLP9E36F5E2OF7g
 rQhV04tkmBgILaH8U3nxBkgT3Ue7uvBn16E63mocUsu20y0DsTtTazIewBKDx3PJvAK//1h7W
 nAK1uWu+bMZ5poZedAa6MJqqpqROFOIz5r8XxqjekronYqA9aFebDkAaicztVjzexDoUVGWGD
 tG1LUF8OkCNpueTFGM/8VRFRR3bGeqJRhVusaPOZ5epwBzcgzdLhryVmoEX+49FNglirToFiL
 sYWUyYqYc+FuRFVgXNL9Aa2t0zsbUmrNS0RSnLC79NQwExaObmtHQBotfK3sabJJp2EMq5U0q
 B8MkpMPGfxgBZe+tCy9x1egAPQjemcUVOSqc6N42w2ioH9ebGdJopbf0jksMFGcF9BdgzlPvu
 uub/Haia+ex/ByHyWQC5jGsJwknv+IZcDgESaegC+L4tkM+ZrZINs1FHjVem1dZRFpCReSe0z
 elCMBwCutANUOxg8oZKaMAO9+odOZxVeMaZ9mRH5vT6F3A7DkE7g+cUglQdBkWmoR98T1S0Ui
 4OOMqe44NnsO3Vm2g
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Sun, Jun 14, 2020 at 10:57:41AM +0200, Johannes Schindelin wrote:
>
> > > >> Why adding yet another environment variable instead of relying on=
ly on a
> > > >> config option?  I understand it's for the tests, but can't we add=
 a
> > > >> shell function in test-lib.sh (and friends) that tries to read
> > > >> `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> > > >> `core.defaultBranchName'?
> > > >
> > > > Can you produce such a patch that does it cleanly?  My knee jerk
> > > > reaction is that I would suspect that you end up having to touch
> > > > many places in the t/ scripts, but if you prove otherwise, that
> > > > would certainly be appreciated.
> > > >
> > > > And no,
> > > >
> > > >     git () { command git -c core.defaultBranchName=3Dmaster "$@" }
> > > >
> > > > is not an acceptable solution.
> > > >
> > >
> > > I wanted to to do something like this:
> > >
> > >   if test -n "$GIT_TEST_DEFAULT_BRANCH_NAME";
> > >   then
> > >       git config core.defaultBranchName "$GIT_TEST_DEFAULT_BRANCH_NA=
ME"
> > >   fi
> > >
> > > But since we do not have a repository to store the config, it won't
> > > work.  Sorry for the noise.
> >
> > We actually would have `~/.gitconfig` because `HOME` is set to `t/tras=
h
> > directory.<test-name>/`.
> >
> > However, that would cause all kinds of issues when test scripts expect=
 the
> > directory to be pristine, containing only `.git/` but not `.gitconfig`=
.
>
> Putting:
>
>   GIT_CONFIG_PARAMETERS=3D"'core.defaultBranchName=3D...'"
>
> into the environment would work (and yes, you need the single quotes
> embedded in the variable), and solves all of the complaints above.
> Further "git -c" invocations properly append to it. But:
>
>   - there are a few tests which explicitly tweak that variable
>
>   - it technically changes any tests of "-c" because now we'd never
>     cover the case where we start without the variable defined

Indeed.

> I think baking in a special environment variable like you have is not so
> bad. If this did become too common a pattern, though (special test-only
> environment variables that do have a separate config option), I wouldn't
> be opposed to a GIT_TEST_CONFIG_PARAMETERS which takes precedence over
> other config, and comes with a big warning label that it shouldn't be
> relied upon outside the test suite. That's equally ugly to
> GIT_TEST_DEFAULT_BRANCH_NAME, but at least solves the problem once for
> all of them. I'm just not sure we have enough "all of them" to make it
> worth doing.

FWIW I do not plan on using that variable for a long time. And it is not
in this here patch series any longer, so let's discuss it in the future
patch contribution of mine.

Thanks,
Dscho
