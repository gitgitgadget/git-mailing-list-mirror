Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B063B42E7
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269791; cv=none; b=bG4pnrwO11EmYuKjwgTBQFDHPbczDnTjW/DoiQ35S0Hw942nM1M0Q99UYkwGZjFcWltTyKuiuzhQL6xMis7QSwrRH03WSZyVusCruXkXMFApWyvs8cRh2PWL+pXnTO8r3x4us3pZ/X94S7LQwANzqCPq8k2qYuEHf8Af9oICJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269791; c=relaxed/simple;
	bh=PYItGzANjsYtk+6gIMikaF4Akhpe7NI/4EscT4//8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5PuZfZ8bJnKglXG48q4fuN4lEAoHbW/hlYZbF8NsWahEks8AYuVfAfP5rUQUh3WYXrzhrXetGMTSCSQckXD/DA9Q4zCwtpzy2mPTiVRwlixPc7yFP7dsQDCwdx4kM3VfA3vczzUanroyYfwdWPqwpuRfoDyWorJhKG7FO38Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUbpQPma; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUbpQPma"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448b0ff4a57so378503fac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269789; x=1787874589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=HUbpQPmaq5CkreS6m/VL+rvpfUJ5agqmD4DafKU/lHlpbwtJMZ60iHh/j7OP8TmO7o
         KTT97EAZAFiDsxtorH69K/3nYO0+j453d60WwI+i6VEt5n7KxiCaOXlLcTjuDkZh2Oxg
         5sMQ+SXqQDfEMUv+ijHnNi1IL8GdQ89P70pOxxhZ+6INgohMKaZpY7a/CNo1smFG5fd2
         p7nLKS0R9ZlZ+nxtqVwZ+prXhWwgivP7stCFyuTCYFvL8qmlxU4ELOPd36xcblhFwM88
         USVCVeSYLg4w3gsu2kwgLoh2TmH581KzUwU4gDLLdnqXT5h7Frirg8bmAHevkyovfJOZ
         bglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269789; x=1787874589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=mdtJzoZUXJb94lBbLXb40SPXqujLMVNMOAZir/IonwBSkW+ViI1qiJSaVCJS26Vkot
         asEh++IbXPuvH86OIQMIIJsgNhdYa+CtM209dDaLVoNDjcwHtjVLxOztoecROqIc1b6c
         myEGOPpkwpbwfrDvppHYC0JIDZdco/WRlfFjTNmlkTZ/yqsSuzDDEXklpVAArpQ0Ugvt
         +uYZIfxn1BoVch6IRsgFXYI/I716Emi25lUvnGJ1UFCmLAveMjVXK6JbmQXcYoi7LRNh
         n76MfDOnKdhPaE3s/cyfrl0rPKTqiqSE2B/KNm+wLUCqfaRBTliNe/xWyY7VQN/PWL+f
         aMUw==
X-Gm-Message-State: AFuF++nWFZN8rH2YY5EqqQhKPPkex4r2bxOkfsY9TW032IdTrv/JiNwJ
	qnTsp1VHKYMVQPLeKSOANq6nnn3vBkLNkmQ3IGqEVWLZyXWAu4qAj0kApykwvw==
X-Gm-Gg: AR+sD109od1vfL806oGpaxrSocTYx7Bus85aGTyZ3+mhhUITsVUIgEF3+XNvOo65BMv
	ogz4PRqmhP7DF1aR68VCGG14K9esBvOHNiP8cQEu0AtHg0GLBFbf/7BNTSMV8GGbg67SPx+4Bqt
	ieUf/iTVkIkIXzU0AVdjkB8oT6382vAWhGXlff+/oeYUlAovnxkTcmCQ3Hq9Ur+FkOeEQfOIUxN
	t72LsM0yjeX1U+XKh0yYdpmSmEjSRcwAIfzfcjLk7Rf44/dJDUgVU7+8FV6aUmqFJ04aACLb/FV
	xC1ZmmMFnOzvWvuoeB4dGyRjTRZo11pMZzYgsEHaYgRr4MMeU1GF3vTd8vtzHOBd/gpS9892TiP
	XWh7XXnJvb6njmC270jUKU5bxdFMqpm0ZwnH47jnX8zFo8ILEufxcsjDmojTageXuqdQUHoRo2J
	si/ERo6bZE4uKEN6/YbQgNbe5RhGmxtzYiMtfJ0VKmDErMo6INwsuYoHwukrgHnwWBHd1k
X-Received: by 2002:a05:6870:9d8c:b0:43b:b245:30ac with SMTP id 586e51a60fabf-4635145b628mr2157499fac.16.1787269788957;
        Thu, 20 Aug 2026 16:49:48 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 4/9] builtin/receive-pack: read unpack limit config lazily
Date: Thu, 20 Aug 2026 18:49:35 -0500
Message-ID: <20260820234940.894624-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
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

