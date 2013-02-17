From: Alain Kalker <a.c.kalker@gmail.com>
Subject: Re: Git bundles for backup and cloning: the Zaphod Beeblebrox
 thread
Date: Sun, 17 Feb 2013 19:51:10 +0000 (UTC)
Message-ID: <kfrcbe$ugv$3@ger.gmane.org>
References: <kfrb11$ugv$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7AHJ-0003Hx-L8
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 20:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab3BQTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 14:51:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:42750 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab3BQTvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 14:51:31 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U7AH0-0003Cp-Ng
	for git@vger.kernel.org; Sun, 17 Feb 2013 20:51:42 +0100
Received: from 524a7994.cm-4-3b.dynamic.ziggo.nl ([82.74.121.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 20:51:42 +0100
Received: from a.c.kalker by 524a7994.cm-4-3b.dynamic.ziggo.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 20:51:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 524a7994.cm-4-3b.dynamic.ziggo.nl
User-Agent: Pan/0.139 (Sexual Chocolate; GIT bf56508
	git://git.gnome.org/pan2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216407>

On Sun, 17 Feb 2013 19:28:33 +0000, Alain Kalker wrote:

> From the current documentation for git-bundle(1), it may not be clear
> for users unfamilliar with Git, how to create a bundle which can be used
> for backup purposes, or, more generally, to clone to a completely new
> repository.
> 
> Philip Oakley has posted a documentation patch some time ago, but Junio
> has pointed out several concerns.
> Ref: http://thread.gmane.org/gmane.comp.version-control.git/205887/
> focus=205897
> 
> Here's my attempt to summarize the concerns, adding some of my own, and
> a possible solution.
> 
> 1. "Missing HEAD syndrome"
> $ git bundle create <bundle> master -or-
> $ git bundle create <bundle> <branchname...>
> -or-
> $ git bundle create <bundle> --branches -then-
> $ git clone <bundle> <dir>
> 
> will be unable to checkout any files due to a missing ref for HEAD.
> Though this can be fixed by going into <dir> and doing `git checkout
> <ref>`, this is not very user-friendly.
> 
> 2. "Detached HEAD syndrome"
> $ git bundle create <bundle> HEAD $ git clone <bundle> <dir>
> will checkout files alright, but leaves one in a "detached HEAD" state.
>  
> 3. "Exploding HEAD syndrome"
> $ git bundle create <bundle> --all will add the HEAD, but will add refs
from refs/*, including all remotes,
> which is not desirable when cloning, unless one
> sets up all the remotes 
as well.
> 
> Finally, my solution for backing up only the local branches of a
> repository:
$ git bundle create <bundle> --branches HEAD # for backup purposes
-or-
$ git bundle create <bundle> master HEAD # for hosting or redistribution
> but this may not be very
> easy for new users to figure out on their own unless well documented
> (perhaps a new flag?)
> 
> Any comments or suggestions (including HHGTTG references!) are very
> welcome.
> 
> -Alain
