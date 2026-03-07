Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145D1A682D
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861715; cv=none; b=KsGA8ZCL+XDVOmfN5yw0H6wQaeeb1VMKnUNQeoZWAbm/X0ucw+jjTB9NufMIDjVojC/5gnarOdnK0jDIycv9KC59hN7hoT/znaiSbNyvwFsv3PYovQBXzM1QUQBue9Jy5zQn7M7BwVY1AEZOr9z4RsOE+Mf4ATQIE5RIY8EVdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861715; c=relaxed/simple;
	bh=A9sBiDBuyCK45aI6TVOafUs9x2WYQby7Xz0XydCjc30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mIxzPRZ8rlxwZ9sQUSkKAEUB3tEX3HBOL+AdWWrZNfd2V6QzptiwNe56KMp3+3ghLodKGdWkTPtYw/mA7/No8sti23iE4c8AfH67Aahp7U1FwkZ6YyOW40JB9q0pxA5OVwaIl8TmBLda3E/QaFl3U83ybGiPzazdZ19ocf2avHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vvx5/2GA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RprUWW7i; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vvx5/2GA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RprUWW7i"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1751A1400109;
	Sat,  7 Mar 2026 00:35:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sat, 07 Mar 2026 00:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772861711; x=1772948111; bh=r9nyBobkX6
	dVzSGLWNdUgCn2Lj4nejqtaukFXu6OlJc=; b=Vvx5/2GASINQ1TMTYDcCDIR1h/
	RDR7C3xkpwLj0RLkgMZj2q6eA4BJ4CZoUc2omHdYeCP4taS1k8umsc3MdK9EL1UY
	e80qD7wES+ruJgF9DCey7ooHqSoYtEZfGUPxpq261/VXGdp2tp0Iy29+5KJ74wUb
	AhzSeIhjOL9o+W75uZIyEi1EUIFpYbaeqK0Yaqad0F1/nS9e8AHmUzSZCkRzn+DC
	M6IuIVfIIn3M4Msg8S64NTEB4jg0ESjIGW+9Cz+ROWRbPnTWZMfMcvshPXWkmWGj
	C5PNHVGi4Ou663/OQP6zIeWeS1tS8rSJzdr99+8M9k7wMKrtEMd91NMS4esQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772861711; x=1772948111; bh=r9nyBobkX6dVzSGLWNdUgCn2Lj4nejqtauk
	FXu6OlJc=; b=RprUWW7iUdok1GZzapLqVcL5tUwN1fMmnsPvEsHp6/n5BAkwhKg
	FjVhSJtttva2XO4Dyk6OR6JqeGT96a756PUOSLNo+yuFP72gl5aV4Vi747UpFDFm
	l8M60i7lqDuUsmuuveWA6+It7F1bm2PMKly+JBE0HNSyCc7bmuM8qLbZS2TdvDn2
	TMJkSgIYUPWaK5PtkgWBmiC8DxHoTVUUksdQMRYR3w1LE3F8aP4j4+XgQX3JUvpV
	SZiwIyFytB4rcSVUlGpi7t/grzSSGdxt/ZGG4aUUeltAS5NUGQGU7c+bCKqVmCLP
	cG5gmZf+QRQVtzsp2d+blpgiN6tcDVq+a3g==
X-ME-Sender: <xms:DrmraS-woigsH2GtitKoqSruCTFAsi1zKCcOdZZLDZFKIUxWcIkMwg>
    <xme:DrmraZkkEMCkYQlxk6h--W0TSWdPxw76lTieS4lHaTiyG1lqsaS3WVJ-hl48OC4ER
    lsTPl3agLkMcR1FVCpjZ4rhryRUjsZdYzdyJJfF34ItTn3Oo9OBxQ>
X-ME-Received: <xmr:DrmraQWe31UlWEFJuZFrg1U7ntEDr7v0iAJhf-2LhpsnLZ_teSR3-e-nycx6iv3AbJePZaHdPZhsHs8HrTQ1CduBY54DKoNUeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefhvdfhkeehieeukedugfeljeetuedugfdukeetvdethfelhffhgfefvdfh
    feeknecuffhomhgrihhnpehmrghpphgvugdrihhtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhn
    thgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:DrmraWHwawBlr-0gk1fnSXAWUkGMoBhsRgusPRTWHU4t3_ybn4Pzbw>
    <xmx:DrmraUc8bhR7LRnmJu_sm2IdRoIdOmE3FgBWxdxItKtoIvrNTyCAcw>
    <xmx:DrmrafLNh-RL4wMIdb2KciUlHCbuojZ1V32ZNlEuzSaIcDhKvZXR3A>
    <xmx:DrmraRFkK15VZItve7JU3x0TRToBI123lQGIllprQ9UiL39AYb7yNw>
    <xmx:D7mraXhWEYsE7aFEPB9BaZQKdLBIrxiAXG_ikb2LqFateDC-L3XfhE_c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 00:35:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3.5/4] object-file: fix mmap() leak in
 odb_source_loose_read_object_stream()
In-Reply-To: <20260307022459.GA693632@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 6 Mar 2026 21:24:59 -0500")
References: <20260305230315.GA2354983@coredump.intra.peff.net>
	<20260305231305.GD2901305@coredump.intra.peff.net>
	<xmqqqzpwv3t7.fsf@gitster.g>
	<20260307022459.GA693632@coredump.intra.peff.net>
Date: Fri, 06 Mar 2026 21:35:08 -0800
Message-ID: <xmqqv7f8td6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Subject: object-file: fix mmap() leak in odb_source_loose_read_object_stream()
>
> We mmap() a loose object file, storing the result in the local variable
> "mapped", which is eventually assigned into our stream struct as
> "st.mapped". If we hit an error, we jump to an error label which does:
>
>   munmap(st.mapped, st.mapsize);
>
> to clean up. But this is wrong; we don't assign st.mapped until the end
> of the function, after all of the "goto error" jumps. So this munmap()
> is never cleaning up anything (st.mapped is always NULL, because we
> initialize the struct with calloc).
>
> Instead, we should feed the local variable to munmap().
>
> This leak is due to 595296e124 (streaming: allocate stream inside the
> backend-specific logic, 2025-11-23), which introduced the local
> variable. Before that, we assigned the mmap result directly into
> st.mapped. It was probably switched there so that we do not have to
> allocate/free the struct when the map operation fails (e.g., because we
> don't have the loose object). Before that commit, the struct was passed
> in from the caller, so there was no allocation at all.

Makes sense.  Thanks for finding and fixing the issue so quickly.


>
> You can see the leak in the test suite by building with:
>
>   make SANITIZE=leak NO_MMAP=1 CC=clang
>
> and running t1060. We need NO_MMAP so that the mmap() is backed by an
> actual malloc(), which allows LSan to detect it. And the leak seems not
> to be detected when compiling with gcc, probably due to some internal
> compiler decisions about how the stack memory is written.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index 3094140055..ab2fb9c4eb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2197,7 +2197,7 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
>  	return 0;
>  error:
>  	git_inflate_end(&st->z);
> -	munmap(st->mapped, st->mapsize);
> +	munmap(mapped, mapsize);
>  	free(st);
>  	return -1;
>  }
