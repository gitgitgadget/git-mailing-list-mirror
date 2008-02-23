From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: Replace sed's non-standard 'Q' by standard 'q'
Date: Sat, 23 Feb 2008 10:27:10 -0800
Message-ID: <7vy79b34w1.fsf@gitster.siamese.dyndns.org>
References: <12037561161987-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:28:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSz6Q-0008Nm-2K
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbYBWS10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 13:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbYBWS10
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:27:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbYBWS1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 13:27:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CCBE11C5;
	Sat, 23 Feb 2008 13:27:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1E56111C3; Sat, 23 Feb 2008 13:27:19 -0500 (EST)
In-Reply-To: <12037561161987-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Sat, 23 Feb 2008 09:41:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74835>

Steffen Prohaska <prohaska@zib.de> writes:

> This commit should be applied on top of db/cover-letter.
>
> -- >8 --
>
> This commit avoids sed's 'Q' operator.  The Open Group's sed
> man page [1] does not mention 'Q'.  sed on Mac OS X 10.4
> does not accept Q.  'q' is sufficient for our purpose.

Thanks.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index a39e786..16aa99d 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -95,7 +95,7 @@ test_expect_success 'extra headers' '
>  	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>
>  " &&
>  	git format-patch --stdout master..side > patch2 &&
> -	sed -e "/^$/Q" patch2 > hdrs2 &&
> +	sed -e "/^$/q" patch2 > hdrs2 &&
>  	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs2 &&
>  	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs2
>  	

I usually try to be pretty careful about these kind of things,
but these somehow slipped in.  Changing them to 'q' means the
output will now have an additional blank line at the end, but
that would not affect the result the later tests inspect, so
it's a good change.
