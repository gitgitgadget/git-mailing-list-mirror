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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A93C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84607610FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbhIMTto (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbhIMTto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:49:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F7C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:48:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s13-20020a17090a760d00b001996da9681dso584414pjk.9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Pk85v3T5/OuwDc34QcIjFDBDtFCEOnykhjNUwDDtSgM=;
        b=EJJ+3hfG3bxX/RMCAkBnuyrpnpPLrmAIa84ny/V3+9cb3uqL21lnAlfzqn0RuzeE94
         jue0udRXTcQsbXlblEUuvJqQ8kGVtTUVcYabBzui0iVa0eBiASDC08hxC3WTTQ1GLKXl
         2WQzpQzp8toxtefHTWWu5ZJSgNs0uYf9tOzrwvXyzQtqNTPqQ8tAdN38idluLKk2ZDiW
         SMiIZY/A1CknoeC7Bo6Z//CPUm7Op+H/UlC747et4Apnmbdurxq8DYNJ3Uc6F7Xj9IN4
         +zBc8ngv2LLm4/XfMEP/ch+xYMMxLNz/1Pq0pxFfH754Rs/2NXfY9zsWpY4+EV/Vl4Eg
         pUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Pk85v3T5/OuwDc34QcIjFDBDtFCEOnykhjNUwDDtSgM=;
        b=wJ3hggekanC45kC6plOPsS6TL5Vix5KiOHS7K4PQSgNK0NBI0Zvbe/uumTP4W89Dhn
         THMjuBDWGJ/yVpQUxyM1NRlRA0VBARzLLqyZ0PaqO5N+F3ZAySZ0UFkTcizTEC7GkVNl
         nwvE2/5ylGoyTki61odRgTQASPEiAq6T46tO+7np+8ksBAbcNeZvcadXejKIPbJA84PN
         RdWKvhtFtVAblv6lJSsKDZtd4yHa6aXtmva8dxMQIwuhmeVknx+bpmUPKlxQU7CGB3+E
         bn3iXYXHog06O8JGOhNVC0b2V6oyVd40/b9iIn8ikMBzXObvKy4fMdSBAlETxvN3oS6s
         wbNQ==
X-Gm-Message-State: AOAM533mSW3e8M8JUSUP70TqZ7OrtXmB+Eoy8pyJu4F+stHgrCCMPkHa
        d5vsgOPyq7yRL3xb/HBqSpZGmfat7cWPorvIrcj8fUBvMV4jNBTdqSfHMCNq/5d0gYikV7665e2
        wT038zNIoVBklt497VrCpXnMpUm502xQCIvqoijotg0qFE0nRQwokI+wzQZ/1hIg=
X-Google-Smtp-Source: ABdhPJyLIULiwAF6AtEYAbXdXztsPumnsz38faKN+j+cG2pbqg09ezWy6IgpjDuiVIYPKWHYCJcifzPEIJiYog==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP
 id e22-20020a62ee160000b02902feffcf775amr1086814pfi.59.1631562505787; Mon, 13
 Sep 2021 12:48:25 -0700 (PDT)
Date:   Mon, 13 Sep 2021 12:48:16 -0700
Message-Id: <20210913194816.51182-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "Sending V2" section, readers are directed to create v2 patches
without using --range-diff. However, it is custom to include a range
diff against the v1 patches as a reviewer aid.

Update the "Sending V2" section to include the --range-diff option. Also
include some explanation for -v2 and --range-diff to help the reader
understand the importance.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/MyFirstContribution.txt | 29 ++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 015cf24631..add1c2bba9 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1033,18 +1033,33 @@ Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
 handle comments from reviewers. Continue this section when your topic branch is
 shaped the way you want it to look for your patchset v2.
 
-When you're ready with the next iteration of your patch, the process is fairly
-similar.
+Let's write v2 as its own topic branch, because this will make some things more
+convenient later on. Create the `psuh-v2` branch like so:
 
-First, generate your v2 patches again:
+----
+$ git checkout -b psuh-v2 psuh
+----
+
+When you're ready with the next iteration of your patch, the process is fairly
+similar to before. Generate your patches again, but with some new flags:
 
 ----
-$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
+$ git format-patch -v2 --range-diff psuh..psuh-v2 --cover-letter -o psuh/ master..psuh
 ----
 
-This will add your v2 patches, all named like `v2-000n-my-commit-subject.patch`,
-to the `psuh/` directory. You may notice that they are sitting alongside the v1
-patches; that's fine, but be careful when you are ready to send them.
+The `--range-diff psuh..psuh-v2` parameter tells `format-patch` to include a
+range diff between `psuh` and `psuh-v2`. This helps tell reviewers about the
+differences between your v1 and v2 patches.
+
+The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
+you may notice that your v2 patches, are all named like
+`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
+prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
+be prefaced with "Range-diff against v1".
+
+Afer you run this command, `format-patch` will output the patches to the `psuh/`
+directory, alongside the v1 patches. That's fine, but be careful when you are
+ready to send them.
 
 Edit your cover letter again. Now is a good time to mention what's different
 between your last version and now, if it's something significant. You do not
-- 
2.33.0.309.g3052b89438-goog

