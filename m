Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C8392C57
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433544; cv=none; b=beWzczF0mfdsfd+pVSgJp1yMiFQlXIu2Yww2dllAVvl1NkUGMXFU4axYXVoHifWXMzodnhdcdPm5QXw1w1g5qr7GXTHmf/zEC2gnCzHgVmf6nxeqrwClEzZpab21mam1lNw6C/JeBspA46TQMd4WsUGDGI7lGoOdHPuHu9Z5sSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433544; c=relaxed/simple;
	bh=HPurUz3U8M9KEiLMl4yx11Dk/vUsaajN7nPMu9hXsfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iSm7HkSUHd6n/bCkpDjM2JPPMV01vQTrhq095X5deOZ3mlxGdirVoQLHOC0VoLdwZHafJ+xNpWCNbrnYC++YEDLbc+ramZhfZG18M129SVHBxae4yO4W8gboxSkc/n8cQcFlTI2OKf52orXNdaNiaOL5xEEk7faKVh6UFIh/338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APK7MKJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KvslHcVM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APK7MKJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvslHcVM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D0267A008F;
	Wed, 14 Jan 2026 18:32:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 14 Jan 2026 18:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768433520; x=1768519920; bh=5AS1mULXMT
	KQfi84D8zBpYma/xq7m+Yfdm9o5j21oSk=; b=APK7MKJBYuSmVFhmY0bOvFSped
	cqi2Q3yLSUA7kpwFBFedfyzZ2Wpb2P20M3Bk8N0bgqdXgyPJP1L/zEWUJeHHcD1r
	w1hoY1z717YXmfiSyI2I1Mu9m1HhyylNC2iTtU4uksXnBzep0iKXHjIxcfICEFHU
	6fp8Oelj6y62S5x1a1cjOFVK0Romt5Z6nYuBLM2VYk4Yfc+HeobtrcKEDuQodDN6
	b/U3MFqNXnWjt2bRh79lWiJt6srJPC3xqMzufEuag4cVx4hqcYKSqi6toMkkQ3E7
	4ebsfUKhohchI8PyH/8xfmtEqJTnViGAkM5xjnhsIDfCfe94pzVhOvuYltGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768433520; x=1768519920; bh=5AS1mULXMTKQfi84D8zBpYma/xq7m+Yfdm9
	o5j21oSk=; b=KvslHcVMCl2LFsPPRG//8COEeiPm+tsMGC5g0QOk4J9dIHobODd
	QV2AjqS3GGEoltRFs+5PUGnhR3u2Aqe1BMixXT/+WOTorwgCLt7Lk8718XqvtWmS
	Tzlbjp1P5eDpSwB1BbT0BoG+YcOt+phMCa//H9h7jGfN0o6yA+bDUVHdHF4ymh7C
	qc85255cjYJnjY9KitFjL84iI4liB+qUSTRXKaw+iCE9cknwIonyTjI7NIgzvlsw
	nFEET3lcA2jLnEMvE5yUAquhzhAHkXRQifxbr6nf7/pApn3225rinoR300hfmQu4
	+NXqgeplXzov0iaEjh++wnnzuvduHJvx9mg==
X-ME-Sender: <xms:cCdoaSUimJ5HRYTb-9MUCJwMpQXytdfJiZ0a6dtnVNMKGmWtm39_yQ>
    <xme:cCdoaVeuvOA9eL1UjoGdgdCATagjQi8WhfSesx0tIT5Yu2dD8EqBw_9hqUBxp-nl6
    JVF4w9Gp5onQSpDb7fA8qMzte28wK11RgeSyEuL10glrCAODOOqsA>
X-ME-Received: <xmr:cCdoaev3PgJKs5xa-AkNyB94HW1WZSAqgAL0PWBJrs2J-kz7cyT6dijq2_LUQpJ4hd7l8Cfl1K8xj4LTUzO5jjdMoMYdOkcVv37gGns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:cCdoaU_b0WPUcK1sznPoqoBmgqIUmVQ4vfkYbSHwx9S_4aBXHdZ8aQ>
    <xmx:cCdoaZ0XTe_EghXGmVvV0d9JTZBUZRsfH91Ad05fXzrYV1lv_h8acA>
    <xmx:cCdoaZB1whXAsE_wuP528yGFpekH0XbZxAthX_LyDUs0O_9Tcg6Tmg>
    <xmx:cCdoaVe2ZJCSETRM8Y8tr1vbK3uwd4rsv5EkEcZ--vsQM6RPrerf7w>
    <xmx:cCdoafeAXy27DWfMunGWLdfO9W8_k6Lb3alpEuyuxn6C3UYKoCj3rpbk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 18:31:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  peff@peff.net
Subject: Re: Triangular workflow
In-Reply-To: <20260114231202.61271-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 15 Jan 2026 00:12:02 +0100")
References: <xmqq8qe0f2iq.fsf@gitster.g>
	<20260114231202.61271-1-haraldnordgren@gmail.com>
Date: Wed, 14 Jan 2026 15:31:58 -0800
Message-ID: <xmqqecnrepox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I wonder if we can come up with a flexible and
>> extensible notation to specify what branch(es) to compare with, so
>> that we can use it as the value of this opt-in configuration
>> variable?  Something like
>> 
>>         [status] compareBranches = @{upstream} @{push}
>
> If we go with that, then it becomes trickier code-wise to show push/pull
> advice for the correct branches. But not impossible since we can check if
> branch is the same as @{upstream} or @{push}.
>
> Philosophically, two main git commands are 'git push' and 'git pull'. So it
> makes perfect sense to me to signal that those two are special, and not
> allow other compareBranches.

You are falling into the same trap as what the folks who designed
the original ahead/behind comparison did by limiting yourself to
push and pull.  They said object transfer always interacts with the
@{upstream}, hence only comparison with that is sufficient and it
makes sense not to allow comparing with anything else.

Until you started wishing that you want to also compare with
@{push}, that is ;-).

A static point that has nothing to do with pushing and pulling
(e.g., "the latest official release tag") may be something useful to
compare with in certain workflows (presumably workflow of the
maintainer type), so limiting our sights to object transfer like
push and pull is likely to be a mistake.
