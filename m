From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Fri, 19 Aug 2005 20:27:32 +0200
Message-ID: <20050819182732.GA5512@fanta>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 20:27:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6BYk-0002VQ-TG
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 20:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVHSSZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVHSSZW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 14:25:22 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:49028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932487AbVHSSZW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 14:25:22 -0400
Received: by wproxy.gmail.com with SMTP id i24so563547wra
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 11:25:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IeHkRXr3VzZx9jNu8nrle9Xl0Z+s5YjYMYxaSxgVRR7Dmr3TS5ozi+krLTZ7l57l5uDVXhM9rD3eYOQNtDW0/zCrDI3g/90qen9cyg6UuzL9Wckw6zDPhzUcExLN2+fMNzvwgDnL5X1JsuCG8uj/ORGtscOqgWuXyiZHAfW18As=
Received: by 10.54.142.2 with SMTP id p2mr2008439wrd;
        Fri, 19 Aug 2005 11:25:14 -0700 (PDT)
Received: from localhost ([84.195.185.241])
        by mx.gmail.com with ESMTP id 45sm2821724wri.2005.08.19.11.25.13;
        Fri, 19 Aug 2005 11:25:14 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnx64u2p81k.fsf@arm.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

> 
> The patch history feature was available in StGIT 0.1/0.2 releases
> where you should have run a 'stg commit' before 'stg refresh'. The
> commit was handling all the history changes, with separate commit
> messages and refresh was updating the main commit with 2 parents. I
> removed it in 0.3 after some people (I think it was Paul Jackson and
> Daniel Barkalow) convinced me that this would make it yet another SCM
> interface on top of GIT, which wasn't really my intention.

hmm, I must have misted those threads, I'll try to find and read them.

> 
> The main problem with having multiple parents for a commit object
> corresponding to a patch is the upstream merging via 'git pull'. In
> general you don't want a gatekeeper to pull the history of your patch
> but the patch only.

I agree that such history should not be imported into the mainline, but such
history would still be very usefull when these patches won't be pushed to
mailine immediately. Also, when pushing to mainline, this history can easily
be removed by removing the branch/patch/parent files and refreshing (this
should off course be automated)

> 
> > The patch below, together with the following script could be used to
> > make snapshots of the patch stack (I call it freeze, as I thought snapshot
> > was already going to be used for something else):
> 
> 'snapshot' is not yet used for anything and I'm not sure how it is
> best to be implemented. I thought about simply saving the current HEAD
> into some .git/refs/heads/<file>, without preserving any history for
> the patch. A gitk on this file would show the patches as they were on
> the time of the snapshot creation. A new snapshot would remove this.
> 
> It might be best for a per-patch history to have a separate file in
> <branch>/<patch>/, maybe called freeze, which keeps this history
> information. The top one should remain unchanged. Its hash could be
> accessed with the 'stg id /freeze' command (implemented
> yesterday). This file would only be updated via the 'freeze' command
> and its parent would be the previous freeze value.
> 
> Would this be close to what you need?
> 

hmm, not exactly, for example, when reordering the patches (including the
top one), I would like to see this in gitk.
Or when a patch has been dropped (amongst a lot of patches), it should be
easily spotted.


But even if the "stg-freeze" would not be incorporated into stgit, would it
still be possible to include some sort of extra parents directory. So that
the freeze can be implemented on top of stgit?

TIA

Best regards,
Jan
