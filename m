Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AA3446C5
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627709; cv=none; b=QkYhLm3Pe5OkwR8JkLl34V9Ad52hFGU+1JhVVKgAnrMU9ErgAEGnO1Gre84a5w8jH0VRUB0RBBYICioRFXV45G4pOCabkoWeG8g3FDinbv5vzmy7gp8UZJe7Jg+CwAPE/jp6oQ+zVbnuuIlHg0+lZKoLNapuFCbVejtLNDaAz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627709; c=relaxed/simple;
	bh=um1yXxYLt+60ZkJhrTeUYSgjKXz+WA1VL73CtCdN3NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1JgJg9tl9tikIyp65YVid8wFu7Q642gF28HcZA9zT75H14zgpZ973ddc8BeHlm/PB+Lu1+5x1/LVi/fMPQmqBVwytTho1gdelX2b/V/nZe+oDe1EbypA1Gk13KXAJlDH+AXkSFPO0Nwadv3yBuqUzJhTUvHPWe4/DnVEoxIdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R7uJjxj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjNAQfqZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7uJjxj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjNAQfqZ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E24FD1D00140;
	Fri, 27 Mar 2026 12:08:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 27 Mar 2026 12:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774627705; x=1774714105; bh=IkjJ+oXGA1
	q75Ck/brGS2Ng6EzHF7M8cBgbcpJ2FIMk=; b=R7uJjxj5XcTlqoKaEHyQuHI5zL
	KGgWHMhpRPb4MElOSpX4LkBS8UkMEGc13fnUl9WDmyMocq0BmxbwFY1tP1OtAIo8
	ftWEnEU1i9Wkv5J4/6RM8Lj+kivBFQeAoXXR3hXn8uuZxdVAElh7kJGdjg5hnVm3
	q1RVhR7M5RGHxuT9bjbFrbqvaOeZDW5SIM/n5RMomeD1tgs5clgaInt+xykZJW8h
	iTGUT537dUi6UyJfK7P5BH/Mrx1eL38B/tB/nuVZO8ID5u1IO1kcSvBZ8Jc/9RUA
	M2tTSF9h+UMXliAgcXChDESzjQeCDBNIf+8C79CjyYmmDd5TN6V8IN1QK4VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774627705; x=1774714105; bh=IkjJ+oXGA1q75Ck/brGS2Ng6EzHF7M8cBgb
	cpJ2FIMk=; b=AjNAQfqZ4E3vOhNLkYE0KpUZrO+Zz/ZWEp/XZ2OC7A77kGd/YSK
	uzyB/FbsiDR2weXrBCPOSAHmTeyMZTYET+eb9UBpyZ7KWVNhApVhMG1lDkdPhr8h
	dQx9l+GU75bq/+++XsVDEtbWScF2/vL8lk2ip+616K4A0AhZ6d81ET50c0JcmXoA
	Z+d0wov6xZxNW9tPPpyteXsuG97vq9nJLvCNEmQmxDXF43stNSZXtUbqGSYH4pfG
	VnLslO/ndjlwhC7//hNRWpf7TtfVsfeMgAFkyabr/oDQgbhCVR+/h+eove5nPOxn
	pE7j6r6EjEA3dtVc22E1H8W4RrT2vtammmA==
X-ME-Sender: <xms:eavGaWrbQZS28MljhEU33Xo9Ktwh12eJ91SvNFPFjotg1RXv5G2CyQ>
    <xme:eavGacGftS79f32ecW06EKePfg-yrnGbS9YTac2Fet4-LUan5MNHnkc0mn0iiAytO
    obH3LOfRoTXUR9n6m1TvWEGGkdtiUEPUCD8PFu8eFcCz02WGA7z5w>
X-ME-Received: <xmr:eavGaYlzRukLjxkaUGLfmfGDkeW4iAbmupaj1greXf61J2UmixvkN7j1RHKUIOFpieLQu3N_sDDsuR5CqLt6gp2Xz3ONITSsHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieejteetgfdtkeekfeefvdeggedtuefhveeiueehjeeugfdvfeeugfehgeev
    keejnecuffhomhgrihhnpegrnhihfigrhidrrghrpdhthhgrnhhkshdrrghrnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eavGafnK4tcDxK_OaOp06H_jr260DikSk2h8ty-l1_jg5MoLM5TNnw>
    <xmx:eavGaZud2SM2wmRGGOrzLb87l3XUwfnDhyoo4qJytz62BrKC6BkUVg>
    <xmx:eavGaSnetoa0MvPWEACZMHzfVzSlcmTumSz-4DpNpTNECV2i1WTYUA>
    <xmx:eavGaUt3FHF296Jjw529cxcSAFEJ6xKDwhWRhrKwbrm-MTg09PmMRg>
    <xmx:eavGaUMC6Y2Mx4PiPTZQpmLkw1qTMErxlX186ym-IsrjgMbZLaUzH8pc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:08:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #11)
In-Reply-To: <acYzVsWrDxzzQFGy@pks.im> (Patrick Steinhardt's message of "Fri,
	27 Mar 2026 08:35:56 +0100")
References: <xmqq4im2npv2.fsf@gitster.g> <acYzVsWrDxzzQFGy@pks.im>
Date: Fri, 27 Mar 2026 09:08:23 -0700
Message-ID: <xmqqh5q1mf0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/commit-graph-overflow-fix (2026-03-23) 1 commit
>>  - commit-graph: fix writing generations with dates exceeding 34 bits
>> ...
>>  Waiting for review response.
>>  cf. <xmqq1ph92pzs.fsf@gitster.g>
>>  source: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
>
> Hm, I think this status is probably stale, as I've sent out that
> response already

Indeed.  I am not convinced by the argument "64-bit compilers would
not care if 32-bit part of the live code that it will optimize away
is not -Werror clean", but we can merge it as-is and then deal with
any fallout later, as it should be trivial to switch to conditional
compilation (the triviality is why I suggested making the change now
in the first place anyway).

>> * ar/config-hook-cleanups (2026-03-25) 13 commits
>> ...
>>  Code clean-up around the recent "hooks defined in config" topic.
>> 
>>  Will merge to 'next'?
>>  source: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
>
> I'll have a look at v3 of this series series today.

Thanks.

>> * ar/parallel-hooks (2026-03-26) 13 commits
>> ...
>
> Likewise, will try to find the time to do this today.

Thanks.
