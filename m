From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 13:43:03 -0800
Message-ID: <7vprhidpnc.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <20090215232013.GA11543@zakalwe.fi>
 <20090216000443.GB3503@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <loom.20090216T101457-231@post.gmane.org>
 <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBGi-0007pP-KQ
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZBPVnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbZBPVnO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:43:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZBPVnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:43:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DE802B467;
	Mon, 16 Feb 2009 16:43:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83D112B430; Mon,
 16 Feb 2009 16:43:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE0BC670-FC72-11DD-A7F9-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110249>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> ... is there some case where one wants
> and has reasons to commit to a detached head before making a temporary
> branch on it?

Absolutely. I do it all the time for minor fix-ups after applying other's
patches on a newly created topic branch.

If you want a push to the current branch of _your_ repository detach HEAD
automatically and record which branch it was pointing at before you
detached, I am reasonably sure you can do that in post-receive hook, no?

I do not think it is such a bad thing to have a new value 'detach' to
receive.denyCurrentBranch as a possible non-default choice per-se, but the
earlier discussion Jeff pointed out is only showing that detaching alone
is not enough to help the user recover from the resulting state, and Dscho
discussed in this thread that detaching and recording the original branch
may not be enough either.  IOW, we do not know yet precisely what needs to
happen other than detaching HEAD when the configuration tells us to
'detach' to be useful.

So how about you experiment the workflow by setting the configuration to
'ignore', setting up a hook to detach _and do some other useful things_ as
necessary, and help all of us figuring out what other information is
useful to record when you receive such a push, and what new indications
you could give users to reduce the possibility of confusion?  Once we know
what we want to happen, we can have it as one of the canned choices and it
would help users.
