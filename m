Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C969C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A2A61247
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhJBVc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBVc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 17:32:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DEC061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 14:31:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so21690339wrb.6
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey1hw+vQGFd5KcgBRRNpcIxRbxH0XOHZb1wiGHkChx4=;
        b=X3PUl/rx1wEG+E8XtOI5PVdMFgGR04F54Phi3prBo6eaAC7pZbIaTjbxgIgMoQMevZ
         dUHg/Y75nckf2glewCCt0EvxjQn8ZfpS8GUbq+O2DoUs2QeMGRywRYbMz0IYNDNGA3bB
         HGyyxQnF4PW7GvtpYmPZ7JNk/cTsGu6PSSUcPSMRkxxVH1SlDvyZrpw4X+okPA6FaTQb
         BGwU+1DbOnW2e1hX8xd6xkykZiAbGeVn7R3/32205Ccm09ZC0v7uW8ZSbNn34l3FHj+c
         7xofxtqgwC5rKy+Do1os9z/qPKOojN73PlgyjbkIKa1VgtcR5hc5Rf6pLax97rMC6qW3
         R/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey1hw+vQGFd5KcgBRRNpcIxRbxH0XOHZb1wiGHkChx4=;
        b=1v0J/1GGes4dP3T4Qhswkd2WpGzMOWwupqDzZ1XSVuRPFB1jAKw+LaqAzk9wRlsEYI
         OT6tx5+iPlNpAZs6TAbWtaU14Sm2ey9AwP9iWnVttbAXU/1BXor9LGxVYTt+u0RFw8YS
         L+Tu6hCrEtGHTI3hHh5zJ3kuUTi20k+YYhNr6v/nC1RZSYIgFZ34xWtTPr5K1n4j0Mky
         PTtlrOMcausErwFa7OVbfAvhiUpyGQGBl8GRBxPWqk0RiiZ5Esq+d9wvAjYD1xeL2U7v
         346evO3hxkajU7AL2eh51bO2yxwYtEVrGlgY4TWLj4OXSKNJ+rm4FZzNsr/8xUALYlrg
         OsZA==
X-Gm-Message-State: AOAM53007GleAkpmsqSTl2wSNiXap3Egonmo1jUPvkt9rLsWtrXYpBdA
        9yTvwN7Wx/hPaXPH+/hyebtXzc3nDSc=
X-Google-Smtp-Source: ABdhPJw8aySyib9nhmJDoKWekXOKeHiqM3409QYwKXto4P2rztHy6kZdEArtvcDQJrBJwA7vFQTuUA==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr5160233wrf.197.1633210270824;
        Sat, 02 Oct 2021 14:31:10 -0700 (PDT)
Received: from localhost.localdomain (77.119.208.5.wireless.dyn.drei.com. [77.119.208.5])
        by smtp.gmail.com with ESMTPSA id e5sm9607297wrd.1.2021.10.02.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:31:10 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Cc:     aclopte@gmail.com
Subject: [PATCH 1/2] Documentation/diff-format: state in which cases porcelain status is T
Date:   Sat,  2 Oct 2021 23:30:45 +0200
Message-Id: <20211002213046.725892-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Porcelain status letter T is documented as "type of the file", which
is technically correct but not enough information for users that are
not so familiar with this term from systems programming. In particular,
given that the only supported file types are regular files and symbolic
links, the term "file type" is surely opaque to the many(?) users who
are not aware that symbolic links can be tracked - I thought that a
"chmod +x" would result in a T status (wrong, it's M).

Explicitly document the three file types (including submodules).
This makes life easier for tool authors, but has potential to go
out of date if a new type is ever added. We could avoid this with a
targeted test, or by using a reStructuredText directive to include the
list of file types from a single source.  Probably not worth it. The
next patch will copy this snippet to git-status.txt though.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---

(The implementation calls the third type "gitlink" but for users that's
always a submodule, AFAICT)

 Documentation/diff-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index fbbd410a84..7a9c3b6ff4 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -59,7 +59,7 @@ Possible status letters are:
 - D: deletion of a file
 - M: modification of the contents or mode of a file
 - R: renaming of a file
-- T: change in the type of the file
+- T: change in the type of the file (regular file, symbolic link or submodule)
 - U: file is unmerged (you must complete the merge before it can
   be committed)
 - X: "unknown" change type (most probably a bug, please report it)
-- 
2.33.0.rc2.dirty

