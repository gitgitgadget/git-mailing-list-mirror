Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC025B668
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212342; cv=none; b=thnyF/iKQGf0oCa/A3QSyDD5hGTkYR0Qz7bbyI11KWhJX3njZ5oAFfJNCDz4DqufejPvQwRzM6l+Sp9S60EVG0o2tat8n521ChkafFnf/6g8bcZDC+x40/Fye8+tk/+obROYmazjvCpeyzT/nUl2czrSl5MhYbmyFvamNUDiK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212342; c=relaxed/simple;
	bh=PZRJP8k6+jLsb/Ql0/jgOXApANxhgWGPw8y7s7ceuJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdkSWHl3BqbQWV02w39z4pSimCF+Zvqi60V5OKOGI8GA3LjK42HQIBHwrW+h0T/c33wVvBd2i1+Wjud14V4rqbjrrO417Gs4WuMD2VrdhA9K2gnIuY7VU3h8N6v0BzI0e0tVaWXW18ITZShvDk2/i0r0C6511O+NwgUPpyJibTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fp8Tdtm2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DK1OQvwC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fp8Tdtm2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK1OQvwC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEDE8254012C;
	Mon, 10 Feb 2025 13:32:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 13:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739212338; x=1739298738; bh=lnr056V6T2
	tM0iwzIKpjTFyVZxdgi/g4BY7xLIOV3f4=; b=Fp8Tdtm29siuHwch/LWMCfO2yc
	Zkmra+Cpr4Go71e1f8rxpieECzPdW3g7Cz2jxYTYHjZhxYU89eXq8UzvaZOGEpSS
	OyGjQf7UQmypZwVf1C4uqjmY7anzhBoRS1iKRmjlYjjC3tsveCigM14yCGB1bT71
	YxsFtmZ7jhKRG9Ie9FbxpcY9qKM/FHdXYiT3CdVeTb7xyCcb3hRxmiZigUCajmLn
	C0pxa8nAreiBKPPIfSfMpVT6YQD8AVZrxfpGfRMs/GAdNsku4EqrTE0tt7I5RTjJ
	Ndcss5apJtsEBWVlEQHt7nzbgt9a8j4u61kp/sbc3tYh4SiDSNTGPhfG9jOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739212338; x=1739298738; bh=lnr056V6T2tM0iwzIKpjTFyVZxdgi/g4BY7
	xLIOV3f4=; b=DK1OQvwC/YXn8qbiitLXHz6+yQKWWmybptd/6ZQfgpNQKUQXVWh
	Qp61ZCzE+MxkTz+45aAKPbj54P8R18yQxfy7RWUH1NFKORvPP42H6H/8BQQc6vHg
	EEmExiDDI4gOtUjbjOsckAuJFXXXHB6zYH+U1t0XnyKz1rwFYAXpbeJeZt5wBYI7
	8h0vcIvTzNFpsvjuUH+hxLkTNHVMEoc4W4rYkIQrBZdz0a1hw7nedFVJmpDbdgCD
	OR2aR7aWEPefI0RrZyMx3k5kYCHJR4oLuOB/VWUO2so1EpgZ+d3Nlg9xIIPPYIQQ
	nFqhTWw+8P0WP5I8xW3rVdIW9GcqFTbqI+Q==
X-ME-Sender: <xms:MkaqZ8wwgKZ3HbBdKZCv7aOPOEj1WgWfMkVU863c-SZpXKqGzqIF9g>
    <xme:MkaqZwQrcjz3t2wx6P2uy8IFHncjTL_BH5TRx77msuVfoR_R2dDDd6dkjTyQr8qSt
    cNbau6_QcVSI9jTeQ>
X-ME-Received: <xmr:MkaqZ-VAUma0XQRmfzMxu9mLKeyVWIt1oAmJcDwAM4bY-x0fN_Dc2hpAONxpmYW2WyhVMIb4034kvNr7WK2kWb6eE_Wp1P_LSS6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MkaqZ6jLUiVEX7pK_PIXDwEvoDYPGTw5Ozh6aJ41J_kmal9epn2VuA>
    <xmx:MkaqZ-BqXfLeLFicZD2iJD1hPqaG6OjJFLkTyZxe7vPF__OTZOzZlA>
    <xmx:MkaqZ7JdMmeTl-o4EfZI8fY9EUv1xIbG5EE3TC_MwVI864NlxAGg0Q>
    <xmx:MkaqZ1BiVV8OBfOTB1s2n1ytFrsI34e59nLP_bwiAu1cHDaeUuH45A>
    <xmx:MkaqZ17sqLCouRLbAJ7lTBLfbPObdGQ2-irej_q9J3AhJiKIYOi5IPsz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 13:32:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/16] path: remove dependency on `the_repository`
In-Reply-To: <Z6d41SYoyavqcei-@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 8 Feb 2025 23:31:33 +0800")
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
	<20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
	<Z6d41SYoyavqcei-@ArchLinux>
Date: Mon, 10 Feb 2025 10:32:16 -0800
Message-ID: <xmqq8qqdbqhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Feb 07, 2025 at 12:03:25PM +0100, Patrick Steinhardt wrote:
>> Hi,
>> 
>> this patch series removes the dependency on `the_repository` from the
>> "path" subsystem. The series is structured as follows:
>> 
>>   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
>>     repository paths (gitdir, commondir, workdir and submodule paths)
>>     and adapts callers accodringly.
>> 
>>   - Patches 6 to 12 drop repository path functions that had an implicit
>>     dependency on `the_repository`.
>> 
>>   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
>>     on `the_repository`.
>> 
>> Changes in v2:
>>   - Rename variable to `wt_gitdir` for the sake of consistency.
>>   - Improve several commit messages.
>>   - Link to v1: https://lore.kernel.org/r/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im
>> 
>
> My questions for v1 are all answered. Thanks for your explanation. The
> range-diff looks good to me.

Thanks, all.

By the way, shejialuo, this may textually conflict with your
get_worktrees_without_reading_head() thing, but the resolution
should be obvious.

