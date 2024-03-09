Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01olkn2075.outbound.protection.outlook.com [40.92.113.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556883771C
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.113.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709978718; cv=fail; b=Joln6HgakIE5wlPAHreLGC89WROfPoesET9mKlGUP/7xnSpg3Q6y8iY8bfFclJsYtwSPau4Jb7jXV/i1/lcUNhlgacdo1Wt4dvrTz18GbACwEuw1P3RBNbNe+ti4AUdWFtmojadgJZq9T8KAgn9LfdkL9qe/wNUin6c0v4X65QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709978718; c=relaxed/simple;
	bh=lMvyGfSEI9WDXg+QGd5xY3qxar/giSEwIv/klI3fr5I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aakINt2i51dKHNERHFSrscBGfkjZJmuns2D9mfpopyUYi8c0p2MM+2nETu60vUxefXMIbnpLJCnE01363MkvLDnEumDKLn8eBA3hCQbtLjzz+rrhBTWjjtU0yNasfeZucBIj0x44+NtoAmJxTei5+X15J92nwN7rlfCuhsKprvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FOKWRpDG; arc=fail smtp.client-ip=40.92.113.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FOKWRpDG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2dzSZ/43OcVsv4bK2biE9aMg+6JzqNwQIqf25s+wUsCMXrlunJ5/So1RM69aXV1f2alLSjRMEb/IHcuGiDwbTYXKRrKjBtb3nMJ2XWJ0favTSzuCgyziblILju95TxSkceOH3su55Qt032CVuV1XPeGRobJeQImmLC4xGSGWaonPadzQxPD49OrrMx6CkHw0YulUnCTrxkECBZYXUWWLOQHTS4tQ3OX5LU3d/pSEbLpehvecVqwGZb5LFAeHoax46DzZp6+OvDaXMFlMmanoiUOXzVDKo6JwbGlsbcVUuEEGLfafgIWDrqmZqcLcKpvzFRtUO+V/eu1dsGjxAxfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMvyGfSEI9WDXg+QGd5xY3qxar/giSEwIv/klI3fr5I=;
 b=lzXs+aiqhX8xG+LOQrvzddlHhmkBEuZ9QSZNVsWWVkRRO74AwfGwc7Om9AuDOYyWFPCXNjNTDOGv1HDTMRUwgXAIidAQ8rdQSwioFnJAb/xTvhIBeABZsr55D4KgwIouqlU41S1aWs1egWU/vYUw2KGsCs9qmBTBDUBgTjXNKk/zk5QNQ7pA16S/ONrpW48g8XhqjVpgD+3c911q9LTurpEzht+pcA8p7A23Q5nm5lNFY8g/qqzjlLqYCfGMNkv8hOUvUe9fQ6OzZYKd9/0SVTud20BmI7r8Z5Ca8tm9IUly/7eDUIGlts22EM8rqPWCbn34M0FuSh2R8TVA9/h0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMvyGfSEI9WDXg+QGd5xY3qxar/giSEwIv/klI3fr5I=;
 b=FOKWRpDGPr3KASyFv/ZFmtm84QlTkzpni+5Yuqu8iPtjQ0IYrI5036nKfUteAa4UubYWA43c0l7TQXeShZnTa82U9q8bFKT056EBMOon0zKQ3bD4yZG5dqSkQ07YZy2I0kDg+xqKL3PVrjt0Wth1dsY7qbsmCbQRDef933gBx9oRx6TJjjkfpWkecY8qN+frrKX4Hesy64lgD66J8zawGwDgc7Ji6SXlwRO9LPLOLIBC6Bx+3Nb5OqMniBxhcR7Xt0oHtz2KbHMP/nDwPUHEmuhAlK9DpxbIDB5DJIsbDkuSI/Mvouat+heMdEvoQ3D16Oxx5gJx6sCheT+HWM5NNQ==
Received: from CWXP123MB5097.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:134::10)
 by LO3P123MB2844.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 10:05:14 +0000
Received: from CWXP123MB5097.GBRP123.PROD.OUTLOOK.COM
 ([fe80::2c93:a25:6ae0:dc3]) by CWXP123MB5097.GBRP123.PROD.OUTLOOK.COM
 ([fe80::2c93:a25:6ae0:dc3%7]) with mapi id 15.20.7362.019; Sat, 9 Mar 2024
 10:05:14 +0000
From: Alex Kubiesa <alex.kubiesa@outlook.com>
To: "Git Mailing List (git@vger.kernel.org)" <git@vger.kernel.org>
Subject: Feature request - summarise changes by folder
Thread-Topic: Feature request - summarise changes by folder
Thread-Index: AdpyCTZYEm1BjNBIQ+SIKyh1RzqfQQ==
Date: Sat, 9 Mar 2024 10:05:13 +0000
Message-ID:
 <CWXP123MB5097836BE3E01F6F90487C3580262@CWXP123MB5097.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [UxSafUNCSfY1hQ31xUNnlbLMjvljozoTd24F5OxV0vsawag1+FmM4cZeYIuX3yBc]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB5097:EE_|LO3P123MB2844:EE_
x-ms-office365-filtering-correlation-id: 899ced8e-8b8a-4261-436d-08dc402069e6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 axIXNMBhzsS0ZDDisBwV8vKbp0m5TbUNsX2OHAXIhNNWnfIu9e8NOEWJCFao0VNEekCyvpxlciLbCdHCH0ugmiQ/crLVGQ64+6kdezOPq4xIMAMHeaFoQtcPSONpzVR/HTo2d70H86Puc8IvlezXBLb+61XrirfXyZL3kCn38NkqII0m4K0eSJbP6L4fb9n7c2AqPjnTGeS1cPAAhzaq82N/vh+h/JvbCsDK4sM84VG76L32DyoMYwRok+w6tmNRsStx1I2TN/5W3aRkJHOzg37qp7HUU9MpLceAGsC1n0LOGzrBjx1ITVJF2JrrKhGfo6MFZbCKiT3YdOEbhRuVI9wfmyR2TsHi+uRNHcUWkHZPFFctlI/t7TC2SxSJINcTANL5NLGlkQbVYCqnfptJJ+AemF4zHQCl9yA6x3/x0UcXI3IdHE9HCgRM3auJrnntCr/swbsrRF2ztPWR7VdUW7Nf7n3WypHqtXooqRpVQeeAVwR+W0Z34ZQUGIWgddGyItOKeUyt2eSC/lZhAdI4Qgk3THuCweDLePE/Gdz5X6YIQWQqPItRhoOL79dvPFpb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W3VXzPu4eCzIeJKIVWlp9pZpn4keb7X8MS+yyb6sWCsYqhp7vGURKrglTTTN?=
 =?us-ascii?Q?av6wEZM3J9LBILjmQIxS2k+AbNebIJijQZzQKRsrODR5GbmqZkLyf206v0p2?=
 =?us-ascii?Q?5jpSNtZ3tj5OvNrIHungOkFGIXreqenv/g2PaXVUx2JRIVZE2eXxVU0BV884?=
 =?us-ascii?Q?I9U+wQw6kIOCRUZgvkyl8Mriw5TPU5/8B+MtjExd8paxi6dutj4fGrRUHzN+?=
 =?us-ascii?Q?xN2tzHnF1MtPdmxDDizzdzjJUjKbERhUIgGCYWdE1rT0AT+y7eOuHRAl4J81?=
 =?us-ascii?Q?qmtXANGQDVDMup1tWyNMYN6dHlhFG9NhTH5ef1am47YeQSUCpuK7A8E8GbPC?=
 =?us-ascii?Q?HvFx0jvGnSHJLDNjCLzkCX+OgZJTrV2g/DxOUlighCONYkFqrDvJwc8A+1X8?=
 =?us-ascii?Q?uWrAgvT62L5LgideibvoYEchOoRF8CqLAld5SBK/oiEUOCNTxjQ5cRZ44mc6?=
 =?us-ascii?Q?Caj1cFXDT37p7WcVXx80NIk7ma++ITsF2CcBj7+YJOl8cFve5ASc7immDTZy?=
 =?us-ascii?Q?Ad97VTldk0HsFylQvIomQQFWG5KqillZGnYzw2q5UTQagDP3waRos0km+Sk9?=
 =?us-ascii?Q?1Dq0WUHuR+sJLz4Wg3BKkIxhev++NCjOAZEh+4uzmQBs0kwi3+Sj+zM1vQhz?=
 =?us-ascii?Q?5chaesMRpp0uooX8xd1mtkzhc0kSBgwzH4iPsniLqss5XP+yHwfailOWAqM5?=
 =?us-ascii?Q?ZuvCe8TnrjZ8Ii2xm4/5FVc9L5srgDcdHZE9nSJd5QqGvbLjsMUHWIlq7c9m?=
 =?us-ascii?Q?ut88fcuIk9TII3u87DKcX8xUd3O+fUXYZXUX+1VaLQinHQEAEch9q4y3JksJ?=
 =?us-ascii?Q?FJbpPhSF/WzMUHka45O7KnT4O8m5+uw2kJk748LSl7Ot+iS1h7TvJxdH1VT2?=
 =?us-ascii?Q?MHvNyeLMPkcXyQMz86FOj5mDF9KLnuzz085sU01yqpfQ0ezFvFf0gn+3mjXt?=
 =?us-ascii?Q?/7QTAmZ9D1Jg4l7WuSFg24/22AhEebwNGBfGEqeRrHKr91jgMP6St8NPwXq1?=
 =?us-ascii?Q?jrVLML5m7kXnh4FjKDoZRTRIVj1W0mE8FtAKOsKeS0tQQwSdk53dwlObsxI8?=
 =?us-ascii?Q?kc5d2Kc4K/aoviqfiMuMva/w9hXHkmctc7Lt8w2Aj9xSmV97K8g0ZD712FQx?=
 =?us-ascii?Q?07fGEkihwrHoLp7yiOSWmZpeI3NWE3x28luabFTg4UvcjRxl3cE0JKl+HE4W?=
 =?us-ascii?Q?ls1FkarVixVDdHp5heUhcZY1sdIgW+NGj9f5M6GWpK3ntwHO3Nc/+80qcSIE?=
 =?us-ascii?Q?qFkCu1U52LhkSe8ybcy6NWhUks88gkl7O0LPhzoWK++IRGRzVf9cCvvnHLkR?=
 =?us-ascii?Q?+ZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5097.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 899ced8e-8b8a-4261-436d-08dc402069e6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2024 10:05:13.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2844

Hi,

I'm new here so please let me know if there is a better place/format to pos=
t something like this.

I am using Git for a personal ML project which has a large number of image =
files (about 32,000 as of today). Every time I add or remove image data, th=
e number or added/deleted files is so large that it overwhelms Git Bash and=
 other Git clients and IDE extensions. If I have other unstaged changes at =
the same time, for example changing a few lines in a data generating script=
, they get lost in the noise.

To solve this, my suggestion would be to add an option to `git diff` or `gi=
t status` which counts added/deleted/changed files by folder. From that inf=
ormation, one could drill down into specific folders to get a handle on all=
 the changes. I tried some existing options like `git diff --dirstat=3Dfile=
s` and `git diff --shortstat` but neither of these gave me enough confidenc=
e to stage and commit my changes.

For now, I am piping `git status` to a file and scanning through the file m=
anually, but it would be great if there was a better option.

Thanks,
Alex
