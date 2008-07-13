From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 13:17:57 -0700
Message-ID: <7vskudr11m.fsf@gitster.siamese.dyndns.org>
References: <20080710170735.4c5b237a@linux360.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ryan@michonline.com, git@vger.kernel.org
To: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI82G-0001q5-Fd
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbYGMUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYGMUSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:18:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbYGMUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:18:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAAAC2E9D5;
	Sun, 13 Jul 2008 16:18:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 058832E9D4; Sun, 13 Jul 2008 16:18:01 -0400 (EDT)
In-Reply-To: <20080710170735.4c5b237a@linux360.ro>
 (eduard.munteanu@linux360.ro's message of "Thu, 10 Jul 2008 17:07:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD53A7E4-5118-11DD-BAE4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88328>

Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3564419..53539cf 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -741,6 +747,10 @@ X-Mailer: git-send-email $gitversion
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> +	} elsif (defined $export_file) {
> +		my $mbox_from = "From $raw_from $date";
> +		$message =~ s/^(>{0,})From/>$1From/m;
> +		print $out "$mbox_from\n$header\n$message";

Sorry, but I am scratching my head here.  Shouldn't this "bare From
munging" be like this instead?

		$message =~ s/^From />From /m;
