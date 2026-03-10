Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FF3AEF4C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161315; cv=none; b=kPjBAz0mK9lWsn4BlbtErG59L3hE/KWnzJCDpXd1D0y5Ow8eYH+BwESP3CdJpjFZciv0UnxpkBeyypVFHSjF7ZEjMdvjImhUmByj4RzE16AE9IXz11/tN4+DlttrLDejkHqzb5VPQKoxWsaaeh2ljtmxqKAgGQX6urscF6KAWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161315; c=relaxed/simple;
	bh=O4GvdcfAHGftrP/LXXYUMFza2MoHhGhY6GMixZ6S1cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0N/cMUz0ww3y+Dr342M4gAlDq939/S+onrB8W4XUlK+pY7/XPEAB0x6d9tZBAesyk7JlMMH1bkzQa3q/tHekfHcAQV9i1+6G92DST2BGPYcdp9BKosvGLcFzbSuGR026zgTBV12sO9rVnUJauhsSCeEYVDvvewm7tfKqXNSF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGiBzbde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vEwwupp5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGiBzbde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vEwwupp5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 68C2EEC10C3;
	Tue, 10 Mar 2026 12:48:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 12:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773161313; x=1773247713; bh=tvt9yM61/t
	N68id4cBQlapUN/gj98g9g0+O5r8ln8TA=; b=fGiBzbde1JGldahJ+iB+rKh7Np
	4T7wyRIn2GJUNqWiBrrqhotJOjN8DhN1GT9C3F66aC/9bnPFwehUk2WMbs80xbHI
	jX4VZ8o5u5ELwg5u6L1kZsFMApej5iGFnn37AK05lcmUECcmfi5lunpuBHxeWlv4
	6Kfsiwzjfj2vPegmmSymQikG5igBDGR16A1qkEFGd2wgwEU+eaFRbirM0sv6gqFs
	DpUb7g/3nDLAZGTvvibqS8+k6tPw7Bvm3deoQ1BkAS8dSQiU9liBnGUbhYvMmEo1
	nDC26/vSNV1fS27zlYgXnK51CLr0Xcfwwq7tfsXUkBBwM7LuSUpikMxTo8Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773161313; x=1773247713; bh=tvt9yM61/tN68id4cBQlapUN/gj98g9g0+O
	5r8ln8TA=; b=vEwwupp5Nu0zzO/5loLh56aC7PB3rPkx5eduTutd9XJrdqO/SMW
	UBXLgremqvT3mA9b2rTV/yVqbuJo7CSLMkHwhZTcZ7W0u3RLhWF4Zj8kOD7VTFVS
	iaVqMwjZek330f+5StzZ8m4fWvIttYDKPsLP3WVC6QjldFjufYspA3lGrH+5O5tn
	RvnuH1i/GO5LUqUIkRUxj3TwvuNUFHuLAnuRP9cbRf54oW1Asy8xrypaRVoi9I20
	InEmGp+CO7YXFs+AhtRoLsBXMlvtgcxDNNBgy6MpfVSbi8u6pjsTROXFiUuBoEdZ
	Iuq8hxF4hB077lmFnIQ0wsDsBFV6anPTQUQ==
X-ME-Sender: <xms:YUuwach7o5Eo9Olcg_aeazPWUmx39nmstYOOqUBOYNPqboNmlKEzCw>
    <xme:YUuwaYulomeVJ_WYMNNdHbZ0L7882dIXi_nErf63eyrXnXD6i1igV1S8g2aov63rz
    30h_C0BMblFqMgFagUBZAFVfsbL_4gEOCdGr4VMjHFn1qDcnXitbw>
X-ME-Received: <xmr:YUuwad644q-s3PHSAOsohxS4m14SFe9uOVb2frGl2-nZld4SO1rV3Q1xK_n-U_Ql1hP1Tq3SazVhcKuQNS5CoJAO-cBEp1YBlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YUuwaUOaNWot6YWl8D1dvATzn6FcQ8G3FFB8GFzky9BkJ6y7g9Seqw>
    <xmx:YUuwabuvpBf15HWa7Ugy7Rq9svDjjxu5-EnAhO4xMBpwmX7Afhkvsw>
    <xmx:YUuwaXbzlMCfYvSZSM-YqCLws3yGr7aKu_yorQYjZl0TosLpWNgchQ>
    <xmx:YUuwadwj-KQodsIbRjTpda5LwdMcjctqdIi26TvC3Cd55RcpdDd0uQ>
    <xmx:YUuwaaErpux3QuODWbshquE8ECDZls0IpwoHibydhhJ9Z41lg4vN_KrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:48:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Arsh Srivastava via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
In-Reply-To: <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
	(Arsh Srivastava's message of "Tue, 10 Mar 2026 20:07:16 +0530")
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
	<pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
	<CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
	<CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
Date: Tue, 10 Mar 2026 09:48:31 -0700
Message-ID: <xmqqeclrwrz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
> branch switches
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
>> So won't this simply be duplicating the same message?
>
> Thank you for the detailed review. You are correct, the existing message
> ...
> I will rework the patch in that direction and send a v4.
>
> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>

Just a comment by a bystander, but it confuses me quite a lot to see
in-body "Subject:" and "Sign-off" in a message that is *not* a patch
at all.  What are you signing off with this signature?
