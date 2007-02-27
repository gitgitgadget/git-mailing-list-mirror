From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 03:06:15 -0800
Message-ID: <7v4pp7hnbs.fsf@assigned-by-dhcp.cox.net>
References: <20070226121557.GA18114@coredump.intra.peff.net>
	<20070226143142.GA1390@spearce.org>
	<Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6scj9qt.fsf@assigned-by-dhcp.cox.net>
	<20070227081933.GA13021@coredump.intra.peff.net>
	<7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
	<20070227105212.GA21757@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 12:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0A0-0003dc-DR
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXB0LGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXB0LGR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:06:17 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:32937 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbXB0LGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:06:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227110616.MKDQ2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 06:06:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ub6F1W00H1kojtg0000000; Tue, 27 Feb 2007 06:06:16 -0500
In-Reply-To: <20070227105212.GA21757@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Feb 2007 05:52:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40709>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 27, 2007 at 02:23:02AM -0800, Junio C Hamano wrote:
>
>> Although pointers to component project commits are represented
>> as "parent" field in commit objects, I suspect that you wish
>> they were treated as if they were tree objects contained in the
>> toplevel commits more often than not for the purposes of many
>> git operations.
>
> Yes, that is exactly correct. One problem I realized after doing this is
> that you get unexpected results from "git-whatchanged -- subproject/".
> My first expectation was to see _just_ the history of the subproject.
> But of course, you see only the merge commit, since the previous commits
> for that subproject didn't have that path at all (they were in the
> root!).  Subproject support would fix that, as would simply rewriting
> the history.

For the record, I am aware of the fact that the recent git.git
itself exhibits this exact problem, due to the subtree merge of
git-gui repository.  I haven't got to the point of being annoyed
enough to regret it, but running "git show" on merges from Shawn
always needs -M option to make heads or tails of.
