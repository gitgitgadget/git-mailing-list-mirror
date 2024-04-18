Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA18171090
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465672; cv=none; b=K925IiIxYKPMikbsg0snTgb9lEZF4doBqzovwQuODS7qifJLF17X2WcS6DsvEJ8UA+fOd2y+o58lycpQLk/+gU9wjKVNaiMi3QC4xxNjmkuTSK3KjMkQ6IXo2Q9cRmM49QRISyZ4kxHP3R3jVoigSpqEurZk0Xk5gDYczp/Jv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465672; c=relaxed/simple;
	bh=SM8HLbabN2WhT3cjZrQLZOTKncyaaB9PTtvhASgUKLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiR5vMoeLnCMvTr6+gBh8syBM394aVRtbGlRiMgu+ZSNXxbVHDJN/dLPfT91aWLZxpF/H2nAVHmrzRSk6tNdy5gevdnGDpPM2o0ZM2/8b4iJOvsoHId7d6f84MwuLSg7P/IoQz/tQ9n7U7YARivfKow1fO+nhBXYKvyj4pZEGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHesO9p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHesO9p"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418effbc5d4so5150085e9.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465667; x=1714070467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6SqfC+XlSNKud2m+IkuTR+13esum+d7299YKyypEsw=;
        b=hsHesO9pORjBY38B5kwO79fKu41fNRZjdvl01o0ptADEHNw69tbLbIYJSiM8KEGEdT
         7250hszOfoX5r3yxbrrnAn1lAuqDC+XwfVvdHw/lc/UNT7/oflMX2TsoSzRPQlYNt8y3
         1xopAE2AE7fEW06bjssGyIqMWcU2Yn/tLD1NVKAt3fVCBw23N2IoLoPxhZ4KOi0moN5N
         XCUyroiR7+b2uAJIA7Yq6wr8dynVFdOO3gqv1YIqDs8ABDbgwlTUZdB5QLKncMQATXsf
         bN2BkVB4+QM8I7rIRpioOweSxnsdum9xG8i28EEaU1kr1yu18+Zuw7Q05LB7YlsUG8aQ
         SKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465667; x=1714070467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6SqfC+XlSNKud2m+IkuTR+13esum+d7299YKyypEsw=;
        b=uuwJgYUZJWlCQ+TMq8TFTx0bPTcbtxIMNobeD3z9HiLh6HrWAgKHCSfs5nWF4BbrjC
         OcGSap7VsgyD/PzirlFXy1TimZ1Ahik1iknATYOdfEi83kqQjCye7p4B+vmBxc1yq+qD
         SpZvfxjhC6bQnkmFz2VkEVFrBvXBS9UU4Jyqn+odtRBuCGkpKovy3CDy7/0e6tv3wgPp
         Tg9RNrjfe2BjDGz7rdtVpsZJRPX0Eesw9en/8jyh6gY6lV8VKy0Kur5YgxGUlNDG4xLD
         iITfUe+BiPd/oiHFln1hWTUFt3hL6+7laIa16Ro/McOiSa7xNriOeBatX79AhG7K0Hl/
         zPvQ==
X-Gm-Message-State: AOJu0YzF9IXEqRpSmTMbqxJoWjmCwUUIhebggnRW1atCKwYJ6YOjy9tf
	3Nej1QACAqJcvAqsVvVLXTpKHmURejJ3EIPzPMSTEnJ2K4rh7ilQKVEQ2g==
X-Google-Smtp-Source: AGHT+IH7/xr8ugoWWYpzy+FSxW+oqQEr9gKFLDmgTI/+bAsi4TeW355Pb9La8MUY4DgLxxQBFZBFrA==
X-Received: by 2002:a05:600c:35d5:b0:414:d95:cc47 with SMTP id r21-20020a05600c35d500b004140d95cc47mr3427121wmq.30.1713465666893;
        Thu, 18 Apr 2024 11:41:06 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm3653670wmo.22.2024.04.18.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:41:06 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] upload-pack: allow configuring a missing-action
Date: Thu, 18 Apr 2024 20:40:43 +0200
Message-ID: <20240418184043.2900955-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.655.g111bceeb19
In-Reply-To: <20240418184043.2900955-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Couder <chriscool@tuxfamily.org>

In case some objects are missing from a server, it might still be
useful to be able to fetch or clone from it if the client already has
the missing objects or can get them in some way.

For example, in case both the server and the client are using a
separate promisor remote that contain some objects, it can be better
if the server doesn't try to send such objects back to the client, but
instead let the client get those objects separately from the promisor
remote. (The client needs to have the separate promisor remote
configured, for that to work.)

Another example could be a server where some objects have been
corrupted or deleted. It could still be useful for clients who could
get those objects from another source, like perhaps a different
client, to be able to fetch or clone from the server.

To configure what a server should do if there are such missing
objects, let's teach `git upload-pack` a new
`uploadpack.missingAction` configuration variable.

This missing-action works in a similar way as what `git rev-list` and
`git pack-objects` already support with their
`--missing=<missing-action>` command line options. In fact when
`uploadpack.missingAction` is set to something different than "error",
`git upload-pack` will just pass the corresponding
`--missing=<missing-action>` to `git pack-objects`.

So the `uploadpack.missingAction` has the same limitations as
`git pack-objects --missing=<missing-action>`. Especially when not
using promisor remotes, 'allow-any' works only for blobs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/uploadpack.txt |   9 ++
 missing.c                           |  16 ++++
 missing.h                           |   2 +
 t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
 upload-pack.c                       |  19 +++++
 5 files changed, 171 insertions(+)
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
index d306dea2d9..022ebbe4be 100644
--- a/missing.c
+++ b/missing.c
@@ -24,3 +24,19 @@ int parse_missing_action_value(const char *value, int print_ok)
 
 	return -1;
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
index 77906691e7..ca574f83a0 100644
--- a/missing.h
+++ b/missing.h
@@ -15,4 +15,6 @@ enum missing_action {
  */
 int parse_missing_action_value(const char *value, int print_ok);
 
+const char *missing_action_to_string(enum missing_action action);
+
 #endif /* MISSING_H */
diff --git a/t/t5706-upload-pack-missing.sh b/t/t5706-upload-pack-missing.sh
new file mode 100755
index 0000000000..21bb6aed2b
--- /dev/null
+++ b/t/t5706-upload-pack-missing.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description='handling of missing objects in upload-pack'
+
+TEST_PASSES_SANITIZE_LEAK=true
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
+	sed -n "s/^\?\(.*\)/\1/p" <all.txt >missing.txt &&
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
+	git clone -c remote.server2.promisor=true \
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
+	git clone -c remote.server2.promisor=true \
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
index 902144b9d3..c355ebe1e5 100644
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
@@ -1371,6 +1378,18 @@ static int upload_pack_config(const char *var, const char *value,
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
 		data->advertise_sid = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.missingaction", var)) {
+		int res = parse_missing_action_value(value, 0);
+		if (res < 0)
+			die(_("invalid value for '%s': '%s'"), var, value);
+		/*
+		 * parse_missing_action_value() unsets fetch_if_missing
+		 * but if we allow promisor we want to still fetch from
+		 * the promisor remote
+		 */
+		if (res == MA_ALLOW_PROMISOR)
+			fetch_if_missing =1;
+		data->missing_action = res;
 	}
 
 	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
-- 
2.44.0.655.g111bceeb19

