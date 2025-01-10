Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50804290F
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487538; cv=none; b=GQnAT2rstepy0Pcc/jGDj6P0xefZJywaiD1k6VtpRnUgQNW1ZM/QMpwpORgKIesBQESikuyspj5ZLeAx0zv01XOuyIvg/YFNsc7cc8D3h3PHmhAeb61XAXqAEPqSjwhTmRQmwBp6bjgSTfRgtCgXfmU7oaCVoJmXOgQz9boxPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487538; c=relaxed/simple;
	bh=6mNQ2PCKpSn6++Tn7XKdhzcvfPmj97Te1VmHtjIuzXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naHILi42DgbcCF7RdViaHc3Cu9cEx8P4yRIx+YNHQ8SFs22gkJ3OUp1Z6jTjv5Fo1a3skkou/9WdUdZGwysR0bHBHElEMEpYR+ww8qzIq6axV89tjA0udIv6Px9zlxfhbtFzGWRJBzFrb5XHI2DMQxrG63n6z+keR0PnueM7EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlFJ0607; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlFJ0607"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e287897ceso1089238a34.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 21:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736487535; x=1737092335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbHFNln+TpGz9fgihu524n+AEzNm6pRmISxwHO1ZPcE=;
        b=jlFJ0607cbkYweYbNsRjN6f9uPOf6EGan+sxmy5pePIs6dezUUPDM5ncCJ/sEoD7um
         wgL+93wr7L4bmYkAHxD5vgvEd4IRSDX/mQPJmXaQiyU0Pj5jFtQ4BWkhINZvaZHx5YAH
         J3Y0z0ujvl2Kcx44cZkEjepvpBa35kQqOZ6kfQ/gMCX6b0x+R3Q5cFbcWu5F9t399sOf
         4M7IVM9qkYrZJqolCsnbnU/dWTX4o6SHETE/15PyTtg16om4eVUtsqSwO/l46QDyn0ZC
         7TuSlnD5+tyfb537e9BLgfr4cq1bwQXM/1nNgFWqEDmxCkOFRYpPmrdY6KDkGiQfL+X8
         TM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487535; x=1737092335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbHFNln+TpGz9fgihu524n+AEzNm6pRmISxwHO1ZPcE=;
        b=li/eWTkI0UCh2WDdM2A+CksW7UA0NS1YYp3f/y7Q6tS1LbcvN4nSAPJPYRAxlwGj62
         FOgE5hhe7qNmMumWXR1/PFUJzqgbm6LV/Vm1jwxC4FOzONfjQ3Ol9NTq+935VsdTVlIo
         PoeHlIFrohH9XyKiZQT2pdhyf8lbr8QEq06l7/HIrDlWAV2zk9N/k3m/MI0hzgs6H77L
         Kj4uUBoiZ2bZFJkBN89fH0xKZtZQvMvPAcsGzJiL0HQhuYLgluQ4WR9YQ7fYcpjfCyLM
         LkX9gI+cz/vN8XgJfVmOgkDOx6vexPWlhPY5qAXqw/XvuTX++Zxhg6HToVCZsnFd4Um3
         G81g==
X-Gm-Message-State: AOJu0YxOMaFT90DSqRG2oWry5ZNC+JM8H7c+XSUkJC2MZN8Ie910P57v
	sehvLQifvTcQ0/1MF+6Ax5U7q0wtcnKhFiyHbvXgMNJ2yJX01YqSVHo2QQ==
X-Gm-Gg: ASbGncv4/bjKi3bdf3Va0n3TjuD6orMRT1Zi7h7pFcXfx8JW27sdBhejrzLInhPOEGs
	fjYlHhifnuBv92J6mg+7I51loZhS7OeJhekSJjy9JnVzYEoC/9eqDuwZ2O9oHP4QkV8dVzUi8kg
	B7BmBjpoaRNp61uWv4mWTy76NNmyTGwHfkV4RRwObcsFv8yiQdS9vNRenDWqZyw+M5YvVVjfqyj
	SeMTppoSvHCILTHSbz0YGyAGM0xOiRUGf9FSNF78skoKb97RYBNzMlojn7bM/Bg
X-Google-Smtp-Source: AGHT+IE/9d8kIq0E460wp7J//smRt8TnA0kd//cSTXsI+6jztDtwWf7qQTY7No9yEAFJwDbMC5H91w==
X-Received: by 2002:a05:6830:841b:b0:723:2186:8906 with SMTP id 46e09a7af769-723218689e7mr804544a34.14.1736487534691;
        Thu, 09 Jan 2025 21:38:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231861c02csm714044a34.46.2025.01.09.21.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:38:54 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/2] rev-list: extend --missing-info to print missing object type
Date: Thu,  9 Jan 2025 23:34:18 -0600
Message-ID: <20250110053417.2602109-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108034012.211043-1-jltobler@gmail.com>
References: <20250108034012.211043-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional information about missing objects found in git-rev-list(1)
can be printed by specifying the `--missing=print` and `--missing-info`
options. Extend this option to also print missing object type
information inferred from its containing object. This attribute follows
the form `type=<type>` and specifies the expected object type of the
missing object.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.txt |  3 +++
 builtin/rev-list.c                 | 11 ++++++++---
 t/t6022-rev-list-missing.sh        |  3 ++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 8e363f5ae7..9722eefc79 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1039,6 +1039,9 @@ we cannot get their Object ID though, an error will be raised.
 +
 The `path=<path>` shows the path of the missing object inferred from a
 containing object.
++
+The `type=<type>` shows the type of the missing object inferred from a
+containing object.
 
 --exclude-promisor-objects::
 	(For internal use only.)  Prefilter object traversal at
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 861ffdaf21..93d173039d 100644
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
@@ -108,7 +109,8 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static void add_missing_object_entry(struct object_id *oid, const char *path)
+static void add_missing_object_entry(struct object_id *oid, const char *path,
+				     unsigned type)
 {
 	struct missing_objects_map_entry *entry;
 
@@ -117,6 +119,7 @@ static void add_missing_object_entry(struct object_id *oid, const char *path)
 
 	CALLOC_ARRAY(entry, 1);
 	entry->entry.oid = *oid;
+	entry->type = type;
 	if (path)
 		entry->path = xstrdup(path);
 	oidmap_put(&missing_objects, entry);
@@ -143,6 +146,8 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 		else
 			strbuf_addstr(&sb, entry->path);
 	}
+	if (entry->type)
+		strbuf_addf(&sb, " type=%s", type_name(entry->type));
 
 	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
@@ -166,7 +171,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
 		return;
 
 	case MA_PRINT:
-		add_missing_object_entry(&obj->oid, name);
+		add_missing_object_entry(&obj->oid, name, obj->type);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -846,7 +851,7 @@ int cmd_rev_list(int argc,
 
 		/* Add missing tips */
 		while ((oid = oidset_iter_next(&iter)))
-			add_missing_object_entry(oid, NULL);
+			add_missing_object_entry(oid, NULL, 0);
 
 		oidset_clear(&revs.missing_commits);
 	}
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 2eb051028e..95bee17cab 100755
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
2.47.1

