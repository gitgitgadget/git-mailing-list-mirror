Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DE1E991D
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135297; cv=none; b=Lbgapwmu+ldHifWHI3XDZcplDM4T85P0d2v3Bnys+esCX8YtgEdWyqd5PS7VVDTmsGAu00cE9/JIwONH4f/80uwKobKZnVLKoMO+SIWI6ifOEaL/8MNECQ2LWPpH0+vcxR1pLIF8TTkEHigHcykxZ6s+EKR5TNXaglEQiJcYQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135297; c=relaxed/simple;
	bh=3TZlM56R7gz7eTIRtaUd/uiDOc7TTMOxYEgNwWeGk5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+Du+sF2GhYNujt1pKqENxSBFr1wVn9zpiQ2KbymUd0kuNxCHfBjuP7d+a1lOKWtSZ/gvGOTdorsetZccIkXmT08oa+TsP1vC6xNGmF0WaA4l06qbqfk58EcVGiRnOJ+YuTVbJxH4xJoeALnberjBAtvbu/a/CEF6+LRxL4Z9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/Na0y9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDu7tVpt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/Na0y9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDu7tVpt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7585C1140278;
	Thu,  1 May 2025 17:34:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 17:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135295; x=
	1746221695; bh=0eiA+piig1eZRGS2GWu5A8vlcNO+FQzHXfkVlC0d/xY=; b=C
	/Na0y9YJnbV21VhS/gl1QPLBaVoBqMOQLyzw/0J8xOjuBfsj/dFXCMFpgkh7itQq
	zIsQigFr7CRa0V7oB9qLPQJeE7CNeJ5IiUxey4CKgFHkDvykDr5Pc7KIa2O677FZ
	ffvsn3caEGguENDtKxP4kHfQK0biRfrsayuJ4Yd58kZRFz7aWaStZ7I4+cf5EPa6
	pfj/tFEhYVAofYgxQ7hEwBWqEeckTZIrShkaXyAiDzl4NoTUUmNYz49laNKYWbg5
	q0LytnlxYd/3Xhgh7e7yqoJX8I+113eV8OLRqTZ5B7177tOkCG7Fzalc6amaNoED
	LVBBQdPfiDmZIyHfed7oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135295; x=1746221695; bh=0eiA+piig1eZRGS2GWu5A8vlcNO+
	FQzHXfkVlC0d/xY=; b=pDu7tVptuDH41eXbKkr99IxUN7FKmXtAeuB9eQ8Lr7TM
	bHGl1vcxpz40/ZSNRQEi+yXJObRp+kYGwMWa/xFiZTXgXr4mxwCSdDf4+n1Sg3XY
	kBJ5k9X9uEkQ43vU51xp/mClHtQS27DjpgFdKaciUKXNLRq6BOuNozzGtBM1IEky
	R9Q7J2j2CeVrQNRW1Ffx/+VFNclfXwI0T2yvTKoylIvZxyHchUVbcshoY6vHt0Yq
	tv1HfUHJUFU/YgDQof+30QmOUm68oVTKOM1XE65h/sMAltY6QgqHo6liwmLd/T7y
	sEV7Wk8n9GWRpZbvIl7jTF2hGEFIcFOjCwsKrVqLeA==
X-ME-Sender: <xms:_-gTaGdtRNWouB4oglh6RcvlEIKz6z-f04A5YYn40AGrwBXpyNJo2w>
    <xme:_-gTaAM7V73EoiX49AQEdK_221QgAKFLusLAKpnefxNj0VFsH6rVKTJi6ToMhWmBB
    JNDXMxu_6ZpRHxDhQ>
X-ME-Received: <xmr:_-gTaHgqTfVG7ZblGMZasftUB2YzibxNj0Uru6g0b3DEp4xYbf0wfHy8hlmQ3CpuH9_zOPfKAqpvCv1x3okrjgrYG8mxRGcqrUV1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_-gTaD9RhkG7OVbfiuxwpcFtgSy9y1389LnGoy59S7B_6_dpx3hJ6g>
    <xmx:_-gTaCv2hldYGHrVzd1aSQYaG_FPIFRmqmSReVrX4TlzDpcl_IZg-A>
    <xmx:_-gTaKEOLEDP3HXCrs4gpruYjb68rt6mXzuSG9ZcYTOWxUlJc1m-Ow>
    <xmx:_-gTaBNy8HS3sdCfMOBm8AalebOSlUx33nHcfClfDlwH_HsMTlcJQQ>
    <xmx:_-gTaHvoHD4_sRRythL4Q9PAH_BrYazcmvOZbpEXf9RRlsDa6YN5rexf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] you-still-use-that??: help deprecating commands for removal
Date: Thu,  1 May 2025 14:34:51 -0700
Message-ID: <20250501213452.370729-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213452.370729-1-gitster@pobox.com>
References: <20250501213452.370729-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command slated for removal like "git pack-redundant" gains a
command line option "--i-still-use-this", and refuses to work when
the option is not given.  The message and the instruction upon
seeing what to do are both rather long, so before letting another
command to use the same mechanism, factor out the message+die part
into a small helper function, and use that.

The existing pack-redundant test lacked a test to make sure that we
require the --i-still-use-this option.  Add one while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 10 ++--------
 git-compat-util.h         |  2 ++
 t/t5323-pack-redundant.sh |  5 +++++
 usage.c                   | 12 ++++++++++++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3febe732f8..6dc9e020c7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -625,14 +625,8 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 			break;
 	}
 
-	if (!i_still_use_this) {
-		fputs(_("'git pack-redundant' is nominated for removal.\n"
-			"If you still use this command, please add an extra\n"
-			"option, '--i-still-use-this', on the command line\n"
-			"and let us know you still use it by sending an e-mail\n"
-			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
-		die(_("refusing to run without --i-still-use-this"));
-	}
+	if (!i_still_use_this)
+		you_still_use_that("git pack-redundant");
 
 	if (load_all_packs)
 		load_all();
diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f..21cab99567 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -703,6 +703,8 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 void show_usage_if_asked(int ac, const char **av, const char *err);
 
+NORETURN void you_still_use_that(const char *command_name);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 688cd9706c..f2f20cfa40 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -45,6 +45,11 @@ fi
 main_repo=main.git
 shared_repo=shared.git
 
+test_expect_success 'pack-redundant needs --i-still-use-this' '
+	test_must_fail git pack-redundant >message 2>&1 &&
+	test_grep "nominated for removal" message
+'
+
 git_pack_redundant='git pack-redundant --i-still-use-this'
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/usage.c b/usage.c
index 38b46bbbfe..4aaad2b553 100644
--- a/usage.c
+++ b/usage.c
@@ -372,3 +372,15 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	trace2_cmd_error_va(fmt, ap);
 	va_end(ap);
 }
+
+NORETURN void you_still_use_that(const char *command_name)
+{
+	fprintf(stderr,
+		_("'%s' is nominated for removal.\n"
+		  "If you still use this command, please add an extra\n"
+		  "option, '--i-still-use-this', on the command line\n"
+		  "and let us know you still use it by sending an e-mail\n"
+		  "to <git@vger.kernel.org>.  Thanks.\n"),
+		command_name);
+	die(_("refusing to run without --i-still-use-this"));
+}
-- 
2.49.0-599-g90c2cffacf

