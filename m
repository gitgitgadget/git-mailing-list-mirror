From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] t4052: Add tests to illustrate issues with
 restrictive COLUMNS
Date: Mon, 16 Apr 2012 11:48:06 -0700
Message-ID: <7v7gxfv7h5.fsf@alter.siamese.dyndns.org>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
 <1334573095-32286-6-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:48:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqyI-0001MI-QT
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 20:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab2DPSsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 14:48:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2DPSsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 14:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A25628C;
	Mon, 16 Apr 2012 14:48:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=gLOyI4/yJLobjHClexRh2YeTCkA=; b=LF4yZuRXdrf8m43pSAgg
	7ScecxgCEVsoE10Szqq1XJcCuOEnKT8T+jei/GDjeckmc/ltHxGchUy/5PQzSrqp
	08kngi+iS8IyOLXRDmHRMBrA5INCfcZNOj8+jXt4CxKGlWA6/fESS2BHp4PRJzM9
	cWZQF8IC9U0ZMWcKMo5Fzyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NzCx1+a9AS4BieMbrBQXiK1Q35aUFCNZoB9ohLFTMBpAJo
	/Qe9YjC8RrkUQmKOjhGjurwunvLzFt6eNVfEt/O4PFMihk9GKIWjAe87BHx181c8
	pvYCYMs0MZyh0Fvu+NDDVacv/e8o4DJIZ/t/BnA0xAV8MBnxJjaOO2jiSmr00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1182628B;
	Mon, 16 Apr 2012 14:48:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA5D8628A; Mon, 16 Apr 2012
 14:48:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B50C8626-87F4-11E1-A7CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195677>

Lucian Poston <lucian.poston@gmail.com> writes:

> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---

Sorry, the patch text itself does not tell me what it wants to "illustate"
at all.

I _guess_ that you are saying that the output for expect1 and
expect1-graph should be limited to very narrow width, not like the
humongous output like we see in the added test vector, and it will be
fixed with your patch 6/7.

If that is the case, please structure this part of the series like this:

	5/7: add test vector to illustrate what the correct output should
	     be, but mark the test with "test_expect_failure".

        6/7: update the code to fix it, and flip the "test_expect_failure"
             in 5/7 to "test_expect_success".

And 7/7 will become unneeded.

Thanks.

>  t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index d748e5e..6cac95b 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -284,6 +284,34 @@ respects expect200 show --stat
>  respects expect200 log -1 --stat
>  EOF
>  
> +cat >expect1 <<'EOF'
> + ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ++
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +EOF
> +cat >expect1-graph <<'EOF'
> +|  ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ++
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +EOF
> +while read verb expect cmd args
> +do
> +	test_expect_success "$cmd $verb prefix greater than COLUMNS (big change)" '
> +		COLUMNS=1 git $cmd $args >output
> +		grep " | " output >actual &&
> +		test_cmp "$expect" actual
> +	'
> +
> +	test "$cmd" != diff || continue
> +
> +	test_expect_success "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
> +		COLUMNS=1 git $cmd $args --graph >output
> +		grep " | " output >actual &&
> +		test_cmp "$expect-graph" actual
> +	'
> +done <<\EOF
> +ignores expect80 format-patch -1 --stdout
> +respects expect1 diff HEAD^ HEAD --stat
> +respects expect1 show --stat
> +respects expect1 log -1 --stat
> +EOF
> +
>  cat >expect <<'EOF'
>   abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  EOF
