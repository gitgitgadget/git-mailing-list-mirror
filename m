Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF433F58B
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302076; cv=none; b=mZSlgJ1bAihtEekhMEuuuWKurRA755YV8vZXUvOuQ4Se4n4Q0WLRpgFznZeLkGBHBQlCvLKMnFxdShNcTHJQdnEeZ3T6W+eqJIxzq9Y2xXBLnKhha/HYEAqxacBjSYM5F4SFSakWErpHqCZcdOOEuZOpkPQc2uCW/W6FG/wOdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302076; c=relaxed/simple;
	bh=2x+cLqx1Con3bPx7b6pE2PDNv2r4etIf2lLWHrVYFUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdXXROS2RVkmoh5bKlRmaWgeaFDsqHq4c7fib18WbEVJNdG7jQyfbD9z3D41eQYtfpXpj+W4etHAFh3+rOf5aO/G0kGdsU5ygKhwI9RgAaz/6KqhLi0XV5w4eNJC1/eUjm/GyK6/VsBmCNPQykLMy8nBoZ39zgH2JX+ojA9EhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em06IDyv; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em06IDyv"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4591f35aff3so432803fac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302073; x=1786906873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JF1xBHR+pFqGbdGbKgcgvNIrjbGmqVDmb6bS3YLzQvE=;
        b=Em06IDyvFlnJI92MynxJR743adVzaj4yxUkVacgI9w6UNDVWmjDIoujaO4gG2bmHgL
         McfGvbMBONfuOvXFUw8T4XsD/pNx2OL1KbeeJwH5h0ZRRfCYc9SLW/lwPOXwpHkxO6ra
         gcvO53hXK7LXXnCosGyi5ATfW+f8gxK2B5Nf+w0SCtSD+zyhlD2iYIMIT8pgRbExcxMY
         VwaacMtfYSbnFsUasCwV3C1Gx/BDHfKtN4eYhj2tDLq/E7RRA84LEsO/0w4t8n9mFspD
         shN+Gk+dfm1m9uTn/8CD/RRZQKTUcySaMRFaweMJIQON1ISEZZxXyTt1d/KdZOnPAd8I
         p7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302073; x=1786906873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JF1xBHR+pFqGbdGbKgcgvNIrjbGmqVDmb6bS3YLzQvE=;
        b=If4jlYQ6S0d9/YYn3kZuRsCxze+Kzb17vrbegQLZYRwneTqWTCvcUQCdg25dKO2bwk
         BfFxXoR1uvet8CuQ1iDgGCN9OquVB9uaWhEWZ+ytyeOXudIyKM5FaROXHzUD0NOT0X98
         06VsTNhSS+yZArb+0y1x688tlI6ZFZC5PfgiK7JJfpJAGTKNj8EO6CXK4Kkw7tbyoKbE
         oWAc/joTKTouhgIB3pF7NHHtkLMffKWUJZsZUIPL9MJPcZOm4P41xLZMihHZPDEjGMFW
         vy7QR8GgUot065ZV/rLYh3yR3Ie/mkadjTskb5nVFry16w0TTFr0lxi4AMZMrld4qgAf
         EZIw==
X-Gm-Message-State: AOJu0Yzg7dWoFTFQeIe+Xe872arcOqPPTJu0+OeawvBwIiEdqhTA50UU
	82IM6XXb7A0rUdnS573elsvApmKwJ8ClNFgiGdpuFUlG1hP5NihIjSjj6r6DBg==
X-Gm-Gg: AR+sD11/DEkl1j+jjOR/hGMjrfZJ083SyBviw9igdq/QGvDsafyDtDV6X6ReF5HRxGv
	ZLFbATWtf0QPon3OgD0CTxZEvA08zy/iuCRf/tGY01JIKr+6Y5cvBkDgXitGTcFLU7h7F8EtvLe
	eHd5czb/NzZoKoGcrWYBwkNA/t9PCdVlJ3idQNTvHhvH6LlsdqmawZRlaGue38KxMwRU+ySJ0ud
	4oIPEdvW9vKqUsR6jqOSP0U2CSccQRGYmRX8WfS0azzrPf90zGeukyiKpyw3XD74O3c/ln1J0Dd
	sufAa6ERQDCjNBzeXFArs0xvQid2+kLTt7Uir/e2Hkna+RhCW6G3CMMZmWYbBxq+HsgqcXl/aBQ
	U/hsPqzj7H+18/Yw8kdZ6rUqh+a54xf398AxO/VjSiBYC6YmcMaYK7+VJNfqv137CRV6f/nNf3+
	oxW4qOjHN2NTRpXFhKCO/imCN49673R6l/N/srDAVQZkN9Zid9teC6SpOnIRHxwdScXSTLvT+6S
	Pne1lM=
X-Received: by 2002:a05:6808:144e:b0:497:d252:d609 with SMTP id 5614622812f47-4afadecc57cmr20155002b6e.4.1786302073350;
        Sun, 09 Aug 2026 12:01:13 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:13 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/7] builtin/receive-pack: read unpack limit config lazily
Date: Sun,  9 Aug 2026 14:01:02 -0500
Message-ID: <20260809190106.1565882-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), the `receive.unpackLimit` and
`transfer.unpackLimit` configuration decides whether an incoming
packfile should be exploded into loose objects or kept as a packfile
on-disk. In a subsequent commit, the logic to write the incoming
packfile is made ODB backend agnostic and moved behind a pluggable ODB
transaction interface. Consequently, whether to explode a packfile is a
detail of how a particular backend stores objects and should not be a
part of the generic interface itself.

In preparation for this, instead resolve the unpack limit lazily inside
`unpack()` by reading the configuration directly. The now-unused unpack
limit globals are dropped accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 78d2911c00..5264d70467 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -62,12 +62,9 @@ static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
-static int receive_unpack_limit = -1;
-static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
 static int advertise_sid;
-static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
 static int report_status_v2;
@@ -157,16 +154,6 @@ static int receive_pack_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (strcmp(var, "receive.unpacklimit") == 0) {
-		receive_unpack_limit = git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
-	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
 		char *path;
 
@@ -2333,6 +2320,30 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
+static int get_unpack_limit(struct repository *repo)
+{
+	static int limit = -1;
+
+	if (limit < 0) {
+		int receive_limit = -1;
+		int transfer_limit = -1;
+
+		repo_config_get_int(repo, "receive.unpacklimit",
+				    &receive_limit);
+		repo_config_get_int(repo, "transfer.unpacklimit",
+				    &transfer_limit);
+
+		if (receive_limit >= 0)
+			limit = receive_limit;
+		else if (transfer_limit >= 0)
+			limit = transfer_limit;
+		else
+			limit = 100;
+	}
+
+	return limit;
+}
+
 static const char *unpack(struct odb_transaction *transaction,
 			  const char *shallow_file, int err_fd)
 {
@@ -2360,7 +2371,7 @@ static const char *unpack(struct odb_transaction *transaction,
 
 	odb_transaction_env(transaction, &child.env);
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
 		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
 		if (quiet)
@@ -2652,11 +2663,6 @@ int cmd_receive_pack(int argc,
 	if (cert_nonce_seed)
 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
-	if (0 <= receive_unpack_limit)
-		unpack_limit = receive_unpack_limit;
-	else if (0 <= transfer_unpack_limit)
-		unpack_limit = transfer_unpack_limit;
-
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		/*
-- 
2.55.0.424.g13c7afec21

