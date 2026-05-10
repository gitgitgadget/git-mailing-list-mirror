Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493B79CD
	for <git@vger.kernel.org>; Sun, 10 May 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778371280; cv=none; b=Q7+XUPkgkFhwFhXJEgVl06mXSctDjlviW+HA+wBUJJm6GoBKMQng82JXrKITf6m0H1r0EhlRS4AOLdW8wp8ZMtoh41QZn/37Q43uJjPe1Kbou5OOBi97cLcgH1KyOiGfa4VtRt2dzwt++9q6VRc6+zwzqsoPS6NRecLRZS4xRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778371280; c=relaxed/simple;
	bh=Kd6lG2Qfky3ooaNsand6VyaqGIvTPSj7w87hkslTQGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbAUvPNm8G1TXp6DrW0f8lDkmcdeztgUhk1Xdx/VAuzj1/h/PO8Hpr207xXdif2e9BuMVM0hkegWyFOmOiKn38mnuxxkS6kHAUNhw4G5/yLQA/clWjdBzV1I7Twq+xGwccXbTPxkOtTTXWJkhu//nJ4VSuduiMR1PvKYYLkPpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ixcSsyQs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VN4G6+fa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ixcSsyQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VN4G6+fa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1345D1400080;
	Sat,  9 May 2026 20:01:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 09 May 2026 20:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778371277;
	 x=1778457677; bh=neO1KFN0C/m1X1DbjLf3P+C9FoZjOkr96SfNamyfbgk=; b=
	ixcSsyQs7MsJQtgqYC9FckspjAOv0wzuDoSepBV28ulQ9OiuLPSPQJS6mmum1XH1
	Do7/J/UhcDsVbZFYqDSGTnnk9xlOO2N+vXXg9my3Q1ise2Kyv6vF7NE52kVQ6j7U
	0itDvOEvtov7FZH6zp44lstMGN8O2hCt162/s2Vo8Iglhp2knnd1yICVE01m3UIz
	d6YaR/Vf/X5qSqAvVwq1rBrfNDeeq+NI/NnyDXO7zHPqDxBtn5JGqW0UbQIcQEW5
	kKVewHAGURIKE+2KSKlv/wOry3ggsTrYYS7FsZgyVn/SDRsflwGsJXP51r9IbWB0
	Ol7uKITjY4iSyu91WqUfYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778371277; x=
	1778457677; bh=neO1KFN0C/m1X1DbjLf3P+C9FoZjOkr96SfNamyfbgk=; b=V
	N4G6+fauMDAr58JapcivhOS97UaGa7MO6PeVYpUosZVF03YZMdv+Xo+2rIQ7+HX5
	2SVAPOXi+wK2QZK6SmELLHJ/BFk572QyWKGWPry2hMvXYP/71hecazgMM4WhLZKL
	ZOhyEHecbrkz66PtlPmB/WLQQBhCXNFi4EytHL6InCBMmkpeyotZJUR+6DyJmg3L
	0GjdHi9z6gJyoOKNEFqLcSATsZJi4IUHFzGR4un5jG62JEfV5XsnbX2eBzJ9tOST
	xC8TGf2jN31Kk+KFJyxKWlTnGc9j+/vt6OH24SmMc9cmkdeYxTGEtGkdgbjEqVMG
	yolqwH/16wLNMid7xe8wQ==
X-ME-Sender: <xms:zMr_aTCBOVer7kCND1budPPtWkBq03NZJCcq1_m7vqUU04fTQQwqmA>
    <xme:zMr_aQYI-qB4jPB34EkbC7lcFElrMhLl5es4IJ8Q9WdB3D1boq86I0Q2R0kB1RoU0
    Sa9K1DjWteVdSAxLgDI3EoFeOZyjXXCPDHbOZGPoqPXwt3ohG6hew>
X-ME-Received: <xmr:zMr_aW5hRWq5po9dtddSIaSc0K8XPDlRRtDSYyyqvCQEPT8IKrD7mqXu9BUZBqXI9G8XeJIxiCvHIl_TQkq9Tbgi3T4gR51uyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    grsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrggrghgrrhesshgrrghgrghrjhhhrgdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zMr_aRZ6HFAo_D6ikSrMP-i5DB8D14gmJDKiejvFkA5dRkqY3_sgqQ>
    <xmx:zMr_aVh8LYeC6LEMVl-D2YGREPUukwYu4SM7pIbnn7SqcxgsqXsYsw>
    <xmx:zMr_aS9bMWGHGd-evmCk9yw8PbxiRweVAFmey68VMFx50pVGYT7AgA>
    <xmx:zMr_aQpVfeEedn26pZ8rnLrLYs6vNIu1mA2UAO4M2NKa0Ha9eWUdgA>
    <xmx:zcr_aS3Famq-h8E9-ZzJCEilJmXOLAY60FXcep3fORhxbz8XKasdkJu9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 20:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: Saagar Jha via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Saagar Jha <saagar@saagarjha.com>
Subject: Re: [PATCH v2] submodule-config: fix reading submodule.fetchJobs
In-Reply-To: <CAN5EUNTPiu7p=M8CZB_3Rcbsn34eEZC6YeiA3NW2zM7zSS42HQ@mail.gmail.com>
	(Pablo's message of "Sun, 3 May 2026 15:07:04 +0200")
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
	<pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
	<CAN5EUNTPiu7p=M8CZB_3Rcbsn34eEZC6YeiA3NW2zM7zSS42HQ@mail.gmail.com>
Date: Sun, 10 May 2026 09:01:15 +0900
Message-ID: <xmqq4ikgb0ac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Pablo <pabloosabaterr@gmail.com> writes:

> El dom, 3 may 2026 a las 13:57, Saagar Jha via GitGitGadget
> (<gitgitgadget@gmail.com>) escribió:
>>
>> From: Saagar Jha <saagar@saagarjha.com>
>>
>> The old code accidentally passed &max_jobs rather than max_jobs into
>> config_from_gitmodules, which caused the setting to be written to the
>> wrong place and dropped.
>
> Better, but we can improve this, following
> Documentation/SubmittingPatches [1], it is better to write in present
> tense something like:
>
>   update_clone_config_from_gitmodules() passes &max_jobs to
>   config_from_gitmodules(), but max_jobs is already a pointer.
>   This causes the config value to be written to the wrong address
>   and dropped.
>
>   Pass max_jobs directly.
>
> I recommend reading Documentation/SubmittingPatches:
>   [1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Very well said.  And your version reads more natural in the context
of this project, to those who are used to "git log --no-merges".

The config_from_gitmodules() function takes (void *) as the third
parameter unfortunately, which forces the compiler to take any
pointer without complaints.  Typically an "int" is the same size as
or narrower than a "(void *)", and has no stricter alignment
requirement than "(int *)", so passing the address of max_int (i.e.,
"&max_int") would have caused the callee to assign an "int" result
to the on-stack "max_int" variable, corrupting the pointer but
otherwise causing no crashes, since the pointer is not used after
the function returns.  That is why we never noticed this at either
compile time or runtime.  Only those who paid attention to the
actual return value, like the test added by this patch, would have
noticed it.  Nicely done.

>> +test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
>> +       test_when_finished "rm -rf super3" &&
>> +       git clone cloned super3 &&
>> +       (cd super3 &&
>> +        git config -f .gitmodules submodule.fetchJobs 67 &&
>> +        GIT_TRACE="$(pwd)/trace.out" git submodule update --init &&
>> +        grep "67 tasks" trace.out
>> +       )
>> +'

This inherited badness from existing tests in the same script, but
in the modern tests, the abouve would be written more like

test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
	test_when_finished "rm -rf super3" &&
	git clone cloned super3 &&
	(
		cd super3 &&
		git config -f .gitmodules submodule.fetchJobs 67 &&
		GIT_TRACE="$(pwd)/trace.out" git submodule update --init &&
		test_grep "67 tasks" trace.out
	)
'

in order to

 (1) open-close parentheses for subshell on their own lines;
 (2) test_grep to make the error stand out more when it fails

or avoiding a subshell altogether and do

test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
	test_when_finished "rm -rf super3" &&
	git clone cloned super3 &&
	git -C super3 config -f .gitmodules submodule.fetchJobs 67 &&
	GIT_TRACE="$(pwd)/trace.out" git -C super3 submodule update --init &&
	test_grep "67 tasks" trace.out
'

