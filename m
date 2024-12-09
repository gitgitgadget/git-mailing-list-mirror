Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58D14F9FB
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776508; cv=none; b=hDj2gtzjDFGq8yDLfBGrXn3mZRJXiGsF6XLBTK1ncB/wlFNcGfzCDKvoRGe12qW7gsihSvfbvvy8RjQeEP/ITB8WGVhofbEvTO3bhqs+6pDJlgDlFCj8AzWOkJO194PF4L6hXEv7gMXgjbcnIfsyLpmEABX0a9bDJpc5nJgyIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776508; c=relaxed/simple;
	bh=hTKVyWVpJqibFaYFUIyH4v0L9CkKSdrz8HsJ2nPHDC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhBr4DtOOYxvMFwZg+Z7XiOWkD2TtIUBv/bARtCGopuqXrSm7ibX6uGl/U9NgGgMW5XkBuIgeZUAC3WYa1IbKhyCPcS7RjhfoQuCV3LapNRmwixhKXywmO60/LSnoBHTLNx0dIlmaoYU66mUCDjIDdQP243vYiALZnOiqq1/ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6kVC6ty; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6kVC6ty"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4350398046fso184775e9.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733776505; x=1734381305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85xFvnqZLSml01v2/vQU/pQo2BCS88Q2y19SZgryS14=;
        b=c6kVC6tyWZ32zm1Vkopm9/+XFN9jsq+s6Q2Ufxs1Xgg3ZHpe7URdso6ZQv6+sAxDix
         k6ZXC4e/CtkkGBbcyBbEsJIkYVsL2XVqToHvuZXDUi8KXkkEnsoChqLlQy9LSVCy1uBa
         vHT0tyL1YKM5m/f7jZc8oGFBFzX7LS4xIb8N3YagyWlW1NnnMDVxLXDqgeurqhe/V6Jj
         OSvfDwUwoy680ueem/ZIt8T//7FudIZlb+3qL4Ir9nsyzDjbJqNaOc/0zTJ7uS5K/qC0
         cRaZXcx4q8pj2S+9sWxJRDXAiGSjgqrxKqlkKgMFWUFZP5BEJfNaVx8GuZuuCLYw0CB2
         FEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733776505; x=1734381305;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85xFvnqZLSml01v2/vQU/pQo2BCS88Q2y19SZgryS14=;
        b=Yh6nH4YnxzAmeIaslmvSTrUr0QcnMFS4UFEnjWWrDaNyvHQWYk6akITDC6IJOBDRfK
         RS7ZGhD3xU7P7w/Rew59hd5DmsfnxlzS5fqVrv7U9nAomvn2dUAUnXqvs0u5fRFVAvzd
         wwrcdAZbqjIDsm3l26Erj0tYpIkFiu9kFZTgSH90iNV+tQVZKAIRXzDSRta7doDOUqxv
         EBBkRdr4Qqg1u4CmbL0APD+f5nzBmhyK5DqcDpVnjPhlSeLNO2VEb5WpqAg0M/T5FGMQ
         P6lmhcabIxgLR45bp7Zdv+OESELoCOVnI6o0E3pOFYX3z7216CJiDeHwJxUwWAX5Kq6u
         k8SA==
X-Forwarded-Encrypted: i=1; AJvYcCV0bTCahaP72w2dhvPz7pGlL0+djgbcCgFhnWaK7XKT+pnL8x+GV3SAd9e5aoLLt/elJ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysQuzrKrh3faifc+OBIJhGO8wwB9xln28J/7rm0vC8+J3VgLP
	L7Js1RN8Io4R6saVBziwebFg+ZbwBQzxcNwcRU136gjpouqC06Yg
X-Gm-Gg: ASbGncttDQ/O88eBEkJGv6qcL/8rlJ/1RyRuL9kBuhTAmXvTsWZu/0FEin6kAEZSO1k
	xCfXS+TusceqW2A9l31w54Fijk+qiD5uIH0pnIqrpsbjdWstJVGSzmSZ0Hy8digBGnm39tBxPdk
	8OhMY17gltN1y1Bo0a4FIyEtn9ecBJ/Srf+UEIreou6gIS2/BnGa66h0Je3DMd4TMc46Rwngkj7
	wW9kUIw2tfQjmnMGLuW4ZP2QwvU7axBExxBmWxcIZqs+wtojicbZlXzhTBX7GD+Y5tsK55tzBJ/
	VJ04gvtWChk=
X-Google-Smtp-Source: AGHT+IEutjaBOPKyGQycj3FwtFR7mlLHCr8ob1bvmjydhvk62Rm1l2hDWpA6BgvDAA5QodiU//Z9SQ==
X-Received: by 2002:a5d:6487:0:b0:385:f092:e1a with SMTP id ffacd0b85a97d-386453d271dmr1905612f8f.11.1733776504802;
        Mon, 09 Dec 2024 12:35:04 -0800 (PST)
Received: from gmail.com (193.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190975fsm13927865f8f.68.2024.12.09.12.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 12:35:04 -0800 (PST)
Message-ID: <be4ee78e-12d4-44c2-9f82-4f0db7706fea@gmail.com>
Date: Mon, 9 Dec 2024 21:35:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Heba Waly <heba.waly@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
 <D674P6875UXA.LXGHCJ9EFE0N@ferdinandy.com>
 <D6791Z2QPSUW.1LP269FO886XF@ferdinandy.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <D6791Z2QPSUW.1LP269FO886XF@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Dec 09, 2024 at 03:46:04PM +0100, Bence Ferdinandy wrote:

> I started to split the commit, but realized that I only updated "git config
> advice\." to "git config set advice." in the tests. If I split the around five
> instances of actually using "git config advice" in the code, then it starts to
> make a lot less sense for why it is only for "advice" and not for all the other
> uses of "git config" in the tests.

If I understand the intention of this series correctly, the main goal
is to update the help messages we give to the user on how to disable
the advice messages.  I think you have addressed that.

Updating the tests to use the new UI "git config set advice" sounds
in this series, because it's related to the advice machinery.

Updating the test suite to use the new "git config" UI seems out of
scope, I think.

> So I'm now inclined to think that I either
> leave the patch as is, or simple just remove the parts that are not updating
> expected test outcomes and leave updating usage of "git config" in tests for
> a later as it would likely be a larger effort to clean up everything to use
> explicit set/get. This cleanup would also only make sense if there are plans to
> deprecate the old implicit setting syntax at some point.
> 
> So should I remove the changes to usage in tests or just leave the patch as is?

I don't have a strong opinion on this.  Since my message, Junio has
marked this series to be merged to "next".  I can be perfectly happy
with the patch as is.

On the other hand, perhaps I could send my patches about
`advise_if_enabled()`, later, rebuilt on this series once the dust has
settled.
