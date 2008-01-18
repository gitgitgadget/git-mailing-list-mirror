From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998 characters
Date: Fri, 18 Jan 2008 02:08:24 -0800
Message-ID: <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
References: <20080117153252.GD2816@coredump.intra.peff.net>
	<1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
	<47905F70.5090003@viscovery.net>
	<4790746D.1000502@users.sourceforge.net>
	<47907914.6000105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Piatyszek <ediap@users.sourceforge.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFo9u-0000Ap-3z
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYARKIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYARKIl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:08:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYARKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:08:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFD1602F;
	Fri, 18 Jan 2008 05:08:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 581E7602E;
	Fri, 18 Jan 2008 05:08:31 -0500 (EST)
In-Reply-To: <47907914.6000105@viscovery.net> (Johannes Sixt's message of
	"Fri, 18 Jan 2008 11:01:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70988>

Johannes Sixt <j.sixt@viscovery.net> writes:

> You are right here. My thought was that even though the recipient gets a
> broken patch, he would be able to fix it up. This may be acceptable for
> peer-to-peer communication, but not for a development style that involves
> many recipients.
>
> Then git-format-patch and log-family with --pretty=email -p could warn
> about these candidates-to-be-broken patches.

I'd rather not, unless it is explicitly asked for by a separate
command line option.  Transferring over SMTP is not the only
(nor even primary) use of format-patch output.

On the other hand, git-send-email _is_ all about SMTP transfer.
Perhaps a loop over input files upfront to check the line length
limit, and warn if there are suspiciously long lines even before
sending the first piece of e-mail out, would be a reasonable
approach.
