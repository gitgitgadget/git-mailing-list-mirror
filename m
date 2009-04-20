From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 15:32:16 +0400
Message-ID: <20090420113216.GC25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 13:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrlV-00028C-27
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbZDTLcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 07:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZDTLcs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 07:32:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:17116 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbZDTLcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 07:32:47 -0400
Received: by rv-out-0506.google.com with SMTP id b25so1308104rvf.5
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o0ZnXQQ3emuXCk+5EJhbSflWr5v7FWz8qtkrasSOLuk=;
        b=gxcUFCJ41QUzwCAbkDjJ+ubCzDlQr+HMIZRA/QbPaLKQqJy+mz9S2xygjWWLmYxgba
         44BBvkEgZ8AooBIMX5yCm3i1KJwxEG34ir//yb1d/3gZCuLIYuhfmBrIn6iT/24pr3WU
         8X57xGMKiXo3wRF6eDinyFbjMFtvOjHFA9gdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NYzkicEgrfhv+Mef8ftfTY59wVaw1CKkSZqlLy1jnfgwXJ8W/rz9gUaLpcVsQf/XXP
         q+cHQAB3lBOpT+owL5P+sfNZlp0FbgmPJUw2h5w8lwemgm5Smn46xGitLYXOQ8kl+BJU
         rz9cklfQ8/pF/U2gll/uL3mh8BlAmzqeCCKiU=
Received: by 10.141.52.3 with SMTP id e3mr2486939rvk.73.1240227166420;
        Mon, 20 Apr 2009 04:32:46 -0700 (PDT)
Received: from localhost ([91.78.50.115])
        by mx.google.com with ESMTPS id g22sm13722069rvb.35.2009.04.20.04.32.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 04:32:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116974>

On Sun, Apr 19, 2009 at 05:17:52PM +0200, Johannes Schindelin wrote:
> 
> But it is important to keep in mind that our concept of branches is not 
> intuitive:
> 
> http://longair.net/blog/2009/04/16/git-fetch-and-merge/

I don't see how our concept of branches is any different from what other
version control systems have; but I see why it is so confusing for many
people. We define a branch as a line of development (I'm still think it
is a pretty good and widely accepted definition of branch), yet when a
newcomer runs gitk, what he or she sees is not a line but a graph.

Thus anyone looking at a gitk image may ask you: "Where is this line
that represents the master branch?" Indeed, it is nearly impossible to
see it, but it does not mean this line does not exist. If you run:
gitk --first-parent master
you can see it.

Unfortunately, this line is far from being one straight line drawn in
a single color. Thus, not surprisingly that this line cannot be seen in
the graph, and here is where the mental image that a new user has about
branches (based on different books and diagrams) clashes with the image
presented by gitk. No one will ever draw the mainline like this:

-o--o--o         o--o--o
        \       /
         o--o--o

but it is not uncommon for gitk to display it in this way, and when
this line is intervene with many other branches that forking from and
merging to this mainline, all what you can see a complex graph and
nothing more.

There is one more thing. In Git, all branches are equal and that is a
really good feature from the implementation point of view as it makes
design simpler and more powerful. But the user point of view, branches
are never equal -- there is a _big_ difference between the master and
any feature branch. All diagrams explaining branching and merging will
show the mainline as a thick straight line running through all history
(like a tree trunk) while feature branches fork and merge back to it.

That is the mental image that a new user has, and that image clashes
with what he or she sees in gitk. BTW, when I started to use Git, I
strongly preferred qgit over gitk. Admittedly, gitk displays branches
much better when you have a really bushy tree, but straight lines
displayed by qgit were much easier to understand and to follow.

So, I don't think that we have any conceptual problem here. It may be
a visualization problem, but if you have a really complex tree, it may
be impossible to present it as nice and simple as artificial diagrams
in textbooks.


Dmitry
