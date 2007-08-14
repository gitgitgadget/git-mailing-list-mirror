From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 19:14:22 -0400
Message-ID: <20070814231422.GA10662@pe.Belkin>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 01:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL5bE-0002ni-T3
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 01:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbXHNXO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 19:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbXHNXOZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 19:14:25 -0400
Received: from eastrmmtao101.cox.net ([68.230.240.7]:63723 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbXHNXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 19:14:23 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814231424.YIDL19516.eastrmmtao101.cox.net@eastrmimpo02.cox.net>;
          Tue, 14 Aug 2007 19:14:24 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id bzEN1X0050epFYL0000000; Tue, 14 Aug 2007 19:14:22 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IL5ag-0002ms-K3; Tue, 14 Aug 2007 19:14:22 -0400
Content-Disposition: inline
In-Reply-To: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55862>

On Tue, Aug 14, 2007 at 03:33:07PM -0700, Junio C Hamano wrote:
> When you try to merge a path that involves binary file-level
> merge, merge-recursive died rudely without cleaning up its own
> mess.  A files added by the merge were left in the working tree,
> but the index was not written out (because it just punted and
> died), so it was cumbersome for the user to retry it by first
> running "git reset --hard".
> 
> This changes merge-recursive to still warn but do the "binary"
> merge for such a path; leave the "our" version in the working
> tree, but still keep the path unmerged so that the user can sort
> it out.

Very nice. Thanks, Junio.  As an additional convenience, it would be
nice to make the "theirs" version easily accessible.  Perhaps, by
leaving an untracked file in the working tree, with the original
filename, suffixed with a hash-prefix.  Or alternatively,
cut-n-pastable instuctions on stdout for replacing the file with the
"theirs" version.

On the other hand, I tend to think that "theirs" would be a better
default than "ours" anyway - still leaving the path unmerged, of
course.

-chris
