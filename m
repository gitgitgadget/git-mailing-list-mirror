Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BD25A320
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910678; cv=none; b=uw5yZrEEQHPmeNyW5QCjRxaEt824tW0XR5xZ2+9GUKugoO7kEgEgDp5UtH8KZUZIHmERbwRyThSlGamNbAUR6+k5+x7FlXYcsWM/ld3bhd2DnGhXvAZkLmxm054I7QhKyoHHlElMU4VR87JeMdxbVLJ1zTK74KWyoYYFn70CE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910678; c=relaxed/simple;
	bh=J1OrGpQompLuATOibSqUqySuU9tLm3d+d+4cH9wN2BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTda5Ndn2PqZ8K5Peo73DOR0lyP6QaRJF5I3iQbJqm/wLY9bjmn7Uf0PruP6herNIgN9fM2FriL5G+PohjEw5VPfwruC7Ws1x7h3qAeuJRsoE2Je+P1hHGalz09cm2Uq6he1zk/2qtLGMnKf4fzbFKDGwnlXjfxeEyVqdqi9uUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K5meHMMG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmRXNpZ1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K5meHMMG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmRXNpZ1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 120441D000B4;
	Mon,  7 Jul 2025 13:51:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Jul 2025 13:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751910674; x=1751997074; bh=jzqyeLR6Cm
	3ZnjpOxVv38tNlGj14Y9uY2oCve4Z+VkM=; b=K5meHMMGW+o3VgvSZJn7/+Zv5o
	AAsVQoiipytSXDbtvza2KAoT6wtfU0/7bIv+pcp1uUmLOLTdF+ofebDq+RpLGmcv
	pBGeISyEnm8bErFUgp0khdCqLo4OPc2Us2yxE+1WogHE2l+gsKGJPWg297p2oeog
	7W5KLc041gjgiANB4IjlpGBn/u1ixq2aWOYH1E1sCzdgnHN7G+ALsh+sUud4w0dH
	P2PNvWjMDDQ4S1WBm5fIMCUTriy4Plpn/YkJfw50+U0LG28y4N1Yb5Pk7I50I2Z2
	n/ag7Ajv8+TKs+Z2N0njQZdKkF0AJgHB57aDOfnyO93FW6OFt5KmBx+ZevJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751910674; x=1751997074; bh=jzqyeLR6Cm3ZnjpOxVv38tNlGj14Y9uY2oC
	ve4Z+VkM=; b=VmRXNpZ1g+S/HHGrZ04DzwpaCjDA7u95W5iB7GU7xhJDInlOC3q
	CYj9hIP1PkgXJ4avnAeF+NpLPXJOVBAQ2Wba6AGt13ps27EVe4mR7xT+SL3U67PX
	xxkJwoO53V5k0723CF3mlY4wVOdJRerMcKnIOggtr4rX0dw9lSuO5/XteOTGMrdR
	uNcYCYUfaCVtKUwxj+RVg060FOjfD8Muqhv1DJdZB8nRd5M2KsKM99Cr+DfSuCcY
	cb2uqLQcL6vducy7VC2047JSzlcNsj2bBp41+pegrjbKBcvLAPLu2vG/ZZYljlRs
	+eBrQ+0MA6TYBz0OS4QcqterhLcYSOrsz7g==
X-ME-Sender: <xms:EglsaOkH0DI15GS2PggQGXQw3xTfN_4Zke4JM-1xF5YkZ3lbSVMr5Q>
    <xme:EglsaDaQvs1lnIXCP_qwkD2SfHyyQ_qk5KhdEeSzH_9fMOUS_GNqHF2ZYq5pTK7aJ
    7IUR2yWq5LegK6kyA>
X-ME-Received: <xmr:EglsaDFZKyTUmgE50Npce9xoLHgh0efnI6-IfiiR291BSNPjVFLnHAMdiMafXhAlJZZXkjRyCnP6V2vR8tOU_0eCh8WswrIoTGNf2Y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrhiesrghm
    vghrvghtrghtrdguvghvpdhrtghpthhtoheprggtlhhophhtvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhgrshhonhduudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    rhhhohgughgvshestghishgtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:EglsaELUd1drGIQv1wqAAgSLRD_V_1FfyOQLNNIYDNY_G3QAbHvrxQ>
    <xmx:EglsaOML3iEUSu7JlIujBCO_cLts5ls3t_pjfXNY2PJ-HPyeAmzOOg>
    <xmx:EglsaEldVy2oRpwpxVoIYnjjNelyJBN-YboLjBM4O6Y2jll0Vr7EoA>
    <xmx:EglsaC5Jt6fszsfLTxqjVTwGmXOXj_txwxAC2625qI0pQqqMvYEtWw>
    <xmx:EglsaKjGASmhvMRBOZKilDNopf4pIcscMFqYlglwfSZsO-THe7ocuUsc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 13:51:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: aclopte@gmail.com,  git@vger.kernel.org,  jason11choca@proton.me,
  kristofferhaugsbakk@fastmail.com,  rhodges@cisco.com
Subject: Re: [PATCH v3 0/4] fix apply --intent-to-add
In-Reply-To: <20250707121534.2933349-1-ray@ameretat.dev> (Raymond E. Pasco's
	message of "Mon, 7 Jul 2025 08:12:29 -0400")
References: <20250702212814.1923253-1-ray@ameretat.dev>
	<20250707121534.2933349-1-ray@ameretat.dev>
Date: Mon, 07 Jul 2025 10:51:12 -0700
Message-ID: <xmqqcyab51pr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> I've rerolled this to considerably expand the commit messages, because
> it took me a while to learn apply.c and a while to relearn it as well,
> so the messages should be as specific as possible to aid the next
> person.

Thanks.  Will queue.
