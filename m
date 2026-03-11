Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F22C11CA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257926; cv=none; b=Yb13DHjrMzpoJUka3uSPSB6YHE4EWZxkpuyjEP1sUbwJpN/u81VbwQxB+X1QCmAJ0XW3V2GhF4ozyxSiQvK6Qd9uqKTbK1CQBRFjVR5XduAqoTINiUU+rj2khMAwa9DNtgTtQHSuONoJ18KGevsNqOelvSbeG88hjgYZn5wOZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257926; c=relaxed/simple;
	bh=M/LNFPcg694LN5sdOss4slU8J0GDjwXoGLCaPeV3wVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SSP71ymaoeCBiI5YLEPnKunVIRI5gwvIDEBllP3JyLxC9tMJjlBmq2TePxQKY43AV1u8ngpNOVhnSOG5EjsIJuad8dmtwqMepg/ZKs1uz/ytVpQOGpGPh3ZSBQzd3wXMeGUq0MiChLmej54YE3D0nWgYg3SQpll2waKcDRJrIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RSwidhep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNp7cyAP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RSwidhep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNp7cyAP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D9807A00CD;
	Wed, 11 Mar 2026 15:38:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 15:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773257924;
	 x=1773344324; bh=jq9/VxfuahWv5AZy7QgXGugrmzsnR6P0fuLLxj04HH4=; b=
	RSwidhepGXHZ5PTJ8R4YJPSqf78W+rsWdnaYPwQ71/w2n+EBgUOFQ5Gn853sQOTL
	0etQ60RkBfGX4XFs3Ot4ArRH450k/OD0PC+TMO60kh7NQ4jKESE87qB2urnM/Iz3
	9ByZ9drsEWxqtfZGVRvHfCVGdUf5dYYUWWqBnShG07NABgTnHYCe+SoOxqLjsqR4
	CbTdjCp2qoYxwDCygowlQwYb/myHFHer7ppDSwXodDkmY4A47IklWxe7TtaUTBcR
	gDD+MqI86dI4Q2ZyPRz5WhhD3t+YmWRg9bfR9WEDpltQ2QRRLxigW10mXpuy5IvY
	XRzJTyXstKc+yKgZUjLvaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773257924; x=
	1773344324; bh=jq9/VxfuahWv5AZy7QgXGugrmzsnR6P0fuLLxj04HH4=; b=L
	Np7cyAPG6OMJccsesin6ZThaLWRZdDdn7phg1SX/INk+HdSC/kK8r3xxaCAeSM49
	lHStxz7vsgzQh88xrHqa6oadJiztRFHz8fahp8ZKdhf94L385kSLHmdiju3BWwlQ
	iHHLmbKc1KNvlAl5uNTw3Z3DWitk8pvHgDafJPHi7sD90QiVkj8CSizPAnzwZfVk
	CaGmkPBSvO3Tb0MnDfSLmUuuMYaMYeXT+HH/KlkiJKGojX6ubaTLw6sSxVKh4u25
	Yt6erE2gFcvo0JQgOYlMoBfRugLfg4ei63IkH1UQnMmfz3Whbsi5NbjZodxUJTRx
	eBhBNYaaNbiTXEtvwJVVg==
X-ME-Sender: <xms:xMSxaRDsYkKVWgyDrFOXJhAh-RxIa_DWKUOjh7k9alv7L9Ic1wlmFw>
    <xme:xMSxaW_axlSOq3yxMwbnJ4l9c7MaE5O_7sGV1q7yNEhy8kUoSUKrv8GwIVpepss2C
    TLn0LxcW2HiMC9uzK02kgP3DeF24hydO41xG-DT2OjJXO-jdVvx>
X-ME-Received: <xmr:xMSxaZ_DvJXqMmSRbSI9_1Ja7jWXJmko14RCSDK4-sJmwIgO2oa4BSjUdv8gIA113lshlRFHS4Gy_jlFaL088-KTSvWgJphDBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghshhhu
    nhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xMSxaVeofnqwos_KwlQIDsETwNoco6EKw0BVg88STbsKpRvTEHGWug>
    <xmx:xMSxaaFSwf-mfTapysqqnHt7_vsyiUm9O-Om5xFBiEDLD3UHimDp5A>
    <xmx:xMSxabdVimrRwjI0CoqJMeE70M9kuUHsMSrampxxoPBxl4Nkb2yZag>
    <xmx:xMSxacHyb8oN6GE7XNY1LAnNaWoSSQzXDjKvYy1sL7jP6weLEyW80g>
    <xmx:xMSxaW9FVXR4NUpfG2eufxQ66BTxM6kQXQwz3m6gRSgFSpvfhknELRa2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:38:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] transport-helper, connect: add atexit handler to
 reap children on abnormal exit
In-Reply-To: <CAGVkMb6M2buc5zS+SFfYa6LLs7fN369MrVagETVg0U_PN7njOg@mail.gmail.com>
	(Andrew Au's message of "Wed, 11 Mar 2026 11:19:54 -0700")
References: <20260223165147.3294516-1-cshung@gmail.com>
	<20260311142021.3464789-1-cshung@gmail.com>
	<xmqqsea6p7st.fsf@gitster.g>
	<CAGVkMb6M2buc5zS+SFfYa6LLs7fN369MrVagETVg0U_PN7njOg@mail.gmail.com>
Date: Wed, 11 Mar 2026 12:38:43 -0700
Message-ID: <xmqqfr66nol8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Andrew Au <cshung@gmail.com> writes:

> Thank you for the feedback.
>
> The use case is a long-running service running as PID 1 inside a
> container. The service continuously spawns git to detect repository
> changes — it is not a one-shot container where git itself is the
> primary process. Because the service is meant to stay alive
> indefinitely, any zombies git leaves behind accumulate over time
> rather than being cleaned up when the container exits.

Wait, the proposed log message said "Git is the pid 1", and now the
above is "there is some long-running service that runs Git".  Which
one is it?  Wouldn't that long-running service be the right process
that should reap these unwaited children?  Or is "git" used as that
long-running service somehow?


