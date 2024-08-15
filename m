Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1D29422
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715479; cv=none; b=iIAxbgfAbYrF126NPfbTMevh2CBgv0sbkWqm12ugi9Qtieb2tzd6b9bQubZCsP/9/lMuorO3rkY+o5+9xHkZ8wv4iPMhV7puHZqKSICITAWTgYq3u/FS3C+G0M+nGsynGEP5UixNePBro/ks+RxPm2Fv3R1HwjVsxznR63hJtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715479; c=relaxed/simple;
	bh=veXp1Fxa7elblEJIvQTjmk9/pVicbOvHDtdP4FiKSJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT0NauE3SndamirznRic5ByZWF5+UkpTlMp2Q3TDBPwaWEeY/rsrExzuyrZyJGq3ZEqKnPT419Io5YysF3RfyhW4SQCY6LQd0mn3iT+TEOgBJwS1msAjE2qNkGCDvqMuYhJ67pMjL2/YoaY7+lQqxOE8BbEvybEXYlO6uoyePXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjUqLMnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+aoZQGf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjUqLMnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+aoZQGf"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E1F0D1390076;
	Thu, 15 Aug 2024 05:41:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714870; x=1723801270; bh=77OXnHg9g+
	QSotp8I0z0enaCWp6+ZyhWLamVb9TQ26E=; b=MjUqLMnHcpmjQDHWQJsdy/eh1J
	0ewaBzobTvYO3iJ1A3Vv0mnA/M3qra7wKmxYk5Rbx2jHN7Prwj0FFy9NThm4z6r0
	aIu98LZ15juxNNjbqB4nyeI68K+9JGynJO/EFPTIqMaelaZUzdjDUOGx7rndbNbL
	Lp39b05F5+JG2svn00k89z46VAh5yPhrDHwonubHrJxjrXFpAaCfEfE4/ZqWzaIA
	/sEc7jl7VFRUfbdo2U0C4cK2FRM68DiVQxnLBRFki4utqpc5PC2El4kuxB8aFKl+
	ZRGTXTp76raFqZaN43NsMjQKMMScuS/5u1pkAyiWhYXw/257M+v+vpCs+UcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714870; x=1723801270; bh=77OXnHg9g+QSotp8I0z0enaCWp6+
	ZyhWLamVb9TQ26E=; b=m+aoZQGfvuAjWQ1+QYtAUC9/H2J2AuIQz46l6nItdYGm
	zrEMVEQ9ELR6vilXGkekWaLGJyAbMAl4HRLg4PW2vTyUPZ4gQCvndNMxrvEXURrz
	q4ZsgvpN5TwZjbfE+/2/pmoWWjSTghQdoW/a1NWvLhQsEJeO1ndauT8JZtR2TVSc
	5lzWGHUVok98wc8IaKk+BRTEuvQaeO9zVR5U51GbDz5+lvd79Gd7caP361hlmv9o
	JHWy/WUuVrumorN3eprWp2d8/b/QtKwVYm7sp+f+zLssBKZCjSc7T9kJSESOjBlf
	sLgOTKjtPBn9EGLQV9URcBsd6AIeQJCAuf9ZvZerEg==
X-ME-Sender: <xms:Ns29ZrCIzim_aG5tERJj4ulxaXOYxMeItkDx96S7e9otW5TzYF_5Bg>
    <xme:Ns29Zhhv9EUn6gsO3QjVpOZoy2uwsmpyb6P3-aR1l9lG49Qg7dJeADTngtTGbMBF4
    0nuCBCak2_MoRPryg>
X-ME-Received: <xmr:Ns29Zmk1Y5ag_dfDB6kwAztBAgh6zaKP6IgGLhxU04KF0Gcdg9M8S_p1RYw-Oo871dHn11kRSkSMf5D76hXU6vNjugf1TGQOleDUmwkukfO89Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ns29Ztx_6blm2C92TNBzSn0Lx__fKbxSFBpp1rVE8jn0A3d7Xwyjmg>
    <xmx:Ns29ZgTdXtQxYW619-BzjE2skyJkGv1wFTFucTjoixrVyOCrW0ezdw>
    <xmx:Ns29ZgZPjF9e5-Y9GvMAcmlTFUz5Xqf1F0EmLj3KbezqUw0O1cdFDw>
    <xmx:Ns29ZhSb4j1KEtK3VXf-Ya33VWbnCsUfWKfK2Z-dpmxmixHWsiKOFQ>
    <xmx:Ns29ZmdPsYHLtGHrv0yCVSqXh0x2TwytouIhmvLGj9gPCk7ISnMXnnv6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:41:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b96c00d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:49 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:41:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/10] t-reftable-block: add tests for obj blocks
Message-ID: <Zr3NNBTXNXSCrTpJ@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-10-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-10-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:17PM +0530, Chandra Pratap wrote:
> In the current testing setup, block operations are left unexercised
> for obj blocks. Add a test that exercises these operations for obj
> blocks.

Same remarks here as for the preceding commit.

> @@ -186,9 +186,88 @@ static void t_log_block_read_write(void)
>  		reftable_record_release(&recs[i]);
>  }
>  
> +static void t_obj_block_read_write(void)
> +{
> +	const int header_off = 21;
> +	struct reftable_record recs[30];
> +	const size_t N = ARRAY_SIZE(recs);
> +	const size_t block_size = 1024;
> +	struct reftable_block block = { 0 };
> +	struct block_writer bw = {
> +		.last_key = STRBUF_INIT,
> +	};
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_OBJ,
> +	};
> +	size_t i = 0;
> +	int n;
> +	struct block_reader br = { 0 };
> +	struct block_iter it = BLOCK_ITER_INIT;
> +	struct strbuf want = STRBUF_INIT;
> +
> +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
> +	block.len = block_size;
> +	block.source = malloc_block_source();
> +	block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
> +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
> +
> +	for (i = 0; i < N; i++) {
> +		uint8_t *bytes = reftable_malloc(sizeof(uint8_t[5]));
> +		memcpy(bytes, (uint8_t[]){i, i+1, i+2, i+3, i+5}, sizeof(uint8_t[5]));

From the top of my head I'm not sure whether we use inline-array
declarations like this anywhere. I'd rather just make it a separate
variable, which also allows us to get rid of the magic 5 via
`ARRAY_SIZE()`.

Patrick
