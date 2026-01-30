Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E517331A6A
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787392; cv=none; b=sQCRoG3whW9EZIPhJ5WvICRxyUQb5t4KhHwXe4gyP6UrWsZEewVj9JLO1Xi6xYDet/nVurDxUmwMWTDd89hrbt2TchHMOiQjK4qkpAVxBJlVav6SiVJEc3AuSX9wnOSGfAC25mwUfvR5P/B6a4ef5PiXFTtRmYVyDAQH8yMRfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787392; c=relaxed/simple;
	bh=PJE9l/ywCw8rSJWLwHdFfUmWSA3N4udOBeZigoN/jsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzyPJ9wUJSUzMyVEGKDzE2u+hxOjA22r13fMA7JVXRSLASM2sb6dNASJQDGl+cbmK97ndfeiHwDCqA8x/p7DbOINTB+wwaVqTq7k/ChiNr7Zs/G6eJKWWLEbJhYAx0crlZZIb3Hn2ciLzIp1+6iq0A87mvTc8Eu6gwPvexPLdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us+kJ1Jc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us+kJ1Jc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823081bb15fso1257061b3a.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787391; x=1770392191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO/VJ69WSt0x1Vt+nfOKr0u5VpnkjFXSmBRtIfLTRLg=;
        b=Us+kJ1Jc+AFm32NwFwQXdQMSazZiYO+BXo4B2qjxGG+7rf58Hk84YayzVRlfzqPae+
         y6OQdwE6xr1VS8vK9X1g5vY8JTZOpF1snztcqJugY3r6ge50etOAqyiO9p3IqV1R7kOP
         mqZ21ybKCtZBoCKnhYIKXjJF39EVsJE0XRyQ9GqRIMZpvxt+2FBV2XFPQlZNjfL9OSZu
         koFfHY2BHlIVaWulLVzsxU31d7XGJg+8R/IFHyFezP8g9R3l7Yqa3NeU3Wr7pZGh6jgb
         wVFrXuTqevpAsxdT92wEBoMFo3jMbKT9b7px5f5JzETAJKoDGCclJV+kwobtt4ikYt++
         tegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787391; x=1770392191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TO/VJ69WSt0x1Vt+nfOKr0u5VpnkjFXSmBRtIfLTRLg=;
        b=nVBuQaRw/wxGTGAVDikE7SlLrfCtbzZ7pMVnwtb05OVTXfs/zewHIIW0Y5F6LPoyNq
         1vLee+MQEv/ElKjR6nq2rf5yqxSv8YdD8EcVYIhIpEWPhL+3GwHtaCebl+UDuEst1Czu
         bt+yRbbOV4zFYH9Ki0nUYdWHmG/uF0rwZfJkbl4rCGw/8nDniEqGycCnkhLInib9n+fN
         1twTfaBE7VcXAQRjtteT46+wdF9vXH22SQPpRcxPN+l212srPs3AA0XNeayzG05amuvn
         IDoOhAOQ5H0i/rJG/SMvxrJsOeS7I0xrRjiYpQ7K8t5Ju/tvHS3b5O+bINkWldph26iR
         SgrQ==
X-Gm-Message-State: AOJu0YzM503jGBtGqUSd5naMKDwjOCfwdLIJqxn8x1mVBpYHhNs+GLxD
	nFIv3gu+cMuEuPXTG52mCyEwL1OkAVjzSOLL9w2McWMHg2a84Sti8agUoGM7Fw==
X-Gm-Gg: AZuq6aJpOjVSUMbevLTzEjH5TkHrr4b3tdVCocY5s2+jzJ8TV8jx7rgOuyrGH3ATgpX
	p3nFLctGbjtODTa4otMvMiavs5IT08/oRWFZYTc4PJZ3JqAGw7mfrqa7Ihh3O5T/9aA6b+OgLoA
	5CKxCYz2fqZJhJLgh12pJLBRnHCjyfAuBQGVetflwT80MJoF60pEAtnAK8K4wtOyIyyKdzp7ZK6
	qudwIu84Y31GQGuwcF+4l44OWMWZLQIA61RBE+kn90/h+0jyNaeU4Ex+tGc4+b6BBAB+84tzikP
	qP58yM/+BjXNEPyqMPNtsGw1mcVC90ChF4E2MbGzMwE5O41M55XHGBOvaif+w3g4HSVcjdu533s
	aK3qS3Nfvzs+ISr8Rt7DOABkyddiHAkADgnU9cOlbtxBoULE8HmF585dFnJ2CfMDXVPuCNSZTnu
	XraemcmDplBWt5XpRIWUlGOh7pS0JbL/0P1reNRXRJ9/JfCA==
X-Received: by 2002:a05:6a00:709a:b0:81f:44f9:7c1a with SMTP id d2e1a72fcca58-823aa40f7efmr2754036b3a.3.1769787390894;
        Fri, 30 Jan 2026 07:36:30 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3c46:c24b:c90e:ca5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm10033713b3a.67.2026.01.30.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:36:30 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 2/2] show-index: use gettext wrapping in user facing error messages
Date: Fri, 30 Jan 2026 21:01:24 +0530
Message-ID: <20260130153603.290196-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple 'die()' calls in show-index.c use literal strings directly.

Wrap all user-facing 'die()' messages with '_()' so they can be translated
via gettext, this ensures better support for users.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 45795da2da..24f0230967 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -55,23 +55,23 @@ int cmd_show_index(int argc,
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
-		die("unable to read header");
+		die(_("unable to read header"));
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
 		if (version < 2 || version > 2)
-			die("unknown index version");
+			die(_("unknown index version"));
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	} else {
 		version = 1;
 		if (fread(&top_index[2], 254 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	}
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
 		if (n < nr)
-			die("corrupt index file");
+			die(_("corrupt index file"));
 		nr = n;
 	}
 	if (version == 1) {
@@ -79,7 +79,7 @@ int cmd_show_index(int argc,
 			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
 
 			if (fread(entry, 4 + hashsz, 1, stdin) != 1)
-				die("unable to read entry %u/%u", i, nr);
+				die(_("unable to read entry %u/%u"), i, nr);
 			offset = ntohl(entry[0]);
 			printf("%u %s\n", offset, hash_to_hex((void *)(entry+1)));
 		}
@@ -93,15 +93,15 @@ int cmd_show_index(int argc,
 		ALLOC_ARRAY(entries, nr);
 		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
-				die("unable to read sha1 %u/%u", i, nr);
+				die(_("unable to read sha1 %u/%u"), i, nr);
 			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
 		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
-				die("unable to read crc %u/%u", i, nr);
+				die(_("unable to read crc %u/%u"), i, nr);
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].off, 4, 1, stdin) != 1)
-				die("unable to read 32b offset %u/%u", i, nr);
+				die(_("unable to read 32b offset %u/%u"), i, nr);
 		for (i = 0; i < nr; i++) {
 			uint64_t offset;
 			uint32_t off = ntohl(entries[i].off);
@@ -110,9 +110,9 @@ int cmd_show_index(int argc,
 			} else {
 				uint32_t off64[2];
 				if ((off & 0x7fffffff) != off64_nr)
-					die("inconsistent 64b offset index");
+					die(_("inconsistent 64b offset index"));
 				if (fread(off64, 8, 1, stdin) != 1)
-					die("unable to read 64b offset %u", off64_nr);
+					die(_("unable to read 64b offset %u"), off64_nr);
 				offset = (((uint64_t)ntohl(off64[0])) << 32) |
 						     ntohl(off64[1]);
 				off64_nr++;
-- 
2.52.0

