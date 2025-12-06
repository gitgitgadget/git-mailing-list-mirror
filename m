Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB62D73A8
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053108; cv=none; b=S/0uNffKBzXoDjn9TH/tn7OY/3dDb7i6OzNaMPSW7kjFwfzbH8mgRP+LQJmFiVj4G1G+eKTgABpNeUVsueCBXk1pbnz43ym/PsaBfeTiuRZekyUuLxbJsSQ3u8hhfffm7qlY4+qWyvG5FmmIIwImHV7/m0/uxspv9slK/vrTcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053108; c=relaxed/simple;
	bh=JOuYZczHjaZFPXDgasZR8RNIatLDPpLSXJcPAqZeTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azd1aEz+BU+BOx5A4THprxOHIlKpqqxLmpDPkCggMWwt8Y1eTGhGfHeJCIJg6HAbb1CKKlBT6dvepfJ94Irll+JNs05MispbRMid7v70onZcPvJnfGmCylZeFGU0nPf5FCt9+MiCtzJN9Nv6N5EkHj7wnSmgKCgAvfHZuYNV0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Eo23ta3n; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Eo23ta3n"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f996d4e1aso3622975d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053105; x=1765657905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sj3SQgYVtt12hOOSNV4BiWY+4ndLSqT9MorUdvFMsHU=;
        b=Eo23ta3nWItr3EiwL0Qd97xrMLdSTkWIm2ukq0MYch1vq5KFY+afZ4rE2yKdnWkJBq
         FddS+gUqvDG3tNbJvacpZ5zp6nDUgXBkufLchhBeS753AVi/2GVYe7Qin2Ijov33yz1y
         Xcswg1zoXY/ImC/qWrtMgM2ux7hp+U/ISzU7eOhf5SUqHqTlfXNgq35WbUU6zZ3k2u0t
         3pc48AC0jwnq6lNuwv2DgwMe1gl9teyBY/rl//gaermSng2peYJAvmokYpq+Y14kZxmt
         hKa0jch087k0gP0NJW9mK3LaciuJtGlOmiW+vPErLE3Yk5kHKHHXDpYTD6m8+xhMkNKP
         oDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053105; x=1765657905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj3SQgYVtt12hOOSNV4BiWY+4ndLSqT9MorUdvFMsHU=;
        b=B126arzjRVXscyEfbuj+Mb+zLfuUujcwYs14rktfmJsU02p/k591yBe7eKgdqQFEZs
         w2KsRmIEhi/2+zBAiXUoc4xy3MtUGOtc+OiD8g6KbSKD0z43CQT+8JXJoss7xi8nFMgk
         a/Pyvbrz7/DxU2NzSWfL7bcON8hulKpN8kKJ0HGTR2KEhMNWnWR5T7nWJhhLWrHK7X3n
         fzrF3K2PZGScbJXCh9W6HFXy5sikY5/aOTqoixWuOwuEbWXCywdKq78k94DapD3xLV2J
         clAKa64ujGrboBGqkIaXT0vUXJwf87ctPTklPEnolA8/sOoBkxgL82zwwm0yPBXoiNaa
         Ww6A==
X-Gm-Message-State: AOJu0Yxz9ksrivMrTE3obqiMVFLSy24fINyrdfDlLTKQ8fGv8lpBwvxq
	I939nfsZioAmUi7LnEHAd378nmiB/GbkpADzKdjK9uGULLldBd7fhK9isKTK+4/u2NljHVw4QIM
	nQjguwV8=
X-Gm-Gg: ASbGncvPm+6e3RdiwMhQSKeLlkif4NCaM8iRrquoa+FzQzlXoKg0YMZowrquQn52q4k
	T3mraeUW9dv/qbXjnME4SfyqP6soWYnZNQ++TOrm1nUT+ewZv/D3IXTrxGSusoolNvXuieYKfgY
	2jF4npYdhhk+IK6kQRwHmkkwk2uHSFUeA0nwFdgM01cTLxo+Q8RTmxzc+vLXyQkr6xHs6bx4Cq9
	2wsljMaS0Izj9QdHZtkmjQ232EMrfLdX4QY3DJFs6sz1kP6TVgT0ND+xc55txcac7znSG/bZFLO
	SrBXlsw0G5S+LQOnZ8Ev6sNYryBvjgWfS1XUeVGA55mVoNtFnLg0bDerXSwqEgEa32v6du14qTP
	coaVflpFgdsi+n04XE6NTQ6pctaPtgxSYtA5cPBn+cqkNXxuJIIMhGca2h2TX+rZ66zVg4yU0oc
	ynFa4ZM+KteDiWg2M8ppPHa3nYmBbAI386fPWSDZSs3Wxkg63EDXys9Ff62Vgdfe/r1qzp+eeuD
	7io/1B72gdfDLl2Sw==
X-Google-Smtp-Source: AGHT+IEBlF9QjClWFU+pNTgtKWuVlEFj1QnBjVh7Ur9BuU7y3/QCNbZOQz8OMjFUhem1fOWf7AJFjg==
X-Received: by 2002:a05:690e:13c1:b0:63f:ce86:8b81 with SMTP id 956f58d0204a3-6444e76d06bmr2207359d50.18.1765053104795;
        Sat, 06 Dec 2025 12:31:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5a3e81sm3388280d50.16.2025.12.06.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:44 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 15/17] t/helper/test-read-midx.c: plug memory leak when
 selecting layer
Message-ID: <43ef3d0013f1534c7ff8b1a7c4a17fb0c9b68684.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

Though our 'read-midx' test tool is capable of printing information
about a single MIDX layer identified by its checksum, no caller in our
test suite exercises this path.

Unfortunately, there is a memory leak lurking in this (currently) unused
path that would otherwise be exposed by the following commit.

This occurs when providing a MIDX layer checksum other than the tip. As
we walk over the MIDX chain trying to find the matching layer, we drop
our reference to the top-most MIDX layer. Thus, our call to
'close_midx()' later on leaks memory between the top-most MIDX layer and
the MIDX layer immediately following the specified one.

Plug this leak by holding a reference to the tip of the MIDX chain, and
ensure that we call `close_midx()` before terminating the test tool.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index dee603b3cd0..6e03aabca79 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -26,9 +26,10 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 			  int show_objects)
 {
 	uint32_t i;
-	struct multi_pack_index *m;
+	struct multi_pack_index *m, *tip;
+	int ret = 0;
 
-	m = setup_midx(object_dir);
+	m = tip = setup_midx(object_dir);
 
 	if (!m)
 		return 1;
@@ -36,8 +37,11 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	if (checksum) {
 		while (m && strcmp(get_midx_checksum(m), checksum))
 			m = m->base_midx;
-		if (!m)
-			return 1;
+		if (!m) {
+			ret = error(_("could not find MIDX with checksum %s"),
+				    checksum);
+			goto out;
+		}
 	}
 
 	printf("header: %08x %d %d %d %d\n",
@@ -82,9 +86,10 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		}
 	}
 
-	close_midx(m);
+out:
+	close_midx(tip);
 
-	return 0;
+	return ret;
 }
 
 static int read_midx_checksum(const char *object_dir)
-- 
2.52.0.171.gd6a4e6b6955

