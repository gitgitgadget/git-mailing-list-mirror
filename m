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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE0C4321E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49886134F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbhIUCWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhIUBvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:17 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBA1C0AEFB0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:32:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a188-20020a627fc5000000b004446be17615so9210032pfd.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m5/0aib0VfCd2ry3MlB2luUXQXjF0cLkXBmpnREix24=;
        b=UnuPIrCcdnyBWeBtGrxy3/zv4RbXpWbLVsRvgp1A0HDBQWojpv7IpcJGtB8XWfd7J7
         E3fa4+nlL0dqetT+KheM4zQycPlsz8vIR7K435A59HfkDPMce4TLquXvW09UYTBAltAU
         /RtNApmjGHVYh3I9UQ4H+M2t1JODxj5u803thK+i+/YVDmrR7PeyiSuLfS6QbEO4TG9Y
         nyAbMpLoq69lWlAi/ERlKH9qfZzj0mgUNDoa6EnMvi4QuIpQh5jNMsQIbc32Fjbfp+Ho
         KUNKLWUm/UqIYBx7h8qbu/BuKwQEGr4+7pRqIW96Ovfr+LdS9HTsbdvIaGdWazzikwXB
         WImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m5/0aib0VfCd2ry3MlB2luUXQXjF0cLkXBmpnREix24=;
        b=aME8Z5he6/2Znz1Oydr0bYszWEqdIsktC2J1DO12P+m5c7xSfIy/HbZ2mZc/vmpbmp
         cu1PNPO6zsucFsjCEZwh56BWNksCvU82KAtaOt3/c/vJAYZjXapBb+QGEy77oRJop/Qj
         QXUJkdx6IHe8G2Rmy8184SuLkEQ707a/bT3kEXj8BKwaOHowIkW0jOLkuAa7yk+pU99C
         XoU4QRzWvBTUd5aaOhh1MVAR5uJThlFlYAlW+PyXWJufbW4ZRzOlOJD5I4BNoTUmtycl
         /l2e+L84zS/KeTsQ604Eom9r/Bztvuv/pqTpMRmNou06+gKyIHj7wFMmI9ibfEhQu3Wj
         /CBw==
X-Gm-Message-State: AOAM532EFKbgB7avG1vVpamBoBqwWbebwG50j3ME+zD+PQoXO/8h/c8V
        dPuvdRDPl6VIWEroybap0GBfd17aRZQSMZyzMARpe1mw/1Qxgi2Xfs0O5Lub1z6ZyRrZKfhpmhT
        pEAFPhzJMkYfLbPUM2ejRkTwzV2B61nY8/eCUAE1WjEhJvAfesznKJeAdzHroR78=
X-Google-Smtp-Source: ABdhPJwWm2P0E6nhWTRYGNvEtz4vfiP8UqRQWeutM2M1Jl4Kq23a/XyV94fktl3s9PnkxDbvfZFy/YKwPM44oQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7d0f:: with SMTP id
 y15mr25485678pgc.446.1632177158959; Mon, 20 Sep 2021 15:32:38 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:32:26 -0700
In-Reply-To: <20210913194816.51182-1-chooglen@google.com>
Message-Id: <20210920223226.25877-1-chooglen@google.com>
Mime-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "Sending v2" section, readers are directed to create v2 patches
without using --range-diff. However, it is customary to include a
range-diff against the v1 patches as a reviewer aid.

Update the "Sending v2" section to suggest a simple workflow that uses
the --range-diff option. Also include some explanation for -v2 and
--range-diff to help the reader understand the importance.

Signed-off-by: Glen Choo <chooglen@google.com>
---
Thanks for the helpful comments on v1! v2 aims to clear up other
ambiguities from v1 and to propose a specific workflow for readers.

Changes since v1:

* recommend that readers reuse the `psuh` topic branch for v2
* recommend that readers mark their v1 topic branch
* add a link to the range-diff docs
* change the v2 glob pattern to `psuh/v2-*.patch` to match the v1 example
* explicitly call out the v2 glob pattern so that readers will be extra
  careful

Interdiff against v1:
  diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
  index add1c2bba9..790bf1e8b5 100644
  --- a/Documentation/MyFirstContribution.txt
  +++ b/Documentation/MyFirstContribution.txt
  @@ -1029,27 +1029,29 @@ kidding - be patient!)
   [[v2-git-send-email]]
   === Sending v2
   
  -Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
  -handle comments from reviewers. Continue this section when your topic branch is
  -shaped the way you want it to look for your patchset v2.
  +This section will focus on how to send a v2 of your patchset. To learn what
  +should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
  +information on how to handle comments from reviewers.
   
  -Let's write v2 as its own topic branch, because this will make some things more
  -convenient later on. Create the `psuh-v2` branch like so:
  +We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
  +mark the tip of our v1 branch for easy reference:
   
   ----
  -$ git checkout -b psuh-v2 psuh
  +$ git checkout psuh
  +$ git branch psuh-v1
   ----
   
  -When you're ready with the next iteration of your patch, the process is fairly
  -similar to before. Generate your patches again, but with some new flags:
  +Make your changes with `git rebase -i`. Once you're ready with the next
  +iteration of your patch, the process is fairly similar to before. Generate your
  +patches again, but with some new flags:
   
   ----
  -$ git format-patch -v2 --range-diff psuh..psuh-v2 --cover-letter -o psuh/ master..psuh
  +$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
   ----
   
  -The `--range-diff psuh..psuh-v2` parameter tells `format-patch` to include a
  -range diff between `psuh` and `psuh-v2`. This helps tell reviewers about the
  -differences between your v1 and v2 patches.
  +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
  +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
  +helps tell reviewers about the differences between your v1 and v2 patches.
   
   The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
   you may notice that your v2 patches, are all named like
  @@ -1058,8 +1060,10 @@ prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
   be prefaced with "Range-diff against v1".
   
   Afer you run this command, `format-patch` will output the patches to the `psuh/`
  -directory, alongside the v1 patches. That's fine, but be careful when you are
  -ready to send them.
  +directory, alongside the v1 patches. Using a single directory makes it easy to
  +refer to the old v1 patches while proofreading the v2 patches, but you will need
  +to be careful to send out only the v2 patches. We will use a pattern like
  +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
   
   Edit your cover letter again. Now is a good time to mention what's different
   between your last version and now, if it's something significant. You do not
  @@ -1097,7 +1101,7 @@ to the command:
   ----
   $ git send-email --to=target@example.com
   		 --in-reply-to="<foo.12345.author@example.com>"
  -		 psuh/v2*
  +		 psuh/v2-*.patch
   ----
   
   [[single-patch]]

 Documentation/MyFirstContribution.txt | 41 ++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 015cf24631..790bf1e8b5 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1029,22 +1029,41 @@ kidding - be patient!)
 [[v2-git-send-email]]
 === Sending v2
 
-Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
-handle comments from reviewers. Continue this section when your topic branch is
-shaped the way you want it to look for your patchset v2.
+This section will focus on how to send a v2 of your patchset. To learn what
+should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
+information on how to handle comments from reviewers.
+
+We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
+mark the tip of our v1 branch for easy reference:
 
-When you're ready with the next iteration of your patch, the process is fairly
-similar.
+----
+$ git checkout psuh
+$ git branch psuh-v1
+----
 
-First, generate your v2 patches again:
+Make your changes with `git rebase -i`. Once you're ready with the next
+iteration of your patch, the process is fairly similar to before. Generate your
+patches again, but with some new flags:
 
 ----
-$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
+$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
 ----
 
-This will add your v2 patches, all named like `v2-000n-my-commit-subject.patch`,
-to the `psuh/` directory. You may notice that they are sitting alongside the v1
-patches; that's fine, but be careful when you are ready to send them.
+The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
+range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
+helps tell reviewers about the differences between your v1 and v2 patches.
+
+The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
+you may notice that your v2 patches, are all named like
+`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
+prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
+be prefaced with "Range-diff against v1".
+
+Afer you run this command, `format-patch` will output the patches to the `psuh/`
+directory, alongside the v1 patches. Using a single directory makes it easy to
+refer to the old v1 patches while proofreading the v2 patches, but you will need
+to be careful to send out only the v2 patches. We will use a pattern like
+"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
 
 Edit your cover letter again. Now is a good time to mention what's different
 between your last version and now, if it's something significant. You do not
@@ -1082,7 +1101,7 @@ to the command:
 ----
 $ git send-email --to=target@example.com
 		 --in-reply-to="<foo.12345.author@example.com>"
-		 psuh/v2*
+		 psuh/v2-*.patch
 ----
 
 [[single-patch]]
-- 
2.33.0.464.g1972c5931b-goog

