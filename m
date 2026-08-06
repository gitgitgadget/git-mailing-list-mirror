Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37F38757B
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047142; cv=none; b=E6jJ3u+ddmKPaIMcXhuQakmZgLgM2qdNzy22WZg0MZFuGxMl4i77GofoqS1t9IkBJ1aLWbuOczmpEC4xUGSmK13A38BawBYbcBqtjAgV6JUUQCxZDO4IN2DzgGFPZff+pstsQ0xyAKazLdZtL8V0y/ZGQN+Fz9T5JyyJ5b1p00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047142; c=relaxed/simple;
	bh=4iG0W/YCJrjjrgIoHtzmTwFDKPJ33xTsHNxDTht7rxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0wKnrxmXMlyqvD0r1VEwm1BbhlxT1gZsPIEDd3dUI76OETETwtDCgWFwzhRmAbjhmahk5XG9mdWkZkQoYA1aEUd3R7i7fwcLj6zXTcVQGGbEoWpYrV87PRMoIL77HvR4xZx+jGWqQAQTvoPsJHhZXbP/UmScq90lrttKfKWwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DRmSG2Cp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MM93g5en; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DRmSG2Cp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MM93g5en"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E0471D0011D;
	Thu,  6 Aug 2026 16:12:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 16:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786047133; x=1786133533; bh=zWM9dKLaIZ
	AZSBjDchEV0jjoLqlexenPwotcmQmG+So=; b=DRmSG2CpiCMdAsYdDrhkWCHekS
	2mC4jXlv9nluwXjRdtdCecPBNO4UfwW9XeVS2iuskEYq1EeF3U/Z6cgCnk+nGX6A
	hSTMM0ghZvCJ32UrEU7i/d/rUxk3FvlAVzeCzpVBoME6/sfOhMUghXjaPKMvoQhw
	YZScUJCRmTaj9wl3Cmqvq7FQj8Zf2HOerj+Qoksnc0vpD5AnqMZPBj3OTTiPsGeX
	MweQQtnYmfzoEzQklGiFHP2JxDhCaTxPEvMDMDiTOkkB7woB6X8o077pOxvXHZxB
	+sG7q82hugG9DKECaVUiuxp+CVOhSDqykVc+UtF2HIXawK/mS2bdEVVHy3IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786047133; x=1786133533; bh=zWM9dKLaIZAZSBjDchEV0jjoLqlexenPwot
	cmQmG+So=; b=MM93g5ente0oQ3C4+Oi2WKlk275v0r51mQSLQ6l0WWLLcu8Dubx
	4cYqeX8XDDCGkZQQuhoVOFWI/dqCIFG25ylg5plzAxWGkT3gvFBc4gWUwAuGfzJT
	e0x65nEUFibSrRoDENvRUF3pKMv3bx+I8c60f3yIagEbHzef4/H1auw3H6ttwu0I
	IZUkAIuL/O+ynRgxhW608+MBFtpzyJkPb1hSXj0zzEEakbAyJbGkxzQUhi813U2e
	a2NvdhBQdoE5xbjVeq3OwCAp2wZtVpHXB1jT37sc2x08By8YakfvsjvQ+Kono6gF
	Q72+GKKWVkVRySBsJeWg9iJOOfURDgqbraQ==
X-ME-Sender: <xms:nep0anU6Qm81_sKX060Cne2TIP58SJu6fd13ilBhHaombRIyxaUMJA>
    <xme:nep0ah0GYjiw6fpLeQ1T-HDoY6Ig0pInTtCjXI4z9wWL7P5cJOJdICjPtTJPIN344
    sD9LlUDdvduGeZcm2xYCA46FX1fQVkvjR9--iT2S9yWFiXvBwRAiQ>
X-ME-Received: <xmr:nep0alqEOsdzpQNbx7_xKlUwOgchlWvuC2aoeETj-3ZB61ZYH6cNqzta_W_C0zlJm0z9WgD1yh6wbk55WtBmayKLP6HYmWS9Kw>
X-ME-Proxy-Cause: dmFkZTGlZDerN0f5KNA6mXD0h9qZ3LdmvcGl3KPNDlWKOC2IPAo0beR0zs81PGc5XNdliy
    TDZun197AzJ7JVg1LLAlKhPsyt4CMbmyDU3ego6CJ9rALUwWrrohKQt+bEikfGBhCkl78I
    M9rBYSor5/IXH4+m2EYM0gqEe+IOVvbaVg9FhtL/fBFr7FSLneKucOFsU54+MlkeK5CSZP
    3fDEeiFAAwPJzsaUyakL9rq1xxmei9Zpf6S9pDUPZvyPRsHePaPyWZyzu7afkIy17CC8RJ
    umZ+h/crcwVS68PhZgaI5/pr41W7oDdeCk7lp/tU5fEPTN8Nnd3JHJwaoY7j60RayvIYbe
    DBdf7JZafGplSQMhnTU+jW8FaghxZsyUzcA95VS/iIC67NVCJpzDA4on0OCvbEDrENt9Xv
    AKs6mxrtmcIp3+D26wRAWWxrbhHOdsWXNu/MHQFfDzAFTkLUNNGIHnL5GbtNEbaAnkPLUx
    UCd2N0RA24uJ3WaNyubNU/v7dbLXwwu1Pbb7+Deb9W8S8Bg8RKIIewMJxgbBZ0cL9jzmID
    YR7Ks+WxGoKJUpjToppPm2rXmNHJSqmOuLykfIX1LcQF7MXkjItJnOwhdgeOkzO7o7wkmc
    nVPGCvxSeKpxIywDSefA9qa4TJ032L3E2EDxZUsl7n0olkdn9/wcvWk7Y3rA
X-ME-Proxy: <xmx:nep0aoWkegTZlD4MxEYHeZzwIdjn7RzBaVAFIct645kf6OFvizLjsg>
    <xmx:nep0agZfWGD76xP2NXY_i8UWv2uDugS8ePM7EL_jW545V2X0p4zfaQ>
    <xmx:nep0alc51Yr0Uf1frTRQuU0zYOw6cf_o1r0h5KbROznzOCWQIHvuMg>
    <xmx:nep0aq3vW3Aw5iB7oaAWMYk1M0HGcc0pooFDgk_WtQBthCpa00lFgg>
    <xmx:nep0alGGQODn97ggt95hBuJXEb6rA4Zl2TAedb8WiB8rl7gtHMcmDXTI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 16:12:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
  Erik Cervin-Edin <erik@cervined.in>,
  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
In-Reply-To: <0844b4e0-679b-4c0a-bea1-5779b4d0489d@gmail.com> (Phillip Wood's
	message of "Thu, 30 Jul 2026 14:10:31 +0100")
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
	<b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
	<5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
	<00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
	<xmqq7bmhycxq.fsf@gitster.g>
	<8631114b-aa6f-446e-9710-92c400320eac@gmail.com>
	<xmqqpl07fb1u.fsf@gitster.g>
	<61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com>
	<xmqqwludan2m.fsf@gitster.g>
	<0844b4e0-679b-4c0a-bea1-5779b4d0489d@gmail.com>
Date: Thu, 06 Aug 2026 13:12:11 -0700
Message-ID: <xmqqh5l7huuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 29/07/2026 15:26, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>>> But that was about a low level mechanism that must be more lenient
>>>> to be usable as repair tools to recover from such a broken state,
>>>> no?
>>>
>>> It checks the new value of HEAD, not the old one so I don't think so.
>>> The commit message talks about topgit using "git symbolic-ref" to set
>>> head outside "refs/heads/" - peff had previously tried to tighten it to
>>> reject non-branch refs but that broke topgit. I've just had a quick look
>>> at the topgit code and still sets HEAD to point to "refs/top-bases/..."
>>> by default[1], although there are plans to start using
>>> "refs/heads/{top-bases}/..." instead.
>> 
>> Ah, that name vaguely rings a bell.  Is it still in use, and now
>> they prevent us from forbidding funny characters like {} in the
>> refname?  Sigh...
>
> Yes, it still seems to be maintained, I guess they chose the funny 
> characters to try and avoid name collisions because no-one would want 
> them in a "normal" branch name.
>
> Thanks

I guess I dropped the ball here.  So given that we are OK to see
HEAD pointing outside refs/heads/, this subthread should be closed.

My understanding is that we still have an issue reported by Erik in
<amSSYagL0jTgzElD@mbp> that needs to be addressed before this topic
can move further?

Thanks.

