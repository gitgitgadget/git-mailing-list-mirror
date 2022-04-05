Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39636C3525B
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454279AbiDFFGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574784AbiDFAb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 20:31:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A6FDB
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:45:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m30so634640wrb.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3Zy/fobw68s/3ZdqkONqazN6xL0FxaZWj/LTV3BfGI=;
        b=GUzUNgGX6yjOfdihtQSZKGTxQ/ttRxhZFVsC7jg15inIptu5i39FaKgMwGzoDBe0E9
         qz5JMkGGw0bjfD6Z0KoKgYZxboYuIyVjnkxjaUBmgMByFx0bImC6dNeB5lGS3H0GNRHD
         3FZbyvEdIDwuJzHnAhNGD23j/1GK1J3qBv6UyMld9abZgu1FnWVfaV+g8UHv1YFS9FCO
         heAq+SNvu4VyFUpG77WRm8zXKia7AZPOvdYtxOLyEgAFp9yJSwP8AG4xPkEOkSpJPpZJ
         Lug6jZxTZZxx019PkXnFGkOssNsaCjBwNJxI795P5SI+XU8VMz2eiSd04WdtOqLDEgJb
         J0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3Zy/fobw68s/3ZdqkONqazN6xL0FxaZWj/LTV3BfGI=;
        b=TOPCwfDBim774NF2KjXa2JVwcePsfQz/ewDUJI0yvn+YW/sh8JnLbkdh/vjzfMf5Bs
         ZVURjDuFr/cznj/csLY9jOXuVtAZC7V2HTuPguWwHZKm/kxEorNPMPoWP2Bfa+xpLczH
         KkeLBBBqs+nI6kkQhIRUk/wYRlkyQjhiSiKzq7YDoi2wr5D6tHQiKCtMGfZaXNVkY9qI
         SqnwX88eLKom7XCbbF4pBuCaSBfldJWpO5HSIl8dc1Z2OPS4PSqiCKZkH/TygqAiy3fC
         QYfSAb4cRpQQXgIhvSTtc9pIENHDtMzHOv8mE1Ucf7FFXtEdzlpTYXG9D94ttCfLc4Hg
         Ozbg==
X-Gm-Message-State: AOAM532mNsKml9UQrrCSrhN5PbYsF7Gq8wLs+s7WOH8RFr+eZ7+6qDiz
        7NcJ8KcMrhgpeMR6pcWcYdE=
X-Google-Smtp-Source: ABdhPJx4fTG8SfDoa/76ezM/e9NjoaGlusAo884BIIVDG2CS1NukEWUkFt0az2ZTzOxr4ZDBYkj+ag==
X-Received: by 2002:a05:6000:1545:b0:205:a82d:8007 with SMTP id 5-20020a056000154500b00205a82d8007mr4415355wry.88.1649198756324;
        Tue, 05 Apr 2022 15:45:56 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d410b000000b002060e6a02cesm7574676wrp.13.2022.04.05.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:45:56 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     matthieu.moy@univ-lyon1.fr
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Subject: [PATCH V1 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Wed,  6 Apr 2022 00:45:02 +0200
Message-Id: <20220405224502.38544-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405224502.38544-1-cogoni.guillaume@gmail.com>
References: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
 <20220405224502.38544-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The externalConsole=true setting is broken for many users (launching the
debugger with such setting results in VS Code waiting forever without
actually starting the debugger). Also, this setting is a matter of user
preference, and is arguably better set in a "launch" section in the
user-wide settings.json than hardcoded in our script. Remove the line to
use VS Code's default, or the user's setting.

Add useful links in contrib/vscode/README.md to help the user to
configure VS Code and how to use the debugging feature.

Add a mention to the README and the init.sh in Documentation/MyFirstContribution.txt
and a part to convince a newcomer that VS Code can help him.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Helped-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/MyFirstContribution.txt | 11 +++++++++++
 contrib/vscode/README.md              |  6 +++++-
 contrib/vscode/init.sh                |  1 -
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 63a2ef5449..7f48990cb8 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1265,3 +1265,14 @@ against the appropriate GitGitGadget/Git branch.
 If you're using `git send-email`, you can use it the same way as before, but you
 should generate your diffs from `<topic>..<mybranch>` and base your work on
 `<topic>` instead of `master`.
+
+[[Bonus-useful-tools]]
+== Bonus - useful tools
+
+=== VS Code
+
+Using the integrate debugger can be particularly helpful to understand how Git works internally.
+It can be used to isolate some parts of code, with this you may be able to ask more precises
+question when you are stuck. (See getting-help sections).
+A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
+and explanation of how to use the script are available in contrib/vscode/README.md.
diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
index 8202d62035..f383c95e1f 100644
--- a/contrib/vscode/README.md
+++ b/contrib/vscode/README.md
@@ -6,7 +6,11 @@ code editor which runs on your desktop and is available for
 [Windows](https://code.visualstudio.com/docs/setup/windows),
 [macOS](https://code.visualstudio.com/docs/setup/mac) and
 [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
-it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
+it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools) with
+[debugging support](https://code.visualstudio.com/docs/editor/debugging)
+
+To get help about "how to personalize your settings" read:
+[How to set up your settings](https://code.visualstudio.com/docs/getstarted/settings)
 
 To start developing Git with VS Code, simply run the Unix shell script called
 `init.sh` in this directory, which creates the configuration files in
diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 27de94994b..f139fd8644 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
             "stopAtEntry": false,
             "cwd": "\${workspaceFolder}",
             "environment": [],
-            "externalConsole": true,
             "MIMode": "gdb",
             "miDebuggerPath": "$GDBPATH",
             "setupCommands": [
-- 
2.25.1

