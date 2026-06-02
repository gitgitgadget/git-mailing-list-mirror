Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DF3C9EE6
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391651; cv=none; b=OrHsIOR6Lgw6gl7DODujrqYYkC7NiTbrd1w9Nq0x815uDku2coMiVBoyBKBoyzrQBfNzEegoW0nDVapY//Fs0iO7cB5MOxHGIkLGl+Se000xHr/JUS3Zdmyvv4x0AY+8AU2EG/fStthPa8uihM20fT8qjQrToeUI77kg9AMdBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391651; c=relaxed/simple;
	bh=xwvCVXyCuogcKk9nzkiS1iusEioskpF/N2Ng11ZfF/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCTlnXJiBKY7ohB9j4Iy6oivQtXAyseeQpAHfLeCKiHWwrRCb54/ihwXufaxMjqdqiUD+6uxsCTSBie6KJDcbL9D2RaUNXQqbF8RxF8A4fGm2t+x1P6fuPQAdM2WRcD1XUzFH2OidHtn2rhEQ02EUaxFKzJ+B5PqBHCYJv48wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c1FnWDEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lCw55Em1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c1FnWDEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lCw55Em1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ABB64EC0702;
	Tue,  2 Jun 2026 05:14:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 02 Jun 2026 05:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780391649; x=1780478049; bh=edYlelN8Wq
	q13UTN+tVRHMDyaQ6PMZE/K9sK/8MwXhI=; b=c1FnWDEBOmuHOyfk9G6XAL8QfA
	+FmE/3WfibPxqxFUGChUSs1FYvJG3aRiFhLhOGW0Mm7OioysQqHH0+ia1Z6GlVBt
	x5HoynfKUGtvKW+zhz652HVBzu0shwp6S+xaiUbYoeVYu45MedUYVQy9VBvsJaHT
	A+yDfZpkTqBlbo/WhpmZwseKtvOeAuMtESC98rkSU8KtbHRTYfYMr/C57qiCpOGi
	xW4/oEYP2NLgY8QOSxHdI9MeokGQ7qntbNDasK1c2k4zFA5SJzholCItBsyCJwsd
	iLANU1F661rL5sylggAgRY8n/AeeiehVPsMGHyFaTCClXeaV47yCcOcomquw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780391649; x=1780478049; bh=edYlelN8Wqq13UTN+tVRHMDyaQ6PMZE/K9s
	K/8MwXhI=; b=lCw55Em1rB3QDE1N143S20Pvp/AGyjX+Cwemy9HlbS0SPzGQn/z
	yGbLkpsspaLZVRaDtm2JikcIl2huwrDS+x262I9MODOO1z+pBdf9avWJqoAqgEIa
	b/3uSreZj5rmp70Sf/rDQy7xhTOGqNSH5JXXM09bFoewaqB04Q5ZmYXGO+26o1Pz
	RvpDrsEDyBUQzztorIPxqOEvyQMk5Z+86eS93UhwhWKNLWLj8FClpvxRt1bvnmlk
	LLd+EAcecVsoBm+v6sqTQ/HPaVFQ1zQMV2Cc4C1zz7OXuP+Ceji8hnDJTmLbwx5s
	MdL5BrZn4jn6VOW6GArMOWNDtoofLHfA67A==
X-ME-Sender: <xms:4Z4ear5LxUxe5rzKrIT7BGT_TrveL5aRvjjyN_x_NQj2kGdTg3LaaA>
    <xme:4Z4eaoXrBztwtyTbwbFRzEwHqSsU0QMvXtmhUYMut8Po6pRGJx49b6CWNeQQRRAuv
    to0LdFI_uECrC3OBsNiaKKqOFZOfOVp8TaIUy_1hSg2rDAwvQSnDg>
X-ME-Received: <xmr:4Z4eav3NEulU5Te4MQycyWOdhxkEcoHkUHb9Lv_Yzkuz9YylyTdXQAiGksktLVZvSnK_iA8BHDKk9M9lnmaGbZejkclSCKZ_Tpyq>
X-ME-Proxy-Cause: dmFkZTG4swiboEQ7z9jPwzgnCwVN54TgqldhZoWjzweXlrjBU5yC+WSVrfPu2xpWci+M68
    NLuw0DQCqKwG0b9BxN2ix9KFjrPMEuiThegYoKAjYCdY0m0HEeNykXG3UuBo+/pqgAfblE
    2A/EAFRBvnibL2n3zFxptC4ZBhOnQ5EloHMbv0w5ReAvqWW+KFt29nHPEKaZjH+yHdMZMN
    rUhjOejV0GUWuixoqH0E/KJR/znIVmUCfZFRI6O5sidP45c0oKB5c7trx/i34GyhzcuG7o
    zlWidctX4Mk2sYJB8L/dCxQVX/invPnD8Bj6qWxZHhpOkt+bufmVlaWLNny2RuOfGpUPCt
    cZSCxeUoPsPwQ5PaugViqSl7CzLhIgTwxDr9jJCxlM4BrtaNp6wb4ZTuWEiFbrryXpxTd0
    jLKAqSFrT8sAjwWvw67EaRZ2tAYkgL3oyq6Zq1zVNn9Ayw3DLnxnCl62HkUG2GJxizozVB
    QFyVTyCKjCj3zq1pUysB/3QdQIfN2ESS31wwTdDhHB1CWgUEkhm2ALLVHAMUy4GO9RN5nC
    poo+oFt9r5HO8IuDrU5p48p1l41a+zZ3P54iKprg8ONNfTCnTn4sR/gO9Pm/i+Q2M7zRkh
    UXhZuVS6XdjJAnpxa0NjQWH3GKNj/wRalNFDhSiWUUdqCUfHzmgaMVtLsdog
X-ME-Proxy: <xmx:4Z4eal2GGVa7v7ZscnLRXwXygiVqw-Q69uo0VtTcGAoAQb2mBAzlvQ>
    <xmx:4Z4eai8_s4VuFlK7nj5XZevx4F3uFeFMPr7EG0EgqNeyzrL4mz8Skw>
    <xmx:4Z4eai2i-wOOniVmJ-pIFb860PzZkl_s6tLzM9BadeGX1OcGE-tc_w>
    <xmx:4Z4eav-EJ7vfxCkHgGHP8sAdCRFr1RqgPSs74b7q8xqAZbODj8Gc8Q>
    <xmx:4Z4eapgZUZc_u-6F9jaKUU_KC-xtaTyQnWDx71rNt5HEioXN3ph81Tql>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:14:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luna Schwalbe <dev@luna.gl>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: document and test `@` prefix for raw timestamps
In-Reply-To: <20260602081924.673763-2-dev@luna.gl> (Luna Schwalbe's message of
	"Tue, 2 Jun 2026 10:17:36 +0200")
References: <20260602081924.673763-2-dev@luna.gl>
Date: Tue, 02 Jun 2026 18:14:08 +0900
Message-ID: <xmqqmrxdxq1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luna Schwalbe <dev@luna.gl> writes:

> The Git internal date format `<unix-timestamp> <time-zone-offset>`
> fails to parse when the timestamp is less than 100,000,000 (fewer than
> 9 digits). This happens to avoid potential ambiguity with other date
> formats such as `YYYYMMDD`, especially when used with approxidate.
>
> To force the parser to interpret the value as a raw timestamp, it must
> be prefixed with `@` (e.g., `@0 +0000`). This behavior was introduced
> in 2c733fb24c10a9d7aacc51f956bf9b7881980870 (parse_date(): '@' prefix
> forces git-timestamp, 2012-02-02) but was never documented.
>
> Document the `@` prefix in `Documentation/date-formats.adoc` to make
> this behavior explicit. Also add test cases to `t/t0006-date.sh` to
> verify and demonstrate the difference between prefixed and unprefixed
> small timestamps (e.g., `@2000` vs `2000`).
>
> Signed-off-by: Luna Schwalbe <dev@luna.gl>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> ---
> Fixed the asciidoc formatting, removed parens around YYYYMMDD example.

Looks good.

Next time, when sending a [v2] patch of a singleton topic,
please make it a reply e-mail message to the [v1] message.  That
would make it easier to see how patches evolved in mailing list
archive.  E.g., https://lore.kernel.org/git/$message_id would show
both rounds (including the review comments they received) on the
same page.

Will queue.  Thanks.



>  Documentation/date-formats.adoc |  5 +++++
>  t/t0006-date.sh                 | 11 +++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/date-formats.adoc b/Documentation/date-formats.adoc
> index e24517c49..330424b2b 100644
> --- a/Documentation/date-formats.adoc
> +++ b/Documentation/date-formats.adoc
> @@ -9,6 +9,11 @@ Git internal format::
>  	`<unix-timestamp>` is the number of seconds since the UNIX epoch.
>  	`<time-zone-offset>` is a positive or negative offset from UTC.
>  	For example CET (which is 1 hour ahead of UTC) is `+0100`.
> ++
> +It is safer to prepend the `<unix-timestamp>` with `@` (e.g.,
> +`@0 +0000`), which forces Git to interpret it as a raw timestamp. This
> +is required for values less than 100,000,000 (which have fewer than 9
> +digits) to avoid confusion with other date formats like `YYYYMMDD`.
>  
>  RFC 2822::
>  	The standard date format as described by RFC 2822, for example
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 53ced36df..8b4e1870b 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -138,6 +138,13 @@ check_parse '1969-12-31 23:59:59 Z' bad
>  check_parse '1969-12-31 23:59:59 +11' bad
>  check_parse '1969-12-31 23:59:59 -11' bad
>  
> +# pathologically small timestamps requiring `@` prefix
> +check_parse '@0 +0000' '1970-01-01 00:00:00 +0000'
> +check_parse '@99999999 +0000' '1973-03-03 09:46:39 +0000'
> +check_parse '99999999 +0000' bad
> +check_parse '@100000000 +0000' '1973-03-03 09:46:40 +0000'
> +check_parse '100000000 +0000' '1973-03-03 09:46:40 +0000'
> +
>  REQUIRE_64BIT_TIME=HAVE_64BIT_TIME
>  check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
>  check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
> @@ -195,6 +202,10 @@ check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
>  check_approxidate '2008-12-01' '2008-12-01 19:20:00'
>  check_approxidate '2009-12-01' '2009-12-01 19:20:00'
>  
> +# ambiguous raw timestamp
> +check_approxidate '2000 +0000' '2000-08-30 19:20:00'
> +check_approxidate '@2000 +0000' '1970-01-01 00:33:20'
> +
>  check_date_format_human() {
>  	t=$(($GIT_TEST_DATE_NOW - $1))
>  	echo "$t -> $2" >expect
