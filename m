From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 15:11:35 -0700
Message-ID: <7v4plf7948.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVdm-00034a-9B
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbXFJWLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759093AbXFJWLi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:11:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53589 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbXFJWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:11:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610221137.HXIH29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 18:11:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9yBc1X00A1kojtg0000000; Sun, 10 Jun 2007 18:11:37 -0400
In-Reply-To: <Pine.LNX.4.64.0706091854330.4059@racer.site> (Johannes
	Schindelin's message of "Sat, 9 Jun 2007 18:55:10 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49779>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With the provided script, edit-commit-annotations, you can add
> after-the-fact annotations to commits, which will be shown by
> the log if the config variable core.showannotations is set.
>
> The annotations are tracked in a new ref, refs/annotations/commits,
> in the same fan-out style as .git/objects/??/*, only that they only
> exist in the object database now.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I have the hunch that this will be relatively fast and scalable,
> 	since the tree objects are sorted by name (the name being the
> 	object name of the to-be-annotated commit).

The entries of tree are sorted but not necessarily of uniform
length so you end up needing linear search anyway.  The fan-out
would help with the current tree objects.

It will hurt _if_ we introduce a new tree object format that
would give you a quick random-access at an entry, but it is
premature to worry about that now.
