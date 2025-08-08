Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB91BFE00
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635261; cv=none; b=gnUT0uDrmA7oP38nRgfuKjDt88W/k1ZwqUW66idpd30e7D3XHKaJWZALZR6mKDGWxiTxTESRsICu77eBsTzVKL90ARtfvIDzXqp/XMry7DNgISs0PJQ5YPq4CHgWVWXOcBr4qcByoTWQ34JHOSDz4uPbZtQbmffpsrsnUcCoa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635261; c=relaxed/simple;
	bh=zU44n4uhQEZx1NSqVmqmxDYuggn5Ta6UAp3Y88gKKDo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NF325AybjdhiKdCDSKa/fx4KdOf+dOmjW+MK1trilVmP/BZJkoCatFw/Y6jn39kwJvpp9a31ptlbcmdxXV0Cgcf3g2f2EWNb2SKpDGnB7rTB+eLu/XPveKmf1tLEa6OjVlF66AsYjmM0AALPMXfaoWgiSYtaBwlZEk2QtV2RnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2ygqZ7K; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2ygqZ7K"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so1853050b3a.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754635259; x=1755240059; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU44n4uhQEZx1NSqVmqmxDYuggn5Ta6UAp3Y88gKKDo=;
        b=H2ygqZ7KYBgYT7tR6EZLPdsmYC7OgoMLQYR3nql9cLZqE3NWNmpbMdYI/RzBb/Koq7
         l2MPr9ddtxrW3yJw1rZwX/a/rKnC4ii/5E0a7/AIntUhmVDX3+v8KiTI7VJHa+cBtZg+
         ck5Fk5HIJ6HqpLOoDwvfRQ+XHNrimMwBg/A+Ckf8V4wthMjU4+i2yrvLo2gMKniCZ5ik
         CSLiyX8/3qxCGJgUq0hi1UjBVc+SzqqRPUSFyuXu4M42FVfUO1xETVnxBoaiI9INwARz
         hDzDH634iJBfcp9Wv7Nb9voZaPjlH2Y5ZxPcE8rxn7LPYHenSHdvqO5TW1+wIYSH8Eyo
         crTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754635259; x=1755240059;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU44n4uhQEZx1NSqVmqmxDYuggn5Ta6UAp3Y88gKKDo=;
        b=OJvE2yTy2Qk2hgSc7micXF+6+VA/diUpSuxYyed2f06D4CPYGRWt4nn+lXAaY5ihsK
         KIejBxsQ3hHXXvr6xftOBC8V9iB6fyBWMh4jkmSyvzn1uHOeRR8vjBD7jKooeWuqizRe
         /rv7+LVn8Z99l2Yw5ekPyjmqZlNzPexdQS4tZYOSf+dQV6UEy6QPO3fg4b9PoZ8jixVV
         HzunhIUMh+gyfFGRjCg5MfsJ4Mv2tPaBVSOrMFrYW9S5CL2Nu+tgZdcpv1xoZijJo+IY
         EubN/VKQx7d+dUY343UHDAF/8t9eIaxDh0RMwjZKqj9Doum++gC9UdeZBN+fj/1PHqyt
         poEw==
X-Forwarded-Encrypted: i=1; AJvYcCWx8ffu6yI/e0OnOs80XFsYTM3z9ctkVo1warYi1RyXNitoV+wqURfwGB1dYoJNSd1mBAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBF1ihKa7bHzdLoGX3HXCRVP4XExcI8XLYvl7i45ZdtxxNRmH
	M00sdphp9D64rRYY+4haCsT1nZ947BeHGwYYNWTWAuv4MCQrsKV9Ur7N
X-Gm-Gg: ASbGncuqqo+51UuhXqzIH3a6eS2ZOihGGAe7uqnm5FzAMJ7MRChvDH8se/FsZCdPoBP
	ttC34DBAB7URqEpHzsdgDC34fRKPKK8C1g2OuQcMPnfYTuRjoj5loygbKQJJkoOR13rSne0DISF
	CYJcPuYnsXv6YRxAIPjiHGNbqYLO2/nLhe06Rrby0O5GetHyI+Cm0QuoA73MT5sJNNyOj9GuQtW
	zTxTDqypjmOwdcPGqcxIYS6GaPAAyouaJ5Rb4I6MF9g1BGupFPD2YdLiMAmsFFTjq3+a+Tsv+69
	NvDrNoEbJqr2CeUF7YeMrzj3CH4czAIyF5IzuUTlNqgX40557pua+j2vjmvsACQyYucBi2+Xhvo
	1ttnTm0gewhsetl/1NF8hnp2UFNHVpSY+3SRvYHkhB16Rm7g1M1895OBOsw==
X-Google-Smtp-Source: AGHT+IFPuaFYECoPPOib5pM3KMXi3vFDkpShhY/lgwaDDg6HEDU+2edMUXT69J2tS2iU8SKbs5S9ig==
X-Received: by 2002:a05:6a20:1588:b0:240:10d2:adea with SMTP id adf61e73a8af0-2405501259amr2859351637.5.1754635259369;
        Thu, 07 Aug 2025 23:40:59 -0700 (PDT)
Received: from smtpclient.apple (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c09adf8efsm11175244b3a.68.2025.08.07.23.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2025 23:40:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqa54brtve.fsf@gitster.g>
Date: Fri, 8 Aug 2025 14:40:42 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org,
 stolee@gmail.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1369D2B0-9B41-40F4-ADE1-B109F0B7B56C@gmail.com>
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
 <aJRMaYfMd3PlRtoz@pks.im> <xmqqa54brtve.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> The numbers are impressive ;-)

The bad news is that the Git versions I tested are 2.39 and 2.51, and I =
used
git commit-graph write --split to build the commit graph, which resulted =
in a
large value for filter_not_present in trace.perf.

The good news is that after rebuilding the commit-graph, I repeated the =
experiment
on HEAD and HEAD~1, and the results on HEAD were still better. Anyway, I =
will
update the experimental results in the next patch.

Thanks,
Lidong=
