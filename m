Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B1EE7C6
	for <git@vger.kernel.org>; Thu,  1 May 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138233; cv=none; b=lhdq3LXmIOWm49TqHAssz/gdii+Q3GP4Z6s+KpJhplxvQg+5ttAyZqbL4j4BPhi8Wu2y39b/TznTxpPtKJgLoRCGdUWHTmugeo3Pwxbsdz8vskicMlCjxxxXDcBeq6tlDK7jcF+GQAFwaNUpzwsvsB7+toesLx91+ZdRkbTi0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138233; c=relaxed/simple;
	bh=9mr0aO2MrE4MShhR+T/U3XJsuQuU/gSMcUbQI6Sv/2k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZXuJd8e+IQO6kesMlGTCLQpgLtadgW7SsBArdcXAtg7FJnzEkc3FavnAbwj+F6+k8SoBThSgnuZ2VCcjXrz1VtEBf7r7rlzfAjikKAaLIExFde9Gl9WxsafyIgj8ZWyib2JJLMJlpvO7JuBA/3XUvbb6SNWb0iuvduG2CxgCrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HZhBlqcY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=haG7oF+9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HZhBlqcY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haG7oF+9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1FBD1140237;
	Thu,  1 May 2025 18:23:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 18:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746138230; x=1746224630; bh=tY+L/M35NE
	Pzs5Ui4abi+QiDoG0CYq65GeSPeXF2GE0=; b=HZhBlqcYf7bU7r4eg3SPKY8tI8
	ksgMIr2nvnGwwrjLcCpgguUNFXPGnv00XX/eBxV9l+2a4Z1SKAqrks1hgXVQRmpA
	1Ld6otD0CMYiJQ+XbQzgB7umDlWTGEGvEIog7hMESXzIf7iDq512pImzBSOTOfG0
	a4HXoA5ia7YgRlquhjXIeF7JlW5RZzDWSosj3u6dPUmDPZwrMvblIVFkMSDzov7G
	MjbtCqI7UWTWlRDjLo4px0EEhXZXbLyCpkbTSpGz4TPu1vrZvZZhKYk8Y6tdmFsk
	mfUqee3hDMIIt69a2UcV+X0lxj2T0VXJFBMx7Um0u4U8EmM3bfZKpRio4H+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746138230; x=1746224630; bh=tY+L/M35NEPzs5Ui4abi+QiDoG0CYq65GeS
	PeXF2GE0=; b=haG7oF+9MhCMTcwh/I5boQrUHVyQNIZ91GDCRCDh/lPYGk9MRf0
	5Ta83X1uRcv1hluY8yY7uGlu4b6CzONHRy5GsaLDOKLT2VWEQApaSgFMd64DbYL5
	/iUQT/czdyhdI/QO2nqhskeAvynOASad+854ullRoqIbkgQVdCQ4JzVcw0WjBE/a
	cNxg/HH9J5dF4eShNB/9jZX9JPgBy7u1ppTEOqw29Sf8alejMm65WriTOOM0pSCg
	V1is5DqSzPst6aNnrVrpRod804xCiLJiV2WSI7DUtnzwOH8Q/x/eMYmQqLygRwRM
	8nwA9DQu/lUWxd6hOV9FG8XxWkbXHW15Dpg==
X-ME-Sender: <xms:dvQTaGr_HBfNpcOEvH22N2vsxAJpIweBWNdl2KuZt6LkK8W4bZLDjw>
    <xme:dvQTaEoYgI6kSxbqz4-YFT853fOU9tT55HYyHM0K5T6wf-Hyec-0zSHz84yfbLnJ1
    LXeOW7aWS9ieZnrAg>
X-ME-Received: <xmr:dvQTaLMr9Uman-KVWbWsdPAILaQRp5ycOoVu-rD9hGqurGNGstHQTAP5CU9Haf59JdKCSLGe6DRPojZRkxMTNQAScDWEi1pXvuie>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhephe
    evkedvveeuteduheeljedvueevkeegieegueelieelgfegueeljefggfekueeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dvQTaF7ZjYpYT9wqWSRmhYHfA-81aoZ5A4HQ_lm-AsO2xLQD2oDbpw>
    <xmx:dvQTaF7Fm5KQucHcDrSstvfD0yncIM6zTXmGYOorilERuhBHYc_R-Q>
    <xmx:dvQTaFgZNFfjeuxpxEQG4-PKOpYzH-mOE8wNrqRO-xvTWBMuTNUaHg>
    <xmx:dvQTaP5rsQ-08YWV60hDXzQjswf3quzEa1ElPMwvaEFerSAxLLw-7Q>
    <xmx:dvQTaKoWqI7jxAg7GG6HyA1129XlnttbK3Fd1-7qAAlGvxh-b6SoQMsC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 18:23:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/2] whatchanged: require --i-still-use-this
In-Reply-To: <20250501213452.370729-3-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 1 May 2025 14:34:52 -0700")
References: <20250501213452.370729-1-gitster@pobox.com>
	<20250501213452.370729-3-gitster@pobox.com>
Date: Thu, 01 May 2025 15:23:49 -0700
Message-ID: <xmqqikmkvukq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The documentation of "git whatchanged" is pretty explicit that this
> has retained for historical reasons to help those whose fingers
> cannot be retrained.  Let's see if they still are finding it hard to
> type "git log --raw" instead of "git whatchanged" by marking the
> command as "nominated for removal", and require "--i-still-use-this"
> on the command line.
>
> While at it, update the documentation page to use the new [synopsis]
> facility to mark-up the SYNOPSIS part.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-whatchanged.adoc | 10 ++++++++--
>  builtin/log.c                      | 13 +++++++++++++
>  t/t4013-diff-various.sh            | 17 +++++++++++++++--
>  3 files changed, 36 insertions(+), 4 deletions(-)

This needs a bit more adjustments to the tests.  Namely

 - t4202-log needs to pass --i-still-use-this because the test wants
   to check the output from the command when it functions;

 - t9300-fast-import needs to run "log --raw" instead, as the output
   from the existing call to "whatchanged" is simply discarded and
   not checked at all.  We could remove the call to "whatchanged"
   whose output is not even tested.

Also as we haven't listed the removal of this command in the 3.0
breaking changes document, we do not support WITH_BREAKING_CHANGES
build knob and test prerequisites yet.

