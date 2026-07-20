Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713583E9F93
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586850; cv=none; b=gX5GJjS8BAOMrECYJ8qM91WhSNzSm05jzFMr2w3qWPbFMgjEiZjSCOvvEbfc2kB79XCMIXjtF/dqmj9D5PexIRTuWzPyu1aPrfJAKH1kd4B4iUggwNbjZAIpo+sG9N8/nPgho6cBjkVyQkVT6AeEih8RictPficyh4g8OmUiH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586850; c=relaxed/simple;
	bh=dDh6YYMsuFEPhSx7JmcXrxh7UYtUQEKywA5MGeajkBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liMb+x1Vkqoti3GjIe0B5dwRXJ5sUYZKW5n3JkvZKVxRrwFxJnyyTUQSA6JCIGBnfrVFyWUKldOyngZQvZ1j9JgfRcsiXbwb6pRKEtQf7icQzKJtsP4zndU4lqC+2Funb/erVyrQYY4/2pAsakscVAbcqSQ86OsHtRavtUSebww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bOMaXRIl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bOMaXRIl"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ef5f7fadbso106244085a.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586845; x=1785191645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=970JYqXaOH3h19Qa0O6W85iodT7umhIahN9uWWq2Jro=;
        b=bOMaXRIljOtLr0M8E8BnjBU6+Rd8pejNX60Y5xzry083zD8yWEAZN5i03D40m3IKBA
         UbM8hHgrnd/pxxSgyGmuq6zDjgXZSIpGkhg5TVCvSiqkRhrd3m8ydD0xEfb+sPxoJ+jt
         I8sWS+bqu01lr0M0C2KYTAuM+35rysrPrw4N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586845; x=1785191645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=970JYqXaOH3h19Qa0O6W85iodT7umhIahN9uWWq2Jro=;
        b=gzqjivt1N7T5m2XUV3EVtUihKk4+ZATqQCSJ8RgMyFAImscTPXQ8XpRYfLSi4nXkmm
         pVn7Zadg9GocwvgN/rJLPWfWqbR7hKSUAbGK/NVonPblgNTYgLNVcwY5HupXMohc6Bx0
         5og2mAPL8YNgsfss01RI4HzDvSqO5A7xovmSRHKhVsMZVClUlz513lrWPo5Yz7y4lZkZ
         3C4++v1aFMjPfykG1aiLQ/fwoMlmXTzUsKQYV01NEH90FB6CLfEOWmrUQ82dzWtJ3aqO
         7F4s29xtfJYesDg8LrDQpGEOUhWTW1XlYeEmMzO9ASTcvT+BqYt4cOi7qg9ph9tfPjXQ
         gYCQ==
X-Gm-Message-State: AOJu0Yw7MwpbZOPAituWQxVYwjlmzjJmNDheG/7unN0KWX048ZIPnTIU
	T4rVS5PG0dOcArgIBYo47uYEjL54aeEqmKJe+Cx05w8Kdby4WjASGRlhBZv5+fyksOxOs4huPzL
	BD4jcjPY=
X-Gm-Gg: AfdE7cncfC3xNChSjT2HJ8HIWUgio6cfhirZsfY6GFJoR9x2VOQWUoTWOukGZT9p86+
	eaorpuE4AC5se7AoiVEeXgBntUrboeKQdls/0QgMfp6O54KS7paerHQRym7d0a8hZDLLh4cHvUk
	aPOstwE0ledZIVesSWJLHJDLdjx3Qe50Hm4Nj22X/wC9DnQZ8MFrnrMvI1Nx70e7clsGaNuSDbU
	+vDHHCsDC8+R0XEFyVQjcjnwG/WUCM6jw0X0cY5or9FI9X0Z6h8+6/UwPI+ky3pXb9FqYVzakuX
	8AbrQ+gTjbOEThf2wiOs7efOBWzGcbp57S36RMUdQFO0jTXkFc4IHO1/kmbrM7CC14WL3/pJoKZ
	TSIChmZnxMtLNQQIO7u4205srsOKWEHKG7BpBCKQZUqIz0ENlCxGxuXWd21YyV1DAU/WAJarM4x
	wOR2KUefrnTr047V8bjSuCstF4tGsXfm0b/d6BGfKyZ1nWCxX+ijZYrgp5SWgJrb8QqNBnOd85O
	Oiksig=
X-Received: by 2002:a05:620a:2806:b0:915:7c1a:1388 with SMTP id af79cd13be357-930e7086dccmr79146785a.5.1784586845418;
        Mon, 20 Jul 2026 15:34:05 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542dd27sm972590185a.29.2026.07.20.15.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:34:05 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v2 2/2] fetch-pack: accept "pack" output for packfile URIs
Date: Mon, 20 Jul 2026 15:34:00 -0700
Message-ID: <9b41d4ddb38a5d7d4cc84f5626d6a031155f8f05.1784582665.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.125.g9b41d4ddb3
In-Reply-To: <cover.1784582665.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com> <cover.1784582665.git.tnyman@openai.com>
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
index 120e01f3cf..509b91527b 100644
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
index 9f6cf4142d..1861eb7d7c 100755
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
2.55.0.125.g9b41d4ddb3

