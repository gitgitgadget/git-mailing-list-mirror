Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5A1E9B0D
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390426; cv=none; b=uYXqa8jEYkUD+cLXBT0CNRPiDRXjoVw+Sw77aqW86SuE5TObpsMiJj4U2YDYy+sQW3omWK5cln8gN3samr2nkEMm48n/Gqo+RD0yK2aiI9qkPVkoqZqd7FvoSIKci/Fsy0/deS9Z3emPbgZ4BKHBoM+c6HoCG51z4keQC36qakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390426; c=relaxed/simple;
	bh=kcISKKIL+tGkj70KPWt6A8U0SCVg/7Hiaf3vGvWLdHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpacPGaDhVqSK+hKMU2eUNoAR7R05xcwH6yBI6n2MjpoAW/2uFGvZknaCMiqq2fApjQPdCnpUHaGn6NsSDUccXJxN2os0nRuVHZptelZu10jloTPJF8jrwGHWdrUOgdpNgeXQszdWCDq+kxYybBJlSAilnyavwbUWF/uwzWoYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLj5nFMS; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLj5nFMS"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb790888c6so1210749b6e.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737390423; x=1737995223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MX/DkJq7rLcG6H/4us4g+uFHuUVMry4mGPs+mrS8jY=;
        b=XLj5nFMSzNvdNs8Z5TPt55pw2O0e1R5rOVZP4KnSu1UiuwIgeEmbMwK6Q0DowWIxVK
         KB6aSG0mSXTa9uaN3dW6Sahkw+X9j3i6EphxoxsRmEpKwQUoxasmSR4mJesxH6c310I4
         Nu7QslHKOJF2LcDUhL7Bd/C9DvwAMPTJgSpQcLqX8vfAqlGV5FIQQqlLUbl9eza1FLb3
         KSjS10gBLuCt6y0NzzcJx0E/4AT1LUiz0B4t+T+Bq0NbCUWKthuH+TB9fmZ8qBZaqX5V
         Q+g5nlUI0rKP21gjVT5PAWOE9Ywrx97tbZC0qnESgg82hH6bQT823GniB1MFp6DZXfzB
         TtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737390423; x=1737995223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MX/DkJq7rLcG6H/4us4g+uFHuUVMry4mGPs+mrS8jY=;
        b=a594J0A3/B+AWfefL5LTpZvIO/iwEae/PX/Sr0Wn5QyKK0Cp2jqSfFoDj0JDXCcCh9
         lXkj0BnIFQjy496S9r66/FlnoHEtkVtAdsKH3ul3w7+7jXLYHVtDMFEzLTHVRE/0fq7M
         nbJTfQSjLO3VVivwvvsZvc9E7a6j7y/bVZ8+yyREhvqhvd+6R+xjJiFfEoS6hBm1hlKy
         c+GnB6dmJKtM8UaAV9GN1T0o5+0rktMHjynJtLmWzhPQKLj9GTdhv1utc8wkd0yo3rO1
         lq8yMlgsUgMCCEtUSXKllOo62D0YxopaeCzMt7h42eFMAvUDejWhcDWwCzn8bviVeZFA
         ZVSw==
X-Gm-Message-State: AOJu0Yy7anxkM1V3jTvAx9lEjCOsxUGGmWfp8t9pY/bC0Flzf3AfEqjn
	SBEdvasUXRAgbcu86ikgyNKcCFzyjm8ggDnuX3tVAOppMIf/N/VanazGXiSP
X-Gm-Gg: ASbGnctfcG3AmP1mO5JkL6lHAZHzmB0U4qWkoKQyr0BC4xM2MgfIrLRUI0MbyJolEZh
	Dp4BuwWvCVnhAcI7m/gPLe9IvsuLjcPUWPLITg3HOZJe145FaN8ftOfRG8f/YeEeDbIE6s9KQMG
	QhiOzXePFsL2m5F3ONmn0ekBXfCmumuvhU59MRXXMCJjwGc4v0riZyPxWOfOriWbfmIoqQJgTii
	SddaeLs13xrlVXnuGlR2opqn3ZQrKbTfwaKec57ApXMkwCw
X-Google-Smtp-Source: AGHT+IENMj2gmzmf+dIVJSCc84FWUTBwiBxDA0WpPQSrCoWt8omZaB6vQb/FNhgeXhlNHuuOJNhJTg==
X-Received: by 2002:a05:6808:3c86:b0:3eb:512e:24e5 with SMTP id 5614622812f47-3f19fb43ccemr8124092b6e.0.1737390423463;
        Mon, 20 Jan 2025 08:27:03 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f19da85a80sm2456348b6e.28.2025.01.20.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:27:02 -0800 (PST)
Date: Tue, 21 Jan 2025 00:28:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: Bob Ruiken <bob@synergi.so>
Cc: git@vger.kernel.org
Subject: Re: [bug] Using --ignore-space-at-eol with --name-only does not
 apply the filtering
Message-ID: <Z455pim1i2u_1odm@ArchLinux>
References: <CAK_bMgeW6ACsWKDbLk0fvm7DuOo5BYhN2OpA-EyOTCSWrkEXSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK_bMgeW6ACsWKDbLk0fvm7DuOo5BYhN2OpA-EyOTCSWrkEXSw@mail.gmail.com>

On Mon, Jan 20, 2025 at 03:15:54PM +0200, Bob Ruiken wrote:
> Hi,
> 
> While doing some diffing work today I found a small issue combining a
> filtering and formatting flag. Let me know if anything is missing in
> this email, this is my first time reporting a bug here.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> I'm using "git diff --name-only" to analyse the difference between the
> current branch and a target branch.
> Then I wanted to expand the preciseness, I don't actually care about
> spacing differences at the end of lines, for which I use the
> "--ignore-space-at-eol" flag.
> The problem comes in when combining the two flags: when I do "git diff
> --name-only --ignore-space-at-eol" the names of the files where only
> space changes at EOL are happening still appear.
> 

Thanks for your report, this problem could be reproduced in the master
branch with the following shell commands:

```sh
git init repo && cd repo
printf "foo\n" > foo
git add foo && git commit -mx && git branch test
printf "foo    \n" > foo
git add foo && git commit -mx
git diff master test --name-only --ignore-space-at-eol
```

> What did you expect to happen? (Expected behavior)
> I expect the two flags "--name-only" and "--ignore-space-at-eol" to
> work together such that files not matching the latter filter are not
> shown in the output.
> 
> What happened instead? (Actual behavior)
> The files that the "--ignore-space-at-eol" flag is supposed to filter
> are still shown when "--name-only" is used.
> 

This logic is in the "diff.c::diff_flush" function, when specifying the
"--name-only" option, it will set the "DIFF_FORMAT_NAME" bit which will
let the code goes to the following control flow and then exit the
function.

```c
	if (output_format & (DIFF_FORMAT_RAW |
			     DIFF_FORMAT_NAME |
			     DIFF_FORMAT_NAME_STATUS |
			     DIFF_FORMAT_CHECKDIFF)) {
		for (i = 0; i < q->nr; i++) {
			struct diff_filepair *p = q->queue[i];
			if (check_pair_status(p))
				flush_one_pair(p, options);
		}
		separator++;
	}
```

So as long as you specify "--name-only", from my understanding (maybe
not correct here), there is no real diff here. We have just stored the
information about which file is added, modified or deleted by comparing
two trees.

Although you have specified "--ignore-space-at-eol", the code path does
not care about this option at all. Because it simply uses the
information described above to print the difference between the two
trees without checking their real contents.

I am not familiar with the code in the diff part, it would cause too
much effort for me to solve this problem. From my perspective, we need to
explain more about "--name-only" option or we need to make sure that we
cannot use both "--name-only" and "--ignore-space-at-eol" options.

Thanks,
Jialuo
