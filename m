From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 13:32:01 -0800
Message-ID: <7vabzgmnn2.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRjW-0005ko-1O
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbXBNVcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbXBNVcE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:32:04 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63839 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbXBNVcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:32:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214213201.YALO1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 16:32:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PZY11W00S1kojtg0000000; Wed, 14 Feb 2007 16:32:01 -0500
In-Reply-To: <17875.30187.289679.417079@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 14:49:47 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39756>

Bill Lear <rael@zopyra.com> writes:

> ... I did try doing this:
>
> 1) with 1.4.4.1 git, clone my public repo
> 2) in this new clone, make modifications to my files as before
> 3) with 1.5.0 git, do a commit
>
> and I got the same blowup on commit, and this on fsck, with 1.5.0 git:
>
> % git fsck-objects --full
> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
> error: 00078437c23cbc04da52233f4f412219f88b8927: object corrupt or missing
> fatal: unknown object type 5 in .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

If you stop after cloning but before making a modification, is
the repository in good shape?

> % ls -l objects/pack/
> total 85992
> -r--r--r--  1 blear software    77360 Feb 13 10:18 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
> -r--r--r--  1 blear software 87874337 Feb 14 10:00 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
>
> The .pack files have the same SHA, but different sizes (don't know
> what that means).

That is usually not a problem;  the name reflects the names of
objects contained in the pack (so both have the same set of
objects), but the actual raw contents (and the offsets recorded
in corresponding .idx file) depends on the packing parameters
(window, depth and deltabaseoffset).
