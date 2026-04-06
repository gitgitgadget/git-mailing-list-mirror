Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9338D019
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495732; cv=none; b=rXnKHqojQ6Cg6wx+tndX+Nz7VwFcH9K5WlM3g8I4pqAwrOsG2iR5pkOQcCbRtpKSTqiQ8EQ/NvFwqXskLgblr0/tTu8oBjJDrBYjs4ODUy2VpT/74QcYo3dfRQJDpt1AhRMAcf+wMLx86/teKMf9aglm0UnSAgkqmiI139K+qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495732; c=relaxed/simple;
	bh=SaQ4uSWyCJ3MlXBlRUWz9cqz9Z5xq5dz15zzhykU/rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQxCeIVGeMckp7KzUq0f86uWVq7iyApVS+eXh/WaQVghWCwStWoUwoTUQw7kmvOZTKwB8XzyXJJ3Na+t0fB6KkV0D5yMZjaZAIp8o9gFnbjlNTB4DrzzX1cz6xD42x6NZL0s5BEOp+kw5cKdHXdL2qUxLi6KZBDD1l4SP79TQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x3Bb5BSI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mSjFUXJJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x3Bb5BSI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mSjFUXJJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D81A67A02C6;
	Mon,  6 Apr 2026 13:15:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Apr 2026 13:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775495729; x=1775582129; bh=apTmOoShI6
	Br/MrUqkH9SBt215s1E7DViidsauiZ3dg=; b=x3Bb5BSIiF04uIK0uBFIWzpYi3
	kik2SazJ4E4jC04kO5IDqkUbPEb0tcba9R1h2p5IGv3ncZCgLxnytQlCnR8lhop3
	KhTG+ya45G41CpvdKfkVgzPB2U7/80urLa34b2N3zEhNoPdxFS0OYr/umAqJ1nUJ
	4hcIIvEzn9hHrPTkghrlwwRo1kd2DpETYpM9dhRHzvxKcruJik2JFGMHTEKqb6qk
	l+bef8L2MFG40yLlwJzArhXtVRs50CXDY4AdZt9lifc/O2sDgGfXf0aQOL77YdcI
	hJalj45F7CeQAbGFwdT6YRqbRsSryD3XB6grgZAF2KEzXBzTzTmv0SEuVqPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775495729; x=1775582129; bh=apTmOoShI6Br/MrUqkH9SBt215s1E7DViid
	sauiZ3dg=; b=mSjFUXJJ26kkfhpKkUPvuZZr7+lmtIXHJqaIglNhS0Ftyzt64Zd
	NDCBFVAChoHxoL3b3ZCgARgm7zw6c4Zkw04bHg8V+bi6jmmqr7whXuhsAXSHIoHM
	N3yruyUTGwzVmmIWqeipnE+QwGO/hmef/3pdhdjuYvZoCwL9ohNX4xVRbEbrpBzv
	Rf4f0dZ+xr1KvpQfQdn+9GhSmHyD6xlX/gMEl4FIF5//ygS7RCaFsVubDStnR8EF
	zpgpUO20dYcb9bI8QiKqzWJQS1YCYPf42UxBqFn+9+8Vfd5XrNdjJ5xHnOEp6318
	9VDI/wDL/TJM1SSfPU0NxM98NTwvjM7eK5A==
X-ME-Sender: <xms:MerTaXkqV1Jpq9ioi5e2_ep9YUJBOv4T3T4sREsH3XtO0JLmUW1e0w>
    <xme:MerTaSTDoybQFbIdntljvD8JJondhKO4hXeTaO0cO8-Kahhv9w8vKkwm66cYYngBj
    oRanpL41KVkg9wPq4YRZ_r9BoJkNCw1a_SgYg5BHQmzaMHl5Rs>
X-ME-Received: <xmr:MerTabB2uuYF1DZKvheEnTGhz6ATYP9pDmFV_lowPOmnhbkAV6zEnsXt5i637ItCdO6Nw6rdtEcwXnFlRym38vcT3GoIzTLDaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrhiesrghm
    vghrvghtrghtrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MerTaZQsEbdz8BdUR_zuJuf5_hLHlkxERS1KF0KzJdNsHTOYbTIx9w>
    <xmx:MerTaZpuLjsgsRelw-Df2dNj-TqEsXd5NRKGR5-XXDm2LZChHY7hwQ>
    <xmx:MerTabz0rHY68FX_zSTJFgfoZMjtzifEkfV1yKPSlt4grYnJg475Sg>
    <xmx:MerTaeIlqP4ZafllROtggN9N5anh57SSXmKVzqnwBEDfHRLeZlfPeQ>
    <xmx:MerTab7BuZNdlb131T9Eb0QQC7qLe24vq2I9qlYfXIFTg8lDcBMIbrxm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 13:15:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
In-Reply-To: <20260406063607.15353-1-ray@ameretat.dev> (Raymond E. Pasco's
	message of "Mon, 6 Apr 2026 02:36:03 -0400")
References: <20260406063607.15353-1-ray@ameretat.dev>
Date: Mon, 06 Apr 2026 10:15:27 -0700
Message-ID: <xmqqo6jwau34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> fast-export chooses its output order by pathname, sorting longer
> paths earlier. However, this causes faulty output when the deleted
> path is a prefix of the added one. For example, deleting a file 'a' and
> creating a file 'a/b' emits:
>
> from :prev_label
> M 100644 :blob_label a/b
> D a
>
> Fix this by sorting deletions to come before other types of change.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>
> This is a quick and dirty fix for the bug. However, I do want to spend a
> little more time on it - it may be that we only want to reverse the sort
> when the deletion is specifically the prefix of some addition, and I
> want to fence this off with new tests.

I recall doing something like this in "git checkout" and also "git
am" to ensure that a thing deep in the hierarchy will not be
affected by a D/F conflict at a shallower level, so I do not have
objection to this kind of change in principle.  I do not know if
depth_first() is the right place to make this decision or if the
function should keep its name if it turns out to be the right place.

In any case, it is a bit surprising that fast-export survived this
long without having encountering the problem you are solving.  I
wonder if fast-import handles such an output with some smart to
avoid the issue?

Thanks.

>  builtin/fast-export.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index b90da5e616..82d73b2f43 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -354,6 +354,12 @@ static int depth_first(const void *a_, const void *b_)
>  	int len_a, len_b, len;
>  	int cmp;
>  
> +	/* emit deletions first */
> +	int a_deletes = (a->status == DIFF_STATUS_DELETED);
> +	int b_deletes = (b->status == DIFF_STATUS_DELETED);
> +	if (a_deletes != b_deletes)
> +		return b_deletes - a_deletes;
> +
>  	name_a = a->one ? a->one->path : a->two->path;
>  	name_b = b->one ? b->one->path : b->two->path;
