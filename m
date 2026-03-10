Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805273CD8C9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126222; cv=none; b=DykBmSASj62OVg5T99L//GT9glWb5OPD0i2S5/PCMK0pZA5yrHNtCHG+goKjXNRGWkYuQB2pXSROwuEWmsbJTjggd1t6fD2KCQ8oSGZlLfx5yFenZrLdSOAxQGinc0vw0DGlMfBFmUG7fiBrOT+R+ScHS9HAKc8wMPysnydpJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126222; c=relaxed/simple;
	bh=0lgNUAnw0+ravsjFmm64TQdZ13K9djyFMtFzsBFunDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdQ7uYKZPQNk7/ti+2cZ4djrDIdM0o+32mXPZszjbkYtlCrn7ZVqk2xnqf+dZdENtaK9pDzAtG6wW10G079Yy/PygXmXz8ju4b5aGP5zOra/RSXoRZleP6/PV4cqnQrtKjnyNtFsF+nDsME2lQH0g5JE4TUVBrcj6AVVPZIGdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeK14DT4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeK14DT4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829781b2b01so3808062b3a.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773126216; x=1773731016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pj9kqxj/5MXCJU02c+nbqYSZ3ieEmokKXU95IIEG7s8=;
        b=IeK14DT4s1mLxkMPB0eSfDc7N2oH3AwkVgk/n/LQ5eW00RNcHS6KWQMcEYHdmQS0sh
         YQrSXS6GNd5KH3/12pQhnh6YpqiGl91F/2p6CiAzudJQwGZeD0u56u/w2MyYqMaOi+rE
         +wgfZHRBSlYBoq66E708Om598XHi0FgEpttUgvf0urvvubDAbq1mUUxrMi4sfhTKIJ+F
         +HIPipNBqtV0jOkCuy8yJbsl2Sie38LVbe9DOOjL3iRJjuYxPGVCiHcctTBc03Jrh2Z7
         HqrQ6OglT2RLp21BkoVHhzOw4SyRCeF/QU0o+MspzlJb1SlOOqpekb1Mk44ifJydoxUN
         C5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773126216; x=1773731016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj9kqxj/5MXCJU02c+nbqYSZ3ieEmokKXU95IIEG7s8=;
        b=gGzKjgCTD3qoZs0+zJkiQxOF8nmZzZg2FoZa9RJukUQ+YxH3Om7q8mtGOGulK1laME
         IoiNSMpW0H7TAVhB4CrJXM/mSfnJmQ01lqt/CorFSztdzLqP9E16TM1No/7QQAhGi49V
         ljKmMWvbOqjc00q6A7OgAe/otum5tiQplysyMuurunO56ToFPrqCK3lWGyMgIgYKnCVZ
         6jEeD1UGi9P3XE3q+nPS44ipRN2271Iw4/fuWqcxa827RJ6o4laBwbZB0/9LqJS9O2Xz
         x5f6FHeN+2/A36e4VjrOvMS4j0clCDXusV0HqXzwa/Ym1BXwlN3UXSc8FCi5q6H9dZkH
         9G1A==
X-Gm-Message-State: AOJu0Yyrdnm3+LTCodhd1mP3loQc+lQGUtC2gGLhxpgm7BzC+PBC2NtR
	jDE+p4Y7HIBe+6RA3lI0W8m+IzpGk0RQgN0CK4OQNwikLCQ7ACi2o7JBb8f7dwUHvyw=
X-Gm-Gg: ATEYQzyZ6cxPCDHbL4ENWrml/LZ9Cx+hs7E2qTaHa79x1pBQZ+Lz9B+ef6EB6vjYvd7
	n980nrwxQ2NPS/1Vn3fejOw7Li4nREYabV8qPfVWQQ5Cx/ZfwWCJdp2/OUAXaYyKhLHMoJriFeG
	NdJnj2j+M+9M3jyg1TjSOe8mLgWYn4BTjg/xos3heY/J9MI6z2n54utXT32Zksy5maVvKtZAcUK
	2ONpKrCya0LUTdGEvhWYouaMc6QM4cMQqVagDEA0x5jyVtYYEVervW8ucoSycivjwapQC6lf/HV
	gB+E5ql7Ga2PbBlcEeLXkkNLZV95gkMPDyuL89XpnKU43K7LZZxsPZAu14MpmBN/fziJpFONM+R
	ucgZr4GhADGTbaHn+rfEtfET0I043f/i3cTyCZUCZsZ8POOlGHrw3HeIOGgdkrGce4K1c0fzUFa
	OmCHfQ84xD9cukLvR3yKuSKSyLo8ZVRDUKTitvvBIkGDFHP6LDI1AiwTDMElD3TQ==
X-Received: by 2002:a05:6a00:4006:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-829a2d6e680mr11577578b3a.11.1773126216012;
        Tue, 10 Mar 2026 00:03:36 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm15137843b3a.23.2026.03.10.00.03.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 00:03:35 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	jonatan@jontes.page,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] builtin/help.c: move strbuf out of help loops
Date: Tue, 10 Mar 2026 12:33:28 +0530
Message-ID: <20260310070328.29836-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In list_config_help(), a strbuf was being initialized and released
inside two separate loops. This caused unnecessary memory allocation
and deallocation on every iteration.

Move the strbuf declaration to the top of the function and use
strbuf_reset() inside the loops to reuse the same buffer. Similarly
release() the buffer at the end of the function to free the memory.
This improves performance by avoiding repeated heap pressure by reducing
the number of allocations.

This also fixes a minor memory leak when the SHOW_CONFIG_HUMAN case
triggers a continue.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/help.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 86a3d03a9b..07398b430e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -134,10 +134,10 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
+	struct strbuf sb = STRBUF_INIT;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
-		struct strbuf sb = STRBUF_INIT;
 
 		for (e = slot_expansions; e->prefix; e++) {
 
@@ -149,7 +149,6 @@ static void list_config_help(enum show_config_type type)
 				break;
 			}
 		}
-		strbuf_release(&sb);
 		if (!e->prefix)
 			string_list_append(&keys, var);
 	}
@@ -161,10 +160,10 @@ static void list_config_help(enum show_config_type type)
 
 	string_list_sort(&keys);
 	for (size_t i = 0; i < keys.nr; i++) {
+		strbuf_reset(&sb);
 		const char *var = keys.items[i].string;
 		const char *wildcard, *tag, *cut;
 		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
 
 		switch (type) {
 		case SHOW_CONFIG_HUMAN:
@@ -195,13 +194,13 @@ static void list_config_help(enum show_config_type type)
 
 		strbuf_add(&sb, var, cut - var);
 		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
 
 	}
 	string_list_clear(&keys, 0);
 	string_list_remove_duplicates(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
+	strbuf_release(&sb);
 	string_list_clear(&keys_uniq, 0);
 }
 
-- 
2.51.2

