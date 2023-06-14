Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C3EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjFNVko (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNVkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:40:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A112130
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso4452054f8f.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778839; x=1689370839;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xro7yXsTuxc8FvJYp/kfoQ3rnsg7NVjWZ0mL5J0Shk=;
        b=sF9MS9tuPOFpRmguGUR9EJSvpBWImY/ThdFpmBL0xXd5jCnVZLwNH+oobcLNAXykWM
         TiKz1ry8wO86o4xp6CCF166QgARqqNbG+7Qfe8OqxEJc6il9V6RA3S1vBq/zszv6bzNI
         c5zQWeDosanuBbW+ouh0KmZim7NjV5bMKuLuhYe5oije5IXNnzXZVf8fWpBNTJ/1LDG+
         k4y8uuZ2N0omnZRqFOgnzGDakxhqfHKhr0rTDvmxfqKrbIo6SUHPkIcpiFje3ToCiljd
         FIqyWo9W1c+I+gv1TUOkpIWZHRjnwgg4kMdI5Q0xOpZ5FdF/Pz7kZyYAzl9lxF/Jncqt
         iLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778839; x=1689370839;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xro7yXsTuxc8FvJYp/kfoQ3rnsg7NVjWZ0mL5J0Shk=;
        b=FYqO4C94NpftjfhWXYMIcBLh1u3VB6u7TizHet4oeuejlpgg70gDiZVokNgQLecAV0
         iS8GFuy39L7CJkD3+toAYDHMRh+kJd3daBQ42c5qv6V4GsuTrT/p4Q+csoD8UXk3IW0B
         jkouo3F4EbM6BQVHIJcQQm9CXkav3mtJc2iw8iEZLjg3t0J5tJu2HhKrDevnSiqBB110
         GkQBv85hxdqeS4MqWopcyALhnN/dmrKKHInvRCYXmamuI+owVDEny/q8AsU+U9PS31mu
         0mxYN0p1KtHGpzZ49OIUz661410sD1nLE273IZ/qGBKveJpumqIjvY6ef+yBXueJ4k4G
         fkTw==
X-Gm-Message-State: AC+VfDzeGNEIdP92AwyrwBgYBp0SZHMBCsBljTyoLkC/jc2CHXSXFoCx
        TOgr3c6PqFNZA2i9y6pmn0hvcYGx8bk=
X-Google-Smtp-Source: ACHHUZ7LgdOs/5ch+d0eG0XJp6aeUaG4Y8Ayc4nvgYGz0ChnyWurRenltB6EvGLGbbJMpJ/mlMyb2g==
X-Received: by 2002:a5d:6347:0:b0:30f:bafb:2478 with SMTP id b7-20020a5d6347000000b0030fbafb2478mr10167956wrw.42.1686778839269;
        Wed, 14 Jun 2023 14:40:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b0030af15d7e41sm19405520wri.4.2023.06.14.14.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:40:39 -0700 (PDT)
Message-Id: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 21:40:36 +0000
Subject: [PATCH v2 0/2] credential: improvements to erase in helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford (2):
  credential: avoid erasing distinct password
  credential: erase all matching credentials

 Documentation/git-credential.txt   |  4 +-
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 11 ++++--
 builtin/credential-store.c         | 21 ++++++-----
 credential.c                       | 11 +++---
 credential.h                       |  2 +-
 t/lib-credential.sh                | 59 ++++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 22 deletions(-)


base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v2
Pull-Request: https://github.com/git/git/pull/1525

Range-diff vs v1:

 1:  35ee1795bcd = 1:  35ee1795bcd credential: avoid erasing distinct password
 2:  fcdb579263f ! 2:  9b12f17dc7e credential: erase all matching credentials
     @@ Metadata
       ## Commit message ##
          credential: erase all matching credentials
      
     -    Users expect that
     -    `echo "url=https://example.com" | git credential reject` or
     -    `echo "url=https://example.com\nusername=tim" | git credential reject`
     -    erase all matching credentials.
     +    `credential reject` sends the erase action to each helper, but the
     +    exact behaviour of erase isn't specified in documentation or tests.
     +    Some helpers (such as credential-libsecret) delete all matching
     +    credentials, others (such as credential-cache and credential-store)
     +    delete at most one matching credential.
      
     -    Fixes for credential-cache and credential-store.
     +    Test that helpers erase all matching credentials. This behaviour is
     +    easiest to reason about. Users expect that `echo
     +    "url=https://example.com" | git credential reject` or `echo
     +    "url=https://example.com\nusername=tim" | git credential reject` erase
     +    all matching credentials.
     +
     +    Fix credential-cache and credential-store.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      

-- 
gitgitgadget
