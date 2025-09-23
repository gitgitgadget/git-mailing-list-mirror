Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420F21C9F4
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661482; cv=none; b=A7ipYR7gA84kXFbnrvt7lnofk14CB3HR6v5JOA4JFQLmQ/mw97D7vYwCCMhxQAM9Hb69ns34ci6rA+wRIeM97gLJI7eWC9YfpN9y7/dRHkLAxHz9anUsM6HCDGWZlAhweJnzVgjXhZZ1D/pB/E5v2X4OJgWbUuvbvdFTWQbMoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661482; c=relaxed/simple;
	bh=aBaXSk/LVgPQViv5RfaF/dgStgAvwVuI1Mt5HpAT47Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGlozbRY0gRktnfWKJynk31wo5YRsGCoqGX0PmuY2uRkH9RRG1TbsdBfaUBWHUfmbppO9rle84VKKnBNtCaer2LG+jkJ3+Wd0m5N8NHerRsKZhsi+eUQ3AF0YQQkzE2/s9bOq+YM+GOVlfjM4hlo6fVPiBthfQN2PNMHzvMn050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=09JbTU9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EE3V9qLf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="09JbTU9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EE3V9qLf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23148140000E;
	Tue, 23 Sep 2025 17:04:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 17:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758661479;
	 x=1758747879; bh=TUpK2XNfF+uXoyjeocyuXWRP9S4Fp4FjLx46EMCZdPY=; b=
	09JbTU9c+nlDaXZb5Yr8xOD6KdYZia06UIfCWiJ3dG2GX89wop/Ri3n48ROdoQaC
	ChcTGffNX0QEK5euMbdFN3RGrbtlZN+OJGc+acri1u1Lgy7bZpwajcD2V0mRCsDY
	jpIVP49lMZhfODl4vUx+xi3Wq5e9SgfdtjXGce5905LFUhDiAaR3sK0rgSQmhG7H
	ZD1r8Z+f8T/rNMe8kePim5ZLG+zQgV/+YligHRRJKfsIVOt4QnsdQGqGaDrSwMB0
	2KO3gF1bRQmYDO07yr/2HgHfgqY6ekw3PtNbZf4rKXN9bvBmUhaTu4n3sC9XLJ1f
	gp4UN5d90Bv1fQnqjAQhiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758661479; x=
	1758747879; bh=TUpK2XNfF+uXoyjeocyuXWRP9S4Fp4FjLx46EMCZdPY=; b=E
	E3V9qLfNcbsxxJdiM/KaxSXE/gTnJRL0TPwqZeZ7+wS33+0TMccftohgkcKOJvjv
	TM086ApDayX9YtC1ycKva387GXSD7YHA2pNHsPnCktBxtxjd3P6sBLegkhfvm488
	A2cxlEPVKiTeYLVtpASOawc5KUmFT2xS2OD5E7jhRRTiW9v65jOiXkivclrLBWfz
	erD6Tie/T8ESoqtfTOn9YUvnPHmf85WhROw8+KV9xF9p8sayYskAoVCN+MPDXw74
	RPC9rlqry/4xv9WIWuwjSeLSEAjMpimddONcbreI13k0nzPyViu3evPiTREg/MmV
	o5NjVefKk56+oMwsEfvpg==
X-ME-Sender: <xms:ZgvTaJbInAc--i_2e0zLJlLLXRlRiLpDMDJKcKpKLSquGboocblyKw>
    <xme:ZgvTaHbsbnvBlwK12SmQcZMwTcOXuZD8CtufPsIR3CcPc0_Se8PQOzTpeBUc9vBXk
    _lGYJmi63qrLTmOP0BvGK5acMmHfAHreCZpKgTlftmMl4pFBjylfg>
X-ME-Received: <xmr:ZgvTaA_AXvXUzX4WBDRvRGtMtu5Jqf8NhzB7Bvn4x86S0Ctq8zMgZgSt6pQXY_26KtO3uOG4r8zq26BTq42ztCr4gZJQfUyk9UNn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZgvTaGhO2YLI4BHdwvDjJPcl28pg3eha-s7J2m36CfK-kdT1Qduqmw>
    <xmx:ZgvTaAcIGRhQBKuVUQS4ohDVLnbNKdBTO0krR95CokMyC5WhEL9-JQ>
    <xmx:ZgvTaNoC6Ybu2PPKlp1t0oRFwy1DubKZPyID65JqpYnmXdc4vk1Rug>
    <xmx:ZgvTaFAmqf5mjgaPueBw4M7Mb-0nQi6UoxiCDAU0sJTthrFFPPF4wA>
    <xmx:ZwvTaAfvfaoUq2q6BDjejmcQknaTt6BGLKYFKb9Ejja8tZGr98OklAYP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:04:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CAH=ZcbBO9bkZTTteZkLK6Ca0qS9v-_Xyw+Y471TFzpNSr7escg@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 23 Sep 2025 12:05:56 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<CAH=ZcbBO9bkZTTteZkLK6Ca0qS9v-_Xyw+Y471TFzpNSr7escg@mail.gmail.com>
Date: Tue, 23 Sep 2025 14:04:37 -0700
Message-ID: <xmqqy0q4op7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Tue, Sep 16, 2025 at 7:16 PM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> DROP PATCH SERIES: I am dropping this patch series in favor of
> Patrick's. Everything I want to add can be rebased on top of his work.

OK.  Thanks for expressing intentions clearly.  Will adjust my end
by ejecting them from 'seen'.

