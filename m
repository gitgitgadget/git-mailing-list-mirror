Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F53016F4
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176686; cv=none; b=kao9r/H+KXvtQtpao0eRz/vc4cQatCRcFI7yekaFgo5/FtAdvn82SX6hC61Lsvl+Q76DfUSIvHEhzJlYjNA7/YWFAV6vwfAozCJh5/0diVP/nG5KvlHoUnevwck8O7m3hWm2nJmGfpmon7Wx4Hfryp34R6pSot5ypsjLJmHHLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176686; c=relaxed/simple;
	bh=NIS46j9w739hKk0MK3RwLcZ/k/7ueBnzulFAHAKO9sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YKIsCt1xXt+4s5hRRuCMoDOmuo3OMrY1AHCsf6ETjw4mKeNtd9tYj+DsFKLbqVicKdYgZdT4XG73djJ6uJdppxWNkD59QITi0M8j0Ig4XgQ9pXKLGRZNuAAsi3j8nE3sX8831VEnj6ljKroeWbY2sZu3Khp/QlsuJvM0+HZtDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WKTwj+wS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t9BrNxP+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WKTwj+wS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t9BrNxP+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 25080EC03B8;
	Wed, 26 Nov 2025 12:04:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Nov 2025 12:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764176684; x=1764263084; bh=iB6JfBERZ1
	J6B0lnDdt4zq45l0ff/2GwojX2resa1Pg=; b=WKTwj+wS6dUD9ONlZE2BFXLfwh
	nKphzeXE1NlG31O38OvjJx5MR6B/XVk5ukER+3WG+t7Jgl8OU/ix2CsLt2byuJ+m
	ZzCdaAUF24JHVq/jQSEEehB6O5sDtoVFLPiKexpjndi7bAbLkutxBFyToX7TpnK5
	1fgBR180uxK9z0vXdIQzkXhjGG4oY3SMLyVRBr+MSXQXXOv5imaA1JX8M3deiRXB
	DQT1ZJ/F37hdPxq+ArFEczSzEikoywWl6lNCl89AYVqAmUdBMys5hp9+CNjPmSm8
	/nOF+dt656LwqH9K+WbOERcJ9GK+0AgVu8IuW0wwNF9FxW3BNNkFySqSMk+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764176684; x=1764263084; bh=iB6JfBERZ1J6B0lnDdt4zq45l0ff/2GwojX
	2resa1Pg=; b=t9BrNxP+gziRRFBZRuS0gAz/9ALJWl9+NllIjUxpvWI++3pievB
	hvWI0y3ovQUT+xgvrgO6Q4ad23ImVrrng3zxD0NAsi9tmZACRaNBby+odPcBZrhe
	VLFWnUzflyHUoFKhU/UhX2aD1PcO7wtX7k+p31FW8J5sTqpLJPvk6LaEsWYPsTMo
	TQLKzmnsP08gVq4hmnZ6QrYKTYf7cMGag96akeMAQwxX+zxEahp72iug3/nBOqmI
	Qc6OBlBjTgZcrwNE2bj5L6wcj+s+w6dLCyftnbReIo9q3owJDLfs8gD8+UoOVNDh
	3kHDUZbo5Cg0ElEKPMY+m+7f6A+U5iMNhAw==
X-ME-Sender: <xms:KzMnaRqNGT6mYoSnV7hKWft77gOx9i8a7a75VgD7hDzJ7YxKhMuhdw>
    <xme:KzMnabFncLfMcIXk8_LjJl0_FkFQj390_QiLiqK1x-oYjy6zFIE0RnfRBWKvvDDim
    9PJQ8YJg-FRy58vBkjwyJ1ETES_Y6H0P1M1pqAaHEQV1D3VbnuQug>
X-ME-Received: <xmr:KzMnabk0r2G9ZIcEFvIx6PKCkSlXLIcePgGfwD0JFOKqdlc8CgNc6nBRxGPvZEmCIOont1KJ-OYF9YjXvTYqTjdrzzdxBpW88yOp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KzMnaWksTvKNowHF7-_UNKoiZMLe8i8HOzZHNObeuhnBAn8rZFKeZw>
    <xmx:KzMnaUu6XNAgjb8cpYQ6hd5MXU0GUKSImpBUUOGEEQF4CYfMaI-_Ew>
    <xmx:KzMnaRk1kNjeTzqum7bClXoxbOQ5edWVf_a13F1xuVMxwj5s-oWqmw>
    <xmx:KzMnaXsb-tPsOejM4TXL7mvizSUqPF_WkwXmoi8jz7A2v5rtmwxOzw>
    <xmx:LDMnaTE5-Rqe5NvXNjiZy-RaTfqaymR4lqz6dgLWSjoRglVGOXAStDSr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:04:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #08; Tue, 25)
In-Reply-To: <xmqqjyzcq2ry.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Nov 2025 06:36:33 -0800")
References: <xmqqo6oppqyt.fsf@gitster.g>
	<CAP8UFD3BfcvRYA85Pp5L66Mqjx7A4AoxKZNkw2OFXqyWwBoViA@mail.gmail.com>
	<xmqqjyzcq2ry.fsf@gitster.g>
Date: Wed, 26 Nov 2025 09:04:42 -0800
Message-ID: <xmqqy0nsohcl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Not sure why but you seem to be the author of the "fast-import: add
>> 'strip-if-invalid' mode to --signed-commits=<mode>" commit now:
>
> Most likely "commit --fixup amend:$THAT" followed by
> "rebase --autosquash $THAT~1", which is the only major thing I
> started using recently, that went bad.  
>
> Thanks for noticing.

Corrected.  I do not think this was "--fixup amend:$THAT"; rather
the application of the patch heavily conflicted and I had to
recreate a clean patch myself to apply, and at that point I probably
forgot to double check the author identity of the resulting commit.

