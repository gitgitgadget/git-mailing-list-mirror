Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BD01F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfJVKUJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44981 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so10348742pfn.11
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WfTfRLFhXz1RU/LqEDa8JaobLYBGmAz3HY+wZYyQVow=;
        b=ugCXjhN0yTfUcREmP2IW4rVrFzN6wu049rYkFEJN1yzZuusA48oWz0A53eYcmJz2zG
         Jg5Xsb6VtY3v+MJuZZTQ8ruIZoTCJEws7OvhLOrcMzzsUIQCCYSspOWDLK3lNBWH9kuB
         kMFM06RKs5RDjjXVn2P8UKiWx3bwoA2UMU2uAIKt8vE8JzSmQbXmGM/iM5xdELzhEAFE
         t9VH0MW33ctgkw7CsFym1Lh+m/NAlycdjkMhnmtjcubsZaCryBDA2Loxg5CTj+GzQzyv
         5amYcNSW9CSdeiKKJW3F7eDqLFPh0ZbrbPe8Rco510mbGHUF0kBt7KfsjsZjA8L00ruL
         LEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WfTfRLFhXz1RU/LqEDa8JaobLYBGmAz3HY+wZYyQVow=;
        b=GhX6cyp0oK1guzdSJVsEMc1fshxyZpHTTgqohvhmLaecSEjDWgP4IvF24hFHWHguR7
         kSs9GO0Ml7OiORhEQbLelbcepHOp/gn1REsmPrGU72bgUbM1/Sbf8iyW8unkvKobOfq3
         EF2C/pCMTDf+GTcklY5zRN9c4la/gOPHMea+l7TRWO8gGpqg3eJp0lL6zkE6ZcQxn/IO
         8c/Lya6bN5T06oN2qabYrs6oD9xfnM/IWklD8bqYt1CmCT7T2EnLJMxfm+nxHFlwXC/N
         RpH3LQ6fj1F5bsYpv9fax5iIo4JkzipenWH5Wbtsro2YqrWvozrI3yoxhx93uhqhBQo6
         ZecA==
X-Gm-Message-State: APjAAAXbWEv/HGZmfHdyokt7tfZsR+LBZzdmwMMYHbR78Ajp6Jp4sR8k
        +ipfNvKIGE+nEAnmu6HCetlv8Ibp
X-Google-Smtp-Source: APXvYqw/bUxtCmhVWo7JTgw5/pqqCRiJ7QGRbsOZ6epCcoEhCTCpxyAGd2n5ewJrbECHMWtFxsNLsg==
X-Received: by 2002:a63:6989:: with SMTP id e131mr2952593pgc.190.1571739607429;
        Tue, 22 Oct 2019 03:20:07 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id c10sm20679196pfo.49.2019.10.22.03.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:06 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 05/14] t5520: replace test -f with test-lib functions
Message-ID: <b696ff0a67024749b458902ed15f44cfaa4a68bf.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file() so that future developers
will have a better experience debugging these test cases.

Also, in the case of `! test -f`, not only should that path not be a
file, it shouldn't exist at all so replace it with
test_path_is_missing().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 55560ce3cd..004d5884cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -39,8 +39,8 @@ test_expect_success 'pulling into void' '
 		cd cloned &&
 		git pull ..
 	) &&
-	test -f file &&
-	test -f cloned/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned/file &&
 	test_cmp file cloned/file
 '
 
@@ -50,8 +50,8 @@ test_expect_success 'pulling into void using master:master' '
 		cd cloned-uho &&
 		git pull .. master:master
 	) &&
-	test -f file &&
-	test -f cloned-uho/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned-uho/file &&
 	test_cmp file cloned-uho/file
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	(
 		cd cloned-octopus &&
 		test_must_fail git pull .. master master &&
-		! test -f file
+		test_path_is_missing file
 	)
 '
 
-- 
2.24.0.rc0.197.g0926ab8072

