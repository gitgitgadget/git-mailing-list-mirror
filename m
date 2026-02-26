Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D25426EAC
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135416; cv=none; b=lBVI9mPC0M5J0s6ttkfUuJszD6jdOkXC2WwKzwOzzKOhFeKAGZnhghrkpSbMC5b9OoQMRbwE31LU/lT5g48SA2xa6i9P6sZzxtBFIN34LDUBWbuRYSHPMaZMxUQYqHoRfgRqsrnA1X6qkj3FvukNKZ0xFfYdACNCvabnD14PThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135416; c=relaxed/simple;
	bh=rA/ZAsMuLfo+Y7hQEtRrmiFD4QwacIAZJHpmJ/9y4SE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJ0KSQ2IezpXEOVEMSo3RgGByqRa771a5TrHM0ufEXCveiNPHVSMJ1b8Rgt3gobIDoTi0yAhoq2Px7K7zmz7aVJpWBrYvt9mwtLI3YJ7gs3g/yslevIXs0ggtHK+HNWP4XsfMtITfHD3SGu+9r7cNnawasQZtNGQSgOq/ZDf2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JjCk/69L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vop9wIsJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JjCk/69L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vop9wIsJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB8D27A0132;
	Thu, 26 Feb 2026 14:50:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 14:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772135413; x=1772221813; bh=lDcpxiKvkT
	ecXarXgB2OMi7VuqgZwHVY0r00hHyqqJ4=; b=JjCk/69LdJtBNlw3UDN0s3EvDX
	+RfafkShoejLMxNrCp8ZYLrMhsl8purpnjIppDR4g3g/49pVbYFyLR9dHW1J3ZY+
	KIh6OYibuMLBfLFc014IsOtPUa0BNxH971IWGsnLqiR75qxLTpmvHKh0KftHTcDM
	rfGKIbWD2wa3tNpaNntRkaleA6rnuSVmy+wwq8dXzJxLtNt3cKjl0shvalcNgDgD
	2Nlx7rx2YjqtxgjWfGKemfKzFEota67z8XjFBpR5o0y6QGbQbsvZYzeTEY7gZ0NH
	nbHouUZNvvJy+D1jbNtvq0w7v3U5YrkzyuGgNsXGR2xJ8TMbGgg/59+BsjGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772135413; x=1772221813; bh=lDcpxiKvkTecXarXgB2OMi7VuqgZwHVY0r0
	0hHyqqJ4=; b=Vop9wIsJRVTJoc9MRtUJXJX8ZN+ulryKdeL1gIIDNxVEVU/+a2r
	adj5wFwfaCp0dsjus9o4+Iqukm62PrVMkvF+o7s/6DWk6SFWCTqtepAIECQCR9LK
	ZP6igpVn7Bwq7lI03ZqwQC4w3XlXeruiCxh/pla31yvudauBFp5Bgd3JzweqD7Bn
	KxanJh3WvjO1qZ8qrVU6EtUovD/JnQBmSKTcEAOgADnFzW/WeKdpR7a7nQuqkJzm
	Q3bGt4AuQRTTnwC3Bo2yzJs3VExzRCvhJWZsiFvTbzNvpZjvuTdaD+4WASTub1Tt
	nO55fEYNf0y90WxPdWvWhldfXhi3bbeoUvw==
X-ME-Sender: <xms:9aOgaaPB7CWRD8gaJZ0r4OLrOJ0zC-0gTXmToIMGKvY2abEanAhIvA>
    <xme:9aOgacolfK_SrLAqSTYx-C67Bf34GvDklhn_XzU08R9y062WDMijwSYktzWgHXpe0
    Pq8Q2oM2RYIKtx6hwYaNN_HjHtLjpjgBK7IcbSwNjzI0xNhejBZsg>
X-ME-Received: <xmr:9aOgabHtyoz99fN-bT8o_kAzVeoXcrcmAjHiP799rxDcO7oh7ONB3DEy0gCWQS-UcX2ECtQzWCBBjIz4JcrB1BiEynoAvgHMxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepvghslhgrmhdrrhgvuggrrdguihhvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9aOgaRqqDcVwO0Nrt9gXhQU9jPPZz1es4Nj9pme8RnsyoS3Z2LELIg>
    <xmx:9aOgaUaYEvDbCMwk8fNvXJjMUU3BnQ8wWQFy7tUACGtUl5y7Szsglg>
    <xmx:9aOgaaXYcZBtFVqnZB-3UXIjXG4spFon7erq6jalxMm3Ttv6i2cl4g>
    <xmx:9aOgad_yQaXBzzMUWzTDtASUwFek0aH1N6ZrkDHML-VRWwh_sX1rGA>
    <xmx:9aOgaRMtsUfTq3NwaWuI_dOtmEwqRkzVVsyjnWcU-_hhV44RWq3W6OfI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 14:50:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  kristofferhaugsbakk@fastmail.com,
  eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 2/5] builtin/repo: collect largest inflated objects
In-Reply-To: <20260223174120.2356504-3-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 23 Feb 2026 11:41:17 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260223174120.2356504-1-jltobler@gmail.com>
	<20260223174120.2356504-3-jltobler@gmail.com>
Date: Thu, 26 Feb 2026 11:50:11 -0800
Message-ID: <xmqqv7fj1dzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> @@ -485,6 +514,23 @@ static void structure_keyvalue_print(struct repo_structure *stats,
>  	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
>  	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
>  
> +	printf("objects.commits.max_size%c%" PRIuMAX "%c", key_delim,
> +	       (uintmax_t)stats->objects.largest.commit_size.value, value_delim);
> +	printf("objects.commits.max_size_oid%c%s%c", key_delim,
> +	       oid_to_hex(&stats->objects.largest.commit_size.oid), value_delim);
> +	printf("objects.trees.max_size%c%" PRIuMAX "%c", key_delim,
> +	       (uintmax_t)stats->objects.largest.tree_size.value, value_delim);
> +	printf("objects.trees.max_size_oid%c%s%c", key_delim,
> +	       oid_to_hex(&stats->objects.largest.tree_size.oid), value_delim);
> +	printf("objects.blobs.max_size%c%" PRIuMAX "%c", key_delim,
> +	       (uintmax_t)stats->objects.largest.blob_size.value, value_delim);
> +	printf("objects.blobs.max_size_oid%c%s%c", key_delim,
> +	       oid_to_hex(&stats->objects.largest.blob_size.oid), value_delim);
> +	printf("objects.tags.max_size%c%" PRIuMAX "%c", key_delim,
> +	       (uintmax_t)stats->objects.largest.tag_size.value, value_delim);
> +	printf("objects.tags.max_size_oid%c%s%c", key_delim,
> +	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);

The repetition tires reviewers' eyes.  I am reasonably sure if there
were an intentional copy-and-paste error, I wouldn't be able to spot
it.  But I tried to be careful and read it over three times ;-).

> @@ -553,6 +599,15 @@ struct count_objects_data {
>  	struct progress *progress;
>  };
>  
> +static void check_largest(struct object_data *data, struct object_id *oid,
> +			  size_t value)
> +{
> +	if (value > data->value) {
> +		oidcpy(&data->oid, oid);
> +		data->value = value;
> +	}
> +}

How important is it for this application to end up with a valid
value in data->oid?

If data->value is initialized to a valid value, instead of an
impossible sentinel value that is strictly smaller than any valid
values, this can leave data->value to a valid value from an existing
object without recording its object name.  Imagine a repository with
a single empty blob, and data->value initialized to zero (it cannot
be initialized to a sentinel -1, as use of size_t here makes it
impossible to have any reasonable sentinel values).


> @@ -138,6 +158,14 @@ test_expect_success SHA1 'keyvalue and nul format' '
>  		objects.trees.disk_size=$(object_type_disk_usage tree)
>  		objects.blobs.disk_size=$(object_type_disk_usage blob)
>  		objects.tags.disk_size=$(object_type_disk_usage tag)
> +		objects.commits.max_size=221
> +		objects.commits.max_size_oid=de3508174b5c2ace6993da67cae9be9069e2df39
> +		objects.trees.max_size=1335
> +		objects.trees.max_size_oid=09931deea9d81ec21300d3e13c74412f32eacec5
> +		objects.blobs.max_size=11
> +		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
> +		objects.tags.max_size=132
> +		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
>  		EOF
>  
>  		git repo structure --format=keyvalue >out 2>err &&
