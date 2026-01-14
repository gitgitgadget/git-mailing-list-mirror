Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45819C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420492; cv=none; b=rgoCH5VgRcSgFZ3areP0JIvWv4eEL8hyD+w0/Ipj4sBjl5+R44gYJnNmpbmp3hOr+/Kx3Kvto3gyRE2oO2+ZRewQKn4lE4Ithg6+OENut18qUSVSQc/1/mw/JE/53CqqGDAyywgsSN9y+tIs2ClTBonRHNHFPkbSyb0UnkxrInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420492; c=relaxed/simple;
	bh=D8f/VHM1ZwDm/RovMxmBAJEqiKr7kQmKzpkMty/gDlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8lPh3YW1k2khY1J9+Qgox9bJes9MD722rgUwekAvQ1of45G+HVNBl+dUJWnmt9O/Q/GCoVX2+EQkUvPJ7zTIq24bXtqW4iCTQsBGW6sawe3TuQfh+ZfppKXhfWLJzLlvv3CVURKUQtX9v27w7rnol89mn8fgIEuB5D6nbuErws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=C4OO2K5X; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="C4OO2K5X"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64661975669so88728d50.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420490; x=1769025290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ89jV2Jg0Zfhl75VfxPwUzzU9NEdKFbMRb3At/2iWQ=;
        b=C4OO2K5X3J85Po673EhqFWQDvYIA2qesx7/Caw44sI0N/RG4KinK5gzu212bwz/FAq
         K0wMTSfl2m1JADTfKsz+frEBmMPKHdeEgW1ZaAQm/O4QT8FKNPXY/4AwlGK1DK7wkFIL
         Xdoql1l24nw1gPg6QipuugotHaS+UzpACqDgofWSfN7aSrh8Rj/ZrzT+/RbJrZjYQIdP
         A0wqu+nO6eGkbLJxJufgdMvueZSSD6FLQeW6HswHc8dwTE6/OzNfYtF+14DwmJuQm2oR
         WeaMJNNMPpLS4T/OsQxFt3rH2A1HSQPfQSUORth4IT/Vwcb+gVGzHLsZIX84BYGQoIM/
         utwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420490; x=1769025290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ89jV2Jg0Zfhl75VfxPwUzzU9NEdKFbMRb3At/2iWQ=;
        b=OWLH3DYyFTsdhxQRtrsFg6UzddktB55MIiZaeBlaIgyaTjWpoK7zOMLiywevJgcU8J
         mXNezpTVH9GgcGlxpgYgmWq4caPCINDtu96Lk8fGrKtl4cm5RtvezglVuZn3eXc70bM2
         tMayjUIYy5bntLpfM7vA8zH/4q07PBZlTi94eESW0Kowl7C+5B0AwB0vj6UXT+SCPvoy
         8YRsxpIV5dMqKYtV9LNh2EGpElkmXA9pgeMNrWodIreqMHL4y7PytRpF+BLBHNKY0TdG
         qaQReEKU2Kyk+HGVHJLdgFlcHap2mRBUANed1aK0w/MyfmZWcSMqQ7pXlFsxOYNJBnfQ
         oiow==
X-Gm-Message-State: AOJu0Yxf7l4JjiJBawFapHD8dsi1yWZHXZzP+Mmv7LYG21sUoych5WEA
	H0V5oO8p7wyjLpPvRoDjcZH6qzsgdcxsXTpL0izBIKftOvyYrTys9mC0l1qqG9B05ppnS5yEhV9
	6VclG7yWMLw==
X-Gm-Gg: AY/fxX7FtwsGQvMO6LFA+aa4CUcqOei9DTgAdQLwHW4De17otGgMa7Qbj5Ey1d4kmEb
	XF6ZIi4I3rdO7fTysGL0gADZJ7pQfsxVqicOQd79i7koLJytIkNDVqX/c7Y3s+sdRbCqbzl395d
	5tTBcEPoX1zJNsKPFj/9vf5nHMVN8c69IlOI4lfUvDboECxfboLPXnBsbtSr1l+WVtnDw2lL0tn
	zaDPBAZVdBoB6OxyCJwTaWXxXDtrdy0JJNR1QPvX6RtLcQOR5cx8SfEoiqU3rdKQA+TC9mozQuD
	ALTDZgJ7fMBpkuj0Sr5/NU4TrnMwxaT213m0z1lCVer80us7eSq09G8B/8pcZfjB0bHOyuYipXO
	gKv/Fo8/bbLZ9dsJRzdcjuY9ksc/gy1jQY6NavriBj/5MCLmuTIaJmnpVFhGb1gKLfiPkLC96fG
	vMe6pDOnZswe8xZ0TdCYV0DbO7hEE/r9KsRW/l/m7IYQ8TI89HbuHrMBSVGA4jGLptXdaLysxPP
	x9qATy9YxLcRcIJOg==
X-Received: by 2002:a05:690e:e8b:b0:63f:b410:e93 with SMTP id 956f58d0204a3-64901ad0f2emr3139900d50.42.1768420490342;
        Wed, 14 Jan 2026 11:54:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a3969sm94057147b3.43.2026.01.14.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:50 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

A future commit will want to add two 32-bit unsigned values together
while checking for overflow. Introduce a variant of the u64_add()
function for operating on 32-bit inputs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git-compat-util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b0673d1a450..db62a6f25c5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -641,6 +641,14 @@ static inline int cast_size_t_to_int(size_t a)
 	return (int)a;
 }
 
+static inline uint32_t u32_add(uint32_t a, uint32_t b)
+{
+	if (unsigned_add_overflows(a, b))
+		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a + b;
+}
+
 static inline uint64_t u64_mult(uint64_t a, uint64_t b)
 {
 	if (unsigned_mult_overflows(a, b))
-- 
2.52.0.457.gb599f1ad4b0

