Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483927991F
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708769; cv=none; b=ue2VgEU/pfgF9TX9oexjOiPA27X+LNFST5jOK0U4d3Dznrbz0aFlyhPyFtv0DchCLTF8sXtOtwowvwal9hnjGHDmtzIYYJbNK/Ftl88Lr2MMtc8KgcQsEE90BvpJ5Y4iQ6Cj7LFpw+Td3Sf6PsQdhJa5ibF8mq90mG8bDjIWlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708769; c=relaxed/simple;
	bh=Gbm4oByw+Hw7dxvmX8hC8Gj0+Bk3riaETiuNzP/kwt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMqCtwzNvJMRgXgPejjoBYO/87MHz8wtN5VXKuUvgYW57YAr1ym9Yzt3Yl1c7N1h3t7sE2vE3yL3I31Z8s7f5O6cbFIzkQXu6+pKRq8rZUYdfJPrFsmQnAGgmiGuuF5iDXQNmOVZqxeqpRTmztLWWjjfirZ29ILAzmAsqPVOec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pddC6xdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZCaW5KB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pddC6xdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZCaW5KB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F04F11402F3;
	Tue, 15 Apr 2025 05:19:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 05:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744708766; x=1744795166; bh=v61qiqwJqG
	zh3s//XnScgFPkh4No8J6820ZcIAuw2SU=; b=pddC6xdAOv3A9aBfPO5kPS4eqm
	uEABEWA9vl0EbWV2wCEveUomSBQNntGOlpfIQPDKEI34ABKgXmtaoEdqmgwJCQZh
	io1DZfuyP66yYOVkBFMwRwLSf0ms3CuWjzMm5NmBJJuEKkRGna9UNwPyNDQi4N6j
	/4ovzEgp5S4IHD4Z2IKzSCeDXpj8kZ1lEg8vz5ei7fn0sw7m9+vvI3WGDytbaF61
	eyl//5ZUgZVUqLmH5pGrHnqDAylfe3Edv/Q1qyjWtw9aELbhOQPn5n4lDTVUTwGg
	NMb+JsjYRiezb6IOUq5mcEZiue5zpuh/0Cw4VbDHkssXLDq6t/hgp6G2ENWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744708766; x=1744795166; bh=v61qiqwJqGzh3s//XnScgFPkh4No8J6820Z
	cIAuw2SU=; b=GZCaW5KBkuuSaLQGMLcgAwa7C6UaWDfbTziFf1h9dQCK3X1R8yc
	tp6U9I/NHNZRdK/eKRheDbe1Lgza5uR1YryZRtLdqHIZoc5aPjlPxYYnfbWxrSgU
	F06ao0SELBDkH+nrvEn8li5rF0q9iD+L7VJrJ3nnxztx5puZOY5/yk782HQCJJH6
	UCAWuqvTr1ZuPWNhNMdMHr0n7YCx3075mVxfqSW0n17ickcsMlDsDUmwvFXVYBZ3
	uTw7uFazBS9sHY1tDqIzd39gjEqQADe3/y4oyi7yjFa5pzTZV5EtnSYYWlW6qcRD
	ybIclb+X0a2nCCnwLzA6M4jppr4zOus0Xzw==
X-ME-Sender: <xms:niT-Z9S7bjqMhw8mO-KHB86b9kUf5VvGa7tzYZYcASEG1lJBv4UuuQ>
    <xme:niT-Z2yNTKXhbpSyJOUvgVXrF9YSmmTPuwIk6GIx46FN9hCi_I5vnkVEWWdhWlPMh
    O4-y_eVXy4bI9gYSg>
X-ME-Received: <xmr:niT-Zy2Xlye8xhVtph62pHsF3PQAzzjr2SuOhY0RwG_-TZJUPx-RggvzpeQ1CWdiXGy39ZpZ8WQRrxDrEkgfJfwPohDjDR7joSfAwoEeCzpoaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:niT-Z1A4vbUHa5o0lMo9C5u-cdzNPC0jngjsEPsG1sLO6X7CIUmrig>
    <xmx:niT-Z2ieLOiUvTb2Yw0BGJXlZ0fCfBDY6ZAF5mPk5U0t3ReZSvrQ3w>
    <xmx:niT-Z5p-F6onGwZCcHBuwFsBfm6p-HFRiIf3bpyIGXrfpfQdKZSmZA>
    <xmx:niT-ZxjVVDzG6xcWMwuuJ_bCaBQUgvREgC-qcrEWYfWGYNvfGI2kzg>
    <xmx:niT-Z88E6nrwaS1fLPyvDc5NW98rPu-rxGhQQiv9p-mn-pmDxZSKFnaT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:19:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6b1b2bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:19:24 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:19:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] object-file: split out functions relating to
 index subsystem
Message-ID: <Z_4kmxMhCnsRyPwn@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
 <20250411-pks-split-object-file-v2-6-2bea0c9033ae@pks.im>
 <20250412081724.GA109770@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412081724.GA109770@coredump.intra.peff.net>

On Sat, Apr 12, 2025 at 04:17:24AM -0400, Jeff King wrote:
> On Fri, Apr 11, 2025 at 11:29:55AM +0200, Patrick Steinhardt wrote:
> 
> > Split out functions relating to the index subsystem from "object-file.c"
> > to help us separate concerns.
> 
> I know these functions all start with "index_", and they do take an
> index_state variable, but I'm not sure they are really about Git's index
> subsystem at all.
> 
> The term "index" here is more about "compute the sha1 index of the
> content". E.g., the function index_path() goes all the way back to
> ec1fcc16af (Show original and resulting blob object info in diff
> output., 2005-10-07)!
> 
> Back then it did not take an index struct, or even care about having an
> index at all. Later, they learned to call convert_to_git() in 6c510bee20
> (Lazy man's auto-CRLF, 2007-02-13). And that function may check the
> index for .gitattributes files.
> 
> It originally just used the global the_index variable for that, but
> later commits like 58bf2a4cc7 (sha1-file.c: remove implicit dependency
> on the_index, 2018-09-21) passed the istate around the call stack.
> 
> So having access to an index struct is mostly incidental to these
> functions. Which makes sense looking at the callers: there are many
> pure-object operations that would work without an index (or even a repo
> in some cases!) like hash-object, git-replace, diff.
> 
>   Side note: I'm actually not even sure we would read attributes from
>   the index, since we don't set GIT_ATTR_INDEX. So I wondered if we
>   could simply pass NULL to convert_to_git() here. But I think these
>   days some of the "auto" CRLF modes also have heuristics based on
>   what's the content we find in the index for that path. See
>   has_crlf_in_index() and its callers.
> 
> 
> So it seems to me that these really are more about creating objects than
> they are about the index. I don't mind splitting them out, but it seems
> like they're equally weird in read-cache.[ch].

Yeah, I was too trigger-happy in this case indeed. I'll retain the code
as-is for now, thanks!

Patrick
