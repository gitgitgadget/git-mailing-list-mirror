Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF56C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814846140D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhJDTDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhJDTDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:03:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA6C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 12:01:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bd28so68581404edb.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kN7ch9qE7mBUOojOyozOOO3RJmY1VglsON0PVxeocCs=;
        b=KzPcq2njZsUxY27/8uPH3QTKsksCi9a7Z5ERl26aKvc/upjlHzKYxtjA4EirvMi/eI
         lKxtdI5dkKdvqVKSpaRbeyVIBwHoIwydOK18YAaQtSuEO2SR87ZGfd79Q0QJQVpdIz86
         MBn7MAitvZIURRN0hskqBuOO189mZVvEj2XhwunGFnWwCE7zMWJPvfaBJlPfFqmqdMXp
         UvvOjgU4jjWb/WNNtImKBWFfhPi/raI5H1XrFhJ/wGvyJpRnvFf7L4avTvvHx5mryalt
         rIO0BNSiJ0RSzwHljojh5//CtNUU2zWGh8VQbRDRS83yAcoRz5SmneqSaevg8+9oKBZn
         C0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kN7ch9qE7mBUOojOyozOOO3RJmY1VglsON0PVxeocCs=;
        b=n5wpBixiwnDK3CburoGvqssGsaNiUuL51CRDM5FuRs4hGmbcalzvtcaznOve+pSD9X
         d0tOdkt0oRa4j7/SMVcIlM2qgpw4p0Zm17tkXcnIgMK2Q+7csVlfdzt6lt6GZ/HwEGMA
         54J/Pj1TccGR5tSJxd9Q2UbNTZSc6vz06UjIuaY+gBoQoFuZ72t7pxu1SN+MMkY5OTkF
         LBDE08Xed3gxctPSKisUrDiuVyKgyhqwlhS1QiEXNLnb8AAVfcmnNyNtzuDpTIu9N8EL
         nmpfpEx1gxc+linKVs1a5E0C0Z2IkPjcPa09YlTx1ukTGgwX6YVJ2UWUAKH91wbTaY5j
         jfog==
X-Gm-Message-State: AOAM532EVVPxzr08e0gT+YtOK6LkTUB/snS9qwoMxYwImBfqGsZvjpDw
        bzcF6ecqpMZWRVO1/VF/0AsOTxt96Zk=
X-Google-Smtp-Source: ABdhPJznEYhO7XIf3T9J2EkcYnRVHdfz2rRhH1g9oMFG3g4NLKD33WxUHa9sluW+dMewACYo2FzbkA==
X-Received: by 2002:a17:906:ca12:: with SMTP id jt18mr18708242ejb.451.1633374079431;
        Mon, 04 Oct 2021 12:01:19 -0700 (PDT)
Received: from localhost.localdomain (178.115.74.220.wireless.dyn.drei.com. [178.115.74.220])
        by smtp.gmail.com with ESMTPSA id v13sm6759357ejo.36.2021.10.04.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:01:18 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     newren@gmail.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: [PATCH v2 1/4] Documentation/git-status: remove impossible porcelain status DR and DC
Date:   Mon,  4 Oct 2021 21:00:47 +0200
Message-Id: <20211004190050.921109-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 176ea74793 ("wt-status.c: handle worktree renames", 2017-12-27)
made a porcelain status like .R or .C possible. They occur only when
the source file is added to the index and the destination file is
added with --intent-to-add.

They also documented DR, but that status is impossible.  The index
change D means that the source file does not exist in the index.
The worktree change R/C states that the file has been renamed/copied
since the index, but that's impossible if it did not exist there.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 Documentation/git-status.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

(the diff looks off by one column but that's just because we use tabs for indentation)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 83f38e3198..20f496094a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -225,8 +225,8 @@ C        [ MD]   copied in index
 [MARC]           index and work tree matches
 [ MARC]     M    work tree changed since index
 [ MARC]     D    deleted in work tree
-[ D]        R    renamed in work tree
-[ D]        C    copied in work tree
+	    R    renamed in work tree
+	    C    copied in work tree
 -------------------------------------------------
 D           D    unmerged, both deleted
 A           U    unmerged, added by us
-- 
2.33.0.rc2.dirty

