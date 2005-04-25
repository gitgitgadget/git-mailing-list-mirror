From: Andreas Gal <gal@uci.edu>
Subject: Re: [PATCH] New option (-H) for rpush/rpull to update HEAD
Date: Sun, 24 Apr 2005 21:55:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504242149330.5553@sam.ics.uci.edu>
References: <Pine.LNX.4.21.0504250041500.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 06:51:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvYj-0003Du-Iv
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 06:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVDYEzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 00:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVDYEzz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 00:55:55 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:31917 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262534AbVDYEzs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 00:55:48 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3P4tkBj005563;
	Sun, 24 Apr 2005 21:55:46 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3P4tkt2005559;
	Sun, 24 Apr 2005 21:55:46 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504250041500.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Why? Updating HEAD right after writing the commit id and all its children 
to the object directory seems reasonable and prevents race conditions when 
the remote repository is shared via HTTP etc. rpull, in contrast, should 
never touch HEAD, because conflicts might force a merge that will set
HEAD to something else. For the pull case we should let the script(tm) do
that. Its local anyway. rpush is different because the script(tm) has to
do some SSH magic to update HEAD. I will gladly supply a patch to fix what 
to read/write once you have figured out the final layout, but I really 
need a working rpush _NOW_ ;).

Andreas

On Mon, 25 Apr 2005, Daniel Barkalow wrote:

> On Sun, 24 Apr 2005, Andreas Gal wrote:
> 
> > This patch adds a new option -H to rpush/rpull to update the
> > HEAD pointer when pushing a new release to a remote repository. 
> 
> Updating the head pointer (in either direction) should be instead of
> specifying a commit, and should also apply to http-pull. I've also
> suggested some changes to the organization of HEAD and related items, so
> the logical things to read and write are likely to change soon.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
