Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4665133405
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120724; cv=none; b=pIX5JAncDlM2aGknI8IHp/THds/BIypVwqCH409BM/orQlGU/6/SEyOeIuRAmrZjp4gzqGe7c43sSJIDDYUE+fvxFPaU0kjPwUG5lGdm8KRZ7PCo7dLNKU60nuPbITx0kEspW9xhLDco1OfhWUHcTU9bK3mADIy1fbYVSDTZ/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120724; c=relaxed/simple;
	bh=tjf4CJ+4EOozLJb3rma55V9mVEHi62g+/v9Nh9t4pI0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iU0XFhJeR4yJIECuuquT6eulv7M9pQW7XWMPFZXvYAYQfI40dOaqEaKH80bEdyL2BBI3xSCdpJry31TNXxlwuuJ2j/Cy2w4PIfSELPTzPgqIoLpGR/oJuKUJck48KvOFEAgaVV5bn/naqR1hJCgCWPKJBumR/KgiXGcrJDa5aQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eR+Y2V+e; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eR+Y2V+e"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708120719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sUH6b/2aBmZODPn6broEd6SZ7gjrOy9sgIDxVhFmD0=;
	b=eR+Y2V+eAGf0DjbyYA8Gpf5ldD/jBsGTX/Q4bi5s8K3YQA/g5ntioYQJpVreICxHot9r2h
	uu+R19tjHgycwjNhTRu5IcmHMAwQnHpnjrLk0yWN+yICbVVQB1xNRcraOvrZ5vAWstqIXS
	pip/8GsI/dgqXyDEXce0urZQ8P88OM9lCeA5Wa/tUg75wFVVjsJtNDhXPaSkfUDwSjK8gn
	L15wqk2lq/QHOP/CCriNblN4u/8qx6fma92k2A+SuRGND+aHtPGoqVnXQaYEsROs0z5rXI
	EuncpVhGRjUfSMd5fArigEAKebKjoj76w8s9vF4hbZV4tiQEC1VpW1gxbdHhRQ==
Date: Fri, 16 Feb 2024 22:58:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name, rjusto@gmail.com,
 spectral@google.com
Subject: Re: [PATCH v2] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <xmqqh6i8gk20.fsf@gitster.g>
References: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
 <xmqq1q9ci3jt.fsf@gitster.g> <608b4e81d71a95c820f1e4068382d391@manjaro.org>
 <xmqqh6i8gk20.fsf@gitster.g>
Message-ID: <7fc9dddac54d09f706419c903911a73c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-16 22:45, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> But the halfway modification to the description section in this
>>> patch is not an improvement.  It makes some options described there
>>> while -m and -c are completely missing now, making the section
>>> incomplete and coverage of the operating modes of the command
>>> uneven.
>> 
>> If I got it right, you'd prefer this patch not to be accepted
>> separately, but as part of the future series that would rework the
>> entire git-branch(1) man page?  I'm fine with that as well.
> 
> Not necessarily.  If you wanted to this this in multiple steps, we
> can first whip the OPTIONS part into a good shape, and then fix the
> DESCRIPTION part.

I'll think a bit more about it, to see what might be our best choice
moving forward.

> What we want to avoid (not limited to this topic) is to say "this
> temporarily makes things worse here, but trust me it will eventually
> become perfect".  Removing only -m/-c from the description section
> makes the description section worse than before the patch---we'd be
> better off leaving the original as-is if we are not revamping the
> entire section.

The way you wrote this brought a smile to my face. :)  I agree, making
things a bit worse while promising perfection later is rarely justified.
Perhaps only when some nasty bug has to be fixed ASAP.
