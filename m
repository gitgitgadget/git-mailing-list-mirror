Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010035.outbound.protection.outlook.com [52.103.10.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB679367F31
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295684; cv=fail; b=Kq78wnF7WulQO7zK1hx4UlV/nzAH5eC8oht1YMkuc0revdIokC6YmS/SbviRRq+5VcCCGhLj+Va9takxXXEXe/1EIHDAwecSHjF2sj/Uuy+mr9CG8dEsceey7NfJH2Q9/ZVnQL43+86ewokEuOD4ncobV34Zd+fPrtHa0/fL6f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295684; c=relaxed/simple;
	bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0cK+pMfoqAIrxG3GS8BrBLKoyuhxfBUzU8ubkvxxhm6kDt8Luq2VrQhitZS4mwJCV9LSpbUssILLET1ueIyb6UjI+mtZM4KAGOszI7ZlXctdLqIo/ZX3x+or5E1hQNVHVtORHRAaTtqERonShag7iVCzo0eN8UrkXVRJcZlsEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dzl8WC78; arc=fail smtp.client-ip=52.103.10.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dzl8WC78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcGraKIwXxX6cXNTwg3zNEXmH3MPrbTi5KVRr1IkT+AkK7tpAlq0YWy+1z5ICO2zmA7BkwomWCdl0S+VhcZ//r54TR4ol6xy20PgDeVDhpoTqmk0IUp85guQ4V/CAvDf5/ewgciIpxQN2vDI3EHH5R+6sNITPJejra6npb+6GJwakvFgEFzQB0AsYZq/84N3BXTkNc/bWw3HUPMwSzt3N0k0lwPQpsjHfbbhwOlOCkf8DPiPROnwFJSAkKKsY0XdeaQXdR7obQMyBMLhlIJ+vQgH4vlc9Cpe6uyMsas2RgLNadUTSGW1Z433lnl6e7pAd428PThJTb7oghtMfOxSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
 b=jc9SW8YisLssbiuHRQF0J1IPXz9L29IYZveTjfwoEcxUapc35Avs32EfnG4N7EVBy9bV36VTphfFdUqCjj7SzH0B9XSOEiUS7ECyKSLP3khgGAJFHamXP66A3gEqgmtZ9/SZlvDk92t5MOLkMD8e1cC5hOQZ892nj61NwqyyNAQut+H5wh6NstCwkTp9feeB3nzJp1oA/7FC57emQJhiuVxiGUXsJ84xc1RyVMzRMmc99mqDHwmbN/ytS1CehWIH3s/5c6N+exDbZb7QpXYgTPqpNcOJl7SwnQYkJe61t7dgBUtKNcH+brOy0STaUqFAbZJusK9Rbb39lYe1bOaKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
 b=dzl8WC78l2gTojHudw5ZCYcj/XtKx3WFcnPx7AM+ajOT9f3zotVhv1L5bbul3+tsZWnJdczYiwNibe+CcInM8TEMvgNw9wFYZ9z2v81TZrKlCEO2YXgJVcPBQYYK7H/SCqEVqtNTqJQkJtgMGMG6yVr0WFNDrFBoARd0K1ShlL+EMb+gyfnshyi20auWE34OtC6Jnmmo8hK9oKEILaMBo+ClZWTulFC/wYEHIfJvBB4EohV01iajAl3jQrkdvg3gouEM2Q5bYKfbD6vAGdfKyMAxTKy2JiRQlnWiEYLhzToP/Y0xI3V3aIWM68bwV5kFSRg6MKnUj/UnuTf8oj77lQ==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by LV2PR10MB997777.namprd10.prod.outlook.com
 (2603:10b6:408:378::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:41:21 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:41:21 +0000
From: Travor Liu <travor_lzh@outlook.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
Thread-Topic: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
Thread-Index: AQHdFDn5KQU+olHpPUChmMyVgf//drZxN9aLgAEJt4A=
Date: Fri, 17 Jul 2026 13:41:20 +0000
Message-ID: <77524BE6-107A-40FB-ABD3-E5B391E7A0AF@outlook.com>
References:
 <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
 <SA1PR10MB9977159B51766C2D9FFE98FD37F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
 <xmqqjyqu6u7i.fsf@gitster.g>
In-Reply-To: <xmqqjyqu6u7i.fsf@gitster.g>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB997715:EE_|LV2PR10MB997777:EE_
x-ms-office365-filtering-correlation-id: e3163d25-e65e-4b37-36f4-08dee4091614
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|6072599003|12121999013|25031999004|8060799015|25010399006|15080799012|51005399006|8062599012|31061999003|19110799012|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2orUDVHKy9nanFYL0RlTFVoei9remFYVVJuVzRZVkRsdHgwQkozcC9lc2ta?=
 =?utf-8?B?TFBpdEp5TUFvSFMyY1BTRHJNMzhjQUFxRGtIVlJlNS9ibWRNdWNLM21TVWha?=
 =?utf-8?B?VlV0VHFmUGlzNC92MHZGOTFXV1Rqd0E4MlE3WW1wTnBJK1JTMVQ3RkU1T25x?=
 =?utf-8?B?MFVJVnR0ZUhFSVlha3VRS3VHMXo3OGJpSjM4anVSbVA5SS9vY1puYUxBRUpt?=
 =?utf-8?B?dnQ3VGovcXZBWGQxNEFoODgwY0wvU1FQbWhpL003N2Fwck82VU52eWtSTFNM?=
 =?utf-8?B?MHl4UFRiMEdaMXNhVHk2N3Y3bjJuZFZ6ZThYUXRGeDJaRVFuV0JYVlpkcm5L?=
 =?utf-8?B?MjVPYUVlUnREL1FGbk5oTFRuaDQ0VVRhSlA2bUN5Qm9oTk4wTTBMUE0zWXpR?=
 =?utf-8?B?aEN5UmlHNG1sVnNLOWFmRnNhNDZUUE5YaktOQTBXaXZrS0pmUXh2YithVnNG?=
 =?utf-8?B?cUtXYkRmRHdNNUFMckFEc1RRUGFqSFZxL3k2YXZrK2VEaU9xaGxsclpIUXE3?=
 =?utf-8?B?dzU0NkFzWXU3OCtjb1JjUTFRbXE3ejVqV3p6YWF1WU5wRW9jQVlOcERLUjdn?=
 =?utf-8?B?dEord1dEYmZ2RDh0UWtNZDlydFpLWmpLVnRobStNSk9YRXhxM0RwVWJQVHBD?=
 =?utf-8?B?UitSSWRKS3ZPcmJtc2J3Rjl6RDU0QnhtNDdQL1EwdGtaNGFrSWVnYi9aYWFM?=
 =?utf-8?B?SCtPKzRYdkpWL3VIMElZUjVPMUxDb2tIZm0rMTQyV0F2bjJKakFjR2hyeWhC?=
 =?utf-8?B?M056bEVQNXNvNmNFYkk1Z3pJWjJnS3FqV1dwa1BhODlYK3h6QWhNNUdOYUtX?=
 =?utf-8?B?RG5RUnpRRzBaTlZlNUFKTlh3OU03SlpBL0lIUFI5NlpHbzcwcGwyMDhIRGFj?=
 =?utf-8?B?WVhmTy9UKytFRHBpd0pJcm8rMVdaZVRnRkJ2blRURXdzenhrOFcxQ21STFhX?=
 =?utf-8?B?d2FwSWtXZkVWaVVjSkNPR0RvRU9yYldoK3ErN3F6NFdNczFqZ2dpaWxwRDhu?=
 =?utf-8?B?ODFQcXM1emhiZ1FjZlhud1NXaUgwUXlNdkd2cTBISlk5Nko0RWkzZWVmNmJr?=
 =?utf-8?B?eDVQcExEYVp5Q1BMemRmWkpJTWZwOFhoN01WWUJjUVVFTy9KbFk3WGxQK004?=
 =?utf-8?B?VE9pc0h6L2ZiSUhtWHlGSURpNlJnKzhGcStJMVh4a1B4a213TzZTYkJtNEFT?=
 =?utf-8?B?Q0c3OW96WFBqNlE5TytkbjRYdm5HM3pOT3RWc0VkaGMvMXVUZktUTnlmcC9w?=
 =?utf-8?B?aVR1Ky9rYzVLM1NGL1JhYnI3YkFZUVBvbmNIR2xsbVRkMzlSbWxFWWkzU2lp?=
 =?utf-8?B?S0VYa1BXZ0lqQytkNy9lcE9GS2ZIeEEyUXl0VlJEZ0lMNHVBb0Q3TklGMFJE?=
 =?utf-8?Q?95C+59MH9VSJTEVF2kmR5RctAikmBYLY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eElxdXVHUUErZVpkYWp4d0V4cmtYZE94M0REaENuT2g1WjdDZFdUaURTeTMv?=
 =?utf-8?B?d2xUb2twYzQ5djgzR3RVUWt0REp5cWNQQm50NXhyNXY3cVNhazM4MzBqYVJo?=
 =?utf-8?B?TUxiQi9lSUtXZk9EYkFDTExhVTBUem1FODVJNEZCbStEQzIvcDlRZ3hZUk5P?=
 =?utf-8?B?WUh4VTRaN1VUVmxsbUU4eTlwWER5S1V2bjNhS3B6WGttaksyYmRkSmRpQjZq?=
 =?utf-8?B?LzRKWDNRRk1TT3BseWFZMnRMekwyYUIxRVNsVzV5Z01qSmpZU0RTU1lHZWJt?=
 =?utf-8?B?WXg5UVNvVU1oSnpzL3NLVjQ0NjNYYmYwdHlNUFdEbDFwWFNwR0s5Y2VlUEZw?=
 =?utf-8?B?djB4azhpQ0FEeVlSZWpkSkNERnBqL3hIWXJSQWhOdkFScjBPSHQxb2xoR2kr?=
 =?utf-8?B?T21yS3RqSmpnbjE5UXRjdEx3dmtGNmg3bWdUYU4rQ0FlUlFXTG50dkY0V2to?=
 =?utf-8?B?Qjl5M1VZTDlvSDhOei9rUEVmN2dFMnNmUGpYSkZJRWVXQ3ZaL05KSzA1V0Zs?=
 =?utf-8?B?VExTUmdxWkRkem5xTVVDbmNZQTRxVDBPQ3BZQ214YnJDOERBUlNGNGRMR3o1?=
 =?utf-8?B?TG8zMXZQaXNOMzF4ekpEVENpWE8yNS9sb25rcEhiY2VaT0tSYU9xU2tFU3lT?=
 =?utf-8?B?dVpwTXUvMXFYdnZtVVYrUE0waDNNK2k0UDlKd3pSNWVYVHRsWWdYVHRtL3ZX?=
 =?utf-8?B?NUFGUkI0N3lTL0xxSFZCNHBzWGhqbXRSWGE0LzByeVFjZFd1YkdtelI1RmQz?=
 =?utf-8?B?dWpZZzhwTXVheXZRd25ZZzlFQ0JXQVhJUXhSVXpaL2RXV21KUHc4ZkZQUXV1?=
 =?utf-8?B?U3BzMVlpbkswakFiQklzYnRNWW95WFd5a3dlV2d3TUxKTGp6U3BMbW01V1ly?=
 =?utf-8?B?d2hKZUM5R3RDWUNCWllrQzUydVJiMVc4RlM3RDJKYWxKblVCQ0ZTUlQvNVQv?=
 =?utf-8?B?TXpxSGpLeGNBRUozeDBNMU00ZFVMQ3ZNK1EvTXlmUUl6dlZxakVLVFZoeGFw?=
 =?utf-8?B?Z1lkc0NUd094dHEvcktFRnQzVmZ5WWlmamdaVXN5cHhrSjF0dStac0EreWJH?=
 =?utf-8?B?eEdoMkpzQUorOWphalM0Vk91RldiVjVFQWY3MzVOemFScndHYjlRMlZ0K1BP?=
 =?utf-8?B?c095bS9QNVdDZUZ0Vko2V3dsaVZHbkhDQjN5WFBqMlh1djJ3QitYSkZ2ZGFP?=
 =?utf-8?B?WDE4d08vcGkya21wZWpvTVhCYWgzajdMeDkyMnA3dUdpVUk1cW4ybEVDelVF?=
 =?utf-8?B?Uk1aNTF5bjVIT3gyNVc1eGVzYlBCQ1JvVENES0hXdjZTSUNHT2I2bENpeXNr?=
 =?utf-8?B?MkdqRi9RNDVHR3VKUDhmZG9UTkw1M3JGWVhKY1BQbWJJWFFKeXJvTHdaNEpl?=
 =?utf-8?B?OWpVWk5oTkpvRy9QaEMzakV5TDNHalJXUWt3bkZncnJ0VU1yeE1sY2xFRXl1?=
 =?utf-8?B?bktNNGpVOVViNVFJMmVoL3dqeVNOblJSY2IxVFdMWlFrNDdlbVpQZlVPRXZD?=
 =?utf-8?B?ZlNYR2l2U2tROWZsT1pjRWQ1MlNtcHlWL01aR2RCSXJDR0RQRVFjeTRBcmp1?=
 =?utf-8?B?ZkNmRkRiN2hQVy9VdDBRYmg5dDJtTCtVanEwOXNRSFA5WndVRURqbkpQenN4?=
 =?utf-8?B?TEdGSWtxTlBsY1VMcG9maUhEYytidkxMRzlEbEc3VzJhZTg3Tjc1c2ttRS9X?=
 =?utf-8?B?RWhMcHZoWWdLOXUxME1DSkNMUWtiUjJuNmp0R05ucXZCT1FjVUpocHA3TkNt?=
 =?utf-8?B?bE1qVVFhZGZrK2U2bEltNVNnTkJiVFZqejhFTHVITkVFcEFub2EvRkpoUEpJ?=
 =?utf-8?B?OThsNThyWi9nUjBBSXpRZkg2N1VxT01aS1FVMVhRT29aeUUwV1BZTUl2bTc1?=
 =?utf-8?Q?jthdtPjrjATnn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11344AB02B85B4439E1BBCD5110BABFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e3163d25-e65e-4b37-36f4-08dee4091614
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 13:41:20.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR10MB997777

VGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkgd2lsbCBzcXVhc2ggdGhlIGNoYW5nZXMgaW50byBv
bmUgcGF0Y2ggYW5kIHVzZSB0ZXN0X2dyZXAgaW4gdjIuDQoNCkJlc3QsDQpUcmF2b3INCg0K77u/
T24gMjAyNi83LzE3LCAxOjUwIFBNLCAiSnVuaW8gQyBIYW1hbm8iIDxnaXRzdGVyQHBvYm94LmNv
bSA8bWFpbHRvOmdpdHN0ZXJAcG9ib3guY29tPj4gd3JvdGU6DQoNCg0KVHJhdm9yQHdlYi5jb2Rl
YXVyb3JhLm9yZyA8bWFpbHRvOlRyYXZvckB3ZWIuY29kZWF1cm9yYS5vcmc+LCAiTGl1IDx0cmF2
b3JfbHpoIkBvdXRsb29rLmNvbSB3cml0ZXM6DQoNCg0KPiBGcm9tOiBUcmF2b3IgTGl1IDx0cmF2
b3JfbHpoQG91dGxvb2suY29tIDxtYWlsdG86dHJhdm9yX2x6aEBvdXRsb29rLmNvbT4+DQo+DQo+
IGdpdHdlYiBzaG91bGQgc2hvcnRlbiBhbmQgbGluayB0aGUgb2JqZWN0IElEcyBpbiBjb21taXRk
aWZmIGluZGV4IGxpbmVzDQo+IGV2ZW4gd2hlbiBHaXQgaW5jbHVkZXMgdGhlIHRyYWlsaW5nIGZp
bGUgbW9kZToNCj4NCj4gaW5kZXggPG9sZD4uLjxuZXc+IDEwMDY0NA0KPg0KPiBBZGQgY292ZXJh
Z2UgZm9yIHRoYXQgY29tbW9uIGZvcm0gYnkgcmVuZGVyaW5nIGEgY29tbWl0ZGlmZiBmb3IgYQ0K
PiByZWd1bGFyIGZpbGUgbW9kaWZpY2F0aW9uLiBDaGVjayB0aGF0IHRoZSB2aXNpYmxlIGluZGV4
IGxpbmUgY29udGFpbnMNCj4gbGlua2VkIHNob3J0IGJsb2IgSURzIGZvbGxvd2VkIGJ5IHRoZSBt
b2RlIGFuZCBmaWxlLXR5cGUgYW5ub3RhdGlvbiwNCj4gYW5kIHRoYXQgdGhlIGZ1bGwgdW5saW5r
ZWQgZm9ybSBpcyBub3QgZW1pdHRlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVHJhdm9yIExpdSA8
dHJhdm9yX2x6aEBvdXRsb29rLmNvbSA8bWFpbHRvOnRyYXZvcl9semhAb3V0bG9vay5jb20+Pg0K
PiAtLS0NCj4gdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2ggfCAxNCAr
KysrKysrKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KDQoNCklm
IHRoZSBuZXcgdGVzdCBhZGRlZCBieSB0aGlzIHBhdGNoIHZhbGlkYXRlcyB0aGUgImZpeCIgaW4N
CltQQVRDSCAxLzJdLCByZXZpZXdpbmcgdGhlIGNoYW5nZSBtaWdodCBiZSBlYXNpZXIgaWYgdGhl
IHR3bw0Kd2VyZSBzcXVhc2hlZCBpbnRvIGEgc2luZ2xlIHBhdGNoLg0KDQoNCj4gZGlmZiAtLWdp
dCBhL3QvdDk1MDItZ2l0d2ViLXN0YW5kYWxvbmUtcGFyc2Utb3V0cHV0LnNoIGIvdC90OTUwMi1n
aXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2gNCj4gaW5kZXggODFkNTYyNS4uN2YzN2Uy
NiAxMDA3NTUNCj4gLS0tIGEvdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQu
c2gNCj4gKysrIGIvdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2gNCj4g
QEAgLTExNSw2ICsxMTUsMjAgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnc25hcHNob3Q6IGhpZXJh
cmNoaWNhbCBicmFuY2ggbmFtZSAoeHgvdGVzdCknICcNCj4gJw0KPiB0ZXN0X2RlYnVnICdjYXQg
Z2l0d2ViLmhlYWRlcnMnDQo+IA0KPiArdGVzdF9leHBlY3Rfc3VjY2VzcyAnY29tbWl0ZGlmZjog
aW5kZXggbGluZSBzaG9ydGVucyBoYXNoZXMgd2l0aCBtb2RlJyAnDQo+ICsgb2xkX2Jsb2I9JChn
aXQgcmV2LXBhcnNlIEhFQUQ6Zm9vKSAmJg0KPiArIG9sZF9zaG9ydD0kKGdpdCByZXYtcGFyc2Ug
LS1zaG9ydD03IEhFQUQ6Zm9vKSAmJg0KPiArIGVjaG8gY2hhbmdlZCA+Zm9vICYmDQo+ICsgZ2l0
IGNvbW1pdCAtYW0gImNoYW5nZSBmb28iICYmDQo+ICsgbmV3X2Jsb2I9JChnaXQgcmV2LXBhcnNl
IEhFQUQ6Zm9vKSAmJg0KPiArIG5ld19zaG9ydD0kKGdpdCByZXYtcGFyc2UgLS1zaG9ydD03IEhF
QUQ6Zm9vKSAmJg0KPiArIGdpdHdlYl9ydW4gInA9LmdpdDthPWNvbW1pdGRpZmY7aD1IRUFEIiAm
Jg0KPiArIGdyZXAgIj4ke29sZF9zaG9ydH08L2E+XFwuXFwuPGEgW14+XSo+JHtuZXdfc2hvcnR9
PC9hPiAxMDA2NDQiIFwNCj4gKyBnaXR3ZWIuYm9keSA+aW5kZXhfbGluZSAmJg0KPiArIGdyZXAg
IjxzcGFuIGNsYXNzPVwiaW5mb1wiPiAoZmlsZSk8L3NwYW4+IiBpbmRleF9saW5lICYmDQo+ICsg
ISBncmVwICJpbmRleCAke29sZF9ibG9ifVxcLlxcLiR7bmV3X2Jsb2J9IDEwMDY0NCIgZ2l0d2Vi
LmJvZHkNCj4gKycNCg0KDQpDYW4gd2UgdXNlICJ0ZXN0X2dyZXAiIChmb3IgcG9zaXRpdmUgInRo
aXMgc3RyaW5nIG11c3QgYmUgdGhlcmUiKSBhbmQNCiJ0ZXN0X2dyZXAgISIgKGZvciBuZWdhdGl2
ZSAiaXQgaXMgYW4gZXJyb3IgaWYgdGhpcyBzdHJpbmcgYXBwZWFycyINCihub3RlIHRoYXQgZXhj
bGFtYXRpb24gcG9pbnQgY29tZXMgYWZ0ZXIgdGVzdF9ncmVwKSk/IEl0IHdvdWxkIG1ha2UNCml0
IGVhc2llciB0byBkaWFnbm9zZSBhIGZhaWxpbmcgdGVzdC4NCg0KDQpBbHNvLCB0aGVyZSBpcyBh
IHRvcGljIGluIGZsaWdodCB0aGF0IGVuZm9yY2VzIHRoZSB1c2Ugb2YgdGVzdF9ncmVwIGluDQp0
aGVzZSB0ZXN0IHNjcmlwdHMsIGFuZCB1c2Ugb2YgcmF3IGdyZXAgbGlrZSB0aGUgYWJvdmUgd291
bGQgYnJlYWsNCnVuZGVyIHRob3NlIHN0cmljdGVyIHJ1bGVzLg0KDQoNClRoYW5rcy4NCg0KDQoN
Cg0KDQo=
