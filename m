Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43885244E83
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051590; cv=none; b=WpOKYged88JdE5NYTqyHe7H3GC0IipoDNWxvnu3d/fvgvTOkv3ubjbXNRYmWfXoDUJh2Z0+fvPN2Ey6NGLYcBVfVJbf/yEAt7XUkPIecJftshTOkpYD/LYIgdErHvey1Hsid6DckQ2bCYcd9sArUfXGLiSQsUK1pihvi8BNuszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051590; c=relaxed/simple;
	bh=VgVNK1g3Ur/6CujCV4KZLDEqQjEJcS/PS4Zbw1C2CVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jlHyCLg0gyr44db/YJfg8iSYPMyHRvCmuK5u5gXksD7JH8gRJZkHKDYkC+z5/ioF9sgAJnJOIJsN11cD4U1Fqkp2eYdX8yKfOwrvIxECK+Ui8KAYOMygeRQyfgsvQxklOeHQZgXemLwWx6D4iv3Q4M907N+wO86E07AzZuvTJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttx0osoE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2zWk4kU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttx0osoE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2zWk4kU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24A14254007C;
	Sat,  8 Feb 2025 16:53:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 08 Feb 2025 16:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739051586; x=1739137986; bh=7YPMcx+LgS
	K4jsRtTho+iQe24SLeP+Q1dTFOQgY3fd8=; b=ttx0osoEvvrS4xxPPmsGj1YIQF
	WhWMZ6bS8L3mqLP0UEwenZ83k+zcNATmU35VcDAvgXlf1GRDjFS8g+B4OWfFcA3J
	xL+r4/twm78wNM5FL7AwnbCWoDJY1t91M2WukLI7lPESNwnghvGd58YZMgNGa1Vd
	+uZIodRDI5uy5QKBoRSaP0MBPSCo6dCc1oDwde6sItDBYOYWX5p7NoGZTgGSFy1W
	8+bALLKypucVX0JbKjPWL8oIXHs8X3uBzfYILmzOGC4OXgbtLqw94VxccdA9jtdD
	glF76BbxExvmJuphpyR8MogLQfynAJwN7ou+l4VCYNkX1lmfoYyApWNs0A/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739051586; x=1739137986; bh=7YPMcx+LgSK4jsRtTho+iQe24SLeP+Q1dTF
	OQgY3fd8=; b=R2zWk4kU5lh1J5MYHPNO8dNvFkn3ATIC5cRqzCceqwGLMggxuTF
	9CnJmRKnjSQwbqGr7eGl5JLAnFGghqYoDkfACEjBQbW2qzL3KLcWKNP2QKwBq8OT
	iYefh4FwFwbdr8/wb/5bdK5P1jcgsJ6sERtMURlAUPy3qX08pVCgaF1n+TA6dnzD
	wHAIrFCw+VXupkQlQSCR6odIvyoWfkVZ/EYCr/jGPkoKJ59KDgv9KuHLdjsZ+ui+
	oxonAOOeY8weBdMUTYrhmqs2bxCz4P8U8/4OkCQI46PEik5emgd0j+3e2sBAB4kk
	idGW1OlNB8U3YanwPf3O8XakgoiU7h6+MvA==
X-ME-Sender: <xms:QtKnZ_JsP7eBohfZAsbEPBTTeIuLZcFy632CogKVejuEX--mFdBtBA>
    <xme:QtKnZzLr8JTdNhgXbOGTZRIuAXonD46bDCiRMtJsavW3KwYLWiyzXY2tbWlqGZbK0
    lON3nUmqBqBEnZQng>
X-ME-Received: <xmr:QtKnZ3toWwOSelp5F0f6596fBAIefr_Gn-0hMEzcyxYciNgqvMmBemce-yVlQYdBpmoqeANQHI8NqZW6m8yO7MPZfsMWEr8v-Bd_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeffeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfhhorhhivhgrlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:QtKnZ4ZqEc428UXGyYHnh0liCAkPHV4higtDaA1G41yCq7vuHIzVMw>
    <xmx:QtKnZ2aD6gZVrmrn5DpxFEOlCINfCV2RqPyzWEW8hTaH8E-nG0p9QQ>
    <xmx:QtKnZ8Ay1rqmzPZDyCq4sMKafp07Iq0d2yUWLMwOE3f5CMJQ7JGHlQ>
    <xmx:QtKnZ0atabrlo_mHbU_6dE9s1orN76mCNDNb4WWJqgGwAfAJlVcVkg>
    <xmx:QtKnZ2EwiprEMqyRX8pB-STJpYfvFCTq_M0VDhadzLzPfZ4AOfb-RoJX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Feb 2025 16:53:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily M Klassen <forivall@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
In-Reply-To: <20250208061702.88469-1-forivall@gmail.com> (Emily M. Klassen's
	message of "Fri, 7 Feb 2025 22:17:02 -0800")
References: <20250208061702.88469-1-forivall@gmail.com>
Date: Sat, 08 Feb 2025 13:53:05 -0800
Message-ID: <xmqqldugdry6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily M Klassen <forivall@gmail.com> writes:

> "git log --graph --no-graph" missed cleaning up the output_prefix and
> output_prefix_data pointers. This resulted in a segfault when using "--patch",
> "--name-status" or "--name-only", as the output_prefix_data continued to be in
> use after free()
>
> Signed-off-by: Emily M Klassen <forivall@gmail.com>
> ---
> I previously reported this a few hours ago, and ended up digging in and figuring
> it out. I'll make sure to bottom reply in the follow ups to this patch.
>
>  revision.c | 2 ++
>  1 file changed, 2 insertions(+)

Reading the symptom in the proposed log message (which is very
clearly written, by the way), it seems that this is reproducible?

Can we have a test to make sure that the fix would not be broken
later?

> diff --git a/revision.c b/revision.c
> index 474fa1e767..84cb028e11 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2615,6 +2615,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		graph_clear(revs->graph);
>  		revs->graph = graph_init(revs);
>  	} else if (!strcmp(arg, "--no-graph")) {
> +		revs->diffopt.output_prefix = NULL;
> +		revs->diffopt.output_prefix_data = NULL;
>  		graph_clear(revs->graph);
>  		revs->graph = NULL;
>  	} else if (!strcmp(arg, "--encode-email-headers")) {

Interesting.

In response to "--graph" (the code we can see in the context before
this part), we clear the revs->graph and then call graph_init(revs)
for ourselves, and we do not have to futz with diffopt at all, and
it works OK because output_prefix_data and output_prefix would be
overwritten by the graph_init() to the value we want to use anyway.

But of course, after "--no-graph", nobody clears these two members
for us, so we'd need to clear them here.

It might make the API less error-prone if the "clear" function
cleared the .graph and diffopt->output_prefix{,_data} together
but among three existing callers of graph_clear(), only this caller
needs to clear these two members, so it probably would not matter.

So in short, this seems to be a good fix for the immediate issue,
and it is unlikely that we'd need any follow-up work.
