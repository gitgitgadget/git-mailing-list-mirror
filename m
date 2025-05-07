Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974C2144C1
	for <git@vger.kernel.org>; Wed,  7 May 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645048; cv=none; b=NEQ15BY+1MW7xt50o9Xi1uDGhHkp5XlnmMdo/CiliqPi9ug/uwf/xCBDEEosrw1qfHGkOVBDC/0/aC08eTdm2JRHAog+27xEh90EJ44KA4RIXqQWfThBZOLo7AAi+jnt5bjtrzRgQc7OHmjvZ/r18WtR8ZVmT82osrCgr2KbLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645048; c=relaxed/simple;
	bh=YFsNXbLivdHUspp2z695Xr8W2yIIzH81rOI+isD9ncc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XOsqbBmsBT2GqHNyhnFk248h/jqB/zb+r/HIINGP+Uqe5BIB0DfdzO7SngrZvhYLcgW3mfG2qJioXMn5ibvZdsksAT/L1zrBVUqj2R+LaRJuZK5zFVvk1TIXZDYa8P4zIXSCCtXO+/jZ975y+6lX9KyvVojIS8wW3LjwP2f00sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XBAS8ehH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8+b/rXn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBAS8ehH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8+b/rXn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E5DF1140163;
	Wed,  7 May 2025 15:10:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 15:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746645043; x=1746731443; bh=5T5RXQ3ESU
	QQ08UDpOa3Vp11L+OsQ/UIdYynbc02fAQ=; b=XBAS8ehHZKFkiORY03DqiSZjYI
	Rv/0GuNZQ2TTy2AaiFLmwngMHQIq9K0JasL0PWAYQiin1jXgYpSqUMjNCi3OYVk0
	ihmlA6pD/UaHsuNhTP4eY/9IrRdp7dmu2rdbZcn51zDHDfOZoitBZO2MSm4/SVB5
	xO75K3C+NBV7JKLONvE0p9El5q+UAIc3u2MmsVUOP2ArnyipHWxgwwaqN3pQ3ZzS
	MqLyeRZ4MyQqQY/UF8URH99qhUwlQI0Sfac5tzuGEFl06aw+hfbcrv1BVVmISiGp
	UgBjQxVDDs8uRTQR94elhnyYJSN/mzHzxpoRVyohXUfqVhIq8Ei80H0smfgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746645043; x=1746731443; bh=5T5RXQ3ESUQQ08UDpOa3Vp11L+OsQ/UIdYy
	nbc02fAQ=; b=e8+b/rXn5sBBCabvt5MJrTQKDkEV7m5CBIbSjKIuYuE/R7/xFOz
	nimoAKFi4OPs1Pe1s9bHJVEnvGeS/juvtjS91bk+fEbQ8EdMIFl13pYugOXLQrxu
	V2YSOtxveLXtGW0IC477rZRNtHc0yVBD2lMKygYD9N7AVjiNRQZ+NNJKMUGQUmrg
	G6rUfHykuiJDpNzyAmp67DZcBIfHbUy9x6c9RNEA1sATuabJCB0/bjLiDl3TRdFm
	2flSR36mWPuTIPSr6yb2+jLz/DkfKSKefqUi6qt8mGyUkkeMKbBzWo/GoUeAyOez
	PZWgd18ef1iAjGTqzVHSv58bNsi/IEDhb8g==
X-ME-Sender: <xms:M7AbaGCcKUIUPcnR2n0Z0Ue4oYAD-Stbl1_9uiIj6hgti7WppGWAwg>
    <xme:M7AbaAjxqz69juo1Li0g9ZLxSwiHt3Mfq4psGz4mfjim4Xa4RZmDYsd5Xj4Tpt3El
    TSncTSmPqejJkkXIA>
X-ME-Received: <xmr:M7AbaJkog0SNU4un0jIfZj59r7etlJt2U5qD6bM73yFj03aP_MzbMe3--yiOiiswy3EKvTc76yiCO0KsbUfMhsbaE1iPyABKgAUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M7AbaEwrQWK0vedYiUfYZ44BnaxQUFj8Lxyp4YUKeAa0YEfwg9X_KA>
    <xmx:M7AbaLR7-XAofaeZvbK1V7kNNLf6SsPTR8sJ6evEfEM-yyxXujsYww>
    <xmx:M7AbaPb_M-JbrYcaekJXJIAeyt9hfqCt08KzCbtzvMQeF3838BlAsg>
    <xmx:M7AbaESRgMUSeGDjZCIAWeNkcmu4pPDg_67WtMtK2nh8trAIKs7q8Q>
    <xmx:M7AbaH0OcWlxzlf9zxvvQW8y2iNSeoXoeYxFXavewTWYeAgaVTpZDIYA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 15:10:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Leon Michalak via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
In-Reply-To: <a290bc6f-9198-4a00-8273-2970cfbd4a29@gmail.com> (Phillip Wood's
	message of "Wed, 7 May 2025 14:30:42 +0100")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
	<CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
	<xmqqldr9lmpg.fsf@gitster.g>
	<a290bc6f-9198-4a00-8273-2970cfbd4a29@gmail.com>
Date: Wed, 07 May 2025 12:10:41 -0700
Message-ID: <xmqqzffob5ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 06/05/2025 17:37, Junio C Hamano wrote:
>> An alternative that may work better is to allow subcommand specific
>> parameters in the answer to the "What now>" prompt, e.g.
>> 	What now> r -U7
>> to choose an equivalent to "git revert -p -U7".
>
> I think the best solution would be to allow users to re-display the
> current hunk with more context inside "add -p" rather than changing
> "add -i". That way a user who needs more context to make a decision on
> the current hunk can get it without restarting the whole process of
> selecting hunks [1]. If the user knows up front that they want a
> certain amount of context they can use "git add -p -U <context>" or
> "git add -i -U <context>" which was added in the preceding patch.

Yes, but notice that the above is about interactive mode "add -i"
that is setting the diff.context to 7 for subsequent "patch"
command, not against "Stage this hunk [y,n,q,...]?" prompt inside
"add -p".  Once you go into the "--patch" mode, especially after you
let the user to edit some hunks, "redisplay this hunk with wider
context" is an impossible operation with the current code structure,
I think, as the implementation does not keep track of information
that are needed to do so.

So, this is like "restarting 'add -p' with -U7", but done from the
"add -i" session.
