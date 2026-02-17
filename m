Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB0372B44
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352852; cv=none; b=uNMANoKzA0TrGMors/Z5P72yg7rriZ+rzYe0jIOhUQBhNXfZkAhosWwEIIpAYYGHz/gHci6W910Cv61IaHX7+jNR1uxZkIjUIJVKYHdhGYXzqxK48Vd4XQ58hlRKDHj/vFBKZDMF5bGKM6ME2m1pEZ2bL39NiVxrorV/a0q3F1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352852; c=relaxed/simple;
	bh=ozDh8MILvCGVhXq0K8IFxA3s1sv/qzX9YDat5gI2Sic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LemZAQ6ndLfhRNnrWYssTcRVHBD9ovax6OH6R5/ctZbE9JT/GA064SrF/7mPppureOIRCXh49pfCovH5R63QUvi6JJyecpACCobVumOUeMzxWTUXAa5B0Mv8/xS7zx2ef/H0FDwwU5BQdiyVDWeOUDVQlpYDIVpF4FylXJmZi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BRHqYHUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUxkKiEq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRHqYHUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUxkKiEq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 60EBE1D0012B;
	Tue, 17 Feb 2026 13:27:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 17 Feb 2026 13:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771352850;
	 x=1771439250; bh=ozDh8MILvCGVhXq0K8IFxA3s1sv/qzX9YDat5gI2Sic=; b=
	BRHqYHUknWSfHKpkoFsqxTK63t2eB2CV3m/yUmVdyQA/ahYT3kMpU1h9r0h5eCBu
	LCQMswufjz/25rCsC3UuA1Q+w8YTvx+4nuLFn2pMfXLcYM2DPLetjPXU5YLy7jxD
	fG1rlMhKxqtN/vhapniVRN2HiyzGCq/2Iv6PUGzV+TdO7ovC01nR+rvYiQXKGpNn
	rUo5W59ll8d30R1EIToGabotor4L4KFWF82jAQK0rjkj+rjxjUgfFSvOpIhBfk1O
	6/AXVgBnGc5V4PhMyl0RlnYh/FSKZkeHMPp7tXUc5OGk/fTBEytf+d5XKYeoMrVr
	7nvjIDT3q1SLrD6CrQKxWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771352850; x=
	1771439250; bh=ozDh8MILvCGVhXq0K8IFxA3s1sv/qzX9YDat5gI2Sic=; b=Q
	UxkKiEq8WUIHMBo0V8XJQmXA38R7vpfngadh/Q2JbsYt3pzPydfa9bcNjE4cCzy7
	tLKO0TnDiNdhHCQ9Rvtd8gNjqBELwCTxgMbHXFUHeYJf7BKySriwoqwG72c99Td9
	He7g/cuwgQ2BySqw1KE5/VnSlUj88speE824Py/88WYJ+oLHKZ1RT0NDS7d+Q3YF
	kyhI47l0mKlgqcjsHJls/3htAW11SFELYkHDzjZSPT/HiicK3jonuAVFsz+RLXqo
	Eym7IIx51yJIlqAGL0Sgt4FwDUypeKR+rQplqFR8i9oYEBJP3tapiRyUC4SvIXBx
	0/gzrEq7saiB6SpqxOPBg==
X-ME-Sender: <xms:ErOUaX1X4Kb0dLp2VQx51tzj-zVmqC3YnAAvQLt2_Xrta_B2wGE0yA>
    <xme:ErOUadFOigxuFT3vUQ4Xgd1j2tW6VTxIjQv7cakanFCUHXbPHJr64RcUMww7s2Dii
    0eJBiYzQjKvvj_ASlA6ZrmDD18fOPmFxYDigC7AQQReiAR_EsMneQ>
X-ME-Received: <xmr:ErOUac5iSe5OcRzEwRVPAllg_BxC9B01uqDoEoZynQi8hpmdeq12JUSGWuXA3Y4pkHIsLIDJFdX6gg8koK4DBBjQdNnML5GrQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudelje
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ErOUabszDPfsCxshu_kPlULkHKZ3c0lr97yFMcDhWhSDiLnxTuVXaA>
    <xmx:ErOUaV4-Ua6ZBNnIg4ZMFCc6Pwy_NW9PK5KZs_9PY9QpPes2b3eaDg>
    <xmx:ErOUaeVP3ocSYh9m5RkOsyNB3SgtrrfPqG2wAISx9IiEnJon522LZg>
    <xmx:ErOUaf_VdloO9vOYfDpVwPmCCOexSJTH-jL46JYVyveFAIlAcfajow>
    <xmx:ErOUaX1B2CpIWniaYI8XdksCVogFOWjzhWraIdHk6p_Pg13rzcuE1wj0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:27:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2] path: factor out skip_slashes() in
 normalize_path_copy_len()
In-Reply-To: <20260214091406.15118-1-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Sat, 14 Feb 2026 09:13:58 +0000")
References: <20260130140143.5579-2-pushkarkumarsingh1970@gmail.com>
	<20260214091406.15118-1-pushkarkumarsingh1970@gmail.com>
Date: Tue, 17 Feb 2026 10:27:28 -0800
Message-ID: <xmqqms17cjjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Hi Junio,
>
> Just checking back on the v2 in case it got missed.
> Let me know if you’d like me to tweak anything.
>
> Thanks,
> Pushkar

Sorry, I saw it, I didn't think it was meant for application (it
didn't have a proper log message like v1 used to describve its
changes, which I expected to be updated to match the smaller scope
of what v2 made---all it had was something akin to a cover letter)
and did not comment on it when I saw it, and then completely forgot
about it.

