From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 21:35:24 +0100
Message-ID: <200911112135.25839.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de> <200911111411.nABEBfox031023@ds9.cixit.se> <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Jvj-0006mW-8w
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 21:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbZKKUg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757320AbZKKUg0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 15:36:26 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45279 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbZKKUgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 15:36:25 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 21:36:31 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 21:36:09 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132698>

Baz wrote:
> 2009/11/11 Peter Krefting <peter@softwolves.pp.se>:
> >  ours::
> >        This resolves any number of heads, but the result of the
> > -       merge is always the current branch head.  It is meant to
> > +       merge is always the current branch head, discarding any
> > +       changes on the merged branch.  It is meant to
> 
> I think part of the problem is that it is unclear what the "current
> branch head" means when used in a rebase, and hence when this text is
> included in the help for git-rebase and git-pull.
[...]
> Perhaps something more in the way of an explicit warning?
> 
> ours::
>          This resolves any number of heads, but the result of the
>          merge is always the current branch head, discarding any
>          changes on the merged branch.  It is meant to
>          be used to supersede old development history of side
>          branches. Note that when rebasing, the branch you are
>          rebasing onto is the "current branch head", and using this
>          strategy will lose all of your changes - unlikely to be what
>          you wanted to do.

I'd much rather see this explained in the description of the rebase
-m/-s options since it (the swap) applies to all uses of 'git rebase
-m'.  Perhaps with an extra (but short) note in the "ours"
description, like so:

diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
index 33e0ef1..181947c 100644
--- i/Documentation/git-rebase.txt
+++ w/Documentation/git-rebase.txt
@@ -228,6 +228,10 @@ OPTIONS
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
++
+Note that in a rebase merge (hence merge conflict), the sides are
+swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
+rebased series, starting with <upstream>.
 
 -s <strategy>::
 --strategy=<strategy>::
diff --git i/Documentation/merge-strategies.txt w/Documentation/merge-strategies.txt
index 4365b7e..0cae1be 100644
--- i/Documentation/merge-strategies.txt
+++ w/Documentation/merge-strategies.txt
@@ -33,6 +33,9 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
++
+Because the sides in a rebase are swapped, using this strategy with
+git-rebase is never a good idea.
 
 subtree::
 	This is a modified recursive strategy. When merging trees A and

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
