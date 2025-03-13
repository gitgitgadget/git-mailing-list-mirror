Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF91C6BE
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825281; cv=none; b=CRTnSgMnPF6PJ1B+4j7brqbC70mgyPnpQHSnC+S2Ubmwo9lRMGg2CntAJIAULSU1lYpXeIXrftZRcKzv9VPDRQRihuX4TPMcbmq9DbsH38DHbXtpto5dEXrnohnp4uwXPoU8B2PGjlziNiZbXuLXV3HUTD3cXdtgtR1ePHvi2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825281; c=relaxed/simple;
	bh=GEbKqhgo25l2t0MfK+P4XVpt6b+YDHqVjJcQzMdWS+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDfHFR+OWkMoDzXI8xNW2739GrwCCpqaQVkL3LzT+elKDl3mO4H0QzcsbwID/zPpcPU+tpoYsCzxO61CoG8TKfFUtnDm9MM4Z4n6NsNa3fknk2TuwRI7fWbAF7wkUEQrnpg1k0hw31PTGwUBH/swr2JCumT3hMOkRT2lOLV2zDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bep9IcS2; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bep9IcS2"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bcdf5ea8faso331185fac.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825278; x=1742430078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp2lDt+EZG37miPI5lzgUD+a7tu6ByGR1ar3CRq+T74=;
        b=Bep9IcS2sbBM9t0Olv1fwyrHJ4q84crg8NCSLMTb4Z4n2pFbb87zXdzP2Oxjb4bVnb
         ihWWP26cotp1WCJFe3BecumJ03qa1LdzKuL7LQsxrn3CtxBqpwEgT+XvW/8ZzJxtjPY7
         pqkvVj2PEhou3CkHK69mjPQDPRImZzLnaU1INQM7HwkVG3l8ltGdWiOKyKvmQWCSuWut
         kzS7eDtCyr28QdDkL5Z4BLDbV7ZCMt2qYp3dnOAobUGPvC2ZvIqoBbRzusxh5v9t1yS6
         nxsJy34zIuzrwMKWHjw5Cpll+yXPrrgFh4u5pwv2aNabSJ8cxozxSrUeH8UGb6MLcB5/
         oqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825278; x=1742430078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp2lDt+EZG37miPI5lzgUD+a7tu6ByGR1ar3CRq+T74=;
        b=LrV8C6n4TTmgJjtMa1YzlTmJL1M9l/Z5pNT/FkOIYBfw7uJ/GF7FDIu1RUby6F2b6q
         kQ5wgEGYAgw01/0Lrlp7udqGs0xHCy3L7nzxUvANFbgW2UoQ3Ulo4YdNtYkhQqbEC7bt
         zqWA3FBik2DnpM/yTlb9fPVZvhbCLo6uKcah1lNkvx9evxWzskn3Ju7Ra5uiJ8nGbTDf
         /XfqWitWfUF6hWuJd6y9zf3DK+gkg8IiXLhO0/KPBq5GepegSVQwtqMlQFlPwxcxBU36
         jSgtsIm/l+a1wiLvE1Ez1FN3XcsP7uNA+jKiFOVDaWP8nXuz73/T4QlqDVRxxmeO5fgl
         MtqA==
X-Gm-Message-State: AOJu0YxMlGniUMtzGWdviiv6MbiCwunkaEANxQPOzqJOl2Y/8Klu81Wu
	dFAg069vNuPqIWCv7Q9IeF8psAin1gswyF6LaVVSZ/oepRvtY0wT62r1VouQ
X-Gm-Gg: ASbGncsBFhChwTut2SRrpWSdSU6V4aKMYzMRdTs0U6BUPyBH5XRaeKdfeSxsiQKXPhA
	wLkkm7p6THyAQOKm12Jc/sfVLDJ3e23cTo17WTFTokBueGLKCssCASesJcUTzXFCbUWMT0SP9e7
	Iw0ETd6eq+L7hEzD+DEYGONNVfp/k0iSX7EJbzE6tinaT3jmRN48eoI7RHW+QK3HsSTUFGePCQu
	mSTUmeE6igTeBJS2muZ2qeOv728zI1aZB7D+66UoVTp4KpzymuCG8wElF9lAsjcGfXLdgQo4JtP
	50rOKGMEfSNqvkYQSyvsN8ALP2qjNf5JIbWgFOPMyUCG7UMXjetH
X-Google-Smtp-Source: AGHT+IE+Lqfo9cjbTrf7C9A5y4c2dAr8DwQQCMLN5d0L8/zyjTSM0g2YwayJTOPe5cDAt4F7TGFRaQ==
X-Received: by 2002:a05:6871:8005:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2c26142a194mr13858104fac.30.1741825278478;
        Wed, 12 Mar 2025 17:21:18 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/6] rev-list: support NUL-delimited --missing option
Date: Wed, 12 Mar 2025 19:17:06 -0500
Message-ID: <20250313001706.3390502-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing={print,print-info}` option for git-rev-list(1) prints
missing objects found while performing the object walk in the form:

        $ git rev-list --missing=print-info <rev>
        ?<oid> [SP <token>=<value>]... LF

Add support for printing missing objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --missing=print-info <rev>
        <oid> NUL missing=yes NUL [<token>=<value> NUL]...

In this mode, values containing special characters or spaces are printed
as-is without being escaped or quoted. Instead of prefixing the missing
OID with '?', a separate `missing=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 13 ++++++------
 builtin/rev-list.c                  | 29 ++++++++++++++++++++-------
 t/t6022-rev-list-missing.sh         | 31 +++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index d400d76cf2..145ded5c78 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -371,8 +371,8 @@ ifdef::git-rev-list[]
 <OID> NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-Additional object metadata, such as object paths or boundary objects, is
-printed using the `<token>=<value>` form. Token values are printed as-is
+Additional object metadata, such as object paths or boundary/missing objects,
+is printed using the `<token>=<value>` form. Token values are printed as-is
 without any encoding/truncation. An OID entry never contains a '=' character
 and thus is used to signal the start of a new object record. Examples:
 +
@@ -380,12 +380,13 @@ and thus is used to signal the start of a new object record. Examples:
 <OID> NUL
 <OID> NUL path=<path> NUL
 <OID> NUL boundary=yes NUL
+<OID> NUL missing=yes NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` and `--boundary` output
-options. Also, revision and pathspec argument parsing on stdin with the
-`--stdin` option is NUL byte delimited instead of using newlines while in this
-mode.
+This mode is only compatible with the `--objects`, `--boundary`, and
+`--missing` output options. Also, revision and pathspec argument parsing on
+stdin with the `--stdin` option is NUL byte delimited instead of using newlines
+while in this mode.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7c6d4b25b0..d7b4dd48ff 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -136,24 +136,39 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 {
 	struct strbuf sb = STRBUF_INIT;
 
+	if (line_term)
+		putchar('?');
+
+	printf("%s", oid_to_hex(&entry->entry.oid));
+
+	if (!line_term)
+		printf("%cmissing=yes", info_term);
+
 	if (!print_missing_info) {
-		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		putchar(line_term);
 		return;
 	}
 
 	if (entry->path && *entry->path) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&sb, " path=");
-		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
-		strbuf_addbuf(&sb, &path);
+		strbuf_addf(&sb, "%cpath=", info_term);
+
+		if (line_term) {
+			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
+			strbuf_addbuf(&sb, &path);
+		} else {
+			strbuf_addstr(&sb, entry->path);
+		}
 
 		strbuf_release(&path);
 	}
 	if (entry->type)
-		strbuf_addf(&sb, " type=%s", type_name(entry->type));
+		strbuf_addf(&sb, "%ctype=%s", info_term, type_name(entry->type));
+
+	fwrite(sb.buf, sizeof(char), sb.len, stdout);
+	putchar(line_term);
 
-	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
 }
 
@@ -784,7 +799,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action)
+		    revs.cherry_mark)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 3e2790d4c8..08e92dd002 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,4 +198,35 @@ do
 	'
 done
 
+test_expect_success "-z nul-delimited --missing" '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m first &&
+
+		path="foo bar" &&
+		echo foobar >"$path" &&
+		git add -A &&
+		git commit -m second &&
+
+		oid=$(git rev-parse "HEAD:$path") &&
+		type="$(git cat-file -t $oid)" &&
+
+		obj_path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		git rev-list -z --objects --no-object-names \
+			HEAD ^"$oid" >expect &&
+		printf "%s\0missing=yes\0path=%s\0type=%s\0" "$oid" "$path" \
+			"$type" >>expect &&
+
+		mv "$obj_path" "$obj_path.hidden" &&
+		git rev-list -z --objects --no-object-names \
+			--missing=print-info HEAD >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.49.0.rc2

