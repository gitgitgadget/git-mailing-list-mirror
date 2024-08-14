Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF31B1430
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640222; cv=none; b=mlsXCik92hHFy30IgUFIVgVv68tS3KPz4yxOUlUGC3vBh53MO2uiiFcX9KVxZXpFcwwb8RdRFGRJ+I+QYSToGCf+LrZTYIEn5jMOJQpDgxbwZtcB2HFr8Gx5g9PE+7MffZxew7QXQilN07ijirPozw5/lTp93ctb9tepHhWISjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640222; c=relaxed/simple;
	bh=/4p/UeNnHlNP/ymzelyQhTli2zi5yQE0V927+fB/lqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV8AQzd6jzfcATmMvuItDu6uXxkmC1q+ZZl6mCDCapsJkHZmZXfGjcSqK4yo4fyAZkHsiryxU+KGf6qWEBIGJDXvDB6d0H4sksnxWWsUC5B1PKpbY4qCzpfvEXHizUcqN1CHe2iU8Pc5Ijk27O5EwGaBDDfsxT0PjeEAnJZUAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lwx0AcwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHtd6z7C; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lwx0AcwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHtd6z7C"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id DB0BB1388073;
	Wed, 14 Aug 2024 08:56:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 08:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723640219; x=1723726619; bh=a3rPpjjyNO
	bvSr0qhPqkxQuSae4wunZB4T+Ak2lG780=; b=Lwx0AcwU/F2BaxJaNhGtry4ZEc
	rOYrGKA/3TwY6vs9AUsg5pMfs9VfgOQ7QpKFTNqnVweUjyCs668uIXHQ/8bIJuIL
	veBaB7IuQBSiJIWAW2bmKb/oOFUuKmP6ViCoIT0Ic3RiU7VI0jGn94Eb35MEzVnl
	GmVMnofOgN/tUIMRINFm9osGpTA0PFGrSuFufE7aEsINEs+1D/8Or/22yJ+0igbo
	rFONCpthq17B54d5pLfPUWRkfmp3ybT2ZcH2VZskqKzmXrhih+ZBUML3mn0svmsL
	7uiZCNpX69Oh7TX3oGCw/eKqilQJq0S2qmJISDkXu8yC6ZpqF38LClmQZAMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723640219; x=1723726619; bh=a3rPpjjyNObvSr0qhPqkxQuSae4w
	unZB4T+Ak2lG780=; b=AHtd6z7CIA4Gh2oi5/0cy9kam9ruOHgSSyJB9bSjZ4mE
	3ZyNIzGL8VAZE4v0lfBI5koLKkRW3tOTEVSj4bJqmCBRChjlyLABDt+4SF419Lv8
	PD+PO7clIKhNqZMACPXLSRQsSXAEFdc3GQDgRMIEJt4C7ALht/evg3mhri7zq5EO
	8wnHXwXoZqGNo7oNuwHl/Z8wu0E6tCpxD97I0XunhBGZXpqfhOhnQAv5NewaZzLA
	YKiJeQXZaLXhGR/BJRSfJ0m6sVMtSQasI3a1p8l1W9SkhbFjaQHheM4ifaSRzz+1
	KbxR4vYqouT0RCMzFryMWywkoreftmEr1lchO0AAlw==
X-ME-Sender: <xms:m6m8ZjHESK-zKTPnUUR8vvw1056vz9c9vi1S8O5vuynD4WFA-Qbv-w>
    <xme:m6m8ZgWrYaWx0gZFCFZqMlRWeHgznqdrUu1LYs_blW0vUML_Ssa3Q6rqVAEe8rlPi
    -STT3hm_jbvnGaKOA>
X-ME-Received: <xmr:m6m8ZlKnOCDiR4eQhrgIAw9vbi26Krs1cxouXt5cLMBbJXFJB8g9eBWUHUQqhlQNY2DtDKdPfjNBmq-j1dtbYLSlpdcv-cyQyl6lb-ErGpeztw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m6m8ZhFW7j62v6IjE6N1Pjl_C1mHPfSGmV40WZvWN24gMzDOLhw8MQ>
    <xmx:m6m8ZpWvvT7-g41wUkrJZ-xbyDV50z0oFNRK1Lkvoci6Js0Ifj-GEA>
    <xmx:m6m8ZsM8xrYLdz68xBe_HdcJ1F2HRK1gfr_AGMDkiMX2bJjBDvrBgQ>
    <xmx:m6m8Zo2iYH3KQ235zFIBx4Q06Y2NoL2v43Bwtd4CGgd6T3kBQ0t1jQ>
    <xmx:m6m8Zmg61Y6G7a-x1R_qUb0UdmOBXoUuABI5kVp8UIlVPNIQLInArvFj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 08:56:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d359575 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 12:56:40 +0000 (UTC)
Date: Wed, 14 Aug 2024 14:56:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] reftable/dump: drop unused printing functionality
Message-ID: <ZrypmQOthfGS1JFn@tanuki>
References: <cover.1723528765.git.ps@pks.im>
 <1f211e514d049379ada609e6a4e8cf985e721271.1723528765.git.ps@pks.im>
 <CAOLa=ZScKRvAWsa4D+_BCyAbxQ9580RBnJ+==DfCvrGV6C2ETg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZScKRvAWsa4D+_BCyAbxQ9580RBnJ+==DfCvrGV6C2ETg@mail.gmail.com>

On Tue, Aug 13, 2024 at 06:14:33AM -0400, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We have a bunch of infrastructure wired up that allows us to print
> > reftable records, tables and stacks. While this functionality is wired
> > up via various "test-tool reftable" options, it is never used. It also
> > feels kind of dubious whether any other eventual user of the reftable
> > library should use it as it very much feels like a debugging aid rather
> > than something sensible. The format itself is somewhat inscrutable and
> > the infrastructure is non-extensible.
> >
> > Drop this code. The only remaining function in this context is
> > `reftable_reader_print_blocks()`, which we do use in our tests.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/dump.c             |  16 +----
> >  reftable/generic.c          |  47 -------------
> >  reftable/reader.c           |  21 ------
> >  reftable/record.c           | 127 ------------------------------------
> >  reftable/record.h           |   4 --
> >  reftable/reftable-generic.h |   3 -
> >  reftable/reftable-reader.h  |   2 -
> >  reftable/reftable-record.h  |   8 ---
> >  reftable/reftable-stack.h   |   3 -
> >  reftable/stack.c            |  20 ------
> >  reftable/stack_test.c       |   7 --
> >  11 files changed, 1 insertion(+), 257 deletions(-)
> >
> > diff --git a/reftable/dump.c b/reftable/dump.c
> > index 2953e0a83a..35a1731da9 100644
> > --- a/reftable/dump.c
> > +++ b/reftable/dump.c
> > @@ -41,9 +41,6 @@ int reftable_dump_main(int argc, char *const *argv)
> >  {
> >  	int err = 0;
> >  	int opt_dump_blocks = 0;
> > -	int opt_dump_table = 0;
> > -	int opt_dump_stack = 0;
> > -	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
> >  	const char *arg = NULL, *argv0 = argv[0];
> >
> >  	for (; argc > 1; argv++, argc--)
> > @@ -51,12 +48,6 @@ int reftable_dump_main(int argc, char *const *argv)
> >  			break;
> >  		else if (!strcmp("-b", argv[1]))
> >  			opt_dump_blocks = 1;
> > -		else if (!strcmp("-t", argv[1]))
> > -			opt_dump_table = 1;
> > -		else if (!strcmp("-6", argv[1]))
> > -			opt_hash_id = GIT_SHA256_FORMAT_ID;
> > -		else if (!strcmp("-s", argv[1]))
> > -			opt_dump_stack = 1;
> >  		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
> >  			print_help();
> >  			return 2;
> > @@ -70,13 +61,8 @@ int reftable_dump_main(int argc, char *const *argv)
> 
> I'm a bit skeptical about this change because I definitely have used the
> `-t` and `-s` options a bunch of times to understand what a table holds.
> Since the reftable format is binary, this is the only tooling we have
> which allows us to read this format from a plumbing point of view. I'd
> keep them. I guess the stack printing just iterates over the tables and
> prints them and could be removed, but I'd keep the option to dump a
> table.

Well, I have to say that I find the output to be rather useless. But
you're making a valid point: we don't have anything else to peek at the
table's contents.

I'll keep this in v2, but make it an internal implementation detail of
the test-tool. It certainly has no place in the reftable library in my
opinion.

> Also this patch misses cleaning up `print_help` if we go down this
> route.

Indeed, will fix.

Patrick
