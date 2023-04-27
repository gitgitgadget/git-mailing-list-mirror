Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B128BC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbjD0WW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjD0WW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:22:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F22715
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so62799195e9.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634145; x=1685226145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRMtY/g2D1XB0LVI1PzqYW/zjl/+4wuIDVbdbOiqM94=;
        b=PTdkM78L3HqAHr8KbA4HZknX5Vq2BdhScARz8lKfiGoscOGKj6LKs7wJ7u+CipbXHc
         QoxVwwh/UVsxGR1qb0+anUhNBJoeWJYCLiClHxwzMFZOBVgUHMhdx1thLbT+ywNmbNjH
         RgHW481VTSv6p5ehWzJzThaSR3cCeff6mxeWjOcbVhpOMEXw7g65SG3RLQMvE0f3h0cr
         Nm/2/6XJqoDdO7gzj7Rwl4aI/qEntYOU5Qm1BfdNdxp/AFPEE/n7LiFfudOS+lXEwTed
         /5R2NGgRhzuMWMdZDr1qF/uHI6MaJWunBYmqi9daNp2o91XwhmuViyJswd64GK97FxbZ
         OGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634145; x=1685226145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRMtY/g2D1XB0LVI1PzqYW/zjl/+4wuIDVbdbOiqM94=;
        b=OsqfxNGSf15qRKl62e23LsEeFpuPQ0y5Aj0GVgy/NT4Xo9HK65XTggAuADBgtBkP0R
         PBS5Bf8pmg74euOpQYp6bSfxtsX3IqTxa4lP+lxvAYRZLdr/WV/PFy5x65u4F+arXSXY
         uSUAMUyI5Uxt3m55Xb+ndSP1Qrymt4Cgk3C7bznjftinAIek1YOgvEf2Iett5kE/ySgs
         zlNGjAfihDjVTfvvSTtg+AzdP/14Eaa6aPFCZvfb87e/1ut5vCPgySpy6N/TQUZ+b4ZV
         DZkQ9iAgErVZYxTFxQYgFUItB/Gzbn+0ixFnidKW796PjdAmdKG0ikK8OYuHV3flFpoQ
         X1Bw==
X-Gm-Message-State: AC+VfDxtKDa5ztvkZXiIwsmmsgIVTt6oTGAn0MIurRekLx6yDRrFiBsm
        7S19EFNfSeXo1lzxkhKSeWJJxpHzLQU=
X-Google-Smtp-Source: ACHHUZ5pXbtpJwFkcUUxtUeepPh3gbAwor8hUYe3iMunXpO386YWx5hR/LUJ3XLZbcGLIKB+lpP7Bg==
X-Received: by 2002:adf:fc06:0:b0:2f6:c5bd:ba13 with SMTP id i6-20020adffc06000000b002f6c5bdba13mr2424810wrr.42.1682634144897;
        Thu, 27 Apr 2023 15:22:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b003012030a0c6sm19500601wri.18.2023.04.27.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:22:24 -0700 (PDT)
Message-Id: <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Apr 2023 22:22:21 +0000
Subject: [PATCH v2 0/2] cocci: codify authoring and reviewing practices
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the input on v1, all :)

I've tried to capture all of the discussion in some form. AFAICT, the result
is quite similar to what we are already doing, so it might not be very
helpful to folks who have already worked with Coccinelle, but it should
hopefully be useful to newcomers.

I suspect that we won't converge on any new practices during this
discussion, but as we develop practices in the future, we can just update
this doc.

Glen Choo (2):
  cocci: add headings to and reword README
  cocci: codify authoring and reviewing practices

 contrib/coccinelle/README | 40 +++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)


base-commit: f285f68a132109c234d93490671c00218066ace9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1495%2Fchooglen%2Fpush-lsxuouxyokwo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1495/chooglen/push-lsxuouxyokwo-v2
Pull-Request: https://github.com/git/git/pull/1495

Range-diff vs v1:

 1:  4a8b8a2a674 = 1:  4a8b8a2a674 cocci: add headings to and reword README
 2:  75feb18dfd8 ! 2:  acee642531a cocci: codify authoring and reviewing practices
     @@ Metadata
       ## Commit message ##
          cocci: codify authoring and reviewing practices
      
     -    This isn't set in stone; we expect this to be updated as the project
     -    evolves.
     +    These practices largely reflect what we are already doing on the mailing
     +    list, which should help new Coccinelle authors and reviewers get up to
     +    speed.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ contrib/coccinelle/README: that might be useful to developers.
      +
      +== Authoring and reviewing coccinelle changes
      +
     -+* When introducing and applying a new .cocci file, both the Git changes and
     -+  .cocci file should be reviewed.
     ++* When a .cocci is made, both the Git changes and .cocci file should be
     ++  reviewed. When reviewing such a change, do your best to understand the .cocci
     ++  changes (e.g. by asking the author to explain the change) and be explicit
     ++  about your understanding of the changes. This helps us decide whether input
     ++  from coccinelle experts is needed or not. If you aren't sure of the cocci
     ++  changes, indicate what changes you actively endorse and leave an Acked-by
     ++  (instead of Reviewed-by).
      +
     -+* Reviewers do not need to be coccinelle experts. To give a Reviewed-By, it is
     -+  enough for the reviewer to get a rough understanding of the proposed rules by
     -+  comparing the .cocci and Git changes, then checking that understanding
     -+  with the author.
     -+
     -+* Conversely, authors should consider that reviewers may not be coccinelle
     -+  experts. The primary aim should be to make .cocci files easy to understand,
     -+  e.g. by adding comments or by using rules that are easier to understand even
     -+  if they are less elegant.
     ++* Authors should consider that reviewers may not be coccinelle experts, thus the
     ++  the .cocci changes may not be self-evident. A plain text description of the
     ++  changes is strongly encouraged, especially when using more esoteric features
     ++  of the language.
      +
      +* .cocci rules should target only the problem it is trying to solve; "collateral
     -+  damage" is not allowed.
     ++  damage" is not allowed. Reviewers should look out and flag overly-broad rules.
     ++
     ++* Consider the cost-benefit ratio of .cocci changes. In particular, consider the
     ++  effect on the runtime of "make coccicheck", and how often your .cocci check
     ++  will catch something valuable. As a rule of thumb, rules that can bail early
     ++  if a file doesn't have a particular token will have a small impact on runtime,
     ++  and vice-versa.
      +
      +* .cocci files used for refactoring should be temporarily kept in-tree to aid
     -+  the refactoring of out-of-tree code (e.g. in-flight topics). They should be
     -+  removed when enough time has been given for others to refactor their code,
     -+  i.e. ~1 release cycle.
     ++  the refactoring of out-of-tree code (e.g. in-flight topics). Periodically
     ++  evaluate the cost-benefit ratio to determine when the file should be removed.
     ++  For example, consider how many out-of-tree users are left and how much this
     ++  slows down "make coccicheck".

-- 
gitgitgadget
