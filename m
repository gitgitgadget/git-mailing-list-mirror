Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7523D7FF
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302075; cv=none; b=neN0efGJ63NbJDb3Sg8KLQYx62i7Zs9/RYc7l/nUAP1P5y8yKqBXugE9XxlUrB8+CRrVED/hIm4BuTmKz+w/UiiA2Y3jQeoc2vsaZCKaCercmjVc9sTlP7Ki1/yhvoY/z/kwF5DMOyAy4UnJCY+ksODhcVdVoLSRSOfyaiKUoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302075; c=relaxed/simple;
	bh=0CwjAQGjanquUTS4iD16uDzJ+55QqBwIRUha1fdGuns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdN9yTY+V3azoVicACr5LGZ/++Gkuv9CIb7Z/2G2YxNF2pN99kxXtUBzLw4bKXkZdsrmOxS/VvpQoqDBNvVHlOYTt7xlJhI9sXOrcF61xEDBbD04LubKlhK77tfdZa0xOLDZu5lCSPNat5oRwZPhqh2JQpMcYT/At3vhcHTIH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7hpE47/; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7hpE47/"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a46a53abc9so713496b6e.3
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302072; x=1786906872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+r2wYdl5bDXiF1nNp13TYLf/6VlIdTz3Ah7Z5Yv/+c=;
        b=A7hpE47/Vx6mMIvHp3b0eTUAmGqetgQIsbLR1NY09kZCDvgAVkVw6z/hvjUh/IwGkI
         TtPEi05YvXJDYzQvMsDcFM/Cu5ZOzY4jSZTIv+aujypMu+bAsEWP00Wl/0ldqvC31v2l
         wvzmLOtpCEU+1gSSGg+CwrBWPC/v2jzKvBHKSDeLobsx0HB8/e6jgilQSnoS66eLQG3m
         jYEZ33ef8IArROuYGMc6Fbuudb+hKfv7BIH5UpdNWYkeJt/q9DNhD7vfI48iUSASNb/I
         xZGd/BXnC1O8pUX0FZj/dAariP+naM7eVynFzS7oW+loFiOZ/zPfAWfgiCVACghTPVaU
         GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302072; x=1786906872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B+r2wYdl5bDXiF1nNp13TYLf/6VlIdTz3Ah7Z5Yv/+c=;
        b=fsL4PbKAmv1rC1EnAkoiYXZD8i4uFOMXexXnECBAL1oYS1H31BMuKuIPDjsk/zkjlu
         9dcOQEH8BhDIXakF4zVVAMr6gLpABLQCZ+Id6jJqQWUirIOnYCscIW5wb44uQV10cc1b
         h727BMcYS0TV7AaIhpcmDw3Hv+KIOX2lsqM8bL9BQKnhh8/I0Z/774TpTGCx0cbWALKT
         fvbrId9lZ74i6ImXEQAkPcAnoaRAmO9QYTfADDGJBfmEKB4uoseob6mT5c5Ml5XJtDWJ
         Sf5f9+Il4TCE/tGV6O7BQb+uarSWrhWRvVL+iQC8UYTjI7/sA/1LFD4+EZrOTvhbKukA
         KGGA==
X-Gm-Message-State: AOJu0YxxTZKcTc+i2focl8s2a/n/BcE6ZqTf/zb+f2jruqe83S/Wyie2
	FslqcY0I5WbWxNHRir7g2tNdVHpZ4Y/mN0rABtPxtRNNCS19iMb2ZI9f85dHqw==
X-Gm-Gg: AR+sD12OguxZlGvcVbyjxqMjHboJn60OiZqiiAXgfOH8aB0wRfIzY+Js6TxWROD+x3b
	CH2GQD1OI+1HLKHbw2WTypBGXshSwtZbvlClY7yBqqOcr145Ggyu6sG2A863mWIr4fxSh7Fc4GG
	ZvEkh9Tw8pNZddqX9MoADQoVLcvkkmELtNPVXy7eObgmMg4WsZkRgNhZRybCsFFz9MJJnUraXSs
	56I+kDXzoh1xhSz23ZR3a52Si4t8VrZbzgJInrckQaxe1P4mseqe0il/qaOwrElCy+4z0EGpwF3
	QMZnbPxA0UpflSvdT83Mqqc3yW11JhKmL0RQpGIgv9hUWAgHzXEH3MM0JcyTjEqIs01IZBLeZoI
	QwYW3izD7H2q1Jh7jmIBs9oQ0MSw0Z7oWvolrMFPhvMoL5+tBXOVXbt4+9HORlU6bYHy1fysYd1
	wjCaCIhlVoifbK3naIA296C9RB1NFv9YXlC/VySAc8TnTGdk5seJW7u3hnM/RbC7kSnWeL
X-Received: by 2002:a05:6808:2507:b0:495:eb85:fc2b with SMTP id 5614622812f47-4b133476122mr13152264b6e.10.1786302072663;
        Sun, 09 Aug 2026 12:01:12 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:12 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/7] builtin/receive-pack: pass shallow file explicitly
Date: Sun,  9 Aug 2026 14:01:01 -0500
Message-ID: <20260809190106.1565882-3-jltobler@gmail.com>
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

If shallow information is provided during `unpack()`, a temporary
shallow file is created and stored in global state. In a subsequent
commit, the `unpack()` logic is moved behind a generic ODB transaction
interface to handle writing packfiles and thus can no longer rely on
such global state. Lift the setup of the temporary shallow file out of
`unpack()` and wire it through to its call sites explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8720281250..78d2911c00 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -86,7 +86,6 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
-static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
@@ -2334,8 +2333,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si,
-			  struct odb_transaction *transaction)
+static const char *unpack(struct odb_transaction *transaction,
+			  const char *shallow_file, int err_fd)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2354,10 +2353,9 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		return hdr_err;
 	}
 
-	if (si->nr_ours || si->nr_theirs) {
-		alt_shallow_file = setup_temporary_shallow(si->shallow);
+	if (shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, alt_shallow_file);
+		strvec_push(&child.args, shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2427,14 +2425,14 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si,
-					struct odb_transaction *transaction)
+static const char *unpack_with_sideband(struct odb_transaction *transaction,
+					const char *shallow_file)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si, transaction);
+		return unpack(transaction, shallow_file, 0);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2443,13 +2441,14 @@ static const char *unpack_with_sideband(struct shallow_info *si,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si, transaction);
+	ret = unpack(transaction, shallow_file, muxer.in);
 
 	finish_async(&muxer);
 	return ret;
 }
 
-static void prepare_shallow_update(struct shallow_info *si)
+static void prepare_shallow_update(struct shallow_info *si,
+				   const char *shallow_file)
 {
 	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
@@ -2489,12 +2488,13 @@ static void prepare_shallow_update(struct shallow_info *si)
 	 * command. check_connected() will be done with
 	 * true .git/shallow though.
 	 */
-	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
+	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, shallow_file, 1);
 }
 
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
-				struct oid_array *ref)
+				struct oid_array *ref,
+				const char *shallow_file)
 {
 	struct command *cmd;
 	int *ref_status;
@@ -2513,7 +2513,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(si);
+		prepare_shallow_update(si, shallow_file);
 		return;
 	}
 
@@ -2705,11 +2705,17 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
+			const char *alt_shallow_file = NULL;
+
+			if (si.nr_ours || si.nr_theirs)
+				alt_shallow_file = setup_temporary_shallow(si.shallow);
+
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
 				unpack_status = "unable to start object transaction";
 			else
-				unpack_status = unpack_with_sideband(&si, transaction);
-			update_shallow_info(commands, &si, &ref);
+				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+
+			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
-- 
2.55.0.424.g13c7afec21

