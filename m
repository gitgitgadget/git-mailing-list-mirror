Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609912690FE
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879529; cv=none; b=Rz1sEl3KNdeQNx/OHzGRpgzK2SV/770AGPRLECxsZXJhAX7eO5qNlbsU9/GJpvTIo5raGG1rOgHSEQSlVYY2w5tqhYyZcQiCbs1QIbSQtTUIkFIeiWXxMEbMtWnHd0cNBk3A1WLcOaL9vqxxKEg79mbYbMM0siIuv/HHFF5h2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879529; c=relaxed/simple;
	bh=3gyYPkgpC8rTLq/2TtYPjLVo0NEYJIcfJujccErkoFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZ1qA1xy4/gNztGYzV76ya+ZJbtbUsraCoWo2NMhpVHLRNh7ljpS2BOm7dOg9hNVmQzAAV1QkDcPskjGvU7GTZj+w411v5CkOI+1iKdhce2M6p7/TJ8D4qldm1GNjuph8jiQsSLJEduq2IeUetF6j/V+VgiZLOH9l0JvXhdwiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yTCUM7UP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvwWCmG8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yTCUM7UP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvwWCmG8"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 572A911401FB;
	Thu, 13 Mar 2025 11:25:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 13 Mar 2025 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741879526; x=1741965926; bh=hUI4ahVIoG
	afveJ0A1iS8Q+oTjax1oyv+j6HQJ8q3fY=; b=yTCUM7UPQ0q6rcOtxrTuXBAkSM
	RznVd/jJ942puoslwWd265JpYySHjMhWxK61hI6Lzrzz9kZ4byEzIQ5OUnrhcoKP
	ECTAPgdHo7v2Xi3lShdCp7Aw+3SICj6LK5cKXlto6Q5fNYJKSvn3NWCJteJlVMek
	Qtb9Fcjw8hVBelUVmZSRtygwih6Z8xOIf/n2apfvTMgBOvXrym86XyYFGsfpL74E
	8fPTrBHbH/79ytbgE2oUbxDz+vPas8QuaquhocikPloMJJ+jVZmBg3fnjvbvGPIS
	6xuCL/6X8iuS8m5TROz58Cqd4hdNIwU6SGXIdi1R/5xBiPbkW+HS1ak62S1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741879526; x=1741965926; bh=hUI4ahVIoGafveJ0A1iS8Q+oTjax1oyv+j6
	HQJ8q3fY=; b=PvwWCmG8zhIVSum/9+6TG7tDh/RGU9iz8+B+MVYQOLbIPKFYFVS
	UQpQu5rDUidEmK6wMnhcb+GqwwoXvPbzoNZzj+cJTod3qX8Xb83pLCR+ZfHDhIRU
	u/HwST62kD0hij2QcydtCV8wWoK0NM6sbaFzT4HKNAb8KyYTYTFxK3FQ219DuDDF
	q5oRXo6R516Gp2dTFUP7ve+vKIYxz2YrR4CEAOu1uNPdIbPr+t5oDTosiBQR28cp
	fqlk67stJArHFYBW7X68qDQEBpJILyQEraQ/uXsWSCW65vNuDhjYrnPGL0MQzcCv
	CUxbquPlM1vCP3zGouLEWLPLK8GJSaTGkNw==
X-ME-Sender: <xms:5vjSZ2KRN8YbAhlW0rK6uoMgydCPfem-Z7UFPhUapRvDLcgGVYYH9w>
    <xme:5vjSZ-IOlZwfTgt7418MAHE0BQRyGCVdyDqRV-bv3Eechfoj5HgWp18IfL8hO2zfp
    Bj7zC6FhtpsG1zeIg>
X-ME-Received: <xmr:5vjSZ2u6jkJKyrmOcVtCRDPvDRkLoDqVDrZ5MZBPajI41w5D_XSr51J4JH8U13DdLgmNodVb2Z1Zd7WAmPNnY9TQoRi2mQQjGCDZTrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5vjSZ7btyHtT4fkduv3XqL88xxwEZsvvY9amdvcZokndEoIb9ECQeA>
    <xmx:5vjSZ9Z-Km67a9I1F2KqNRsvDNAbEUrJ3grNSD0gI3QWHvAZYZmwmw>
    <xmx:5vjSZ3DhOhgJY21kfm5nNWKoUtONGa8IcYQ_GiaR8hTxdSCI3lZ9sw>
    <xmx:5vjSZzYuep2SiPbKQALnBez8s3f9HOkT9nUMzqiQ-7JJIXMaWUo__w>
    <xmx:5vjSZ8UNM7zvPowPwxVzK1VEGmXx2DRVHFKnKOHdwhfKGUZ7rBSB6FzB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 11:25:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arnav Bhate <bhatearnav@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
In-Reply-To: <CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Mar 2025 07:25:07 -0400")
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
	<xmqqy0x9s8mg.fsf@gitster.g>
	<CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
Date: Thu, 13 Mar 2025 08:25:24 -0700
Message-ID: <xmqqmsdpq7ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I have to agree. I think it would a bit cleaner to actually change the
> functions argument type itself. Perhaps, something like:
>
> -- >8 --
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 12ae086a55..79e47d6e9e 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -40,10 +40,8 @@ static struct {
>  	} *entry;
>  } list;
>
> -static int get_ours_cache_pos(const char *path, int pos)
> +static int get_ours_cache_pos(const char *path, unsigned int i)
>  {
> -	int i = -pos - 1;
> -
>  	while ((i < the_repository->index->cache_nr) &&
> !strcmp(the_repository->index->cache[i]->name, path)) {
>  		if (ce_stage(the_repository->index->cache[i]) == 2)
>  			return i;
> @@ -83,7 +81,7 @@ static void submodules_absorb_gitdir_if_needed(void)
>
>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>  		if (pos < 0) {
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;
>  		}
>
> @@ -131,7 +129,7 @@ static int check_local_mod(struct object_id *head,
> int index_only)
>  			 * Skip unmerged entries except for populated submodules
>  			 * that could lose history when removed.
>  			 */
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;

It makes the code far easier to read to turn what index_name_pos()
returns to the index where the conflicted "our" entry ought to
appear like the above two hunks do.  Makes perfect sense, even if
there weren't any type mismatch warnings.

Thanks.
