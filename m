Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD833227B9E
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716326; cv=none; b=dza1KRlpaSW6mWtkyNhs9SJgT221dYZ/GScA3nFj8mpkefAp/sbleBfI12qFhCmil2IjR6usKf/LGE7kBnal4ry5RDs+1YGUhyxiLxBPEhDqj3DR0bFMHraJnxZDWeObNlx6S5tbT2zrI4y/VNXDKKEHAPo/KZceFXNtyMDmqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716326; c=relaxed/simple;
	bh=Dtk9nW48eK3GQPdN9VJ2WhkBATiBpew4dT8BP0KwM3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suybzjQhKyrRC9h+e257ovGHkOu/1UtSXwc3d9qDZAlxOPYXcUGTd/UPr6tjPKz2ljCfFlgAXY2FxUXP2sGr+xzqlqLVJnyLkTgTIN9DlPk0s+CL40DfV39cYoXZ+7AqHy1cwyajxU/yFRGVVICKLvoRbiGhshnh6aqtkFlUUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Xn+1Et; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Xn+1Et"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f304ac59b9so3126807eaf.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738716323; x=1739321123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ww/55A9PAZ/HSeb8eoMBzxpuGXRe0kl6VTVg76qFHI=;
        b=k2Xn+1Et/FDljhT5n+SNr1yvH4nzxzO8K1qLT8qQGVuxWP9knsZ5Qimp5Rs+56wkh6
         JERdXES+Qe5dBhDEMeWJ80MG8B62QHNI5v+kKBnbo2rTPrqUaPFn1TWoWFK3Saj/RJzF
         XOSsoYPVuoDiksvcWk6i24KbHE0d5PuwKPF3cStslrCqoQ+rWmmhP0qIJ3YlMEQehGP5
         NYT/Ms1b53cMf3/S9nwdFKZ9qnpJSImq6z3a0/7BvhtzwT0xPBRzg3Yb0mw43cGXHMkS
         WBszOB2imq/E7WBtGFyqAHILfGMErldwJZu7Y9R3EOupc7h5i9Inr2eRdK2a8BFoXK5i
         P1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716323; x=1739321123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ww/55A9PAZ/HSeb8eoMBzxpuGXRe0kl6VTVg76qFHI=;
        b=rdcsaT44tS5ZFAG4xf/yn79yR1GbinsvvSena0gT/fnUYjwYfpV0YZffhfeOZBe0i4
         2pnyjJhEf9ltHxAhhH4t01ciemMtIIxPnuXVnjwBdHX9y1DdQiXSJGBtO1IFF35bSyNr
         k2jOyD0mMnjAoLMYioYQ6KFytfuQAW6EpEvLOO5PrwV6AorEcDsyNyfU108W4zZBkv45
         s0J0E5F+4O2g6Bymee8HIQAiqXygCcs4WECdEcCfMIdMmP+CBgjhyGLuWANKjO4MxBSX
         ETGhLPGjgyVGjA8hHJzNoUz7jfTHWxt5obtdPOaW/TtMHQUGZBG6pm7saLyUbRc8WH+q
         ICBw==
X-Gm-Message-State: AOJu0Yz/e9G6RhMTb1QI1ZoaX8fKq+SRUdTLBNj0nGDXNaI8UzJl3Z9o
	MdeMP54IKpvYLU78gQr6w78GRqId5dMclq73IWxFzr3dJKOfuUSXfnMI+w==
X-Gm-Gg: ASbGnctKYQokRlRYvxWmRW28QpLYMdb1Q1d95rdgWNbg6p4NZo0FOow0C83ySHAI70T
	j2hxulom0K6CqdxLYwuTy17xK0gl6Jc6Hm5BORnTQgf6NCwB9gJPVrsUnuECxHtLvNAiKktLlor
	apz1E50UlnsUUMabyyVaHcEXVTJUco+1nzWIaSf9XKigaMByN9TOvp9UFc/djt4t+pTDxdTg+va
	k/ERTI1q5jZ1fiUiNu+JHXuUhsPICC4wcWu2ygWN85tetNcSrJYJyLFYfaX52hr33YKIRLoK9Gn
	ULo/JgJN6/PfGtSTB41kbIg=
X-Google-Smtp-Source: AGHT+IEDo70CFbDe+AoNcCWUkrgjrTobvf+qi3k/QH05LU19aoOZOXRlHIM2TdHOyAgQffsX9Rx3Sg==
X-Received: by 2002:a05:6871:2314:b0:29e:362b:2148 with SMTP id 586e51a60fabf-2b804fdbb4dmr629797fac.19.1738716323163;
        Tue, 04 Feb 2025 16:45:23 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356643beesm4429451fac.41.2025.02.04.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:45:22 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/2] rev-list: extend print-info to print missing object type
Date: Tue,  4 Feb 2025 18:41:47 -0600
Message-ID: <20250205004147.887106-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250205004147.887106-1-jltobler@gmail.com>
References: <20250201201658.11562-1-jltobler@gmail.com>
 <20250205004147.887106-1-jltobler@gmail.com>
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
index 00f157eb68..ead43a34ef 100644
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
@@ -142,6 +145,8 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 
 		strbuf_release(&path);
 	}
+	if (entry->type)
+		strbuf_addf(&sb, " type=%s", type_name(entry->type));
 
 	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
@@ -166,7 +171,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
 
 	case MA_PRINT:
 	case MA_PRINT_INFO:
-		add_missing_object_entry(&obj->oid, name);
+		add_missing_object_entry(&obj->oid, name, obj->type);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -843,7 +848,7 @@ int cmd_rev_list(int argc,
 
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

