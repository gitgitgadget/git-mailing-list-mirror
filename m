Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47800256C7F
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794967; cv=none; b=N8o6RdsWYrD1CPNV1or7F+4pTNQbq4247WvPdClS6iKh430OgfCUAshpIWe96DCHwRa4qV0zQTkqpifWOpjZw1ZxFd1YvbRNTurm53sPoDwLUVGNGsDWqnDoMDLhGcsJfly+Ab+66wCoGuSaq7d6KbgU3o7zNeH0JIv/0VUgFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794967; c=relaxed/simple;
	bh=H7cYOI1F7yALjoqfQghCpZV9cua3fl3KP4GidOR2QUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULHCIt3aTXk1QuuU0P9kYb3OZ6dospWzyAglzLkCPxQH1maMdjDKddCSvOapKp4Ra9Vu/9Hxjy0JCb10YVCKtXsq9Dz/K6DM9wrBdIB6v1TX7koIg0bGFJEqhkwQZoxgV6zUNKT3OVAEO6go9CH/PH1xOeNpLSjFa90yTsOc6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NWuBP5am; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdRil/fD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NWuBP5am";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdRil/fD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AD97D1382DAC;
	Wed, 12 Mar 2025 11:56:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Mar 2025 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741794963; x=1741881363; bh=HalZiwlGj4
	smyqhK6+wN4w4cuyj0EHyXh96HjYivX3c=; b=NWuBP5amVbtLK2j3Irxd6EyHLh
	toK64ulRYOwl5WS2UHO4qLMYmDoN/AobJR/5VDfV80cC/FHCrxaPsmwXK6iKrcbU
	tDjd5TC1EwdetLtaYAMTNTDQQyN7P5xowOTYbkss+xlODkmbZkItGCEZSKSznFd1
	HC78z2bGUWViVroSKHOD4CWNA9xMVUWh8rCm9UXNEDxshwh+0VZs2YNdQ2uNX9VS
	7aZY7nHsBiODFskyRhzRvmUvzF+qvWUkiNndZB8LaBeRybFUh68QSkpLyWIBSAmK
	I8MncihppHiBAotPeTmG0Sr/6tB3hcV90M5jURRaXSKobcZIre6btYNZKC0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741794963; x=1741881363; bh=HalZiwlGj4smyqhK6+wN4w4cuyj0EHyXh96
	HjYivX3c=; b=hdRil/fDGg/ydbOZGZou2T8BjJ4alJX6PbsYOGbAmNGhCVK9hFg
	J/QAlZBK6dgN097LLP5HVe8drbImuzY/wNV61QgtPBf6VVnf6lWsvSnxutB1+Doj
	dvSMutl8MISPDxcUsy0fLivkTMVTsGQo1TTMSN5zz5RJ1dbx6ewsSBOkeVOnich4
	kSb8iY9ddS1WtQcOPR+uUesu7Y1gMwqdKzQYS5eyscKX++o0zpfr2+Jjp6G0lVF4
	a2nKMwI/u/qLKRI4onjSrBEdk7U0ROmXfvA1DEaw4d8NKqYaI120VddPp/PlZ2w0
	Q2VmXHDQYwJivxXD9D5/eZ5AHcGaye6A59g==
X-ME-Sender: <xms:k67RZ2Rxl5jC0AT_BekTqQ7xUVMdMcvfcbMSWltD4JXgWbU8R3d8XQ>
    <xme:k67RZ7w7gZDf2I68xIYisZ0B1o8z_2w3pKKd-Ol8v-Fk6hSyzvT3FddyYpbHqN38H
    nUySDpyLcwcYqrc9A>
X-ME-Received: <xmr:k67RZz2vYbMZsreWFx6IgYLQV53HMFCl7e1xRm-zOGyJl64yGNLfubf5lmjqHMVE_dj5uLf8zqI-YQ30X0-GlVruVUOn68apfUbr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:k67RZyDXJ9v0mlyodyD8cD8vVbxeQvIO8s-17a4DkiUh1dtH0PkAjg>
    <xmx:k67RZ_gcAWnb7E0WegVQgStP1r_tkDCWiCrL3NyMtqskgp87zrh74w>
    <xmx:k67RZ-rBBvvA0nCPh8ux6upaMdrn3iOpcJE3Ej6ulF-leUzFMU4GWA>
    <xmx:k67RZyhebhYGC0DOSRVUBaU32PLVTVCs5QRMhJKNXTExysrjPG4RuQ>
    <xmx:k67RZ6X3E3onlNC4hCF1_7cDQfqDWkFujIousTuPFYdyoo71M0LcTrKc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <Z9E60LG6ExSJzmuo@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Mar 2025 08:42:08 +0100")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250311235720.GA73755@coredump.intra.peff.net>
	<Z9E60LG6ExSJzmuo@pks.im>
Date: Wed, 12 Mar 2025 08:56:01 -0700
Message-ID: <xmqqfrji1bvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 11, 2025 at 07:57:20PM -0400, Jeff King wrote:
>> On Mon, Mar 10, 2025 at 02:28:25PM -0500, Justin Tobler wrote:
>> 
>> > To make machine parsing easier, this series introduces a NUL-delimited
>> > output mode for git-rev-list(1) via a `-z` option following a suggestion
>> > from Junio in a previous thread[1]. In this mode, instead of LF, each
>> > object is delimited with two NUL bytes and any object metadata is
>> > separated with a single NUL byte. Examples:
>> > 
>> >         <oid> NUL NUL
>> >         <oid> [NUL <path>] NUL NUL
>> >         ?<oid> [NUL <token>=<value>]... NUL NUL
>> > 
>> > In this mode, path and value info are printed as-is without any special
>> > encoding or truncation.
>> 
>> I think this is a good direction, but I have two compatibility
>> questions:
>> 
>>   1. What should "git rev-list -z --stdin" do? In most other programs
>>      with a "-z" option it affects both input and output. I don't
>>      particularly care about this case myself, but it will be hard to
>>      change later. So we probably want to decide now.
>
> I would lean into the direction of making "-z" change the format both
> for stdin and stdout. That's what we do in most cases, and in those
> cases where we didn't we came to regret it (git-cat-file(1)).

I've seen "-Z", in addition to "-z", used to differentiate between
input and output in some commands.  If we are not going to do that,
I agree that making "-z" to affect both input and output is less
surprising than having to remember which side is still text.

