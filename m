Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE01C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D11E20757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2UvS+jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDIX0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:26:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50502 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIX0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 19:26:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so683506wmc.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lzASjhSGxDy1RLSxn5MSF0UgRY1oxcL58lqWffxXxt4=;
        b=i2UvS+jmI3TYvfZfkjfKDof+Ulzw7ErbWM+/eQMxXZ1Zn60trKuVJdT82cN9QMi62n
         rJkWDAiMr/MolFHMoWg7E/T0zcjVYny4Mji0DPc67fwuN32jMHDjMgxA72vO0BI/wkLA
         ai4tfB6cqtWUf77XWyAGbBIOGMVYxxvm+H57vq8b6hs3suSqmzPRIz8EZe41gEJmwRC5
         AusB+Ho0Z+QQQjgd4pJZDFkdugfUCwt51SplcKte3Z8ytxYlqrf6+IPmxWRAtjJI3tBd
         pxNgaSFgYGT58smPwceka3JBOhLL6uaZrfkU3gd0uZJn9zDHC+AWQ9INeAnrPxAM/kcx
         aaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lzASjhSGxDy1RLSxn5MSF0UgRY1oxcL58lqWffxXxt4=;
        b=ZzyFeMDNgU4mKdDOFXZrvT9JvQ+a8AeQ0j9nUnvTjxxmpPflgQ0M9dHXywLxUOAn1o
         1weAecX/h1qZcPiVpnxfe5DM1Rxn0apb4ac7VN1obV5ElDO+zFPeQ642gGni05UAMpwd
         JAJX0h4il8FfRJvIuh3PV7DJ5lxREpPsARjXV2ix7CAGQQ1BmY3hagI719roFNeVBL4u
         VqHZdlDpV6J7ukLGyc6H3DvmnTUNZTYSR92tcDLX4YFAJzeMRSNW1qdb1Dz3zL4gJtu/
         1oO2/eWXHe2F9DsDUK32DVIi76rNbANJwTdI4wfdkxgZjILJVSWchSCLEHKfjl9Pm9Wq
         UbBA==
X-Gm-Message-State: AGi0PuYaDQ/fl/q+HhEvRXIvjFm0L1W6Sjw2xbgp6MnAmmStlRf5BzWk
        /dqYMwzVWkh8by99JZEVbHgmJuA9
X-Google-Smtp-Source: APiQypKNKADay8R9P9t+IFv3cLyD+w9wc+P03sQpspkR7bIRu4zSIibCClwWdAnCyzRthaE34f34cg==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr2178886wmj.55.1586474801454;
        Thu, 09 Apr 2020 16:26:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm359550wmb.14.2020.04.09.16.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:26:40 -0700 (PDT)
Message-Id: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 23:26:39 +0000
Subject: [PATCH] rebase -i: mark commits that begin empty in todo editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While many users who intentionally create empty commits do not want them
thrown away by a rebase, there are third-party tools that generate empty
commits that a user might not want.  In the past, users have used rebase
to get rid of such commits (a side-effect of the fact that the --apply
backend is not currently capable of keeping them).  While such users
could fire up an interactive rebase and just remove the lines
corresponding to empty commits, that might be difficult if the
third-party tool generates many of them.  Simplify this task for users
by marking such lines with a suffix of " # empty" in the todo list.

Suggested-by: Sami Boukortt <sami@boukortt.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    rebase -i: mark commits that begin empty in todo editor
    
    If this isn't enough, we could talk about resurrecting --no-keep-empty
    (and making --keep-empty just exist to countermand an earlier
    --no-keep-empty), but perhaps this is good enough?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-757%2Fnewren%2Frebase-mark-empty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-757/newren/rebase-mark-empty-v1
Pull-Request: https://github.com/git/git/pull/757

 Documentation/git-rebase.txt | 3 ++-
 sequencer.c                  | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..8ab0558aca2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -620,7 +620,8 @@ commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The merge backend keeps intentionally empty commits.  Similar to the
+The merge backend keeps intentionally empty commits (though with -i
+they are marked as empty in the todo list editor).  Similar to the
 apply backend, by default the merge backend drops commits that become
 empty unless -i/--interactive is specified (in which case it stops and
 asks the user what to do).  The merge backend also has an
diff --git a/sequencer.c b/sequencer.c
index e528225e787..ce9fd27a878 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4656,6 +4656,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			strbuf_addf(&buf, "%s %s %s", cmd_pick,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
+			if (is_empty)
+				strbuf_addf(&buf, " %c empty",
+					    comment_line_char);
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -4861,6 +4864,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
+		if (is_empty)
+			strbuf_addf(out, " %c empty", comment_line_char);
 		strbuf_addch(out, '\n');
 	}
 	return 0;

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
