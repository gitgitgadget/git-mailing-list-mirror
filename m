From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a second testcase for handling invalid
 strategies in git-merge
Date: Tue, 29 Jul 2008 16:42:53 -0700
Message-ID: <7vhca89s02.fsf@gitster.siamese.dyndns.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
 <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org> <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org> <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org> <f8e5afe347c194013ffd104b196a19a37d762f9b.1217372486.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyrO-0006SM-Ul
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYG2XnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYG2XnA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:43:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYG2Xm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:42:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D30E94208F;
	Tue, 29 Jul 2008 19:42:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1DAD04208B; Tue, 29 Jul 2008 19:42:55 -0400 (EDT)
In-Reply-To: <f8e5afe347c194013ffd104b196a19a37d762f9b.1217372486.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Wed, 30 Jul 2008 01:17:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 133C5092-5DC8-11DD-9776-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90709>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This one tests '-s index' which is interesting because git-merge-index
> is an existing git command but it is not a valid strategy.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  t/t7600-merge.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 5eeb6c2..0329aee 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -230,6 +230,10 @@ test_expect_success 'test option parsing' '
>  	test_must_fail git merge
>  '
>  
> +test_expect_success 'reject non-strategy with a git-merge-foo name' '
> +	test_must_fail git merge -s index c1
> +'
> +

True, but with the old code that might blindly have executed
git-merge-index the test would also have failed, and you would want to
tell two cases apart, wouldn't you?
