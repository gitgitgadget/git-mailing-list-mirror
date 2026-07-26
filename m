Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83595370D6D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048296; cv=none; b=o9arnX3U1w6JovL3b77gGPUnRk4sChKXAIg5NBSz5v+h6oygypsXFMJ5N5ymyRnwd95GvHcvU91efOerFPyzo7rrzAvFAATUfUes+KF+tC6JPsb8H4cxSFMWq/wMJqLIR/KpYTJi9eme0jqJqTA+QkTwM9jpqM8f6ccGf2kMowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048296; c=relaxed/simple;
	bh=uGWD67MW6wYScfwvTn5vnH3dAuOQ6DRsntabHBdk/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLcvVZp24kkRcNYSDNuW1rM/6DJhVnhhz+PmAhmtHF2oi7eGlpQRw97D0eIft0KR07cCimarWOLCBTOCqK9OymYItm0R2qwsnMo43UiYOuFQL/PXMuR2dc5KyqB026wu9CFv5hTnMZaZqnvtbjiMB9iEoYfPZ3RdXUhdj3qzylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=BHfJsCXM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="BHfJsCXM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdce28edeso2392275ad.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785048294; x=1785653094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=BHfJsCXMhlygnDeKapSQ5m8/iubhrYbzwRJ6Cr9+yqjja07TRxNAxOV/vJt+O2uwRc
         YUabHKLgqquLg2yMLVSyay8RgvQiR6jKVOc/IrxsbxhwSdmXUZ5rXlwrBtDPSWxfeO4d
         xnvuA6E9YLIXye3FX0dYwzWtZv3UEZ01NQ+aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048294; x=1785653094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=f3311iOy2//WnHvJ7B627WVjQR68stE0+ed4Flq7OFXAGFxPMG5wEa9ub2Wn2Ek/xC
         9foylPx+3TAKySdJPTv2EHjGDIq95B+fIk1w/YY9jdwFhfspq7ShyQchgVz4gVn2uqH1
         nM7dXpa3nnZiEqvPWucOGNu7ZFHNFi9FnKI+M8PR4Zp9BLei/o2q0zfnZ3RAFeA+5eEk
         1xe28neuglHDn0F+X5Uxcel4cbrg2DUqfsMzVAVDVL0QkKACLSN4aOZN7v10b188hG6f
         /C/YG4ynKMl/o+8ust4qSr9WdUwpyaAA5tKH1MXWC000MyMs7+LxogRODJAsztZYIk65
         EhYA==
X-Gm-Message-State: AOJu0YyKjZFwhmR9geGscTL8/nXnVy4UC8MDRgZBUnBqHDjiwH6ZnTGP
	BFZ26mERCHzlne8kOZ4RF1R1tMCcTgT+A3OOhlIXJRqB7cmozVOhbsntzoPqh1EuPfkiv9w48jM
	pPP5SkF4=
X-Gm-Gg: AR+sD12dRpsMw2hhqqVwv0QLOolpm3ibUt4qyBx4W2/zDLRQnzK+xnMeV8L1MX1XfYb
	4KasNyYoV5nPqBgsfovu5H47cU63bN/yfljb1aq4wFX/xyJJAvhglQrFpk8iAKP8Jdq1FLAMsEX
	duDSrZDsDZkBXYK1ZtY1gw7e1CTO7XydVejqV2CMhnTKiOdoYdbhs10CVlv0eiwl18ug1/jgIyH
	hREtwexqy1OgSkewrmUIZNQZpCi+HMbm8HUxUF8HAHVQGV2NisfQ73Y4r/lWmhfSx1EyYm+y/dx
	4KHk/v+7nNbZ8+z7nyDhsfhNJxUrg0IoEAX5fmoCbpW0vJrDioLjBvkEjPBIlsCm1hSqmyIfxOp
	pOR9IGwQgoKAZp3D6zdmhUNH7uub03Ec03XE2G3VIpU1oQKGigOYX/HVCx5A1zaxDlCwHm/+JKr
	1RBrbUyZyrCzIapV7nYyJBkf9fpsG4WbKhoNX4Ak+MJndXzOr4YQ8qDoMsubgGuvaxJBoyr0PK5
	Wjkr6AO6YNKdDk=
X-Received: by 2002:a17:903:26c4:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2cfde55d876mr59224285ad.0.1785048293773;
        Sat, 25 Jul 2026 23:44:53 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm18622982eec.18.2026.07.25.23.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:44:53 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v5 3/3] fetch-pack: accept "pack" output for packfile URIs
Date: Sat, 25 Jul 2026 23:44:48 -0700
Message-ID: <fee6f292cba09a8190cc78595d0aa80e31243a8d.1785047139.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785047139.git.tnyman@openai.com>
References: <cover.1784874850.git.tnyman@openai.com> <cover.1785047139.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When index-pack finds an existing keep file it reports pack rather than
keep. Accept either result from http-fetch, and only register a keep
lockfile when this fetch created it.

Read the pack/keep prefix and hash without consuming any following fsck
output, validate the reported pack hash against the advertised hash, and
exercise a packfile URI fetch with a pre-existing keep file.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 fetch-pack.c           | 33 ++++++++++++++++++---------------
 t/t5702-protocol-v2.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 29c41132ee..e9f24fbd63 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1887,9 +1887,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	for (i = 0; i < packfile_uris.nr; i++) {
+		bool created_keep;
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
-		char packname[GIT_MAX_HEXSZ + 1];
+		char packhash[GIT_MAX_HEXSZ + 1];
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
@@ -1907,16 +1908,17 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		if (start_command(&cmd))
 			die("fetch-pack: unable to spawn http-fetch");
 
-		if (read_in_full(cmd.out, packname, 5) < 0 ||
-		    memcmp(packname, "keep\t", 5))
-			die("fetch-pack: expected keep then TAB at start of http-fetch output");
+		if (read_in_full(cmd.out, packhash, 5) != 5 ||
+		    (memcmp(packhash, "keep\t", 5) &&
+		     memcmp(packhash, "pack\t", 5)))
+			die("fetch-pack: expected pack or keep then TAB at start of http-fetch output");
+		created_keep = !memcmp(packhash, "keep\t", 5);
 
-		if (read_in_full(cmd.out, packname,
-				 the_hash_algo->hexsz + 1) < 0 ||
-		    packname[the_hash_algo->hexsz] != '\n')
-			die("fetch-pack: expected hash then LF at end of http-fetch output");
-
-		packname[the_hash_algo->hexsz] = '\0';
+		if (read_in_full(cmd.out, packhash,
+				 the_hash_algo->hexsz + 1) != the_hash_algo->hexsz + 1 ||
+		    packhash[the_hash_algo->hexsz] != '\n')
+			die("fetch-pack: expected hash then LF in http-fetch output");
+		packhash[the_hash_algo->hexsz] = '\0';
 
 		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
 
@@ -1925,16 +1927,17 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		if (finish_command(&cmd))
 			die("fetch-pack: unable to finish http-fetch");
 
-		if (memcmp(packfile_uris.items[i].string, packname,
+		if (memcmp(packfile_uris.items[i].string, packhash,
 			   the_hash_algo->hexsz))
 			die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
 			    uri, (int) the_hash_algo->hexsz,
 			    packfile_uris.items[i].string);
 
-		string_list_append_nodup(pack_lockfiles,
-					 xstrfmt("%s/pack/pack-%s.keep",
-						 repo_get_object_directory(the_repository),
-						 packname));
+		if (created_keep)
+			string_list_append_nodup(pack_lockfiles,
+						 xstrfmt("%s/pack/pack-%s.keep",
+							 repo_get_object_directory(the_repository),
+							 packhash));
 	}
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 74a2b7730b..0f05286de8 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1291,6 +1291,37 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 		fetch "$HTTPD_URL/smart/http_parent"
 '
 
+test_expect_success 'packfile URI preserves an existing keep file' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child keep.expect &&
+
+	git init "$P" &&
+	git -C "$P" config uploadpack.allowsidebandall true &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+	configure_exclusion "$P" my-blob >h &&
+
+	git init http_child &&
+	packhash=$(cat packh) &&
+	keep="http_child/.git/objects/pack/pack-$packhash.keep" &&
+	echo pre-existing >"$keep" &&
+	cp "$keep" keep.expect &&
+
+	GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent" &&
+
+	test_path_is_file \
+		"http_child/.git/objects/pack/pack-$packhash.pack" &&
+	test_path_is_file \
+		"http_child/.git/objects/pack/pack-$packhash.idx" &&
+	test_cmp keep.expect "$keep" &&
+	git -C http_child cat-file -e "$(cat h)"
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
-- 
2.55.0.openai.131.g83a728de1eb6

