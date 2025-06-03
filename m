Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E622745E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960318; cv=none; b=Zfv2SGGpBeEgU44zkv2cUvH8+B74Utazknj2Ru4MDoaD/ldwc4fMEcLkTdckIjGphfyopLQ0DkWmzyjT3ENfQiBxEgFdGbL/G8thsIsYpnFbQf55JGJY57z9PN1tAVleSoU0IW3CY4MtCyVtXlqqTy49uVhu8vp5bD8v3cighSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960318; c=relaxed/simple;
	bh=EMRHvVAlhG7NnqzJIi3jC8MGm1PpLG7iGO92sbst5Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7/Y8OmhL/EZEwUQ5jeGdGXfVbXxUGmsMK0RsSZGyATjxX1Bg9occ+FcIvKZTPgq9JhDRsY4G5C3SgfUSDhlgDkLrHH+ECHQQqD1cN+vbgVcrhnQbuvabq1z/1R/38ZGO3ttTUr89Lsp/esXQcojoctgXRfdvP/hueK3AfSBKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XEaKyHay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPUcka3e; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XEaKyHay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPUcka3e"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B070A114012A;
	Tue,  3 Jun 2025 10:18:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 10:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748960315; x=1749046715; bh=6OmxASUSYh
	gmG08fIEgJ8yhCOkAhuakjDG4T0DPOLh8=; b=XEaKyHaySJAL+bctay3G9T+gb6
	RAidCMXSYbnr40hmEvrx7mVskknfdAqP7P36IGtWp0rRUilu2al5I+8vJ+cQHZMX
	I/iLkJ/o0yX1kwTR5+ByJj9xdYJboMXZrG1gDIyvEenAPkypm0rFR6yWOyNSH8ji
	urU2tUHjDGWyhm86ebz0B23UqjNWFXK60JEb2YVmTbSQeOhEy0vz48IEfOAotDKG
	irVyhUBouGrVrGe/P3IXdcq0Sn5Im4p+BI5NYgD3OF3gSS91cwiyDy1yDPlP98ta
	0p430DcjdyK/CQak5Iq1oWq/18ouFS4+Knvv3Hyg4FiNED3eF+xy4iX4Gs+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748960315; x=1749046715; bh=6OmxASUSYhgmG08fIEgJ8yhCOkAhuakjDG4
	T0DPOLh8=; b=LPUcka3eGTiIGHBmN+jN6tD2OggnnXUsnwJMJNuCl/xIw75bFKJ
	VfsPxFl44lAg5Sgb+HTtBP4Sfz9UG3cPKd4e4Rx0kZY7x2hhpqVFWqBYMcfRtMYs
	Ucv90KHS+0KGlZfYtXEg5ZtLJEtfqBtW4OhtWuvMJjwR4SveV8wKQSre0sjOfAjp
	mFuFEJrdieD0Tb9DDbJ12Yctvl5Iz1oFSJK02830/bPL4WTZOa0xuKTxhZ786Dfi
	M+ETTVQRkMGlSydscpO/Ef8CJnl7MHpQ0BdQZq/aw+iXtLmZH+kPaYQKra6iC+ll
	PXAVv9k3Ad3mN982BTQQkDuu1bKxt+PS66g==
X-ME-Sender: <xms:OwQ_aIW5ysnloz7SBYVthK4AfAMZwUfSSVcYM4W_7EkrcS8SaU-S_A>
    <xme:OwQ_aMmXkLI89EMTX5ASlT6jpr34yvEAmT0tyrjCYJezqoMSQdDQifcDy9MV0ljsB
    oEa33kbYwUP8emAjg>
X-ME-Received: <xmr:OwQ_aMaOmyIoNXt3stMotjGpk2UGUGG5JdayeQsSVqU2sqozWmuEIJdR4_iQM-lML5VBHhv15Cs4jMdGL1Bx3Kr3IXUCeNLuChg73SXbjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeuieeuudfhvefhkeeigfekgfegleejtdffteehheethffh
    vdeludekkeffhfffvdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhufhho
    rhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OwQ_aHUa7RUPq_vTsRBaXcf4jwygAaKXXpwiqoiJDgtG5ubxlqejPw>
    <xmx:OwQ_aCkm2XHaUl93XPVrPxa7-341JDkGn2xFZi1aysoCGWgICXvf7g>
    <xmx:OwQ_aMexcM5wDoEDd4P86us9Mozldh7Y1-wP-5UjlMGlMlEBVTiMLg>
    <xmx:OwQ_aEENxg1bIjYnKXANgwayyMnAE069VoeviKLNlMW4zjVDptiVBA>
    <xmx:OwQ_aA-nT4fjZLDNR2DQaE93UJW94v6druXgWFlV-52iJ5qPbPxgCmnz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:18:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32811f6e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:18:33 +0000 (UTC)
Date: Tue, 3 Jun 2025 16:18:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 03/10] t/unit-tests: convert reftable block test to
 use clar
Message-ID: <aD8EOE1BWWfXxOij@pks.im>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-4-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602122559.208780-4-kuforiji98@gmail.com>

On Mon, Jun 02, 2025 at 01:25:51PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/u-reftable-block.c
> similarity index 74%
> rename from t/unit-tests/t-reftable-block.c
> rename to t/unit-tests/u-reftable-block.c
> index 52f1dae1c9..5d1419b801 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -6,14 +6,15 @@ license that can be found in the LICENSE file or at
>  https://developers.google.com/open-source/licenses/bsd
>  */
>  
> -#include "test-lib.h"
> +#include "unit-test.h"
> +#include "lib-reftable-clar.h"
>  #include "reftable/block.h"
>  #include "reftable/blocksource.h"
>  #include "reftable/constants.h"
>  #include "reftable/reftable-error.h"
>  #include "strbuf.h"
>  
> -static void t_ref_block_read_write(void)
> +void test_reftable_block__index_read_write(void)
>  {
>  	const int header_off = 21; /* random */
>  	struct reftable_record recs[30];

The name here still looks wrong to me. This is about writing ref blocks,
not index blocks.

> @@ -220,12 +222,12 @@ static void t_obj_block_read_write(void)
>  	struct reftable_buf block_data = REFTABLE_BUF_INIT;
>  
>  	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
> -	check(block_data.buf != NULL);
> +	cl_assert(block_data.buf != NULL);
>  	block_data.len = block_size;
>  
>  	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
>  				header_off, hash_size(REFTABLE_HASH_SHA1));
> -	check(!ret);
> +	cl_assert(ret == 0);

All of these could be retained as `cl_assert(!ret)`, which is more
idiomatic in our codebase. Either that, or these should use
`cl_assert_equal_i()` to give better diagnostics.

Patrick
