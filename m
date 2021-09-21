Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EFC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7184611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhIUQxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhIUQwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B948C061760
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:24 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o9-20020ac80249000000b002a0c9fd54d5so219703984qtg.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t9cwlG+FrGgkn5xv3ucIAw4oOscV1kNAZh0tFZOztbE=;
        b=QrOivPt1bp2rORltM4vpsut6RGW5noaUsY0ChETjHiss1oXppsmen3CWoAzKTBX4V1
         LZtp0JRTDbn5oLAm+WjsYAKRgWFm9BPbhe/Wz23uLGHYFyxdrvBoaFzVYF+F6NDnyBUy
         bQ+1M0+mqy2zb9S36oi3pD8puqeiiOqZWytsw4WbWBOt4rCvpu7VDrNuoD79TLp8KTxs
         H0itmMA06zJIYqZS2bXccK1k1imCSs2RwYIkgu2VnfQrA/P3KHDOBDO/3dJOvGKyVCV1
         vcpsid3Vfm0FePGGqDC7z+M0b6JEuxCaNIbwgLN6sZrYv29czhEpHV6+YHkXeZ3dFitG
         xeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t9cwlG+FrGgkn5xv3ucIAw4oOscV1kNAZh0tFZOztbE=;
        b=hRtOxhV4Nce10JqEVD+qLXbtwYW3RtiM2NitJiaWL9KFdgr+l0GkiR3quSboXqHXdN
         0nEJlTDjkyrT6v1Ysh5qR5GQm9E9OfvmTGq0i+ZCA+5M7Gb1T54oCfWsOvWwQpn4MJrD
         7CLD76ExV+Hr2Bpe2R73B1bKgVJpQkijMwo4CZMw6MhBJO3msjPBNMfm83MkQmuVyXx7
         Eul39qOuY8g8v5sVkcBLCtj2mfsHjs9Dc5ygab2qhsyMwbjZS5xaoWYkNIQ7CPab+dXg
         4i08iabInwbL7+LVXzowEysiHsKnh8WoFXDzAjkMfAhwtW8cmDjdkBzWUgUvE6UZDep7
         Zulw==
X-Gm-Message-State: AOAM532iti33dkQk0N1VcIMePueKznh5orVzRsiIsuZjZB6Rg/7YUNgX
        QdoaIOX6X0K3b+XLyWgC0WOpngEgyOp0awypl9hw308P585rExh1gJdCs9IbG3oatQrax3hnhGp
        Vuf3duQoFiA11MWg7r+V6j4xEin7zlsWQnl6BZxtrB8kBD1RjucWF8C25BLUvdGinfrfQqS4FgJ
        BN
X-Google-Smtp-Source: ABdhPJw1vFnL5DOqk1QEOG5SCkf9etm+JelGF04Uv1PXh7DeOwPeyWtsdJ72hgaLMz11gfJkajKo7HNeZ5dRAu2pNoEt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1474:: with SMTP id
 c20mr31643423qvy.14.1632243083366; Tue, 21 Sep 2021 09:51:23 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:08 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <a62741e779a7e7bf6c371a1cab4f87821110b947.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 6/9] object-file: only register submodule ODB if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a35e03dee0 ("submodule: lazily add submodule ODBs as alternates",
2021-09-08), Git was taught to add all known submodule ODBs as
alternates when attempting to read an object that doesn't exist, as a
fallback for when a submodule object is read as if it were in
the_repository. However, this behavior wasn't restricted to happen only
when reading from the_repository. Fix this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 621b121bcb..ab861dfdeb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1593,7 +1593,8 @@ static int do_oid_object_info_extended(struct repository *r,
 				break;
 		}
 
-		if (register_all_submodule_odb_as_alternates())
+		if (r == the_repository &&
+		    register_all_submodule_odb_as_alternates())
 			/* We added some alternates; retry */
 			continue;
 
-- 
2.33.0.464.g1972c5931b-goog

