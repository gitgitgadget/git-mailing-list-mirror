Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7842AA9
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749193163; cv=fail; b=ACI7kNPY8jYw4eZsATdHi3HwO+0Cv2CE1tcDcUBzx9bubthUtISwyoD3rcov1TLd6tvAjhgpiMTBb0rOGk/lSzFnD0YATavldULy+FWin4taFK9TUy6z+HMNj8qK3qQP0LTxdn9H0BOrmPR0EQbqjdK2E+1F7+SmWSEXDvTgXQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749193163; c=relaxed/simple;
	bh=yWrvjugN6KlDizbWq1p3ivkiNUIxBetvfTZwxV1ZnYk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EYBqHtwEaWn368yaytMw19XE0EDhA95zOttAStilm1GefU87tBM3771FU5RlN3A6NEKADL0VYkASgE7pzX4F5bgPlU48VzuUSJpnq339MajdwdOZXoC/lnYNd4pW7wSB3Bezcwg42BIjURBiT29/EA5JphhXqEfUXpXbpNX7TNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pyCtM7KS; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pyCtM7KS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9QmiWoSScgwC9av7TYPwNog6/zCpkhc20K3UDjiyiBBcrYP40jSFKy0n1hhy4y/8wQYa+dljpYdQhz3kbh4nl144Cj4bKWmDCXoUr4ZKtwzCIGksIGvcXWe/ngSCcTKXtYfXKAKfV5UqY5i7pBE7LxIDJttqs4HM0UV4bkIPc5Uk2OudrqAng/yjfxV8M7nSZswHMlPjPsvyBZyCrmMj2YMo4PZZ0rD/9hElhP5vsnPyinzkcXw2orGxs1wPgRA5t2JwNLTON90kRQE4TomSso0L/tpkNYKH4wxFCePnCIJcaz2qSMsA+0Rn0kwwWiAjAXyC/JmfZeFzleD4ny7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWrvjugN6KlDizbWq1p3ivkiNUIxBetvfTZwxV1ZnYk=;
 b=aOW4oMU6ev7aDO/QluEeXeCgm6+ag45oQeKagZKSZtokCzDF6GH2CNAoBHvlbYnbwmslWKpukkACSQE77hffbq9S/dSHUu/p2rAm6aFZzH9QBvNm/G1wkWn1bLkO0Udfq3DkC2d28LqaVBkz5aP4v9dYegLBfDmIFjLVKPkOrdEy4eZwDg/M0Ym4bIjdQ4MApP71a4JIIsNyjnNG2XeCA8IQWQ87Ib8xk3CcIWi7aDYELAtOdkLamx17txzyQ3xPn9RvhQiFoh7w8e1HaGFiqBnhHtDaoZxhlkgIPn0WiFrsyeGqvlScXZUx0C8NOfbe27fUG/BiRN8Yid9WG8qAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWrvjugN6KlDizbWq1p3ivkiNUIxBetvfTZwxV1ZnYk=;
 b=pyCtM7KSj8YT4IfG8Er1l7HS6h3dfGuELpd5AVMxv8kQZ7el445MlsbvUvMsFZpArrHzC2/zBR8TFq1YystcihmybG0E0irELVTnSp8vsUPxo2s8iylsACBf78VPcUXVH8yZHcZ6Xx6rWwCubrDEb5qUIxfOrWdPlbibFxDcAZIpKJn7g9vtGXo3SYkGUXrW9fg8ZlWavQ9kJujHxAcWqSXo93wu1ysdzS6Q8ylkQH9CqsVsfWAfIJBOtj6NZuqYHkUvDTH+D4jr6X/CI03lSmGHhxD/9QMWjml/SYVXexQs68Cezy6jnfO5S4hTYiG+8KllvgvvLDFgERzk2yT8ag==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9132.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Fri, 6 Jun
 2025 06:59:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 06:59:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb1rCCpRSbkEC9pkCE5UNU00JzjA==
Date: Fri, 6 Jun 2025 06:59:12 +0000
Message-ID:
 <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9132:EE_
x-ms-office365-filtering-correlation-id: 863532d7-d3ac-46bd-5b31-08dda4c7a508
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|6072599003|19110799006|15080799009|8062599006|8060799009|7092599006|3412199025|440099028|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWlrQXJFQVdLWVRBNzEya1d1c3BXanhGd1l1QlJJTjUyVTAyUFR1WTJVVjdH?=
 =?utf-8?B?NFc2UE1MVzlWQk5OTTNTaEIwcFlCRlNCK1UzWkNTTjRDVXhsYnlqSXFvZDdw?=
 =?utf-8?B?M1dnQi9TY3NiWk5hYUNtc1FVb3ROTTdVVTlFRnJIUnFocEVpalpRNU8xRWRj?=
 =?utf-8?B?NHBqSGNZS00wQ3B4VXpDTE94b1RUL2R1dEk1VDZRbmUrODhhcnFOcVpBTXNW?=
 =?utf-8?B?N2dTb3JtZHFzcVBNVDh1K3VnVzJ3bys3UGJpSXdqRGdjbWdTTnZaVGJDYll2?=
 =?utf-8?B?dGpZcTNRS2hEa250dVQxOEs4WkpaNU93TjRxS0o1VVhkRFNhazFkamE0ZytK?=
 =?utf-8?B?UEFqQmhiLzl4cFFNdHRtaEZ3WUdnbjB1WmYwTGFQN3hiRnhweTg4V3dLY2xQ?=
 =?utf-8?B?K3NFdTNiV0VYTytCSkl0eFNha0dHS3dhbGdyWkdKUWZ6QmoyWVAyNmhBVzNl?=
 =?utf-8?B?ZzFJZk5JdlYrVks4VmJMSXlwWjdyZythVk9IUGV1RGZCL2ZoNVVNMEt4bC9J?=
 =?utf-8?B?OWJuYXczU1ljSityaWRjNnMwVnl6ZnIzMHltZ1JoWUpUdFVqdE9jSERVa1RV?=
 =?utf-8?B?eGFERkMxYjd2Umc1d25nSUlyU1MzUEJtYUNKUmowRzNrbXVac0lxeG9UZkFY?=
 =?utf-8?B?bkpKaFAxUVJkL2l1N1dGNGIxRjlPc1pPaXdGWnBSNlIwK2ZER2FBUnVKZlpC?=
 =?utf-8?B?YUNSc0ZzcDNtZHBENS8rMTVsdmFZaEQweGQxRG1rOGpvcExndU9uR25kUGhq?=
 =?utf-8?B?QU9ZNDhJOXNUaUlIRnkxZml2Y1V4dHV6NzRSZXo0N3NFSjQ5bzJEaXMxOGl3?=
 =?utf-8?B?SEFPbVVCMGlEMEk4djlHS1J3c0pqNDBRZGlmVE9nMjNNY3ZlK3pXd3Fnby9X?=
 =?utf-8?B?Q3BnUmpqKyswRUtPWVVtUnVvMWhuTmpBNlk2MTNoQTJxNy93TllYTmpOMmhG?=
 =?utf-8?B?SzdUMnJzUjRMTWJlSGNtT0pxaGl2S3NIVVRYbmlKTXVKanJpTXJrYUU5TUdy?=
 =?utf-8?B?VDdXUnZPNlhqSU1Ta1J0YzN4SWpld3NhbmNJVWJNcjFnZTJPZXZuWk5MSzJo?=
 =?utf-8?B?ampLN2dKWlgzdE9yVlVJNEJFcGdSM2kxWFBUM1ZUTWJjY2kxZTFkR0w4U2g4?=
 =?utf-8?B?TmptSFpVS21OcnV4czA5a3hrdkNkOHAwU2c4Z24rV3o2aVE1QTBVUlBsejBv?=
 =?utf-8?B?a2dsdHBxZ01vd2VMNzNEVVpyMEc3UDhWU1grVVY3aWl1c3JDUmZqeFlWOGVO?=
 =?utf-8?B?c1ZLak80d2hoRVk4SHJRd1MxenowQnFjUDhvbWJGVWFvaUJMODhETVE1dDhG?=
 =?utf-8?B?aVBnSVZ3aG5LVkNhQTBrc21OMTRMY3E0dHJndmx3VWdST2JJaXVyUmxpQVAv?=
 =?utf-8?B?UW5YYlJqWXJvZitZcFNnNDNoaE1YdTlhTlg2aWdrNGJhMG1IY0lyOEVEKzVM?=
 =?utf-8?B?Rk9HaHZ2T1l0eGUreVB4OW9LRytCVFpHQzEvTVdSMmhYR3Fjb1huMjF6QzVo?=
 =?utf-8?B?cy82cFF4aFF4TUhzdEJTWHcrRFpVWHF6SDlkUXZxTExSNDdBckdWQXl3L2d5?=
 =?utf-8?B?L2ttZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGFKM0pjQTkrNityTkxaSy9Sd1U4ZnhyNkcwaGlObXNHenYveVVyVjJQa2to?=
 =?utf-8?B?ZWdrZzNzOXdjR05zMno5bFBMZEZMNU1WK0tkNmx2RFZBdGtqRERLVFQ5bVh2?=
 =?utf-8?B?Ry9TcDhUQ0xVR1g5MFAyYUx5Q3NQUFRZMUUxWVp6N1QxenJXRHR2V0dNMFpP?=
 =?utf-8?B?QVBIbnhrTXVNOGlkSm54WkN5L3k0bjV6bFk4ZkRrTlFUREdjTU5uOE1IOGUr?=
 =?utf-8?B?cy81dk1IZ1k0djFlMDZ5UDlGY0FnaGg4MlJQanMwV2JoUkY0Z1h1cnNNSkpl?=
 =?utf-8?B?TzViZFJwNXhBMjBqUzRrR05LbDdiWHltZlFRT3IweUkzODJXVi84MW5HczVI?=
 =?utf-8?B?ZmNKUUQ2cXRJRE9udVRYU2p4RXU5TTlZYTlqcWMvUUs1ZTJGN1A0RGZEUWEz?=
 =?utf-8?B?TmhnTzg1TERUM3FQUTdHZVhUckgwWkhzbFRhcUZaYkFkeWx4QmdYaG9sZDNS?=
 =?utf-8?B?Zyt3RU9ZcTJWUFB2RXJ3ZDlMT2c4YkE4QUc3ME9oNHovZXV1cVdDb0xpYzRK?=
 =?utf-8?B?RjNkRmdtRnVFUVd0NkdIcXNqVFdsL1pPL3AwcHVkbmh5aVlqdzNIVmROQ0Zw?=
 =?utf-8?B?NzduNWJSZnEwQytnKzFTWkpkMjI2OHkvNThiUFdVWmxHOW5iV0R0b1JiYWZp?=
 =?utf-8?B?bzhNeVc2dWdKYy9LbmZFUGdyeUdaVkRHS20zb0JOVlVNNmNSR0hOSHBJc003?=
 =?utf-8?B?aXhwWXBNS05uVzUwbGd4Q3FFYlhBNU5LZ1VDR3kzU0phQnVrOXdsclpEN2lt?=
 =?utf-8?B?VHpmclhiUmxkd0N1UFN5N1R4YWlsV1FONHFhSzZuNjRZODFqaU4zVHMwczVq?=
 =?utf-8?B?Um5QK1Zod1FIOHRHZjlleXV1SjZ5VmFpMWRyMGRKZk42NlZaaG0xQnl1clFQ?=
 =?utf-8?B?TURNc1ZGQ2lJVkRzMzZmUTJZYS8xSlJKcUFzTUVTVkppZVVMblovTDVBVVMv?=
 =?utf-8?B?NVZ2MGw0amRpWjNKSXZsRVh3SlN6VFN0cGxtak54NnBsUXFEdmEyRU84aGMz?=
 =?utf-8?B?bmhwamY3cW1mQTR5SWkwSWxWNHBHMU01cmJ3OXZaWmRpZ2o5MlJ1TFAwYVox?=
 =?utf-8?B?Y2c1VDJrNXVtTUlOanhTOG9xd3RrSUhTZzdvdEFEcGVMeExrZmdjMnA5LzVJ?=
 =?utf-8?B?NlVLMGU5MkVlcUV5LzFURG5RRkNnQTBOM1crM2h2Wk9SUElOK29kVXRKVGRh?=
 =?utf-8?B?M1pnOUpqNmgzNGNxMmwyejk5NHViejJNazdXcUJTV1FoczNwbExJVzM0NjFz?=
 =?utf-8?B?RWRlbnU3MitPWm43TFFuSk43TzF0ZUdpSjFocVlxNlFoUXVQdWxLQ1JYNW5X?=
 =?utf-8?B?R0RYWDd2T3Q2R0gzeUJ1d2hzUks4ZlNhVEdRQ3gyOUN4cUUvTVQxTU5vR2hB?=
 =?utf-8?B?V3IxZmVUdmt3Z0lHZVhmbUR3RFIxaElmZS84UGVtVXZwTWZXc1FxQU1JTWlI?=
 =?utf-8?B?VWRxQVVNMHpQSzF3REoxd1p3MjhLQUpTYVprZHU2MmtEaUV5NksrMGFMcURK?=
 =?utf-8?B?R0V6SUcvdC9obmFxYWN5dWdZOENxeW9ONG9VYXk0UDRHUjY3aGRTSCtOY0FK?=
 =?utf-8?B?dnFhcC94aHB5RTJlVmRBbEU0ZDM3c1NhVjdFNjhiMDBNNmJkWVc4cVA4SUFM?=
 =?utf-8?B?cVloT3E1OGtKMWJnUlRYRzJRdFVCL3RWTkJ2Ynh3b1FBUGhNTFFvU0hBQUJS?=
 =?utf-8?B?YnRBVmVaZUc3dTRzWlYwSzVrZkdyY2hRd1RSZTh4M2N2SCtOb2NHK0U1QVNn?=
 =?utf-8?Q?q/vL26jrF0+FIeqf6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <1FEB0AEEF151014984C82B2AE70428EF@sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 863532d7-d3ac-46bd-5b31-08dda4c7a508
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:59:13.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9132

DQoNCg0KPiBPbiA2IEp1biAyMDI1LCBhdCAxMjoxOOKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0
c3RlckBwb2JveC5jb20+IHdyb3RlOg0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxp
dmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gTWlnaHQgbG9vayBsZXNzIHVnbHksIGJ1dCB3aWxsIHJl
c3VsdCBpbiBhIGNvbXBpbGVyIHdhcm5pbmcgdGhhdCB0aGlzIHdpbGwgYWx3YXlzDQo+PiBiZSB0
cnVlIGlmIGNvbXBpbGVkIHdpdGggTk9fT1BFTlNTTC4gSWYgeW91IGFyZSBmaW5lIHdpdGggdGhh
dCwgZ29vZC4gRWxzZSB0YmgNCj4+IEkgYW0gb3V0IG9mIGlkZWFzIDooLg0KPiANCj4gU291bmRz
IGxpa2UgYSBnb29kIHBsYWNlIHRvIHVzZSBOT1RfQ09OU1RBTlQoKSwgaXQgc2VlbXM/DQoNCk9r
IHNvIEkgd2FzIHdyb25nIGhlcmUuIFRoZSB3YXJuaW5nIGFjdHVhbGx5IGNvbWVzIHdoZW4gd2Ug
Y29tcGlsZQ0KV0lUSE9VVCBOT19PUEVOU1NMLCBzaW5jZSBhdXRoX29hdXRoYmVhcmVyIGlzIGEg
ZnVuY3Rpb24gdGhlcmUsIGFuZA0Kd2lsbCBhdHRyYWN0IHdhZGRyZXNzIHdhcm5pbmdzLA0KDQpB
bmQgTk9UX0NPTlNUQU5UIGRvZXNuJ3QgaGVscCBoZXJlLg0KPiANCj4gICAgaWYgKE5PVF9DT05T
VEFOVCghYXV0aF9vYXV0aGJlYXJlcikpIHsNCj4gICAgICAgIC4uLiBza2lwIHRoZSB0aGluZyAu
Li4NCj4gICAgfQ0KPiANCj4gDQo+Pj4+ICAgIHNlcnZlcl9maWxsX2NyZWRlbnRpYWwoc3J2Yywg
Y3JlZCk7DQo+Pj4+ICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9VU0VSTkFNRSwg
c3J2Yy0+dXNlcik7DQo+Pj4+IC0gICAgY3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1BB
U1NXT1JELCBzcnZjLT5wYXNzKTsNCj4+Pj4gKw0KPj4+PiArICAgIGlmICghc3J2Yy0+YXV0aF9t
ZXRob2QgfHwNCj4+Pj4gKyAgICAgICAgKHN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwgIlhPQVVU
SDIiKSAmJg0KPj4+PiArICAgICAgICBzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJPQVVUSEJF
QVJFUiIpKSkNCj4+Pj4gKyAgICAgICAgY3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1BB
U1NXT1JELCBzcnZjLT5wYXNzKTsNCj4+PiBDYW4gd2UgY2xhcmlmeSB0aGlzIHBhcnQsIHBvc3Np
Ymx5IHdpdGggYW4gaW4tY29kZSBjb21tZW50Pw0KPj4+ICJVbmxlc3MgWE9BVVRIMiBvciBPQVVU
SEJFQVJFUiwgdXNlIHRoZSBwYXNzd29yZCIgc291bmRzIGEgYml0DQo+Pj4gc3RyYW5nZS4gIFdo
YXQgYWJvdXQgbWV0aG9kcyBvdGhlciB0aGFuIHRoZXNlIHR3byB0aGF0IGFyZSBub3QgYQ0KPj4+
IHBsYWluIHNpbXBsZSBwYXNzd29yZCBhdXRoZW50aWNhdGlvbj8gIFdpbGwgd2UgcmVtZW1iZXIg
ZXh0ZW5kaW5nDQo+Pj4gdGhpcyBjb2RlIHdoZW4gd2UgYWRkIHlldCBhbm90aGVyIG9uZSB0byBl
eGNsdWRlIGl0IGxpa2UgWE9BVVRIMiBhbmQNCj4+PiBPQVVUSEJFQVJFUiBhcmUgZXhjbHVkZWQg
d2l0aCB0aGlzIHBhdGNoPw0KPiANCj4+IExldCBtZSBhbnN3ZXIgdGhpcyBmaXJzdC4gQ1VSTE9Q
VF9QQVNTV09SRCBpcyBmb3IgcGxhaW4gb3IgbG9naW4gdHlwZQ0KPj4gYXV0aGVudGljYXRpb24s
IGFuZCBpZiBzcnZjLT5hdXRoX21ldGhvZCBpcyBub3QgZGVmaW5lZCwgY3VybCdzIGJlaGF2aW91
cg0KPj4gZGVmYXVsdHMgdG8gdGhlbS4NCj4gDQo+IFdoaWNoIG1ha2VzIGl0IHNvdW5kIGxpa2Ug
aWYgKCFzcnZjLT5hdXRoX21ldGhvZCkgaXMgZW5vdWdoPw0KPiANCj4+IE9BVVRIQkVBUkVSIGFu
ZCBYT0FVVEgyIHVzZSBDVVJMT1BUX1hPQVVUSDJfQkVBUkVSDQo+PiBpbiBjdXJsLCB3aGljaCBj
YW4gdXNlIGVpdGhlciBvZiB0aGVtIGJhc2VkIG9uIHdoYXQgc2VydmVyIHNheXMuDQo+IA0KPiBU
aGF0IGlzIHdoYXQgd2UgY2FuIHJlYWQgZnJvbSB0aGUgdXBkYXRlZCBjb2RlLg0KPiANCj4gVGhl
IHF1ZXN0aW9uIGlzIHdoYXQgaGFwcGVucyB3aGVuIHRoZSB1c2VyIHNldHMgc3J2Yy0+YXV0aF9t
ZXRob2QgdG8NCj4gc29tZXRoaW5nIG90aGVyIHRoYW4gTlVMTCAodW51c2VkLS0tdXNlIHBsYWlu
IHBhc3N3b3JkKSwgIlhPQVVUSDIiDQo+IG9yICJPQVVUSEJFQVJFUiIuDQo+IA0KPiBJZiB0aGUg
YW5zd2VyIHRvIHRoYXQgcXVlc3Rpb24gaXMgLi4uDQo+IA0KPj4gT3RoZXIgYXV0aCBtZXRob2Rz
DQo+PiBhcmUgbm90IHN1cHBvcnRlZCB5ZXQgaW4gdGhpcyBjb2RlLCBhbmQgdGhpcyBpcyB0aGUg
cmVhc29uIENSQU1fTUQ1IGlzIHN1cHBvcnRlZA0KPj4gYnkgb25seSBPcGVuU1NMLg0KPiANCj4g
Li4uICJ3aXRoIHNydmMtPmF1dGhfbWV0aG9kIHNldCB0byBvdGhlciBtZXRob2RzIGxpa2UgQ1JB
TV9NRDUsIHRoZQ0KPiBjb250cm9sIHdvdWxkIG5ldmVyIGVudGVyIHRoaXMgY29kZXBhdGgsIGFz
IHRoZXkgYXJlIGltcGxlbWVudGVkDQo+IGVsc2V3aGVyZSIsIHRoZW4gSSB0aGluayBpdCB3b3Vs
ZCBtYWtlIG1vcmUgc2Vuc2UgdG8gd3JpdGUgdGhlIGFib3ZlDQo+IGxpa2UgdGhpczoNCj4gDQo+
ICAgIGlmICghc3J2Yy0+YXV0aF9tZXRob2QpDQo+ICAgICAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1
cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNydmMtPnBhc3MpOw0KPiAgICBlbHNlIGlmIChzdHJjbXAo
c3J2Yy0+YXV0aF9tZXRob2QsICJYT0FVVEgyIikgJiYNCj4gICAgICAgICBzdHJjbXAoc3J2Yy0+
YXV0aF9tZXRob2QsICJPQVVUSEJFQVJFUiIpKQ0KPiAgICAgICAgQlVHKCJ3ZSBvbmx5IHN1cHBv
cnQgWE9BVVRIMiBhbmQgT0FVVEhCRUFSRVIgaW4gdGhpcyBjb2RlcGF0aCIpOw0KPiANCj4gT3Ig
dGhlIGNvZGUgaXMgbm90IHByb3RlY3RpbmcgdGhpcyBjb2RlIHBhdGggc28gY29udHJvbCBjYW4g
cmVhY2gNCj4gd2l0aCBhdXRoX21ldGhvZCBzZXQgdG8gQ1JBTV9NRDUgaGVyZSAoZS5nLiB3aGVu
IGJ1aWx0IHdpdGhvdXQNCj4gT3BlblNTTCk/ICBJZiBzbywgcmVwbGFjZSBCVUcoIm1lc3NhZ2Ui
KSB3aXRoIGRpZShfKCJtZXNzYWdlIikpDQo+IGFib3ZlLg0KPiANCj4gT24gdGhlIG90aGVyIGhh
bmQsIGlmIHlvdSBhcmUgdHJ5aW5nIHRvIGZhbGwgYmFjayB0byBwbGFpbiBwYXNzd29yZA0KPiB3
aGVuIG90aGVyIHVuaGFuZGxlZCBtZXRob2RzIGFyZSBzcGVjaWZpZWQsIEkgd291bGQgZXhwZWN0
IHRoYXQgdGhlDQo+IGNvZGUgdG8gcmVhZCBtb3JlIGxpa2U6DQo+IA0KPiAgICBpZiAoc3J2Yy0+
YXV0aF9tZXRob2QgJiYNCj4gICAgICAgICAgICAoIXN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwg
IlhPQVVUSDIiKSB8fA0KPiAgICAgICAgICAgICAhc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAi
T0FVVEhCRUFSRVIiKSkpDQo+ICAgICAgICA7DQo+ICAgIGVsc2Ugew0KPiAgICAgICAgaWYgKHNy
dmMtPmF1dGhfbWV0aG9kKQ0KPiAgICAgICAgICAgIHdhcm5pbmcoImF1dGggbWV0aG9kICVzIG5v
dCBzdXBwb3J0ZWQsDQo+ICAgICAgICAgICAgICAgICAgICAgZmFsbGluZyBiYWNrIHRvIHBsYWlu
IHBhc3N3b3JkIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNydmMtPmF1dGhf
bWV0aG9kKTsNCj4gICAgICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9QQVNTV09S
RCwgc3J2Yy0+cGFzcyk7DQo+ICAgIH0NCj4gDQo+IEkgY2Fubm90IHF1aXRlIHRlbGwgd2hpY2gg
b25lIHlvdSBtZWFudCwgYnV0IEkgYW0gZ3Vlc3NpbmcgdGhhdCB0aGUNCj4gZm9ybWVyIGlzIHRo
ZSBjYXNlIGZyb20geW91ciBleHBsYW5hdGlvbi4NCj4gDQo+IFRoYW5rcy4NCg==
