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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE466109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhIVUYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhIVUYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:24:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76923C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:22:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z8-20020a17090acb0800b001996f635e3bso2514553pjt.6
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2gv+81xAEbA/4diICeUP3Q1pQBmqdk/oSUqsKoanc4M=;
        b=MuxNqtPsozzgUHpUHjSC5IqIJxsutVTe6m83cCzx7jSgWPKVuEFt2aOgjurL89atPM
         eRcQ1loXiNYwn20tBuBm1Wef2bVKtpFCeCiGObDzbL0kvgmPJSxuUgCu8XMR+4LvKQSH
         LBbUPc2TztwCeBdyPu9VWKbr0aPduiFtrmlRzZIJwobt/mCCKCd9vdKmPgBjAqxc4wBp
         5N46tq2F+a6LjroSy54jnSrq9RD7NuzatKdOTrriVOUUn1pNWcP3u0nlYmR3HQb8Prhd
         nbq2xVHR5VqhNNiZJQXgttutqhJuIDseNwT0A8NR0woacCyVpkefX1xH3+RsyAxj9Qph
         ch+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2gv+81xAEbA/4diICeUP3Q1pQBmqdk/oSUqsKoanc4M=;
        b=cl+yDn4MwCZATDy7kzQOpDPIo8hBE7LBLmRDVLE7u/RT45jbUCspX5FWDsUQlyIhF6
         HVb3toCkqMKn0VdkGGQuae/qJXzDQROiXJ93HG3OLSx9/vLZwLKPn0i6sAaLREmjQxyv
         oOR8mTUJw9M2zkKrKUjUPPMT5KXyM3fzL+vgo59hBRHJd/jCUtGO1V7uPGokscD8wle/
         MMokGjJGrF4mS5KxLcJ4fbvnJedtok49LPnFRkF1UOXYlYseiHWWiTw4RX5+rexF6tf4
         VjlpTo/mrQtFdkLlthvO1xsgM+PF4xl0dhNfJuFadc488wtlmKkUIXf0W6PMYTPuyxFn
         /VpQ==
X-Gm-Message-State: AOAM531ip4DRfLms4AYsaW9lf/CIoudq+qLxROD3mcMbge1lSaGjgmz2
        awpWDCahm0o6jE3XzJaOormEePpkbgsblEXaLSaEGLc4pY+ngVKbqBB4w69suXJyhfTkuXr8pdL
        YJMBMotqWi0sbwUGOCIKZMaZi/sbe8DF3KueMdWDfh6peHu709EZcDQAmpZ3n5CM=
X-Google-Smtp-Source: ABdhPJwjYa9Bm6wY+nN+RiTZ02Q2Xj/QsI0+wa36lJAjTI6Ou9qz+6ehLBu7Vef6pkB5Q646slLcobDsg/88Ww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c412:b0:13d:b4f8:7614 with SMTP
 id k18-20020a170902c41200b0013db4f87614mr595171plk.57.1632342149808; Wed, 22
 Sep 2021 13:22:29 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:22:18 -0700
In-Reply-To: <20210920223226.25877-1-chooglen@google.com>
Message-Id: <20210922202218.7986-1-chooglen@google.com>
Mime-Version: 1.0
References: <20210920223226.25877-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3] MyFirstContribution: Document --range-diff option when
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
This tightens up some of the language from v2, but is otherwise largely
similar. As always, thanks for the input!

Changes since v2:
* clarify that the range-diff is inserted into the cover letter
* describe -v2 as creating version "2" instead of "v2"
* fix typo in email prefix (s/V2/v2)
* explicitly compare the v2 glob pattern with the v1 glob pattern

Interdiff against v2:
  diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
  index 790bf1e8b5..b20bc8e914 100644
  --- a/Documentation/MyFirstContribution.txt
  +++ b/Documentation/MyFirstContribution.txt
  @@ -1041,8 +1041,8 @@ $ git checkout psuh
   $ git branch psuh-v1
   ----
   
  -Make your changes with `git rebase -i`. Once you're ready with the next
  -iteration of your patch, the process is fairly similar to before. Generate your
  +Refine your patch series by using `git rebase -i` to adjust commits based upon
  +reviewer comments. Once the patch series is ready for submission, generate your
   patches again, but with some new flags:
   
   ----
  @@ -1050,20 +1050,21 @@ $ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 mast
   ----
   
   The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
  -range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
  -helps tell reviewers about the differences between your v1 and v2 patches.
  +range-diff between `psuh-v1` and `psuh` in the cover letter (see
  +linkgit:git-range-diff[1]). This helps tell reviewers about the differences
  +between your v1 and v2 patches.
   
  -The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
  -you may notice that your v2 patches, are all named like
  -`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
  -prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
  -be prefaced with "Range-diff against v1".
  +The `-v2` parameter tells `format-patch` to output your patches
  +as version "2". For instance, you may notice that your v2 patches are
  +all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
  +your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
  +and your range-diff will be prefaced with "Range-diff against v1".
   
   Afer you run this command, `format-patch` will output the patches to the `psuh/`
   directory, alongside the v1 patches. Using a single directory makes it easy to
   refer to the old v1 patches while proofreading the v2 patches, but you will need
   to be careful to send out only the v2 patches. We will use a pattern like
  -"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
  +"psuh/v2-*.patch" (not "psuh/*.patch", which would match v1 and v2 patches).
   
   Edit your cover letter again. Now is a good time to mention what's different
   between your last version and now, if it's something significant. You do not

 Documentation/MyFirstContribution.txt | 42 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 015cf24631..b20bc8e914 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1029,22 +1029,42 @@ kidding - be patient!)
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
+Refine your patch series by using `git rebase -i` to adjust commits based upon
+reviewer comments. Once the patch series is ready for submission, generate your
+patches again, but with some new flags:
 
 ----
-$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
+$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
 ----
 
-This will add your v2 patches, all named like `v2-000n-my-commit-subject.patch`,
-to the `psuh/` directory. You may notice that they are sitting alongside the v1
-patches; that's fine, but be careful when you are ready to send them.
+The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
+range-diff between `psuh-v1` and `psuh` in the cover letter (see
+linkgit:git-range-diff[1]). This helps tell reviewers about the differences
+between your v1 and v2 patches.
+
+The `-v2` parameter tells `format-patch` to output your patches
+as version "2". For instance, you may notice that your v2 patches are
+all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
+your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
+and your range-diff will be prefaced with "Range-diff against v1".
+
+Afer you run this command, `format-patch` will output the patches to the `psuh/`
+directory, alongside the v1 patches. Using a single directory makes it easy to
+refer to the old v1 patches while proofreading the v2 patches, but you will need
+to be careful to send out only the v2 patches. We will use a pattern like
+"psuh/v2-*.patch" (not "psuh/*.patch", which would match v1 and v2 patches).
 
 Edit your cover letter again. Now is a good time to mention what's different
 between your last version and now, if it's something significant. You do not
@@ -1082,7 +1102,7 @@ to the command:
 ----
 $ git send-email --to=target@example.com
 		 --in-reply-to="<foo.12345.author@example.com>"
-		 psuh/v2*
+		 psuh/v2-*.patch
 ----
 
 [[single-patch]]
-- 
2.33.0.464.g1972c5931b-goog

