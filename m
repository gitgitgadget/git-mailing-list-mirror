Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615615C15E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495431; cv=none; b=IBhxYXjamn+WZzj3L8pt1iiMvU1vWnKNDvxLCY38LUxomCzNIpk2mwLXYcWWdaXm2laUtIGSxOACCUllxsR3c+HuqJOR8IiTs+DiVBFWc13pzkf+ZWrwtpaOkmSFoDquQ7O7PJCwW14wk2pCe1gHKhnCNUNwJebpTKoYW8R8k0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495431; c=relaxed/simple;
	bh=YVv882rMrWv03G4oGUhXV9IeUXzupQFSOJTvnsB3DfU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hupygDhZI+ec6dGn286Jz/DsnJSZ5/EbR9HFCd0LJyUqNhhfgGrh35YY/zFq7wR58iu3mMW/0VKRVT3A+CDQ0vSMwASYpxQWa9kMj2S/hXbjXg4j2QiR5LgYYbPQ41L2pcKciVCkuVAi6b6okwKPQh8/cq6IufMELe2B+o2YyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VFnsTQxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M+hzmAtw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VFnsTQxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+hzmAtw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0ED8114012B;
	Wed,  9 Oct 2024 13:37:07 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 09 Oct 2024 13:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728495427;
	 x=1728581827; bh=t1wMiH8J1Fnqwlr8ukYifzfxXD8OaID/0dUn04VrAfI=; b=
	VFnsTQxa+6f9OQNE/9H2E6JUo5oGKJ071b433yoP4Z+WDYw8zsraPlXJ74OgGV3p
	OVtz2Z/x4IzsXna8y0aHGC1o9VzgvSRnNaxeKidnd0Yq30o6CGeIhBaQSXCrE2vS
	vxf/SNr15Dkj14V3jkmbZnr3VTlE44Y3bDju1rXU9hP/k5OoJo8fdJOv/XZSAEiz
	0Ztv8yvjsLTuFDsrmVf8Nis5e2J/NcgxMRroSifg92x2tkmJpjmppl5Z5swiLx2P
	da5mhVJIsZ9Rtc3ATvfuPDRek78kng1hf5h2Vm+jdDcXjEJQYJC02heawdbfnOlt
	iEI5t7zoE9kGaGpxwo18fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728495427; x=
	1728581827; bh=t1wMiH8J1Fnqwlr8ukYifzfxXD8OaID/0dUn04VrAfI=; b=M
	+hzmAtwKNsgTu06hTjPKSUyUkJK8DoJ5f3t/HKR+3VoKbennZ9wcyVYzAATUtjNm
	yn3egj5MPKxj1EgPjOf3o1fepteY9p8FmxKLdakTChKD0dWYPqWAJ/S6aKUv8n0D
	1LWo8d9fnyIFfTqhtnSTGKT0LdIG7HUG4XmESPd/pWOUlf4spsvVa5jDHH/AFMy/
	Ap2i55hW60+iNGgSoV4ha3pLugwWpQ/yWVph5q1oWB6sWZUNoBkqGRxZNqUFtcPT
	3icQ725c3wo1gtuT5xI4g2avx8TjLuJEYlVk5QgtHEPh96nXAYr8WXA4pwlAt1rf
	7gyBIMGdJ7cGtx73TRTaA==
X-ME-Sender: <xms:Q78GZ_HIps5meOTAWFwMb9mzaQeBKTuxpMiD4Ko5HRDFVdayGBf3gE8>
    <xme:Q78GZ8UwrlmYgfk_7mavdw9bTxE7nsDh7VDGiyEmTeQyi9GB19PrMLOYeoFozUOUv
    bH0fB4gIo7bmQ79rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheehffejgedtveef
    hedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q78GZxIa-HFdJmL3Eq2gNZvkKnD8t-sMsjBYRcZBojP1UisuPAdp3g>
    <xmx:Q78GZ9Gxilef9QUMgBy5fy4Z1CVRDJTmlGRwhQQHe5iU8zMQ01QMZw>
    <xmx:Q78GZ1VAv0jBUxILW2YppBrMwGZGOrtKFOd6h72rt79KsBoXEb-GXQ>
    <xmx:Q78GZ4NefVLzRbXGd-_X2QJIsQP6CkGDWdP7DS38Q0_nHZuUF_x1Gg>
    <xmx:Q78GZ0fG3Qqo7mjood0r0FWjZPCIi-gSrs3QaF9HSZt3pVb5GGA4Pua2>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A690C780068; Wed,  9 Oct 2024 13:37:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Oct 2024 19:36:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <203447e2-5305-4367-adb9-3cdf16c32f27@app.fastmail.com>
In-Reply-To: 
 <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
References: 
 <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
Subject: Re: [PATCH] checkout: refer to other-worktree branch, not ref
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 9, 2024, at 19:27, Kristoffer Haugsbakk wrote:
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I did the format-patch + send-email mistake again.

https://lore.kernel.org/git/b41ce281-d3b8-43c3-8b27-f5dc59601ca7@app.fastmail.com/

-- 
Kristoffer


