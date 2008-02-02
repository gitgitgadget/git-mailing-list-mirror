From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2][Perlers?] git-send-email: SIG{TERM,INT} handlers
Date: Sat, 02 Feb 2008 13:31:32 -0800
Message-ID: <7vprvf11vv.fsf@gitster.siamese.dyndns.org>
References: <7vve586tbz.fsf@gitster.siamese.dyndns.org>
	<1201925161-9864-1-git-send-email-mfwitten@mit.edu>
	<1201925161-9864-2-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 02 22:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLPyI-0006gP-AW
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 22:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763769AbYBBVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 16:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763622AbYBBVbs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 16:31:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbYBBVbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 16:31:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 80765546E;
	Sat,  2 Feb 2008 16:31:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D981546D;
	Sat,  2 Feb 2008 16:31:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72304>

Michael Witten <mfwitten@MIT.EDU> writes:

> +# Handle Uncouth Termination
> +sub signal_handler{
> +	
> +	# Make text normal
> +	print color("reset"), "\n";
> +
> +	# SMTP password masked
> +	system "stty echo";
> +
> +	# tmp files from --compose
> +	if (-e $compose_filename) {
> +		print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
> +	}
> +	if (-e ($compose_filename . ".final")) {
> +		print "'$compose_filename.final' contains the composed email.\n"
> +	}
> +
> +	exit;
> +};
> +
> +$SIG{TERM} = \&signal_handler;
> +$SIG{INT}  = \&signal_handler;
> +
>  # Begin by accumulating all the variables (defined above), that we will end up
>  # needing, first, from the command line:

Now I think this patch (except the part about "stty echo") makes
sense, although I did not try killing a send-email session with
signals myself.

Success stories, people?
