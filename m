Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AE2C3262
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748827996; cv=none; b=pStlpRdOAOS3QLkI90W69b8JvnkdmIAYT+0j/QYAa5g6tdPXHMAH+S4cTgopD1Q8aHG/mWW0HDqJRb9Mps8oVdrtUEfR3KWo++dAHS2qz0y6u66zPS2tyrVOs4i4g/ah2JnwNnrf6Z13Ed4LE5X5RgMqYWqJjcp87Ts5t1vWGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748827996; c=relaxed/simple;
	bh=G98qB7HVAFMM0v2sG3ExOGjus0Zw8tHbG/B3QRcKJD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPsxG+65zfzvia7Q8UHFsnu2DvKeCLBbAUd6IMM8vJuf1tQeVNc2UOXTag2ln0ZLGcqw68TQUdxhCc0Hx+zmSsHqdCptUyRHl6hPLyK8C2fkwuuwza1raH4/QakzRkDPiMdW6NcBIN2ixFDnH1nrh7K5Ht37Drfd0P35M7rnPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EqWt/uhl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHnsHI1X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EqWt/uhl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHnsHI1X"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2413311400FC;
	Sun,  1 Jun 2025 21:33:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 01 Jun 2025 21:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748827993;
	 x=1748914393; bh=emuBTbj65kft//0pKqKzCIJbd8oJVT3XNtRgFJVzhA4=; b=
	EqWt/uhlcKmqL4RDnm35SqtgvdZFrIC1Z7FWGtrndD5Gm1QrFiGlqy1ULJJRI+YE
	iiPqSw4jpoSAZm8J2DMNxm7VBVrLITWl0jqjyx1OVlI1G7tkOxVeCoKa1+A4MxPJ
	Y0gSb8oRi+tnl/gixErjjNdSdsEDa8lswNEybi7aXFJujgPCz3FNpj2CzWUTukKM
	+a8v6R3LT/RFySit1u82O9HCgDtuxCncqCOq+i95KC8/p3DaFMckMY33Ac8GOYj1
	2ivv7sLp0d7nsE0l3n5qvLSCkH5cHpfszfYtfygCqTLkmCqRqUOaw6x2ZGXiatxA
	GvLjIzofvBwArw7kpMkUVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748827993; x=
	1748914393; bh=emuBTbj65kft//0pKqKzCIJbd8oJVT3XNtRgFJVzhA4=; b=b
	HnsHI1X/7jVIMdTLHClpiaVcooabpWmr/3be1nsiVFcRrVO6GHRojjuyOIc6Lmt4
	bYJnmiqEuUSjbMCBJ9LEzlsbTzTSDuBWAjkuodA5Cnn2aw5Jtrq40Ox9DA4q46Yc
	RJtd07bsYBd2sYXZ2vmMrNonWqn8narQ+t9qu7ggqJr5ND14wlGUtj6jzSMSH0Nc
	WlC5urBcMu3cM/Pg4EQgYsAYW+Ucc5jeCE/Dch2to9C1AOfVSPVDUPTXsnN9MbXf
	nPvwmRZFKzL654m3/9LqRHGxu7IJkrf/Mg3c5Q8/5UMh6aW5TdZdULy63ovLlviR
	g2Hw3BgJJQnUiJXjYXwdA==
X-ME-Sender: <xms:WP88aBnfe-56OtgpHkK2lhiyD6yOPbRdCdfr3UGjhjcDcCk9FhI_zg>
    <xme:WP88aM2PMHYmXbqDX7qt5jvtFWtM6duXNBeQ3c5-wrkWYr9PBWfTXKq-a2ez0joJq
    V9FoHF-y6yPzaiMJg>
X-ME-Received: <xmr:WP88aHrAO0JlfF1o1xWXt1CLlVZWhg70JchAW6UREfzFHeT4Mg1zmi2-K5dQ_eQclI2lOYorDvSOTpHtYbleha66oLxoLR55sO5F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieefieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:WP88aBn8uWORIl_mIurZELbLwhm6ajObcwp8uHE9BotEpHJyFz-7eg>
    <xmx:WP88aP2Q_t-lGIzBFiiqlIp_q7zztCheY8nFN6ssf6_R7bd3rb8Ydw>
    <xmx:WP88aAumyaXpBHolaoWAhqG2L6VYounkIaxZa6zI_GKWIheKwvYGpg>
    <xmx:WP88aDUmy9B9mIkOS5z7eV-oSMqveNLLLlvYAIAsr4RT25w2K1N1Rg>
    <xmx:Wf88aJUwqkvc2Nb9zYQ1S1phA_KGpTiIIqDrmCGVgeCkJCDfxpZysGXM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 21:33:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Karthik Nayak" <karthik.188@gmail.com>,  "Eric
 Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked worktrees
In-Reply-To: <3f731776-9a9e-4c8f-8de9-99d470503345@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 31 May 2025 14:17:34 +0200")
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
	<aDp55upE6AhYunz7@ArchLinux>
	<3f731776-9a9e-4c8f-8de9-99d470503345@app.fastmail.com>
Date: Sun, 01 Jun 2025 18:33:10 -0700
Message-ID: <xmqqv7pfudux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Sat, May 31, 2025, at 05:39, shejialuo wrote:
>> It is reported that "git refs verify" would fail when encountering
>> worktrees created on Git v2.43.0 or older versions. These versions
>
> Nit: maybe
>
>     "git refs verify" doesn't work if there are worktrees created on Git
>     v2.43.0 ...

Yeah, "It is reported that" was somewhat odd introduction.

>> don't automatically create the "refs" directory, causing the error:
>>
>>     error: cannot open directory .git/worktrees/<worktree name>/refs:
>>     No such file or directory

The original of this part already reads quite well, I think.

>> Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
>> 2024-01-08), we automatically create the "refs" directory for new
>> worktrees. However, the fsck code incorrectly assumes all linked
>> worktrees have this directory, thus introducing compatibility issue.
>
> Thanks for finding that commit.

Yup.  And that one is v2.44.0-rc0~58^2, and that is where "v2.43" in
the above description comes from.

> At this point in the message it seems like the fsck code never worked
> with these old linked worktrees.  But `git refs verify` used to work
> with them until 7c78d819e6a (ref: support multiple worktrees check for
> refs, 2024-11-20) which was part of v2.48.0.  So I think it’s worth
> mentioning that commit as well.

Good suggestion.

> Like I said in the first email the only minor regression in this release
> cycle is that git-fsck(1) reports these errors on stderr because the
> default `--reference`.  This was how I spotted the issue on rc0.  But I
> neglected to mention that the commit that introduced `--references`
> (default) for git-fsck(1) is v2.48.0-rc1-49-gc1cf918d3ad (builtin/fsck:
> add `git refs verify` child process, 2025-02-28).[1]

Thanks for a careful analysis.  The "fix" is rather obvious, so
let's see if we can come up with the final wording of the commit log
message and merge it down in time ;-).

