Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848F29CA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998898; cv=none; b=dozUZNk5viOPdPqwu1/LdYTBCXCRWEKE376is3/NP7K1NFlgeXZ/BEcOuYdvOMADgo7rrTa1ROYVR7KGNyZcKNZdMQXm7B9osN6gi6Ai+ppc2lQ6nfzNE6rknkEERsTzr3TbMEyHDv/nVpODlkOss8mdRfzpNuh5N24YBtgqqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998898; c=relaxed/simple;
	bh=8dUygCE2OQV1AyXi8VjQm+1HL38VYY0p8kWyx+haosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+UQebgulbVNxs+UBzxs4aMPbuq14qF6L4HjzUtfTZ0PRxbam1PDawyHJWObzr6bCYeThuVE1JcVa5z+6qSZ3dv87nwzL8Nr8+9fVawJIBfE3cNwOaBjE3Db5RXnJJcbdkTzHrIFv2BpvLaWopX46kH2w7p8Cvr/6QIMIrBYmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QJTIg+Mf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezvnPMfe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QJTIg+Mf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezvnPMfe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F281138014C;
	Tue, 19 Nov 2024 01:48:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 01:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731998895; x=1732085295; bh=KKuuPVy+8H
	CxGbFeM+blCpPgzwILv5gE7c7c1bf4acw=; b=QJTIg+MftrO9ZYL5V28EVD1GpS
	B1+VoR4yhjiIUhE3IG3mB4hpdV8VnBfQdpg8oMampivjyaTSmF7IODssYsqVQx1e
	W82dmSVdpFVSRsrFjoscu5PR1atpUq3KrjleCX0kw6fgoyNiy66QPsYLRmm3NCoG
	N41J6jq8TWVxY/0cOymsokLnbI+wqVchO1EXCT5Sg71Hnb9HqxZ9WXAGwiNQ8PQC
	5qJTLzjzd5PxI0Yk6QsGGKFJtuzU3ernJo5VueIeyA6Up3eXPz9PxR48HtIlAI+w
	3JZGMP8PRRQRrYDjefrf0V5Q5t4Linhj6nC7zdwREkoVHzic2O7SP6DRnieQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731998895; x=1732085295; bh=KKuuPVy+8HCxGbFeM+blCpPgzwILv5gE7c7
	c1bf4acw=; b=ezvnPMfeNLptBW0SG0cipSheDB6ltkGmf17VlsyuV7Nbbaxktin
	Gr1H01XoeNDGyowzmL0hYZ9cBcdj+LnzDYN7/wtni13xXfT10CjdbXzoqrinoSOI
	3jCm3E28jICEfKTmQSAzi6dmw0ONCsUA7Qh8h4FV8dylS/cx7Xbo+vI3ottDyiIB
	mCKtuhoimH2BIGFbZ/ECEDYUaWHZeo7tZbSnvzCEV5hxMJW+owzKk/tpysnUhmiF
	77TqBcc+rj2dy47lW2JQfVAdxAS/Sj5IZJPfKiOXwiHVzlGjrlB2ytqD5naxtIR9
	yCFZ98lpruB5wq/BNVgy9n6mlgGDwteb5Og==
X-ME-Sender: <xms:rjQ8Z0iJPaTZo4jn6RkKg4Nt2fGwWm27xoSlmRxzJlEdlKkzEKFXKw>
    <xme:rjQ8Z9A_4H2rpLp-ul3Mjl-FJuCXNPBRIgjBmmVWRHf6-baDK2wXaLvgawSrxqKd2
    aKQThf9j2lN5t5D0g>
X-ME-Received: <xmr:rjQ8Z8Fj8DxZTyTx-X54_NWiRX2q5LlH-EtU7KXnvEvI4kcRFJyege_DBw5x3OrAZ0Eap7PzFwbbKpvBn-S-2FWbpBwPMIYWHttu7BtduEV_We4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthht
    ohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:rjQ8Z1RLyYR00NMHZt9HAW1pTi3xI1uYgrP0RVo8zLiSV5cWYo4SMA>
    <xmx:rjQ8ZxxPFukGYMkRJ_YSNwrkakQX0vmzNK6-bCVAuEKxGrsP8PRiUA>
    <xmx:rjQ8Zz5zSQBh54ck2IQTSqQDEdpMV9bWOFfVkPOvrmjuuOogL0pn9A>
    <xmx:rjQ8Z-xWlZCxN21P_sM8B7-yX5fdgzR5ZIWMPOuiL9nEn1S_N38xjg>
    <xmx:rzQ8Zxfp1whKRGR9iGJjpYCD704V-caCQIpgmnRkMa-O9N_BjNIYWQKj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:48:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5e3df04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 06:47:22 +0000 (UTC)
Date: Tue, 19 Nov 2024 07:48:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of
 refs_read_symbolic_ref
Message-ID: <Zzw0ooX0HFwSit7v@pks.im>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118151755.756265-3-bence@ferdinandy.com>

On Mon, Nov 18, 2024 at 04:09:21PM +0100, Bence Ferdinandy wrote:
> diff --git a/refs.h b/refs.h
> index 108dfc93b3..f8b714ca1d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -83,6 +83,12 @@ int refs_read_ref_full(struct ref_store *refs, const char *refname,
>  
>  int refs_read_ref(struct ref_store *refs, const char *refname, struct object_id *oid);
>  
> +/*
> + * Return 0 if the symbolic reference could be read without error.
> + * Return -1 for generic errors.
> + * Return -2 if the reference was actually non-symbolic.
> + */
> +

Extraneous empty newline.

Also, how about the following:

    /*
     * Read the symbolic ref named "refname" and write its immediate
     * referent into the provided buffer. This does not resolve the
     * symbolic ref recursively in case the target is a symbolic ref, as
     * well.
     *
     * Returns 0 on success, -2 if the "refname" is not a symbolic ref,
     * -1 otherwise.
     */

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 2313c830d8..f0ef354bce 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -673,6 +673,12 @@ struct ref_storage_be {
>  
>  	ref_iterator_begin_fn *iterator_begin;
>  	read_raw_ref_fn *read_raw_ref;
> +
> +	/*
> +	 * Return 0 if the symbolic reference could be read without error.
> +	 * Return -1 for generic errors.
> +	 * Return -2 if the reference was actually non-symbolic.
> +	 */
>  	read_symbolic_ref_fn *read_symbolic_ref;

As proposed in the other thread, this could instead be:

    /*
     * Please refer to `refs_read_symbolic_ref()` for the expected
     * behaviour.
     /

Patrick
