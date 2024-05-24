Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F512F36F
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568791; cv=none; b=oMCgdpSt1o222QrMPU59Huhb3czoq/O817PDpFxkFWWtP+1xdsFQSVUzMt3Y5sZTHFkoZw5hGMyasDQiqoAGMPCOve9JxjWwyRuHg0IuWu4h1jKWuXSByLZ0ejswP36i8EPpM5/XtnwZPcYMtJDYEOgSb9uaG8AWFDRXKs3FsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568791; c=relaxed/simple;
	bh=raJj6f53O+c0TbvYuF5I6TAOyxXnXs8DaP4rxsH6yTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD4j/Z1cKTFIHIg0NJVRGV9rVGiYIVoDVa0XFFZ54wei02k4Z4AP/B0r+hmy0LHdi+CEX4OKDThFamORuKFnor7Tve+ihNg1G3Vt7y/TZIWL1IleEpYnHCsS5FDVpydqKhgXAfO9oHWMhUENj55jpkrdWm5xY/UBGyKKoa3Sq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJOX7wA6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJOX7wA6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3550840d92dso992555f8f.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568787; x=1717173587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCnLT40YLDA+AV45sQYgoAWmVwBhZaOkwvPuTAMSGok=;
        b=fJOX7wA6mQAvdg1MCXn4S3DaXak46mjVjVluttxmEH3rb4MtwOC4iUPH6ARAk4hxVR
         dud7rAHxH7+u4Xd5XhQzfuCccxY1lsb5lvlfyXhwF9ZWTFVXQ3/3K0Mr9ek7b0OtxqJj
         tVv4ZZ6s5UVMiIt6HaLcriypXNWeDJPaKgHyFN4jw7qhnfbVibXq5+kKpKGxV6VPJDN6
         AC/2WTLb5VIHTFujExZmOvkweDYMB8KlC2SNQSofoNbHHknk419yv0oR3UwJv56QSOoX
         KMwmRTMsfipqCQ3Qh6a+VXBeYyb5C1Z2q8AsxGFzDMXChryg+ZIGGAZCSHlv/EebrzdY
         nxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568787; x=1717173587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCnLT40YLDA+AV45sQYgoAWmVwBhZaOkwvPuTAMSGok=;
        b=WjcRFSDJ0knZZwNKPntZASo9TdfLd6GPKNUca0rYjzG7NgKMM2+tmX4sVL3y3QR2cN
         65ZzHT3JzJrEypOpTpkP1zyHIzb292FT0oXHUW7sRAoi8TRZnPuDwOB8wH2ix3YKfN+E
         BGtjGxUBMtOQ+NMukWahGB/PkaJ3nZ77QyQ/JQb6t58oRwjnp4Sn91uzLXiZQ1M8r+2O
         Z83clbf7mos9/057iZmE7L5ugnYQN9kmaM3jmw7VtapUqoOijuCKhWQmt0EfgjTxY6DG
         5wSCBgNaqLEr7psRMahZvJlqH3LQ6Ua8DGi3ly8mGEPD6SKyIdbp16MNLD/QLnK2HylY
         7n9A==
X-Gm-Message-State: AOJu0Yyb2+qkmGe/wgKB6yauLnJER1ZNchrtT12bmNj8sIJnPlnvZM4q
	wkKbVc8o+3fNxS8BRneJN+ivPayffnHCflB4YuSwkAorAG9a2UxLtYseYg==
X-Google-Smtp-Source: AGHT+IHNXx63bfm1+9G4ie3w5CDyJNw+at1eVLUig+9RCnPz90LXsdyWJD8zcuprTCcQ3GeeHrrSrw==
X-Received: by 2002:a5d:5144:0:b0:354:fbdc:7d2e with SMTP id ffacd0b85a97d-355245e30e8mr1791219f8f.11.1716568787381;
        Fri, 24 May 2024 09:39:47 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9303sm1976282f8f.88.2024.05.24.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:39:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/3] upload-pack: allow configuring a missing-action
Date: Fri, 24 May 2024 18:39:26 +0200
Message-ID: <20240524163926.2019648-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.219.gbac909a070
In-Reply-To: <20240524163926.2019648-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
 <20240524163926.2019648-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case some objects are missing from a server, it is sometimes
useful to be able to fetch or clone from it if the client already has
the missing objects or can get them in some way.

Suppose repository S borrows from its "promisor" X, and repository C
which initially cloned from S borrows from its "promisor" S. If C
wants an object in order to fill in the gap in its object graph, and
S does not have it (as S itself has no need for that object), then it
makes sense to let C go directly to X bypassing S.

Another example could be a server where some objects have been
corrupted or deleted. It could still be useful for clients who could
get those objects from another source, like perhaps a different
client, to be able to fetch or clone from the server.

To configure what a server should do if there are such missing
objects, let's teach `git upload-pack` a new
`uploadpack.missingAction` configuration variable.

This new missing-action works in a similar way as what `git rev-list`
and `git pack-objects` already support with their
`--missing=<missing-action>` command line options. In fact when
`uploadpack.missingAction` is set to something different than "error",
`git upload-pack` will just pass the corresponding
`--missing=<missing-action>` to `git pack-objects`.

So this new missing-action has the same limitations as
`git pack-objects --missing=<missing-action>`. Especially when not
using promisor remotes, 'allow-any' works only for blobs.

Another limitation comes from `git upload-pack` itself which requires
setting `GIT_NO_LAZY_FETCH` to 0 since 7b70e9efb1 (upload-pack:
disable lazy-fetching by default, 2024-04-16) for lazy fetching from
a promisor remote to work on the server side.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/uploadpack.txt |   9 ++
 missing.c                           |  16 ++++
 missing.h                           |   3 +
 t/t5706-upload-pack-missing.sh      | 124 ++++++++++++++++++++++++++++
 upload-pack.c                       |  17 ++++
 5 files changed, 169 insertions(+)
 create mode 100755 t/t5706-upload-pack-missing.sh

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 16264d82a7..cd70e853b3 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -82,3 +82,12 @@ uploadpack.allowRefInWant::
 	is intended for the benefit of load-balanced servers which may
 	not have the same view of what OIDs their refs point to due to
 	replication delay.
+
+uploadpack.missingAction::
+	If this option is set, `upload-pack` will call
+	linkgit:git-pack-objects[1] passing it the corresponding
+	`--missing=<missing-action>` command line option. See the
+	documentation for that option, to see the valid values and
+	their meaning. This could be useful if some objects are
+	missing on a server, but a client already has them or could
+	still get them from somewhere else.
diff --git a/missing.c b/missing.c
index a0c2800d30..814cab5326 100644
--- a/missing.c
+++ b/missing.c
@@ -35,3 +35,19 @@ int parse_missing_action_value_for_packing(const char *value)
 		return -2 - res;
 	}
 }
+
+const char *missing_action_to_string(enum missing_action action)
+{
+	switch (action) {
+	case MA_ERROR:
+		return "error";
+	case MA_ALLOW_ANY:
+		return "allow-any";
+	case MA_PRINT:
+		return "print";
+	case MA_ALLOW_PROMISOR:
+		return "allow-promisor";
+	default:
+		BUG("invalid missing action %d", action);
+	}
+}
diff --git a/missing.h b/missing.h
index cdfd522852..3a4659e546 100644
--- a/missing.h
+++ b/missing.h
@@ -22,4 +22,7 @@ int parse_missing_action_value(const char *value);
  */
 int parse_missing_action_value_for_packing(const char *value);
 
+/* Return a short string literal describing the action. */
+const char *missing_action_to_string(enum missing_action action);
+
 #endif /* MISSING_H */
diff --git a/t/t5706-upload-pack-missing.sh b/t/t5706-upload-pack-missing.sh
new file mode 100755
index 0000000000..1a9b06d84e
--- /dev/null
+++ b/t/t5706-upload-pack-missing.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='handling of missing objects in upload-pack'
+
+. ./test-lib.sh
+
+# Setup the repository with three commits, this way HEAD is always
+# available and we can hide commit 1 or 2.
+test_expect_success 'setup: create "template" repository' '
+	git init template &&
+	test_commit -C template 1 &&
+	test_commit -C template 2 &&
+	test_commit -C template 3 &&
+	test-tool genrandom foo 10240 >template/foo &&
+	git -C template add foo &&
+	git -C template commit -m foo
+'
+
+# A bare repo will act as a server repo with unpacked objects.
+test_expect_success 'setup: create bare "server" repository' '
+	git clone --bare --no-local template server &&
+	mv server/objects/pack/pack-* . &&
+	packfile=$(ls pack-*.pack) &&
+	git -C server unpack-objects --strict <"$packfile"
+'
+
+# Fetching with 'uploadpack.missingAction=allow-any' only works with
+# blobs, as `git pack-objects --missing=allow-any` fails if a missing
+# object is not a blob.
+test_expect_success "fetch with uploadpack.missingAction=allow-any" '
+	oid="$(git -C server rev-parse HEAD:1.t)" &&
+	oid_path="$(test_oid_to_path $oid)" &&
+	path="server/objects/$oid_path" &&
+
+	mv "$path" "$path.hidden" &&
+	test_when_finished "mv $path.hidden $path" &&
+
+	git init client &&
+	test_when_finished "rm -rf client" &&
+
+	# Client needs the missing objects to be available somehow
+	client_path="client/.git/objects/$oid_path" &&
+	mkdir -p $(dirname "$client_path") &&
+	cp "$path.hidden" "$client_path" &&
+
+	test_must_fail git -C client fetch ../server &&
+	git -C server config uploadpack.missingAction error &&
+	test_must_fail git -C client fetch ../server &&
+	git -C server config uploadpack.missingAction allow-any &&
+	git -C client fetch ../server &&
+	git -C server config --unset uploadpack.missingAction
+'
+
+check_missing_objects () {
+	git -C "$1" rev-list --objects --all --missing=print > all.txt &&
+	perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
+	test_line_count = "$2" missing.txt &&
+	test "$3" = "$(cat missing.txt)"
+}
+
+test_expect_success "setup for testing uploadpack.missingAction=allow-promisor" '
+	# Create another bare repo called "server2"
+	git init --bare server2 &&
+
+	# Copy the largest object from server to server2
+	obj="HEAD:foo" &&
+	oid="$(git -C server rev-parse $obj)" &&
+	oid_path="$(test_oid_to_path $oid)" &&
+	path="server/objects/$oid_path" &&
+	path2="server2/objects/$oid_path" &&
+	mkdir -p $(dirname "$path2") &&
+	cp "$path" "$path2" &&
+
+	# Repack everything first
+	git -C server -c repack.writebitmaps=false repack -a -d &&
+
+	# Repack without the largest object and create a promisor pack on server
+	git -C server -c repack.writebitmaps=false repack -a -d \
+	    --filter=blob:limit=5k --filter-to="$(pwd)" &&
+	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	> "$promisor_file" &&
+
+	# Check that only one object is missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Configure server2 as promisor remote for server
+	git -C server remote add server2 "file://$(pwd)/server2" &&
+	git -C server config remote.server2.promisor true &&
+
+	git -C server2 config uploadpack.allowFilter true &&
+	git -C server2 config uploadpack.allowAnySHA1InWant true &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true
+'
+
+test_expect_success "fetch with uploadpack.missingAction=allow-promisor" '
+	git -C server config uploadpack.missingAction allow-promisor &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch without uploadpack.missingAction=allow-promisor" '
+	git -C server config --unset uploadpack.missingAction &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server anymore
+	check_missing_objects server 0 ""
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 8fbd138515..064996d95e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -29,6 +29,8 @@
 #include "write-or-die.h"
 #include "json-writer.h"
 #include "strmap.h"
+#include "missing.h"
+#include "object-file.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -96,6 +98,8 @@ struct upload_pack_data {
 
 	const char *pack_objects_hook;
 
+	enum missing_action missing_action;
+
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
@@ -315,6 +319,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		strvec_push(&pack_objects.args, "--delta-base-offset");
 	if (pack_data->use_include_tag)
 		strvec_push(&pack_objects.args, "--include-tag");
+	if (pack_data->missing_action)
+		strvec_pushf(&pack_objects.args, "--missing=%s",
+			     missing_action_to_string(pack_data->missing_action));
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
@@ -1374,6 +1381,16 @@ static int upload_pack_config(const char *var, const char *value,
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
 		data->advertise_sid = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.missingaction", var)) {
+		int res = parse_missing_action_value_for_packing(value);
+		if (res < 0)
+			die(_("invalid value for '%s': '%s'"), var, value);
+		/* Allow fetching only from promisor remotes */
+		if (res == MA_ALLOW_PROMISOR)
+			fetch_if_missing = 1;
+		if (res == MA_ALLOW_ANY)
+			fetch_if_missing = 0;
+		data->missing_action = res;
 	}
 
 	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
-- 
2.45.1.219.gbac909a070

