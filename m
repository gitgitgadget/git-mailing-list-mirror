Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6C207A20
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257730; cv=none; b=C+r2GTlwLagGMi8vZrkPUK0XPIDve08cZluqHFcZpgm90i0pvr2iNYSTEfKc0UEBYsPVwxwlMHoAI3RKu1IB7xXBS8BTx6rgCGe4rEPgZacg0but5ityx6EBszHzlfcrVCrJRnWWbv+mwLnWGOO1LQYA9kCLk8vqbAaCus25YDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257730; c=relaxed/simple;
	bh=XuyYaNrTaTxy5i85u97RUHY5ftnq3pV+frjCbsOH1eI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKLdMsFBwuLN5LZ5t68udjp5Rdnqsf6i6JduEi+ZV63pxB2qUn9OeKzNRBZ5beVDs8T3gs8H/1kFUgG9T10hZ/inXQflmqoakdDDd429zV8lHltQSY0fJRvCSV3bTj4w1F+iuIjCvyZ1N71MuwJJ5BofewebK2EtXUBqypPPmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLFSpa9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=49AlOG0b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLFSpa9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="49AlOG0b"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B0451D000A0;
	Wed, 11 Mar 2026 15:35:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 15:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773257728;
	 x=1773344128; bh=bR8icUPCAw+LJYkziozHS8V3Ls8TUTtK27XdUYLXTfA=; b=
	SLFSpa9CX2CJyFZa7u26Echx62s/8wFmPUkBAno8lX3QvjySNMX8OpCEzQheP4B2
	ee01S1z3mzGEPprAGROKcI8WNStWIIvUxAweJqkGhOUI+aoa/B/A0wshhPZomdCF
	fErAeZAoMjmoJO9jAtYL1QdBikXStWjWdC+AozW04F+j4L4YLKjreyKjI72L8HKe
	20vOYwTsjtolgOJ+pVAtAMkV3Bk4zCPjL8SqcePrAUoy39DXyfuKodehaNZ8L7qN
	zOeU4jhwYh3VInfeiUtCKycMxVMF/eIJJda25mCs9+KcNqR5Cdw926vgoGcimZNp
	G/GF7pcCxDoXy/5Z9u0qYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773257728; x=
	1773344128; bh=bR8icUPCAw+LJYkziozHS8V3Ls8TUTtK27XdUYLXTfA=; b=4
	9AlOG0bjeD2xGfMkGPzYXPhbm+MoxX5kvFH9H+8jBi0YdqEb/qOINJrWbjH4VH9l
	dqanKvxR86OrIIO1VMUFDjFWmr+R7reydzmUIUdUqH0wFasws4kCu+d/yYVF4X63
	jtEt9Ha7sw+N/nyDu/INlnyYeZfD47hK+b9pxpgpOgcOoaz+nIxY9Aq3ERwx9919
	rPZGofXn+WUU5LAy3FGz64Kc9G1XrHEl9IJ13RVaLIuFCTadXTAW5/4zoafXgBrL
	xlFyZV/nZ4OG4c7W7TyINFp5EXgbiWRnajdOe4nyCth3uYmzEC+gUL0uu1Y3Y314
	xnNd0JZp1aiEPHHJYL/qA==
X-ME-Sender: <xms:AMSxaa7MzBjNIb019BCUrjG_B6pymsd67LPNrjGJ5-D2RsYolGlCWg>
    <xme:AMSxaQdhS5sos6QqdnQoiVYSch_PDF29NXPIZh2-YGHqPCM_GyOv6-U9nYIe1NfyJ
    wQ2PiE9uAp9gGcBmQFGkGrAhuMkDr1rQdeJ3Z0roxb9ETnahAnV6g>
X-ME-Received: <xmr:AMSxad7SXtDX-KUwCSGcqEyV3O2c_o3AQv51NmtqOUivlrlJeiX2bRnkgqBJzQSYr24X5e9vBkP3I0OCTMxTm281jRys5sr42Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epsghkkhgrrhgrtggrhiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AMSxad898AJc6uOtMIU1Q6Q0I6Xg-9ybaNSvKawTGHmpOUjO29uUJA>
    <xmx:AMSxafGJkt_wbPEjOICpNB0yeaLMOdJVBQfHNNkxcLmJCBsJHBDPdw>
    <xmx:AMSxaSW5gdotjHVp5_TwSk8bfBuyrw9nnldGLgOYe94k01NGhSyiTg>
    <xmx:AMSxab97b-3l_L4IuTw8TWG6AApTehqVvIhNPbRD3BR8cIEgP4rWRQ>
    <xmx:AMSxaRK4BInGoGr2MFEuqoH2vJXDjwdDTH1iElMmX-Esk7wlB4j1Dxpi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:35:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>,
  git@vger.kernel.org,
  christian.couder@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  ayu.chandekar@gmail.com,  siddharthasthana31@gmail.com,  ps@pks.im
Subject: Re: [PATCH 0/4] wean start_command() off the_repository
In-Reply-To: <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 11 Mar 2026 19:18:10 +0100")
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
	<041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>
Date: Wed, 11 Mar 2026 12:35:26 -0700
Message-ID: <xmqqjyvinoqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 3/11/26 4:19 PM, Burak Kaan Karaçay wrote:
>> 
>> start_command() relies on the_repository due to the 'close_object_store'
>> flag in 'struct child_process'. Introduce repo_start_command() to allow
>> working with arbitrary repositories. Turn start_command() into a macro
>> that wraps repo_start_command() and migrate the existing callers with a
>> cocci script.
>
> Good idea to expose this hidden dependency.  It's different from the
> other repo_* functions, though, in that most callers can safely pass
> NULL as repo because they don't set close_object_store.
>
> Only gc, pull and auto-maintenance set close_object_store.  If we
> changed them to set a pointer to the object store they want to have
> closed instead of a binary flag then we could leave the other callers
> unchanged.

You solved my "don't we need to know where we are coming from, in
addition to where we are going?" question elegantly.

Thanks.
