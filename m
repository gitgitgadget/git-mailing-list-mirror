From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Mon, 8 Nov 2010 23:29:37 +0100
Message-ID: <20101108222937.GH3167@home.lan>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
 <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan>
 <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
 <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Yann Dirson <ydirson@free.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 23:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaDo-0005qu-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab0KHW3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:29:48 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49021 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab0KHW3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:29:47 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 194B2D480DA;
	Mon,  8 Nov 2010 23:29:38 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PFaDZ-0001re-Oy; Mon, 08 Nov 2010 23:29:37 +0100
Content-Disposition: inline
In-Reply-To: <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160998>

On Mon, Nov 08, 2010 at 01:49:44PM -0800, Kevin Ballard wrote:
> On Nov 8, 2010, at 10:31 AM, Junio C Hamano wrote:
> 
> > Yann Dirson <ydirson@free.fr> writes:
> > 
> >> #  e, edit = use commit (if specified) but pause to amend/examine/test
> > 
> > When an end user is given
> > 
> >    pick one
> >    pick two
> >    pick three
> >    ...
> > 
> > and told the above, would it be crystal clear that, if he changed the insn
> > sheet to
> > 
> >    pick one
> >    edit
> >    pick three
> >    ...
> > 
> > then he will _lose_ the change made by foo, or will the user come back
> > here and complain that a precious change "two" is lost and it is git's
> > fault?
> 
> On the one hand, once someone understands what the todo list is actually
> doing, then it should be instantly obvious that removing the reference to
> a commit will remove that commit entirely. On the other hand, I agree it
> may be confusing to new git users (or new rebase users). Do you have an
> alternative solution in mind?

Maybe restating in an explanatory paragraph something like:

|Keep in mind that any commit in the original todo list, that would
|not be there after your edits, would not be included in the resulting
|rebased branch.  In case you realize afterwards that you need such a
|commit, you can still access it as an ancestor of @{1}, see
|git-reflog(1) for details.

Maybe we could list a copy of the todo list in the comments, as a
reference for double-checking.  Such a list could even be used for a
final check before applying, that would ask confirmation if the set of
patches has changed, and offer to edit again.  The same config item
(eg. advice.interactiveRebase ?) could be used to hide the note and
the check.

Now making "rebase -i" possibly interactive may cause problems, for
any porcelain scripts above it.  Not sure it'd be the way to do it.
Maybe add a "check" command to be inserted at bottom of todo list to
activate it, that would be here by default but commented out ?
