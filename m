Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82064C4332F
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 20:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiDLUod (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDLUo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 16:44:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1198B0A6D
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:38:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h16so12682982wmd.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaFtx2tmwtZhUrUljp1lrV+yp9A5bcjWq42Cma300pg=;
        b=HXYz9aOxHmonD2stFiHeO80upAOPsLQuD3KS/bZjfv52ki3ElrbRPcvezPxkwK7Ic1
         sIKToMvKfMF8N9rMaad8AN9E6T0gJw4e8eI2vvt8rZ/po426OboWxkieOd6uzP+bh1sI
         WeEG0GPXVn9nGJ0eHfhsL6U0aa+5xYdX7zyOm58TIatCNMgwZecHaaV1w6nuw6KiU7hv
         pKIWELuw46GkPYXEOPCgJf6lWzNwPIG4uWm/Dm0NO76FukhRBCZwWrbT/7LhF8KLE+6l
         +z6Yu8f26Gq893hwO2G89qnMtHV0FgA0uWbk9GO8xG2Z20FpDDxiff1BElNl8x657LS3
         sLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaFtx2tmwtZhUrUljp1lrV+yp9A5bcjWq42Cma300pg=;
        b=OnFq6r6S9hpVt8k/1TNVRND/hR3V26SAbF3Pkyn5BOHRIoBuyUDQUHNpWJqLW2r89Y
         8AfdtqvjZPYWkdX+dT5R9TrnkUfAR2518Dt6NkoD+uOpoM03QsFd8cGaenheywtGYiKx
         4R2uPabQh4tEv9gHwvBRPLZjRHgrq1HvHlwACSntlB6eU/ZF94tSEUGWb9Org/j1o2YU
         ONVWLMMSpRB2w+qV0Tm84Lyc+5vFP3HHV58NflCrYx/5rKkJlXMTeTw/eT71V1L7Syal
         M3cVjVriO+QIuyPQrYpZ3ZvdbN36KS1zybPa+oPZMFE3R3puuRIBaV9+vK6Oku+0c0pi
         RK/A==
X-Gm-Message-State: AOAM530opa2PcCD1507FRwIWcjngdIPuylpGBuDwTThQag0RY/gxxxdO
        Y4JiZldXnS1h0siYqLQVxZLLW/nUlIRdBnWL
X-Google-Smtp-Source: ABdhPJwxi7Clsa+CahomxTuXpqilsGpuQM2AA5CeH8FTPShVSsZEcN25H1OW/tY9L6O7ELf8k3YHEg==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr5598667wmm.17.1649795175489;
        Tue, 12 Apr 2022 13:26:15 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm29491705wrw.91.2022.04.12.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:26:15 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        derrickstolee@github.com, guillaume.cogoni@gmail.com,
        COGONI Guillaume <cogoni.guillaume@gmail.com>
Subject: [PATCH 1/1] documentation: guide of best practices for GIT developer
Date:   Tue, 12 Apr 2022 22:25:57 +0200
Message-Id: <20220412202557.32101-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412202557.32101-1-cogoni.guillaume@gmail.com>
References: <20220412202557.32101-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of this guide is to have a place where GIT developer can
share their own best practices, tools or workflows to the community in
order to help the GIT developer.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/Makefile         |  1 +
 Documentation/WorkingOnGit.txt | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/WorkingOnGit.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 44c080e3e5..82badee19a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -93,6 +93,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += WorkingOnGit
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
diff --git a/Documentation/WorkingOnGit.txt b/Documentation/WorkingOnGit.txt
new file mode 100644
index 0000000000..d324d9fcd8
--- /dev/null
+++ b/Documentation/WorkingOnGit.txt
@@ -0,0 +1,53 @@
+Guide of the best practices and custom workflow
+===============================================
+:sectanchors:
+
+[[summary]]
+== Summary
+
+This book aims to put together a lot of useful tools, best practices and
+custom workflows that might help the Git developer.
+
+[[author]]
+=== Author
+
+The Git community.
+
+[[table_of_contents]]
+== Table of contents
+
+- <<debuggers>>
+
+[[debuggers]]
+== Using debuggers
+
+You'll probably find it useful to use a debugger to interactively inspect
+your code as it's running.
+
+There's numerous such debuggers, and you may even have one installed
+already along with your development toolchain.
+
+The GNU debugger (gdb) is probably the most common one command-line
+debugger, along with the LLDB debugger (lldb):
+
+==== https://www.sourceware.org/gdb/
+==== https://lldb.llvm.org/
+
+=== GUIs
+
+==== Visual Studio Code (VS Code)
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
+more precises question when you are stuck.
-- 
2.25.1

