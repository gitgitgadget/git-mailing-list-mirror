Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F942264A8
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546812; cv=none; b=BsdW3xhXaMwXU0zYY/67vBI9MsYmudRiEi1QMOisajHhvrk0sly7WJA2oVtHaunC6EddRx3pEN01uskFycjECkjUmXBW+YYmTLPWu1KjQWBluqQk1Iv6c173QZdySfh+XY4+GQmpk7Jx00M8mgfKjal+cWKf3eIVa6lWBt1TPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546812; c=relaxed/simple;
	bh=TNjKMMfwQUvnMMI4AgeRTEPABICsVBaZgS2vmQIf/js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6jcCmXYfd3hG5NZlcYJJUpRPiVFfbxfhGS3MRUP1KwVIH5W/nSmqfoOeQRJESsRGIS4v3gS3fLt2+vCTQLqRH++dfW0Beyupf2jCPeAx/iFL6MrGlWmu1Epya9yrG/nnxPIwwzPFY63+6jnWQyFA/200uoIE6YlT6zUOpoKPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PX8AFprS; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PX8AFprS"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c7a459105so5504380d50.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546809; x=1779151609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUpzJXlzdVKk3WT03MqTGi4MXfJywjXsbTgDuL4rid0=;
        b=PX8AFprSwjT0zX2CejvGEazG1ivEZeq8Y7tNhi/J35OfzC2e3X+G6sDYk/AvgeBaKL
         EoHaixi41VE65UgT4/yzz8jO1LWrMBuNTm2FtI7+XNNoWpeWdzyJD1BuZ99ImNiTRpVi
         KBl3dUSj57YoPDXooJqhEH1CiN7MtJFRdR2gP4Y3yWx1U7jlVv7OI+lTZwHtL/Tsy4x6
         NBfS1La0MTz6y/nbxCYjo2zGza9h7ouwnvOb9wQ0CY+sKTl3BAsvArNqWrldLo4cIKco
         jJR6dWyv65VtQCIYZZ31UTFg/8pX9tNitcd/kH0s84fSKj43pOAl6U4bUL485R9hsrfC
         5W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546809; x=1779151609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUpzJXlzdVKk3WT03MqTGi4MXfJywjXsbTgDuL4rid0=;
        b=X025rxQdYuYoR+X47hW4fkc0l5eHrnaP32EjcvDAnqO63ddiYb/KRf6qDsdoF9UMqW
         cKUZgXHp/YRuZQkwrhHVetz1a2XkUeXExuQurMOiHSSzdwUTYAd0N37/fGmQJzpfcBvU
         kb92k1sBurAZZn6sbbbg55fo03VOFOdHTpoTR88avgXMnOsBYhRegrfjYm7ovQZV6lKu
         wIEqazYqFPkFvL9tgUoGb1XAiNfdrTFIjU49mrVDI07ueLy2jbsYfVdQBqJdAG6xSx1V
         Sk7f5vlNtOG9fxKY4vf0dO9sDYkvHCnXT2lB6OUQiPq63SYz+lAxSs91ROzWq27gtpno
         CdVA==
X-Gm-Message-State: AOJu0YwQ0am4LKZG5SRmjgLr7Y1XdxafCwVmor4JKJgqSypTN4JezVZX
	/XcodHwnFsekBIsXwNPDYxPlaxS4jo0e7Z+jbPq6RMthog6qTeQrRZPhIfpd7LnWv5TDaq12cQX
	GSPnRpbkpAw==
X-Gm-Gg: Acq92OEG6JNpCRlRtzHW2y1RBrscT2jl/PKK4JB8P9JfRumsW+IcNKlNGDNqbY21X9v
	47/SUOOkWoukbkicQWfD7r32B751BXwKRjTJkuo+ZgCE4hWkivU4HLy7rAVZV7UUZ5sMbDbRe/t
	M32CECJZJPtDRFTH09TF1MZynCw64QLVhmXAsFXD9A8QMfKclwQ3mxeg8RPaY824cYndeBg3oUZ
	jtA86p17Kdz9NnjTDvyd5zBn0zKinerts9cfF+s5mql+bj2xxH++De5aMcff3lf6oafrWHnQG2+
	+xxv62mfqV05PQcgU/D5QOq9qmnDCNhVBJsE0VP4r7Ewqiz5koe3UA+B/0ES/yz63MTqm3JalzE
	++vDk88aU13w+yf1MG2LNXekoHy+3LjIzvIo1/BIXo4P85r2W7EQ2eGFDCZthmFzKrulH8KUeYw
	9LBI2R5hQNk7qpsQqlG8tEucGMOiser1O4Lwn9Ss5RueBybNxsZ4jV8DzZbZQvEE4cxmqMyfStC
	Wz2r/mzWlZsB3QmJAS6uLCEVFfi3GZ90FTGGRwiDVq3qO8ucrflbrYU4lSSgG6yrrhIXxDkgsqk
	p+yYfRpi5w04udAm
X-Received: by 2002:a05:690e:2514:20b0:651:e1e7:7f51 with SMTP id 956f58d0204a3-65ddd66f9eemr1234874d50.31.1778546809479;
        Mon, 11 May 2026 17:46:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96be4aa2sm6175228d50.15.2026.05.11.17.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:46:48 -0700 (PDT)
Date: Mon, 11 May 2026 20:46:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/9] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <9c7a829cbeb0321866e684228a954cbf9547ee02.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

In f16eb1c091 (pseudo-merge: fix disk reads from find_pseudo_merge(),
2026-03-31), we noted that `apply_pseudo_merges_for_commit()` is never
triggered by the existing test suite, and that this bears further
investigation.

This patch is the first one to begin that investigation. The following
patches will expose and fix a variety of bugs in the implementation of
pseudo-merge bitmaps.

In order to do so, however, many of these tests require very precise
selection of which commits receive bitmaps and which do not. To date,
there isn't a standard approach to easily facilitate this. Address this
by introducing a `test-tool bitmap write` subcommand that writes a
bitmap for a given packfile, reading the set of commits which should
receive individual bitmaps from stdin like so:

    test-tool bitmap write <pack-basename> </path/to/commits.list

, where "<pack-basename>" is the filename for a specific packfile (e.g.,
"pack-abc123.pack"), and "/path/to/commits.list" is a list of commit
OIDs which will receive bitmaps.

The helper respects `bitmapPseudoMerge.*` configuration for creating
pseudo-merge bitmaps alongside the regular commit bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-bitmap.c  | 113 +++++++++++++++++++++++++++++++++++++++-
 t/t5310-pack-bitmaps.sh |  24 +++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 16a01669e41..381e9b58b2c 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -2,7 +2,10 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "hex.h"
+#include "odb.h"
 #include "pack-bitmap.h"
+#include "pseudo-merge.h"
 #include "setup.h"
 
 static int bitmap_list_commits(void)
@@ -35,6 +38,111 @@ static int bitmap_dump_pseudo_merge_objects(uint32_t n)
 	return test_bitmap_pseudo_merge_objects(the_repository, n);
 }
 
+static int add_packed_object(const struct object_id *oid,
+			     struct packed_git *pack,
+			     uint32_t pos,
+			     void *_data)
+{
+	struct packing_data *packed = _data;
+	struct object_entry *entry;
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	oi.typep = &type;
+
+	entry = packlist_alloc(packed, oid);
+	entry->idx.offset = nth_packed_object_offset(pack, pos);
+	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
+		die("could not get type of object %s",
+		    oid_to_hex(oid));
+	oe_set_type(entry, type);
+	oe_set_in_pack(packed, entry, pack);
+
+	return 0;
+}
+
+static int idx_oid_cmp(const void *va, const void *vb)
+{
+	const struct pack_idx_entry *a = *(const struct pack_idx_entry **)va;
+	const struct pack_idx_entry *b = *(const struct pack_idx_entry **)vb;
+
+	return oidcmp(&a->oid, &b->oid);
+}
+
+static int bitmap_write(const char *basename)
+{
+	struct packed_git *p = NULL;
+	struct packing_data packed = { 0 };
+	struct bitmap_writer writer;
+	struct pack_idx_entry **index;
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	prepare_repo_settings(the_repository);
+	repo_for_each_pack(the_repository, p) {
+		if (!strcmp(pack_basename(p), basename))
+			break;
+	}
+
+	if (!p)
+		die("could not find pack '%s'", basename);
+
+	if (open_pack_index(p))
+		die("cannot open pack index for '%s'", p->pack_name);
+
+	prepare_packing_data(the_repository, &packed);
+
+	for_each_object_in_pack(p, add_packed_object, &packed,
+				ODB_FOR_EACH_OBJECT_PACK_ORDER);
+
+	/*
+	 * Build the index array now that data.packed.objects[] is
+	 * fully allocated (packlist_alloc() may have reallocated it
+	 * during the loop above).
+	 */
+	ALLOC_ARRAY(index, p->num_objects);
+	for (i = 0; i < p->num_objects; i++)
+		index[i] = &packed.objects[i].idx;
+
+	bitmap_writer_init(&writer, the_repository, &packed, NULL);
+	bitmap_writer_build_type_index(&writer, index);
+
+	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+		struct object_id oid;
+		struct commit *c;
+
+		if (get_oid_hex(buf.buf, &oid))
+			die("invalid OID: %s", buf.buf);
+
+		c = lookup_commit(the_repository, &oid);
+		if (!c || repo_parse_commit(the_repository, c))
+			die("could not parse commit %s", buf.buf);
+
+		bitmap_writer_push_commit(&writer, c, 0);
+	}
+
+	select_pseudo_merges(&writer);
+	if (bitmap_writer_build(&writer) < 0)
+		die("failed to build bitmaps");
+
+	bitmap_writer_set_checksum(&writer, p->hash);
+
+	QSORT(index, p->num_objects, idx_oid_cmp);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, p->pack_name);
+	strbuf_strip_suffix(&buf, ".pack");
+	strbuf_addstr(&buf, ".bitmap");
+	bitmap_writer_finish(&writer, index, buf.buf, 0);
+
+	bitmap_writer_free(&writer);
+	strbuf_release(&buf);
+	free(index);
+	clear_packing_data(&packed);
+
+	return 0;
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
@@ -51,13 +159,16 @@ int cmd__bitmap(int argc, const char **argv)
 		return bitmap_dump_pseudo_merge_commits(atoi(argv[2]));
 	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-objects"))
 		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
+	if (argc == 3 && !strcmp(argv[1], "write"))
+		return bitmap_write(argv[2]);
 
 	usage("\ttest-tool bitmap list-commits\n"
 	      "\ttest-tool bitmap list-commits-with-offset\n"
 	      "\ttest-tool bitmap dump-hashes\n"
 	      "\ttest-tool bitmap dump-pseudo-merges\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
-	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>");
+	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>\n"
+	      "\ttest-tool bitmap write <pack-basename> < <commit-list>");
 
 	return -1;
 }
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f693cb56691..efeb71593bf 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -648,4 +648,28 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_grep corrupted.bitmap.index stderr
 '
 
+test_expect_success 'test-tool bitmap write determines bitmap selection' '
+	test_when_finished "rm -fr bitmap-write-helper" &&
+	git init bitmap-write-helper &&
+	(
+		cd bitmap-write-helper &&
+
+		test_commit_bulk 64 &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git rev-parse HEAD >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test-tool bitmap list-commits >bitmaps.raw &&
+		sort bitmaps.raw >bitmaps &&
+		test_cmp in bitmaps &&
+
+		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		git rev-list --count --objects HEAD >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.54.0.76.g9b17dab2cf7

