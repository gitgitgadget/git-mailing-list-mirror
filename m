Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AE11F453
	for <e@80x24.org>; Sat, 27 Apr 2019 20:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfD0UVq (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 16:21:46 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:58094 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbfD0UVp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Apr 2019 16:21:45 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RKDsNn110670
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180315;
 bh=GV+rQ07xi8j2LtL6XAUoM7MZ57iSwn8um14QL8fdFSY=;
 b=tszOoIzq3Mco8HlhXyGzDSQqmLWg33Op+zkVtKa7Q73GWzlb/bNSMfbZbkHtWumrnoQF
 Qu2XZ8RVi1KNytHQ6j7EG9Qa/RXTNGxQ44E5TdMrNuFvPipztj6waMalqGw6S6Q1zUIB
 +EKN80BOoM85aWXD7ylaUzodOAa1Uj+7LB9gkhJUNrRwO111asCrho3ZbpuU6lKmiiYk
 zkJ5m2IsMqELRLMFnLJx2KkXu7HSwPScq2cAhNMoxSVRHYoH3V7wMUMWTVo7yT1xf5qi
 FLjWW+uEcz2b+AueBZ9m7mYfrfOnlAoTaKqqmKefmoq+Qm8wiwHjfJp5r43D9Nh07hBU CQ== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s4gdfggg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:44 -0400
Received: by mail-qt1-f198.google.com with SMTP id k20so677626qtk.13
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV+rQ07xi8j2LtL6XAUoM7MZ57iSwn8um14QL8fdFSY=;
        b=WfifTL/CHFCu2GSUwRFnV0Mv29B4YMqiy8EmKthsSYlWdnoTBeUPsQGrUgu0w1V/U3
         gqysPqsFfeyFCz7k+yG1ZJDbCLStLXP67M+h4Luc4uRLD0VP4lyyNW13OB8bQ1yhGo3z
         irs3/P3wa/AMztwjc/LRMBwXXp6dqDItX0CNDqYnnp6JfDR1qsesP2zfNeXCx/CsXjC0
         zAtpP/s14K1yKtef2PxDyg2vnn8RVDtDYrvHL4wxyKDrdGdgXjyhg+TE2M6hzZqz+JhX
         tGYo8Ov2FMmDLU4MNslDB1Q4VD3vKCVa9AkAWKW6oG2eltKmVnWDCvmXv7Aj+SRZQd33
         OoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV+rQ07xi8j2LtL6XAUoM7MZ57iSwn8um14QL8fdFSY=;
        b=nbraZ5CUoLHilU42SUVFk8+XitgL06/zqzcbsVFe0f9QYDt15NQheV6Ld2EW1iHLzO
         ZEvpIJeu/sSauQI5xxllWRJL7x4d9Kk1uLA47bkaI3H6gRF9RLDxWGGf2VioaooFbMwb
         fiNx2I8f5V6E1aw6pcY5+G5C5lBknAUDAOac6DMDhTa3vHekqmOtuHNhYkV2Ff4zkXkG
         BjzPsnF2ipsU8OWzPdj3I6GcTvxDlzs/Pvk+jCNLz38gYCFpZ7QCzGhIi9USoFswUHyK
         CBhWurpfyZKmyXHxtU2gg3H1J0oVI0TgJQjYr3gIprLTpJ0IeR12eUtZFzD5cMjGgUec
         r7jA==
X-Gm-Message-State: APjAAAWOXB7wBzI0TJL0hHDrcZTXM31o0NkbAd5Shqjd0Qpv6rnWvWfe
        mobrbuC9cdRD1kJbvOhfMYstQ5GGKV6sKdVKmC7/CTULvNQUM6u0dOa6YQUgN/mtiMDKQKbiwcl
        to3XqwLquQyQ=
X-Received: by 2002:aed:3769:: with SMTP id i96mr43526624qtb.296.1556396503589;
        Sat, 27 Apr 2019 13:21:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+zbJr5SG1SjWgC4miiO0llYHleGsV62s5RiPzB0S01lz6Td3ntB8ZO0/OZEHXvzk/oeQqnQ==
X-Received: by 2002:aed:3769:: with SMTP id i96mr43526613qtb.296.1556396503458;
        Sat, 27 Apr 2019 13:21:43 -0700 (PDT)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id o34sm2901285qtc.80.2019.04.27.13.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 13:21:43 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH 2/2] builtin/verify-tag: do not omit gpg on --format
Date:   Sat, 27 Apr 2019 16:21:23 -0400
Message-Id: <20190427202123.15380-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190427202123.15380-1-santiago@nyu.edu>
References: <20190427202123.15380-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Orig-IP: 209.85.160.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

The current implementation of git-verify-tag omits the gpg output when
the --format flag is passed. This may not be useful to users that want
to see the gpg output *and* --format the output of git verify-tag.
Instead, respect the --raw flag or the default gpg output.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 6fa04b751a..262e73cb45 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -47,15 +47,13 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_tag_usage, verify_tag_options);
 
-	if (verbose)
+	if (verbose && !format.format)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	if (format.format) {
+	if (format.format)
 		if (verify_ref_format(&format))
 			usage_with_options(verify_tag_usage,
 					   verify_tag_options);
-		flags |= GPG_VERIFY_OMIT_STATUS;
-	}
 
 	while (i < argc) {
 		struct object_id oid;
-- 
2.21.0

