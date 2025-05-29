Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC722CBFE
	for <git@vger.kernel.org>; Thu, 29 May 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532204; cv=none; b=XotNs+H70hrW0mbkPk0YUbW2NpwMswtJNQ5vTRNmSVUtDJxZW3NLQY6yJjm0fA8y/2A9C8AYLJGj6iXELLpCRKn27IkAN22/s3viCl38KHEV1WZngAagpfWCUOvtal1ZE3BlprVuMLAc8hCZU4KOZMtae1FN7rzWAkEJomq8mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532204; c=relaxed/simple;
	bh=LFnuQ47LCBmZA22REprHQmgBigoPajTE8euqaUcTgAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbMmtxml+W9VlWosjR8kssGcqfErwzO3uu5Dj2bQrBK6KKg6nJFe5CR/C6MVCWSADPI6r5A2YWBo0M3jFLOnTeZJLVDBo/MbC8EMWFj+t9LKNIlbOi85vCbiKq2ygPUjqAix13y5UU75lUZxfrmUSllvFdxWpLkzF1By3g1YUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=etz3zKaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbhbPx66; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="etz3zKaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbhbPx66"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 56EFB1380103;
	Thu, 29 May 2025 11:23:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 29 May 2025 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748532199; x=1748618599; bh=2LPL9PrZbs
	gUDUPTUCgXm9GjvHt/nwA4fT4uv8FmU40=; b=etz3zKaH6bKi7ml9XhYhhoeTwn
	q0fFLN9S5qr7xH7hwpfM/VjSxbZ6MEl5Kw+8j0GXXu14eBYdnXziuZA6wJbNlDwZ
	w5FBiLax1xjIWDSuB2ax8+eb+YrxCFJtEo9Hp0SFco5vdP+xIZI+/9G1hwVbDRaF
	IvwsW0336f9DUdguGtvIHET3hK0DYIeEiZ/4RRydNeIHKr2n4DnVfglCx5otDo++
	Bmow8aOycEwQLh7z8ou5iV/YebhVsS6jfpp4/kgQ9OfT01mvAUIKbgZ5QcJlzewz
	z+MtdF2gs9gH38hnBsPU51H+FbTWebifS60ioIc8R0jpCITU5tHD7RUmIP+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748532199; x=1748618599; bh=2LPL9PrZbsgUDUPTUCgXm9GjvHt/nwA4fT4
	uv8FmU40=; b=MbhbPx66/sKQx7w3R22LfQsAYyqbzTN0cNLhge5zyiudrs+ohCd
	8lrcPOeIRzuUyyvEDVlLiCSCqYYgPoKPQ2fcGK+EgxG52LBVMWSAPynb2FZSNEjT
	RkDTJjKvG3bV5GxOsvtiHb2VvJNL2erxoEIhXd0m5CDNw7rl/H/jLMpObjDe6lJt
	Z6BoCjIrg5YiDzjvBiOcsMlhY/R6WPEhXXapq5Z+tpfNd9kBom10/ptQA3M4jTjZ
	co6k3mdZLonN5uabXtXmtXdjs1ZZOnd5uF7JxHqlDZhPNDdbL/k6qWBUA8fj1HzY
	v/VbprXBGAsPId0UIj/RNnyjlp3F7P/R/cA==
X-ME-Sender: <xms:5ns4aFceYUqBNn2kriDMmkTjFzGKs5iOvlHrVlX7_9rimWS9oQoh8A>
    <xme:5ns4aDMxxp4ePL7kmA87lR4Ycwj6-xmhnR2IaWSADCHCYkMt4T3yP-xs8EU-doM1W
    hcuGoEnaj4k_2e43A>
X-ME-Received: <xmr:5ns4aOgc-zZ-nTkCiAyFCr74BxUIfVL_2xyS5iTM54SLKPARPkwvv-cFbgd27SIrF_lfk66a95b89UxUNxulKsdxyRra71-vGuu_0nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieegleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfff
    ffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshi
    htvggurghntggvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5ns4aO8qpx_eFCSZhL_lf_Ylp2VeH8lwwvQAcSIP6jjAbZ7kTCoh9w>
    <xmx:5ns4aBvGV70tiNdBKD7qkWLrhuTkSQjOWrOwh-PadXK2mEIIeimqGQ>
    <xmx:5ns4aNE3Jga7bDZvPOrtz5vzxsNh12_ScAPvRkGi3jAVFGAoNHAfTg>
    <xmx:5ns4aIMbtRk5bKidOz_HxUWV46mIo6TXqYgAs2VjcE-a6hCow3JI7w>
    <xmx:53s4aGPBn29TOdj9WsMm3cRflgh9oqtJWiQPSgc7QxXrqtsRgj5WmI-T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 11:23:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  jonathantanmy@google.com
Subject: Re: [PATCH] promisor-remote: remove the promisor object check for
 failed fetch
In-Reply-To: <20250528095830.30306-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Wed, 28 May 2025 17:58:30 +0800")
References: <20250528095830.30306-1-hanyang.tony@bytedance.com>
Date: Thu, 29 May 2025 08:23:17 -0700
Message-ID: <xmqqplfrmoey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> If the promisor objects fail to fetch, we check the remaining objects
> to see if they are indeed promisor objects. Then, we die on the first
> remaining promisor object. However, this promisor object check is 
> unnecessary because callers of promisor_remote_get_direct already filter
> out local objects. All objects passed to promisor_remote_get_direct are
> promisor objects.
>
> The is_promisor_object check essentially iterates through every object
> in the local packfiles and adds them to an oid set. This process is
> agonizingly slow for large repositories.
> Remove the check so that we fail immediately.

Thanks for CC'ing Christian and Jonathan Tan, who may indeed be good
reviewers for this change.

let me think aloud a bit, but because I haven't looked at this part
of the system for quite some time, what I mumble may not make much
sense.  Please bear with me.

So the incoming list remaining_oids[] is what was already filtered
by the caller and everything in it should be promisor?  If so ...

> -	for (i = 0; i < remaining_nr; i++) {
> -		if (is_promisor_object(repo, &remaining_oids[i]))
> -			die(_("could not fetch %s from promisor remote"),
> -			    oid_to_hex(&remaining_oids[i]));

... the first iteration of this loop, after is_promisor_object()
says the object is a promisor object (which is guaranteed if
everybody in that remaining_oids[] array is promisor object), will
die immediately.  So your "agonizingly slow" comes from just one
single call to is_promisor_object() function is ultra slow?

If that is the case, the patch, including the above explanation,
makes perfect sense (note that I didn't verify the "everybody in the
remaining_oids[] array is guaranteed to be a promisor object" claim
myself, though).

But at the same time, it sounds like is_promisor_object() seriously
is wrong.  Perhaps we need to tell pack-objects to pre-compute the
packfile.c:add_promisor_object() stuff and cache the result in an
on-disk file, just like reverse index is stored in an auxiliary
file?

What do the callers of the function use to "filter out local
objects" to ensure that "all objects passed ... are promisor
objects" do?  Have they already spent agonizingly large amount of
time to do so?  I sampled a few existing callers but they do not
explicitly restrict what they throw at the function to promisor
objects---they prepare an oid array, throw anything they do not see
locally in the array and call this function.  So objects in the
array are either promisor objects or missing due to repository
corruption---we simply cannot tell.  I suspect that the claim
"everything the caller calls the function with is a promisor object"
is not exactly correct.

The end-result when remaining_nr is not zero (i.e., some objects
that the caller wanted us to be fetched) would not exactly be the
same.  The function used to die only when the object we failed to
obtain was what a promisor remote promised to give us.  With this
change, we also die when an object the caller asked us to fetch is
not promised by any promisor.  I do not know what the implication
of this behaviour change would be.  Reviewers, comments?

> +	if (remaining_nr) {
> +		die(_("could not fetch %s from promisor remote"),
> +			oid_to_hex(&remaining_oids[0]));
>  	}

