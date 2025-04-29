Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49B1FBEA9
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918190; cv=none; b=gUiZnvxMCg3MpXGOFZVH+NxTCsROfc5odwa/+5zbsv1WHBPRATFaSdYf6qwLQKEp6G2h1FGNmhxYBpZzq/BphTJ4C/u/NmrmvIvNAD5+YuK6eNoQMl28xR4r1TNxVqI68BTc/X1E7malHhj9JPti+egUiMSeJ1EvdyUV3kE8AVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918190; c=relaxed/simple;
	bh=3o/8Czf1+cCERa18WKFOelXaLhisL4G/zPEtl/CMTV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SWBK8+wwIhRKYwJrgfatCn+vuziK99aeuF+SbjfZY81dkLITd3KWSZj0r8ciBzgrR2BIWCPu5LeYgf7Z/fGVAPfwv3NSFXNV4TO8TNiSvv0Kkq04HnGpbQBmcUBX5VpTeAH0PbvSkAKTtTYtFPJnOXgL3/9bPYdbKi+e+4g7XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRLMDeyw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRLMDeyw"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so5373018e87.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918187; x=1746522987; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3o/8Czf1+cCERa18WKFOelXaLhisL4G/zPEtl/CMTV0=;
        b=NRLMDeywRr9DuLfqvL95ic5cvrI/10zgeXuttdtPnDR/XT5UIwKGGEZAVst6QVSoxg
         6H8OQI2AL3jIG30lEjgDL5nnz9zfOGMYX3Zhz5VjAF3AEgTDOSgS5HoQTu4PeBCMcZLC
         encUXVechIAucocQME0EQR5301wAwc4E1j/xzqo+T/i8qYkWBTBr+umAuHLNZw39mL2F
         onthIuM9Ex/6+T3wv/NpUByl8kXcuijZsZokmghVBALIkbcOLitEzjJrBfxkSltaTsXf
         q6AkoMpiNhkfDp22NBK7BODVDMekqQOwYOj3EFjlXfSlIYV8U72n7kThR0GCxUl4QbNg
         gfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918187; x=1746522987;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o/8Czf1+cCERa18WKFOelXaLhisL4G/zPEtl/CMTV0=;
        b=i82px95ft4NTRrnyNbKccG5siAwMRKTzqGorcitK8ECgSS2Q1YrcsUPd0H08xZRS0a
         k9Cj/cn0TPnWYMAWfH2BvpYbf3Abcw19qaOBf01BBdebl9MHpzIyVFrxpxAIT6jxtTQs
         j8K/dugXy+bXjmjCDBvLRvHEx8vktXLNwI2ND50oAXlGslbPDUWYjP1cXCiidc8euDeQ
         2jqk3h5Q5JVFzxm7U3fNne6AR0yHU1ptiYdgLuof4bMWXC7u0/8jM2mJXd88iHIw1gSb
         cl0SFTsexhxmbnWveQZvopOgEqmJ6J6Vi8jXH1+twIDexd18HO2iD35NZCjoqUmWsEiB
         bV4Q==
X-Gm-Message-State: AOJu0YzAApRCNPvt+tWat9FxbuTreCjQsTZbGmpCTwacQcH064tP1D/T
	aY7ZUlkp9/OU0ScAT0NSwnKGj1vOiaGgL7X8YirXI1K2tvtlfyFQAFPLmKAE7FGAREiABtY3/W8
	yUriIjvQuZZo//FiaPouC9gE1QK5SpngrHTQ=
X-Gm-Gg: ASbGncsPPvzzNjVQ2J3CGYa+YO19QmEbewKtHj42FjuFNTQzea0wttWMo5I7MVnC8Ap
	1d6zUyHHpeJ5BbfemrlTavmxiF2dT9qbi/knwUWZSHppyvkQMQH1r8FwVwTkflkFa8Xm28jZ6GY
	ZCoHpnUCFw3RwY8/Yq1z3VAYrBV70F+rnlVyIF5ibXoZyPUqVxohmK
X-Google-Smtp-Source: AGHT+IEFTASsxezP/LBeZRxqJs9HTC+12TSbkNIDAeUMKwYywZHIjs7gBX+iY9s/1qerzN4TRw4eO5EfC8ba6hp2/hM=
X-Received: by 2002:a05:6512:3f1f:b0:54b:117b:952d with SMTP id
 2adb3069b0e04-54e9e57323bmr516925e87.54.1745918186619; Tue, 29 Apr 2025
 02:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 29 Apr 2025 10:16:15 +0100
X-Gm-Features: ATxdqUFpY5AFPlsdrrtNVaVPFG521wFVEhGGh_CoVYDdyMPw1ntja5QwV5m12gY
Message-ID: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
Subject: Discussion for interactive --patch commands to get --unified support
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone!

I am a big fan of `git diff` with a custom `diff.context` setting to
increase the context lines (which also extends to other commands like
`git show` which I really like). As well as this, I am also a frequent
user of `git add --patch` (and also the other interactive `--patch`
variants such as reset).

As I've grown to use and appreciate these features even more, I have
noticed and been bothered that `git add --patch` doesn't have a (easy)
way of configuring how many context lines you see. There is a
stackoverflow post
(https://stackoverflow.com/questions/6711670/git-show-more-context-when-using-git-add-i-or-git-add-e)
which mentions you can do `GIT_DIFF_OPTS=-u<number> git add -p` which
does work however isn't very user friendly or convenient.

It would be great if it was possible to start a discussion how this
could be made better (and I would be happy to submit a patch if all is
good). Whilst brainstorming briefly, here are a few options I have
thought of that could solve this pain point, some not mutually
exclusive:
- `-U<number>/--unified=<number>` command line options to the
interactive patch commands (all builtins who call `run_add_p`)
- make `diff.context` setting extend to the interactive patch commands
(not sure how a change like this would be welcomed considering it
could change users command outputs seemingly out of nowhere)
- add an `interactive.context` setting that would work like the
existing `diff.context` setting but apply only to the interactive
patch commands

Is this feature something people would welcome, and what are your thoughts?

Thanks!
