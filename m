Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57281E4B2
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276359; cv=none; b=IJFz2sO9V0e9s8GZxDxOZi9ZT3w2exGkRRkdj/ym7rdHjg3Brey+BLLrizWYUcuVEgwn8tAgg3NDH2ssJXWC3muRxntQiyFmJTtofC5wEth5O3MiZpfVB3lK97KFO/IdgZpAssAPBqhILq9WUbReu6CjYPbz/uhXqQYdX3KcFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276359; c=relaxed/simple;
	bh=YSbGEndRE14RjiXXQGV2HvUU/Fp6E9mv2us0+KEAgOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yi87oSjr9EwEefdn70jlsalFbKdjQQXNqZygI0SnRNO4Bd5dQr4ZoPNs0Hn1OQDTvUoerwROnwWdvubKZs4Mo8XEDeHpydNi5hft1Cqoi5WCttC2xwNDjTs/pBzSKxTy1BCxExU8b8/qT4dM7CTt3XRMW5iaqyepv1qx5/XB7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qzsWSciA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3+JAISo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qzsWSciA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3+JAISo"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B02E1138018D;
	Thu, 30 Jan 2025 17:32:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jan 2025 17:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738276356;
	 x=1738362756; bh=wEfYavBsUQqmQl7P0PTThIWFqLzImZEWXh8bz4QKo+s=; b=
	qzsWSciA2z49zGVNBeUz08V4dp0QmWqwLKJR/xB1pUAdlIn0VtKG9BjcokyGSTF3
	Oi7cyBfnVJNfd068mMpxabpsOA0FIRzKFJLLBrG6ls1euQsSMrGl5M8bY3Eu8fNr
	YAmDPnA9UfSy3h2Awf+KG7XmBRodv1AAbgywL1uD0R4y8MHYf822MyvwSauO6gC2
	K7fFPnBs5TamGBULTlrY5xFx56AwwQKY+MGzNkmsATaInJaY0v4cLJg5GJbXugKP
	scQJparvnyjxR1zXlmn602S3Z0y5+VxVI2vlv9dPo4G3nJH/2M4xua/Oe6bRubVK
	oJYIY5De6tFlKsYB/ee26A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738276356; x=
	1738362756; bh=wEfYavBsUQqmQl7P0PTThIWFqLzImZEWXh8bz4QKo+s=; b=G
	3+JAISotVuND2w/grkzvNJJan4EEf6ZNIgwRFkiRyTJREMBZlhCl1TJVc3tTXU0+
	8MGBCG1bfTK0NNLLnRpm9VJlgYP++t9YVuguYoM8ndnQ3dJNVAYqAWqPtcbm2Wyc
	viWhIZbPbZjlKaLk6oPQC7RAho8TO/0QEF+UcwT3JwjfO1mbpaAF73ehhxr4MDnc
	pAxymXyOCOy6D01kruEYpqrF45qhwn6OYJFnmxXU1yUWXkdjZkOQZ/ypuUgFxNa6
	x0AxN/WRNW6f5RzwR/yCc3Swv77w3M6Q5xZqISAzVeYLW1WPTkwYKjt3uqY/hPiv
	50UW5lY71Tpw3UH1hatsg==
X-ME-Sender: <xms:A_6bZ36IsyAiw7VpK-htdZkTRNTxKaobjCIpuUYd1K9I9vffMFsSIA>
    <xme:A_6bZ85tMJkiEsGLxNuzhBvgcBy4dQbiyle3KgQ8_JgnYeq_zR5685rWYREC1xmnA
    u5oAVjA4RpFhv4Cvw>
X-ME-Received: <xmr:A_6bZ-csjpFIZlDgNNSuwNyP0ndQENQ8nCr1Ee97xw5aKC4bOVWrTENTenjU1CVhu3GizxP6WSZ0uANSA5M1hqDUouz77NreJbDh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdegleef
    vdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepthhrnhhkrgesshgtmhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhho
    nhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgrnhihrg
    hnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A_6bZ4IUuLG1UKl9qKhEeHWsKvak8fIYScb04J4zkOVQge4-YTFHiw>
    <xmx:A_6bZ7JL6e2-FSlMNy1CAOxYzbPU9-WajnuQE-gCQZLX5b53F1XnSg>
    <xmx:A_6bZxzDVYvRIbXmkzi1700HniadrSSFU08bhpizjTkcg6xO4yV1Xg>
    <xmx:A_6bZ3LMPPmdZ8mTQ7XovIJP4EDIoo8d2Qv9n29oKSnZ8M7MXvBQnw>
    <xmx:BP6bZ4oH6TltqB11eHdrNnQY42XVMZbGNDWrj06snHluyIDrrM-nkGgm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 17:32:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,
    Jonathan Tan <jonathantanmy@google.com>,
    hanyang.tony@bytedance.com
Subject: Re: [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep
 when repacking promisor objects
In-Reply-To: <19759704.fSG56mABFh@electra> (=?utf-8?B?IlRvbcOhxaE=?=
 Trnka"'s message of "Thu,
	30 Jan 2025 09:11:31 +0100")
References: <19759704.fSG56mABFh@electra>
Date: Thu, 30 Jan 2025 14:32:34 -0800
Message-ID: <xmqq34h0aq65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tomáš Trnka <trnka@scm.com> writes:

> git-repack currently does not pass --keep-pack or --honor-pack-keep to
> the git-pack-objects handling promisor packs. This means that settings
> like gc.bigPackThreshold are completely ignored for promisor packs.
>
> The simple fix is to just copy the keep-pack logic into
> repack_promisor_objects(), although this could possibly be improved by
> making prepare_pack_objects() handle it instead.
>
> Signed-off-by: Tomáš Trnka <trnka@scm.com>
> ---

I don't have a strong opinion about the technical aspects of this
patch to be a reviewer.  I have no idea how you decided whom to Cc:,
but I recall these two threads that worked in the same "interaction
between repack and promisor objects" area (I am not saying and I do
not think they addressed the same problem as you are):

 * https://lore.kernel.org/git/20240925072021.77078-1-hanyang.tony@bytedance.com/
 * https://lore.kernel.org/git/cover.1730491845.git.jonathantanmy@google.com/

so asking review from the authors of these topics would be more
relevant than sending it to me (I did that already, and that is why
the remainder of the original patch is not culled from this
response---after the next line, there is nothing I wrote but the
original patch left for others' convenience).

Thanks.

>
> RFC: This probably needs a test, but where and how should it be
> implemented? Perhaps in t7700-repack.sh, copying one of the tests using
> prepare_for_keep_packs and just touching .promisor files? Or instead in
> t/t0410-partial-clone.sh using a copy/variant of one of the basic 
> repack tests there?
>
>  builtin/repack.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d6bb37e84a..fe62fe03eb 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -388,15 +388,23 @@ static int has_pack_ext(const struct generated_pack_data *data,
>  }
>  
>  static void repack_promisor_objects(const struct pack_objects_args *args,
> -				    struct string_list *names)
> +				    struct string_list *names,
> +				    struct string_list *keep_pack_list)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	FILE *out;
>  	struct strbuf line = STRBUF_INIT;
> +	int i;
>  
>  	prepare_pack_objects(&cmd, args, packtmp);
>  	cmd.in = -1;
>  
> +	if (!pack_kept_objects)
> +		strvec_push(&cmd.args, "--honor-pack-keep");
> +	for (i = 0; i < keep_pack_list->nr; i++)
> +		strvec_pushf(&cmd.args, "--keep-pack=%s",
> +			     keep_pack_list->items[i].string);
> +
>  	/*
>  	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
>  	 * hints may result in suboptimal deltas in the resulting pack. See if
> @@ -1350,7 +1358,7 @@ int cmd_repack(int argc,
>  		strvec_push(&cmd.args, "--delta-islands");
>  
>  	if (pack_everything & ALL_INTO_ONE) {
> -		repack_promisor_objects(&po_args, &names);
> +		repack_promisor_objects(&po_args, &names, &keep_pack_list);
>  
>  		if (has_existing_non_kept_packs(&existing) &&
>  		    delete_redundant &&
>
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
