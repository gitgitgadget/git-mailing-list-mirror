From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Mon, 18 Jul 2011 12:01:10 -0400
Message-ID: <1311004870.18654.21.camel@drew-northup.unet.maine.edu>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu>
	 <4E200611.9010005@alum.mit.edu> <7vlivz1inu.fsf@alter.siamese.dyndns.org>
	 <20110715212059.GA2117@sigill.intra.peff.net>
	 <4E212113.6000906@alum.mit.edu>
	 <1310909091.21563.23.camel@drew-northup.unet.maine.edu>
	 <m3pql8yngt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiqHb-0003WW-JX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1GRQCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:02:51 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:35842 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab1GRQCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:02:50 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6IG1FvA002353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 Jul 2011 12:01:20 -0400
In-Reply-To: <m3pql8yngt.fsf@localhost.localdomain>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6IG1FvA002353
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311609691.4062@7zMdzuN10MFrAikSGnCvYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177378>


On Mon, 2011-07-18 at 01:59 -0700, Jakub Narebski wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> 
> > On Sat, 2011-07-16 at 07:26 +0200, Michael Haggerty wrote:
> > 
> > > Currently, the loose ref cache is stored as a single linked list, so
> > > there is no easy way to populate part of it now and part of it later.
> > > So with the current data structure, the loose refs cache is
> > > all-or-nothing.  It would be possible to avoid filling it if there are
> > > not replace references, but if there is even one loose replace reference
> > > then the whole refs tree would have to be crawled.  Implementing this
> > > variation is alternative 4 from the early email.
> > > 
> > > More flexible would be to change the way the loose ref cache is stored
> > > from a linked list into a tree (probably mirroring the directory tree).
> > 
> > Given the potential for high performance inherent with trees, why mix
> > metaphors like this? What would the gain be?
> 
> Did you mean: "why linked list"?  I _guess_ that it is most probably
> because linked list is simpler and better known data structure than
> non-binary tree.

No, that I can compute. I was asking why mix tree metaphors (pure
binary, R/B, and 234 being probably the most common kinds for the data
structure; and filesystem "trees"). In my mind I was thinking of
SHA1sums as the keys (for some reason that doesn't occur to me right
now) and thought perhaps it was worth becoming enlightened (or
something). Perhaps I should have looked harder in my mail queue for the
patch referenced.

> 
> What is needed I think is something like trie[1], but with path
> components and not letters stored in trie nodes.
> 
> [1]: http://en.wikipedia.org/wiki/Trie

Obviously, there are other "tree" structures. That's one I probably
should have thought of earlier.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
