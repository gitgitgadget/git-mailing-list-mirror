Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1D1474A8
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462277; cv=none; b=sW9+qCB1okg9RUJub919y9S4eDyYq/8ujTWKsjjROW0cfmkB4nqihdqFhvNjp8YKq644LLbmOTD5q47M2WPSpGoM6fFeqZvIBod/7YhO+md2Xsm4n+i1qrlRb0N8yrdr4LtUxBTSLBla0hOR5hbBWcdIBjU8wlQo6RxniG19+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462277; c=relaxed/simple;
	bh=uqPQvhvV61/47h92gAFgsY6EQy0t0ET5bApIrGyMo50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFubF42rNzsiHNi43yXiY57+maJHn394+dD122fQF9PAGtGgYRo+SHKdADeDzu3FZeWM02Rorpf0qcY+UERqrzVyKlHtWhmvu+tdb4owry5u3/axNbsPx3ZnMJujRW08TUNcczJR5slLM8ltEMmmiBnyObTCuvQqIVu+rutQ6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eU/rXAJC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eU/rXAJC"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2454507fac.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720462275; x=1721067075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByRSP2HcT/OmNJZ+1L+N9vHeCxAvl0/QOwhxpDF6Zg8=;
        b=eU/rXAJChHHdZMOtUo6/+LaQTAdi3q4XX5dLFR6JIZ9jRBk72yd1YBE5V3XhW/Z6OK
         LTgUXNZN4HrElnFNSkZ45gf+keRnMrVLfdTBvJBnGjyyheX3paEd/8vpW0+iOgJbBnsd
         D3zx5jlMwIABf+J3GaYNFRXzP0UNzOwE5ro8DiX3EpHzpOPTHi8W8wRCilJrbcRA4YPk
         WbGOeYdIpwf+dcnOD6oRpc3TVaqUz3k72KYDqq8upKttYJv5lXV2MXzBa6LNigUzS1kn
         W+BLAxQ6FSD5giR7ZLz2l2exzgyO1A1xwpgV6NkFhjKjGp/192DkunX3k4LBdcojk4ri
         Hcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462275; x=1721067075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByRSP2HcT/OmNJZ+1L+N9vHeCxAvl0/QOwhxpDF6Zg8=;
        b=WbFyidJFZwmTxt7FklGmzA/wopw3r5RM2UGJKcPbEXEiDPanPgVkXEOi+mQjijY9EE
         F+TM2I1v0aYqM2uyfuG8oOFDAt/Ha70qUQDTcO43d6bhEGFLoNIwWOuQY0GG8S1kZNfe
         d9uUFoC6AiLkJiPZnLSluhgfXnZlb75E0Uobye0QTeYGOfuCQYsk4OsS1Uju0pMrQ00e
         Ch1DvqZwNqDBu3apFzbqwIJBztWLb6AZ3kK9DszBqi4DweFoIqqboeuWjZx5+3ziQp3s
         JBin1nqnFebggvxTEEGKh/DOi14mWccBz3UL/ttQIV4Y7l+4mV2f/7zLTQ6IHdDwy1T0
         Vm7A==
X-Forwarded-Encrypted: i=1; AJvYcCVHmbB3HCa2TXNdwVFHp1Nl1QDjIVxxysdrjhAGsWMxd3EU/Gy9TU5z2BczvkOiwIwOJve8gdLGpJqdMBj0P+SxCwjN
X-Gm-Message-State: AOJu0YylN/9//tZx9APlJpKqiREJPMIKmC+Vh6v56B2BD8Vqd9WEPI5B
	Y3cnoa5rLfxuTqChl8bM3i6qXIWWdvTAQW8Y60AfBhs1fB1WDysrBR+ECGkjtg==
X-Google-Smtp-Source: AGHT+IFUcM51eZ0bwnWcDdKjg9I0SrbH8hQGCQKGQq0+cHhX7vLOxXjdv2u9lZ9JzFQGN06iPLAPwg==
X-Received: by 2002:a05:6870:55ce:b0:25e:5ff:758b with SMTP id 586e51a60fabf-25eae761feamr142697fac.4.1720462274575;
        Mon, 08 Jul 2024 11:11:14 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4af:e000:f2a5:b9e4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5edcdec1sm161777a12.6.2024.07.08.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:11:14 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:11:08 -0700
From: Josh Steadmon <steadmon@google.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
Message-ID: <tswyfparvchgi7qxrjxbx4eb7cohypzekjqzbnkbffsesaiazs@vtewtz7o6twi>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Phillip Wood <phillip.wood123@gmail.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>

On 2024.07.02 22:59, Ghanshyam Thakkar wrote:
> Josh Steadmon <steadmon@google.com> wrote:
> > > -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> > > -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> > > -	TEST(setup_populated(t_addch, "initial value", "a"),
> > > -	     "strbuf_addch appends to initial value");
> > > -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> > > -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
> > > -	     "strbuf_addstr appends string to initial value");
> > > +
> > > +	if (TEST_RUN("strbuf_addch adds char")) {
> > > +		struct strbuf sb = STRBUF_INIT;
> > > +		t_addch(&sb, 'a');
> > > +		t_release(&sb);
> > > +	}
> > > +
> > > +	if (TEST_RUN("strbuf_addch adds NUL char")) {
> > > +		struct strbuf sb = STRBUF_INIT;
> > > +		t_addch(&sb, '\0');
> > > +		t_release(&sb);
> > > +	}
> > > +
> > > +	if (TEST_RUN("strbuf_addch appends to initial value")) {
> > > +		struct strbuf sb = STRBUF_INIT;
> > > +		t_addstr(&sb, "initial value");
> > > +		t_addch(&sb, 'a');
> > > +		t_release(&sb);
> > > +	}
> > > +
> > > +	if (TEST_RUN("strbuf_addstr adds string")) {
> > > +		struct strbuf sb = STRBUF_INIT;
> > > +		t_addstr(&sb, "hello there");
> > > +		t_release(&sb);
> > > +	}
> > > +
> > > +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
> > > +		struct strbuf sb = STRBUF_INIT;
> > > +		t_addstr(&sb, "initial value");
> > > +		t_addstr(&sb, "hello there");
> > > +		t_release(&sb);
> > > +	}
> > > 
> > >  	return test_done();
> > >  }
> > > --
> > > 2.45.2
> >
> > I think this commit in particular shows how TEST_RUN() is more
> > convenient than TEST(). (Although, arguably we shouldn't have allowed
> > the setup() + callback situation to start with.)
> 
> Could you expand a bit on why the setup() + callback thing shouldn't be
> allowed? I think it is a nice way of avoiding boilerplate and having
> independent state.

It's a matter of taste rather than strict principles, I suppose, but I
think that test cases should focus on being readable rather than
avoiding duplication. Production code can follow a Don't Repeat Yourself
philosophy, but when a test breaks, it's better to be able to look at
only the failing test and quickly see what's wrong, rather than having
to work out which functions call which callbacks and what gets verified
where. Also, since we don't have tests for our tests, it's important
that the tests are easy for people to manually verify them.

I also agree with René's point about the test cases matching real-world
API usage.

I do agree that having separate functions improves isolation, but
hopefully we can encourage test authors to define local variables in
their TEST_RUN blocks.

> And, I see the true potential of TEST_RUN() in
> testcases defined through macros rather than replacing functions. I
> actually think that the previous version with the functions was not
> particularly bad, and I agree with Phillip that the previous version's
> main() provided nice overview of the tests and it was easier to
> verify the independence between each testcase.
> 
> Perhaps, the code snippets inside the functions are small enough to
> perceive TEST_RUN() as more convenient than TEST() in this test, but,
> for future reference, I definitely don't think TEST_RUN() should be
> looked at as a replacement for TEST(), and more like 'when we have to
> use macro magic which requires us to use internal test__run_*
> functions, using TEST_RUN() is more convenient'. Patch [3/6] is a good
> example of that. But, I also don't mind if patches 4, 5, or 6 get
> merged as I don't see any difference between using TEST_RUN() or
> TEST() in those patches, besides moving everything inside main().
> 
> Thanks.
