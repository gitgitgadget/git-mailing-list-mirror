Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8691F463
	for <e@80x24.org>; Thu, 12 Sep 2019 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfILR2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 13:28:35 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33726 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfILR2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:35 -0400
Received: by mail-pg1-f172.google.com with SMTP id n190so13852883pgn.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PgoO6jSQ8CdQBGG39VCXJoe4XkOi3FfHvNUYaHQzVac=;
        b=RjkSwb6Ytv9KQkt0OciLIKHNnj7gRRwaWnMP1wzIbN8nl8gxJJFIl6/E8eWgwKXyfO
         sgSxv/RHHPdgPeUgyUJjTmVxgdUm8vlbwO+wbT82nCAIMdC2iKyialpkpuNjhJo+lAQm
         1LicxckoMsoLpsn0LSVdIscKK7pGWXhTEteeyctNQAp8j51mP9wOtKDSL+760nAyaf0S
         IBRYp+hc18MIUhXmj7YfQLGCDkw1qws3pfNnXB0iEu48qKXhAsMjQuVDGp7yi3WWGCWp
         0eLIzv+s+SXeKkACiwwrQKOUanmnuYUUqg6kdK/BvizPbYINOYr9HDDQgHOnWxzFw/dk
         35yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PgoO6jSQ8CdQBGG39VCXJoe4XkOi3FfHvNUYaHQzVac=;
        b=DPdqGvizoLHpbExuEFZp5tAjCB45W+eO8Q0zwh/QyT5VivaIxckx5ad/XvWh8j85Av
         mF/2smfoTM2oxR1hbP/ly1zw80Z4TSb4ciVPrfU/9gT9qpIV4RHbcbVwhQcdCtHXUbxZ
         ewZ60Kn3/7rCm3zjLwbmWHmr0Kjn4Z6vmg9/aoWw3HT3UzlmVNlQ67yl+T1l2yvcZLmX
         3UD58aZWKKbZdCs+brvAX+d77O2wLTGJi2+MTMECAWapSBCRZG2pux97wy6/glpvhtd3
         Apnz8U1xEziSLeG9Hgmx8WyiR6yX8mIuM9tNb6QJ1fhO1rLESQZj/XOCXfbdqm5YRo3q
         a5og==
X-Gm-Message-State: APjAAAVEprI/Nr0L/k0AHz5FPIvx2t1L3SLKF3uSLixoycUjO8OHxMLw
        Rc/LbSybbXrR8xJYG0naaZTCmX7xxjU=
X-Google-Smtp-Source: APXvYqyjknmwACC5aoGGAEdU9eA24jzbpJoa7TWAl32SkbHRcmzcJyzTjwdAKTUQUiGHq7JjNOhFZg==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr1351842pjo.119.1568309314402;
        Thu, 12 Sep 2019 10:28:34 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id y138sm13401720pfb.174.2019.09.12.10.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:28:33 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:28:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
Message-ID: <239ffa690cc0bf65e2ee7fbdbb9c481499e37020.1568309119.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568309119.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, $(FIND_SOURCE_FILES) has two modes: if `git ls-files` is
present, it will use that to enumerate the files in the repository; else
it will use `$(FIND) .` to enumerate the files in the directory.

There is a subtle difference between these two methods, however. With
ls-files, filenames don't have a leading `./` while with $(FIND), they
do. This does not currently pose a problem but in a future patch, we
will be using `filter-out` to process the list of files with the
assumption that there is no prefix.

Unify the two possible invocations in $(FIND_SOURCE_FILES) by using sed
to remove the `./` prefix in the $(FIND) case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index b88b42d7ed..e2c693440b 100644
--- a/Makefile
+++ b/Makefile
@@ -2610,6 +2610,7 @@ FIND_SOURCE_FILES = ( \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 		-o \( -name '*.sh' -type f -print \) \
+		| sed -e 's|^\./||' \
 	)
 
 $(ETAGS_TARGET): FORCE
-- 
2.23.0.37.g745f681289

