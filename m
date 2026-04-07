Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8637EFFE
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599434; cv=none; b=ndDq4Qanafbu8qXGe9WHCdWZDgQuoutXw2QjYbzHvyDmKA2VB6R1QUhyj9xeA5a60so5Rrx/D23P3YXIBE5beR07r7RTxCjikRi2n0/C7TofmX5iVWDPH6hi74lbNkoEq244NQpSGqnuXKDKDebdnNJ8+41HIA2+mOvv/y/bdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599434; c=relaxed/simple;
	bh=UhLf1w/osH0PRrP29tZwI+5ZRvl5H1PGhTPF8X+Bu0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtoA+vIO5j2ldHrNezzacjdizFQHbydOcTYOBAZdWjyCH4UN27iQwDSmUAbXDfF2FiLecmNqXNKdfLD+zSSJL9Igce2Ie2RaZbGYr7S0h1Nvu1hFXpCf2NmdmETmPOCzfXXyvLW6GGUznTM+4eB/LNe00G/MdP37DXMpdirB7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k5WXcwgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPPmTNoW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k5WXcwgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPPmTNoW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E47DEC048C;
	Tue,  7 Apr 2026 18:03:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 07 Apr 2026 18:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775599432; x=1775685832; bh=WF/bpxSrJ0
	QZ+jwlE5lPgSt95HZ/6qK9Zh86i+hQrlY=; b=k5WXcwgpKLKIVmw8eV3EufccoB
	ue3MoN55YFZpXSvAltY+3hUerAvN5QK4jAr+UG6suxm3m72SWSpOOFe0uTVltN3N
	hUfVRE6a/rYJ33oQhmoSQaS0QlRliperh82qzS2Chnq3AD36YHb5F0fVGaWpEZ9c
	bnHAmo1o/5zLlgGQIN1pemrpKr85xSY0PETWsdCOwJhvIBUuXydoIL5GzTdDhCB9
	95AWv8RWTX8dMvjMTJ5V6Ri38ED3t+5YIq4pYrEu/H4TUhJqDtMbne9Az/kb+m+1
	RmRWicSwg3kNogyDs98khW0toHk+OP61Sc0oXqxnHCU7Hs+YMmRMf+lpnWOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775599432; x=1775685832; bh=WF/bpxSrJ0QZ+jwlE5lPgSt95HZ/6qK9Zh8
	6i+hQrlY=; b=GPPmTNoWIPsy93Z2LE9kWerFovrAsRdriqqnvGKeS6FlzC3gGV+
	1qnkOYuN9mq3F4/7f0PI33a23q6pPOjxZOMvd+qDHivShRfs4tAMx+tSS2pXwzL9
	7CbDTY8WWNCmdYAz/GTVd2dQhCTCEdD+iePXI1dBmU9fu83zGk3zT7J8omSr3fpa
	rh/f8lj6xpXS6o6/vKwqpff1Gs40V3dqhypXxOqbumeeS2fzwqf0RxCtWvBUSR2R
	jrQnITwnNCaoeClgECbNgHGcZWQZzwe4xQgQxTuFEDrJCZa+MZwAfbpfbxSSRRqu
	H4e0vCOUcY0pXsv2fE+6ULptZk88z5Kpv8A==
X-ME-Sender: <xms:R3_VaeUFXGzZOGA_D-ApvmIPNKy3101GmL7z8p907q6P0ntntRZAvg>
    <xme:R3_VadIgSgjwSC5Sh-JXj50DwMBTDPQjQjcSiS9C0eVS1Zg6d1J2CSfSF-ei-00cz
    CegN1NcP9s9W13wKbY3Eo9FDA22uSZU_sUU3K4w1B5dQ1sylgpwwN8>
X-ME-Received: <xmr:R3_VaWB6wgUcwJIOYgahb-EKzRnwqZpc4fqt-UwmE1GUXazuMcVhc4Bkl9pGavtq-b78BCyN0Hk5-1GvT8dNldPpLYUgk-z1Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiffduveehheeulefhieeiueekkeelgfekveejjeegkefgudeihfegffekgefh
    geenucffohhmrghinhepshhtpghmthhimhdrthhvpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehlohhrvghniihordhpvghgohhrrghrihdvtddtvdesghhmrghilhdr
    tghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R3_VaVcQzUsqEOwWS-l5N_D7ehEs0cKgswrpMBkWxiyS6_D3WAHQig>
    <xmx:R3_Vad1OsoZ3OkRHYDPUrVPWePBREpa9FLnwKHy8WI4j6vd0jWTL0A>
    <xmx:R3_VaUjYI_gE__RdPFrAQ-B4JdYLw08kolfihPAKJUzsQpWPy_DGrw>
    <xmx:R3_VaenC-nar3VkwtPRYMjwwCQi8LfJDGeTPdVLs2S7MMg1DXl5z-Q>
    <xmx:SH_VacLOyb02-Qyt9tgj8KRU-0zOuGRzrf0MWt3u2IFJZ0_BZwF6AarT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 18:03:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <adV8iP668rgxK-9k@lorenzo-VM> (Lorenzo Pegorari's message of
	"Tue, 7 Apr 2026 23:52:08 +0200")
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
	<adP-MYYSmElK9wL3@lorenzo-VM> <xmqqy0iz7clt.fsf@gitster.g>
	<adV8iP668rgxK-9k@lorenzo-VM>
Date: Tue, 07 Apr 2026 15:03:50 -0700
Message-ID: <xmqqbjfu2zsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:

> On Mon, Apr 06, 2026 at 07:01:18PM -0700, Junio C Hamano wrote:
>> Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:
>> > On Tue, Apr 07, 2026 at 01:22:16AM +0800, Tian Yuchen wrote:
>> >> On 4/6/26 08:24, LorenzoPegorari wrote:
>> >> > +
>> >> > +			/* If <time> doesn't exist, retrieve it and add it to line */
>> >> > +			if (!parts[2]) {
>> >> > +				struct tm tm;
>> >> > +				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
>> >> 
>> >> Typo.
>> >
>> > Ack.
>> 
>> Not just an unintended use of comma operator, this is not portable
>> and breaks OSX build
>> 
>>   https://github.com/git/git/actions/runs/24058681172/job/70170218891#step:4:213
>
> Yeah, I was shocked that it compiled at all on my system with no issue
> whatsoever.
>
>> >> > +				strbuf_addch(&line, ' ');
>> >> > +				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
>> 
>> I suspect that storing seconds since epoch as a large integer would
>> be simpler and much less error prone than storing localtime in
>> textual form without even recording the timezone.
>
> Yeah, maybe for this kinda specific debugging info being less error
> prone is more important then "looking good". Will do that.
>
> Thanks,
> Lorenzo

Before moving on, please fetch what I pushed out and see if
SQUASH??? commit I made on top (you should be able to find it out of
'seen') is any useful for your update.

Thanks.
