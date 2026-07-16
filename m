Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220341B8E2
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208557; cv=none; b=dRFpVQOCkGBG4Jnu4AwciafE/F5W7Bb4bqK2xR+j0kYuZ5w68KaaYXnBGqPIHkhyl6BeoxEImuYp+yOYT38PyuTkVne/3sndL8oYN4GsaaMUXfonEsJgXxzGmhRjdeepbJxm269kTiBlKzlf5LlL+Y5JNtQPsnJoGP9r0qTBlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208557; c=relaxed/simple;
	bh=B6GfEsbqf2Kv3w5TXzc4J2SEnCpa7YOYoqPjMBF1XgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFtBXIcYkUvCWfxX53xbkbXolmM6wn0bjn0gbRTacM7fQYp1bYqpKPlmiFE65z/Z0iIU6TcZbRplaD2HGg43/aegWDsKachmR7KYieVyZXlwtfDucBw/kt3XuptP6f8hBwgZhvvoWg2yIN68pGQUgpJ7wsk7TY4dk5AQhf23u+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytp7/XIL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytp7/XIL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4721183a91.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208555; x=1784813355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c/oV9m0Q070zkk7/euPIbU8n9Wa3A2zM0ox8GnwjD8=;
        b=Ytp7/XILC4hTDKuyDDPv4hSnEWoE16n1vXczwjEfmvkhTgRPk8qEPwLgZ2OJQbWMgg
         +iPMeLbe2Q4YqeduI1woyqRCbmnhpPaBc53J5UsX/hvWDncQAppd3FLo0t/ixsogWDQ2
         3+L91FLNIZGns0/qY/cG5ADQ0xDBOmO5MuJ6jqubdD0RX3/NOCcTiAlLGBaIVM/wkAx/
         IEBt0CcAiik1nBwIsK9GSy+A2wSRIwfLnp8udm3R1+h6ZVrjjR72zSpdrbeP1l74qlxJ
         edibw0IgiITTXeOueX74VHJHqIUjYrnm61ANvTsxbB7FCbL+pJz5Tll7/VT377+maZjc
         GBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208555; x=1784813355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6c/oV9m0Q070zkk7/euPIbU8n9Wa3A2zM0ox8GnwjD8=;
        b=CSoJKOHxp0uaX21Iv25tDojGH5Y+2wV1M02/PsCuxQL37cBU2NPIvyFbVVgGbUn22c
         reInuRzVdsRgFbVL7zVnueujQRGYDmdmQFWd+OBkKPwDSL7wmDt7poZ7PnHq6CmhL6Iy
         Ew2yuQ3hUlCFYrg18XtlkHZcVpA9y/O18zJFzU1e+67RDAbRRi5EvnSeDL/UKhnsDrp4
         csxgRJGCjv35CrkCya0tq1jUERsKZ2fgepncaxYx/71fRwXD9KSWSokRJ6PzTuKf5Vbt
         2XEsbhmcUgHY9tEie2D2pfKGl2DJ7g7pMw/UinyKFeXOP80bCDSBA6evogl0iI09X3zT
         07EQ==
X-Gm-Message-State: AOJu0YxumiXfaf61M8pIxw1gM2vKaNj0CUaowaqjdulTIuTwUJf5N3Vq
	NQgeddodVPyC6fEXPg/PfKxHi9JGNtDLiXO9yEa3HM6Ddx+xzTbOTPoFTW/HHgwm
X-Gm-Gg: AfdE7clDmTbMxXqpvD5LdBEZVQhp2PQkqpMnCYwKotx8H3CX3l2gUPkYHgGMftW6Zl1
	IQK6XftiBDEJ91gaWtKuvk6UHbLvfxS71tdiSng4zM9YH4PY8xdAGt6TdlQqaboQUqQmzpRnFy6
	ugppjOohx4wI1RvbowiLUJ39YYtdBKfez+y6I2I24uNxLoTGBhBhh74vQBLXHGBNsj+uX9Q8Lzd
	upoSdmDlBEbEAE/s/6huDESydyKYLa5juO6dX4S6uo5r/cFu8sKZA29Lmh/8hkczLTlHfK8t082
	wrUeo8Za5hQh3yhDRC55CiqDAKm1ULyJPd0DE/pbDoPEibdJCNYqv05b0Hnp4DYtPjLJrMCU4Yy
	sZ7gjNn2iKg8111nVx9GQF6yf9bdr59Vc8vj/nDYh7les00j37kipiAkdOtlIMyryXOd9K3B6gO
	A2hyLiV/Hy+RxtRehuNOP+MK2QYHR2GRS2pByUm9aZqfksTd8ho276gHD3j6D+/gOSHXII0bcGz
	Gjq8coxBULDINejbCeFZr7V06N7aLXUBjCyG3TsTGnu
X-Received: by 2002:a17:90b:1807:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-38e2a0174famr5208232a91.13.1784208554712;
        Thu, 16 Jul 2026 06:29:14 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:14 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and --dry-run options
Date: Thu, 16 Jul 2026 18:58:42 +0530
Message-ID: <20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new command-line options to 'git-repack':

  --drop-filtered: intended to eventually delete objects that match
                   the filter specification. Requires --filter and -a,
                   and is incompatible with --filter-to.
  --dry-run: show which objects would be dropped without making any
             changes. Only meaningful with --drop-filtered.

--drop-filtered also requires a promisor remote to be configured,
since dropping objects without a remote to fetch them back from would
be permanent data loss.

--drop-filtered is incompatible with bitmap writing: filtering breaks
the "all objects in one pack" closure that bitmaps require. An explicit
-b is rejected with a clear error and a default-on bitmap configuration is
silently disabled for the duration of the command.

These options currently only perform validation. The actual enumeration
and deletion will be added in follow-up commits.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index db504d673f..f4db0fc535 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,6 +14,7 @@
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -28,6 +29,8 @@ static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 static int midx_must_contain_cruft = 1;
+static int drop_filtered;
+static int dry_run;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
@@ -231,6 +234,10 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_BOOL(0, "drop-filtered", &drop_filtered,
+				N_("delete filtered out objects (requires --filter)")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+				N_("only show which objects would be dropped")),
 		OPT_END()
 	};
 
@@ -252,6 +259,43 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
+	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
+		!!filter_to, "--filter-to");
+
+	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
+		write_bitmaps > 0, "--write-bitmap-index");
+
+	if (dry_run && !drop_filtered)
+		die(_("--dry-run only takes effect with --drop-filtered"));
+
+	if (drop_filtered) {
+		if (!dry_run)
+			die(_("--drop-filtered doesn't work without --dry-run yet"));
+
+		if (!po_args.filter_options.choice)
+			die(_("--drop-filtered requires --filter"));
+
+		if (!(pack_everything & ALL_INTO_ONE))
+			die(_("--drop-filtered requires -a"));
+
+		/*
+		 * Only blob:limit=<n> is supported for now. Reject other
+		 * filter choices early, before walking the object database.
+		 */
+		if (po_args.filter_options.choice != LOFC_BLOB_LIMIT)
+			die(_("--drop-filtered only supports --filter=blob:limit=<n> for now"));
+
+		/*
+		 * Without a promisor remote there is nowhere to re-fetch the
+		 * dropped objects from, so dropping them would be permanent
+		 * data loss.
+		 */
+		if (!repo_has_promisor_remote(repo))
+			die(_("--drop-filtered requires a promisor remote"));
+
+		write_bitmaps = 0;
+	}
+
 	if (delete_redundant && repo->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
-- 
2.54.0

