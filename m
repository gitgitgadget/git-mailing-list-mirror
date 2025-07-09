Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506E2165E2
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078386; cv=none; b=c4LWLrV2V0iq4CYymNMCriV+t2Wz77RW99A10r9BfRIF4ywkkh4pHCN4QX2MScV6h4v2WvMJ/XKuN9EgwXlsvd60Dup9GkEK8mjqUF4artC8Y3dOHYu+6aRkpe+Io9ok+9GMYv0T0wLmHe8QE73sCCmEOTUfEdbN/XpehDS45GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078386; c=relaxed/simple;
	bh=P4VeH71m/9gA5gxtDsoNwRWdAK3jTjqshOIgSTrgTT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P2WjkjD9lNs5sHSWNChuH8iQ1MfTmZ92XZak3/Gkb6CHnOS3K+gx6IpTmbLcfWzBVmefUmMsNBwvfQfPtfnEtvK95qn04jazWv2ahMiRXPfX+NS4F+kbv1wQz0H8NVsh4QK6RkLK1hG7Hvioi5AY1pwWFhIKVkkcUQ358jh9kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kRGqBSQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yk46u1o2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kRGqBSQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yk46u1o2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D55F91400395;
	Wed,  9 Jul 2025 12:26:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Jul 2025 12:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752078383;
	 x=1752164783; bh=7YMeGGlTt3dgDsQJGmTiwpcdnzeSRLkP2Gk07bWyKJo=; b=
	kRGqBSQ+yRmYwiBiMdi9eK2DaNVrjO7rZPbEVLGzvjERG6BOYW05jTuxO2bx1o/S
	f9gCl1i8Pbo/Saw4Oz0EqL4+ep98B7vRCb6kS8dXwl0N5p03UUIwJUYbFMSSyR+B
	Yc+VDIReKJh1iwVrS0nTPish/O7ZptLbiwpT5aZi41QufZQIMGRA9PDPRc8VPbfO
	T8my+c/DjbhjjXRf+B38VATdst3pYZSr1iSPqq7Cdm/bB0XJvpA1p287OJIZIVHb
	WIgE5dVW6OYfbGW/WOtucZWnja+A1IMc0CO6P57i3t5GqJ+W5sWrS6c8iMaJzBSo
	E7+gD9mko32PW/xKAVPNPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752078383; x=
	1752164783; bh=7YMeGGlTt3dgDsQJGmTiwpcdnzeSRLkP2Gk07bWyKJo=; b=Y
	k46u1o2Lk6wb73YZDfqdFpSD6F7k/Pr/VBExqVmpI4Vusom47x7qZ39deAtwcR2s
	lnhuEfEy3NYHvqDf7FEkO8DrK84sm5UWQtOEMBPJjbiIjKfZstoj22iXIiDYO+Wa
	9x4Sb14+mDx/VAiqlmqnIhVZq43TtWYXXFbFJktT+IdLfCxJnLTUAptugiQp5zBX
	OZHyBPxsuQ8asxReb/hvTwejJ0ZqoQhqVCn1X74yMqYsHwKF0LwuZe7y/oOW7jac
	FJDx98MrMAsOPeTML4Bd+LUjbsBK8lXcefQEErYCBPB2aLhPq4ROMLyMHqQqXn6m
	L4hHz/sFmkQ6KFx6LnCCA==
X-ME-Sender: <xms:L5huaLoWzNix0HdeRtbGCvreX3Z_IExMtXSCcpWL8v71iuJtrC7dPg>
    <xme:L5huaBJc241eZvl3ZJcciBU8cqR0FcsnHVo-EF7QN9XwYNkTQKfeOuvh2UfE7mFk5
    kP1V3VEfY01AdpNVw>
X-ME-Received: <xmr:L5huaOqJV33jj-5uTIYGH8dkGKv4vkm1mFm4kVtFI8tA60B9ne8TnJedXPBoIcOtDPYQL4mKp_fH737kGgkr3a__sQ4sSQVL25nLav8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L5huaJyx-0ixy_UzirIXrPfA5H0nfucc0kpocLwqKj_4ZV9N--6bAw>
    <xmx:L5huaCMhiTz9sIkUldyZUwtf9QFH05gWhbSnJLBei4qsBI0VcJjQSw>
    <xmx:L5huaO7VpTarLq8iqbNa2hXsbOvijQoYoKS0pfDat3jlqS0GKWhriw>
    <xmx:L5huaLkrqdVwDcPtpe-u5Qu5HTZ2GqXmCIvu2lBfwdvkRC_Z4otwYg>
    <xmx:L5huaKdlD8HJAmPGtt6wQEo7xa0qid-vVzve_3v-jpthmxUfI56u-Bxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 12:26:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org,  phillip.wood123@gmail.com
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 9 Jul
 2025 03:41:13
	-0700")
References: <xmqqplebzgm7.fsf@gitster.g>
	<vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
Date: Wed, 09 Jul 2025 09:26:22 -0700
Message-ID: <xmqqa55dnxe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Mon, Jul 07, 2025 at 05:11:12PM -0800, Junio C Hamano wrote:
>> 
>> * cb/daemon-reap-children (2025-06-26) 4 commits
>>  - daemon: explicitly allow EINTR during poll()
>>  - daemon: use sigaction() to install child_handler()
>>  - compat/mingw: allow sigaction(SIGCHLD)
>>  - compat/posix.h: track SA_RESTART fallback
>> 
>>  Futz with SIGCHLD handling in "git daemon".
>> 
>>  Stalled?
>>  cf. <dba9ae0d-1e43-4345-a7ec-b57a07d45a07@gmail.com>
>>  source: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
>
> I don't think so, but definitely missing reviews (specially for patch 2)

That is what I called Stalled---stalling does not have to be due to
author's inaction.

> and slightly controversial.
> ...
> On the rationale on why this is independently useful, note that we are
> currently relying in at least 2 "unspecified" behaviours:
>
> 1) using signal() means that it is implementation defined if SA_RESTART
> will be enabled or not for that signal, and
> 2) if SA_RESTART is enabled, it is implementation defined if we might get
> interrupted in poll().
>
> both are resolved by using sigaction() instead, and it is up to us to
> decide if SA_RESTART is enabled or not (which might make patch 4 obsolete
> if we decide against).
>
> Carlo
>
> CC: Johannes Sixt on feedback for SIGCHLD in mingw which uses 17 instead
>     of 22 (cygwin and others) and therefore seem to cause signal to err
>     without setting errno as it should.

Thanks.
