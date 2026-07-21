Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE0433BAC
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676620; cv=none; b=fYEL6YwCopeX3CTKFff5WqP444jugB/11L5zcEfqhC0eJUo2fTpFGBTTCSC08Nv+CMsp6NyH/i02zLpCV5Svs+49pmiKhrYXEYAlkDg3/C1hOZZABpSoqmJGyXmIpvpTv4TSKNpqJjXu38R+eTAU56C5Oerc8uXtPDfn+BPIZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676620; c=relaxed/simple;
	bh=uGWD67MW6wYScfwvTn5vnH3dAuOQ6DRsntabHBdk/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkj4TgsvTSfiHmRuo236W/3orF49uxWuoHO6om38pThRJr28YzVvaHr6ZsAk5qSh6yZhuowUe/dBB2g1SiNbdpULGj/3aJOCwdIAGj4N+ewSyXx+O+le1DgvhBjWe7/kMzYHw/8gJIPEABp7NO0abMYoXVoFIMMVdScrTQ5Taqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fxiPnBgm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fxiPnBgm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e68de4f9aso184089085a.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784676618; x=1785281418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=fxiPnBgm8ip6ZqNTFWNRiSj5suFgyqIIWGK7vY/d/KwzWYTtJJV0cmaehm+fCEg9Xo
         4Nj9i0nAcot+tx5Eq+ULJwq/0xea9BNXmNypJiheMgm/BoH+xK50aH23jLwp+8yinPfA
         8qzYKkzzGYUTOGTgdfNMXxFC3ZENOgBylRkzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676618; x=1785281418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=GWOgtTBp0XOolI5Ch0N6NwQnpqfIPqLhksBm71e2HnYk3BibzZIgFcxW+yzX3/xRQr
         ZTGuNpS3CfHgVFy+VWJue9pRz7PwnkbBoMAiCOg7KY1+DtoGenEU90XkcnEirzP+cIHC
         2cqoCbEjCBNJ2tgChHgpYh66Hoq/Pknaba7/ZBs1hodGSohLVYc5S3J72Y6Uy+fppAiR
         ijpqh+ECn/woYdLR55ptknostae9mBd4wMEDgRzPBYPIm9TfDVSM9UM1gzWsamzyFXTt
         QqvRwHwCQXgt3E1ZjduCU8kvvAIeSnjFUE2UaU57XQyBPFzfHbj4kaFQSsiaKA7bHFNx
         gE0A==
X-Gm-Message-State: AOJu0YzGeOtlYkTN/dBTiUcMOZa41nelt9j+6lx4Zw40Xo0HFDKAbalb
	oNuY2GfirBT6mD3exAt+MhhIJWBOqqk5lQ9LU5ixp+EPEnM/7GCySRegex/pB5mIw2INjGJmM8I
	Bl2In4fU=
X-Gm-Gg: AR+sD10Lj2rTRogBDJZ4HmItk+r6Sx/aI4Y/mBWYUTz0csniK1664vGsgx9a+DZQS0s
	7/sF/JNhnNyQX5NBwdLczojz3Cubxe04AcBlQvOHTcw2ZDxngnwy3yCBpqn1/MHwpkNlJ6wRkDB
	MyckQG5a9bQLkL2EuKaFr7UVBSg/y1++62QOS+AGSYHMhMyJ6yIKY8tfDPuFxnrla0AzEYf9Itq
	YI/rnJrIxg29j3YsV3ZLTkKlomHpVlPqnAV6ZwN9gUlVom7QYftvKPQ2gJB84X69bkagN+WQzZ2
	8uH+f1m/SqFypoA1pjUNfogc99TabzSCw1M8hmyJKuHp+StCL0N643kR6cPKgPX2oofDo2nxliP
	BEoIP9D1xlQqXNRQiHzca4d6G1+R3ot6WFoq59M5BTLBTrtV5qWftXxQ40Fbl0uLW6Oa81CBkX9
	LYFdn737+vxVxf+wS5vAKZ5pYI5qpG4CsALBcOSftKgfOc5nLvyDGYQQvqqE3QsqR3Eg/dneVlD
	y5pn3u1CGZThyJLwA==
X-Received: by 2002:a05:620a:1709:b0:92e:705f:1626 with SMTP id af79cd13be357-930f458fd0emr105472785a.6.1784676617604;
        Tue, 21 Jul 2026 16:30:17 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0b2c7sm16008585a.24.2026.07.21.16.30.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 16:30:17 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v3 3/3] fetch-pack: accept "pack" output for packfile URIs
Date: Tue, 21 Jul 2026 16:29:42 -0700
Message-ID: <1ee5d7e02747e76dd044571379ce07bdc9c96c94.1784676106.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.337.g1ee5d7e027
In-Reply-To: <cover.1784676106.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com> <cover.1784676106.git.tnyman@openai.com>
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

