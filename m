From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 00:34:33 +0200
Message-ID: <20080703223433.GE6677@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <7vlk0iy5we.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEXOs-0001HL-Ao
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYGCWek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 18:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbYGCWej
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:34:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:35919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754262AbYGCWej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 18:34:39 -0400
Received: (qmail invoked by alias); 03 Jul 2008 22:34:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 04 Jul 2008 00:34:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18JxLpwC5kJKNa3DdW2U+IrVgEe0MfpnRay8gnqZX
	vJ6gL5Nkd7wo0k
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEXNp-0000Yj-HD; Fri, 04 Jul 2008 00:34:33 +0200
Content-Disposition: inline
In-Reply-To: <7vlk0iy5we.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87330>

On Thu, Jul 03, 2008 at 03:11:45PM -0700, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> >> > +		die_to_continue 'Patch failed. See the .rej files.'
> >> > +		# XXX: We actually needed a git-apply flag that creates
> >> > +		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.
> >> 
> >> That is what -3way is all about, and this codepath is when the user did
> >> not ask for it, isn't it?
> >
> > Now imagine you apply a patch that cannot be applied 100% cleanly and
> > you don't have the 3-way base in the repo. You know what happens?
> 
> Do you think I don't?  You can check who invented 3way by running "git
> log" or "git blame" on git-am.sh ;-)

I know you know.  The question was just rhetorical.

> I think you misread my "That is what -3way is all about".  That remark is
> about the comment you have about "creates conflict markers".  The conflict
> markers is only possible because we do 3-way merge when you ran "am -3".
> If you do not have the base object but only a blob and an unapplicable
> patch, you cannot do "here is our change since common ancestor, and here
> is their change the patch wants to make" conflict markers, because you do
> not have the common ancestor.

I didn't misread it.
But it is a wrong implication that you cannot do this when you do not have
a common ancestor.
For example: Even if no context matches (or no context exists), it is
possible to add a conflict marker at the specified line. It can happen
that this will result in crap, but resolving some parts that just look
wrong is easier than applying a patch 100% manually.

I think I'm going to add such a git-apply option after GSoC, if nobody
does this before.

> > Yes, the patch is completly rejected, because apply is atomic.
> > And I think a git-apply option that results in a non-atomic behavior,
> > that creates conflict markers (and no .rej files), would be a great
> > usability feature for the "patch" insn in sequencer.
> 
> Yes, I think I already said in the message you are responding to that it
> may make sense to have such an option (but at the same time we should
> remember that nobody asked to add --reject to "git am").

Right, so I removed it ;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
