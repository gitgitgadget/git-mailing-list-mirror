Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71E23C4F7
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179875; cv=none; b=bxjYo8Lha3p2GN1gemYiC+uZhhqXm/Q152knv0X1gHg+1ONcVCvakQ/WJ4C+t7px7Fl7cvKXlIWEQ3DKkuNXdXZriABmC1Cz1W2DGvjL+uMuyyl/cuLiedodA8c3Glp30hVINqjSw9CxJW5H2SLChbluFBQ1+/oTRcdnw9MmBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179875; c=relaxed/simple;
	bh=skIM/MO+3QsMKIWE/qjoEkBDeqa4zgR5AxFK3QDtXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK208hTVaIT0nRRulxeuqTQjAxVaP6Sas3wskf12Ya1TgkwR666is507whoxtkHcOdjM44TB4Laj5bYq+08TlU43PawEe5bmslhn8KWyI9E+LNGB3y36x9XnXcSRemWn+zsLwshpvJ400OWBoQLF2iwlb5mIKyn69xmwL9d9f7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ykHXuLbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jj/Jti1Y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ykHXuLbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jj/Jti1Y"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E0C911380FEE;
	Fri,  2 May 2025 05:57:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 05:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179872; x=1746266272; bh=zLOVYigYpz
	ZBUdNPBK5P6Gw/I3Wy+y6MUu3Am3Iv4n0=; b=ykHXuLbvfy29pZN/u7/HgG2oY8
	92RBwhNX+RCfgzW7x3vVyNvrc9FXKVK/1sXYll5FU5O6yyPvAxTu3yCF1lYxIPLe
	VyNOYKOVZK8o74/y/oSo3LxOjNS6jekEErIpF59P9+9vJiGRFCJPN/A/PEdI+MUs
	PNrrQZ6VD83OIHomCNeGqh9QvZY7WYtpSN4XL7C4uZJH+ZDUqitgmdaX98sy1qn3
	xUSQg+K3bU/ENlLgXz/ug7FUBdzgxBuevaA0V0Gt5Oee/OZcKX8t2ylygXfNOFfK
	StwKFcQ1093XWZXBbNR8Obg9aKRDFapbDYcWr+q8meFbAvf7o6t9zUnrh6FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179872; x=1746266272; bh=zLOVYigYpzZBUdNPBK5P6Gw/I3Wy+y6MUu3
	Am3Iv4n0=; b=jj/Jti1YfWyjVN1ZzBURpCuQNpPOQ9drin6GOSIpTEoR49RL3yX
	koBpgJObd4pM7+ynEs+8zMlTsHN15BlK09fjVyDhXTuuGMaQVfjq3ErD6ebBD/fb
	cEASinNRFaU9a90+VhosK4SVi+ylEWgQa9fWzTrBkIUPeT3h4K0JFpv9Gx61hUk6
	t5CO1+WBcPau+U5CFqMwl8PzY20PhqaivOX5znNd6Z2+n8nZ3xlsaNvluJrI2H30
	BaJhJKf/vlHUtb0m0ElgiHL4e9wAyH2Jc7qi6SDqUcnsD+zfEzcvVFKt3TNxFDiv
	VZuDQ3ELlmmdR2WM6wRQ9/VUnVFpfKIH9kw==
X-ME-Sender: <xms:IJcUaC9wTQf7_5WWUXoz2-A2YVFFd96Mi75YH_f302ZuNF3Y1C-a-w>
    <xme:IJcUaCsaDSTa05qcOJkadJ10dT-0uL20cKp0FjVhukEmHntzfYF_MnJGUJaJqXzFj
    Z_2lrHTWd0plPbIJw>
X-ME-Received: <xmr:IJcUaIAeG4CP5kjkdZvqhymmVFwyNC1P3drmOpJNc1X6P69oLfGpN81usb0Oxq0C6jzPrJceNouGQExqrPzaWkul05tC2rs9KKu1AVVEJoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheeh
    tefhhfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorhhijhhi
    leeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:IJcUaKdo1kuCU2l-2Mts7iF_aeGdwNsgaJBnLwqdhBNB-4vpfp2UxQ>
    <xmx:IJcUaHNdiHQaSiCkrG1BUdu_ZDYjEcaxIkv1LPr7G9dTVU5I9axuxw>
    <xmx:IJcUaEm474L1RBIHpaO3JVDATOzb3PJ9ky9JIbZeA1MqmRC_OxQrhQ>
    <xmx:IJcUaJuejMP5Fwa_eyoWZwvSLuuBCPfja57wnJ2y4tQfvfgQw7OcCA>
    <xmx:IJcUaMYTlrHxJjRQz9eq9n-AOf3XqJT2ApaZXXBHTy_6FMcWnBrfBQ_V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03412fde (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:51 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/10] t/unit-tests: convert reftable merged test to
 use clar
Message-ID: <aBSXHs4nuuBhqOW1@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-5-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-5-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:56PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/u-reftable-merged.c b/t/unit-tests/u-reftable-merged.c
> new file mode 100644
> index 0000000000..48c8f9f6b5
> --- /dev/null
> +++ b/t/unit-tests/u-reftable-merged.c
> @@ -0,0 +1,515 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "unit-test.h"
> +#include "lib-reftable.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/constants.h"
> +#include "reftable/merged.h"
> +#include "reftable/reader.h"
> +#include "reftable/reftable-error.h"
> +#include "reftable/reftable-merged.h"
> +#include "reftable/reftable-writer.h"
> +
> +static struct reftable_merged_table *
> +merged_table_from_records(struct reftable_ref_record **refs,
> +			  struct reftable_block_source **source,
> +			  struct reftable_reader ***readers, const size_t *sizes,
> +			  struct reftable_buf *buf, const size_t n)
> +{
> +	struct reftable_merged_table *mt = NULL;
> +	struct reftable_write_options opts = {
> +		.block_size = 256,
> +	};
> +	int err;
> +
> +	REFTABLE_CALLOC_ARRAY(*readers, n);
> +	cl_assert(*readers != NULL);
> +	REFTABLE_CALLOC_ARRAY(*source, n);
> +	cl_assert(*source != NULL);
> +
> +	for (size_t i = 0; i < n; i++) {
> +		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
> +		block_source_from_buf(&(*source)[i], &buf[i]);
> +
> +		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
> +					  "name");
> +		cl_assert(err == 0);
> +	}
> +
> +	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
> +	cl_assert(err == 0);
> +	return mt;
> +}
> +
> +static void readers_destroy(struct reftable_reader **readers, const size_t n)
> +{
> +	for (size_t i = 0; i < n; i++)
> +		reftable_reader_decref(readers[i]);
> +	reftable_free(readers);
> +}
> +
> +void test_reftable_merged__merged_single_record(void)

This should be `__single_record(void)`. Same for the others, the
`__merged` prefix is somewhat duplicate as you already have it in the
test suite name.

> +void test_reftable_merged__merged_seek_multiple_times(void)

So, same here, let's rename to `__seek_multiple_times()`.

> +{
> +	struct reftable_ref_record r1[] = {
> +		{
> +			.refname = (char *) "a",
> +			.update_index = 1,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 1 },
> +		},
> +		{
> +			.refname = (char *) "c",
> +			.update_index = 1,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 2 },
> +		}
> +	};
> +	struct reftable_ref_record r2[] = {
> +		{
> +			.refname = (char *) "b",
> +			.update_index = 2,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 3 },
> +		},
> +		{
> +			.refname = (char *) "d",
> +			.update_index = 2,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 4 },
> +		},
> +	};
> +	struct reftable_ref_record *refs[] = {
> +		r1, r2,
> +	};
> +	size_t sizes[] = {
> +		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
> +	};
> +	struct reftable_buf bufs[] = {
> +		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
> +	};
> +	struct reftable_block_source *sources = NULL;
> +	struct reftable_reader **readers = NULL;
> +	struct reftable_ref_record rec = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_merged_table *mt;
> +
> +	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
> +	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
> +
> +	for (size_t i = 0; i < 5; i++) {
> +		int err = reftable_iterator_seek_ref(&it, "c");
> +		cl_assert(err == 0);
> +
> +		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
> +		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[1],
> +													REFTABLE_HASH_SIZE_SHA1), 1);

Indentation is wrong. Our tabs are 8 spaces, so this is indented too
deep now.

> +		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
> +		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[1],
> +													REFTABLE_HASH_SIZE_SHA1), 1);

Same here. There are also other instances in this file.

Patrick
