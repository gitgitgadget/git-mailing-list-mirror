From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/27] update-ref --stdin: Harmonize error messages
Date: Mon, 31 Mar 2014 14:51:48 -0700
Message-ID: <xmqqy4zq2g0b.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:52:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk7Y-0000ZT-VV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbaCaVvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:51:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbaCaVvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:51:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8323079006;
	Mon, 31 Mar 2014 17:51:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JaZRF4Nk8tqV+8lzgJBRiHV6WSY=; b=qR0HKg
	CD55mDNWi2nopo/UXj7F1v5YIo0vv7uaucbHF76QqTBS8UT5OWwczBXbParfshqA
	1SyaBCneePjqa9+CYsmdpbPUv7wQHo/30xzEZbflHGhY8PhBN8D2cwbPgqkyTZWE
	Lc/wqO3xL/7/ghMhyrey6Z+miQNGu1qBeH8AA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U65JJM5ZZ4RWIQAEjtoPH9vL9FUFx+l5
	8ofH3JYK9BhK499SF39fRuaxw2inKdt06MUYoESSupEpDHocgEnfttUzQIz2MI7N
	YNtvGForh1o1BoJLDikdP6HMQKZK1rlBDETUCDu6jNkKz5KC9CLIZ1jNGGDjr+mB
	G9tIf/NRbJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B0D979005;
	Mon, 31 Mar 2014 17:51:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EBA079003;
	Mon, 31 Mar 2014 17:51:49 -0400 (EDT)
In-Reply-To: <1395683820-17304-19-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A98C585A-B91E-11E3-B1C3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245546>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Make (most of) the error messages for invalid input have the same
> format [1]:
>
>     $COMMAND [SP $REFNAME]: $MESSAGE
>
> Update the tests accordingly.
>
> [1] A few error messages are left with their old form, because
>     $COMMAND and $REFNAME aren't passed all the way down the call
>     stack.  Maybe those sites should be changed some day, too.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Up to this point, modulo nits that have been pointed out separately,
the series looked reasonably well done.

Thanks.

>  builtin/update-ref.c  | 24 ++++++++++++------------
>  t/t1400-update-ref.sh | 32 ++++++++++++++++----------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index b49a5b0..bbc04b2 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -202,19 +202,19 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  
>  	update->ref_name = parse_refname(input, &next);
>  	if (!update->ref_name)
> -		die("update line missing <ref>");
> +		die("update: missing <ref>");
>  
>  	if (parse_next_sha1(input, &next, update->new_sha1,
>  			    "update", update->ref_name,
>  			    PARSE_SHA1_ALLOW_EMPTY))
> -		die("update %s missing <newvalue>", update->ref_name);
> +		die("update %s: missing <newvalue>", update->ref_name);
>  
>  	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
>  					    "update", update->ref_name,
>  					    PARSE_SHA1_OLD);
>  
>  	if (*next != line_termination)
> -		die("update %s has extra input: %s", update->ref_name, next);
> +		die("update %s: extra input: %s", update->ref_name, next);
>  
>  	return next;
>  }
> @@ -227,17 +227,17 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  
>  	update->ref_name = parse_refname(input, &next);
>  	if (!update->ref_name)
> -		die("create line missing <ref>");
> +		die("create: missing <ref>");
>  
>  	if (parse_next_sha1(input, &next, update->new_sha1,
>  			    "create", update->ref_name, 0))
> -		die("create %s missing <newvalue>", update->ref_name);
> +		die("create %s: missing <newvalue>", update->ref_name);
>  
>  	if (is_null_sha1(update->new_sha1))
> -		die("create %s given zero <newvalue>", update->ref_name);
> +		die("create %s: zero <newvalue>", update->ref_name);
>  
>  	if (*next != line_termination)
> -		die("create %s has extra input: %s", update->ref_name, next);
> +		die("create %s: extra input: %s", update->ref_name, next);
>  
>  	return next;
>  }
> @@ -250,19 +250,19 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
>  
>  	update->ref_name = parse_refname(input, &next);
>  	if (!update->ref_name)
> -		die("delete line missing <ref>");
> +		die("delete: missing <ref>");
>  
>  	if (parse_next_sha1(input, &next, update->old_sha1,
>  			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
>  		update->have_old = 0;
>  	} else {
>  		if (is_null_sha1(update->old_sha1))
> -			die("delete %s given zero <oldvalue>", update->ref_name);
> +			die("delete %s: zero <oldvalue>", update->ref_name);
>  		update->have_old = 1;
>  	}
>  
>  	if (*next != line_termination)
> -		die("delete %s has extra input: %s", update->ref_name, next);
> +		die("delete %s: extra input: %s", update->ref_name, next);
>  
>  	return next;
>  }
> @@ -275,7 +275,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  
>  	update->ref_name = parse_refname(input, &next);
>  	if (!update->ref_name)
> -		die("verify line missing <ref>");
> +		die("verify: missing <ref>");
>  
>  	if (parse_next_sha1(input, &next, update->old_sha1,
>  			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
> @@ -286,7 +286,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  	}
>  
>  	if (*next != line_termination)
> -		die("verify %s has extra input: %s", update->ref_name, next);
> +		die("verify %s: extra input: %s", update->ref_name, next);
>  
>  	return next;
>  }
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 1db0689..48ccc4d 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -371,7 +371,7 @@ test_expect_success 'stdin fails on junk after quoted argument' '
>  test_expect_success 'stdin fails create with no ref' '
>  	echo "create " >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: create line missing <ref>" err
> +	grep "fatal: create: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin fails create with bad ref name' '
> @@ -383,19 +383,19 @@ test_expect_success 'stdin fails create with bad ref name' '
>  test_expect_success 'stdin fails create with no new value' '
>  	echo "create $a" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: create $a missing <newvalue>" err
> +	grep "fatal: create $a: missing <newvalue>" err
>  '
>  
>  test_expect_success 'stdin fails create with too many arguments' '
>  	echo "create $a $m $m" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: create $a has extra input:  $m" err
> +	grep "fatal: create $a: extra input:  $m" err
>  '
>  
>  test_expect_success 'stdin fails update with no ref' '
>  	echo "update " >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: update line missing <ref>" err
> +	grep "fatal: update: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin fails update with bad ref name' '
> @@ -407,19 +407,19 @@ test_expect_success 'stdin fails update with bad ref name' '
>  test_expect_success 'stdin fails update with no new value' '
>  	echo "update $a" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: update $a missing <newvalue>" err
> +	grep "fatal: update $a: missing <newvalue>" err
>  '
>  
>  test_expect_success 'stdin fails update with too many arguments' '
>  	echo "update $a $m $m $m" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: update $a has extra input:  $m" err
> +	grep "fatal: update $a: extra input:  $m" err
>  '
>  
>  test_expect_success 'stdin fails delete with no ref' '
>  	echo "delete " >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: delete line missing <ref>" err
> +	grep "fatal: delete: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin fails delete with bad ref name' '
> @@ -431,13 +431,13 @@ test_expect_success 'stdin fails delete with bad ref name' '
>  test_expect_success 'stdin fails delete with too many arguments' '
>  	echo "delete $a $m $m" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: delete $a has extra input:  $m" err
> +	grep "fatal: delete $a: extra input:  $m" err
>  '
>  
>  test_expect_success 'stdin fails verify with too many arguments' '
>  	echo "verify $a $m $m" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: verify $a has extra input:  $m" err
> +	grep "fatal: verify $a: extra input:  $m" err
>  '
>  
>  test_expect_success 'stdin fails option with unknown name' '
> @@ -532,7 +532,7 @@ test_expect_success 'stdin create ref fails with bad new value' '
>  test_expect_success 'stdin create ref fails with zero new value' '
>  	echo "create $c " >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: create $c given zero <newvalue>" err &&
> +	grep "fatal: create $c: zero <newvalue>" err &&
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> @@ -556,7 +556,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
>  test_expect_success 'stdin delete ref fails with zero old value' '
>  	echo "delete $a " >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: delete $a given zero <oldvalue>" err &&
> +	grep "fatal: delete $a: zero <oldvalue>" err &&
>  	git rev-parse $m >expect &&
>  	git rev-parse $a >actual &&
>  	test_cmp expect actual
> @@ -697,7 +697,7 @@ test_expect_success 'stdin -z fails on unknown command' '
>  test_expect_success 'stdin -z fails create with no ref' '
>  	printf $F "create " >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: create line missing <ref>" err
> +	grep "fatal: create: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin -z fails create with bad ref name' '
> @@ -721,7 +721,7 @@ test_expect_success 'stdin -z fails create with too many arguments' '
>  test_expect_success 'stdin -z fails update with no ref' '
>  	printf $F "update " >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: update line missing <ref>" err
> +	grep "fatal: update: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin -z fails update with too few args' '
> @@ -765,7 +765,7 @@ test_expect_success 'stdin -z fails update with too many arguments' '
>  test_expect_success 'stdin -z fails delete with no ref' '
>  	printf $F "delete " >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: delete line missing <ref>" err
> +	grep "fatal: delete: missing <ref>" err
>  '
>  
>  test_expect_success 'stdin -z fails delete with bad ref name' '
> @@ -868,7 +868,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
>  test_expect_success 'stdin -z create ref fails with empty new value' '
>  	printf $F "create $c" "" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: create $c missing <newvalue>" err &&
> +	grep "fatal: create $c: missing <newvalue>" err &&
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> @@ -892,7 +892,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
>  test_expect_success 'stdin -z delete ref fails with zero old value' '
>  	printf $F "delete $a" "$Z" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: delete $a given zero <oldvalue>" err &&
> +	grep "fatal: delete $a: zero <oldvalue>" err &&
>  	git rev-parse $m >expect &&
>  	git rev-parse $a >actual &&
>  	test_cmp expect actual
