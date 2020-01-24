Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8C9C3F68F
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C422075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="JMaCmRTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgAXKek (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:34:40 -0500
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:40513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgAXKek (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 05:34:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERYikfw0PlgBCocc21iTIEIqD3xHz7w3/CB7nqNu6Q91lvGdgEOEoP/KOHCbCS0Ump1b708qIVrFEKiLFkR9t/vJ0OY/6LemMR1Vjj4X+fOy0N0PGOeIEmNkrk+0c4ZPddB/P9J/XVBZor28aoGVMIywHyHxfSPr4b79ZH950liACqKvmxdnHwfQYEWxLYBL8yESqe+SsmGxPgLWALh1pwExlPHwMp0V3/eVHRCUbKUsQ0bRnPGENgS9l3ESZxymGNjVx/H32kcEiiFiULSGcfP2hFJWzvRaPOfLBaQFrr6o6fEp7eMKERW/GD1fpYUt+DNKOnQr/fAJZFTUh4eenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An8yiUNRWMqdcjeqh+KN/P9uwOzMSDyzYjrf0/ppfys=;
 b=efCZ0CLG49/Q5SNZDDBZCma2pyeJZHDqPamT20tkOkPstd5i3nIMHIurC3S29zqCskrUBSDNb7KtvQjuG//5va4G1d70i3RH03YmUyC2vCp9acw2DjIdr1kIfuxxKUjL5afKDjQO37Ye/KmQKD2myZnO5RwBhP4wU2pSJRu0NY05y1m7lPed9kCO3IX4rBt7+YAQfZ34wTP2QTsYIdTGOL6wUbxfshkG/Sef39TKLKHIDfaOyMx4Ke+hxLsPpsmDTWlmhb4PFHIAKCJ5l9z4jAy5nVIePYxwP7y0IErgSPZ9EnBmICIUb9j6+ETueIupTSEK5id2BeJzuaFBeEKFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An8yiUNRWMqdcjeqh+KN/P9uwOzMSDyzYjrf0/ppfys=;
 b=JMaCmRTIP6ThIbLcyxzN+9gxFAXt9PXx3wuCX7JhdCwM+pefWVh3+mYK8cP+B8mpTBDBas68aH4zxbjwPhArpISvygXmLGLWnZvlRkWlCetnVuBD26y49XciATAtGJI6wq1Djo13NuseIxVFSKiHDTIIp9sf9Rvi08TFsSwkF6g=
Received: from VI1PR07CA0192.eurprd07.prod.outlook.com (2603:10a6:802:3f::16)
 by AM6PR0702MB3702.eurprd07.prod.outlook.com (2603:10a6:209:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.15; Fri, 24 Jan
 2020 10:34:37 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR07CA0192.outlook.office365.com
 (2603:10a6:802:3f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend
 Transport; Fri, 24 Jan 2020 10:34:37 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Fri, 24 Jan 2020 10:34:37 +0000
Received: from ulegcpork.emea.nsn-net.net (ulegcpork.emea.nsn-net.net [10.151.74.148])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 00OAYXj3023167;
        Fri, 24 Jan 2020 10:34:34 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, pc44800@gmail.com
Cc:     Peter Kaestle <peter.kaestle@nokia.com>
Subject: [PATCH v3 1/2] Testcase for submodule status on empty dirs
Date:   Fri, 24 Jan 2020 11:34:03 +0100
Message-Id: <1579862044-29847-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
References: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(8936002)(6666004)(356004)(107886003)(86362001)(4326008)(26005)(186003)(5660300002)(4744005)(81166006)(81156014)(8676002)(36756003)(2906002)(26826003)(316002)(44832011)(478600001)(2616005)(70206006)(336012)(70586007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3702;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a952112f-501b-442b-1a25-08d7a0b902dd
X-MS-TrafficTypeDiagnostic: AM6PR0702MB3702:
X-Microsoft-Antispam-PRVS: <AM6PR0702MB3702C0097D1B0FCDD63E086DEE0E0@AM6PR0702MB3702.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02929ECF07
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCBSc1SpEH2LSdqJ34lnyASWVEfwI3ooKjp9TkyehUMpCI84nILv/XZvPhBj/CQnkClc0Tz+W9+r29BTC/HrdL1H15+AhQbkzaJLtiPgeT7R5Z2IDqdfLTIABlaV5HNL9GXnujxuY+MH4vjTUOwxAk4nI5cQO73jU5//EFNS4IPfSRy7Dxar6NhzbkYUFvODy8TSJU9jsSUpRPk3dXJjDtbAZoWK86Et4dewJly8F0ytYIycIBBZ9IixPAFdlKkREj2dGY50SyGsHjwltpBYw5Gm8CV6LkyhHhGEE1Qvv6SALg43+edu/LyUxckEDPFsQVY8/Fzd/Fuj5K5ddl681WeVGfVQXHSnfmjlR6RTnRIBrLaFkirduGQScyENdVV3njP+zrFJHWNsvD4JfNfnBxx/2lXm0vgyuyVkDWnXSW8M2ag0nbf6oz3LFW+I7Z/5
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 10:34:37.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a952112f-501b-442b-1a25-08d7a0b902dd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3702
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test that submodule status reports initialized but not cloned
submodules as missing.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 t/t7400-submodule-basic.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7f75bb1..2e84914 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -399,6 +399,14 @@ test_expect_success 'init should register submodule url in .git/config' '
 	test_cmp expect url
 '
 
+test_expect_success 'status should still be "missing" after initializing' '
+	rm -fr init &&
+	mkdir init &&
+	git submodule status >lines &&
+	rm -fr init &&
+	grep "^-$rev1" lines
+'
+
 test_failure_with_unknown_submodule () {
 	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
 	test_i18ngrep "^error: .*no-such-submodule" output.err
-- 
2.6.2

