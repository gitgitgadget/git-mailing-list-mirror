Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8CE3F9FC
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728260; cv=none; b=M/8A3z+RFC4RxOHlPuwkzl379qwXN40MB2dWUz/GJdmygz/5vpL6uJi7BCm4aarIUbB0oMTaPxKJ6SYwmVFVwXduY4WcsSO+EWF9gf3rsJa0CIuGoQFj7Qu2gH/m3aQeycnrUlduVWs/Dwzb8LHqZM+TeizUZx5HBOnT6v8i/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728260; c=relaxed/simple;
	bh=hSkAc3grpDDiUBl3C4TCIIDwYwvYF5bWkTVmuANvNtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuaqAX5ZK6vJIH8Db5aSjTlJzcVm9r+5cQmiQINMbyOEGLg/kjKdYi1fK8G2cipzjYL6xbqXppgUGREZ/eRMd+3wCJAY8Rsz5eMl6taBxzI+H1xlp/yvvZ2hI+1nR3hr/oGxcsGGcfAcviDQtkQV/KKrXvjKQaF6Q3ggE+1LmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih4Rbu90; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih4Rbu90"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-417e327773cso25599935e9.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713728257; x=1714333057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8KX6LyW5QcSD8oiAqH0oYhLBh0scSpimOBX6sERERc=;
        b=Ih4Rbu90ZziWb2c37eDSrMm0SslKEDBTEmKvRol1xbUNb3DArXBF9ZzxKQ9Nuhf8Gl
         2Qw7l8/ZDYqcfTpEBM9RCN4Xy6rmeg4Edc7lER7/56ZbP8wXrvjJf2g6+dXA0Cv3266G
         cZdApA94p5IVz68Z6Q6AifOZxXtMtvePRG5i5VQ7DxZmlj594nKk6F6NiGvfaJC6ebPQ
         F9HxfQzlvHfU5vqh7r2GhCik61zwGUhibCvEOFDoX52UZFdPwpmRtTssWKeTXJRG6c8X
         RHs1TsG9h/jp+JZaxsIF2sN9fcadyAIe5j3tzKIBpTZlhH5IH8IbSdhU+Yh1mtyjpbwP
         rN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728257; x=1714333057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8KX6LyW5QcSD8oiAqH0oYhLBh0scSpimOBX6sERERc=;
        b=IBpuUELxGct1lvjQJ6s7qYL9bUwYNFKBhzQU3jaqXsUqLqMVF2Pv2ZBnZmRJ3gWmJD
         Cb5kwYnA00zvJNg2c3MJS4am9jFI4Zwkah5/l5xGHRRpUr92AtrRRLcaEdFKqW2oUgrh
         MRy/U/kleFzGopRSRv6slQ90BVtZg+g47/KcxOi9NgnTb45lQlrWndt9FVBl8Wj1Emrt
         99/J629lCyVlrTahU5PesrBLypVFfeVe5DqobjB6OTpr3kZbB9zFYHhucJ72fXIzE535
         Kn+9+W21ai1Fn78MfExLWGhcFqMkDKHxbD/Xq1ux7aseIVLoj3l6W+mp4eCGBw9hVjGR
         wtBg==
X-Forwarded-Encrypted: i=1; AJvYcCWtzZy7idvH0micLJ6SQEr189iEETsAXec1d3IZqr9zJomSOYyKW07V6Kyl4YQXtpwW5vebSDMPJ2mC422Cmpxy1cE7
X-Gm-Message-State: AOJu0YzliiUxOgx3Eek8ZfscJ6jU0vGKp0rLX1c4DBepyMImetHSQ4xw
	E2b1uENEv4mENvqS4/mBkzMn/vXU3ijAO5ufGzZQvUXZMtLLsmhg7ZSydQ==
X-Google-Smtp-Source: AGHT+IHfO9lK0ewmoBn3lQ+949J9xFfhrfPiepiQjn5wwkw03xLfIxyKKvdQsc5jftfa4OuqoHwhOA==
X-Received: by 2002:a05:600c:444e:b0:417:f537:42a8 with SMTP id v14-20020a05600c444e00b00417f53742a8mr7417635wmn.20.1713728256372;
        Sun, 21 Apr 2024 12:37:36 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm12026769wmq.18.2024.04.21.12.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 12:37:36 -0700 (PDT)
Message-ID: <c8f0f709-4a0d-469f-876a-63940705746c@gmail.com>
Date: Sun, 21 Apr 2024 21:37:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add-patch: response to unknown command
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b1c725f3-0e92-4723-a7ca-8d001d60b89e@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <b1c725f3-0e92-4723-a7ca-8d001d60b89e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Apr 21, 2024 at 02:18:32PM +0100, phillip.wood123@gmail.com wrote:

> > +	git add -N command &&
> > +	cat >expect <<-EOF &&
> > +	diff --git a/command b/command
> > +	new file mode 100644
> > +	index 0000000..a42d8ff
> > +	--- /dev/null
> > +	+++ b/command
> > +	@@ -0,0 +1 @@
> > +	+W
> > +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> > +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> > +	EOF
> > +	git add -p -- command <command >actual 2>&1 &&
> > +	test_cmp expect actual
> 
> It is really good to see us testing the whole of the program output now but
> have you tested this with GIT_TEST_DEFAULT_HASH=sha256? All the other tests
> use diff_cmp() to avoid test failures caused by the index line depending on
> the hash function. Alternatively you could run "git diff" to create that
> part of the expected output.

Oops.  Thank you for pointing this out.  I'll reroll with a fix for it
later today.

> It is a shame we're not testing '?' as we have changed the implementation -
> before this commit '?' was just another unknown command as far as the
> implementation was concerned, now we treat it differently.

I think testing for '?' deserves its own series.

> It would be nice
> to see some test coverage for the 'p' command you recently added as well at
> some point.

Yes.  I'll send some tests for it soon.

Thanks.
