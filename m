Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F893C482
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469778; cv=none; b=TVLfudKBDuQXs/KGb2aisNm38Qo04JsvBWV5W3Ba9TNt6kQe7fPoU8nCDkpdfbC0XmmCsDqXaE3N8xI53AfgUPbjaou9zYjhpNEFrh4UsVDChDYF6abqTY739HPkDeNuhAIFwth4GgMEwU1hLGOImC3tsSdt6lnXaBUMc6V/YlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469778; c=relaxed/simple;
	bh=UBbni5WCidL0LwmXE3pC6b1pG3rPSQcbdEl/CGJS+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxZ0dBteLP7ABijAiL1+YUyMjgCjAQ7F2VYL39pQqn4IpLfWYz22OQb3tRoOmexVDSVV/aSjUDCo7/hV+uGlkXZOgXOEymop2Z6giMoAswv/GIaYSDe3YB9YxKvfaXiT9VrElGlJJkz7F6aLmZCJE2Sueuyc0480EiG0QPXfjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XzzbqhkQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dul9nd8o; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XzzbqhkQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dul9nd8o"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 494271140207;
	Mon, 16 Sep 2024 02:56:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 02:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726469775; x=1726556175; bh=7OT83PSkKg
	cjH/o5o3HJ5qHGJ+zoZoTmCeE3l3bvgbY=; b=XzzbqhkQezD5GNqfvGf671Q1Wb
	vTMjORm+U3zt9UBJ5DRzUJ6/mA0YCdUxZHM+TPz+G4SwxiHekjGO0NSnbSBvxuXW
	2Um5BegjYKVbtiAqaw7Hz8H3Qdys81PCiJc6D/4YjI9HPFotsg0zN87s+3u70vgw
	YwJsZ6oQ6DTEG9YCxXrJ4+jrcqb7MpCwndYs0wew/PvjDigxVVkKLZ7W3GyrkNlM
	sy5xkg4sReEGctDVFa9ellm5zmBHQp/kZwDtTrAGvAkTk7x4zk9Tr0AuhiqOkhow
	XInyh/Uzt7PTevuLUTllxQf120K8zsdD+G0OX3ex2aD9PSB1NLhzyfEdhUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726469775; x=1726556175; bh=7OT83PSkKgcjH/o5o3HJ5qHGJ+zo
	ZoTmCeE3l3bvgbY=; b=Dul9nd8oIIJo4anfWr96xyqvMd7c3Nchd/XxjPTCE4mU
	ggfU+/HyMdEO8STmSU0ESB9M4HHrtjuOkD6s9XUEqZClFjVv8HYHpgRvLgzPDhgi
	6SsNGmBOgGG/GU/HCqw/NTJzqE/pJYKx9xjFfnCZ9Xs4RAH4lN2JBO11xj7sQLRJ
	e2spqwPxTbLwGQcupB5hzBX3biLs2qyShJxf2TGUT9smeJflzC4JUxV7Z+teUXEw
	U/kbuMIIJZHlGQgfGIJtRvOndV6TvtJGXMRrU7gMRCRmrsJzBF9oJmFFixH0you9
	hxBAPQ4YlaOXlNkHffbIxV3g8k+Lvye8qkvlG9ByKg==
X-ME-Sender: <xms:jtbnZoe2yoPhecUOYzCXLKUT8Srt7SCZnlzRN4b9e2qQbyWmEB2MCg>
    <xme:jtbnZqMdt9sRoHImYaSsppiZk0UvRR02fA8PJJIlttwCt2cHMXxPbE5yRVkOL6gLV
    43RideuxqZTMO2Ruw>
X-ME-Received: <xmr:jtbnZphoPLWa9v_CgFyOClPcLOYf2sW6tBKlQEuSremLPSF_g-KEfXKvpEpM0YKQ8LrWXEVWtm49TGZ9iNwk6O0TWbLcjdVYKaYYT8EW7RmGCtP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jtbnZt-EtPF0TM4biAdtfIr3b0q6ASieM_9_vDG77nS2hk_ipAJI6w>
    <xmx:jtbnZkuxFDXjoddUGEIUT5Qw8LuLu8xX_Ddk4dOicwszoX5Bt6S3RA>
    <xmx:jtbnZkF7Iy0L-hxT2k0aCIHWgtPHQXME92wJeC1B31HMc3v3sEx7TA>
    <xmx:jtbnZjNyYYla-qYGFmruqeXNFSC_mJm8B84paiw9BV-GeM8PMioGtw>
    <xmx:j9bnZgKoLfD6Lyt9u8uFk_FSdVUKGTA9f7h28XceAbVn8etm1k5o9HVl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 02:56:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d18aa03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 06:55:57 +0000 (UTC)
Date: Mon, 16 Sep 2024 08:56:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/6] reftable/reader: make table iterator reseekable
Message-ID: <ZufWjY053IKObF8T@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <a281f936a2b3a697b32f57652a2120afd54f7e4f.1725881266.git.ps@pks.im>
 <CAOLa=ZRA=vFjnWZC7PQBAxOxDfD9X6767ddgBqwaen5n6JLt0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRA=vFjnWZC7PQBAxOxDfD9X6767ddgBqwaen5n6JLt0w@mail.gmail.com>

On Fri, Sep 13, 2024 at 07:11:54AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
> > new file mode 100644
> > index 00000000000..7a46580b6f1
> > --- /dev/null
> > +++ b/t/unit-tests/t-reftable-reader.c
> > @@ -0,0 +1,96 @@
> > +#include "test-lib.h"
> > +#include "lib-reftable.h"
> > +#include "reftable/blocksource.h"
> > +#include "reftable/reader.h"
> > +
> > +static int t_reader_seek_once(void)
> > +{
> > +	struct reftable_ref_record records[] = {
> > +		{
> > +			.refname = (char *) "refs/heads/main",
> > +			.value_type = REFTABLE_REF_VAL1,
> > +			.value.val1 = { 42 },
> > +		},
> > +	};
> > +	struct reftable_block_source source = { 0 };
> > +	struct reftable_ref_record ref = { 0 };
> > +	struct reftable_iterator it = { 0 };
> > +	struct reftable_reader *reader;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	int ret;
> > +
> > +	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
> > +	block_source_from_strbuf(&source, &buf);
> > +
> > +	ret = reftable_reader_new(&reader, &source, "name");
> > +	check_int(ret, ==, 0);
> > +
> > +	reftable_reader_init_ref_iterator(reader, &it);
> > +	ret = reftable_iterator_seek_ref(&it, "");
> > +	check_int(ret, ==, 0);
> > +	ret = reftable_iterator_next_ref(&it, &ref);
> > +	check_int(ret, ==, 0);
> > +
> > +	ret = reftable_ref_record_equal(&ref, &records[0], 20);
> 
> s/20/GIT_SHA1_RAWSZ

Indeed.

> Also here and elsewhere, shouldn't we just do
> `check(reftable_ref_record_equal(...))` or even
> `!check(reftable_iterator_seek_ref(...))` ?

I guess you mean `check(!reftable_iteraror_seek_ref())`, right?

In the case where we just expect a zero error code I can certainly adapt
the code to use `check(...)`. But the other cases shouldn't use
`check(!...)` because it is important that the returnd error code is
positive.

Patrick
