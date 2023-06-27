Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71651EB64DD
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjF0OmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjF0OmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33E35AE
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so22316405e9.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876887; x=1690468887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvx70z2BXZ1jKRLTnGgIZScDPe0wQ43yxPzL6H+ZIhM=;
        b=aZDvpyvCBXRE2kuKPuka1idL0usKXKQWqOCH3Rx1oSVYwIRnPNJ2+Xo9iGr9/Cxsb7
         7rDqv9AAcyiECJ3uuusAsczwRU8vXdcKU19Im5CTR0Z/SGr4eQSD2RUVXPTfzP0twxC/
         Zb7fJJ95lCXkO+YpAkhtR81SBpDMoPf0eIFuyjQoLxIKAmq4ibZjSJudk1pOw+CADOTx
         o/XDuhHUFjcQllHcCPlBQ8XoyLgMpCyeJWXRDkiO9xdrTlF83FHn/WIh9amFyro9Lske
         kJj+scBCI9/qor6aJuFcLpSyeUnaWqBJ19M/jcejKvcadyUTbybVEk/xHGVeb7Av83IH
         3o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876887; x=1690468887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvx70z2BXZ1jKRLTnGgIZScDPe0wQ43yxPzL6H+ZIhM=;
        b=XoFJUlWc3jWEkz/TFjOtM1kCmYkzbT+0JBuhbz+ljsRUyNfihzkTkefP7m/f/7d2V/
         /H0cXh0oAJD93nA9kH1HtwR0wfXMcRQp/V2B6phJ36xd4XyH/teQK9X6QTb3fIMdO2Hn
         qxWZC4PPvwoVqFGrwrgqgsj5dofK1ZL2bB+HiAJmLE7JY9TELEvm81IPm9vAz9bvQKSo
         9xJKMsW5OFl3SSs7bqPiWKYeaAlwNLZjDS+h4JkFRtYlstzPHisIjeD+sG/urCjhMjfr
         UlWXWCU6ihQkzQNa6unc6VVVXh13jYZi1xxb1sK1BkdrBP4qbw2yt/Tin5fWs9PYukjW
         FNYw==
X-Gm-Message-State: AC+VfDwjiwYo3xel7GGe1dsrJ5nkxrjFEocCDATdEdgrO4pXxw6Unh5X
        9sbjNv9/MyVhNAjDgE4EUNH51UfOzwI=
X-Google-Smtp-Source: ACHHUZ6nZPPVo6NnLGWvrx06UN4ic+aERjNvCCvh/kEiThcLJ6a8VsL6j42uiDdsxLAZpX7O7FCJtQ==
X-Received: by 2002:a1c:4b0d:0:b0:3fa:e92e:7a8b with SMTP id y13-20020a1c4b0d000000b003fae92e7a8bmr3169540wma.13.1687876887432;
        Tue, 27 Jun 2023 07:41:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c365300b003fa8dbb7b5dsm7285618wmq.25.2023.06.27.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:27 -0700 (PDT)
Message-Id: <cbbc1462f58f6ac01a215865d65f6b62f0dca95c.1687876884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:16 +0000
Subject: [PATCH 1/9] gitk: add procedures to get commit info from selected row
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

These procedures are useful for implementing keyboard commands. Keyboard
commands don't have access to commits that are selected by the mouse and
hence must get info from the selected row.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99b..a533ff9002e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1333,6 +1333,24 @@ proc commitonrow {row} {
     return $id
 }
 
+# Get commits ID of the row that is selected in the GUI
+proc selected_line_id {} {
+    global selectedline
+    return [commitonrow $selectedline]
+}
+
+# Gets the first branch name of the row that is selected in the GUI, or the
+# empty string if there is no branches on that commit.
+proc selected_line_head {} {
+    global idheads
+    set id [selected_line_id]
+    if {[info exists idheads($id)]} {
+        return [lindex $idheads($id) 0]
+    } else {
+        return ""
+    }
+}
+
 proc closevarcs {v} {
     global varctok varccommits varcid parents children
     global cmitlisted commitidx vtokmod curview numcommits
-- 
gitgitgadget

