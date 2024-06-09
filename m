Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32D17997
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717917989; cv=none; b=trmX9cR7tLF9odxIo7AhLQTxWHOgpfm+6YK5R2CpZqjih0JT12bPjf2lH6lTTRqRSHb61zmENq81LLu6V5BQlCJg4Kk2bMnqbVMhM3SGzzFMgaQD1aSZRYb+wQgpLyjfrs9f3KUiDWt1ZL1BxKyUa+UpFsovPhDhWmzIFvRK8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717917989; c=relaxed/simple;
	bh=9glUrcnyancxDkMB6H8F9i6dLigPOdxJkba1wj84bic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH3n6Z02rP30k3HkJSZKE/YIZLgxSmflEDdyGp2Rfm9fFfNQn3nuTBFBtGOfMelYxtVSaEQCvdnjDzXpo5lrmOiV/1+Cr8TcX8r3LAwVRJ+aL8Wzvroj/Bdwz8oNJDPecsNxis4Jv95Tw3hu104t9RpO/3vdmyt0qrIbaFKznkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPMJCDzm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPMJCDzm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421792aa955so10459595e9.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717917987; x=1718522787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVlJVYVYvbEP8dn9UrG9KaFVaLD4TFBdz6uNhz7fzy4=;
        b=NPMJCDzmGodLspNip96IaM/5KshYOpVSU0cGRlgaiXXgSM2DUYIO7JSnw/ybksFjZ8
         CfJ7BQDGSkGA4SL3hLbN4h5RdwntnPavc5WhIzfzqqMWl2KcvtfbMYbUk/TQD2pFvuNA
         DdjhUeJj+z2NaiB1JB/WTFRD9/wWQESWyXn55Sntw6xVi9gnKUTsea5HnJ3f9BR+5uZB
         uRa1uRn8xDLuCSPOoKcThn/MmCP5khPtzQZMdRf5ruEljkDykD1uuLfBnR2gZ+U/K7HM
         +5faV25EnoiIZ1pMTz5amaduUL/no9fqTpFziPXDTL2xtXyNsiR0Zucz65nSO875PGwI
         j0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717917987; x=1718522787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVlJVYVYvbEP8dn9UrG9KaFVaLD4TFBdz6uNhz7fzy4=;
        b=QU8RylexTmQPIFPZtKxCNdZxM7yo3r/Xq43Woibk0zULF/bI8nQ3ztrvQ5JLyP2ttI
         sjJWvddd5D0mjjTBHNcNn/lWte1pO1/d8LfAdW7zYo3ioM1Wbc9QJNxt4dxgwdpfwopm
         VH515Kt+JWgYVMo0kco/QhgqdS369SvH5lCTvE4q2lHIbB/u1fyvITBRUzyvlQQGtzwt
         ffA46EiinPtLfGxnlxm2bzzZuujP4yokQ82cIMJvnPJ1WDg0FJGkMsvpy6p1DpF3qZVs
         3MCkW7NsTikL303zJf5uzGPncVrKgCTHXhc/+xctv8S+gmA6nMG+wSKlvJ7nqMqaSMuB
         0Tqw==
X-Forwarded-Encrypted: i=1; AJvYcCWo4bXHIBd71xaHclC6NvjGVFrzONSdPeupbo7cohPUaf8GjmARfUxZyKBWl86XvHvJFuWH3CoQHFVJHkxkhqtoDVNZ
X-Gm-Message-State: AOJu0YylpVzOw0SPGcyWjNR6n3WC0BsCRkikspi0n5QvWne5V9CXr4r3
	PIpKRzoZgZ6D9gWKQqPU57RYhr1ILcGkFFRedgvvsR3QFcQ0eMt7
X-Google-Smtp-Source: AGHT+IGkk7DEellI64wJlx2T7Lyi2OF5JvOFVunGsBRnSCuhEDan+soojXSbOKeogB2//phrPnsYUg==
X-Received: by 2002:a05:600c:4fc7:b0:41f:ed4b:93f9 with SMTP id 5b1f17b1804b1-42164a02777mr54661525e9.19.1717917986452;
        Sun, 09 Jun 2024 00:26:26 -0700 (PDT)
Received: from gmail.com (62.red-88-14-48.dynamicip.rima-tde.net. [88.14.48.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4218144244dsm10693835e9.1.2024.06.09.00.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 00:26:25 -0700 (PDT)
Message-ID: <da18f9c2-018f-4808-92e0-d2fb67a427fb@gmail.com>
Date: Sun, 9 Jun 2024 09:26:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
 <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
 <9c76f1f3-f858-400e-8fc7-8e3bc9764e87@gmail.com>
 <20240606082748.GD658959@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240606082748.GD658959@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jun 06, 2024 at 04:27:48AM -0400, Jeff King wrote:

> I just sent a series, and I think you could either build on top, or
> the merge resolution could just drop your new option.

I've already responded to your series, but just to confirm here.  I'm
glad to drop this step and building on top of jk/am-retry.

Thanks!
