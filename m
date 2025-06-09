Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732922126E
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500617; cv=fail; b=aeeqlv0TLUdd0gw4j8XxbWhKicMP/EN95koiRjTU4ivJjVCFRihO6hoeBxvlpFJSjHeHrYW56bfGHUHCb3E6P4Xt0+ngWGs8y16FznQDEMj+9UnDyonvUTQOsLrOY6DmW368RqvinFpwbP/ff/nu2VzMBinZ9XFeqO1bVn1LOCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500617; c=relaxed/simple;
	bh=C8WNoBFynTIG4rshjJOjbxOamlO+CPacmkg5Mm68OiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAPFapHuqobqVWcqdxqji9NYfeuMSoi/9gbnsOKy2zfe6Ebpk40btu+8S++0mg3Gf3Ah/oTzFzoAF8COnV4AJz8TntW3eDceZAi5X3Q7WZAFHWDdQZ/rRhfkWmfqsDwtfZnFRjaGNPSKhWlNSB6TE+WG91YaJasBh7w98LkFGOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fxVXh1uU; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fxVXh1uU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYsiIOvpKTPqOIslHX04f8TbWzsjf5qAHJ5PlArgZsWkIvTO9VnmSHKJHRs+JZjUiJqZh/gi2ZyeBQ2GK6bBT+Sa2486DWvuDAzqGJ2zrgz+vEFJPgkk8D/oRtsD/If4CL/yY2SK68It6lhlQmmpQeiFk/umyWu3ayJpRaBcDeFXuyyPCIUzoveeDzogKfVjA8u5rLBur6BZB5ebybHcbFmQClGeUwqP7/WsNsUoOcASsaUkaALyd+zFfnSdekA+YoWoQkuPhiRLA7QvcNavT8X5osBm8le2pZiHsathGAoBu9yt/MWUXuxysSlkJhxUMOZ5DRatdmh7RdPY3eybow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVQxMoBJl7rNWDafTGo8zRVNSUIqsoOKJXBHTzleZc4=;
 b=Iz9VcjplrQ9OAbujHfO3nZDgzidZhwfi2Xd0DGCOu/966z2+WLbksjlPQy7KoUjqlvwH6pdttCklwqmFjDGgi241ie6qQHE5pFsHe5mu6Up0d0a/mkwdr8mHu3pTfIWh3VLWmjGUyONphlIQ3qlx2jD6gupeLXK8WFYZTk8yAgaSw/I5rJRDpXmpwbKqpTTmZ5F2f0sQ94Hie1CKQQDa6ck4qmqyokW8DdGvTQjKsYX3CWdUJgsZvzEu4PBUUYDc019bJDXFdYpm53EB4PhSoHL+sDCi948sX4mPua3cDgZ8Ak0y/lhZJjd0Ib5iO9KAbyhKZxZRdjFrQJ/byAgPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVQxMoBJl7rNWDafTGo8zRVNSUIqsoOKJXBHTzleZc4=;
 b=fxVXh1uUJ5ut5ReSsobRqUz/MLEFvyQknviVGWB8eFMBtP3PbPSYfO/1hzfXgg7q+dhd9LnaQB6cs5UklQhCE9bjXVG9cmXXXpQ67b160Dzwg9qUSlzl48JTCuyxsjqXpoO4tmM2ggaietBkhFkC1Z7sVo58AvRiZQhoU7X7QVAwWPZLOIlAME4BZYGb4ut2OxMxXHq+SZOC2YKxtIN5a/tFPEMrvjMnaQPtWAtIRFgsHyDqp4IuhwPdLY0l+MJbUNUB59KJEg2IPf8JZloXUbZp0UYOX0SIMS/PB3b30qrUsFaoqFbh8FM4m2Pk/vqeiXVx8zSAo74chAREzCXUiw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 03/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Mon,  9 Jun 2025 20:22:48 +0000
Message-ID:
 <PN3PR01MB95971F19E9D30FAD7AF1A3B3B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9d5bc9-ede3-4742-f7e0-08dda7937db4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDTCiJVAOYAyKUFpdLHMU8vPPhIK/BuzCFPU14XANuRZyr9jW0ObSSyEGtim?=
 =?us-ascii?Q?lYgaKaC6pPdaDtRv5nKqKnKGg/NArh3ko0JU3jPP+WZ9ni0IDrf3rfBqSpDe?=
 =?us-ascii?Q?LBTBONXMi7piFlqCFgMfRZo2t07wu29c02/H8rCSevMBo7rlrjQ1jfc7yXLx?=
 =?us-ascii?Q?wG0najXEu7D2cU8RCetuuSkpfcm6hT30DUu+NyK5U22A9mSf6Dzx7VV59vOy?=
 =?us-ascii?Q?HMcEvJIeMait7FMYFy5KjYbyUsKBvy8Z7Pnh6dLHdv9FFWgVdcf7gjvM5Hk8?=
 =?us-ascii?Q?1uJIHaDmjXDqQo8STBnZM1sauTQCrhd0hPpMuZ6s3DMfjDfLGVXh1Ng/YtSU?=
 =?us-ascii?Q?jrUTm8OcLrM8xtELCueFOMAgOV74ZNtxm65ewm7ikI4R0Ysnt1E2soF6gjm6?=
 =?us-ascii?Q?CigM6Mj8xKecFulMi9uZtJ5mHHu+I9jxgdkzHySeCmmq4yFUKUAnHmr5JHWO?=
 =?us-ascii?Q?oKg4wN2JW8xYuVb+k4xYV81vlp07Oy7aTcdQyNiJHjH5zf0qfphK/lMvDf2J?=
 =?us-ascii?Q?c31ux16zo9N4f8Tq1NOsLFgMUjmeeZdncrRMNVLXW0x+DcDi1OghOrFKGkg4?=
 =?us-ascii?Q?GGb0xME2nHV2pvPdWxnhIv/CVO277NW3Z6A5tR8KaFT+aia0mdRE1fmK299L?=
 =?us-ascii?Q?jNqA/Xit37JZvgqbaz5grMH7jXa5kUUvaYcYF6s8tHqXIcZgacKMlll7KhTs?=
 =?us-ascii?Q?d7Jz2LJALVWmdr7JoXQcEIiq4QSFjMnSGm8T9eBm61fHp3w3q/bvYofqIRhP?=
 =?us-ascii?Q?cPd/9COI9UMqtnU5znVvDuEuQp3f8Y8cHLPYGDH7O3ejxQzOSeXxCI8eUl4f?=
 =?us-ascii?Q?u4aaaLobRNNA2cD0m9KEswrJE+ZUguSTM8oq27s35vZkV4thuMLhMrmwWTYd?=
 =?us-ascii?Q?uoGNxTnA0/azds4re7+jh6NlhkDsRH2oFpIAqyzzcEm4Ct2HdWZP0be6gHiS?=
 =?us-ascii?Q?Ebnbxwgx91p9L/XF5h8pp+eNywrUbtJQsdTo8C9l16hUBxWWRZARO4eutNbf?=
 =?us-ascii?Q?HMuyH02dhO+n+2HRVMew/x1vvHUTnNoDykLxnJ4a1i/8JPblwGuEchHMQkX1?=
 =?us-ascii?Q?Xt8BOlM4URMNDXVQ8z/UWo8AaUPmG1RIPovqVuJiCc5SKnUodrOIKK8dd9Be?=
 =?us-ascii?Q?PFTFerk+34G1WgPe5LrtrhfaEQ5typwIJdQfeFUc7Rp4I5UjlG/t6uU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+Ax2Z7b6U67XQccXUyyMF1qHRL1d+M5T8MRb+l0E1cML03Q6XyG1BOfVBmB?=
 =?us-ascii?Q?JvwoC359XLYTbpSY/Q1r6JNewOI+sa5vWgaKWlg6W88KOha4gLZlKszwj+Rk?=
 =?us-ascii?Q?wgnHu+JYfbKYAYhTbeglnm2JdvqVDkOVsoMxJdhRssON/dFsZjImVIjJDTYY?=
 =?us-ascii?Q?gFOIeQ9Hr/0zZLTgORQSVSBLV14B7JUBtSAYXZaq8nHnia3nXWwGF9cM5dpI?=
 =?us-ascii?Q?iqAGEifxWSrBzwrZKGxPXAWzgvwf+23xznU8xEkGsLBEn2ocz5eZ1RrtWCul?=
 =?us-ascii?Q?Y/HhWpDy9mDD0z+ccUMKsdpWbyLfia75uatWW+pqVIldAzvtpbEaPJP6l1S9?=
 =?us-ascii?Q?E63WCZKWQ3FGRjvKHGZbMXmX3ghGTXXAX0hGhRRbg89pRi8E2gGYrg7tOHEz?=
 =?us-ascii?Q?V9l/iCKCIBjmticEGeO/7+UcSoGaN7NovWPQn7MrNsW9PnmW3kvzCPz75Swc?=
 =?us-ascii?Q?vUbk9hQGmKOhYNwuraY64pAFFQ3HtMVUQW7fh+AyCSyxrQZXhOweiHmxLSGn?=
 =?us-ascii?Q?nUYkVmddCyGoOZWWnMgMxLOn5T/ryivxix8s3lP6XdEEyDnUr5auH3FTsmK9?=
 =?us-ascii?Q?1TNpsdWqYevSNLaky6bqzI91b4pui8k8vRY/dP600JT4il/9ZFUm9w0AMSU5?=
 =?us-ascii?Q?Mt7x/GVA0D5Ha86UZpf/9xg9q0GWeDqh0qvIroaePFwlS9MVZ4Yo/BQL9nAi?=
 =?us-ascii?Q?CnfQUMshepC99JJPsH3RfbQYZrSphHb/oEbwkYK9YeuiZ9YmsNDEaby1EIlS?=
 =?us-ascii?Q?NV8Pt4BU19gquk8iabJfzopti+gjhSrdPbLBeVWxgRI1TPus4/R48higchqQ?=
 =?us-ascii?Q?KRPV1aV4i3I1jiwFZy3wUC79yFzi28fpa4YvFhKjJH3vf0EtI+aG3OKR343a?=
 =?us-ascii?Q?IvLDeiUseC0HhKk/WyeWlMtbJxTO2/E+asH9DRpHNnCKcjpgzkhDlNC0PZpe?=
 =?us-ascii?Q?gr/w4m37V+i2Yp0plvS2Pzam+eDJS1pjfq1ChhjyQq18bBYmnjAI1O0IIxu6?=
 =?us-ascii?Q?pMMyYqP0rQZ0MdbsdrieJyQFkUZA+32XlTkzQGfGmKay/RbWhWY2/55qKCML?=
 =?us-ascii?Q?w72zL//XL5QNOiokM19nA7Fhq+66m3wG6IKKwcaqbYFFNOxC8HaVHIPwB1ss?=
 =?us-ascii?Q?hd7Ocym0gNYDnb+9GjhDF+3OMEGrdZFlv7w8wmRHPvyZ8Fqtp8PmQ9rd5q3P?=
 =?us-ascii?Q?HF5YSmyNPRfzPLbUYfKi1yl5Jq7Sw/Bcp0g7IZ5skDsJ/8nyc8iuaR8+2/Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9d5bc9-ede3-4742-f7e0-08dda7937db4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:26.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
supported by libcurl and requires OpenSSL. If the user tries to use
CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
attempt to authenticate and fail with a die(error). Handle this in a
better way by first checking if OpenSSL is available and then attempting
to authenticate. If OpenSSL is not available, print an error message and
exit gracefully.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 66 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index cee8f5690d..39013330a7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -885,18 +885,6 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
-#else
-
-static char *cram(const char *challenge_64 UNUSED,
-		  const char *user UNUSED,
-		  const char *pass UNUSED)
-{
-	die("If you want to use CRAM-MD5 authenticate method, "
-	    "you have to build git-imap-send with OpenSSL library.");
-}
-
-#endif
-
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -915,6 +903,12 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+#else
+
+#define auth_cram_md5 NULL
+
+#endif
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -934,6 +928,38 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		srvc->pass = xstrdup(cred->password);
 }
 
+static int try_auth_method(struct imap_server_conf *srvc,
+			   struct imap_store *ctx,
+			   struct imap *imap,
+			   const char *auth_method,
+			   enum CAPABILITY cap,
+			   int (*fn)(struct imap_store *, const char *))
+{
+	struct imap_cmd_cb cb = {0};
+
+	if (!CAP(cap)) {
+		fprintf(stderr, "You specified "
+			"%s as authentication method, "
+			"but %s doesn't support it.\n",
+			auth_method, srvc->host);
+		return -1;
+	}
+	cb.cont = fn;
+
+	if (NOT_CONSTANT(!cb.cont)) {
+		fprintf(stderr, "If you want to use %s authentication mechanism, "
+			"you have to build git-imap-send with OpenSSL library.",
+			auth_method);
+		return -1;
+	}
+	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
+		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
+			auth_method);
+		return -1;
+	}
+	return 0;
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -1089,23 +1115,9 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
-			struct imap_cmd_cb cb;
-
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
-				if (!CAP(AUTH_CRAM_MD5)) {
-					fprintf(stderr, "You specified "
-						"CRAM-MD5 as authentication method, "
-						"but %s doesn't support it.\n", srvc->host);
-					goto bail;
-				}
-				/* CRAM-MD5 */
-
-				memset(&cb, 0, sizeof(cb));
-				cb.cont = auth_cram_md5;
-				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
-					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
+				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
-				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
-- 
2.49.0

