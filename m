Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C609228C99
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789922; cv=none; b=lHCAoZcl1wnsr6/weKhuJG//qEJf6VRlurW4iwv38STzAJS298Kw8T5K9+teQ93sp87PVMS4GlXtrpY4Q/4wi+sfwB8VmhEuxk7GXJppeJsB9QWjU1PvDIp05NwQ7LyK/iqNaoO5634RWpCgFMRRYDVaclU8Ck8ZENyNRwXTXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789922; c=relaxed/simple;
	bh=SIJl4hldPsMKnADpbMQhTx+79gWO9q/qvNVS+Yc6WBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNAWq7nxp9yZkLxHGXtnY0cX3nUfRUmBOHm4hCNCeAAy9YrdZ31PrkkXqduyxEnm2W06G648XeNbLZUYrm2gg3Bdr5z3AdkZE21jelEeupbMsSpNe9NEVUZn6dc2zGbkp6jUa2BuKSYgxmpZYSWKRwy9BZcchWq0Ka+x9nH3WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lGqHlO1c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uZT/spb8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lGqHlO1c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZT/spb8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 59D731380229;
	Fri,  9 May 2025 07:25:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 07:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789919; x=1746876319; bh=AEg19Lb6QF
	WUijTNvejLxVLmSzHeal5RVC54ZF1SylA=; b=lGqHlO1cXWHqvpnkqASb8BujHW
	bI3h260jtoPi6UaxqypTHPI2Xt37U7Fv4rQZA9bjETOzqGLbn+6y6xuCYXtFYGJ3
	EiHrUuJ5AOBjzV9o67APQ4OmAfTrHMPnzfK4Ql6ji2vkLO86JGuB3Ry0fLLwq2es
	4Gojni0jdd3FM5Lds+XGmgBrwZBbFl0przAuClFHUIrjmzLpahyWGtolBe4ssMOO
	mY5t7XpEXX0uz01O+DUZ2FWerZofBhlcQ52oyW3S2tBeYE3P6n2YP+hz02n6RpMb
	4AC2LW9ff3SiqDVShCsr+mDB70c7zygZIAygFSSri2LyJ6WbtuHMFi7ghOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789919; x=1746876319; bh=AEg19Lb6QFWUijTNvejLxVLmSzHeal5RVC5
	4ZF1SylA=; b=uZT/spb89LrJdy0NIrHIiCAK/2gdWHTdPPNO78YCfmbDpk6wVPj
	PRfgEYaN/qRRMxlnweekk1OjZG7Rbz6WhjP0SkzKBDruBkfz/p096XfmBf5PVz14
	I6rhjLrHx3A+YJG6bowImolTUJv/OL3q5W6wOyGLnIzG1Kmxbn4Nv8VJiqnEZIzl
	72wxwAq83Y651Yn/Fecd89S2pA/VG+A7Tl5JRcqUsfKrfRQa1ubfAcvoTXo1XLgx
	QVf9ZctoYPFKkTLgE39fOcJ/6QI7YT54jY/yOf+eY8srIWPZpSO4CzLMl2FduzjL
	CBrYnI13CTpxC+vbd+7iAgFFtVKY7cf+vKg==
X-ME-Sender: <xms:H-YdaO-64TxFVOWU32HiYLImdYifqFKHz-n34fDaJ7ZKSoXVEoJ9Lg>
    <xme:H-YdaOttWZi_BVx_uQPJMl5ZDk0qXVxQzInDSgon1NuA4r7rkkX0s5wgL1Y_GFv4v
    yqBLWWQjUmubG8WNw>
X-ME-Received: <xmr:H-YdaEBH2UxkIEdShOFSKuidEBgQMJZrd63eCqOjcy-m1Q1HNwpoE9MrnoAtnW_uVr7Rgiyah8l4Nrjdjvk-FS5jRCTeEgLEJTzNoE6AiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:H-YdaGdCamJqC9cuplDfJjiiQrNzcmDRdpK3GIqj-wmKYKw9cqNvSw>
    <xmx:H-YdaDOUHiQbH94jWrWgfRhgVt5mHELl4UOkDmMPadZWaxf8soYHfw>
    <xmx:H-YdaAmIFTS8ToqQ3QLAeBFWkD9CchYUuQWsk1gZfGSFd72g7zXRdg>
    <xmx:H-YdaFuTTC5KMeGfBnViahsknpH50tANna1nZMxvqeE8-lU030kkLg>
    <xmx:H-YdaKpnWfHGa2pbKYMy_Ujf7SiSsxzaLtsHpGpq9_Mxd2eTMpsu0MxU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e596e9b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:18 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/17] odb: get rid of `the_repository` in `find_odb()`
Message-ID: <aB3mHVX0A_ADYLKM@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-5-c05b82e7b126@pks.im>
 <d731678d-bda2-474d-81e8-39da85bd9038@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d731678d-bda2-474d-81e8-39da85bd9038@gmail.com>

On Tue, May 06, 2025 at 09:10:06PM -0400, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> 
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index 0a184d39720..28550d3bcc9 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
> >   			struct repository *repo UNUSED)
> >   {
> >   	struct commit_graph *graph = NULL;
> > -	struct odb_backend *odb = NULL;
> > +	struct odb_backend *backend = NULL;
> 
> nit: this looks like a misplaced variable rename that should be in
> an earlier patch.

Fixed.

> > @@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
> >   	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
> >   	struct strbuf buf = STRBUF_INIT;
> >   	struct oidset commits = OIDSET_INIT;
> > -	struct odb_backend *odb = NULL;
> > +	struct odb_backend *backend = NULL;
> 
> Here's another of those delayed renames.

Fixed.

> > -struct odb_backend *find_odb(struct repository *r, const char *obj_dir)
> > +struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir)
> 
> I was looking at this implementation and wondering why it wasn't
> renamed earlier, but upon closer inspection I agree that the
> rename is worthwhile _and_ the method shouldn't have been
> changed until now.
> 
> >   {
> > -	struct odb_backend *odb;
> > +	struct odb_backend *backend;
> >   	char *obj_dir_real = real_pathdup(obj_dir, 1);
> >   	struct strbuf odb_path_real = STRBUF_INIT;
> > -	prepare_alt_odb(r);
> > -	for (odb = r->objects->backends; odb; odb = odb->next) {
> > -		strbuf_realpath(&odb_path_real, odb->path, 1);
> > +	prepare_alt_odb(odb->repo);
> This does make me wonder if we should be able to prepare the
> alternates for a given odb without using an owning repo. Yes,
> we'd need to assign the repo parent when creating new odbs, but
> the info/alternates file is in the object dir.
> 
> Perhaps this is waiting for me in a later patch...

Things are still somewhat mixed at the end of this patch series, but we
do reduce the dependency over time. Eventually, the goal is that we only
need a repository to read its configuration, which may even happen once
and then never again for the object database so that we can stop
tracking the parent repository.

Patrick
