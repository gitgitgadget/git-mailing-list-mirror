Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC7CC47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEB613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhE0AMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhE0AMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:12:20 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A263C06135B
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n12-20020a0cdc8c0000b02901efdf8d3bc7so2534047qvk.23
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TJJkj6w7H78AOnljLVFLdOFVsu/TQvCzoH/8PvUwvg8=;
        b=TMtaV7YaeFAvqwxuC7mR4Nae20UTI6uYi0LfP+t03EaJXWcfU7G7xM3o1+/qc4jWlZ
         r7OvX01v7jFomjR8I7p43DEetqtOi7Oxv0MyOs9VAQgDNVhb4acCtmNXbhnX6DPQFTtd
         a0Mu4vhTXtE9RlAZVMEt7cnsVeWXCi20d9ML+dOW2LCpm1KqyIRqQ4Ee0Y6bTPXXYEzG
         ZPLUz78OSR1YIaHK+HiO/NjRwp9eEzGDIMv53sa95DNciyWo2CcTGWlSqF2T0BpqGW7r
         mipTfWmmJptH5E9f4tCTfBNbk+BW33AxNDu+beCdLLJpDz6FPMxS7lNL+dcjnY96vaYD
         CP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TJJkj6w7H78AOnljLVFLdOFVsu/TQvCzoH/8PvUwvg8=;
        b=EwvoVPJCrnqD8tqh9Ti+Va6PCKG09IZZ7o+fAk92RnRiOw7+ZDj/FvFo5OtLktF2g1
         MoTrQ3HQ39uTe5WX3+QM+y8sDFHJtaf1LY9x0owkHFug7YbZWThkF1qnEmwWRuIeySfM
         b1SAAB5ir8ly98S/MdOsTkCttFA1CTmRKFiP2IeAd0A8P/PuWxeYfPhw1sAV1KdRMhPT
         Itq2XDVtaCDhuRdhc10LgPIaeO//eitjhqtcieZNdL7kc2i0g/QrOJC7l4KJxd8fGCxm
         mNmG8D386FgmJQ2gTmBiWsTJIH/Szw9Iwe/s86Dbp6SyMjksg2c4H/SjBDGDdSANvdT/
         FqgQ==
X-Gm-Message-State: AOAM53033buAP3we9n+dKmyd2ZFCt52EoOOB5y11Xdz2iqELD6ytnnu0
        5Tf13DhBnSEF374m8AlYZsrd889WCiQj52dAM5ro1li+iGo/vNqYsHC2V75/SfxKsL/gqcHhac2
        3riVtnyn9uOSxPP7kYJ0eybeN2SShnYB5ffsPwi47gpYW2thGmOpESx2donwuzBk6AA28PMz9Cw
        ==
X-Google-Smtp-Source: ABdhPJzSY0cft/mxodMbWE0nzdpQqCBYSo7W17wc2RBZeGuK18Nm2rGXFrCSYfa4wsFdOfCTHtB4HDQnNlM3UL7Y3nM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4a83:: with SMTP id
 h3mr815682qvx.19.1622074206448; Wed, 26 May 2021 17:10:06 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:53 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-35-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 34/37] git-send-email: use 'git hook run' for 'sendemail-validate'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the new 'git hook run' subcommand to run 'sendemail-validate',
we can reduce the boilerplate needed to run this hook in perl. Using
config-based hooks also allows us to run 'sendemail-validate' hooks that
were configured globally when running 'git send-email' from outside of a
Git directory, alongside other benefits like multihooks and
parallelization.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git-send-email.perl   | 26 ++++++--------------------
 t/t9001-send-email.sh | 13 +------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 170f42fe21..b55687453e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1958,26 +1958,12 @@ sub unique_email_list {
 sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
-	if ($repo) {
-		my $validate_hook = catfile($repo->hooks_path(),
-					    'sendemail-validate');
-		my $hook_error;
-		if (-x $validate_hook) {
-			my $target = abs_path($fn);
-			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = cwd();
-			chdir($repo->wc_path() or $repo->repo_path())
-				or die("chdir: $!");
-			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = system_or_msg([$validate_hook, $target]);
-			chdir($cwd_save) or die("chdir: $!");
-		}
-		if ($hook_error) {
-			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
-				       "%s\n" .
-				       "warning: no patches were sent\n"), $fn, $hook_error);
-		}
-	}
+	my $target = abs_path($fn);
+
+	system_or_die(["git", "hook", "run", "sendemail-validate", "-j1", "-a", $target],
+		sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
+			   "warning: no patches were sent\n"),
+		        $fn));
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
 	# encoding.
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa603cf4d0..bdf6472871 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,7 +539,6 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -557,7 +556,6 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -2170,16 +2168,7 @@ test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
 	write_script .git/hooks/sendemail-validate <<-\EOF &&
-	# test that we have the correct environment variable, pwd, and
-	# argument
-	case "$GIT_DIR" in
-	*.git)
-		true
-		;;
-	*)
-		false
-		;;
-	esac &&
+	# test that we have the correct argument
 	test -f 0001-add-main.patch &&
 	grep "add main" "$1"
 	EOF
-- 
2.31.1.818.g46aad6cb9e-goog

