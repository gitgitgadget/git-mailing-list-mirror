Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4431F982
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490612; cv=none; b=TwA/aP86TNNBAIu4xtjVYjuo6LobPjVUgj8zf2zGvryS93gqPTPRa2m7lHz1M5l9hOlchXcNOqmA2WD1Fwq1rO0SNlfWMmPGQCfihvKaY+hRjpTSRIQDp1cMYoRdar0MYOaNFOk/EhrGJKNowlfPY7d4LboxOlF/W0Bb8LkiS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490612; c=relaxed/simple;
	bh=lGyCbv/M6uMMiFUqoSBrTXCgr96Y7dGHLSb1UjHlUFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDiAahe+8I/JoWDI9XrW1HP1bgQANkqC7WWKmD6wNgUzJ/fDH57/n3MNLx6BAaS7hLOS/tlvIK8Qxd49y+nB1oWA7rY8QYzu3jQvspiCq7sF/qZ//OfmsCz5rvWxjwTU8zxX2rO1xL8i93Z3QC0oAdD58xgKyFN6lpe4QMLOFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q54pPkiq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/3nprpJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q54pPkiq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/3nprpJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EAE8EEC0566;
	Mon,  2 Mar 2026 17:30:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 17:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772490608; x=1772577008; bh=8uDui1PjQ2
	Lqv+L96PX1mPNycoNVQszJ+b09RvHg+XI=; b=Q54pPkiqa3ZaZx7mqbwzAFxwuN
	oQj4mMTYBlqKIHf8E3Wtlp7wmpbwBOlFs/cW9FNFiA+9gImOt/Ax8Ok3S6Gjq5tx
	soPBgrsDKw64SSYBrODRAnPhD9ALAAIMoDSxBTK9UxWgemVbzGRRlaI9BBlwa7Lx
	cn3Tv6JZGSYFtO1WXuyFM8wmbW+LTh7A6xn/mJuzEpg5B2S0J6ekms53kLHxLj+X
	O6xn9xyM5kCZWZ7awWJmqLdZ49ADWgVj/P+SRhPxBdEM6MO/pmV7KxZL/j8GytuT
	BVxDBTRm6KoSAxS4D61OwdSPpEEvH3kJ+5oah/INlr7Vx8xy3AVpYKq33+Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772490608; x=1772577008; bh=8uDui1PjQ2Lqv+L96PX1mPNycoNVQszJ+b0
	9RvHg+XI=; b=A/3nprpJRTeL31P80k3CUsJN1iY+6dd4RxP4FVqPFm4y98klB3n
	YXX5A6CcQea7BZmwDAs8pt0lYuSEFmKap+1/h3CRiFiAfECCPvVSaUIOPVwhl5SD
	SHd4kt13UJ5Y+z6h4QQoYcZ09Ca5wsn8s9ut7JDy5aTTzx3NRhk5fxV43i528zLj
	NvKznB7VnPEfu9ZArlXRfu2XfDudwHXqGtkV+R7m7WiyLsJWlXyCcInhQXi2wbGe
	Plg10Y8dVaNqyr/D2MVjQvfIGMr9Eyxu0Uh04UqfILqJogkYsuBfapOu+XDqynPM
	dx6q6seF/8Ykl/jQj+hQur3JP+WbnyXCMZw==
X-ME-Sender: <xms:cA-maVOl5-VIPn10s3fAbizd9FIQiFZs4nOszGhQR_ATLBIR1Vgjmw>
    <xme:cA-mae-23MfORw2zQInBMtYiuKpLMMfL24zuxxhNt0lQiHCNBUkBfTodgSs8eDul3
    oIxQj97A_P0IDo-SFdwfJS5e69vZ_5OS7lQqMUoiBWlhZl7fdzqhQ>
X-ME-Received: <xmr:cA-maZSrkrlfApbcBAbcJ9JpRVO_nhxxExWMy4ENy5EkErte-w9Rq9LhLO0e359cCU8oA3NsuXtR0jmisUaqb_77zv_n4ha5LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cA-maQkUKiezaoJNKm7Smtw5N3j-ZYMfKVwOdoiNXFrTNXB4SaZZuw>
    <xmx:cA-maZTTd25I8HFtH1m35-ULPiTaVKfRa545Q9b-0RVFwi-72MujwA>
    <xmx:cA-maeNbImTouPcOSQ1p9_rRvuFfD1e26BB5FBHLUL3Xl7dC7iEKqQ>
    <xmx:cA-maSUlXpiExsud_loN2j9BtrYt5MdVlCzdiGy5HRI80FSAEBZ8Iw>
    <xmx:cA-macyS1DVUuL9uXxXYzMnvXatAWSoeGEtweVI-nyE9t7N0S_mqN4PU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:30:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 3/5] list-objects-filter: use
 oidmap_clear_with_free() for cleanup
In-Reply-To: <20260302200018.75731-4-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Mar 2026 21:00:15 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-4-kuforiji98@gmail.com>
Date: Mon, 02 Mar 2026 14:30:07 -0800
Message-ID: <xmqq7brtyids.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 78316e7f90..0038bfaac5 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -143,6 +143,13 @@ struct seen_map_entry {
>  	size_t depth;
>  };
>  
> +static void free_seen_map_entry(void *e)
> +{
> +	struct seen_map_entry *entry =
> +		container_of(e, struct seen_map_entry, base);
> +	free(entry);
> +}

As there is *no* extra resources held in seen_map_entry other than
the shell itself, this step alone does not make the code any clearer
to follow.  But if we are going to add new members to the structure
in the future, the story will change and we'll leap the same benefit
as we saw in [PATCH v2 2/5].

> @@ -244,7 +251,7 @@ static void filter_trees_free(void *filter_data) {
>  	struct filter_trees_depth_data *d = filter_data;
>  	if (!d)
>  		return;
> -	oidmap_clear(&d->seen_at_depth, 1);
> +	oidmap_clear_with_free(&d->seen_at_depth, free_seen_map_entry);
>  	free(d);
>  }
