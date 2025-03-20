Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE6339A1
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502396; cv=none; b=dEYY2K+lnFU4IbQTosdKKdUKZW3rlWIZ7m63+OBgFLJ2U/tiRa/WFFHvbk32C39xJ8X3yZiumaUQE9pa0lBqbzN2QSv1VxsdVHTkePx4i1hOP/fb4i9iy7b4kN/xJoTSXIcg62YhMN3d4N+ibVzBMRF0V4a1CeQZ/t/LcqMWb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502396; c=relaxed/simple;
	bh=XGml9SNxAl5COAmzSlPvMvVuGLJqrshb18KvmTed2X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7RLKHRT5Ixp8bReVRFh1xVx6rQVnMtSd2ntK1QZj0zsyHoVaUFtvew9NrbQneIJcXPdQGSlsrC0SZGtrct7JpmpWXWIpB18vMegSQh/xHqJvZ1RLa8ZKdZTGte2coCd82KC1xMKu0TUdUfeqsM8b4dd6S4ENToJfrSCyP7vMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQcq2Af+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPNxEXK+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQcq2Af+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPNxEXK+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC49D114016F;
	Thu, 20 Mar 2025 16:26:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 16:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742502392; x=1742588792; bh=bEb788GUBd
	ChPIyWJPwkYvu0lXj1p8MXitp3ChQcubM=; b=EQcq2Af+aFNantM2XCE5Ykesr8
	/2oNxpuSpcp6S8mgPim9k2UvypgTe9WD4XBugYwLbZdAeHdyWlhj+pKPk84WnSCe
	OA4bM4105xAXTueppa3Qii1z5JwO2BMfXUBco62qXp4S4UY9SCMi6Ev4EoZh/bwy
	2G/QueEyROLS0Tnd4Opsukv8S3Zw7qQBncPGSgAbAfFiRWUEvpn0jilgLjl0RbaP
	LIabj3FDXZzLmGCfhzwu+pAFIRoOGdEbR6mSLLZyfB8JedA0tFsGcfH5DRD5AEKp
	7gXdVa8PdGFjWcdCsSt21CL3sAhn09vK/RRGh6T0b8Z05oHiw5NNQ1brxBsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742502392; x=1742588792; bh=bEb788GUBdChPIyWJPwkYvu0lXj1p8MXitp
	3ChQcubM=; b=HPNxEXK+Tdk6Ibn7NJXiuYl/E4FggBHB9pxspekOKVRaKEMI+SJ
	bClnY9v7l3jIzML6eElFbUG9YGNFk1SDP7yPVKIBtISrt6qR+ecjpFgIRnzdc6NE
	ZZ5WPXcI5G+BJrGrR7KSPUCyQxPt6lYTLOgGAMx6uwkEZHoRCCfUzK+RGVGBsfPL
	GFMeAMfI+9EdkOFyDNPA5JX57p42vuDr53T2EszuhQ+S/JKLjqi2v+/3PiJGMWAM
	BX/rYuIWy+zYZqRQdDgid+X5Px659oQpF/yjfYvXyFaMvoIkfe3v60oRGCdUWeMW
	sJE1T5YuSoiPljXPSYF+MuHFzjaxbQZBiug==
X-ME-Sender: <xms:-HncZ8yvNwzXmQxjOw_k6pzJvqbzub3YIETGxgEiBzMDxJgtJs_8lg>
    <xme:-HncZwQ-rXvVFzijXeRRDz5tArrmQ7OQGs8I3EDSYCrPpKl3XGKtHUGsnTdnHNUdo
    a25xFL5diZY25Ii_w>
X-ME-Received: <xmr:-HncZ-VXi-klB5lokai9YuWm-F4W46pbWrIAjmpjcOiab9hze5i8d4spMui2g9xb9v-pVhgUO1ctWmuG84aFhJBm68kSe7YgbeIZbIKMjHGhkmLr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-HncZ6iWS4NQdRl6NH1oOnuYfzoSTVBRx_eqa0EOGZ8-R7QvS-NO1g>
    <xmx:-HncZ-DZrZ8A4Byfx0BfzhS3eul8ya0wwrTnWg-8kPtkawFv2dxaWg>
    <xmx:-HncZ7KgK8rY_XtGfUvx88rPbjGKUXH_4WBVuFP8oZsZqkqfV9wcRA>
    <xmx:-HncZ1DpqDlfkJIzIlNZRmcm8QNCZOIdBwWlKBe6R59fQGJgOx4E5A>
    <xmx:-HncZx9SMBXZRzJyFco6l5x-DUhAdQ6xqLqMK_PYgLXe54MJ13rhlOaL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 16:26:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b0c67f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 20:26:28 +0000 (UTC)
Date: Thu, 20 Mar 2025 21:26:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 5/8] refs: introduce enum-based transaction error types
Message-ID: <Z9x578gHJQPCYU4v@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-5-3dcc1b311dc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-5-3dcc1b311dc9@gmail.com>
X-TUID: JsaneKqacl4B

On Thu, Mar 20, 2025 at 12:44:00PM +0100, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index 240e2d8537..dcd83e81e2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -16,6 +16,29 @@ struct worktree;
>  enum ref_storage_format ref_storage_format_by_name(const char *name);
>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
>  
> +/*
> + * enum ref_transaction_error represents the following return codes:
> + * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
> + * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
> + * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
> + * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
> + * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
> + * reference doesn't match actual.
> + * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
> + * invalid.
> + * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
> + * regular ref.
> + */
> +enum ref_transaction_error {
> +	REF_TRANSACTION_ERROR_GENERIC = -1,
> +	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
> +	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
> +	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
> +	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
> +	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
> +	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
> +};
> +

Tiny nit: I think it's generally preferable to document each specific
right next to its definition.

Patrick
