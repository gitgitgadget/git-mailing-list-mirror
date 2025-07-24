Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B5190664
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338137; cv=none; b=GwPY/4O5J0RFegvgUTTX56SPBDqDcTiqGXtmECaUXujuo9dItryBQwVJFJiRbRMiXhJJFxuKVY3d+r3D5d7TCVvzcWrrxrygwTMhNtkX+MDGjW3iDpda1Giv2+e8Kev5LSpF6z/mhTGUU6//y/cg0kEtXqtrENNNSw7DGDMtgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338137; c=relaxed/simple;
	bh=Ggy7TqxxOBbAtqk+C/K/9g2c/aZUI97rok8g9P7hC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXksdW7NsWX/1+7g98EKtaE9uFn8Ffg7/5l5/0pD7+y3IeuJmLLRIS6BzCo2SmA8qe6kgMHuxpWPeCk7j+o7ZWKNg2D6tPyKr3WGnBUdXLpu8ZF3Z3WvRXxKZnVwMYTTqDhGGygUyB5nU0hBhdZ+MXGgCCTCot78m8DHBcMSye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vbMIgpnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sz6kUsFA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vbMIgpnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sz6kUsFA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB95D7A0046;
	Thu, 24 Jul 2025 02:22:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Jul 2025 02:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753338134; x=1753424534; bh=aOo3faFkVD
	B7uX9XlEiEZMlcisk9wwTy3nS1sgVraeg=; b=vbMIgpnHKqIUiwiICBRRb8rFrV
	1PZ8oUgld9SPQQcTu4Q9umHO1oz7XAKfF1pGRv4hRRsCSlTfV7waPI/kdY6DuxNU
	5cfSh74L5iLVwg2gM/sqWHhlS02pCEaAgJIRaZMkN8/LUCVJ/WWJ+BdzqsIMNo4+
	87FbXF3uX5c78yVUXKdp6oR6i/5P0vz2Cn7bx9ig02AQ0ITDuwLYjTE5uM8WrZP2
	M+mX3NYxlP0lu2hon20PPXQ0gm8EzkkZNtKog8cP2tx+yqJchGpi0ioZV7rC53f9
	auSNvpXhFUxidLdTtW8QVXImTGjqkxPv3Vn8w9IEdweJSpL0obvreCXH0o5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753338134; x=1753424534; bh=aOo3faFkVDB7uX9XlEiEZMlcisk9wwTy3nS
	1sgVraeg=; b=Sz6kUsFA6pADr/0Z7OsAca8PJ3ScX0sGK1uiJAZA3ERTY/ZZoUF
	9FfTh4krqwCM8hUbtwmPrrlg2RHc5wGuFLgoqRWOQbeSmVkYtyEYpOeq3vn29kbq
	VV2gfFUxtGjsOLP/qTrhFBAlU2/0C2mtI23XmOdm1NkLrqaHCkn0iprz39CKVfZV
	T3jaek6J+MGV0cSHOM2z/qmN2ODUtQNxMX6v6JvbXDGySyoRNhPOC7IBMDlAqf87
	8HP5/oyUNX7PhC+hweP5PHpRx+tRa3OrLp3j2TtZEqLZJSiQkjAmCu20ul54YLT+
	HCLW+YXSxnslt0UJnGBMruF38WMPmw++q9w==
X-ME-Sender: <xms:FtGBaJEh0dPxiDJipEiOPLUJziStLQEIL_HieTnPIMwu0vgl_T6P6A>
    <xme:FtGBaDgfHuxlJA5fxtZAxZqZAXHwoYba1tta2bwh4mNhj1elofQhJxJ1j5gNNjmZP
    5S_oEjHX8tgLflQOw>
X-ME-Received: <xmr:FtGBaMCYN9FmpSwMIez4ytDXOi2OwGH_WfVCY3HHTlKC7RfbyUX5g-uFmb-iqGzzSUptZPEABIFJ5zv62dq8O_j41r3QZGAZCIYn2JEFdBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlh
    gurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehluhgtrghsshgv
    ihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FtGBaFTaq9vpItZr7Vr04b3r2ormTWpstBBSwqY72Oa5JeMoibwfbQ>
    <xmx:FtGBaBVOdz6WatnFsA5mHjWiHo1b_sZKHfYA4HGTq7dc4tBX9yARIA>
    <xmx:FtGBaOfxbIHuQCDgffsf42oaR304nBGmZEY12Mxpw584RPM-Gsh73g>
    <xmx:FtGBaNI-OV33lxsW8APocPZGANX3Vznwj8dfUV4Cqi4pFe0pQLI5qQ>
    <xmx:FtGBaI8is-pe_kgroiMVdFp_XxLVoRveqttwrWXNKKcT8T6svdeOEMvt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:22:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f14cd8d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:22:12 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:22:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
Message-ID: <aIHRETKuPM6gGErZ@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722002835.33428-3-lucasseikioshiro@gmail.com>

On Mon, Jul 21, 2025 at 09:28:32PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index d4f01e35e2..5beae0f781 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,12 +1,83 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "refs.h"
>  
> -static int repo_info(int argc UNUSED, const char **argv UNUSED,
> -		     const char *prefix UNUSED, struct repository *repo UNUSED)
> +typedef const char *get_value_fn(struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	get_value_fn *add_field_callback;
> +};
> +
> +static const char *get_references_format(struct repository *repo)
> +{
> +	return ref_storage_format_to_name(repo->ref_storage_format);
> +}
> +
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] = {
> +	{ "references.format", get_references_format },
> +};

One problem that we'll eventually face is that we want to add a callback
that needs to return an allocated string. With the current design we
cannot really handle that without creating amemory leak. So I guess it
would make more sense if the callback thus received a pointer to a
strbuf that it is expected to print its value to.

Also, we should be able to return errors. While that's not needed right
now, it may be in the future. So how about:

	typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

	static int get_references_format(struct repository *repo,
					 struct strbuf *buf)
	{
		strbuf_addstr(buf, ref_storage_format_to_name(repo->ref_storage_format));
		return 0;
	}

> +static int repo_info_fields_cmp(const void *va, const void *vb)
> +{
> +	const struct field *a = va;
> +	const struct field *b = vb;
> +
> +	return strcmp(a->key, b->key);
> +}
> +
> +static get_value_fn *get_value_callback(const char *key)
>  {
> +	const struct field search_key = { key, NULL };
> +	const struct field *found = bsearch(&search_key, repo_info_fields,
> +					    ARRAY_SIZE(repo_info_fields),
> +					    sizeof(struct field),

Nit: let's rather use `sizeof(*repo_info_fields)`. Makes it more
trivially correct without having to double check whether
`repo_info_fields` actually is a `struct field`..

Patrick
