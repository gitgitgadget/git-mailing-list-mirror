Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3F1C36
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721270388; cv=none; b=oRgoSD+o0HjpZqJDGgtS8nowSEhapZ/JUZEpmg9s6JAMemlCJCaAvPkGFG4N0JllN6FBsyqbTxfLlKVScpwqadBWLRKOSoa/AGZ505DfHa1/IWWdK7BQ1YOVgvo5nTKXRAGkne1uxKRgv98uSpHLp+zKpGU367dziIbjl0Tw+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721270388; c=relaxed/simple;
	bh=a90Gcx90gTCSuOGkdPA2NgyRZIDJlAoC7rTffQXAlh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAVB6Tu/l51XvF2E2i+UVl7BKNArEExzCkTDVO+ctd5n/cA/lUWhE+WOXuf+UNPopVHPb2aTn5eB276Lfq29BmZm1bpFrC+0EwuWtwNFVW7dP7n7PtLGwg4A+hHnbqoGDaxEARbhmtZvXW8+OLfnOwuCQ47ozqtM5QHb8AvAo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4d4FW8s; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4d4FW8s"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b4a8a5587so181802b3a.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721270386; x=1721875186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8+1CL9rz/Lqe6iu0V1CULmzL9Sgscq7P+epcRFgDq0=;
        b=W4d4FW8sfsaLHqCQ2+chKBtq0CM5nc1bQlwgYtwnoXpAnbXD5K5lmK+5eWPvGtETbB
         gSA/AD3tfPMWvX743p3FtIrGhQNuv4rLg8eqyvtRP02aAb52SknHzin01GD7qgcYP87s
         u7ZlcG1W+1ve2e4jfHy1LKe0/Sh/s5OdXWTczvcJfVRX3XlkBw2sQKTIxsyXuNkHbzPe
         6jMEdQ3/GJ/CDIF2soTOqqVB5SLQIoH4thfhx+YNrIY6daHHoR7+azM3lu3BAAq4oeYC
         YC3E1twN1PmrJSI6qpcYdW3fQana51s6Pu4MApyNN57yit1JpJdwuGPw1wV6PO1JwfPz
         eUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721270386; x=1721875186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8+1CL9rz/Lqe6iu0V1CULmzL9Sgscq7P+epcRFgDq0=;
        b=GMIRTa8YM+YuNjeSIjHBjspBkhOLkJiD+Y38HDT2GgYTtb9W4sck1vTCg9/FgXX/dv
         1y865RmWqYAj7Uw2pGAZAjmNj00BLYMbM3n1JFgJIWwSkL3VUY8O3DPSTECRraM0qlAw
         2rOS/YKM6/FVitNzB5i2/ZwaSZohrtyoMy0a5O/1ikMvtSSsnGxMkTMj4rU/9v8AvCx4
         4wqCxXP+XrDbsJzxiZb1f9yg/tZpZPKShUXJ/+lIA6WxZ2SdrMbookMpXDZ1esU4fdry
         P3Tfmj42nFR7PARYnwTtsFQv2WMkj67XY6lSgJoRK58nztvlGnrRBF3+dDeVw9XFen7a
         o//g==
X-Forwarded-Encrypted: i=1; AJvYcCUT5tGAnoovdSSDAE1QiFg7JTEZ5+LHeUzNICJ3NmhT0wSWu6lkLyjZn+vKXNjCkZ0kjxOzb0n6DmtP16WrChAoCNX1
X-Gm-Message-State: AOJu0Yw7iX3m2tx9HjNcaf4lYbB90+KLKvanuCwYQJrBxT8l34cw4EiZ
	eqyv/bsp7kJ3f6jcBQHCrkTCck/SmL/MEkty9VJPBMZuvt1fald5
X-Google-Smtp-Source: AGHT+IHlGKR6mueTI3V+DTl1foJRqqabknNWXmee8Wggdaw6OaQTo6DDfaXwvWWuJ9rRHSA7Vhdjig==
X-Received: by 2002:a05:6a20:d50c:b0:1c2:8c8f:aa0c with SMTP id adf61e73a8af0-1c3fdccd4famr4222743637.12.1721270386062;
        Wed, 17 Jul 2024 19:39:46 -0700 (PDT)
Received: from localhost ([14.191.223.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3a26csm84159205ad.192.2024.07.17.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 19:39:45 -0700 (PDT)
Date: Thu, 18 Jul 2024 09:39:44 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
Message-ID: <ZpiAcJuAH50UlHIX@danh.dev>
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
 <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
 <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
 <xmqq5xt33a10.fsf@gitster.g>
 <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>

On 2024-07-18 01:02:54+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 17/07/2024 23:53, Junio C Hamano wrote:
> [snip]
> > That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
> > Luc's patch is a sufficient fix without any downsides, no?
> > 
> 
> Yes, assuming you're only concerned with 'make sparse' usage.
> 
> BTW, I didn't expect it to take this long for this issue to come
> back to the list! I expected it to almost immediately cause
> problems with the sparse ci job, when the version of Ubuntu was
> updated to the LTS (now previous LTS!). So, I just found a simple
> solution for now (which turned into 2 years).

Well, yeah, -Wno-vla would work, I used that macro __STDC_NO_VLA__
because I'm not sure Git want to use vla or not, so I only tried to
disable it for system headers.

And yes, the vla declarationw as added into glibc 2.35.

-- 
Danh
