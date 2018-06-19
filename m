Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB071F403
	for <e@80x24.org>; Tue, 19 Jun 2018 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937581AbeFSKwz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 06:52:55 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:47833 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936108AbeFSKwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 06:52:54 -0400
X-Greylist: delayed 2018 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 06:52:54 EDT
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1fVDjH-0001Yf-LH; Tue, 19 Jun 2018 11:19:15 +0100
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23336.55459.558413.723251@chiark.greenend.org.uk>
Date:   Tue, 19 Jun 2018 11:19:15 +0100
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: want <reason> option to git-rebase
In-Reply-To: <20180619010655.GA173168@aiede.svl.corp.google.com>
References: <23335.52730.475955.861241@chiark.greenend.org.uk>
        <20180619010655.GA173168@aiede.svl.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder writes ("Re: want <reason> option to git-rebase"):
> Ian Jackson wrote[1]:
> > git-rebase leaves entries like this in the reflog:
> >
> >   c15f4d5391 HEAD@{33}: rebase: checkout c15f4d5391ff07a718431aca68a73e672fe8870e
...
>  GIT_REFLOG_ACTION
> 	When a ref is updated, reflog entries are created to keep
> 	track of the reason why the ref was updated (which is
> 	typically the name of the high-level command that updated the
> 	ref), in addition to the old and new values of the ref. A
> 	scripted Porcelain command can use set_reflog_action helper
> 	function in git-sh-setup to set its name to this variable when
> 	it is invoked as the top level command by the end user, to be
> 	recorded in the body of the reflog.
> 
> "git rebase" sets this itself, so it doesn't solve your problem.

Hrm.

> Can you say more about what your tool does?  I'm wondering if it would
> make sense for it to use lower-level commands where GIT_REFLOG_ACTION
> applies, instead of the more user-facing git rebase.

Sure.

http://www.chiark.greenend.org.uk/ucgi/~ianmdlvl/git-manpage/dgit.git/git-debrebase.1

See the description of git-rebase new-upstream.  It does a lot of
complicated work, synthesising a new pair of commits using plumbing
etc., and then does
  git rebase --onto <thing it made> <user's previous base>

If the user says git rebase --abort, everything should be undone.

Another alternative solution would be to be able to make git reflog
entries without actually updating any ref.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
