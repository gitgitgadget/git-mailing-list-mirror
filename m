Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A01269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218362; cv=none; b=dIbRhPJuhgd/E5KJG9TCmcQeY98XE4+x5yeU7Oul1VIpjXA9HEoXX/KzKfvEfUykmDtQMQBV6frGZ7+bRpdFJ6Q4RYhUF6+ZbHJ7EWejWsvefzAJycT4wbtexy0SsionY9q/AkyhN0N73laXXKvDvqzwO9IgfnvYXsBbGi0bnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218362; c=relaxed/simple;
	bh=QhiZ4K930B7/zCFxYktPwQqmpH9jweQHNkYYOG7q9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GagzzyfxaNWh2kePsiJML3veIgtk4Pzf+AbPfn7YPz2GXnL2cY9FJ1Ht0/3VQE2DEllB3Cb0kQPBpq5ZGLss08CA55imRdURw2/FFN6N9TSkoTJXYYP1okITkpbFHPC8hgtoOxOn4nOehPXRBgVTrAOA7yc/0f1UJOci19h5FEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a03mw/5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqVBRSAQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a03mw/5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqVBRSAQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C9CDEC056D;
	Mon,  8 Dec 2025 13:25:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 13:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218358; x=1765304758; bh=mSaV0Mib8E
	gi6IHKbUMtNLl12RBMVPeEkVkefmm9RH4=; b=a03mw/5gQaQXs/E1Q5IrIbrESd
	VM1VmKLEOtyxaKVpDVE4U+LgdO4Pa3DI/RLmxw4RzP1jzYkw/PI9sc7zREHxv/p4
	B6rQkEA2FQN/dWR6QIUqwf9Yhs68PQYerePdIHTIKN0Aeg42PKCYjiEMspgs87cW
	VdS+k/3dptyW7mFXaC4otgloWj2kIwHGoBhNUnMPigbTBUblYTkB90c9wwuiucro
	/Y1bDyFjd4IUo/rWlS+GZzM4B+sGSKo8sxVA6kA2ZqnB3oqPKuFLp/1uF5aElaLn
	vwNaRfTTbXGxM2oP4E1iEmqkpwXgEvFsHApYOXdyxVUeduC9A+CSokpy8SfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218358; x=1765304758; bh=mSaV0Mib8Egi6IHKbUMtNLl12RBMVPeEkVk
	efmm9RH4=; b=GqVBRSAQ6KvLCpnbAUEgkvjAvEuWoqPmfJqjMsVMoIcxYjLT6HJ
	D7bvFb8Xjm7ZgW2AfLAdtyzesj8pjhtqI8l0h588Y8L7Bt88ECMFfYHl71Y9mj2u
	o0ddl4uBIdiIkSBSHvvCBV9EfiWLb2KiURQc7g3WhI15RDppUzpjHrS8AK9320e7
	qJRcW4GJXOtZX3o232RWzc6cBZd2+sByCP7I3sm1tNC0gOJJZW7Pc83iEA2FEaom
	VimYGzCNaUluKLmrVW6udgG7LSALoozPyBhUS48z80EfhSs89P10SUX3HhMH46ek
	AZwic4iFP140Qw2wUpQdCeaA54RJa3qNn9g==
X-ME-Sender: <xms:NRg3aY_WR52LgpJHjpYpRSGZY-SIV0AAWYP5V6hEu_VSjoUh9FMyKg>
    <xme:NRg3aXm7W2vDt_S6MXXe61sP0FVAo_SL3bYwxbYbWIlDp5jQy4vRCyH2L2dceLMo8
    qURrmdme8HK5Plks6ofa9Mu4Zz1zYrLS6wc2_2e0wngA8-xQm4TjkE>
X-ME-Received: <xmr:NRg3aWUbHIX7NQAkpq3RQbIFY5iyAKKNbOg_yK1iAC9r4yOD5oGbFvcqMN6YukVwrHstLgdFJusdwHsiLA92oPj3nij4xnvmo3XMouitc5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:NRg3aUGSUUqVV3sjunZUtkvGKtxUJHQuwaBx05kiTTo5whc39JW5sA>
    <xmx:NRg3aadoI1WLpY9Fn4mksU2Tc0X7a8s19OykqJwRcGqIuhUNaTZXKA>
    <xmx:NRg3adLyCWDO3JJPE3jVdkOmS7LFt3X8GCUGpPKSdcCE0bVihFjtHw>
    <xmx:NRg3aXFXNiBRys8UiokaUXw2w_i1phM6ojrOAj_cpA9Vg8V21-48tA>
    <xmx:Nhg3aQk6sFfBt2KLDZk33IC-oMofxoNEGJWXQJvzktFnAi1sVAysSor->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:25:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2a3054b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:25:54 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:25:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <aTcYAdJ6lNCST7PT@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:04PM -0500, Taylor Blau wrote:
> When trying to print out, say, the hexadecimal representation of a
> MIDX's hash, our code will do something like:
> 
>     hash_to_hex_algop(get_midx_checksum(m),
>                       m->source->odb->repo->hash_algo);
> 
> , which is both cumbersome and repetitive. In fact, all but a handful of
> callers to `get_midx_checksum()` do exactly the above. Reduce the
> repetitive nature of calling `get_midx_checksum()` by having it return a
> pointer into a static buffer containing the above result.
> 
> For the handful of callers that do need to compare the raw bytes and
> don't want to deal with an encoded copy (e.g., because they are passing
> it to hasheq() or similar), introduce `get_midx_hash()` which returns
> the raw bytes.

This is a welcome change indeed.

> diff --git a/midx.h b/midx.h
> index 7c7e0b59121..e188ffeb578 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -85,7 +85,8 @@ struct multi_pack_index {
>  #define MIDX_EXT_BITMAP "bitmap"
>  #define MIDX_EXT_MIDX "midx"
>  
> -const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
> +const char *get_midx_checksum(const struct multi_pack_index *m) /* static buffer */;
> +const unsigned char *get_midx_hash(const struct multi_pack_index *m);
>  void get_midx_filename(struct odb_source *source, struct strbuf *out);
>  void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
>  			   const unsigned char *hash, const char *ext);

If I didn't have the context of this patch series I would be wondering
what the actual difference between `get_midx_checksum()` and
`get_midx_hash()` is. The way the functions are named seems to rather
indicate that we talk about two different kinds of hashes, rather than
two different ways to encode them.

Would it maybe be preferable to call them `get_midx_checksum()` and
`get_midx_checksum_hex()`? While at it, we could go even further and
rename them to `midx_get_checksum()` and `midx_get_checksum_hex()` to
conform to our modern best practices.

Patrick
