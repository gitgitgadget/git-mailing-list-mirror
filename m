Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE03E5A0A
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538496; cv=none; b=RgGZEeuqb+Njk1W1LwlhuUq3vw+1TfBsqMj6lbBuPMjtw8rLzMm1wV2BqHzgdsiADK9Y1jdEQNq7Q7iB/5NGaBOxO1OsS6GeA+HUivSHfXOglCVEyjf/awnBp8EBanpzTHcWaAn1SZOvjGbaKF+xNXEbDFkAKAVNMhB4Tka7nUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538496; c=relaxed/simple;
	bh=asU6squaP9/YiquZvJnZQPWO1rtvYbowQQgvujg94Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kb+wlaLnEHw3gJOdNW0qKGIRM7cJnIo6bYR5PnbwxIslZPZq1Hmdh9sMAwF8uuRCKqzvUfxPmhD3AEEccKxo1p8kXWQguOfCZ2uQCllI8p1IvG9fdYSI0Xx6w0YQ6O3XauICc5qNilygaUrQKAcdGnSUP9ikqiwt9g5NPP4zO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QNtwayky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHLx1xGl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNtwayky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHLx1xGl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 67AA6EC01CD;
	Fri,  4 Sep 2026 12:14:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 12:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788538493; x=1788624893; bh=fuqPFe91J1
	fFhKwge0WIIf67AjLUc1YsUcv2ULCMWvQ=; b=QNtwaykyM4ZQBXXEMMF9vqndUe
	Bl5uQDQ78oxmu3kcgBe3N8JfDqgvZHu2eIq8ZnblkklKqgJJdecnJlmjbpej7VUe
	I31axbtvNsZ7RG7eE45fMiFlozdHHU3cbtR1tiGOa83fuact2bDLiS79d4Ssn1BZ
	fmu5MuJFbwT+Zk+UymbAqWHXhGsPnayQ7xx6cK2oUrNPYHe6zg50yEJPPy7w1A1l
	HFdSZmywnLuTRJSGFJyoRq0T7lussAXEIKMFw6Ci0OusDe4PN/z7nRgsdPeWjNFN
	ZpWWXSdin23pje7zfEyMy5vfaSp9d0fEvktE7yZwjvYV5xxaKuOMEtv2oKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788538493; x=1788624893; bh=fuqPFe91J1fFhKwge0WIIf67AjLUc1YsUcv
	2ULCMWvQ=; b=DHLx1xGlvo5T6Pd3Km49WGTCAyEOh/tX5w53ZJcf683XyiqUV3Z
	oLjER8wi/T3GevPNh/g57j8dfOflIzUnG7JLaDrg7qvMkA8v14M8P+83L1/wwp83
	pmzIUMMx/dxWu487QrnoVu0jkeVj4Qaiu18HlqMg7soEc8IxXGbkP+Q4AsW8mNde
	AmhmVlBmVe4U/5rzRhT8rjRcKLFj8iGYyLHUsfLw0dbDlH0uT35JkouH0uJ504aO
	qWGKLI1Z5ac7+2q6yTbAPMBAlnole2vRPDqq3paB0+U4Tlb3z4BP0Fmg3xFseq91
	UHjnJVmp9rgvp8HiSU/6Fu3LgNXQDM4ysvA==
X-ME-Sender: <xms:fO6aaro2gJYLdS1Kn2uqmqwdNbnu2pMuCAqFpB3-qw2M8iVggCdWkQ>
    <xme:fO6aau_YJ-nV0GamtjxtU8VGzmKS1leigMiFyOPLSxlGqrQEa4tmHb3niPqleX1uR
    I62E1Q6Xgf9bborcFAPSdUqFDw6VcLNGF363PLn8c-aldjM5kcTNK1G>
X-ME-Received: <xmr:fO6aavfmp7cNH-4eBmfd4m-U_WTd_iKlNbbPlGS6QPGcL-pNEgEQF-668abou4f9eoVSkimNmVAe6zlkOkfvrPoHpq-secpR6g>
X-ME-Proxy-Cause: dmFkZTFV9YFOzgumuwRcswUNdhMUqc7+Q4Bev/DsZhC6j4Ixy3qISXU8LqWfBSZYgrnGdb
    3R56nbO5mEilUg5Wr7yAiEI4owZ1K5eFalWKEg2lq8aloLp+lj6nGH70E9C+Fj1C3WLPbW
    7rxGjnTupgxEsRGemmHf5tHM1Sr8kh7kzFatuLpfkG9Z7+1sbiyfwzXYe8OkxR8VPShWIt
    AFVtM5AyhjjwOshI8UukergYOyuqIY/V0jViZSGF2xjaH1W44IPqPo2RKOe6RnWD1GjJD3
    1L9qUpzSYiFCUn1WkIYOkmsKMdKzkkqDNheYlk9GTxvZ/evLg3T81BBYS7xsyhQ0Rr5zrp
    mWi4HlGO3/+Pfojokb7ei/QuwmbtxZsobwNWB1ztDwcm0j8qPK+pqmUPYzqUuEZHYwhQ9z
    E5zQXo5S6Pwy0YSadlMH+AU4NQB/tAmZrcgzuZrq8YT0W5nc6rQa8W+1Kar0rovuP9gRQJ
    V8ngFXjmhX+kiBjFcpzI5DkVliouG1EEByf+zF6wVHVBKREGJ22KavCexFqtvGnPYKXWjW
    +vO3eo1vbwgJHUOSXr4/az1ffMK6Chzkx9BPFqRM4A9UaUEmKbnhPgVBm0aYwzbxezqzie
    TBIdrZAksvFuRbikVrKDrnGMN0VVKiiKCtl0q9YzK9F+hbWaHGhNpgF2qggA
X-ME-Proxy: <xmx:fO6aagJg47hh-9i9tIHEjlqYrxhL5RdCmksH428s8tY-VgeqMm9-kA>
    <xmx:fO6aangj8kwN9mcVTETHFay5ia7LuTWoUjHpFtSgR2m8lptJ3Aa3pw>
    <xmx:fO6aamTuZBCCBYRzDgLDSWuTYnBAlzwJTT5i0q8Vg0TC8R_1UxzowQ>
    <xmx:fO6aapU0mxBGX3rDX4jTqcI19-YtjBIPyWHv_oHVh_EZtLOAK78FPA>
    <xmx:fe6aallVxThULwwnm-gE0L3-pMCBVymfY-jQ7ZCDYBPew2ncutlnpoqU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 12:14:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Thomas Bachem <mail@thomasbachem.com>,  Derrick
 Stolee <stolee@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for
 "rerere gc"
In-Reply-To: <xmqqfqzp6pir.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	04 Sep 2026 07:48:44 -0700")
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
	<20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
	<xmqqfqzp6pir.fsf@gitster.g>
Date: Fri, 04 Sep 2026 09:14:50 -0700
Message-ID: <xmqqld9h56yt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> as reported and discussed in [1]. Thanks!
>
> Can you, and everybody else, refrain from forcing all readers to
> visit a different message to understand what it is?  It does not
> help that [1] is a full description of both problem and solution
> that is not designed to be a summary to begin with, and to add
> insult to injury, it is AI slop wall of text that mistakenly thinks
> that more is better.
>
> Perhaps you could have distilled the essense down to several lines?
>
>     Since Git 2.54, background maintenance triggers after a commit
>     runs "git rerere gc", which acquires the MERGE_RR.lock.  During
>     rebase, a subsequent sequencer commit also tries to acquire this
>     lock within milliseconds.  Due to use of LOCK_DIE_ON_ERROR,
>     whichever arrives second aborts, causing rebase failures.
>
> I'll leave it as an exercise to readers to summarize the solution
> part that this series (not the original one) proposes to make.

Hmph.

So the two-patch series is not about what happens when two "rerere
gc" trigger in quick successions, and even with the "improve"d
heuristic, the second "rerere gc" would fail the same way when when
another one is already running?
