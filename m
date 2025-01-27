Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA060B8A
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000944; cv=none; b=DYrD8dqRsUenCwUWAqoT5PCiNojpTFROA/f221WugFnyKXdM8cTE/raTS73WDCQgAgTP70RV71nIU4avt0EngJfdcMCrG6XbXa/UWNL2ChnW3h+rHOLdVf0JRk7NxyLgPKJnEx5CsVHv7uGCX70Ruo11fhM2/lXSoIk+8UjUgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000944; c=relaxed/simple;
	bh=mXC7b4UDkvzRIa5WiIcPRqBF8363tdzQD9hubgiDGkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OB0dhNJe8kQ5ed4wVvLWJBOhbezuFUNu4pQu+QH9iJ9/rTEbpKAx+MqfDkjSspxrpMXhk0n9VpqjF7UcR2FEO1t/Se2xjSpiN7DRetuWe1SDqszOeAbnx4H/PoT6B8E3J9vPCo85DmDA/ZAbTRZB8ytbnywhuDKHmUZ0YL71lUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qYze6bYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exQHlPSc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qYze6bYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exQHlPSc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57D9D25400DE;
	Mon, 27 Jan 2025 13:02:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jan 2025 13:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738000941; x=1738087341; bh=CiKPWoSbIX
	V8Vl7YSgsvBhg3FPlQjDoKHCaBmoXQNO8=; b=qYze6bYq+PoQ25B7Mz79GzI+ln
	RgDc3KE9nmDGJxFuloDVVIHGQ4Oyu+uhlKGBcSjTbcpagHLMzmOf53pLaVT8/U64
	+LxPBcEsBXvWH7CAaNeO83nAGITxF0VqTthXcFBGF4+4mKU9Xs4PX9h0WlqLX8tt
	rwL0GGSGIV9mqtjPOICSSDpnDVeTG/ERrPq4VhsRdp9od/eCNcWuIMCxU4B0CfT9
	nHGPhEafjATOYAqiy0IGyVIZZPqdmK/+1OzmdoC48WNLDBcloF0I17DASjwbTgo6
	PdCuMR+CrLEjM0iEiv3JDLToA7uRXQj6YzSO/bwsHeg7+JOHAFpUyni7RGbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738000941; x=1738087341; bh=CiKPWoSbIXV8Vl7YSgsvBhg3FPlQjDoKHCa
	BmoXQNO8=; b=exQHlPScV2eUl5ThnVeD4/tw8A8h901f8JrB4HMSH03uYRoJNUV
	Zmp6Gy7Q9hNHxbJ0HW+OiZ/843Ng+JEaA1/cT7dojlqgHCyAa8gVeHoW/7VKo9as
	T9IAjCJAiWY+KMW/nxK2TOoABnuvskexbA8NATxJ1yotEc3z4XTMAqBlIJLyG3so
	6IUamUqt9SmDFGnAAqRWi60urjN5CHkFmTW9r6KGl1PBx9NNrxuLONLlmodwSwqW
	9UbwCIOyxkMvXmzNygbRCZv9PeooETcyrxclgcy72O1I7xCo8SVdz0+HbbhPf8o9
	QSi2wk1dLqXOyBgJ9xXl0i042oiz9Qn5C9A==
X-ME-Sender: <xms:LMqXZ4nQXt7-sMpvckhwJ0f9_HtpWTr5eEoWf1dmeTsw-obfbdV9Ag>
    <xme:LMqXZ338-zGKzS7xcdFIOI7oN4lmv_zwGQOh4iK6PvY-ra2SCFsqMNvJ5bKdYTAH0
    I5i5P7rNKWHhw8COQ>
X-ME-Received: <xmr:LMqXZ2onv82WvU-zFZ7uZq0SZ-3AuRIb_8xVCAxszoJzBK6H3qL5fmlgR7kVxJtkf7YbuW7evzpmXUNpIuIAXxK8MLAzn8fgGW4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LMqXZ0lwaN7M9Dp-jvGKVmFAUUMn3jiFNtXmjvrxJ_COCnJK-IpkmQ>
    <xmx:LMqXZ20p6ZQjvoAlr7aEFqhJvhgcQlO-WKYJmfo1QF5eAz7plkrWuw>
    <xmx:LMqXZ7st4Rms0Z5wWmp3jOblScPihhM3mPnP77pBvKa-h7VchCQaxw>
    <xmx:LMqXZyUM-BiwqL3ebzh-qf7V_TcSLvHi8fnwkB5Ji0aVg2B4c89GPQ>
    <xmx:LcqXZ3K-jo_1Rzlh9kFXQO-mlD-GDx67xZCdKTOiZiqKW3QwmDxditL9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 13:02:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object
 promisors
In-Reply-To: <CAP8UFD2Pehtk2=GkjrXga0bqsrUFauYKkPYPWgdRHsoaDvQQDA@mail.gmail.com>
	(Christian Couder's message of "Mon, 27 Jan 2025 16:11:18 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-6-christian.couder@gmail.com>
	<xmqqjzc7lq60.fsf@gitster.g>
	<CAP8UFD2Pehtk2=GkjrXga0bqsrUFauYKkPYPWgdRHsoaDvQQDA@mail.gmail.com>
Date: Mon, 27 Jan 2025 10:02:18 -0800
Message-ID: <xmqqplk8rv85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> > +In other words, the goal of this document is not to talk about all the
>> > +possible ways to optimize how Git could handle large blobs, but to
>> > +describe how a LOP based solution could work well and alleviate a
>> > +number of current issues in the context of Git clients and servers
>> > +sharing Git objects.
>>
>> But if you do not discuss even a single way, and handwave "we'll
>> have this magical object storage that would solve all the problems
>> for us", then we cannot really tell if the problem is solved by us,
>> or by handwaved away by assuming the magical object storage.
>> We'd need at least one working example.
>
> It's not magical object storage. Amazon S3, GCP Bucket and MinIO
> (which is open source), for example, already exist and are used a lot
> in the industry.

That's just "we can store bunch of bytes and ask them to be
retrieved".  What I said about handwaving the presence of magical
"object storage" is exactly the "optimize how to handle large blobs"
part.  I agree that we do not need to discuss _ALL_ the possible
ways.  But without telling what our thoughts on _how_ to use these
"lower cost and safe by duplication but with high latency" services
to store our objects efficiently enough to make it practical, I'd
have to call what we see in the document "magical object storage".

>> > +7) A client can offload to a LOP
>> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > +
>> > +When a client is using a LOP that is also a LOP of its main remote,
>> > +the client should be able to offload some large blobs it has fetched,
>> > +but might not need anymore, to the LOP.
>>
>> For a client that _creates_ a large object, the situation would be
>> the same, right?  After it creates several versions of the opening
>> segment of, say, a movie, the latest version may be still wanted,
>> but the creating client may want to offload earlier versions.
>
> Yeah, but it's not clear if the versions of the opening segment should
> be sent directly to the LOP without the main remote checking them in
> some ways (hooks might be configured only on the main remote) and/or
> checking that they are connected to the repo. I guess it depends on
> the context if it would be OK or not.

If it is not clear to us or whoever writes this document, the users
would have a hard time to make effective use of it, which is why I
am worried about the current design in this feature.

Thanks for clarifying other parts of my confusion.


