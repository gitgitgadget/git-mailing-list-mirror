Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFC285419
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218438; cv=none; b=FI/cqLHeRxnwEie76OP8sU5qJqYnJvmOFdgEXK6FgiNXB9WT3mC74rYaKedIEZS/V+q6H5lWgyjT7dEEspyv30B6w5bbdz60w/0eF0v+6+MN4FTyGa3L6nnfJoprrvPUuSkLye386cVITW8kkov92K/c8suk5OT0XawPPi3HAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218438; c=relaxed/simple;
	bh=ZugDJtRp5Mg8BsrkbCFVA461SQQ49u7gipTUTEf5Wd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaNNtoH0ZKfUNS6qbpYgw3ut4tWEgVAPd26/T+3CPqFdTV7aEmbTnBB0aG33DdnSFeT30GJAe4oSaIbCCjF86xLTOO1RUkDim3WdaWC4whW5nnIDekZG/egkRL+QXNmbYx9t1Zg3n6skvz2GUrnOP1exFZPgIeebpnOmIZDzabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ow5O5l34; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwAljCdv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ow5O5l34";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwAljCdv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 774471400080;
	Mon,  8 Dec 2025 13:27:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 08 Dec 2025 13:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218435; x=1765304835; bh=kw1UVjLIv8
	FKh3H6FzgGWEgtsYXznnB/WTkJ7Bhw964=; b=ow5O5l34Bue4LcECVrfpOIe+Vb
	rek4YYu5IN3hi0cdw1gYge0kFfDtqtOWzllxmr3rTyjoohG+C1lnjAQnBknsQZhR
	4eSnH19WXTDUajKkQjns80pWmPyy4RwBRY5+b5jinuIueMrLyXitKY/u7awOVmkX
	6vvCxre2VazRk7c2tmqF5Woe8/L1jsPTpZqZoN+cEmrVG3tIKKv96KH2F3AtZ/1x
	TLM5VqK4Fp4oCTkiiU1cjZNbREU9cX8N2HRcX5NMmI1AxWC7zWOiLG9uUUiFygaU
	2yjSSVHCNRgUVTmmpp6mQTHHbTDJlLtr/xjxxVEfL7UDULQ8yLVH2T4PzZtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218435; x=1765304835; bh=kw1UVjLIv8FKh3H6FzgGWEgtsYXznnB/WTk
	J7Bhw964=; b=XwAljCdvI+L4Z0wiyXTrJk7O1alsgi1MOnxE32R1uzyjTS8JFNu
	OAk49ipUKx2jIy+rx4Bf19F00DDCXDGAsw1xZpmZZZ1ZXDGT/KQr3VmwKegG+iWy
	Fe+vbp5IO9iHjucvbfuFZ0mWMH2MTf+ufNDsUPI5LwcdeBN1vfPpXwVkO/Y29yn8
	O8Tr2+SlR2yjCNP8A9yyb7GW06U2xHW3GQ4Wkjy5s82tJwEx+52PGlXgGZj1fjE4
	wT4d2uqx66K3r5YW8jV/uUOzky/hvrihnRbA2n3R1PoPf0uND/e6aO3U4BKsbr6X
	pdXRHePFjJyEoxzc5qUIb7bkUUobWqZClcA==
X-ME-Sender: <xms:gxg3aaQYqOI7Nv1VoNCgMbdtUTiLx2FRk9hssaZzo_TzFZS5Gya_OA>
    <xme:gxg3aWq8EpKIqKsNdTIxyBKdXwoR4XYkWne7NtKrqM1R4lzdwRbuFtiX5qjvPD_F0
    djXBi8peCjr_mtw9qvjfiRWPQB1CQkS006Z4oPAUHn_x_xRBDobpg>
X-ME-Received: <xmr:gxg3aQIIDEhPjSJeNnYys5kbSczxUBF4mfBZmSZ6dWC0o65n1XsKSLABWj4YA_FKkLq2GHBfhreCXqwisA8gSxHiBn714A-hfZc49JS29Pc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:gxg3aRpfyh-yz2jaWS1Rz9hFPWFeHvhkh5p23VsYZDhZXZ8sX67ryw>
    <xmx:gxg3aQyXqcfRcL9FCGU4-xjuaNeo9TN3DPBo1RRY_wOCtickh9mMCA>
    <xmx:gxg3adNx9gs3igKXkre9CLys-lnJ-clwGH3DULoMGiGY2ltF1sjGrw>
    <xmx:gxg3ad5Q78AINdTPc4-95Vc0B6A8bWQlgRFYTxNmnrblSzamlDzbRQ>
    <xmx:gxg3aeIIOEyqhVps9Q_uLE80HCyCf76A-JoDXHqTjbeunuLhDCWWxs18>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cba5a6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:13 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:27:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/17] midx-write.c: enumerate `pack_int_id` values
 directly
Message-ID: <aTcYfOZ4_GdIwM9b@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <8288afd8cc40a56999353643f49c48d610e6b3aa.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8288afd8cc40a56999353643f49c48d610e6b3aa.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:37PM -0500, Taylor Blau wrote:
> Our `midx-write.c::fill_packs_from_midx()` function currently enumerates
> the range [0, m->num_packs), and then shifts its index variable up by
> `m->num_packs_in_base` to produce a valid `pack_int_id`.
> 
> Instead, directly enumerate the range:
> 
>     [m->num_packs_in_base, m->num_packs_in_base + m->num_packs)
> 
> , which are the original pack_int_ids themselves as opposed to the
> indexes of those packs relative to the MIDX layer they are contained
> within.

Sensible. I was confused a bit by the previous change because I couldn't
quite spot the shift happening. I think this makes things a bit easier
to read.

Patrick
