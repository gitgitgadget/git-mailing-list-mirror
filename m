Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B82797AF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405478; cv=none; b=Q2cCzCgSYemX0QPF/nYv+CFP+DtC1IMuwq3k0EVLXdiCeGuXk3WwRn5EguHwN3FCASNDOdMveCkdcDIwIJvg/uHowN7EkvqWsWnl5Vs6Ot/O48+77dEun9pHf/fQbB9jvP1kqDmZaRXWXuYV3HO8So3FaLVU7VoufPBOUXUSdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405478; c=relaxed/simple;
	bh=jdNSbzSJbwVNMbpO5SUfIw5WQsADHW0LafVNY99IBuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEjFVsMNq9VGVwqxBlb8MEekfPoYmw++Lkl2QmV4x+dhpHI97ELuSNr4Vf3aITy3UMkt/LyOcvqAE0I/lfg6ytHQfHAeiE9OoSxLUpJ7zZc7UmCgXGys4TZEtrjhnCSdtEsv0epVrDDoAKBwuuuoiruxBDufKATkIiPffHwHYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XzMwO4Oz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJbc/Zb8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XzMwO4Oz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJbc/Zb8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8CA67A0173;
	Thu,  2 Oct 2025 07:44:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 07:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759405475; x=1759491875; bh=CAxT2LuTTN
	6IPUhFo+4T3QvtzL0ZLU0kVgfGZeBz5aI=; b=XzMwO4OzYnTx9nKeJMbWENkjL0
	9kBhAeKuoZYu5Yi/m+apetuxARquuvHzTPdlrKqZorB7LtWnQs3v95R8mzg7wV1a
	I7/c5gA/C+u5c1gPxEn5DVVBk0gq4mfxExP0s4dJZCpO1zyrgOngtbF/ReZ7YjEM
	nwVrmtZimX3sWbc8gJO2+FnsqFOtDlVNAUYWUiCgFc0ngttMqBvAtGdgkofAd9b4
	00gJ3Z4w5g6fmL+vPXWLm8FnC1XSSPsP8PM1HLLhD4RCHmn+hWVCak00738IA0Qx
	1RXV7QYzVo/Z6VH6rTyY8ZwIJreQ9z/UX1o8ScReZlfvA6hUF10KfA4jkzzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759405475; x=1759491875; bh=CAxT2LuTTN6IPUhFo+4T3QvtzL0ZLU0kVgf
	GZeBz5aI=; b=BJbc/Zb8vSVYS9EQtfa/GbaxmMoJLi3uDGQ9u7JS+PvhYyN20go
	jJzCqyYykBnSX4il7mIPlRSkXwO4UUconvCiIzVdUeZD3aseawE6sK+AgQHM5+Kp
	R/dvgXKFqRxCxCdZYVX9sMR8LQa9m5NteLc9EXvfEWaZGJhOnJZDEhvQQYwFvTnv
	Tvp+GSuBB8nlkZOVB2hjDc9RqhSsOQlPVWZ7KT29R7NtZBqgGGI3BAPyj3FFfhuu
	jSFLbgdiFx9psqFas7MgEP4gyZxe2coFN6JlS8gCPwhrGGOmpzea9+zw8cK0Gqn3
	Whls1+iv3cRUxHwxZNOyzTUmMqUt/sn+bbg==
X-ME-Sender: <xms:o2XeaLdmzHAqfPFDxy3XpH4oXGVen5rn6gHk7pBr8LusQ15KaYboMw>
    <xme:o2XeaIPmMnEMzoFXgB2AtAy5WK5IO0_YpRdC0uCeT9PMO2sohgSOXxMqBRg7iAtIA
    vyN--Nox55P_BwpCTTgu6zIN316yKrUOFNGlGu_0bvyGIGFCuPR-g>
X-ME-Received: <xmr:o2XeaJjlc3a89-sxfQTNkZ6tEt_Qd5MMYPe1RVKEIdGgESLP0MBLAeFGpZ3fFt-qOYmDLfTYBg7gM3TTKz8D8U5p9ctD4xfGpHXh2vm9cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o2XeaL1f3-Dd7mhQ8tzji6K8IN1PsYRL95L7SoUNi3QFcT0inq0L5A>
    <xmx:o2XeaDjHnER5G1rrQ_qr_9AjQLrgBLZryf_XesATYwnzt9LQ60Tlxw>
    <xmx:o2XeaLdw85emriHpemI6O7Bds2D51tgG1rsLo2rdip6aqM64iT1Glg>
    <xmx:o2XeaGl7iow4Ol_ggq3DJnFl7aV2EXG6r4yl27cvYGwc-Dhwob5nVw>
    <xmx:o2XeaND5PF5Q2un5HgnY9_gCgl4lHXEq6jqsJHDleDjzUwp9ZLoE_hpL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:44:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19cab7ce (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:44:34 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:44:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v4 6/7] reftable: add code to facilitate consistency
 checks
Message-ID: <aN5lngvE39JGwGSx@pks.im>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
 <20250926-228-reftable-introduce-consistency-checks-v4-6-c96fd8551c0d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-6-c96fd8551c0d@gmail.com>

On Fri, Sep 26, 2025 at 09:25:49AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/fsck.c b/reftable/fsck.c
> new file mode 100644
> index 0000000000..26b9115b14
> --- /dev/null
> +++ b/reftable/fsck.c
> @@ -0,0 +1,100 @@
[snip]
> +static int table_checks(struct reftable_table *table,
> +			reftable_fsck_report_fn report_fn,
> +			reftable_fsck_verbose_fn verbose_fn UNUSED,
> +			void *cb_data)
> +{
> +	table_check_fn table_check_fns[] = {
> +		table_check_name,
> +		NULL,
> +	};
> +	int err = 0;
> +
> +	for (size_t i = 0; table_check_fns[i]; i++)
> +		err |= table_check_fns[i](table, report_fn, cb_data);
> +
> +	return err;
> +}

Okay, good. We now only verify individual table names part of the stack,
and don't scan the directory anymore. Furthermore, it is easy to add
more tests by adding to the function array.

Patrick
