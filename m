Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A89357D1E
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431799; cv=none; b=j9KUno/u32MKbeVrtaKjrc3i1viJkUDa8CrrfUscr+8Q50qtmUOCeUOZMyu/QvF/5OSa/Eanh4X/3egu+//plfISIMhejPX0y5Mj1Ca8PqpkWYYOxkpe/SCG+LnTQd1ckys+JvmO79TQQzE1KpALoGBnTpro/Pkn+EyuFT2/vaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431799; c=relaxed/simple;
	bh=frvHmajUKGP/Ei+GCco6gHNZZu9uNiDirhdZEJb5w28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTmVK8ZHHtJHl+DQRr3RjS1n8lEzd3fHSCVMF6Q/RbLEtLEE++duQBLH4gjK5s8c57a0bwsTE/eAnss7ZklmKqTLMYXzrbclDzTb5dXadFeI2VjOv2NHmQI3NkTY1S396Ht2yR4SKAVDYCxPr1u96V5xdiYHRZ+sCCsw8ip9vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dq4McfMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHel98nI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dq4McfMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHel98nI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B49D8140007F;
	Fri, 22 May 2026 02:36:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 22 May 2026 02:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779431794; x=1779518194; bh=GeYG3w+yMR
	V4kEEuqRDzTn7GzLwWwkeD9RHzjZDQ++I=; b=Dq4McfMvgpbpqhpsDg614Y0NGq
	IlAtdeRZe4uB4OJpuKvQJpKdFN79VNU7f6bt/r+LjRQsv+Oc2TRF6mkIj7RrA/ni
	XY3o4W8DA89u9pdbJ+yLPwG2dpmgDqfOZYPdUfQ8AjEUsRjUF7QBzWTveUibEnN/
	oOQAxEjEvTAMOjq2qmdLeMWuXiYt0yudWmVVrLxoXJVZ5zQ4xPke8ci55wUCb6n1
	K1Lg1wfIaIoK1wodRbTikNywIISYYbj8Xbot0maSFgka6x/u5pvx0ArdzWb8IcyD
	vrSPhyd4axX9rhHOVH9YBzt5KUP/wdHK3eF31SOj0vRpGzr9LWeAJUIh4o9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779431794; x=1779518194; bh=GeYG3w+yMRV4kEEuqRDzTn7GzLwWwkeD9RH
	zjZDQ++I=; b=YHel98nICqNC/65sFrF0qclnGgOEDahEJH/hWZQTW3D/1kuVX4s
	aEz6hbiKBEMQkPX9IgYKnFfNlPd5bDe7UrvBvF9QeA4mrnRTJtShJVnLR4SmK9ws
	Pad57934/ba39yNvN6UST1SLZwJMyDLINbQnh1jFyUisOPtkdBeSp4wdSAZUwird
	rknZGPpGhZ3FA6oLyC83p7rXBQ6RgTvdW823NluCLpTzDy3dG7IlXx0+k/hCoZPN
	bcZvDLdqHBhNWSqZBGBPumCHBDtC9jJq8HaEzeCAtyfJv4fHQcMSjz0p2atUVmx4
	aOrgIZdjQwYclEofpR39AkzHqOlp0z2SesA==
X-ME-Sender: <xms:cvkPak7pXDbAd02yZ2ft8W_ZpEvxKUcWhEp9o_cXxgdweYXYY97IWg>
    <xme:cvkPaoJu4VUqIRoS6vc6Yx0u1oHa8DU0glkuofBeAsnTwBcxKjpIp0VHxvnr8gZhE
    O0otCtTNyB_HJ8N1ReK9Uy_z2zKEe4UBrIIxXfJvkQpA_ujbsY>
X-ME-Received: <xmr:cvkPalu1YKGWtY5dz4DoQ8R78dVFuX1jeiHVRIxeD9wigWAp2MWmhkykEf3vXXTBJ6p-1jySQF8hziwyotWoCPXsn_SJRSL5iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohephh
    grrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:cvkPavJnsEEGYuClU3VKT9891oOzLT7Y8-AEiUoD4YW1phJRh2mETQ>
    <xmx:cvkPam-CTGzp0NmWsy7VW_h_Pcq00VJDNALfayl0_cco4mdkaz6V2A>
    <xmx:cvkPagyjZKyJTvvxmTcIIysogqjtRvb3JIX8m30j_CkLxwEft3-YYg>
    <xmx:cvkPar6PQPwGz8ZA0e9mxP1_LpSZRgfmjVWtzreTA_JT0m2Mkvph9w>
    <xmx:cvkPam1e9SNb2gm3AaMgrN9-7U0mGQPuWpuG4EOvoh5o0nRBgNcKcBmf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v10 1/4] branch: add --forked <branch>
In-Reply-To: <273103d7-c816-4cde-9e89-b630c37b0749@kdbg.org> (Johannes Sixt's
	message of "Fri, 22 May 2026 08:18:50 +0200")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
	<273103d7-c816-4cde-9e89-b630c37b0749@kdbg.org>
Date: Fri, 22 May 2026 15:36:33 +0900
Message-ID: <xmqqse7kt0ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The icing on the cake would now be that
>
>     git branch --merged origin/main --forked origin/*
>
> provides the list of branches forked from origin that have already been
> integrated.

Yup, that is very nice.  Also with "--merged" replaced with
"--not-merged", i.e., "our work building on top of origin's, and
still need to be finished", would give us a good list to work on.
