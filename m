Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE5C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB202166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZtKeXcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBDVcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:32:48 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33601 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDVcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:32:48 -0500
Received: by mail-wm1-f53.google.com with SMTP id m10so3096219wmc.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6FrzxH8vIvziAAtRT4rNwH4UbXJPNSD9vD8tryOHKFQ=;
        b=QZtKeXcZxutZpN6RLDaeT4PVPvYm2O2Ao8Pyf8Mt4pyZRgA3c2tVh3x5YNBds6/iky
         wIjqvgYbHzm5lBzYlu7z1Ol8a/8RqfOTSyUIEWZJTudNQBzQ2wlPma3LlHbJ20nApq/1
         UFWThgkK4zKoYegPIKzWmqjDytxjy2oDLXTrfA9iPyq+mHVr/2EFD6XbSyiRtwtecxQu
         vlnBLyaHC9GHbxrk4+TyMXeHKDLs00s1qtBww3Uc1LvM6U82avewmEpBxQUDVvWbujNa
         DDz05Co+6fAVssac4vUR53FueAMCYsvnL6kKRala32aZeHJZx2TUxM7oV1jNhrv34zCP
         QaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6FrzxH8vIvziAAtRT4rNwH4UbXJPNSD9vD8tryOHKFQ=;
        b=oR+JVVMuh095DxtFi6KRUghi4dNN76KCz5UhS9U1r1nioBv7ScrT6iBV9fQ1YIGPN8
         aIsMAcHcaVGQq8uM1vyf49MxGvzORdldqWqluXhl5h39d+DTPI0Gj1VGQPjzCs3lEiBY
         MsS59HNSZPQ4QUdrDCvof2M7VUJaTyeDD1mmnZGvrXq6rThWuiFPAt1sEoT1faKjK973
         dvnZ7ikDdRr8Ql8iT3lGuGMeO/uZZo02abjDourWWoOIxwe5/0+uFTaInV/835Mrj/db
         5F8bghUYM5Az4g+0+45Pfh7WHG+i9mN5dQMy13/PAQBlG+DHGMe4MPkvj2ptTwBrgj0H
         c5hA==
X-Gm-Message-State: APjAAAVUYxIZcYEgk1nSAlYUZtVwCxqX1zhzoIM6OLoQEgsXLn/RFyzq
        cDa+BF7dSbmSu9EYIeOkzGP0XCUZ
X-Google-Smtp-Source: APXvYqx/oSrAHDhjgVE2WAPyQ+VLTywPr83P3f2iMo8P3oKlPGoZ+Z9Fyxuopv8jrBDWp7Pdvx7PwA==
X-Received: by 2002:a1c:b4d7:: with SMTP id d206mr1022667wmf.188.1580851965011;
        Tue, 04 Feb 2020 13:32:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm31844210wrp.58.2020.02.04.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 13:32:44 -0800 (PST)
Message-Id: <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
From:   "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 21:32:42 +0000
Subject: [PATCH v2] clone: use submodules.recurse option for automatically
 clone submodules
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Markus Klein <masmiseim@gmx.de>, Markus Klein <masmiseim@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Klein <masmiseim@gmx.de>

Simplify cloning repositories with submodules when the option
submodules.recurse is set by the user. This makes it transparent to the
user if submodules are used. The user doesn’t have to know if he has to add
an extra parameter to get the full project including the used submodules.
This makes clone behave identical to other commands like fetch, pull,
checkout, ... which include the submodules automatically if this option is
set.

It is implemented analog to the pull command by using an own config
function instead of using just the default config. In contrast to the pull
command, the submodule.recurse state is saved as an array of strings as it
can take an optionally pathspec argument which describes which submodules
should be recursively initialized and cloned. To recursively initialize and
clone all submodules a pathspec of "." has to be used.
The regression test is simplified compared to the test for "git clone
--recursive" as the general functionality is already checked there.

Changes since v1:
* Fixed the commit author to match the Signed-off-by line

Signed-off-by: Markus Klein <masmiseim@gmx.de>
---
    Add the usage of the submodules.recurse parameter on clone
    
    I try to finish the pullrequest #573 from Maddimax. This adds the usage
    of the submodules.recurse parameter on clone

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-695%2FMasmiseim36%2Fdev%2FCloneWithSubmodule-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-695/Masmiseim36/dev/CloneWithSubmodule-v2
Pull-Request: https://github.com/git/git/pull/695

Range-diff vs v1:

 1:  7fa8d19faf ! 1:  c75835268a clone: use submodules.recurse option for automatically clone submodules
     @@ -1,4 +1,4 @@
     -Author: Markus <masmiseim@gmx.de>
     +Author: Markus Klein <masmiseim@gmx.de>
      
          clone: use submodules.recurse option for automatically clone submodules
      
     @@ -19,6 +19,9 @@
          The regression test is simplified compared to the test for "git clone
          --recursive" as the general functionality is already checked there.
      
     +    Changes since v1:
     +    * Fixed the commit author to match the Signed-off-by line
     +
          Signed-off-by: Markus Klein <masmiseim@gmx.de>
      
       diff --git a/builtin/clone.c b/builtin/clone.c


 builtin/clone.c              | 16 +++++++++++++++-
 t/t7407-submodule-foreach.sh | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9..21b9d927a2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -26,6 +26,8 @@
 #include "dir-iterator.h"
 #include "iterator.h"
 #include "sigchain.h"
+#include "submodule-config.h"
+#include "submodule.h"
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
@@ -929,6 +931,18 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+/**
+ * Read config variables.
+ */
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, value)) {
+		string_list_append(&option_recurse_submodules, "true");
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1103,7 +1117,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	git_config(git_clone_config, NULL);
 
 	if (option_bare) {
 		if (option_mirror)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e1..44b32f7b27 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -383,6 +383,17 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
+test_expect_success 'use "git clone" with submodule.recurse=true to checkout all submodules' '
+	git clone -c submodule.recurse=true super clone7 &&
+	(
+		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
+		cat >expect <<-EOF &&
+		.git
+		$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
+		EOF
+		test_cmp expect actual
+	)
+'
 
 test_expect_success 'command passed to foreach retains notion of stdin' '
 	(

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
