Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029323B1AB
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624992; cv=none; b=hUHPZ3aIqOwhfOZYV5O2/jyVh4hzrOO3+QKqJ3oKx/GSsUFMtwGPCTfe3qz3CWcW/HQJuBjiQI11CIfy+Ayk7GLiVRQf5BHtpWWoBO1/GPrzNrcFYrlEhHCuC62DcCmudbVM18G94emDmtKVvwwmHn6sEJ3blKlu1z2QHYDfJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624992; c=relaxed/simple;
	bh=89UJhljZ76me26a6WGI/yaRSBYF5zG+H3GBpDLWAAyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXGjT5cXSlOOUqU3PjK0ddFxhezaCCWAUN37TC7UdGPjV7uvI6Kewr4LpLgyrOLskHIsjbUiEadzPyxTJ8DNO7ox646kUO46h0JK5sJ9Bn4eoOWYjANSlni+YWLLhjXV+uOaWYV3/ia1O+Q7t+1o1sHD86akyENbBwMoLXPS7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzXrESQv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzXrESQv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42155143bb6so4004705e9.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717624989; x=1718229789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/YjO0d60Uu/2dCerkOa4/DEU9qBsZD6VOHtRCG4h3o=;
        b=ZzXrESQvZgggN8rKKZCqvz06YNcn8WgSOUmsf6GuDFmW+Ht97gBVm/JdQyEIwCBZlw
         VJaK2VJMrVScuWyxnlYSiR5gBgJc070L5CBbpWdAiO7peF9FjfeOD8srLnZ/bIIsE4F2
         c0oE1wBBLRTpQDEs9spxZCBjkQm6H+aOTg0RYoj32ldmIALufrpYvlte6fXu+GxP4Jl8
         6DckqjnIHfrR6D3Dwm3aMlUsbeVCw4QTyVYthRH0g36dY06Rsfejmy0Sos59optqrFHL
         5osPtkDeIa4evPDbaXeQKqeCk8Z69osqlsKh98dAYZze+MGeGop0bjILQTbdIknD0ZOp
         79sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717624989; x=1718229789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/YjO0d60Uu/2dCerkOa4/DEU9qBsZD6VOHtRCG4h3o=;
        b=eqP28zcCqN+mhhcWM8cHSqzr2F6PZcRTAy8XZ3AbC9CWZVCgvavgR+UFPnupcwFRKJ
         ol12QA0dIBe/YrkGG19gLVx2CnQ8YjtuP2ktGVUdJnKp/f5+YjUGhXJS/Ezp8xExugJE
         ktfa9ICkGFCoLgYYR/OiT40Slf/oS0+YQq4inLOK/71yL6y/9x43rFWvXPBwTPItjMQO
         e1cpT7jihX4tryfaUHyZlMZjB5AvU0VHYFcwT9mCmTLg/LovawNXFgYPAp1YqXXW4b5v
         bdJ9w0/1fcg/5eZCKtai8bSE4CpUFIueY0ei1lEei5VRwd2ctmjTEG6iWVmQkt89NiF1
         5J3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtWEhbRdBiIngjfxlxVEEIUPCdpgYQQ8+t4ZwFZ/U7hvW1ndrwbA5W0lhMiC1LDVrtukL7NvZB9oGvk2W92RcnKiEP
X-Gm-Message-State: AOJu0YzqwdP8VZaRa2sp1IUWtfq4pmV2ynFAIabTHqwox13GfcmgU54R
	mPXMpjwk0hZ3JU60JtEUmflPceUe047oGpFOrTQ5U2sG6nx7h2bM
X-Google-Smtp-Source: AGHT+IH+uV/h2fwYWBjwBx7pUEGdFv5ROwserP2neH7uM3KsJbCrHyxS+N8DU8r2Rok+Pwpul2Ol3A==
X-Received: by 2002:a05:600c:444b:b0:416:536b:683a with SMTP id 5b1f17b1804b1-4215635045emr30449925e9.32.1717624988988;
        Wed, 05 Jun 2024 15:03:08 -0700 (PDT)
Received: from gmail.com (52.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e91csm34767985e9.41.2024.06.05.15.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 15:03:08 -0700 (PDT)
Message-ID: <0c93f4ea-aef1-4639-9d58-1decaf24c90e@gmail.com>
Date: Thu, 6 Jun 2024 00:03:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] pager: introduce wait_for_pager
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
 <3f085795-79bd-4a56-9df8-659e32179925@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <3f085795-79bd-4a56-9df8-659e32179925@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jun 04, 2024 at 11:00:37AM +0100, Phillip Wood wrote:
> Hi Rubén
> 
> On 03/06/2024 21:38, Rubén Justo wrote:
> > Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
> > 2006-02-28) we have the machinery to send our output to a pager.
> > 
> > That machinery, once set up, does not allow us to regain the original
> > stdio streams.
> > 
> > In the interactive commands (i.e.: add -p) we want to use the pager for
> > some output, while maintaining the interaction with the user.
> > 
> > Modify the pager machinery so that we can use setup_pager and, once
> > we've finished sending the desired output for the pager, wait for the
> > pager termination using a new function wait_for_pager.   Make this
> > function reset the pager machinery before returning.
> 
> This makes sense, I've left a few comments below
> 
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> 
> >   static void wait_for_pager_atexit(void)
> >   {
> > +	if (old_fd1 == -1)
> > +		return;
> > +
> 
> This is good - we'll return early if we've already cleaned up the pager.
> 
> >   	fflush(stdout);
> >   	fflush(stderr);
> >   	close_pager_fds();
> >   	finish_command(&pager_process);
> >   }
> > +void wait_for_pager(void)
> > +{
> > +	if (old_fd1 == -1)
> > +		return;
> 
> Isn't it a bug to call this with old_fd1 == -1 or have I missed something?

It is.  I'll remove it to avoid confusion.

> 
> > +	wait_for_pager_atexit();
> > +	unsetenv("GIT_PAGER_IN_USE");
> > +	dup2(old_fd1, 1);
> > +	old_fd1 = -1;
> > +	if (old_fd2 != -1) {
> > +		dup2(old_fd2, 2);
> > +		old_fd2 = -1;
> 
> We're leaking old_fd1 and old_fd2 here.

Good eyes.  Will fix.  Thanks.

> wait_for_pager_atexit() flushes
> stdout and stderr so this switching of fds should play nicely with code that
> uses stdio.
> 
> > @@ -113,6 +134,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
> >   void setup_pager(void)
> >   {
> > +	static int once = 0;
> >   	const char *pager = git_pager(isatty(1));
> >   	if (!pager)
> > @@ -142,16 +164,18 @@ void setup_pager(void)
> >   		return;
> >   	/* original process continues, but writes to the pipe */
> > +	old_fd1 = dup(1);
> >   	dup2(pager_process.in, 1);
> >   	if (isatty(2)) {
> > -		close_fd2 = 1;
> > +		old_fd2 = dup(2);
> >   		dup2(pager_process.in, 2);
> >   	}
> >   	close(pager_process.in);
> > -	/* this makes sure that the parent terminates after the pager */
> > -	sigchain_push_common(wait_for_pager_signal);
> > -	atexit(wait_for_pager_atexit);
> > +	if (!once++) {
> 
> We only need to increment "once" when we enter this block, not every time
> the code is run.

OK. :-)

> 
> > +		sigchain_push_common(wait_for_pager_signal);
> 
> I think we should be calling this each time we setup the pager and pop it in
> wait_for_pager(). Imagine a caller sets up a signal handler before calling
> setup_pager() and wants to pop it after the pager has finished
> 
> 	sigchain_push(...)
> 	setup_pager(...)
> 	do_something()
> 	wait_for_pager()
> 	sigchain_pop(...)
> 
> With the changes here it will pop the signal handler added by setup_pager()
> rather than the one it is expecting.

I hadn't thought about this.  Thank you for pointing it out.

> 
> > +		atexit(wait_for_pager_atexit);
> 
> It is a bit of a shame we have to leave this function active when the pager
> has finished. We could add a wrapper around atexit() that allows us to pop
> functions we no-longer want to call but I don't think it is worth the effort
> here. wait_for_pager_atexit() is careful to return early if it is not
> needed.
> 
> 
> Best Wishes
> 
> Phillip
> 

Thanks!
