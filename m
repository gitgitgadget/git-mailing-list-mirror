X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: when is a remote a branch?
Date: Sun, 12 Nov 2006 17:11:41 +0100
Organization: At home
Message-ID: <ej7h1n$ed8$1@sea.gmane.org>
References: <ej7fra$8ca$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 12 Nov 2006 16:11:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 77
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31264>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjHvA-0007wo-4r for gcvg-git@gmane.org; Sun, 12 Nov
 2006 17:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932943AbWKLQK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbWKLQK4
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 11:10:56 -0500
Received: from main.gmane.org ([80.91.229.2]:20408 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932943AbWKLQKz (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 11:10:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjHuu-0007uA-Bn for git@vger.kernel.org; Sun, 12 Nov 2006 17:10:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 17:10:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 12 Nov 2006
 17:10:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Anand Kumria wrote:

> I generally tend to use cogito -- it does all the heavy lifting, like
> recovering from interrupted fetchs (usually) for me.  One thing I haven't
> really gotten my head around is the difference between a branch and a
> remote.
> 
> git-branch knows of 'remotes' (via the -r parameter) and these to be
> unrelated to what cogito thinks remotes are (it seems to look for things
> in .git/refs/head/<name> and then a corresponding .git/branches/<name>/
> which it then declares a remote).

Not about 'remotes', but about 'remote [read-only] branches', i.e. refs not
from .refs/heads/, but from .refs/remotes/<remotename>/

> Yet, git-init-db creates both .git/remotes and .git/branches
> 
> What is the difference between the two. From my (na?ve) perspective the
> two tools (git and cogito) regarded them very differently.
> 
> Any explanation, or pointer to some documentation, would be helpful.

Read Documentation/repository-layout.txt (ot it's HTML version, either
locally ot at www.kernel.org).

 branches::
         A slightly deprecated way to store shorthands to be used
         to specify URL to `git fetch`, `git pull` and `git push`
         commands is to store a file in `branches/'name'` and
         give 'name' to these commands in place of 'repository'
         argument.

You can store only one branch to fetch per shorthand. I'm not sure about
where it is stored which branch to download, and how to name this branch 
locally.

 remotes::
         Stores shorthands to be used to give URL and default
         refnames to interact with remote repository to `git
         fetch`, `git pull` and `git push` commands.

From Documentation/urls.txt

 In addition to the above, as a short-hand, the name of a
 file in `$GIT_DIR/remotes` directory can be given; the
 named file should be in the following format:

         URL: one of the above URL format
         Push: <refspec>
         Pull: <refspec>

Currently there is yet another way, by using config file:
(also from Documentation/urls.txt):

 Or, equivalently, in the `$GIT_DIR/config` (note the use
 of `fetch` instead of `Pull:`):

 [remote "<remote>"]
         url = <url>
         push = <refspec>
         fetch = <refspec>

where <refspec> is defined in Documentation/fetch-pull-param.txt

 <refspec>::
         The canonical format of a <refspec> parameter is
         `+?<src>:<dst>`; that is, an optional plus `+`, followed
         by the source ref, followed by a colon `:`, followed by
         the destination ref.

(or, simply, in git-pull(1), which includes those files, with exception of
repository layout document).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

