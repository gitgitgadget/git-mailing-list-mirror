Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916BF1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407336AbfFKVGx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:06:53 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:46253 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406793AbfFKVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:06:53 -0400
Received: by mail-oi1-f202.google.com with SMTP id x72so1232066oif.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QMZjR6Lu5zwTeDAblnuqe/ZxeGzF7hP5N2im5o41CCg=;
        b=fWXEqb2QULYgZ9mpn2BrbqKic+4bkyZ0P0XhGFKQzCTxMrlKUgq0DQVfAvFGIseiJY
         +BNku5YB4xs5y/KSQcN5YsE/Q7WJcprj/aT9yrScn3AelLzwk0MF2MpLmPXTqXKPmFrR
         zaEE8b43HHxgx1/eEYVsZf7S/ilJ+eK95VT7Aw58FG6xbsD068/1YZ/m3sO0hX7LrttN
         4XAJDKGlkA4LkRkn5yi57r5BrHZzCf2RIy6pX34bAnV/blwk/+7Z5OMF73TbHH+HHCym
         BixOZiIxN8dqAMppVGnBQVb7i43cmdmq4iDsaZiWWZilfJPyv+nodyI21pkwT7+jQ10F
         G1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QMZjR6Lu5zwTeDAblnuqe/ZxeGzF7hP5N2im5o41CCg=;
        b=F/UYUeX3eXwhk2INbwx6Sgofq1rZko/IEa/AfZ/NlMFdrIQ2sLeK90BB5Ha4GNoSpd
         O/Tl2QO9Jus8MAq0jjRcVXDuneg4vEL6m+3YhGXjA6X/1jzznuUsldYzlf8eTwJCUh1p
         Tbct5nALpTcjNIUYQCFnk9nY1aLL+fL4u25P75BoLLqa26+7yuX1bfPM94FRAZDMNte6
         JfeyUAvSPCK4iduEAL8fKBB3Pdtraf6+T6k4FKMdFP0RT5nBppEjr260CSQu/+jHXWJ9
         oQJWd50WgChlrFW1DbFtLNH3PpmM3gyL8tgsWwxcIH3fVkPch7Eh4r6b48x9IPc0mWj+
         fiIA==
X-Gm-Message-State: APjAAAUCbVcwA/G+hrb+Sw/eFVoK3vfCjsimEf904F7bRIz89WTIynPy
        KtLjIksYCbiOZrDKoochInW+AS54Z4XWUVJo+BsCjWwyA8uhn6mfsWsy81WyENQ0/t7ySeqIviv
        9JnGLY3f0esgSmnvmSPnRkZ6kWNvZe53BHOUffrou/3uZ0OtiLKiHpDZrq/T1EweBWs+Vb1qphK
        to
X-Google-Smtp-Source: APXvYqwczMbJGv+gYFdgUU6gcDdO/ukJS+Rcu0fx9T2VlXgEasmXIq6iXPUQpwHgzfcajCdzafHq1awbZlRgOs3enoBn
X-Received: by 2002:aca:3b8a:: with SMTP id i132mr15687989oia.90.1560287212509;
 Tue, 11 Jun 2019 14:06:52 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:06:46 -0700
In-Reply-To: <cover.1560286956.git.jonathantanmy@google.com>
Message-Id: <c09d6119e51d70390d130cd9c47ef8d363244f80.1560286956.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1560286956.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH 1/2] t5616: use correct flag to check object is missing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we want to check whether an object is missing, the correct flag to
pass to rev-list is --ignore-missing; --exclude-promisor-objects will
exclude any object that came from the promisor remote, whether it is
present or missing. Use the correct flag.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f1baf83502..8b9b471a62 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -359,7 +359,7 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
 
 	# Sanity check to ensure that the client does not have that blob.
-	git -C repo rev-list --objects --exclude-promisor-objects \
+	git -C repo rev-list --objects --ignore-missing \
 		-- $(cat deltabase) >objlist &&
 	test_line_count = 0 objlist &&
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

