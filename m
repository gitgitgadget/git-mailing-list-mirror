Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E873220F52
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956038; cv=none; b=lPA9LlgFDfc2ClOy4CVOUfiBV6TZ805uvI+Q9HbYSek6TXXkgWmRgA00N4FnGeKx2MjH44DhZ7gm5UK6EF/F5bEczXYC96YVVFex4K6FxzXGGS2O8iN844+koE3M1+WGkLLEBvYhazDN6c8duhtlVcXb0xLOnwT3TqH+FKjat9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956038; c=relaxed/simple;
	bh=EWxxmJlsyzCGfXoSSCO5hl3DtmRNtiRVtQSaYAQalug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ilq7xeW3FsrsgFb5xJoOWLHQ3mPlydWkVcwy3emP2d1JynsjdlJiRRtLYNvrYULZBd0ty/NWB1ebkFvymBq1BrzQQ/iDyclZo++1UFsJAxrW5LNKJR7KmTdHaWWjv4cQXjx8J0yB4epw0WSK2hX581HBju7s62i5qt1huN0J/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE9BavtB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE9BavtB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60be827f2b7so2964799eaf.0
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 23:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956036; x=1752560836; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWxxmJlsyzCGfXoSSCO5hl3DtmRNtiRVtQSaYAQalug=;
        b=UE9BavtBb6gVg4Kztbv2QzgBmSAhz0i7nB9C45qJ2izeg9KQi9FJVjv0L53DFCAcPS
         XSgXZP4/MptOl7zhZLPMLMv6oQyZ+beTuxXfs+Vcgdt0TiOGcI+ccnknh8T/rgly+BpT
         m2tIaR/khEK1jrVOzc3XJkeK2tDoPKuB594xkJ5VHMYnV7WtpUCDhetk/fuIAtk2fcV6
         RWKdP3UvsJUUEufVE0Bd5Op71P7KE0lSYqC3E6fNyZBM5eRdQOaVJXJ+4jklISKu3/LV
         X4+4KHgpCx6LvlZFkaXYeZEOcCjudddHY3rWCSwv4LvAXe70QM8kzCvZIGByT0h+RKHO
         RR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956036; x=1752560836;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWxxmJlsyzCGfXoSSCO5hl3DtmRNtiRVtQSaYAQalug=;
        b=aUaASOeuDxTvekkssUWGDrBmrgg+C/WV+KEvDvaFoKC293OZ70oR6qq94ZrL/eEvet
         rWLy2eQ6VJb1c87jb2+vodxtzCbr3FAu6X2besCxRj+O563m/e5SN+EKg/c+FdWS5WvJ
         bSd6AOban9hlvMmGZOd2U1tPaCwNAS7/Gzh+mB3OfS2oWQrxrqwPf+quRB6RdXf/rxjk
         l7vcvmvMUOzNHbh7rb7x9d79p9fFH/s1jTFONB14Q2dsoeUbumn+auf/a5zP48c16HMD
         gsJMUvi3JB+ea8q6LEYNJHfQcrQ7WX7HF1hWZ8/J0SfzK5iCz1bvA6VPJemBFx9bxuqg
         Zrqg==
X-Gm-Message-State: AOJu0YwkB5xrcc8VkyHr6upbcD0PNzbqLC7TkM1ZVQHM1VA3aFXGx0TD
	jYRkgFV3vor6GTnqh5uMT6QkFsltUv8Y98qSZymxKHu86+2FVwtKWtZs6jFV/eyk8HAcpXZcf4d
	WMX7noOCuB/STLzqs0t+ShShs/9fcnhyZmQ==
X-Gm-Gg: ASbGncvdzKuSvsRYl7xC8CpOKFz3+NRiLpejGZoHxakUyAmuSqwTV7N5OowTKA0/il5
	U7UE0ezD0/YSYoU23J3F9fomlOhgI+h7ShdRccCiaLyoY7PVJxHpAF9SpsoS2/ijpjsMPKg2tep
	Rdh7oz76Bs7k4Ajqckdka4HglD7ojtnLPuNqF4Xbiqmtpq
X-Google-Smtp-Source: AGHT+IEy4Y3ljt537VhJWRx6pA3fUbFBUtNiLK8hqQ2pqXvGEuw5IygEH8ltYl4aqge7PBf/buoa2s2QPdicCbJRTZw=
X-Received: by 2002:a05:6808:15a6:b0:408:fef8:9c91 with SMTP id
 5614622812f47-4114df61f75mr1145528b6e.5.1751956035666; Mon, 07 Jul 2025
 23:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
 <f9a6c8a1-bdbe-4892-bb71-39a6307a5452@ryz.dev>
In-Reply-To: <f9a6c8a1-bdbe-4892-bb71-39a6307a5452@ryz.dev>
From: =?UTF-8?Q?Jos=C3=A9_Miguel_Armijo_Fidalgo?= <jm.armijo.f@gmail.com>
Date: Tue, 8 Jul 2025 16:26:49 +1000
X-Gm-Features: Ac12FXwbqYLIZ12Br9s0xIwzEDCUn1b4odNsWZ7p-BB7lG4L1p9Dj9ywR-LYDeU
Message-ID: <CAKMuBmQadPerSrOsMmLkJzPChr0TWRH3dy1mRYFx4Hfn6DoBPw@mail.gmail.com>
Subject: Re: Bug: "git stash create" ignores "message" argument
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You won't see the custom message in `git stash list`
If this is working as expected, maybe this is a documentation bug?
