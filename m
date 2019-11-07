Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8011F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfKGSvs (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34313 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfKGSvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so2616677pgs.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E3sVJOSprGW1kZocGfXTxKI4ScsS5+LToeKaeIpshoY=;
        b=qytDLITS9762X6kqEkwPSFkNNqG4ZGpG+2ejZPSHFtMr77qlbyfhN1duL6uw+CMszT
         m3vSvRgk5jU/4IyIupOMJvPxGQJ0bOgEyBh8vodPhVDr2J0YRIs90xkoa8bmzqQuTTkH
         chLpV3cjo8MFQ1mbucP0lQ5Po1Q1lqF0YUaM+WL+K6KX8wPmd9BVNyZvx19J77jy8yXW
         nsMe1Roxeem7dnDNsymHGpzpwElkAVqnbnelEzkSug3UPfZEK/2q0g1kmnGS8ZnaqgYL
         SMNoapTA6BQxGFm9is+d1OGheI63OG+gxaTgn8fM06uHykIe8jSdpek62PwWR8q6TGkh
         5hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E3sVJOSprGW1kZocGfXTxKI4ScsS5+LToeKaeIpshoY=;
        b=TyJVslDRA6YnihXKy/QwI/oCGQFcbGRHV895uYs75P+0UzLS0ITGXUaIen+kXN8rR3
         4jn+VxWMWInp4pYTHbuy1Nc/rCSf1qqo72NxxyK11nIvUi+NvF/0nlAIWVFP+kj4fG2E
         z2RN2Q8lUWoMtkm4lFPrsAyYUPw6i0awlEAtV0J2oObEtxQsWxoO50OAHgoMH8lv2yZr
         uG6TKTxAXDUJqy/Dp0G3PyG8uT7pAnPHMQSxhGubhYBlSAAceHrQ7rzNMtYYidYYU9Yn
         kNB5lC8bADnhna+VPtTzaYH/5xHPGrqbV6+zh9/rY1WuDQd1zY0F5qM1/1pESUdza3yE
         fsfg==
X-Gm-Message-State: APjAAAWy/FC3+w/RhX0NKcVeDd1p8xqY28DuCNIuYhMDlZx/QTva3gln
        4uYJwAfVpj6lywTwWISBq+pR0SLi
X-Google-Smtp-Source: APXvYqyNxK5PXVQjqTmCK/ibCT3MFsWKoz4fhXiCI7TTV8gMRZKiJjIf4I/W8AZ4xH91ED0HQuJqsg==
X-Received: by 2002:a62:14d0:: with SMTP id 199mr5900211pfu.147.1573152706166;
        Thu, 07 Nov 2019 10:51:46 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y11sm4218242pfq.1.2019.11.07.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:45 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/14] t5520: don't put git in upstream of pipe
Message-ID: <acbfc39cb0c99a979e198cdfc35259bbf13ae06d.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the Git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8b7e7ae55d..8ddf89e550 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.24.0.rc2.262.g2d07a97ef5

