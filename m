Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE6C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiBXI45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiBXI4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 03:56:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2E17B89E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 00:56:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk11so2874687ejb.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 00:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qLPZmfXY5bwr6RRcUhM43YDHSJKRUoyahoVktgG91I8=;
        b=L97u1wLU67PYs1ErkFyR8OmW39y6rSzU72gtmhHC1ncM+Rn3rrsa19G07boE5rEW9H
         r9uKlyPtKRLx47il+8LGiXh8dNjKYPkJ5KgVKtm05A5ZVtzh5eEK+y/ZZ5qPZKHkAWMK
         G3MDvQRw643zceoba+sUhpLW2uyN8FOAR3o2SrHA/2h7bjO4SBmV1dZV9j9Fb983xydW
         9bg5YmE9sxGkTrAs0FRw9Nkt2/9aLugbv4bO9a8q9iobHWKKm3zvqePJbqKebIpBzMK+
         WjYP44dILk+7GbiZtFv789FVlSDiJGheQecAhwO7CRHTAXAWojc//mQX1BNQFRoYC4kT
         WaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qLPZmfXY5bwr6RRcUhM43YDHSJKRUoyahoVktgG91I8=;
        b=RtDGgAFZH1YuewQpZ6YX19DJFGUZSpXtVDehyDMipyTnDTU1YG8gdCAHSCc/y9xjkM
         q/cLsJiOYEDpCNxVAPcY+SnCMXShgYGPjE9UXRCeax4/6/qpdeBmc7Ncm/9jQgFy3QpM
         SG2PBA582elGZQq8bpYEpunpHZU4NfWqCWg8q5XBxLFFgogZuazPGxspZHbd7ZZgJnLX
         z0uHUD/IzrGYBq3El5OeFhprnXxy0V+iYF4NnTyUTl7chYjnst7ZwOk00E+5N5Hldgyz
         KDwAyJpv685e7QQXW8YLF+2tOExFgQhNtRP0SbMLPGvB1vaolRcLhHbYY/sn/Vb4oQjS
         9H4w==
X-Gm-Message-State: AOAM53347pgIrIXuxHwGNJNagPtahoPDbqP7NZgO0DrGg7kqZwxIo84h
        ZwvHJH23YYvmT1tKvrAsWfZ70op87jg=
X-Google-Smtp-Source: ABdhPJwbW2dSP2sr4IIa4nC9EyfLB2Htx6z1l9AAmAq7D/MnJoXv0lE60aY/SK1Tc0tQQZzekShzKA==
X-Received: by 2002:a17:906:95d5:b0:6b3:2e97:25ab with SMTP id n21-20020a17090695d500b006b32e9725abmr1496010ejy.322.1645692959062;
        Thu, 24 Feb 2022 00:55:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m2sm967499edl.106.2022.02.24.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:55:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nN9un-000CSJ-PK;
        Thu, 24 Feb 2022 09:55:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v2] switch: mention the --detach option when dying due
 to lack of a branch
Date:   Thu, 24 Feb 2022 09:53:09 +0100
References: <20220224064710.2252637-1-alexhenrie24@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220224064710.2252637-1-alexhenrie24@gmail.com>
Message-ID: <220224.86sfs8abj6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Alex Henrie wrote:

> Users who are accustomed to doing `git checkout <tag>` assume that
> `git switch <tag>` will do the same thing. Inform them of the --detach
> option so they aren't left wondering why `git switch` doesn't work but
> `git checkout` does.

Thanks, this looks good to me! FWIW while testing this v2 I came up with
this on top, which you may or may not want (some unrelated changes):

1. We had a to_free but didn't free it, now we do. Didn't matter with
   SANITIZE=leak, but FWIW valgrind with "valgrind --leak-check=full
   --show-leak-kinds=all" is marginally happier

2. Maybe s/code = /return / with a helper is easier to read, maybe not.

3. That #2 makes the code/advice wrapper simpler (also with the to_free)

4. Used test_cmp in the test to check the actual output we got, and added
   a missing test for the "tag" case.

   In any case s/test_i18ngrep/grep/ is the right thing nowadays for new code.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9244827ca02..9e4d03343fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1393,34 +1393,39 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	return status;
 }
 
-static void die_expecting_a_branch(const struct branch_info *branch_info)
+static int die_expecting_a_branch_message(const struct branch_info *branch_info, char **to_free)
 {
 	struct object_id oid;
-	char *to_free;
-	int code;
 
-	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
-		const char *ref = to_free;
+	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, to_free, 0) == 1) {
+		const char *ref = *to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
-			code = die_message(_("a branch is expected, got tag '%s'"), ref);
+			return die_message(_("a branch is expected, got tag '%s'"), ref);
 		else if (skip_prefix(ref, "refs/remotes/", &ref))
-			code = die_message(_("a branch is expected, got remote branch '%s'"), ref);
+			return die_message(_("a branch is expected, got remote branch '%s'"), ref);
 		else
-			code = die_message(_("a branch is expected, got '%s'"), ref);
+			return die_message(_("a branch is expected, got '%s'"), ref);
 	}
 	else if (branch_info->commit)
-		code = die_message(_("a branch is expected, got commit '%s'"), branch_info->name);
+		return die_message(_("a branch is expected, got commit '%s'"), branch_info->name);
 	else
 		/*
 		 * This case should never happen because we already die() on
 		 * non-commit, but just in case.
 		 */
-		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);
+		return die_message(_("a branch is expected, got '%s'"), branch_info->name);
+}
+
+static void die_expecting_a_branch(const struct branch_info *branch_info)
+{
+	char *to_free = NULL;
+	int code = die_expecting_a_branch_message(branch_info, &to_free);
 
 	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
 		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
 
+	free(to_free);
 	exit(code);
 }
 
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index f54691bac9f..0708359ee24 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -32,15 +32,31 @@ test_expect_success 'switch and detach' '
 	test_must_fail git symbolic-ref HEAD
 '
 
-test_expect_success 'suggestion to detach' '
-	test_must_fail git switch main^{commit} 2>stderr &&
-	test_i18ngrep "try again with the --detach option" stderr
+test_expect_success 'suggestion to detach commit' '
+	test_must_fail git switch main^{commit} 2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: a branch is expected, got commit '\''main^{commit}'\''
+	hint: If you want to detach HEAD at the commit, try again with the --detach option.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'suggestion to detach tag' '
+	test_must_fail git switch first 2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: a branch is expected, got tag '\''first'\''
+	hint: If you want to detach HEAD at the commit, try again with the --detach option.
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
 	test_config advice.suggestDetachingHead false &&
-	test_must_fail git switch main^{commit} 2>stderr &&
-	test_i18ngrep ! "try again with the --detach option" stderr
+	test_must_fail git switch main^{commit} 2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: a branch is expected, got commit '\''main^{commit}'\''
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'switch and detach current branch' '
