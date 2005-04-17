From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 20:51:49 +0100
Message-ID: <20050417205149.E13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org> <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 21:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFkT-00053F-1o
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVDQTvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDQTvz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:51:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54280 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261442AbVDQTvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 15:51:53 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNFo6-0008Pe-IW; Sun, 17 Apr 2005 20:51:51 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNFo5-0006gn-BE; Sun, 17 Apr 2005 20:51:49 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Apr 17, 2005 at 12:33:22PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(Dropped HPA from the CC line - I think he was only copied for the
master.kernel.org issues.)

On Sun, Apr 17, 2005 at 12:33:22PM -0700, Linus Torvalds wrote:
> On Sun, 17 Apr 2005, Russell King wrote:
> > I still need to work out how to make my noddy script follow different
> > branches which may be present though.  However, for my common work
> > flow, it fits what I require.
> 
> The way to handle that is that you need to 
> 
>  - remember (or re-fetch) what the latest HEAD was that you merged with in 
>    my tree.
> 
>    if you didn't remember, you can just get all my objects and do a
> 
> 	merge-head $(cat .git/HEAD) $linus-current-head
> 
>    or something (using the current git archive that has a "merge-head" 
>    program. That gives you the most recent common head.

My script currently sends between two commit-ids, so...

>  - use "rev-tree" to show reachability
> 
> 	rev-tree $my-current-head $last-merge-head
> 		| sort -n		# sort by date rather than sha1
> 		| cut -d' ' -f2		# get the sha1 + "flags" mask
> 		| grep :1		# show the ones that are only
> 					# reachable from $my-current-head
> 
> and you now have a nice list of sha1's ordered by date.

This will (and does) do exactly what I want.  I'll also read into the
above a request that you want it in forward date order. 8)

-- 
Russell King

