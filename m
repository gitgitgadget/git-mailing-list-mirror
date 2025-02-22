Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737151E489
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740190551; cv=none; b=udgu1etN6+vQhcruMPygScMw3cg2mdtzoRCYmdvjFcZlCK1JqcZifVbg6g0l1rHpcxjkc0JDQlDnrA0ptnuWirbhwTd1pzsh0ZoJySWS8HtRZoWsqygsCT2bya51mATFxJqCqExRFecoJGWRpVLXGU8eEPJjsxzZDODA7Dc0QOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740190551; c=relaxed/simple;
	bh=BPvWVO7vAWyXIC6u9L0UHq+vXheOfKFAAlkp53o5OAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pv/wlVZTk9F15PqurpxGqesTceYRyKHrydxfQ1zGi/snmy3yyqrgIvMJ731Jd5OnAuI0eQEENwfZglnNVvbEXsm09MJvec6dX1hAtZq6PzbV5mrLWBkj4W+4oFXULLCT1arJAMFvq3vrlmELq6KDi9RGJdTOnQ6SAW7OpWgw2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y+kW/KxU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1oI2aFZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y+kW/KxU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1oI2aFZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E8E413809AB;
	Fri, 21 Feb 2025 21:15:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 21:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740190548;
	 x=1740276948; bh=QgWQknxkWBj78zrEl42ZVbVceLSvF2pFDx+2UkX7tXA=; b=
	Y+kW/KxU/IAQ4woYF3xGnPxSCOm93zQBWserQQt5aQiI7aAFyfa7rsVN3WPT30oh
	R3iT7PcGr5ehspaamDDQUAgMSMgY8rn+2NiHhBN1ADnuKbI9OZ0OZmcO0cT7SzUw
	9iDULqKvoBa9XVTeY15zDkarGzD6XKA4PuhBrPsGWb42RROvAD+ccricH+rnNmIc
	sJkNscoI/j4ifaSAgqicRTLlYolM/50PCrT2h2i+e2CY7O1MZhyEPq12KrtZlO6w
	QCTAGkrcMCfKtn05exRa+/HZvNIlNWFj6VktgoT7jdLcvkX/b4IiA4sct1MWT06V
	GgIC5Ob7xv5Eadnm77odNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740190548; x=
	1740276948; bh=QgWQknxkWBj78zrEl42ZVbVceLSvF2pFDx+2UkX7tXA=; b=S
	1oI2aFZIPO+YNy7JL5Kx58sfWmOd5RYwAxwDePpixDXBWrumsqPQ18m9uzWrkb5t
	XYyO+nAAFyPsIU8+2EcHAemTWDMCNOhEXeXaRiqII0Wl/nKDZAMe2YcvnJ6crTEf
	kPDtU8ULL64rdPc0rJ9fqed6Mz9QD5LXY02Bc+j/lZi0vTV3y7wgCyaWYCgQ0Npo
	KgNVle3mIcltubZnsMy1WgXLYHFCmd+V4K/pA9/3ZFVYuZhlmBg27UNDZtpdN6ZB
	JoKlvqFc2s6yKFApWRRZtFrnQZwDetEzltSmlvnIt5yihmQDaryIEhbs6MDdfRG6
	qqKH+pAnWCzcENtRefPLA==
X-ME-Sender: <xms:VDO5Z0LStv0SaHbiTm7zaQ4pAhiz26N9wEeLDYc2fLquu03y5PA1kw>
    <xme:VDO5Z0LujKAZGA09sHMouWTLND2dtvmDeB7o5FJeWigqI2ArpTXQ2dczkkIlTaOyD
    t2oHgg2bur97kYOFg>
X-ME-Received: <xmr:VDO5Z0sWSdJwGN9VBrRMhLUVQ2f5BgnWxjhWjoJDnwTA4nZ1cKbMYX2-uaNu75nEVHPcG-KrLgQ9WNmX3KYEGO4uE4kLuxeXDWjNHYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhdr
    khhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VDO5ZxZMLQ9UwtpW8BAH01YGB_zW2G_OI46nbqxxGrr5wCNKVgruyw>
    <xmx:VDO5Z7btMJ2QRv7Ux064C-57_wiTTLmUJINnve0E03b_H-EbEJU7AQ>
    <xmx:VDO5Z9BWFVypF2-ryyBfc0hhWSUGziV1SGLuQ-DM6ZFe2oY8qFEgYg>
    <xmx:VDO5ZxZocjuz5UhKhmA_Ks4Y0SEPXf5yYL_VCATXLnDFM8uT1EBysg>
    <xmx:VDO5ZwNMZYqQkHQe8u054OKBGFWSTtJht-F7BTkC5WVMkvlNxpItDZIO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 21:15:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: first bisection step takes quite a while
In-Reply-To: <CAP8UFD0xsZWDnH9kLJ4eWfzq4nvAm+qMHcdbZSf0d4-yPG9+5g@mail.gmail.com>
	(Christian Couder's message of "Sat, 22 Feb 2025 00:06:56 +0100")
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
	<CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
	<xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g>
	<CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
	<xmqqcyfbb35h.fsf@gitster.g>
	<CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
	<CAP8UFD0xsZWDnH9kLJ4eWfzq4nvAm+qMHcdbZSf0d4-yPG9+5g@mail.gmail.com>
Date: Fri, 21 Feb 2025 18:15:46 -0800
Message-ID: <xmqqldty912l.fsf@gitster.g>
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

> On Fri, Feb 21, 2025 at 9:24 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> On Fri, Feb 21, 2025 at 6:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > >>  * The "this is good enough" logic currently allows us to be within
>> > >>    0.1% of the real halfway point.  Until the candidate set becomes
>> > >>    small enough, we could loosen the criteria to allow larger, say
>> > >>    3%, slack.  This code is written but not enabled (with "0 &&").
>> >
>> > The above follows the same reasoning why we chose "division by 1024"
>> > in the first place.  The illustration patch postulates that we could
>> > be way more aggressive than 0.1% while the set is large by dividing
>> > 64, without wanting to loosen the criteria near the end of the
>> > bisection session when the remaining set is reasonably small like
>> > 1000 commits.  So we cannot rely on integer division truncating.
>>
>> The code you posted above uses 10000 as the threshold, not 1000:
>>
>> 10000 < nr && abs(diff) < nr / 64) || abs(diff) < nr / 1024)
>
> Also if "division by 1024" means within 0.1% of the real halfway
> point, then division by 64 means 0.1 * 1024 / 64 = 1.6 % not 3%.

Heh, I suck at arithmetic (but that is why I have you guys around
for correction ;-).

The current code makes sure that we do not punt with an inexact
result below nr for which nr/1024 is truncated away.  The overly
loose cutoff that uses nr/64 needs to stop kicking in way before
that happens to make sure we do not affect correctness with the
change to optimize, and that is the only reason why 10000 was
arbitrary chosen.  The threashold could have been set at 5000, or
100000.

Exact numbers do not matter as much as the real issue, i.e.,
limiting the possible damage to correctness from the change near the
end of a bisect session.

Thanks.

