Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035C1C5D46
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776908; cv=none; b=NUa7bg+Y4dpZIXsfR7v/Yfuyvudj3M/lXXGR2L2nCd22TNKSZZmCmhwDVFHmBjZPkNVzQNaau1kBzu3GsT/ust99o6YI5jxLGyK+l9YiJUs/Xz4U+EjxTG0sPu/PqQmGUI3O/gbQbR6shltz1kea8V9y+235tfwWXAK9FwGYdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776908; c=relaxed/simple;
	bh=34VXHu3rv5MI26S+PNzBZyl+Nuj2dahh3+BHBTdorD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMj2BGXMyW0s08ccgBUZPGqSr+USEtKGp0Ye8yNn9MVfei4mKnVeh/ONjlvRdDUc7oQIqUd8y2GYk472Ck9tu5VCmN7/pfdc2cuNYmpw0cICxS3VoDg+AFYzirW3WbpiYv7RozZsPxjyX6bgiN1rCOeKwpzpgz53EWD/g8sDJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/QrqaZT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/QrqaZT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so74363666b.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776905; x=1762381705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CO0HA984aGsV+Z5LH3iOXL/n+dW2lWsFqXP+VUkk9mE=;
        b=h/QrqaZTgtVDJ+Be83xIQh5FYuKUT8agVROoTxNrVSP9S9gEiwaDAwKDDAIU90Q54P
         tjC68Q2o8ktWKQnrNHJ7BhzZ9oZ1+1GSY/rWRnB3xN+vq4DIvk/MX63UhXFjrbzsie5F
         VpJU8LWH76Z0aGTkZC1AEycIkYbMs8RfC28a3VYnom9KvNCYoYr38xthXc4bpEeA6EFg
         ir3JflBSDrrb5JroVGbjaW+6VmGXm/8I/YkU3dCCMTlCcxGXkhxhkC39g0rNIbSZ0I8F
         MS7K+a0oZWuuLzkWr/Do2QA6TKD8rbPMN+G17v6dvI8ANHwuXrcMtQ9xfHA1P6EQzGr/
         oo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776905; x=1762381705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO0HA984aGsV+Z5LH3iOXL/n+dW2lWsFqXP+VUkk9mE=;
        b=Rkpg1vmypdnoe05MMFhOaG81WYntcIOQOdWFNUjG55wTjBrvk9rH+VGQFX1O8RLcb7
         v+i1dLR0i5rfQ8GD8h/agrsFsJIk0itk28gzYmqf0T1bMI9xfFgqTwBLxEdpkCE0PoIg
         Lu1aTQNiqx1WJdYV0g7mvnabVM1JpbjG80P7KzIdGug/WLG9S8a4Dkkm2jqTKXnktSXm
         O8dKYAwy4/RTHKDJTuBvCaqo8jUKM1ZZjVEI+lHIVHdmhitKLfP5GtHaywJ94yKF8H4K
         J9IJxVBZyNwuOLXKj1ZxH/MDxcIOYKeJgykuTKfefewlZXVc51lO7HcomTpvmmS/UGHA
         eUng==
X-Gm-Message-State: AOJu0YyaS+mNx+1TngLi2YSB+OPwb0sDUJo9w+hYDwCL6ds/29WnVYym
	V3hsWkHVsYrDJeOdhwJOty15Kzfa2QVsA3aUpyX2HkWsOq0NrVcglbPn7usXtg==
X-Gm-Gg: ASbGncsTTnTkK02bWof7mVyIWJTKT3w2+9h2wwBdFYa+8qkmXpM4PZ13rbvVonnaCB4
	aP0X09X58trTH28VzTD5uyQYQdBEOgGNue6xL583orMqgXi8ea7lAhGQPrhhraDn+dZzsLtjsqH
	73BvQtESSREcEAcSzc9Al1H3ghfeJxemKdGqzwowkQ7EvK4gI43uNvWFnGsm/gueJtdRfJ/1ROR
	5FVPZD1BCsHvglu9YPnQh4J1FSOOW/ysXZQcZ93S9WyJfAIJKlhe3hAquGWlMkawdzUbZfeBHq+
	YBWzo54LnihDdHBK9Cm2Gaq0qmPT/M9xaLjYD5OiDEp/z1CkmVIcZRzXzzl7h4uc0YimhjAQApv
	Ra/hHC9OxTJDUm8HmsvoPW+RctCqGLVKi2jqYftVoZ68CXCX/49UGsUHo1PClUMAPC/slUa4TsL
	dcElIpsc9tkvI3IMzgniGnMuu8WdkkiA==
X-Google-Smtp-Source: AGHT+IFNnXeGOh8Mb0lA48fCtNkL5MR/GReDaKkreedQtLCERKUZyTmy0x24jbxJEVVP9htMW/AcbQ==
X-Received: by 2002:a17:907:96ab:b0:b57:1d99:ac93 with SMTP id a640c23a62f3a-b703d5bff18mr408173966b.51.1761776904636;
        Wed, 29 Oct 2025 15:28:24 -0700 (PDT)
Received: from localhost (62-165-236-60.pool.digikabel.hu. [62.165.236.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm1551604266b.64.2025.10.29.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:28:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:28:23 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Message-ID: <aQKVByfUdYHSEcDz@szeder.dev>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>

On Tue, Oct 28, 2025 at 01:40:42PM -0400, rsbecker@nexbridge.com wrote:
> I have found new defects on 2.51.2 that were not present in 2.51.1 when building with OpenSSL 3.5 (probably unrelated).
> 
> Many failures in t7900 resulting from the use of test_subcommand ! as seen below. This is run in bash 5.0.18:
> 
> + test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
> + 0< run-no-auto.txt
> {"event":"child_start","sid":"20251028T172435.690328Z-H36b1c598-P7b00002d","thread":"main","time":"2025-10-28T17:24:35.879833Z","file":"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/run-command.c","line":740,"child_id":2,"child_class":"?","use_shell":false,"argv":["git","gc","--quiet","--no-detach","--skip-foreground-tasks"]}
> + test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks
> + 0< run-auto.txt
> test_subcommand[5]: test: argument expected

This is a strange trace output, as it includes file descriptor
redirections, but lacks the trace of commands executed in
test_subcommands.  This trace doesn't look like it's coming from Bash.

