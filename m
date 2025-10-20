Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAF25A65B
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987054; cv=none; b=aM8wnMIy4a5Qfer4aiNWKO1VGDrMUWqAn2qT+ffmvs3fQdFUjCuVxGYbjCwP9Fd2JttmnQa1YN8xNuWqXemRREPplIDYGs77Gza3aQ1ryGLGq7THLNvLj2xGYVx9YNZFX3raTBUv0vhADvw8rG+LFXYDewceS53EYPabUMkbZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987054; c=relaxed/simple;
	bh=xq9IiejE8PkG4BGxX4LbHYN8Ao/NvgVf3xgGLaHqLWY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FkigM7UsJIa80AP/l5Tc9D/QqaRXhT/HODv9YIeKTnJr1YR1RyAqOg4dlVdQm7ybOm/acNOZiSJD9Nhm4rN/lnAPNW/HlU74Dhql45I1deJYnye/J4kwtmVYf89TpPyCZZV4/OecweLkaYqPn/d/3m2VTBAoqiV97E3M0oCZEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=KlVxrTba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrhsVlwa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="KlVxrTba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrhsVlwa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CDBE61D00120;
	Mon, 20 Oct 2025 15:04:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 15:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760987050;
	 x=1761073450; bh=7F2iN2hBqmpyoIenTD15f0tuo2zvQI9Q5SUy2Pk0xQY=; b=
	KlVxrTba0kBdETHGVOk9bLoMf/UZiJLRcWgQpvkNXnzkdJP+tHdrNI+DrovI0Sfj
	JCZuTO3zoZjIi5LLbjvjzbtL0IVrhOVWSK9eZgJGNoY1zRxFQ2t01glukYJWu0FA
	IOE9X4tgGQvG2nvbQMUkohaG+DtKRrfY0mOHoyzTSRnSp1huXH6aSPJV+aRvQrBz
	oMVQ2c2cT2K4oTrqCm9TgDNkaWEftqMlNU2/stjmIARSA2Uc7eGWt5mEI9/VPOQX
	ig4bJS5MQ1sWQVcOVLvMo8Ef/B8OBH88dKOuTBC0OCnVnxMIScIF3EWedbF1cRrt
	lg7FuKkUui7Q8hrnyBUIUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760987050; x=
	1761073450; bh=7F2iN2hBqmpyoIenTD15f0tuo2zvQI9Q5SUy2Pk0xQY=; b=l
	rhsVlwaLh9PGjYwekP4i1R7W4dniBG6J6/NUvzK5G663qvFn8Yi6IIda6dPXHsbL
	CQYitU9TReGQKluRpqYTyj8jz4ll+1SW0xXxKuT5YTAebpSwL6HLwLwsciwwRg8c
	X+Hx5Gg1I4FrP2S9cA0LpRa1cRHNFO/qjuNIh4r5hUPv+unTllz3yDp1JFolMAdn
	ehL59+smYRIwnsEvywlsb1hlBwr/73fq4JqUJFEOmWGfgltLXp/w/W4zuGfqmXza
	kLO5gAcxebdiTUchibwkefEB29QS5nPeIBSkcmeaLbfM/txuYAA/P08YwX0Z3e9V
	AxLdScH4m57u9zIEntBjQ==
X-ME-Sender: <xms:qof2aFj4xyu76mBHW2iTxKsF-TXXXReT7XFMLMsA2H310ud39YWRuQ>
    <xme:qof2aE2h8mknVjkktVoY8TstsIXew6AfP-PXUluK1E4T-P4MdmrnWVcw0VvsKkhCm
    Evvp1S8ZeBpJm_OJJB7TKbqxKqdk4JlnY508Mw64WmJms_1TGlthCLJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qof2aO_4Rq6WQoJkgELv8ddePQUieKDIxp02WFxjRj8xQuvgCT7Zow>
    <xmx:qof2aGc7_Z635hSzNv9aKJkrzNbPNJJThM8cNs4XmulRfRsVSnZewg>
    <xmx:qof2aHFQhrQ0jCiPAYzBeYX1KwlqeFGXY2ouabQ4M39Iga3jrr_fsQ>
    <xmx:qof2aEdHM7pIadtRFI8KUEtvpTZJz2xUJXeagEOaRI4XcD2W_Wgi4A>
    <xmx:qof2aBapDIInSwWBAO1i19Krdxv8Z6XFdLDVawHJwhwsQhDO89mOGDpQ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BF25780076; Mon, 20 Oct 2025 15:04:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbxYa7LnRpoB
Date: Mon, 20 Oct 2025 15:03:39 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <8099e7ef-2673-407e-8cca-e6b566b99549@app.fastmail.com>
In-Reply-To: <xmqqikgdxj93.fsf@gitster.g>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <c7e1c090475f76d94363018681c34f3955abe87e.1760731558.git.gitgitgadget@gmail.com>
 <xmqqikgdxj93.fsf@gitster.g>
Subject: Re: [PATCH 1/4] doc: git-reset: reorder the forms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 17, 2025, at 6:20 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
>> index 3b9ba9aee9..9843682e81 100644
>> --- a/Documentation/git-reset.adoc
>> +++ b/Documentation/git-reset.adoc
>> @@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
>>  SYNOPSIS
>>  --------
>>  [synopsis]
>> +git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>>  git reset [-q] [<tree-ish>] [--] <pathspec>...
>>  git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
>>  git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
>> -git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>>  
>>  DESCRIPTION
>>  -----------
>> -In the first three forms, copy entries from _<tree-ish>_ to the index.
>> -In the last form, set the current branch head (`HEAD`) to _<commit>_,
>> +In the first form, set the current branch head (`HEAD`) to _<commit>_,
>>  optionally modifying index and working tree to match.
>>  The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
>
> In the original, the "defaults to HEAD in all forms" did make sense,
> but as the new text does not mention there are three other forms
> like the original did, that sentence was made harder to fathom.

That's true. I didn't pay very careful attention to the text here
because I completely rewrote it in a later patch anyway.
I'll make it say something that makes more sense.

> I can accept that you do not want to get ahead of yourself to
> explain "copy from <treeish>" before you are ready to talk more
> about these other forms, but we'd at least need to acknowledge that
> what we want to refer to when we say "all forms" here.  Perhaps
>
>     Among the four forms, the first form sets the current branch
>     head to ....  In all forms, the tree-ish/commit defaults to
>     HEAD.
>
> is easier to read?
>
>> +In the last three forms, copy entries from _<tree-ish>_ to the index.
>
> Or "The other three forms copy entries ..."?
>
> Other than that, looks good to me.
