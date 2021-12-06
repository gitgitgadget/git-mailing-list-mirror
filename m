Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E6C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356723AbhLFQj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:39:57 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47182 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356646AbhLFQj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:39:56 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0ED721F953;
        Mon,  6 Dec 2021 16:36:27 +0000 (UTC)
Date:   Mon, 6 Dec 2021 16:36:26 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>, meta@public-inbox.org
Subject: Re: Large delays in mailing list delivery?
Message-ID: <20211206163626.GA4714@dcvr>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
 <20211203202427.o575sgrx4auqkmjp@meerkat.local>
 <211206.867dchr9nt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211206.867dchr9nt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Dec 03 2021, Konstantin Ryabitsev wrote:
> 
> > On Fri, Dec 03, 2021 at 09:02:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> When I've experienced delays (sometimes of half a day or more) both
> >> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
> >> updated.
> >
> > Btw, you can source lore.kernel.org straight into your gmail inbox. :)
> >
> >     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> >     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
> >
> > Or, you can read it via nntp://nntp.lore.kernel.org/.
> 
> [CC'd meta@public-inbox.org, probably best to move this thread over
> there sooner than later, but CC'ing git@ still in case this is
> interesting to others]
> 
> I poked a bit at setting this up but couldn't find from building
> public-inbox.org & trying to page through the docs how I'd get from an
> existing public-inbox.org/git/ checkout to a local Maildir.

Existing, public-inboxes can be set as "externals" and managed
via {add,forget,ls}-external sub-commands:

	# for locally-cloned inboxes:
	public-inbox-index /path/to/existing/inbox
	lei add-external /path/to/existing/inbox

	# relies on curl, memoizes data downloaded for each search:
	lei add-external https://yhbt.net/lore/git

Local externals will be included by every "lei q" invocation;
HTTP(S) ones require "lei q --remote"

If you only want to use an external as a one-off without adding
it, the -I/--include and -O/--only flags are useful:

  lei q -O https://yhbt.net/lore/git -o /tmp/results SEARCH_TERMS

> If you could share some recipe or a pointer to the right docs for that
> that would be much appreciated. Thanks!

lei-overview(7) manpage documents some things, at least:
https://public-inbox.org/lei-overview.html  Patches welcome :>

IMHO lei still kinda sucks, and I probably won't have time to
work on it for a bit :<
