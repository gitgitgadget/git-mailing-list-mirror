Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3CEC8300A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1420757
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh7Y8Ggl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD3LzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3LzD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 07:55:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B77AC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 04:55:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id n143so5313484qkn.8
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e04Cppj7FagZnViisuqdOb3IB5yY19CCYuIZxzwoY/Q=;
        b=Wh7Y8GglV+GapOroW+uWwV/5JnVLFz6P9gbOao2oHTP3qnUN4oNNFhsfEYUQAP/0iu
         bE3KR4T70WQYaShWzxkA+WnHl8dpe+kfAXaQ+IvWI4oBW6jO05e9XIaMsDnC8kXTA9Y4
         ILHTsEafAgDkHMMlySMl03cBNbM6LJuMcKtWMsJRE3B5sqeTvlYC8cifJLP/Depfhcce
         2VeSskmZSl3e7yRlAwe0M9PbxHPQnVOkI2xcwHFgX5ueoAzvDnwKGXEup0E1YxKkAXRf
         7jcxSCo37E65FyH/3l2TlXH7XC7vOXNlTKRAkD9lSBVpjc7guOtQ1KpAeCryHOaLd6WD
         gTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e04Cppj7FagZnViisuqdOb3IB5yY19CCYuIZxzwoY/Q=;
        b=nhsb3ZEInCu2sifeIO205Z/ixhq3SQxNFxaq1IxSlHEBqcMsC3fDX6qjfd+nimmaal
         2K1SPqb2Diy+Wp1/tU5S73GfMRAi5yLGqQmnHCEhDaFSzu2BQRcG5suic7+K57aFWG5+
         UzO1oM6oa9+K3ZwPeYbTnusSovPglpIFmCnCyFaW6JLLlXtB6UawQhYLNB1sAVsEWZHq
         kixvTQmBdvR1IZ+VASUd1Fp/24wnvwHwELRuGVyZozVs1hro0jFKOCY1ExH8jSdfkluf
         a2wBjkZE4trwE+wwy+tf7i0SB8vC1O31PyVEwnYjKzwBRbP983gmLYyR0y5Hi6P6Ecik
         vnKQ==
X-Gm-Message-State: AGi0PuagEqYYT60VD7jlOrmalNqCAz84RLWCnTIBBRExgIYJqsnGE/mJ
        PpM+IdM7IfIuxchZAz8C5BvkfJx8
X-Google-Smtp-Source: APiQypJSvPbWnJY9T0fdKqdvVRzUGUOrvaf7SPEgAh9a7FTFtWY/KA+J5RBNgrrcOWEkR7O43UIESg==
X-Received: by 2002:a37:a0c7:: with SMTP id j190mr2988314qke.461.1588247701771;
        Thu, 30 Apr 2020 04:55:01 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id 22sm1612400qks.76.2020.04.30.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 04:55:00 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Simpson <no-reply@MailScreen.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] switch: fix errors and comments related to -c and -C
Date:   Thu, 30 Apr 2020 07:54:57 -0400
Message-Id: <75c9cf6ce95e753f50ce9b8b86b2c3ded5d8d38d.1588247662.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
References: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d787d311db (checkout: split part of it to new command 'switch',
2019-03-29), the `git switch` command was created by extracting the
common functionality of cmd_checkout() in checkout_main(). However, in
b7b5fce270 (switch: better names for -b and -B, 2019-03-29), the branch
creation and force creation options for 'switch' were changed to -c and
-C, respectively. As a result of this, error messages and comments that
previously referred to `-b` and `-B` became invalid for `git switch`.

For error messages that refer to `-b` and `-B`, use a format string
instead so that `-c` and `-C` can be printed when `git switch` is
invoked.

Reported-by: Robert Simpson
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Robert, is the email listed above correct? If not, please let me know
    which email to use. (I hope that this reaches you somehow.)

Range-diff against v1:
1:  0f7f9eefc0 ! 1:  75c9cf6ce9 switch: fix errors and comments related to -c and -C
    @@ Commit message
         In d787d311db (checkout: split part of it to new command 'switch',
         2019-03-29), the `git switch` command was created by extracting the
         common functionality of cmd_checkout() in checkout_main(). However, in
    -    b7b5fce270 (switch: better names for -b and -B, 2019-03-29), these
    -    the branch creation and force creation options for 'switch' were changed
    -    to -c and -C, respectively. As a result of this, error messages and
    -    comments that previously referred to `-b` and `-B` became invalid for
    -    `git switch`.
    +    b7b5fce270 (switch: better names for -b and -B, 2019-03-29), the branch
    +    creation and force creation options for 'switch' were changed to -c and
    +    -C, respectively. As a result of this, error messages and comments that
    +    previously referred to `-b` and `-B` became invalid for `git switch`.
     
    -    For comments that refer to `-b` and `-B`, add `-c` and `-C` to the
    -    comment.
    +    For error messages that refer to `-b` and `-B`, use a format string
    +    instead so that `-c` and `-C` can be printed when `git switch` is
    +    invoked.
     
    -    For error messages that refer to `-b`, introduce `enum cmd_variant` and
    -    use it to differentiate between `checkout` and `switch` when printing
    -    out error messages.
    -
    -    An alternative implementation which was considered involved inserting
    -    option name variants into a struct which is passed in by each command
    -    variant. Even though this approach is more general and could be
    -    applicable for future differing option names, it seemed like an
    -    over-engineered solution when the current pair of options are the only
    -    differing ones. We should probably avoid adding options which have
    -    different names anyway.
    -
    -    Reported-by: Robert Simpson <no-reply@MailScreen.com>
    +    Reported-by: Robert Simpson
     
     
      ## Notes ##
    @@ builtin/checkout.c: static struct option *add_checkout_path_options(struct check
      	return newopts;
      }
      
    -+enum cmd_variant {
    -+	CMD_CHECKOUT,
    -+	CMD_SWITCH,
    -+	CMD_RESTORE
    -+};
    ++/* create-branch option (either b or c) */
    ++static char cb_option = 'b';
     +
      static int checkout_main(int argc, const char **argv, const char *prefix,
      			 struct checkout_opts *opts, struct option *options,
    --			 const char * const usagestr[])
    -+			 const char * const usagestr[],
    -+			 enum cmd_variant variant)
    - {
    - 	struct branch_info new_branch_info;
    - 	int parseopt_flags = 0;
    + 			 const char * const usagestr[])
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
      	}
      
      	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
     -		die(_("-b, -B and --orphan are mutually exclusive"));
    -+		die(variant == CMD_CHECKOUT ?
    -+				_("-b, -B and --orphan are mutually exclusive") :
    -+				_("-c, -C and --orphan are mutually exclusive"));
    ++		die(_("-%c, -%c and --orphan are mutually exclusive"),
    ++				cb_option, toupper(cb_option));
      
      	if (opts->overlay_mode == 1 && opts->patch_mode)
      		die(_("-p and --overlay are mutually exclusive"));
    @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      		opts->new_branch = opts->new_orphan_branch;
      
     -	/* --track without -b/-B/--orphan should DWIM */
    -+	/* --track without -b/-B/--orphan for checkout or -c/-C/--orphan for switch should DWIM */
    ++	/* --track without -c/-C/-b/-B/--orphan should DWIM */
      	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
      		const char *argv0 = argv[0];
      		if (!argc || !strcmp(argv0, "--"))
    @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      		if (!argv0 || !argv0[1])
     -			die(_("missing branch name; try -b"));
     +			die(_("missing branch name; try -%c"),
    -+					variant == CMD_CHECKOUT ? 'b' : 'c');
    ++					cb_option);
      		opts->new_branch = argv0 + 1;
      	}
      
    -@@ builtin/checkout.c: int cmd_checkout(int argc, const char **argv, const char *prefix)
    - 	options = add_checkout_path_options(&opts, options);
    - 
    - 	ret = checkout_main(argc, argv, prefix, &opts,
    --			    options, checkout_usage);
    -+			    options, checkout_usage, CMD_CHECKOUT);
    - 	FREE_AND_NULL(options);
    - 	return ret;
    - }
     @@ builtin/checkout.c: int cmd_switch(int argc, const char **argv, const char *prefix)
    + 	options = add_common_options(&opts, options);
      	options = add_common_switch_branch_options(&opts, options);
      
    ++	cb_option = 'c';
    ++
      	ret = checkout_main(argc, argv, prefix, &opts,
    --			    options, switch_branch_usage);
    -+			    options, switch_branch_usage, CMD_SWITCH);
    + 			    options, switch_branch_usage);
      	FREE_AND_NULL(options);
    - 	return ret;
    - }
    -@@ builtin/checkout.c: int cmd_restore(int argc, const char **argv, const char *prefix)
    - 	options = add_checkout_path_options(&opts, options);
    - 
    - 	ret = checkout_main(argc, argv, prefix, &opts,
    --			    options, restore_usage);
    -+			    options, restore_usage, CMD_RESTORE);
    - 	FREE_AND_NULL(options);
    - 	return ret;
    - }

 builtin/checkout.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bc94d392b..a45519a2b4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1544,6 +1544,9 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
+/* create-branch option (either b or c) */
+static char cb_option = 'b';
+
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 const char * const usagestr[])
@@ -1586,7 +1589,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("-b, -B and --orphan are mutually exclusive"));
+		die(_("-%c, -%c and --orphan are mutually exclusive"),
+				cb_option, toupper(cb_option));
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("-p and --overlay are mutually exclusive"));
@@ -1614,7 +1618,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
 	 * and new_branch_force and new_orphan_branch will tell us which one of
-	 * -b/-B/--orphan is being used.
+	 * -b/-B/-c/-C/--orphan is being used.
 	 */
 	if (opts->new_branch_force)
 		opts->new_branch = opts->new_branch_force;
@@ -1622,7 +1626,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->new_orphan_branch)
 		opts->new_branch = opts->new_orphan_branch;
 
-	/* --track without -b/-B/--orphan should DWIM */
+	/* --track without -c/-C/-b/-B/--orphan should DWIM */
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
@@ -1631,7 +1635,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		skip_prefix(argv0, "remotes/", &argv0);
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
-			die(_("missing branch name; try -b"));
+			die(_("missing branch name; try -%c"),
+					cb_option);
 		opts->new_branch = argv0 + 1;
 	}
 
@@ -1822,6 +1827,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	options = add_common_options(&opts, options);
 	options = add_common_switch_branch_options(&opts, options);
 
+	cb_option = 'c';
+
 	ret = checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage);
 	FREE_AND_NULL(options);
-- 
2.26.2.548.gbb00c8a0a9

