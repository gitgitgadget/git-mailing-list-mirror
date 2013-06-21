From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/16] t/t5505-remote: test push-refspec in branches-file
Date: Fri, 21 Jun 2013 15:08:32 -0700
Message-ID: <7va9mjktgf.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9VX-0004sO-UT
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946197Ab3FUWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:08:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946172Ab3FUWIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:08:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 197982A604;
	Fri, 21 Jun 2013 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tgE52vRG25wDs36Me9KI0wblies=; b=W3/hPd
	TE9EgGy9I9i2PrwI+TK2BiL100wuZ+9fUAB9Yg0x+aT/9k53Q9uS9GTro4/NMYw6
	DoegU7V4coYVSjqjOXpXZ7XO4aVPBy4M3bDzGbkNVeik/09DGe9n46eF+a5ACSc6
	3B3W7xWQAfU3Re+GOmeyOH8TP+Ew7kJhTcxxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qr4gfAxPKgE+iozqjfGg5Tul+2ZaZATx
	AchMK4Gr5cWgn3ah49P5uU1TkfQ9wcGnyo/ZU/KRBW+rjazV8nryrXoMbbjDTemk
	AurcPnN0GmsyNvGVEdwiM0ynecbT7EYq6nrc34uqPhGJQOLPR7/xjM4mgUifcG3W
	0M5PRXkZOhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3ED2A603;
	Fri, 21 Jun 2013 22:08:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 690BD2A600;
	Fri, 21 Jun 2013 22:08:34 +0000 (UTC)
In-Reply-To: <1371813160-4200-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D943F36-DABF-11E2-B8EC-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228661>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The test "migrate a remote from named file in $GIT_DIR/branches" reads
> the branches-file, but only checks that the url and fetch-refspec are
> set correctly.  Check that the push-refspec is also set correctly.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5505-remote.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 4d5810f..38c62ec 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -698,7 +698,8 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
>  		git remote rename origin origin &&
>  		! test -f .git/branches/origin &&
>  		test "$(git config remote.origin.url)" = "$origin_url" &&
> -		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
> +		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
> +		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"

OK.  That is an ancient "Cogito-compatible push" which might not be
a sensible setting, but there is no point changing it now, and there
is a value in making sure it will stay working the way it has.

Good.


>  	)
>  '
