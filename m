From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 8/8] clone: allow an explicit argument for parallel submodule clones
Date: Wed, 28 Oct 2015 16:21:44 -0700
Message-ID: <1446074504-6014-9-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2t-00033w-MK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbbJ1XWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:13 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35009 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbbJ1XWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:09 -0400
Received: by pasz6 with SMTP id z6so20297664pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iddROr9Ov3oTbGwNKfWsmPbNLD+JZDOz5rD6U4IbZs=;
        b=XotTajG3VqUfgIPpgZglHoZ+p7GhkiVkRzuRU1z74otplsdVDbvxzbkAF1trBD4+F8
         qfPdbjNTwvCJMnKCQ2zBg2zj6rabIceQaIaY++iK8Te0hphhUUsFA+trh6E4CpCvK4Jw
         4az5l32476P1z6y1kzpE/VTN+5QoYIPj6uBq3oayMMqfm0FQAIgQKz45jfbO/NjZacOW
         yUaMMzvBNYGvfcgOSza5YRjaBtay9tpdJ3a7mmszQrkoIgI+lf/QQ7G5Zerljq83E382
         uYq/fbBwSYDWVnf1Oz3oFIyhxAwJa8rhGzQuAf7/+tn4CZQHGVdGNzQQWzCjUfqjP9+C
         WFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4iddROr9Ov3oTbGwNKfWsmPbNLD+JZDOz5rD6U4IbZs=;
        b=hGerA/oFHr4zSTIXdTArfCHOKgn4ivw/TIcOgPHBKu98NNtwYHBVrAd14+zCoh3cjO
         r9yOoTLwpCdLJu/FnHfe086lqhQXOcHctcjoD9ud2xr9rFEZRBmb+8zD6ufKC8wBwoAo
         BVUlV2aJ1uLx7a/nJX4nWKTlCkeGFunCO6vVm1rlsEz7MBROj0tx6sUpr5VWUT3UXSYv
         mTMS657yN5MxIjP7NAMRZ3wAUraW6pXYv4lZ9+0P/f0CHCEqFg0itimYbkaKOYZla7d6
         AWwx/ETG7mVOIe7En41IdHsT7vbzr9KH96zGMbsQ926AqPJz+BVdfqp3i17YKrudxbhr
         +oHg==
X-Gm-Message-State: ALoCoQlFqrFHGqca/KhZSjmO2c9E950QwdhXpQ4M3KUqBFKIgRLv5ux+IKcQPC8ftJKuJIhGWd9s
X-Received: by 10.66.220.2 with SMTP id ps2mr36370115pac.145.1446074529060;
        Wed, 28 Oct 2015 16:22:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id yi8sm47592866pab.22.2015.10.28.16.22.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280427>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 23 +++++++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..01bd6b7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--] <repository>
+	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -216,6 +216,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j <n>::
+--jobs <n>::
+	The number of submodules fetched at the same time.
+	Defaults to the `submodule.jobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..22b9924 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static int max_jobs = -1;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -72,6 +73,8 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
+	OPT_INTEGER('j', "jobs", &max_jobs,
+		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
@@ -95,10 +98,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -724,8 +723,20 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+
+		if (max_jobs != -1) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "--jobs=%d", max_jobs);
+			argv_array_push(&args, sb.buf);
+			strbuf_release(&sb);
+		}
+
+		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
+		argv_array_clear(&args);
+	}
 
 	return err;
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 05ea66f..ade0524 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -786,4 +786,19 @@ test_expect_success 'submodule update can be run in parallel' '
 	 grep "9 children" trace.out
 	)
 '
+
+test_expect_success 'git clone passes the parallel jobs config on to submodules' '
+	test_when_finished "rm -rf super4" &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&
+	grep "7 children" trace.out &&
+	rm -rf super4 &&
+	git config --global submodule.jobs 8 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules . super4 &&
+	grep "8 children" trace.out &&
+	rm -rf super4 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 9 . super4 &&
+	grep "9 children" trace.out &&
+	rm -rf super4
+'
+
 test_done
-- 
2.5.0.281.g4ed9cdb
