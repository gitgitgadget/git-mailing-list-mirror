Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BA1211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 21:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLDVYX (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 16:24:23 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35230 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbeLDVYW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Dec 2018 16:24:22 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4LOHgm007601;
        Tue, 4 Dec 2018 13:24:17 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p3s1r44r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 04 Dec 2018 13:24:17 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 4 Dec 2018 13:24:09 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 4 Dec 2018 13:24:09 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 7ECAF2212481;
        Tue,  4 Dec 2018 13:24:13 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <j6t@kdbg.org>, <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
Date:   Tue, 4 Dec 2018 13:24:11 -0800
Message-ID: <20181204212411.11572-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.2.gca0e531e87
In-Reply-To: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040183
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Dec 2018, Johannes Sixt wrote:

> The text body of section Behavioral Differences is typeset as code,
> but should be regular text. Remove the indentation to achieve that.
> 
> While here, prettify the language:
> 
> - use "the x backend" instead of "x-based rebase";
> - use present tense instead of future tense;
> 
> and use subsections instead of a list.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Cf. https://git-scm.com/docs/git-rebase#_behavioral_differences
> 
> I actually did not test the result, because I don't have the
> infrastructure.
> 
> The sentence "The am backend sometimes does not" is not very useful,
> but is not my fault ;) It would be great if it could be made more
> specific, but I do not know the details.

That sentence is my fault.  I've been sitting on a patch for about a
week that fixes it which I was going to submit after 2.20.0, but since
you're fixing this text up right now, I guess putting these two patches
together makes sense.  I've rebased it on top of your commit and provided
it below.

-- 8< --
Subject: [PATCH] git-rebase.txt: update note about directory rename detection
 and am

In commit 6aba117d5cf7 ("am: avoid directory rename detection when
calling recursive merge machinery", 2018-08-29), the git-rebase manpage
probably should have also been updated to note the stronger
incompatibility between git-am and directory rename detection.  Update
it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 41631df6e4..b220b8b2b6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -569,8 +569,12 @@ it to keep commits that started empty.
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The merge and interactive backends work fine with
-directory rename detection.  The am backend sometimes does not.
+The merge and interactive backends work fine with directory rename
+detection.  The am backend sometimes does not because it operates on
+"fake ancestors" that involve trees containing only the files modified
+in the patch.  Without accurate tree information, directory rename
+detection cannot safely operate and is thus turned off in the am
+backend.
 
 include::merge-strategies.txt[]
 
-- 
2.20.0.rc1.2.gca0e531e87

