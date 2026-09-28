Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505F4EBACE
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610863; cv=none; b=m1CqntRh0Y8XQ7s0EPifv9qPvV5kDSr2qqvT8Nz+wb8ELjmjK12phNG3CiLYAAdJj6LLJh0Eh2yVOQoty1m07/uExNJ99jLMeVK8GXUnVuIOYZCwSHvHATqmnADOoxPikd/miIo4Ngy4eOWZWcsrMovJFrLSmWgFyeLeGPeX/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610863; c=relaxed/simple;
	bh=1YaxcCeFsTTHam0QhLi3fZE2VUFpg7M/R9MZQRmHysw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fXctRGU+jt0E9oW0ycT4CR5btVFBioOrVrlODFx9DxbfFYOTJS4kMhmQrXIHl/M0x4qLVSAkx7/xrLhB9UgQwHOnWe17ALsPiXegsGM4GgAdLkTw3Xz05JEqM41BEDzhFKivjviyDvb7Av6GuO/hiSpY4mHo46iQd3CpbdVJE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PZNGDUt3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZNfBUt7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PZNGDUt3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZNfBUt7"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8114814000E9;
	Mon, 28 Sep 2026 11:54:19 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 28 Sep 2026 11:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790610858;
	 x=1790697258; bh=D+KBJafV9ocdP/ng630aA82LczLEI6zf7gfvt8R/wj8=; b=
	PZNGDUt3ugEjlm8LtHayAikWZsiTOLUcdOSjbJpzLj5jPWGXFkrkYrr2pMmJeRYM
	jJS/d3GGyQIcZvdIWTtKa51+SMiYlQkH3J6NB/be/KZdwHMH/A8JkmL6b/0DR+QY
	3ZvCP31Ggl57fx/JaBFroMRt7JSLyxKPiRcZk/aT12Zznqm7Z4f4tLYvZtWVIhIH
	27uPrelpxrWLuKx5Pil9Mo+M4S3Rmup6rNT4PcFMIAMyfUTgjZKeE6RYBZ+2wT8t
	3CJPeo1waDo6VW+KCXg554/nptUBbcfGmYKRoR06gutQB/WyjDNXmyqZGSPll8Jt
	Nz7Vrm4aWgokC8BKACghnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790610858; x=
	1790697258; bh=D+KBJafV9ocdP/ng630aA82LczLEI6zf7gfvt8R/wj8=; b=A
	ZNfBUt73y8q8F9C/rGsGq8dIAOGzcxlXzb0a4GbHmUn9bA4/sB5hdT0LMOq8BUp2
	OXUva2Wyt2YoprZQuitlpuG0dFgWCPWm8GdeWf16VmdmcmOCLYCLdkBG1WZczM8d
	kZxECPtx5mMz3Qu6LHzshqUjc1ftf3yuBkzOTlvwfaJqaxfs8tu/mkbk1PSeiEHb
	F001OXJr2XhoIYwz9/SgFOvG4Ybw70T/HOPu0cY1yYBT13XFR9wpJ/R/0LH1LHPt
	t6DkC1BjsPj/BPiGO5dVMyy4+tAo8nExBkkxskkMDN6KEIaJ5ZKoj1d/5XzGoTuL
	kMvf69oXe3toaRYWCKZtg==
X-ME-Sender: <xms:qY26al4wZ6AHEXRLU5ygUQzZM1KQn9KvgxiwecHm1bwfcV_dM1v4Xgg>
    <xme:qY26atvfmveotwtMeZA0Wx-Vq43xLcNmruvj7pYiW1U6zVL_2LCHRDXT_xEitQFf-
    wJDkAtnghNhMddOV5o56uNYH66YZhUYQk4V5bP_DPbmoRaKX9wrXLY>
X-ME-Proxy-Cause: dmFkZTGcw+1Yqla8rZWTuw6KC9LCHTXYuJ664xrgQ1RG9xoDpzspL2AitJFfOO+2cROqNp
    cd3DWeosrOILIrjLfrcaJYqu/k+ZBoyU/I17sWO26poHu30qJCMTphtRlC6p2z4aNd1Tdw
    xQTw5WZSA6Y8Y7yYG4LNsK2crwueMYOvvi6onLWyA/E2XNZsjElxAYqpkH8+qnPMMm4pO3
    x+bxohW5wqnbr5WCc5+QtD5zUH/Y3xicpYZ97bukUQ9YR4EUUrtbQDEkFGxAabCyf5cSC2
    ukbstAMPOTbMaNTT7ML5qjMMPq/1G9RRaPNuKCPfmKAIne2VRWsPOPadptqAZ6oX3rY1Dm
    ywIIIjDtJRHxGxyXXg9N9GW0Zdjy5gNvKLHXu+xRuPCx0N/eJjNrminXzwWxn1eE4LswIQ
    ZTCmJ6z15IyYlvuCJC3ZZpIE+dGup2aAKQSI7jmRDg4l7CRf9PCg7z7m1gKJzBxqgyWvwE
    YQ8NrMe7HSN/39VihdWW6d/2Q7yVzJ4Ll64+g3pRhDUAZTKydcfiUXTevEjM35XpWyPEZm
    s6nJN5WiYFTBkr59v+FLJstQYvUiYiAivoYZzk+PUvgRT009vi3QS+VVMRRaxdPIhbCcD4
    GSNC94+zaHsH7vEaoBAWjxZdOrTAkQcl0hNkGdSeQUEjjWCwIRy7Dd9FYGLw
X-ME-Proxy: <xmx:qo26aijzJGy-s8h8HlrMkj2rolSHQzaaPn1Rh3IMr4wi5S2X3p09-g>
    <xmx:qo26ag2GMfAxtXn3hxhQ9Rpf-iSc6EQB2Dv4RkXDO85jr0N2zsMT4Q>
    <xmx:qo26akj3wkqnpn4PceS7OjEiPFp8ZblaEbXEyrgJoK6R-sgUQ7oAzw>
    <xmx:qo26aodHJLSvE2sRw6eh8ziCGNeE-OFeL4zkxgydA9tvHTnFPQMA1w>
    <xmx:qo26annEkRGTj49WGnkYZTpWWQqM1bfDTASdr-3hhyAT2539OIMXGWUR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E56A722C008B; Mon, 28 Sep 2026 11:54:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 17:53:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <69ff90da-875c-44c5-bf00-f53fa61a0482@app.fastmail.com>
In-Reply-To: <xmqq33uto0bl.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
 <V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
 <xmqq33uusvst.fsf@gitster.g>
 <57741bea-f264-45ab-b5fc-52466fdcb03e@app.fastmail.com>
 <xmqq33uto0bl.fsf@gitster.g>
Subject: Re: [PATCH v2 2/2] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 28, 2026, at 17:35, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>
>> On Sun, Sep 27, 2026, at 14:50, Junio C Hamano wrote:
>>> kristofferhaugsbakk@fastmail.com writes:
>>>
>>>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>>>> index ef92704de39..640c5dec52e 100755
>>>> --- a/t/t3206-range-diff.sh
>>>> +++ b/t/t3206-range-diff.sh
>>>> ...
>>>> +# The '--range-diff-notes' has no effect but is allowed
>>>> +test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
>>>> +	test_when_finished "rm -f 000?-*" &&
>>>> +	git format-patch --range-diff-notes=not-a-note --cover-letter \
>>>> +		main..unmodified &&
>>>> +	test_when_finished "rm -f 000?-*" &&
>>>> +	test_file_not_empty 0000-cover-letter* &&
>>>> +	test_grep ! "^Range-diff:" 0000-cover-letter* &&
>>>> +	test_grep ! "## Notes " 0000-cover-letter*
>>>> +'
>>>
>>> The second test_when_finished is redundant, I suspect.
>>
>> Oh yeah. If there is no Range-diff then
>> there won't be a notes section. I'll fix that
>> in the next version.
>
> I do not understand that comment.  I was merely saying that you are
> registering the same clean-up-when-we-are-done handler twice.
> Having the earlier invocation of "test_when_finished rm -f 000?-*"
> shoud be sufficient.  It does not make a difference whether we have
> notes in the range-diff or not.

Yeah. For some reason in my head I jumped
to assuming that second test_grep was in question. x)

Yeah that cleanup is redundant. It happens to be
placed where I have the Notes cleanup in the
other tests.
