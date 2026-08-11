Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2095371041
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470870; cv=none; b=TFsUyf63G3wnt/JuJkWlG4YOZFKf/7v41/OKvTnDuY2E6iQwk8hcmjPjg5qQFA1COo5rrN3P78awjpK4bHwHIWcF9vW0vuDQh/g9sfSg8gcw0uBDnHy0iBKUDFZ76WmM91LouRsXlqj0L3vvOznbV6/Xl6iI2xwVmIKMtn663dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470870; c=relaxed/simple;
	bh=PYItGzANjsYtk+6gIMikaF4Akhpe7NI/4EscT4//8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLFIixHo0h3SxZTvCfmKB3lsQU7QSg0wX30f0EmIsnRoy25whpHh9Bp1LZpVAukdQ3OEauhNKgD3rOi+VPgOMMGtvJzW2yQMQsNMZhPcKErOm4KkNPkxvqz9iHLLRAQM6Z7tnVR98S5ksi9HAJ2GX6BjpHRolr3CRIzHpAnMfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcoqzITx; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcoqzITx"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-495b27007d0so94192b6e.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470867; x=1787075667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=AcoqzITxjCzNhUPSLrHZKwmwyMfWaReyGt00lNB2GEdMYreOAGOFgVeTyaD2/E63VB
         5tSa6vRT9W49ebpg98rnIUOqWjDdK2KnwMOyNHBIpplWyDIguveN1WvrOoG91SYBxzGb
         zfSyhUrOuLz9VxHq5wCEcvqpRhe5laogRct8wDa0xekswSx/Mpxddc+5MFo+CanUQoWA
         BQPTUYxeboCNzHJU30XctJbnRaz6sOTQLUZ8UZhcX5m7KT1Dw3AECDvAbolQhv0mbo+V
         0xDOqbNCNJSJqhpzlVvdg0bUVxeq9kV4V3CZFknKy1rQvt/UY6w4FdvIFkvzLvg/YhIQ
         Kw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470867; x=1787075667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=COmXqe7kb/6w3W9UiiZp1nKxL2tfLId5N3PqPUSRFKNry/XXrvTZSBBj3WfZ+twFb6
         SrRvngM87vV1hdoUw3/CznKTEbZNa9ZJ6baV3QgwV4P1CI1wbWPQKORP/T3vNTjzkLHk
         ojPVzHeLEnZr5kScOpTUf7+YvvbIPNQy61XU3r0K078q4R1OWRZLKKZuKFxGBsi2JpQF
         6H2axQ0t50uvqFDGzOR5p8hnBJymChQEhmNquwCWf82efxpirIDCo3OstrDWlTkQ7q73
         X5iE3uiH05pXdStIDMiZgMKjBWhn+AaY1JKj1g4UPbT6waFrjO0zrZAp1J05i21EMLhx
         eMJA==
X-Gm-Message-State: AOJu0Yy6O9dZBm00jbHABqWTN9vw0PI60uRjm+ol9IpUcQzGkNWn6t2N
	3TdJoF4AhQIQ7sl6FO+gGLIk8XIo4JeMqQN88NdhSg1mBVMpavNyz5Qv19ylrQ==
X-Gm-Gg: AR+sD13XnkFj/Ob55XXqCBBmI0Hv2dZnbcttyJAJZMjsRdgXOepWmWksC8aEOBu4Soh
	HZdi3FJPyee57OxPWkq3jGdplnuoTfGn6f/hDcQSIm+6A28TaWZl1sYLnPAkVHuoK6DdhczdH51
	yDy5/T8u04cP3/cbdtvuOcYSMrtxnaybvn3Lc9lzbfLn7MGAu6w2O2t/nKRM0Jt3I65H7z/Zkb/
	Vrx+podE6PfjxijyZoANrZ2FEiwaDKe7Y0PCgerPLRzzE6qFhqvJu7QeJ3EdNRvDG+DhKMmpmwP
	bffbYh+Zx9L1tQD6lGj8bmfjFLoN9y2zulYd23ISyneM4fALWq4pBkA9Sb7DHcxj97VCosg2FKp
	CQbGuAbdrg1mT4WweIMg65lVnMmfGJcbfhARJmhSooDnM06yZyL06fZyRvUsfXVz0A+BYi31VdF
	N+PHE4AXDvp2h3ZBRFYowGJd9atDxPLTTbl7/xRKDlGC/pYqhqMmd5ARWIHxJ1l8Pe6YY5
X-Received: by 2002:a05:6808:c2d3:b0:497:df42:1e05 with SMTP id 5614622812f47-4b1fd77f304mr3494386b6e.8.1786470867504;
        Tue, 11 Aug 2026 10:54:27 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:26 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/9] builtin/receive-pack: read unpack limit config lazily
Date: Tue, 11 Aug 2026 12:54:10 -0500
Message-ID: <20260811175415.2044235-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
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
 builtin/receive-pack.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 135105deae..971dc3f52e 100644
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
 
@@ -2333,6 +2320,16 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
+static unsigned int get_unpack_limit(struct repository *repo)
+{
+	unsigned int limit = 100;
+
+	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
+	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
+
+	return limit;
+}
+
 static const char *unpack(struct odb_transaction *transaction,
 			  const char *shallow_file, int err_fd)
 {
@@ -2360,7 +2357,7 @@ static const char *unpack(struct odb_transaction *transaction,
 
 	odb_transaction_env(transaction, &child.env);
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
 		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
 		if (quiet)
@@ -2658,11 +2655,6 @@ int cmd_receive_pack(int argc,
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

