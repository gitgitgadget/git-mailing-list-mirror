From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [COGITO PATCH] cg-branch-switch and local branches
Date: Wed, 01 Jun 2005 16:41:38 +0200
Message-ID: <87mzqaqgv1.fsf@gmail.com>
References: <87ekbmi5zl.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 16:39:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdUMw-0003To-6Y
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 16:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFAOln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFAOln
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 10:41:43 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:48014 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261361AbVFAOlf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 10:41:35 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51EfXZ19261
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 16:41:33 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87ekbmi5zl.fsf@ifae.es> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 15:03:42
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

        after reading it I think I have to explain it better.

        And first I have to say that this patch depends on my patches
        in the thread "[COGITO PATCH] Heads and tags in subdirectories".
        But the logic does not depend on it, I think :)

Suppose I want to make some modifications to the cogito. So I do:

cg-clone cogito rsync://rsync.kernel.org/pub/scm/cogito/cogito.git

the first argument been the name I've gave to this repositori. Now I can
do the changes/commits in the usual way. But I want to work in two
differents patches, named dirs and switch, so I do:

cg-branch-add dirs cogito
cg-branch-add switch cogito

Now I have to local branches with their respective names, and the origin
been the cogito branch for both (but it can be different).

If I want to work on the dirs branch I do:

cg-branch-switch dirs

an the same for switch. In each case I can do a:

cg-merge origin

and merge their respective origin (in this case is the same).

If I want to work directly in cogito, I can do:

cg-branch-switch cogito

and work in the usual way. If the cogito repository have a branche
called cogito2 I could do:

cg-branch-switch cogito#cogito2

in the case I've already pulled this branch.

Internally it is:

Local branches
--------------

The master file is always a link:

master -> ${localbranch}

The content of $_git/branches/${localbranch} is the original branch of
local branch. The cases and the corresponding origin links are:

1a.- name         : a name of an external repository
                    $branch corresponding to the definition
                    origin -> $name/$branch
1b.- name#branch : optionally with a branch
                    origin -> $name/$branch
2 .- name         : a name of another local branch
                    $branch corresponding to the definition
                    origin -> $name/$branch

Local unnamed branches
----------------------

The master file is a regular file and the origin link only has the cases
1a and 1b where the $name is name of the local branch.



