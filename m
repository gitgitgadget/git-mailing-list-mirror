Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5C399374
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697071; cv=none; b=KeY+gyXK+QyaQ46Q2TvHArYaRo9fKKvqiGkfAfDbdwGEGhndWGpL5dCGzrFEnOZ46xAxiKExo378YrUNd5SimZDGoLQNw7RRpUO0Dt0wOMOa2dnkOXsYzQaU6agPbf6BDV4gOKU7ilDpeqJvLRkWrvc2d88lWVh+MsJo3CTLNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697071; c=relaxed/simple;
	bh=Ao0ev9QnGYo0ykF95atvgENQzjTTZRubXYr5m4r2Rp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfzFBjgA17OCiuTpIijMiYLJ6cstDDmyXNHIHQHe5Bm8flg/JhxfwvONdYO9b8m7Sl89cfzwxvm94L4MdxPpXyaV7lv58upSRhuM0bGreZfsRZiP60FIolTXos8Vqzlnzl4Hyd4OJZPM+7sT7UaMyhEzl/l0BeKpect0IagD2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nkjlyIpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShLk3EWE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkjlyIpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShLk3EWE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C9C0A1D00135;
	Wed, 17 Jun 2026 07:51:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 07:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781697068; x=1781783468; bh=8adSPz2aEq
	Ws2V+mUFigAVdESSbkzrMG2eE9xJbdhTo=; b=nkjlyIpNWbpzsBi7K2YvhcLNeb
	/VSQD0CApHH5mdX4kNE12VShleCXENkh0t9lSNqicqtUlftSStj5Mpyd67t8slzE
	dMDOxLzO6345/JudOD0uQiOt9E8mJLVMdVvtOiVvIU3yLKr7rQhNfILDFLLqBGgp
	nwbbxvN/NNsivcB130X6MF1MkBR36BpfP/pPQrJhU4s735XVFn9B/P9hRVW1qo1l
	YZLuD7eWW7dm7O8HXRai5M7sDn32DG7+uchpmfXLTPvNrKY6B0xbIyPNHujbFO02
	QbyONFTvtmMigRoAWcR3jE9cf2j84plugoMK6y5KGrnBwEi7p6U6ruzNNNgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781697068; x=1781783468; bh=8adSPz2aEqWs2V+mUFigAVdESSbkzrMG2eE
	9xJbdhTo=; b=ShLk3EWEVdeWjK9P3S6h6kWbdxeJM5qFwZ2AG0PYg152YS7xxRT
	hy4gpm8inedoBPj9PM509nVmqZoIWj0JuApOV5IEgWub7T6EPf2U+1IgnT01lbYJ
	cAhlUlUOVBsZeD4vk78l1GmJzYuu3dC8mNESoknsNUaz4tMVBmIpy9cVeOme0I8G
	Sc1nOlmV276Vu1cuqnOIwRCp4T+YM9fQdjifbyfhpoNNreYxeeKsEauE2yLHhbsP
	NtJhMHgMsknRYGdBGo4i+1jKO2vfYtpSl68OAYvT6vLQlrOyUZicVJjytcC5FUc9
	fGV+4TPchsoYwv/xCyOSesSENxG1IyJviYw==
X-ME-Sender: <xms:LIoyajWzGsOR7P-IuqTEiSWmuLZ8W6pWXQ3EjdvqCclZanywTcIY-A>
    <xme:LIoyaifSaFV8iZ-iYH4WU8G9vnGMFvkMUp_t0BSGg1rUgp8vsxePoulgYh3qpUD5M
    WSzWstT_USnZt_0E58Zx3NmquCseK4LCK1ohmcX0BW0LMhC_xFFng>
X-ME-Received: <xmr:LIoyansXd7smWgPXrwxx6349-pP_J7En2hdBdS8JdOUhOUN4RNHiA97NxRpyqMJxT_1XVO3H_R9n5OM55Q6VL_la3zo82xiJOPxg>
X-ME-Proxy-Cause: dmFkZTFB/fFbrb4SRL6U0vbzzjRGhBdEvPVuL5n0B6JwXlPA9RwaR5kKJH5RDriLu6gRSv
    ElyUOFsQanAGp/PlCzhiPZt7LBwZ8s8oAy1rZ2oda9dSIy023m+aomQERsARBVRqxAKBe5
    pka6f4OxNyPEjzWtXEhWQz+kGzJQRmf6NRuiDK2U07sEwutYjJkehON2e2J9HZZqLT04TO
    JnFtEal5bCRIwntHErlAxTnSyqwDf9eJjhythqmqNW9pTp5stm+7Nxq7NLma5IrQbjYy19
    4mcKMTavrZEf4om0DzpHuuujgtVT95HELW2tPYVFzzeYemNhB7M/GuZSfkXTMrVLSfe3tM
    ugMShBP05h7YBp5SnMQ/iQLkaj34K0tYcKxvfW1SJ494j2I7VRBti2mWy3RDJl0mY7bYQv
    59RTifK4ncUPTISGjywNS73EFtrAiCZYxxTQKAB/lCgvOv5u/ManJLsQoiFlXVUqz+Gm3u
    +weySoO0yjoveWgnnMp1FTt7SbigS2/1VJ2k36J6DSr3HDT27jc+oMC+eoQ4iKJ25rSg4K
    7WwySBSkOLUxieqV5JHHycfdn8dBDBNsxd+AZvS3cxH+O5VGg4QpYcNcYcWNq8i1Za+KnE
    ugGrCnT65aVlC68MMGsziHyJZL14bOdVPGUTyI7VEnNaRcV+HHo+VBAtoWFQ
X-ME-Proxy: <xmx:LIoyap-r0qW7DHpFwmp-Gz_-3UeMeejvXDylgcwnlPX9aEtteChMgw>
    <xmx:LIoyaq2pjS5JgtnQzSAXeSe8WRmGao_MxNxuJztzESjjqI0U1I2XeA>
    <xmx:LIoyamAGO46PYMBb3aP06pTU-Wz7WxGhxCX6lsipjzmIe6VpiAeBGQ>
    <xmx:LIoyauc-lQ1PGnNJQj_JdjMn2cOPzytMQHYQOWAb_9MUKkjOT6xzPg>
    <xmx:LIoyasGkTkHLzD0WTujjwV-kigeTQzC1LVxo3kD6BEkcKsPABTmoRKds>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 07:51:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org,  Bence Ferdinandy <bence@ferdinandy.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] Introduce fetch.followRemoteHEAD config variable
In-Reply-To: <xmqqh5n213bw.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	16 Jun 2026 16:18:59 -0700")
References: <20260612055947.1499497-1-m@lfurio.us>
	<20260616222606.1003521-1-m@lfurio.us> <xmqqh5n213bw.fsf@gitster.g>
Date: Wed, 17 Jun 2026 04:51:06 -0700
Message-ID: <xmqqcxxp1j2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> ... to some "unspecified" or "default" value?  What does the existing
> parser routine for remote.*.followremotehead do?
>
> Ideally,
>
>  (1) If the "fetch" operation ends up with not needing to consult
>      the value of fetch.followRemoteHEAD at all (e.g., it is a
>      one-shot fetch that updates no remote-tracking hierarchy, or it
>      has a more specific per-remote setting that this variable is
>      meant to serve as a mere fallback), any bogus or unknown value
>      will not get any warning.
>
>  (2) If fetch.followRemoteHEAD ends up being _used_, and if it has
>      an unknown value, we should at least warn "we do not understand
>      what you wrote, 'awlays', and we ignore it", or die "we do not
>      understand 'reset', perhaps it is from a future version of Git?".
>
> I do not think customization based on git_config() callback like the
> above can easily implement such an ideal semantics.
>
> And I suspect that the existing per-remote configuration that this
> variable is meant to serve as a fallback definition would not work
> in such an ideal way (i.e., even if we are doing one-shot fetch that
> does not touch any remote-tracking hierarchies, "git fetch" may warn
> if the value is not understood, and when we do need the value, the
> code would only warn and does not die), ...

Having said all that, I do not think it is a blocker for this series
that it does not take us into the more ideal direction and still
makes a syntax check on a value that will not be used and complains
to the user.  We may want an in-code NEEDSWORK comment to hint
future developers that they may want to revamp both of the code
paths for fetch.followRemoteHEAD and remote.*.followremotehead not
to complain when the values are unneeded and die when the unrecognized
value is needed to continue, though.

Other than that, this looks excellent.  Thanks.
