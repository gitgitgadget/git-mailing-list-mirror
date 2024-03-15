Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6C4D13B
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523338; cv=none; b=RZnr16LYkaWadpSwL84rDI6AFuBJ/0LqAUGPeDQdquZzKQPB5GE7ewciW0XZIlZYt0k+HLmn0CcOjALt1mBq48bBAgwyzn0fktujWD2eRJHdQbAj0YOJoSybaeRqlnRrFNylZ8MBH/6jnAvXl2rIKfa8rhP/2nER9DjBz41/fPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523338; c=relaxed/simple;
	bh=DaVaIv3OfAK66TNqk9hPwZM0W8fGCumd/jZUoIqlzn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEJCEVJyE0pQTdiaZ/svq4G22JDln4nIsnxSlaxausi9JMDwURvwd9USS6DHHEPAf3OCTrPZ0DSk1oFtspuQ6NHU9FG1JKBZsCuVlcepLRcPQ2anRVtzOJ+6OQp0LSV99babD4BbswIQLrhjM7pPOyJQFg1hp2gezuAUacp7BjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v5sgpT33; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v5sgpT33"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 810C31E9269;
	Fri, 15 Mar 2024 13:22:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DaVaIv3OfAK66TNqk9hPwZM0W8fGCumd/jZUoI
	qlzn8=; b=v5sgpT33Mh8zCi1zWdkqG8GlfRs1J/cP8kh1HmFkOGp+WsdRera8aI
	splcQTDLIfePfZPDnfa2XuOivPKjIto3a42PsvlSzFNvDhxIaPc+/pRnpKW3pLs1
	3UnkRQTZmd0LQu2wOp6q7v+8SfSxgL9v3qPNxEHxwUFFZmv7wOuxU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76FE71E9268;
	Fri, 15 Mar 2024 13:22:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7B861E9267;
	Fri, 15 Mar 2024 13:22:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Christian Couder [ ]" <chriscool@tuxfamily.org>,
  "Emily Shaffer [ ]" <nasamuffin@google.com>,  "Josh Steadmon [ ]"
 <steadmon@google.com>,  "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
  "Christian Couder [ ]" <christian.couder@gmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 3/5] format_trailer_info(): append newline for
 non-trailer lines
In-Reply-To: <259a4edcfa5138053255dbade411ef151617bb1b.1710485706.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 15 Mar 2024 06:55:03
	+0000")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
	<259a4edcfa5138053255dbade411ef151617bb1b.1710485706.git.gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 10:22:13 -0700
Message-ID: <xmqqfrwrquka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9112758C-E2F0-11EE-A24A-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This wraps up the preparatory refactors to unify the trailer formatters.
> ...
> The test suite can pass again without the need to hide failures
> with *_failure, so flip the affected test cases back to *_success. Now,
> format_trailer_info() is in better shape to supersede format_trailers(),
> which we'll do in the next commit.

Nicely done.  Queued.

>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  t/t4205-log-pretty-formats.sh | 12 ++++++------
>  t/t6300-for-each-ref.sh       | 16 ++--------------
>  trailer.c                     |  5 +++--
>  3 files changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 339e0c892ef..e3d655e6b8b 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -675,7 +675,7 @@ test_expect_success '%(trailers:only=no,only=true) shows only "key: value" trail
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure '%(trailers:unfold) unfolds trailers' '
> +test_expect_success '%(trailers:unfold) unfolds trailers' '
>  	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
>  	{
>  		unfold <trailers &&
> @@ -737,7 +737,7 @@ test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
> +test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
>  	git log --no-walk --pretty="format:%(trailers:key=Acked-by,only=no)" >actual &&
>  	{
>  		echo "Acked-by: A U Thor <author@example.com>" &&
> @@ -752,7 +752,7 @@ test_expect_success '%(trailers:key) without value is error' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure '%(trailers:keyonly) shows only keys' '
> +test_expect_success '%(trailers:keyonly) shows only keys' '
>  	git log --no-walk --pretty="format:%(trailers:keyonly)" >actual &&
>  	test_write_lines \
>  		"Signed-off-by" \
> @@ -774,7 +774,7 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure '%(trailers:valueonly) shows only values' '
> +test_expect_success '%(trailers:valueonly) shows only values' '
>  	git log --no-walk --pretty="format:%(trailers:valueonly)" >actual &&
>  	test_write_lines \
>  		"A U Thor <author@example.com>" \
> @@ -813,7 +813,7 @@ test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'pretty format %(trailers:key_value_separator) changes key-value separator' '
> +test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
>  	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00)X" >actual &&
>  	(
>  		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
> @@ -824,7 +824,7 @@ test_expect_failure 'pretty format %(trailers:key_value_separator) changes key-v
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
> +test_expect_success 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
>  	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00,unfold)X" >actual &&
>  	(
>  		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2688dcc7b9e..eb6c8204e8b 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1446,19 +1446,7 @@ test_trailer_option () {
>  	'
>  }
>  
> -# Just like test_trailer_option, but expect failure instead of success.
> -test_trailer_option_expect_failure () {
> -	title=$1 option=$2
> -	cat >expect
> -	test_expect_failure "$title" '
> -		git for-each-ref --format="%($option)" refs/heads/main >actual &&
> -		test_cmp expect actual &&
> -		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
> -		test_cmp expect actual
> -	'
> -}
> -
> -test_trailer_option_expect_failure '%(trailers:unfold) unfolds trailers' \
> +test_trailer_option '%(trailers:unfold) unfolds trailers' \
>  	'trailers:unfold' <<-EOF
>  	$(unfold <trailers)
>  
> @@ -1542,7 +1530,7 @@ test_trailer_option '%(trailers:key=foo,unfold) properly unfolds' \
>  
>  	EOF
>  
> -test_trailer_option_expect_failure '%(trailers:key=foo,only=no) also includes nontrailer lines' \
> +test_trailer_option '%(trailers:key=foo,only=no) also includes nontrailer lines' \
>  	'trailers:key=Signed-off-by,only=no' <<-EOF
>  	Signed-off-by: A U Thor <author@example.com>
>  	$(grep patch.description <trailers)
> diff --git a/trailer.c b/trailer.c
> index 2c0dd8ac829..fe8b0819d55 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1124,9 +1124,10 @@ static void format_trailer_info(const struct process_trailer_options *opts,
>  				strbuf_addbuf(out, opts->separator);
>  			}
>  			strbuf_addstr(out, item->value);
> -			if (opts->separator) {
> +			if (opts->separator)
>  				strbuf_rtrim(out);
> -			}
> +			else
> +				strbuf_addch(out, '\n');
>  		}
>  	}
>  }
