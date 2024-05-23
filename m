Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED91129E94
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499626; cv=none; b=YYHygSatmCF3Q99mz9C170+pOqn6Wt53FNRwKEMEThlDdZbtJneaYml7P35YfjI5wB/EUmXcJOvlWEd3EQLmp/C6PfzgMrBFd1tTgvBeqK/ReDucekZJxTu8Wh7ENm/bqpaCBg28/iK0IfIjYluVDHMpWAleM0sVJCLyCa9OC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499626; c=relaxed/simple;
	bh=yJz/yrRHcrAYTwawq9EKRwgOKtLZ5QwIzWxAfUy7Xdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clm7JjDl1yyIGkr1Otb2jiJDNwzCE/Ob9orR1XSRVXsWmW0Yrrvba4QKdJf2jvj8OZjlu4+X7SRlcs+5NwbaCwpqAs40vnbRFoHYT3pZ79MHPidSOEY1/nAOOhJZq+UwErMsGgmb9pnm4jOfHdqJAQKVgYmn3yTqPZ90uqodgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iu89s6kp; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iu89s6kp"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80324bcb9ebso523209241.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499623; x=1717104423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRM/0EiABz5NflFNmv+/dFJedOOt5/SGfFG7VeoWWU0=;
        b=iu89s6kpjWOFviNbKaRRJCkhfa1qyZ0UZ+gF1g93w24rnvn+Yo257XYciJZYEB6EX5
         Ssz/ie7Hbt8KfgGvToAAK+rIZ1Fh093uKSIEVSXLAmTU6J2gduzYCrupeMQtVE+OfC4Z
         wfkGb5SpUtRpcH82lYtC6L1MeYvyaOVhU2Ycogwi9UC3mZeDpiIujIXbCzaaCE1Z8YQG
         EbDqWPpkQEDIpJxSAqpxDz/Ji5cZMaCh8BGrr0bKbXP9y2AS1afUcEFQCw0ZzH80Hpww
         jPfVlnmPgNhm1HXIRfdAU7xcTu8F5oPHexUfG7q0RvYANglZpzDFOEEx459I8JJ+pXfF
         HBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499623; x=1717104423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRM/0EiABz5NflFNmv+/dFJedOOt5/SGfFG7VeoWWU0=;
        b=fHlOVXJwh+fVSs74LGZUBpDgAF3saht8ftLrXfd65O96y+NR9oVNH7HrDMvFtgz8FY
         NKvhKM32q8mbSfRpNIAaFMPmHh/bsD01oPEb9h17j3wJ1LHuHWeS5eR70x3NJ2yFbbOQ
         dUfAvUzDRZWua1lBKvyvuz4wHVKFe7zxAqEpBW44zrt1Vn8/RK1Guvfd7vgdQ+gxIj+K
         nDYPkqKcQu7u0ReLpcNsrRTUCQ7oPNk4BKNMtM5lDLvbe1SGc8/Exxf0Mg8Sedki7hll
         crgyIlv0rEAI5wJ1qBzbCc4f+By+KyTYX9dTkYfOQZ2TkyE821ajMSeVdoJ7PRqLugTw
         ZNLQ==
X-Gm-Message-State: AOJu0YyYSOzK+oq70GxtP4EzzTqhZQCne0GXjFxbLcPfw5JiJzoqtNy2
	jAseK+Nu0pyqUtKBBYNDt23mp925iTvCOeUZa01zckiBv/XCpb32sCwzC8H+5S1nn3ysE+EjGcz
	f
X-Google-Smtp-Source: AGHT+IHyVMi9kO4sIlYPRLimg0knFZ0YwZWt0y/q+dZ6ZrGZdyNFEXPqIM4tTjjJU5chCS32ELaWkw==
X-Received: by 2002:a05:6102:3022:b0:48a:34b3:82 with SMTP id ada2fe7eead31-48a386e3fb1mr573727137.35.1716499623507;
        Thu, 23 May 2024 14:27:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c21f3sm522481cf.94.2024.05.23.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:03 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 17/24] ewah: implement `ewah_bitmap_popcount()`
Message-ID: <42a836fda8add1e0f26394660b88f0e2e3e635e7.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Some of the pseudo-merge test helpers (which will be introduced in the
following commit) will want to indicate the total number of commits in
or objects reachable from a pseudo-merge.

Implement a popcount() function that operates on EWAH bitmaps to quickly
determine how many bits are set in each of the respective bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 ++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d352fec54ce..dc2ca190f12 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -212,6 +212,20 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t count = 0;
+
+	ewah_iterator_init(&it, self);
+
+	while (ewah_iterator_next(&word, &it))
+		count += ewah_bit_popcount64(word);
+
+	return count;
+}
+
 int bitmap_is_empty(struct bitmap *self)
 {
 	size_t i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 2b6c4ac499c..7074a6347b7 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -195,6 +195,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);
 
 size_t bitmap_popcount(struct bitmap *self);
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self);
 int bitmap_is_empty(struct bitmap *self);
 
 #endif
-- 
2.45.1.175.gcf0316ad0e9

