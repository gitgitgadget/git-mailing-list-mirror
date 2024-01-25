Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F9130E33
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202695; cv=none; b=phSjSBpj5khDg6beaUC7m+8HDzYaG2Cgml1HdiQpy36oJp6iwFPR5SYbjWiXexM1CiJ8/2ENJEwnQJUGW7pu2OGZQjeU7a86Xo0VTWLzHJKVHeIKQzR7g6oXgRSyE6cT6cRHXCWRSzwXvTTXCvGeZoGUgsCZ176mZG3w+hlRbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202695; c=relaxed/simple;
	bh=mg8/WIhGJPW1WG+fRgT1N/QycS9O9b3EPpH1jrZ3jTI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Kes2MTVnx6oWkxeun1UjwSFZcEHAkcivBQk3bxyjgtdZ5McyhUJZwhD9k+ABOc8YQ41E6DfLeXsewt+KFi20WIUu7YLurs+EJLBwCRBoB+nt42FStyg8Zl7f7DoEfY/RVX0Oq1FEMXj5JlvaK1BKdRk/Zv17uUn3utKM846CBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoVeacmJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoVeacmJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso10369166e87.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202691; x=1706807491; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aEGqyhargVIv2l2UXzGW161Wun1Q2xW8zjeayB/eec=;
        b=eoVeacmJ+ZUswh7Upz47101cRJC/RzPIAJh8/9SaO9x2S1B8e1ussWYCzE3T/Udaje
         GO6hutFJkiI3Shw7HWgAbZ0h/9bWORGMbWPi/GBBRrWLLD/P4oM8pRFNFIPzL/2Ohm1C
         a6cmCJMpgfuVcBs7nM+rqqL8zoWQb3Zq7BhS5M6nhSVY23Iat8ZAFKAj1GusGFgDZgMP
         b2dmNmRFxN7yb+uLVPCqKYqSOLQFJX5Yr0OU31i7NkcSANiwwbJkkHpM7bRReTqcEnDT
         Hq+HXMRrVdA8vmA6OvjyvdB/1E5AdusPHDSO5TWrgH95kD5tLdl0kzRqUvPtFOxGJ0eB
         5YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202691; x=1706807491;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aEGqyhargVIv2l2UXzGW161Wun1Q2xW8zjeayB/eec=;
        b=cfAC+BADPC0yUKup0IeIPkkn4/QDalAM9hYNkA2MCh9G2VPn3UteIAcnwr8vpwRSf1
         ponnQPNOcuuGR79khzx9AcrZRTMYn1YWY7BhVsg/JyUxhr51UQ/6smCcShNVT4IDrsXP
         ANr/+Tcp1MQznMr+Te7A9a+H3m0t4r4Ug3hc35Bws/MI8AAFnszLB8a+FNE7DUIJJqe9
         wem5y/Lzdg79WKSiLapOzZIMI3fZqwAEynoeARribjugyEo1aeHnYuiLEyUl44VglrKf
         5ZWkad7pLlaU1TGiwBSEfv+N/lO7hx/Vnxgpz9yD7Bc1l9/nfNG075WvdHHduJ/nqOzs
         F19A==
X-Gm-Message-State: AOJu0Yywhh+uWeqEgvLebW4kHSMXcNNgFevI0ZlYyiUwSJyAtw4sYnBP
	kHCcsxegXVUa/b//UeHsGqOaZZIwfa3b0sdNfdLjOuo+wjKazSHnVAlTmujt
X-Google-Smtp-Source: AGHT+IHVjN3Z9Mq2ecF4jC7QS6H5f4mG3YX1AAw1gLZ8HpE4ZXXyYhy8NImIA1eOmur34RFGRGCZqg==
X-Received: by 2002:a2e:980f:0:b0:2cd:7fe1:3a1 with SMTP id a15-20020a2e980f000000b002cd7fe103a1mr1109787ljj.66.1706202690775;
        Thu, 25 Jan 2024 09:11:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d10-20020a2e360a000000b002cdfa928e56sm332679lja.34.2024.01.25.09.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:11:30 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
Date: Thu, 25 Jan 2024 20:11:29 +0300
In-Reply-To: <xmqqa5ouhckj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jan 2024 09:21:32 -0800")
Message-ID: <87il3h72ym.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Whereas obsoleting second -f in favor of new --nested-repo might be a
>> good idea indeed, I believe it's still a mistake for "dry run" to
>> somehow interfere with -f, sorry.
>
> No need to be sorry ;-)
>
> I actually think the true culprit of making this an odd-man-out is
> that the use of "-f" in "git clean", especially with its use of the
> configuration variable clean.requireForce that defaults to true, is
> utterly non-standard.
>
> The usual pattern of defining what "-f" does is that the "git foo"
> command without any options does its common thing but refuses to
> perform undesirable operations (e.g. "git add ."  adds everything
> but refrains from adding ignored paths). And "git foo -f" is a way
> to also perform what it commonly skips.
>
> In contrast, with clean.requireForce that defaults to true, "git
> clean" does not do anything useful by default.  Without such a
> safety, "git clean" would be a way to clean expendable paths, and
> "git clean -f" might be to also clean precious paths.  But it does
> not work that way.  It always requires "-f" to do anything.  Worse
> yet, it is not even "by default it acts as if -n is given and -f is
> a way to countermand that implicit -n".  It is "you must give me
> either -f (i.e. please do work) or -n (i.e. please show what you
> would do) before I do anything".
>
>   $ git clean
>   fatal: clean.requireForce defaults to true and neither -i, -n, nor -f given; refusing to clean
>
> Given that, it is hard to argue that it would be a natural end-user
> expectation that the command does something useful (i.e. show what
> would be done) when it is given "-f" and "-n" at the same time.
> What makes this a rather nonsense UI is the fact that "-f" does not
> work the way we would expect for this command.

I think we all agree that current UI is a kind of nonsense, but have
different views of the optimal target interface. My points are as
following:

1. The fact that bare "git clean" only produces error by default is
probably a good thing, as removal of untracked files is unrecoverable
operation in Git domain, so requiring -f by default is probably a good
thing as well, provided the *only* operation that "git clean" performs
is dangerous enough.

2. The "-n" behavior is pure nonsense.

So, how do we fix (2)? Let's try mental experiment. Suppose there is no
"-n" option for "git clean" and we are going to implement it. We start
from:

  $ git clean
  fatal: clean.requireForce defaults to true and neither -i nor -f given; refusing to clean
  $ git clean -f
  removing "a"
  removing "b"
  $

Please notice that there is no "-n" in the error message as there is no
such option yet in our experiment.

Now we are going to introduce "dry run" option "-n". Most simple and
obvious way to do it is to set internal flag "dry_run" and then at every
invocation of "remove(file_name)" put an if(dry_run) that will just
print(file_name) instead or removing it. Let's suppose we did just that.
We get this behavior:

  $ git clean -n
  fatal: clean.requireForce defaults to true and neither -i nor -f given; refusing to clean
  $ git clean -f -n
  would remove "a"
  would remove "b"
  $ git clean -f -f -n
  would remove "a"
  would remove "b"
  would remove "sub/a"
  $

I see this as logical, clean, and straightforward behavior, meeting user
expectations for "dry run" option, so I suggest to do just that.

Thanks,
-- Sergey Organov.
