Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14B40861E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724211; cv=none; b=WKWq4WcHB9KtHZIZdEM5nLEY5aXPbABBM+ladDqkuQwrEJJw5kOtd5LUtEjAC8OjDJ34oWzPysDQ474w++nI7oTKg5m+Y0c8HFqpUk9CBX5zM5lxDM27zJ5fyYAMicFsRxI8Z7Cx9XAR8KQFvsRpDoXqiF6RAUC57BoWSLV1sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724211; c=relaxed/simple;
	bh=nBrBRVZAFpH7+pje7A9A+xrorHl2HxXNYVddRT7b+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkV3q5CDFONekiEsvnRacMTZ42gP8hXTNBCkqdqUD3L4kW6s5aT+dzzf321XJWe9wbOCHdiimxeqs5AOq2HxwTXhOwpwlYL5C1QIwU1LH6sMId5kPqzecxhSL7a6F2ezjcwWTHPNCuo0cQgURp3m6BBDf2WScnTUo5AJsNL1r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=P/dQDXow; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="P/dQDXow"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92c7a0a701aso71572585a.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783724209; x=1784329009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kvwWnyCbWtvcB2fdXrDz+3vYN6KAo6iNuXixZa2Cc9U=;
        b=P/dQDXowlCHG4DSJluljy7JpbfoMa4JS7VbLiYgL8pbo1t4tJdQJKWJhKST1uw8LOF
         rZ/6t+cdYTk/E2DxqDw578l6RrR8s0CTgc3wG2O5HT2QYnsPY5mchqo8dcqHeyu+BTzA
         p9EhM62vPT3xzJmdJlYneasmjkuqHKpvVdJaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783724209; x=1784329009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvwWnyCbWtvcB2fdXrDz+3vYN6KAo6iNuXixZa2Cc9U=;
        b=icEFQkjwLopBZa6XWVpXB9mg+DX5QrkbRhbzPeiSFjjGVvG40w7aquqJzWROcq1sJN
         9oZy7mxwbHasVmz6nuQaD9lgDffUk4C2LwFXnXnb2BQcjJFUw2vfpwtioNh9r/eObnMJ
         b8AjdVZwu2X+VGiNlYcQ6FEgFZ7ypuPc9anSQbJ8ELTGU4lFJuUuVd5QzjV31bGmbPxE
         rCyJj6MrNbdH5fGCpDIiIuNe5Y+Ic3uctPxm6uX3yxem/CWzWwXuXiHBKhepALVrUipM
         7Sgulhk1RdYS6vUXRnk3fYoo+NJlmCS1esNvF2TZZCyc5DwIEFbWAAfSI4WrbvCyYgE7
         Frdg==
X-Forwarded-Encrypted: i=1; AHgh+RpkWo39xVL0pxV2H3PlvwpaRfE2CmlxYkLA9CMTbZZQGDbtEjWO895pPHG/Lea/3HDsgIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/EgIU+nH9dACXzx9uFKW0dZvU809KiMvs+ekDL4i5uT+23uJ
	4rOcryaWDXEO2sjrDI3fcDVo+6gCuO7BPd7gG8VC6S6xsKAD7NQtPOUT7ZlRUcp51Ic=
X-Gm-Gg: AfdE7cmu30aPKlf89EUVGWpTtL9u94Qw48Wc59MV4V3mwYlBfcOLIWeOp914OYipUDi
	owS/LhMO76QeYHRIL3C5iSzQoo5V8coKj/wtNHqcnhDEXrYWDuOGrwhkj/rpsVUmQ3RMsrKWCeo
	/SS/uO97ABIYe8vzTUzcteoV4z+sNfyxzNma14MFxfbk9FWfICac7l031T3mJa09q+QJcfJ3EUr
	zUJH7OVi+LimT9kXqnNV/1cr9oRFeMhOJW5x81YuKKR+gnyra7znow9JzjWtSxeD9B8uqtbWov9
	KMC3OzWrhmxTgPj1Zjr+KeXhNAGPHR/2xUw/ooFGSNz8PzkcsOTJH8vLAVKOYwCCFXYk4mfA716
	DnUWwhVz/XfWdaNa7yCfuu0Lh2OvsCf6fo4ubqwzQeEUxkabL2QI0PwhY6IpQwEIgxB+pnXAJsc
	OwY1DzgDreibEtyxyZUm1Uqg8prJYhkGLmCzY=
X-Received: by 2002:a05:620a:7107:b0:916:15c3:cc6b with SMTP id af79cd13be357-92ef2c377c4mr146435885a.55.1783724209257;
        Fri, 10 Jul 2026 15:56:49 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88e40sm303474985a.14.2026.07.10.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:56:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:56:45 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson <krka@spotify.com>, Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
Message-ID: <alF4rYSTxpQUC38K@com-79390>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <ak0DUx5Y/5y1OINz@nand.local>
 <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
 <alFthqGQjsowvpEz@com-79390>
 <xmqqik6mbhtw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik6mbhtw.fsf@gitster.g>

On Fri, Jul 10, 2026 at 03:28:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > On Tue, Jul 07, 2026 at 04:08:36PM +0200, Kristofer Karlsson wrote:
> >> > Instead of writing "# BUG ..." and then an incorrect assertion, I
> >> > would suggest that you write the assertion you expect:
> >> >
> >> >     test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
> >> >
> >> > , but mark the test as "test_expect_failure".
> >>
> >> I started with this actually and then changed my mind in order
> >> to demonstrate exactly how the counter changed, not just that it
> >> changed from failure to success. But I'd be happy to change this
> >> too if needed - it would effectively reduce the second commit to
> >> just the bugfix line and switching from test_expect_failure
> >> to test_expect_success.
> >
> > Yeah, I think this would be ideal.
>
> If the test involved is longer than 3 lines, I would recommend
> against it, as "git show" of such a patch will show the full code
> change to implement a different behaviour plus "_failure" changing
> to "_success" in the test, with the body of the test hidden outside
> the context, which makes it hard to guess what the behaviour change
> is really about.

Hmm, I am not sure that I agree. Or, at the very least, that is now how
I have written series in the past where I want to demonstrate and then
subsequently fix an existing bug.

When either the test setup or the bugfix is trivial, I think having it
in the same commit is just fine. But I think there are two good reasons
for splitting it out if the test or bug is complex:

 - If the test is complex, but the complexity is not directly related to
   the bugfix, having to explain both in the same commit message can be
   awkward, and makes it harder for a reviewer to reason about either
   component of the patch.

 - If the bugfix is complex, having the failing test in a separate
   commit demonstrates that the bug existed before, but is definitively
   fixed in the following commit, as both would be expected to 'make
   test' cleanly.

I am happy to change my style if you feel strongly. It would be nice to
document this in CodingGuidelines (or SubmittingPatches?) if it is not
already.

Thanks,
Taylor
