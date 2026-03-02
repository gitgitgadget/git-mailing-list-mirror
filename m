Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E82F3C18
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491120; cv=none; b=t9m45JsXYPEFkjx94KlF1pwOUZOU91wXW2UWzNirqy1yLdJxgVJHB3hgOTxySmw/bedXUtJic2bX913Qw4nCzrlYJXky+jZOm9FNsRJ28OSmnZLakHU8KXFQXArTO6Cx15s5pd4075h/6+gwZ3Ped1vVckwrJprAioOp6ByFyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491120; c=relaxed/simple;
	bh=M0l1Km702T5CXXXbpBpaKpywFeNsrzkbfkFix0Ub1IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JEhrJC06HQeN5+KA7l6JdZc+3nFoZ12yISFycdjkLpyya/NleQbk8fS/5rtW5FUKzANAJhTI6VBKOFNwkQMF5WvtrJ9HT6t38jISpAah5BeWGmQwsNzdv0DYYJxw0sMhCDLOsZPSeGBhqrY0Zk+phYoFmofkd3QvdnRlAJ390Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cxVfIbxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jj2hd1q1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cxVfIbxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jj2hd1q1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1ED83140021D;
	Mon,  2 Mar 2026 17:38:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 17:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772491118; x=1772577518; bh=GpO7mmgtNt
	mMq0es4K+ahsekCcqtHTXQDNA7RuRWhfI=; b=cxVfIbxOapn6h4eK+vsXCXITAs
	vRf2htt7XokT/JEhu4TLoEaL2eN+D5czyWQ7HpTQe6YUq0oLYVxIERH6uJBOwGn8
	v8eys70LfzuzERh6KlWAR3d2a3aP2jAZtIeL+/izQ2cEAThunmTXNtliQjlUhadb
	6tP/jCZffy2+PMKxt2j6nRib64arSBxMqMNAlE70Ke5w7InJMJcwsHPSStyfph98
	MQU2HO9FKQX2r/E7T7/BS9nPnrRx03N0xDoTO48Gt0PwC556gFBp2VRTmHhFz4Jv
	ClBlZA+dnO1uKumFweikKO4ZbcRbwQrVIptHsa/m2AGaD5ZZLHq+55JWitHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772491118; x=1772577518; bh=GpO7mmgtNtmMq0es4K+ahsekCcqtHTXQDNA
	7RuRWhfI=; b=Jj2hd1q1MjvGYu8LrdlS7O5QCp8MaOuwDu2aoi+YJBFHBh6D/rQ
	oopqyiXSsyRnNatAm0VMPMKSINVG7bpoOw7jW97fJaXafFQ3wQiV4Us73iWrzLJe
	pq1z77IMsPlNU+axFPOFYVlu8eOzwwLuhyT8B7s/oGeKMRZtreYiSc6UgN9Xm4Cf
	c8qkeMiH4DZwo7qU8cRdFsCa/oP+A1Kk586RgqUY/j2hc19Syq+5zDyLbw+hvR/H
	3KfkG8DyTXWHyZxt/PvOUYT9Nl0JbyYGi1cLzC0BzfA0embECFkQlW229AcTO0NN
	RySuk76JNlNcK9q/04smAl9F2O/r99TneDg==
X-ME-Sender: <xms:bhGmaeEtSg2lovSNMFHyiP_f4lGHHaVTcAocDfLTl1Bu2atvOUeVlg>
    <xme:bhGmaWVvaBruPcRhNnMhubgBxP3uv57hPM-kSzEij3pSOIo7H4u5Y0-yKa4h6AR2B
    u7s1pXDrduS0s03IKhKiCaB8UbsevH_00sKVcbPQ4xroa6dl9bL>
X-ME-Received: <xmr:bhGmadI5kseodM2wktkKvH_8BoxnoAGlceIy0ICrPgFv5J-UxtHx0mmB7NitZFSPfNp4O31rt5B-sxR-lHVcG1Ancq8P3dcZ5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bhGmaW9Y7ZvFSltT9XhziDvkIN1eUKDeCEqwYMeb_biQBdK2CN1Ehg>
    <xmx:bhGmaQKXFxepo8dfVfGTqqa44zgA1QbXeU7-jbcxmVoqju8yJY0Q8A>
    <xmx:bhGmabllJUfjqDqq-dnFdlxVVToReimrpplTvh-xTFm31AZ3OAZy7w>
    <xmx:bhGmaUOZx6AFk9BH4xs9qog6Bv1qoxuQ_JVR_S986HIjr6ljQBTM8A>
    <xmx:bhGmaYoaf7jASAhMqroLTU9wOwmNNtgphh48xU2SbC5QuYELc-jGf680>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:38:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 5/5] sequencer: use oidmap_clear_with_free() for
 string_entry cleanup
In-Reply-To: <20260302200018.75731-6-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Mar 2026 21:00:17 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-6-kuforiji98@gmail.com>
Date: Mon, 02 Mar 2026 14:38:36 -0800
Message-ID: <xmqqwlztx3f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> From: Seyi Kufoiji <kuforiji98@gmail.com>
>
> Switch cleanup of the string_entry oidmap to
> oidmap_clear_with_free() and introduce a free_string_entry()
> helper to properly free each allocated struct string_entry.
>
> This aligns with the ongoing migration to use the callback-based
> oidmap cleanup API.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  sequencer.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index a3eb39bb25..75ef2ace4f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5654,6 +5654,12 @@ struct string_entry {
>  	char string[FLEX_ARRAY];
>  };
>  
> +static void free_string_entry(void *e)
> +{
> +	struct string_entry *entry = container_of(e, struct string_entry, entry);
> +	free(entry);
> +}

Exactly the same comment applies to this step as [PATCH v2 3/5].

In other words, with the current codebase, these three steps in the
context of the current code are uninteresting with little value, but
if we ever add a member to these entries that hold their own
resources, it would become easier to manage the lifetime rules of
them.

> @@ -6044,8 +6050,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  	oidset_clear(&interesting);
>  	oidset_clear(&child_seen);
>  	oidset_clear(&shown);
> -	oidmap_clear(&commit2todo, 1);
> -	oidmap_clear(&state.commit2label, 1);
> +	oidmap_clear_with_free(&commit2todo, free_string_entry);
> +	oidmap_clear_with_free(&state.commit2label, free_string_entry);
>  	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
>  	strbuf_release(&state.buf);
