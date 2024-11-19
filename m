Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BC1D0F5C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047428; cv=none; b=Izck3arQYGkAOh1lttur72/1spYdhyVGQU7BmFeAz9VEmS8Ov44Q3ZgERsrNJZoWmdMPXKq+FACaPd0+pKi+sh2u6bCJ3iOl4tuhxI+9uxYFzdApoEchT9wEWdNkTrOhhgZw0PVjiBNo/PB6aBhQpQBvmDYLm4ffn0K9VgiAMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047428; c=relaxed/simple;
	bh=xKbJOi5glpk7bPFZ1IY/Gt8IX5g6QtnF2K1OZNQsROk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Z249p92RqZdj86CS+0b9OSUMbbCdYFrUBYw1DeKkTkrfX/h/va8yzZ2JV6ZMwFbPghMeKTu1CpfINMT6cHNn069tIUBznO7T8kn0N5xkG2lHIMirZtt3bLWErvJTFvGIKU494rlAbHRlnjcBHrInU5gaXxLhNa861zhWKA1bXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=GzRgxdqx; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="GzRgxdqx"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e60825aa26so1969126b6e.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1732047425; x=1732652225; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKbJOi5glpk7bPFZ1IY/Gt8IX5g6QtnF2K1OZNQsROk=;
        b=GzRgxdqxwVHSvIYU7gGiYqOdKuLpIjqpVKEIjvdMcehfqjv4zG8K4R5RfsO+Cw9HVg
         02NZLplsub8+ci2bkTTcmE/9PwlwEFpu2OHb4T7FtplVpBmeGqYbBLFv3mqow4E9U2eI
         JpLEO5gcCbzFyjPlxD58xI52LZP2qtEhnwJSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047425; x=1732652225;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKbJOi5glpk7bPFZ1IY/Gt8IX5g6QtnF2K1OZNQsROk=;
        b=nES/zymysIWDvx+jc0KyPirgnw46mSjPxbTvfrnqJrBJxJB/Z+qi0/++YP4NjzKiHu
         94NF1R0DaLVMTTPf2q9L67HCxOBlqCge6TBDwv7KBJvoFT7e02taoHNyZ5B/Vo3VwxKv
         u1cqwxWPnXXgZj8jVInmFejGwr1VcxNeT9FuWH1S+33uYcRmdi+yA+R5cgREKAZXGoHS
         suUbbt2/m92OUDYBTzk0k8Z8lr5Nh6a+KF0KAB9MntkWmyvyEUt52/lqyLoxwFrVKcL1
         y9DBLaGJ6eXi72ZbH897bblzhUpX4nqdiINxCvlhLSILVHU1s+7aC06HYo6MYIiuquJW
         o+2g==
X-Gm-Message-State: AOJu0YyIkb6ExJ74fKmdGl9S5+YRFcbVI4ihF7FCR9Io+uUilBgXMXa1
	2Pr2nfofESP3hoApV4W3Fnsxh4PEm3QVFydAu7uJ1pJnXFdpA2rQGqxLNIHN+Rn7V9wKOpOJOP5
	LIOUwfNe3uCGWBHMdFwyelhKlG/bU3hftVTQF2GyPtVuxfv2lnG0NWTD9cg2oNuOO6PdqDLp5Rc
	TRddMKrrz/VLxul/bBlsCFdoyiX5Tq+7yVSKaeqz6+BQ==
X-Google-Smtp-Source: AGHT+IHM1l+LgPwHMODIzuhop0nodSNtgvHA6ZiuSKW3T1mgJCJoFdYe5X1ZPGvR8zbutObzzBv9iQ==
X-Received: by 2002:a05:6808:2023:b0:3e6:3860:596b with SMTP id 5614622812f47-3e7eb6b83d8mr136176b6e.8.1732047425213;
        Tue, 19 Nov 2024 12:17:05 -0800 (PST)
Received: from smtpclient.apple ([45.78.96.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812abdasm67106d6.75.2024.11.19.12.17.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2024 12:17:04 -0800 (PST)
From: Burke Libbey <burke.libbey@shopify.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: git-blame extremely slow in partial clones due to serial object
 fetching
Message-Id: <B010051F-B182-4DB8-9469-AA2F53781968@shopify.com>
Date: Tue, 19 Nov 2024 15:16:53 -0500
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)

When running git-blame in a partial clone (--filter=3Dblob:none), it =
fetches
missing blob objects one at a time. This can result in thousands of =
serial fetch
operations, making blame extremely slow, regardless of network latency.

For example, in one large repository, blaming a single large file =
required=20
fetching about 6500 objects. Each fetch requiring a round-trip means =
this=20
operation would have taken something on the order of an hour to =
complete.

The core issue appears to be in fill_origin_blob(), which is called
individually for each blob needed during the blame process. While the =
blame
algorithm does need blob contents to make detailed line-matching =
decisions,
it seems like we don't necessarily need the contents just to determine =
which=20
blobs we'llexamine.

It seems like this could be optimized by batch-fetching the needed =
objects
upfront, rather than fetching them one at a time. This would convert =
O(n)
round-trips into a small number of batch fetches.

Reproduction:
1. Create a partial clone with --filter=3Dblob:none
2. Run git blame on a file with significant history
3. Observe serial fetching of objects in the trace output

Let me know if you need any additional information to investigate this =
issue.

=E2=80=94burke=
