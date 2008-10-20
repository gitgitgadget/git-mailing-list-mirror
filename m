From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is XDL_MERGE_ZEALOUS too zealous (or maybe not zealous
 enough)?
Date: Mon, 20 Oct 2008 18:17:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810201809100.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1224377652.19061.12.camel@mattlaptop2.local> <7vhc785izq.fsf@gitster.siamese.dyndns.org> <7v3ais5hb3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Matt McCutchen <matt@mattmccutchen.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:25:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxLq-00083I-2U
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYJTQKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYJTQKO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:10:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:54244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbYJTQKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:10:13 -0400
Received: (qmail invoked by alias); 20 Oct 2008 16:10:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 20 Oct 2008 18:10:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YQV9DKbbYeYYC/DIIZwIHdjgtFeWGcywOQU+/Tw
	3NHSfj8Z2VP/nQ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v3ais5hb3.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98726>

Hi,

On Sun, 19 Oct 2008, Junio C Hamano wrote:

> <<<<<<< ours
> 	/* --track without -b should DWIM */
> 	if (0 < opts.track && !opts.new_branch) {
> 		const char *argv0 = argv[0];
> 	...
> 		opts.new_branch = argv0 + 1;
> 	}
> 
> 	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
> 		opts.track = git_branch_track;
> =======
> 	if (conflict_style) {
> 		opts.merge = 1; /* implied */
> 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> 	}
> 
> 	if (!opts.new_branch && (opts.track != git_branch_track))
> 		die("git checkout: --track and --no-track require -b");
> >>>>>>> theirs

This is that case that adjacent blocks A and B are changed to A' B and A 
B' in the to-be-merged branches.

I could imagine that you would have this automerged to A' B', but I 
actually advise against that.

My gut feeling tells me that a "for" statement as block "A" and some 
change ("B") in the _body_ of the "for" loop that takes advantage of the 
original version of the "for" statement would be _real_ hard to detect.

Better have trivial conflicts reported, but catch more non-trivial ones 
(instead of mismerging them).

(Another possibility would be that block "B" is actually an "else".  Also 
in this case it is easy to think of cases that would wreak havoc; OTOH we 
would mismerge them _already_ if at least 1 common line is unchanged 
between the blocks.  Tough.)

But I might be completely wrong.

Ciao,
Dscho "who is a little jet-lagged, so you should trust him even less than 
normally"
