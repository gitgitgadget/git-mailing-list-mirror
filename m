From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Sat, 05 Jan 2008 00:36:30 -0800
Message-ID: <7vbq80d5yp.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	<7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4Wl-0007UD-QS
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYAEIgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYAEIgm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:36:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYAEIgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:36:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 00DEA7AFD;
	Sat,  5 Jan 2008 03:36:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A7F7AFC;
	Sat,  5 Jan 2008 03:36:37 -0500 (EST)
In-Reply-To: <e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
	(Marco Costalba's message of "Sat, 5 Jan 2008 09:25:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69652>

"Marco Costalba" <mcostalba@gmail.com> writes:

> This low level run() should know nothing about the semantic of the
> command or the outputted data, but should detect command failing,
> because failing reporting framework is unified and is the same for
> each type of command.

That sounds like a framework generalized in a wrong way to me.

> Please note that also gitk uses the same approach, indeed from
> http://ftp.tcl.tk/man/tcl8.5/tutorial/Tcl26.html you can read:
> ...

Heh, as if tcl is a textbook of good programming style.

> I can also black list not commonly behaving programs, but in case of
> git-stash a fail to see why to choose a not standard behaviour when
> not needed.

I do not offhand see a reason it would _hurt_ for this
particular case (git-stash) to write the diagnostics we
currently spit out to stderr to stdout.  My objection is
primarily because I do not think "never writing to stderr if
there is no error" is standard behaviour AT ALL.

IOW, I do have much less objections to what your patch actually
does, than I have problems with the way the reason for the
change is stated.  The change is not fixing anything to conform
to some standard behaviour.  It is more about bending
(admittedly only slightly) backwards to help broken callers.
That is what I have most trouble with.
