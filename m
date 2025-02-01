Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441A1CBE87
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441214; cv=none; b=PN6xTBDY+7qNevfXNZN1hFZz1BOQG0Ruu+QqddzvnHydCmvOf7wqs7cPNDgPAjkAb2yhIWkj6CiH1pDQ5ZWfUrCCAajGZpOx5xsFxSRTYiiq9xOpWxW4X/0rBlS0OnpYKAkXvsYGRLbtqyx6pTomEDzxQ+a5vHJthfhxrCEj2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441214; c=relaxed/simple;
	bh=gXJLtyvcSkqUbmZsllV1MYxcE6Vsp7c1nYHzdC/Runs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8zZc9GXLQ6krHD46RFXa0Pb/B+AB3niWND9ojpBY4O+5IcYCKApFi4CZdPVJtS5LkU4pgqS1Rc2te/SuUq7Ei9cICvbcarrCYg8/A/juMsYMxeeeXCoX0cC+KG4PYGvWzKOMp1bCnJPxMHREpl2uWVaKzpPQiSzuaNBXTHobRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSvOpNbb; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSvOpNbb"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba7784112so1711747b6e.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441211; x=1739046011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIAVxO/hyNcU2z7+EW7A4eD5X/AtlgSjbCbPT1g7Ars=;
        b=dSvOpNbbhIwIGCWzGGa2bEdhzCCTGmXpKkp8SKUEeouWDLtF+kDRRkwRDhxAh/H1kQ
         KOwPawkqsDI9P5hvUhTLJC7WQ8jryWx1HwLFQWpgkA8mtCwkY2BN0SAx4ZhQ/I1ixUkq
         cH6TRZw9f77E1WumJGrxlgjhcpSOyke5IN/qnRo/Jrl0WpF0aeWOSqA8xFnOUikxTvSz
         UeYBhmd6oKES7FncG+npgbhg+judXxi4fF+L/CbxVHwYxpTw0jTd5RXZusq6Jb2y8DZd
         hKU0Acjg8DxCaPJTaueoimWZJpyIDjb6hS4OOhIPZc+Ksw4hm+HmBf5Zg3EVgZVN2lFz
         RxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441211; x=1739046011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIAVxO/hyNcU2z7+EW7A4eD5X/AtlgSjbCbPT1g7Ars=;
        b=TeqB9mvRh6ZZuaogAjqi5tBK3SIDPGc6niynrzXlwAbtteRhJnpDDbU1oC/gYXC2qS
         5wJVia3306pGaOvjOS7ObfzsSJTw+qAk8fbMMkBhUNgO18CWQKWpCZa74U2DQ9t8rXVX
         ulsQdtDK+pGZr++sL3qwo4G3/KdpGDSi1YLBBaJQ4pUGHNjilF1lZFGiwIVcJRTt1HZz
         nXJ+rgr2raR2zj0VDXxMJv1YcauCGauZSDp1PTmx4P/Wox9VaPkCnn4yj4+CX84JDnpc
         fe7qfFt1kU/VVTjQd5Aqel6ROBXnAzVWcMSwq3ZWCQlj2wk5dtF6GeGaTPvbxDWvpzcR
         H33A==
X-Gm-Message-State: AOJu0YxcYaG+SGHy4BM1EOr+Y/5qHhgThbvkKPz++ilsDp2hZ9TZMuDq
	R8ouW4WHfeZPCEaFAk2GKJ5/tpdWDVlybSm9bdVTf0EDmYx1Lv5l/ElBtQ==
X-Gm-Gg: ASbGnctu5ucvij4WjTpkzYVSPZfhNFMQJfbEZfkcm41Kffu7IiMCnIQcXda7XR9VyCi
	UFEYSGL6n6AZl3ATa7kIIC0ZIsf5Hfh0Pqd1axhPQqtFi6Rj8+y3BLPIlu8J5VHriGV+tbj/Faf
	Ca+6nHkHZzxWUtBF/npOl7oWe3AOl7C/Aj5JjMw6i/dKtej1oA901FosssbczIChMp0MJuf0aAa
	XKQmhxz2IOZQ1lnpVB1e2CUoRqOzfmTmBgY65Naq050KsSG/5/NLMCW6q94aQLe200CSVgoPpYr
	R7jI1xFXe/Ed0N81gHxJgfI=
X-Google-Smtp-Source: AGHT+IF/FlOhYcGx6eZ6Nfx5183fOXEfpY+1muZjjhn8P2LtI8hh9oH6J2Rv7DWJfD4QxnHp8bihtQ==
X-Received: by 2002:a05:6808:15a4:b0:3eb:58b5:8614 with SMTP id 5614622812f47-3f323b674fbmr10215498b6e.29.1738441211650;
        Sat, 01 Feb 2025 12:20:11 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm1588336b6e.0.2025.02.01.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 12:20:10 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/4] rev-list: extend print-info to print missing object type
Date: Sat,  1 Feb 2025 14:16:58 -0600
Message-ID: <20250201201658.11562-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional information about missing objects found in git-rev-list(1)
can be printed by specifying the `print-info` missing action for the
`--missing` option. Extend this action to also print missing object type
information inferred from its containing object. This token follows the
form `type=<type>` and specifies the expected object type of the missing
object.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.txt |  3 +++
 builtin/rev-list.c                 | 11 ++++++++---
 t/t6022-rev-list-missing.sh        |  3 ++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0bea9d4ad3..f10f78c600 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1038,6 +1038,9 @@ one of the following:
 * The `path=<path>` shows the path of the missing object inferred from a
   containing object. A path containing SP or special characters is enclosed in
   double-quotes in the C style as needed.
++
+* The `type=<type>` shows the type of the missing object inferred from a
+  containing object.
 --
 +
 If some tips passed to the traversal are missing, they will be
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4a45a4e555..963f96d031 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -79,6 +79,7 @@ static int arg_print_omitted; /* print objects omitted by filter */
 struct missing_objects_map_entry {
 	struct oidmap_entry entry;
 	const char *path;
+	unsigned type;
 };
 static struct oidmap missing_objects;
 enum missing_action {
@@ -109,7 +110,8 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static void add_missing_object_entry(struct object_id *oid, const char *path)
+static void add_missing_object_entry(struct object_id *oid, const char *path,
+				     unsigned type)
 {
 	struct missing_objects_map_entry *entry;
 
@@ -118,6 +120,7 @@ static void add_missing_object_entry(struct object_id *oid, const char *path)
 
 	CALLOC_ARRAY(entry, 1);
 	entry->entry.oid = *oid;
+	entry->type = type;
 	if (path)
 		entry->path = xstrdup(path);
 	oidmap_put(&missing_objects, entry);
@@ -143,6 +146,8 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 
 		strbuf_release(&path);
 	}
+	if (entry->type)
+		strbuf_addf(&sb, " type=%s", type_name(entry->type));
 
 	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
@@ -167,7 +172,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
 
 	case MA_PRINT:
 	case MA_PRINT_INFO:
-		add_missing_object_entry(&obj->oid, name);
+		add_missing_object_entry(&obj->oid, name, obj->type);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -844,7 +849,7 @@ int cmd_rev_list(int argc,
 
 		/* Add missing tips */
 		while ((oid = oidset_iter_next(&iter)))
-			add_missing_object_entry(oid, NULL);
+			add_missing_object_entry(oid, NULL, 0);
 
 		oidset_clear(&revs.missing_commits);
 	}
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 38afca6f09..3e2790d4c8 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -164,6 +164,7 @@ do
 
 			oid="$(git rev-parse "$obj")" &&
 			path=".git/objects/$(test_oid_to_path $oid)" &&
+			type_info=" type=$(git cat-file -t $oid)" &&
 
 			case $obj in
 			HEAD:foo)
@@ -184,7 +185,7 @@ do
 			# get the expected oids.
 			git rev-list --objects --no-object-names \
 				HEAD ^"$obj" >expect.raw &&
-			echo "?$oid$path_info" >>expect.raw &&
+			echo "?$oid$path_info$type_info" >>expect.raw &&
 
 			mv "$path" "$path.hidden" &&
 			git rev-list --objects --no-object-names \
-- 
2.48.1.157.g3b0d05c4a7

