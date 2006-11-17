X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Troy Telford" <ttelford.groups@gmail.com>
Subject: Re: git-svn bug?
Date: Fri, 17 Nov 2006 14:17:41 -0700
Message-ID: <op.ti6irtilzidtg1@rygel.lnxi.com>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <7vejs4jshp.fsf@assigned-by-dhcp.cox.net> <op.ti2xykijzidtg1@rygel.lnxi.com> <20061117085509.GA29644@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 21:18:12 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=Z4cPZnzlIMoHbtYYsi03hYpfFhInaQ5yOyB7z5j2TSLas5PL1+1/w11W7WhSO5vP2Wb3CW8rabgn6D2d/R2q4uiaWVHX4y9f9M2iuL9m1nnJTxxpqYl2f3mGu9OFq1aADA8ohUA3Obc3Kw8sZEOvr7Fa8Ff2qzyy3iXEUbBK0jE=
In-Reply-To: <20061117085509.GA29644@localdomain>
User-Agent: Opera Mail/9.10 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31731>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlB63-00089G-E5 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 22:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424903AbWKQVSA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 16:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424905AbWKQVSA
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 16:18:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60502 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1424903AbWKQVR7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 16:17:59 -0500
Received: by ug-out-1314.google.com with SMTP id m3so817686ugc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 13:17:58 -0800 (PST)
Received: by 10.78.17.1 with SMTP id 1mr2337967huq.1163798277693; Fri, 17 Nov
 2006 13:17:57 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2]) by mx.google.com with ESMTP
 id 15sm3744966hui.2006.11.17.13.17.55; Fri, 17 Nov 2006 13:17:57 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 01:55:10 -0700, Eric Wong <normalperson@yhbt.net>  
wrote:

> dcommit expects to be run on a git-svn fetch-ed HEAD that is linear
> superset of remotes/git-svn.  That is: remotes/git-svn..HEAD should
> (ideally) contain no merges, and no root commits.  git-svn currently
> does no checking for root commits, but it should.
>
> This commit is missing the git-svn-id: line at the bottom.  If you
> simply left it out (private svn repository info), can you check that the
> URL in this line is actually for the SVN repository you want to commit
> to?

I didn't remove anything, but I did double-check and the URL is correct.   
But the following may shed light on why there is no git-svn-id anywhere:   
IIRC, this is how my current repository came to be (from the very  
beginning):
1.)  Way back when, before I even started on the project, it started life  
as a CVS repository
2.)  Was converted from CVS -> SVN in early '05 (pre-git)
3.)  I converted from SVN->git in Nov/Dec '05 (using git-svnimport.  I'm  
not sure git-svn was available at the time.)
4.)  The svn repository is still around, and I need to interoperate with  
the svn repository on occasion.  I read about the new (at the time)  
'git-svn', and decided to give it a try.
5.)  I start with my pre-existing git repository, running:

   git svn init <url>
   git svn fetch
   git checkout -b master svn
   git rebase remotes/git-svn

> It seems like your usage of dcommit would actually cause the issue
> you're experiencing to be triggered on the dummy repository, and not the
> real one.  My other guess would be that you somehow merged commits from
> your dummy svn repo into your master branch.

I need to work on being more clear; sorry about that.  Here's what I did  
with my 'dummy' repository
1. create a new (empty) svn repository
2. imported it into a new git repository using git-svn
3. added a few files that were just sitting in $HOME, then modified them,  
removed some, added others, etc.  (using both git-svn and subversion)
4. verified everything was working as I expected it to.  (and if not,  
figure out why I was wrong).

My 'dummy' repo was imported using git-svn.
My 'real' repo was imported using git-svnimport.

Having not read any of the code, I'm just taking a wild guess; but is it  
reasonable to say that since the repository was originally imported to git  
using git-svnimport (rather than git-svn), git-svn doesn't have some of  
the data it needs to push to the remote svn repo?

Would it be reasonable to use git-svn to import the SVN repository into a  
new git repo, and then rebase from the old git-svnimport'ed repo into the  
new git-svn imported one?  (did that even make sense?!?)
-- 
