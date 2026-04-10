Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE973D8915
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834271; cv=none; b=EcsS59SWtdfZDbTovUw/ncFHI2arU8UXCf08+7zXdpq9//Q/rqbI4E7tS5i7epjpC16Ks21ojzqXSm8FnWUec1mqTnyFTq6VfMsIWsBPfNq4bT11ztt1lXAZsAWYGpkgjd+mQfDPIiAE2Fu8/IGpC6WeArQTFm2XtXpUI2Exm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834271; c=relaxed/simple;
	bh=v+jS8zYPIEd6EKAh12ZTO0PKpXP391N2G9PcBrKkh2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYH0zBgSqrwWEpnOrbz6TEF/lWr+CPZzzxyz3VDMl7ZXlrn/PlKfAuBP33aRBugSPDUZsfnmi1r8GW4Q7Lhcw0LDaBLLUcMdh6hwIzv7NBFSlLMNm/oW7pqq+5WWg4Lo3LoXQcZ1HV+MYmbERQ0vRroEmyaHwPAjS0nAQC5bSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGYc56VO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGYc56VO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso23271585e9.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834268; x=1776439068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iuvT3o+nxnRjdL2NtpnmT//+OJcBjFlBA+hgIss6lsU=;
        b=bGYc56VOKnZAXxHqAbAGIdnpx3Yv0dJmsAOvMrAT8/zKGkdS2vJ1Xk6EPgyDiqdpuZ
         kZTWX7NPUldU5BrmdK/O571AYnWzKEcGJc4Uk77PprTZWl2JhO2LnVfhaHhUgKBgZyIB
         TEfkMp8D0fbmWjqLvWiq0UgjfpjWXPpphhzVWYQjmx40xW0DMjrGr3svVN8orHG5vhcU
         iv1kc25Fym29GnroStntUNwZ8qlHM3AD6uOE8PdsV9w+vl13RjL3amCSafYZwYvZD6UO
         HYuJUNgUjScXDkQ7eUgECTzkL2cvxQfkHDS0fVP6HPzT+fxJ51ernwsvnZQUNTbz+CC7
         3iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834268; x=1776439068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuvT3o+nxnRjdL2NtpnmT//+OJcBjFlBA+hgIss6lsU=;
        b=r2nH+nbA2ejbiAJkiP0vJAczwZkZ8krB4DSTyp5pEr0rGLAc/Yw5MV81NWTd0nbuoo
         KstpV83OwJxd7makp2drcT/3D6d2xrwy80edxlsXs136S/P5wZGmbrBr/T3UAWLAIsMX
         2gGm6OKrimDvi2/EGzfEK7Y8Yoay66W/3vt4JKk8YRlrT7ovcv5vWe+C/7T05VmTXCK1
         p77EfuFmaZ9Skq7yd+wpgh12SZvMXAdDYCdW7aOu0laoCVjnmYjBNUVCLpQGeDBb6nhe
         XHHMq++XUJiLzuXBLIdc0wL8yoeVWLk35+/N7tSKlCI1jsHC7qLN6D+zRa8s2Xix+lSy
         V/jw==
X-Forwarded-Encrypted: i=1; AJvYcCUsi0Z+OHW16sCdR/AorCsD0ql+xwXZN9jKN+vjqxkaPofLEF7LitidtMPRqH+XszufWig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wt0UCiQyCQHxStwP/MLKFae9JmuA9w6q485FlUrrOTvRFmVO
	VlKp+yVYsAnhq8RbMMK8n0RNECQqzmYxFXv/P2Z49JWQOYpWnt1srkJBulpqMg==
X-Gm-Gg: AeBDiesoD0ZmYDG6bqlnCYOcmh0JbomKrACx0gpX3k2Am91KSfTK3AIG4jOgMtNXf67
	utvXX0zsTYwuTTIHIF+KuiJEzscvzKEiZznzWnqZHhX8hCDBB0IbGiQIVC8zxgXNKiGqNQ6lpHb
	lFzLPb2RNxtnRywnKR2hpOt42NLm8SOUqRoYKXVlxcjvO+fXJ7VBWiNMZ0XQ3VQnwA/y3iCmvgA
	W8tpNVFO16VFrwVTS/dBZyL9AJ4KGb2pKB4PTge8FYILaTo1vHitgzZrWnNRK6gzARQkh9ypOIC
	C7NGYChOUpVrWmTCgQVyYfhrrVN44UoB8Yr9WmV8ro5WU+3wmb0Pu5Fg9S1rnpJoZkRIP7cPcW8
	DA0dUuNmkvFceC4b84fqFXtyW9IkJz/XTO/jc6G7hM4OjkQOkIRS1ALE40RE8WdfvGe1CgY3o9Z
	whZlc77IL2thLnDy8ESvbSWt9nLuSV6VSrHlsljcCJrGXL022H/NIl
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id 5b1f17b1804b1-488d67b8d4emr54370885e9.3.1775834268051;
        Fri, 10 Apr 2026 08:17:48 -0700 (PDT)
Received: from localhost (62-165-238-49.pool.digikabel.hu. [62.165.238.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e70sm42306225e9.0.2026.04.10.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:17:47 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:17:46 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <adkUms2ee8aKIdAB@szeder.dev>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
 <abH6dayn5tJBMY9p@szeder.dev>
 <abJbhQwc-X0T6S_B@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abJbhQwc-X0T6S_B@pks.im>

On Thu, Mar 12, 2026 at 07:21:57AM +0100, Patrick Steinhardt wrote:
> On Thu, Mar 12, 2026 at 12:27:49AM +0100, SZEDER Gábor wrote:
> > On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> > > On 11/03/2026 14:32, Phillip Wood wrote:
> > > > On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > > > > In the next commit we're about to introduce a precompiled header for
> > > > > "git-compat-util.h". The consequence of this change is that we'll
> > > > > implicitly include that header for every compilation unit that uses the
> > > > > precompiled headers.
> > > > 
> > > > Is that a meson thing? I know it defines precompiled headers on a per-
> > > > target basis but does it somehow force each source file to include the
> > > > precompiled header? Looking at the gcc documentation it seems like the
> > > > precompiled header is only included where the original header is
> > > > included.
> > > 
> > > Answering my own question the precompiled header is included via "-include"
> > > on the commandline. This is necessary in the general case because a
> > > precompiled header cannot be used once the first C token is seen.
> > > 
> > > As an aside in git we could probably get away without using "-include"
> > > because if we include "git-compat-util.h" it is always the first thing we
> > > do, or we inculde another file like "builtin.h" which immediately includes
> > > "git-compat-util.h" and so it is included before the first C token is seen.
> > 
> > I couldn't find this in the GCC docs, but Make's documentation states
> > that "you cannot include a precompiled header from inside another
> > header." [1]
> 
> I think you must have confused something, because the link _does_ point
> to GCC's documentation, which does contain the quote.

Indeed.  I wanted to say that I couldn't find this in the GCC *man
page*...  And then mixed up which documentation site I was looking at,
as they very much look alike.

> But yes, overall there can only be one precompiled header, and it cannot
> be used after the first token indeed. The use of "-include" is also
> explicitly noted for "projects not designed with precompiled headers in
> mind", which fits Git. After all, we still have the ability to compile
> without precompiled headers, and I don't expect that to go away.
> 
> Patrick
> 
> > [1] Second bullet point at:
> >     https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
