Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E821F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIEV5C (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:57:02 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50170 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbeIEV5C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 17:57:02 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85HMp5Q029157;
        Wed, 5 Sep 2018 10:25:52 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7qnmqebh-1;
        Wed, 05 Sep 2018 10:25:52 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 2D81922E02A0;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 214F72CDEA7;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     brad.king@kitware.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] --no-deref and --stdin compatibility for update-ref
Date:   Wed,  5 Sep 2018 10:25:48 -0700
Message-Id: <20180905172550.11621-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=682 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the --no-deref and --stdin options of update-ref cannot be
used together (the code aborts immediately with a usage message), though
it makes sense to do so and is easier than repeatedly specifying on
stdin that each ref should not be dereferenced.  Also, the documentation
for the --no-deref option has a few problems, making it unclear what it
is and isn't compatible with.

The first patch is just a minor code fixup that the second lightly
depends on.  The second patch has the changes to fix the issues stated
above.


Elijah Newren (2):
  update-ref: fix type of update_flags variable to match its usage
  update-ref: allow --no-deref with --stdin

 Documentation/git-update-ref.txt |  2 +-
 builtin/update-ref.c             | 25 ++++++++++++++-----------
 t/t1400-update-ref.sh            | 31 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

--=20
2.19.0.rc2.2.g1aedc61e22

