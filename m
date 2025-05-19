Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928E266EEF
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639092; cv=none; b=qi1noQdBmOnWH9Ou1CL5Tt6SpWt2y+eC8D2jpzuG/syNgXCl86TVqaQxk+Iazxcipg25Z93rhfhrUOI3PuhYcXyxzNncqgW51TIz6WSIlrS9VpF8gQsyZqKEYx8/0mpC5AfXNQugqVDvATVyLzBc2SAoooNJ3Fzk42m6k+3TwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639092; c=relaxed/simple;
	bh=OD4bD0cHnlv7d9RdC4f5s8BcBVSxDJwTTXy7aZWEHlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIdMOJMLzYyZ1PpD+etvONpFxxbmP7KHuCuARaXlZAsQKjyivpa2jZrBKVwkHnY6F5aD65IKBfXSKq8Jt3zbuymI2OZiObzjs7yFocZeUM9iAJg6cXMFc3QN8ha5Ap4qpj1ccZP0fsi6E/Z4OuZnsjmUXnXnnJbPyQqe/fLSE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MpZHefOq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=in6Wg5wf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MpZHefOq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="in6Wg5wf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 430BA11400A3;
	Mon, 19 May 2025 03:18:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 19 May 2025 03:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639089; x=1747725489; bh=TOyOqJgO70
	RecACJrwlleqTd4lAKdsPqXRJf3JY2ol4=; b=MpZHefOq6wLt27bb2SZXc6VX++
	HBok4yy0tj9bu2SAkYWotsWiCmDUOEeEy7ZXu2udDX48EgMv2y/O7dwMdWByrz3d
	qYU5zcSqOyQ6g4OxXwteTbdkSnoFHxhZUjXJVelxOm5ffG/gUElyy6g4tdUdWcJ4
	FgMXhxFDZHHuZvQSik8YKsuazX2019xRxdC27iawocnjZObd2yZXkD3v3SFXxgtO
	yH31X3Lk27A0JK7AFgdN3ixIX0dgkXWqf9Fvi8ADta2nH5hQ+D4BgmIaAYaqyJIb
	dYZcl6SfUo4wzWQMJuQ5J2dWBLXSb6yH7EQF9TwV6qC3JEcF7Hm29DAHMSXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639089; x=1747725489; bh=TOyOqJgO70RecACJrwlleqTd4lAKdsPqXRJ
	f3JY2ol4=; b=in6Wg5wfe/d5CruEH1hLKuWTJI+ICiQOsLxkfeEzXM3LEFeJgZO
	iw0DCuUvBphZVWXRlM4nw3Q4EcomA+EV7jnIJeftcgzggMZoY4LyV9eFIDV762iz
	lUSZAtTgPg2SYyPqbVpYZac8dDnI0RF5S1zqxGTzv/yjvhcrwXNjdnLMz5RraTfK
	/rXAiIDmQmGKKxJBB/8hJYyLrCp6S7Cy5TzavhCGdli31JvsR5zVCjRwgFDBd2y5
	ngK809quzBvqJJ4bbLaXDckxPhXp9V1lSanG2Jfxd7T3JIjYjk9xeRF0LIGSGVac
	kS5Q5WKCLzwmY8dt9cJuLp/csM5vgkoESaw==
X-ME-Sender: <xms:MNsqaGK_TDDyJOXPXSFZN9x9nZ-ejYJtGuFpPINVj-3x0N6SBsXn-A>
    <xme:MNsqaOKk7TZ4yLCetzamJU_XUKE5TnXTs_7SDLfa4cW71u-oTHs4AkiEXyG2jZhf8
    zSTqkynfmvPgDWNFA>
X-ME-Received: <xmr:MNsqaGuYCtkHtA7y5IBq47YVJl2rdsog23NDyd_WghA1mjA-aSmkzMXSUXvi-aLYFl3IwlhkNL9vh6ERmJf9dy0uo6eDWcfxBa1yHXFI5Grt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MNsqaLZz-n8_Ka86B8EyQEwh5S3icnG7lXQu87No_aGNV1-7UAzltQ>
    <xmx:MdsqaNaMpD2XlvywXd8UA5DRWfkaOF442-5rh3sMYr3JjCUFKHk59g>
    <xmx:MdsqaHDXxv_Mbz7F17G91JuVPPB6HovjDgXkEATvRo5txy-wbP4Bqg>
    <xmx:MdsqaDbsFbtRcUrhIoDOlw9F6-x4TqLi-qdbiTAsDeRuc57sOTow5Q>
    <xmx:MdsqaB0_QVKCOiqM9xUnsD0JLQryAaLlAXam4tqwB-28Kru0xyKbysXf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:18:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb4696e0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:18:07 +0000 (UTC)
Date: Mon, 19 May 2025 09:18:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] u-string-list: move "filter string" test to
 "u-string-list.c"
Message-ID: <aCrbLoElTJJq6jwZ@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDkaAyxRGgYMJZ@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDkaAyxRGgYMJZ@ArchLinux>

On Sun, May 18, 2025 at 11:58:09PM +0800, shejialuo wrote:
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> index e4b8e38fb8..be2bb5f103 100644
> --- a/t/unit-tests/u-string-list.c
> +++ b/t/unit-tests/u-string-list.c
> @@ -103,3 +115,57 @@ void test_string_list__split_in_place(void)
>  
>  	t_string_list_clear(&list, 0);
>  }
> +
> +static int prefix_cb(struct string_list_item *item, void *cb_data)
> +{
> +	const char *prefix = (const char *)cb_data;
> +	return starts_with(item->string, prefix);
> +}
> +
> +static void t_string_list_filter(struct string_list *list,
> +				 string_list_each_func_t want, void *cb_data, ...)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +	va_list ap;
> +
> +	va_start(ap, cb_data);
> +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
> +	va_end(ap);
> +
> +	filter_string_list(list, 0, want, cb_data);
> +	t_string_list_equal(list, &expected_strings);
> +
> +	string_list_clear(&expected_strings, 0);
> +}
> +
> +void test_string_list__filter(void)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	const char *prefix = "y";
> +
> +	t_create_string_list_dup(&list, 0, NULL);

Okay, here we have to manually create a list because you cannot pass two
vararg lists to `t_string_list_filter()`. It's not the prettiest and
feels a bit repetitive, but the alternatives I can think of aren't a lot
nicer, either.

> +	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);

Both the `prefix_cb` and `prefix` are the same across all function
calls, so I wondered whether we might want to move them into the
wrapper function directly.

The `void *` casts are also all unnecessary.

Patrick
