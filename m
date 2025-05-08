Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EE1BE23F
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718590; cv=none; b=W25t9YS77G4VgF7b9HjQ/srKCcyuU8v5ygdcxltMrhuNGTVwBe8084t8hn+/m7B6yzOaw+k3Tszt+sTWjLjSbiTDU6+qNE15P/cBfm0ZIdasRJRncIJR66T3ywn5kGi9/KhPOQyTfNv9+067m0NHQRC2py8C6TsZxVE5G2e0aKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718590; c=relaxed/simple;
	bh=iCIXqIrIUCFYTTuVf2kDnC9/iVXbjIC7bWXInFxrZoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErDwKk3MjQhegk3nmxwaB9kKBFy5Miiun42SigB+sLNsonXao8Byq8HBRkXaTDnRohFdbPdcgZXi0iVB5s9kB3+ZrEBaxhOQdMaLZjRwmAUi+0zRsX3Ytm/rb4duEj3Y7GBdsh5TrVrKNf9xGMjQu6UN617JfwPGJI6BaJcDYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mDsF1t3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXibY2pR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mDsF1t3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXibY2pR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BCC9114010D;
	Thu,  8 May 2025 11:36:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 May 2025 11:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746718586;
	 x=1746804986; bh=Q7nP2RGi6rdrpOcYgU+8VeIgvEF1pAHkXPyGPnwutqw=; b=
	mDsF1t3YecovjGGX48vJpNIleNS6rppVKDo1zWyQjFiWsmmb9N82BE6oh4jnV2Hq
	vOLU0edVlr6Ku4CfTQmwr9NqyAoPrXL5smMIRxGYSNnPt+vkyIBY2kCT5p1SbhJJ
	n0VCRCzEKd2PIAcXQj1msyiHIO6l5jQNwGsMlQ8b4A+/Ai+RbRJSsMzVWRI7R5EG
	g11QF6I9gqdClMxEkieuaQqbPCcDpUW9jLZlbdARvUq5CnHxxrvAT37GtVEYaLF4
	Em5T27jo5OXMG32Vm+86YEoDeATBpcsot9Bq0x/MIh2LnITZkHqLAfTLsV4tTSbY
	ylFXX2URMa9GG2mEFkmjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746718586; x=
	1746804986; bh=Q7nP2RGi6rdrpOcYgU+8VeIgvEF1pAHkXPyGPnwutqw=; b=C
	XibY2pR/lQyjrURhtmuemApQIRw9JGjkGAjJDj6vqAytCSuVfQTkiDZAr9OD8yQ/
	dWCvi/kKqagixZg71wClLryvDVmmf36YlFRe4Y0YWud9Js3nBmHGxn+stAdL3koq
	L2X/6Npn5124f1VBWopCeM+Yw/H208K6dEFZ7WcgNiU7yZrwOhb9uFEbisheL73h
	b0yxyhIFbQK7bdNYOgWhpY7kshUuZiTVqeZZP8fYRVTo/VjoJAhG+zw8XP6ljeYl
	3KPyNCBHOQx2KEO+M6B79mFL/736pYhA4ARbiq5RSqsNzCPLbBDRzSImKk+oKgqr
	wqrM4GWRB7QDIL2vQSZ3A==
X-ME-Sender: <xms:ec8caFVXc6oEVoGj77rCr7O_bnS5knlMx10F9wVvf-k8IFTebwzNmw>
    <xme:ec8caFmp5LOKdkDCLbYSqmNd5OadraiSJBCFZK-XJo4VMocmUe-8n_bXqNgHJX3KV
    i0bdf-O4SFN-kG0dQ>
X-ME-Received: <xmr:ec8caBZp7ktzyQaeRRmM47LTNuAbCdDwLnuWKEcnEdjebMRtIQnz9fAQSkBlp44nKcftKlLAhoRDOYXtOBsyDcjp4CbDw7lAvbTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgt
    phhtthhopehtrhhnkhgrsehstghmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ec8caIXuF8BhHO8UoEKNC1RiUZRR0IhJomvbb9aBFyRUnVFv8okR-Q>
    <xmx:ec8caPnQW7-xc-PdgEfQew9zRrpQ7gOmFpSoed0T9cCfRE0YWLP5mQ>
    <xmx:ec8caFdMSgx0pkwg_wVWa5p1GabrlbjTt_z9oSWll5Mv04aqY4Q04Q>
    <xmx:ec8caJE8CkGMWbHv14cwJ3FPNAbwY8z43Jc89H7eF8VkFnBogsHiEA>
    <xmx:es8caPwM-3g-sruRtUwRF734y7a9GOMZUiTcboV_Yeib9id8CB4TL4ql>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 11:36:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
Cc: Han Young <hanyang.tony@bytedance.com>,
  trnka@scm.com,  git@vger.kernel.org,
  jonathantanmy@google.com
Subject: Re: [PATCH v2] builtin/repack: Honor --keep-pack and .keep when
 repacking promisor objects
In-Reply-To: <20250508104437.51513-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Thu, 8 May 2025 18:44:37 +0800")
References: <20250508104437.51513-1-hanyang.tony@bytedance.com>
Date: Thu, 08 May 2025 08:36:23 -0700
Message-ID: <xmqqwmar6rns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Han Young <hanyang.tony@bytedance.com> writes:

> From: Tomáš Trnka <trnka@scm.com>
>
> git-repack currently does not pass --keep-pack or --honor-pack-keep to
> the git-pack-objects handling promisor packs. This means that settings
> like gc.bigPackThreshold are completely ignored for promisor packs.
>
> The simple fix is to just skip keep packs when iterating promisor packs.
>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> Original-patch-by: Tomáš Trnka <trnka@scm.com>
> ---
> The original patch passes the --keep-pack arguments to pack-objects. While
> this approach avoids repacking the keep packs, the objects in the keep
> packs are still enumerated. These objects are iterated in repack and sent
> to be packed, only to be skipped in pack-objects.
>
> Filtering out the keep packs in repack_promisor_objects is more efficient,
> the objects in keep packs are not enumerated and sent to pack-objects.

Christian, I thought you have also been active around promisor area
these days, so let us pick your brain for this one, too.

Thanks.

>
> In a test repo with a 2.7G promisor pack. The original patch took longer to
> repack the repo, most of the time was spent on enumerating objects.
>
> The original patch:
>
> $ time git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack
> Enumerating objects: 19091575, done.
> Counting objects: 100% (5934/5934), done.
> Delta compression using up to 12 threads
> Compressing objects: 100% (4517/4517), done.
> Writing objects: 100% (5934/5934), done.
> Total 5934 (delta 2885), reused 2986 (delta 1192), pack-reused 0 (from 0)
> git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack  43.94s user 46.83s system 134% cpu 1:07.60 total
>
> This patch:
>
> $ time git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack
> Enumerating objects: 20952, done.
> Counting objects: 100% (18323/18323), done.
> Delta compression using up to 12 threads
> Compressing objects: 100% (9022/9022), done.
> Writing objects: 100% (18323/18323), done.
> Total 18323 (delta 11340), reused 15753 (delta 8771), pack-reused 0 (from 0)
> git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack  8.65s user 3.14s system 62% cpu 18.838 total
>
> I also noticed that this patch produced a smaller packfile.
> 1.6M compared to 4.5M generated by the original patch.
> I suspect this is because some objects exist in multiple packs,
> so pack-objects still repacks them even if they are actually present
> in keep-packs.
> ---
>  builtin/repack.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 59214dbdfd..fb09df53c0 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -252,8 +252,9 @@ static void existing_packs_release(struct existing_packs *existing)
>  /*
>   * Adds all packs hex strings (pack-$HASH) to either packs->non_kept
>   * or packs->kept based on whether each pack has a corresponding
> - * .keep file or not.  Packs without a .keep file are not to be kept
> - * if we are going to pack everything into one file.
> + * .keep file or not.  Packs without a .keep file or specified by
> + * --keep-pack are not to be kept if we are going to pack everything
> + * into one file.
>   */
>  static void collect_pack_filenames(struct existing_packs *existing,
>  				   const struct string_list *extra_keep)
> @@ -278,8 +279,15 @@ static void collect_pack_filenames(struct existing_packs *existing,
>  		strbuf_addstr(&buf, base);
>  		strbuf_strip_suffix(&buf, ".pack");
>  
> -		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
> +		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep) {
>  			string_list_append(&existing->kept_packs, buf.buf);
> +			/*
> +			 * mark packs specified by --keep-pack as keep in core, keep packs
> +			 * are ignored by repack_promisor_objects. This avoids passthrough
> +			 * --keep-pack args to pack-objects
> +			 */
> +			p->pack_keep_in_core = 1;
> +		}
>  		else if (p->is_cruft)
>  			string_list_append(&existing->cruft_packs, buf.buf);
>  		else
> @@ -412,7 +420,9 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  	 * of a {type -> size} ordering, which may produce better deltas.
>  	 */
>  	for_each_packed_object(the_repository, write_oid, &cmd,
> -			       FOR_EACH_OBJECT_PROMISOR_ONLY);
> +			       FOR_EACH_OBJECT_PROMISOR_ONLY |
> +				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> +				   FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS);
>  
>  	if (cmd.in == -1) {
>  		/* No packed objects; cmd was never started */
