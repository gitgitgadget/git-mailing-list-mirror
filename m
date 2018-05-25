Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CFD1F51C
	for <e@80x24.org>; Fri, 25 May 2018 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965781AbeEYK64 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 06:58:56 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:45854 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965554AbeEYK6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 06:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pqizUKieUQqqv+RjK+fzBH7E5f0s3w4gtkPYF3TChrU=; b=wNXoo8NIM1WbjqnzF+PAtcxVN
        Hh5ymHRtBs+/8EQOY69tP6vZjT+MVJdqJ9DgkzhX+IZjQuUpGkVxKQMrEZHHb+fo6D18i25RQ1ceN
        3Z3MaZuJrIxHcg2jAWLK78mNRG5CWmz3DNsMEbgYu3I/Xj+jzTLoHlnVKKmhJnCjwpjt1dgRUOtbC
        LMjJuQZfQ9UwefyT3IK4Nf0Ujoz6gTcXgCaG++omQyZIXU8DtZGIq1bBZlhwKgvOIigAlVwdb81k7
        3MIdBZtomyKO7+9WzINqL2PDackHTbHs+9eOZS2Hd+Ef+sqQkb0NlKdN5Z3tJx2vXYNjTwbQpEo2c
        4hRjSrSuA==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:12673 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fMAQu-001MdB-8N; Fri, 25 May 2018 06:58:53 -0400
Date:   Fri, 25 May 2018 06:56:57 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git grep" and "working tree" vs "working directory"
In-Reply-To: <xmqqa7sor1t3.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1805250649180.11158@localhost.localdomain>
References: <alpine.LFD.2.21.1805231434010.28811@localhost.localdomain> <CAGZ79kavmH5KVS2Byc5+Hg3dOvVwGD11KZ3yzZTLwp8Ok9ZDTg@mail.gmail.com> <xmqqa7sor1t3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 May 2018, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
>
> > There are 2 dimensions to it:
> > * (where you are)
> >   if you run git-grep from a sub directory of the repository, then the
> > "sub-working-tree"
> >   will be searched.
>
> s/the repository/the top level directory of the working tree/, perhaps?
>
> >>   also, at the bottom of that section, one reads:
> >>
> >>   <pathspec>...
> >>       If given, limit the search to paths matching at least one
> >>       pattern. Both leading paths match and glob(7) patterns are supported.
> >>
> >>       For more details about the <pathspec> syntax, see the pathspec
> >>       entry in gitglossary(7).
> >>
> >> but, again, what if <pathspec> is *not* given? then what?
> >
> > Assume "$pwd/."
>
> This is not technically wrong per-se, but I do not think there is
> any reason to encourage it over just a simple "." dot.
>
> >>   finally, the first example has the same problem:
> >>
> >>   git grep 'time_t' -- '*.[ch]'
> >>       Looks for time_t in all tracked .c and .h files in the
> >>       working directory and its subdirectories.
> >>
> >> in "the working directory"?
> >>
> >>   what is the proper terminology to be used here?
> >
> > the working directory sounds right, not sure which aspect you want to be
> > exposed more clearly.
>
> "The part of the working tree below and including your current
> working directory", if you really want to be pedantic ;-).
>
> But almost all the examples that show how to work _with_ Git
> inspecting and manipulating tracked contents assume that your
> current working directory _is_ inside a working tree of the
> repository you are working on, so the above is equivalent to "The
> current working directory" should be clear enough for most readers,
> I would think.

  against my better judgment, i'm going to try to summarize this.
first, it appears everyone agrees that the proper way to refer to the
*entirety* of the checked out content is "working tree", and that is
the phrase to use, regardless of your current location in said working
tree.  so, given that, one might say that the command "git status"
would normally display all untracked files in the working tree
(because it does so regardless of your current working directory.)

  related to that, it would seem that the phrase "working tree" is,
far and away, the preferred way to refer to the checked out content.

  on the other end, the meaning of "current working directory" should
be self-evident.

  it's the middle ground, "working directory", that is the problem,
since lots of documentation and comments use that phrase
interchangeably with "working tree", and i doubt that confusion is
ever going away. all one needs to do is:

  $ grep -r "working directory" *

in the git code base to see its prevalence. so, what *should* it mean?
or is there any point in even trying to clarify it?

rday

p.s. i absolutely will not entertain the introduction of the weirdness
that is "sub-working-tree." it's just a subdirectory, that's all.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
