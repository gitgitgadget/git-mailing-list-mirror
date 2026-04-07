Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855DEED8
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527284; cv=none; b=p+h6C7szVrQCl5l61HZC6zCwspAYab9+2KLtr+JP2qVw6se9hLZR00bMRSd1kzFxScyOqfCOhWUHQ9AyFzP8cS629VChrEGq8IjstbSbSPRZZl//f9Bu/R/JI3OcElp8JHZmzcg1VnNcbN+l3nRbLHW/295jR6pGMXA4794pYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527284; c=relaxed/simple;
	bh=H2EQ14raH5n2li7h70SQM2Z1uMK1dKbVradhDlw9o7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gnUHKvfHmmPjiJdD5jFqyLbqDNdEePq7bVHPfCPV5dUQmoE/uKL2SwGH3vH2E9OMXXiHQxW3PhDjaa5kzbwGSUliSDSKYbUdjwYP5VW7F/vTvDS6bhxGyfbfGOW7oJNOnZ59EtbCj7QIoiUtR7pk5VZBGRpNaE69ric9bgMIb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LsZugA0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vPKV/29+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LsZugA0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vPKV/29+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B46EC000B;
	Mon,  6 Apr 2026 22:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 06 Apr 2026 22:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775527280; x=1775613680; bh=2a4Tt+dKVw
	C0uJBXNQd0fCSNAA6QzHXpsSRPWy9TzPE=; b=LsZugA0iXxKJei5oyLS6ilHjll
	bm+qoCIsOuTuRhecD4blnLW0mvZ1/GgQjDFGbOsYny2d2obGCrHh2yaZLYprOZgv
	2tefbbzwMOHT/h2zNWFVBfQzFEWHLwvhF0B/23kDv+91f6blyR/rsBVCwczg6Vg8
	x4FZe/wuy2Uj2g7VAZRR4A3qmMjikO7S2cvM1Yb/kJiDd+GXqDAE/ChrBDE5OS6c
	HUzqryitftubqg82cmy9TDz2Wz2R4lHKhYWJE1adhHQBsbZYcchhXKDAILKfnNBA
	XwzLMP8MEyOKQfibwC89FfbkJ0SUT0QAKouGE+Aqn2zlOuq/LMjNHw3q/8yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775527280; x=1775613680; bh=2a4Tt+dKVwC0uJBXNQd0fCSNAA6QzHXpsSR
	PWy9TzPE=; b=vPKV/29+VupYt9OXp9WzKaGew2UrPkJHarBEEGhB16AD9M1wZhZ
	i9qFWjUNAnKTv2ywJVD9zN/UN3589QxirhAewdAamf21Wz/YQg1NhYmRx511UY/d
	3x6xudLFhSTV7RwQx2Pnqw6AKOqPk90F8nhxlCKYFqK3PKbsILK6BIuYOihHGWGv
	VjyJjuIvIjFIB7gMaUylag4zTzzGxrKVw8Ld6sujorC5MbG48Oa57pFJjQh2KD42
	Q9mxJu2PbNHas2muLc9hnb6BRbE+xNAMkTrS0f7OT9zYUnwiOXFw0VCaa1tSAdyF
	ZQYdQqpP4uza+NiEkRWbrLvdTGzEI9ADl6w==
X-ME-Sender: <xms:b2XUaYuCVA-MPrcGypgAVKSmreCIxTP3cBKfXJkNUFMR3YzNMaNN0A>
    <xme:b2XUaYBXHIkxMIdq4G111KNy_qFm90oS4IMy6xdohc4yp-L8IRJ2BnpEexvGwi3x8
    gaVWLC3fjEIrcqlMq4LHwJWbYdHAkpzwH_DuX9GuP1xC4sWE9t2Cg>
X-ME-Received: <xmr:b2XUaXYWzAgEDvtqaT9RHdRbU0u5ajXM1f5o4-bBMCwmB3mNBUIufCR3k5tutm2ELoS1lT9qevJ-0zU-WiFMak1IvyD3FYoa5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduleeflecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cGXUabVJaDHAy-d_mZb46BwuiF10FTc3I89iTcsvEnG1ihwBphT59g>
    <xmx:cGXUaeMv_CXjoaHqbY40xsjmfroRiPOmqBSt6MwKVSHNkd_LV-vrcQ>
    <xmx:cGXUadYLTNAHbbYTl_GjeXduy26EX5Z6V4Lcjmi5U7U0wEqGdSRjNg>
    <xmx:cGXUaV9KUklEULVd6T6dqkFFLM3e86svmobgXKroUicvdQQD__DZ_Q>
    <xmx:cGXUaYj2BngUdCfp01D-74KCeOm2vRDAaW985kYPSCDmsITcWJTsW1mX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 22:01:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <adP-MYYSmElK9wL3@lorenzo-VM> (Lorenzo Pegorari's message of
	"Mon, 6 Apr 2026 20:40:49 +0200")
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
	<adP-MYYSmElK9wL3@lorenzo-VM>
Date: Mon, 06 Apr 2026 19:01:18 -0700
Message-ID: <xmqqy0iz7clt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:

> On Tue, Apr 07, 2026 at 01:22:16AM +0800, Tian Yuchen wrote:
>> Hi,
>> 
>> On 4/6/26 08:24, LorenzoPegorari wrote:
>> 
>> > +		while (strbuf_getline(&line, source) != EOF) {
>> > +			struct strbuf **parts;
>> > +			struct object_id oid;
>> > +
>> > +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
>> > +			parts = strbuf_split_max(&line, ' ', 3);
>> > +
>> > +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
>> > +			strbuf_rtrim(parts[0]);
>> > +			get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
>> > +			if (!find_pack_entry_one(&oid, dest_pack))
>> > +				continue;
>> 
>> Memory leak here;
>
> Yep, `strbuf_list_free(parts)` is missing here. Ack.
>
>> > +
>> > +			/* If <time> doesn't exist, retrieve it and add it to line */
>> > +			if (!parts[2]) {
>> > +				struct tm tm;
>> > +				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
>> 
>> Typo.
>
> Ack.

Not just an unintended use of comma operator, this is not portable
and breaks OSX build

  https://github.com/git/git/actions/runs/24058681172/job/70170218891#step:4:213

>> > +				strbuf_addch(&line, ' ');
>> > +				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);

I suspect that storing seconds since epoch as a large integer would
be simpler and much less error prone than storing localtime in
textual form without even recording the timezone.

