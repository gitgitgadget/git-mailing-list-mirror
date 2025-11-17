Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA18335577
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405320; cv=none; b=dmrijae6mGgmgJRgnC9YXPPL0EMKWEGAaKDkMwG7GH/LdKZHjy91WKwHJKD4BJxIMFY6LHWo3rbtlnUa2bqD31CSOo1yGO32cAsqmegW1b3lsOSK2GbW3bRHkOBJbSFdL6Z9vHL0fS3GhG9b4B8tsIMSLQNsQNYJ7NPXqOfpYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405320; c=relaxed/simple;
	bh=yUxPBCO0nRUTZM02H2ktRWdYABmUA39QGdlUb0q857E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=En29PU4bpPTOkIpD61CaOBkwD1QUzDfcxF168ZYw3ldx/qQ74z1eB4Qj+1yFc61Ms4JOMqaVtPgxrSVmePPXI5kpbZzHgB8zywkj0eDA16WJoSb3BDV0AMy3mb3hJoOvgSd6TYv7CiBBTJoRmmQhcYkliZcxDuXTyR4cUgldAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jMi1Lh6G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pco3L0ZI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jMi1Lh6G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pco3L0ZI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F21514001DF;
	Mon, 17 Nov 2025 13:48:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 13:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763405316; x=1763491716; bh=CfnO8Uhesf
	JumNApDoc2Ho4+s0fFXApENfRjGbr7B20=; b=jMi1Lh6GNXIY+TgSooSRZmzpSd
	n0U+Yyxl83xoMI6fMUoI2nr2iPk969VQJuwSg/cIAFk7/uubm6aWbq1RjrCxVytn
	byxqSHbU5O+CqBstokF9quHBD8bwJWfGrzx4VBBep9rqSKc9GoD1cFBBsO+Xar2s
	U9m4Klv86dfMDhit+LkCFjdkrBdltGvHEp2ZITnZnSo3kOYMZfw3JJbiCJtxkLh2
	5P1w/iDIcNYdZwff/r2t7yVDGiMCyU3FkpA0Wn8ZzdwfgeUBwyBgTtTnpV5x8tbn
	ermbfQd6Gd0bJQa3hn1P79xYJLAFFj+UB/iV4jhPJQVn1YDuoueaLQGTp8nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763405316; x=1763491716; bh=CfnO8UhesfJumNApDoc2Ho4+s0fFXApENfR
	jGbr7B20=; b=pco3L0ZIGmHK+XMYybdseFpw9NwGM00MCG6/r5LCU6G8gRfy2eX
	9+aZBuIzD6BQTjL4YNVQuqCOFEMnae0/zafO+yqbykLpM4gitTjdeZHWeO5HoCK9
	f7LKdyE3EIguAhvovtZJAhiEPOE9ieVx/6jGnR0+FSFPZtfDVWiqs6223HB8yLdW
	jd2tL9rJUncrZH+1tjJieYyLF9WvxTgc9Gwdg/SOsT0ngKPjnDaS7MJwNFpEeLdL
	i8shvhFUjFIkTyMofcP6+Aa5kt5W+2AafbNySnJgwTsCOsfOjfgHhpXJ4O0kpQRB
	VuAQn7ciZGoluKG2zADStxZ7y6nQcJTjl5g==
X-ME-Sender: <xms:A24babc47g2fmI0PL96lVayW7Rf3eCA7p0TK1YBDYX0m7n4GaOBP1Q>
    <xme:A24baU7Rh-dANJ13MFzTL9wQ3y8RCreCBEoTUEqTsJ1v3G2hNc456Aez3OWJFdt-r
    rhDwRfelrLT-cC4n8yewRqf6VBxIfcRc9thVc998w4ozXJTHTFkGw>
X-ME-Received: <xmr:A24baeWMi3vcHWsPu2nKS3RJiKrnutuFrjUR1MFkmdeJC1kYrXz8kqhfuzn0ZhiT0bD3l5jhrL3gmKfkYaKUeKtC7Lu8WAyfr7dF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A24baT4rCliob9pgLb7NktUcO-SB6UMfgK3paRVFMGF5TTf4R_VxuA>
    <xmx:A24baZrsy6YRA6wLV0nKhvlHuNCiHcXWGIA9vk8RIbsy_nZgtuQ7tg>
    <xmx:A24baWk4jnQGgkUciGMsxnvGW4J6_ltXLNmZBnTFAP0S37qI8c7u4Q>
    <xmx:A24baVPREIQK3dUx0qXrmYiMXGcdYZh1YF2m-7JFSZm3hySCg_IyYg>
    <xmx:BG4baciCseJQpLXbAKjjZN4JbGlCVIZKloqjw8OnJEdbzkj5x0gouc-0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 13:48:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v4 1/2] repo: factor out field printing to dedicated
 function
In-Reply-To: <20251117151844.14802-2-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 17 Nov 2025 12:02:51 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-2-lucasseikioshiro@gmail.com>
Date: Mon, 17 Nov 2025 10:48:34 -0800
Message-ID: <xmqqldk4ijgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Move the field printing in git-repo-info to a new function called
> `print_field`, allowing it to be called by functions other than
> `print_fields`.

Missing:

    Also change its use of quote_c_style() helper to output directly to
    the standard output stream, instead of taking a result in a strbuf
    and then printing it outselves.

The patch text looks great.

> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 9d4749f79b..f9fb418494 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -85,13 +85,29 @@ static get_value_fn *get_value_fn_for_key(const char *key)
>  	return found ? found->get_value : NULL;
>  }
>  
> +static void print_field(enum output_format format, const char *key,
> +			const char *value)
> +{
> +	switch (format) {
> +	case FORMAT_KEYVALUE:
> +		printf("%s=", key);
> +		quote_c_style(value, NULL, stdout, 0);
> +		putchar('\n');
> +		break;
> +	case FORMAT_NUL_TERMINATED:
> +		printf("%s\n%s%c", key, value, '\0');
> +		break;
> +	default:
> +		BUG("not a valid output format: %d", format);
> +	}
> +}
> +
>  static int print_fields(int argc, const char **argv,
>  			struct repository *repo,
>  			enum output_format format)
>  {
>  	int ret = 0;
>  	struct strbuf valbuf = STRBUF_INIT;
> -	struct strbuf quotbuf = STRBUF_INIT;
>  
>  	for (int i = 0; i < argc; i++) {
>  		get_value_fn *get_value;
> @@ -105,25 +121,11 @@ static int print_fields(int argc, const char **argv,
>  		}
>  
>  		strbuf_reset(&valbuf);
> -		strbuf_reset(&quotbuf);
> -
>  		get_value(repo, &valbuf);
> -
> -		switch (format) {
> -		case FORMAT_KEYVALUE:
> -			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> -			printf("%s=%s\n", key, quotbuf.buf);
> -			break;
> -		case FORMAT_NUL_TERMINATED:
> -			printf("%s\n%s%c", key, valbuf.buf, '\0');
> -			break;
> -		default:
> -			BUG("not a valid output format: %d", format);
> -		}
> +		print_field(format, key, valbuf.buf);
>  	}
>  
>  	strbuf_release(&valbuf);
> -	strbuf_release(&quotbuf);
>  	return ret;
>  }
