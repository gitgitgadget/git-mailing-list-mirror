Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B61E5724
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598716; cv=none; b=Nlk9jQx+dgONp2+SQtcx6uL7WPjYjG5JFVZt1d7aV+I7wYnPA6Bcyr7PqHtAPGNeg59dhorC0fVDF/1KujwMs9FAMlHF+VLj1wbJObsqRnHV8ziqrjvBme0MloIotJWIYEx3berPb8u8shLTbJ7fs5C2OCa27RaYZGnM1NBsdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598716; c=relaxed/simple;
	bh=hDNYL9ws9rU5GRZ8rTfZ6zvKqlqO/ylvO7B3xBsqEQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jd2XUpAvcH8hho+BDQtOgvvO92PYWeOfrm8zqFlkvTBWS9Rx5f9D/MbXt1Vuu3bMg1PymIXsoDr2vb1L8HbTkdH+LTcaYn0H1nya2r4hryLweD/p89IvYnoPurBnGB0Du3fLOrkSzB64s93+A5OtcdSdTepqSQpdoQTDe/lkE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yj29i8I7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KzntL2ah; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yj29i8I7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KzntL2ah"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DB3F2EC0368;
	Mon, 27 Oct 2025 16:58:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 16:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761598710; x=1761685110; bh=D43Uu8oEUG
	RRSiO2ZpgaKBvpH05NFtrQS5C47tlbRpg=; b=Yj29i8I7D65Zyg/715T+gKmtks
	oCljh//GSsz8/o00iw3Ks4+jXztRVtKdl1Rxw49/H2Jgp7K8AOWzxuX6aVl/mwzv
	gmk1BvFcc/zK2SxNXJX9oq34szOoNJ2HpVWGPNiIadFSLLaz7sy1BGU6+8d0bhpt
	PXUBJAWylsq7NN2P3lQ4uPKlju5tk07d61nnOGHTWBUNYUeiEtIgf9K4nxxoOSW5
	sBcltQudt4Q/Iv+AkB8H871/p9rJsajf6kTwYCUJuwrnMJtpU9WqZws7pq9VU9ug
	mkWfusJhUbHtJK7UeU9F0+RMMvMZ+tQ7uk0PozpR/QM1InKYV5dLuqMZ8tEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761598710; x=1761685110; bh=D43Uu8oEUGRRSiO2ZpgaKBvpH05NFtrQS5C
	47tlbRpg=; b=KzntL2ahdPCN3uLp2mx3QrJzRDkhTwb6U5c7pEoeqnUFZWigibT
	9v0IevFYHxIN2uf0oBqo997kqsmUqQXeqM6Kc0vutIwWItu1+VgZ5ba2QJ2S/K96
	pTLPtnGIp3z8wBxRiMn5IR4Pf5jGxAlNm1HTWL8AF5CY2cPM24WMdE5exTIHfQJM
	mCDc6+gh3+MefRuz7rljCrqw4eEG09tDSQn9vgOkQaACrM5aVw9LHw5L/geII0aI
	O2DLI12antsDrZi8Krgfp7CiSOjCLWdvCpy6u2BfAnfNQleXUqevRKWeqMdkWzmn
	uWQ/ckEKG1LgSGSpYXhgBugZg1KJNrvK/BA==
X-ME-Sender: <xms:9tz_aOGPeSILsZtX9gIWc4GPA9Uzna5WobJjM7F499j8M32_umVrgA>
    <xme:9tz_aBltQKWKclSNarTHtyf4zESW5tgs6WKjqol_eckyXbd8xMRYyU5AyJmRfPLT8
    VxO1DMmHLLi1nnKQ4MUJ1dObFhvIXjsZTPRjO8fK7lutPd485AmEg>
X-ME-Received: <xmr:9tz_aKbFwmr0xvk1RKRSWs7ksNCMqz-voNNNLwFD9AZeYlr7P1lIihQu7wqrZ1IVSsEdLYhc18V22hgshTLDptf57hrmlQzPZxqB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9tz_aOG5OCoG0u-FN9CgaS9Ktm-Ky_u82VFVJi4U8mZ8d57Pw7_90w>
    <xmx:9tz_aDIfSLKnrGDPHGyhWw_RcE59fsksAtVP4ovG6gpIdk9KvM0Q9Q>
    <xmx:9tz_aBOUISVWHoVG3uULZ7ZwxoKRMxMZLJfADg69mK0l9ycNt9vp6w>
    <xmx:9tz_aLl5s2kJebL8kMIvNC7R8tE-ck4TI0tfGVXklOFf3q-Zg2_13g>
    <xmx:9tz_aCsouCdCy-QV5xDMwX0SFbAFo79MQuz22Ze0qTG2Uin5N_heYsoW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 16:58:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Derrick Stolee
 <stolee@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/10] builtin/maintenance: introduce "geometric"
 strategy
In-Reply-To: <aP_Qe2QG5w3g4Z9y@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Oct 2025 21:05:15 +0100")
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
	<20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
	<xmqqtszkjq8d.fsf@gitster.g> <aP_Qe2QG5w3g4Z9y@pks.im>
Date: Mon, 27 Oct 2025 13:58:29 -0700
Message-ID: <xmqqbjlshxje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 27, 2025 at 08:53:22AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Changes in v4:
>> >   - Fix a flaky test because git-repack(1) always decides to rewrite the
>> >     MIDX, even though no packs have changed. This isn't a new issue, and
>> >     other maintenance tasks behave the same. So I decided to punt on it
>> >     for now.
>> 
>> Thanks, but this round raced against 'next', so let me fabricate the
>> following and queue it instead.
>
> Thanks for doing this!
>
>> ------- >8 -------
>> From: Patrick Steinhardt <ps@pks.im>
>> Date: Mon, 27 Oct 2025 09:30:50 +0100
>> Subject: [PATCH] t7900: fix a flaky test due to git-repack always regenerating .midx
>
> s/.midx/MIDX, as the MIDX file does not have a dot anywhere.
>
>> 
>> When a supposedly no-op "git repack" runs across a second boundary,
>> because the command always touches the MIDX file and updates its
>> timestamp, "ls -l $GIT_DIR/objects/pack/" before and after the
>> operation can change, which causes such a test to fail.  Only
>> compare the *.pack files in the directory before and after the
>> operation to work around this flakyness.
>
> Maybe add something like the following:
>
>     Arguably, git-repack(1) should learn to not rewrite the MIDX in case
>     we know it is already up-to-date. But this is not a new problem
>     introduced via the new geometric maintenance task, so for now it
>     should be good enough to paper over the issue.

Will add.  Let me mark it for 'next' after squashing it in.
