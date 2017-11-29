Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E643920A40
	for <e@80x24.org>; Wed, 29 Nov 2017 14:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbdK2Oia (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 09:38:30 -0500
Received: from mail-co1nam03on0106.outbound.protection.outlook.com ([104.47.40.106]:37633
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752853AbdK2OiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 09:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p30mL/NVtJxb0/1Li08agG6oi0M14h7TYyFbgl8zLhY=;
 b=j0E6Ty2qj/mejNWKXq40nj5af6cIPjm224d/44eRAF26oCvPk07uK0NwKi38P+xA5Bk2EakWDOP1ADrOglTVTxnTLPp1JwhqkMOOxKse4xIl8AbBc9OUcRnydUNj+07ZbI4oXvoEYMVVX8j1qU/Xig5R39hh6WUPYlSx07uSJok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.11; Wed, 29 Nov 2017 14:38:21 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
Date:   Wed, 29 Nov 2017 15:37:52 +0100
Message-Id: <20171129143752.60553-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171129143752.60553-1-lars.schneider@autodesk.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com (10.170.225.37) To
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 284d6fc2-4d02-4b40-24bb-08d53736d793
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603271);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:tDE0qC4SmDOkXa1u+eY133pHA+3Jt8nrFkmlningskRFuWAiN1ZObGOXsirWB29SXP1zBMv6RUlXQLfrTi8r6LNIFbrRwPGMuRY+O/xkjI+MCQP9BKicofTNk1v8CKL5Kndo0bvfBu6pOKvpcVY/Ccbvt9FJ3/8VuCpF7N/BVYMOovci3RkPwpNy8SLy9FY3vJcQpt4AUjIRtzjTMIWYGK6rQnmqm9t/8bSFkFr9ijI8maiI3Nm8bMLUZv2f4Fcz;25:ewbRQKbvFWjDnBo27VoSCdMXKbDEbInTqyZXhRVs2kCKa0v5CQI4YK33kOXsCbiPOy4CNf6XiifMx6hEJUDgu+l6jFLA/YYlmbYXCUgQEoJRQqYj3KrVRQGQMva8tze5s1ars9ZDouajVAzycsxIkMKwzdCUbxbbFddguvTaET0NGLaqHyPoeSaotdOMEvm7Cj6ssYaaWMEz7Vtp9oX+3zDt5myGzDJZiZl1mtoO5iv+72wC+Ml2XT6pYUnXeiMFk7T0Ei2Lv/2Ab+HE/Lxm2cbUNHHW++rjmiAxOtxmz+6S7LXxdCZdOiLofxMECWUWu24kBZABVbG0Zt++lxTrYw==;31:0oXhJgv+3pQcwWTvnAA7bginJ8Hz58Ag+9jsw9dSpSpN+JeiDqjASxaJKm74Mg0r2tK54eegnhtsnYXz4S9d3jt1jVVABNPx37c8qMSP9eK6XtzLma1RmKNJeCz4qOfBMmp93gdqKW1RNRVOZJxacEP4zNolX9HKrYf8FJouzy8fYYPOcH94NpgBgZA7L0ib8TrDOY0YVOKgxQrHu4rv1JY57iR6ucD1RWmlfSuJhx0=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:zRItf/g6/lU3vpJV2cEdOl1qnQCThlsiIGohY0br/5FtuHC/Y/WxYJh3eBa1sWmtQU7tlEGp0I5KfI/X5Nr0jZfhhdS37x477uicAJtaSaaj3Qhntrd16GTeRGClqUK8mjkiB7v6GxZe4nMHJ2+FLbJx1HHCh90mCEgrVrEADfIRHcR/Dz61/shOTeR+jH1qeq+imetd0irIbIVF77orOqL99ou6r3ec+YodwcI3GpFzkF9HTMPbm0BDUicnEE+HYnUx8QPku982lqn1KD+r/YEHg78Q0zWmor4dyZxMtsrStlYMicWKRQTIRKP9BtCZuRAxdHzkgEOB7hDbxMepiwZT0L1CjG0VKIv1sOpmkVG/2/4WpEO8BfGAay9p6IZw+J6RjgV6o0gmKm1VTco64zd58k8VxsXQDaOBEsij1S5ZTwBIAB2Dh+svTPftuNazNIqfdDTkhRDxv/ETCgl6cW1zEP4eOGWnlJHFkya9SfdJq2M2Lcqac1UkdtRcUQoXrvUPBO2vv92H0l4xg87j7Fae1QnMDev9OVzXRSCf/NFXSc6LHUzOUuwysLpyzZmD/mP+TBchJv3ZISLajyxmZena9jVkf0IrukG1NQodvBo=
X-Microsoft-Antispam-PRVS: <BN6P136MB0017DA0487009B02FA8F795EE83B0@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123555025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;4:ycwn3a/RvnX2IV8JjTNu2FuytIrqHxDvQ08a6Xy0xjAwlrome8epkB9rYto3xBZQHSlsK0+lyYJuEd7+MmP/7Y3OI429SQkVsFWZJ1bqGy0ppVC/4lfVlbFO2GOf0unwzUDBBUV9zQmZyMvX0oQ7rKtlRrugfttEw7DJ2aiVR/X6aau17X7iRW6gFzRFxDGCEUWTBznqCsSmvkW5sifW46gx4RwI50OuVvVjeeh4g3ZmkdAJkPbuZgc7002stwGLhKY2f016Tmi9mF48d1w6ylD//bdw2h1EhUQDbvp5YjjvxLE3uYE6Q6zCZlpVZXQpdIuxJQK7umUsLQ8Ksy6IYuts7ffUE9pfUyv0gK4vNZI=
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(366004)(189002)(199003)(5660300001)(2950100002)(53936002)(6666003)(6916009)(101416001)(50986999)(76176999)(9686003)(575784001)(305945005)(8676002)(86362001)(189998001)(36756003)(8936002)(16586007)(25786009)(81156014)(81166006)(4326008)(85782001)(105586002)(51416003)(52116002)(7696005)(6116002)(66066001)(8656006)(1076002)(7736002)(2906002)(50226002)(478600001)(106356001)(3846002)(68736007)(2351001)(2361001)(39060400002)(16526018)(47776003)(316002)(33646002)(6486002)(48376002)(97736004)(50466002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:NgecxWiegL6PHOEQxOl1n89tHIwXavnChLGPV8Yn2?=
 =?us-ascii?Q?rIm/M67eOF48AuO3RYjKaCL2pq6yQf98NjjmJClmP1nTpS16y+lghsFJX+I7?=
 =?us-ascii?Q?J9sMLmhU00Gk56Ddsf4r2MOV/VlUa6OUdlMoPYkVsMSlSqCBqzpaWGMkKVJP?=
 =?us-ascii?Q?PVooryrgpK239deeWFweXTq5JiBO+NrY/0mXKzj2dwcraIWUZn5+HW4VcqfH?=
 =?us-ascii?Q?uJZfvhuvyMy8faArzSUSwvf1Xji44spoHn6+0kniN6TBDF6yV5jZCLjYZwXb?=
 =?us-ascii?Q?0azXTGh5kXXekMoZF43ke15Fil4ol/weJ/zjySjbsmUbmXeh6Kzjj9+Bq84C?=
 =?us-ascii?Q?np4+Nu7xDU2D/61eBk9ZlZ7QYx5gbiUbHiW0JC/wWig3puObYxdwUJUamVyt?=
 =?us-ascii?Q?eHv8RKmRb6USZ4jSBGfIngHbfYdOvTqDpFkIa7cg4zLZ/UTfZ3tXmHQQCgwC?=
 =?us-ascii?Q?nd2m34FlFg2yS10sXGWMy21s7C4TRL+iIpR5veZzmeu2kJWNt/Kus6EqCYXP?=
 =?us-ascii?Q?hrYmJgus0uieCslWB8rLj6HNAI9tA8E6+7jaKiFozAfYrPRnAMUJXqtGlAhc?=
 =?us-ascii?Q?dn2yPxFaG7TRzN7ZNboccVQlQnB2/hifF0B0Hy61Vm7U68m+z4a1JNyhGyit?=
 =?us-ascii?Q?U+DLkth2a/hErd/v/fcUogcvaWGcGJbMGZMt+9Bl4hUul3O/zEA5Xvrg+ZlC?=
 =?us-ascii?Q?0thvcmWDpcLCKEiK1dHsAIoqNLarHYj/WbvC7/MVFo8FlECBgAbV10PdJU9N?=
 =?us-ascii?Q?I/avWJsASeETx/OgTycYk1ziycqC7F78aEQB125QdtAcymVI46V1/bJF6lTv?=
 =?us-ascii?Q?lL0/weAwXvLvRQAbLHxhpXVNXrDQqbUFSeTHL5JUqnLtS8GuSj97dQXs1FH/?=
 =?us-ascii?Q?CozMiOs7IaE+qdKccReqKsc7wSYuTX79yJeqNpAi8+JmHLIIz9GAtOOCnDB/?=
 =?us-ascii?Q?oDEWxIClKmAWKKoHHh/aevbB06qA4+qrNUZ77kOwLUvtPz8bGnFf3LH33+pT?=
 =?us-ascii?Q?R/MfhahiNpMXfjmB/ns8D1ZNeiJuNL+E9LnCEbrogVD+SPqwp7obqcQzr2/z?=
 =?us-ascii?Q?QSAi77sdk+kLzWloyJmhzALHFcJkLqGVMy6rNASpibnM/NflTrGeO/TdqnRJ?=
 =?us-ascii?Q?pAby3GHC2e/Gpa2gNujj65ZCiNj+wNO1tL9bYEDobURVyt0w5duUN/wVW/qY?=
 =?us-ascii?Q?LKegCQUwKV108GLlV0A1HpIxH4xYcIhwtacGK0hwL0W6hRF0jfo9Z15XGB/z?=
 =?us-ascii?Q?70xbCot2dbAoIjCf3S+/rraQN0Yu3vGnV9lw8x4Evwwgqt2EwWZR+5c925sJ?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:RrzMXyHPn9NG5K7c1i9vmHAVrxL0aE7C9blkBeEdP0c+Xqz3vA3SXmUea/KRiznEFXCJKgN1ULStayxTIP2FV9cyU5x3bcR6+q72gl2cfWrQ3YGumi6LL3ISF3CcuIH881MYGGf8ejVN4iYSuka8yRtOUviEQ2cF/AXIWguHmsvMXcxag+UuOQnjyERh1juHYCr83SLkK89EvCVzgtCJv6p6QChgm39a7hBPnV67n2vTSAIufc75xumnN+/nHhXPE6b45Xr60vV+a5fG3uhRRp6sSvODiuj2d/I7XbHgK7hT4cZZER9BBv0keomDdr1HnqJK4Jqj7TGTofJ4KDyVQcWyKBYfTjHIqPBs8m1YEMI=;5:SuPqz4N5Xgt/JCZZyuTb3AN7lz49tXz4Zr304Qen8XKfQ9l6pCxKuutuvrX4WsfR1devtn44wvXYxXPE05owCT93uhUBHqSE51JoCwbshf7989ZBpzF/Rb7UY3tSPRuoqqsqBWja73hIL5A2y2htxjovVq+lO1LqKG3sV6+F8y4=;24:TppAERUXlbp5knDtm8kcE8ad977Hi2NJl64y9NQDYWKkku/HX1TNNBjDTx9k/FtUrhkTnWVGfL5HBM3fh++HbGi6yO7mFR3SDA+75IvWQAo=;7:8BQKpvj/E2eV+b4xZG3E53vjxEyTZJZotUM+pzCCwI3ihpw/snpB3AtMDlWfpnqm5xEVEgN1rQCfjp8QkkD5p2Cu8L5zIP06uvCTnhxPkZ7zx4lU/65UVKkVfPmjRlZ33KZDMuePfUJYJyP7a5Gj+5ZvP6SPweE+5KSILww2iquIrVtYwCNlz0N/YELxUMsm/Wy3U18bUN34Od9azPqSwxyek0/MSlIuBVAo1ml7mpjoJSZO1kEDpQ770szm/xso
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:9VzmvznpVjPOjfQIP0qMIMHoEtjubflb6y3NV/JPVeBxTGuCx8nJmqKDCaXiMYC9+tRgyQ3VXoHL/uhzjZaPnWaMffJW+GEEoUVvDGCFvM/3FIS4xYbwDeUE+82fg/FQoCOPpsyrcpk8bj9JHBRWK6MBWJwYJ49EhxZChtYf354=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 14:38:21.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284d6fc2-4d02-4b40-24bb-08d53736d793
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for user input (e.g. "git rebase -i"), then the editor window
might be obscured by other windows. The user may be left staring at the
original Git terminal window without even realizing that s/he needs to
interact with another window before Git can proceed. To this user Git
appears hanging.

Print a message that Git is waiting for editor input in the original
terminal and get rid of it when the editor returns.

No message is printed in a "dumb" terminal as it would not be possible
to remove the message after the editor returns. This should not be a
problem as this feature is targeted at novice Git users and they are
unlikely to work with a "dumb" terminal.

Power users might not want to see this message or their editor might
already print such a message (e.g. emacsclient). Allow these users to
suppress the message by disabling the "advice.waitingForEditor" config.

The standard advise() function is not used here as it would always add
a newline which would make deleting the message harder.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 editor.c                 | 15 +++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 671fcbaa0f..de64201e82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -354,6 +354,9 @@ advice.*::
 	ignoredHook::
 		Advice shown if an hook is ignored because the hook is not
 		set as executable.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index c6169bcb52..406efc183b 100644
--- a/advice.c
+++ b/advice.c
@@ -18,6 +18,7 @@ int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
+int advice_waiting_for_editor = 1;
 
 static struct {
 	const char *name;
@@ -40,6 +41,7 @@ static struct {
 	{ "rmhints", &advice_rm_hints },
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
+	{ "waitingforeditor", &advice_waiting_for_editor },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index f525d6f89c..70568fa792 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
+extern int advice_waiting_for_editor;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/editor.c b/editor.c
index c65ea698eb..cdad4f74ec 100644
--- a/editor.c
+++ b/editor.c
@@ -45,6 +45,13 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
+		int print_waiting_for_editor = advice_waiting_for_editor &&
+			isatty(2) && !is_terminal_dumb();
+
+		if (print_waiting_for_editor) {
+			fprintf(stderr, _("hint: Waiting for your editor input..."));
+			fflush(stderr);
+		}
 
 		p.argv = args;
 		p.env = env;
@@ -63,6 +70,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
+
+		if (print_waiting_for_editor)
+			/*
+			 * go back to the beginning and erase the
+			 * entire line to avoid wasting the vertical
+			 * space.
+			 */
+			fputs("\r\033[K", stderr);
 	}
 
 	if (!buffer)
-- 
2.15.0

