Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC81F60A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821458; cv=none; b=KfUC6Yz+vVkfGIME0N3FIRoSTR+EkGrF85wt087KjhoURTEbersBfTFlY9VtA3nsFSa1YMWydvX+jV2dBoyLEg313yf8IWmjt8gigSez0f/3hRBbNuApau7fchR4PzglonFWqNABdnGgnQOQnIqGoNfDTK4hNtg3xzml/3/YhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821458; c=relaxed/simple;
	bh=7+T55XJ8OYWOOEzXj7D1Ghh3F5Qp2lX+rsOa0qUNJZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuOLArWIkDXfTu8Y4mYON2IZBte+4K/+fLgvZci43wSHRUfdEFXQSAHU3/Y2qutPHwGWO33wYX3BpiOl/heW12NbYi4+bnganNMo0RiUYwO0aEaTWmoWNmg8xawYGRQFulD1lU2i9ZmQgtG8ZZJ+ppQ97Sc1Mob+Vh4ob20Wnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlQYSbcE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlQYSbcE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9e415fa42so865525a91.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821455; x=1739426255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIaRyQxKZ5Dr/nA1G+kAaUr/gDDbTIE36CuAYz0P/cY=;
        b=TlQYSbcEeoFidUgwkc7PTRz0pR3ZN2TAkNBncv/xU7JKPcABK5T6h/FuyM16TAUH9o
         cE/kKTydvyritV4JOq8gl9LP3H0SBPRtXDhqRlwVMmjSuQ19gM+91HTeaK+MdlTVHVmj
         M/oksjuIykfoyTAAvGvD6becFhPo9bK9/ofirE2AcVUS0NCZlRrWebXyYrpoRkt4d3On
         NAizEYusUmgqYyhZYfoIaafkO7zrdqU6/XF7V2np2Bnc2OWrmIWbrYF3JATKgTvO7uCs
         jJIS/YFds7Fl3BAvjSYrqscnvrEVQ6i7kiw4W+HIMfgl4xMVwcu1I36WwP/zGGvZm11U
         369Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821455; x=1739426255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIaRyQxKZ5Dr/nA1G+kAaUr/gDDbTIE36CuAYz0P/cY=;
        b=IEF63tMEzTSBGdKwu073s5ObjIq9F/PZWPQL/klUQPb9cfwkOlz/pWvgrbfA0XZ342
         Isb4/SkAfXX1Pwszjcm88nZnd/8KWnP7ECfoNmJRqdVmuryDab8tFU8ZpHtcX4d7OD5R
         zlJ4m3fpUMR0tv726VjsiJIS2r4LgAafIxiYEsEYnbBcRBRyN3qJxtGY09UyqmFZwv3f
         39/NKOxregNIpOL/iS4DcODKDSsInhmXWHKOHp857L9N/BQ/yl8axMKugZAH4MDjWpNM
         ORuV/Ghy8jrSIH1JKLNaht1EtBV58EdBbjHKmV8Lagdb9aDKb8JnLKa6Hl8i8KIpkfpU
         hSeg==
X-Gm-Message-State: AOJu0YyZ+gJP4bj8d+E/F5BEZmtqPArw2z4+pRCsizb9fi+WNAlrppDy
	kNPErkM40AuKlLCvLRcqZloM+LDr6vnLZV/Pl2RcYnBi11LIx4EhXBfK0g==
X-Gm-Gg: ASbGncvxvXFhlr6c2Avas9EHknPgFPDrroYOBHpryLIidwWmT1wwfvhV5v05T9Y1d2B
	94yHOMfKHIll5EprSt2dJRaeE4Ur5B4/c0267n003UbI+JT7ED5a0rXWY+ZLAgXU53E0os1lwRw
	8/Jolx83VXJu/aY6x9Ttx+CPDO/0nCpWjKpN3EAHTJcQvgm09jHVi9MNJyuH3tOYpx4ujK5hZwY
	WG+oz8FbYnAAh1lD/JB9fR8OFCM6MkwYfZIB6pGmg/pJh4ek83dNVEpJPBpVSfqu70aKQ==
X-Google-Smtp-Source: AGHT+IHJV/3GlsONFT2vQ84TXkr2Ll1bfD+cRKLNXvCmZ7TN7pmHdI4j5Vzt7sTbQmjNHmCx05R93A==
X-Received: by 2002:a17:90a:d605:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-2f9e0753d07mr9152514a91.7.1738821455188;
        Wed, 05 Feb 2025 21:57:35 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f9e1e2352asm2688771a91.34.2025.02.05.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:57:34 -0800 (PST)
Date: Thu, 6 Feb 2025 13:59:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/8] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z6RPtC5KIvYnqtrh@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

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
index 683cfe78dc..c8bb93bb18 100644
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

