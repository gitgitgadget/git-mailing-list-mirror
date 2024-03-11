Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3356B70
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183371; cv=none; b=YRaXqqd0ynF6xLyfON+eFpWe8Eq1yH5Y5ncMp2ccGsa7HhpWCjZ/YtVWDUgMD/CLEW6q+5edOr3FJ+zFMNMpgxyGO9G0isyQ1NTvnLoFhPjdgMkI7wBkVSu1tJaHP6T+fR+u4BYI8RgdZajV6djtBHxH8QSuczXCS9rIPRwhLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183371; c=relaxed/simple;
	bh=B0UK4xFeT/+jAnON+ggJ0ncjHxbPSK/Dq2087FliE9g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a+wymOb1nEkcihn5uQQwi1+mxyL4pkAxnxZPgYIkJhv6gZHjWt4cmQRJ83awYTpWtSrytmws1U/ZpCPnXqx6jILP7I+Vg+gaqf6h8GS8ZjoqoxR3iYRuusw7kygeNON01+sBPOljIj+NSsF2PNIaWojHJyZp64oKIpV05CV2gDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT8ceJCK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT8ceJCK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4132f780ee2so4869245e9.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710183367; x=1710788167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiNmcppLSuZ3kX5OqT4X52QIqiQ8P8ajK3HwdVXTiMM=;
        b=HT8ceJCKVlTiefaYgpCpgicjLlCC+r76nkstmFeQGSID8kX2PdD6ODdu+GCfvk81aR
         zKx8tgyrDRAix/rxTpiQu5lQmCyK9Zldh7sjwpYZ/zTLMX3fUnENpWd2Zsn2OopgHe/t
         YhD3jBS5AalSLc539ujgMgKtE56AhysoGlhcIFl8g6zpyDPcCsAcqKlOX+a/HDsNVDNv
         ME/LQxPXD4r/cBQ8w+g5x7k+2GdgWYobHtfhaCi09F2JYJ8UWILIcARcyvLQEXDDV1jk
         JnfNdZ6CZH1Uf24UeMj5ormoUWkK0/7vwdLCRQxywYA0P1Dda0vmwr/EK2vVrVj9Un1e
         w/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183367; x=1710788167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiNmcppLSuZ3kX5OqT4X52QIqiQ8P8ajK3HwdVXTiMM=;
        b=D+F01aTJCbh5PCt8+6dLkqNa9h3/2PvS1AQGlU0w/mbdkD32lneFn7WRuVW++m7dIP
         shmQTOpP88dxbNuesnL0ImfulXyHcjXaa0/lHVweppHB/7PfLYvX9/oU8gdrsnbvORtt
         UtimKjnHYTr/Er1hgLIGiccQqJVTjWyglp4z8QIfJIHay/21zisJrBlZ7naLtiaXB95q
         7i7l84W15vNs6yz7xFw0KlJVNmEI6T722iC8SBKR4z/5JLfq8MxkE7ehpRj7wfqtPtuB
         THjcPE2Lq5FfZPofRLEQcz9yWG0/9mTbnPf+WH9NEcgqPLnpnSHizwO67jol07mib/sc
         5NQw==
X-Gm-Message-State: AOJu0Yw4NC9JyPuwSFBK7Cm1q1/ZQY8P0DX4Toonqc0wMyK1Of7Z5TtX
	qFQiuG5l6yLHJgHp0JVLOwYy/g8m+I8BfW0UL4keLd3MOdo7Q+yd30YhimQ5
X-Google-Smtp-Source: AGHT+IEQdIyiD9t4oGoKpcrvH+XGXQ37IfzR94vy/+QFZK4fSbPGM8XkTG1zUr9InPBfWn1+4xY1wQ==
X-Received: by 2002:a05:600c:4fce:b0:412:e444:133a with SMTP id o14-20020a05600c4fce00b00412e444133amr6795611wmq.20.1710183366164;
        Mon, 11 Mar 2024 11:56:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o27-20020a5d58db000000b0033d640c8942sm7093378wrf.10.2024.03.11.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:56:05 -0700 (PDT)
Message-ID: <951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 18:56:02 +0000
Subject: [PATCH 3/3] cat-file: avoid verifying submodules' OIDs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Submodules are strange creatures. They have OIDs, but the corresponding
objects are not expected to be present in the current directory.

Let's teach `cat-file` about this: This command should not even attempt
to look up those objects, let alone declare them "missing".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt |  5 +++++
 builtin/cat-file.c             | 32 ++++++++++++++++++++++++++------
 t/t1006-cat-file.sh            | 10 ++++++++++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index de29e6d79d9..69b50d2042f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -412,6 +412,11 @@ Note also that multiple copies of an object may be present in the object
 database; in this case, it is undefined which copy's size or delta base
 will be reported.
 
+Submodules are handled specially in `git cat-file`, as the objects
+corresponding to the recorded OIDs are not expected to be present in the
+current repository. For that reason, submodules are reported as having
+type `submodule` and mode 1600000 and all other fields are zeroed out.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 73bd78c0b63..c59ad682d1f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -128,7 +128,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.type_name = &sb;
-		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
+		if (obj_context.mode == S_IFGITLINK)
+			strbuf_addstr(&sb, "submodule");
+		else if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -319,17 +321,26 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (!data->mark_query)
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
+		if (data->mode == S_IFGITLINK) {
+			if (!data->mark_query)
+				strbuf_addstr(sb, "submodule");
+		} else if (data->mark_query)
 			data->info.typep = &data->type;
 		else
 			strbuf_addstr(sb, type_name(data->type));
 	} else if (is_atom("objectsize", atom, len)) {
-		if (data->mark_query)
+		if (data->mode == S_IFGITLINK) {
+			if (!data->mark_query)
+				strbuf_addstr(sb, "0");
+		} else if (data->mark_query)
 			data->info.sizep = &data->size;
 		else
 			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (data->mark_query)
+		if (data->mode == S_IFGITLINK) {
+			if (!data->mark_query)
+				strbuf_addstr(sb, "0");
+		} else if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
@@ -448,7 +459,8 @@ static void print_default_format(struct strbuf *scratch, struct expand_data *dat
 				 struct batch_options *opt)
 {
 	strbuf_addf(scratch, "%s %s %"PRIuMAX"%c", oid_to_hex(&data->oid),
-		    type_name(data->type),
+		    data->mode == S_IFGITLINK ?
+		    "submodule" : type_name(data->type),
 		    (uintmax_t)data->size, opt->output_delim);
 }
 
@@ -470,7 +482,15 @@ static void batch_object_write(const char *obj_name,
 		if (use_mailmap)
 			data->info.typep = &data->type;
 
-		if (pack)
+		if (data->mode == S_IFGITLINK) {
+			data->type = OBJ_BAD; /* `type_name()` does not know submodules */
+			data->size = 0;
+			data->disk_size = 0;
+			data->rest = NULL;
+			oidcpy(&data->delta_base_oid, null_oid());
+			memset(&data->info, 0, sizeof(data->info));
+			ret = 0; /* no info to look up */
+		} else if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
 		else
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 6f25cc20ec6..3368b663ef3 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1178,6 +1178,16 @@ test_expect_success 'cat-file --batch-check respects replace objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'batch-command with a submodule' '
+	printf "160000 commit %0.*d\tsub\n" $(test_oid hexsz) 17 >tree-with-sub &&
+	tree=$(git mktree <tree-with-sub) &&
+	git cat-file --batch-check >actual <<-EOF &&
+	$tree:sub
+	EOF
+	printf "%0.*d submodule 0\n" $(test_oid hexsz) 17 >expect &&
+	test_cmp expect actual
+'
+
 # Pull the entry for object with oid "$1" out of the output of
 # "cat-file --batch", including its object content (which requires
 # parsing and reading a set amount of bytes, hence perl).
-- 
gitgitgadget
