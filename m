Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABDC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 23:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiDFXmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiDFXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 19:41:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D218D2B5
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 16:39:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so4627023wms.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9mxCO+nTrBVFUUaeU9ooUxL6nnknoJWyw+lOLzt2QaI=;
        b=WBKeSec8Y7kvXSLnVdtWrOLewShvPSTtPgmfbICgkh626wYoxXbOqVo8zi31lUsak/
         89Nr8cHhB6DjxYyH+OugyXnVO2HqYyeqyjUVlJke1a87EU1z1JUrC/LKE2wXOWuHMjO3
         Yg2wVlZm2EMpThV/ppUEuA2+2wggsM2pdUhXtDUwhfhIa9k0DhGWXAnU4RYajvBAST1F
         ViZ9UnjvqviCyaNc4Rh6DuoHrZ4jJb9aYwUqE8kOE3akPnXCxO4x4TZhvKs25BXHZGfF
         jjteFoQMu+/BW1qwh/gPaWwNzKV9teqNg5eTBSj9vnj1LqIqetT9WCXL3GQ85m26lkkT
         YFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mxCO+nTrBVFUUaeU9ooUxL6nnknoJWyw+lOLzt2QaI=;
        b=xQWVdvLtjGOPwbIw5Tm6xmQgzsyoIOm+GQ85uKM15PpqVMmlDlkO2R+/LqiIlj/4Qa
         4qsMYNRmzajYb3g/dEUjYWqd+I6PDCZTquuoUHWXqCHvA2/pJ/85osdXH+ygAEUszeoO
         JPSz5ahZN0L1VZuP+6+GCOOXQ3kV/J7S566jexM8yRsNLhyQTpghKQTnJBYFP1ZpQR/q
         +ylXoH8StHhsd2+Wc22rbGDrCRvCgU6Hg42+zcWeD/ovF4eprYXXLMhu3dPRS7WuYDAk
         yjQ4UZsX6Wblhq6RKsSsPfGLQWxU3rsm85XlvOr4aH5/QwCElIM30gFl4nbV6iVCR643
         QeFA==
X-Gm-Message-State: AOAM533akDEzu1pIIu6gvIEOGGy9X6vpoWXBQ0+hcDgx426hkPHZPaYj
        SPsJZmF+kuu0QVchCaS9AtaSyW4TRM1n4iYv
X-Google-Smtp-Source: ABdhPJyPA24k0hisQUM5Bme8E8SeIiv47d/jqPwkZTt8kriVGWWrtdSBbscew5EnAsCHMn62RCAzJA==
X-Received: by 2002:a05:600c:2041:b0:38e:7627:e9b3 with SMTP id p1-20020a05600c204100b0038e7627e9b3mr9371024wmg.76.1649288393794;
        Wed, 06 Apr 2022 16:39:53 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id y11-20020a056000168b00b002041af9a73fsm17928848wrd.84.2022.04.06.16.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:39:53 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, avarab@gmail.com,
        cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 0/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Thu,  7 Apr 2022 01:39:45 +0200
Message-Id: <20220406233946.45778-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqbkxex8oy.fsf@gitster.g>
References: <xmqqbkxex8oy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2022 18:03 PM, Derrick Stolee wrote:

> Sorry for not getting to this in v1.

No problem, I take this opportunity to get a better view of the review 
process.

> Thanks for working on this!

Thanks for your help and reviewing.


COGONI Guillaume (1):
  contrib/vscode/: debugging with VS Code and gdb

 Documentation/MyFirstContribution.txt | 20 ++++++++++++++++++++
 contrib/vscode/README.md              |  6 +++++-
 contrib/vscode/init.sh                |  1 -
 3 files changed, 25 insertions(+), 2 deletions(-)

Diff-intervalle between v2 and v3 :
1:  367a478855 ! 1:  0600ab64f8 contrib/vscode/: debugging with VS Code and gdb
@@ Commit message
     MyFirstContribution.txt and a part to convince a newcomer that VS Code
     can be helpful.
     
-    Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
-    Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
     Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
     Helped-by: Derrick Stolee <derrickstolee@github.com>
+    Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
+    Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
     
     ## Documentation/MyFirstContribution.txt ##
     @@ Documentation/MyFirstContribution.txt: against the appropriate GitGitGadget/Git branch.
@@ Documentation/MyFirstContribution.txt: against the appropriate GitGitGadget/Git
+[[Bonus-useful-tools]]
+== Bonus - useful tools
+
-+=== VS Code
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
-A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
-and explanation of how to use the script are available in contrib/vscode/README.md.
-Using the integrate debugger can be particularly helpful to understand how Git works internally.
-It can be used to isolate some parts of code, with this you may be able to ask more precises
-question when you are stuck. (See getting-help sections).
- \ No newline at end of file
+In sum, using the built-in debugger can be particularly helpful to understand
+how Git works internally.
+It can be used to isolate certain parts of code, with this you may be able to ask
+more precises question when you are stuck. (See getting-help sections).
     
     ## contrib/vscode/README.md ##
     @@ contrib/vscode/README.md: code editor which runs on your desktop and is available for
-- 
2.25.1

