Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7591F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 07:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfH0HDZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 03:03:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37124 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0HDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 03:03:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1177F1F461;
        Tue, 27 Aug 2019 07:03:25 +0000 (UTC)
Date:   Tue, 27 Aug 2019 07:03:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it
 elsewhere
Message-ID: <20190827070324.7l2cpc3dlnithbm6@whir>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> wrote:
> Some highlevel notes on the patches:
> 
>   * Patches 1&2: are good cleanups & performance wins regardless of
>     whether the rest of the series is taken

Agreed.  Though weren't we moving away from pipes in tests
because failures could go unnoticed?  (I haven't been paying too
much attention, though)

>   * Patch 5: actually deletes git-filter-branch, its tests, and
>     documentation.

Given how long we've had git-filter-branch, I suggest we keep it
around but add a warning at runtime notifying users of it's
impending removal.  Such warning should remain for >=10 years or
whatever an distro support cycle is, nowadays.

And there should probably be a way to disable the warning via
git-config if it's too annoying.

AFAIK, filter-branch is not causing support headaches for any
git developers today.  With so many commands in git, it's
unlikely newbies will ever get around to discover it :)
So I think think we should be in any rush to remove it.

But I agree that filter-branch isn't useful and certainly
shouldn't be encouraged/promoted.

Yet there's probably still users which ARE happy with it, that
will never hit the edge cases and problems it poses; and will
never read release notes.  And said users are probably getting
git from a slow-moving distro, so it'd be a disservice to them
if they lost a tool they depend on without any warning.
