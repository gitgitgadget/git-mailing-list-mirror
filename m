Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C0B1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756940AbeDZRvQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:51:16 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:48358 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756891AbeDZRvP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:51:15 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 7BFAC335C78
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:51:15 +0000 (UTC)
Received: (qmail 24622 invoked by uid 10000); 26 Apr 2018 17:51:13 -0000
Date:   Thu, 26 Apr 2018 17:51:13 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        " Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180426T174943-370851719Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <871sf3el01.fsf@evledraar.gmail.com>
 <20180426171540.GA2037@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426171540.GA2037@duynguyen.home>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 07:15:40PM +0200, Duy Nguyen wrote:
> On Wed, Apr 25, 2018 at 10:41:18AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >  2. Add some config so we can have hook search paths, and ship with a
> >     default search path for hooks shipped with git.
> 
> I would go for something like this instead of search paths. This
> allows you to specify a path to any specific hook in hooks.* config
> group. This is basically "$GIT_DIR/hooks directory in config file" but
> with lower priority than those in $GIT_DIR/hooks.
> 
> Now we can do something like
> 
> 
>     git -c hooks.post-checkout=/path/to/some/script clone ...
> 
> but of course I would need to fix the FIXME or this hook config is
> only effective just this one time. (And of course you could put it in
> ~/.gitconfig)
The FIXME leaves something ambiguous:
How do you differentiate between -c behavior that should be
one-time-only vs persisted by being written to $GIT_DIR/config during
$GIR_DIR init?

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
