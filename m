Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0919415E
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508783; cv=none; b=eZ3jKm5pDEYTD4S6NqUYFnKd5FwKFV4SP5VicPvP4qitcsZuOpXSaWWnQt0UbrHfpcfgFVJLvjpleDrMXUrQY0stFKRLOcxu88/FvUM9l2dmPtcbOhqw80kHVIJgbg+qJbAGMgVdl/S/WcisjJRFqr8r6xnCuu3oWh+zWvOVJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508783; c=relaxed/simple;
	bh=hPMn6DD0ADH4YnGuaYhRQGtOKD8bax7WYvj5uffBL1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAwbp+djyuhmn9BDx61ia16j+H4oYR0W2IgNZPL+WTJ9ktblLJeLDFowHhpWUu6Rr7pSJ7uPLqXVl+fWeMa2/zsgG2g+14LYWi21CqRnlI/K1JA/ZXZPnCumlu1T/8j7dQR8CrzaEJoRgXODzZFNQsGXm2ER1YxEWcwdcE6ENXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft+EYfh1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft+EYfh1"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f4bc408e49so13277167b3.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508780; x=1740113580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjJLRkmge/Qhg78bYF2NZXzaCqee1nKnJIaYhGxD6tU=;
        b=Ft+EYfh1zGsnxthM2zKX1soCTO3NqDiF4melKDLjVPU/E5IruYmgheo3i9wIf6PHhh
         AbWB7IxMMhJFwOZtQsI8fHr/pRu/8up4/T4RYuxvdW1BfCRt+tsGGWRG+0SPdjK/aWkr
         lxign/BB3bN6JtdZHrVrOiC6/8wmEIZJOK8Y9bLxqoGUDTGJXk7XLlsKGcwhEZ98lqm8
         wj5N2JgaxS6r8BaOS9v9dKftvo6ZJbALGmqF/5T/oB9DQTvHdBz95m/MGNr1i4bcU1k+
         ZitTmDyJpMY9BcvLWNA11vzfPgRWqEP9yvyDKKSV8WQ942fBHlZ73/8B0NndyXusj+oY
         1BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508780; x=1740113580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjJLRkmge/Qhg78bYF2NZXzaCqee1nKnJIaYhGxD6tU=;
        b=ajVAI3+ObFhAf6Kp127tdPJ1pM9J+9SHKGPUWCa8nJZXJwDPsH/7FWnPZe261b4DlE
         /abobz5RGhZfvYBGE3VEOppG601+klaBbyuW9royELegI1h/zZQwHLqGQNuSX8tUUIax
         c1SeZD4iwkNqJaBh9QSjFedDv8sD/8q63RatfZn+MtnXdgUFWfaysUD1aF++HYiZ0Ynu
         9tk7l60G3WrNH473dE+8arzKJLr71/+mKgenzNK6iwZRPbAZ77Xfq5ZIizcGgkbaO/NX
         9CGjIizqA7MYSzhmB7kiw5n5SlIkaTsTLvxG+OVpQC0LaykXlZJIw5sfq4uG4yvPO8U1
         jK9Q==
X-Gm-Message-State: AOJu0YxCKTTTVZ2P3S/YGArpQtW3pZIHq7nXjvHk7vRP/sGTXYuTHeIA
	fjmViJaOXxeJT/7HYT6dfTaHnqmzaPU1RIGyiHqEgcUeAa04RNwPSgxwKrZw
X-Gm-Gg: ASbGncuWhTSWrNP/rrXA1zHl/80gQiASyK5TdpfPH928wNGbaOwasA+EFacKEVDy01i
	zSNW32VNIb9b5qdVv1ajop9yk7ytRMa7P3LM2HHUBSRB7nen6vwea/93O7x8tdrfg3QQfNqRmxk
	r7gZoW4sppRBbmtsdulECFlnzeR5z0HDkAc2SPbZUQEm8FakaZV6FTOohrFduZNp/89OdRqSGQq
	bv6BMX/BmqItHAR89f1PMYr7ydZ6Hq1nA8W0l7k+Vi1Dm59HGSvRHPGxaB1y2Rkbjtd2A==
X-Google-Smtp-Source: AGHT+IHbIBbEXSY0CNUzb+xrCaPBcUk2v9WSsPC+1QPxl5RqecVVdKTjzhe9UIcWhCiYJVdajzALQw==
X-Received: by 2002:a05:690c:6988:b0:6f6:cad6:6b5a with SMTP id 00721157ae682-6fb1f19ba28mr122491737b3.13.1739508779883;
        Thu, 13 Feb 2025 20:52:59 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb35d58720sm6229387b3.22.2025.02.13.20.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:52:58 -0800 (PST)
Date: Fri, 14 Feb 2025 12:52:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 5/8] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z67MJjI9coLnyi3a@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

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
index ff74ab915e..692e315e41 100644
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

