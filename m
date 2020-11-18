Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A69C63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EA5221F8
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n0AX2CwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKRSCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:02:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62946 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKRSCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:02:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5C318EB60;
        Wed, 18 Nov 2020 13:02:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TZyvANQuk4Jl4rwjEAJ8Nn8gU74=; b=n0AX2C
        wZx0vfrMO7rR2lHSM3caugHiX2Fb66J44CqC52zmIFzS7TDcwsN9lMFgLVHf2mQ+
        Zx8gVQYY9Fcl54PI3CUTEF7vuvJa6HU3f2NA0htzPhY/3yS9MikOchNfig2farfS
        u8AW44ZnD+tdnhqK3FUxXKbft7zqZAKY2a7LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RhhkLbqWIQ3IJM92TU723SLPt/I1OXNo
        MXEalT7mWSOGg4h9tYL86E9HAdxt1DxKPe/xSdAWGC+ViHf78xzDD/1wkJkgLguS
        dJ612t6i2X8/XtRkzkxqtlttAcQP4SMtb8CMM6dCg0q1YUsl2ZbMT2Jni6i/ghND
        83d6t7nR4Lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADE498EB5F;
        Wed, 18 Nov 2020 13:02:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F3EA8EB5E;
        Wed, 18 Nov 2020 13:02:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v4] help.c: expand options for help.autocorrect
References: <20201118172849.24715-1-sir@cmpwn.com>
Date:   Wed, 18 Nov 2020 10:02:29 -0800
In-Reply-To: <20201118172849.24715-1-sir@cmpwn.com> (Drew DeVault's message of
        "Wed, 18 Nov 2020 12:28:49 -0500")
Message-ID: <xmqq1rgq35my.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39A3A792-29C8-11EB-BE43-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Some users would prefer to never suggest corrections at all.

Here is how I would have phrased it.

Key points:

 - The log message starts with the description of the current state
   of the system and introduces the problem the patch tries to
   solve.

 - Then gives orders to the codebase to "be like so"

 - The addition of "never" is the primary change to solve the stated
   problem.  "immediate" is not the essential part but is merely
   adding a synonym while we are in the vicinity.

Thanks.


--- >8 ------ >8 ------ >8 --- cut here --- >8 ------ >8 ------ >8 ---
Subject: [PATCH] help.c: allow help.autocorrect to say "do not even compute  suggestions"

While help.autocorrect can be set to 0 to decline auto-execution of
possibly mistyped commands, it still spends cycles to compute the
suggestions, and it wastes screen real estate.

Update help.autocorrect to accept the string "never" to just exit
with error upon mistyped commands to help users who prefer to never
see suggested corrections at all.

While at it, introduce "immediate" as a more readable way to
immediately execute the auto-corrected command, which can be done
with negative value.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff:
1:  036b766035 ! 1:  cfe85a6e16 help.c: expand options for help.autocorrect
    @@ Metadata
     Author: Drew DeVault <sir@cmpwn.com>
     
      ## Commit message ##
    -    help.c: expand options for help.autocorrect
    +    help.c: allow help.autocorrect to say "do not even compute suggestions"
     
    -    Some users would prefer to never suggest corrections at all. This
    -    updates help.autocorrect to accept the strings "immediate" and "never",
    -    the former assuming the prior behavior of negative values for
    -    autocorrect, and the latter skipping auto-correction entirely.
    +    While help.autocorrect can be set to 0 to decline auto-execution of
    +    possibly mistyped commands, it still spends cycles to compute the
    +    suggestions, and it wastes screen real estates.
    +
    +    Update help.autocorrect to accept the string "never" to just exit
    +    with error upon mistyped commands to help users who prefer to never
    +    see suggested corrections at all.
    +
    +    While at it, introduce "immediate" as a more readable way to
    +    immediately execute the auto-corrected command, which can be done
    +    with negative value.
     
         Signed-off-by: Drew DeVault <sir@cmpwn.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ Documentation/config/help.txt: help.format::
     +	to the error, git will automatically run the intended command after
     +	waiting a duration of time defined by this configuration value in
     +	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
    -+	will be shown, but not executed. If "immediate", the suggested command
    ++	will be shown, but not executed. If it is a negative integer, or
    ++	"immediate", the suggested command
     +	is run immediately. If "never", suggestions are not shown at all. The
     +	default value is zero.
    -++
    -+Negative integers are interpreted as "immediately" for historical reasons.
      
      help.htmlPath::
      	Specify the path where the HTML documentation resides. File system paths

 Documentation/config/help.txt | 15 ++++++++-------
 help.c                        | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 224bbf5a28..783a90a0f9 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -8,13 +8,14 @@ help.format::
 	the default. 'web' and 'html' are the same.
 
 help.autoCorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	If git detects typos and can identify exactly one valid command similar
+	to the error, git will automatically run the intended command after
+	waiting a duration of time defined by this configuration value in
+	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
+	will be shown, but not executed. If it is a negative integer, or
+	"immediate", the suggested command
+	is run immediately. If "never", suggestions are not shown at all. The
+	default value is zero.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 919cbb9206..3c3bdec213 100644
--- a/help.c
+++ b/help.c
@@ -472,12 +472,26 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 static int autocorrect;
 static struct cmdnames aliases;
 
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
+
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	const char *p;
 
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "never")) {
+			autocorrect = AUTOCORRECT_NEVER;
+		} else if (!strcmp(value, "immediate")) {
+			autocorrect = AUTOCORRECT_IMMEDIATELY;
+		} else {
+			int v = git_config_int(var, value);
+			autocorrect = (v < 0)
+				? AUTOCORRECT_IMMEDIATELY : v;
+		}
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -525,6 +539,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -594,7 +613,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
-- 
2.29.2-461-g858fb5bde9

