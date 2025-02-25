Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FE25A65F
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470180; cv=none; b=A4xbezVCPA8NnB9znX3KM1svhSWyLJ8OCnZZSU0AD4gRyl3tTo27rxkVmRkE4ZJGPicNEtGAiW6oMgzr0CSWzX8CzyidbhE7lRJSuXyL5ZcvNea491LtldBkW9j5hd0Sz+QKBX327lk8tkTkzuuFiBQMFWq7Hl+BlWR5ZokfQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470180; c=relaxed/simple;
	bh=hwNEY/i0wCVJtlb1pdLfw7L9v8SJ7Po70bhQ2yfJuUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/wZRyNviAuFEDeHbqSQP0v251osWsE38roVDOyeAh6UuPQZ9gmdNK/cyVA3n42Tql2jzmzEY+jYhShgKur1Q+1s4WmoP9NXRoRSh0BicfaQPQOn9RuuB1d5VPBaq0QVNHAb3aXlsVJ6rWSVDKr9U11Rsb6V1vrZVudVIUMYguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fydy8k1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5/4H3fP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fydy8k1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5/4H3fP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E5FE11140092;
	Tue, 25 Feb 2025 02:56:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 02:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740470176; x=1740556576; bh=uxS8yIUIv5
	DYli75KK7VgGsGQVkLQc3tgxUFEZV3hgU=; b=fydy8k1uVsCgYA5cNwpcH7W8jQ
	t2qZcKS/IafqZCi99fM2/5DyQ0ZugG3j6rkhBcmAMN27cs68fYZq5gJxkK9agY0p
	0kQHfDB3vBjhd5Oy8+IDtI20eImH9vUDdTlqHtcO9OsOxIUH5PviFFuIJjoHQXpG
	BWVdosyx4jgvv5Gzha6ucAzA/yrECK6vEw6Q/Lbx3x5A5EM/5D5q4uKTzCEM8LWj
	sTgY3Pxmndb8VkuP1CWl6DTm0lfMlspRtscIQ/4Zj/U4Y9XWMg0DwNu7HYYhCX2w
	alx8g0gVbXEl2q8ojDIxywJb09b4uYZoIlnvSI/HlTp4JS5Z9JYWOtS0GBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740470176; x=1740556576; bh=uxS8yIUIv5DYli75KK7VgGsGQVkLQc3tgxU
	FEZV3hgU=; b=Z5/4H3fPb89dTaY35keap72BSNb6/7fHtciyZynWbNV6co0qoud
	vmCbmY3AWlPS6CEGBsfwtY1YeWYuQ8eRcBxZZ0KiN/5ym3Mk9mdV9lrenrcVDhDJ
	Jcw+VJ+hxNEAQMRafSevzPTLcgum7sd01hYvAaAOOK2dfPXTuYvl781M3k9+i5MR
	sYZ8OOLZe8BiboNB3dv6w3EGw2waL36cFVa6SHgfq7UrxAyvYuXTQqlmgpo2FnBZ
	qghzrZpnqs8lWrNOYs71tAQyyuBMLamNufvvgYBvh9gHW9DoWg5DTNJpBc+ZQ4qt
	4TNQtn/K8leI1o26qdq8ZUftWSUHo0xZT1Q==
X-ME-Sender: <xms:oHe9ZzJERcf_pCzPScs9CLDm1MwihztiBjJCar3f9G9mXeJEHDQFzA>
    <xme:oHe9Z3IR0ZV2TsZgBsLdxXCgreFdOLMzYgunDyK9eK_1pMAhFntp4BT4M5o4FIOj3
    if0ibJex9jxQIEzUQ>
X-ME-Received: <xmr:oHe9Z7sxKYjcX7qh1W-YN1GMTAClVuvXvBK9HxggBRNADvnsPeTLKf_ZVVVhGp0NC4vPU85Y83w41H75AL_E-dcdLzTqrwoOjHN2fmze5XPbFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhho
    rhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oHe9Z8aaf0Ms9RzyAxDrXmcfJqFPiYKPdX-dPpfbWP_wCybT6daV_A>
    <xmx:oHe9Z6aOLgEzZLx0j_e0QslrMbJ1z_Ko3N5nKqmNk9ptjs3wjwLN4g>
    <xmx:oHe9ZwB96koosdGwtsSXpdMJDiVqqzZWXdbiWe7VfGXcxG99pGcPTw>
    <xmx:oHe9Z4bKwkAvmfqL9Nt6qp1QmtqNy04TWQmv8j8AJwmI0SItLUhNDw>
    <xmx:oHe9ZxXkNCkrMR3m3RAT80H2D1chVHM7oEWqytn4q2gXjf8sjgt9j5yB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:56:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 020733de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:56:13 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:56:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: implement clar specific oid helper
 functions
Message-ID: <Z713nJNLbEzAU4JM@pks.im>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250224152704.70289-1-kuforiji98@gmail.com>
 <20250224152704.70289-2-kuforiji98@gmail.com>
 <xmqqwmdf5is1.fsf@gitster.g>
 <CAGedMteOTewr9=m6=5NztLA_cDiuq=uEt-A26rFWRCmEw0=_UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMteOTewr9=m6=5NztLA_cDiuq=uEt-A26rFWRCmEw0=_UA@mail.gmail.com>

On Tue, Feb 25, 2025 at 08:14:35AM +0100, Seyi Chamber wrote:
> On Mon, 24 Feb 2025 at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Seyi Kuforiji <kuforiji98@gmail.com> writes:
> >
> > > -static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
> > > +static void cl_parse_oid(const char *hex, struct object_id *oid,
> > >                                      const struct git_hash_algo *algop)
> > >  {
> > >       int ret;
> > >       size_t sz = strlen(hex);
> > >       struct strbuf buf = STRBUF_INIT;
> > >
> > > -     if (!check(sz <= algop->hexsz)) {
> > > -             test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
> > > -                      hex, (unsigned long)algop->hexsz);
> > > -             return -1;
> > > -     }
> > > +     cl_assert(sz <= algop->hexsz);
> > >
> > >       strbuf_add(&buf, hex, sz);
> > >       strbuf_addchars(&buf, '0', algop->hexsz - sz);
> > >
> > > -     ret = get_oid_hex_algop(buf.buf, oid, algop);
> > > -     if (!check_int(ret, ==, 0))
> > > -             test_msg("BUG: invalid hex input (%s) provided", hex);
> > > +     cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);
> > >
> > >       strbuf_release(&buf);
> > > -     return ret;
> > >  }
> >
> > As you are not returning "ret" and making the function void, you
> > made "int ret" an unused variable that needs removing.
> >
> > Thanks.
> 
> Hi Junio,
> 
> Do I send in a new patch series addressing this?

The expectation would be that you reroll the series and send out a new
version thereof that gets rid of the return value in the same commit
where you stop returning it.

This would typically be the case as long as your series has not yet been
merged to `next`. Once it has been merged to `next`, you would have to
send an entirely new patch series as a follow-up.

Patrick
