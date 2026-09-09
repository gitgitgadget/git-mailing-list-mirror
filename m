Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41806370ACE
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974909; cv=none; b=Il9ZcCrb6CiubUG4EdUtDOKhKE4pApHNu2o8c9ACQWB/4IisFLKWiX8vAAG0bAYL1YxFP6HiIlF0RJsp2Q+qSiPEGW9MmohbfUFMGvWjGfVRvyAkNvVL6Qsdos+mDeJ5+om7TWp/eD3C4cpOt/SULrTOr0VMnxJ3z6xOipE7r24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974909; c=relaxed/simple;
	bh=6rzVT9UeiZgaBYiI1uGALTvpm6QOZqaqWSt3lV6RdDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcPlKqWyZg4Ai/2Mowt0f7mS9fokahWQkqJP6x6jtU254Xnl3WJRl4Fwj6O98ooUoi5nS1ogbmjzof+fMWOuRfHT1ipHP9WmRXHNvSq87mi5g+oHaVMclCI+FN5Fjrn4d6jJaH717UvoEsUn4bTELd7FsEcqLI4tg2wUduPIIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EWXOZeek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQG/vw/0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EWXOZeek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQG/vw/0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D792EC0216;
	Wed,  9 Sep 2026 13:28:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 09 Sep 2026 13:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788974907;
	 x=1789061307; bh=qgqSh0PiPpLj3s1Gyqz5Vg2K+RJjG6ILWegc6AASs4Y=; b=
	EWXOZeeklcT2R69tYIhnPwl7EiezsciB34zUvzWPo0M6oiaoLatHd1LDrUA20Qoo
	Wey2RiNI8LBoMISLTm0IpwnhZa0s0f9H/UA43WVpMnhzomRxDbLsQwaY9pyVXkNK
	zDEdNOB8+U00iMYTCvJIZ2YbOEO6W4SQnQMPwgyKkHI6rBBYSMzzgXf+W6RTP2US
	ZAiMLB1NB4WKgbaO7Ph2luLixPmPKmS7FEsyO7BmfaHo4Nd45dKDCtrABep8vMfk
	ZKKeJoyG0AvLuUACLT616J3SbfQm47skPlOZ3r7Qf2/tJBqAL49a/MoUPXbGNIKO
	hqodskjCBaipzFZ9xVmvCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788974907; x=
	1789061307; bh=qgqSh0PiPpLj3s1Gyqz5Vg2K+RJjG6ILWegc6AASs4Y=; b=t
	QG/vw/0C3z14RWEnICBI2WlNr7O6EOKTGMjsmF0IFAkwP9Udcs9U6CBi4+ystDFT
	KQHVfiTnA+V49D3KvLzen+ZgFsAgps1M71J527VOxTRdDui0BZEppZFwva7QSbX4
	/RXP6yk7rTlnLJw85a1U5DOc8drc7y6OrVy7zJe6I9vCwOpFe+cOfXIL4EsE+E52
	+Z2ZDnMNzH4PkSDN39jU0wVF8moDBkLruYopaIH1sn9MF/7xoJVWu2+/Y//mmQ7k
	ePtssUx6NpfVA15npbOEzv1sgUYii/jUJzB9yMNwwD/kUKLws0ObCEK5wUqk3fWS
	0Ko97qn+ATsSxxqqhMbMQ==
X-ME-Sender: <xms:O5ehaoxJefLcW9RGWtrgrzag0y84Ih2PTE8KRHLWHty6F8R4ZaUwxw>
    <xme:O5ehajL_9IXU4z_-D1CSPRY6pAtU7ueWOkWA8ZGIwMuHZhxnqN2yZ-iuLPzSXk0u1
    eE6NAuifbFXteULXllm75xkSq6vKkjuIIOtqaRkh7vIfb1X9OIel0Qk>
X-ME-Received: <xmr:O5ehaionwmdtSIG49RIsBooOt6jb5T4s13GcduxZKo2NGiJg_vTk7QpQXUVTrARUZDH36L7wC2vsccvj1PcgyEf7sGc9MKL0A5Rk>
X-ME-Proxy-Cause: dmFkZTE1dx33gO3dVX4HpXJfnvQ5h2OzW3Kh4+sftGDoM9q+H64p4Wlw+12Z1BdNGFdsgZ
    /C5uwhM/4zCa6oY5XkW09htDt5H2rDTu/GKpjvsseJGQ1QHrNfqwAoeg0KARYMuiFYXo53
    iX92en0RGM1jly8Tn7oKsxGXpK1qe57xBBj++jdPB4F5I+4G3at5yi6opQzodeawPGyyyo
    PUMl/N2wqWu4roHYmBzAKL8+rpKCrXtTLc41cvNstsnPkxMJMA0OCpId9iHUk1AeqhtMqM
    wHxFrpniAQ6OPRR8oSF1XpR4NRjjYLO7dRQ2ourKjO9aLEkgr0DL8s3Nxkym9L4qGedrAX
    w85wV8OTYU+Dzgzf/3f50NAmNQMn0VGEyXb1+CoXMZk6P2F5ZnXEhBzUVkeCJOFW5k+Pvh
    PsSidbF2r9wWxGJyLpLnjbfbS4TwpJ5eXyrSt0RU2mMiij633WHzceCk77CGQz0K4LwAJQ
    1VuVsK2dwKgHKw89lePyktwAqZXH6MycEXlGOLJvO0Il10gt3b/J/GUqiHuum5JH+4qgHY
    V02JbGqtJTxlQ/4p77kbuQZ7O866AsH6tNBt9NWil0RULb4lhsE0xtvSnyhg6XKRPe7wDV
    cSH/Wg3D7l1e9alU7ODukeWS3j8CJYQCmUINnaLPD7hTSJbZiLBxtXBSXytA
X-ME-Proxy: <xmx:O5ehaiKTM6lV9ViB4t6qrne3xAmwgYAWzs-glQ-N7PEtw76bkE95WA>
    <xmx:O5ehanTuk7Vsj8jWcs_fvsqJ7XrsBjn8quOYaiq10kiZUvEN63G4Lg>
    <xmx:O5ehahsZJafz_84FzF2EZ8nNrWX-KRCTTT_7hcTK8523gLNo4u3RxA>
    <xmx:O5ehaoY6d2Qy9T0BsmTY8pMDVBImVVDkTRkwhQWp3S-YutaBM-Uzqw>
    <xmx:O5ehagjtxQ_1B1jibWiTsrlGqcMzVCsYZzip_jZx2iENYJMFRRkfDgME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:28:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
    Brigham Campbell <me@brighamcampbell.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Sep 2026, #03)
In-Reply-To: <2ed6b008-1d15-4007-8db0-b6684ec324c5@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 09 Sep 2026 16:07:32 +0200")
References: <xmqq5x0gyw9e.fsf@gitster.g>
	<2ed6b008-1d15-4007-8db0-b6684ec324c5@app.fastmail.com>
Date: Wed, 09 Sep 2026 10:28:25 -0700
Message-ID: <xmqqcxums5ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Sep 8, 2026, at 10:37, Junio C Hamano wrote:
>> Here are the topics that have been cooking in my tree.  Commits
>> prefixed with '+' are in 'next' (being in 'next' is a sign that a
>> topic is stable enough to be used and is a candidate to be in a
>> future release).  Commits prefixed with '-' are only in 'seen', and
>> aren't considered "accepted" at all.  They may be annotated with a URL
>> to a message that raises issues but they are by no means exhaustive.
>> A topic without enough support may be discarded after a long period
>> of no activity (of course, it can be resubmitted when new interest
>> arises).
>>
>>[snip]
>
> There’s also a topic from Sep 7th that I don’t see listed here, for your
> information.
>
> <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>

It is very likely that anything missing was simply overlooked (It
also is possible that it wasn't interesting).  It is far easier to
pick up if you resend it, rather than sending an message-ID of it.

Doing so also shows that somebody other than the original author
cares enough to do so (especially if the re-sender adds their own
acked-by).

I think I did not touch it back then because the discussion
identified needs for further work, and decided to leave it up to the
author, i.e., if the author cares enough, a final reroll will come,
at which point I may pick it up, otherwise I can safely ignore such
a patch even whose author does not care enough.

Thanks for pinging.
