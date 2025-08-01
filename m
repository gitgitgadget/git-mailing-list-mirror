Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2B1D63E6
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067598; cv=none; b=tlY2wLK/T5lVEemOLar0FHCrpmRXWdqHweKiI2klHaz9KWSDfVFqZatZIwVS5WFTI17I5csb1Pd7NSUoFfHudhlQDmbpBJv6X7S3Qpe2Rpiz+GEq9lfXlZmPkQEusbebhA42HG3sDHRwmuUzRbzZ6WzU1Wb093PrNxtQ8rVjros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067598; c=relaxed/simple;
	bh=wkmyzuuIBG+pA4U/8trQF6+yyiFLh94fYRMKInKYZcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cthaV/pmDXFsi91Sn78vJwj4qhs3X61hMOZQGtJgwLA2Q4MlyPCwXiATkPqiF6A07qZD83V9TVxQz9YJ37A85zj6UxS6O7gbYHD3ou7W0dwy5URPv5MehHzOQ2fTD3DhZgcnjlWctzkuJ40/G2XPKdHXU9pxEeQo2s2+mip09ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JHMnVCbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Crjo3VCq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHMnVCbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Crjo3VCq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EA48A1D00B75;
	Fri,  1 Aug 2025 12:59:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 01 Aug 2025 12:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754067595;
	 x=1754153995; bh=K9Dcc7cwAq3Wu5DJA8u+BW7rY+80TKAOzSl9lOPnvXw=; b=
	JHMnVCbPQHVd+pmKIyxUXBF27Swv2B2Jjbcab1bL8L/MypViqp4FzPMgi+6zzEx2
	GynGWmUx50vUKYsnLdrKPe51ara9tBi42s63Cyc5oMrp2nc561r6sC8kEpIC4+gO
	7VxBZl+LU1KG0G2WIhvortDFksdgaPAuta4qY4OZf8FCw/Nexw6oNO9L76X6Z99I
	C3kAaiMYu24xQzv+x5zHGHwPOEWFxEl2TsRcFWDOWOzuVBksxPSQ5LYounVacL7h
	LHMc0kqE3LCf+HthLLlTOk+dHGGPUt+hMmgHRstq8kSYYxLMxWUStbKRmCZEfn8k
	sn/uoYIrZBQ0wYMBdeazRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754067595; x=
	1754153995; bh=K9Dcc7cwAq3Wu5DJA8u+BW7rY+80TKAOzSl9lOPnvXw=; b=C
	rjo3VCq/lfIruZUpbK0+u8hgSZEOk49JUqA+4HkW0UaJu4PAnGvCqLpBwQNGm8TT
	So6wUzhWl7HUQr/c6Z61pE9IRd2G58a0OB6uj2Rp1WBupFkfZy9EhKhZjDjQw1/N
	MVTGKr7wQeFzHUx6yU1rWoAoQbTh80XAXv8wfBVWaibvH6ol70AFQLp7U31nndCp
	/BfNr4hbGPplT3Kzu5sSjTl+UXuWT5V/momf8cdG9o6Zg8f2mij42WIsMhAL8Cpp
	tgcoiTLHYmozspJw/bkARXm2iFzVynV3OCXCaC+KVvc4rRdxoSkYgQ37BvIJp7D4
	typhs0xdO0WA/mkIgLeUA==
X-ME-Sender: <xms:i_KMaMxW8Mtl_GsOpT9C4IQ0uYRjDMoV1jl4Ahq1B_X0NDyyC8okoQ>
    <xme:i_KMaNIRfjYufc8wXZj7YkeYuJTshMwiQPm6s6mWv85eL80u854nz0hFwiSCxwYmi
    IG2u4bKuAqsgc9EUA>
X-ME-Received: <xmr:i_KMaOH31A64qByjbhrPiRhMhmJNnkT1sCmJaQojMUL_-SsUfvDWFSbVtleHVuRy364lAcScRR9bqmMF7buzruxWQXhX6A4EnBHlX_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprghvrghr
    rggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:i_KMaJ_gTcqmU3a91r61adTs9relNpc8_PgAXL546mN3pXfmXvgxnQ>
    <xmx:i_KMaOIzLSHCvSaESE0XzjJ6iKNjCcUppbkRS1qsDZXe2w0DziZq3A>
    <xmx:i_KMaHsfO1asW60gHasa4sa8QJk22wL2ErW3_Q4RcwfX_IRRmX-odg>
    <xmx:i_KMaFDQpPx5bu6MuHPNLcQEqYV0JJ5nC7traxMlCZkQbqkLN5Y8xQ>
    <xmx:i_KMaOCMWuw6jkxyaJjM-VnIhCEPx6Iro9c1OTdFPTFqApPpNFJLD-2N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 12:59:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Toon Claes <toon@iotcl.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v5 1/6] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <CAP8UFD18Ds4zME_ZHRdTA0W7KXk57zo9664xaU2TbH7YsHbFUg@mail.gmail.com>
	(Christian Couder's message of "Fri, 1 Aug 2025 11:09:24 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250716133518.1788126-1-toon@iotcl.com>
	<aHmPHcNQYlhGo8JB@nand.local>
	<CAP8UFD18Ds4zME_ZHRdTA0W7KXk57zo9664xaU2TbH7YsHbFUg@mail.gmail.com>
Date: Fri, 01 Aug 2025 09:59:54 -0700
Message-ID: <xmqqh5yrm0z9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jul 18, 2025 at 2:02 AM Taylor Blau <me@ttaylorr.com> wrote:
>
>> > +struct last_modified {
>> > +     struct hashmap paths;
>> > +     struct rev_info rev;
>> > +     int recursive, tree_in_recursive;
>>
>> Can we either make these two part of a bitfield, or at least declare
>> them separately?
>
> I wonder if we could/should use the `bool` type from <stdbool.h> as
> Documentation/CodingGuidelines says that it's now allowed.

Even though "allowed" is different from "encouraged", I would say
it is a good idea to declare them separately, i.e.

	bool recursive;
	bool show_trees_in_recursive;

I am guessing 'tree-in-recursive' is one similar to 'git ls-tree -t'
feature but the name given in the patch requires such guessing, as
the name is a bit inadequate (it does not say what you want to do to
trees when recursive).

Renaming to show_trees_in_recursive eliminates the need for such
guessing.  The implementation of ls-tree calls the corresponding but
as LS_SHOW_TREES which is a bit inadequate.
