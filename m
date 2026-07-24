Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A583CC334
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880870; cv=none; b=LV8l+pOpnVcU61LQr2UXWHm/tQbaAE+IvSE8CkzRRypH9nPSGnM46CtuItqR77/VdiDHDZywfFO5ahNk/BW8WPtQgJA2bGhLDVRLUMuUMWlfYCo9W8i7fHijg5zCCl/jqHNCjwvE1bwMSMSzljtcU2/QTPO51kFVqoWiaVaFSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880870; c=relaxed/simple;
	bh=uGWD67MW6wYScfwvTn5vnH3dAuOQ6DRsntabHBdk/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+JKjN7xlh2jE786jqCBhuPsY2dztqtcu+QRcguJABqp5IC8QGWzNdgD2AO8y8bbfP7nkLbgvXcIz+v8SionFtVScsR4H+3OGLEiKVawK/b3/37asZewAX/CSQFwhQhwSHAOZGEblisSCLlmg46QpIIwEzWY30CGoRhIMdTONYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=aX5Tuh2Y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="aX5Tuh2Y"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca6bda96134so7947a12.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784880868; x=1785485668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=aX5Tuh2YCJxYrs6mECGefb3ypgkyuSY86Bbyga0Jnmd5D0WDMYif+izxV21nCYpgWk
         sut9qP6eLFtrcdDVZVEU8AgYpktdnoCaRZJL0JCk+ooA7sJmO/j5m8GrqLRA7pAaEmRr
         cAs+mdsiyDodfczHN6zYJ4MQLQQuZgn3ac5ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784880868; x=1785485668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=PTVK3JfD1Wj9HyUS/jfTJzwEMWMPc0Rs5t0ih3Ok1JobAeQMLFefDfmY2pcxPhLmyG
         L4DUNuwG8r5n+v4edv15ztKfFmFXPNca7YSQobqcDvKmdjeck3JxX4WZMbSnRxyYHbx9
         HhDAd/HyKN5dTIAK4KoHqEQkKohJXSILo/97uO/SF+cKr/4fvUqWewgTeN4TG9yx5tHy
         Ee5fKd3Oyrl8cRQkDInlfoc9g7h6mzB4OJJWwoTNImWbBnUp5eOor/zY8Jn0tLNoY9gi
         7k4WvkKFsugWr+qF9JlqzMPCZubPXbdYxxSCmLk817Nz4zL10DL8NWtjRwOqt/KBqizF
         m5Qw==
X-Gm-Message-State: AOJu0YyeYG+jkXKsTl8zusFm6EIrMQ4W1SdMvlbaylMwfTsCaAxs1ONV
	KN5qpCd278Uo63BCFFe+rowVxjLb6vniMGDZxFtt3G6WwDxukJWSCfDY8clO9zN8iX1JO8czbUl
	gwMFHd9s=
X-Gm-Gg: AR+sD113z6XcD6zlkeuJbHbD0SAJOAiA9aIYKilkpeXHv9VIdaqtVwuIrXJfHL5vKtX
	4NqWrMFgo2zjW+OVa5AnFJ8iRKaRLTTTJfacoD9h52jibXuxJuaNIZlzX9+eyPBrSan9kgQ2Od+
	9/fIEm7noIv0VV1dcurkdxVL79AAnfZj/cNzpUZqw2beErwnL6yp7YHjrlmrkTJ7pRCo8ZH6rdw
	6Baa8jsJnSjNKZG6H1lO7EaqBdA8wdMwVUF0BD6Yl4GBrSorQxapeSJNRWfEdjlx4xYVuxoU2ZV
	pTXAGqGjQ9Dqeg1AshSUS95SGIqeesoCvXvvMfrg6hbVJuROO/Gda1fWCuemENG+j4RTlVAfYqG
	Cee51Jisuv+DsCoumA/SdKDsdaaAiV02NYhyMjJgu9XUlyJPnxnzvk99bEJ5V3ueCSKNGwYKVJm
	gRDClqeVeWEsFaK87c+3Q1L9CZXKn+12krXI3EZ6LJbx0DKQsBxq+YEhiegdJvfQIJ0jBWyIfLb
	EZriRW77ZL3mA4=
X-Received: by 2002:a17:903:3d07:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2cfbca02135mr26697045ad.2.1784880868038;
        Fri, 24 Jul 2026 01:14:28 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm26218810eec.0.2026.07.24.01.14.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 01:14:27 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v4 3/3] fetch-pack: accept "pack" output for packfile URIs
Date: Fri, 24 Jul 2026 01:14:25 -0700
Message-ID: <d9063deb60354eb731e34c453cd6730e1098f905.1784874850.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784874850.git.tnyman@openai.com>
References: <cover.1784676106.git.tnyman@openai.com> <cover.1784874850.git.tnyman@openai.com>
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

