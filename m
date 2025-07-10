Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E422B8A4
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121549; cv=none; b=JL2bis1T8fN7wHe7f+mYfd2JosdFL7GC++PZ8snJcJa+4tbuSQsdndqlNCPUiHJUkON32v7orEmSrrlL2Y7u0TGA+8ArdPi/uxnRKwkH4yJ0D3vjlpNTCCpbTtTkkpXtGLkFP2Qj5yH1AAU2Lz6h6UfSU1/scqAgfGYJDoOsTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121549; c=relaxed/simple;
	bh=bx0UTq/uVOEMDz134ipHuP7D2fXO7Yxb6HKTYWAlDsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAJ+2fUmj1ox1BbE66UYS1mXWbsIwzYnYXcSgpGRofWvbAqR/LLYxpt1IDQ4LTKTJef+8fp/bIUArpgt4qCv0rh8mUbVVbLnQkAC3y/kwwO5MIq/Bhncz02t0ClZ1PFuhRqZKpDfJ2ChAbocyjhtFMmWdWzygyK1ECgadEtdoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvJ69nMW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvJ69nMW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31c84b8052so807056a12.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 21:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752121547; x=1752726347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pw88LUIl55Q6ahQkUjkCUm6EzmuOMRv3r8/KYP7CoJQ=;
        b=fvJ69nMWsEb5fMdGCwXRKJlWn/IM+t4p7Gm5lmlfWQYmt5W0nuYG/GW8Oy7wpt1iwD
         fVsu42vibBHIgljpnZIkH8xiomw0cfpLXHXL2xepvfAcaBqAUnbSb+3db8wvjsf9bWWz
         aHY52f5lFA7zJ0FUTx7/6lOPOn7D+Sb34eRc6xuxaV1L4+hHCPIEW33JST1FEdfr5cSh
         LszWl5rdn4fLgNChXT+efSsHaa3Op6gJMH0lsrvBJ7grdlqQeLrWgjRy/gEsFF6afqme
         lDAmgDQXmsXIkDUnro7eCZtvUq/omkDRBlFUZsk9kkEfniW7hw2HUgnhbbUvisOjdDpO
         yWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752121547; x=1752726347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw88LUIl55Q6ahQkUjkCUm6EzmuOMRv3r8/KYP7CoJQ=;
        b=nWWkec3uxv+NMRfUCX5y/+/JuE8nd9XcoYEamc+p8VQP1HkoJxzDem+nqvNmMeM64n
         7soVxHFCiryRQG9XKlc/vaBTpaJEdgLMRyU4jBU7mgkluDaQCuzlj36IgEylijITlexe
         d4/o1VBb4NB2CLhJ9vjoLsmR5L5+92mVw/33lkvDKJF8knx9OCYRk4Sjz6/1sGyCxQAb
         a/rk+m4jVmoROfYVFnRfOHv2jU4VtnFQ1qM6QpG7LT4Koo21ijpJKYPWQIjL1RdzlfnK
         32DbOzSgYR4VjfYPRekUDhFzHYoMCFcgrnhaPw7WDCJacY9exUIZHjUQRnVEEfQmjT5W
         2c+g==
X-Gm-Message-State: AOJu0Yw5XRqAPvxgmFT8DuFQgY15EZ1EQF9EfVlg1lnuC7KoMOvpIeva
	nk8iYNbfMS8aLcAiVWx/+IKK0NCLpjNrpQzV5ArPElWbtG46DNKpnJzX
X-Gm-Gg: ASbGncsyEQtlP4fGtMpvOhEthEnD4pdPQSUOXZYWwNfa4rwdx1+/0i97pLp0YjhVHNj
	F9zHhJ3PjNksvzqvRk1qXYOUovE+Y0j1X8EYtXqclEsstSymcXwPT3XQ1DrKMtHuOiOFSxXOkyq
	cXB8LOt/iLGCsa9e63dPl+dc3ijL020KLnKxckVqzSkwkcqGLTWMj/GyONZL91F8xtkqVgXQDAI
	H1xTI8I8JQDfodJPGvr/mGK7o+efKlg85UXcBkqzr+942tKKWN/dzNsvmV0RnO1yyigMiJJ6lDe
	3PTaS+6Kj4KqhnHKcoHPDFjnETIwLKgYgR2qUX/IBkhxwoXZh2pJT4YvlAzp3NFG5ToQVyXHGvX
	LbcMpu4gwYX5vTTrbXGSCKGM=
X-Google-Smtp-Source: AGHT+IHSkN/OLj7Gc6YHTbTUmqBoIsWuoNf4R+dH377CGx79HHyOhC6PGNhmxQvlWjr4Cq82/uGMww==
X-Received: by 2002:a05:6a20:1596:b0:220:af59:2e35 with SMTP id adf61e73a8af0-22cd8f236cdmr8317314637.38.1752121546745;
        Wed, 09 Jul 2025 21:25:46 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:1511:ef8b:3b0b:71c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4e156sm813083b3a.140.2025.07.09.21.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:25:46 -0700 (PDT)
Date: Wed, 9 Jul 2025 21:25:44 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
Message-ID: <tuglsm3r64mkgzdh2zdrewpzydz7xmyatqxwbbzpqmltwseefc@65cbcs3pq2qg>
References: <xmqqplebzgm7.fsf@gitster.g>
 <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
 <668ce4d4-3b60-47e0-a4a5-dbf73efd1e75@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <668ce4d4-3b60-47e0-a4a5-dbf73efd1e75@kdbg.org>

On Wed, Jul 09, 2025 at 05:04:51PM -0800, Johannes Sixt wrote:
> Am 09.07.25 um 12:41 schrieb Carlo Marcelo Arenas Belón:
> > CC: Johannes Sixt on feedback for SIGCHLD in mingw which uses 17 instead
> >     of 20 (cygwin and others) and therefore seem to cause signal to err
> >     without setting errno as it should.
> 
> I don't know what the relevance of the actual number of a signal is.
> Nobody is supposed to use the number, only the macro. But I may be
> misjudging the situation as a bystander of this discussion.

In d28250654f (Windows: Fix signal numbers, 2009-01-22), the value for
SIGCHLD was changed from 0 to 17 mentioning some sort of POSIX system.

the relevance comes that if I build a program in Windows that calls
`signal(SIGCHLD)` using that number I get an error back, but nothing
on errno, but if the number would be instead 20, like in Cygwin/macOS
suddenly the behaviour changes and we get the expected EINVAL(20) in errno.

> Furthermore, there is no such thing as "a signal" on Windows (outside of
> Cygwin), let alone a SIGCHLD. Therefore, this topic about SA_RESTART is
> irrelevant for the MinGW port.

So do you have any objection on changing the value (which should be otherwise
unused, and irrelevanted as you pointed out) to 20 then?

Carlo
