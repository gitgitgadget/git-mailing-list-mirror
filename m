Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DDAC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4660C2082E
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgG3KLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:11:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgG3KLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 06:11:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84E4CB64B;
        Thu, 30 Jul 2020 10:11:53 +0000 (UTC)
Date:   Thu, 30 Jul 2020 12:11:39 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730101139.GB32107@kitsune.suse.cz>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <xmqqv9i6814y.fsf@gitster.c.googlers.com>
 <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
 <20200730001442.GA2996059@coredump.intra.peff.net>
 <CAHk-=wjN0o-+OAn5wXMcshLGQ4H+CLJwq8+wRnaqzKMuhbmZqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjN0o-+OAn5wXMcshLGQ4H+CLJwq8+wRnaqzKMuhbmZqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 05:23:59PM -0700, Linus Torvalds wrote:
> On Wed, Jul 29, 2020 at 5:14 PM Jeff King <peff@peff.net> wrote:
> >
> > I'm on the fence on how magical to make the default. Having "master"
> > there gets Linus's case back where he wanted without having to configure
> > anything, which is probably reasonable. I'm not sure if people would
> > want their init.defaultBranch in addition / instead.
> 
> Junio seemed to go for "instead", but I think it might be more natural
> to just have "master" as the initial entry, and anybody adding entries
> will add it to the list.
> 
> I do think it might be a good idea to make "git init" just add the
> entry from whatever the default initial branch is.
> 
> And then the "empty entry to clear" can be used to _force_ a clean
> slate, although I don't see why anybody would ever really want that.
> If you make your default branch name be "develop", and you really want
> to see the "into develop", you'd remove the entry that "git init"
> would hypothetically add, you wouldn't necessarily want to do a "clear
> list".

Please don't. I have seen this in systemd services and it is a mess  to
deal with from user side. I suppose it is a mess on the implementation
side as well. This mystery variable content is just pain and the
complexity of the problem at hand does not really call for such
mostrosity.

FTR I don't really care about the omission of target branch in merge
messages. I typically work with repositories that are about three levels
of indirection away from the 'master' branch that would get omitted by
deafult. But in the systemd case you do need to care to expunge the
previous broken values and it is a real pain.

Thanks

Michal
