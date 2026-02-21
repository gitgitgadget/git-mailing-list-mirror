Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12247359F8F
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693677; cv=none; b=S0AxXxEpQ8uhP96G38wao7ECwt/n6JzCi8Azv7TT+cKnKXcuGg1mSGkhgLR4oSPD3dgwqyiFwmgke6uJaMXr+4phwuWQeueeqzRwV9qMxy3unAbCfJIsCwTsu5LU9BFDnnVwQz4MTmMTD5cyt+DbYebULEgaYPybt7PCyNR/sIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693677; c=relaxed/simple;
	bh=wqweFh+pERx5RxjXJku4hVOQ10aomiiwyiG5lkHhUI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPbBW97ZKnsRAW9NPExg95DKxFTXUCMZoprUcoSRxFG8kRVLsjGlivUlaunuMsj/+gbv8q5qKOcRcrjMKpVfN7zMMsJd3h/IfSJX/CPDwWFlD7v5W81D+cy9i0EEMycjClIewISh+k1v7rFAv5tCi2rxC+JQJA39U2u2eTVbmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A9mCkFO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4m0orJF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A9mCkFO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4m0orJF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F34F1D00197;
	Sat, 21 Feb 2026 12:07:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 21 Feb 2026 12:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771693674; x=1771780074; bh=JL0JQCVANL
	aqObyPqVs8hN1OBrjO//Xv2B+g/SjoKRE=; b=A9mCkFO7RQGx25jRp6OluW3sfC
	JsMsuIeF8RCe9p4zku2l+Xj/GpgKvPHWz97ibME0P3KHpwb39+Y6j4JOvfrJD5D7
	pdOQgjg0pF7VHjoUDF47S8Ob9qco1QmhVyM3RGbMQjtl68mq/XGNXlADAwOKaGmX
	xi3ABqBhD+t4r15mgECCaEQGMbDM43piRWNsOwDY1Wr13Tbe5fOYcpAXjFhV5bmO
	O+73RWYy8t5De9C+c8YzZeQ4Z8FulEU5SX7kLW79aEAKvuvTA3n4BpESU5qaQK4O
	hBfSbf8wBUFyH3HBRdfcEogqEB0+xU1sSyW3s8D1s4ne3qXWxikivfh+P0hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771693674; x=1771780074; bh=JL0JQCVANLaqObyPqVs8hN1OBrjO//Xv2B+
	g/SjoKRE=; b=I4m0orJFmrgTBLJVm7HJLX/BCdL8RgQQt73ARqFB2JmFX3uOPoC
	36MT1Zy4netgJL0n9CdjYD28I4FNelTcqROCDi4B8OynmstUcXG1R+tg0ibfiWDQ
	V/1PF4u+Kp1s6S9oJExbi9kdojMU5HwbLx65d52OIHTv3UzJO7t/smsK587W4iEk
	jAQRhwIK3SEg9R1QBWT60Nz2fz4DXWSwMW1dbHQVt4ZDtu3DZOiBMoBYlY+4Lpct
	PiG+LwhB9eRW88NrkmWpPHBCUzObLJMbfLD5Qw0eDeUECUa5Wb3Y8jcDOlTmLLRA
	UDXytAjJWj8+tajkujRcw17YYCnvdj4LtTw==
X-ME-Sender: <xms:auaZaTYJflhIZa_ISAN_TNaC8FvDi6X1-gAxOnZ45e30dn0oopEZMA>
    <xme:auaZaWGxKTMfkH_8pAyK6OPN5QyCnViYw5KGkMotKdjuLHxc-n6_ybLW-GoPFQd89
    riepowMezYg7_6cFwUAofAzHLWDEeQSe8hlYxFm1a5_kq3zQmackQ>
X-ME-Received: <xmr:auaZafwGTSrSc4Jucfs31wljHUk1dSZwH9_Z1eRH-mGNczDahwHjhWkcGQOwJQ4pzB6dIAgi-ZX-rT39roSlMgRKa7q073hgQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprg
    hulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:auaZaQnRTxPmvxrqsmC06_7t9RqX64DrkRE_RTTZ33fwi2cyp-fz4A>
    <xmx:auaZaQnmi9fbiAPScAPHx_nGxRmYJ-6MtiBs1SB_EWKCGKIqZLfpIg>
    <xmx:auaZaawmueThkJySygIspJyKiGFd3irOoOVSFB8ercYeGoSSOBVISA>
    <xmx:auaZadp1LJgwhTpV9wnz8FwuZKXasfMeuNds5I0F0sDCfaytpNDezA>
    <xmx:auaZadjFkuAzgILA7w65mvZTrYRxtWGMO1gqB2NtqgPdk6EjlnAyj5z0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:07:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Paul Tarjan <github@paulisageek.com>,
  Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
In-Reply-To: <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
	(Paul Tarjan's message of "Sat, 21 Feb 2026 09:15:02 -0700")
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
	<pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
	<aVuplzNaoCHlZG3S@pks.im> <xmqqikbrvz2l.fsf@gitster.g>
	<CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
Date: Sat, 21 Feb 2026 09:07:52 -0800
Message-ID: <xmqq1piet47r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Tarjan <paul@paultarjan.com> writes:

>> I just noticed that the discussion thread went silent after this
>> message.  Has the patch been reviewed and tested well to proceed,
>> except for that meson-build support?
>
> I'd love to see it integrated upstream. Is there anything else you
> need from me?
>
>> > This would also need the below patch to support Meson. Would be great if
>> > you include it, otherwise I can send it as a separate patch once this
>> > topic lands. Thanks!
>
> I'd prefer to take you up on the offer to send the meson support as a
> separate patch.

This part of your message is one thing we needed from you to unblock
ourselves, I guess.

Patrick, do you think you can help making this into two-patch
series, the original one being the [PATCH 1/2] and update for
meson-build in [PATCH 2/2]?

> I'm unfamiliar with that system and the suggested
> patch failed in CI on some dependency installation steps which felt
> unrelated but I didn't want to debug.
> https://github.com/git/git/actions/runs/20720903513

The topic has been in my tree near the tip of 'seen' and I do not
think we saw CI failures coming from this topic.

Thanks.

