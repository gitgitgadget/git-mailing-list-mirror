Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B296256C8D
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804169; cv=none; b=ODjXkae5hVmZhpgtCJXbcY3b/r/ZsDz0hhlJgeeXj9YNR+iK6PFo7t3zCY1blZyL7jA+pJ5rIE4CbJ7uq5yoolYPE8vdg26iSBf590KOfqIWuIjOBL46QJsaxljUlAJjDIUjTjct/ipgeUa8jTu9EVtZkUo1C8fov3DvQRwJl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804169; c=relaxed/simple;
	bh=xZYWR7fiDoEnRZjmSFxizQ2X3E0ZFRafMhi2vZc+8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajgBl/W/jSRmXMf8UkrIuYwGcD79QFPFgqP5nhUwCc3BhkZk2kH5wso7vTfnGex3K3Icy3+SE0yOGjVoT0absJhiMkvlvSr6NrO6TqMPmwORUNnm1Hd3qAEa4nv9y32xO3DSB0wcjd9d0e40t9GxcwvMsMiJLwv51zWNzrfs8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV7Yz+BA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV7Yz+BA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c7a52e97so634237b3a.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750804167; x=1751408967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyO1U2AAVHuN/obNOc1CpxjCePLLJLQKlCP9UPS56lE=;
        b=LV7Yz+BAQzCnlx+kY4L5GQ6hJjzfdaHNa0qpIzMGn2KQCo3i7PXJ4xq6OQCmjQ8Yxl
         YQf7S8GbDXp79aP7ZPlCQv5Gd8sb+OjeAA8Jk7yCUKVNbW6UdxMX28sQbY7lECyvt/va
         CnHVWCUySV8Du80kzCfwUbECrU6xeAbS1U6k+cJcj66PMAGXAecHZhjhV3bTdeYBqRUq
         3cERyXbxIJDsJLgiL2e3R1V5pAa42pO4VWSYay4+miVOBRAh8K0JpW1hw+I/ehxZPDYh
         gumSJTj7xtsaw67Cl4mejlkE3XlIhYzPpWM3B8TLzDB9k7ERUsll8oOA6HHi3Y5nJAA2
         Bpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750804167; x=1751408967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyO1U2AAVHuN/obNOc1CpxjCePLLJLQKlCP9UPS56lE=;
        b=p9sWuVnG3ekOOX3sAdWlSMEKpylGLpfPUQxfeFUTS8rbFFiIpLM2MzKQSt1hJn5WQB
         R63TKtR64byopu6Ww6+BOcj3Wm0o3STkxJfEa8W0lyYCaRgNTBZC6plAwq0vNSavozQQ
         j4cfygI6wGQRTjZHbW1Sl3OMrKKIXed2pQJYGO8IZDJQYF072LzlrHHKCsYgSLWNil5Z
         m+O/TsVSn+X9SjnK1BoewC0s4D63ac3B8LqmhyPa/fXiiiEBuQk7kBvn1py9GqSdewVY
         kagu2jAAxc59Nyd5D0K26qKpByvRfBpDVYiKf95a3s0P02POzpCYoeGBOTerizAZ76x7
         9D9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJnobdwq8/8OjygcKjIgt24dCEvDKLQha8aZGj+UMmKXI/GGj72nr34CqGY/60qAo0bno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik9eYyzSIVf69dPJgtbFE9TyQQK8n7TrGvGJQXhXp3woySWAq
	1l9HHKCyeXotEmUiFAjLlwlRD099F9AfCTvLezkahddtcDKgZutIB2jg
X-Gm-Gg: ASbGncvjZKUVXbeNHhQIpY5pf11lJ6pPaenFQoC4jnqRXFwFnxl/qFLGkhAlqhxOA57
	2LlPSHcDXCl83KAXB72NAuBIhLItYIztnfuNGCJlJJ05HuA2G589Aa664uo9+SoySwuDcfFWFuQ
	MA8MXyypZo6NGH+jttnaOBA1G7BN+2kSyZ4k7cxJ/iW4D+05aYmB4Y1LRjW+2IROQAKJeEoBgqU
	JC+jkHxjgBruJHSwR4VLggLMRLFPKScZEzW2hBjKmtHn9hSI5EEuds21zwsuFRvhoPGJUXcFGN+
	5q433GGpUduHx0j85YIwad+Xt24ZL0j54QPXnGoM4U/3iCJb/hklW617440qW9U4/w1upVWerJO
	m4jE1z8kugA5To6f6Fzq6Jr4=
X-Google-Smtp-Source: AGHT+IFyUWeA2gnFQrCS2vHc5V02p3DtPPP5niO19o4ooaFhkUQ4UDVHKz0eaL9LiVVB4nn4kcYMyQ==
X-Received: by 2002:a05:6a00:1826:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-74ad4462622mr1422337b3a.3.1750804167293;
        Tue, 24 Jun 2025 15:29:27 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1d3:1456:244b:d366])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08d28sm2800597b3a.28.2025.06.24.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:29:26 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:29:25 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] daemon: use sigaction() to install child_handler()
Message-ID: <neeiqdzggdukyfd5metm56nq6tnperhcnzvgvt4e6idw52rxeg@qrwzjoexs35e>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
 <xmqqv7ol177p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7ol177p.fsf@gitster.g>

On Tue, Jun 24, 2025 at 08:37:30AM -0800, Junio C Hamano wrote:
> "Carlo Marcelo Arenas Belón via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
> 
> > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> >
> > In a future change, the flags used for processing SIGCHLD will need to
> > be updated, which is only possible by using sigaction().
> >
> > Replace the call, which hs the added benefit of using BSD semantics
> > reliably and therefore not needing the rearming call.
> 
> "hs" -> "has"
> 
> Hmph, if we do not have to rearm, do we even need to have the
> handler at all, now it is a completely empty function?  Presumably
> we'll see the answer to this question in the next step?

I didn'r address it because I didn't knew where to put it, but removing
the signal handler isn't possible, because as soon as we do, EINTR is no
longer "returned" by `poll()` on the systems that allowed that as an 
exception to SA_RESTART rules, and even trying to force it with
`siginterrupt()` no longer works, not even returning an error.

Carlo
