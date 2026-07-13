Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFF33469C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982089; cv=none; b=QDJ1EXqP4hItqlt8GOCdUmePtWZ9vTF+s4vWvql78JZwqoWUHQ1Q656yh4NkM2zP2I6PxKSng8G+iPGDlSwzFHYyc0ELQqdwKNT0a/yOSr/MTd1FkiI6CPNZlJiMw2LV2e1JGAbvJ4/tbZBmRvucZ8lNXzlvM//BPCzm8o4F8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982089; c=relaxed/simple;
	bh=/5DGYDFvSyGQH0SMJ04Br+BcQVZU69DpKcXKmplXAbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y99QgIHOv0qIvCUr7UHWOy+q6Wif14XwPI4SM1r3bt5XR0x5AzI+Z3O91g+UATLZ3VvN+v8ssM5fkCOtDNQ7GoZpPIc4SE4Lh1AdBR6lmewQgl7ybNApJBs8q2H3LjUXdjmG/NJvOoFgP26IMITsa2qPVnPGNNYZu3sg4ZMSCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SGsOVytd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SGsOVytd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e552471b8so36713985a.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783982087; x=1784586887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmH8F+iAie6MENpTgA+JkfdQ8OQHq0LnuYIh0p+mjJ0=;
        b=SGsOVytdWAhZUtotIzigN+bfTdHEXYFKxk/Tq7BhizOFabnT5ggc5Y42cbCGCEUL+M
         fQJYPUvXaQen0CG6ImneLPX0U74jJTuSwrsyKeZ5eUWivgN+mseSAIEAyxuTgob6LL9d
         Srb8lB2cBVzJd1EorWBqIlWcgFryx6BqI0Rh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982087; x=1784586887;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmH8F+iAie6MENpTgA+JkfdQ8OQHq0LnuYIh0p+mjJ0=;
        b=HQgMgeSlxcg9g/dQypa7ol7vcJxbqfB1AI3CvekCTw8vKvAZW6fEtlvT1oFPHlCqPx
         YHK/vk1gLM+eICBXv7bnhjUBTwC9/MtJskLt0AsDfI0Ifw5xlSMrKvDfdE13qW++AES7
         ajAA4/59I2dLz41eBz0p5UbwG6BiO8lpGH2USJlHxoSdgdo0D1Xqe5KLSUOdZnUyodJx
         QAe8QRy5a3zv8lKCuZB2hzvBSNKBYUor6pc9XRvgQxuDYpPcYmnUiBk+XnABcCmucooV
         5b8ex/VwBTjKJRGaGzc1Z5UvOD2MGML9k1EdbUdmKFATgIlQZZf80Lse/HUOPn1+eeNa
         7k8w==
X-Gm-Message-State: AOJu0YxTXrvwgL+Ja8SPP2vn2WPA7lpf+pOycSpPz2yjOeTHlULWZytL
	i4071QrArbKH+Ln2GBMoz7+dLQC+E4kfEshKuSEyoGkwFIR458ckVDS2tbY+YciytsX8SlXptih
	KuiwhjjA=
X-Gm-Gg: AfdE7ckxzMwdJi9wV4DSneV7zJ9IX9zgwrm/oJceODh+Ed4FDDklsRTthUjqP54xoBC
	aYiW78a2q5n5v4HDXRm5ZivlQgIZPYXT/XvJ+AIn+8uK0/1h7Wvz9KZaqnJaozBshk6suD2dWnM
	ZSXS5D0XEZ2Aet/Tmc4ntvvkEpHqZBC5MqekcIIcbAKNHdem/Y0I9nozpUaiGhSVUz2kRrBcj2T
	sglWad6GfYyJoeIOtbW6vkJAyF2ZyRlfZumfCB0AgS9crMkMw+mKKMGcfZWHta/yN5MKg0MF3KB
	5vTwFfPvkwi/J4NhtJmW3Lb9Ha6WJwcYyDgqBofBACMuPltSGkibQosqcQAku6prXvhvM1bH+48
	WSp8m9u4kBjhFVLnSJWtlT2Y7zPENcI68hmSSAekywU9uPk0DCJH8OziyjMyQ+GTbg5p+BIV7X5
	C0vsWj9mtMb/K83C/g0/sF1TVqXPr2xx3Q2U+XxjarVfoqHw2tFYoCrOJCySBjcK1rWTFO
X-Received: by 2002:a05:620a:1a15:b0:915:6433:2599 with SMTP id af79cd13be357-92ef2b10cafmr877917285a.1.1783982086896;
        Mon, 13 Jul 2026 15:34:46 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b93387sm1344000185a.16.2026.07.13.15.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:34:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:34:43 -0700
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/2] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <alVoA5-fDDPwKPZZ@com-76773>
References: <cover.1783982021.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783982021.git.tnyman@openai.com>

When "index-pack --keep" creates a .keep file, it reports
"keep<TAB><hash>". If the file already exists, index-pack leaves it
untouched and reports "pack<TAB><hash>" instead.

Since dd4b732df7 (upload-pack: send part of packfile response as uri,
2020-06-10), fetch-pack has accepted only the "keep" form for packs
downloaded through packfile URIs. A concurrent fetch can install the
same pack and create its .keep file before another process reaches
index-pack. The latter process then fails even though index-pack
completed successfully.

Accept both successful forms. Add a path to pack_lockfiles only for the
"keep" form, so cleanup removes only a keep file created by the current
process and preserves a pre-existing one.

Add a regression test which pre-creates a keep file and verifies that a
fetch succeeds without changing it.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 fetch-pack.c           | 36 ++++++++++++++++++++----------------
 t/t5702-protocol-v2.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..a16b80177a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1887,9 +1887,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	for (i = 0; i < packfile_uris.nr; i++) {
+		int created_keep = 0;
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
-		char packname[GIT_MAX_HEXSZ + 1];
+		char packname[GIT_MAX_HEXSZ + 6];
+		const char *packhash;
+		const int packname_len = the_hash_algo->hexsz + 6;
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
@@ -1907,16 +1910,16 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		if (start_command(&cmd))
 			die("fetch-pack: unable to spawn http-fetch");
 
-		if (read_in_full(cmd.out, packname, 5) < 0 ||
-		    memcmp(packname, "keep\t", 5))
-			die("fetch-pack: expected keep then TAB at start of http-fetch output");
-
-		if (read_in_full(cmd.out, packname,
-				 the_hash_algo->hexsz + 1) < 0 ||
-		    packname[the_hash_algo->hexsz] != '\n')
-			die("fetch-pack: expected hash then LF at end of http-fetch output");
-
-		packname[the_hash_algo->hexsz] = '\0';
+		if (read_in_full(cmd.out, packname, packname_len) != packname_len ||
+		    packname[packname_len - 1] != '\n')
+			die("fetch-pack: expected pack or keep, TAB, hash, "
+			    "then LF in http-fetch output");
+		packname[packname_len - 1] = '\0';
+		if (skip_prefix(packname, "keep\t", &packhash))
+			created_keep = 1;
+		else if (!skip_prefix(packname, "pack\t", &packhash))
+			die("fetch-pack: expected pack or keep, TAB, hash, "
+			    "then LF in http-fetch output");
 
 		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
 
@@ -1925,16 +1928,17 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
2.55.0
