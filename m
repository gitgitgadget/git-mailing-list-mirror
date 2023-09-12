Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42109CA0EF1
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjILRCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjILRCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:02:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CBE1702
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:02:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so63361745e9.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538138; x=1695142938; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aAR4aU6H1WYUIyS4SOXH7q6LBZW6pPUo+QY9qxDt+E=;
        b=PQn3iJ2efWvTtXDA0c7Y8MM7FBZVuLPQPMhOEbWBpyH72ryWEkevLd69UeYEUimDee
         meKXL4+JXOZzpVoB0DhkmRmvuiRVbWx4ti4fgePC1xTZZHzcJv4ky6+QZAEwaOmz37Ja
         d9+XwHym6rhlOll4rdnQQKkTPnrceyS5lNmLzOnkrbeYIKUEjY1Px+JKh8dioYhHFQze
         SZmmtBNmchV1u750I3txV9pRO0KIPuWbhgtO+9Xm6gO0oivp4Pb7uL0IIuJRaKLH/Y3+
         l1OIoK0EwsXiXa3QdYFvv5Bj1x5PQqoe+c/RPE+qMne6Xw/ynXDDiH3uEEB993uP2BAo
         Sr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538138; x=1695142938;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aAR4aU6H1WYUIyS4SOXH7q6LBZW6pPUo+QY9qxDt+E=;
        b=WD5F3Jqsvtts3TqMgq8WqUCkbIS4CSbaJ6Uj+41vtYNlVlKYLmnep8sioMXyfocjlL
         uS7PKd5+t61A4A+ztKQgJXCLqWGn1mVDDze0cvjCjhz2Yg6x3RPsqgbpXmusukwgSdy0
         +JYhZZ4rRB6DH0xwGM5gKUzOu3RlZWuFnXibcF5F2to46pVqscgn12azhvqeJGKPr/xo
         1cepZr2TFBZYFbSJrC7NZ8TuCR0L31oA5C7tW93ieDwZx3dPrEnTjdls/TdS6C1M6UNl
         coISCWyEK39PuqWKaUhLdRLIFrlS3KzlXY4cJDKlxTupw8Sa3LgBbWostpeF5tAfmr/2
         /otw==
X-Gm-Message-State: AOJu0Yx8h8Qf4iMx7bP7GV2+23GQt8J4Tb8lkoB9sopTcBDOTRdxG0Vw
        SDizgDCEONNZOB3qB0q7kw8LP8RHf1Q=
X-Google-Smtp-Source: AGHT+IFNsC6GeSESTHht+GIUKoaYKUt4vK5ot/Eati1SC60jO+hw+2bjHS7+qKEXXLXjno4UoGs+2Q==
X-Received: by 2002:a05:600c:21d8:b0:3fb:c9f4:150e with SMTP id x24-20020a05600c21d800b003fbc9f4150emr32944wmj.14.1694538137588;
        Tue, 12 Sep 2023 10:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b003fed70fb09dsm13416393wme.26.2023.09.12.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:02:16 -0700 (PDT)
Message-ID: <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
In-Reply-To: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:02:15 +0000
Subject: [PATCH v2] completion: improve doc for complex aliases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Linus Arver <linusa@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The completion code can be told to use a particular completion for
aliases that shell out by using ': git <cmd> ;' as the first command of
the alias. This only works if <cmd> and the semicolon are separated by a
space, since if the space is missing __git_aliased_command returns (for
example) 'checkout;' instead of just 'checkout', and then
__git_complete_command fails to find a completion for 'checkout;'.

The examples have that space but it's not clear if it's just for
style or if it's mandatory. Explicitly mention it.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    completion: improve doc for complex aliases
    
    Changes since v1:
    
     * fixed the typo pointed out by Eric
     * added an explanation of why the space is mandatory, as suggested by
       Linus

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1585%2Fphil-blain%2Fcompletion-shell-aliases-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1585/phil-blain/completion-shell-aliases-doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1585

Range-diff vs v1:

 1:  b3621ed25f0 ! 1:  96a0867c5ad completion: improve doc for complex aliases
     @@ Commit message
          The completion code can be told to use a particular completion for
          aliases that shell out by using ': git <cmd> ;' as the first command of
          the alias. This only works if <cmd> and the semicolon are separated by a
     -    space. The examples have that space but it's not clear if it's just for
     -    style or if it's mandatory.
     +    space, since if the space is missing __git_aliased_command returns (for
     +    example) 'checkout;' instead of just 'checkout', and then
     +    __git_complete_command fails to find a completion for 'checkout;'.
      
     -    Explicitely mention it.
     +    The examples have that space but it's not clear if it's just for
     +    style or if it's mandatory. Explicitly mention it.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      


 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..659df570496 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -28,6 +28,7 @@
 # completion style.  For example '!f() { : git commit ; ... }; f' will
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
+# Be sure to add a space between the command name and the ';'.
 #
 # If you have a command that is not part of git, but you would still
 # like completion, you can use __git_complete:

base-commit: 23c56f7bd5f1667f8b793d796bf30e39545920f6
-- 
gitgitgadget
