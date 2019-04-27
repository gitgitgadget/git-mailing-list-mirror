Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E261F453
	for <e@80x24.org>; Sat, 27 Apr 2019 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfD0UVn (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 16:21:43 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:58074 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbfD0UVn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Apr 2019 16:21:43 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RKCjKF109730
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180315;
 bh=eaTVICmi/xflf6XJracF8McJcpToZdc/VgG1GVCpsMg=;
 b=tzl1khgDVi87HzF+FUPIB8/vBTBaGL/OJH8KFNiOR8jukVwAPfW4v2gJEhVhxeDa9Sos
 +zsKYK3yF0r7stouW/Xei3i5zPz1IspsHHnVtjoPTYDYtzvK65UT3UswZMHnODi2ytJP
 BNOBUMEWyObV8wdOQIej4UXr9oasVnxGuIHy9QE+R1UXihJE3/ZS0FXCcKqDOIVeIjan
 y3Nh7gNyceR29mBzBGbLC00G05mUPHtP9cfq/TRaK9cc2Owpef3nzDwP/+dKen2Ld9wy
 aZ3lcQVphYctLN4rBStbMLP/mrX6B66Kd9IC8u6Hj2mLkcobf5oktINp3M52kbesC1aB RQ== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s4gdfggfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:42 -0400
Received: by mail-qk1-f200.google.com with SMTP id t67so5839657qkd.15
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaTVICmi/xflf6XJracF8McJcpToZdc/VgG1GVCpsMg=;
        b=PVzuc8juqh1xWVEmlXQD1WTYjufAZb5+Au9m21DUsTbGUIZTw5Qi317KcSoAmTDCHP
         bqBBvq7G7Sv4c1UZ6U0bOv4ajJfoZ5kv4i9IGlqLbuEbEi7I8kaqurN0d2cW4OemVKJ7
         pMyWImYNW4S4rZDoXwxnGrzvgSwItUk0INIi3B8VcFTb51y/gnVIt194dgOBSN9dEHvO
         B5XIO3zxBhxx+5ZsbQfGvcrs89UZvVO2pf6WnZItTqefsrSm/tGQP+Z1LqPUJZ5+6YxT
         oBHGfM5qi/cZRg4x1Ka93AfpM25P4dovfkmL1nPMzE0cVolUpQhIL59r77Xa9yn8di+Z
         Gk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaTVICmi/xflf6XJracF8McJcpToZdc/VgG1GVCpsMg=;
        b=ahfFz9AEbT9aatcqPxEDxC0kLxYazFVNvxpZIfc0udM+7K+YfyHxou/kGzrOV0c1aQ
         +6OHbsrxaS3dTmlRreZrCyZVe1suvavGA2qVcLmvieKHtAt5Dd1MoF7QKktXGMTAfTev
         4qc1zbLjc68cNb9I7jEebvc6CxwFwGf8lUZhbVI2dRpMhYlqdAP9kDfx0N7/z+gZSs2C
         INuLkMzADcoc7KrCh0564ReDvWKLeCCCeUQndlITEe+OZc/+ZVC3cQrcYWoTpZvqfeY/
         36eUfekkJ0X9ADe2ZtDP9cmscF3WcnmW8m+C8x23WQw71Klds7tdHM1YUEXCTaZM/emu
         N0Yw==
X-Gm-Message-State: APjAAAUBqHoto5WpEyAWseLIiWceIrzQnrh86ClZZI3i8Z6IIQ4cqoxq
        OHPXZ+HAXHfyQ8sBge36Xtb9EJjplsFz8J2PEOCNbtn8/5eh2IHl6T3V52pu4mqDbcmNLWrwaUJ
        HBFu+WJJGEls=
X-Received: by 2002:a0c:c3cb:: with SMTP id p11mr15380415qvi.172.1556396500963;
        Sat, 27 Apr 2019 13:21:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUhXNMM7UA6lBninKqTI9sFN+gaBxqiJVzGVb396hI1aQiIGFGUIwMl/OdTk/bn2V/C+2FwA==
X-Received: by 2002:a0c:c3cb:: with SMTP id p11mr15380407qvi.172.1556396500850;
        Sat, 27 Apr 2019 13:21:40 -0700 (PDT)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id o34sm2901285qtc.80.2019.04.27.13.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 13:21:40 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH 1/2] builtin/tag: do not omit -v gpg out for --format
Date:   Sat, 27 Apr 2019 16:21:22 -0400
Message-Id: <20190427202123.15380-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190427202123.15380-1-santiago@nyu.edu>
References: <20190427202123.15380-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=952 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

The current implementation of git tag -v omits the gpg output when the
--format flag is passed. This may not be useful to users that want to
see the gpg output *and* --format the output of the git tag -v. Instead,
pass the default gpg interface output if --format is specified.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..449d91c13c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -110,10 +110,10 @@ static int verify_tag(const char *name, const char *ref,
 {
 	int flags;
 	const struct ref_format *format = cb_data;
-	flags = GPG_VERIFY_VERBOSE;
+	flags = 0;
 
-	if (format->format)
-		flags = GPG_VERIFY_OMIT_STATUS;
+	if (!format->format)
+		flags = GPG_VERIFY_VERBOSE;
 
 	if (gpg_verify_tag(oid, name, flags))
 		return -1;
-- 
2.21.0

