X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 17:34:38 -0800
Message-ID: <f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <455BBCE9.4050503@xs4all.nl>
	 <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	 <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
	 <455CFCBD.8040901@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 01:36:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DpUGWP33zPQXmLqxq9KxYtP7qv4vPyKlpQ0XKx5ev7PtF3LEAk0S79cToqZiLSf6IgJfsQxYWvy7+Wh0kd9CD2fdS8lvAVR4e+KXSUKjq1qwNRzu+lWe6iUZG3//WET5AZxZezaoqhS5xnpeDkWna/EQ+vDhzL1yVeUD6aZsxUg=
In-Reply-To: <455CFCBD.8040901@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31657>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksdB-0001Jk-5Y for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424888AbWKQBek (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424891AbWKQBek
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:34:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:51852 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1424888AbWKQBej
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:34:39 -0500
Received: by wx-out-0506.google.com with SMTP id s7so784521wxc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 17:34:38 -0800 (PST)
Received: by 10.90.90.16 with SMTP id n16mr1137728agb.1163727278342; Thu, 16
 Nov 2006 17:34:38 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Thu, 16 Nov 2006 17:34:38 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I think there's a fundamental assumption built into the design of git
that most programmers accustomed to a corporate environment don't
understand.  Namely, that each programmer owns his or her entire
"repository", and can do whatever he or she darn well pleases with it
at any time.  Go ahead and create hundreds of transient branches as
part of a scripted "merge complexity metric" calculation.  Try three
different refactoring strategies on different branches, abandon two of
them, and prune them months later.  And generally use the power of the
SCM to juggle a lot of things at once, because there's no sysadmin
gatekeeper stopping you, and the thing is designed and coded scalably
so it doesn't grind to a halt as soon as everyone has dozens of
private branches.

Even if you do find a way to push git in a direction that it doesn't
scale, it's no one's problem but your own -- people who pull from you
are pulling the _content_ on the branches they care about, not the
structure of your repository.

On 11/16/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> I agree that discussions on naming may cloud the issue, but "learning
> the workflow" implies that people should adapt to the limitations of
> their tools.  That's only a viable stance when the tools are finished
> and completely perfect.
>
> Until that time, it would be good goal to remove all idiosyncrasies,
> all gratuitious asymetries and needless limitations in the commands of
> git, eg.

One person's gratuitous asymmetry is another's minimalism.  (If the
symmetric thing doesn't make any sense or can't be implemented
scalably, leave it out.)  It is more important that git continue to
work than that it appear symmetric without reference to its function.

>  - clone but not a put-clone,

What possible use would that be?  git is not rsync.

>  - pull = merge + fetch, but no command for merge + throw

pull = fetch + merge.  It is (almost?) always followed by a judgment
call based on the merge results.  merge + throw doesn't make any sense
in terms of the job at hand, which is facilitating human judgments
about whether to accept someone else's work into one's working tree.

>  - clone for getting all branches of a repo, but no command for
>    updating all branches of a repo.

clone is shorthand for the steps involved in setting up a new
repository with content similar to an existing one.  There isn't any
merge involved, and no scope for human judgment, so it's simplest to
clone the whole state of the remote repository (including tags and
branches) and let the user blow away any branches he doesn't need.
But once the clone is done, all of those branches are _truly_ _local_
-- they don't retain any reference to the remote branches, and you can
commit to all of them.  The only entry placed in .git/remotes is the
"origin" of the new clone, which is the "master" of the remote
repository.  That's for the user's convenience, and is about the only
thing in the new clone that _isn't_ a copy of something in the remote
tree.

So the "update all" process wouldn't look anything like a clone, it
would be a fetch and replay of each remote branch onto the
corresponding local branch.  You and Carl seem to want "git clone" not
only to copy the heads of the remote branches but to populate
.git/remotes with trackers for all of those branches, and then to
start each "git update" by polling all of the remote repositories to
see if branches have been created or deleted, then pull every branch
in sight.  What do you do when "upstream" creates a branch with the
same name as a local branch you have created?  How do you deal with
branch points that don't exist in your repository because you touched
one of the "tracker" branches between pulls?

In short, if you want a local, read-only tracker for a whole remote
repository instead of a branch that's actually published to you (and
maintained accordingly), you might consider s/git/rsync/.

Cheers,
