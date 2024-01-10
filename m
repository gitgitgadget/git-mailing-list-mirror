Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21E4B5D2
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xrjCBxXG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704897881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLtYXFoBcWNMAUKsuJt9TmAc45vtZIH+B5R8D4Oqxrk=;
	b=xrjCBxXGQrMUSiWgWp+M0wpvKOszfLQWYVhVlZx+Z236tH/H8SEKa9D0X8QYMkzP7qEsJ7
	cklW2/gQdMDsuuRrhYRVIEESY2tkyS+25hDqxOQ16stD6zIIVTkBMnWjbmPnacfNpEx1ku
	Df0Y886LRBtwSF4D/6Pp1T0NCD9RehVlEnE5caSB5M0pnJErlqTAouVybl5Q+VbA+djIQI
	y/XK1XciSBlRGm6VkrIFGXJsXtSrGEhFecTzxRQyzAj71nIZxy3BMbBbOjP8Pfmf+p0yOQ
	u6cVbHvE5DLFVxMr0a1Ho6edP/zW/z1KuTumVBLypVyLhAO1nh0xprumv+UYdQ==
Date: Wed, 10 Jan 2024 15:44:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
Message-ID: <a97b03a305a7b8b95341b63af1de0271@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-10 15:32, Rubén Justo wrote:
> On 10-ene-2024 15:18:17, Dragan Simic wrote:
>> On 2024-01-10 12:02, Jeff King wrote:
> 
>> Just to chime in and support this behavior of the advice messages.
>> Basically, you don't want to have them all disabled at the same time, 
>> but to
>> have per-message enable/disable granularity.  I'd guess that some of 
>> the
>> messages are quite usable even to highly experienced users, and 
>> encountering
>> newly added messages is also very useful.  Thus, having them all 
>> disabled
>> wouldn't be the best idea.
> 
> Totally agree.
> 
> This series is about disabling _the part in the advice about how to
> disable the advice_, but not the proper advice.
> 
> Maybe the name ADVICE_ADVICE_OFF has caused confusion.  Sorry if so.

No worries.  Regarding disabling the advices for disabling the advice 
messages, maybe it would be better to have only one configuration knob 
for that purpose, e.g. "core.verboseAdvice", as a boolean knob.  That 
way, fishing for the right knob for some advice message wouldn't turn 
itself into an issue, and the users would be able to turn the additional 
"advices about advices" on and off easily, to be able to see what knobs 
actually turn off the advice messages that have become annoying enough 
to them.
