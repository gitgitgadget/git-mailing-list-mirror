Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616D270EA1
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672412; cv=none; b=ANrJyXd7SMESgakkUFEWt3OmgQkNBhBz8uM9rbg5hrk84KltBhJvv8DqLzkdbr6v+//MGg0I4BAANjA3zCtCyz2Z9F5TIXzwyq8JVI7mJdbDZyxmoX1xegu8rhSykFjaKlyIQF8hWkZRmTSJ7bINave5I1MECqfMPcuQ6b3XWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672412; c=relaxed/simple;
	bh=QekR0961pvX6HFiFDJDKS4hak/TtitFjKecH8+u5FZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7KCRHEEces/+LkzxzgaDuZMZZ4i4sDkzuC/qN8ucHN4aMqb2fRTgQITy2abgoTK9uzFNwRLktdgVCrWeLg6o8GuMgV8W+PhnP2xyxfqheXPCZ64ux+r7Qf6PLJtaFbmQAzLqrLUzXzo+F7iNxQZBEqx9bv8Zfab+1oempRBG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlYi6f3Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlYi6f3Y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22185cddbffso40149515ad.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672410; x=1741277210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AP9SIJdhrfnUTGwoJ7kpX9ICLYFNcNWpeaQbuHw9fcA=;
        b=TlYi6f3Y3SZuymr+Q7KUgv8wJzkPeCm4HhjKVIv0GMqprYVYMvQpyc9KlermQDe0bj
         BsWFZhUNpW6pvv6OjcHVlHBmlwj5Oo3/Ir7yhussZBJz7SSN8Lt5GeUGFwnJL3TZTbHw
         7Dj/VtHEIXLeW0a0KiVwTMu3nT9MkU2N+L7gN5Ap2DObZEkM7GdjcNNW01LhhFnQhihn
         2ByHY0Ljvi+ka0iHlfm0FoK1AG9ygcNq5wGkoPBmkVynPCZ3+Izf9KHdWLl7X48xL1l4
         gJfJPt3jEnlNkTtK9pwZ5+3tbDLVYvPOX297eg/POZMltSoJi3viOMQhLV5Mib6S3Jvz
         rdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672410; x=1741277210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP9SIJdhrfnUTGwoJ7kpX9ICLYFNcNWpeaQbuHw9fcA=;
        b=JeRUK+b870EzSBIS5FB4Y3b2tnwCA3bY2Etdt5i/a0faCZSGr2D3Ow/+w1EVx24i1g
         +uKDPZxcTvaOnT2LL5HxlTe8krhaTMMGclif8cGmbVKZcHB1Lb7OA/Pc0ig8pLUNvGca
         +iL5EMVjhpHWE76lh93LvSY0Vj9aMiwsIfrzV1i6pxNcfKHiFg5y54r5zTPi2HjNHAXY
         jFDbf1F57Cuzolgs58YVqScznh4qEQifCRUKJSPCLvzM6yUO/sTWw52QZEiaUPGfFzUd
         dXh83WtGDfQ5n5X1bxcXiY1NRPVXB0giy1PGvdAMQuruZiJY+7iqlJmrQmbl4xn+Goab
         9/fw==
X-Gm-Message-State: AOJu0Yw8aF0xRDKag9VEpLxiMdwoUiIcD39mf1GtyYEZglpFWyYPJk9Y
	OQ+SODVc55QcyeWwwz/7FYIwUhdZyJFM7sah0OKP7dIYhjr4x08AZP1qmg==
X-Gm-Gg: ASbGncvSGFjDWOXoOOkxu8ATgarHZmgOC3l8h3zvdupdzPccd+DU7PaxEPtvf+Ywunc
	Q3MGMmrEG5ay1t8YHCx0NF9pqgPp5u28Yv/bhFitRJGYp2ivduWFcQj66arXp340nW3JgtvuAo2
	tkEkcl11vY05dpkW2hdNc1JjqYsB0HfnCMGTC1R7FKJucq9Xviqbi1x2wZLz69kRE/j4JtT0mRL
	fWFTXddbSoU/PLVTvz2p2CfQsnjL/Rc5JVdvfchiPHSf+DM/ndRYxrIP9o3Pyt3TmMD7fy+QYaX
	N2pmzGFydqJ3Srrep1P7vQ==
X-Google-Smtp-Source: AGHT+IEX0LJDHzD2pBfK0GKiEgmP9JzgnDujr2x/Gm6hJF0nyqurSp3ukN3FjXoPwbxopO5b4hqxXw==
X-Received: by 2002:a05:6a00:4f85:b0:734:a78:2f36 with SMTP id d2e1a72fcca58-7349d2a6a7bmr6534108b3a.12.1740672410070;
        Thu, 27 Feb 2025 08:06:50 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe2b89csm1798159b3a.5.2025.02.27.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:06:49 -0800 (PST)
Date: Fri, 28 Feb 2025 00:07:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 6/9] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z8CNpE0FdCLwaSpU@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

"packed-backend.c::next_record" will use "check_refname_format" to check
the consistency of the refname. If it is not OK, the program will die.
However, it is reported in [1], we cannot catch some corruption. But we
already have the code path and we must miss out something.

We use the following code to get the refname:

    strbuf_add(&iter->refname_buf, p, eol - p);
    iter->base.refname = iter->refname_buf.buf

In the above code, `p` is the start pointer of the refname and `eol` is
the next newline pointer. We calculate the length of the refname by
subtracting the two pointers. Then we add the memory range between `p`
and `eol` to get the refname.

However, if there are some NUL characters in the memory range between `p`
and `eol`, we will see the refname as a valid ref name as long as the
memory range between `p` and first occurred NUL character is valid.

In order to catch above corruption, create a new function
"refname_contains_nul" by searching the first NUL character. If it is
not at the end of the string, there must be some NUL characters in the
refname.

Use this function in "next_record" function to die the program if
"refname_contains_nul" returns true.

[1] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/

Reported-by: R. Diez <rdiez-temp3@rd10.de>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07154bccae..9a90c52f70 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -494,6 +494,21 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+/*
+ * When parsing the "packed-refs" file, we will parse it line by line.
+ * Because we know the start pointer of the refname and the next
+ * newline pointer, we could calculate the length of the refname by
+ * subtracting the two pointers. However, there is a corner case where
+ * the refname contains corrupted embedded NUL characters. And
+ * `check_refname_format()` will not catch this when the truncated
+ * refname is still a valid refname. To prevent this, we need to check
+ * whether the refname contains the NUL characters.
+ */
+static int refname_contains_nul(struct strbuf *refname)
+{
+	return !!memchr(refname->buf, '\0', refname->len);
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -895,6 +910,9 @@ static int next_record(struct packed_ref_iterator *iter)
 	strbuf_add(&iter->refname_buf, p, eol - p);
 	iter->base.refname = iter->refname_buf.buf;
 
+	if (refname_contains_nul(&iter->refname_buf))
+		die("packed refname contains embedded NULL: %s", iter->base.refname);
+
 	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
-- 
2.48.1

