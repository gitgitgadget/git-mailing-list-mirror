Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBC18952E
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486255; cv=none; b=VvTnn49LsoCKt8cAErW79LGKk3PslUI1fZEnjbt69QF3HbUfJzMNWMA52N821DGFIghVjAsHr0/ISX3yutiIj4k77MAh9bEwlCKPZ3N1vTPpheVOt/+Tf9L1wjd003Iq/WElPzgW4K9n6NrI3zcPDrNwyhSTF6rr+KaVxBOGAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486255; c=relaxed/simple;
	bh=Cg+dKy0Fc/bi70FbIKMtFxtp4YSqvPLaLa3b6gzYmUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccf3EDmyOKjI7ldBr8O+Ht1/nqcR2yS0xmS49JmiUzcjO52np7v4iyADIsx0EljaNVyRKGt9vohWpi/52eu5OfPz3vN6ZtB3myP3mwtTlU2TdalqAKhq+KRjdk4/nxHFOulYAhTZhoKvZak+AWmAA5X6C5MyltSI0+pwx12/csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVR4oIQm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVR4oIQm"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fec34f94abso38859745ad.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723486253; x=1724091053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5lOKcauPOeEq/lur6Pa7DpHb0+6wfde1aGpAyMHPSY=;
        b=gVR4oIQmmSzl7XAouLE+Fmf3PQNEqQYZhmIo7vXusBOOOLlI4vNKTKKSJHdFL7VK99
         /5aagkrfEn9HDFHokDJjc2HlP5EnoS4VYDfRJeAEzq96oT5KDANczkfJt7s1sKa5nQMf
         NLsO3Q1GACEi0iuc+h11fm8sATScqOC9n1k0LnXu771eSBk8xpPxkoQa5S0OHyw6vrd2
         4UpbRjBGx6g1dPdUNXTKr8Yyg+fVRERA4g56DUQF7/6nQwxyPrE8Y/nbb7yZ6Lb6bqfK
         YGC/wkKpX7Qviy8+FhRcEy5zLpiSyheZ5W+7WAGE1lkqdt04sK/5L5T39nxJox24cIqS
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486253; x=1724091053;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5lOKcauPOeEq/lur6Pa7DpHb0+6wfde1aGpAyMHPSY=;
        b=YeCG99Q6XYMtnEc5z6z8b+FJpo6+6jlyb3qVQEewa6ahA60AMT+BtyPoZwO8b6MvV0
         Jylk3PUIfj1oHUK9v8NPtDXKYZBIsQL4FldFWCNPAuCBoaEPHQnxoEBDpMUwxCcURms7
         V5tBiKo1gCHItdelVc96dJtx3gY2mOk/DA4wub4/jhpSi+o+ceQA7Ui5fFwpHPNrtbyT
         By0xSnqupLu6n+BKUySzocn3JE68kRtuFdg0woyGfWJ80mGdhX+3tQUateDBSuiVcoT8
         +41JOx14B9iqUASE05DzU0C9GhVHLXvmx8HamJy2y2vOPbAiF5neBLqscOPu/WVVuCi5
         6AQQ==
X-Gm-Message-State: AOJu0YxOwWDBUSr/bfTKLCOFXTDjIWrQIwz77yGD+4vV7vSNt2ApGlic
	+m/UeOUk3b0+QNKGcmjE4xyaH2LQW0nlGLhPlcx4Q/aLVvTpJtDbaHNhTu7YBQ==
X-Google-Smtp-Source: AGHT+IHjVjjsreQ5J372UAexOKpNG+8ehVziOJPOeLKpzb3gbLPC/2FXjyLp88sfoVFN6M6AXXVrLw==
X-Received: by 2002:a17:902:da82:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-201ca129a3amr12571555ad.5.1723486252738;
        Mon, 12 Aug 2024 11:10:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4c2b:85dd:6293:a02c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba169dbsm40674115ad.240.2024.08.12.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:10:52 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:10:46 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 0/7] Introduce clar testing framework
Message-ID: <k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>

On 2024.08.08 07:38, Patrick Steinhardt wrote:
> Hi,
> 
> this is the third version of my RFC patch series that introduces the
> clar testing framework into our unit tests. The intent is to not have to
> hand-craft all features of a proper unit testing framework, while still
> not painting us into a corner. As such, the clar itself is small and
> extensible while still bringing some nice features to the table.
> 
> Changes compared to v2:
> 
>   - Fix a copy/paste error for the clar license. It's ISC, not LGPL.
> 
>   - Include "clar.h" via "clar/clar.h" such that we do not have to add
>     "clar/" as in preprocessor include directive.
> 
>   - Adapt strvec unit test to use `cl_assert_equal_i()` instead of
>     `cl_assert()`.
> 
> Thanks!
> 
> Patrick
> 
> Patrick Steinhardt (7):
>   t: do not pass GIT_TEST_OPTS to unit tests with prove
>   t: import the clar unit testing framework
>   t/clar: fix whitespace errors
>   t/clar: fix compatibility with NonStop
>   Makefile: wire up the clar unit testing framework
>   t/unit-tests: convert strvec tests to use clar
>   t/unit-tests: convert ctype tests to use clar

I'm generally in favor of this change, but I'm still unsure what our
plan is for importing this from upstream clar. Are we going to vendor
our own copy here and (hopefully) someone will pay attention to upstream
fixes and apply them to our copy? Or will we replace this with a
submodule?
