Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8838235C17
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635138; cv=none; b=kHUQX2McmQR0SbwUFv3LTABtg7bRqOdGWYoRb6NE/zcYU6csdObbpYxXcUbNOehrKsEhRzuiytco7FV7/WWDwGSR64MON39JPqt7rVHBSAHE/swsPxWmc0ZSRRmMBzasNURKuhFEcJPRXnHYY1Nm288mC/MoExKmaGyp696OD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635138; c=relaxed/simple;
	bh=Qdj5XL2FzQf4k8X80NPbvZF0BGr5f6tdeILTIbjfEEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQOpate6u+Eym8qvRs83+WrCz1uaKdEWcUoBR1VHoh6+YEEvH5JTIebMGzQy3T+dmVePOHVetv8KYUXYg0EacnZ7+fZrTkRYhOdwHDO23TTvWCniZLa6ltaDUEmsbyu5Rzm/0xfr7jgwSut6ZVOM7fBeI8IVAlC9N6dV1IoamyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9tWRPkc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9tWRPkc"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7272cc739f7so3100995a34.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635135; x=1742239935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKf7zRU5/PB/c6d9zXcaQLXv9ej5IdDNVPo7BHtUQrw=;
        b=e9tWRPkcBJ2f8E/OANLwFF+VcVj7kv4RANGPXt3oF1pZs2SJYCvtsA80M5OxHCY/y2
         TTK2pvJmG+YJLK4hJu/0L4Q0DiVCtwV66B95bhmV01OOtIQX4r7TRkx2Qp92DCyb0CWR
         BI8/OQsjaocoBFX8NlS9umkHkeDJhWBoFpDXPrzK9DFqSNuFnfo3oZ8cnEIw07DuNBVQ
         vNFdwfQ1hNf7NiGfB3+GZgL/m4uevw0q9/U3yHaVUgv8XKroTKh/AbkjQNM3KLBVpR2E
         xT7QkgWa9VkOMTgCytH+3P9IADfxHncrWQhbTnbsPg59j9EHrpsK1+t4heR1ARCzmK6d
         +9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635135; x=1742239935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKf7zRU5/PB/c6d9zXcaQLXv9ej5IdDNVPo7BHtUQrw=;
        b=SE03N9y2LGVGcYibia24czqRUyo4ygp072CB2Tz7h8C8ursnpQaXh3VvWjOUvDnnZ5
         gGJSD1eUFcdCjdcsZy3t/bHRUzPJ5AiGW1O+v02w6z9MkLP2PUvJ2A8WANCXeCSQihIY
         LTdlGWDv0JZ2/GpPywosLzmsY4hpL6DtHftadea0uFAvbY+SvxFBjQLbfz7UO9b0PtNT
         1AqU3p2meKMW0iKzP5iuzn6mQv32p2zwir7WSh3sq4thqCnr2KVsmkgXkGztQ7lkUPgw
         64XDWPQRJ/Y1xjW5XTF1kA62c3sdWsiyFghMv+N+IRJURh0gM/uknYHTy2w2SbMV3E42
         Mqvg==
X-Gm-Message-State: AOJu0YxFIyOgvI8pFgeGZpWb3d4hqD+b2ppCAHI9xYFizK98wAbXUfe/
	jvwM8Zld0nDeKOikA+PH/LuSHWXUzfMCCwrmIzRM5Z6u/+YZZSbrTLx+hA==
X-Gm-Gg: ASbGncuZhqtVE6iKoFX+O8YzNIIHpRamFuAMQ+EnMaEsnTRSupwsavC12urH8ICQoSQ
	yhrEWMFXEHh5+q6D9Ps4mmDG9yb1t+PGUtMeufRmb+iX5mA5aiMg+wIbBP5GPxdK1uAXE/HSnjM
	7qWKe16f4agJaxIc58unudV8dU9RldTWyIiMc3ZKoulfnGwfpV7dIPKuIFBH7svY1EDvrMhmYWi
	EQvTt/6M2+3wzGPqve4whVu1QI2g0YW7ueSo5Mz/IHxOI7GXwDyJk7QqXn2+bae/xGSn7xijNln
	otSsIgGHvsV2Zv+BgH65PIJPVFApGu5XdfVW38UdVr+1/eeN+6Q6
X-Google-Smtp-Source: AGHT+IEFDVYN/+FnF+NUj5zowWM3KQ63zHIrMdMRg5FYdQ536xtPHczgfNG3iIzvxrVZR7GfnmqYjQ==
X-Received: by 2002:a05:6808:10cd:b0:3f3:fe04:f86 with SMTP id 5614622812f47-3fa28dfb00dmr551334b6e.0.1741635135109;
        Mon, 10 Mar 2025 12:32:15 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f861f30de5sm697819b6e.46.2025.03.10.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:32:14 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/4] rev-list: support delimiting objects with NUL bytes
Date: Mon, 10 Mar 2025 14:28:28 -0500
Message-ID: <20250310192829.661692-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line. Some options, such as `--objects`, may print additional
information about tree and blob object on the same line in the form:

        $ git rev-list --objects <rev>
        <tree/blob oid> SP [<path>] LF

Note that in this form the SP is appended regardless of whether the tree
or blob object has path information available. Paths containing a
newline are also truncated at the newline.

Introduce the `-z` option for git-rev-list(1) which reformats the output
to use NUL-delimiters between objects and associated info. Each object
line uses two NUL bytes to indicate the end of an object entry and a
single NUL byte to delimit between object information in the following
form:

        $ git rev-list -z --objects <rev>
        <oid> [NUL <path>] NUL NUL

For now, the `--objects` flag is the only option that can be used in
combination with `-z`. In this mode, the object path is not truncated at
newlines. In a subsequent commit, NUL-delimiter support for other
options is added. Other options that do not make sense with be used in
combination with `-z` are rejected.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 18 +++++++++++++
 builtin/rev-list.c                  | 39 +++++++++++++++++++++++++----
 t/t6000-rev-list-misc.sh            | 34 +++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0..d21016d657 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -361,6 +361,24 @@ ifdef::git-rev-list[]
 --progress=<header>::
 	Show progress reports on stderr as objects are considered. The
 	`<header>` text will be printed with each progress update.
+
+-z::
+	Instead of being newline-delimited, each outputted object is delimited
+	with two NUL bytes in the following form:
++
+-----------------------------------------------------------------------
+<OID> NUL NUL
+-----------------------------------------------------------------------
++
+When the `--objects` option is also present, available object name information
+is printed in the following form without any truncation for object names
+containing newline characters:
++
+-----------------------------------------------------------------------
+<OID> [NUL <object-name>] NUL NUL
+-----------------------------------------------------------------------
++
+This option is only compatible with `--objects`.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 04d9c893b5..86b3ce5806 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -65,6 +65,7 @@ static const char rev_list_usage[] =
 "    --abbrev-commit\n"
 "    --left-right\n"
 "    --count\n"
+"    -z\n"
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
@@ -97,10 +98,23 @@ static int arg_show_object_names = 1;
 
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
+static int nul_delim;
 static int show_disk_usage;
 static off_t total_disk_usage;
 static int human_readable;
 
+static void print_object_term(int nul_delim)
+{
+	char line_sep = '\n';
+
+	if (nul_delim)
+		line_sep = '\0';
+
+	putchar(line_sep);
+	if (nul_delim)
+		putchar(line_sep);
+}
+
 static off_t get_object_disk_usage(struct object *obj)
 {
 	off_t size;
@@ -264,7 +278,7 @@ static void show_commit(struct commit *commit, void *data)
 	if (revs->commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else if (revs->include_header)
-		putchar('\n');
+		print_object_term(nul_delim);
 
 	if (revs->verbose_header) {
 		struct strbuf buf = STRBUF_INIT;
@@ -361,12 +375,17 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	printf("%s", oid_to_hex(&obj->oid));
 
 	if (arg_show_object_names) {
-		putchar(' ');
-		for (const char *p = name; *p && *p != '\n'; p++)
-			putchar(*p);
+		if (nul_delim && *name) {
+			putchar('\0');
+			printf("%s", name);
+		} else if (!nul_delim) {
+			putchar(' ');
+			for (const char *p = name; *p && *p != '\n'; p++)
+				putchar(*p);
+		}
 	}
 
-	putchar('\n');
+	print_object_term(nul_delim);
 }
 
 static void show_edge(struct commit *commit)
@@ -642,6 +661,8 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(arg);
+		} else if (!strcmp(arg, "-z")) {
+			nul_delim = 1;
 		}
 	}
 
@@ -757,6 +778,14 @@ int cmd_rev_list(int argc,
 		usage(rev_list_usage);
 
 	}
+
+	if (nul_delim) {
+		if (revs.graph || revs.verbose_header || show_disk_usage ||
+		    info.show_timestamp || info.header_prefix || bisect_list ||
+		    use_bitmap_index || revs.edge_hint || arg_missing_action)
+			die(_("-z option used with unsupported option"));
+	}
+
 	if (revs.commit_format != CMIT_FMT_USERFORMAT)
 		revs.include_header = 1;
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 6289a2e8b0..25c2f2f238 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -182,4 +182,38 @@ test_expect_success 'rev-list --unpacked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -z' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD) &&
+	oid2=$(git -C repo rev-parse HEAD~) &&
+
+	printf "%s\0\0%s\0\0" "$oid1" "$oid2" >expect &&
+	git -C repo rev-list -z HEAD >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list -z --objects' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD:1.t) &&
+	oid2=$(git -C repo rev-parse HEAD:2.t) &&
+	path1=1.t &&
+	path2=2.t &&
+
+	printf "%s\0%s\0\0%s\0%s\0\0" "$oid1" "$path1" "$oid2" "$path2" >expect &&
+	git -C repo rev-list -z --objects HEAD:1.t HEAD:2.t >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.rc2

