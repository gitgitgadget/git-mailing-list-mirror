Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9463BF
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466638; cv=none; b=roZ6SzzpyN54xowttAoeDBrVF5Lqe/6Z1dKtaJ1LeWh4RMYWOXYZ4uvpuLmz2qDWNLKqx8wDiqsmcS7XxY76MG2ZdUyrYb3bBBmP9TaJR1Fvpn9l8Br+MTrzZ83DiwKyuio3gIei0RtWGcsyDLhPbbvfhvz6wzck0ApADK+TBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466638; c=relaxed/simple;
	bh=pYfdiV9OdvEMYPlCLkIE8yx7/J9tT7CjeRtM2YRz6kY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Qovj53GaINgWzjKKFAFvWcow7RluiM0XTT5f7o1Ju8dJfhVKHqZ79dGGaKsrxjkMKUTp316a/+Oi31ppECL7w6C8/4oDnNJjZpNyWCWWGzHSg48kwH/ehwcE9WvU+jQqqsAvIyydxPxwnlo71Me3dRUBW0WZ0RjGSyTQXZ15YJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HApeQG58; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HApeQG58"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712466627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fD6BnlNJAg9g+B1Z55JlKeSKEnKOuIbZZsyzZnX49zM=;
	b=HApeQG58YwyAHAsZf0RJE58Q5TiCCZSDachBtHk82LGjrYiA/P0WrgkqpvsFOw56klVhRH
	BaNlp2Qa3aP7wxNXoRgglnG4WuPGC/iWXy2LjrebItcprUvqk9uDPLo5p19UqeGo586qp8
	p+IHI44oPclDWqM3kCAxZa/9x6uY3URE4PyiVZqUXdU16lYEBsgy7mpPVdtACYjiPN3pba
	aJJV1sP9tnn2MyTQBjYupJi6YPxUwHiMGA43sXHavaw/0zNDXRFLrALvre84M2jMVT16wo
	WDpIXc8yOTwOjmddA8lhFiDyOOcjS2vzGab/s/mS5aOCm6/jYxEJpvtF6JgEEA==
Date: Sun, 07 Apr 2024 07:10:27 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jeff King <peff@peff.net>
Cc: prpr 19xx <prpr19xx@gmail.com>, git@vger.kernel.org
Subject: Re: Warning message in remote.c when compiling
In-Reply-To: <20240407013843.GE1085004@coredump.intra.peff.net>
References: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
 <7f0da057773d39add4ede71667e9ff70@manjaro.org>
 <20240407013843.GE1085004@coredump.intra.peff.net>
Message-ID: <0d8660bd28ea10d062a3bf71d5d66b8f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jeff,

On 2024-04-07 03:38, Jeff King wrote:
> On Sat, Apr 06, 2024 at 06:12:34PM +0200, Dragan Simic wrote:
> 
>> Hello,
>> 
>> On 2024-04-06 16:21, prpr 19xx wrote:
>> > I get this warning message when compiling remote.c:
>> >
>> > ...
>> >     CC remote.o
>> > remote.c:596: warning: 'remotes_remote_get' declared inline after being
>> > called
>> > remote.c:596: warning: previous declaration of 'remotes_remote_get' was
>> > here
>> >     CC replace-object.o
>> > ...
>> 
>> Could you, please, provide more details about your environment,
>> i.e. the operating system and compiler?
> 
> I'm also curious about which compiler, but I think it's a reasonable
> complaint. We forward-declare the static function, use it, and then
> later declare it inline. I didn't check to see what the standard says,
> but it seems like a funny thing to do in general.

The link below seems to provide more details.  The way I see it,
declarations and definitions should match, and the standard seems
to support that.  Though, not all compilers (or not all versions)
complain in this particular case.

https://stackoverflow.com/a/62390378/22330192

> It has been that way for a while; since 56eed3422c (remote: remove
> the_repository->remote_state from static methods, 2021-11-17), I think.
> 
> I don't really see any need to mark the wrapper as inline. It's one
> basic function call (on top of an interface which requires a callback
> anyway!), and I suspect many compilers would consider inlining anyway,
> since it's a static function.
> 
> Ditto for remotes_pushremote_get(), though it doesn't have a forward
> declaration.
> 
> -Peff
