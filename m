Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5861EC35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB332077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="evjt6QB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgAXKem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:34:42 -0500
Received: from mail-eopbgr10122.outbound.protection.outlook.com ([40.107.1.122]:9703
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730051AbgAXKel (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 05:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh/igMGRqHEQBxI4bziPa2Q/3O/kv2GFJn9NhOv6fuyg3mukrLZF3ZsFuSN2KRuYEOHXJZ6u3SipQnOYpFaEYXrIgvHNbaujLIbHjENkfBk5pYTZsYXaBzYK44b1XAdGll1ykIOO4MiHsXuBnm95iec/AGMxV1N46h8ZEpIvuK6zy5ZRrqBgBu4+2s9rx/XAv9j7jlA+qaqV7A5MzXyvfvxgSyVK0SBu/dbzHDQ9ZuZJe0D/Yyh9t5hCIobILLzStWhClxZxyiYKk8cDJmqHDsQ6BpGABfhvZ2jcjNSnfvAI8WN3RSBogxjjTkzcDJmyra2gHGs+dtwXWLaA3B1Vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh391SXeTDq004abKoVAAxNK2nhmMCo6qynVdZmLvMU=;
 b=eTH/FkV5EnjtiuR6QvzTAM3hRQvZpCnJJS+V3UlqA7haGYzINqOX8XAgvh+5Fhd6ztt+t26KSxczYBq7FIXl7Ar2oVVRJxD2/qll45UfhmKp0j6J8zECmCe0dfghbFP5KeapPAsS9OLJqWD7qBE9BPV3ET//R2Ldpmr9GGoN+9m9J532Vf/ujs2j0+P8ITyJk6SydKOO0ap2aTCPjhVX0X6SFw7hx6IkaBjxujJ+5Dd6QfTPhSzbwD/nRjB4N7YztROsheq06qqE/3pnrvu4Oqt3G76iwvJ+BCoc1yqcHwm3LwONv3ay41Paf+/DD1Bnk/d00MIyuh+YFI1sgJoVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh391SXeTDq004abKoVAAxNK2nhmMCo6qynVdZmLvMU=;
 b=evjt6QB2kYziM93Nqi9pCy24NIniMI9xhsUA6hQU0g1BQ+3S1LFMk7aLAwUUHjv0KInukpwAIdkmMVmrlksROt3N9YOL5+6P0yx6RwYCAb300sJ+jJwgjDL2CX6HR5bJnkmarEzIKHXZtZWEXjd7k9UKXiaQ+HnZE21+wsXZoiE=
Received: from AM5PR0701CA0072.eurprd07.prod.outlook.com (2603:10a6:203:2::34)
 by VI1PR07MB3455.eurprd07.prod.outlook.com (2603:10a6:802:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14; Fri, 24 Jan
 2020 10:34:37 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by AM5PR0701CA0072.outlook.office365.com
 (2603:10a6:203:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend
 Transport; Fri, 24 Jan 2020 10:34:37 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Fri, 24 Jan 2020 10:34:37 +0000
Received: from ulegcpork.emea.nsn-net.net (ulegcpork.emea.nsn-net.net [10.151.74.148])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 00OAYXj4023167;
        Fri, 24 Jan 2020 10:34:35 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, pc44800@gmail.com
Cc:     Peter Kaestle <peter.kaestle@nokia.com>
Subject: [PATCH v3 2/2] Fix status of initialized but not cloned submodules
Date:   Fri, 24 Jan 2020 11:34:04 +0100
Message-Id: <1579862044-29847-2-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1579862044-29847-1-git-send-email-peter.kaestle@nokia.com>
References: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
 <1579862044-29847-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(6666004)(26826003)(26005)(316002)(5660300002)(356004)(186003)(336012)(86362001)(70206006)(478600001)(70586007)(4326008)(107886003)(8936002)(44832011)(81156014)(2906002)(36756003)(81166006)(2616005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3455;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02605e4-2ab1-4c3a-3ee0-08d7a0b90308
X-MS-TrafficTypeDiagnostic: VI1PR07MB3455:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3455C63938E744871B74C71AEE0E0@VI1PR07MB3455.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 02929ECF07
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VY6H+T3ucXVnhAkmTXh+qG2rD+x/Zz28/UUhDpMu8lbXcDBGfl0160Z709PgVRdljgstjYuU12NT1imB8za7I4qZHDvfnvoYv3B6DX1TQzfjxYiCB8gja7ajHfzZugt9fEBqu8EUA5ImnVDIzWhtTnR9IeCWhlaWN8UcRHFk3j59epfdCnn5k250KK5WeQkcaic7t3wBFUnFUwjA+bbbhAUn5UpSzsl72BGjAUqBsAyGVeEbXTyTUXiHyZXOROhzkZTBXc3t+kJn4SYGmkOcJVzyL2/9ZdgQAtSdGkaDLeq49RMGxNbtdi14bVzw3c71IdDgd372jxLwR3WBiBgK0vd3vdFJS1pNJJcgo8Ie49XdlyffcPJvTI/0bfxJSSYF9xVs952sAc0JMsiiV8GxtKdd4OVHWgzbumrJAs2HdNdKb/UsKZzuwBKbKwXNTbI8
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 10:34:37.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02605e4-2ab1-4c3a-3ee0-08d7a0b90308
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3455
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
 builtin/submodule--helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931e..c04241b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -782,6 +782,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
 	struct rev_info rev;
 	int diff_files_result;
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+
 
 	if (!submodule_from_path(the_repository, &null_oid, path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -794,10 +797,18 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
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

