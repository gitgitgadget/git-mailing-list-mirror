Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3135D20281
	for <e@80x24.org>; Sat, 30 Sep 2017 06:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdI3GW4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:22:56 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:47869 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdI3GWy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:54 -0400
Received: by mail-pf0-f170.google.com with SMTP id u12so797564pfl.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P2Rd71kECELw4jqkq7Xd3T09OFneyAvk4DMLK4GB9RQ=;
        b=cQ35tb2auXVsaD/jLladWdthghr3me+KmKLHipVoSyOzYPnweOVG+AxVjgKmYRCkyx
         xqY43JLT3gLJUBT3WGmKPq5g4Sf5X2TAF0mlRYcUHsT2gHEPfR/N4g/5s/ejYJ0jgOln
         Z+zK54q9pg55GKa5eK0kz95dJc4lbB1fkgrmnEGpfkUnB00oKu0VPzj+YydDxp6Nd+ZE
         K0q3aUcJGRjRtA+Li8rHzGF7lSsOWoUXME1UFMNW3g1zA/XBsrN64R2/f9W9EarjcxZU
         lSUUpkC4qn+63tbhLDYnS/SQg9PC+EVuiiVO0Pen6Nl6fFtQ4O8q5060MXoRIz5yPETd
         cgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P2Rd71kECELw4jqkq7Xd3T09OFneyAvk4DMLK4GB9RQ=;
        b=jVYIj6ZYhXJhXLIpIdS7BzKxnKdpVYH+/UeJsxcNiSroInNn5NT/tmKF5CsDJRz8qh
         WXFbWsZ3+YqLUhiji0jzWF7irzC1wSXo++8wfE4nTvLOlS2igqpGT1ye8Yq9QNlLSliK
         b6HYOg3IqjLLhEPjyB1uG00ehkrjvuefmZkhLPgnfps72yQqEAEqqPacf84I3BnzTlxm
         gJU2j/WqRVx2OvGdPtY1dCV3PtVzbHmTO6l1DghVcV0IKK30oUOpHgZTXVNM7uVOXsEj
         jxirNrmLP7OstPwWkI7+XCHcNDNXMAoOjsaPPFpRmMC1H0paNr7lFWVuXOS+BNbU0qt5
         4cfw==
X-Gm-Message-State: AHPjjUj3rKLz0OtUQBkok78LojdBzE+JS+RoC0kdmAOEN6MaRMfr9Qdw
        MgTc965x5giH1oabCN30gPp4pXkKgZ4=
X-Google-Smtp-Source: AOwi7QBn7OJ9LTLoiLVAl73o+HxRw/M+ZYMjQZHIMULxhgcdmsfhUUot7sFP8HRSeBJLSViynvPTbQ==
X-Received: by 10.98.15.209 with SMTP id 78mr9897378pfp.87.1506752573295;
        Fri, 29 Sep 2017 23:22:53 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id y7sm9078388pfy.35.2017.09.29.23.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:51 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/5] ref-filter.c: add trailer options to used_atom
Date:   Fri, 29 Sep 2017 23:22:36 -0700
Message-Id: <20170930062238.87077-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
References: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for "%(trailers)" to take trailer parsing arguments, use Jeff's
convenience structure for trailer processing options introduced in 8abc89800c.

We will later populate this field from the arguments given to %(trailers), and
then use the trailer_opts instance to format ref trailers correctly using
`format_trailer_from_commit`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ref-filter.c b/ref-filter.c
index 467c0279c..84f14093c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -82,6 +82,7 @@ static struct used_atom {
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
 		struct {
-- 
2.14.1.145.gb3622a4ee

