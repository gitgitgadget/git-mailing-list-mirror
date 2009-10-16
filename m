From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 19:56:52 -0700
Message-ID: <7vvdigxczv.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
 <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0910152118360.20122@xanadu.home>
 <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 05:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myd5o-0000gz-7S
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 05:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbZJPC5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 22:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZJPC5w
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 22:57:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbZJPC5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 22:57:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E36F7796E6;
	Thu, 15 Oct 2009 22:57:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/r9O1xOW8p/wsm2yenYoP7WDLDc=; b=jgKhNL
	wxiFVuk9wCrFXE1IdCSb2oe/6lRfuU63119Rg/Q3iz/4ryn8/TMqc2+yZyx0cKy2
	JwcMa0rthasOVy72i7iuQibmrojjg6L70ShMSKUsn9srpQvstybh1xHXrW+JTcoP
	Mae0bkZJmvgPjBazXgIK3F7NObMckLNY7dn+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vw8Hr3RvvZOJiPEUo0L6DjJT7rp03Efa
	Y5Xz/qpC0+zDqzNYCeky0RFxpNL/T28viNWCjj3v/GIt1TCxY20WaM9Sb1agKq0Q
	OkNISQHbEXtCATIVpJOONiRLOYHaaQodMG5fp2FGDNzftvuFf3doKu+ZnBNxFSRp
	Fbo2bpAWZqs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 825AC796E2;
	Thu, 15 Oct 2009 22:57:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 233C2796DF; Thu, 15 Oct 2009
 22:56:53 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 16 Oct 2009 04\:07\:23 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94F9EEC0-B9FF-11DE-A8AD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You are trying to educate the users to use the double-clutch.  Rather than 
> making the double-clutch obsolete.

I do not quite get your double-clutch rhetoric, in the sense that I do not
think it has anything analogous in the topic of detached HEAD we have been
discussing.

Didn't we discuss possible solutions to make sure that you do not have to
detach HEAD and lose commits by coming back without saving them?  I would
consider that corresponds to inventing automatic (iow, making sure that
sightseeing can be done without having to worry about accidentally
committing on that state and later losing them).  Obviously, you would
need to cover cases other than we have discussed (e.g. if "rebase -i"
detaches, it needs to allow "commit", "commit --amend", and "reset --soft
HEAD^", but you probably would not want to allow "checkout" to switch to
another branch).  Thinking things through so that we can fill in all these
details is a tedious and hard work, but I would say it would be worth it.
In the ideal world, if you do not have to (nor want to) use the detached
HEAD feature, you do not have to.

But that is entirely different from saying "I do not need to use detached
HEAD, I cannot explain it to my users. Let's make it unusable, iow, I give
up".  Unfortunately that is the impression I am getting from your whining.

If you have been advocating for something else, and you share the goal of
helping users by e.g. making it unnecessary to worry about accidentally
committing on that state and later losing them, you would need to do a
better job explaining yourself.

> Just recently, I had a user request (a very valid one, mind you) where the 
> user does not want to provide a commit message, and wants to just commit 
> all the current changes.  In that particular case, it is very sensible to 
> ask for these things.  It is something utterly simple to ask for. Yet, it 
> is utterly hard with Git, especially if I have to explain it.

I suspect the above is another example of your needing to do a better job
explaining yourself here, but from "just commit all the changes without
saying message", my knee-jerk reaction is "git commit -a -m 'no message'".

You would need to justify why -m 'no message' does not fit the bill better
than just saying "is very sensible to ask for these things", as I highly
suspect that I misunderstood what "these things" are in your five lines to
come up with that "solution" that you are now going to explain why that is
not what the end user wanted.  And in this case, I do not think it is that
me being disconnected from the real world, but that your explanation is
insufficient.
