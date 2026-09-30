Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5135187EB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798626; cv=none; b=jbc0Hv5MCutJc1FZuiOCpTDj7KzIDO2bYOv56vKOmwIqqSSdwfjRYiV3GEzJHA1OrGn3u9ktPAUiuCgpTM2O++CLrGSUavafD6ilaRB01pHb2hYt6F91wF6xZOonsxb/1e0aDtz4hFIymposGXwEC7KacsrXT01jFxml5SNdJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798626; c=relaxed/simple;
	bh=3mXA9+UYtjawdCxCi9nhpU8UYIsFGSn8URgd0Um3g0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rj5lil0TsdFeygBeB+8wTHP9WkFXNVbEoBHdLxxOLC/azMPmGZOGOqyPTId0BSQKSy3bnqPQ6YtoRIgnBT6hqgxNEcbQgTpnZzFayAcicDGAUhYmVHepT+XOUf49/FjkVgnvDWDNUOX5QY7jUS2ygnr6ItK9WyjJ8+VvzFA8P/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RTzRkcm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijbRHKU/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RTzRkcm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijbRHKU/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E689EC00E0;
	Wed, 30 Sep 2026 16:03:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 30 Sep 2026 16:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790798624; x=1790885024; bh=3mXA9+UYtj
	awdCxCi9nhpU8UYIsFGSn8URgd0Um3g0M=; b=RTzRkcm3XlAHTe/F8pCUYfhgyA
	HkS/V8ySew9OJ6l/HHdU3zqwKM9uuZfAL3pTA7BihFtFQcG+rN1zxR8nRk/n33/L
	oagdUrRTqggMkC861OdcMJUyZVszNWqGBLJ7sZ7FCBcjj7zRwVgoCROjhY1vEkvN
	HAbqZOtFtc7ve8H4rzLqMCbk6g63Ztxuy83OCsKnOyDmoKsviPPKOwA7/PKHpUiE
	nzqLKkw/WII0n2hmqerXg2GvpsKAeW0/1ZZt0zH0ksKoqUrPdAMd+6zK494Phf1l
	LbAUpkvAY09je0ZaCC18ArvQ8i6BULPVV1Z/rHUEHyWp0XamrWc4N7rQTcOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790798624; x=1790885024; bh=3mXA9+UYtjawdCxCi9nhpU8UYIsFGSn8URg
	d0Um3g0M=; b=ijbRHKU/PGIqgl8Moh3bqRS2uOX+6m8ripqjRtwljtiMKfCrWVb
	toDPFeSxlqWNY1qxCM2dX+DBdYXNBdcPp79z2inHdRoqjuRQ0SE3nA/ef0PU6TAT
	x0FIIlWhzEqSNa9NYncW65auRiTO2DKrIzBr5LVKTFFj+5tGuOSoa3B9ts87VveC
	1XOSN5YcDY28/+pIB9lyOfjfoEott8NQ6KfAzgFZ8QepSsNAsKeghZ6oV4MOXQ8t
	Ej2VXPSeQJTjrgVHG+8bCU5aXMWlPYTMoFDtGbXC6s0ZU8Ve4OGjHRDuAaJVtw1A
	PQrfjyqLUXx0bDO5QF02/SnpnEsa/i9lnSQ==
X-ME-Sender: <xms:IGu9aoROWXl1Y9EqnVz65AmGvriZNvVe76xEvT6lgkVYbG1gto2rNQ>
    <xme:IGu9aszGbyQvYJ3Z-IO7LMfI88eY__E4q-ag0h2hxuHcP5bLnAJdsRqIvpetMbkwZ
    _fPPyRG4yBTTcPwB0ryM7FDuSMg8-VzeclPxXI-K_y9NVfc_VSddA>
X-ME-Received: <xmr:IGu9aq36LIqqARb4fuF5CE8jyOcREXbjTksKXtu9LPVQkUoKgHLtXJif5ybAVVEKrWOcraezCMOFj6U87XF7HPth1tTMYpyYIqFB>
X-ME-Proxy-Cause: dmFkZTFpCX9NNHU6aKPH+80M//hUswTjlQeXIxc5iNR9k7WAoZXLB2YNMEiSA3pd4L4ilB
    STUAYvwKX+PtfUeYQypMO3DDnlaJmc/Nqz2rGsbGkWYFCzAnK2AEo8S0EBHXstbECW3LIF
    p2MriiYn/hV2mt+3fYqeqjLvgjOqJecIlZa/Vlrd886En2oKF3d57f/4ym6Ga2pUjPlxHD
    0RUBZmIeNvPv7a8oPyHR1kFls1hxXb+d9u2lk/hhoZeKD7+ihG6Gu7rr9dY8eAVnnJvw+Q
    bFm8XWd0ljJ1gXWKq09wVLBUY7/yeA3QFcJOXexB+uX8DSLq4EfsaLJqyM5HzCTFXuylpM
    M5E8LkDDKDKfifJelBOjOcLaX94l3MUwidsq3c2zFqCYOaaeALtySh8g6UcRSAMIt0zu9J
    yaWFsA41cHQMvKCSdI+KRKxhbdza0nZDLQ86WiIWWduKdQwiQqiPx2Jg+jzMqwraRH78tc
    iEN3hgJdmvXwjxVIhUw9ACOAPcK6/9M7tmbn1UdozDZcB8SNeq1QOHskDwGM/3gF5mKikE
    WQJ5egm9vo9rDzWlfdl7miXtI6hK4184NnpOWleV2WqNeYa8rQBj/PHiKAL0P3PRRqd4vX
    F8Ye0ZkO0wzlAljfIrX4/XX1sOVGDmbyFCk88MwBy8XsexKUDf1U8gpgR6Vg
X-ME-Proxy: <xmx:IGu9aq43-jQBqwcnDxAXGNcy5qBT-cYWVsbAnP7eeL5iuOKK_fZOig>
    <xmx:IGu9atU-OUKtyiN4hKn7T5I975mKGQQrc-TiAid9ugRvgLWgrGZCQA>
    <xmx:IGu9apBsxZF7aToc4h9vONPjDQIgg6g6PkSjAKWv8oX85IezoRUdxg>
    <xmx:IGu9as6sQ-0GVXiwFPY2_ur4u0BJ7Lzy2lF5JuhTlVP8wjV6fePbuA>
    <xmx:IGu9aiVbBqCIeaGDltfJvnRaJn7r5yVmJGrQxLZsyZAJibHVpmm8mO8f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 16:03:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Add --dry-run option to git-backfill(1)
In-Reply-To: <ed1b9048-d438-4143-a224-fa0e28d4fd42@gmail.com> (Derrick
	Stolee's message of "Wed, 30 Sep 2026 14:14:46 -0400")
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
	<ed1b9048-d438-4143-a224-fa0e28d4fd42@gmail.com>
Date: Wed, 30 Sep 2026 13:03:42 -0700
Message-ID: <xmqqwls28q1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> This is a helpful capability, but I'm not sure the size check counts
> as a "dry run" because it involves a network call (and possibly many
> depending on --min-batch-size).
> ...
> I'm not sure that we want to add a feature based on speculation. Git
> is a collection of "itches" that the contributors needed scratched.
> The work is motivated by real needs.
> ...
> I don't think the uncompressed size is a useful metric here, as it is
> likely astronomically larger than what will be downloaded. How will
> this help a user make a decision?

I agree with you on all counts.
