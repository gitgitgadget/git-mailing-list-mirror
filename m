Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE31898F8
	for <git@vger.kernel.org>; Thu,  1 May 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105841; cv=none; b=Bp8ihgbP6jNFexCD0c0qws5tj/BEJw4AoSF3VYWGxZXGgUzWKfWpOANzyG87ZPcasjnrLJwq2TghKeVayLZ6DOBTQnF0PUgDnMDgdpB7AEJo1n1VQGCRLxUjVvXc6xA09npmeQ5Oz6afxfq5XefGBApokVxblhhHZGWlB9Y4Hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105841; c=relaxed/simple;
	bh=2v4h/YozirTUaoO4XNWqHprghp/NSNsY/L93kl6m6jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjCkc9sgdAyzmR+HcFIxh5pl4J0Z/M/rOs6jN5iNhZG5msda50nitCuMbJXA3+PdBcEcNjYuaItp8oiMgcQRTrn2L8K+w8BmwdZMWt72jstU+tAYvvbQZq9jZLUY0AQ64gqsqurV7PdbOoQak3zFJ/AdVAk4wy9SAeA05z+C10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hkQR+Kh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWgXM+X8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hkQR+Kh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWgXM+X8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9629811400C9;
	Thu,  1 May 2025 09:23:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 01 May 2025 09:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746105837; x=1746192237; bh=ovsmNz5Dt1
	DqIdHCVw/LHt64icufp315VhRI1u/6DJ0=; b=hkQR+Kh3/9l8jN+lfrPUdGTi8B
	gF2WQxaOAFYO6482VKnMcCWyYmRv7AROTZ2h5YBOSubufVDo1Ndjdbkk2InVIruy
	2VTy+bCPGm3kdIrDV3fYDyBrkIsDCK/zgNNK4LJBODIyM+LHflEbA602GZJsWS//
	W1NXJhYX53WS3pejOWF/R+BC+iML6rWObXzLq6qh9E/t3DGcATuDoS24cAcj8/BM
	35oU89cDu7g59AZ7XJHmKomryItzkOfuCcy+b7adnfLmgsjbIn0+n2VzEjts6wEq
	hry0W3hIbqOa9wJm3Z3L1qHUmG4z7BIPFWO5r8WKdHc62a8VQIK+1HsdMaag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746105837; x=1746192237; bh=ovsmNz5Dt1DqIdHCVw/LHt64icufp315VhR
	I1u/6DJ0=; b=dWgXM+X8189GffqO8b9uZS+Qti+qK3co9UCu06v5xYeKCdU0o9m
	cudPWYAcdUXAcx+ybBcX4TGJIvHjZOOLKLsisI8i/mNqyI3t0YA6QoLD76VMUkXx
	Q1dWE/W8B6I0GdVpXD8ag13r8Xh6Kdj2WNZ5375oRl1pOGYx8e0qd31CShH1IUo2
	qeAyk+07uJ39+0GJt7RnIfCqTKnyUb9ZsycTkrm6jo/Ja6aQE1UPxCV+DWpwqaGo
	NZZpqaXimStng+v5bJGfhaArv6pw+fTwDQHzT+BgVrdvhvBIqHw4prnlke7lfx1M
	dlFqieGCghOb6nKyjtsC/UYQI0FmSh0+VcA==
X-ME-Sender: <xms:7XUTaMls0u0egdZundkzqwFsbNmmI7gXqwXSsXMzU31kSGQH7Iv2bg>
    <xme:7XUTaL0Dly84imYxWmNw8KytuAUkaR0WLNC8_C_Oz29mSAKD6jogDkZ-8bQiTEXL5
    ik76_MRR0lwi4Haag>
X-ME-Received: <xmr:7XUTaKq9REC-Q-_bFpbHridtfQT4qHzR3J2q87vr6dRMX8zoqUQdyLu3lXt_tHT7hxCVymD3ZwiyppvFX1QC88nLetRFjn-OfDzS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjrghkvghrohhgghgvnhgs
    uhgtkhdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohhgghgvnhgsuhgtkhhjrghkvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7XUTaInpRqkBi69Wi-m3dBm8B5PMelgMwW8w0dLxu0Sr8I4PWjjpdA>
    <xmx:7XUTaK1Jkh089bS1e3bPn21BxIw0aj8Kx8mjHf8erMn5-KG0XQtxfQ>
    <xmx:7XUTaPto3Xf4PBgO1Pe3EtOYCjxfgoad0YekNcR968MlTUotF2G_LQ>
    <xmx:7XUTaGXGmNmcc2elAO5FhB93CA2QlPLUyxX_6waA1hfif2IzHwlb5Q>
    <xmx:7XUTaANl5sQIkPmffuX29kS1IqxVr_zSQuMBRIP6SB_YyLg0vFoGzKIq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 09:23:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jake Roggenbuck <jakeroggenbuck2@gmail.com>,  git@vger.kernel.org,
  roggenbuckjake@gmail.com
Subject: Re: [PATCH 1/1] Exit on invalid diff status of diff_filepair
In-Reply-To: <CAPig+cRehhM-z0md_iV-VYCk_Qwv0A4zS1TfPqPxsrLZ3eYxvA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 1 May 2025 02:16:36 -0400")
References: <20250108060151.7218-2-jakeroggenbuck2@gmail.com>
	<20250430185309.11197-1-jakeroggenbuck2@gmail.com>
	<CAPig+cRehhM-z0md_iV-VYCk_Qwv0A4zS1TfPqPxsrLZ3eYxvA@mail.gmail.com>
Date: Thu, 01 May 2025 06:23:55 -0700
Message-ID: <xmqq8qngzcpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>>     git (main) $ cd ~/Repos/ECS50-3/hw3-skeleton-broken/
>>     hw3-skeleton-broken (main) $ ~/Build/git/git diff
>>     Segmentation fault (core dumped)
>>     hw3-skeleton-broken (main) $
>>
>> Let me know if you have any feedback or suggestions.
>
> Do you have a reproduction recipe which demonstrates the problem which
> your patch fixes? Including the recipe in the patch's commit message
> would help reviewers better understand the circumstances under which
> the crash occurs since the descriptions provided by both the original
> problem report[1] and the submitted patch[2] seem rather nebulous[3].
>
> More importantly, if you have a reproduction recipe, then it can be
> used as the basis for creating a test which should accompany the patch
> (and which should be added to one of the `t/t40xx-*.sh` files). We can
> help you convert the reproduction recipe into a test if desired.

Nicely put.

It is a bug _elsewhere_ in the code for the .status member to be
unassigned when the control reaches that point, so a patch to exit
after that happens is not all that interesting.  Instead of exiting
there, we would want to see a patch against the place where it
should have set the .status member but fails to do so.

Maybe with a corrupted repository, some of the blob objects we read
for comparison may fail to load and the function may be taking an
early return instead of complaining and dying upon unreadable blob
(I am not saying that is the only or even a likely case; just giving
an example situation for illustrate the point), in which case we
would want to fix _that_ code to complain and die properly.

Thanks.
