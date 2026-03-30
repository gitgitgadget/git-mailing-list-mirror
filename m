Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBC397E6D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900764; cv=none; b=gteAwRNPpEoofJOd4a1n338hn1eGAuSbBwIc7eA+ByKmqpp6YZTtAJ7KmACm+z5AVb7kpvQji0DEyboiYmWUonO93v77hPdWM/v8NxcIRPAqVyP7N9Nah2jRjS2LuSsuNI7u6IGhoT0F+CHq0sB1iKFbrO4WZTW9PVJNGUPqPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900764; c=relaxed/simple;
	bh=oA5ny6Ev00Uxer3IMwu4AFlEuDB7vdjqacyLNiMfzpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxhLMK+7cqCe/Bn46B6gH4Wb+BUrPZuqJ0rdwjwHUtGgvm3uH0KGerO9BV5rKuAVZurOYKAVOKQxvBwboolFzhmQX0vc2WG4cCtNgJeY/neonqhxugBRxYBex2/XpG7PpIuZRIkrUQPkF+f/TcwB80MDStHaBl+xy8uZ4s5bvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XFMIuNB9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myoh+WcL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XFMIuNB9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myoh+WcL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D41E7EC01A9;
	Mon, 30 Mar 2026 15:59:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 15:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774900761;
	 x=1774987161; bh=61ypu21p3fpmExFUXCmZXoCcZx4KEngIQBZU9DL5KgY=; b=
	XFMIuNB9roGrK5BJRTvYB4XnscxFTyzrFbkeLN1TOVRFmVGRqZHjS6w7K+4j9K9I
	ylqviUr3wGLw2lEOuibwodAqLScTVKYtG6LBpXSX0b/OtS3r70eBcECuzKiqcH60
	ijakCZZae5AjAWSPPW5tX9P1GfjxGP6PI/T+2Af4ZG12wbrBfQIna6agvVISWWLe
	H2kBEGPSIT8KTemp+25rYGDKSYWnM3mSrHakniMyY4MBR7Vur9zMB+af3jB8L/LU
	367JAlIjrMZ+/isNEas/js1HDLkYlsuV/GjHqZCM1DUwZusZMyuQYfxIAWqkCJEi
	6orUnZBF/UdZqTvgS7jwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774900761; x=
	1774987161; bh=61ypu21p3fpmExFUXCmZXoCcZx4KEngIQBZU9DL5KgY=; b=m
	yoh+WcLw1AUC9KXbJGzDBRG0Ef5Ds3tKTQHEpxEJcDebNVlS3D8GuiEH0IgHIKm2
	Bl/qM5gxIKRc0O68xZr0Vhg4EKvDADe09C8S+eapSFLPl4uForFo5lbmpiHLwVJQ
	k2L76t2T9m9bkLFUvTeoG8/RYE/57gpXbKiUYVEyb/oTWVzT7K7dp0Lct0r2viRm
	gPgFoahjZRIkTwqvOS+gYxK8t38vt1/BdJoToo4qQUyDwoSVd8m4+wHOUAkkuCy8
	LILcZsxsTiqWw+1MPnf6eW4SZeC8emkWwy3MA0WhNPapAU01xZIczhrDG9V6Qd80
	R5lRZ7LPmxXn6CrJUZ2LA==
X-ME-Sender: <xms:GdbKacSbZgYBH5RM5g-F1JCUnSKTP6uuKIViaILUl0kSDH41uyOpBQ>
    <xme:GdbKacVKBq15VSgGyEJqt0IJAL2Lt3p_7tE6KtOvBq6gURuxkyg4QfrJ1BFWjRpvi
    U5p9VZvWog4v-GYZUPW1EipOplRugP04tKYjYhSrJ7Jt0K-sgA>
X-ME-Received: <xmr:GdbKadeolJ1K_wSkynFOnUF5qdkPCKG-XR-uQNw_TWcYcTVdRbJO9QU8bly6HxiP7g06Q43NhTmxVbMQH_nXhYZ2Nl2jWJGGHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihtg
    hhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:GdbKaQLDvc0jPTwmKz4E3ebJnLzu04Bo6jeBWFOcSCfngZMnY4v3cg>
    <xmx:GdbKaawDWBro0NY3WE7H8pdjqz3mEJvUG_aR_ZCi_d7OIOuHoQCaew>
    <xmx:GdbKaWvO9-YBZiCsEixsSLsadhA2RMTq2CQEuHVeG_Unmo79B0pPXQ>
    <xmx:GdbKadABotg1bj1eStZs3DPU5AzPVN-xn894wa5NMjUL4OdGxUEPMw>
    <xmx:GdbKaT4V2V6zXmNScM66kS1evfw1TM1b9FmLWbcy6sNO3me4KlGPSJEa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 15:59:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
In-Reply-To: <CAH=ZcbAKwtq9jiv=XWi_P0ZD1hz7XEpEtMPONB9n=_EcOPPSRg@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 30 Mar 2026 10:00:18 -0600")
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
	<xmqqy0jdhtd0.fsf@gitster.g> <xmqqcy0oj2s1.fsf@gitster.g>
	<CAH=ZcbAKwtq9jiv=XWi_P0ZD1hz7XEpEtMPONB9n=_EcOPPSRg@mail.gmail.com>
Date: Mon, 30 Mar 2026 12:59:20 -0700
Message-ID: <xmqqtstxdr6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Fri, Mar 27, 2026 at 5:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Updated code, when nm is not zero, does something different.  if
>> need_min is true, mlim1 is set to -1 and presumably nm is a count or
>> length that is bounded on its lower end with 0, so it is larger than
>> mlim1 (== -1), and we always take INVESTIGATE and never KEEP.
>>
>> So the rewritten code is broken when need_min is true?
>>
>> I suspect the remainder of the patch is broken exactly the same way,
>> so the remedy would be similar?
>
> Your assessment is correct, PTRDIFF_MAX should be used instead of
> SIZE_MAX. I realized my mistake a few hours after I pushed. This will
> be fixed in the next version.

Yeah, using PTRDIFF_MAX is fine.  When I reported the breakage I was
hinting that everything may want to become unsigned, but since the
original does use signed quantities and variables, it is far safer
to stick to signed arithmetic---until a full audit says it is safe
to switch to size_t of course.

Thanks.
