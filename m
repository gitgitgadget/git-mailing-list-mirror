Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887842F6F1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946305; cv=none; b=cYdWJ/o5u3LlUd7M0XcZdvufOPomkl/QpXkw9UZ3AtgK24BwzCWWfWMebIAyLeCEE4viD9YA6/s2Q5XCAGu0ks+Y6MAHwszkcaHHrKxZEvFzqVMVS9tPRhiFxmi1sSHcihKSlJpZc3jYX6XROf9kr2VtEVcltvUaKXRcNqO8/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946305; c=relaxed/simple;
	bh=psH0hWZi3RQr7zroniOVEP7BzLEOkmfjNq05BX/z9vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=DLO2xl3GTdFw03TKQ6MFfkI6qZVVGH8DKOTjIW49y5ifJ8TEzsHoazUkt1UmZjSANlPPAudUuKtTPbH3kM/4tzXA9x/E+tUh28C3QV5YXIMh+YJ7BHiPx1eX5mmvH+Zq8y6fh4Od52jFwoLjJtMCmnuBIEC9g8ACaITYPHzxKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkd27j6n; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkd27j6n"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so200595e9.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790946294; x=1791551094; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRpoTPkOwu2kHYGd58XTlUABLsElVNkyb/S9ROItkY4=;
        b=Gkd27j6nZiV6DLPTnD0vGAjKOBJsmL7PXDGtt0/XnIZBJ3lw4od5UxuBzEhXXQfuf8
         oy/YbY7mJNLLyQcLOITYhkJOxPoyjR+ZvrnwwzihwGbUIut0earp1PuSc+MEbhUkRLIJ
         rbOt+g73qf/Rr7snwvlAPDJ7MDDSlmi/RZrExOyXkTdaJXBo6aiM10rfGf3gF6IirO0w
         GR6YfvtwsKx0nY36NUNrpItQ8+HgxtpBLWApyCQ0ZwgQrmHZpPArhY2leGPW7rSarEv9
         MOFPRkryOPBBoQxZkENKj1APTRPCXZwdOgcxDRliRiRCKMuUGx1NSlgM7vMs55iAH6NH
         qfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946294; x=1791551094;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRpoTPkOwu2kHYGd58XTlUABLsElVNkyb/S9ROItkY4=;
        b=Dz8fukojI122Zu2uNd0Kyrv/8TM0UO7oV9yq+tAkqSbT8nFZB3OsbSXzCBpwUjlpLd
         z0pg+/YIiJtqT6TFNXiSwTC04I3CImuEPFoCeVSUFI37g+1iP8EuDfIXtIN88s+/imxO
         hzpTOxRdopAG8iyQs8HDcOKaitdv+clMu1w1KNJraNNDf/m8CpzJE2ocbRIGjdo4ABSN
         f56Fvf3j1Pn8AFEaAKbCHl7kRmEBjPMAGv4KITRi8LtlPSKjP/9ccAe/Uu5WUS3T89re
         xHciyPENpDVqb5+vq6KUFKXVjjqnW3ZQ1jLWpMWFlyKJDL8vj+OrIYBTh3yGl9P1vhSD
         +orQ==
X-Gm-Message-State: AFuF++ltzfRoUeZG7vbw0oEnIBTtRqEAGgCN7RnED+JdYfrW664yHmHN
	HjfJXUmlJaGv4uZx7AnRd6e1QWv9p0+ukGNGmzSvfVgVLNe5Kro6L5g7vM3A3A==
X-Gm-Gg: AYBFou363DCAsFsnkUuE/mCCaQ96DnGj7qtjiZdP2Sj9iwMpGBZlVB8Eqx4BUoYO5oY
	HGcTu19s/LNGv/OEDoxZ4QDPK5mRYKkce+wVmW2yzagLS9lnoTWe7TDd0Zi4sOsnhMaxlgMri7q
	pXpBbOau1Deweq5bT4kllkQskaiDz5TnyFOqeqTwEXRZKIJpBrHDCsIv7fr+AzfvvCEeJTqtqrq
	p3gXEOlFkh9gJ7QzMqduKxlgDBgu6TThJQlm1jlrJ0tuVs8MALKTjKOvOwycI9qUWPG3uC1qtFp
	0RRUxqXtxlTsaVny27I9/61SMtSgYoG+lSlmD17OjEhscyF3ExlLBe1Kr7tUZsEeddjuDVSE9T5
	NtyWFRGX1XwfXdKYdNCpopadYd6LJhBkeSjl2OhmFHBmb9/7mZJNbabhuq3nw3PwHeFuEpvDyPq
	MXFgwAJgODnL4uXqPzjAjH5xA1ACXDFAjmbnFJdco0azcC9d6hfEb+ocJGUyRGjYwvOgRiYQveC
	PNSwbCZBNrzLgj/i+4xmtgnDnyF16lluszvig==
X-Received: by 2002:a05:600c:b85:b0:4a0:313:3a12 with SMTP id 5b1f17b1804b1-4a02759b47amr41707765e9.20.1790946294152;
        Fri, 02 Oct 2026 06:04:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1c2e:b954:6be3:cd5e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c6597sm84012995e9.9.2026.10.02.06.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:03:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 02 Oct 2026 15:03:34 +0200
Subject: [PATCH v2] packed-refs: use `fwrite()` when passing refs verbatim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0K6dkwLkVBX3oOwKO0AIwJNB4iGc
 HcLHsC81ffyfjbBGAhZ3JNNBFyJaRojpJdE2M6MLQK5yCKVaS51JqEfgT2iWzx4Y3t0ELBh0EV
 eNDcnTY1axLKPLr3P4bL6MS/1E+18rB2Jjniewud8XtWR+3uyKohSyjqZOV1LfLSDodfVToOo9
 n3/AiptENrOAAAA
X-Change-ID: 20260930-kn-speedup-packed-refs-9868f5d0abe9
In-Reply-To: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=psH0hWZi3RQr7zroniOVEP7BzLEOkmfjNq05BX/z9vw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGq/q7n7QmjyvXs6BCzpOp6SZPE2/E6FtiSI2
 ycOx41JuOzVoIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqv6u5AAoJED7VnySO
 Rox/gwoL+wcyLDL2KACqatDAC7Mq3LWpL8Uwj1iR3GDK+R9ABM+HaLsmsCbM3EjtGu8zqgsNyzL
 PuifhX5gMtGnpIQpBZRMDl+zU7U7B6x+lOuhIztynT4a+r11FKWM4ExnCM0nGjSGW8wKWzZi7QK
 FoUiB/ZJFr3fNgeeWWdIDN4iOVcEY8pIYqJOmmj5ZEepRmUTEiLmkkeJfUoFAmMO/JFrCCyRhYp
 ZP9pJ1zoFfgoclQNSizrnKRzhE/TCvoBYJeBApIBq1x1UVvqSy68E9SCM6EGtYwYreTkkIgB6CZ
 fAO6ZfHUpE4DgRyzTQjcSt8co17T5a04vV1UCIgcML6iDzJJV8tdPsbmvWwozPFLVk/49vWZGoW
 BZWvAqni63iaKvYxLnSpMjpcjFJT/utjEED8fWvr8e7BNLsGoCwJ5e82NAgEyW7iJ3e60PWp32t
 td//XpmaF4X+KEBEoUFLljkdwQwCwKHoi2/aK7NUcD4n2RcXxsdJhNdbk8z83xkTChrMh7rSU65
 ic=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_with_updates()` function uses a `struct ref_iterator` to
iterate over all refs to write to the temporary packed-refs file. It
receives the iterator from `packed_ref_iterator_begin()` which takes a
snapshot of the 'packed-refs' file.

While writing to the new packed-refs file, writes are routed via
`write_packed_entry()` which uses `fprintf()`. Even for references which
haven't changed, we use the same mechanism. Instead, let's track the
position of unchanged references in the snapshot iterator and directly
use `fwrite()`.

With this, any sanitation which was happening as a side of reformatting
is now lost. But that was never the job of this section of the code,
since the main intention is to simply rewrite the remaining refs post
deletion of the selective few.

This removes the unnecessary formatting operation involved. We can see a
consistent ~20% performance improvement when deleting from packed
references.

Benchmark 1: update-ref: delete ref (refcount = 100000, revision = master)
  Time (mean ± σ):      28.7 ms ±   1.7 ms    [User: 22.5 ms, System: 5.9 ms]
  Range (min … max):    26.7 ms …  33.3 ms    46 runs

Benchmark 2: update-ref: delete ref (refcount = 100000, revision = b4/kn-speedup-packed-refs)
  Time (mean ± σ):      23.8 ms ±   1.2 ms    [User: 17.5 ms, System: 6.0 ms]
  Range (min … max):    22.1 ms …  27.7 ms    56 runs

Summary
  update-ref: delete ref (refcount = 100000, revision = b4/kn-speedup-packed-refs) ran
    1.21 ± 0.09 times faster than update-ref: delete ref (refformat = files, refcount = 100000, revision = master)

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Instead of using the existing function, introduce a new
  `write_packed_entry_raw()`.
- Modify the commit to also note that we lose sanitization.
- Link to v1: https://patch.msgid.link/20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com
---
 refs/packed-backend.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..43ad674cf4 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -879,6 +879,12 @@ struct packed_ref_iterator {
 	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
+	/*
+	 * Start of the current record, set when advancing `pos`. Used to
+	 * pass records verbatim to `fwrite()`.
+	 */
+	const char *record_start;
+
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
@@ -933,6 +939,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->pos == iter->eof)
 		return ITER_DONE;
 
+	iter->record_start = iter->pos;
 	iter->base.ref.flags = REF_ISPACKED;
 	p = iter->pos;
 
@@ -1233,6 +1240,19 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
+/*
+ * Write an entry to the packed-refs file skip any formatting and directly
+ * write to  the file using `fwrite()`. e.g. when deleting references and
+ * remaining refs need to be written verbatim.
+ */
+static int write_packed_entry_raw(FILE *fh, const char *entry, size_t len)
+{
+	if (fwrite(entry, len, 1, fh) != 1)
+		return -1;
+
+	return 0;
+}
+
 int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
@@ -1530,9 +1550,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		}
 
 		if (cmp < 0) {
-			/* Pass the old reference through. */
-			if (write_packed_entry(out, iter->ref.name,
-					       iter->ref.oid, iter->ref.peeled_oid))
+			const struct packed_ref_iterator *packed_iter =
+				(const struct packed_ref_iterator *)iter;
+			size_t len = packed_iter->pos - packed_iter->record_start;
+
+			if (write_packed_entry_raw(out,
+						   packed_iter->record_start,
+						   len))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260930-kn-speedup-packed-refs-9868f5d0abe9


Thanks
- Karthik

