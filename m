Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D04C35276
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454808AbiDFFHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573336AbiDFAb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 20:31:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC8C1A07D
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:45:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w21so630005wra.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKGw/McyyAOgqygGUIhrMWmmxcwz5Al/B7a9IjjquRU=;
        b=ERPCO5jpT/d7p0slQ1SY5mp9LzRVkons2Fhh1TjwNNYd8T0QM5UrGsIDWVqwnAtxzK
         yiHzKPLmg25gCC6iVBEOAtz2bd8AG1Tv5wOo//gQRijGp0TSSkOeaQz9H/6PVKj8X255
         6je5d8uatwbsWzyzt6shQpFc70Y8VYu+sB55l06I6VJ7ONz7sMthdYVkWV/uYS1XUJQ9
         rRnty46CTjlMr+ef4qbhrRD3L+dNqckBGgs5PmqLWBwhHGcO6v4cxWJZCfESwkGa1T4A
         PXkFaOszxo1LY/GmPprmLO0nyirj0srY2PrFHUnaSsBLZdEjsbC93onsMEJ4a6+tj1r1
         OBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKGw/McyyAOgqygGUIhrMWmmxcwz5Al/B7a9IjjquRU=;
        b=Wo00VeKwW58XCcClqcOWHHF46blEQpf9nFA3n/d4yYF94sr6UX3ZKdooHCrQBeLyGY
         TFazp14+l0ESy+Qws8YZlfdbP5S+Ve5mNsd1df264l6N940Ma8miHycVhQkTuPmKDb6S
         BOed1bptF7GF6xwESnL2rYDWmtkuHmanxtp0bv5/sEUr/CJ7TnDi+pKLY+qH0FPjhMMd
         6xQ25h1P+9yWQLWQ1ELSY7P5x9iqSUTOKD2fHpG99CgSpegpaT6/MHQoH68zQY+8HDRk
         1cLtmL9ZouhDgSskJYy8t7+OV8QB2C0pa8L5rROeI14e3oTwlkzPevlJ7EBKGYkOU7rQ
         4HKw==
X-Gm-Message-State: AOAM533NXHtjsv86z7rjkmwBYdRJZKA/ei27UA9r63wJIz+EC3JbTNGC
        FLo6CJ0+1ainOvWhxEnWPWM=
X-Google-Smtp-Source: ABdhPJz+EGYxsMyk9BxuSy3u2aGL+7qNPSLuik2QnSdAB1AWwui0Iyhn5pPDbE6Lk9bul6vJLNS4dw==
X-Received: by 2002:a05:6000:1a8f:b0:205:82c0:58ac with SMTP id f15-20020a0560001a8f00b0020582c058acmr4298416wry.30.1649198745877;
        Tue, 05 Apr 2022 15:45:45 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d410b000000b002060e6a02cesm7574676wrp.13.2022.04.05.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:45:45 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     matthieu.moy@univ-lyon1.fr
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
Subject: [PATCH V1 0/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Wed,  6 Apr 2022 00:45:01 +0200
Message-Id: <20220405224502.38544-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
References: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 4/5/22 11:43, Matthieu Moy wrote:

> How did you generate this patch? It doesn't apply with 'git am', I 
> suspect you copy-pasted incorrectly into your mailer. Using 'git 
> send-email' helps sending properly formatted patches.

My bad, I copy and paste. 
I'm a bit ashamed to say it, but I didn't know about the command 'git am',
but never too late to know about it, so thanks.

> I usually explain the problem first, and then the solution.

Yes, if you don't mind, I take your explanation and put it inside the commit
because it sounds really good to me. So, if I had to add a special tag for 
this alert me.

> A set of scripts and instructions to use VS Code on Git's codebase is
> available in `contrib/vscode/README.md` ?.

Indeed, it's a bit confused the way I said it. So, I change the text 
to something more accurate.

> I'm reluctant to adding general programming tips in a Git-specific
> document. Perhaps shorten it to eg. just "Using the integrated debugger
> can be particularly helpful to understand how Git works internally"?

I know, it can be strange to talk about programming tips, but I also think that,
it can be a good idea if it could help a beginer. And I also think that, in 
MyFirstContribution it's the right place to talk about it, because it might be
the first reading of newcomers. But, maybe create another file to talk
about things like this with a mention of this file in MyFirstContribution 
can be good too.

> Why not, but I don't think it's necessary here. People familiar with VS
> Code don't need such link, and people not familiar at all with is would
> better read a tutorial.

You got a point, but like you said, why not.


Thanks for your help and for taking your time to review.



COGONI Guillaume (1):
  contrib/vscode/: debugging with VS Code and gdb

 Documentation/MyFirstContribution.txt | 11 +++++++++++
 contrib/vscode/README.md              |  6 +++++-
 contrib/vscode/init.sh                |  1 -
 3 files changed, 16 insertions(+), 2 deletions(-)


Difference between V0 and V1
diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 97f53f536d..7f48990cb8 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1271,9 +1271,8 @@ should generate your diffs from `<topic>..<mybranch>` and base your work on
 
 === VS Code
 
-To see "how to use VS Code" read contrib/vscode/README.md.
-If you want to try to understand "how git works internally", the debugging
-feature of VS Code can help you. It will not give you all the keys to fully understand it, but
-it can give you an idea of "how the informations travel inside the code".
-It can help you to isolate some parts of code, with this you are able
-to ask more precises question when you are stuck. (See getting-help sections).
+Using the integrate debugger can be particularly helpful to understand how Git works internally.
+It can be used to isolate some parts of code, with this you may be able to ask more precises
+question when you are stuck. (See getting-help sections).
+A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
+and explanation of how to use the script are available in contrib/vscode/README.md.

diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
index a416a752c1..f383c95e1f 100644
--- a/contrib/vscode/README.md
+++ b/contrib/vscode/README.md
@@ -6,10 +6,9 @@ code editor which runs on your desktop and is available for
 [Windows](https://code.visualstudio.com/docs/setup/windows),
 [macOS](https://code.visualstudio.com/docs/setup/mac) and
 [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
-it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
+it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools) with
+[debugging support](https://code.visualstudio.com/docs/editor/debugging)
 
-To understand "how works the debbuging part" read:
-[Help with the debbuging part](https://code.visualstudio.com/docs/editor/debugging)
 To get help about "how to personalize your settings" read:
 [How to set up your settings](https://code.visualstudio.com/docs/getstarted/settings)


-- 
2.25.1

