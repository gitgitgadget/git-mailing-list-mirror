Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F131F7575
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963362; cv=none; b=oe9KSGSoWj37Dknz1mh82ebXVATNrErZTl3igYnhHPBxwoXmHdo0GObsosS/4HFv6EHJPsP/ZCgxJeZhFTovBqXCzLZmHS8Wf1oxd5uPd3ZwudpGLTIE9XxzK10AYio0W+wTR7AD8ghOVEgnUGFxqmlGXDgZDYwgF68P4ui/78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963362; c=relaxed/simple;
	bh=SnjTv8UEAvO+GRICmyc4vg19rhap5wyA3ylrrm5Wk44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieV0AvkT8osVgIYx7GDio9OM/RJBZPGNPzv8M9ldXDUjuaKRbr/SHcjvvBW4I0HQbDD7ak6OmKudjDlqL1GqY79sTssbTr2s+zD0DQqS+GRYA7CZEQ1/0ijh9Whiev5qSmrQt/Q9yQkwY94BvUcs7kmwngcpWvgnnOx6ByNk3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gdh1d7f4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAGKAFMo; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gdh1d7f4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAGKAFMo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A4F77A017B;
	Mon, 15 Sep 2025 15:09:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 15:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757963356; x=1758049756; bh=LkKwkJuKUu
	5GF2RiSAg7ssvzZzZfoPCU7ll/CnOWMCU=; b=gdh1d7f4Cqbmn2ZkflI0fJjqIT
	nXljHNqPu1A+d5ufb7Bv+i87SuJHuFcDJA+r4fZ+Zhx2T0+F9BseRoWAqwqx9Gg7
	vmKNiOMr6t4UKiTtYf36t/0Dxs7WMwRoT5UHkXm6h9DQYPayRkAQ9+DpfLMR7xrV
	2qSwceptuVLfbMpAzHZmf7fC7ciuhFY4321XtIoaOTn5qSSyQEEKBQrKU2uALf8t
	BnjQxi9vFfBIintUqmrP8TGn060kK/B/VSxIb1OPvjvJrN6gPAVWLt1yNgeB8X7K
	VKFkoi3FXYajeOvPTbmEUYr1N9vLYc2qaqUzsI/68JYixD9GY6nmrz8IpZkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757963356; x=1758049756; bh=LkKwkJuKUu5GF2RiSAg7ssvzZzZfoPCU7ll
	/CnOWMCU=; b=JAGKAFMotChKT3rae7RhSp6l2pTovQeHCp5z9/KmwihYnJIu6dN
	bskMX7n2tcjML6nXy0TXCiiecWTMOUd1DSnI45QrPzMCjNcngelFaoCCUSaNvBIo
	MCDrdjy8HDVxeR5kZpNFtdMPt1XdIzf7cbjHxcrqrxB2fRANiK37aHEP3gZ4QJMm
	cDSg83h8h+YnmYqLN/1X7LchwzPox4Vyh/CFOY/n8RLJBAyEc4+HOvKNaMvm5Drq
	JavSW+sCmpvsl5DfYMvvWQl/i+i1ENQhRK+bBYLB0Q42j2f2ykAv42a+aW7GYEcZ
	71sJO/ZEaffoh3I3gjvm5G7V2sOSZY1Ev6w==
X-ME-Sender: <xms:XGTIaGQnLGtFCbaxdy1ny8d112Hk_QKVH11wWEB2MteZ7x2uzAFx_Q>
    <xme:XGTIaHQwc_heItccCwAgQNJSh1DFFWZkDh54eGh3iv1coNHCGfjsdNJsLC-Jz3chk
    Zlp0ku1Ks5KuZfMtA>
X-ME-Received: <xmr:XGTIaKQDJQ8GF-s1xb9uYeFSRJFcjvPvbx3KmEceIgi5JeA5_LEKDqqwvoe7YbIOI8TpEj0SfPElOJCTYRYHfCWWBiwGjg2sEuthW44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XGTIaM6hTXyukJy3FWQ-LESySo-Di4ZG0f-68hXOaRgq9PFI4IntCw>
    <xmx:XGTIaG1SUX5f7d0u7X3PBsEY6dRFrebuTa_zMBjU30lO_f7NcThbFw>
    <xmx:XGTIaHBOY7G-pTbBeq2xtXtnhrPFSBddriYCBApgDXHhbaGlr6idEw>
    <xmx:XGTIaBNHcibeTrw0FaDUlfeJYqDkDB2anbhWgi01zr87mym6rrpoYg>
    <xmx:XGTIaES3gIwjWNO48l7_C-VTp2WDHnyQYthqQD0cwWAa0udo7ZyI8ONY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 15:09:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] git: run alias subprocess according to the API
In-Reply-To: <20250915180842.GA642496@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 15 Sep 2025 14:08:42 -0400")
References: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
	<xmqqms6wi08y.fsf@gitster.g>
	<20250915180842.GA642496@coredump.intra.peff.net>
Date: Mon, 15 Sep 2025 12:09:14 -0700
Message-ID: <xmqq7bxzh6sl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'm not sure there _is_ any reason to use a raw "git" instead of
> ".git_cmd". The case in upload-pack is _not_ running a git command
> directly. It is passing the name of a git command to the hook. So you
> end up running:
>
>   /path/to/my/hook git pack-objects ...args...
>
> So I don't think there is any X or Y, and the rule can just be "you
> should use .git_cmd".
> ...
> That said, I do not think it is particularly important to use .git_cmd;
> it really is just prepending "git" to argv. It does also override
> .use_shell, but it is nonsense to set both flags in the first place
> (which is something we could perhaps flag with a BUG() if we cared to).
> But I have no problem with preferring .git_cmd to "git" as a style
> preference.

Ah, OK.  I just was confused by the explanation in the middle that
appeared to be saying that they are not truly equivalent.  If not,
then I am perfectly fine.

I would actually prefer to get rid of the .git_cmd member altogether
to make it simpler to code.  The run_command() function should be
able to internally decide to short-circuit and invoke "git" directly
without the shell by looking at the first element of the argv[]
array,  One less thing for human programmers to worry about.



