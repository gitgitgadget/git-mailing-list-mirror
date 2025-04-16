Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C031FCFE2
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765194; cv=none; b=r+w07i8qDwRssoBBBn+AUph2fhXlG9NGNQz3mYx4UuQdCpJ8r83+AU1hXmVgEt8VNZpc7JSd4lV4cS5MYMimf3pV9GXdd+DscirJT3z+z8EtKKX8jFBvqBm3X8ZW3joBmNSsSsrcpRarlxUCjtKXwxPXnZvbYSAi33U+/64ao9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765194; c=relaxed/simple;
	bh=LsboKCfYYI92C6wUpFIO1Iy2v+XZ6k2VVQppnjEafYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQ9j4jQEg2Ot+Pem12VsfJjp1g/Ece+yzuFK5rpz4gvXn3NI0w3eRgWRmy1LXTSbpB3YJ8NObEjTxobZsC75udQEU81otFpiI/5MVW3mqlktNWg9N4/DyMmp6V1JaeOQZ7fnTaZaabO6wVdoszqj282K+rQ3SDGRmriGpejh3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VpAahHDL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v3tSkq4v; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VpAahHDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3tSkq4v"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76BE51140189;
	Tue, 15 Apr 2025 20:59:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 20:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744765191; x=1744851591; bh=pm6YTvxmEc
	1JvKpoYW625GhiYjC/ujxZp6aP2p6CzBQ=; b=VpAahHDLHNtaLlBcispFeT+dU/
	fBIjNNmtxkWJjVn1VrLjYPqFhmUaOVppDY4Cx69AyXwypWnWMaqP2/K7J/LD6+iB
	i/MMNZiX9BS7f/ItHchf40XgPADjls3h7FpCiYKRMo4VSJmQ8obsGYOovFkBHOPp
	bYZuKj/MxzfdV3Wtemx0mCS3U2FNoiRwdZrR+OYvOFM2p6JjpsqrAMGMEm9r4oxn
	kRntLLb6nervsQ4G/GDg4Lw/hVxzNf0GFqvGZh9qU/oExDXZMK0s56uLtwC+mzNJ
	m+WGknoWWNVjHstBtYrgH2ElaPDQngr/5TIuAGXopoqQ3ttXJNeY/31XaE8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744765191; x=1744851591; bh=pm6YTvxmEc1JvKpoYW625GhiYjC/ujxZp6a
	P2p6CzBQ=; b=v3tSkq4vGMmprcRj5BPq9gw5xot7qc5CjXnfmXPVqE/3POXeia4
	CyOILBeFfkQDn/J0o003hULeqltIywsxXTdomkJe3jW3qSUsUhS1HLI/hIHPYFnz
	lWd4FP/kuFb3jPDi3BFxKUPT3rEfQDOXK97hXenVDAkDeSCsVJwZ8RDiRziZjGx3
	66rWbVgjiEU724Swq7ACsRrc5mgYb8SQjO7vGwaKq6Id+T/F1szuBvLOFVwFZ3zi
	zukOuBCu54kIrUKh/oRpJW0OZ4MO7niUMPOsyn6/a10RIt8Pewv5noV/BZYPq9YP
	NyJrP6ZxtWajL94vXn+GFg/Ew7UXjI8f6hQ==
X-ME-Sender: <xms:BwH_Z7kqaYsion7xucIs33AimKKy2XVl7WttVvx3moPKqPBIKQ-M6g>
    <xme:BwH_Z-2Cq_Aud7ZYWo8K0zYDyxYMTl4atrbfjYhUUWw5458d5ygDmqxlAw1Ih7z6Q
    hNg-dWtgekD5RaLLQ>
X-ME-Received: <xmr:BwH_ZxoFhMDIadW7BarkVC5CQ7wD8GelZvFUVgWKylmEuhI7_cx2HL5E2R9N69Uj_6Oou5dt7KuuVUm8rrwtJXac9gB_8S_8bW0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BwH_Zzn0phnmip3guSA_oPq6jBhFRB2R-wQnrbeiTmLy1LzfSmK-BA>
    <xmx:BwH_Z532ULoLP9nNNniq-6nloO-ezNEjE11zoPeIUNvgylE1p0Qzqg>
    <xmx:BwH_ZyurrBGiq0d5XhTJUwcvY3nzsy3G9vPt93bsYUDp_SRlk77pKg>
    <xmx:BwH_Z9UUjzC9TnvB5L0W8sEXPvFNw-yFkkGyo9MBkpXTar_gxSvhDQ>
    <xmx:BwH_Z55HyMHgVi98zmFLAjUq1YLGcBjm_cumeLahzX27mV0z-YP6V9s_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 20:59:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 3/9] pack-objects: factor out handling '--stdin-packs'
In-Reply-To: <6f8fe8a4e10198b0339337376279cff4ac654879.1744757204.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 15 Apr 2025 18:46:54 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744757204.git.me@ttaylorr.com>
	<6f8fe8a4e10198b0339337376279cff4ac654879.1744757204.git.me@ttaylorr.com>
Date: Tue, 15 Apr 2025 17:59:49 -0700
Message-ID: <xmqqplhckjju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> At the bottom of cmd_pack_objects() we check which mode the command is
> running in (e.g., generating a cruft pack, handling '--stdin-packs',
> using the internal rev-list, etc.) and handle the mode appropriately.
>
> The '--stdin-packs' case is handled inline (dating back to its
> introduction in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs'
> option, 2021-02-22)) since it is relatively short. Extract the body of
> "if (stdin_packs)" into its own function to prepare for the
> implementation to become lengthier in a following commit.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Makes sense.

>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 4ab695a3aa..a293267074 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3674,6 +3674,17 @@ static void read_packs_list_from_stdin(void)
>  	string_list_clear(&exclude_packs, 0);
>  }
>  
> +static void add_unreachable_loose_objects(void);
> +
> +static void read_stdin_packs(int rev_list_unpacked)
> +{
> +	/* avoids adding objects in excluded packs */
> +	ignore_packed_keep_in_core = 1;
> +	read_packs_list_from_stdin();
> +	if (rev_list_unpacked)
> +		add_unreachable_loose_objects();
> +}
> +
>  static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
>  				   struct packed_git *pack, off_t offset,
>  				   const char *name, uint32_t mtime)
> @@ -3769,7 +3780,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
>  	}
>  }
>  
> -static void add_unreachable_loose_objects(void);
>  static void add_objects_in_unpacked_packs(void);
>  
>  static void enumerate_cruft_objects(void)
> @@ -4776,11 +4786,7 @@ int cmd_pack_objects(int argc,
>  		progress_state = start_progress(the_repository,
>  						_("Enumerating objects"), 0);
>  	if (stdin_packs) {
> -		/* avoids adding objects in excluded packs */
> -		ignore_packed_keep_in_core = 1;
> -		read_packs_list_from_stdin();
> -		if (rev_list_unpacked)
> -			add_unreachable_loose_objects();
> +		read_stdin_packs(rev_list_unpacked);
>  	} else if (cruft) {
>  		read_cruft_objects();
>  	} else if (!use_internal_rev_list) {
