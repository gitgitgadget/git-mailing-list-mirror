Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F6A20248
	for <e@80x24.org>; Fri, 12 Apr 2019 20:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLUOn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 16:14:43 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:34416 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfDLUOn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Apr 2019 16:14:43 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CK1wsu134646
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=tJdS0UrcvJHGjiv8tNOo2ULxC9Ia6YJfFYjFxp1jPTk=;
 b=Oq8NEn4mVzGtma8bqJgYB87tWQqXNgd5vsepn4d4BdmW01VqHGbBlxhgMOxQnd745D5w
 jsAfPsjIBUEwcyqx8nvICQ0/Dvq7THT+GCAGPBsn8IBk7LIqeuBPSuy3cnpDQgfe5DZK
 t8IOpjfrdxEANUMmaUUsqmXo6IBfo4HSZw9ldpS87rP52k0zLvS5y835CvveTvKd3/Pw
 8PzUBUouNDOGQ8yyTnds4EP7OsJdBVd+2TsP5F2n4UFHmY+N19aIWhBR8hg64W1op2EI
 HYtrk9Tl7lfDXHleN1zjXjSrUMKl6JFGOLw67Mq+OzIS78TUb7obN+oUw5FIYqtH0Taz OA== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2rts27j4nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:14:41 -0400
Received: by mail-qt1-f198.google.com with SMTP id p26so9797532qtq.21
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJdS0UrcvJHGjiv8tNOo2ULxC9Ia6YJfFYjFxp1jPTk=;
        b=WwAlHlmwZ+oyNwkv7IRGmEbTDe8kDQlEO2hTsx9pKBylDSxfrjd220FSR5tBXGL2A/
         G1IUA/yv44eI63LLsKdM5kdoVPsypkckXGcXLYqsS2yojfKZhTNYkyFZ/eIMthhf85od
         A9A6ACU+o5UF9bXA3RN0JNJ3hTg5sx0PPrvtUdA9mMOOOsV4Sj57CAk8akAil7/qxiz+
         NDi9RlSDahzPS4RizJeiOsfDdP7HCm8DPtYyT1b6JHhN7z3Xd8upQXitEyT25XIctlCw
         kFWAdhX35Ro0+OTLxB09G19VpNfSaf14yC0U5P0rNOd+Dqfpit+J8x4f39u8H6f1EcIZ
         4KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJdS0UrcvJHGjiv8tNOo2ULxC9Ia6YJfFYjFxp1jPTk=;
        b=T1DBDEtch3tINKNiWQoubWvKm/0cvuCJehpmAE+oK/d/tmxdL+MZKs+FwzHAZs5s5N
         PHhBK6VYFVJ8r9OriVHS6X8gPiSoQd9u4ktQLfgOTThiyceSrioOs7JKaUfzbFtgNvp1
         3cwlgWOS7Am6/1AN7fdw+/qMdSmkHnX2f7QkTUkL9g/mY1pSsbiLZEVDZtf3oLtb5w3f
         MXVIR5aL9AtDWVacbUEDcY81CWZV3JlSwf6qjh80hFpO9HMTrbNh3viJH7iiertk8KTV
         CuIcxfGte2hrhbibhCrGur2tsD6LXRgIVmqfkgpXZ6vLlQtCPHI9w6u5A92BUcELyCTP
         F8+g==
X-Gm-Message-State: APjAAAX/85iKzEQnwpcrSo1+VgtKUDGabpTj1TKUqrWZyo4i5OELsGiD
        ooBlGOieVoOvPuPh19DzOUYSn0g8Aq7g77nJb8yQCVNsDqqMd1PpRIQk5K8NHORgo8+eN8sswmT
        Ji4UdQN1uA70=
X-Received: by 2002:a0c:d1a6:: with SMTP id e35mr47675699qvh.174.1555100080552;
        Fri, 12 Apr 2019 13:14:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHu5e5RCfnqfJVGL7ZbemNLPvNZki1zpd4m/5Q6aOCHukmiEPW9upciRQP1vVtI/1AXV/Iyw==
X-Received: by 2002:a0c:d1a6:: with SMTP id e35mr47675682qvh.174.1555100080403;
        Fri, 12 Apr 2019 13:14:40 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-150.natpool.nyu.edu. [216.165.95.150])
        by smtp.gmail.com with ESMTPSA id y18sm28626248qty.78.2019.04.12.13.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 13:14:39 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        Santiago Torres <santiago@nyu.edu>
Subject: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Date:   Fri, 12 Apr 2019 16:14:32 -0400
Message-Id: <20190412201432.11328-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Orig-IP: 209.85.160.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

On the git tag -v code, there is a guard to suppress gpg output if a
pretty format is provided. The rationale for this is that the gpg output
*and* the pretty formats together may conflict with each other. However,
both outputs are directed to different output streams and, as such,
they can safely coexist. Drop the guard clause and use
GPG_VERIFY_VERBOSE regardless of the pretty format

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 8c493a569..4b91c769c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -110,9 +110,6 @@ static int verify_tag(const char *name, const char *ref,
 	const struct ref_format *format = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
-	if (format->format)
-		flags = GPG_VERIFY_OMIT_STATUS;
-
 	if (gpg_verify_tag(oid, name, flags))
 		return -1;
 
-- 
2.21.0

