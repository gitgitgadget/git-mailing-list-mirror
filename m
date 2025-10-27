Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613882C0272
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581135; cv=none; b=Ha8F6q9ieVr+6je1XCAHbdYAHPNgzW3Mly32AXiMlj2YdshJU3Y8r4ADjTt77f4Trcd/+edVdtzzcxk5d0VwTk9Lw8t0Sxz45hII39dedVxA1XjHVHr1SuAZBMLkw2Jgizyy968Gf+kWT1iuKG+/FDrgcYnD8jjOMIX8lfqvrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581135; c=relaxed/simple;
	bh=goJMhqdr1PUSPK17QWBf+uAVaqFLLsscOcsRJb8Wccc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5f26q2NSi/upra9LlrqbJT++K7jepjF0cTq5x1ezyhYtFR1IK/CsbTirJbHo1SyFYGJtIt1guptQUdoVDIAk1RtF17JBBqvP7+TShTwj5WeZvGOd0bWLevVsj/RUTPEpl2bn1c6mclntGfgfpxz82a4ajwK0wnVWWB7OFTCgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5AOQ2eo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n31nbeW/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5AOQ2eo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n31nbeW/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B608140027C;
	Mon, 27 Oct 2025 12:05:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 12:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761581132; x=1761667532; bh=Yjd3tEiODq
	R/cpSwO1qILWW5pI5ATLPG8Hb4O/7puPk=; b=L5AOQ2eo0v0MN9I1aRHUMmfM9O
	2aunH+owHG/Zx7W5lM9P7Onh9hHPEoqRh28mvSfWAKpspj4ZoQnWhFMy3XFPUXtX
	UniPGD5kePr/aZWMQdWZVm4T5WSTxEcge8uwojB5lM6ga0/uvhlkmlyVGMD034Bq
	B2atr2hFFEHlB389TfSq70hY/k4xP9rB0bMxmIr6l5FeSR1+Ad9cxNa8gQBW+Ujv
	lvrgsDCu5b2mL+JrcP0RxZYD4urg838RuLv7Dyoy4yMa8ghxwwAwOlDx30o200BO
	ldV5OrtyfRDVNbTti3UHOML8Lm5+mAzidHYDN3n/khcMmWAhpaJfu7Y0P4Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761581132; x=1761667532; bh=Yjd3tEiODqR/cpSwO1qILWW5pI5ATLPG8Hb
	4O/7puPk=; b=n31nbeW/k9GCDJaa5kDs+olvYRNg8uYVms6MpR8e//f8Tr4boLi
	hBo/kSlvce8RVeA0RtvJJaJktiUFWG+K3eP16IcUsdRx9ttXsFzOuly364P/E8Q2
	85BDRXjjXd06BB7LLv/w2JAwdOx1DZxoG+IMDKGgrAsHOPGApwC4sh3Q9RpynEZB
	0tISaUSIepVmo+XDiXICVaOOiV2YN2EgpdxhHZ5JVFWQd7oLwH/3BGYU1a8miOW9
	inWppTqOaOWrpcnbDMLHCZ8glPG+XSqzcTBkqNgVLmZ3RJCVOL+QiXBmVfJjbB/0
	LH0xCNsI5aorjcUKRdKcOUqR6fHkmZAt5kA==
X-ME-Sender: <xms:TJj_aF_uuJT1QV2CTnQXI4aorPxfcKRWQ926lkKa_Rz80F8Z7RV2sg>
    <xme:TJj_aAm_p7U7sRTP9bXirJk9k_4mPr2622q1nzYNH8UUHAGLSQsx6YVryDdRpdzDw
    6DeA4dLRv8qDWyDehnaAyBYv7rtH8NygHB--iH-OpwOVEipx9wTZQ>
X-ME-Received: <xmr:TJj_aLX_bJtOe7rdGyzdfKRmYWMNOpnnhfXpP43_hP9371fNZ6nXscoUy1TiFVSqa8s7Bf42rcmddhetUnZ85QKL3BXVJ1TT5ter>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmh
    grnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TJj_aFGoolG3lvZAfC1g2KJ_gu5Nn49S5Oego90-sj4MNalZuSUPvQ>
    <xmx:TJj_aHctPINSZCIbHxiQyd8fyBgeLSGSRMkDT3KDMkSi2fKbetTxpw>
    <xmx:TJj_aGKfKBGf56WO_FY3VnJikY0B1ThrrH50bS-n6VrUpWduaZy7CA>
    <xmx:TJj_aMEwDw6d7kuO78Eaeb4WooFYe6kt8NnI5dT-MGJ9jXu3FyafMg>
    <xmx:TJj_aP3lQXpMwEsPst9uPcgPy1qVcvgF1pO9MySSYZjAL3J5tJNWw8oQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 12:05:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
In-Reply-To: <CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
	(Queen Jessa's message of "Mon, 27 Oct 2025 16:50:47 +0100")
References: <20251027111600.1481-1-qjessa662@gmail.com>
	<xmqqms5cl6t8.fsf@gitster.g>
	<CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
Date: Mon, 27 Oct 2025 09:05:30 -0700
Message-ID: <xmqq8qgwjpo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Queen Jessa <qjessa662@gmail.com> writes:

> Thanks for reviewing and for the clarification. I appreciate the
> feedback and will make sure to exclude generated patch files in future
> submissions.
>
> Regarding the author identity, I wanted to clarify that Queen Ediri
> Jessa is my real name; the same one I used in my first patch. I
> adjusted the configuration to ensure my author name matches the one in
> the Signed-off-by line, based on your earlier feedback:
>
> "We want to see that author identity and the identity on Sign-off
> match. I can tweak the author identity on our end for this patch, but
> if you are going to send further patches please make sure that your
> [user] name = '...' configuration is what you wrote on the Sign-off
> line."

Now I am truly confused.  The above reads to me that you prefer
"Queen Ediri Jessa" as your author identity, which was why I said I
was surprised because [v3] used QueenJcloud for author identity and
sign off (matching author identity to what was used to sign-off
feels like a tail wagging the dog).

I can make the author identity and sign-off of the version I queue
consistent locally before applying to save an extra patch exchange,
of course.  But now I am not sure if I understand your preference
correctly.

Thanks.

