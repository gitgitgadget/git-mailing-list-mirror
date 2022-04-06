Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9CC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiDFRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiDFRUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:20:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB01D8AA6
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:19:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k23so3732635wrd.8
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMlYE64jwzYY8J6DbtDH8F2CRQ1ke20Hm5SduRNsK4U=;
        b=ciNJvbjvTDdbRy31Gb9q/A5BJ6DsqUcwG2ZxHq5UJAhqhkkpWUQ9W6p31iq+qT4HRG
         74V7J76Euwoe5Us0U+ksjv3PbOInz3lJnXRtXDnRyezjiN1qKdviPZOu7jmSvIjQxfeD
         iDBR9H2CR/KQm47RrrwY8Yd0Uk0VwoQm8uUoxuNbvtWpMa5Z28srIBf33XXXfkO1wopm
         sZsuaaaE6qtBdr1Rrt/XP2i0RifaKD6/UfIzcFGy8kgqWEw9UbF2XIGjiv7JfdzIegqZ
         dBNCv4mRtwrFOsb4avdDqkWvPP3QSCxkmqCkIbHmXUrpPm+BGdPhdncIxrenA05U8kpC
         ykug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMlYE64jwzYY8J6DbtDH8F2CRQ1ke20Hm5SduRNsK4U=;
        b=e/UktX08UkqZE5lMj7X2mLn2wVlNBfvw9haK5H3k4pr1HZLiAYcHB9JGu4JvMxtVnM
         Xu2eeWlJYQbAyORs7vYHOGx0JCCERbssAlw0gZfUvNbftGHpDPMNTWGfFgJHI0q/ka0l
         /fnHhYUq25wFjrVDiSHRuhjrxllvQG+IcEe92FtBuK9FVgQRzeYz6vv5ZF/oDF+t0T+k
         79n8FZyXlUdDCLSGLLF4vil+g1EvcoAopb2Qa9f4xJ0CExLCYv1nPEtwSqsFJqmjpIMu
         rfOfhZuofAjP74G7TNmR2VxukHTwhzpqOcXADMmVSlTbyUfAjSQbJI5kOmUTonLk5Svu
         oVxQ==
X-Gm-Message-State: AOAM530dcs0woRhW5lqyWKN2f5sIQYfbdAl0S02iLz5NkEufxpFGZTH2
        VCCHNy0/jiCDW8oS7bq/cCI=
X-Google-Smtp-Source: ABdhPJzWnWqezPBV5Cdhp4wTE+J8U2ErUSXnGIdlbqhwUAb/tj8I/ha6FvHWfNApxpEfH7lOf6e79Q==
X-Received: by 2002:a5d:64a7:0:b0:205:fb7a:50ee with SMTP id m7-20020a5d64a7000000b00205fb7a50eemr6973483wrp.185.1649258353624;
        Wed, 06 Apr 2022 08:19:13 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm17086490wri.52.2022.04.06.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:19:13 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
Subject: [PATCH v2 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Wed,  6 Apr 2022 17:18:58 +0200
Message-Id: <20220406151858.5047-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406151858.5047-1-cogoni.guillaume@gmail.com>
References: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
 <20220406151858.5047-1-cogoni.guillaume@gmail.com>
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
index 63a2ef5449..9cdb661271 100644
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
+A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
+and explanation of how to use the script are available in contrib/vscode/README.md.
+Using the integrate debugger can be particularly helpful to understand how Git works internally.
+It can be used to isolate some parts of code, with this you may be able to ask more precises
+question when you are stuck. (See getting-help sections).
\ No newline at end of file
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

