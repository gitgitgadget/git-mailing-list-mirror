Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444A1DE4EF
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588277; cv=none; b=oKmUTQ9MEkKJ2bYpjEYHor5Gj5eTnjK8A3iJgkBH2wJg/aB/96zvt+MDOE/2qf5Ep19pvmUBQ5Xf5tPFr3wqKHDv5SVeKt5e2vQM6hiyXdc8HI0sd6r99fI6Gb8CeuG6pQZQiFOS11EvXorjVOxojH5xXId5E5ACZGtcXrIK2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588277; c=relaxed/simple;
	bh=nJheU/IZaSoyXpROi+cen6v5aNDnV+XsoAmSegXcNAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWEwpNVVVv7a/ZaEaZNvPLMNi6zNorLbTEJ3pdMG+McRzTVkqD3MVK7/xW3hmts5+ZMakVfQ9kLsXUvl2e2Drb3S5yBtwG9F8k2YpUBwT08zMquzNKI3iUoB9W5KLMarwDJNiAsquZGCQL0FojJIk+FDx66H6EX5lWPmpFFH8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NzvUcX9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZ5wz/hS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NzvUcX9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZ5wz/hS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DC362EC0064;
	Fri, 16 Jan 2026 13:31:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 13:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768588274; x=1768674674; bh=PG7wjeLBzc
	af1l9afxQcmhmBi4FlgFoNeXSw4C74Ooo=; b=NzvUcX9K9TAZe53qQ7beO2uvew
	daaEpENyA5XxFHpsgCbMlUpaIn0xKwlQOBBBppRXKZzYqNPxrmrQKgoHwbKxFDWP
	MPVAR3+TkAPBpDaoZ5TSj/y1qzL2SH617+WFwpclkmw0cPNoT3M2MljC8hZSZjAI
	3o/xTQ5OkGuXC9CMrI797lzXmm9R5NnkShmN1cc/a2JImdHTYFXozFJC8TuESqUw
	KvwegPLxdHxBoaNv37x4t407W/aMGyb8uoNxWa7N1a2d6JCcneyCTroVQG+kJigz
	laRciHYtHDJIT9JccEAtEfL2glC1xCTPqbQRjUoItJni7xXRI06pyjPqqRaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768588274; x=1768674674; bh=PG7wjeLBzcaf1l9afxQcmhmBi4FlgFoNeXS
	w4C74Ooo=; b=oZ5wz/hS/Ae1DWauBXqyaZNx6cEuI1B34pWbygV1zC35L6b+iqT
	W0gRbhNDHNsaJghWJZv/Paq0JIsZOnRq6QEUDi3n1KtwKXXVeG25TxiLvrAzG6j+
	E/0MuAcki6BDMs9sPdyrUklwu8lm6HyeE68od3b17MKOXZ9Shp2NhVIAqC6qUNAK
	AR9wJXxMQJKaTpM2avynmCMoPTBaMc3T/CVU4TKOy1t6vebq5HOXujxM6qZ9uzFo
	3HKQ5SHkMprIsJJtTpJypX/6ieKJTkZVR1OSezrfNEnnUXEagOCntBgYdS2W08o+
	65tL3TS1cyuGkZR5tpNx37NbT3D880JBz0w==
X-ME-Sender: <xms:8oNqaTqwWCyDsxWgd_nZLBFBqVlNUPPmAvaU-Bl38kVB6q9qn4Fsgw>
    <xme:8oNqaUgLvGxz-k2D32NMYTOfZSno3mQKBGM135YvguyvCryerb8QJQs7xi9wcohMY
    8oyUbGtn_AC3R6N23C4Lk_EjzjOf6qdMmkpVxStJ1G7DfwSSa3Gm7s>
X-ME-Received: <xmr:8oNqaYgQprdoBpCHnOwZrnyEdwVtXNTO0fOnT4YGRUJFF2_8l50EGW7xQCjFlrUYh72N1DcKeaM9zVU-ubOLnDdkrpwljOv4xnHDvf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehguh
    hsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:8oNqaShkkBegzVH83gaprYpVaQy4bbUCDG1Xu0eaTyqXbxtBHwmUYQ>
    <xmx:8oNqaQJSbPxZkelSOyDgElkjpotQ7M4XQ9-vAAtTUdJbbfWFr7gVhQ>
    <xmx:8oNqaZEQoSUL9ODEMhq8QaoGv_YXyNtTsf3V_tbu4tAxNJj6p1wwfw>
    <xmx:8oNqacSbWxRWVXLABarlHb165UFZRCzpqEuqasc77sViLmkwsCcwrw>
    <xmx:8oNqaZ9kdK_lJ__qj2OiszM_rSoofvJiqcDNzysfJepYamZif40UjnGT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:31:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 2/5] last-modified: add option '-z' to help output
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-2-79e44f2806fe@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:22:50 +0100")
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
	<20260116-toon-last-modified-zzzz-v2-2-79e44f2806fe@iotcl.com>
Date: Fri, 16 Jan 2026 10:31:13 -0800
Message-ID: <xmqqcy398l5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +		OPT_BOOL('z', NULL, &lm.null_termination,
> +			N_("lines are separated with NUL character")),

As this is a name of a file-scope static thing, I do not think it
matters too much, but "&lm.null_termination" (instead of
"nul_termination") that controls use of "NUL character" somewhat
bothers me ;-).
