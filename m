Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06918CBF2
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111873; cv=none; b=dWqCmZ8xZyb0wwThi+3VCAOT1CVHTCE5RfRusxOQYK4xZbrbMMQ6qhY99X6R+9RvRd+bbPFWPTquM2sfzJSJ8fCH3MnwXQko3F1aNIJb7XPNa9BXXLPug2pVNUDMqDX0wszWFTc9tBWnS7etBvFCT1Q7MfY4bh7pTJTMM1AqUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111873; c=relaxed/simple;
	bh=Ky9kSyyLcGGVE9XaQjwVR5S2j4i7k4GWchQw8S5aHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4O0SC3mdc21PlVmRBIGkOCmoo3iC5Mk+CzKpjNpVCjRc8sw3Jj9BgDqNl9OMqGGdAcSWIL4Yb8KPtDgH0OStdV/FNoQofJ9ms00UD41XgkLQo8ExRs62pUj8UV3iAB4GoyqE/gkeFgazNo426HsgZkmzaWhd/hgzR03rNPb4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mov45yOU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mov45yOU"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so261057276.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729111870; x=1729716670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45KgiKnP+UjTRBPiJxV/knrRx/x1lN16UlNNyiO3/R0=;
        b=mov45yOUqP2mWg7L58Gc9cELY8+gThVys7R8ZFif/4xKs1CWbxHlrjHys9VK252DWw
         R1Fi3/7okoJ0fYUmtKLPW9TPeYCjngrdFTXcuctIURY8Qm13fNtWM4bsRp+9RYCbkJGD
         9RxhRRc/KgFmx0Qmo4Yell9FDEPvCbMLJhAFmXgXC9flKN828e0Fp5B+GJYUbXIRwKTc
         bL81v0hZAM6ZSbqKwx7y7DtiCQtuOJJ1fs3ktJk8Peb1nMhiGKZjlTWiRYjap2K/2UE7
         6n7+Bse/iTqv49ZbQJsEWtOHsgelSJS5o1mGMPkyFTE92dZlZ/fkE55XWaKjwnZy+Wc+
         oEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111870; x=1729716670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45KgiKnP+UjTRBPiJxV/knrRx/x1lN16UlNNyiO3/R0=;
        b=asiGViAv+xvSWmu14Pc5RiQJruLRwKhJ9G4tomlIuh/S1EM03X4UBsfW5JkbdSLCUs
         L4z9iH+e+QE+uRztpu68KeIpRVASaFIR6Lk30ejhaYghBiPeVmub3Iv60yGuT2pHlvEk
         HmcXHxmtAWhGlsODIYGolBCdXkLdy2gbnqCRcUBZswht1TfqsbcTkxa2EZNJ8VQZmmif
         wIdZRqIXbaV+Aub0RZfLYinjiUxjCVIahOTsEzJjgAyisVvUgCOMOzu+KKjZkKwlHtlZ
         3avXevcHBElgpkvCw5AHfatf8gXDihZAcIJdtKqYu/bgpLj3JqSKf4YHbntoEuhYWupp
         47sg==
X-Gm-Message-State: AOJu0Yym+wOSJfFsDM6Tay3o1tQJ7UcIkjVIux0bbn1vMUOze3dMvHg+
	84QuL40E1+oObVBW5j3DhITMYlZaBF/J0wZ40wkeb9N7vlhlQeSOnDBpxsXI39E=
X-Google-Smtp-Source: AGHT+IGfJWhphxqjSmHRvY9lf+dY9oKfhVm7BhdYL8dybV/QXoQmE//0Kdw0QEI7z8pPub7+/RDODg==
X-Received: by 2002:a05:6902:2404:b0:e29:2a45:1e83 with SMTP id 3f1490d57ef6-e2931b62da2mr12497519276.31.1729111870553;
        Wed, 16 Oct 2024 13:51:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfd3f1sm746437276.13.2024.10.16.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:51:09 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:51:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 4/6] doc: update-ref: remove confusing paragraph
Message-ID: <ZxAnO5zH1vtgRvLk@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <dec48e2d37cc4edafb51476284ce3fece4718ce7.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec48e2d37cc4edafb51476284ce3fece4718ce7.1729017728.git.code@khaugsbakk.name>

On Tue, Oct 15, 2024 at 09:03:13PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This paragraph interrupts the flow of this section by going into detail
> about what a symbolic ref file is and how it is implemented.  It is not
> clear what the purpose is since symbolic refs were already mentioned
> prior (“possibly dereferencing the symbolic refs”).  Worse, it can
> confuse the reader about what argument can be a symbolic ref since it
> just says “it” and not which of the parameters; in turn the reader can
> be lead to try `<new-oid>` and then get a confusing error since
> update-ref will just say that it is not a valid SHA1.

I think that it is worth saying that this concept is explained well
throughout other parts of the documentation, including other parts of
'git-update-ref(1)', as well as the glossary content.

I don't think that you necessarily need to mention that here. But at
least I was initially confused thinking that this patch proposed
removing the only mention of the special "ref:" syntax for symbolic
references.

But it does not, so I think that this patch as you wrote it is good.
Let's keep reading...

Thanks,
Taylor
