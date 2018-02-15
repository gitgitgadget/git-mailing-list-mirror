Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE961F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164001AbeBOSQl (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:16:41 -0500
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:23424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163590AbeBOP13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8o3sHu6rkjUymqBr30CM6mUK0fpAASLNdWncZq/XpwY=;
 b=Vr0Gn20nn4T+A15EzcyKFdqnbtcQKBBonLEfal5si4USkb3trxxeXix3ypMgVWSjEHQXNcyp5i/IiA/bmo1YCbD3jlZ6klEMMDdLtuoGXO3CMjGnoW8H6qFX1gSKKJIpXgF8A9tenCvRKXv60wRlUAiLb4FLhoqPWu1ukAnD2co=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:23 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Thu, 15 Feb 2018 16:27:05 +0100
Message-Id: <20180215152711.158-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28b69668-e7bc-4c22-42b5-08d574889dff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:ssRu+CI2yx1LR9OeknscAaH/d8ePoAT8r0r8CQ/uRpe23OePqqSBrU3nYASGMxoHMIe3OAkaUBRAce9HYl3K4vDQ7DQ9C5a8J9caEN1dBQFAQ7J4Zx6by73HiZ6gp243QA2H4/lLKeQWN56vm2j/0nKHqbPUFnmsku0bUb7if5n9apbcY+olZneMK98VToUb6ugedfNqA0QHDfZcNbr1AsZ2LNaEQjPvdLn6DvKEsF85OCMHbT4D9tMlIwAqOwXB;25:exWrrU8B2xEq2LM7PKDadPC8ucMDfUqF9KI1DpROyBtWDiqidgjrJ+KVbTLdcvmgdpw5U7wHXYxIjHte1LHKhzvpYa9NpKoCN2DDyOgYgxhkv4MPaJbclSbsg0/fmOGPls5JqV+Ol47dY11YRstB4lwin4n2uYACvNqbp8z0uj2TFfevKJWfo2pQzEF9UU3ml+uvFcdNXKoPq9Q9DPq+gbsbfhPlgNa1sxCfn8211E1PeUhvTwoNUNQqSv8fUH0+J9/BYmChNtaDW7qkVeaemu3gCNvJ/U5blBy2wPvTgGBshlheO4Q/wG53LOyBcukvYmmm9SWGEt7iGJvjV84Eyg==;31:kQ2ExOGbat5BjPH1+QLM1nf1noCqLGb/c6TvjRBcc6MsUt/WRjVGDWw66mNZNkUCvzK6Z4zYw+Ib+7DL8haOv4hbHfwXCeItlKdgz7SEUBwNrxOHloet8S3Mt3cEo9lGomAQgg2X94/HaF0bD00D/903Hhrhr2XVjjg534pJBZsL+/qHMwgzUc7FKgR2bbRdFzH5CWHL9NycTkNTjTkPPRWt5UqIv0xS67BQq19PrpY=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:PLkUlQWd+E9AzyGdcwef91jyfHNKzRigzfkSsw/D7VvSnz2X3ceR+cA+IlD3mwGI8Oizu4GEqIDcJFEINQ867i+tOsrte/lqtZSitvKd/viF4i887RPJE/sB+I3ise55RbpGJbiYYeRyT5xNZTntz0ehixZt1+JPkLSMv91cbOZfphWm72HKLv0SCAU19SstyZ2xWoSfJcQ7Lwr/7HmKMe74r4XssbUmt6+gcmONXumEPeClI2wd3ldpuadnjMVDKag7x5Dwhod9nWIPLQvv13ObfKBa7Fhv8hlqv7Q97yJtd3l+T/M43FcDaM3CM+usL+zk14EFYKn54lGzSxoSM0SUNqD0qlbLXCPzzGcw26Znw3VaHBgCl/iZjUYk4AF8Fb/Fb1kle29muKlki4h438LPL3L5D0mlFGjCHX0FzGh3PmlYMhCME3JjLGLvSG+fAHaRv16oLVNvZLVQ2XvocQe4rBkNsARd6qpDcZsdn5gROcHW/oR0g861AvjyEltZ2jTzWtDfqoNMx+T6B14dmxF7XSWGbfPTJsWqLaDj1/TPXXeHEjqUyGJjk0zIOzhcX2FlR5Um3ysUt7hqXwJ/xnyb+1qHdrphNbtIoA+MH3U=;4:a+OU2yUlApBmWPLJw0OCoKvvLEaM4Iv4F5Q4pKxJPRiB1ZFrMFUWPh0cdYSVIjPX8hVYMvfIFl+WVX66xhVBvt1UkkFyupK3ItddNsOH46tVsoOydKl/CJ7nzui5DQK0xD4ejcTWOp5b/3GZXgXL4Q0F2VNJDs5HEyF8W5Uvq1qM+GvMtW0H6dxkCrUCb+rAuBJHYnNcdG6ixRUb/UC7xj1R4hSATtzbYB6+QAgqQePUVdClzIiGOqFiRVtiDh+nOsifuxANj4HkpCvOAn8HelrPq8z4WW0/ccNZ9QO9q3cERGIStHRRjKS76QcTurMX
X-Microsoft-Antispam-PRVS: <BN6P136MB002091D5A13F4BB746706116E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(377424004)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(81156014)(105586002)(8936002)(48376002)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(59450400001)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:4Gc4NfGOHzuHnqwT1wPGpkbBEEw7TaaNwKQ4FwX2+?=
 =?us-ascii?Q?2mmwNcg2pJ3mM+121A8gqNtI56Nmw512ypG+XtzpxlFn9SudWni+PbgcGABM?=
 =?us-ascii?Q?/f9e6E6tZTp0X/UqAMUJLqXUCdx96FNJ71mCKQ/julHBDc4nk3mgOT/wOYSg?=
 =?us-ascii?Q?NbAtQw2czhrhT2FUrjQyda1hEhpFpWRbdTs5rppVK/30eNaiePg3cNdt75Bu?=
 =?us-ascii?Q?tIeEGpb57tkKQllFh2l1pZNq97Y0myJVdw6cOK6xG2N2+hzxL9cr1v6nCDhu?=
 =?us-ascii?Q?nA5ueFPIgdXgigE5aD4e2FcFfKvjr6D1lj4cOt8ZP/16oje8eQNuCZz2Ldin?=
 =?us-ascii?Q?G8po3FJmhZp2HlDSvR44VVUcBWM9XtvIWldoiX0B+Z69DcWzYCnwJ7uzVVYU?=
 =?us-ascii?Q?RbOojSWN1MlSGguf8Rcfl9DnjXankQWtvDkzup8MZApw05/5N5PGOgoM8r6Z?=
 =?us-ascii?Q?L388RndwICCJJQxH9AR/36OivVsgpaqs7S0HLgIl3c/G+v9y9LMndTNb3sSb?=
 =?us-ascii?Q?riGHVjVMOJRmJhzSfjjPBuyMmm3+5aSAsCkQ6BImOhxbv/OCY//sbnoFTmhu?=
 =?us-ascii?Q?XTeoDG4vGWgjSRfiPx6RprTzqbey9JecdDwHQoC0oY+WanGWe4d+jGTx5X8R?=
 =?us-ascii?Q?Yock7SWJQUCXme3HjxvyTgUV+KOZ7Qvb1eOTJvk2GEUayEmG0ohRDx4Uq/mZ?=
 =?us-ascii?Q?z4ltizHQF7NlPM8Hy7zCrqvWWXumRqIKfKNPpw/FrlLsdTe91nI72driBKYQ?=
 =?us-ascii?Q?l35MdietpNDZcNVfUAkwlkFs9yfunjQCJHxHVWPLnsi2ySmY5krvpebPc/kp?=
 =?us-ascii?Q?Q3WgeIU0ctIlNbpdEPVRUkfQcnC/UXnDxgCFR8Lc2nOfR6a6D66IXZ8Of+zt?=
 =?us-ascii?Q?c8jcSC6k+9yD0LTrKxnMWRBkUKv5TYgYRT6LE9YepZ9HZ2HmqaSDzeHBjoek?=
 =?us-ascii?Q?h91b+CFmqaebgAgW+4BSzOQoUHTRMVa/p++PeU0YGKpb8nfASMGE+1F4yVri?=
 =?us-ascii?Q?CxcL4bMxvKHyT/OPRn1koOdd57evzQF2dLvrIkn4OvNicurZlmJ4JwDDPW45?=
 =?us-ascii?Q?ultWg8/REhtovAWb7TKBGTt3fz7V8UFZjYol21eTVxS6/lQjjBxHwR98jyqD?=
 =?us-ascii?Q?t6QIDSNHhHXLkZHdL7H1DigWTMxjFwYnoO2Nm0HqGUryeOmScwpcbaJErOCp?=
 =?us-ascii?Q?A4pYy4X8Nkn7+5Le8O+NRy5qf4RmEfIPoIQZY5B+YMRFylEt9qqXr35XeQAx?=
 =?us-ascii?Q?bN5zXt0DSObmZ8NceKDoIFEEAewE7TiwXh2/kvWpxq4LDnrYwh8r0zwWs7V4?=
 =?us-ascii?Q?P7YO38LixbYxhdBSLqJM+Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:ktL35GDEn1gjyBspAhql/m2jQbn43pegzVa0JTw35rhSeNpUB2uJj2dlvKao/Sp7W5lx9nda3c02Q1hfhd/KEvWsNhufl/MXSOpbo6pGnTVK9GMkTUarHBxRYjWQ6E7Q0ut+zEOKxJfeLz9mgiDOXqVMzdvTiVHW8qeiyPDUJix3ciWfZCep0irX06dvr8+//0uIFfK1ki9f76z9fdtIZCW4Y3xjPaI8h2+aTkI9p3TcRajIMNFTl1vrhn1zrHdkLnJazquAsaiAQ9z9DCF/MR+bdoD45rkAwFQgJrRAQ1tj+tb8JrvoVdEqA2HUUI0qzV8OvF8jYqNLTOqA10XrpHR/9mDyKjbOPM/U+a7aWLM=;5:qZml9bs4HcR6GkrTY6V0c1HBSZq9oeZcXkhY84hVjd5Cbl++xrL9cHVjivO0DNcAAs8xD3Ce0ZOrc5cBEZ++Y8/k2F3s3wt1Df0toNGX47KeFvCAKmgVxwCSm4L3XD2/b6QLEmdHZhuoPwTsLDyNqli+6HPELQGMcnlmCRI1iUo=;24:zWLYww4M2fNJRYf+8AxOVi/JlnOsEIzQC3iwSNgd71umzziEnsqSKn2pMZi4RUzCJToZ67W8kZ8zjNAkmBT6fH4RQq5kaOsVHYxgmtHS5WY=;7:Z8+kD5SEpC2G5Ijv3IQn+B3L9f6Z9gqsq6v1gPHABkc+kt93fAcYQeQWZ0gD2cE1ed7nse4fobe7dz0n1Oj1/IvMG/JGoEaZwcf/cbclYwBB4fkix8iPlZUJ+hzgVgDQfJ7R2N0OSR7Sh++xpSMe9Mnqj3fAtDOTMeBho4BmdjJJv0TSCOj/DxjDPxhKY1Yga7Mz7Zb678Lr6jTWvj1sARGXHb83qf9EYE+Rx+ujRcVSFf4LbTOVbObd5QEV+N0A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:23.9481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b69668-e7bc-4c22-42b5-08d574889dff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..55b7daeb35 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.1

