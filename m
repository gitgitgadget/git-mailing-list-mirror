Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40C1CDFDE
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417861; cv=none; b=LuHm1rJWya45L6O6b+E5t9bnenYMuDCw2yaaH6uu5msLkXgDvcCLYEeowRbstXpvF36SHlwJDfSFlyyLwJsR+v2UVPjfHTBWmaVufNWoMuukqELzEEve9sbXMrr5ikw0u0wv38EVThKcQ6XybojkiQiQHoWCg0bZ+Gfo8ljkHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417861; c=relaxed/simple;
	bh=XKFMIIwGdf4XfrgkZVkKHXYPKjBUmejqOQOHFVhxspA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOyfLzBRnBmTvYFI9pFDN1E4i+kQNFd0vijHziS62RTxzoOs5scXxAXIdJ29lDKeviJLk06bVJrizupcf96kHa995OGo6IxCge0DURiJni32aKI8nc1FeFIjXrkqpzJk1PBRlwR/wgL0eR4TpGKIgtu8tXeWrRXydRF9CjtAh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gmmo+EDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1TJpWNou; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gmmo+EDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1TJpWNou"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FB3C1140225
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 17 Dec 2024 01:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417858;
	 x=1734504258; bh=nrXHItR8pkv5Cvt1+lij1K08YzghxL16A29KK+nUm9k=; b=
	Gmmo+EDuLhMS59Z09oJGDIn2CjrbQy3IRrSRrb0qFuurKXtZlZoK/98+4gVpsojR
	YqnRkfrhApTYSLrC5GqRIKhtnPdSYKgr7xZ+Px9YatLEIVg0o58CDRfby6id4gx9
	1htVtihjAyvdUw3p3fM/NxWmUFB+S9214gydkVigLozpUJAIpEuv3+QBbDTgmzLi
	JvBf2BMXvyG0MYkKC8dxETfWCDeqcHYhQWTFQwhuF78cqw/WZ2LWphG+7eZMyo1f
	ndlagxeyoIPleUwFfnEvga0QLs+JlaxWV8p8reSwAFhg3G0tqYlAHZK1T7TkEsfX
	OEJmEjiuUeeSFmZSfi15dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417858; x=
	1734504258; bh=nrXHItR8pkv5Cvt1+lij1K08YzghxL16A29KK+nUm9k=; b=1
	TJpWNout20iIvE6dXGwGBAgqVl+yK4zfF/nhGbeFvB61IdSWdE4VAtdQX+9hTbiD
	UFrud1djsDjyPai8jt83kfIcMwtXRVhYcvmNuOPGGx/fZsQZrCzGvXyLM/Q8XgX3
	SxBH5fEz0ufKqiemIxqjR5eMCVbFwC+sYBVf75Z0lCY9NYyvtKYj9Jv96s5pAWQI
	vjMOtA7XhFA3IepQRizY6bWj3ZmDVeTlKRw8QYvyKX7aV5Qm0bQQsfXUE8S/WVZF
	kIVENIj1vwOSFisJyL5Vdu5J+noWXWvVlnMqGsI1lPzyVcQVouDA8gBFP7QPOwjH
	vO9LvIOq0UfmxjrQ7q+OA==
X-ME-Sender: <xms:wh1hZ0WSiNfbutzwsDZ-rAcE6MNR5XoqSTX9luJjmQ-6_KyuQJ3w0A>
    <xme:wh1hZ4lhIm5j5xX-woJK2omEwQ0msdxxzvoKxEwXW2hNend72ihIlOaZJSw6hNc2G
    C10BQML9p2nePPtfQ>
X-ME-Received: <xmr:wh1hZ4b18HeYopKjQal8DqdaJYKT6XFEwALLdAWahnXiGJGLEt0fjHORd79xTX7DFNvuDGq2FOuLiEOwWpFq7UOn-amEJwlW-Mk1AQ5_9PYbHYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wh1hZzVaml6OrefmVrtfv5R57BYby3tGgCEZujcb3FK5t5MhJISxVg>
    <xmx:wh1hZ-nK40-iOR04N7FKlTbo13lsodYbu5GxfXa3x0orpoxP5YmZxw>
    <xmx:wh1hZ4dX_UmeUMeln4mb_LRonRqrIP8rKyAtMLJbghl0oK86Lywlkw>
    <xmx:wh1hZwEgk1IJ83MCdZlTW4_pYKx2JNTVDGcMsvx4wPujIdGYlqfk2g>
    <xmx:wh1hZyuX7B-mGVLh22876Sj_yrRhP2NuJDH6i2P-LbrKnmeVokWdkHv_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d63e0433 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:51 +0100
Subject: [PATCH 04/14] serve: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-4-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "serve" subsystem by passing in a
repository when advertising capabilities or serving requests.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/upload-pack.c    |  6 ++++--
 serve.c                  | 36 +++++++++++++++++-------------------
 serve.h                  |  6 ++++--
 t/helper/test-serve-v2.c |  7 +++++--
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index dd63d6eadfe0028b3a62d7d14f777c919f567cc8..c2bbc035ab0c91baf5d66cee8bb370ecf1640505 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
@@ -63,9 +65,9 @@ int cmd_upload_pack(int argc,
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		if (advertise_refs)
-			protocol_v2_advertise_capabilities();
+			protocol_v2_advertise_capabilities(the_repository);
 		else
-			protocol_v2_serve_loop(stateless_rpc);
+			protocol_v2_serve_loop(the_repository, stateless_rpc);
 		break;
 	case protocol_v1:
 		/*
diff --git a/serve.c b/serve.c
index c8694e375159ca0044cb045500954770e1e5cb93..f6dfe34a2bee6b24bedace2c272f8377dec9fb91 100644
--- a/serve.c
+++ b/serve.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
@@ -159,7 +157,7 @@ static struct protocol_capability capabilities[] = {
 	},
 };
 
-void protocol_v2_advertise_capabilities(void)
+void protocol_v2_advertise_capabilities(struct repository *r)
 {
 	struct strbuf capability = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
@@ -170,7 +168,7 @@ void protocol_v2_advertise_capabilities(void)
 	for (size_t i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
-		if (c->advertise(the_repository, &value)) {
+		if (c->advertise(r, &value)) {
 			strbuf_addstr(&capability, c->name);
 
 			if (value.len) {
@@ -214,20 +212,20 @@ static struct protocol_capability *get_capability(const char *key, const char **
 	return NULL;
 }
 
-static int receive_client_capability(const char *key)
+static int receive_client_capability(struct repository *r, const char *key)
 {
 	const char *value;
 	const struct protocol_capability *c = get_capability(key, &value);
 
-	if (!c || c->command || !c->advertise(the_repository, NULL))
+	if (!c || c->command || !c->advertise(r, NULL))
 		return 0;
 
 	if (c->receive)
-		c->receive(the_repository, value);
+		c->receive(r, value);
 	return 1;
 }
 
-static int parse_command(const char *key, struct protocol_capability **command)
+static int parse_command(struct repository *r, const char *key, struct protocol_capability **command)
 {
 	const char *out;
 
@@ -238,7 +236,7 @@ static int parse_command(const char *key, struct protocol_capability **command)
 		if (*command)
 			die("command '%s' requested after already requesting command '%s'",
 			    out, (*command)->name);
-		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command || value)
+		if (!cmd || !cmd->advertise(r, NULL) || !cmd->command || value)
 			die("invalid command '%s'", out);
 
 		*command = cmd;
@@ -253,7 +251,7 @@ enum request_state {
 	PROCESS_REQUEST_DONE,
 };
 
-static int process_request(void)
+static int process_request(struct repository *r)
 {
 	enum request_state state = PROCESS_REQUEST_KEYS;
 	struct packet_reader reader;
@@ -278,8 +276,8 @@ static int process_request(void)
 		case PACKET_READ_EOF:
 			BUG("Should have already died when seeing EOF");
 		case PACKET_READ_NORMAL:
-			if (parse_command(reader.line, &command) ||
-			    receive_client_capability(reader.line))
+			if (parse_command(r, reader.line, &command) ||
+			    receive_client_capability(r, reader.line))
 				seen_capability_or_command = 1;
 			else
 				die("unknown capability '%s'", reader.line);
@@ -319,30 +317,30 @@ static int process_request(void)
 	if (!command)
 		die("no command requested");
 
-	if (client_hash_algo != hash_algo_by_ptr(the_repository->hash_algo))
+	if (client_hash_algo != hash_algo_by_ptr(r->hash_algo))
 		die("mismatched object format: server %s; client %s",
-		    the_repository->hash_algo->name,
+		    r->hash_algo->name,
 		    hash_algos[client_hash_algo].name);
 
-	command->command(the_repository, &reader);
+	command->command(r, &reader);
 
 	return 0;
 }
 
-void protocol_v2_serve_loop(int stateless_rpc)
+void protocol_v2_serve_loop(struct repository *r, int stateless_rpc)
 {
 	if (!stateless_rpc)
-		protocol_v2_advertise_capabilities();
+		protocol_v2_advertise_capabilities(r);
 
 	/*
 	 * If stateless-rpc was requested then exit after
 	 * a single request/response exchange
 	 */
 	if (stateless_rpc) {
-		process_request();
+		process_request(r);
 	} else {
 		for (;;)
-			if (process_request())
+			if (process_request(r))
 				break;
 	}
 }
diff --git a/serve.h b/serve.h
index f946cf904a242db5106625e280d7daa671348516..85bf73cfe53cb9cbb4b042c43a1f6a55338ad6ed 100644
--- a/serve.h
+++ b/serve.h
@@ -1,7 +1,9 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-void protocol_v2_advertise_capabilities(void);
-void protocol_v2_serve_loop(int stateless_rpc);
+struct repository;
+
+void protocol_v2_advertise_capabilities(struct repository *r);
+void protocol_v2_serve_loop(struct repository *r, int stateless_rpc);
 
 #endif /* SERVE_H */
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 054cbcf5d83946b225774dc9da6b0ec1d112e79d..63a200b8d46f68bfd69f63f844977cc8e382bb32 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -1,6 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "serve.h"
 #include "setup.h"
 
@@ -28,9 +31,9 @@ int cmd__serve_v2(int argc, const char **argv)
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (advertise_capabilities)
-		protocol_v2_advertise_capabilities();
+		protocol_v2_advertise_capabilities(the_repository);
 	else
-		protocol_v2_serve_loop(stateless_rpc);
+		protocol_v2_serve_loop(the_repository, stateless_rpc);
 
 	return 0;
 }

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

