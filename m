Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA7BC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BF2214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="XKyttWAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgA0JG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:06:57 -0500
Received: from mail-db8eur05on2127.outbound.protection.outlook.com ([40.107.20.127]:8225
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728253AbgA0JG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 04:06:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOGWEZC3nJHuzQvqDW2ISOqHk3oe8J1iZBlGyY5U1xajCjP7TbYdVcSPoRGgVfXbnixST0Nr46FBVyphawyMQAt7lvNhb7wu7W2EpwCWW4TzhP6YmzwnMmgGBw+U0SxXgOPR0FdlJ9luBaU8TmcR9kGnGbxMrm9ekFhbEWi3cbrhtJokTmopHg3BcoBhM79eAG7CZLCm945cgjVQoY7N7flBibP9OwDNuzyVAgLbz5117bT5K3QDNeYeX5Sta4G9Qt4MblAJUKtsrvXWhY/YB5giW/bRjx/7RFOQmMRY5/DxhSCe4iXp74hRVHR1RyS/OkMpaDFj1bca8RGhYQlOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPVyHwwjxojEqzezs8xO/0lWghIvtS8BWesvzCOnmCw=;
 b=JygbYV4vRLz6VRTWSxXjkiLgId8/e71/TXQWuv8dKPBO2vPy9/olFVQgfTrrQlcG14oNlVubNHWteDe1x0RJuHUf+e7MiwxXdA4kD8lWS4dK/sA8LKgupxmbsrEUL/PtBWnbBsFpJOGqwA5/27fyBCBLdPaW4V14N2VD0Vxshmdxxwct/Brt0ugECZ6j7m+/cUwCtd2nC4n+gJlLvPaINO2PSZm/pHKj/KAjV01ySNAkSZaTWrpNu4Ca2ww+iwOyR1jKHBk7dufMRPkE5rRtPwFBldAgO2p284Hh8fgvNITqkQSioKdL0q4Bv+dnddlC4hyHH/JpS5Fanbko+91Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPVyHwwjxojEqzezs8xO/0lWghIvtS8BWesvzCOnmCw=;
 b=XKyttWAyCPKr5UjND+sTfq0+6lmUui1YDPwWmnhHgWq3Bc0m83kxLPenYRQbAQZzJnCpyTrwg4+P6xIlcUkCJxU4wXgqV7XSeGAdU4DkxvNF5ThQl47qoTPkdUrIqXArh1a5SK/QZJC383Sp/6nRHQMjZY04jzMaOzvEb+ZkLbY=
Received: from AM3PR07CA0121.eurprd07.prod.outlook.com (2603:10a6:207:7::31)
 by AM7PR07MB6246.eurprd07.prod.outlook.com (2603:10a6:20b:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.18; Mon, 27 Jan
 2020 09:06:54 +0000
Received: from AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by AM3PR07CA0121.outlook.office365.com
 (2603:10a6:207:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.15 via Frontend
 Transport; Mon, 27 Jan 2020 09:06:54 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 AM5EUR03FT041.mail.protection.outlook.com (10.152.17.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Mon, 27 Jan 2020 09:06:53 +0000
Received: from ulegcpork.emea.nsn-net.net (ulegcpork.emea.nsn-net.net [10.151.74.148])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 00R96eFp025313;
        Mon, 27 Jan 2020 09:06:40 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, pc44800@gmail.com
Cc:     Peter Kaestle <peter.kaestle@nokia.com>
Subject: [PATCH v4 2/2] Fix status of initialized but not cloned submodules
Date:   Mon, 27 Jan 2020 10:06:29 +0100
Message-Id: <1580115989-32649-2-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
References: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
 <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(70586007)(70206006)(316002)(86362001)(26005)(5660300002)(186003)(36756003)(81156014)(81166006)(8676002)(4326008)(336012)(2616005)(107886003)(8936002)(6666004)(44832011)(356004)(478600001)(26826003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR07MB6246;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a68c2505-5531-4e97-1b7a-08d7a30840e7
X-MS-TrafficTypeDiagnostic: AM7PR07MB6246:
X-Microsoft-Antispam-PRVS: <AM7PR07MB62468E2096D2D18B5B69179AEE0B0@AM7PR07MB6246.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 02951C14DC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2S7r55/Bp9sdBeczadHyy3h02uXIp3oB9v8GnwsGJy5RJuEQsh9gDv4jLmH0aaFerI99OOpppZdzvQ8ovLaPKUFlsquoY3SO1pdWHgm36Ygr54wvVjlYA2MEak50KEFT0H6PhNH5K5f+HrIEyAepZCKjVcba5rPlNXYmVdx8WUk80jnvppNCeReFkEzqK/OYqYHTiO5KJh5TkEDHv+RipDwrL4iS04/BB4MpKlcwt7Pmw38Cdi7CtjH7CMRmAsCjDvLQnwc0HJjSCAk5KAN21ST4hlPt73BhCAq3wkI/fEMgW/0kc3tR736oT++0tOJUWULF+NvWxbwSuQK9/bu8BfRWRiiZfSOFGZZC6IHBnCQqg2uO4HtWdWRJm1xiB4PJnXOgNxVbT6oQp76vW4uhkWJDsuRJkL1rLDUjtwFQxwSwkcmP38geZaQeESCgV8so
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 09:06:53.9587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68c2505-5531-4e97-1b7a-08d7a30840e7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original bash helper for "submodule status" was doing a check for
initialized but not cloned submodules and prefixed the status with
a minus sign in case no .git file or folder was found inside the
submodule directory.
This check was missed when the original port of the functionality
from bash to C was done.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 builtin/submodule--helper.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931e..4031cf4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -782,6 +782,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
 	struct rev_info rev;
 	int diff_files_result;
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
 
 	if (!submodule_from_path(the_repository, &null_oid, path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -794,10 +796,18 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		goto cleanup;
 	}
 
-	if (!is_submodule_active(the_repository, path)) {
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+
+	if (!is_submodule_active(the_repository, path) ||
+			!is_git_directory(git_dir)) {
 		print_status(flags, '-', path, ce_oid, displaypath);
+		strbuf_release(&buf);
 		goto cleanup;
 	}
+	strbuf_release(&buf);
 
 	argv_array_pushl(&diff_files_args, "diff-files",
 			 "--ignore-submodules=dirty", "--quiet", "--",
-- 
2.6.2

