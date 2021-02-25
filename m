Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F809C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D083C64F2C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhBYU12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:27:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:45762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234222AbhBYU1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:27:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17AD9AAAE;
        Thu, 25 Feb 2021 20:26:29 +0000 (UTC)
Date:   Thu, 25 Feb 2021 21:26:27 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Getting an actuallt useful merge base?
Message-ID: <20210225202627.GA6564@kitsune.suse.cz>
References: <20210224175834.GT6564@kitsune.suse.cz>
 <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
 <20210225182924.GY6564@kitsune.suse.cz>
 <CABPp-BGdFX6V+GNQ6JVnoY3S9cvA0mL+cKSnAhUhArQbGaD6vw@mail.gmail.com>
 <xmqqv9afud75.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv9afud75.fsf@gitster.g>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 12:03:58PM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> >> It's like this
> >>
> >> T
> >> ----o----o----o----o----o----o----o----o----o----o----o----o---(t)---o----o----
> >>      \             \     \                                      \\\
> >>       \             \     \                                      \\\
> >>        \             \     \                                      \\\
> >>         \        o----o----o\̶---o---(s)---o----o----o----o----o----o\̶\̶-(a)
> >>          \      /            \      /                                \\
> >> S+T  o----o----o----o----o----o---(u)---o----o----o----o----o----o----o\̶--(b)
> >>     /                                       /                           \
> >> ---o----o----o----o----o----o----o----o----o----o----o----o----o----o----o---(m)
> >>
> >> So (t) is common ancestor for (a) and (b) that merge-base reports but it is
> >> only ancestor for files in set T, and does not have files from set S at all.
> >> The common ancestor I am insterested in is (s) which is merge base for both
> >> sets of files.
> >
> > From git-merge-base(1):
> >
> > "When the history involves criss-cross merges, there can be more than
> > one best common ancestor for two commits...When the --all option is
> > not given, it is unspecified which best one is output."
> >
> > Perhaps you want to specify --all to git merge-base, and then perform
> > additional checks on the output to select one yourself?

The description does not inspire much confidence but it indeed gives
something reasonable (ie what looks like would be (t) (u) in this
situation).

Nonetheless, (t) is clearly inferior and is reported by default when
--all is not given.

> 
> Ignore me, as it is likely I am just confused, but if we are merging
> (a) and (b), I do not think (s) could be usable as a merge base; it
> may be an ancestor of (a) but is not an ancestor of (b), no?

Indeed, it should be the parent of (s) on the (b) branch - (u).

Thanks

Michal
