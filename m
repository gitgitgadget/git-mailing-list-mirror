Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936A2D321A
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913401; cv=none; b=tdJY2A8VvMjUxvm7jJCTeA32fCfu8QEjAXzPKRVyN7rd60iSOXEWnBQaunf0HxuadC1WGwJ3DZGNmoB2/lr0P1oCJhwhgg809+w/LZ5yABnpsJXj7djHFrDglSFkCs4DdAgxnhuHwAqVxryO1iEu3HT788ieQy7MQVXzl79meyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913401; c=relaxed/simple;
	bh=p53YJ9LlQcVzvjAyp/n8mtC4wHFC+KB8DjbyOxdHa+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbaKIFlM5+UUdP5nuwvYZfdhniEOZqvi8n6pWYy+1zVckMURGxN6x9lYkt0lR/4yr6XEa82cY8KNrzQyvmxgJQRzpY/4YJQ6MEquFBUYfEw3i3C6g5/G2+bKCyAgdPbnqnc9mdb2KBc2iDQYipm0cXx49xYsI6iL77GCFuedJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJrd10hS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEL+D/iF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJrd10hS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEL+D/iF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97E23140008A;
	Mon, 11 Aug 2025 07:56:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 07:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754913396; x=1754999796; bh=ZSePJpbPTL
	wlTDTPjN7EakM9eJHn1iMVFZuI/fHNQww=; b=OJrd10hSu5sNPnSYL+EUShoBU4
	yyQAv7HMn6lsf/8nKWDW5lGhZHFgnbJbtAAhM0sB6ucwMp1UIMFxSu9AH9K9mDC5
	mxfE3cdClQTdq914A8RAZf0EbziBYCX+TS/ChMzPD4RqYT2tY6fwv8c7oBAIQIzl
	pqj4fcgODYPRDG0CF1pX6MlNNbpda1kpszCUj/pK5bZWL//WO7X+zXiDJS+YJs0Q
	NtdRS1xv+G08o5eVAphrTi1br78WCaGa44ZjpcPQPS8eMkhbI/EIHUl3vZvOFeX7
	2tjxpBoOzgdRsjv3ygk8nDPCkcgRleWaqOnUTHun4UZwXeQVXDxfgUBhjuXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754913396; x=1754999796; bh=ZSePJpbPTLwlTDTPjN7EakM9eJHn1iMVFZu
	I/fHNQww=; b=eEL+D/iFt9bD/IrMBDJyNB+msULOvxauK3/M7yGRzHCvutvbTK8
	7OZdowf3di1tN7Ug6MrU+3FTVqU30Yrd6VgivmnTB/5VeYxC3KxEfAIzw32gmYbW
	ct4b1zZ2yW+VNTt5BgC1IvnDiLwo9rOJMz1g63cQnNPDcZKDIlusTGYWfv/55zGH
	1L92z5Ie3AGMWsd1x4BoCUohSuX6PJdjv3YioSiITI1kwM4z0SdOgOxrxSJ0T/Fv
	ABqmn/WbCbwQFjk3Rl5pX8ZGkAvZItDEjvWvpJzpSTJskLqodp4ckyLx8gVW1Xt6
	Qk10P1VVFCm5LqSUaX4R633bLH2l9Z9/X+Q==
X-ME-Sender: <xms:c9qZaBlY0fKRdiChqBQhBBZKJxytmQIWsdj68F70o3B9Q50HkBPPHQ>
    <xme:c9qZaAEB05Ecr-pCm6Hcddbtv2SvQ4Rs0CgAbFSk9vjN4251cWyBw7N4SoMZlqfzh
    bHhfmIQH8zCn_FTAw>
X-ME-Received: <xmr:c9qZaBHXdF06rY-uIgpQCl8yAPomKp_Ce82G1Xq0oj7mU1Tau0xCWTks6Q75woW8umt3fjax5YpS2YBlF_6XmXvtHdq5BAiGL4AsEkeCVp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:c9qZaNNTBjBU7N_Q8BkDOZmHz4MAjJrnG8u64XC9DClkrNyKQ0byEw>
    <xmx:c9qZaAHEFm3R7ElrWZIDqa450JAdDvwrefjopqbUxbtCM5vt4rwaNQ>
    <xmx:c9qZaENkieMCVOtFP1YisjHR8NQ1qSt0TNLlvzWdXiIdzMGF5DMmRg>
    <xmx:c9qZaB-jhjxu8rV8vEV2FkVtCchZiYLgqYV7lL5hBMc_NUZSDXavWA>
    <xmx:dNqZaG4-77x8j68h_L4l3o7JTzyegkvMRjbm5RYaYG-4DPWWSHyGY2dH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:56:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eabfb106 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 11:56:33 +0000 (UTC)
Date: Mon, 11 Aug 2025 13:56:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 2/9] odb: allow `odb_find_source()` to fail
Message-ID: <aJnabZWb9WBQK2KF@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-2-bcffb8fc119c@pks.im>
 <aJUk68fgQttR2gMe@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUk68fgQttR2gMe@nand.local>

On Thu, Aug 07, 2025 at 06:12:59PM -0400, Taylor Blau wrote:
> On Thu, Aug 07, 2025 at 10:09:52AM +0200, Patrick Steinhardt wrote:
> > When trying to locate a source for an unknown object directory we will
> > die right away. In subsequent patches we will add new callsites though
> > that want to handle this situation gracefully instead.
> >
> > Refactor the function to return a `NULL` pointer if the source could not
> > be found and adapt the callsites to die instead.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/commit-graph.c | 4 ++++
> >  midx-write.c           | 2 ++
> >  odb.c                  | 2 --
> >  odb.h                  | 4 ++--
> >  4 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index 25018a0b9d..dc2c1a5432 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -102,6 +102,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
> >  		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
> >
> >  	source = odb_find_source(the_repository->objects, opts.obj_dir);
> > +	if (!source)
> > +		die(_("could not find object directory matching %s"), opts.obj_dir);
> 
> Makes sense, and I am glad that we are trending towards having fewer
> internal functions that assume the caller wants to die() on failure. I
> wonder if it might be worth having a odb_find_source_or_die()
> counterpart here such that callers don't have to repeat the "could not
> find object directory ..." message.
> 
> Perhaps something like:
> 
>     struct odb_source *odb_find_source_or_die(struct object_database *odb,
>                                               const char *obj_dir)
>     {
>         struct odb_source *source = odb_find_source(odb, obj_dir);
>         if (!source)
>             die(_("could not find object directory matching %s"),
>                 obj_dir);
>         return source;
>     }
> 
> ?
> 
> Of course, callers that want to use a different message or otherwise
> handle a missing source differently would still be able to do so by
> calling odb_find_source() directly.

Fair, that'd allow us to get rid of the repeated calls to `die()`. Will
do, thanks!

Patrick
