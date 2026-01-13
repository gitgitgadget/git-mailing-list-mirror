Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871073904D1
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317746; cv=none; b=eWim2g8YArkbP1dlIehmqOzjwlyqFVRtVdiRJUT+JOnOS6IvzsQ/7JGDr3L4XfTMAZbU7m/OiowyP6qWCj0YDJQhFBNYvzuzmcZjOAxO/kXqdqtqFPEKdc0mU5o1C9fNpq/GNu6iWakRgiTQAmK6Cf4//cmAlIagdF7dU4CSDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317746; c=relaxed/simple;
	bh=97/w2L7KO8Si23573/CW1AAwtbehAHNkJ1cozN7q8kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HXGb7Pm14i5dkhEwToad7sdOS3LO1uD3MFskFiptCSFhn7JN1V84u2Mv/qJuHRpmOWr48EnyCU1voXmQb7MX4q+CH+I8v3FTsaLdztPJ4Y8GP3NFZRDmfvEVZS0qZlHKY+zUVutyzQjj5okygZKdW26eW9Ntxi3fx42dCtSIdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m+wqRRMp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoNNZjV0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+wqRRMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoNNZjV0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBD007A008A;
	Tue, 13 Jan 2026 10:22:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 13 Jan 2026 10:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768317742; x=1768404142; bh=laN8Gz6CJO
	mTmlp5W89es0qEt5qavjRetnWcXMSIQpI=; b=m+wqRRMpcVfDp65ZOCanEUD6dQ
	id0/+vwPjF+9qCXcdIDdodSNixMNr7WsZZIO52xhmiFGt3CdVBy7MD6iPHkbvVby
	QQzHO1VZ0psAYvKuXgyIkh1WiNjvnubCEs0KuEk1RoMYGbCCWqJXqDk+GwGSU6EG
	vQEW9ygE0+QpVkbPgrmA/FtrtWa8ADvFHWpyfpZgKlOHX+6AGJ9MQYDS4k4WHvXj
	7bW4cGI4lT0hJwNJZl83qzIRWwQgU9dY3UvlTmgqFDZsZMmPKxK14YopWGJ9Q80M
	DwGADZBK7R5ymDA0v2G3gqRF+WbXlVvvkwnLFdgdnNSd1Ms1YQxkJtg70jvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768317742; x=1768404142; bh=laN8Gz6CJOmTmlp5W89es0qEt5qavjRetnW
	cXMSIQpI=; b=AoNNZjV0Ad9Jj46llfKCvmnsGIO/iFGvvdzHYv/SNUpJLmjIKCO
	6DMIxaS+Splfpf8V7HCmUxu1JQOaSIqsf0Gy90M5dF1cGKsPGIj4gx/X8V0ccgUk
	7Z8IYT7A+xW7SYp6+mlU7nQfXkMUKH+tmEgU0Mn/V4JTnOm1PNtA/q1kSm6p6G4S
	gIn9PzHgSpJvu20U4Lls6kdzGIyRNlnNjmC3mEO0289FbGYBTp9XrHHc8VO87VMe
	3xuQSvuQ1H7zcz4vERgNYpQ0JH80oOUMOD7w848kPGRl+cMXZhFzGnoQ6wOjq6Hp
	QAY30FoXHtg1K9PMsOoVATj9BkpDzsyz82g==
X-ME-Sender: <xms:LmNmaYXYynYLcLG6BCqO0s-09lQLUbL7kchVvuBnL5oYthkaywa7bg>
    <xme:LmNmae2yT8LP0-08RIeziR6j6RBGCEP0Qb7eqD_RrQq3sED51YUeRcPbyMmPwFbge
    JF8Cs_VVPMUR6HJoPEiKC_Rn2y6VssE88_TKvKuPsVfUdQKVnsu7A>
X-ME-Received: <xmr:LmNmaer4b7oEf9Oox-s4BO9z_Yr1MrgpDGZN6fNML9nCJqH7F5Me8NgaGekA-SzoGiKuvCfhH2FLHHNpuD97H2J5BZopUBwK8OEu9l0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhg
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LmNmadWltu01pXN0XVdOw_jRVXY517U6VvyEiJYclMCjJwPNMwodvw>
    <xmx:LmNmaRbO0i0MFdhn2H-1lCKdd2wWFL68sTO_7bwRvcK5PtI6isWZGg>
    <xmx:LmNmaSfjfkpkrnQ662sXNwPlwNM9JevWeheSVR-O_NeaTQG1lUZonQ>
    <xmx:LmNmaT0d6mVh9nueorK1Mna7cUw47GomeABUpyGlqFxUD27eU6OgRQ>
    <xmx:LmNmaSpujxtkgp37-dYraO3-8mSQhtoA2uaU-UF2z8HfOhLluEfnaDQh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 10:22:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Chris Darroch <chrisd@apache.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <87h5spimno.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	13 Jan 2026 16:59:23 +0200")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
	<xmqq7btlliip.fsf@gitster.g> <xmqqzf6hk3ox.fsf@gitster.g>
	<87h5spimno.fsf@collabora.com>
Date: Tue, 13 Jan 2026 07:22:20 -0800
Message-ID: <xmqqv7h5k05v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> What was the previous behaviour of code paths that ran other hooks?
>>> Was pre-push the only one that didn't divert standard output to
>>> standard error?  This patch does look like a proper regression fix
>>> in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
>>> the change for "Merge branch 'ar/run-command-hook'") and random
>>> sampling (like run_receive_hook() that used run_and_feed_hook(),
>>> which set stdout_to_stderr to 1) seems to indicate that it is the
>>> case.
>>
>> By the way, if stdout_to_stderr is by default set to true, but tnis
>> regression fix allows specific callers to opt out of it, then the
>> title "make stdout_to_stderr optional" is a bit misleaing.  It makes
>> it sound as if it is false by default and optionally turned on.
>>
>> Perhaps like "hook: allow stdout_to_stderr optionally off" or
>> something?
>
> Ack. Will rename in v2.
>
> Please wait for v2 because, while writing the tests, I noticed pre-push
> needs 1 additional line (ungroup output) to function as before.

Understood.  Thanks.

Writing these tests would take particular care, I imagine.  Apply
the test to the tip of the 'master' before ar/run-commmand-hook was
merged, to verify that the tests expect the behaviour before these
series, and then merge the result up in more recent 'master' to see
that the changes in ar/run-commmand-hook did not negatively change
the behaviour, or something like that?

Thanks for working on the fix and the tests.
