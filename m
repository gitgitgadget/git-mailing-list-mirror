Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5C2DF6F4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642603; cv=none; b=maQ3Uafzay6hI96kkfhljhxbYHc9tpFwrEI49D2p1fVy/vis9CFsBl9zZOdtZqPT/hD5rdf1fY79DCdGexL8PPaXAm3CqfUeJQCf5wfOwdeFcEGd34PnpVvHgJ+8WzCg5PYPVEecM0LM5d6OL7bb8DF8pxHTMp3YhWD+SQ48xGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642603; c=relaxed/simple;
	bh=/RCzGNYlzfQCS+wprfaMfv8wVXm8cFXEE34iyhg0mCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNc3/9/dgD4d6eV3QM1YDqWEUG96t7ffmv91POUe/gEb0plnFA5fhIdVF62u+r8iv+ZCjA4Atx9cwZsNqiIfoqHYke6/dr1uu5QUQuTXdWjeYVCClrTvVni5loSwPf6HMwTBDVnkO7ORKFDa4Xvu3e8Gfvw5ZmQl4F3ARfChcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dy/4coie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpbEuC4z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dy/4coie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpbEuC4z"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 33D74EC02C4;
	Thu, 13 Aug 2026 13:36:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 13:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786642601; x=1786729001; bh=IsCqFOGguY
	D63K0R2pyyUQW9ql4Yz+kkJREpR8wY2zg=; b=Dy/4coieYDZ6RkN8yGYQF3lfxI
	OTnKIRP6l+YVMw292nM7dMFmPIB06F5Yz/kx+K6TDxHW1HpHEDCDAfXbuxswLmZ3
	cRPRCYxat2WmE3KYxYo3yLOODp4ysUceLxEHeshhA/TdwZ0iUGJ9dzOb7JIUjO0I
	Z8ukqTV/WD3hdFAz/zmdlcEHUyLh5qUY8BmQF147OEnMMc+Oz6lV2hXwNz2ji727
	i2QNeHvbG0tRNNEn26Kq3+qeWLJHbDtZH1WyCT7h7LqG9oeaoozT2am/Hu2nmydi
	8w1NkHx3Db7ohR/1Nd0Bh0AX/JO1/eeiT1n0nrilu4cxN9ZUMKUDsCLqvk3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786642601; x=1786729001; bh=IsCqFOGguYD63K0R2pyyUQW9ql4Yz+kkJRE
	pR8wY2zg=; b=SpbEuC4zza7YBFWUe4+cEICztqPUw9CKbwZMNBuFDPSit1Gyb0/
	f+qWc7bHL75LMSM5+45+4JaYZfxWtGe4xxJ7fBHu0JY2xC2ag9kakYvfHqwmQAME
	AFYlGN10/QbnW2NK7FWMRbsR6Gz0Ag4ge0yNDu5+NDgSKZkoIzKkhTqD/7ZMMzfJ
	fdJXTw0DFknaPmB7G7rxyuyLsVOBp77/+aahbXTlgvYHJU+f1pvH202kGo8py+V1
	sczF4XgHvJwRT3blx1x01uWYYJsvzDXt2TDyM6mLggY6eoh0Gsb8nSr7YN0PDl+p
	KAAUrUx5Igm2Aew3JdRlxUnTIOzt6iDc9Cw==
X-ME-Sender: <xms:qQB-am2cPN9j6XMd2mLZx2g-pCkEbq_7YZYZTfRo4BZbepRZ3tUrVw>
    <xme:qQB-agiApu0PO7fCAwf50z2nPVYMRsR5FF2dYpsB-aZxPyMVILg88TkSYhwsGYCZN
    6OW4fCLZiibC5mgqzopw8_b-0S_8wBkh4xZ6KJIhJ6Qp_4AHxaJOBM>
X-ME-Received: <xmr:qQB-asS7yfKvUUo_f6e10BD1M0noFLri4CbGnYzx1cbCD-F6V8TQxTba6gPM9Kk_rQSDdiJFsqq9ErAfJotuxF632f6XJkUmAQ>
X-ME-Proxy-Cause: dmFkZTFxjUW89Pcv1BMf8j91/TKRyGauMe9V+Z0iejEUFWnHOKLVaugMQLTXuVn+2994+Z
    ByQDuVcZwYvk34Gr050rGQtnVRFcW3CQ1sANQBi3X0WVYhSvbHmItEUyLDkAOIQX/NFeXn
    JzVL9H8lDcbk3UfbJHMdpUPl6+Brdvk8I8J5XBYx3xD/y0oi/L4ux1IvUzTTKzc5svgjta
    9A5++8m4coMr1GDSSF60a0b2HLACXJfTSM5h5TEsiswYM+xIcRdLsF3MwRyInk18ztnHFP
    V+XqhDyE4hG4l5mmVmUICkc41LXtwNRSSB3sxOEy4Hv7wVduE5uDESmhOrOrSQOPcop/Q3
    bj5eqD4wbrco/PfPfTsH5YSc4CA+bAnVi7E5AezoKQ6V2VIRlgS/p6fPtW27D6SDTNIMQ1
    ZOO/1UWj2LCdsHq0zMEuYZXaabFMyh+dUh8lOxsQBy2UI09obJhUetP2wXxjC0j2MSxy/S
    vv4Bc6rsWZQAmEHaezTapkYNgBobFc09c1M10XH8WCsbagdmFIrOU6UV5lNOGfmfK+NOv3
    quR+y4G4fvF2eQRW2NhT/XynaTERGwQELs3gnRxbNCML6aCpPqGZckvP/kJXkGYLP501aM
    Sq/Sh/HEdlMwU7o/f8UYSBxQRmHPmhRvMNoDHPL4gIr7teWDEkLPyNCANB3Q
X-ME-Proxy: <xmx:qQB-ahiOEZh7jl4QBV_qOrT91vwpH8xA2rB11smXwR1mM6efCLXOYw>
    <xmx:qQB-as6LpL2iYRL5paAih0SZ_1A2EbaoxRcFWU-4ao4Fi1oO_hEHNA>
    <xmx:qQB-auAbJCXzqw8l8NMCaPQhTXvcwn6awvI_WqH7skWJVU6R2Vca4Q>
    <xmx:qQB-ajYovqFiFIe7dATo43zNMfEABeN79CnLfQx4uO7PRRDsspwwfg>
    <xmx:qQB-agqSij4zLP9T6uwUQP1vDqudTJuiQQF7mncKFjOch8urE2D2GTbo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:36:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #05)
In-Reply-To: <an15Vvcfudlz69TM@pks.im> (Patrick Steinhardt's message of "Thu,
	13 Aug 2026 09:59:18 +0200")
References: <xmqqcxvmvda1.fsf@gitster.g> <an15Vvcfudlz69TM@pks.im>
Date: Thu, 13 Aug 2026 10:36:39 -0700
Message-ID: <xmqqv79dsz14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * tb/send-pack-no-ref-delta (2026-07-12) 4 commits
>>  - send-pack: honor `no-ref-delta` capability
>>  - pack-objects: support reuse with `--no-ref-delta`
>>  - pack-objects: introduce `--no-ref-delta`
>>  - t/helper: teach pack-deltas to list delta entries
>> 
>>  'git send-pack' has been taught to refrain from sending 'REF_DELTA'
>>  encoded packfiles when the other side asks it to.
>> 
>>  Needs review.
>>  source: <alQ7WKITYDXfiVn9@com-79390>
>
> In <an0EkMZGEbg6LERc@com-79390> we've agreed that this series can be
> evicted for now in favor of
> <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>, as Taylor
> still needs some more time to rethink the approach in there.
>
>> * tb/midx-incremental-custom-base (2026-06-12) 3 commits
>>  - midx-write: include packs above custom incremental base
>>  - midx: pass custom '--base' through incremental writes
>>  - t5334: expose shared `nth_line()` helper
>> 
>>  The 'git multi-pack-index write --incremental' command has been
>>  corrected to properly honor the '--base' option.  Previously, the
>>  custom base was ignored by the normal write path; packs from layers
>>  above the selected base were incorrectly skipped by the pack exclusion
>>  logic, and reachability closure for bitmaps was broken.
>> 
>>  Needs review.
>>  source: <cover.1781294771.git.me@ttaylorr.com>
>
> I'll try to have a look at this series later today.

Thanks.
