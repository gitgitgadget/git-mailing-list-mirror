Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB63C43142
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F45B64FEE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCKCMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCKCMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:12:00 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEEC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:54 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id iy2so14134298qvb.22
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rw+eb/obMKPLBdEDKBTqV2W8PW7N/pZsGxejVqfZVyQ=;
        b=d3M41RZH4DR9S9nf2/7MG+z1kYs3mUsjsLgalyR3kgJolTv3yRC1d47Tx33nEdJM0s
         FnFI3sUL5UDRwvgVhylto0lSU6ApmqOboylSGRyxb16KcrxtZDP1i+l3WE7mldvhVnos
         KdFI1qABNSxDZCLAtHR8o45xxBvIHNyLYHKza5bMxribxlF0t2OPaIo4PCrjzVms4kxk
         yIIyH+9LD49oBGjAho4ai+rWhfoiW5cTUEY91SYqPjTC85fBuzVjUw1/IDJksc2zZ8nf
         D/iAuIMngxvdYWUKuKX797vfV2pDxNR4Oljo8s6rxtReftRnuMHOoAULIumr9AnERlZg
         zM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rw+eb/obMKPLBdEDKBTqV2W8PW7N/pZsGxejVqfZVyQ=;
        b=imdyxmISeh6mWEE3pgCZGy8EajLmvAeYHXJ++kE9gL3zlaIs9OvuhWQ1IVJ4syl3/S
         29VBAMdSnevNM8EWcOxcdG864NUwO0P6FSB4ubP8F07o2BQpuPiKjcC0yFCqOkOPYANP
         mskUGCUcQG3saypUa4HYtxONDFZ+Q2EA5nmt+PeVIvAAHivdKUIKSXpFHGhUcRnjYezM
         i+udX4kZXXNfSrBrUAeCij9YIDvc/H68I40s+QhTdxT0fstUZIilvZp3WDYy6D0hULz+
         ICHnhRQEWn4HsfSfudOviodniQ3hJwu6wsFEOqvxUbmRtO6htCf3DSwaBw84YHe58iJX
         an8w==
X-Gm-Message-State: AOAM53001e4mB40hfo/VVitc1twPgA4Z0PTquUrF0EyiCVRNuB5G5/1W
        gHp3ygKr75+OBcwamhSHixbdoX6NiZNj+xJyQDOE6uo7kaG6uRRxsgdDww3N12C8FMFVa8c6ZJo
        WoE7iv4Qr3dtFc4i2hju0XtxZ36QNK9zHI/Yelj0tYbbavHvR1VI2J0+vIHx8CZs/oZ15cTv9bw
        ==
X-Google-Smtp-Source: ABdhPJxGuoxZWnWz58v66mC5saCHy/iBUziXQ6LpNqPf98ptjpYfuGtOsFF7q2oeJZjnBLwO/CrylQkBK0yf6ocCrOg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:c8a:: with SMTP id
 r10mr5880204qvr.13.1615428713355; Wed, 10 Mar 2021 18:11:53 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:35 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-36-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 35/37] git-send-email: use 'git hook run' for 'sendemail-validate'
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
 git-send-email.perl   | 21 ++++-----------------
 t/t9001-send-email.sh | 11 +----------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c0809..73e1e0b51a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1941,23 +1941,10 @@ sub unique_email_list {
 sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
-	if ($repo) {
-		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
-					    'sendemail-validate');
-		my $hook_error;
-		if (-x $validate_hook) {
-			my $target = abs_path($fn);
-			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = cwd();
-			chdir($repo->wc_path() or $repo->repo_path())
-				or die("chdir: $!");
-			local $ENV{"GIT_DIR"} = $repo->repo_path();
-			$hook_error = "rejected by sendemail-validate hook"
-				if system($validate_hook, $target);
-			chdir($cwd_save) or die("chdir: $!");
-		}
-		return $hook_error if $hook_error;
-	}
+	my $target = abs_path($fn);
+	return "rejected by sendemail-validate hook"
+		if system(("git", "hook", "run", "sendemail-validate", "-a",
+				$target));
 
 	# Any long lines will be automatically fixed if we use a suitable transfer
 	# encoding.
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4eee9c3dcb..456b471c5c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2101,16 +2101,7 @@ test_expect_success $PREREQ 'invoke hook' '
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
2.31.0.rc2.261.g7f71774620-goog

