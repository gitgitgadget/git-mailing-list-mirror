Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97582270EB9
	for <git@vger.kernel.org>; Mon,  5 May 2025 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481670; cv=none; b=oaZQBFKooEUuuuOLv3hKPeEqyqt0hUf+kS5dSGuwV09GD7KPveJITVDEf1XGc+fLPOZJFMyzrAXILn4MI2H+6LbQCDeObDdbtuvYbSOFFD3GxTiY94ilNjdWSAuc0KBXkwfsYXJRw7pp69knyRl7ovQk4NswT8vOuNAXNM0kI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481670; c=relaxed/simple;
	bh=JOGDWGUPvoWeZhSuxztcZS8tCesJbjACYzWnLLUTLAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfNIBLpyj3iylaZLkAhLgb7YowxRtievJMHso72DlJGDOXg2uckAnIuzXEBnhTEgSI/zzAiNUNcKHxUxEWbhUSArUN1ZhNAWbxenbAB4J+o/qlnOh06hz9s4ZJQOeIaHPXejRzjl3CSn3Quw8TheOIw+hxoxtXRkJJhOtMDC1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F5eBft70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vwt5uDE4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F5eBft70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vwt5uDE4"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 75D361140233;
	Mon,  5 May 2025 17:47:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 17:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746481666; x=1746568066; bh=ErlMv2tqoi
	tI8tuaAxirr5DJQ68/OjJf+FnXAtD0+5A=; b=F5eBft70Tk6dae0bbCT6i2WKkT
	hDsYe6N3BaEGd9sXHj5Y4YwL21/obdXRdgolwBZmEho5zkuw1T+IHQV9q1fPPMJC
	/aK143G0ZAABcbBs/3OXLI835mou1Dg+0hLtYeH5swhywzSGNdyKBoZqpnHTbRwX
	EorlXBVhakOaocuOZQ518j803+nTN7DAUq6Ku3Z0/6qLAxkiwlv4938on79vj0M0
	LBOS8SG39194NzK6kzIXWUrBmKmX6Alz6UzcktSfVhnR+JF1IOt5YGK8VOjr56ea
	NQ66NFb4SNDuq4ecxhgTFctEq8rvG9Nt1c7pttVqyqVR3arFhPP/eyqMfwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746481666; x=1746568066; bh=ErlMv2tqoitI8tuaAxirr5DJQ68/OjJf+Fn
	XAtD0+5A=; b=vwt5uDE4UN4+FAGtnNKmrXcDwaa6LNC/QuikrEoHC8PfBz5Swhh
	AfrYvd/oqdIVosPkGtwXQCF8FoWDQACFS74P9IJcaJVpZIVuTgmVy0B1An3vGhSM
	YmVJSL9c9bZuLzaVdoBUXbfowUlZYHgdS9hWTkpjP1VYEwuG+PVZYbPTR+HQ+SRS
	2dzLvNrvlGZPa81INoHmKopTh96MgrgxloAxpQvxEV3MXDHw/wlkzEh5/I+0wg/0
	sZu0KHF+bzHP3aQRUjU38KBIJ1H7Zzca7/jLHHCdAC/uWRCVl2LJHRN6HX+jIS3m
	BxElESw3riO2A6WfovywggW2v+xEjW8c0sw==
X-ME-Sender: <xms:AjIZaIDKYrmG-swnJAPHa2Uzg0-UCT__x3_9rIa28sw_K0V2yHQAsQ>
    <xme:AjIZaKhU9aZeT9Pg2LSFrPmLwR1vLEj5FRf9sN02d7L4l5qGryq-PpIlAeypa1Be0
    eeD7JwgY0zdOufqGQ>
X-ME-Received: <xmr:AjIZaLlTxDKI2zFyBWVbZng9k8xRHuZze-s9sePz0kyDKLy4l8Im99XZwJxDwa0w6hS8Sb32vHMVxdISxArY9k1kr3wwbv7szqsd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:AjIZaOxHP-KKLfslyATJqOeDezlXQYJKjvVriWYUMGRdlM9o_iixeA>
    <xmx:AjIZaNRrY2EPUR8lNT2Od0CJME8SaJED9MbmxwhKRhZz21AErjZBnw>
    <xmx:AjIZaJb9i4qzZo5gDNpxlwWQfhvu7n2QxBE2x4dVvtLZj3fUzoZ5ig>
    <xmx:AjIZaGROVRAc5EdBa7IE1JGiqstIOOLbd1HdAqWQX5gMCyxPtzJJTQ>
    <xmx:AjIZaOLD_F6S5cey99O3kIGgPdoIr6i8LLPUvAf04zsZj67VK8jnVEMz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 17:47:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/4] scalar reconfigure: add --no-maintenance option
In-Reply-To: <6fac9c4c394b9882a2f7af6209af389edf384e4d.1746458844.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 05 May 2025
	15:27:24 +0000")
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<6fac9c4c394b9882a2f7af6209af389edf384e4d.1746458844.git.gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 14:47:44 -0700
Message-ID: <xmqqselin30f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When users want to enable the latest and greatest configuration options
> recommended by Scalar after a Git upgrade, 'scalar reconfigure --all' is
> a great option that iterates over all repos in the multi-valued
> 'scalar.repos' config key.
>
> However, this feature previously forced users to enable background
> maintenance. In some environments this is not preferred.
>
> Add a new --[no-]maintenance option to 'scalar reconfigure' that avoids
> running 'git maintenance start' on these enlistments.

It makes sense for --maintenance option to be between enable and
disable when registering a new directory to the system, and when
cloning somebody else's repository that causes a new directory to be
created and enlisting the resulting new directory to the system.

But wouldn't users want "leave maintenance-enrollment status alone"
option when reconfiguring an existing already enlisted directory?

As written, the design easily allows enabling of maintenance as part
of reconfiguring, but disabling cannot be done the same way
(i.e. individual enlistments need to be visited and their
maintenance disabled manually).

IOW, it is a bit counter-intuitive

> +--[no-]maintenance::
> +	By default, Scalar configures the enlistment to use Git's
> +	background maintenance feature. Use the `--no-maintenance` to skip
> +	this configuration and leave the repositories in whatever state is
> +	currently configured.

that for clone and register, --maintenance means "enable" and
"--no-maintenance" means "disable", but when reconfiguring an
already registered directory, it would be natural to expect that
"--no-maintenance" would explicitly tell the command to disable
scheduled maintenance.

> -		if (toggle_maintenance(1) >= 0)
> +		if (maintenance &&
> +		    toggle_maintenance(1) >= 0)
>  			succeeded = 1;

A 3-way approach would make this part something like ...

	switch (maintenance) {
	default:	BUG("..."); break;
	case ENABLE:	res = toggle_maintenance(1); break;
	case DISABLE:	res = toggle_maintenance(0); break;
	case ASIS:	res = 0; break;
	}
	if (res >= 0)
		succeeded = 1;

... which would allow people to easily say "leave the existing
maintenance state alone".

I dunno.
