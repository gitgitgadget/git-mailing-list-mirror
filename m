Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91400C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 23:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiDFXmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiDFXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 19:41:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517553A5FF
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 16:39:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35so2461831wms.5
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spkn4NkGtMIEpAA4oa/L5oZVBfjyEA4QnqWbw5i0FJA=;
        b=gbl7GpzwIIO+zZ3BpjYxwAy/nJ25DFMSyeY97pkfbU9B+SEbK7S0YaPXraJS/RUQra
         OIB4bjfYk5kehvVwsRY9vE23VbtoLCpSFh4FS+u0w7A0EgiVjmKm/H4rrqxe9L7yTgOL
         IXCUx09H3Dr7cah5n++VHwuv8A3bIFBWdlShaIECEaA9D5fparjSmKeOmsUo2bnb1Aob
         j7mLYG8BmNu9wOFQqIaqq2iDwgQDqR0MTyfhrU/7z3BazQPCJ5phL/Hsg8sbR4hnQ9/i
         4k1j8TUARlB4flxF/tFVDBfr6LVHdeKYpXkDUeQuH8nYkn4W7uffB4HnCFhZivfiUrQ+
         MQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spkn4NkGtMIEpAA4oa/L5oZVBfjyEA4QnqWbw5i0FJA=;
        b=WNSPaK8n30jb6nJAKXIlJ8+1QCmFTTPhFy+4y6ardO4GlXiFdgEt+84K/jVnuh3NKR
         EEq7I1qxsaal487/MVxD95PGYWrX7xzLzpeVhkyh1OtxlVGLXSilhmiTH2cOFejE1rQk
         5lurb3YjR3A0+aaakI43wtyLPUxF/uoTOmJ/yVASHp9lSDDDXhDRYPhnfv2bkU+mdRc5
         9FwD0nvsW2C3nVD7fg/ZijX+pwGNgxDaDJViyZ2d3OUxgDxnbKT/WCN3erQ8zS/jIZcF
         QTTvUVmfkZvR9GOzgfI95V5dMZfpV3GT3HzMAki4JqE0Hpc4H5ghuSl3UX0UuoyjnaPZ
         48Jw==
X-Gm-Message-State: AOAM532W57jb9XauQLnrer7M7/JHQqSyXVTCXv90+G7ZMOP4dVwgBRnj
        0Lt7CN0YSFR/CpmsqGfPWNY=
X-Google-Smtp-Source: ABdhPJyuWWL2tOv8t/pB+WVIlyIog8ML7KgP+/3rbrpxhdlzN52P72aEpLTCys5PEF6sXZRYWRjoRg==
X-Received: by 2002:a05:600c:4f86:b0:38c:bd13:e074 with SMTP id n6-20020a05600c4f8600b0038cbd13e074mr9683429wmq.97.1649288395918;
        Wed, 06 Apr 2022 16:39:55 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id y11-20020a056000168b00b002041af9a73fsm17928848wrd.84.2022.04.06.16.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:39:55 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, avarab@gmail.com,
        cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Thu,  7 Apr 2022 01:39:46 +0200
Message-Id: <20220406233946.45778-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406233946.45778-1-cogoni.guillaume@gmail.com>
References: <xmqqbkxex8oy.fsf@gitster.g>
 <20220406233946.45778-1-cogoni.guillaume@gmail.com>
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

Add a mention to the README and the init.sh in Documentation/
MyFirstContribution.txt and a part to convince a newcomer that VS Code
can be helpful.

Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/MyFirstContribution.txt | 20 ++++++++++++++++++++
 contrib/vscode/README.md              |  6 +++++-
 contrib/vscode/init.sh                |  1 -
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 63a2ef5449..fc53456527 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1265,3 +1265,23 @@ against the appropriate GitGitGadget/Git branch.
 If you're using `git send-email`, you can use it the same way as before, but you
 should generate your diffs from `<topic>..<mybranch>` and base your work on
 `<topic>` instead of `master`.
+
+[[Bonus-useful-tools]]
+== Bonus - useful tools
+
+=== Visual Studio Code (VS Code)
+
+The contrib/vscode/init.sh script creates configuration files that enable
+several valuable VS Code features. See contrib/vscode/README.md for more
+information on using the script.
+
+In particular, this script enables using the VS Code visual debugger, including
+setting breakpoints, logpoints, conditional breakpoints in the editor.
+In addition, it includes the ability to see the call stack, the line of code that
+is executing and more. It is possible to visualize the variables and their values
+and change them during execution.
+
+In sum, using the built-in debugger can be particularly helpful to understand
+how Git works internally.
+It can be used to isolate certain parts of code, with this you may be able to ask
+more precises question when you are stuck. (See getting-help sections).
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

