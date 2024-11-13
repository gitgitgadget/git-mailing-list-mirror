Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED0200B88
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502999; cv=none; b=c3Qy70kcALIIxCvM1hwVwnk0qyeMegftkUSJw5GyaLGQGG3vXWv1AyGG+VF/02GHC+UH04F4+gyWAdjOfA8NbXklMKRAxOwJd7uOB/u6Ge50rI7gsb+c8uPTXtWdvhgcORRD90IhqcHehIJcdm78Z99BV1vRaOZJdNwMdJ4BDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502999; c=relaxed/simple;
	bh=9OHXZeLkMihk1e0eRU5uOfktbI/s+JQ2xAPj93lZ8uE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpEaXf28dnxl9oxLwHzQo/A8G3JxpWW9+nHejrujc8ePOOH++yrVx+9mkvS9nBEEXUdT8Yb3qcVr5vfnkIsi5lUAIWCgLf7YvZeNqN+G6Ns9iMSX+9FSEmFIUmTFRawnCNiBul+ljDLkOLdqkdswb/zdhX5nH7dFEC1+mWuDgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffTYAZ8U; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffTYAZ8U"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-718065d6364so3498128a34.3
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 05:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502997; x=1732107797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OHXZeLkMihk1e0eRU5uOfktbI/s+JQ2xAPj93lZ8uE=;
        b=ffTYAZ8UCCeQdjXOZJtTHwKm49anCdLDW9gLYdO+zBp4LIX2627q9URmEhQb1s2Lv2
         rV11FHyG1t8HRJ3eVQB6tyLU4CUg+U55pW8nbFC5mvJebEM9ngB5zl90d9bXPO+Vzx1w
         QJ/Yvcp/hr82RH4Mt79ZMHqpRXBh94lbDzDzdF7/R3JMSwVKdiawV7P/9ZkVFIP0ZlsD
         k0C54RWQ9JBPoezuqwcCYWJSCfthWIfo/7i7eQrWB6KvTwqXPgrITdR5Y+O8LOiV0wjq
         pWBXYbym4uJXt5NBusH1UccbJ8VwC1bHGuydHuceBTgxEoG482xGSqHGd2b13Q/iVNZz
         jMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502997; x=1732107797;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OHXZeLkMihk1e0eRU5uOfktbI/s+JQ2xAPj93lZ8uE=;
        b=R7uzM78xyPRmevwQNdNbmBFNs/OB7eNqGOVvTFO6c203O56VBn8UyoZ4n8YwUFO97/
         jcaQzq0/q00R0uGmQdPJdtHjzExcBpuxW24KACnLK5kHqCquxadZNhQbqpSerpx4KW6g
         BD++vKlkTG2Uqu47KJim7sjvDOkEymregvSsjNdIAWz3Nv4VuD0A+ZJP4Cl9CUx3MQ+d
         99faJ8sQz/4kYd+jvaAi0ejbOOGPpVePvm8dLeKFgVBEkaEoBkAKi9+IAeAbmHacRAog
         yoNuwp49GSnjAzI+aXrl23lX8iopUNK+qPcEXNEhaUowwgt2YNhE5WGP0qEP+JhySPHh
         oReg==
X-Gm-Message-State: AOJu0Yy+jT3O9CH4tWKhXjmfNXVJ/5vx+8uKdvhclAnPMYegw8KsVa7V
	G59qx+Xzy3gdXVNs+OOiMRSRQ+txQZ/B5XV2n5tUoLaMj0MtJWJCkM+7JHnRvBhDJLCJVZAcl8n
	sNpbo9BLzPnZQ4VDjUKVKqNxN8lFK4jyw
X-Google-Smtp-Source: AGHT+IEcPJsMjyxMpiTD+uPjoBLxQwOcw+p/66qZw8qJo5XF+rYEIIp81hA1SCsrPRKLYndiIldpd3B+7WGhrnxFRps=
X-Received: by 2002:a05:6358:d04c:b0:1b8:f18:3e53 with SMTP id
 e5c5f4694b2df-1c641ebd6aemr810026955d.9.1731502997036; Wed, 13 Nov 2024
 05:03:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Nov 2024 05:03:16 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241112083044.GA3393089@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1731323350.git.karthik.188@gmail.com>
 <20241112083044.GA3393089@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 05:03:16 -0800
Message-ID: <CAOLa=ZQZCbkw+4sx=T8BvL5gaTxHtTYxcCN76awETBK_-FJV_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] packfile: avoid using the 'the_repository' global variable
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000001196930626caf5b3"

--0000000000001196930626caf5b3
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Nov 11, 2024 at 12:14:00PM +0100, Karthik Nayak wrote:
>
>> Changes in v7:
>> - Cleanup stale commit message.
>> - Add missing space in `if` statement.
>> - Fix typo s/incase/in case/.
>
> Thanks, I think this addresses all of the comments I had on previous
> versions.
>

Thanks for your review!
- Karthik

--0000000000001196930626caf5b3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d5424b10582ff3a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jMG81RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0VlQy8wUjVKV3k3bGNjazA2bDR3aEtEQ2UrakgzVwpHckdtMHhSWHNs
QXFWSjFHZjJNK3ZJTWMrVzQvS3Y0T1FnVUdSbUJZTlY0WjNOUnF4NkFHZVQ3NHZsZ0JQWTlxCnhj
d0J3WjE1Q1JPbDdqaVlDSVdYRDdyZGZaa2N0REUwa3gwQUpxWHFxajVxL3hGemtSNnpsb2xIT3Bi
WkdGTkoKa1ZIU2pnRk03TjYxWFJBUThsb0R6Qk9LeXlEeUJrK2syNGVqM1FVRkVLSFpEZFpZZFdq
VHpFQUtzRTd4UGNaSwpOeW1LUmUwejNKcVByamJjNlZ0TUw4YXc0SWgyMFhGU0J1NTFiTjlHcDBV
cUszdTJGYjlGdGpRS3pLR2cwR3ZICkxTenlnTjd3ZUZQYm9VTGdYd0tvdGRSYnpVQ25ad0RzcE8w
aXV6ZjBjNS92VFhIZkFKYzFsQ25ZUDdENHRRd3AKYlNRbjFDTnJzTldpR09yRHBVYmhEOXl1RzFz
UkRXS3BHV1pLYWVxNjQydXRKaFJONTR1NmdKSXJpSDg1WHJYcgpkYTFtdy9jQUpnMm5HdUhnRXY3
RTBGVUF3QXpNTER6ZUFMM0hJUXhyanpzOGtnOHJoSDUrRTg4WExDS2tvcE9yCmhyVjFWY2pwN1d6
bkNPUDFSVk9TQldrZ2FGMlp5MlRCeHI2N2ZVdz0KPTNKWWoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001196930626caf5b3--
