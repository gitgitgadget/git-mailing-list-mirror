From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Sun, 07 Jun 2009 23:57:01 -0700
Message-ID: <7vhbyr8b7m.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<7v7hznaaji.fsf@alter.siamese.dyndns.org>
	<200906080747.18233.markus.heidelberg@web.de>
	<200906080837.31548.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jun 08 08:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDYn9-0007gk-Gs
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 08:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbZFHG5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 02:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbZFHG5A
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 02:57:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52158 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZFHG5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 02:57:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608065702.NNXR20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 02:57:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Jx21c0014aMwMQ03Jx2TK; Mon, 08 Jun 2009 02:57:02 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=y8DKxdtP650A:10 a=Ze1UVqwS1wEA:10
 a=A1X0JdhQAAAA:8 a=9whKkZ9wrTmWbDE0AjsA:9 a=g6YOQahDrlq-sPDAQ7LM8-0BA3YA:4
 a=5N_Nib3jKbIA:10 a=XTUYKXyG0EEA:10 a=5KVauyKsRKMA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
In-Reply-To: <200906080837.31548.markus.heidelberg@web.de> (Markus Heidelberg's message of "Mon\, 8 Jun 2009 08\:37\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121039>

Markus Heidelberg <markus.heidelberg@web.de> writes:

>> What can be done to make the test better?
>
> Is this change sufficient? Dumping the stdout into a file and grepping
> this.

Yup, that is better for test scripts.

>
>
>  t/t9001-send-email.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index ce26ea4..8f810ab 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -621,4 +621,15 @@ test_expect_success 'in-reply-to but no threading' '
>  	grep "In-Reply-To: <in-reply-id@example.com>"
>  '
>  
> +test_expect_failure 'threading but no chain-reply-to' '
> +	git send-email \
> +		--dry-run \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--thread \
> +		--nochain-reply-to \
> +		$patches $patches >stdout &&
> +	grep "In-Reply-To: " stdout
> +'
> +
>  test_done
> -- 
> 1.6.3.2.220.gb421
