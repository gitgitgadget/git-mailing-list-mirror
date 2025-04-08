Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7031B6CE5
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123806; cv=none; b=mBo0YH0K6veR9SxtUSSRMfTtNvLXvDbRqo8v+6ugUO/FzO+JaJBk/U8qdYPs0Ohi69q6B1RQt9shajAJ6gFfG11dH+pASmdfcOJAKX3hjauGQkGUdKLUSqxUo41XCrbweikAK2iqi4od4pYIAE3BwETjs8XBrQFJ5u/7ZiYkBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123806; c=relaxed/simple;
	bh=0RASz1pkQxm4AIccyzlbVsVsudTvjjuz589T6wM0bLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AhZWl6d2SOqpkip3U+7j9hnUHL8VthMbmdl/WJ4fT4hjtbTfhXzgt9OG0nU7Rpy/8YVgduCMRnOxc2WX2tsmBWlSCdTq5cWEKN81mXzdDb0plVSVgYvRFxvGd8FCB+wd8Rz4jB1qosnceuHMcGuMz1JvdN7Be6p3/J0dVNROYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W8q1Brk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ek53KTT5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W8q1Brk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ek53KTT5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C474013801CF;
	Tue,  8 Apr 2025 10:50:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 08 Apr 2025 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744123802; x=1744210202; bh=Wqz9tyZmaZ
	xwAPrjxl7vXKReFLTglz9XfKFZn0CG068=; b=W8q1Brk6utV2RtyeAsGSZrZ7lb
	PWbCeEU4FLcqNUNvhl012y6xxnbU0ifnc43YKGGCd5Nk4Gf1gfe0F5p3bI9nTzsI
	E/d8D5E6YPhyXZrxG07UIUZspTyLi9uMMzjAr7zI8dIabyvHmfPgBD0wNqNpfPno
	ZtYxXSjE8KbqGDcaBKImX+18BVhzZZH3vx7TsT4qQVHqWFeDo1U90V25KBtTlQRS
	/AthAtBsKITh5fVhgxD5yMqG3HBg/9s6dbCg2tpQLeU0QxNo9v89BimR3FLiwqyV
	4PZGsbfpJlJhtXxjw0V+8+Emo/+hV+CJArp7Cu5NjZa2r4gPlWo+RjYkyZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744123802; x=1744210202; bh=Wqz9tyZmaZxwAPrjxl7vXKReFLTglz9XfKF
	Zn0CG068=; b=Ek53KTT5YLnihKIKOGwjhVZq4riBqGY3CZtGTKFhRDTeDwlbccN
	rgTuKGC1dKeTwq7vmmWIM9hYfUTgIufe8ZMddimkzljkNE84gURcTF0YcF0HTQQn
	vc5+/ABnbX/H6rPpBCHdYfij67kVgYDkFiVrDe38YbKRjn4+2wUoO5nGPg0BY40V
	HE1iuoRIjs0O4b93yo375CSZhPvFP14+56Fs11xlVPvGKdrzZvVctbLdd2lgUB62
	Y9RguZiv+gQqfDV71PnhJ2ydwG7yw8CeX0idpEzONPVsN66KV5Gb/D3698zrGJKc
	pGhK+fWM5JojtG5ZHTrtD0F5LPdPQAgAC+w==
X-ME-Sender: <xms:mjf1Z6pEeO-BrC0RV9Q1AXmrqbdxC27oe9zcIlF0iQ-amAFt9rDWWw>
    <xme:mjf1Z4oUlARwtc1-UykeXVpfB0z2gxg07WwMuD5yjYpO1hxJphsGqUQKcGB91xsWA
    jDAhwmTjVSewG7e5Q>
X-ME-Received: <xmr:mjf1Z_MSGZB4Pd_y1MS296UKoGF2f_b7o_7UVPHY_ivPJ1JSVM2OEdQBVhgOX_6Cri3PNURD3ZdNJvjbovFjFYxPMlhzharStCSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepleehfefhteeuvdekteeijeetuedtudej
    heegtddtueefvdeijeduudfggfejveegnecuffhomhgrihhnpehosghjvggtthhiohhnrg
    gslhgvrdhskhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mjf1Z57PmliZrm8-FzusBPRXc4vq8tOO-rY8ZahAG7_xal3wWsOUhg>
    <xmx:mjf1Z54eXnYosfsl-7EWdwvqfbabl-QNFt3hlC-_ktI44rom0kjbOw>
    <xmx:mjf1Z5iZI7RQFYkAFcTVXQyAtEdlKc5QbAaGyYQD_BJcvWGgYEjl6A>
    <xmx:mjf1Zz6H5ImwcVkgMbxUuM6Ik0qkYo2mkxg1tGJIU1_u7dS2VWav2A>
    <xmx:mjf1Z4IRwMwB8B6B0l3dq3CEtNRlbBEDzXeUWD5PRarxYm_QUgSZt79g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 10:50:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
In-Reply-To: <Z_TAtJ9LEeHo2AQN@pks.im> (Patrick Steinhardt's message of "Tue,
	8 Apr 2025 08:22:44 +0200")
References: <xmqqtt6znch3.fsf@gitster.g> <Z_TAtJ9LEeHo2AQN@pks.im>
Date: Tue, 08 Apr 2025 07:50:00 -0700
Message-ID: <xmqqmscqyag7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 07, 2025 at 04:49:28PM +0000, Junio C Hamano wrote:
>> * pb/perf-test-fixes (2025-03-28) 2 commits
>>  - p9210: fix 'scalar clone' when running from a detached HEAD
>>  - p7821: fix test_perf invocation for prereqs
>> 
>>  "make perf" fixes.
>> 
>>  Will merge to 'next'?
>>  cf. <Z-pD1puYT87YKAd4@pks.im>
>>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
>
> I had one question around empty prereqs introduced by the patch that
> wasn't yet answered. Based on my testing empty prereqs do work just fine
> though and evaluate to true, so the patch series looks fine to me.
>
>> * ps/misc-build-fixes (2025-04-01) 5 commits
>>  - ci: use Visual Studio for win+meson job on GitHub Workflows
>>  - meson: distinguish build and target host binaries
>>  - meson: respect 'tests' build option in contrib
>>  - gitweb: fix generation of "gitweb.js"
>>  - meson: fix handling of '-Dcurl=auto'
>> 
>>  Random build fixes.
>> 
>>  Will merge to 'next'?
>>  cf. <CAOLa=ZQ8bTn-prAs2ycLdLLjVaLQL4GtLw_gFsvAcx_6j=MBjA@mail.gmail.com>
>>  source: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
>
> I think this one should be ready to be merged.
>
>> * ab/pathspec-sign-compare-workaround (2025-04-01) 1 commit
>>  - pathspec: fix sign comparison warnings
>> 
>>  Some warnings from "-Wsign-compare" for pathspec.c have been
>>  squelched.
>>  
>>  Will merge to 'next'?
>>  source: <127c3010-4b23-436e-a07d-e6031e746113@gmail.com>
>
> I had another read just now, the patch looks good to me.
>
>> * jt/rev-list-z (2025-03-21) 5 commits
>>  - rev-list: support NUL-delimited --missing option
>>  - rev-list: support NUL-delimited --boundary option
>>  - rev-list: support delimiting objects with NUL bytes
>>  - rev-list: refactor early option parsing
>>  - rev-list: inline `show_object_with_name()` in `show_object()`
>> 
>>  "git rev-list" learns machine-parsable output format that delimits
>>  each field with NUL.
>> 
>>  Will merge to 'next'?
>>  source: <20250319183410.1225428-1-jltobler@gmail.com>
>
> Same here, I did scan through the series again and didn't notice
> anything objectionable.
>
>> * sk/clar-trailer-urlmatch-norm-test (2025-03-04) 2 commits
>>  - t/unit-tests: convert urlmatch-normalization test to clar
>>  - t/unit-tests: convert trailer test to use clar
>> 
>>  A few traditional unit tests have been rewritten to use the clar
>>  framework.
>> 
>>  Will merge to 'next'?
>>  cf. <xmqqzfi0pthr.fsf@gitster.g>
>>  source: <20250304113323.10564-1-kuforiji98@gmail.com>
>
> Yup. I didn't review this on-list, but already reviewed it internally
> before Seyi sent it to the mailing list.
>
> Patrick

Thanks.
