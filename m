Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71E3081A5
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578176; cv=none; b=M5v8RYC/3luVKzy2g3ypV1a97gmoZ02Vy66xn/nUpIGIk8GyeimI0SNevvfw7NkuYCQbvo7hCBNaBwX1wtsKEGmhgebDiat/urkh2lrG95/s/juDmNHr7qO+/y2GW7kGnn+tRjzUpLrwkQYHNXA6nmLoSuGRZE9nqwus2CL5qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578176; c=relaxed/simple;
	bh=yBWIv6nVk/jTj5Ruzdn/+eg8h2Q2TVYan2xhDlKzZoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAgInj3QsMqULDGyHeEYGNUXobRhjqFrfMyAuTpCSG8iX1XUnM8tUf4RYn+E6JGj/FTzAOeSaM9HytMPT/41+S/pP49Yla8Y3aSvXdGHR6lRSaTaCCCeb0P8vColLzldAS8El8kyVYgUiOdEmXGFZ46ArX+bVmaerGna6ohOpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEraPjC/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEraPjC/"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3eae4e590a4so1709130fac.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578166; x=1764182966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLBI+TV1xSPgveA3/5rE1OGwyhzUyoGQP0rN3jUv4Ak=;
        b=JEraPjC/vZHSC+3RPJIN049Ybdg+xSvZVseV+wtNFVmAKE3ZoZ5IE9Dv2asFbUah31
         BlxjtZqUSw/Ibx3gQrl3Kfts4nWm9Zds90BSFojIaHGMsD4kzh20eiDJ5YChie7BAK2j
         qEH/+AWe3MewjgysONTzi9bD2KZcX/EN7nNUfD5sSpavc5faPDsB1KSc4qoXLGG/5Tiw
         r4B8LJ+9g4oDisCwTipmVnDg0AyUhcSG1b5hgwWkKS0z8FYFrv36UBnGXmKeP1PqnXkG
         EQAehtBU4Bq7iacziuAmVP5xw5T0DRnMaIqkJC15lfWdKzyul3UfmI0mxsFnxLJ2vb30
         sp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578166; x=1764182966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLBI+TV1xSPgveA3/5rE1OGwyhzUyoGQP0rN3jUv4Ak=;
        b=iMLe830FYqhCENRvYFbrPB/Im7yt4XuZ+4eU1OuSM3/t66PiAlAEd1TpWeUlmN8msU
         GFmf14KuE78TB8dJWsflHcwVqCGJ8WT0QjYfCmz5BaDHWdvSK2R/R94tMLxdfLBbelxH
         PdydmigKXfI3hIQEZKtzOEigBdqmGPZ/cFHwW6YJUGs5eGx11BH5wVTA6bD7XWMrrNJT
         Vav6bbwgZPatIEZcL5dgHkqFM/s7xJ/5YKnEZeDMpiI2AYhQBOu4/R81wzyZG/j4o7VH
         PIdRRvGjo7YZbiMB96klteLM9xHtnoln94xG4963glj5Gh0+jhefbkwupLJJSrZa+PUD
         zSqA==
X-Gm-Message-State: AOJu0Yz+EAwCXEiveJyoaWLQxSIoxALKtM74cfXNEtjjg/Xg2mZqQVdv
	U7H3g2Y6nXot3mSagGOMEkpixOhhzkSL90TUI5yZIn4YnRvYLU/gKn823rSvmg==
X-Gm-Gg: ASbGnctvqU+/FDDXbEu99gWjfRLc6YepgSUZo0MlFldAkFrgYypaTnkiiPlTLvDsN1M
	ZKvdTN7UyTdsgXuIQTt1KC7NghPzueHuJBWNWuhaU5mkqg9hmfa2w7mtOC3q+ttKBpXnASOiK7X
	9pQDgovjCuGtdWNjUNoRuRatT1s219R7LX4y17RGyGKKXHky2/Qy5uJ6N1oxXeJwVUp4d82Hje3
	kkmR56e7bbX+VbhdHyTMy/nJKu9TcZ9h/hxeUqcYRzT+blDNO+Z+rCkm56zWKXqaMNXtPmyMobX
	Jwu/58c4LFgSq5+9mTUSa4VGrd+ErBVRRAyiAnG6Gbwi6jDUIa9Wv4A39Y6UThL8pZXW8BA+WjE
	/bX4kuhQVzWVen2BK+TPu/xV8mHbMNh4AtR6QiZuRtGrSePdQceHsbj5Pc7bPbPKESzWZs0STZX
	2J8e1FRMm9j1wiCas=
X-Google-Smtp-Source: AGHT+IHTpmDrQvD/pqTnzzX2pfwxGxhtxzo2yMMN7PI199xG2t0zzLrLP87kSkFjoCl/xrGaRBkcjQ==
X-Received: by 2002:a05:6871:3308:b0:3d3:4338:bba5 with SMTP id 586e51a60fabf-3ec9a400d78mr256587fac.2.1763578165926;
        Wed, 19 Nov 2025 10:49:25 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dce7853sm51383fac.20.2025.11.19.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:49:25 -0800 (PST)
Date: Wed, 19 Nov 2025 12:49:22 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/18] streaming: rename `git_istream` into
 `odb_read_stream`
Message-ID: <2nd7qcj7jrrwc4fyhfsovs3ptrwmrdxxcap4sqadujtwwua5ha@bpbjlbnbcpiw>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-1-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-1-adacf03c2ccf@pks.im>

On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> In the following patches we are about to make the `git_istream` more
> generic so that it becomes fully controlled by the specific object
> source that wants to create it. As part of these refactorings we'll
> fully move the structure into the object database subsystem.

Ok, so looking at the current implementation of `git_istream`, it does
appear to be already defined in a somewhat generic manner as it supports
reading loose/packed objects. What sources are supported are all
centrally defined in "streaming.c" though. It sounds like we eventually
want each source to fully control this interface without having to go
through "streaming.c" to setup each source stream type which makes
sense.

> Prepare for this change by renaming the structure from `git_istream`
> to `odb_read_stream`. This mirrors the `odb_write_stream` structure that
> we already have.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/streaming.h b/streaming.h
> index bd27f59e57..acf4c84338 100644
> --- a/streaming.h
> +++ b/streaming.h
> @@ -7,14 +7,14 @@
>  #include "object.h"
>  
>  /* opaque */
> -struct git_istream;
> +struct odb_read_stream;

The name change here makes sense. While we are here, it might be nice to
leave a comment annotating it's purpose in a bit more detail.

-Justin
