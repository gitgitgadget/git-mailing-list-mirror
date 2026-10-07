Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE704A7C80
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372052; cv=none; b=XdGEaYTV5fzk8IIrWRExQhtkQhYBJxUZDxadbUcoNIizoUHGyrzEklaEkBRnWAqFLPwalHwhjoMqpynypjCl8KVs9naT+NdBC5RNdb0/+0qcznLBoKC8KwmPskPrWL3SRSc0fjxZQz7zz89fka8svX8ml6t7bz3ak4CKUqrXUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372052; c=relaxed/simple;
	bh=2tlDbIOtz3CxCJm/q3w3KqFUMkjtxPGb15uYpON7+Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=GTpF2cn/qAdWHKG7qcmr5C++BNVW2Bj1GosfIEiqlxlbnJdemr4GY7TgdtdhiEaBupBFKu0Wn7TRIm3ZUocMQYEm+GiVp4DijZgZnnf6w01wuL3dEuvYzwaQ+siJzDtLG1jq3VfJkfgcg47BtH7cVYjpyVsChMPESW68MIwMKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpuTJgnt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpuTJgnt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b02a2359aso1597543f8f.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372021; x=1791976821; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlhG8iS+3SaBU/WKfX17E61FBNc+7LCX+1SZAmGLJng=;
        b=PpuTJgntc1/tbVHDl67+sSgb2q5ROseqPbaZK7N3g4GZXu567uRH1uISfYG90QiKe7
         KHKcxmRnX6cy7UepoAmd1hAdRwIizfLmhBeCLXv5cgz2QjVKtFs5U926jR0yw/5o5tF5
         bsHQ+0WW6R8tHMBAdjpTFmL6m7erR+hZknXsuNDf4Rzr8TU1/GngDMs13MRTBg8a2ILC
         bB9hru4uMMh8R+WFMP6xiiQlHtw9NjUGEpF86pCuaB8MdhKvSGgrXx1E5+I5Hj0p5xxs
         hUU/fjQovXG410o2xXavR8wPB/ehxNC5C+y9Ht8auC5xn6HaF7JHzM+e1rvwx6MtZ36K
         qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372021; x=1791976821;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FlhG8iS+3SaBU/WKfX17E61FBNc+7LCX+1SZAmGLJng=;
        b=fDWZGXOk9O/obtUI1flfOvymxsjd9KuiNicJEz/py4HG/rr/Wsy4PCu+1p2tUT1fTq
         +et9Cvl5P3uIY7nhzI9TN94qdF69uJByaNDpCLxKLSI0oBP7dMVfEgi6U8keQfTBTOf0
         dWEIltePOiyj7KqXhyw0anDrbhjIisxRqLSzXug3nuWWz9mDco+wNiaGFb2duAbC5/Io
         WfQZpbEgcZtsETIXU9t1R1mD4tbvxfiYQIOwwky1xZFMndqEXcu/W/BXdkhDYGtXlBs4
         7LBtQLTxJMiTEWPZ+bn96rUmJLKRwJieHhCR7Krp/ybrB5xdZMpgJa2/W2pu8KjIlQJz
         znXg==
X-Gm-Message-State: AFq9FYJEOaduWUW/tylwoJWPF9XXMm0XpqgrSPF0k8KXJ+ynJjBPfeaW
	sDIuhMC8zcy2SPMTltbYh5ulRBG3KJy2cEUIYXEI+Vl6ieWbxT8uIVqnJ8jYog==
X-Gm-Gg: AYBFou2+i23/V9MtOT7CPOtXUDdWyrvG8O027JPH2RzJ4b9ZxX38pcdwP0z6w1kWSuK
	G8EbNc2T5FpeqcEMeev1NUNzb7Asthmf415qu7A3DpkhVZNM+uxf3pkWd6uXngXRpFHJgRpaXMT
	+gBP0hRPbFltigCw7/hV9LdOpKvTGMQZyZn1y0SpCermzfYwMOFCT9zSAa/OvCEs3lrLOfkO+uE
	AKKDO4cmj1Hqr5GaGtQlWA1+9UAZOTCa2TWxujgs2WUxBeywjeyLrNRcBEvN538iKK1WuEoPMJ2
	sUkclCkiCTjzWY5z1/3XWOGrLEikG29iopf/+8W/OV+WNHzYrERhVs+FBDkQjfLalkXsKAadqG6
	P2hjXjPYfFqPqdfd+j64ciOfOLH63SbAGZiisyI72N1jAhIGUVtX0rYfQgvoqXd79Pae5tga3fS
	RZ2qZVcWZ5F5HpnLI8lAoheqMvHTULGm060bgDnUY8SIE/waB2nJ7Rwz/JyKJCvE8oHkXC127ps
	9df+Gj+7grIRlQgttPQCC4AZkaWp1Z5Q3SvkSE=
X-Received: by 2002:adf:e502:0:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48c7276916emr3061613f8f.13.1791372020413;
        Wed, 07 Oct 2026 04:20:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:c19a:7fb7:2411:8ce8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3d3eesm5600903f8f.53.2026.10.07.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:20:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 07 Oct 2026 13:20:16 +0200
Subject: [PATCH v4] packed-refs: use `fwrite()` when passing refs verbatim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261007-kn-speedup-packed-refs-v4-1-79a411026596@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNyw6CMBAF0F8hXVszLfKoK//DuOhjgIo8QoFoC
 P9uwcQQE2JmdScz507EYWfRkXMwkQ5H62xT+3A6BEQXss6RWuMz4cBjECHQsqauRTRDS1upSzS
 0w8xRkcZpFhmQCgXxz63f2ucKX2+f7AZ1R90v2nJRWNc33WttHtly97dkZNQPY9pAaIQCvOSVt
 I+jbiqylIz8yzAAvstwz3CJSZQkHJVmv0y4ZeJdJvSMZDqJFTOZQNgy8zy/Afv8E8hcAQAA
X-Change-ID: 20260930-kn-speedup-packed-refs-9868f5d0abe9
In-Reply-To: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2tlDbIOtz3CxCJm/q3w3KqFUMkjtxPGb15uYpON7+Y8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrGKvJ3rxlAaGB5I2Iu7HpwqPHJd8Mgx6ol+
 V0PgdibMUwhKokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqxiryAAoJED7VnySO
 Rox/JzMMAJZnOu5f1qZvrJv3dzkDwt1B4ZyPXh8NjXipE8TT8i2APnnTBhhgHrsLbcTc9TLzSEc
 jVkDSXv5q8VKlJIgp/oIeNk0KfyuhZ8ksrJcAN3Hl8PbZVMNi4HNciODSo2qjtYAx3Uqi5o+9e6
 b247Tvi/jTk8+8aPJ2MOMPN4jxDc0ofz+/O5uhZHvVe1rjfsHwBKTq1+UG/P8kK9RqUVQdMQNL/
 ozfjOVTfW4FOLlqoAVSQbUUWIMM8eYzvMlaYDsORQ8F+Bk/rAsL2Ww9RRM6r+c/hKZo8xO9F+u2
 ldCmQle2Z9BBGW9y2WnCuz4kNnCHtP56G+wtyRf1mDAxe2SkQaZjKuLdUwi8n2mVD97XpkGc7j0
 Z/ppcOzwAFxDFct+tzdHlXcBfGwTcCre25nf65zAh2hvoTQ22Z04CY4YqwmU3BC6VKANaLBrBGv
 LzLjambzb9b35T6t9Bmv/HisKDU296SAXIaiUYNtpjVt066VRafzmCxPwl9ekCKZmP5RzvlYZX5
 lI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_with_updates()` function uses a `struct ref_iterator` to
iterate over all refs to write to the temporary packed-refs file. It
receives the iterator from `packed_ref_iterator_begin()` which takes a
snapshot of the 'packed-refs' file.

While writing to the new packed-refs file, writes are routed via
`write_packed_entry()` which uses `fprintf()`. Even for references which
haven't changed, we use the same mechanism. This is slow since we need
to do string parsing and formatting. Instead, let's track the position
of unchanged references in the snapshot iterator and directly write
verbatim via `fwrite()`.

With this, any sanitization which was happening as a side effect of
reformatting is now lost. But that was never the job of this section of
the code, since the main intention is to simply rewrite the remaining
refs post deletion of the selective few.

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
    1.21 ± 0.09 times faster than update-ref: delete ref (refcount = 100000, revision = master)

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v4:
- Modify the commit message to state the issue with the previous
  approach.
- Modify the comment for `record_start` to remove ambiguity around its
  setting.
- Remove `write_packed_entry_raw()` and inline the call to `fwrite()`.
- Link to v3: https://patch.msgid.link/20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com

Changes in v3:
- Fixed a typo in the commit message.
- Link to v2: https://patch.msgid.link/20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com

Changes in v2:
- Instead of using the existing function, introduce a new
  `write_packed_entry_raw()`.
- Modify the commit to also note that we lose sanitization.
- Link to v1: https://patch.msgid.link/20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com
---
 refs/packed-backend.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..53511f2d91 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -879,6 +879,9 @@ struct packed_ref_iterator {
 	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
+	/* The starting position of the current ref record. */
+	const char *record_start;
+
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
@@ -933,6 +936,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->pos == iter->eof)
 		return ITER_DONE;
 
+	iter->record_start = iter->pos;
 	iter->base.ref.flags = REF_ISPACKED;
 	p = iter->pos;
 
@@ -1530,9 +1534,15 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		}
 
 		if (cmp < 0) {
-			/* Pass the old reference through. */
-			if (write_packed_entry(out, iter->ref.name,
-					       iter->ref.oid, iter->ref.peeled_oid))
+			const struct packed_ref_iterator *packed_iter =
+				(const struct packed_ref_iterator *)iter;
+			size_t len = packed_iter->pos - packed_iter->record_start;
+
+			/*
+			 * Skip any formatting and directly write to the packed-refs file
+			 * when deleting references and writing the remaining refs verbatim.
+			 */
+			if (fwrite(packed_iter->record_start, len, 1, out) != 1)
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260930-kn-speedup-packed-refs-9868f5d0abe9


Thanks
- Karthik

