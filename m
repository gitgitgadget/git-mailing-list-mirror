Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F1156F46
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025734; cv=none; b=Yn7Bqf+eGmTLIDpX0s8Zn/0h2PDVaJOregifv3opL0y3wRSkoVFGZ/bup0vB7M7SUnit1ppt32EmOycmDD8YUE1Dx8AI+u+5q0nd9CQN50qAEGYOte/9KIIWMdAUOMvdtKDNSH4YPU1ktleZ4ITbisvtevlNoVEEhISmnx7UMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025734; c=relaxed/simple;
	bh=rZxycWQ2AmwPaANT5a2w0ELjVdP9Ksg0qW/KPW/pPTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVMKGrNzQZvqui2Nq75XtO1jM2tQW1CzA/CzfvrUCPFvMgUrNPIMGoosMnyYEF9fKollUwXD5xkqI1JJCXjTlCl134Q8W4ExTH9hFzWa534qZom6/CM5Ljl4QI+uWQwup0WjkkKYu5iXGEV/u1KB2II5Ir43GyKUn8G73DvGag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1x+vFzu/; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1x+vFzu/"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c8bdc30f7so9671515ab.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025732; x=1715630532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTSUJyF7yMJ/5XyGs0zRoBsdCvSnuMI7k1v6spLw7Tc=;
        b=1x+vFzu/X/DgZg0RE0X8gVjEm99cGjmuW1W7116S8Nhtjo3ayRzz3LDx5bftSXsJpd
         VdZXmZVVqS5jVQEn1/qNtR80aOLFSyAaW3ndeAxiNMjb5qgsEgCVOUN6piH9CkQrVkK0
         ZJ2Re435qwsh2d0QdDmNOzLGc6LoDbrsY4zTVW7us6mjSpS108ULN5SiBwhYs3JG3+RP
         PGffEi+YAzNH2x3da2eOvWBFRpmO9nKgX2MiU3bfCIs6kak4PKRMPll97EwrK7xJ98bi
         gN/GPBrufY0LRe6RLjbvV+eVIhRyzbUn+dVaWwerixTgTPVRZZmF2wKbaO1M/FGNr5Lx
         kcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025732; x=1715630532;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTSUJyF7yMJ/5XyGs0zRoBsdCvSnuMI7k1v6spLw7Tc=;
        b=aEM28KvMs6AlWmhjLhnzJP4CgYYKCpUZiNpaDSOUrAXE1V8GB1RdkQ6pVa/KM/hDSf
         hAIQFTJvujZnMEhwKDaEaWq0DmT7nuheIK1R8xLTvjHia9So26UQI40TMKO3QNVpdv69
         OtvnEEsHNDJL2bjlDs+6eAzZ00Gc5OGXN6wOa1weia2NiN7iiswXw3VQ43Kas5Kuwiqr
         FJHyj0qdICJmn5JjptohQTE4YLVhnPUjMkn6vTokdc6eseiCkvHD+oceUMmaBCdruBL8
         xs5vERwJjo3B2ZPNYxe92vNFjamNR3l+8Qvyt9oI/3iS2xVxJi8a0y0AddW+yMrmnGGZ
         nShA==
X-Gm-Message-State: AOJu0Yy3CS5BIjoIPXJQ2ZC7JocgjLbdf5bsbqgrH7EMli2hjsQOFNVK
	93eg+rZWzW5+nyWlRlV1luupT+ik+Yma/Sxh+M4BF/4r56UBvzw4KbJ8/NNwVUPqLjjJfqhvxR3
	GpQ==
X-Google-Smtp-Source: AGHT+IFNEFrOY7sFykkGohHj55wAoM7Ka2tZX1tiKtIzxUYvN6kJw6wS7vUUFYCW89uaryDHMItHmg==
X-Received: by 2002:a05:6e02:16ca:b0:36c:4c7e:3059 with SMTP id 10-20020a056e0216ca00b0036c4c7e3059mr13879107ilx.4.1715025732074;
        Mon, 06 May 2024 13:02:12 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
        by smtp.gmail.com with ESMTPSA id s187-20020a632cc4000000b005dc4b562f6csm8416707pgs.3.2024.05.06.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:02:11 -0700 (PDT)
Date: Mon, 6 May 2024 13:02:07 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 0/7] test-tool: add unit test suite runner
Message-ID: <agz4p6ilfrlxnt3wjjxiqpecosne5ipax32fskzgh722xxryzz@7ddif3kdujkt>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, peff@peff.net
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1714506612.git.steadmon@google.com>
 <xmqqbk5qy2l3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk5qy2l3.fsf@gitster.g>

On 2024.04.30 14:15, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > For various reasons (see discussion at [1]) we would like an alternative
> > to `prove` for running test suites (including the unit tests) on
> > Windows.
> >
> > [1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/
> >
> > This series extends the existing `test-tool run-command testsuite` to
> > support running unit tests. In addition, it includes some small
> > cleanups:
> > * move t-basic out of the unit-tests directory
> > * don't hardcode the shell for running tests in `test-tool ... testsuite`
> > * don't hardcode a test name filter in `test-tool ... testsuite`
> > * add a test wrapper script to allow unit tests and the shell test suite
> >   to run in a single `prove` process
> 
> I am OK to see it outside the scope of this series, but we would
> need unit tests supported by the GIT_SKIP_TESTS mechanism (or an
> alternative mechanism written), given that I hear "migrate tests to
> unit-test framework" every once in a while, which means we would
> accumlate more and more tests that ignore GIT_SKIP_TESTS mechansim.
> 
> I did spot one potential problem (rather, "we'd want to fix it as we
> are changing it with this reroll anyway"), but other than that I did
> not see anything wrong in the other patches.
> 
> Thanks.  Will queue.

Ack. I think the current GIT_SKIP_TESTS system should be fine. I'll put
it on my TODO but can't promise that it will be a priority yet.
