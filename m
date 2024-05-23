Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167552E414
	for <git@vger.kernel.org>; Thu, 23 May 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473888; cv=none; b=Sejh/Qc+zSUz1AsrBMw3L0nZu20UQCWg6u2CEzHDUy4RhIRHkK3tXblaWDbbJQmml1Ri67G+jIKYoXmPwvnj1mcVxh2kCEJkkhu8fFetYqozbQPA09cCATbge3HA/l3V1BqPq9z7Mvwc+wiOziv+TcEUqj22AAXPd1tK+lLmbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473888; c=relaxed/simple;
	bh=Bd4NIEipIbnIVDEqLkgHE2kU2ok0b0/Uc5whyByezWM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WL/CVp5NmfbHLZFmb1SVLrYqdDksbZiCrecUpd9g/OXzj+fel5LwBT0U+gThD/HDJp2zb5dQs5jq3T4kRRJbimybFDHcO8k1z9ZHVpLopJk3PlKbchjkpeGxzqDkoAS32SQ/+inv+PDydTPmEjlbIofTysm25A3RC0HfKikxl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ei8OzLSE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ei8OzLSE"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716473883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wAkdD+NwFXGJ6gLknPudDO90VLTe7eJbgdsviq2yfc=;
	b=Ei8OzLSEN4QMEtiFjo+CkbRJ0X+xLPF1sMbjzqEtYyj/emX3JfHMfPMOEe2q3P7SKNUzHS
	yt3zVfMI//+8Z4f4E00xxpfTOXAgDHwRfziPrx24YZIlVPKOEwXV7R5Z5knzwk1uAINBtE
	Jj/j/T0fMcgrG45SvchA4QPKL8V4ROVgVV2mQQ+Ozv2qg2DAkEV1AlS18JW4xTpiowVfP7
	Nb1PQWgZz1VF+uwdfkIGLWSczfLsQobXriyy6nPYos1zVMXMoR3sUtZRt0AngWFfY7sETT
	QjB6iDwdfCsN+8F8EhZHmjwGsqNbLCGJ52H4HU9//IUSeJKoVnVMOeG8I3bxCg==
Date: Thu, 23 May 2024 16:18:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <xmqqjzjky6eo.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <xmqqjzjky6eo.fsf@gitster.g>
Message-ID: <261636d461e58ac8a16180c4cd6e0460@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 16:00, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I do still think it
>> would be useful to be able to configure its pager separately (in my
>> case, I'd use "less -FX" rather than my default setup, which doesn't 
>> use
>> either of those options).
> 
> Even better.  Allow to optionally have the command after the option,
> e.g.,
> 
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] P<RET>
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pless -FX<RET>
>     (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pcat<RET>

Please note that "-X" will no longer be used as one of the options
passed to less(1) as the pager, in the upcoming resolution of the
age-old pager issues. [1]

In more detail, "-X" is actually an ugly hack that was nothing more
than a stopgap measure, but it has never been resolved properly.  That
is, until recently, when I started to collaborate with the author of
less(1) towards finding and implementing the real solution.

[1] 
https://lore.kernel.org/git/8289ef15266172cbfa10bb146afe9797@manjaro.org/T/#u

> The first one feeds the default program with the hunk via pipe, the
> second one instead invokes command you specifed, "less -FX", and
> feeds the hunk to it via a pipe.  The last one emulates a plain 'p'
> behaviour.

Frankly, that would be a lot of typing, and may even open a path for
some unforeseen security issues.

> And for usability, perhaps giving a specific command would change
> the default program a bare 'P' invokes for the rest of the session
> until another specific command overrides.  Another usability hack
> may be "[interactive] pipecommand = less -FX" configuration variable
> gives the initial default for each session.

I think that would be way too complicated.

> At that point, we can explain it as
> 
>    p - print the current hunk
>    P[<program>] - pipe the current hunk to a program
> 
> or even use '|' instead of 'P'.
