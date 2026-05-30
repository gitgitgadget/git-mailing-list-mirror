Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C9377EDF
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180648; cv=none; b=IOTu+cKnu/1rZ0Atg/1smOYEl8PI6UbtWktWcF/KJM5OPVV6xhkl3tnhQqXe4MFN/ezyAzYRzJclhbL67ZflZrUsHIIirhLrbFLKz0QXbN5LEPsFk+32JXw9V7ccMlXR57Ax//RRsvmr7fhTt0EFbj8C4RMWitJhhqvHv82SYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180648; c=relaxed/simple;
	bh=UPRvnN46xwSh2L//hcb8AB8qIlGvjq1vVU6KyWvOzy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lu89NdOUNY38A0vdwTjpx5ddesqBFsbqgU8piV2GJlNPgJu7zIWWIdcy/EXrisOIJheR9Xi/nDu+ubrZ4RQqD//pniUs76iPxTCFVIkPCcdhDMCgsBOvQb9B9izOUWbdORqowkYfKUKqB24KMC+WHEWtTlKKhVdKc+bXlI9YaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h0oFiFBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htfuFLZX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h0oFiFBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htfuFLZX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89A0D7A0074;
	Sat, 30 May 2026 18:37:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 30 May 2026 18:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780180646;
	 x=1780267046; bh=FscbRDl4oEymdGByTPus5XbuYt3eY8L7kxfArlGJ5nk=; b=
	h0oFiFBqBUixvYE7X6b542wOGcnj8oTqJrAXpdVOu7koM61G542Ygtrv9BEUjz7W
	Sl40IdJ3TqkwyvG6Ut6NZcERR/eyaakRWtSefq9BFkgN39f0pilHGgKBlVzjzQ1i
	Kuy8apA46KLM0GrEZTvI/0QWsPLjOEivi8mLN07ow5vpDpJwO6PKUfgAuKcfEs0W
	7Y6xXZcB6108ZCbc2uDGy5Ps5RNDH7AbYYrujZv/2LlF7zZ/0UoVJ/pG4yhSYKSf
	MC/w+mhD+U5iaVfof2h/j2JJiygZpPZT0Z/m9+qb3/7FURa0zWZEkLBUG23abdN4
	uI1JB2c8LD2RoGSc7R/0TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780180646; x=
	1780267046; bh=FscbRDl4oEymdGByTPus5XbuYt3eY8L7kxfArlGJ5nk=; b=h
	tfuFLZXTSO2ApSWQytrkFm1Yw6GLwjUgvdjrODNMfyuD40KScDmTlQ9gZN6th6Bi
	UIOU3016tLwiR2ssVImcE7f0KyuAGpP1/LWCMh+XPF1IqIpaBvPNBsgwan8Hcqqc
	yyAS6oCgOPIfRbE8OIpyEr4EBFqGKHHYgH1GUzc3Pz1S0TGixUpb2DFGtiV0UCvG
	DgcxsYXC4Pt7lvIEQ21Rd38STj3ZReaV6vlznLLanKhfFTzvXMlbvCR9TIahNOrC
	UGJGmY7IlMQelfCP+DzueVNkIbCO+It7UKuYi3hFmLMGQ+AzydoQ2T/fzgc3eyjW
	03LFV0ptGcdtR10HY76Yg==
X-ME-Sender: <xms:pmYbahEXKt889NXyUETBKzISKUR472l0DnwMDdkzWLdAShP7ABd8GA>
    <xme:pmYbatP-ffKXzZHMO_wBuaQuidoplU6wHcfpQbgPjPUOSvDE1-I1k1nd_3D6Cdr-O
    5-bV36UcQMNaJkcFeqAUnkpy6TWv6g3OesQZbsM7jI56xFcKljdng>
X-ME-Received: <xmr:pmYbarekLfous6DucBarLLXfrQWgy4MYFbvzvPNMMEacuSMkcvsXzx65jgsxdlgVDlnXBzyQXYNyefrQfDz4cjOVz16agdP1CCO3>
X-ME-Proxy-Cause: dmFkZTF1JMoG4IxU78XP71Op4zpJZyEX4BJro8E94hvdQRS7/Ct/E3Dpo0w7vOu8aAyGcv
    yLvGap38XraVv3lL52GcF2LtazxqE3qbjneEzcuox1163pvJPp/cxlouzAXfTRF1Lm98yc
    VQLnec1x/K1VwVW4ahLpmpkmswztrrqNvQUPopoLiVO9VAz+/kFI6Xck4wEUQ7/Epr2Xah
    rf2zXfPQdnGvcrSynOA8elWm4MjKp+vWjv86VJwhuzd/phGcVDP3a7+67GXUognXu8kAbx
    nO0HCkfaOU/uqi+obfJkeoCL5OwzpfjWcX7Yu2fvAkmUzN0pSp1TcQ3D3GUxo18dUmd9KP
    Nqr427H0h0gkYJuBvRQYLcpsR5cOwqdvBpFMjmAi6sfhy9hOO77MqvQcVuwmCm2RDePxh9
    AOke0qt9W2K1c398k9DlfTCCf5gX3ylD0JhIJGXmqfYa34NnepphXA/J2irwZojvGaeE+K
    g7uE3/+AfEYcKkBaqU1/hCizaX4x8qTW8zDL/90BD/JGz2U5FFPIkfaVaYCfqYgLDfO4m1
    cSv7oPYUK2e4m4Sdzd18hSvScqv5LP04hFtlaT22TnxgaTDJD0TZpoFtbADTphhFBg9tmj
    bVmA8fUC4Sq9B8oGCTuZg8G9KN68kW0uOJMuSchvBU6tzFkkVQfNH+Q1VpFA
X-ME-Proxy: <xmx:pmYbaiu2wJc-SehFuXEYkM6sEGBxuox4huznOSwSbqEVmBvoatDqIA>
    <xmx:pmYbaknvcS9SWDFqFcxpBlQow2Iu0nfPFd95riocwZt3f-O1tJyGAw>
    <xmx:pmYbaszRxnl-qEdzda_LmvSuyIALlmjTcwLPUQ8jflRnpqYxBHEoUw>
    <xmx:pmYbauPjbSBTO-1x1j4mmW99fiVL3bzoWPgi2qvW7VWeR5828Pqegg>
    <xmx:pmYbah9chT_qf-lnbeXhfaeEEH-Pz7ZhF6Nd8Q5CcZUuDSTyRSgybfKb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:37:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 3/4] doc: replay: use a nested definition list
In-Reply-To: <--ref-action_definition_list.70c@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 21 May 2026
	20:02:00 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<--ref-action_definition_list.70c@msgid.xyz>
Date: Sun, 31 May 2026 07:37:24 +0900
Message-ID: <xmqqtsroed7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This bullet list for `--ref-action` introduces a term with a colon.
> This is exactly what a definition list is, structurally. Let’s be
> sylistically consistent and use the definition list markup construct.

Makes sense.

>  --
> -	* `update` (default): Update refs directly using an atomic transaction.
> -	  All refs are updated or none are (all-or-nothing behavior).
> -	* `print`: Output update-ref commands for pipeline use. This is the
> -	  traditional behavior where output can be piped to `git update-ref --stdin`.
> +`update` (default);; Update refs directly using an atomic transaction.
> +	All refs are updated or none are (all-or-nothing behavior).
> +`print`;; Output update-ref commands for pipeline use. This is the
> +	traditional behavior where output can be piped to `git update-ref --stdin`.
>  --
>  +

The transition from a bulleted list to a nested definition list
(`;;`) for the `--ref-action` modes indeed makes the document
structure much cleaner.

>  The default mode can be configured via the `replay.refAction` configuration variable.
