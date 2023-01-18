Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05237C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 15:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjARP4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjARP4O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 10:56:14 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0C54217
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:51:45 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id v81so16610911vkv.5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/csYEKK3DOW+VP7DkXCnERSululrChPuQ8XhJvomzk=;
        b=G2oaNE/3BxJOJhhNRDeibkgLbmOY1ObMVBWeHrw0PdODiItPBwyjL1Xn2XJ0stdwDS
         CpukcSsGqcN3sexeu5i7PyLmNTmnKNCBNS+ZZ4upaAmp1p2H3DDRbKtmKghGUUU5347V
         w4HV9bqZKcL1Bj2ow7SWXIFbrBdV+BwZMS/MH2///0ikdf/wli8ZMdgSp0pYLi1NPxX0
         bIwUBN3BJNY26rqhY/6/fOauD0g7L0xFOftFzfykmJu3TidtCEvlGdUv3tn46heNMhzk
         zIJlZts1QotlPdQIO4PWIf7x8cLY5NpMl41Gbp7yI4SC+g7YirGumpE2E0CaPMxHcy/4
         APUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/csYEKK3DOW+VP7DkXCnERSululrChPuQ8XhJvomzk=;
        b=ZifbPFNFQbT4anJ8SX7s5kIfmwNeej89ik7kHwtET/Kf1ml6K+wSm9mYedbwWF3MFz
         HKwoFLDdBWjZcDQ4APCAap1T8kVHuMEr7gs9/HHDd/15rAzdAK5WYKVlQpvuA1RAIXGg
         nMbVLm8pG8DCPk8SGYZiVohzVyfXDBbNB7sAYopUGtxXT6QZlzJ+HHby74G1yULty39a
         talLMO9EfNyw1IimHHx4PBHSClmszmBTmKxoatXgJTycCGZHsJafjViYO3foJlUaZSKY
         82meuCMleyxdROmbNABFgyWKOMrhBxPJXhrguG55AuMBjN+BpEhZ0z5jCpoMps9Fb/70
         q/wQ==
X-Gm-Message-State: AFqh2kq38+6n5SCOLLVN8BTeUtoXxWn9T35Atk10Ilyn3oz+mbDS7ki8
        YAZVYp3j0Hk0N+s106v/w+mzjNcn+LBfQqY=
X-Google-Smtp-Source: AMrXdXsJQhxOLhnPVAwD1aYFzrTBuykLgXqA6bKlxJmX3K0pqOigH80GwnFyJ33B7tdnJkuin0VFzQ==
X-Received: by 2002:a05:6122:9a1:b0:3dd:fcfe:192d with SMTP id g33-20020a05612209a100b003ddfcfe192dmr5776968vkd.3.1674057104698;
        Wed, 18 Jan 2023 07:51:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1543:36d:dc9e:b94? ([2600:1700:e72:80a0:1543:36d:dc9e:b94])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a444600b00706719da000sm6013686qkp.103.2023.01.18.07.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:51:44 -0800 (PST)
Message-ID: <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
Date:   Wed, 18 Jan 2023 10:51:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible,
 but not enforced
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2023 5:02 PM, Philippe Blain wrote:
> Hi Elijah and Stolee,
> 
> First, Stolee, thanks a lot for adding '--update-refs', it is very useful (I've
> added it to my config so I don't forget to use it).

I'm glad you're using it, and thanks for the report!
 
> I recently learned that 'git rebase --whitespace=fix' exists, which is also
> great but since it uses the apply backend, it can't be used with --update-refs.
> I understand this, and the fact that adding '--whitespace=fix' to the merge
> backend would be a big task; this is not what this email is about.

I also use --whitespace=fix, and am disappointed that it doesn't work with
--update-refs. I guess I just haven't used it in my workflows that depend on
--update-refs.

> I think there is a bug in that the code does not enforce the fact that
> both options can't be used together.  Whenever '--whitespace' or '-C' are used,
> the code defaults to the apply backend:
...
> but 'is_merge' only checks if 'opts->type == REBASE_MERGE', so the check only
> works if --merge was given explicitely, but not when none of '--merge' or '--apply' 
> were given (and so the default "merge" backend is used).
> 
> I would have expected the code to die telling me --update-refs and --whitespace
> are incompatible. But instead it defaulted to --apply, and (of course) did not
> update the refs in my history (which I found out later). 

Yes, I agree that there should be an error message (and a die(), not just a
warning). I quickly whipped up the patch below, which should resolve your
concern.

Note that I was a bit worried about users with the config option and not
just those that specify the option over the command-line. I put in an extra
warning for those users, but I could see the community wanting different
behavior there.

Let me know what you think. If we need a new version, I'll create a new
thread for that review.

Thanks,
-Stolee

--- >8 ---
From fe310b37796b0b15554481eb1cfa3942a9200b4b Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Wed, 18 Jan 2023 10:38:18 -0500
Subject: [PATCH] rebase: die for both --apply and --update-refs

The --apply backend is not compatible with the --update-refs option,
which requires the interactive backend. Without any warning, users
running 'git rebase --whitespace=fix' with --update-refs (or
rebase.updateRefs=true in their config) will realize that their non-HEAD
branches did not come along for the ride.

Fix this with a die() message in the presence of both options. Since we
cannot distinguish between the --update-refs option and the config
option at this point, do an extra check to see if --update-refs was
implied by the config and present a helpful warning to use
--no-update-refs.

It is possible that users might want to be able to use options such as
--whitespace=fix with rebase.updateRefs=true in their config without
explicitly adding --no-update-refs. However, it is probably safest to
require them to explicitly opt-in to that behavior. Users with the
config option likely expect that their refs will be automatically
updated and this will help warn them that the action they are doing is
likely destructive to their branch organization.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rebase.c              | 21 +++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..5330258c865 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1247,6 +1247,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
+	/* Check for arguments that imply --apply before checking --apply itself. */
+	if (options.update_refs) {
+		const char *incompatible = NULL;
+		if (options.git_am_opts.nr)
+			incompatible = options.git_am_opts.v[0];
+		else if (options.type == REBASE_APPLY)
+			incompatible = "--apply";
+
+		if (incompatible) {
+			int from_config = 0;
+			if (!git_config_get_bool("rebase.updaterefs", &from_config) &&
+			    from_config) {
+				warning(_("you have 'rebase.updateRefs' enabled in your config, "
+					  "but it is incompatible with one or more options;"));
+				warning(_("run again with '--no-update-refs' to resolve the issue"));
+			}
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--upate-refs", incompatible);
+		}
+	}
+
 	if (trace2_is_enabled()) {
 		if (is_merge(&options))
 			trace2_cmd_mode("interactive");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 462cefd25df..8681c8a07f8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2123,6 +2123,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_cmp expect err.trimmed
 '
 
+test_expect_success '--apply options are incompatible with --update-refs' '
+	for opt in "--whitespace=fix" "-C1" "--apply"
+	do
+		test_must_fail git rebase "$opt" --update-refs HEAD~1 2>err &&
+		grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
+
+		test_must_fail git -c rebase.updateRefs=true rebase "$opt" HEAD~1 2>err &&
+		grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
+		grep "you have '\''rebase.updateRefs'\'' enabled" err || return 1
+	done
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.39.1.vfs.0.0


