From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 18:00:22 +0000
Message-ID: <20121030180021.GX26850@arachsys.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
 <20121030102526.GN4891@arachsys.com>
 <CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTG7G-0001YV-4c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013Ab2J3SA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:00:29 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:53634 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759668Ab2J3SA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:00:28 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1TTG71-0002j0-Cp; Tue, 30 Oct 2012 18:00:27 +0000
Content-Disposition: inline
In-Reply-To: <CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208712>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Yes, it seems this is an API issue; repo.branchtip doesn't exist in
> python 2.2.

Hi. Presumably this is a problem with old mercurial not a problem with old
python as mentioned in the commit?

> Both issues should be fixed now :)

They are indeed, and it now works nicely on all the repos I've tested it
with, including http://selenic.com/hg: very impressive!

I wonder whether it's worth ignoring heads with bookmarks pointing to them
when it comes to considering heads of branches, or at least allowing the
hg branch tracking to be easily disabled?

A common idiom when working with hg bookmarks is to completely ignore the
(not very useful) hg branches (i.e. all commits are on the default hg
branch) and have a bookmark for each line of development used exactly as a
git branch would be.

On such a repository, at the moment you will always get a warning about
multiple heads on branches/default, even though you actually don't care
about branches/default (and would prefer it not to exist) and just want the
branches coming from the bookmarks.

I've also seen repositories with no hg branches, but with a single
unbookmarked tip and bookmarks on some other heads to mark non-mainline
development. It would be nice for branches/default to track the unbookmarked
tip in this case, without warning about the other, bookmarked heads.

Finally, on a simple repo with no branches and where there's no clash with a
bookmark called master, I'd love to be able to a get a more idiomatic
origin/master rather than origin/branches/default.

Just some idle thoughts...

Best wishes,

Chris.
