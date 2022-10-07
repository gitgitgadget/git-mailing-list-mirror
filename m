Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B80C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJGOiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJGOiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 10:38:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259871204FB
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 07:38:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p26-20020a7bcc9a000000b003c384e59047so750798wma.4
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSymgYDjIgl3c3Vb02LE4tZC4Nd4DdI9q1jBdD30K5w=;
        b=BN4iDY0mURCg6+XtOpCWGvfw80mG238hV2rvoXXxOFv6Q6NYX7HtSp1EH86hZTWQ59
         mVL5AzULCQtYjUPVpc2AzhXCkrs2MiZkNl0CV6GUELkz/2/fEeWq0SBHWSUtE2naQOZI
         DcRHQEKNYT9Xzh7ni18FOwmvn1g0ML6xgiqdW5fiZ+z/9RICSdyvv2eiD2H/c8zqD3Q4
         Gx1V6h3zjwXM3IIfqRg1aY//SKcwHaSxYAQWxsNIGnvhvzXhQCMYz4OjFoni2U3t9u6m
         H/xX3dysLyPVtDishIvEtv6TzdDLZNaoesL6JMrbZqNohxYmWk9P0NvLprUnoWBsbnex
         bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSymgYDjIgl3c3Vb02LE4tZC4Nd4DdI9q1jBdD30K5w=;
        b=VDKqtlzR5vNdKCz7j0fsNFHnzekRN8uPDY4Yb284NxJ+0IC2FJZJLB5xpPMPblAkI1
         kqp52X4oTOQlD4US4AQHxPq8+uC2okLBpURYdKlYZGqLS2CYRqOPACcfxJpwzxGRIm+Z
         nQ9suncYUN9+vWPP8z9PvJaGgdo57sOPA4PFfInz9nimn3hlHJ9z4i7RADZk/kRtNv2S
         KjZJq+jXtP8crGHhqxrbPwQnxFBqWcPL2i7R3jz+96EFWBtvD8EPb+5WcCfblAinTrJO
         JavezuHokoAuHqPfDIdPnZA0eLcSd0LwDjtrVBGRdvjniVRyiF6QHK6LlFfdYklrI5hB
         HSKg==
X-Gm-Message-State: ACrzQf31gW/Gcke8ASBWXGIqkOFLoId53qPjam7+5wd732ekmIqYOebM
        qmAv8n31rF1gWp55dpgjvb76tCqjcjI=
X-Google-Smtp-Source: AMsMyM4Tlj8/OOsPEOycndYJb+L1WSTvfp0OMParNbLNw8M66Cg1pIWjz7iAU/gZoCCptwKJTpa0aA==
X-Received: by 2002:a05:600c:1caa:b0:3a8:4066:981d with SMTP id k42-20020a05600c1caa00b003a84066981dmr10747908wms.54.1665153488411;
        Fri, 07 Oct 2022 07:38:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b0022a297950cesm2226330wrb.23.2022.10.07.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:38:07 -0700 (PDT)
Message-Id: <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
From:   "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 14:38:04 +0000
Subject: [PATCH v2 0/2] git.c: improve readability | git-p4: minor optimization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git.c - made the code more readable in cmd_main by moving the spacial casing
for "version" and "help" as part of the regular code path

git-p4.py - minor optimization in read_pipe_lines by first checking for
errors, then reading data and/or decoding it from the pip stream

Daniel Sonbolian (2):
  git-p4: minor optimization in read_pip_lines
  git.c: improve code readability in cmd_main

 git-p4.py | 10 +++++++---
 git.c     | 14 ++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)


base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1355%2Fdsal3389%2Frm-useless-else-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1355/dsal3389/rm-useless-else-v2
Pull-Request: https://github.com/git/git/pull/1355

Range-diff vs v1:

 1:  71da6f53a44 ! 1:  dd81a2cadec python file more pytonic, adjust "if" and "for"
     @@
       ## Metadata ##
     -Author: dsal3389 <dsal3389@gmail.com>
     +Author: Daniel Sonbolian <dsal3389@gmail.com>
      
       ## Commit message ##
     -    python file more pytonic, adjust "if" and "for"
     +    git-p4: minor optimization in read_pip_lines
      
     -    L371
     -    redesign few lines to get rid of the "else" statement
     -
     -    L404
     -    moved the if statement below another if statement that
     -    checks if it should exit the code, only if it doesnt need to,
     -    then we can iterate the for loop and decode the text
     -
     -    Changes to be committed:
     -            modified:   git-p4.py
     +    checking for an error condition before reading and/or decoding
     +    lines from the pip stream to avoid unnecessary computation
      
          Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
      
       ## git-p4.py ##
     -@@ git-p4.py: def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     -        """
     -     retcode, out, err = read_pipe_full(c, *k, **kw)
     -     if retcode != 0:
     --        if ignore_error:
     --            out = ""
     --        else:
     -+        if not ignore_error:
     -             die('Command failed: {}\nError: {}'.format(' '.join(c), err))
     -+        out = ""
     -     if not raw:
     -         out = decode_text_stream(out)
     -     return out
      @@ git-p4.py: def read_pipe_lines(c, raw=False, *k, **kw):
     + 
           p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
           pipe = p.stdout
     ++
     ++    if p.wait():
     ++        die('Command failed: {}'.format(' '.join(c)))
     ++
           lines = pipe.readlines()
     --    if not raw:
     ++    pipe.close()
     ++
     +     if not raw:
      -        lines = [decode_text_stream(line) for line in lines]
     -     if pipe.close() or p.wait():
     -         die('Command failed: {}'.format(' '.join(c)))
     -+    if not raw:
     -+        lines = [decode_text_stream(line) for line in lines]
     +-    if pipe.close() or p.wait():
     +-        die('Command failed: {}'.format(' '.join(c)))
     ++        return [decode_text_stream(line) for line in lines]
           return lines
       
       
 2:  c107ad9f6ff ! 2:  7fe59688018 removed else statement
     @@
       ## Metadata ##
     -Author: dsal3389 <dsal3389@gmail.com>
     +Author: Daniel Sonbolian <dsal3389@gmail.com>
      
       ## Commit message ##
     -    removed else statement
     +    git.c: improve code readability in cmd_main
      
     -    there is no need for the else statement if we can do it more
     -    elegantly with a signle if statement we no "else"
     +    checking for an error condition whose body unconditionally exists first,
     +    and then the special casing of "version" and "help" as part of the
     +    preparation for the "normal codepath", making the code simpler to read
      
          Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
      

-- 
gitgitgadget
