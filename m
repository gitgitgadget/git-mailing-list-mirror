From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Tue, 23 Jun 2009 08:50:13 -0700
Message-ID: <7v4ou79cga.fsf@alter.siamese.dyndns.org>
References: <20090622214032.GC19364@coredump.intra.peff.net>
	<20090623011001.GA15352@cthulhu> <4A40EF9C.7000706@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 17:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ8GN-0002Jm-7M
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 17:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZFWPuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZFWPuM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 11:50:12 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55671 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbZFWPuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 11:50:11 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623155012.LNZD25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Tue, 23 Jun 2009 11:50:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7TqD1c0094aMwMQ04TqD86; Tue, 23 Jun 2009 11:50:13 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=thBImqoGNukA:10 a=8q6LdnVOAAAA:8
 a=wwoviQxNuiOZ40WGPZUA:9 a=_Tqua5HZe7cK9Oygb5D93gWYmDMA:4 a=ACi2bg3fm-oA:10
X-CM-Score: 0.00
In-Reply-To: <4A40EF9C.7000706@xiplink.com> (Marc Branchaud's message of "Tue\, 23 Jun 2009 11\:07\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122096>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Shouldn't this option be named "--plumbing" since it's making 'git push'
> act like plumbing?  Actually, neither name seems intuitively descriptive
> to me...

Perhaps.  But asking for output format designed for Porcelain
implementions to read with --porcelain option has precedence.

> Why not teach 'git push' to change its output format if it's writing to a pipe?

That is ugly.  Besides, "writing to a pipe" would not be a right criteria,
if you want to do

          git push >log
          if grep blah log
          then
                do blah thing
          fi
          if grep baa log
          then
                do baa thing, too
          fi

When you make a program behave differently depending on where your stdout
goes, typically you see if it is going to the terminal (e.g. isatty(3)),
but even then you would need an explicit override from the command line
when stdout is a tty and you do not want "for humans" frills (e.g. color),
and when stdout is not a tty and you do want such frills.
