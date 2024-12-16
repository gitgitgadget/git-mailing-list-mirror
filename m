Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45B19DF8D
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366459; cv=none; b=sLN3i7wU1zm4hWmVDM3+lMbw/Nq3x//XzX3CIJqItDbJyfp5AWTi5QHdbXl30fKPuSnhCq91a6OI1kqBPInk099R6ONd7wHv8OTx4/NxBRi2tZVHXqvFdqKdgLLIgGZVQ+Pu74+LSbhjpi+eQ5FiaPNYUo0VK1OgoD/9hAgTrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366459; c=relaxed/simple;
	bh=33VvUn3FRsNOGuiJxWGyCGET4H9jj5M7q9iyFGbRIEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPwQSh8ZonbfWowRqEDNxrDPJEnppIf3Shyp8mFMi/kPDRlgVCbqDXbP7Q0K2PtiE8G6zCe5OIeVikOpLrJHyHZcsAirq4PpZN9zzG2EkznCvaNwilDW8VA+KnfkcWQMks3ka+t3lzor0L7gfePp7WwSoeL7s0steY+Gi2AhVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yu03fXsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2dK/jUbq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yu03fXsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2dK/jUbq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A031E1140120;
	Mon, 16 Dec 2024 11:27:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Dec 2024 11:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734366456; x=1734452856; bh=Hf5//UbZww
	JtYGovEjonlLq68nqSn59mB2alHbDGibU=; b=Yu03fXsNzE1u+oGfEJ+MM3ZL3o
	r5O7TcClpqk7naAQeUe1bLgyVBB0lzSeASZr/0cC3NhR9TsO/BKI1oC1tCeNx1I8
	qvwLnpf1be/jeISPLWUy09f1WcOHm59Rx004Ez9SPbH+f6El+PUfExHsBx8vucgO
	qe8/8PkkDRMEf/rL97Pkal+WAW/+ATQz4qKzx+9v6Feq+fbSsbXasFPtTrne5Etx
	MpHSyU/oE8UxRYdhS17jLTvIFWoAUF9A7sxKG6Hl61/rRp3cO23EKDoUrhiIMM4h
	72rKe3yRKWmQ0u5UP5e3ho989ytcRymBSi8itKZDO8LPcNyBgQql/hjPd9tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734366456; x=1734452856; bh=Hf5//UbZwwJtYGovEjonlLq68nqSn59mB2a
	lHbDGibU=; b=2dK/jUbqn3bN1Rj4DFQWvr+5DTu2FFfaNyyCu1ZXcx3k4Xgkga0
	s0cz5vlc8HmsN3WJ8jc+pRu/XhVyLHRBKOC7GAA+9TFwrYy0Q4aZVFaVN20jPVrC
	5jOOTC4akP8op3ThXvT0KWPD9Fnd6vOTMRdFlO1AQuZWGvfO9q04PjJxjKPXCyGs
	shFQYEuT+wvtaa0Cw6Is8p2CWAM4a0XsQ36Yj03r5k4RYgJys31YrudAhTcKpYtm
	o3iq4PY4p2kjiCZvOMb/ZxoIxVZfGLecGK454VYxA6Q9CS6GmhTjma9O0mTR0Kv9
	nmZXb3RtA22e+niRLBlYxxUj2DOUsXwWwIw==
X-ME-Sender: <xms:-FRgZ2TETU20qg1xCaDaco6gfL7dRQeZWnd8TmGoK4Pzk7PRDWNIiA>
    <xme:-FRgZ7yStNTcMI_1mvILpQvgolpoSY7MVyKRtxFTbFMhKnvLpplzJBmlYJbj2amfC
    vzWjNe21hxIc_dhNw>
X-ME-Received: <xmr:-FRgZz26ZxFRTs9vx05UZTfOA6SGkzhAg4FWrqaoswRv5Xt0o0hHNzzzzI1jyr6iwGOtpa1rHX19kXvGBQ8O8DusC4xtjv5JYmkUsvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-FRgZyCGnHWQYEfUPPmik-7nVJYhsHnW4ovrscxR4-MnZLRtHtL_xQ>
    <xmx:-FRgZ_if6VVMbmX9SdCbwJBzE3BRc7MDEIJdefmBfaR8_vCWzj33vg>
    <xmx:-FRgZ-qIuIPDsBENe1-Zg1gyloOR2ytfGWNyUw9_oVwBDPJ-7oaQrw>
    <xmx:-FRgZygZ6nYuUtwJsx_6S3g4YPiP0QJaTpcbH3FO4-ZMrXNmFVBYZg>
    <xmx:-FRgZ1YdhwAPtsMZFeiOVBvhaJ8DKyStm6Jg-nRsyabmk6WnxCMExxuI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 11:27:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  karthik nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/8] ci: wire up support for Meson
In-Reply-To: <87zfkwgehr.fsf@iotcl.com> (Toon Claes's message of "Mon, 16 Dec
	2024 10:32:16 +0100")
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
	<20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
	<87zfkwgehr.fsf@iotcl.com>
Date: Mon, 16 Dec 2024 08:27:34 -0800
Message-ID: <xmqqa5cv7fux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Changes in v2:
>>
>>   - Improve a couple of commit messages.
>>   - Explain why we remove `-x` from the unit-test driver.
>>   - Remove unneeded `CC_PACKAGE` variable.
>>   - Improve error messages when tests weren't found.
>>   - Link to v1: https://lore.kernel.org/r/20241211-pks-meson-ci-v1-0-28d18b494374@pks.im
>>
>> The series is built on top of caacdb5dfd (The fifteenth batch,
>> 2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
>> build system, 2024-12-06) and cw/worktree-extension at 2037ca85ad
>> (worktree: refactor `repair_worktree_after_gitdir_move()`, 2024-11-29)
>> merged into it.
>>
>> Thanks!
>>
>> Patrick
>
> I went through the range-diff and looked at the individual patches, and
> I've got no more comments.

Thanks, both.  Let's mark the topic for 'next'.
