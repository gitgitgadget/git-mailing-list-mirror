From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 16:29:48 -0800
Message-ID: <7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAwvf-0006AQ-RE
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYAEA35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYAEA35
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:29:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbYAEA34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:29:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04EB16346;
	Fri,  4 Jan 2008 19:29:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 858E16345;
	Fri,  4 Jan 2008 19:29:50 -0500 (EST)
In-Reply-To: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	(Marco Costalba's message of "Fri, 4 Jan 2008 17:14:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69620>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Otherwise git-stash is unusable by scripts that check
> stderr to detect fail/success of launched command.

Sorry, but I happen to disagree with your notion of "having
something on stderr is an error" to begin with.  I think scripts
written that way are either simply bogus, or are working around
a defect in the underlying command it calls (perhaps it does not
signal error with exit status properly).

A command that produces machine parsable output should write
that out to stdout, and if it needs to emit other informational
messages meant for human consumption (this includes progress
bars), that should be sent to stderr so that scripts can get the
meat of the output without having to filter cruft out.

If the command does not signal an error by exiting with non-zero
status, that would be a bug indeed and you can fix that instead,
I think.
