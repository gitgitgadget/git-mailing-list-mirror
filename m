Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A71C29D
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUT5WOni"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB3A6
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so618269f8f.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933144; x=1699537944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciIRKW9ZoyDVfznpcr+TQ+UeWjWjOr3JawO7e7mZUZg=;
        b=eUT5WOni8iZJYtqy7iiV5k+a0eCSu0FihvrNDqNlGeMW7ztXlVhTJOZkVxHI1Jf3iW
         dDQbZike4/m192GrGRh1y46ah2OmuLvhcPoDKjRlw/5+TLGGqpmmgfguvhqmgHaYUuzL
         isFRLQiUL+kZQ7kmacGPYsLla4uKjpJ1T8FoeC6Oa4UAgubDX89G1/PMMLJCPvRRqp6o
         2ufflSHF4lCYOhWHCw9Bl601guYBt8XBZnNGzDd12b6pF1bNsz0OCPpigD8H7/MoTTT+
         UtSNElJAQrkYFrP0aJrWjOoEs9o0MbOv9/YBH4XxSbw+o1SerFOYfyc4j8yj5zoQ2wJY
         liBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933144; x=1699537944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciIRKW9ZoyDVfznpcr+TQ+UeWjWjOr3JawO7e7mZUZg=;
        b=XkmTvHZriLZ1q348xzmSWPgRC9GPs7FMse/VoqNV22iPJsxntVJuMtCFsK8yQQv9hK
         Q1RNJyGvfoKziPLZJwOET++qIU/joOt8JlqhPkFUkpH13d7ynqbpsa1CSrcg4FfxDoDD
         tG+H9aohoN2MlF16ND5zwTp//L2CbrDv0Q+KYgBzhcowUPh7tWeoKRs6ihsibUShdeFc
         +OYKUAiQfOj0Sb0rB3mz/G+unB+IHECCS+b7OdGoiwqjaKPSBU+nu6FOl+n537tacVwR
         V/zXnaI+XvFdHfZyTXSpD4TyHCUsb6KaoIhDxcrebX6EHHbdSh8tk+CTyRJSQs5HJ3LT
         sIhA==
X-Gm-Message-State: AOJu0YwOcAI3tfhWbZWFciQOjpL3aLCMt7OtBn3wnmaxQTDkYT1PIKRk
	//tF/76hoVcFLLM5xw+BQWQRrP7Zaz8=
X-Google-Smtp-Source: AGHT+IEGOhX71JDyyVx8lbdwpbDHYBkuSYgJEM3DnEb/rJ1dAlQ/RgXva2f0CoHmaonQ3j0l+3q3EQ==
X-Received: by 2002:a05:6000:1aca:b0:32d:d973:b546 with SMTP id i10-20020a0560001aca00b0032dd973b546mr7898440wry.0.1698933143546;
        Thu, 02 Nov 2023 06:52:23 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 08/14] replay: remove progress and info output
Date: Thu,  2 Nov 2023 14:51:45 +0100
Message-ID: <20231102135151.843758-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 544a546674..74680b0c8f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -208,7 +208,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -216,9 +216,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -237,7 +234,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -251,7 +247,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.42.0.496.g529a7fda40

