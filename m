From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 13:49:42 -0800
Message-ID: <7vprxu3urt.fsf@gitster.siamese.dyndns.org>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org>
	<20071128194159.GA25977@midwinter.com>
	<20071128194919.GC11396@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUnL-0007fD-RQ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXK1Vtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757269AbXK1Vtu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:49:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38148 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbXK1Vtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:49:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id ED81C2F9;
	Wed, 28 Nov 2007 16:50:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D4809ACB5;
	Wed, 28 Nov 2007 16:50:06 -0500 (EST)
In-Reply-To: <20071128194919.GC11396@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 14:49:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66431>

Jeff King <peff@peff.net> writes:

> Hrm, this is going to have nasty conflicts with 'next', which already
> does the remote ref matching. I think the best way to implement this
> would probably be on top of the jk/send-pack topic in next, and add a
> new REF_STATUS_REMOTE_CHANGED status type.

I think Jeff is referring to sp/refspec-match (605b4978).

I still have doubts about having this in the update hook, as the hook is
about accepting or refusing and has never been about rewriting.

If the implementation of the svn hook were to check if you can rebase
cleanly in the update hook without actually rewriting the refs, and then
to perform the real update of the refs in post-receive or post-update
hook, that would feel much cleaner.  But the end result would be the
same as you rewrote the refs inside the update hook like your patch
does, so maybe I am worrying about conceptual cleanliness too much,
needlessly.
