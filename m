Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A31C3039
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323845; cv=none; b=tk349oaHrIlWgUxQfHztO47riNvp1pS0nNFfRRpeahpxj7W1PBLbC3AcYed3Y4pAbfn5H1Mwjn720WIKHr8l7HkttO4j65kSTowtnlszpz+DSnWoE6+kLgpjz2117Kw+MqxlkLBEbMmYBf2kPHsgxRb9nXfDYsF8v5X/c4q/hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323845; c=relaxed/simple;
	bh=XmQ8aFeCwxmpM9a+HIKVGM8/IIcu3zv5mN45pou7ciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGUV8LfOiD6yyS56ytXpOVycXgs3Q+76Gf3elsN21bV3aAmzoc3J2kXyR6tRK3wil2IcBkyNeLpwvPpcWUCoXWmki86zdTr2q/3YkSN+KRfq/mGzi96K76B0EGJ8XGYr+mnZ1rGgfPl0iDxbkPb+Kamr4xK6ix7BeWVNzu9D7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E4VM7pM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yvbGoO67; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E4VM7pM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvbGoO67"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CBE4413800EF;
	Fri, 31 Jan 2025 06:44:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 06:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738323842; x=1738410242; bh=IJ0QQqnM4B
	veDKxVW1Sv7sG4I7vqQrLngW3AIppymvg=; b=E4VM7pM3QiIA+ZYh60rCxU8HCD
	P+oEtQgq1TONSmYhA7B+rXxTKm9hmnsJLeotL73VuXVhY/AXf6zOgwmq64y5iei6
	A1V8I/zHmDu+L82H8cT5F+c+bGv1VgYHQNlyj5greOzfq5SKMwhggikBHQRAz6xn
	vGm9KxLNAajAsP9jtL8vrXrA4gIi04oxo9IsDdQfzGeSeerzTpFSWnEvyalhUZ5U
	KXy8CeVIWD19rwEThnIEN909IQDdpl+pFG1PxflnjvFVMyUr3pgxopWHcUe1yv1H
	p6J0oDO5xlETMem86NNxkFgcTsMkMt8xoAExLMAV0CIjpXenh9+gaETN1CVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738323842; x=1738410242; bh=IJ0QQqnM4BveDKxVW1Sv7sG4I7vqQrLngW3
	AIppymvg=; b=yvbGoO67nfIAzWZXphMht6deJZj7uCKra5peO73VenjPXaGFZwJ
	9HBK0ZlcEPOJsSX4dqhGY8x8xBd30o1aIBWyPMytflHEdqgC/naiVq481VWmJYbg
	S3r9tztLsSNH3w/hp45QlyJDRgMeISKsuYZgXjhfltWJ5x5/ytZuJpQGkfkevnb2
	4YcMuJte7+DQIeQNTKwdunqyBuveZT6OvhwEo9rD7bir9UZ5reP8RSFi+Rq8Qj0I
	4HDZmPIVYOth4Rr8eQZVxPemcD9GRc4ZxVFQvOG2hocUj66mmy3P3RIaddSK0uGF
	6iS/PtYls0ZkkkPudlBX2sNgomicxUKFIXQ==
X-ME-Sender: <xms:grecZ5nk679_IZ_ulSDuve2RB7DHm6tXERJOjgZFV5kmpGmzov923w>
    <xme:grecZ03n01nstNMSULSLEFMuduizpEXsUcIr3WrF_SVBsQ7lE5uqhwKUmURQT9LYV
    zKlcHUouP_E_qT5Fw>
X-ME-Received: <xmr:grecZ_oBZZkeBhPp9ffVy9Ivr08ptJoyGJKvVDjmpFYhhL2I4B5eFoLCIqCW4vqKpm8UXLyo8S_OAUHDqjjFXSbk51EcEYQtkWLEMAupAF0ESQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:grecZ5nfI_PiIbZ2PSMZWJK9BuDE7-0vlmgQDCACD3d9FDVgAp50vA>
    <xmx:grecZ31ueczgYkA_7jy98hQ_P8vHjIGkkAsV77jxTVh_A274LscI4A>
    <xmx:grecZ4v1GuvVTjtroGjy3VSp1Hxgjbbhtz38yAekIWoNhYZ7Sm0otw>
    <xmx:grecZ7X_1qvycCSzAdBcV2YbJMbpE048_5TbJ_IR-Sh7FdqLfSEtuQ>
    <xmx:grecZ4xhusQKukLCrmABW8XaBT5pc5I4sncysg-tIMdC1_HZPTeRDULT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:44:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f6c7d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 11:44:00 +0000 (UTC)
Date: Fri, 31 Jan 2025 12:43:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] t/unit-tests: convert strbuf test to clar framework
Message-ID: <Z5y3f1B450LZOp3v@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250130091334.39922-4-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091334.39922-4-kuforiji98@gmail.com>

On Thu, Jan 30, 2025 at 10:13:33AM +0100, Seyi Kuforiji wrote:
> Adapt strbuf test script to clar framework by using clar assertions
> where necessary. Test functions are created as standalone to test
> different test cases.

Same comment here regarding the second sentence.

> diff --git a/t/unit-tests/u-strbuf.c b/t/unit-tests/u-strbuf.c
> new file mode 100644
> index 0000000000..fec3c768d2
> --- /dev/null
> +++ b/t/unit-tests/u-strbuf.c
> @@ -0,0 +1,121 @@
> +#include "unit-test.h"
> +#include "strbuf.h"

It's somewhat sad that Git doesn't not think of this as a rename, as it
would've made the diff easier to read. You might want to try using
`git format-patch --find-renames=20' to ask Git to still consider this a
rename.

[snip]
> +static void assert_sane_strbuf(struct strbuf *buf)
> +{
> +	/* Initialized strbufs should always have a non-NULL buffer */
> +	cl_assert(buf->buf != NULL);
> +	/* Buffers should always be NUL-terminated */
> +	cl_assert(buf->buf[buf->len] == '\0');
> +	/*
> +	 * Freshly-initialized strbufs may not have a dynamically allocated
> +	 * buffer
> +	 */
> +	if (buf->len == 0 && buf->alloc == 0)
> +		return;
> +	/* alloc must be at least one byte larger than len */
> +	cl_assert(buf->len < buf->alloc);

I think this condition can be simplified a bit:

        /*
         * In case the buffer contains anything, `alloc` must alloc must
         * be at least one byte larger than `len`.
         */
        if (buf->len)
            cl_assert(buf->len < buf->alloc);

> +void test_strbuf__add_empty_char(void)
> +{
> +	setup(t_addch, "");
> +}
> +
> +void test_strbuf__add_multi_char(void)

Nit: I think "add_multi_char" is slightly misleading. What this test
exercises is that we can append to a non-empty buffer. So maybe
"append_char" would be a better fit?

> +{
> +	setup_populated(t_addch, "initial value", "a");
> +}
> +
> +void test_strbuf__add_single_str(void)
> +{
> +	setup(t_addstr, "hello there");
> +}
> +
> +void test_strbuf__add_multi_str(void)

Similarly, we could name this "append_str".

> +{
> +	setup_populated(t_addstr, "initial value", "hello there");
> +}

Patrick
