X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: when is a remote a branch?
Date: Sun, 12 Nov 2006 17:36:24 +0100
Message-ID: <20061112163624.GE7201@pasky.or.cz>
References: <ej7fra$8ca$2@sea.gmane.org> <ej7h1n$ed8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 16:36:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ej7h1n$ed8$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31265>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjIJv-0004Sn-Bl for gcvg-git@gmane.org; Sun, 12 Nov
 2006 17:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932952AbWKLQg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 11:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932955AbWKLQg1
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 11:36:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57508 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932952AbWKLQg0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 11:36:26 -0500
Received: (qmail 23866 invoked by uid 2001); 12 Nov 2006 17:36:25 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Nov 12, 2006 at 05:11:41PM CET, Jakub Narebski wrote:
> Read Documentation/repository-layout.txt (ot it's HTML version, either
> locally ot at www.kernel.org).
> 
>  branches::
>          A slightly deprecated way to store shorthands to be used
>          to specify URL to `git fetch`, `git pull` and `git push`
>          commands is to store a file in `branches/'name'` and
>          give 'name' to these commands in place of 'repository'
>          argument.
> 
> You can store only one branch to fetch per shorthand. I'm not sure about
> where it is stored which branch to download, and how to name this branch 
> locally.

I think the above is quite confusing description. This really is not
about any "shorthands" at all, but just about branches (how the name
implies, after all).

Git and Cogito share the same models of branches. These branches are
'heads' with commit pointers stored in refs/heads/, etc. The branches/
directory says that some branches do not correspond to local development
(and should never be used for that) but instead they correspond to a
particular branch in some remote repository. Such branches are called
"REMOTE BRANCHES".

So it's "if branch X has corresponding .git/branch/X file, it's not a
local branch but instead a REMOTE BRANCH corresponding to the URL stored
in that file". That simple. The URL is address of the repository plus
optionally a '#branchname' if the branch name in the remote repository
should not default to remote HEAD or master.

In addition, Git (not Cogito at this point) supports a completely
different and unrelated abstraction called REMOTES. They don't have
anything to do with branches. Instead, a REMOTE represents a repository
URL and a set of local/remote branch pairs to handle on pulls and
pushes; it has no other obvious mapping to branches and branches can be
even shared between various REMOTES etc. (this is changing lately with
the refs/remotes/ hierarchy, but I think that's still not in wide use).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
