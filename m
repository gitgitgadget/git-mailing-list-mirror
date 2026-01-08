Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579E35966
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911457; cv=none; b=sSsbQeF5SjTbEDPU3UqQ7IAWGTwFEtM9eslPsxcceKh89Ie7PuWWfBVvHm1vdLLHJFBZAI2KxrsdlJ5vzte2Fo8nzY/kjg0jc8yOFw3WG4X7pI5K3THCBxUon4p1pJTpvmHuVM2x5xoIgVWPcz0Mb9WGBqB3ZsD0A0rxYyZBVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911457; c=relaxed/simple;
	bh=DFoQdUiH/PPSPeW1Vt7p1Uima0dIPHiE923pl5CukT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFER4q4gj4A813ZfxYIo98k4o2E9Em74OM+KxJ48P0xWMEsPJd9xvb/2/6odhqGb2cNI79Qei5nSI5Prvk5pG9/oXDQDHwS5PmXK0gncJiyPk4wry8jLOpj6aK1qkU6lTavgQybIua19yUSo0BD5rh1vEfjXAHmjAjWnSwQgXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iem+pGQz; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iem+pGQz"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121b14efcddso1549c88.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767911455; x=1768516255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoIFdhzWtE7OzbuLDtmwtOfW3W3V619QyA+0A8P8wjA=;
        b=Iem+pGQzDOOPRsT5Pe/GgsV2Ndzteo6tWdujHfYO5AAYZp6BcBQtEpclPhza6Won47
         Q427RnM6jyaBfVbeWbBb2pqXW1gJZrxuGldHlD01nVH6F5cEaG7uQ0BgrFlDhfh1GVNf
         +lEhZdGS+UjUZC8kK0dOsZ1P7hQGGym7N8mXIdimIyhClpx1Kkk+suiTD6LXjm8nVzk4
         AfkCbTRwMOdUxxUZjph555y7n58K5EFd5pu1zWHSpY8MgkK+hXimO2lu+0D/4O/xp8Hj
         qXw5diy/myMdcvMkBWpL92IAnDBMIIAkwpqSuktwi2n8vxsusdRytNxwzeGdct16eZN8
         GCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767911455; x=1768516255;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoIFdhzWtE7OzbuLDtmwtOfW3W3V619QyA+0A8P8wjA=;
        b=WHdi+98G+h11uOTzfMHByacZciio92efOUakJt6Yb813GiaJwrrSTsJJCrgxwRrzFB
         G/lCl2008tlFeGBmrbiVMkHQBUA2Y19RaBAyTSaUIEK8HKUk2ywD5NKl2bHvoNfHQ8sG
         lx+EGQl76Q1WpBxrDZYYlP6yNSK/fyrnSgjxd36kqAGFqBwnXZt2fqkWUJ7H3piSupdT
         dMMv4IYHD635tEtGhCBBrSZPB2tivW0ODVcKcY3thcgwGxgPXQp43djYrNCZy47o9h5Y
         GQUAmLiPVQjRjZ/zEHf+06c21sFDKe8DKZjnSFmbusYDBj/AVXiTYoDh1KASxfH9Upf8
         fxxA==
X-Forwarded-Encrypted: i=1; AJvYcCU2rdw47JO1vjISuANaqcLkJQTlM4ApHzGTvzzyt4OJAmPBbZSEqcmOEs+ayBlANXYKbns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsK48O9scOz6Uy/YK+GHULzccXTfX7MDNmaPnltcDzPoU++hL1
	STif1TapmQxesyyuTGIubRTzQMF1NKc7qmyQUxV4mfojjOh9jGtJNygbE96ncn2egQ==
X-Gm-Gg: AY/fxX5jup3dsnQDiTPq8FnWfOVHq3E+vut9dH04kDFRcMpKKYDxvu4pCP6jot2GVy8
	aF24Lp60J0/6yVFVUxcjPEnQJWp7gFJ+r8EvkbF8Vc/A8flME8h/zxg49aEShp7EqqXjrry05CA
	eldtO7Ua+6hMqtlgAQkZiYHp8sx2lGvRfN4azjasG3rPQEEH8irUrW5KJSfmTPjhfYiJD+aUIJH
	t5xqjn9Fvd6YnutsSS/C0Ipn3KCINJfpvPXF9XPFCuVJaV0/8rqpiAOENbDtLPm1a6Bboylw/yO
	NBpL5vj5hZsyJpyFBxRpBeBWaftcmr+WuBg3dI9cMoHScb0atXU2QW1JRVsHpAxsRR5jbuIHrDx
	Sy0gBUCg1Dyyx2xA0+rV8AouqRnPeglceDjtwjw6rjT9nVkPGxn/qF2PN8q7xGnX5I/+pRLTzn1
	O6UoTLvFrodF2kmPZT2V6kWsrEwx2UgaRBqQuTOCVa9gJWd+Ohe+NW7FQ=
X-Received: by 2002:a05:701a:c951:b0:121:f3e6:edf1 with SMTP id a92af1059eb24-12205d1ff79mr13416c88.15.1767911454712;
        Thu, 08 Jan 2026 14:30:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2f0b:6:3df6:856c:cebe:5bc4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078d9b1sm10925819eec.18.2026.01.08.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 14:30:53 -0800 (PST)
Date: Thu, 8 Jan 2026 14:30:47 -0800
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, 
	Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp <rdamazio@google.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 00/11] Add submodulePathConfig extension and gitdir
 encoding
Message-ID: <bd2wmyi5pq5rd5l23nsk7d6lp3q4664omkq4pfjuwlcdkcajr3@v2c7vsfv2hxa>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, 
	Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp <rdamazio@google.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
 <aV9S_oUJjitkeWjo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9S_oUJjitkeWjo@pks.im>

On 2026.01.08 07:47, Patrick Steinhardt wrote:
> On Thu, Jan 08, 2026 at 01:01:34AM +0200, Adrian Ratiu wrote:
> > Changes in v8:
> > * Added a new test to ensure gitdir config path is relative (Patrick)
> > * Improved gitdir validation error message and added advice (Patrick)
> > * Renamed init.autoSetupSubmodulePathConfig to init.defaultSubmodulePathConfig
> >   and moved its init logic to initialize_repository_version() (Patrick)
> > * repositoryformatversion is only set to 1 if it's 0, so it doesn't
> >   overwrite potential future higher versions (Patrick)
> > * Fixed global init.defaultSubmodulePathConfig leak between tests (Adrian)
> > * Whitespace and other minor fixes (Junio, Patrick)
> 
> I've had two more small comments, but other than that this version looks
> good to me. Thanks!
> 
> Patrick

Disclaimer for the list: my employer is funding Adrian's work on this
series.

I've tested this locally, and I'm convinced that this can replace our
downstream version of this feature without requiring user toil or
disruption.

Thanks Adrian for your work on this!

This looks good to me too (modulo Patrick's comments, which I agree
with).
