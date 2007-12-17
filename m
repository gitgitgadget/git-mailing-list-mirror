From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 09:58:02 -0800
Message-ID: <7vsl218aqd.fsf@gitster.siamese.dyndns.org>
References: <20071215155150.GA24810@coredump.intra.peff.net>
	<7vprx7n90t.fsf@gitster.siamese.dyndns.org>
	<20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
	<7v8x3ul927.fsf@gitster.siamese.dyndns.org>
	<7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
	<20071216212104.GA32307@coredump.intra.peff.net>
	<7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
	<20071216221545.GA32596@coredump.intra.peff.net>
	<7vtzmii8io.fsf@gitster.siamese.dyndns.org>
	<20071216222919.GA2260@coredump.intra.peff.net>
	<EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com>
	<Pine.LNX.4.64.0712171038130.9446@racer.site>
	<36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com>
	<Pine.LNX.4.64.0712171151490.9446@racer.site>
	<57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
	<476669A7.1050407@viscovery.net>
	<Pine.LNX.4.64.0712171250550.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 18:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KEn-00075l-QJ
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 18:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXLQR6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 12:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbXLQR6X
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 12:58:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbXLQR6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 12:58:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D8874570;
	Mon, 17 Dec 2007 12:58:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB1A7456C;
	Mon, 17 Dec 2007 12:58:04 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712171250550.9446@racer.site> (Johannes
	Schindelin's message of "Mon, 17 Dec 2007 12:51:29 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68584>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> But as at least one released version of GNU diff has a pretty serious
>> >> bug,
>> >> I would rather not rely too much on diff.  (BTW this was the reason I
>> >> wanted --no-index so badly.)
>> >>
>> >> So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but not
>> >> "git diff".
>> > 
>> > Well cmp would be fine as well, seeing all we want is a boolean "is 
>> > this the same or not" answer. (I'm not familiar with the GNU diff bug 
>> > you speak of, but was it so bad that it couldn't even get *that* 
>> > answer right?)
>> 
>> Heh, there's at least one distribution out there (Suse 10.1) that comes 
>> with a *cmp* that doesn't get that answer right if its output is 
>> connected to /dev/null, which is the case when you simply 'make test'.
>
> Yeah.  That's what it was.  I even posted a patch to GNU diff, only to 
> find out that it was already fixed in CVS.  Sigh.

Wait.  Are you still talking about diff or cmp, or are you saying that
your earlier statement about avoiding GNU diff due to its bugs is
unfounded?
