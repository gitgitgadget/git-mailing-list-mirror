Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8F2110
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770598554; cv=none; b=tHNh/38kBNbVoRsypM85RQhizNoFI8WtxW/NMoaYDsnIea63vCIrO7DzmCdaV5OJb5ae+cv6iw1KK67Q+KQ6VaHG2FxycHwcJrteFskMdcqhp54uArRJs59RUPz8o28orQ9XIB43vGpldiljcKnQA5j7mxGVKuttna+IVfH1Ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770598554; c=relaxed/simple;
	bh=0TwuBfg+dIAVRwgwy9R9KUv3N52wX3oonGM2cAjaLGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J2Rp7slqs3kCrl/S5yq100zd9NeQ9yDD7csGydlYmiSHwcz0yjAKCv7Rkzy91oAc0lyTGZ8sFud2s72voUQT6nbOLOB2LA6NO4CaSZE5SXSrPff0gamJDkAGeZwzhzS5WZ4WCIWDRRwlRoZDTtM2PbdMDJl5ICxc7r5dHjJvz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JrnsQ9UV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sFfiVjCD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JrnsQ9UV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sFfiVjCD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B29241D00089;
	Sun,  8 Feb 2026 19:55:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 08 Feb 2026 19:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770598553; x=1770684953; bh=y7MlywbUJE
	HgPQwi0wDuRmL74D2kVbqmXpyFwhWPqJs=; b=JrnsQ9UV/SFcSZNnf/s8DiXQ60
	AiYG5ulZF7QsPmmHnfvxtIcs6axfw419+Xp2/8ERKES9g1lFcfWPfbgpLvhpnLVM
	/ZDt4huWIUf7XX8UNkkMvFqtR//A19VQLD6NegRQcfRFGBFA4jqSx20eWe8fHEOR
	Me6NEMVzG2sIZUt9twNrVmyObmml9bs1Wcl0w3l/VnSD+YurVXFaZ5raX9GKSHQ4
	UfxIJckVWj3X48w9Vd71iNzNYB+rJwwjHzX/E540crkjXXN5f9FANsnpDId2TV/z
	1c6icQyBCCOAzp9xtwoZseZ1aTpa0bzM+EbJvu8Tlmx0SVQPdD9LQf6AgSRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770598553; x=1770684953; bh=y7MlywbUJEHgPQwi0wDuRmL74D2kVbqmXpy
	FwhWPqJs=; b=sFfiVjCDV8VBxgauIjFRHRKCYKfpMtqI+0Xuj2QQnYo8S/V2pBj
	CJ3VMlkZ6w9U86qmOjwiv9znjLcyCi80WtTX1GFINtzbfBvGYSukMMeZzOvyyN8j
	cXYvWpMzPUtz9WB8Rx1+TV3jBpyQbAog2IJCk6vhXFzFDSo+JfdaB0Xo9S+P+WRn
	Y0yd9rX4dMcXjx5TRQltDjhQOXvHxqsAzP8xvsJOBsHL1ViDbdsGIVBh9prb1j33
	sbjupBrVxtWq0r/i5hPD+n6sHs6AAUnu7kp6BRzJS8eFf8C07+QP6LuVZ6EaT3+K
	YWkQa+rZNUjz3hWmBtKrxJlkrwx1SG7xwXA==
X-ME-Sender: <xms:mTCJae8KDrWcfbnhEHWlFasFkdcZgHUyw2i73osCNIIlr944PjR6sA>
    <xme:mTCJaWJZ87x_MQtFLSP1PL9_QXj8sdAsD9ucjuDHqr94Rg2gAkGVw8Fky4k53CRiR
    GdmKafhyc-BY8wv5B3A1jbb5BQccxxf-JE0FPxzhhHNJchjYUqc-g>
X-ME-Received: <xmr:mTCJaRYjwayQFxO9K61TqWBfrA1mI89CrChN43r5DJHWkcB8aQZP4SUv3KzjqwrpouiBFGiXSB8ePGtl8aiVWjl1Me8xQUEF-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:mTCJaQI41GiYdTnYhIwrQXnZGK2KhlNWYKNpLbaSXZS-T4TeLGzuEQ>
    <xmx:mTCJaXAg5xQknsBETpjFoNBYC46g_BXXLV-CcCghyZUhl58a_PQCJw>
    <xmx:mTCJadrwXp_FL3wZWkEhjSggqqyV8Tf35GoijXsSkK1-0jb3F_k5mQ>
    <xmx:mTCJaahym6r9FUdvRMP0jUtobiq_J7UeULIwgwBfvUZiQEIBqleyEQ>
    <xmx:mTCJaQ2_Xouei5Mk5p3O7CA5FJKZXFNtvnE7UrLQp3hmNXumv3TexRjd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 19:55:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
In-Reply-To: <aYkX3rIkpIvLsej0@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 8 Feb 2026 23:10:22 +0000")
References: <xmqq7bsob0wo.fsf@gitster.g>
	<aYkX3rIkpIvLsej0@fruit.crustytoothpaste.net>
Date: Sun, 08 Feb 2026 16:55:51 -0800
Message-ID: <xmqqv7g67n1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-02-07 at 23:15:51, Junio C Hamano wrote:
>> * bc/sha1-256-interop-02 (2025-11-17) 15 commits
>>  - object-file-convert: always make sure object ID algo is valid
>>  - rust: add a small wrapper around the hashfile code
>>  - rust: add a new binary object map format
>>  - rust: add functionality to hash an object
>>  - rust: add a build.rs script for tests
>>  - hash: expose hash context functions to Rust
>>  - write-or-die: add an fsync component for the object map
>>  - csum-file: define hashwrite's count as a uint32_t
>>  - rust: add additional helpers for ObjectID
>>  - hash: add a function to look up hash algo structs
>>  - rust: add a hash algorithm abstraction
>>  - rust: add a ObjectID struct
>>  - hash: use uint32_t for object_id algorithm
>>  - conversion: don't crash when no destination algo
>>  - repository: require Rust support for interoperability
>> 
>>  The code to maintain mapping between object names in multiple hash
>>  functions is being added, written in Rust.
>> 
>>  Any progress on CI breakages???
>>  source: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
>
> I just sent v3 yesterday which fixes the CI breakages.

Yup, I replaced the topic with the latest one, and the draft for the
next issue of "What's cooking" has this entry updated already.

Thanks.


* bc/sha1-256-interop-02 (2026-02-07) 16 commits
 - object-file-convert: always make sure object ID algo is valid
 - rust: add a small wrapper around the hashfile code
 - rust: add a new binary object map format
 - rust: add functionality to hash an object
 - rust: add a build.rs script for tests
 - rust: fix linking binaries with cargo
 - hash: expose hash context functions to Rust
 - write-or-die: add an fsync component for the object map
 - csum-file: define hashwrite's count as a uint32_t
 - rust: add additional helpers for ObjectID
 - hash: add a function to look up hash algo structs
 - rust: add a hash algorithm abstraction
 - rust: add a ObjectID struct
 - hash: use uint32_t for object_id algorithm
 - conversion: don't crash when no destination algo
 - repository: require Rust support for interoperability

 The code to maintain mapping between object names in multiple hash
 functions is being added, written in Rust.

 Comments?  v1 saw a lot of discussions, v2 didn't, and this is v3,
 which is essentially identical to v2 with CI fixes (which work!).
 source: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
