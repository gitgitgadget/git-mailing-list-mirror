Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2335210F4A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273758; cv=fail; b=BbiDO1LUOcgwPhg4WIlphcQTasiANAOEAodBMNABv6pmb8izNJ05dC+yIkxSwZlX+xK1l0i/F9ej386xHqgDRR8cthAvv5YhhG+J44CVCyNu11jkNIHH88TbdbtK+iCsKOfk4NMgzft0snFA3cImELTtkdYqHD/H9UtefLwK70A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273758; c=relaxed/simple;
	bh=Jr/FJLDNxcJfoKvne+xoUGR18rfawxFK1SdkwxXQVwo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WFPJwm7Za4ENBty8jGScKp8l5vwcw7KuvXPiW6jCC1pyuQH32ZnxTL8o5sr4maYY52XgUub2pnOZEvImc8BD88EB4nJDgV1KqaErtuDKUQaGUJrYxXNyRnptnVX3JwYBmXtil2X7BeR2NcijmLTQZexZZvq2iYlOopiiWFxouT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pWkZuyGg; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pWkZuyGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATnwC1bHRENKkNB6EgjSXt06PXLabtRu0Q6eL0ACUQftpMEfDnF2IJ1fF31R3bZ/tL2H7RjhTZ84K9GxoPsyoqHx5qWEfaZ4/nTCJpmd61LX3TOxPNfFv2Ht/y4awCmiaojUQev9mVsmvbLwC1fdAnHIEla0dZyY9W7lkdkeoBake8cL+NqEmfFSYdwZxAzuRAzQws7pvW1AjagjSCl6BsITszcmciveQ8FLOgiO+YIOlGyHlPe/9PjGUmiD21jG8ZDF/yUKX6J01y7MwSkdsGCNdG8dkuHfzZwwLpUUnZDMcxzX4DAeKZvoZ7ZNblDYlcNPhxbzFYImatHzqXEc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlKSBYYrh8AgXrmj87m+9MSTmJdFyPMYDMvq1wOMT48=;
 b=Nyio9aJqIhF7xOjXpiqhd2t1kPI7Fs9FF3fIXnrT3Rzvr4tQ26wzbROPfeLbNeMPrALT1k0otGfNXy8az4odd973nlMQHqgYUL0T0ZVwyC7bqsSywDOfNA4gqlQUs8U41SV1uxgLESlt98TOWbVuXORScJcOQZa4/h5ezCm77jPs+oBSTPkcCPcjqpXI8wf4nphokLyTCF12tgvGx6Acm1U4SVIYyVplbjFjwMFantZZB8PpVxRPBcDzsbk0P2aXhTctKKk72EjvEKUwBpa7Eag7hBseZBB5xc55VmIMrUb/yDZunGmadhfKwIjYJYlLenX/9gCm5KMsLNZs21gaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlKSBYYrh8AgXrmj87m+9MSTmJdFyPMYDMvq1wOMT48=;
 b=pWkZuyGgMwVZyTUnSYI4szVltTg9f8jk0S2lXcYTh8wm0b2tmJRBxmscZXmv2ApkOmJUuydJhqyHCZIg0+GqcH+SbULPPRklVwBzaGrpLE0LDGIZHNxyXSTg+JpuBJmly+qfBFDYNgmEZ6sT0YSBqJ8OdWSpP2nQmeKo1xTTPhmVbxl/Dl7+tFR2qP8uxycPa+o192jcTTh+x0o9ylihqYWk0qMPChDm6zx1NK23+jlwyn1gwilVKZh8cu4rocFCOI8bSLB0iGSt2oLTlKVx8jAb9EM9gPMIrukF3jDHTDUQ5hkiq7TVglEzoQXEGmdhUnZG5rnNfs50MooCgCPyJQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10269.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 12:29:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 12:29:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] imap-send: add option to mark sent messages as read or unread
Thread-Topic: [PATCH] imap-send: add option to mark sent messages as read or
 unread
Thread-Index: AQHb+81kOsb3aqbVj0WTwu91w6cBzA==
Date: Wed, 23 Jul 2025 12:29:10 +0000
Message-ID:
 <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB10269:EE_
x-ms-office365-filtering-correlation-id: ee11211e-d023-49c4-ef47-08ddc9e486c9
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|38102599003|15080799012|461199028|8062599012|8060799015|3412199025|40105399003|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WTjOm7htMHr4dEN+0L6QU72iR7fdJNdbN8Op5I7ANjcXQ7IcnWRZBIMarA?=
 =?iso-8859-1?Q?VcLi4tNBXWpou2Z+adht8NXVBHSFKp9RNOmxk3A5/3xmtH9rSfA/og19UG?=
 =?iso-8859-1?Q?wl1hXgLLpCt7VRQ34HT5KlKFG6GNzXriGVD/vXTt/WVc2FEEPGhsCZ8XOc?=
 =?iso-8859-1?Q?urmxtsi1l493uuSbZj8tPuSpgPRPqJl8L/Ep/VyKyezNgLvOErYa6CjH1I?=
 =?iso-8859-1?Q?D7JqVEeFdN1bRmSWqpJc1D/7DIrB2uRvQMh3Oxxz/d0rS0LW+A/CfU1wGI?=
 =?iso-8859-1?Q?CFzWHWbTcwY00+IiAkv53Aao2EQMc1frlBFY5/AGpFZDLrKhQYdLcQXYDo?=
 =?iso-8859-1?Q?khyO/Gb1PZnltvHDpDq++cyz3slc/li3D4o8uNZU9/hmXZH0/oJRu5rcOp?=
 =?iso-8859-1?Q?QPKEORAJLd9READWPi+SV2Gtr+bMq6cKj1JGoNaKA5yQiDC0hsHIVZClNS?=
 =?iso-8859-1?Q?t9LS4Iu93XqJ1AZPILJ4RfUONb+EUzkMLotgw7tMb6iUIT3tG9qD7VyHF0?=
 =?iso-8859-1?Q?FbYRJzHJjRLEBwAoILdKb47p2VRAdGoukRSJ84CUmTSjIQpJOgtk9B4l3e?=
 =?iso-8859-1?Q?byn49V7ZOvPTj6Fiy/INGHCdp4aKhEcer9ZFjYUyuLHvKjjguaunacrPtt?=
 =?iso-8859-1?Q?vVv2Ec0chNY+qX2ABRd9ZYfIjgSxgdRXMH9+1DCSzMnCh0nCg2yW0Dz0Hb?=
 =?iso-8859-1?Q?/ER1Kq2dioB1C52oOq5wOC3wJDzqxjLvNO0mP2Ci5cXGx2qF1w/GFMZdcA?=
 =?iso-8859-1?Q?wQThJtf93XcmpPxxHVW0UXtWL6ElWpxP17RorppqB6r4Brhfmi0EAY7zPQ?=
 =?iso-8859-1?Q?GONAQjRD/vt3IThcLbnHdFZPr3Mp5kD2M0AHtqeIL0kzju/lnE/EI1wziG?=
 =?iso-8859-1?Q?6NiqmGLsWKyKPeB9XZcfE9qKOgXYtLnM+2JNVUjJ/mnelwe7mzttq9XZhL?=
 =?iso-8859-1?Q?ZBnI2ANOv3FBYmME97bGkBHLvJoYkyKzSUborkFcsDUEPdUHF7DNruahSC?=
 =?iso-8859-1?Q?/fMCP6r7vDXQnTTyHX39enjwZRcgdcMcMDDpOJmt4xPvWesgMIUOYSl2rH?=
 =?iso-8859-1?Q?q685/gmdiuYF22RwuaIOXpTFMHZascbfYSym/lbWmQAGmdo23YZoMKQ3y6?=
 =?iso-8859-1?Q?5g5kzmYP/H9i+2FNwl7LSlUqKdVy3ULkPo/A0R7WWXcg0SKUjMWsQo1hAQ?=
 =?iso-8859-1?Q?pKf0nfUw4jgPWtNj+XGBcU4EV9fNz389kp+sccuGOP2N1LXmjcFbIO5P4r?=
 =?iso-8859-1?Q?IhCAZHfKtEEX3UisEMrg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0uz5akKPn6S7j/+7dVY6XqXAs6+fM/kB6HqnSPY5ZJtWoGcTnIBSCyN8eO?=
 =?iso-8859-1?Q?4x0tMEVk3Qc+wLtruA5n9VSbp6DknrXMN95Qf1zVZajOP/PNOWShyrsHvE?=
 =?iso-8859-1?Q?rEVrFygwS8/OwGtXkcUrKspxPYa5n3iTOON75RuWlG32P3FtTiUXdnFEUZ?=
 =?iso-8859-1?Q?YEI8nvvffrz4Vgf0+LaehJ3iUM4lnfu7eqaktdv5v5FobqkJIp3G3eCbTD?=
 =?iso-8859-1?Q?K4JscpdBN5BsKqPzNMCPEa5r3eOhcN8WDsDeZX7u6sMf0LMfhorMnhuByd?=
 =?iso-8859-1?Q?7dWEcnMgVR1c3/ur/GivbvWWkmT1oLkWQwvWE4b2nfQD74r3YkFtoL/Mt4?=
 =?iso-8859-1?Q?+ny3QAs290XkMmDJ2I2Lzs7gWpFUtnafWe2JCd05j9WviR9Erl9cH/OpOC?=
 =?iso-8859-1?Q?miHi6MYGBwCWfrAoF7RfL09EWNY3HMWXQb5rJy6C8m91sZnRi+j2J4z7lF?=
 =?iso-8859-1?Q?i2cVcurPI9Z4cprRLrBPrGl2cCCvzHpEiDbYoCGAD9gjxgqGRrCJD6llEq?=
 =?iso-8859-1?Q?KLGIfL1NxsBQTqzeaZU4MFL7rnQ0OGsjEyDP8gGuTaMWdyPyTlF0lax1p+?=
 =?iso-8859-1?Q?e+XNHP3Xh6VX6oHfYjswzl0O98eg1OoKOthX+KryTwUpqj4vr4xuMM28KF?=
 =?iso-8859-1?Q?FcMTLRDpL57FV1WvHueT5S/hKfACwXWZcEftjb9csDL2z8dS9g/Vu4tCL2?=
 =?iso-8859-1?Q?QNs8YUXa9NX6PfJgLnVm7xlYkH3duImrNeXiyDMj2e8SKJ+9gwqqcUS3J6?=
 =?iso-8859-1?Q?yt+Paku6uCID/OKHv45TVpu0vwmEGsJaZ+ct/CrGdoLd/6s+ORdrIlj52K?=
 =?iso-8859-1?Q?94pD0qylqS2qqjBX20PoSFpLtomjoaysvwF5l1TF1MYNtkm0GvF99gtAZy?=
 =?iso-8859-1?Q?CcWpA6HGxEVYNzaw4cXOUkhqjNf58WKhWNomosnlb864/JD90Nb6CP9Llj?=
 =?iso-8859-1?Q?+Z8FiLlgvqkaGNKdpdBdkCqOxlCt3F3+ldlsEuVOIY1DSTBmgnv/xFrg8o?=
 =?iso-8859-1?Q?eI9wnE+sWb8gDTyK5hEIlPjz3awaO8NjYzhA1+0jppvY7QciW8W5kGL2sW?=
 =?iso-8859-1?Q?c68UKYu0sVBHWBmHUUDIOuVdam/eDSDWn+wIsIT+pWRsP/EdeXacDbLrXc?=
 =?iso-8859-1?Q?sE/zFfNbHN/QALOI5QqaiffS/ArrOl6qh2Ylz+yoy66kO4rZepmrP8EmXD?=
 =?iso-8859-1?Q?yuE56M+Gh8ix53m8P5rZypXFMgvT3qa69aXpkzRhXi1L/WyxnmLdKggP9g?=
 =?iso-8859-1?Q?m/MPSBWLyFF27dudOgLDa6KPbgoFas+rVv09i0dNc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee11211e-d023-49c4-ef47-08ddc9e486c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 12:29:10.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10269

The current behaviour of `git imap-send` is to mark sent messages as read
if curl is used, and unread if OpenSSL is used.

Fix this inconsistency by marking the message as read by default in both
cases. Also introduce `--[no-]mark-as-read` and `imap.markAsRead` option
to allow users to change this behaviour.

While at it, also clarify that `imap.folder` will be used if --folder is
not specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  4 ++++
 Documentation/git-imap-send.adoc | 10 +++++++++-
 imap-send.c                      | 18 ++++++++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 4682a6bd03..afae49391c 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -45,3 +45,7 @@ imap.authMethod::
 	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
 	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMA=
P
 	plaintext `LOGIN` command.
+
+imap.markAsRead::
+	Choose whether to mark the sent message as read or not.
+	Default is `true`.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 17147f93c3..3976c128c7 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to =
an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' [-v] [-q] [--[no-]curl] [--[no-]mark-as-read] [(--folder|-=
f) <folder>]
 'git imap-send' --list
=20
=20
@@ -44,6 +44,8 @@ OPTIONS
 --folder=3D<folder>::
 	Specify the folder in which the emails have to saved.
 	For example: `--folder=3D[Gmail]/Drafts` or `-f INBOX/Drafts`.
+	If not specified, the folder assigned using `imap.folder`
+	will be used.
=20
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
@@ -58,6 +60,12 @@ OPTIONS
 --list::
 	Run the IMAP LIST command to output a list of all the folders present.
=20
+--[no-]mark-as-read::
+	Choose whether to mark the sent message as read or not.
+	`--mark-as-read` will mark the message as read, and `--no-mark-as-read`
+	will mark it as unread. If not specified, the default behaviour will
+	be decided by the value of `imap.markAsRead`.
+
 CONFIGURATION
 -------------
=20
diff --git a/imap-send.c b/imap-send.c
index 44de0c5a77..a242119164 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -47,11 +47,12 @@
=20
 static int verbosity;
 static int list_folders;
+static int mark_seen =3D 1;
 static int use_curl =3D USE_CURL_DEFAULT;
 static char *opt_folder;
=20
 static char const * const imap_send_usage[] =3D {
-	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbo=
x>"),
+	N_("git imap-send [-v] [-q] [--[no-]curl] [--[no-]mark-as-read] [(--folde=
r|-f) <folder>] < <mbox>"),
 	"git imap-send --list",
 	NULL
 };
@@ -61,6 +62,7 @@ static struct option imap_send_options[] =3D {
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
 	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server")=
,
+	OPT_BOOL(0, "mark-as-read", &mark_seen, "mark messages as read after send=
ing"),
 	OPT_END()
 };
=20
@@ -1402,7 +1404,11 @@ static int imap_store_msg(struct imap_store *ctx, st=
ruct strbuf *msg)
=20
 	box =3D ctx->name;
 	prefix =3D !strcmp(box, "INBOX") ? "" : ctx->prefix;
-	ret =3D imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
+	if (mark_seen) {
+		ret =3D imap_exec_m(ctx, &cb, "APPEND \"%s%s\" (\\Seen) ", prefix, box);
+	} else {
+		ret =3D imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
+	}
 	imap->caps =3D imap->rcaps;
 	if (ret !=3D DRV_OK)
 		return ret;
@@ -1513,6 +1519,8 @@ static int git_imap_config(const char *var, const cha=
r *val,
 		cfg->ssl_verify =3D git_config_bool(var, val);
 	} else if (!strcmp("imap.preformattedhtml", var)) {
 		cfg->use_html =3D git_config_bool(var, val);
+	} else if (!strcmp("imap.markasread", var)) {
+		mark_seen =3D git_config_bool(var, val);
 	} else if (!strcmp("imap.folder", var)) {
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
@@ -1702,6 +1710,12 @@ static int curl_append_msgs_to_imap(struct imap_serv=
er_conf *server,
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
=20
+	if (mark_seen) {
+		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, CURLULFLAG_SEEN);
+	} else {
+		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, 0L);
+	}
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
--=20
2.50.1.320.g2ad311502d

