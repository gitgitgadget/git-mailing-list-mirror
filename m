Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30821E491
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861058; cv=none; b=DX48ppLjh3/YoBYKuIhs93GxfcbFpCuwS9Uch9Ls0DOFy2CjgwKI1jTqY37nNwIMYR96KktRv+dIML1Rz2VZVgyCFgQUb83jlz8mXDddiTRASZNRDgOn46D11EufOYf8kgK3uDkDAeQ517EHNVZabQW3rvtb+TTOJRafvGlEFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861058; c=relaxed/simple;
	bh=vT7RhImPYFHmQoybFgFgo4wGb3WFt7r1rhfxx+1EeoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHxcP4XD/vbfeP8Inga0l04Nl1ysJjvEckzcdoAC1eSJ+vJL5e93Y8LHSlWycyrRrU7V3i03FSaSk94nnMcCvr3CUlIlrp8K0Ff+iUNB2eQ5/fAiq6Z3FtjKvfFZFQx5kgTVFWmh7F80+UJteFLEmg/nabCPnw/9xa6XqH2BuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3VGsy+X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3VGsy+X"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso169493b3a.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712861056; x=1713465856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcuMTTkyrEu/u38FVXck6h3r++39i4e2oYCRd9P7b+k=;
        b=t3VGsy+XTGv09xhI8LywSkuVcaesFJXP2BtMT/HvnKskTUh2Rs7f2UNRFGi8bhgLkE
         +qOOlRBofk7X8eqVz6aeLzeX33ly5Bt1tiHSmXGn3DXcCYjocZV8zMDo+3ingarh2ENv
         4dE/gKA73cjHdQ7t3U6Vow4uIA58ciOexjEw6vK7aGxCfWsp0m6ie3pPIo7Lp+VN2ILt
         NV14PTjaA7d8wj/FoWfpNS+jmm3Hs3mR3Q0MGcECfpQtsGzU5dnIX9uleosMw+Be3aey
         DtjA3n0VMHaeNNEaQjBE6As8q+uu2yW7ufzmzmt2HJbcc4gwUgAWZLS9c1Vcs+3LYeMU
         /zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712861056; x=1713465856;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcuMTTkyrEu/u38FVXck6h3r++39i4e2oYCRd9P7b+k=;
        b=cDRZl42bwru39N7GW5mJPjuy0FcYlx5UD2ZgUMatVX+KhQaIFDQPoWoj5Qujv4K6no
         KK5CBlemoe0Hk7kiwhF4ild3sIGIsdFioVAljVOUn7xyL7IDY4/CFgepGs4DbbRNgkwz
         sQ5atAIcfGTPKLkjMydLkAkbZzLshefFAw5jFA5Ih1IPEQ2X/qadJw8CAgJXWYgeogfV
         u6m1KPD5T8wpPS3JpybbtQ1cPKK/5gy5YsXHJifvprW9zlvDHmBqRkXsg+taKsvvclEe
         r4o0+KBjnZSKUMHiBekRG3XStz84VKwNMGfv3XbMcPUWW7SVSg4YYLsa1klQXh3hY0ES
         ncfw==
X-Gm-Message-State: AOJu0YwuziEGNB/gOvtPLX3awd16Xy/lvQZsxpSAC8IMRiwcQ0E1wCnL
	eahw/EOYGZCECs+0FIkcIpOuoqIaXmm0v8a+rXoqrmd4+yVZoO4ijd/bqeKCN88+bSsRstFXkYK
	vfg==
X-Google-Smtp-Source: AGHT+IFGhOPZZGtqt+Gdy51PvePq6dO3JRdMJsER4ARxj9LEO4PpUGM1+i/D0h1RnWux0Wqk9Ixh/A==
X-Received: by 2002:a05:6a00:4b55:b0:6ec:f566:6eb0 with SMTP id kr21-20020a056a004b5500b006ecf5666eb0mr592245pfb.17.1712861055920;
        Thu, 11 Apr 2024 11:44:15 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
        by smtp.gmail.com with ESMTPSA id v1-20020aa799c1000000b006eb3c3db4afsm1476613pfi.186.2024.04.11.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:44:15 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:44:09 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v3 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <ZhgvefDKhTQ6rfnD@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk,
	gitster@pobox.com
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1708728717.git.steadmon@google.com>
 <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>
 <20240327085827.GA846805@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327085827.GA846805@coredump.intra.peff.net>

On 2024.03.27 04:58, Jeff King wrote:
> On Fri, Feb 23, 2024 at 03:33:55PM -0800, Josh Steadmon wrote:
> 
> > diff --git a/t/run-test.sh b/t/run-test.sh
> > new file mode 100755
> > index 0000000000..c29fef48dc
> > --- /dev/null
> > +++ b/t/run-test.sh
> > @@ -0,0 +1,13 @@
> > +#!/bin/sh
> > +
> > +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> > +# or exec unit tests directly.
> > +
> > +case "$1" in
> > +*.sh)
> > +	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
> > +	;;
> > +*)
> > +	exec "$@"
> > +	;;
> > +esac
> 
> An earlier step required that runs via "test-tool run-command" have
> TEST_SHELL_PATH set correctly. So defaulting to /bin/sh here is
> pointless, I'd think? This is used only for the in-Makefile "prove"
> invocation, so running individual tests or even a manual "prove" outside
> of the Makefile (where the user might not have set TEST_SHELL_PATH)
> would not apply.

Actually, I think the "manual prove outside of the Makefile" situation
is worth keeping this. I know I sometimes copy commands from Makefiles
and run them manually when debugging issues, so it could be annoying for
folks if we remove the default here.

> It obviously is not hurting anything, but I wonder if you'd want to have
> it complain loudly to catch any instance where your assumption is not
> true.
> 
> -Peff
