Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F67DEB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjGZDFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGZDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5A1BDA
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4897667f8f.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgE7BCdrkdi3NO+bbFytp6LnhzOcx40qeHgu/9tv0lg=;
        b=B9X2vTqUzsNZg37m5rNyvlpUuhEFupD4TbIoEfQZBT2nmpQgHqRB8GnE3SGyg49GQy
         cbqwHLePLxN12Tbxs5fWH5+FjpxbikkcQKefabtWTC1uZiPzYvUCQoziG641f0WyfBLC
         pb2guNcR6UA8mwPqkkDob27Tu7EdYAk5sK6vlfAaV+7jTZYZl2Tpprn0w6UUdsIuw3iF
         UgdWGh3rUH2RPew+5OSdF7ixrz4hGwW/iNilHNJyBF56khcgKqVEZxcxQH/o7R5umciN
         MsV3dMQ0uodfr754TOP7zfm/nibiVWhw/CbHKAjNvMrrfC4AsiFo2en1EJ8Pw6jKI1gx
         t1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgE7BCdrkdi3NO+bbFytp6LnhzOcx40qeHgu/9tv0lg=;
        b=IgJkgLmU9FIzoe/14GKrvKxKYW7l0KQ5+vUxXtXzA+tWx2e+dNiAtTAf8+CKZ/jI0H
         EEgoNocwWxSx2xzOY5P8wi9UEQSuVpBhYA3ARsjTeId3G0tSj2m54Mgr/TIB3NCQ0hyu
         b/YN81aZAiXdeVDwgFowoPxi3N2Dp3aojsGZlINcwMEo3Yu/Q8gaf0fYQ8enzd9BpNjc
         VEMJXUh/8kj8lwVGHdAYDjQMyEhuSBwHPVBP9KrE+3oZm4M8qTy6Tv7bmtWK2fqtlNg7
         MIwRt1Q1PEy2fndeeIlxR0eZyd9FlBUyxh915J5AS1XgMiKeOd0TqtYTBWaFk95EYHas
         Gluw==
X-Gm-Message-State: ABy/qLYRBcFiSSyciZdD1Ze9Xns0V5TcUgS0gxZM37kKFWf8DQkbCBse
        1dQAzN7RqL+VIHbXEbYs10BdEaqgEek=
X-Google-Smtp-Source: APBJJlEMEUZ9dVk1VNaEYwiGq8iMeNA+h8HFibpOjhPd0KEahqbohuXLEAokd/t5yZwN9bj2Jx8IXg==
X-Received: by 2002:a5d:4405:0:b0:317:5cfb:714c with SMTP id z5-20020a5d4405000000b003175cfb714cmr337403wrq.25.1690340704015;
        Tue, 25 Jul 2023 20:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b0031272fced4dsm18130659wro.52.2023.07.25.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:03 -0700 (PDT)
Message-ID: <8d4b57a8704b658e5b4fd0d5e78a53e9bc327d22.1690340701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:04:58 +0000
Subject: [PATCH v3 2/5] SubmittingPatches: discuss subsystems separately from
 git.git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The discussion around subsystems disrupts the flow of discussion in the
surrounding area, which only deals with starting points used for the
git.git project. So move this bullet point out to the end.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b89678cedc3..7919a362e31 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -35,14 +35,14 @@ change is relevant to.
   to stabilize, you would have to rebase it (see the "depends on other
   topics" above).
 
-* Some parts of the system have dedicated maintainers with their own
-  repositories (see the section "Subsystems" below).  Changes to
-  these parts should be based on their trees.
-
 To find the tip of a topic branch, run `git log --first-parent
 master..seen` and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
 
+Finally, note that some parts of the system have dedicated maintainers
+with their own separate source code repositories (see the section
+"Subsystems" below).
+
 [[separate-commits]]
 === Make separate commits for logically separate changes.
 
-- 
gitgitgadget

