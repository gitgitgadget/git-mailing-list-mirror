Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA672771B
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112155; cv=none; b=RO8dn9kEgITeGPwz2pOupS40+Qvb6eQkYYClp52QLCkzRJmXqvi/w7lLWNWh+T4fPakmTNFTLYnkyM2BgvA8Z/ApRhx/YaH76aTHz1syQBZJhk65KhGJ5Od7Tj2XgoQgymBQFFLRKjdAq9OcztTiHyj+I/FV0GjgTxO75Vd6az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112155; c=relaxed/simple;
	bh=uGWD67MW6wYScfwvTn5vnH3dAuOQ6DRsntabHBdk/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0OZprNi2YEDzZeyj8L7Bl32ogpkfU+QnC1k4WcrqIkgZzClGyyDrjTLRm0njqsZIEwrSFuSFQk0ZU+NLXW4BznyoprgF7ChP6UcQn2x0D6j5bUOQDrwflEns3H57yGdsGqncV1sgpgmD0Da0oZ9Cn88kcnAxobWi+ItRI1iSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Sffb+xTg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Sffb+xTg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccae46de39so3178625ad.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112153; x=1785716953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=Sffb+xTguxXnJ6OC8DKafzT0/99WKPV91HVBdEnaGS6FaC/uAeEr5OtKIPHdKgY4wN
         D3O3cTClA82l/1wpM26EmO73N/yxbrlLN5uqOQWw/O93fgFk3PddRk7cwX0/Un+6/tKu
         heQrVkJW7YrcDzK7TQYnOYPuAJi3WurrdZajQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112153; x=1785716953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qwRMl6vimJZ8+A5tlbsP6yLxFvWRgz0RRj/KprB4qA=;
        b=aLYRglAS2ak/yCpDLmXsY3R3uGgvnBBdARM9uslcBsha3/F77e+rlCaQQ6RxsWzTYk
         jTMPn2olYg7s6dDKcar9127S230n/Nkiay+7W98EVIC4oh+5V5uxMmH3DMqDQJ5vqiet
         3v2qvusKbDkJsCW9GkDEoQ8yDGZWCe8TsdyMkSoHSUD6jI1orDZnJ3RU5LGSbIelbAPV
         2Y9mVC0oFKqi1rM/FxcMWYCP/f5LRIyJZW0yw1q9+ZK/JTW8V2Cau/d8sukrlWlbDx3C
         zdiI3vRf5zKKUlEee6TnfbHdbNn4pdP5WU3U308Lh225C+p339wwIz7CnLMGoJxffmoE
         zmQQ==
X-Gm-Message-State: AOJu0Yy788N6xH8w0y5BW87n4A6xtBGZcpdzottTy7rDgp9AgE/Nw9zu
	A4rvfuGxTH71ZxSotmFfVaBwpX5rS8fZJwcNjIVLJyOnaIpVp6ND9KRb9xQcadZ5My+7T5dowBx
	rwfuAci0=
X-Gm-Gg: AR+sD12WbTPdx+5dobPDzUhC7Mu/Ra+yTpfuea0pnAB9gsQQiddaFGxADnidux8OjSE
	4dG9v2p+whU8Q++os4v2E7kk6XCUTRTRIMBVSoN4Hxq7jRw2qVcK8/0pWUuSuShTjWIq6pBDwce
	sQ5wCpeZFQ7QrsoHRFCCUbz0nUpcLSEvdh6YUdsvOtINBANN6zYzwJVnURUKsndK850juI90G3j
	cH+0gaYvURkl9krrMWFi5ijLL/gBx/exXlZUTAzU807e+duQ2Va4fI+uriVhwxf6L+5Gl+B9pFS
	CvvzNTP1R2oDqQoTzjhQjLg+8EEZFJfB1UMkN4zqvpsrD3tkvzWygBN0EhvtyGnYIv4osJDgWj1
	PK0qNewepn6LdDXhk6BgyQwrW4YjticbnHuv1rIOuIGZrRUd3z8Hp6AvPFzfj3LZPwhah02RwPO
	dF2EaPpOZm/Aoiqz9RT5T/fFfk20t/YMc3Tq4TE6FjES/K2h5cvvlc4uuqRTPtIso/p9yZ6508w
	PLuX4bP+kdWlI+FQQ==
X-Received: by 2002:a17:90b:53c8:b0:381:2788:a437 with SMTP id 98e67ed59e1d1-38f293cfc02mr4573867a91.1.1785112153230;
        Sun, 26 Jul 2026 17:29:13 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:29:12 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 6/6] fetch-pack: accept "pack" output for packfile URIs
Date: Sun, 26 Jul 2026 17:28:43 -0700
Message-ID: <be9e2fe2735124ee16e2c87fc3aaf3d37dde416b.1785111375.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785111375.git.tnyman@openai.com>
References: <cover.1785047139.git.tnyman@openai.com> <cover.1785111375.git.tnyman@openai.com>
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

