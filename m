Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88D24112E
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041353; cv=none; b=jmfNAOV2G5RCnVh9C/7/5Ornl4EGGSDmMddX0drW5uXtajUvWoHS1wMQwDqdH/+ZNoTG1bJZ+RYf/uSVdiyVOolD6jqkd/dAXdEdu1QpX9GYyQkOjrAK4MI/GiWpJjbkht4QONR+Ad3OsZYjKk3k+RMp7ZJDan/azTAMHJTAIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041353; c=relaxed/simple;
	bh=/NFlIeiEhrfWkhHFdZjPLPrxWopseVkccQ5yWQ0hXhw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=joWzEozK3JL+UDrslFGLvvjLGjU6oftxAtKE4rG8v8QPoHmZlA/INI9sw1E0TJiJ8JmkMMddHGuJ5k3vliYtlXvez76XP5rvaoXB6eKv6OgtciNr8/MKbLkqi66rgaFwb4s3815nxnxs+Ve/hgb5W3ZXGm/i8mHaPZep4cVtI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c54OHfDD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7UMwsGH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c54OHfDD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7UMwsGH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5847C2540091;
	Sat,  8 Feb 2025 14:02:30 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 08 Feb 2025 14:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739041350;
	 x=1739127750; bh=ncCN+xqe89iAnnE5dZzTJXND81EXVRp/WkNRuSRMfKE=; b=
	c54OHfDDiKk1a8UvEsa4jsorn3ySooLhfdTcDc3/TN1ejqnk5zzm/h/4mSJkuo1u
	sftwDyQYlBpNyS0gahVVvkSpzWsxRMEfE8TwhhB7tdB1Le+t6guEAydu1tmAynyF
	WjXnWyBhE52hAuhZn5YEhQ5texeOOdKHnQt4f1l0UBic+AwwENGtRvmsmHRwvajI
	/rKk7AiYiRcnFph6RZqny2vX0hnAWGnC5T1BWfzum2uWCBSM6dXQxQ8HB2pJWZcI
	ie2gzYe3vFsSwE87PgykUaleerZb+xA1Z5NStNBedi92pg85U3pZS10TXIdkJVes
	BDCaRPn7Tnwa/S57wzQ9Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739041350; x=
	1739127750; bh=ncCN+xqe89iAnnE5dZzTJXND81EXVRp/WkNRuSRMfKE=; b=K
	7UMwsGH/WJ6jrInEK88SYcmjiJgxrHyV2edBki44xU3ZGavUjyLhbYCc07onKrsk
	60GxPOtk+XQ6jhNNq6WINsn5+4hpG5OtcJ5jhdgR1zwKBJjzFJvc7YOFcGQmPoJm
	P3SQcc5FRddnUbgkRmaLk+R1NsZ3sM1bZKMHCDOYp3RjcDRywgZvBXSaEvXreeXd
	pGEjAL6PjOZNqi35XjKyGumVukFqYgs7DxwqS/xJhDTUMnjHaxuaCZGAM1ENlIxQ
	orBRmgMQlU6rMPwh2ZKFpFjMyqxlCr4PgRaxGud06PFNZ+e5CAyAceGsP+qOl5wP
	kvH4R/YwKNfWMkNXIYxGQ==
X-ME-Sender: <xms:RaqnZ_HB_M922dYAa8A1PRYTYOzWzXwBlWJqTsJjPHiLg3Uc2InILi8>
    <xme:RaqnZ8U1_7RvSw4gN090Sr6TysiWLsuoeNksf3Mrr_jfvpNb5JupDY6ej5g5ZpMRm
    YHIoAC9FpmaA_YLCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeffedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughhrghr
    ieduheelheesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RaqnZxI79ble6opJ6Cy7QIvKAQD56q3KVVt0z0kvyuQfwvXUTRSebg>
    <xmx:RaqnZ9G-99U5lKAge62EziSxiFgq-vTygm6tTJIind5Ysa675XdzTg>
    <xmx:RaqnZ1XJ2xL02wVKXQftcufTg7gKSwWLWtFMtojG4WsepZgeukIHFg>
    <xmx:RaqnZ4OzuU9FqU4_eSqORozF5jo7o3yeoKB79VQFtBBwOe_LKXvyaA>
    <xmx:RqqnZzfHxK7Vya1r9X890u8n-_H4Ins2TWSTYzoUr6yjMV0HtzT21njt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0AEE780069; Sat,  8 Feb 2025 14:02:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Feb 2025 20:01:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: Moumita <dhar61595@gmail.com>, git@vger.kernel.org
Cc: "Calvin Wan" <calvinwan@google.com>, "Junio C Hamano" <gitster@pobox.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Elijah Newren" <newren@gmail.com>
Message-Id: <190f7624-d45e-4c5f-a29a-b3be84e113d1@app.fastmail.com>
In-Reply-To: <20250208182736.18133-2-dhar61595@gmail.com>
References: <20250208182736.18133-1-dhar61595@gmail.com>
 <20250208182736.18133-2-dhar61595@gmail.com>
Subject: Re: [PATCH 1/1] refs.c: fix -Wsign-compare warnings
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Feb 8, 2025, at 19:27, Moumita wrote:
> Remove DISABLE_SIGN_COMPARE_WARNINGS from refs.c and fix integer
> comparison issues that caused -Wsign-compare warnings.
>
> Tested using `make DEVELOPER=1` and `make t` to ensure correctness.

Notes on how the patch/commit was tested is usually not 
included in the commit message.

> ---

You forgot the signoff.
