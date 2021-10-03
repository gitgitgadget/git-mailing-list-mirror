Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B68C433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA8361B31
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJCMbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 08:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJCMbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 08:31:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16568C061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 05:30:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so4903934pjb.3
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zzYB649SUQeFEv+CNLZnMiewbejrWDe3PrP3+EPyo0=;
        b=pywQkngJeBT3dy9e8173UGyvFqAQxYRCqNHfIfuzfjAdKTTtL/VV6mfRLrbMRp3Sag
         a0GZAxsLaQ71KnSJC9C8iY3etC2MP/vhDdnDQ6ytmVwbl0S0ZcZr2kCNVvNrSH1OXxB6
         7Kpu9ZefXrqYKbTX4Spx7cZdJbKJna9bDMWH36hnniMFBoLRLqvNNI14hhTVMMQRihPK
         i376Zx+SZHF5MXx+AQ3tUVBxC4qjiK2hlmMs33Q7oku84VPf7Rzo20bV7a/j3hx3Y4IN
         M6YwpIuM1OOzkIHxPqT15+18++0VWIrFovplyXHeaatK23lujQ211NJC8llJLl6ssbgZ
         aPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zzYB649SUQeFEv+CNLZnMiewbejrWDe3PrP3+EPyo0=;
        b=qoP4wAhW+kef5mS3K3Esurggsg4PirCZmVvYD02BtyDrSPTR/KWl0qaTvZ9GQ8jDEV
         SiFAf9kDWJtJVLqUZznBnDzo4pDEgvJjm/XhjlXyYFweirK6xw/aVSg4t2jRT67iuH/v
         czyhqvAgTJrwQivCWfL4fkyKT6matPvkR8vscgUt7CYr0+6T7HsMXE7YDUq0Zhwz/9aM
         Gcq6E7KK/R9y3+lQ4vzZQhqCJ6RbIib1k3YSqFl+maXm9IX9K9Kij7jYEXyQIRQJI7pk
         icVgV9BRLeEAS6mSagnEoSP+cRcZSgrI8tG1FVo2+fzy4gXES3FaHpvz+9/9pJmNu3Aw
         DAqQ==
X-Gm-Message-State: AOAM530SYFSfE6QUD/BnE8w01fqmD2g/ThZZN+TkbBkxcpqHstv5e03S
        6NZzEY0kAd5FbD/2GhSeCbP5wPTmGxlmWQ==
X-Google-Smtp-Source: ABdhPJwGOA7e77u4ars2ADtzHujYAqYncPioMFzCysCyn6nDp8Uk+G0kupZavpnRG6ALCXdocujGcw==
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id o6-20020a170902bcc600b00138d3cac356mr18091028pls.6.1633264199410;
        Sun, 03 Oct 2021 05:29:59 -0700 (PDT)
Received: from ubuntu.mate (subs09b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id k17sm8476394pfu.82.2021.10.03.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:29:59 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Ryan Anderson <ryan@michonline.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] request-pull: document -o/--output
Date:   Sun,  3 Oct 2021 19:29:43 +0700
Message-Id: <20211003122943.338199-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003122943.338199-1-bagasdotme@gmail.com>
References: <20211003122943.338199-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the option in git-request-pull(1), as well as usage example
(along with shell redirection method).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-request-pull.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 4d4392d0f8..4bb07d8865 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -8,7 +8,7 @@ git-request-pull - Generates a summary of pending changes
 SYNOPSIS
 --------
 [verse]
-'git request-pull' [-p] <start> <url> [<end>]
+'git request-pull' [-p] [-o | --output <file>] <start> <url> [<end>]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,10 @@ OPTIONS
 -p::
 	Include patch text in the output.
 
+-o <file>::
+--output <file>::
+	Write the request to the specified file.
+
 <start>::
 	Commit to start at.  This names a commit that is already in
 	the upstream history.
@@ -64,6 +68,15 @@ which will produce a request to the upstream, summarizing the
 changes between the `v1.0` release and your `master`, to pull it
 from your public repository.
 
+To generate the request to a file for later editing, you can either
+use shell redirection:
+
+	git request-pull v1.0 https://git.ko.xz/project master > request
+
+or with `-o` option:
+
+	git request-pull -o request v1.0 https://git.ko.xz/project master
+
 If you pushed your change to a branch whose name is different from
 the one you have locally, e.g.
 
@@ -73,7 +86,6 @@ then you can ask that to be pulled with
 
 	git request-pull v1.0 https://git.ko.xz/project master:for-linus
 
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
An old man doll... just what I always wanted! - Clara

