Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9528467
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340207; cv=none; b=d3oDVKxzLI6lwQypb468BEEwGphM7dpa/JuNkT18kWDNCbqYO5UFQdjuYapRBme6T84AMePT/rfUM6oTcN0/AozMYMpBvuC92ZnCZZEo2U3zwjpPnGJJ5KpeG9gvAI5sdyMgFTrmxBrBAV1zpufHKhv2CwigheOKd8xVBEC4UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340207; c=relaxed/simple;
	bh=NrIw4IaOwkEFeIp1tDp1+CAFuF6zAXtpJ8rV4nQY1jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m18L6dp53cpAXSyX3/Y4el0ccrJFW634h4QZiksGPOaDk2vepMjbMhray7aFwDFkCKqtnYyBDoh1MYyL02otN4wcDihUZ9/hCLvrKrIQchfgA5s8cpqFvcuSI+wIsydsPTdPefRTWpJo8YYcKDor0AyLIFPwIklU7mLq9HmeaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=owxm6WsD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lbj+gktR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="owxm6WsD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lbj+gktR"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6251411400F6;
	Fri, 31 Jan 2025 11:16:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jan 2025 11:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738340204; x=1738426604; bh=NrIw4IaOwk
	EFeIp1tDp1+CAFuF6zAXtpJ8rV4nQY1jc=; b=owxm6WsDvAacnMavdexJPHSias
	FJBNLC7ltpIyx/K9NbeamJzybpKlaCySp11D19wPR8qT9/8zPjsKVIoR4omUmcVr
	zvW9B8YaHPkWHdz2FoPTKblsFXjuZXfmeWkhunVug7Gzbfj0b8q71OpFIsIj8vGe
	Uw1YfsmG32t5uxR4dJIx+4BrXgnOe5lrXWEGR2xcqFaekA5iZZxeOhqqaoglYqR/
	WBUAU6dXVoMMkZBRGNAzlrL3xKrD1Whi0Dc6d/Ux6/O50LPoufj48xv81EHp528H
	WQfDdR0FhQYVdXSrgcWt9670AaLezYCLjXnWvC6xqDCJAKQGV6uLN3YrPUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738340204; x=1738426604; bh=NrIw4IaOwkEFeIp1tDp1+CAFuF6zAXtpJ8r
	V4nQY1jc=; b=Lbj+gktRRLbIB4+xcbWXlVy+ctLMYqqAJU9nq1ZCSa86q5yrCZY
	NfOCWE+eQJ4KQwDfopBzCiK5wXxjcweTP4CkqZBu/8j6K13HrIMljXd9dELgoKJc
	7L0FMxlECyZs0S1TiuBVuyFb/ehe1zA8N+/6BuzUU6my87iu6iKKrXE8pUf90Hvi
	3GPsf0OxvsSprciKgAEiyUSCXH0PdPqEPvSpxSRSaIuRuR8d5rJybj26hp8fuaDF
	67SSh6xn9z2BDz0SN6APyJ5v4MJPvCbnSa4ju4KgULgjVBBB/zIqbGFObN3HIrEb
	gvfkrrlFJ4G1fboy019+PzPhzYQqqvVbMQw==
X-ME-Sender: <xms:bPecZ08fXQsR0maurivz3_iByA_rG5Rs8gM4vIDsHRgvaAocu7g4Uw>
    <xme:bPecZ8tqkSfTKAArFl9LRbhiLZCKg4aYuvvUEseNtWAXO8o7Hav6pnSCyxcuv3-Wq
    UXXkkUC4RWIybXl1Q>
X-ME-Received: <xmr:bPecZ6AyYfMgiKL_IBC6xkeirDpB9PKrV4wa_yTn7smx-m70FcuXEEOnrvGhprwe6qFrTtTkJXj4kJdvJwHKowSQhO5Nf_e1M91O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bPecZ0e6QaSz22okKwXiNUnC-VxYctBCeyRoGn4oG1Xv_-VYZvmtnA>
    <xmx:bPecZ5PeD4Ur0ylvr3IwwIg6hjA21RG28txQHqlaVAAcm1zGPAyKcA>
    <xmx:bPecZ-lyJBQwv4NSoF5WWGNbcXm6isPRRSK9Kfik8zJ1_bn6r9frkw>
    <xmx:bPecZ7vUK8KoynP1GQlPHT-L7EkKqmq5LKOg7lBrBqB3zsz1jXsPgw>
    <xmx:bPecZ1D2HBj6YjIPpTqHB3dmQ0mwr1f6LtbNN0MhuaktBY21XDKzJX5b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:16:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/8] builtin/refs: get worktrees without reading head
 info
In-Reply-To: <Z5zQMCRETczMQMxj@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 31 Jan 2025 21:29:20 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r679AyETgMO5Ge@ArchLinux>
	<xmqq5xlwfa9u.fsf@gitster.g> <Z5zQMCRETczMQMxj@ArchLinux>
Date: Fri, 31 Jan 2025 08:16:42 -0800
Message-ID: <xmqqplk39cwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> I want to say that we cannot check the content of the "HEAD" itself. If
> the content of "HEAD" is not correct, we cannot detect the current
> directory as a valid git repository. So, there is no need to say "we
> will check the contents of 'HEAD' else where".

Instead you should say "we detected your HEAD is broken" somewhere
in the documentation for this, and then the end-user should get a
message to telling them about the broken HEAD in such a case,
though.

