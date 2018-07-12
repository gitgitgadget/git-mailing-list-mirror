Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FA41F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeGLT7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:02 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:42212 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeGLT7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:02 -0400
Received: by mail-yw0-f201.google.com with SMTP id r144-v6so18667727ywg.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XfPP60whMlE2PCMkhx5wZqYkrrSb+TsbpNIxUxvU3vY=;
        b=I7HONdQ6N/QEFHk9rB90ZqXBfevYpYKf12gmO89IL75Ar845W8i0RN5S5ub3283Iac
         uRKWpD27SN0MI/VbKh2N7cGtgOC8XfjoNYw1wBFbOht0PHnj0omVkvGDmndq08rPLQAQ
         eYbsnLyXaw6yZ+VnEpS92d6JqFlTBFd0Jsv3jHFF38GpdJB7rmZQa2Z2VQMHJ72IBalt
         RDqBFacBlyFiccqX0V+p59CLNOpNZgrTG1zoyEdNnwFekVzWzymVDhQaYXHZHZ3m3nPY
         ySWVVnKiKMtwfBdV0G8NsFrdBlSKOlcyd6JgEIrUsAUNgmzRdWHgGGUoWyzoN4aZSdXg
         NGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XfPP60whMlE2PCMkhx5wZqYkrrSb+TsbpNIxUxvU3vY=;
        b=t4Op6UxWFa4JU4oY9KzTbjg37als2QN5a0/89BD+FAuLdJKsBATj0Wn0ZRvx+3Ppmv
         NXLC/pvPAaqNvR2lwHCkMoL6oSWWnlvAI9aXazfdNzb5TyKKlIeaWS+CxH37fbFPEFTK
         tktdWVMA5w1AbdvqKUl/okf8PtoscWjhtN8PXPSIOKo5m9qrTycqPiP6yMksuK+kidSA
         Vu9BhSrGKJuZFQupbSPnk+/juG18Zkqs+hY/P8oFPzHvzaTvXyjdP6PL/FB5WMQzppVN
         O8xNNBOg29kGWa8s+VipSUn8biCoD3ImEGayFzYhzLtR1xcEX/C5Pt6nNecGW6hZ8Svm
         3M4w==
X-Gm-Message-State: AOUpUlE3fFqu0Y/KWMZOPB7x0WKFP2zqG0jLDkIu66aoz3gn+sZ8o5sw
        iIr6yj0hkWobjeMJga8CgUQLlqvDQCeHkUZCFmM1xWKDsBpBF9LtFuT0JjTLY3h+kXXlUrAgpwe
        JN1KegceN4JFaTFB/153dhPQBiRooiZbuYA8WkBG65FcfOiq19E7S6uHdLcuO
X-Google-Smtp-Source: AAOMgpdSQ2EHpIbIlHDmRO4MozpQOTHpu+dKEj8oKGZOq0/rEPuD7rKOEO5+VfBQGCmIWK7J5w1gnlB9VcIb
MIME-Version: 1.0
X-Received: by 2002:a81:b667:: with SMTP id h39-v6mr1187469ywk.2.1531424880325;
 Thu, 12 Jul 2018 12:48:00 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:49 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-2-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/6] git-submodule.sh: align error reporting for update mode
 to use path
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in cmd_update are reporting the submodule based
on its path, so let's do that for invalid update modes, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5f9d9f6ea37..8a611865397 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -627,7 +627,7 @@ cmd_update()
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-- 
2.18.0.203.gfac676dfb9-goog

