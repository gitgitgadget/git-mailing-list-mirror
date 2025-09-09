Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25B303A3D
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445111; cv=none; b=h2XfyXZwse4YahI1AO88OfwoXgJPlFo6/659qnOW9LHqtkwuI0KWV8awum5PDkky5+C3IXDnaY0veCTF5yNwt7oGGb+owa/N2WxAAbDRQGuZ+LoUacj3ZTl8v8tScI1MazTvO7YdlABZbsA9mRFIqrvaOs5tbrSIIvqPWx+etZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445111; c=relaxed/simple;
	bh=H2W5Miy/aN7pfSD1SdVRBtjq1BBkRQ/I0Rpd/zy+SkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bABw2a+aD/oaQa9N+GjTZxxA76/7v9DFftC91JtRnl6+sXuH+ZgD/qxH7LIZiJtpjMmFUyutZGhENSEYc9pWMEoYGhB+HUoiuh3IR7gbNHN8nqbA8hPa6cG5tzLWAuWpKXE7jacxbunskGC3EcX0KT0eQ48+hvKDrs/ZQI7AePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOI8/YAC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOI8/YAC"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7493d03f426so1627359a34.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445108; x=1758049908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct6D3f+ZMHULnO9/vNNY6NyekVxdLOiAUi2qqzhqtjk=;
        b=GOI8/YAC7I9vuc3XNMpu0y0Y8H71JhprsOyRMbcwUWhBj+Qlp73A/eMXAhqbMVdBhC
         oYNOAE769Ehq7DMq0oLWieUyR6GMwsHknoWr0UoeFbVsLCxDrbyRNXxkNPS1ZYKRMt54
         GOepPg1kSjmXmN4YBr1rm5aXS9h3O5hwTe5k6cHeRJ50qJYChMmTxjX/inXxGEvWyuC0
         8AJoTERzwLBBbaFNPIeq2avMkKY6mX6r6Q+PPujsQuAQrbfSVmYFWgQdQX6mi37xSMcT
         LCd1b490PRqxsH8r2lXPwc1c8j8M2FJeLaeVoAVin0ncJoLrczDgtvvnfy+ZnxFjmOzE
         duLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445108; x=1758049908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct6D3f+ZMHULnO9/vNNY6NyekVxdLOiAUi2qqzhqtjk=;
        b=d19y2yF2dYONxQOvKuWA/o2PSjjuP8pqZNlVl14XHtQE+kCdE7F228nplvs1wgfW63
         P1Q9sUQitKDbprG020X7p22i/PYkv6N4FAV+Nx7aMJBuBYwbPG6YMI/xYJQwCNhVjFhD
         EmFbDuvJEQ+4zRC2WqTffjAuYQNHpTumCoFAXotsTjLVyEl0L90IZjmF5BSSKJyaShl0
         H9n7vallCM5vp+HTX72/hQoQ9pq4JEmm5Bu5Vn6ZvG2aCXHzdXIRk9KsfTuOj2+Ic5fY
         +kbVA+a465ZIqEpsZKbKbBj+p0X/JdoSy8FqCAP/Nw7K482rKF8GYKzdyrASJwh2iSbN
         5VAg==
X-Gm-Message-State: AOJu0YyDzzbEQFS8HlhJ9EWRlZD+IT/wuU0QrtiLEzLtsyBPIrU0t7Jj
	8iGQV2Qqwv4h8nBT4aWgZ3DyKyJWoYjroK7/ukjDt9jNFkFZI5YsMZW/ZIJ3WQ==
X-Gm-Gg: ASbGnctSVnPkkeT9j0EQjm4dNkY4YWbxO9XO5t5+mCjqdjOo0tCL4esJwDAJMsjlU5P
	7aOQE2qnfWzFLLmy+WKyJv4NjIEKGxC7cd+8JWpUQaTBRuP0GV1T0nVyptAShTnsT75jcQ7OCkb
	A8A0emoNlOIBtYIoudiiksKio0UYROvaZOG8ZJxp/uJzGRPXlZqMe2rmIOrvdR8b30OqX2+OxkI
	37dVvsUo1RIdPK6aiMV8+28YlCsBBdwphPbKtWfyN0kjNspG17I8abhapKAZryddoDKPoBxai7t
	xfUbTB2gJ0y10s0fjxILyd9js9YUOg3uGtoOIEqLWzsUv6TPOQWR/15dVfBX7pQLGtEYrifdxLk
	Vwf5nm31gxOST5+ZTykU9tnR0QPbRQak=
X-Google-Smtp-Source: AGHT+IH3DpOTDzf5oHhM/ep96HjcOtukWuuYOnpwY2pKVGAmnhEU9pXntmXZx9hUBsHBjqX6tDW/aA==
X-Received: by 2002:a05:6830:67ca:b0:74a:6197:368e with SMTP id 46e09a7af769-74c768f9e4bmr7128850a34.17.1757445108141;
        Tue, 09 Sep 2025 12:11:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/6] builtin/update-index: end ODB transaction when --verbose is specified
Date: Tue,  9 Sep 2025 14:11:30 -0500
Message-ID: <20250909191134.555689-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250909191134.555689-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 23a3a303 (update-index: use the bulk-checkin infrastructure,
2022-04-04), object database transactions were added to
git-update-index(1) to facilitate writing objects in bulk. With
transactions, newly added objects are instead written to a temporary
object directory and migrated to the primary object database upon
transaction commit.

When the --verbose option is specified, each individual object is
explicitly flushed via flush_odb_transaction() prior to reporting the
update. Flushing the object database transaction migrates pending
objects to the primary object database without marking the transaction
as complete. This is done so objects are immediately visible to
git-update-index(1) callers using the --verbose option and that rely on
parsing verbose output to know when objects are written.

As soon as verbose output is requested in git-update-index(1), all
subsequent object writes are flushed prior to being reported and thus no
longer benefit from being transactional. Furthermore, the mechanism to
flush a transaction without committing is rather awkward. Drop the call
to flush_odb_transaction() in favor of ending the transaction early when
the --verbose flag is encountered.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/update-index.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2ba2d29c959..0129b14f447 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -70,14 +70,6 @@ static void report(const char *fmt, ...)
 	if (!verbose)
 		return;
 
-	/*
-	 * It is possible, though unlikely, that a caller could use the verbose
-	 * output to synchronize with addition of objects to the object
-	 * database. The current implementation of ODB transactions leaves
-	 * objects invisible while a transaction is active, so flush the
-	 * transaction here before reporting a change made by update-index.
-	 */
-	flush_odb_transaction(the_repository->objects->transaction);
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -1150,6 +1142,21 @@ int cmd_update_index(int argc,
 			const char *path = ctx.argv[0];
 			char *p;
 
+			/*
+			 * It is possible, though unlikely, that a caller could
+			 * use the verbose output to synchronize with addition
+			 * of objects to the object database. The current
+			 * implementation of ODB transactions leaves objects
+			 * invisible while a transaction is active, so end the
+			 * transaction here early before processing the next
+			 * update. All further updates are performed outside of
+			 * a transaction.
+			 */
+			if (transaction && verbose) {
+				end_odb_transaction(transaction);
+				transaction = NULL;
+			}
+
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
@@ -1214,7 +1221,8 @@ int cmd_update_index(int argc,
 	/*
 	 * By now we have added all of the new objects
 	 */
-	end_odb_transaction(transaction);
+	if (transaction)
+		end_odb_transaction(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
-- 
2.51.0.193.g4975ec3473b

