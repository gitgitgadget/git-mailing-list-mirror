From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git push": tellme-more protocol extension
Date: Thu, 20 Mar 2008 21:24:18 -0700
Message-ID: <7vy78cu2kt.fsf@gitster.siamese.dyndns.org>
References: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org>
 <20080321023303.GE1613@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYoY-0004l0-S3
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYCUEY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYCUEY3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:24:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbYCUEY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:24:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25BF1217C;
	Fri, 21 Mar 2008 00:24:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8270F217B; Fri, 21 Mar 2008 00:24:24 -0400 (EDT)
In-Reply-To: <20080321023303.GE1613@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 20 Mar 2008 22:33:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77705>

Jeff King <peff@peff.net> writes:

>   2. This can actually be _more_ network intensive than your proposal.

I do not think this matters much in practice.  If you have tons of refs on
_your_ side to matter, some of them would be tags that are known to both
ends.  The only case it really is troublesome is when the sender does not
know _any_ of the refs the receiver presented to it.

In the illustration in the message you are responding to, if the commit A
was tagged at the shared repository when two developers cloned, it does
not matter if C is unknown to the second pusher.

So a potential improvement might be to ask for "tellme-more" only if we do
not know any of the refs the receiver showed us; my patch does it if there
is at least one unknown instead.
