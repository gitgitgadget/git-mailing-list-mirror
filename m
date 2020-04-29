Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB237C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856B52076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUKOFwNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD2JAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2JA3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 05:00:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98AC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:00:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t20so1171979qtq.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2FLFvNk2gqZ9rZ41fS9t4DIs1FyImN9KepVpVb3D/c=;
        b=KUKOFwNdOhQLLldJDA3qeVNK77BjjcumcJSI383ecgiYoklQc15ckBCj+bo5EOc08p
         90HLxYFmFRt5U/Eja6cG6TSbam7dYh931yqmzlKPJmCXTlNzFb7eJHVyT0j8QuNnTl24
         7uyoNiiRw0/OYhri0cRNPhX953OZzuGvMPXTlZdRihsvJ2Ca7LL1jokP7mIlnJPpcYUz
         ZEbEO+Z4txshfrov9L59Sx/xxW7VPdVp3MNJSMxgi5ZhlbFd9jiU5ikTe0DOqL/8NFok
         vN9Hgqw9ubozxUgLdEoiZngcwyDWlUHVs8uXkrFaCf1T7rsvYaBtEMEG2MaBUsGH9Ur7
         nH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2FLFvNk2gqZ9rZ41fS9t4DIs1FyImN9KepVpVb3D/c=;
        b=l0g9XQKM3VJcCgpUxw9PZB+qwBauZ/Qtwbr4dijdnD8dfWBFXo2uemGKov2OVr2JI6
         O4AM5eJweX6752aGQL+Sv7waDgD4T1ADt+Cz66zj6iXvUlWapB65FnLeq8WYe1/neCsq
         B9xaUxdUegN8tKkx5EFnwQcGB+EyGpIsmLBrd4yoN3Zgybqm9joH5UVxInb+bU0ds5pG
         3G9BCAsrvN7V7GAmuchfbi3CIQQA89KO5ZB2pRCZIr+O76oAVxJC6ktXQ9UCUu7TgbVz
         TVgIXBPxkPtd/q7M18oRdJ/ZY5snfQSMvUHZjXEgMmJTbDCMyvY0dhUSA6O38XsN0lHN
         uttg==
X-Gm-Message-State: AGi0PubEws8s/tP0VxcgDLgQpjShsKa8HwtgrI6h8QzLwhaOSqImHmgL
        eYtpk8sXNR61aJ3Y36BN9GIWaQKT
X-Google-Smtp-Source: APiQypLfBPOfFZr+4FlAv3h0TwFx06fIbwW5hPwwbghzOt3VOm8wd8ajvsi0rNk1ZjNPacR+NOh4SA==
X-Received: by 2002:ac8:4e86:: with SMTP id 6mr32735373qtp.37.1588150828084;
        Wed, 29 Apr 2020 02:00:28 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id m7sm15386308qke.124.2020.04.29.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:00:27 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Simpson <no-reply@MailScreen.com>
Subject: [PATCH] switch: fix errors and comments related to -c and -C
Date:   Wed, 29 Apr 2020 05:00:19 -0400
Message-Id: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
References: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d787d311db (checkout: split part of it to new command 'switch',
2019-03-29), the `git switch` command was created by extracting the
common functionality of cmd_checkout() in checkout_main(). However, in
b7b5fce270 (switch: better names for -b and -B, 2019-03-29), these
the branch creation and force creation options for 'switch' were changed
to -c and -C, respectively. As a result of this, error messages and
comments that previously referred to `-b` and `-B` became invalid for
`git switch`.

For comments that refer to `-b` and `-B`, add `-c` and `-C` to the
comment.

For error messages that refer to `-b`, introduce `enum cmd_variant` and
use it to differentiate between `checkout` and `switch` when printing
out error messages.

An alternative implementation which was considered involved inserting
option name variants into a struct which is passed in by each command
variant. Even though this approach is more general and could be
applicable for future differing option names, it seemed like an
over-engineered solution when the current pair of options are the only
differing ones. We should probably avoid adding options which have
different names anyway.

Reported-by: Robert Simpson <no-reply@MailScreen.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Robert, is the email listed above correct? If not, please let me know
    which email to use. (I hope that this reaches you somehow.)

 builtin/checkout.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bc94d392b..0ca74cde08 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1544,9 +1544,16 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
+enum cmd_variant {
+	CMD_CHECKOUT,
+	CMD_SWITCH,
+	CMD_RESTORE
+};
+
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[])
+			 const char * const usagestr[],
+			 enum cmd_variant variant)
 {
 	struct branch_info new_branch_info;
 	int parseopt_flags = 0;
@@ -1586,7 +1593,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("-b, -B and --orphan are mutually exclusive"));
+		die(variant == CMD_CHECKOUT ?
+				_("-b, -B and --orphan are mutually exclusive") :
+				_("-c, -C and --orphan are mutually exclusive"));
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("-p and --overlay are mutually exclusive"));
@@ -1614,7 +1623,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
 	 * and new_branch_force and new_orphan_branch will tell us which one of
-	 * -b/-B/--orphan is being used.
+	 * -b/-B/-c/-C/--orphan is being used.
 	 */
 	if (opts->new_branch_force)
 		opts->new_branch = opts->new_branch_force;
@@ -1622,7 +1631,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->new_orphan_branch)
 		opts->new_branch = opts->new_orphan_branch;
 
-	/* --track without -b/-B/--orphan should DWIM */
+	/* --track without -b/-B/--orphan for checkout or -c/-C/--orphan for switch should DWIM */
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
@@ -1631,7 +1640,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		skip_prefix(argv0, "remotes/", &argv0);
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
-			die(_("missing branch name; try -b"));
+			die(_("missing branch name; try -%c"),
+					variant == CMD_CHECKOUT ? 'b' : 'c');
 		opts->new_branch = argv0 + 1;
 	}
 
@@ -1785,7 +1795,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage);
+			    options, checkout_usage, CMD_CHECKOUT);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1823,7 +1833,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	options = add_common_switch_branch_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage);
+			    options, switch_branch_usage, CMD_SWITCH);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1860,7 +1870,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage);
+			    options, restore_usage, CMD_RESTORE);
 	FREE_AND_NULL(options);
 	return ret;
 }
-- 
2.26.2.548.gbb00c8a0a9

