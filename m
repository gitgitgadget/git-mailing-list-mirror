Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE3257AD3
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639082; cv=none; b=WrqzQulvjIEqRpuvHCvr6hyVHsgVPVafR1+ZTdxIQ2ywSVafAh6mZt1IqQl/6xnA+byzW60//t67W15kanWim7xqGWpjZ8yzqkRdhD++xfTIiSgBnGZBKg8OEQTUwWgqsMygFikaiKYe5PM2LZqZrBJdeZZhzE2iUTeQOrR0HNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639082; c=relaxed/simple;
	bh=uJf1G2t+i5mGnk6ipUGrb2ZRylVFhCr1lN8II+YcA8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIlJhfOEq1uPfycQyWZ/z7clJvJrrwV87ggmzbYzGNhkg2uuSK0YawYC+U31tPvsu7EggCG0zISaxzqvI66FaPUY20sMlhA4aLSPNtE4DzOov3jMyT5zT2aMHijt1x1OW5kvjjMjuerZwFuBCALpl/5Lua16U5zY1AFOEed1u8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ycO7XpVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u/RWpPv6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ycO7XpVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u/RWpPv6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 634131140100;
	Mon, 19 May 2025 03:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 03:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639079; x=1747725479; bh=F1EBZzXJnK
	Xd/q5vM9OpfvF4v/jMvzh+iC8nEAMavls=; b=ycO7XpVG1LCQaCGLb9yh3BZS0F
	ZRMDlMaghx5bs70Vs6+Ri7uwqr6q8vOTHKhpxN1miY/xRasu+Ng5k0XDyH0e1TU3
	ohJAKymy23TCjFah9Rn3WrZZCyytiFWdHdEmG3OdkvE/8IVDm59hOV7mdwzz1QLO
	O0/gHUv+Pg/xUDxABFt0loFGb9Wsz2GEonMiWNqZ2lby76od4ox3pIGiGsPJqFw+
	/XgWBIMarbRqRPazaIERQw5CSUFtnTRbjGbpPh969RGr94Bn80eqgjgr48ooELjE
	7ZFNprv1dVTp1lROpX3QtJTiw8+EFkQ9DBdwp+gw0YNFrWfADQQFn24dQPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639079; x=1747725479; bh=F1EBZzXJnKXd/q5vM9OpfvF4v/jMvzh+iC8
	nEAMavls=; b=u/RWpPv6rI3w93SQ+ZR65uXH5UZ3mi54H+SSnFz1pgnGe2aWQ0J
	anKMmcLV5oJKzXsF3cZh08KviN7cs1ohnCqU2mR2N4pQwszd7YZYJXMpbuCct5yw
	kjrTaQsU2vFXDSvZIcc/GfX+j2we42zizvkbK9nPyJItPmVHBhc1DcCtWznvWRZF
	XcUKkl4JLQXeRTybs3E7vaISUd3gfcmF/tvVBa+i2PjeMy24MH0fXtkR5XU4nBgW
	wNOufB8bBf+ASkm8/+K1l9kYq2PrJWGK5FnTx7j1yJwuZn3gwFAi8SFRHqrdc8rZ
	3VcQPySioGq5LH+VB1xlfOnySVShWQItsxg==
X-ME-Sender: <xms:J9sqaLzazUw4VH9a5DzcxGQ-xfdjfK2qy55t_mAKMpJ03BypsweXDg>
    <xme:J9sqaDQmcZu9o2NK9j65gwFypWIW2ZNhJRdMZP9YFXYbTdl5_ZZXRiuPGpvofv45R
    c4GB1Nk8e9XUIpFdw>
X-ME-Received: <xmr:J9sqaFVU0B4REAx1kovIW7JHBStqbg_SK7CRdUrTUth9gZJ5KrZMU2ZR2gcub4fYlvTjohq5Wn8DCySTY5FDSgRTii4mbM_VmvTKjEItNsw5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:J9sqaFiytwNQDh6VJgM6aY2EDhagiJw-e7Z9KoQrZMR4mijSVDcc_Q>
    <xmx:J9sqaNDD1ZSpsphageBscbmQzu-1eaLME1QyPiRCq7MVI93EaMARmA>
    <xmx:J9sqaOLbl9HiH8tvIOIJrLaBcydeHvrw1V4XkXD-XC-yYfEOnifNbA>
    <xmx:J9sqaMA8K9Bb6DRkzx0xfmufEc6W_3Lzvsew6pgubYGQ-sAx58hBlA>
    <xmx:J9sqaO_aInU8gFpC-TWs8-Xr2HrA0-wHAsG6R6AZ7EPa3EAskS1TLomp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:17:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdbc02f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:17:58 +0000 (UTC)
Date: Mon, 19 May 2025 09:17:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aCrbJcUMl554xMUg@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDbRCQSjAXV7H1@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDbRCQSjAXV7H1@ArchLinux>

On Sun, May 18, 2025 at 11:57:33PM +0800, shejialuo wrote:
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> new file mode 100644
> index 0000000000..c304934de2
> --- /dev/null
> +++ b/t/unit-tests/u-string-list.c
> @@ -0,0 +1,66 @@
> +#include "unit-test.h"
> +#include "string-list.h"
> +
> +static void t_vcreate_string_list_dup(struct string_list *list,
> +				      int free_util, va_list ap)
> +{
> +	const char *arg;
> +
> +	cl_assert(list->strdup_strings);
> +
> +	string_list_clear(list, free_util);
> +	while ((arg = va_arg(ap, const char *)))
> +		string_list_append(list, arg);
> +}
> +
> +static void t_string_list_clear(struct string_list *list, int free_util)
> +{
> +	string_list_clear(list, free_util);
> +	cl_assert_equal_p(list->items, NULL);
> +	cl_assert_equal_i(list->nr, 0);
> +	cl_assert_equal_i(list->alloc, 0);
> +}
> +
> +static void t_string_list_equal(struct string_list *list,
> +				struct string_list *expected_strings)
> +{
> +	cl_assert_equal_i(list->nr, expected_strings->nr);
> +	cl_assert(list->nr <= list->alloc);
> +	for (size_t i = 0; i < expected_strings->nr; i++)
> +		cl_assert_equal_s(list->items[i].string,
> +				  expected_strings->items[i].string);
> +}
> +
> +static void t_string_list_split(struct string_list *list, const char *data,
> +				int delim, int maxsplit, ...)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +	va_list ap;
> +	int len;
> +
> +	va_start(ap, maxsplit);
> +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
> +	va_end(ap);
> +
> +	string_list_clear(list, 0);
> +	len = string_list_split(list, data, delim, maxsplit);
> +	cl_assert_equal_i(len, expected_strings.nr);
> +	t_string_list_equal(list, &expected_strings);
> +
> +	string_list_clear(&expected_strings, 0);
> +}
> +
> +void test_string_list__split(void)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;

Let's move this list into `t_string_list_split()`. Otherwise, tests may
negatively impact one another via this shared state. The same comment
also applies to subsequent commits.

> +	t_string_list_split(&list, "foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
> +	t_string_list_split(&list, "foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
> +	t_string_list_split(&list, "foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
> +	t_string_list_split(&list, "foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
> +	t_string_list_split(&list, "foo:bar:", ':', -1, "foo", "bar", "", NULL);
> +	t_string_list_split(&list, "", ':', -1, "", NULL);
> +	t_string_list_split(&list, ":", ':', -1, "", "", NULL);
> +
> +	t_string_list_clear(&list, 0);

Patrick
