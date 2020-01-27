Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB7C35242
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7D720674
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="VaF1q3DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgA0JZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:25:58 -0500
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com ([40.107.21.92]:58112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729213AbgA0JZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 04:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmAdrW8vM3f/d2DNXz7wfzQhMqnJalM3AE0aa2sHEPXveKuLE8Md08Iix16iR2/uFFsOxAVbenWZmeV/jQvFjUGJLROy9Rbc1NxbhLHP83dQOTbTgn4ESJzs648m6yicv+fjoZZLF1XPnxjwsZzTKZNNwDyVKVjw7wXaGRJMO7Ey0189J9XbHPBqGVfPGNmqRk3ScrBQ+o98YjqEMBRL9C0+ka85LW0RLFiLn+k0Y5+g3IqLVTO0Iw4dcgtO7Qk9svEc3MELAK8Mc51S99c4zfqRQ4ho1Qqj1TuRrJL3+APpufjoCZVkA1tGEozGElKocQ1GG8txGN8YkTS7OG1jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf5FPPp3PplncUgSGqzltngNE5gsm1qD+L0mPhb0HVU=;
 b=IWglgM9Ml509UffYkim6Jp1bsuP+L4VwsO8yNP4PlSqWcopR5RFF+uSzmcmApJgUSyMZECntjRcL6TRWo3C6nGCR9ldKd6R8prbx2bCbWQo8iPJYIP4JmHhs9uz6ZQvFfbIanc3eIorxua/Mxu6rFIBvO95J+QKdiKf2h4OT68umyKdxxtYu+T79VuEpH57dG/LdRbMnD15QgLKF3bIISt1jp5wqY8wb9B47C+s0XwvDWcdqq+f2O7vLIU/ZsStRQl4WoJBOA712CR4xYsG73o1UTesodkUrVdMZqB5mYB+18W+BajqF21hhQt/oXd06+CW7/HxUpHpjR9hNzKAj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf5FPPp3PplncUgSGqzltngNE5gsm1qD+L0mPhb0HVU=;
 b=VaF1q3DEc4k1/FPCoyHWU804K6QSg0Fo/4n1QEADZnz5FKPntR/KS94vNhE7ImnJhWw9knSw5GUK8eDXRMnTT51DwswYY7iPwCB0O8DCMUGsNB0xz0m5ZPVUGYQNmQAE7f7PpKI7o5fuO1IUGXm+G9IjFqOscwwYTQhfgqdsk+s=
Received: from VI1PR0701CA0042.eurprd07.prod.outlook.com
 (2603:10a6:800:90::28) by DB6PR0701MB2550.eurprd07.prod.outlook.com
 (2603:10a6:4:24::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.10; Mon, 27 Jan
 2020 09:25:54 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR0701CA0042.outlook.office365.com
 (2603:10a6:800:90::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.12 via Frontend
 Transport; Mon, 27 Jan 2020 09:25:53 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Mon, 27 Jan 2020 09:25:53 +0000
Received: from ulegcpork.emea.nsn-net.net (ulegcpork.emea.nsn-net.net [10.151.74.148])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 00R96eFo025313;
        Mon, 27 Jan 2020 09:06:40 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, pc44800@gmail.com
Cc:     Peter Kaestle <peter.kaestle@nokia.com>
Subject: [PATCH v4 1/2] t7400: add a testcase for submodule status on empty dirs
Date:   Mon, 27 Jan 2020 10:06:28 +0100
Message-Id: <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
References: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(70586007)(70206006)(5660300002)(186003)(478600001)(336012)(26005)(2616005)(26826003)(8676002)(316002)(356004)(6666004)(107886003)(81166006)(81156014)(2906002)(8936002)(36756003)(4326008)(86362001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0701MB2550;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2a2ef5-c939-47d0-9d7f-08d7a30ae83e
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2550:
X-Microsoft-Antispam-PRVS: <DB6PR0701MB2550332579A0AB9FE4905497EE0B0@DB6PR0701MB2550.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 02951C14DC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzOjGrKxxlzRd6wFuhRaoty9M/8x+wXs+eY1f6QDssAPqUmFcFqoQ7woaqtdrBhH2sB5/ukVcAOV/bjwfe/br9L6PC2NtFNEFlwIn9gh44ez07KcJzKrxh18WvP2wvbyyPCrtVlGmhZ5WxMXIoVIGDI35XvXUsVsDXigvO523FxCy06rBIW9IvTga1vX3Hd6oM2W5bkkwjfpNXTjiZfmNNGTEOpHEA3XX3QAa4YRLLjcQfqNgvEMh8JtR2c0FkqYjv50hELtUc6a+9PjlJpAkUp2D1oHaLi1J5PBwPWQAjrBfRgx6I+XGJMYhoA0fwdwblu1ETOVqzKbxxpdR/sss9/k6ofwBfkkd+KZsUPGCbR4yD43Fmrg6gf4jqz6IbDcNLUZW2JLxyLcg8l/dD254kbDmCZaGMRcGknRatuhJK2SiuRG+kZ/d59swYpt8HsM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 09:25:53.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a2ef5-c939-47d0-9d7f-08d7a30ae83e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2550
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have test coverage for "git submodule status" output in
various cases, i.e.

  1) not-init, not-cloned: status should initially be "missing"
  2) init, not-cloned: status should be "missing"
  3) not-init, cloned:
  4) init, cloned:'status should be "up-to-date" after update
  4.1) + modified: status should be "modified" after submodule commit
  4.2) + modified, committed: status should be "up-to-date" after update

Case 2) will be covered by this patch.  Case 3) remains uncovered.

Test that submodule status reports initialized but not cloned
submodules as missing to fill the gap in test coverage.

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

