Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB846D1A8
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264842; cv=none; b=AwAuYqIMPoFwp2RtIHEzHUbN0sakUzzzpnShc3fFSgcFtt5sxp3hXRuj8VOtTho+svht1lfNK6CowJIxnxMJjreAWJDxTJgC4Cq28ek+lJYWFnCMvN3MHUXZ9zA9M2pSLJiiZ0VkLA2uVa4AYuGSMaBZxP/GcFGN0V7qlzX8GzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264842; c=relaxed/simple;
	bh=S6TqR7MopMtpi33HfjV4sgUAgG2U0ezDmk4JUUexmfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/tnSuXeC3I1VQsfCAwHBMfsid4ogGusiYH8RMYYqXEZxYWElWhJwHlv1SFd044rHC3LnNB/7jZQyHhFJuFvtMbrVvKYofjnyiZpyVADqHRunV5tUJUnFb8uF28peCmPMDptUJ3Cp/327Ztd8kpTALKw2ggO6lI4aEqYI1C9IZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdDIQnL4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdDIQnL4"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so25614221fa.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720264839; x=1720869639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGviB0zBD6EgkZAVbceJ2St3Z7lw4k05FOMK9+AYvJA=;
        b=HdDIQnL4mBDw8ZE4vu2DBrXHvbUAfpAn330PHm+eNs2r6shZZuP3a/s9LS458ULkqI
         Kd2LBO0mgRSPZX8xDdbU6YZxmH+0dPJZTuWU7zWxWQuGvJm5qslJZhc8bOAVTaVc40qx
         8bD6SYYG/kU1m0iNFi4B8J6+RNGOLc+SsiYemf3wiWoOb7dKAW47/cTFxxIWtFuU4KLs
         SwuqM1WrU1v2UwJVTNkCyfy06ivgD6+biP2AqDcUy6UXXjNQVveQoa7peVX2LhJnLNAs
         p33ib/0W9PyyqA24KRwfyFFbhLFpeLoyc3IkmteUaB8MkDvtFCpB8rnPKXNLnM/NbCFR
         rzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720264839; x=1720869639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGviB0zBD6EgkZAVbceJ2St3Z7lw4k05FOMK9+AYvJA=;
        b=hhg08gjIgGcfU2jf9hGtf3+anAUiv3S4bglwJYdaOpdefNrJ34LIMdecjjzTGMbKDb
         O68yFkkem1RsIgTfoEvka5FQpoClbxc41qd9e0dLC4uXAajTNVF3eI+PFCGlr6oSj+zt
         VOAnP9pq669ryjvBiqVLhxAPxuupboeRBTPLgvxmB0/Msfw4ONN38o8ULE3qKuJtrHuC
         TXe+eoLVYhaNuTR20RovkfnzExoY3lx36yzvLWI8JIbIk322JQ/7SVbRQ6GVtiSzoJt7
         DfgIbSececosj1bzpzmpPwc/69a9AER/3fFRxWSNy7pHWLo/PCgEmJftUR37sVy38SsC
         kQAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWdFqcSG4WtrWL9x0VeAwtxp33Y1UfwhapF9VqUXh6Br1yEzyuUIedt70cTLMFYc4bw4C5n6xlXXmGuuWP8eeC2egV
X-Gm-Message-State: AOJu0Yzb+qjliYrcnEPqhKQ+vAVt1MVVRpX6/tYJXwxoD2Q7rxmc/G98
	tIMR7W09khCtCC5whDoTsYRaulMo+gmkbAvxf2xI08dQniUBvMux
X-Google-Smtp-Source: AGHT+IElUpthO9y9nj9x9vW1npFIA6tpzL0wLMu6Bl/qnksyX9Ef+3NUhrMnhlmO5u861vPgTs95dA==
X-Received: by 2002:a2e:a4d1:0:b0:2ee:868e:e281 with SMTP id 38308e7fff4ca-2ee8ed90b66mr54282991fa.14.1720264838357;
        Sat, 06 Jul 2024 04:20:38 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678877f19dsm11484550f8f.43.2024.07.06.04.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 04:20:37 -0700 (PDT)
Message-ID: <75a635b9-7622-42f7-b202-6991775e75f0@gmail.com>
Date: Sat, 6 Jul 2024 13:20:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 <xmqqv81ovp9l.fsf@gitster.g> <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
 <72b69a20-3f51-4f51-8ebc-ead20e3eebcb@gmail.com>
 <20240706061850.GB700645@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240706061850.GB700645@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jul 06, 2024 at 02:18:50AM -0400, Jeff King wrote:
> On Wed, Jul 03, 2024 at 11:44:33PM +0200, Rubén Justo wrote:
> 
> > > Explicitly indicating that the error is being forced due to
> > > "GIT_TEST_SANITIZE_LEAK_LOG=true", for a test that doesn't fail when run
> > > normally or even when run with just
> > > "GIT_TEST_PASSING_SANITIZE_LEAK=yes", could save us some confusion.
> > > 
> > > So, I dunno.
> > > 
> > > Anyway, I agree that this can be addressed later.
> > > 
> > > Thanks.
> > 
> > Maybe what we should do is integrate "GIT_TEST_SANITIZE_LEAK_LOG" into
> > "GIT_TEST_PASSING_SANITIZE_LEAK" because I'm not sure what value we get
> > by keeping them separate (test performance?).  But that's another topic,
> > even further out of scope of this patch :-)
> 
> I don't think we want to integrate them, but I'd suggest that
> SANITIZE_LEAK_LOG should be the default/only option.
> 
> Without it, you are potentially missing leaks in programs whose failing
> exit codes do not trigger a test failure. So there is no point in
> running PASSING_SANITIZE_LEAK=check without also checking the logs. But
> it is still useful to set SANITIZE_LEAK_LOG just for normal runs to look
> for leaks.
> 
> I don't know of any reason we couldn't always check the logs (for a
> leak-checking build), and I didn't see anything in the history. I think
> it was written that way only because there is otherwise no affirmative
> action by the user to say "and btw, look for leaks" (and if we are not
> looking for leaks, there might not be any logs!).
> 
> But really, if you have done a leak-checking build, then every run of
> the tests is looking for leaks, whether you check the logs or not. So we
> should able to just check that $SANITIZE_LEAK is set.

> And then there would be one less thing for people checking for leaks
> to remember to set.

I completely agree.

Let's wait for the dust to settle after the fix in this series, and then
I'll address the change as you described.

Thanks.
