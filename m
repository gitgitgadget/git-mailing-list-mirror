Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CBE20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbdASTTt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:19:49 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:41235 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754343AbdASTTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:19:48 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4524F10C14C5;
        Thu, 19 Jan 2017 10:54:48 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 001D528E;
        Thu, 19 Jan 2017 10:54:47 -0800 (PST)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id DC59728A;
        Thu, 19 Jan 2017 10:54:47 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 10:54:47 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 19:54:42 +0100
Received: from [10.107.19.116] (10.107.19.116) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 19 Jan 2017 19:54:42 +0100
Subject: Re: Git: new feature suggestion
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khomoutov <kostix+git@007spb.ru>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
 <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
CC:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <991ef396-3fc3-27d6-283c-b8dffa10a7b7@synopsys.com>
Date:   Thu, 19 Jan 2017 18:54:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.116]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Linus,

Às 6:39 PM de 1/19/2017, Linus Torvalds escreveu:
> On Wed, Jan 18, 2017 at 10:33 PM, Konstantin Khomoutov
> <kostix+git@007spb.ru> wrote:
>>
>> Still, I welcome you to read the sort-of "reference" post by Linus
>> Torvalds [1] in which he explains the reasoning behind this approach
>> implemented in Git.
> 
> It's worth noting that that discussion was from some _very_ early days
> in git (one week into the whole thing), when none of those
> visualization tools were actually implemented.
> 
> Even now, ten years after the fact, plain git doesn't actually do what
> I outlined. Yes, "git blame -Cw" works fairly well, and is in general
> better than the traditional per-file "annotate". And yes, "git log
> --follow" does another (small) part of the outlined thing, but is
> really not very powerful.
> 
> Some tools on top of git do more, but I think in general this is an
> area that could easily be improved upon. For example, the whole
> iterative and interactive drilling down in history of a particular
> file is very inconvenient to do with "git blame" (you find a commit
> that change the area in some way that you don't find interesting, so
> then you have to restart git blame with the parent of that
> unintersting commit).
> 
> You can do it in tig, but I suspect a more graphical tool might be better.
> 
> .. and we still end up having a lot of things where we simply just
> work with pathnames. For example, when doing merges, it' absolutely
> _wonderful_ doing
> 
>    gitk --merge <filename>
> 
> to see what happened to that filename that has a conflict during the
> merge. But it's all based on the whole-file changes, and sometimes
> you'd like to see just the commits that generate one particular
> conflict (in the kernel, things like the MAINTAINERS file can have
> quite a lot of changes, but they are all pretty idnependent, and what
> you want to see is just "changes to this area").
> 
> We do have the "-L" flag to git log, but it doesn't actually work for
> this particular case because of limitations.
> 
> So what I'm trying to say is that the argument from 10+ years ago that
> "you can do better with intelligent tools after-the-fact" is very much
> true, but it's also true that we don't actually have all those
> intelligent tools, and this is an area that could still be improved
> upon. Some of them are actually available as add-ons in various
> graphical IDE's that use git.
> 
>                  Linus
> 

I am currently facing some challenges in one of Linux subsystems where a rename
of a set of folders and files would be the perfect scenario for future
development, but the suggestion is not accepted, not because it's not correct,
but because it makes the maintainer life harder in backporting bug fixes and new
features to older kernel versions and because it is not easy to follow the
renamed file/folder history from the kernel.org history logs.

Like nature shows us, the ability to adapt is the key for survival, so Linux
would gain a lot with some new features in git that can make maintainers life
easier. Assisted-backporting would be an excellent feature for them.

Did you ever thought about optimization backport operations through git or by an
add-on to it?

I am available to help if this feature makes sense for git users.

Thanks,
Joao
