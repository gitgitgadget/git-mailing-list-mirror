Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CE1AA1C4
	for <git@vger.kernel.org>; Mon,  5 May 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472832; cv=none; b=nUMplyb0RdRnEZn2ICw55ivkMzWIJjDvQ9CAMwDPRPN9VVY85cHJ+K2KpuFAZX7tVegLZpUsQIMmljgdcKPE6vuDbgJUf49pMM4TWClOttdYC7qjzl+ARjOTv1jOfysMEugppqk65c4aO2vAQZRDSBx+H7MRRKT36PI71zeoFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472832; c=relaxed/simple;
	bh=kAXAZycc2ttF/PeP7Pjd6XFg8iL+J/Ig2fGkl2cMvd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYACBQA2IoKLe5RR6fPXG+OK+2j1eyPR8QjSQ1ALU1yhJfKns367tz7ghjTA6I+n6L5XQLGhchIXr9LuuO2XXL5T14sYRQVvJHV13Kin5jTVFBYvdxy1KjNSEAdb93jNpKmpu1ZHw+UM6MD41AG+ObNjKhM83EecC/BoihUe4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j9VkJXgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7l3CvEw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j9VkJXgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7l3CvEw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4306254027A;
	Mon,  5 May 2025 15:20:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 15:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746472828; x=1746559228; bh=FC7r3PLcc5
	lm7T9hOHXyc4yH6jNxY3xfrM59BazL+yg=; b=j9VkJXgToJ2J4Ap4TSiLU/E45c
	VgCkV8yEK3QQWvXnohBt6SWRcXsSA2xa+pt2Y96rWv7NKY/So001jHE8Aw8EVM+T
	CkluFJLKmCLRKAf7ilN34DcDGm0qnhxFzOb78+fDOdkahgj0Nkr/H957CR0DaXWS
	gVlSOskn12U/BIpHNQopHMIHTvFPgZJegL5rVc8M25BaCYo/r7yBmBAgOzehBw2F
	3Y1cfKR+cggSiXW7iUZ4r6vUeH4JIkpUmB9EtWF1C5O7ayrx3VzuTHtm3Mrnb2qb
	f9AMTHmPZTdePoOblSL6mnRkef38yjx+45er4r3TM9c3K/ATH1SDH3CH9CJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746472828; x=1746559228; bh=FC7r3PLcc5lm7T9hOHXyc4yH6jNxY3xfrM5
	9BazL+yg=; b=G7l3CvEwii38PqqyRKJC2QcTZjPZ5bUNXnbLLnuX4CVMe4+izVo
	V535MqbuNGp5s8MOeZwBgB5btlwCOi2TMqQo3ccFSZZY+c38bvDaTHBV/Y8I6aJQ
	FFHZvbDsKaQzFvltWdL468wf+y4e86C3FwDfxJrNSripL7BiL+Wo6Kh3DVal4Y1y
	gY2S1apE81eJop1TnQdTtWJtGuYGtc7iQb1K15fBZy/45h2JEnd5X1wSrMPw4VKK
	oLuDvyMnlyeqPl2EBDiYQ8jmYncJcL9oG/Vl/zUsNrnMG2BFjDOOFkPmwLTbjBtf
	4OUX6mbM7L62Qx00t4JAV0btO8Z5Zmm1GWg==
X-ME-Sender: <xms:ew8ZaO8EpIdY2YXMMiRjuy0dsRt2QD51cVHTCKJa9_sdRiimLMZD-w>
    <xme:ew8ZaOvvjjNwFGJdlLNxK__z7bz2hsuOzlT-WjguM5UBA9zvj9b3YPFcX3IQr9NSN
    6VNmqsBYxSAlgG_2g>
X-ME-Received: <xmr:ew8ZaEChbU1kTEmXe50xMlgkxJa5M034OZV_7rEDyg5zQ3YobgL3KafE6aVDEg4wzVHyBGnn5niIGzodBswTvZ8UbMawf5fLtpeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ew8ZaGeUcOLMuLVg5mPWUlb_mzsM2nKhHht3dFGgSZYrWO9TxtRnCg>
    <xmx:ew8ZaDN-e-zCS1j_e64x2KigroCzQjNIgg7DaWzdYP4233aOctABSw>
    <xmx:ew8ZaAkq4bWtN_7U_wHTPSZwWRaHjBm63ym3JVfq1eF8z1nNw9fGGw>
    <xmx:ew8ZaFuNjL0cyCiQogQEckfILh1d5t8mTtZ1jiU71kKw3ZUq9uH9Xg>
    <xmx:fA8ZaMyjTdL8lysO11rSB2cgl0FrZPSyES2flIiPObdpAB6k1oQjVJ8Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 15:20:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,
  sandals@crustytoothpaste.net,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/3] docs: improve send-email documentation
In-Reply-To: <PN3PR01MB9597E545331A9BBF088329EBB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 5 May 2025 06:16:23 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597E545331A9BBF088329EBB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 05 May 2025 12:20:26 -0700
Message-ID: <xmqqv7qeooed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> This commit does the following changes to the send email doc:
>
> 1. Added examples to use OAuth2.0 with Gmail and Outlook.
> 2. Improved examples to send patches using git send-email
> 3. Added links of credential helpers for Gmail and Outlook

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  Don't throw a bulleted list at readers without
preparing them by explaining what problem you are solving and why
such a solution is needed.

> +SENDING PATCHES
> +---------------
> +The following examples can be used to have a basic idea on how to send patches
> +to a mailing list:
> +
> +If you want to send a single patch, run:
> +
> +	$ git send-email --to="mailinglist@example.org" HEAD~1
> ...
> -	$ git format-patch --cover-letter -M origin/master -o outgoing/
> -	$ edit outgoing/0000-*
> -	$ git send-email outgoing/*

All good intentions to improve the documentation, but loss of these
lines is very much lamentable, especially the fact that these
original instructions were written to encourage to run format-patch
and send-email as separate steps, with proofreading and final
copy-editing step in between.

It means the author has a chance to spend more time and care to help
recipients read their patches more smoothly with fewer typoes and
improved explanations.

Running "git send-email" with the revision range to run the "git
format-patch" command is often an anti-pattern, especially for
unexperienced people who are still learning from the examples in the
documentation.  Please do not unnecessarily promote the use of it.

Thanks.

