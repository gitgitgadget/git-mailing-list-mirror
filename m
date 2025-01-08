Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8055204690
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376239; cv=none; b=EHvSmu8I+GB7Wm9vpvjfs4Z9w3Mtee+bgxoTXVfXvXiNZADoIe5NDbQq5i54uMVX081DlTvY4AsQqdnJPjjqylymSKo9vYKiF9nl17HnhmpPgG7w+uIYaRJlWF4bI3RAPx27xMv3Q/Fof8yJKZ6YYmyycXwAftMM6VLFOS6DnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376239; c=relaxed/simple;
	bh=vepqRDI5X+jRjWN29CFdL5odeVNjuwIMK67tSAVge7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6rkvhMocXyS5pJP2hR/Y7YUIw4MyRRjM2jJaQ/xZeJJsUKJYjx226SwbnSSyNeXUVf9XC6T2x13KaFkI5FigeJsOVhTzurI+hPqFlwGYv8XgFZRdh705FwS+GtFljploIauuOZbraPW8MFAq3XMQzHMY3FCFegW+OO7GCPd9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=itcdRFu4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjMNQluN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="itcdRFu4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjMNQluN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8EC11140224;
	Wed,  8 Jan 2025 17:43:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 17:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736376235; x=1736462635; bh=NEbaZSiw9L
	a5J+iLS6elIHMgt95Xu1/6IVy7TUHA6AM=; b=itcdRFu4BGwVqPcie2ixIlg7k/
	jlO9F18gTzeIkP8U6wgtLL1/AZ3fGMC+84MkL8GS2y3ggio6KXY0QCQWxuzmzPlu
	MhvIFgja9cNLAkyXIepzDzzserGdEQLJvDhMKHTmMNYIAH+f7Jh7SXeLCtkSTie4
	3J3MgiCdGYH1J5UHqghSem3pdzybtWXs8IOJKLfPaFAFtaSmwE8cY0muIB4jwByf
	YGbSAXcSEIHSQ1FVX82jkVpqtqCE3bA9ZyaeA/MlNe+lO8MHbE7RUBs1cC0x9M2r
	TL5bmt3X0hc6cjF0CxCCSXSAuAMuFR6eB8PNJAAjiQhd5wdvL8Wl/7tSfL+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736376235; x=1736462635; bh=NEbaZSiw9La5J+iLS6elIHMgt95Xu1/6IVy
	7TUHA6AM=; b=UjMNQluNnsjYahIfr45Go4mMfh2cNuFw+uW4rSanwXgfUg+cTyj
	1UMXxA4+lkDtdqCAMqU+6vYAA0QHr0gEkUVF9uurb8yhfu854QHWq2t9FfUvi0he
	x3Ux/9QAlj5viMUD0SK3a4Ir7yeeVSZeyr67yoO2x8+SDllVgEBlj/IDtpxGxfTB
	bVC6eViKOWFVw73fHufGRoSVBSSoNhcC1KX8oL7NhDf/5EmD5o24TeB5UF/7oXJa
	DPkFqwM01cYxuf30CPyeyiD94Y32dhVvvMqlLvwO96SHuvWVosPx6KvrV2+P7D37
	Rj6p/Cce8w1aS59OkHu6pOOqzFn2a4GJtrQ==
X-ME-Sender: <xms:q_9-Z4gl3IRFrvRW0c3-fWeaCafg7yGwCyCmG_O5jTIZT0MxXVXgLg>
    <xme:q_9-ZxBHyiyjeLMk9ZcPyT61v5g6QsZtT9tJWekQ-j0CZuN__pZ3w7ZoYAddw0DLy
    rb_N8g3jPLM0bhy6A>
X-ME-Received: <xmr:q_9-ZwH6GCjJC-NfGFfLehWHHrIj8OVwlWbj_iwsITwGsYlrUwMbYps0L8rXUfTx59FArNBxeFB2qYKgKGggUutFgcDI_PxCe1C6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q_9-Z5TEDh-qlxi6MECogtIXj19e1uVe7LTgH63quZZER-EPrdjkXg>
    <xmx:q_9-Z1xvmkr5JbNk52yVO9WG0IYcPXA_khdIKgSe3Co5pSDYqPJyTg>
    <xmx:q_9-Z36uhHVWBO9bK5q_1GCnuq9lnZQhXoC8ZB2tGLVccOOV1T9WXQ>
    <xmx:q_9-ZywRCdFDugx6twfHOKikoTBX-7UYZOYZUXLryOo98dgDRFJsqg>
    <xmx:q_9-Z3sZI7iblLJfp1NZsOQ4B8Ff9Yx6xBOXlGbCdCe-Gwug5WK-RWdV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:43:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH] rev-list: print missing object type with
 --missing=print-type
In-Reply-To: <onddu4fjgo2q7f6r7f6kgqctrbhshkll23z6ocsxiiqxbynap5@msq7qtj2un4w>
	(Justin Tobler's message of "Wed, 8 Jan 2025 16:18:35 -0600")
References: <20250108034012.211043-1-jltobler@gmail.com>
	<xmqqjzb5pc6t.fsf@gitster.g>
	<onddu4fjgo2q7f6r7f6kgqctrbhshkll23z6ocsxiiqxbynap5@msq7qtj2un4w>
Date: Wed, 08 Jan 2025 14:43:53 -0800
Message-ID: <xmqq8qrllydy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> As I suspect that we would want to leave the door open for us to
>> extend this later, I would perhaps suggest an output format format
>> like:
>> 
>>     ?<object name> [<token>=<value>]...
>
> I think this is a great idea. To select which attributes get printed
> with the missing object we could add an option. Something like:
>
>   $ git rev-list --objects --missing=print \
>   --missing-attr=path --missing-attr=type

My knee-jerk reaction is that this is over-engineered; wouldn't it
be possible for us to simply dump everything we know about the
object, and let the receiving end pick and choose?

> I like the idea of also adding a path attribute, but this raises a
> couple of questions. The way `--missing=print` currently works is that
> it prints the unique set of missing object IDs. A missing object could
> possibly be referenced by multiple trees and thus have multiple valid
> paths.

That is not an issue at all, I think.  "rev-list --objects" that
shows objects that are not missing already has the same issue, and
the solution is "show the path when the object gets shown for the
first time".  Even when the same object is encountered during the
history-and-then-tree walk later, that object is simply not listed.

The code path that collects "I thought this blob should exist
because a tree wants to see it at this path, but the repository is
corrupt and I cannot see it there" into the missing object table
with attributes should do the same.  If the table does not yet have
the object, record the attributes (like "expected type", "path at
which the object was found") when inserting the object into the
table for the first time.  If you have a missing object and the
table already has it recorded there, don't do anything extra.
