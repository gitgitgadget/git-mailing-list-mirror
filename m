Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FE32ABF3
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538708; cv=none; b=CRq8FsQfG9R+KQQY74Pzk1iyXkNb3lrM1SRyiM191O7tmUvOY0aQQc6HZ+A6rE2I/KoyvxZMgG0mIsIJZPC9YEak9OBkowK0mBD2ZXjN88+f9rTAW+aPCDXtSfiidrl58ibyRQzNY5qXhOdKMxV5EN0xV82fIWAzleU6JATQiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538708; c=relaxed/simple;
	bh=5Tu8jbbeanEwB1gPIZ580mA4sBByNPSm66S07pDy7ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sb+iZkoiPE1uywyf56WBTgpD+voTctn+cvjoVrL/9fq7NCkzeoSp6C17VI1t5KG286xpEgffSW8h2nQEuOT1BChpZ9tVkTw6QvdOX03GGSvoQ6LNtAoXxHwT6brmh9J3IFTqivQcwymceyigULEzJy2vFpSCXncSi+UHgoWS80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nm12NwFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2ts2lMQR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nm12NwFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2ts2lMQR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A377914001DF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538705;
	 x=1763625105; bh=zWzVeq/v0+FbGwbD0t43Z2/Mh52tNZZiEzaEdSwT1xg=; b=
	nm12NwFNtMnYXbJuP9vCkOR3DbVZjFQeQZ5YJNCPakRhCG8THtHVW1U+UV7w70Uu
	x+KqEKRihkuYJnLWV5K2DD6pDvcJ776YOSjKNpX7wVFb7icLZvBj+BiDPujqWnaR
	7PQtx8v66V31zmtiQLgXbKgF+ZzFDczcKFj/tXFbVkU/6kGFS9uoYC92gKG4xScs
	r4Le43jcUXP706BOIHv5NlXSR2CPHmwOyDW7lB599ipriU9+CcqOPW4YC8n6fOQq
	+dZjBI+3j5UikoXdM0LCsoRbkyO1SeswwKwwW63Tn/63E5vLvbfA7jptQhFYOQNf
	p8u4E5k3nVeIzbDuSkQFOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538705; x=
	1763625105; bh=zWzVeq/v0+FbGwbD0t43Z2/Mh52tNZZiEzaEdSwT1xg=; b=2
	ts2lMQRR4z8U3t7UUO+11t5qylEwFBt++KdF3bQsOXu23Et0btsoGELDHafdxB7q
	tjNKxa3mT+Tmf2QIr5Md826Uz6+Uf0SpkddgOxQhMWouTvrf61Qy1TAMisWO6QJb
	yY/nP9wnsiBq0NNTjwf/v5ZX8X/RZu5mCKuGErT/z8WgVG9gYgf0DbH4aYq8ewOf
	/ymQVQ5EkNrZVnIl9vN6+kGT9Uny4gFl80JSi4EMc8SBlmrBUJ4CjpEgDxxz6NOf
	ARy/ofLv6g+kVnXIXtmAc1Z/i95N0bkbsaJao/dPa3C9pc0sfjHDUVXGv/7z1yxq
	8tfOq3oavlVIM+yn/Y9Wg==
X-ME-Sender: <xms:EXcdabdJ5Zv_lkbFc-odQrsIn0hSgPIKCF8o2kqVf9dssoNJYvVZ-Q>
    <xme:EXcdaYLhLq67BPcyDGla3T3BQwHS0LuYMBKThExvaSijYb0btcRFFM0SGg40OQrOU
    dLWQLR-c3SmfQqG8b7v7kU4JjaFEx59PCrjKYmQjRaim2mDwyvTkg>
X-ME-Received: <xmr:EXcdaaI7i2T8-DXYlGHxUEGMP9TR0ZS0OdRb_Am0jgVLPoU0VxHFRvHGjL3k0DRfuAdnKXgeQnjLlniKLHu9VACZw01-B6QX2rE9UfC1MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:EXcdaSFxqcReOzKJEVF1yREwCu4lV6Vz_Y2cr8JyPUIh-R_d63iicQ>
    <xmx:EXcdaXnGWYEAdUT21Novb0pg0L3sFKfBkdzuHHDmxky602BhLeHfeA>
    <xmx:EXcdaXIkwWJThlQwZZxEvKrUOcZ5nh-wkHHgOuNI2PlXI3fng4Gqpg>
    <xmx:EXcdaQb6ERe6gHhawAzfpJPk8XxEVtaf4tBa5oYaTEDCPKUuxjisGQ>
    <xmx:EXcdadNK0EbVST_qMYkrtLtlrHSm02ylQOjQDHjOgX_qjK6MmjcdekD_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2205e68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:51:01 +0100
Subject: [PATCH 13/13] odb: handle recreation of quarantine directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-13-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the preceding commit we have moved the logic that reparents object
database sources on chdir(3p) from "setup.c" into "odb.c". Let's also do
the same for any temporary quarantine directories so that the complete
reparenting logic is self-contained in "odb.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c   | 7 +++++++
 setup.c | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index 70665fb7f4..dc8f292f3d 100644
--- a/odb.c
+++ b/odb.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
+#include "tmp-objdir.h"
 #include "trace2.h"
 #include "write-or-die.h"
 
@@ -1041,8 +1042,11 @@ static void odb_update_commondir(const char *name UNUSED,
 				 void *cb_data)
 {
 	struct object_database *odb = cb_data;
+	struct tmp_objdir *tmp_objdir;
 	struct odb_source *source;
 
+	tmp_objdir = tmp_objdir_unapply_primary_odb();
+
 	/*
 	 * In theory, we only have to do this for the primary object source, as
 	 * alternates' paths are always resolved to an absolute path.
@@ -1059,6 +1063,9 @@ static void odb_update_commondir(const char *name UNUSED,
 		free(source->path);
 		source->path = path;
 	}
+
+	if (tmp_objdir)
+		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
 }
 
 struct object_database *odb_new(struct repository *repo,
diff --git a/setup.c b/setup.c
index a625f9fbc8..ae66188af3 100644
--- a/setup.c
+++ b/setup.c
@@ -22,7 +22,6 @@
 #include "chdir-notify.h"
 #include "path.h"
 #include "quote.h"
-#include "tmp-objdir.h"
 #include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
@@ -1056,14 +1055,10 @@ static void update_relative_gitdir(const char *name UNUSED,
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd,
 					    repo_get_git_dir(the_repository));
-	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
-
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
 	set_git_dir_1(path, true);
-	if (tmp_objdir)
-		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
 	free(path);
 }
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

