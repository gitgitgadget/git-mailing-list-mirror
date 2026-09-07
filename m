Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010016.outbound.protection.outlook.com [52.103.13.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1040801E
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769161; cv=fail; b=Mx+dQKmw2gq+tR5wNB9ThMjeDjAXCKUjBnyFudFzP/XpJ9Bdd0QeXBqLiTI02cW40CRzr7CCXw85rLO9+BUgeVFoclz9ObZCpuoXBL74ccd3h6OZGqMFn4N0pBMntzs4cyK41lftQkeaIYLOmaVQ+qGGPFo/6K27mDiMP7woFQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769161; c=relaxed/simple;
	bh=RXVm6zydezlUJNEZFQWYYtz1J4dC1JaZIkhxV6crtvA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TxtGHSWoyOwlJeDpIaZrgx2jjNjpTnt10PjSw0COAtMxcXLjjV3an7fUqIjrvVQI9Na/ieKuUKrFid54QrmDV+gUR6kHi2c9agO5R///wplrdKGHv0HP0zHayOcRtCL3k/hA7JAwU6p7y53MKfLqEHdOYQKZstOE9UZ10/kMzFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mpRa25mZ; arc=fail smtp.client-ip=52.103.13.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mpRa25mZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOU0cM0pCyr7TfvGesQlw71qPeUCpIud5TK9GeQ7Bpw91hY6EwaPL9MWBiJ2/VW3dDhUcxvADN3Z5X6ejVAus3bPL3uKAEa+o/wqmoAHGN9GbDzS28ctiqmDYkFrW0N9qKZsBFWhTjm7AHRZ3VT0Z12RABQ0QynjXCYvDware/jvi43xpJh0dH1OckkSIDQ3UbOzSCKvT6+ZaO0wo3ZNB+maQNdV5DQWaQvKDu3xxM7ezd14jtlxpvMNdgCGCP+fF7f+lZBpTs8Isji6cLMJM53JDw3piBy+EfDOSQU+IhlrfNZ4qbKO/P3xH7QVYqTFr1fcKq2iNQb8P09ljso63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXVm6zydezlUJNEZFQWYYtz1J4dC1JaZIkhxV6crtvA=;
 b=RNvZUMkFEJ49WRyL1giNVVR2Oqqpxf8FfBzOhcGG1C3CDqJ2f9xoo8vcZD6o7fdrhhkY499xeP910fyq+aGcYXCILu4bJ0aXPh5HqcLIHJCIgExvMgE94NaPUTqLZqSrrc2Js7AzQxRplUm2uXkA2S/ojatCyi1/3oSBZWwcW8MdL9li8DTNIxKgT9AbnKh7KxplELtVwiHIVITlwO371pemXp2O01VnYLkPz1ckbPMBqQqXowFYsMniNevQMtGdNUEdjenX8mnAJ3vwCKJ8NQ7iNBEglz3bK1NPy4veM/HTT4AtpNAa79RMOv/sZn5ubqj9D2NCLzEdzr+1SeZS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXVm6zydezlUJNEZFQWYYtz1J4dC1JaZIkhxV6crtvA=;
 b=mpRa25mZ9+zv6nxgYIyDZAKsYtb4amBb3BHW9XlKy/LXi0Q7BluYNFkH5g8yAAuL+Ga+epgMXKZWP1NhV5bP7OgDWxaFmpd5zmuipDvYmk294kUos6tY7FfM6OdtFdzEFPwJT6KnV93cyIvBVkjR/hjX5t/OglMvuIu4I3HEztc7KJ9+f33XXQl0EHq3DByfu4m7V+v2/REIpMmNrgV+h7lj0w3imiMN388rwRrB01L1qo+gBjEfMjYZtV8LeA83SOyYSVeCJkdCjS0A5P+oa0R/xuIq1dcEgc5X5q5ZsQaeTeR+CHJCw/RG0yAqcA5RIrTS0wu8EUxjkui078MMRQ==
Received: from DSWPR04MB9945.namprd04.prod.outlook.com (2603:10b6:8:35e::18)
 by DS2PR04MB994121.namprd04.prod.outlook.com (2603:10b6:8:4ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:19:17 +0000
Received: from DSWPR04MB9945.namprd04.prod.outlook.com
 ([fe80::f5d7:5b55:28e9:12e8]) by DSWPR04MB9945.namprd04.prod.outlook.com
 ([fe80::f5d7:5b55:28e9:12e8%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:19:17 +0000
From: AIKSXD ax <aiksxd@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] git pull silently overwrites local directory with symlink due
 to .gitignore "dir/"
Thread-Topic: [PATCH] git pull silently overwrites local directory with
 symlink due to .gitignore "dir/"
Thread-Index: AQHdPpg7KjdB1bmo8USa7LbKnLwbbg==
Date: Mon, 7 Sep 2026 08:19:17 +0000
Message-ID:
 <DSWPR04MB9945756976C15A3A4978CE9AD0B22@DSWPR04MB9945.namprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR04MB9945:EE_|DS2PR04MB994121:EE_
x-ms-office365-filtering-correlation-id: 1d289542-49e7-4d89-4c9f-08df0cb8b60b
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|41001999006|4140399003|6050399003|19110799012|15080799012|20031999006|15030799006|8060799015|8062599012|24021099003|31061999003|39105399006|3412199025|440099028|26104999009|102099032|12091999003|40105399003|3430499035|2607281247196008;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFF1YmRKTzJjSjhEWTRRVnhibEhKWVBaL25GbUFDTUJON0JZcS9OOC9IT2l0?=
 =?utf-8?B?VlJwMWJXSGIvemE1MnVXQmptVFJPeGtLU3BzMzNtMWt2Yzd6YjM3Und4QWhB?=
 =?utf-8?B?MWRJYnRUT3BQb2pvYldXVHg3dFltYWU5dlRWV0dPSXBzcFYrOEpadjI0YXo0?=
 =?utf-8?B?TUM0UjFzT2kwc0NITlR2Ri9nSWpkMjdWL2Y3cTBTVWw0eXUrUDJjZUZmREh3?=
 =?utf-8?B?cDQ3VWdPcnJZbFhwM2dOWHhqZGtnamxua0twWnpqWFZ1ZHl3NExuN3B4T1Q5?=
 =?utf-8?B?QURwa05RMFM4cytRM0FzOGQ4aG5CQlIwL1B1Nndia1pmT2lrK1UvTUJ5MDFY?=
 =?utf-8?B?WlkwZkpad1cvRHhkYW5tcjI0NEx3WnN3Y3prTlA4VUlzU0RqbXhneFBqNFVh?=
 =?utf-8?B?aytKemtDbTNUUUlOMTMzUW1WbU5aZyt4dnl1eFNUcXhOMnNKSjZXcDFaa0tn?=
 =?utf-8?B?SWh1QktLRExaZzlTam4vcjBTZHJSWG5WK2NEeHkwOHU0M3VpTzBnMWxGSlJp?=
 =?utf-8?B?UkNNYmtTczlicUNKc0RzSk9QR3NWVEwvMndqMEc3N2w5MDZHdVlDRnNsT0FB?=
 =?utf-8?B?aURpTXBIRXJiN0Via1RqL2ZSY1pjM1Rlang2L3Aycjh6SXdVaC8zREk3Wk1k?=
 =?utf-8?B?ZUx2R2x2WDk3MUlzQ3ZueEJvMzVQa2tlZDA0dHd1SGFHN3RFNXpyQ0w1aERh?=
 =?utf-8?B?NmIwOFdoQzVlZjI2ZGEyMTloVTRydlo3bUpYMzRUSnVBenBlT1pCb3gyL3h3?=
 =?utf-8?B?NVRWT1pFRWNTbkxIV1hENUFWTmJyRmZpN2treEhRN1ZoLysrUGRNT0RjQlZn?=
 =?utf-8?B?ZlljT3FjU0c0L0llcEpQaXhXNWdGZHVrSjJ1dEMxNUI2MkhGL3JVdWJrRGpa?=
 =?utf-8?B?ZEFSTlRUVTQyekpaY29qU2FYZ0xJcWR6OTZ2UW11VlNxYmVTTGVZNmphemlH?=
 =?utf-8?B?MVR4cFhrSlZtU1EyVXpOZStKUm5qbWM1TUVTQlZZQ0JBdHNsSkNFekRQSi9j?=
 =?utf-8?B?Y0xxOUh1ZjZRUi9lNDlOS2l2Wlc4OTZSQ1UxT0k2OU9KSENMWmdmNG5ZZnlN?=
 =?utf-8?B?NkM2RWdUNGFIZVlhenkzSGJjVEd6QS9kZlV0d2ZxajJzenZFaXg0Q1BmbmNh?=
 =?utf-8?B?OVR1bldzUzdEWEo4aTlOVlpXdVZFN1ZadzRuVG9KUEh1c0xvb3J5TnJibmNu?=
 =?utf-8?B?YlBxQjlicDNGZnNoVlI4TGpwRWorZDQ3T3JNWFJFQ216czZYb0NVeVlTYzNN?=
 =?utf-8?B?MXFDcDhlb0dWbkxUTWh2U3ZVTmJSbXAzR0s5a2FOYUx2Vy82MUVqYyswZEZr?=
 =?utf-8?B?SFovR2w3KzloOXRJaGxkV0RNVy8vSHhQVlNRakV3dVNBL2dVR25QaG9iVllY?=
 =?utf-8?B?enFsWjR0Vktyd1pzdDM5aEp4U09yeHlnakZPQisvSWgyakNJa01jSHphd0tj?=
 =?utf-8?B?elEzRFB4aCs3WGFFejRZM05CMmNpTVQzbEV2WDNSZmpGQ1hST1JxdUhMNmpB?=
 =?utf-8?Q?FH4kxo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhNNi9ieEtGS3I3M3J5WXFQdVNzUG1LcndXVTdyemVNRmp2TDlNL0tBd3JO?=
 =?utf-8?B?bHNidGl6S1B4SUdXallEL2Y4S3Y4TjZxUG5keUFZR3dMdXBzblRBd3FNaU5Y?=
 =?utf-8?B?NEVkcHAwbEZjUnlJdktUR3RFdGZFUzFxQUZ0dlg0S3dmN1QzdUlJUFhKaElG?=
 =?utf-8?B?Mis5YnBKcTc5OUt5ZGdRSGI1Z2szaXpKQ2pxNk1vS0Q2YUtPa2lKYXFtS0NK?=
 =?utf-8?B?MkZBWlZBY2RWcmdtaEVXUWVDMVZySC8rVlkvc0ZscVl2dERWN2pVZERrNFV2?=
 =?utf-8?B?emhhR1o2dU1ZazJ0QVhha1ViU0g5Y2R4ZTRzN0tkY1hoMG5ubUp6YXZlenJY?=
 =?utf-8?B?dHR6ckQ4eE55Q0Y0OUtFbGtNT2tVblkrOGZueUUyNGk0ZjJ1cjlSZUxEejVt?=
 =?utf-8?B?T2oybUJIcEFEM1hmSFE2WE1Ia1FSM1FqZTFlN3ZnZTJwazJua0xUZHQzTHNY?=
 =?utf-8?B?Zkd5cERXYzIzMXJPQzVyekN0Sk5JVm1rT283cFhPamRQOTR1dEZqZ01HOWNu?=
 =?utf-8?B?ampJWmJncVlpbFJkUmkrT3dZbERtWTVjN1hCR0Q3OUgwcmtIa0FNcGJLZ2Rx?=
 =?utf-8?B?Ri93ekUzU2t1c1ZWRVFzYXBXVnhmcmFDR1djV3FrVjJsc01acVJyVUhMRCtQ?=
 =?utf-8?B?Rk1ucEdhWjlMZDdEb1lSYzljYndlVzRKaXNwN1U2bEJIUzBpVys2RHZqS0lt?=
 =?utf-8?B?elRyVUZCWGhPZmVhdUpBTHpGUEVJYWtYcTJUWXNaN29CcmszZXZ1Q09VUWRi?=
 =?utf-8?B?bWQycy9pWEdZTG45Q2tDcllKR2dNa2c5cEJpUXRXRy9SU3F6UGhGVWVWYVBI?=
 =?utf-8?B?NEhNZ2xzbWx6MzJjb29hbjBGZXdtQWdoWjFvM3R4VW80eG5GRmRiRTB6SUJv?=
 =?utf-8?B?MVZzSGs1OWM4ZVZQVXJ1cnFxQ0R0L2FvM1ZOU05Kc1lXTXM2TFRFdTFuelNH?=
 =?utf-8?B?dENZSlpPdjh6bDRFNzA1Rk1neGN5VVpGaGRSMEUzWjkzMS96dUllMWw2SkdS?=
 =?utf-8?B?NXgvREhKOGJxTURqNzZmMTNMTFZtNnF6NitZLytUV1NxQjdnOVQzMlJudGxn?=
 =?utf-8?B?L1l4ckRHOTc0bHJtdW51ZGk1RVRrTWJJVlBzeFdGdkt1M2FiWDM2bUhYSzF5?=
 =?utf-8?B?Mzk0TTdLK2FydDhScnlJcGtEQVJ3T3ArYnpiTWgrYU9uL0hEei8wV1hDTUpD?=
 =?utf-8?B?UzQvNzdpUEsrMFYvNFBrMTVwbWpvc3g3ZlhOa0s0RFhETmsyZ3NqbEN5eWVX?=
 =?utf-8?B?VGh5YnJRUFJzVlpsMGtuQU8wY01MUmplcVNwd3A1TkZJVVVUVXpTZmN5MWJv?=
 =?utf-8?B?TklhMjBZWXdpbHBTazYxMVQxQldWNlhiUFJxamxuU0ZFVzl3QUpxMDNMbjRO?=
 =?utf-8?B?aUw4QlVzZWZFSG44aklTSEZTODloRTBBVnp2d1IyV1lnT2JnVGdnUlBVOWMr?=
 =?utf-8?B?S3p1Z2RoSzBlYnVjeGVEcTdZWmdjMXU2L0k1Nmc1Q2JwRzVDajZJcW1nZUFw?=
 =?utf-8?B?VjFHZUp5TTZzQU9BOWk5Ynl6UUc1YXdZYjl0ZDE3WVJhTEtxcUUxSERSZDJH?=
 =?utf-8?B?MURUc3hWd3JvUldBSVFWdnpKbU9SVXRjUnRnQkp3bHU1NGo1T2RXWmxjZ0hm?=
 =?utf-8?B?N2RqWEtNc0kwTXFXdjlHbXBOU1c0aUV2T2gzS3RWWnVzbFBFUGNPM3FPYkh2?=
 =?utf-8?B?UFdwK1hFMUZaSTZHVlA1dk1MVkFpMUFEUTdwdVNtSEUvNUxNNUtTbUdBMHcr?=
 =?utf-8?B?QkhlU0tuYWZxUHBBQXdkZUJaWUJOMkM4K3QzQmcrTzdQWG50RFhZNXg1TCs3?=
 =?utf-8?Q?YmEaNC9LDSNZw6Tn0ixvHpSOeCAWVLyXwBKK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR04MB9945.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d289542-49e7-4d89-4c9f-08df0cb8b60b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 08:19:17.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994121

SGVsbG8sSSB3b3VsZCBsaWtlIHRvIHJlcG9ydCBhIGlzc3VlIGluIEdpdCB0aGF0IGNhbiBjYXVz
ZSBzaWxlbnQgZGF0YSBsb3NzIG9uIHVzZXIgbWFjaGluZXMuIFRoZSBwcm9ibGVtIG9jY3VycyB3
aGVuIGEgJy5naXRpZ25vcmUnIHBhdHRlcm4gZW5kaW5nIHdpdGggYSBzbGFzaCAoZS5nLiAnZGly
LycpIGlzIHVzZWQgdG8gaWdub3JlIGEgZGlyZWN0b3J5LCBidXQgYSBzeW1ib2xpYyBsaW5rIHdp
dGggdGhlIHNhbWUgbmFtZSB3aWxsIGJlIGNvbW1pdHRlZC4gTGF0ZXIsIHdoZW4gYW5vdGhlciB1
c2VyIHB1bGxzIHRoZSByZXBvc2l0b3J5LCBHaXQgc2lsZW50bHkgcmVwbGFjZXMgdGhlaXIgbG9j
YWwgZGlyZWN0b3J5IHdpdGggdGhhdCBzeW1saW5rLCBkZXN0cm95aW5nIGFsbCBkYXRhIGluc2lk
ZSBpdCB3aXRob3V0IGFueSBoaW50cy4KCk9TOiBMaW51eChHaXQgMi40My4wKSAmIFdpbmRvd3Mo
R2l0IDIuNTMuMC53aW5kb3dzLjIpIGJvdGggcmVwcm9kdWNlZAoKQ29uY3JldGUgZXhhbXBsZSAo
ZnJvbSBhIHJlYWwgaW5jaWRlbnQpOgoxLiBXZSBoYWQgYSByZXBvc2l0b3J5IHdpdGggYSBzeW1s
aW5rIG5hbWVkICdkYXRhc2V0JyBwb2ludGluZyB0byBhIGxhcmdlIGRhdGEgZGlyZWN0b3J5IGxv
Y2F0ZWQgb3V0c2lkZSB0aGUgcmVwbzoKCsKg4p6cICBleHBlcmltZW50IGdpdDoobWFpbikg4pyX
IGxsCiAgICAgICAgdG90YWwgMAogICAgICAgIGxyd3hyd3hyd3ggMSBheCBheCAxMCBTZXAgIDcg
MTQ6MTEgZGF0YXNldCAtPiAuLi9kYXRhc2V0CiAgICAgICAgLXJ3LXItLXItLSAxIGF4IGF4ICAw
IFNlcCAgNyAxNDoxNyB0cmFpbi5weQoK4p6cICBleHBlcmltZW50IGdpdDoobWFpbikg4pyXIGNh
dCAuZ2l0aWdub3JlCiAgICAgICAgZGF0YXNldC8KCuKenCAgZXhwZXJpbWVudCBnaXQ6KG1haW4p
IOKclyBnaXQgYWRkIC4gJiYgZ2l0IGNvbW1pdCAtbSAiZmVhdDogLi4uIiAmJiBnaXQgcHVzaAog
ICAgICAgIFttYWluIDZhOWRjYThdIGZlYXQ6IC4uLgogICAgICAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQogICAgICAgIGNyZWF0ZSBtb2RlIDEyMDAwMCBkYXRhc2V0CgotLS0tLS0t
LS0tLS0tCjIuIE9uIGFub3RoZXIgbWFjaGluZSwgdGhlIHNhbWUgcmVwb3NpdG9yeSBoYWQgYSBy
ZWFsIGRpcmVjdG9yeSBuYW1lZCAnZGF0YXNldCcgY29udGFpbmluZyBpbXBvcnRhbnQgZGF0YS4g
QWZ0ZXIgYGdpdCBwdWxsYCwgR2l0IHJlcGxhY2VkIHRoYXQgZGlyZWN0b3J5IHdpdGggdGhlIHN5
bWxpbmsgd2l0aG91dCBhbnkgd2FybmluZzoKCuKenCAgZXhwZXJpbWVudCBnaXQ6KG1haW4pIGR1
IC1oIC1kIDAgZGF0YXNldAogICAgICAgIDY0TSAgICAgZGF0YXNldAoK4p6cICBleHBlcmltZW50
IGdpdDoobWFpbikgbGwKICAgICAgICB0b3RhbCA0LjBLCiAgICAgICAgZHJ3eHIteHIteCAzIGF4
IGF4IDQuMEsgU2VwICA3IDE0OjMyIGRhdGFzZXQKICAgICAgICAtcnctci0tci0tIDEgYXggYXgg
ICAgMCBTZXAgIDcgMTQ6MzEgdHJhaW4ucHkKCuKenCAgZXhwZXJpbWVudCBnaXQ6KG1haW4pIGdp
dCBwdWxsCiAgICAgICAgcmVtb3RlOiBFbnVtZXJhdGluZyBvYmplY3RzOiA0LCBkb25lLgogICAg
ICAgIHJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogMTAwJSAoNC80KSwgZG9uZS4KICAgICAgICBy
ZW1vdGU6IENvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDIvMiksIGRvbmUuCiAgICAgICAgcmVt
b3RlOiBUb3RhbCAzIChkZWx0YSAwKSwgcmV1c2VkIDMgKGRlbHRhIDApLCBwYWNrLXJldXNlZCAw
IChmcm9tIDApCiAgICAgICAgVW5wYWNraW5nIG9iamVjdHM6IDEwMCUgKDMvMyksIDI5MiBieXRl
cyB8IDI5Mi4wMCBLaUIvcywgZG9uZS4KICAgICAgICBGcm9tIGdpdGh1Yi5jb206YWlrc3hkL2V4
cGVyaW1lbnQKICAgICAgICAgICAwYmRjYmE3Li42YTlkY2E4ICBtYWluICAgICAgIC0+IG9yaWdp
bi9tYWluCiAgICAgICAgVXBkYXRpbmcgMGJkY2JhNy4uNmE5ZGNhOAogICAgICAgIEZhc3QtZm9y
d2FyZAogICAgICAgICBkYXRhc2V0IHwgMSArCiAgICAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQogICAgICAgICBjcmVhdGUgbW9kZSAxMjAwMDAgZGF0YXNldAoK4p6cICBleHBl
cmltZW50IGdpdDoobWFpbikgbGwKICAgICAgICB0b3RhbCAwCiAgICAgICAgbHJ3eHJ3eHJ3eCAx
IGF4IGF4IDEwIFNlcCAgNyAxNDozOCBkYXRhc2V0IC0+IC4uL2RhdGFzZXQKICAgICAgICAtcnct
ci0tci0tIDEgYXggYXggIDAgU2VwICA3IDE0OjMxIHRyYWluLnB5CgrinpwgIGV4cGVyaW1lbnQg
Z2l0OihtYWluKSBkdSAtaCAtZCAwIGRhdGFzZXQKICAgICAgICAwICAgICAgIGRhdGFzZXQKCi0t
LS0tLS0tLS0tCi0gVGhlIHN5bWxpbmsgaXMgdHJhY2tlZCBhbmQgY29tbWl0dGVkIGJlY2F1c2Ug
dGhlIHRyYWlsaW5nLXNsYXNoIGlnbm9yZSBydWxlIGhhdmUgbm8gZWZmZWN0IG9uIGZpbGVzLgot
IE9uIHB1bGwsIEdpdCBzaWxlbnRseSByZXBsYWNlcyB0aGUgbG9jYWwgZGlyZWN0b3J5IHdpdGgg
dGhlIHN5bWxpbmssIGNhdXNpbmcgaXJyZXZlcnNpYmxlIGRhdGEgbG9zcy4KVGhpcyBpcyB1bmFj
Y2VwdGFibGUgYmVoYXZpb3I7IEdpdCBzaG91bGQgbmV2ZXIgb3ZlcndyaXRlIGEgbG9jYWwgZGly
ZWN0b3J5IHdpdGggYSBzeW1saW5rIHdpdGhvdXQgZXhwbGljaXQgdXNlciBjb25maXJtYXRpb24u
CgpJbXBhY3Q6ClRoaXMgaXNzdWUgY2FuIHJlc3VsdCBpbiB0aGUgbG9zcyBvZiBodW5kcmVkcyBv
ZiBnaWdhYnl0ZXMgb2YgbG9jYWwgZGF0YSwgYXMgdXNlcnMgb2Z0ZW4ga2VlcCBsYXJnZSBkYXRh
c2V0cyBvciBvdGhlciBpbXBvcnRhbnQgZGlyZWN0b3JpZXMgd2l0aCB0aGUgc2FtZSBuYW1lIGFz
IGFuIGlnbm9yZWQgc3ltbGluay4gVGhlIGRhdGEgbG9zcyBpcyBzaWxlbnQgYW5kIG9jY3VycyBk
dXJpbmcgYSByb3V0aW5lICdnaXQgcHVsbCcoIEkgZG9u4oCZdCBrbm93IHdoeSBzbyBtdWNoIGZy
ZWUgc3BhY2Ugc2hvd2VkIHVwIG9uIG15IGNvbXB1dGVyIHRoYXQgZGF5KS4KCk15IG9wdGlvbnM6
ClRoZSBwYXR0ZXJuICdkYXRhc2V0Lycgc2hvdWxkIGFsc28gaWdub3JlIGEgc3ltbGluayB3aXRo
IHRoYXQgbmFtZSwgc28gaXQgbmV2ZXIgZW50ZXJzIHRoZSByZXBvc2l0b3J5IGluIHRoZSBmaXJz
dCBwbGFjZS4KSWYgc3VjaCBhIHN5bWxpbmsgaXMgY29tbWl0dGVkIChhY2NpZGVudGFsbHkgb3Ig
b3RoZXJ3aXNlKSwgR2l0IG11c3QgZGV0ZWN0IHRoZSBjb25mbGljdCB3aGVuIHB1bGxpbmcgdG8g
YSBtYWNoaW5lIHRoYXQgaGFzIGEgcmVhbCBkaXJlY3RvcnkgYXQgdGhlIHNhbWUgcGF0aCwgYW5k
IHJlZnVzZSB0byBvdmVyd3JpdGUgaXQgd2l0aG91dCBwcm9tcHRpbmcuCgpUaGFuayB5b3UgZm9y
IHlvdXIgdGltZSBhbmQgZm9yIG1haW50YWluaW5nIEdpdC4KCkJlc3QgcmVnYXJkcywKYWlrc3hk
QDEyNi5jb20=
