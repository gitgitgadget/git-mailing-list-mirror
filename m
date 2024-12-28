Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0435958
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375287; cv=none; b=rinaFWgu1GcsVVbgSwssdq/jzu4LtFg49+d8v31bxGNGT2z5vtA2TR+JsPF9m1TWtTP1NPK6G3umQVdyN42pbI2VrG8TZRzWWDUJOZI/sgHFG/gye5KVy6cMcr+G2zRXozG1E/fi2f5nRcgZZpFFe47l2hzqEYb6cWrnMgDt2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375287; c=relaxed/simple;
	bh=SqbnMiH3WZL87vaDru4OPa6aZ/J5fFADCFxxcctRLLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5XhsgXctH2gA5YviXH2pbFo/hDKDj3w37msmUU3eR8cwUiRCCNEjtSfhbLK9nQYmu0QVMhgXfkeHfeES+XpfU1+e7Y9cbcDy+Ddxrlf7sX2otgL9rgO/xY23WU60ebB5ZyYXwiBDGC/TKGgG31fFV/oT1ZQ1y9TVenuqZX8aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yp3BMw+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjO6dPp2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yp3BMw+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjO6dPp2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 280CC114013D;
	Sat, 28 Dec 2024 03:41:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 28 Dec 2024 03:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735375284; x=1735461684; bh=P8FfHrp3bM
	XsZmGJkNMxqH44jeRGBHhpzu5SMxZjvPk=; b=Yp3BMw+mDQkzpN0XhF2IuDuXgU
	N72axZRuTrVaCvpz9q167LMcmqnpbDFcpPqerYxySdtNYKYgYaI+0A2E8m6BkyJi
	t3OoOAsY6a4gbbx6jfQdH9nXrpbiLlMgzB3joO4xJLERXE3Ewo+XAjTd7jOF2sSK
	3jBdxNlxYme864Vm34j8tvQvaDdWTqPy5xGmt1+dGvVowiPNyuIN9V8ocM0dahit
	4LRZm3EOPdWjXVriG21vqjmgkXadg8dXvCRB8XXgX+DLygMeIxaHPZtYfizT6ry2
	GH4LhgguBtFqPARoM4inOg6FVGR2jXFT/RwovfWKfo0/NxxeftZgIjL/yQmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735375284; x=1735461684; bh=P8FfHrp3bMXsZmGJkNMxqH44jeRGBHhpzu5
	SMxZjvPk=; b=mjO6dPp2lqVMt8WxbcXzgZzmuWgkWewps5SVgzDDTEd8RsuIUKC
	8or6Ksw1uM97iBJTV1FsGjRMpl2ytmGkQunB7Q1veWgSM4hzAhD9gyctfbBKz8Pa
	Unwfe5UkPYn/3MxiTa+ZjPjBl+7JWmA+Pgd8zZ9SWZlrJL0fnet5FsMNnv0uEvFl
	dAvRd9raf1QWQ0kLQNd8hXjsnjQJgUmAw5rUaDqbM1MX0EBB+4eZuit19/Ka8t+s
	DYng4t4569Evvre7eAiQEbFquATSkrcmrR2QuL4Dgii+7YJuAShozWvFCdGMHQGm
	TUvDeo5iir2Je/ha3jylQA7sZKZoM/RQdsA==
X-ME-Sender: <xms:s7lvZzk9Pxi2mCyqqej0UvIhRIvMU-yrICRl-xacFP36gXHUddCL8A>
    <xme:s7lvZ21jcEptkOrZuuh3CvVmy7eh9wBu0nC0PlH7y3L51WD1C3QDB8jBo8Ptel665
    YdLKVs9qqFyXarZKg>
X-ME-Received: <xmr:s7lvZ5qbCtHvS3a4jVDx96wd4pIvA3p9dJVm5IdRglDziLEJFVSC972u_2YNchzpmWk2MShotlKmuEr0vb2BUOaWhRm_zSF_yhiwqbeZg4dn_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:s7lvZ7kILMwud5HU4h5oL0nYfgYlIS8O_BuZtCAv7-v7qAJ3lXmMdQ>
    <xmx:s7lvZx2xZTMqMTtdiHUHWLMqUwZu475qyzcerPyJUaAobiQ3TVHAuA>
    <xmx:s7lvZ6sTDy0l-TJRmc0zO7-L2uzjKvukA3L8CL0udwnFE7YnqDOvqw>
    <xmx:s7lvZ1WTWJna_AaR5kZHrgIaVjEF1ZLVjTH7cOn_ywRZWPHVXdD4ZQ>
    <xmx:s7lvZ6wjiB7eUfF6Oqp7mesVYiRMUHA4BLxLMMDt28OlEwSRkclxbOBf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 03:41:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb592961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 28 Dec 2024 08:39:34 +0000 (UTC)
Date: Sat, 28 Dec 2024 09:41:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
Message-ID: <Z2-5nnBzPKP3iPxl@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <20241227213729.GA796141@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227213729.GA796141@coredump.intra.peff.net>

On Fri, Dec 27, 2024 at 04:37:29PM -0500, Jeff King wrote:
> On Fri, Dec 27, 2024 at 12:08:03PM -0800, Junio C Hamano wrote:
> I doubt there is a way to tell the compiler that (or that a compiler
> could even switch to an unsigned ptrdiff type if it knew that). But I
> wonder if there is a generalized helper we can devise that would avoid
> simply casting here. I guess that could be a checked cast like:
> 
>   static inline size_t ptrdiff_to_size(ptrdiff_t v)
>   {
> 	if (v < 0)
> 		BUG("surprising negative value: %"PRIdMAX, v);
> 	return (size_t)v;
>   }
> 
> or even:
> 
>   static inline bool has_space(const void *vs, const void *ve, size_t want)
>   {
> 	const char *s = vs, e = ve;
> 	return want <= ptrdiff_to_size(ve - vs);
>   }
> 
> I don't love hiding basic things like this behind macros or inlines. But
> allocation and bounds comparisons do have gotchas (especially against an
> adversary that can try to create pathological situations). Maybe it's worth
> having an easy way to do them safely without having to think about each
> one. I dunno.

I think having a wrapper like `cast_ptrdiff_to_size_t()` would be a
sensible solution for now, also because it fits in nicely with
`cast_size_t_to_int()`. I'll introduce such a wrapper once I've got a
good excuse to do so.

Patrick
