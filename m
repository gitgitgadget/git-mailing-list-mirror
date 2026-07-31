Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002E30E0E5
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527400; cv=none; b=e9DpIoi2AVupN2jQ52ZbxJFl5r2mnAg0JRyM0J5qI5tUClW5q737N0jYGcC/dueaWh53FYU4jDcIOAD4HDtg/0FYZg//1Z1KsLgAnaGmMCi2tMdm0FVhfGcvNGgnZbNioa1OgedhOG5tTy3mplp264KQe8VaJjobD/WqaU3MZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527400; c=relaxed/simple;
	bh=P2HhzQ8IQgI4AcLooddN99wU/RI4q41Mub2LP4Q+WHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwY0jV2zYociJx6IcHu1ncHBdflmzqvQ6H7ASYZ1UeALKHgR1v21y+5AoRgbURzolXDqnAbk8S5gIlj7q3IQaWD4AWFI7BSJ5SI66pw4jWAIZq6S5Y2r6H4lpAGdM59XYBwRN6JK+pU3vP1NEElxeFhQKg6/SU4oD7r0tF5yGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll8B1J0o; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll8B1J0o"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de008b020so1015194f8f.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527397; x=1786132197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwleYlsq0+K8RtomcDU1ekceQBYJEXEoYWXo91BaQX0=;
        b=ll8B1J0o0IqX3OwZoygokQr9viufQ+HSPNQ1dg0Xk6+ibk3CE5uZP8OpWYggdmHrwC
         Vfwaifn9FRqAtwhI0YaFcFypKzLV1j4UsvHwkyjW5EWXfpZmF4qqzCVBTci4YoraHPAE
         sHwQna68yXb4Wc310iVjMFpAtyuQXzlRn1sBzFQ7NoqB+5b/w+jopAVlQJoiE9bxkPKO
         LZrVM7HDXBxX/gXt/6TmNmJA9+92fcuAKR+lf2SJmCmfKRehx4dXoN3rcOtCEsYU2iEo
         Sj9N28CCvr+hjdIIB9X8KRYqzihlnO0NOH0jAzQILSZxSHH60KA/C2pn7XjsEdDr2V2e
         0afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527397; x=1786132197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwleYlsq0+K8RtomcDU1ekceQBYJEXEoYWXo91BaQX0=;
        b=sknDjQHlylr8NUQfj3GJ7CgNBvs+aKMWQT6+femMBPCDYe9JQyM/Xm1bPvhaJqsoIY
         zhNMw9ICAlpgeYHzDqYpZNgEtJIlbsmqjB0rWZROU6lDICO3hZTppBDQCUFadnsUZ+Hf
         hcX7eY7HhmPinadrErVG1H1EUJStkng56mdWNU7xUGI6O8qrJ5vgMxIC+jbwsusjR2Tw
         AEXfnPmqrO2kVGGleBxs2a2YU4Fj4U3/mzyW8Cqtoaejbj19SxmqRaCtObcXQ6Sg2Zl+
         lxuSMFEbLyUYkaCZd8T41bJAU24yd0eftVQ6yeJWssztkFR9+uJM5KAXfpEeHliIBwxM
         Tk1g==
X-Gm-Message-State: AOJu0YyXjpsNkz930VUMMvdHI2hs6blqrDI4MdfcTWtylZbMwlOyC80V
	nEMjUTG6jd9f757cW90xYAzcu+lnumFNSXrqFKROK+u8zKotoRyFsc55
X-Gm-Gg: AR+sD102B4fHCf8NPbUkJoDiUDbMGelF/qpyz3LRYo2Hnz9rLCkfRE3eXBiJ4fISiPJ
	q8GvxRpVp6cslph5gZrc5wYlXE/hPJFrlJg8VXDFunJWDpiYqH5vzlilkp/3aagc2w4XlZWfZKI
	fJCHWfBOVTnOZ2saJ6S6/GqhvTEy7So7ui5qCoijJFthsAaeljGmfi/jJUZT4n3YKXfycE+Qpsl
	uMvPN4q14OdmdfNbnoTCGw+nICSFi132wlxIbY3ZH4OIKgbDIAIZOMchSBSSvVZEYw5wCdKhS0B
	yZWvQJphDIVkd4IKJ8/Ts7/dyeL4053pmxK0ZvVOM3MV7zUspgeT1PQnGTHda4ulycBKOhFFQ+d
	p56LQKfedE+8qec/LKe+6EvfNHgmpd696h5wQl4gso3FQ063C/rFxOjKyPs5h70uYStKucr6jKJ
	JfjDok14PGWULqBHA+eVpyuT7UJgPeAAt5FRy/8icfEzAIpmGAH+IzBeGDAX0DInZzC2TabZjuW
	tA/TJLM3j/vIt6tRR+vnvaE/dfjVEbSbBj/18pUJqpYAXKMBJIZEQi43HQQj5isZz/Jrhz8KduI
	ReS4rD4wmKWYN/mhPTnbcZetTx9zwMZ5OG5ZZOzYmSJux2Gfo/oxcq3t2NM67ZHiwwUMuX+YAdk
	A1duXU/2AgbiArU/FHHW9oTYws8oqs0lpiyt77tKv47krwUtNL0qxODGzcNw3UXzSsl8He4u1hY
	Lu7BXTo9k=
X-Received: by 2002:a05:6000:220c:b0:470:8e2b:9c84 with SMTP id ffacd0b85a97d-47fd32b8f8emr6974117f8f.7.1785527396958;
        Fri, 31 Jul 2026 12:49:56 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:49:56 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:34 +0200
Subject: [PATCH GSoC v2 1/6] fetch-object-info: request all supported
 options dynamically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-1-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

In send_object_info_request(), size is hardcoded to be the only option
sent. In order to support type and future capabilities, replace the
hardcoded size with a loop that requests everything on
object_info_options list.

This is safe because the list has already been trimmed previously in
fetch_object_info() to only contain options that the server supports.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..ec8a80b3be 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -12,13 +12,16 @@
 static void send_object_info_request(const int fd_out, struct object_info_args *args)
 {
 	struct strbuf req_buf = STRBUF_INIT;
+	struct string_list_item *item;
 
 	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
 
-	if (unsorted_string_list_has_string(args->object_info_options, "size"))
-		packet_buf_write(&req_buf, "size");
-	else if (args->object_info_options->nr)
-		BUG("only size should be in object_info_options");
+	/*
+	 * The list has already been checked to only contain valid and
+	 * supported fields, so just request everything remaining on it.
+	 */
+	for_each_string_list_item(item, args->object_info_options)
+		packet_buf_write(&req_buf, "%s", item->string);
 
 	if (args->oids)
 		for (size_t i = 0; i < args->oids->nr; i++)

-- 
2.54.0

