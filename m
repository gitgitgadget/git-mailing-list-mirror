Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473F22D4E9
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293342; cv=none; b=gjemYmAWTryj0i5xPrdAs7X8E08f2CyfgbmRDHrg4BjuxgrfbkGnPOJ/kPIDu9d5/cA0wT+oZQ5e85OA5s3WJ8ivoljoxx6G35WEgJrMoHFe8npfPtBKe7CZSDYNnZ63Mjo0YbOuKG1pzRTu3rGdVUiRzh9o0WCPsMyOH3jHq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293342; c=relaxed/simple;
	bh=eoIdBonu++T4KmSsqspr03BNnOWXm998rOS5LGihYm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKxr2NGazS3j9KRtEjGTVYHoYZgOmhzZ0A3o/pVrkues4QuDT5dnCFJdo8dOl4iCKVjV/LIDm2rjRWpEgRb8wEnRbsM/XnXfbiBPDiTTxsO+FdHa3MmyrtN+8M6crI4NFKJsT+fGyr+9rcLTgPA/Fd8Q95hdbw/D5KqhHHmRRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iA/iKViN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZ53rwqq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iA/iKViN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZ53rwqq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CC88EC0300;
	Wed, 23 Jul 2025 13:55:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 13:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753293340;
	 x=1753379740; bh=fjebCa5bbMl7ougALg368zriZg9SB4REwoukVcbJ9y4=; b=
	iA/iKViN1YXmVFIaPlcRd7fU0AESRjR90qQ0GwSeu4pgAxHlTLzqWcavLnbgl0/q
	+VWMilv4FUtHMdKnr3eM/XksmUP72aqbLU1sMBIFzZ66U/MkZbzRZcxufnC48V8O
	Wb6vg3JMtVUfOE2OTFTd+VjjTmoujGqMThaYh5a8f+CYe225tMNJk2MFA19ioKmD
	FsGHiFMSu6rbFQiPz05DALIZa1aRMAMZachHqX11iPuBPE2ac/u3FrO0Fp0iKW4P
	lSw28uuioLaDznvZhw0O7UVjqrv3mro8yDUCnUO8yczQJE2NHLhk0e4bM267sP/j
	kAX71l2jjhXY4LNMKjixiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753293340; x=
	1753379740; bh=fjebCa5bbMl7ougALg368zriZg9SB4REwoukVcbJ9y4=; b=A
	Z53rwqq2XG/RGLLWSa9dZ09WZCRvLPgxyQ4rarURIXD9P2NiUC1SvtI/P0SQ8MQf
	cyXdtKkclk4hQubsGmennGqxD2PS9bOwBH4oSVdorPBaeVxGcAOJDhZ1y3QNPe6/
	wUeSNON6cuMVy1AvZy1XCY80X3UiW9BqoRDTF2FrtVWEW3dm1aZ3cwHIfUvdZCQa
	7oz/IIMiq/IR/nFeZU0tvtFy9dcvUzYV9GpgMVKrjE3RZWmxLzfTZJ7zXOVtq6cR
	d15g7wDSLqhN/pPDSDblSZ81OGASo0FOzLmsDu5ft0uao6ZESi0SQ8x4cnLhaXJV
	Ccf/p1ehi2x9UVHgEfVrQ==
X-ME-Sender: <xms:GyKBaNu6ikeof9ucw3Oe1jNptz7kKuh6aioVa1k5_Vzsg2zlJDOqQA>
    <xme:GyKBaHK_hdQ12fyWbPP3-b5Bewt9bCpttesyG4SLe5KUpJVkubVhTUa6VCQkDGDF8
    eJ6WLmwlXJIslVdPQ>
X-ME-Received: <xmr:GyKBaO_Dv0dgLnotw9UvRAtIoD5nl5-Qttka13vHzuPSiamU8jeilT7L6GLevZzkDs4nTwunIyFx0CySKyqpeYT5tO_K_hCwVe2HVzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GyKBaIyGUAufCbCt8yD8aUvJjuHjXcpLEzwARvDJo-BUBaGmMWG3LA>
    <xmx:GyKBaD5tFQ9qib3AL3VgVnmGwfWc0FVHZFgeNTtUpfeKIrxdFI80IQ>
    <xmx:GyKBaH8y1rOaMVJlGEAKPFZxM7Z3iNg7Vh4vOiklfxgukHcW3p_cXQ>
    <xmx:GyKBaApYMkYxb6yKo01rZ01HdRKX96FPwkwjCWOaW4xbfCMlxFSQgQ>
    <xmx:HCKBaMGcWwJ3u0pz2Uz-VAeAE0tWZIhvTOo5meFULTTzChBvABibpuB->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:55:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  brian m carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
In-Reply-To: <PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Jul 2025 17:33:36 +0000")
References: <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
	<xmqqecu6om3t.fsf@gitster.g>
	<PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Jul 2025 10:55:38 -0700
Message-ID: <xmqqtt32n65h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 23 Jul 2025, at 10:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> +imap.markAsRead::
>>> +    Choose whether to mark the sent message as read or not.
>> 
>> Is this something user typically want to use a single setting,
>> or would it often be per invocation?  Especially with the new
>> invoker in send-email, wouldn't it become more like "if I use
>> imap-send to stuff things in my outgoing folder, they shouldn't be
>> marked as read, but fcc copies send-email stuffs via imap-send
>> should be marked as read" or something like that?
>
> So whenever the user changes the folder, he can change this option too?

I am not sure what you mean.  If it is primarily per invocation, we
do not want a new configuration variable.  A new feature should be
introduced behind a command line option (disabled by default) first,
and then if it proves useful enough to wide audience, a configuration
is added for enhanced usability.  Adding a new configuration variable
at the same time an option is introduced smelled more like a spinal
reflection than a well thought out design.
