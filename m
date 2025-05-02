Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7659238C35
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179872; cv=none; b=PcFI064vKieYZ68xFxU+Sl/Elin9ap9fOOya2IEpzu50JPJNAvYdnyX79wlPBFdYtK+G6szI0f2knQqwiNcyYYfeUaj644sGXAB4IMF1QPy/xIDeI7ngEko4wrzBeNCeJbyRx2ddGvlhoIakosSojEUMHHr7TdCdeHAAquGJbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179872; c=relaxed/simple;
	bh=4bdgF1E28FXL/Hgx9K96lX9TApq1Rt5CYLttBHGgSzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ3YXknCkQnPeIyj3dioasqpjGGZueSRq+1soBWT5C1lVZVqTORUActFBpCcqY3oTqvf5q//YGzy9LnLSdVFfrWqfSDut034QniIqrsLcKn4chpp2OMGZUAOrS6TbtMMF4yrZ/OQWb3zgbGN7rOciNM9bb2jcYgENbevo8dVVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jap9zZpb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liM5Pw4F; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jap9zZpb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liM5Pw4F"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EC09B1380FEE;
	Fri,  2 May 2025 05:57:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 02 May 2025 05:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179869; x=1746266269; bh=gVUA7AOnJJ
	OSreBo53uqyYKCR2zmN2Ip/bYOepcZeyQ=; b=jap9zZpbBRBSkFl3k2qk05UxHu
	VHomCAqmt0ZpiHT6MnyrKjOmlqjjhF+eGwCpGKysiofgfhQ2UF/wkVzooEZKoqS4
	6FAZnan/Oou2zl0EjworW3dRSM0iNLR8anzkLt7FLGaKOA6Wnn/3+i2sAt7cECRL
	Vpcib5jqm/gdK8cL5qgilt1LXUiqWdGJlS6J/Gd7RSjVerizxNdTCxTE6+NacBju
	Yjyee6cHZFXeyoTM3xrcZ3U0skLdVl5nds1q4pck72hP9bmShDRTXEUFXxzhurZ9
	EDAc+QzNywmUxzRb0yNrmGca+Llg8jOcObJmymg9La3eFksTOL2bxA3fvnMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179869; x=1746266269; bh=gVUA7AOnJJOSreBo53uqyYKCR2zmN2Ip/bY
	OepcZeyQ=; b=liM5Pw4F+eVxny2DXqSHGGpusoHZmk4z4e0YZAx0p6VHaVyVRE4
	VgZjBq/wKBodqDZlzTJaoyaoG6rbwroGquzUJ0I5kXm8CPEd/zFU8SAf1mjohQsy
	PrT9nRV52x75olLGtZKi/NAA75LH/x9cHQz1AfjHvYOuFuGYamL8zKG7XtfChGl3
	oPJCBsrD9hEGLa6PvFcP47GoYud+M1YZahshKRqtdScgtDAi97C1Bk1IZWVXrEdD
	dYXXPVgKytACh51a/dUuTgcTDajKz6pqAfwZ9tB1LklXiv2+U5bUg0M8NAr51agm
	u9f0Qznxjm6OncomSR3D2W6L4XSEnTALKaQ==
X-ME-Sender: <xms:HZcUaB5_E6q2o0roZm-d22pdPCmffWhGupk4s2QvsGlxEE0We8ypcA>
    <xme:HZcUaO4vIGrB9xjeU8FOWnb1Dq0HyCJVVvYHueRu8TkuSauj9o5uVmC99Fe8cSCr8
    8dAP2haZ_HyVTL9cA>
X-ME-Received: <xmr:HZcUaIeUjKXjU_8F_4wp9IpyeQEux7ROZjp-rqF7MfG6GJuh5GHg2Ef2ZmB6W9g56-dBobyi6GG42E8g_dTecJz51ul86jS8hQdv0bBrICk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheeh
    tefhhfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:HZcUaKLzow35ePpt4D187WEtB_337B9_ZVFf-2S4P_DWUrueYCtwsw>
    <xmx:HZcUaFIMTm12-MgaeXy4hC4d5ZbCmyyZAdYBslfUb_gXO05ksymceQ>
    <xmx:HZcUaDyHy6GjxE7s9Zy4xWb9U5FdHWQ9TkLhU9eYTH1th-yNaPhuFQ>
    <xmx:HZcUaBIOFuULFjJfKhZ5dOpI6ZN_5rXS1abGQysh2RabfCAh9SGxtA>
    <xmx:HZcUaOvKpeWUgBS2LyT8tDfjAG-NUkd-TfwT-T-LfSoRdXNSWhQc2oCh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86e9e3b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:48 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] t/unit-tests: convert reftable block test to
 use clar
Message-ID: <aBSXGz_eIljWbb2H@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-4-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-4-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:55PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> deleted file mode 100644
> index 22040aeefa..0000000000
> --- a/t/unit-tests/t-reftable-block.c
> +++ /dev/null

Hm, why is this recorded as a delete and creation? Weird, inspecting the
diff locally properly shows it as a rename, which makes it a ton easier
to review. It would be great if you could try to play around with the
`--find-renames` option in the next iteration of this series and double
check that these are shown as a rename.

> diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> new file mode 100644
> index 0000000000..af24901230
> --- /dev/null
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -0,0 +1,373 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "unit-test.h"
> +#include "reftable/block.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/constants.h"
> +#include "reftable/reftable-error.h"
> +#include "strbuf.h"
> +
> +void test_reftable_block__index_read_write(void)

This doesn't got to do anything with indices but with refs, so I'd
rename this to `__ref_read_write()`.

> +{
> +	const int header_off = 21; /* random */
> +	struct reftable_record recs[30];
> +	const size_t N = ARRAY_SIZE(recs);
> +	const size_t block_size = 1024;
> +	struct reftable_block block = { 0 };
> +	struct block_writer bw = {
> +		.last_key = REFTABLE_BUF_INIT,
> +	};
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_REF,
> +	};
> +	size_t i = 0;
> +	int ret;
> +	struct block_reader br = { 0 };
> +	struct block_iter it = BLOCK_ITER_INIT;
> +	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
> +
> +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
> +	cl_assert(block.data != NULL);
> +	block.len = block_size;
> +	block_source_from_buf(&block.source ,&buf);
> +	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
> +				header_off, hash_size(REFTABLE_HASH_SHA1));
> +	cl_assert(ret == 0);

Same comment here, asserts like this can be retained as
`cl_assert(!ret)`.

> +	rec.u.ref.refname = (char *) "";
> +	rec.u.ref.value_type = REFTABLE_REF_DELETION;
> +	ret = block_writer_add(&bw, &rec);
> +	cl_assert_equal_i(ret, REFTABLE_API_ERROR);
> +
> +	for (i = 0; i < N; i++) {
> +		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
> +		rec.u.ref.value_type = REFTABLE_REF_VAL1;
> +		memset(rec.u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
> +
> +		recs[i] = rec;
> +		ret = block_writer_add(&bw, &rec);
> +		rec.u.ref.refname = NULL;
> +		rec.u.ref.value_type = REFTABLE_REF_DELETION;
> +		cl_assert_equal_i(ret, 0);
> +	}
> +
> +	ret = block_writer_finish(&bw);
> +	cl_assert(ret > 0);

It's a bit unfortunate that we have to use `cl_assert()` here, but that
isn't the fault of this series. I do have a pull request pending
upstream that introduces integer comparisons. Once we've updated to that
version I'll go through our unit tests and adapt callsites accordingly.

[snip]
> +void test_reftable_block__ref_read_write(void)

This one here should be called `__index_read_write()`. I guess you
confused the first and and this test name with one another.

Patrick
