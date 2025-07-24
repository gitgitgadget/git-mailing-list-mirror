Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54F27467B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344902; cv=none; b=rLwXhMyVHD0ErSPY3YfYFSuS33XHCCufINZYDIf2BkdX+4JQ5lhgc4axKeq0KgKkgASlb6pvzzn+rf6k6w9UhLUjL2fXAyHIFZaHZ8wezpeXxMYu/BuqvCcmkq2DtePPGSDke1YMggCHhOgloZt76RbGTwmm39xi6esasBE3tIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344902; c=relaxed/simple;
	bh=UNqHU7RSHD+xDYFcXjvmrbSGdTWwsLFiqzs0bVhmxCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kumWCsa1qlrnLrw/aKtYWKeRJpIp97/LXVFAGDp0ZjEX91zmq+QoaMwM1/8WovymaSIsgzAaMzndvKHD4DISQg27U38DZEW7FnyTpJ65MZQaabZEm2gXneNmAMCO324P21SLyNAEirCeswHXZECUK2/QogvQYsjZArny1tjDaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czqUKoVj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czqUKoVj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso4422215e9.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344899; x=1753949699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cs7v0jlqOf/8cPRn9ZQw1ifYbHnPycbQj/SNf9Q2Ros=;
        b=czqUKoVjj+vWH3HGOWtyQlJ0TfPatwXFqIWis5dJ1wWDTmLi5Y/eFdFPka0uWtjZUY
         spRpJcEbjPtJ4W5p7iegxnslIrVukPF11Lit1Ma3+QfJDGuVegbare9+ZVvpR2Bcr5a5
         Yh8Q3XbKEFMP+JfoXA5FcoegkWDdFigGRc0fQbFDYNPLkOMIYVS3MHxvEdRXheG9BWuk
         PlYoBZjr8iu/L8W9UhLw44ZEP8WUdYDvxnPppy2D2ISmPFENH51PeHJ6QEcH2tcq5hS8
         SS0JhfI8Rnm5KMHJuGVhFz00tFvxr6cO8kacP+gJsdt0Lb4tgUI8vwJO1fR3LWNQHueZ
         +r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344899; x=1753949699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs7v0jlqOf/8cPRn9ZQw1ifYbHnPycbQj/SNf9Q2Ros=;
        b=T72hZxX5TYQiXHgEuKvcjElc91b4w4f7jJJpS31hgTmKacK2b2EBM+H5haFy43s9Rv
         jnNCT8cpZxX8s/+gIUEvAjBXG9c7wwd6Gc6qBKo03SrpU3oluzAaQbrSb5VRUbN0lFaz
         Uqv7V3uHZVFeVdBE72fIdqFIyAykUS98T6CnF+BOj4vhmErSIIGo7DGfaHaWySCO4Llk
         rC+KlncYzYhkKwT3Pkj8Gt19e4J+yhY6W25EE//OwMg+fxNupfVr4E2gAcQW4Xc7l8XM
         w7Gfmopjopssyl7yXQZ5/RyHiF42BGxcbq3qQmKgB2EGHbhHShZ2gIra9uUD0oOF+4RC
         98jA==
X-Gm-Message-State: AOJu0Yz6iEAmP6iXcPJkwCTCCMd+GcqgczTkrqsL1CF/v/fmzRETxdg9
	v16jc8s/iEt6B/26m6I0X/WqQgUp8wyFzvL6QfKfAB3FCCSohyvDT5oP7/mzErpm
X-Gm-Gg: ASbGncsWt6U5rUJDbyZ8TyVZynLtm2tuuD9HplXQQ1Q7vo4v1A02342GrXHq74yzELi
	Sei+PojCq7xlGzKvPhE2Exh/eVht45DdocndxfsrPVNf+a7+erzh/Fyx1cLGcN0Gl3pLpstm7yr
	b/8ZO6tieFwyRAh31MnV3vWAcoa9mWX8od28GHBJGzHrY0241Qu2vT2M1Rf7KAfEvsDfWmvQNdu
	pytdNhvnboVgaim4y3l68CCPRgQPyelgaFg7jwy+Y9jdyIgTMIaqvDZzrkjr3EDFU5wcey3nn9y
	0DVPdoJTF0eTUMLm/7TXowcTtyfAbvw+BqglpTLrajrzcNY7Ik0pnauL+lUdlrxenOdMubZvCEs
	=
X-Google-Smtp-Source: AGHT+IH8+4QY5uTYryu6Kjpn88TmITd57ZythuxNoyebjdi173wVGQrAiVx//HCY0hXMZOYMSwaUjQ==
X-Received: by 2002:a05:600c:64ce:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-458709d0f11mr6930325e9.20.1753344898890;
        Thu, 24 Jul 2025 01:14:58 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 10:14:46 +0200
Subject: [PATCH 5/5] ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX instead
 of '1'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-kn-small-cleanups-v1-5-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=UNqHU7RSHD+xDYFcXjvmrbSGdTWwsLFiqzs0bVhmxCE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB636rR31e6YqCnwuXva4LuSgkzJyA4ySNQ
 ciajbsdXf085YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget+AAoJED7VnySO
 Rox/Fa8MAJosEKUqEEmQUVLdpzq4ANHjwBVpCKJ/3ccr6Ow4q1wHsOs1muTlrh2if0yXYe8UW30
 dPZOdJpejehaQuAeey1UuYVfHDtO5c6Zy3EfZAGj3JDMy/8J08eJTdd1QEh0rQKUt/fwOYdwrxZ
 W6Vw39BRhUiXJXpqsVlw+WfOwLSwqIr4PmVNIEutSGg8dRdnojh4vcM2ZGRiE15vSBAcbIzodeL
 fgD+kzfA660nbKIbSq+SCqyiYkoNbbG/qkj2QmMZ5jz/sKBeOEV0YI77ARo85kC/J6yjZhaCi2i
 gfNxj6GxWwf7vm8hWvrxl+nd9qyYxpTz4KxCzUAupX82Ho5ZVJpLnfgstZDUlUa16LZXKBh52Cr
 7yQyTKR8LrFEIQY9z80c69oRWrT9ooo34EP4b2I1TLxfiOVSYvuGoNzUYbvCAqlYTl4p9ShBtn0
 8397KJ1m+xUUF6h7g+QhatNHsVkVnLEEPsoX+BfL7xYgHLHi52O0Q4HYENIBsGe/8ZZV5QTdul5
 Hg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the commit 51511d68f4 (for-each-ref: introduce a '--start-after'
option, 2025-07-15), for introducing the '--start-after' flag, the
`ref_iterator_seek()` was modified to also accept a flag. This was to
allow the function to also set the prefix when
'REF_ITERATOR_SEEK_SET_PREFIX' was set.

In `do_filter_refs()` instead of passing the flag, we pass in '1' which
is the value of the flag. While this works, this is definitely hard to
read and introduces inconsistency. Change it to use the flag.

While here, remove the unnecessary 'if (prefix)' clause in the 'else'
statement, since the block already checks for 'prefix'.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d5a146de87..4edf0df4cc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3254,8 +3254,9 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 
 		if (filter->start_after)
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else if (prefix)
-			ret = ref_iterator_seek(iter, prefix, 1);
+		else
+			ret = ref_iterator_seek(iter, prefix,
+						REF_ITERATOR_SEEK_SET_PREFIX);
 
 		if (!ret)
 			ret = do_for_each_ref_iterator(iter, fn, cb_data);

-- 
2.49.0

