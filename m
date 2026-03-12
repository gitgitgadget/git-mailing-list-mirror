Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF731328E
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310988; cv=none; b=Yo+qUD4JXHYhmrmGPc95ulyuqG3Bo6Ek6ADu6S0E77MMrTanx/r8dwLfohIxamWu+qmMXlP1KGlG/RM+UdqBVkfWQ9VVfhCmoyhcBBh2nWFMebuKeGkh/3OOrvTkOPVq4VHadH/t6DkViflrlp5ouuZj+DWcdSVcekDpOOe+8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310988; c=relaxed/simple;
	bh=Vxuo3TtrbvWNHBsD7vdggGKSAO12zYVRG768aGijqzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwUg43fsJ1HxUpRqwpAVswkt5Iy8Qlpj21iZ6hNCKjOHUFB/OT2Fgqd1ne+iAVeruwld6S1khvJn+zcelx+zfkNb788XgyTlycK6qzWb5+RlFMncfMc0BGnkKUdlqvYe4JD0kK05I2VCyxKzD1E/AIpYgIBtuVhZvOzC8oGPbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mYTfXgHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lT0D3WPJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mYTfXgHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT0D3WPJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DB501400176;
	Thu, 12 Mar 2026 06:23:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 06:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773310986; x=1773397386; bh=BpkGlUn1dO
	dJQdsa6RdixVFvinCmDOqWkCGZ/m6NqEE=; b=mYTfXgHZhk5Wuo32bG8JRZ47SI
	Cb6JOi8A66zBSkMLCyAztHyxZWcnqaPboIGM+vlfBQ9FKvlKNfJu7K/arPd3abm7
	i/MAeYeLJocVxfovlTUGBEs7AgRvYPG7UHt2uYw1cBL/HfTP1rzQJDR587Q2TreC
	CprJVPOoLCxdl4teGEJ+ImhcVvvyC2XrWMiQcIqcNo7JeUQl6+unGYEe0+hMkeey
	eDG/AvaPEYvI6mE8WSisrG6GGGBgfazOw1kwhLzCadmji5KOiIunUojU9b1l4aOo
	NH8wWV3OKkldMZF4rUdkhfv5uaaR/VOWxbdd78Zzj+Z9yC9bt92VzUcqC68Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773310986; x=1773397386; bh=BpkGlUn1dOdJQdsa6RdixVFvinCmDOqWkCG
	Z/m6NqEE=; b=lT0D3WPJIAo5mjsgRF7zVi4AtT6CFXPUdlwzr8V5bkbb6UhGQ1Y
	RDjt3eR5EdUvUaHthpyMKhzUMbixJQJOmr+XKFGalZ48Sp0bEAaxlxN79aqL8C9b
	Rrn4AqDqJAaqypUdfm9pg8RoXUV97vbK3MrlHq1GsrTXxDQjWaabqgsC519ygQ3p
	ZynuI+99xAQibV7hdKfQvaN3FcCB5T847bY0r8gf3JVxz2fTA0oZ5GMnBgmG1CQB
	5HCSEJvuSkCps1qOc1p1RMEndOJ4WpR+ZXRB+UQqPlHRg8c+D45pNe4SeT1lctvH
	qjUAo/76SbFyMzI/nhMpV/LZ8KZz6Kovr1A==
X-ME-Sender: <xms:CpSyaQojn9SVBMOpjNEy-0fWK-nWLmUKG5Eubm7qtPLnJOvnZ7EEpA>
    <xme:CpSyadjNoZVyjMa8-UcDSSCMcF8HHE2qDOh_M3sVWnFJwcrJuMbkTlyExEq6GDxdL
    BEVQ6TlvjGI-eirTeJhBZVse-7S3KqNX6F1CN3-nIVFv1biGTecfQ>
X-ME-Received: <xmr:CpSyadhHB8tYM4HhhR8YFhiOA_-ktMz3JzAocBioLaYmz3-JcLA7gB1BeiZ1hir_CDRTvxzKihBSyBLiTr4oPIjIaC7bXmqp_xMEfqc04aLV-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:CpSyaTjRZg0UzG8ksbqki5lUIGHH3g2h6Jc9siEakCYZVgbkoDXTXw>
    <xmx:CpSyadIhdbk6cYe_H2OtT2nUqignX48DyPeSz0XhIXzYJW0l9KRN_w>
    <xmx:CpSyaSFs1oDHiiFbTN9q3uUMdxEKrjWa54vkV_VVag5HtgUJngsIZA>
    <xmx:CpSyaRT4FiPPoERPQnnTzJ0rIcc1vUOvrS7ZzhkSiWhGnfK5ZOikyw>
    <xmx:CpSyaQy1MhF-ZxyVDXJTcbnh2gZvknXDAVFAp7vlPuHD5TeMi0TBHsL5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 06:23:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd30e448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 10:23:04 +0000 (UTC)
Date: Thu, 12 Mar 2026 11:23:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abKUBRRgRmbJ1hRA@pks.im>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311173147.2336432-4-jltobler@gmail.com>

On Wed, Mar 11, 2026 at 12:31:47PM -0500, Justin Tobler wrote:
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index b8a7757cfd..d6281ff119 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2865,6 +2855,66 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
>  		else
>  			warning(_("stripping invalid signature for commit\n"
>  				  "  allegedly by %s"), signer);
> +		break;
> +	case SIGN_SIGN_IF_INVALID:
> +		if (subject_len > 100)
> +			warning(_("signing commit with invalid signature for '%.100s...'\n"
> +				  "  allegedly by %s"), subject, signer);
> +		else if (subject_len > 0)
> +			warning(_("signing commit with invalid signature for '%.*s'\n"
> +				  "  allegedly by %s"), subject_len, subject, signer);
> +		else
> +			warning(_("signing commit with invalid signature\n"
> +				  "  allegedly by %s"), signer);
> +		break;
> +	default:
> +		BUG("unsupported signing mode");
> +	}
> +}

I'm still not convinced that it makes sense to warn about this case.
After all the user has asked us to re-sign such commits, so they
probably expect such cases. These warnings would thus result in a ton of
noise in a repository where most commits are signed, drowning out the
potentially-useful warnings.

Anyway, I won't insist on a change here.

> +static void handle_signature_if_invalid(struct strbuf *new_data,
> +					struct signature_data *sig_sha1,
> +					struct signature_data *sig_sha256,
> +					struct strbuf *msg,
> +					enum sign_mode mode)
> +{
> +	struct strbuf tmp_buf = STRBUF_INIT;
> +	struct signature_check signature_check = { 0 };
> +	int ret;
> +
> +	/* Check signature in a temporary commit buffer */
> +	strbuf_addbuf(&tmp_buf, new_data);
> +	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
> +	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
> +
> +	if (ret) {
> +		warn_invalid_signature(&signature_check, msg->buf, mode);
> +
> +		if (mode == SIGN_SIGN_IF_INVALID) {
> +			struct strbuf signature = STRBUF_INIT;
> +			struct strbuf payload = STRBUF_INIT;
> +
> +			/*
> +			 * NEEDSWORK: To properly support interoperability mode
> +			 * when signing commit signatures, the commit buffer
> +			 * must be provided in both the repository and
> +			 * compatibility object formats. As currently
> +			 * implemented, only the repository object format is
> +			 * considered meaning compatibility signatures cannot be
> +			 * generated. Thus, attempting to sign commit signatures
> +			 * in interoperability mode is currently unsupported.
> +			 */
> +			if (the_repository->compat_hash_algo)
> +				die(_("signing signatures in interoperability mode is unsupported"));

"signing signatures"? You probably meant "signing commits"?

Patrick
