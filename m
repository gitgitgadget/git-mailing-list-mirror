Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD076C77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 03:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjEDDzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 23:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEDDzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 23:55:36 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72D268C
        for <git@vger.kernel.org>; Wed,  3 May 2023 20:55:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38dec65ab50so38329b6e.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 20:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683172518; x=1685764518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojx2vxZowMSw3AkwJFyOlYJelUHV5MbtuuZhfRzir0M=;
        b=dnpHE/QXXRfuxxs276KAGLFkcUlkO71r7PEy+1UXfEjods79odUsjP9VYbYaVpjxm7
         VDfUHOm81H3WeQkGqmCQCSbwfbLPBthD5aLkDk5DNj7IBEzEyuOUx4TIVSXjMg42PLv+
         lgylAl8p+HaoQCLRoqqxe+IP1WGMIj6YDz3WaGuk68x5ojKk7wCtHJ2SG4aiGPhIjdHG
         er+lm3JZWMrSAy9mzY7sjtzTzb7Q0aSEiePkKyIQv1k42Ue/iRX5nYWLw6NlmUNG+RrA
         SIcOwxgBCISVFKOLkrWCmxm0BUwyA9XuVcu4qwdrh/daIH53z8MKFMM0z2c9udmxOeeJ
         Ziqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683172518; x=1685764518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojx2vxZowMSw3AkwJFyOlYJelUHV5MbtuuZhfRzir0M=;
        b=EYF85uXx9qdPeZs94BKQb18mUqma7W/PzAoZPCuXzQTPAWZTBIexecdk4GXupOAx64
         Aqo3iP5RJcK0UGROy+Hohmc3A43SG7JNG1/puj4nXUzeAkWe0EKyI27kVUOJ2aM6DmZO
         X5zFhnZZqS2hJuZF2Wi6tUXLOHv9W+a0VA8qkcSoNChPozPh5p4tQBLlPfBZkaHqbJPt
         N1Tz0DqGtjQcVvPQewFKUlUuhWLLB5K+TtTllsJoTdLqI7umGHPkTI6BbtjjI7fS1zPE
         pnPEW8Uq8GRkb5231EL2efrqbwzaG/bKHPtNGsgNMMe4eeBOJEFnZ3Vfj5VlpwT3IL10
         QFbA==
X-Gm-Message-State: AC+VfDyMehu1wGfnIuiiU5kfAuGOt17Fkc1NIYBFvanMSl+/ohmTRMZH
        SymwE5H3l5cBKv4qAT/Z3UA6uWtP7H8=
X-Google-Smtp-Source: ACHHUZ7j33AoNqOJON3BVsqEQ6l8y0LZylEmShvtIwLnuAfTq0Z9ItakeIgVBfud6ay6gBpVBLZCgg==
X-Received: by 2002:aca:efd5:0:b0:38e:257e:a62a with SMTP id n204-20020acaefd5000000b0038e257ea62amr1091426oih.50.1683172518664;
        Wed, 03 May 2023 20:55:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u42-20020a056808152a00b00383d9700294sm1112813oiw.40.2023.05.03.20.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:55:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] doc: manpage: get rid of an ancient asciidoc workaround
Date:   Wed,  3 May 2023 21:55:15 -0600
Message-Id: <20230504035517.329765-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There a small issue removing the workaround in git-svn.txt, so that's
fixed first, which also improves the output with asciidoctor, and then
removing the workaround is a no-op.

Felipe Contreras (2):
  doc: git-svn: use listing instead of verse
  doc: manpage: remove ancient workaround

 Documentation/asciidoc.conf | 21 ------------------
 Documentation/git-svn.txt   | 43 +++++++++++++------------------------
 2 files changed, 15 insertions(+), 49 deletions(-)

-- 
2.40.0+fc1

