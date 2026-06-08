Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B43CF69E
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913703; cv=none; b=P/AM3L8ivzJ/ia5RoVyVPBxcS1zCgOKpu35+rG3OaOFP6Yl7rDqqZ/Dfw+EqUBIhpWaPjDDvieTzFE2mg3rHmiyM0Upz23U1qNhPa0WxFJ1TcZHEqcpMY5e/F59HUh/7I6VkldYiwBwtZfY8xsPEcG/CnV2clxI0pf7sCMHxL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913703; c=relaxed/simple;
	bh=NNAm6z12+ZB5sndNRRRZMdWNr7cD14nx6JEAcdpNhMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrMkM1D53XKutdoiOtNBSnzw96ZYoWrLH9uwRYxPSMCTAcbcjFyxYk2xvc/KeL+p75RXxX4wZ5C6fjiMyk27RhTsW8PRvfzWdu5KFu91o2gBywmv9hvw9H2hOl5hgCbHnLWZ8bdEKBdpMzG4uqvDTpqmAc2R7XGFTfqbksB9JZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhMBMpW/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhMBMpW/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so2772763f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913701; x=1781518501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o0GkilDwWFYQD65uEI1gRRBBpon4ytBP21YuTHyU4c=;
        b=KhMBMpW/RX92qRH5RSNxFVhgFyUh7qNUH3RJueBjFqzLDWQmqTTNpU00gqqqJUvfYK
         eXxC6cipTfAuK25KZKK7Fbrgc7Vr4vweZ+BqKri99WWdvUAGbddIwt9BR9x1TwykhyLU
         zndajJo1TtGg8NLsGhR23RCnnMTdhD8XJC1qTB9ByAHsDjmFJwDIyrUlfZYJ18hoqLUC
         5BpLxCjVMOBNTqygXYvTP/KBT8hVxpmCxAeCDzMYJrtQtD7Y94R7Xg/X3ivz1OW3RLKY
         NE0uLt7fSUtObckpXikvYOa/rietbVsTF+jUVlr5Z3p5lEhCFHAoWUugCIp3hEbZHEAS
         coIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913701; x=1781518501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8o0GkilDwWFYQD65uEI1gRRBBpon4ytBP21YuTHyU4c=;
        b=UNvTfrjErJ84tYV/2kOeybqnEhfESvHtg04Ghn/bg11JjoW1prxjOVZoLEtN/zNPQ8
         M236ghDuEykuq2h/VaGk/NwLL7Nq/xlAaJ0zBjfzvM0y6wyzNtqTxd43yz9/o2PqMlcM
         OQkfODzuXSR12dX/DKBdOXLvSA6Sf9kY8cbaDwnVVZfAJ1AoXkeBouPAfMPJ7vJoRhUl
         fzrwDb85EAQzvFK4BogBxdjgrS7y/nXmG0VQkIoX/Ayt06cubLL36JsXHtRtlKPRHRab
         mJghY7m9VqZFDm7ZD1Ptzulju8xqKTPrgfyi89UsnTIkm5Q01jK5H7vG2axx/L/ue+TH
         VvwA==
X-Forwarded-Encrypted: i=1; AFNElJ+sVAOJnxpsayA7MJcOan71c47E6aZVzUVECEkSJvkXBfhRZ9WaRYmxEIBzZkyH9pT7CWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnoEkqtxtwQsFf8/daAMltSumn76lj+RFC+17nSDIezo4s6PG
	3DZfc28IzUHhdwLJCUacFuxpzeRz+l32Pj2ux+fXtcnPUa56h+ge1b9N
X-Gm-Gg: Acq92OHsLeqsc9ZjaeUZnAO1vtYIhGNzkahFH+wE074Np8xpetN4z3vWXhHVHki+UKK
	tU94DZcOQLxlwa1o6kZTKgGikopDkpJ1oaWbEipz8niJeOpXafxs54Nss2R5rPlcqxyCnB51K7W
	M2YJLNhZAq1zEhqSkT7nEqY59zMqZcvOLxqMPh290HZUEbb5pdJSXDWH+p41RPX/pCmrwvjVxr5
	hbBEr0pPxujHLjUAukWvpjucZeE8ChgaWcHaAQ745nXD9//dctDeclMIUp9/BQXcRINebAJOxLi
	S0LqtGq18gizIXzEJf+1BXKbk/jeneEkUKfD+XLeDwcAB4Qx3X/ifhlIgUz1IA68sqaeqSTPtc/
	eGbfI7aN9W6jdy3xgS/E6x0BdHyPHuS+cX48/MDmer4e790fGau5pnk8Rx4qam8wSCCvyhAoMtC
	QwHmeC2543JsvGDcfMjB6ui/anI7qW0C3CNvrP4hmryFgG0n1DvcVEAScW50RhpRrXSoI4+jJEI
	VC0IcnS0u3hGSE3nd1uCVEBmHJw6OvxPsaHEpsyJWvelSPgkfjqXO/pwfdZlqiasHymbDlqAnVF
	Wt8gGf4iq4NJT/f/ZWZ+w0L0X7goTgGRQub7J52mO/7akpcX2ZTPK3d3oW+5DTYYUw==
X-Received: by 2002:a05:6000:4406:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-460306092b8mr16963316f8f.17.1780913700608;
        Mon, 08 Jun 2026 03:15:00 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:15:00 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 11/12] cat-file: validate remote atoms with allow_list
Date: Mon,  8 Jun 2026 12:14:34 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-11-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

strstr() is not enough to validate the format placeholders in
remote-object-info causing two errors:

- Atoms recognized by expand_atom() but the remote doesn't returns 1, but
  data->type contains garbage causing segfault.
- expand_atom() returns 0 for unknown atoms, calling
  strbuf_expand_bad_format() which ends in die() blocking local queries
  if the same format is shared.

Add an allow_list with the supported atoms at the top of expand_atom().
In remote mode, unsupported atoms return 1 leaving the sb empty,
honoring how for-each-ref handles known but inapplicable atoms.

As extra safety, initialize data->type to OBJ_BAD and add a NULL check
for type_name() so uninitialized data doesn't cause segfault.

Update tests that expect previous die() behaviour to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update caveat behaviour documentation.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  5 +++--
 builtin/cat-file.c                     | 41 +++++++++++++++++++++++++++-------
 t/t1017-cat-file-remote-object-info.sh | 28 +++++++++++++++++++----
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index aba20eb770..3b7a85b383 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -451,8 +451,9 @@ CAVEATS
 -------
 
 Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
-currently not supported by the `remote-object-info` command, we will raise
-an error and exit when they appear in the format string.
+currently not supported by the `remote-object-info` command, they will
+return an empty string for remote queries, matching how `for-each-ref`
+behaves for known but inapplicable placeholders.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a14cfea815..1166a046b4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -336,8 +336,18 @@ struct expand_data {
 	 * optimized out.
 	 */
 	unsigned skip_object_info : 1;
+
+	/*
+	 * Flags about when an object info is being fetched from remote.
+	 */
+	unsigned is_remote:1;
+};
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
+
+static const char *remote_object_info_atoms[] = {
+	"objectname",
+	"objectsize",
 };
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -348,14 +358,31 @@ static int is_atom(const char *atom, const char *s, int slen)
 static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
+	if (data->is_remote) {
+		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
+		for (i = 0; i < allowed_nr; i++)
+			if (is_atom(remote_object_info_atoms[i], atom, len))
+				break;
+
+		/*
+		 * On remote, skip unsupported atoms returning an empty sb,
+		 * honoring how for-each-ref handles known but inapplicable
+		 * atoms (e.g. %(tagger)).
+		 */
+		if (i == allowed_nr)
+			return 1;
+	}
+
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
+		if (data->mark_query) {
 			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
+		} else {
+			const char *t = type_name(data->type);
+			strbuf_addstr(sb, t ? t : "");
+		}
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
 			data->info.sizep = &data->size;
@@ -699,10 +726,6 @@ static int get_remote_info(struct batch_options *opt,
 	gtransport->smart_options->object_info = 1;
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -832,7 +855,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 			 */
 			data->size = *remote_object_info[i].sizep;
 			opt->batch_mode = BATCH_MODE_INFO;
+			data->is_remote = 1;
 			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+			data->is_remote = 0;
 		}
 	}
 	data->skip_object_info = 0;
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 5c8c07b0cf..0a78aabf3b 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -205,6 +205,22 @@ info $tag_oid
 	)
 '
 
+# This tests depends on %(objecttype) not being supported yet, once supported
+# it needs to be updated.
+test_expect_success 'unsupported placeholder on remote returns empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "" >expect &&
+
+		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 # Test --batch-command remote-object-info with 'git://' and
 # transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
 test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
@@ -544,10 +560,12 @@ test_expect_success 'remote-object-info fails on unspported filter option (objec
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		echo "$hello_oid " >expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize:disk)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(objectsize:disk) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 
@@ -556,10 +574,12 @@ test_expect_success 'remote-object-info fails on unspported filter option (delta
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		echo "" >expect &&
+
+		git cat-file --batch-command="%(deltabase)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(deltabase) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 

-- 
2.54.0
