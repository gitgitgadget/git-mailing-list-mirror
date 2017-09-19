Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B6420A28
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdIST2g (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:36 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:27081
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751309AbdIST2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YH8/DQUqmc51vGD1ES/klvVA+BQWlGbEl+LLClr2d7I=;
 b=avsPATw+MQmrxvRjHIAaFVmtfV/Zo+P1t8wJel8l7G8NvVzJiPJT8caSnnoOtW7fbTiHsAAhoUWm4ewh8OwatjfBTFiOxITzA+8tQ6Zgqyic1xP5ql8w0xNX6YfsagoItY26Poeef1JTM0FEIordL1uJ4XDVCY/lAXZSzq1ltjM=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:26 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 02/12] preload-index: add override to enable testing preload-index
Date:   Tue, 19 Sep 2017 15:27:34 -0400
Message-Id: <20170919192744.19224-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-Office365-Filtering-Correlation-Id: b1b6963e-a80f-4375-16bf-08d4ff949a26
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:Q55yM1yqaYIuv4gR3dRejK1QbzpWB+sC9n9Lf0+umcZCj2tKrh9W3a337I1BpcncVf3eZN73P+D0+/ErmsxMG3NDMQR2nSn+WNnzEDaM8ymAEhp1vIURkUfTXB+QQqzbrJ9KWzIaSowvO0KIKnaZEkblT6+6IynFBvE+MhhmYEI1QWPiau0ws+D/cbruFJWuGfgOa6valbHiL/5avXQop8j6S8O1RGu0banID2XAs43wiIxiZN4N/fVnGSWNlEhd;25:UOit0O8NufhWQF1W9FpF9rYqT0WGK81k2Al+eMaQblZPsTcYi7EEDMAvBxZ04UbEHt1zpTtfsx7B41hlK4FITU1UXIt4Hs+5jMLiGiSiIRsrKJp7uDf8twytt/Yiae/dFEGIqThsTgounBseBVpLmrhdVtCAlZ4fE0xBtt5X46hp4fnJfJ9vvMSo8DRfwrS3gPW+9+5hr6rz0HgUhyDrw+6v2AU/jzO6R7by8TOA7vUlmbOLJOLIDxsnyJN3mpXtY6piXJQ0/xEdQ3zen7GL3ZL5Mhvx6CNUkROy2Ode3K309e9ncQnlZ4PgAzYnC5if634aMXrtpgJiJfHGN6IeWw==;31:vsazcibXEP7PRBDhG7erLOcSUHP4iK6OXJg9K5EpD5iBPTgf3jFmU+SU0KE5EDhbwYPyEBVl6gaml2vCISAb+6M4Di1TsfUR8Vn6YHh6SR7Bvy2EVfPoeXnRJBAHK2iq1ZTbWUTSrqdc21xyr+bUKDciCjLHJV8vKla74W4MoSczCA8i06qoKMPJ4lN6IxsE54tmX9O45xg5pl+6qMGkNYMXfznr09XXoaThWDHNX7w=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:C8RwHjjZZyLtCwm8Xmg+xa5Ej6utQt2DmGjEDhXMsoQBfZG9ZnU1TUBUfR6HclGmQYKOn1oiEFr8YrNlKGEwCeuyVKKl0YNDoLaBFsxlI/B8n4XBs+WUY4NOHxnURH1kER8bn0TDzUFL58LO6QJTmwa8gHESdXhjmeLv8xyXPw3W3VSIuBvj/R18mI2Knd0fdCc/wZJaQth0ZzEI8zu7A1sVZXmMS+nw9TWpIwnkcFYsPnZI00XKaDJN87kKtY03Bq8e0hpEytGToK7UM4yfPcoKglfuCPUAENSQiq9H8GVgFzQK+3GqvvQ9dw1LGzr+CgiJqUO19+a1IbaBX8yaLPOqTJSEPAZeO5qvJ3YAsHHZHuhUuGW3Ee6krSHZ4ATRrN3xwmKsXVWOL1ho0Vu+4He/Um+8lY5ss2A0XI+eRNgC5SN390hHjNj+auArNqwVE1SMK8LZSEY3CXXbf5tXuNNA9ON8T/BToERrKAncOIPQvOFLZlzzQTXoZskmApg/;4:9eSIxYno/mBtnIpxYidGDcsPzUcrJjsX8q7wYPgJx+1kWkUcPZ+K6OzcDB9fb7U137SY4Jg4LJ/4P22jbGSeIICD3DNGW7G2GcXZUmrWFVIgO7zRw3I0hx3FVAJCr+HqW/FhhEirrv/W7kM2uAGzK/gE83WJ5qyLPkM4qzEXsDctlcU8F9kyfZQZRrmXhs4SuvLpomS0g1m8P8l5AuzTBiA+YvgCVGjepXVJKJk/ya3bmlJUa+lEcGcwZte8OkZbZeO+XpFsohu49PzXAiSspd3iXVNFeZrnaATnJpRiqRU=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471C5D1CE74F1ECA8F12080F4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:BWMwUk3ITXzY1qmLZZuoUcl4X98dy0yvBPmJivr0/?=
 =?us-ascii?Q?HfN1PTPY5Ijf8lXZ1WeyFLkLcfrhGmV7bCFeFBrq9DINO3JT2dN3FRVWSZgq?=
 =?us-ascii?Q?GPsNUtMInlALYHWgGks4M/HnKiPW/MBs94W1dAyIVZ4vG1pTg+xVEPoJNnHp?=
 =?us-ascii?Q?0tj2ATZnmLeg/vHfAKrE4FtEg+akH9tcm7JSsSLDiL1f9fm02OokBlRhqWN5?=
 =?us-ascii?Q?5QNYvMKf9UZ9EDx0BXfFt1EFew+t8p/wFMJkEQVRvTohdVo7H3j1u2rv49wi?=
 =?us-ascii?Q?Y8RzC7D0Y0iC3EHQMioTi3iDiefSKzhdVQwP5eQa8s8RSMaaIuqYGgKDgDPJ?=
 =?us-ascii?Q?+O6reXrqXxZThJPsJ3BNF3Fj2s2z3y5bVPzwCv28X+//laKYFB5Cj/l1ymAa?=
 =?us-ascii?Q?+UgzkXcE4UjVgCcCYDGCm46Y2LSv3GrpBgXLTIVXrgiYD62RYP1roW9xFTZq?=
 =?us-ascii?Q?xv2J8bEfNtDFhF8/kap0ybZ0iuVWTR4uC8NT0Ne5ua87uXSucqbgQ1ha7fiU?=
 =?us-ascii?Q?wgnAuAjST66aSYl2+CBHo5ffWBw+Rdca5Q6VpsAHPZOrDacD6yN1EHUR6jCy?=
 =?us-ascii?Q?hmTpK2aBDsy4y9RBAPGOuIKRxGvu5RUa9acLm5dmb1+G2bbDYy7CNLQhXqNU?=
 =?us-ascii?Q?ieZh3UqDyAiZX2qZ1LAfo0ybDtOpL/Zw0MuO/CICiWSIJg8DfFLnhKE04WdT?=
 =?us-ascii?Q?fbX6DIaBCFIJRqvJrNuVmw6aV0RJ7K/R9rHG0mQDaqZBQoEPUkxZZ51J14jb?=
 =?us-ascii?Q?SlSUWkGx4eusbu7Xw5rOqWVvjx0bOM8L9WdxR+tjO2UWzGWixuggxKXf8K1+?=
 =?us-ascii?Q?KERQdGdWRusG/ieywBScZqiWMRcZ5HJ4IspbqJ0HE5v9GDv0Y2ZD+pFoyPBU?=
 =?us-ascii?Q?gU9D0ZF/7wiqFMAB5136HqpNB7Kn+eys+9+eQU7LdpO9qQjYO7BYHbMb0z0f?=
 =?us-ascii?Q?JRIYfRU1PG8Jl0YhrRhcH4Dh7ssr1b5PpzY9y/inOHhsDYtrmkgvIjIFnLgb?=
 =?us-ascii?Q?++9eqjIraMx4a5NnwYQWDngC778qUVHcOoci3KTAhqZPwlNkcnjFZboW1M2V?=
 =?us-ascii?Q?mC/sgb2PcAdnhNF6RwyvzIGFbWiclUhcdxJy1lB4MvM+MYv7gQsTxXqPA8GL?=
 =?us-ascii?Q?Uni7bkf6ydCEbypxHoF/8JGy6D1IrxMkRoNm1hSqx42nml245HPFqnuEJkoO?=
 =?us-ascii?Q?9kTgy499gGrvKG1K+K3wtezNHELZ767MJSyMPS1BURB/DfGGPv3uXauLIEsm?=
 =?us-ascii?Q?wcRUbQyCqg7p5SOKzSVDCdxxodjtAPWMd/qyoPQE3mBXStULhprYH9y1DMvh?=
 =?us-ascii?Q?8s/IJfcQqvQn4SDMr+fBO2vhjbe0XpCipTUcoMgPoCRFIPr89Ufi9W95q6NA?=
 =?us-ascii?Q?V6O5IddAzcqNmGLa7d7s+GE/3ES2oTdfAwR2enJjhaq5gmmuwbL1Smoggg/v?=
 =?us-ascii?Q?YsyR6QFFaeO1fSdTFli7KR1J268ePI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:rDh9HxeviIiwSVac4unB5CeZwD8Lyuve7Bugpx+99Hmc1ReqNpuqhcnZlhbwNWYyZ80SG91jpHpyujhdVingcSI5D8cQ+CVCQFUsO1MOBaZpl9+M0RN1LeLI5YvJbUcUIU1G/bIqTKtJQFvyxxaTESkyNXcEXz8cGHUO9sH89QDll+BC5TsaDDR/hr8cZvo6lJOAgugnGRtlwL+b8czQ3HSnHsZhOYrr7JDZarp7dGc7fEG8sWAVI9lg25BrBNiKcXG0XehOhaatDWtCsu3uOktfSzqddN45xWsueAH9cXZRDRuwgoQ6rVK5bvgTGocmgiXC9+HyI2OYDA3ITKLFHw==;5:MVgTv4Trw+RfGOg3soyVd419/2+LX77NSfi+AER9FRORT/L2p61PHzFrSYFc9NxgfoJWrGUVMcrL3prF1GURts1xb1+SHRXaoeXP+ivVxZdjLCA17tC6JAe1l4ZS+zT/nRbL8OzOiequkmJpV39Imw==;24:xoWziYVH/QC0HM9K4vSSMy35QL/73vJVCyArmHT0bzk3DwKWTV7JtJWRErSePuXoPw1TOxOSj/NDLoSp/wjBvlMnPO82hf1Jv3uvJY3O6Fo=;7:teuF33EWSZtmwCdK7RhVqgqmynu3Ew6/UDjvglp8b6JzoNU1GLSzy+Vnet/rv6s31b+rdkmBgnEh8m1Vybw3+atyxC2b9jgslDX3wYU3V6lG6UuRrgvG82JGm3IKiqo2HkmQy57VHxujPvEKh91IxBVe+CdH9G/JdwxDS0PzKieP+OswxRNuWBX33qgFYoCKOIYVm5OIsSGfKRGt2L1zvSLK1VY03t1mUCGrfDGSxcE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:26.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preload index doesn't run unless it has a minimum number of 1000 files.
To enable running tests with fewer files, add an environment variable
(GIT_FORCE_PRELOAD_TEST) which will override that minimum and set it to 2.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 preload-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index 70a4c80878..75564c497a 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -79,6 +79,8 @@ static void preload_index(struct index_state *index,
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
+	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
+		threads = 2;
 	if (threads < 2)
 		return;
 	if (threads > MAX_PARALLEL)
-- 
2.14.1.windows.1

