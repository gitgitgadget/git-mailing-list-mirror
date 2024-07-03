Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71294191F91
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043083; cv=none; b=dWXRmBZaoKO8duLZrbOhokePLJFGwuH1YLQl2voBrfh4lO8H042+U4Y7V1SdvheZYH2eOwGgMHyeLBlF5WIGusvIuPnvZpdq4fzURhUAtGLhqzTD3XUMuqB9pemMsd+LM3madXkIuQyzymVbQGR7NIIOJbQVEntG3GKHeYLL1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043083; c=relaxed/simple;
	bh=PVzZte3swP1P61mW8unyzVunfOWomrbbOmSf7bdQKTc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QB47WCzCvKRs59PM2FnPqNdeg5mIESz5KclXWAQFdJ7QHA0v8m8j9w5MDuIB9GBQbP9dq++kcSRk4q1NB8yt6Cjsc4Im46LbG4Q/NAj6xv8aQPn8Ho61RdGwgmyaz7obfP1zWls72AR25+1zEEdH3yMsIPnNe07vEn4XzmRvoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZCb/jXz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZCb/jXz"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so81004221fa.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043075; x=1720647875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NkyxrgUWrN5Bs3uAx4RgmZBilUYLQn1ybUWHrnDE2Z0=;
        b=bZCb/jXz8+D9jSKb6h4Y9vIPO7JAS21OiDhzkUxlOlQEYba6DojsDA1i4Yx/gRN8+L
         7YfLV5Iwse2fliHaVKKT6I1o8TCh94CucCXBH4zMtedw5pNI+4Htoa6Veh3L9ISubgLv
         RAAxbgoubGCnU7ZRlCdPzES2opKWLzRvTF8bLTwIpMJO3i4Q+YsyTt3ZqzxoL0DFLlcj
         VOkmtJGFpgTnoGbpUn883vyxYNnTbOAKaNuvwtN0LKh3wObPj01bmarphtYqbfA2XGv3
         asg/psSTQS+6LERYdKZZQ+zQTyguQ4I4dDS/Q0ku0652rOIehXr0kgAv70mVYHmJHqyA
         dRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043075; x=1720647875;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkyxrgUWrN5Bs3uAx4RgmZBilUYLQn1ybUWHrnDE2Z0=;
        b=TEk8jKGhaYucG+U4kb6AXDwcu2o0fgxFLTufO2/TGfwtisTJpP7g6rXYtH2GJPxfAg
         QJ+vicL5QjfNMOpQVByAEBagYLK54Zqo+MZPqd8fCHL+Isjf+ED3+9wp1Mtk/GRLEF+W
         Q40SH6xDLKcAWLk0oeI5a8oWv6l2UDW9uERcYUaEyWFRXwQhevxtDYmED/u3ElVXLsZU
         znYRSNcXXyLye25NNB2hzHDkz+R/1MAtKMWZFVXdcbXVGXkyx49kh/bsW1e0EPh0To1w
         0wi1zqnrtOIHyxb0OdobfA6OtOlck/3pZismN5EXq8R+krpIQ3VscaK0bs3jMUva3vdE
         fPDA==
X-Gm-Message-State: AOJu0Yw1YUcgfTjqtM7En56GQxiipxxMsydKDsIhBJ6Uu32EdaPM4mja
	3bJKu2slTMZFOp8rXkgky8GZAuzkMk4QvC5KLkhyOhABpQEl5ouk
X-Google-Smtp-Source: AGHT+IEArHxdJEK8mh5uihQw2A91zbFPh7tZMDOBBd/sY2sd/XyLSj+SY1KOB7yIQ+jwZZEBxkN2oA==
X-Received: by 2002:a2e:9dd4:0:b0:2ec:403e:6314 with SMTP id 38308e7fff4ca-2ee5e3809b5mr86882031fa.3.1720043074691;
        Wed, 03 Jul 2024 14:44:34 -0700 (PDT)
Received: from gmail.com (110.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba67sm252119965e9.19.2024.07.03.14.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:44:34 -0700 (PDT)
Message-ID: <72b69a20-3f51-4f51-8ebc-ead20e3eebcb@gmail.com>
Date: Wed, 3 Jul 2024 23:44:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 <xmqqv81ovp9l.fsf@gitster.g> <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
Content-Language: en-US
In-Reply-To: <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 03, 2024 at 11:35:48PM +0200, Rubén Justo wrote:
> On Mon, Jul 01, 2024 at 01:19:34PM -0700, Junio C Hamano wrote:
> 
> > Your patch from September 2023 [*] did mention it upfront:
> > 
> >     GIT_TEST_SANITIZE_LEAK_LOG=true with a test that leaks, will
> >     make the test return zero unintentionally.
> > 
> > With that inserted in front of the proposed log message, the
> > resulting explanation looks reasonable to me.
> 
> I see that you have already added this paragraph to what is already in
> "seen". OK.
> 
> > > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > > index 79d3e0e7d9..7ed6d3fc47 100644
> > > --- a/t/test-lib.sh
> > > +++ b/t/test-lib.sh
> > > @@ -1269,9 +1269,12 @@ check_test_results_san_file_ () {
> > >  	then
> > >  		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
> > >  		invert_exit_code=t
> > > -	else
> > > +	elif test "$test_failure" = 0
> > > +	then
> > >  		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
> > >  		invert_exit_code=t
> > > +	else
> > > +		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
> > >  	fi
> > >  }
> > 
> > This is outside the scope of this patch simply because it is
> > inherited from the original, but does ", exit non-zero!"  part of
> > the message really add any value?
> 
> Explicitly indicating that the error is being forced due to
> "GIT_TEST_SANITIZE_LEAK_LOG=true", for a test that doesn't fail when run
> normally or even when run with just
> "GIT_TEST_PASSING_SANITIZE_LEAK=yes", could save us some confusion.
> 
> So, I dunno.
> 
> Anyway, I agree that this can be addressed later.
> 
> Thanks.

Maybe what we should do is integrate "GIT_TEST_SANITIZE_LEAK_LOG" into
"GIT_TEST_PASSING_SANITIZE_LEAK" because I'm not sure what value we get
by keeping them separate (test performance?).  But that's another topic,
even further out of scope of this patch :-)
