Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E0388E53
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178499; cv=none; b=p2UqfJ3IrreBilbkWvnfnvGmWTyp1S7lXWn9h+aF6NZKvqJSL96uB4RFc5WkAQVIjHBCIpWgCBO7wGQjlEf86l1nPYCYL5/upwfRoU7Mu61XZ8EJC6xcwnGAU3izIBTO9vRS7Hhsx+XoQ6MjtpetCuEKR0j87o5FX25DDvBGy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178499; c=relaxed/simple;
	bh=4O60WcHsgdgUthXaU4XxjyW8QEwKOwfEDVY+rHhEtIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKsV7QawKvUJzNe8FMfhQwxGzJIxUwPJQ0u3A4xc2DLBTB4pGTr9pftPw4UYQsHaaE8hFwQ/OMmuL2bZg5wgqe9PK0nFVUTXowCKL0KvG2hJNIpXWVs39iHbkoSeYBFhS+9EvvGVkrnWGwsilD6PcqBFoZW0JHDSsV51nod3U/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HOvRjCFG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbB3VjkC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOvRjCFG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbB3VjkC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 58C691D0008A;
	Tue, 19 May 2026 04:14:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 04:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779178496; x=1779264896; bh=l/VVxfQE1m
	SFypav5WMPwXhdYh58W91oTOmKfMTqd4E=; b=HOvRjCFGymoc00gvy6wuVYm6HH
	BZkvDphLuzO3sF6EYov2mrMQFYXr+sE+74CaddErZOSLNZaYUKOKdK+QpXLgeEzE
	8HeOb0jM/jd9oPfuciyvqy+6FQQnYiqA6aTNlAM1UIz4h7XFSNC2AgtWZxvO/b0U
	FDRcJlBxSwQpIkcEc8/JQOfgBxcaTYappPJ2aNgUekgeEOAw3wenInw9TKfgx5ZP
	21Nbxoh16XUX+l1AhczUvxQeZkWe+1c1MOpZmLV8kQLdYZhSvk7EjbS8pPxw5p0F
	cttMfKpxPRPD1aG8dN40R4iSTOaTt2EvUEixydK+7H1YRG/izBdNMfPh2sJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779178496; x=1779264896; bh=l/VVxfQE1mSFypav5WMPwXhdYh58W91oTOm
	KfMTqd4E=; b=TbB3VjkCe2SxG2RfhZn+/Qjs0mf86Zd4TdWkqtX/jn4YYYk+7iE
	ahJH7xqO97HMP7LOdIma/ASdxbiHwajY3MqSDpjskZtP8kieSymumvvoVfR0XsUn
	eVIB59SVo7xHvOryaWkdKjFQvsJ3Zbz37Gn62b4qXmkLu+ZlXTvNRBtXJ9dABbOa
	P/UbHOzM8W/rPOGNFOZsFi5yccqQlbmBVrCazDAFYanG95LaifPGSvUTis4i+8xY
	Se51jb4TLzl0+/lSIUobBe86Jx/fdSNSOXXkeoFTPG5v4Jugl7yHToeLsXz7p2u9
	esNZ4xWRymSoCGkLN7eIYG8URWoKTYttTUw==
X-ME-Sender: <xms:_xsMaiPzAV0mI6AowoGFWAAAGM10G1J7-SI1Y4IaXoDPUhorixaY9w>
    <xme:_xsMan3etvOkXro_E53aNlqpNehTrk29bABLozZnidlMxrKqWFi_Rb3yfwk_CYdz5
    rxDOmIInz0zaTdTCQRv6D976wYwGSgv5M4VWr5FCfVowV2np0nGiw>
X-ME-Received: <xmr:_xsMahmcDzXreF_VA3UGeuHH5ywhi5OVaP_0cRfXHiN-i7XhFhIYFZlbHesudz7HU6TuI_u13hCg2aQTHGRcct93sPUrRTFBCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvmh
    hikhhlohhssegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_xsMauUWkbjXlJrncExHbE8YzTsO9jalnnhxtFXAbOAKhoqCHRbAaA>
    <xmx:_xsMans6itY4M3Gfwax8XUsLq1Si6opUdqcit1AR6fKeQKHzkPo9RA>
    <xmx:_xsMahbCxSDE-FGFrwKao7ZZiG2QiV4EkDva69Kl8T_tPWp14y97hg>
    <xmx:_xsMamWvFPernrIndwHig1GukNrAUUmj4ueXMtQunflUEE5LpnY4uw>
    <xmx:ABwMagejurYXllO9Cxd817wXwjuZPwgxZpulWgGq9c3IufLpsNgCh4a3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 04:14:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] log: let --follow follow renames in merge commits
In-Reply-To: <xmqqo6ib7vlp.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	19 May 2026 15:37:54 +0900")
References: <agLU58gbG1y7KLz-@collabora.com> <agwAkHzjrJQPVtCS@collabora.com>
	<xmqqo6ib7vlp.fsf@gitster.g>
Date: Tue, 19 May 2026 17:14:54 +0900
Message-ID: <xmqqjysz7r41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>> Could you please review this?
>>
>> I'm a bit confused regarding what can be a next step here. I
>> understanding you were away for 3 weeks, so there is a lot to process.
>> :-) Should I just wait more or should I resend this?
>
> Rather, ask other reviewers; when I do not comment on a patch, I
> often am not interested, or too busy and the change does not look
> interesting enough to me to make me drop what I am doing.

Addendum.  As I said in

    https://lore.kernel.org/git/xmqqqzni967o.fsf@gitster.g/

and the subsequent discussion concluded, the "==follow" checkbox
feature is meant to work well only in a linear history, and that is
inherent to the way it "follows" the single path.

It does not follow different pathname(s) while following a set of
different histories merged, e.g., in a history like this (as usual
time flows from left to right)

    ----o----A----o
                   \
                    M----o----o----o
                   /
    ----x----B----x

you may start following path F at the HEAD, and after crossing the
merge M, one history may find out that path F came from path G.
The traveral starts with "F" as the sole element in the pathspec,
but once the traversal hits that commit (say, A), the traversal
switches to use "G" as the sole element in the pathspec and follows
the history down.  Even if the other history (i.e., 'x' on the lower
history) had path F all along, once the pathspec is swapped to
follow "G" on the upper lineage of the history, traversal of the
lower lineage that happens after the traversal passes 'A" _will_ try
to follow "G" that may not exist at all.  Or 'x' may have done the
same rename from "G" to "F" at "B".  Depending on the order in which
"A" and any of these commits on the lower history are visited, the
commit that is a child of "B" (which has the path at "F") may be
visited after "A", in which case the path in question "F" will not
be looked for in it.

A minor "tweak" that does not solve this inherent design issue does
not interest me, so...
