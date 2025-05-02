Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7622CBF6
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179863; cv=none; b=NBVwkGf91ltKRS89XAVTrXld+u1z2m+HceUvw5AuNdCBgeuzjNA2G+4CQXT3G95ziRH6VoZRza5zIzAreget5lyr+BaTSvF8SSCe71ODt+KIBjoo2ple0CF/y+IBQoMNwX7pKBmbVKaXifu00kBdoQOPGowwulF6wxDUmair6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179863; c=relaxed/simple;
	bh=xpmwsxsw8CZ5cNMHRg3unuQynJUxdgTRironGhGmD3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhrSHVcWvFVkRC3BsWnvSZICf8bOMSfVvefdhK+bGOGmV0mHpwV8Ij/OYBzlA+gDUfefMYIyBUROMLrqf7F9iZJZJY6r+HlVl7dsPyyHX9wZ9JrwFmXz+naXRHTxB58BTzi1vhZs+JJyGAaaj7XYXhrMcKhApoYwnpsumIi6zb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6QIuE0V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cl8VThc5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6QIuE0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cl8VThc5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B88CE1380FF0;
	Fri,  2 May 2025 05:57:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 05:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179859; x=1746266259; bh=bNUe2udJ/l
	lFydVoujHstsFv6F5Aw5o+wpazZmqm2J0=; b=i6QIuE0VNaK00O749DNpdbfVxO
	WYrvUR+zTEH5eRZz96vfBA/048Jp8sqScXhkhMR8ViSeXrw1BjFvY66bYcKNFpxb
	Fp6aeC0ecbtfpoX5eJHGOPhi78VD0fWXw3mg1YUTCWJWMaJ6mNaErjdWSTq3mh6g
	BDnd5xJc8wGdMkuymUaLylx2qf6atoOfSQSdryd2uEKsdfM/lgo4ZnVGmBmnPUDk
	eGC0WAJbd4OY0+mbw+9Xl53S2VaE/R9EkWysvlyOjxWBoVE1wPs9hR4I6QzEuyI5
	L0gFXvzygN2479GO9SzkwwZvHXpwgwYM2RvxicfSKR6O2cw51vcaV+DNk8fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179859; x=1746266259; bh=bNUe2udJ/llFydVoujHstsFv6F5Aw5o+wpa
	zZmqm2J0=; b=Cl8VThc57mg/RLkvM2eGSuPARNPehLIq3PdzAqzZnOLkE+l1EiT
	CE5r2Or71KB8Sw6kD5V8zoy54bi6zhMTGmZ1qXG7k/JTx0rMb6K7E+7pvm6wv4j0
	bWG54qDG0tpUgL/DuwFvniVuHiwJwe89Z/UstfGZCyTjHzXxfeWCzUi6yR0r/V3r
	JA4vQIZHHURIHSbL4VYlXH5e1Wp96V7K/KdOODaWgeYOYmeFoTQIwIReAvMm0Ffy
	8N9T2XMPWFzf1+oDprUEtJi3KnuSRIbqKdqlcQRyqNVIxq3ClEeFK2D3DzZDrmQR
	2C6cktKJpSUSVR+hqiDszS4wy8oNaK8xcXg==
X-ME-Sender: <xms:E5cUaLdR8Po0944nr6ko1DIzNAWRamI1inqBgxbtETH9NcR3E4YVdA>
    <xme:E5cUaBNRZxBlh5FDe3Qj9_hJK-Ct-s2exyVrgZmvr566bOAIQjpWRagRAu-cpyqTx
    IJw-ChDXMl5v0C_Pw>
X-ME-Received: <xmr:E5cUaEjvuP03-xPmXw2WVDEDd9OCJ8f3sSUa-gfylypJTfaMy4zfb0q5EA2asL8GIHFVweqif7HGqz2lF4_-sHysTQqwiSyHm0lG3csdCCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:E5cUaM_9-3lVeoTnWTWNq7yLWrD4k1wCznjnNY7-oS8fnwZUOcmO3w>
    <xmx:E5cUaHvPag--Iw6_sr-jMXDE1_nf405NJIebYhf5Kbym6JZ7EyoRXA>
    <xmx:E5cUaLF1Lfepj5P1pQrT6eQ6euJzUCkauyy2Ynatv6aoTvKOvv2BKQ>
    <xmx:E5cUaOOz4YWKd8PGkg_qzoyqy_bbbiPxW-a1evt4zs5AVTfAxj8PfA>
    <xmx:E5cUaPDT6fBxsvOKBg1g3cUXx9WLD6dmWWBGr91m895VOEH08ot4pip_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed5ed9b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:37 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] t/unit-tests: implement reftable test helper
 functions in unit-test.{c,h}
Message-ID: <aBSXEEjRyh2cQ4Jm@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-2-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-2-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:53PM +0100, Seyi Kuforiji wrote:
> Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> required for the reftable-related test files to run efficeintly. In the
> current implementation these functions are designed to conform with our
> homegrown unit-testing structure. So in other to convert the reftable
> test files, there is need for a clar specific implementation of these
> helper functions.
> 
> type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks;
> i++)`, implement equivalent helper functions in unit-test.{c,h} to use
> clar. These functions conform with the clar testing framework and become
> available for all reftable-related test files implemented using the clar
> testing framework, which requires them. This will be used by subsequent
> commits.
> 
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/unit-tests/unit-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  t/unit-tests/unit-test.h | 16 +++++++
>  2 files changed, 109 insertions(+)

I think this functionality should be added to
"t/unit-tests/lib-reftable.{c,h}" instead of to the generic unit testing
library as it is highly specific to reftables.

> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 5af645048a..6c2a4e6aa8 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -1,10 +1,103 @@
>  #include "unit-test.h"
>  #include "hex.h"
>  #include "parse-options.h"
> +#include "reftable/constants.h"
> +#include "reftable/writer.h"
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "strvec.h"
>  
> +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
> +{
> +	memset(p, (uint8_t)i, hash_size(id));
> +}
> +
> +static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
> +{
> +	strbuf_add(b, data, sz);
> +	return sz;
> +}
> +
> +static int strbuf_writer_flush(void *arg UNUSED)
> +{
> +	return 0;
> +}
> +
> +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
> +						 struct reftable_write_options *opts)
> +{
> +	struct reftable_writer *writer;
> +	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
> +				      buf, opts);
> +	cl_assert(ret == 0);

We typically don't explicitly compare with zero, so this should rather
be `cl_assert(!ret)`.

> +	return writer;
> +}
> +
> +void cl_reftable_write_to_buf(struct reftable_buf *buf,
> +			     struct reftable_ref_record *refs,
> +			     size_t nrefs,
> +			     struct reftable_log_record *logs,
> +			     size_t nlogs,
> +			     struct reftable_write_options *_opts)
> +{
> +	struct reftable_write_options opts = { 0 };
> +	const struct reftable_stats *stats;
> +	struct reftable_writer *writer;
> +	uint64_t min = 0xffffffff;
> +	uint64_t max = 0;
> +	int ret;
> +
> +	if (_opts)
> +		opts = *_opts;
> +
> +	for (size_t i = 0; i < nrefs; i++) {
> +		uint64_t ui = refs[i].update_index;
> +		if (ui > max)
> +			max = ui;
> +		if (ui < min)
> +			min = ui;
> +	}
> +	for (size_t i = 0; i < nlogs; i++) {
> +		uint64_t ui = logs[i].update_index;
> +		if (ui > max)
> +			max = ui;
> +		if (ui < min)
> +			min = ui;
> +	}
> +
> +	writer = cl_reftable_strbuf_writer(buf, &opts);
> +	reftable_writer_set_limits(writer, min, max);

This function may return an error, as well, so let's verify it while at
it.

Patrick
