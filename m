From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 13:48:45 -0800
Message-ID: <7veje23zcy.fsf@gitster.siamese.dyndns.org>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201>
	<7vir3e428i.fsf@gitster.siamese.dyndns.org>
	<vpq4peyjgd7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 04 22:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izfdl-00045Z-W7
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 22:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbXLDVs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 16:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLDVs4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 16:48:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57202 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXLDVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 16:48:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F1C292EF;
	Tue,  4 Dec 2007 16:49:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 64C909CF0A;
	Tue,  4 Dec 2007 16:49:11 -0500 (EST)
In-Reply-To: <vpq4peyjgd7.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	04 Dec 2007 22:32:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67085>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Having said that, I am not sympathetic to "I have to remember".
>
> That's definitely not an important point, but I find it conveinient,
> for example in hg, to be able to just "hg update" to get to the tip of
> a branch.
>
> A use-case (which joins the one of Salikh actually) is to publish both
> a repository and a working tree (I do that for my collegues which may
> or (usually) may not use git). Making a hook to update the working
> tree after a push is a terrible hack in git, and just "hg update" in
> Mercurial.

That's a different issue.  The reason push-into-a-live-tree works that
way in Hg is because they have this implicit notion of unmerged heads
that is merged with the next "hg update".  We don't.

Instead, we are more explicit.  If you want to emulate that workflow in
git, you would prepare a reception branch, and have people push into it
(see gitfaq and look for "sync out of a firewalled host".  In the FAQ
entry, pretend as if machineA is such a live work tree you are working
in, and allow people to push into --- that B/master is the reception
branch, although the FAQ entry is about your private use and written as
if only you from a satellite machine can push into it, it can easily be
a shared branch).

Instead of saying "hg update", you (the person working in such a live
work tree that allows others to push into) merge that reception branch.
