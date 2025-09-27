Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011061.outbound.protection.outlook.com [52.103.14.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78001F541E
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972283; cv=fail; b=M/LE+XVq+H7FF2/ltMFgLMGS9TtDc5aZ/DMsIsio45I/9hHy0OBxjqJVaY5W5iKoXR9+H0ndw6gQNX35fVNRMG6M5h+iEScdX5E1S6CCiVQs8zJ2S22b6BYFkmnJnUygYgy5CyJL2v26U/n1COyJfyi1QeKu1mAYc60LMWyX77I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972283; c=relaxed/simple;
	bh=DHoer8T1mUw/+jgSZ0Pf6aeHO5+SEzRw0d+QL7HR/T4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JCvZqNbe3nG65VS+CNde1orTno741ZYEMMLIWKH2wVQzZGmSVDgvjXrkn+278HbGIZGedJ7ctj6vgYifmaHd3JVrjjKCuVjPihzUBevyYRgWgHJ2qx9+01TVXcA29kspPM0DYEmi/dc4kfmqRpw1PB7DprB7N2pGTi44SSVHjGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hxtHM0Bu; arc=fail smtp.client-ip=52.103.14.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hxtHM0Bu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa8vqGylKRFMhBxM31thBJMHWcrWyo/8o5l8tfajKyed4SAAkRZ/8xiXw637rrRogOR0qdpFyNUmM9J9hJA/EdCVTH02OFn1jS1bkcLAgYqJk2OSSnD0zbiJKrtZdg7GIhXuGhsSjrCfwo87nVHht0/icJao5LxeVs9GAu2CWhE6tGy2MymGkP5Gk5YiGG/G1XLoXvt5dkl4V0Qab3lDh7Ontx1lJH2diPemDKLFEt/ZoVcOnOddivERoQxMZg+Fn2sn/RXMGvAFKbNasU4ExJhGuDtwhmzn7HVdiB/cicIaRP5s9/jG8SIhHieoF2qtZuGzixWXi/Oe05hO5PqTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHoer8T1mUw/+jgSZ0Pf6aeHO5+SEzRw0d+QL7HR/T4=;
 b=lluo1ObadfFZlnfiwkjIAXSweWDuY+wxmwNaNmkMTaTu+WsUmVYUwW6IKbzas6rME5EaQoaISFkp415F7f51Dj6VsXZko/QG8bRPjbGtRamdbZRORCDZ8jFkfEG25gtHe5TOO+YbC6EzyhBdeoNmTqqKRV4fhv27GYX+u4ihHYqNbBJ7iiLHb+vTMVJT56fMdk4g2QRdGGvSMhf5Po2FOLFFm4zSAidF/oVmq12b3fVcLqcsIeEs8qkNmf7hjMhEvrtvj9K+o0yMS0UduQtMHQGqKuplBP0OCJ2gyl4/Z6Ve+tRp449NZWtmQPwOpYT3j6K5TdyVB/FxyLu1+yxCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHoer8T1mUw/+jgSZ0Pf6aeHO5+SEzRw0d+QL7HR/T4=;
 b=hxtHM0BuTW+auygSmkepVqDjBzClJ8gE8XSlDJOYMKXhGLGoxItbU28HLv1wXrxHN1bhC4MiwN0d6Sw3x69n82i7APD1khOGMyNSoXc879x3dNsXmAPe7zK713qKHoHJrN7+ujHoecCvqrrtQQ6bAcPIEvhMvlFYmF0KFK6u+0hiPwebHb/G07xTuZSjFWSWO9EgrkAuqSB7XBn+CQ3lK3AWF3WPs16oQRk9uV2R21faDJfrhNwlEKa75sKIgNWLGmnrnFM6WjPh0aKAjslovWj3RgQ0TvWaaMaEqLg8gfEdHgQqpmvZKBW5TEZLoM0cvs2EZ433764mYubBtNGC1g==
Received: from SJ0PR20MB5158.namprd20.prod.outlook.com (2603:10b6:a03:47a::8)
 by CH3PR20MB6643.namprd20.prod.outlook.com (2603:10b6:610:173::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Sat, 27 Sep
 2025 11:24:39 +0000
Received: from SJ0PR20MB5158.namprd20.prod.outlook.com
 ([fe80::f6c7:8787:99d7:6169]) by SJ0PR20MB5158.namprd20.prod.outlook.com
 ([fe80::f6c7:8787:99d7:6169%6]) with mapi id 15.20.9160.010; Sat, 27 Sep 2025
 11:24:39 +0000
From: =?gb2312?B?0+og0MA=?= <YuXin_YuYe2024@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: The description of push.default=simple is misleading
Thread-Topic: The description of push.default=simple is misleading
Thread-Index: AQHcL6DwWs9v50+a9U+4BPSXEizjDA==
Date: Sat, 27 Sep 2025 11:24:39 +0000
Message-ID:
 <SJ0PR20MB515802EF2B4A04688D01D2FFE419A@SJ0PR20MB5158.namprd20.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB5158:EE_|CH3PR20MB6643:EE_
x-ms-office365-filtering-correlation-id: 1417d155-526c-487d-ec2c-08ddfdb87271
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|15030799006|31061999003|8062599012|8060799015|19110799012|26104999006|40105399003|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?gb2312?B?U0pnNWd4dFJqUkxaOURzSlR5NWt2azI4clEzTnA2RWxvMngvN1pDdmRhM0lx?=
 =?gb2312?B?N0xTcnRuQzR1VWVOaVZGaFlSMTk5OFQvZnRCcGF5SGhsZ0tUc1NVMUtFK3Qv?=
 =?gb2312?B?MUZkaDRlTFNMcFR0ZXBtUHlUTVk2M3NreVpLWFlPMnEyYXk0M3IzTXdtMWhS?=
 =?gb2312?B?aVNUbjk5K01ENDFZVzRXaDVzS25EY0VuNjBRcFFwKzlzQlFYYkVNdDBvMDJk?=
 =?gb2312?B?U0pnNFNsNVdLRkZIRzRjQ28yMUhBZjJIbTVqMzA5OHlYRVRaK29JUmJPWkpU?=
 =?gb2312?B?THBQcTVwQ1ZGVmN1VmpIZFZ0VnZTWmkyd0F6YmVrZ0Q2b0Y4bWp5L1ZtYUZB?=
 =?gb2312?B?SEtzR2IxLzlZU280SmtHVklpK05xd2orT0lQWndMSWlYTERCMkJKRHp0WVdK?=
 =?gb2312?B?eXA3YVk1UGNDaTlCYWppSzhjYzVhQlZjenJVMzd1ODFQcHdjTjJBZENuSThr?=
 =?gb2312?B?aUJuaW5zaHdOaThVMlRmYUR6SlhGQWE3VElPa2FPSHA4T25BVk41TGxqcXdY?=
 =?gb2312?B?aXVRVklnODMzVFNkZUhGZmxtcUo2Uy9NNHRRVDRzTVZEaGJhZWdSZU9RNHda?=
 =?gb2312?B?S25tNjN5Vm5lTjgrbFg5b2VtQWNwcDN2M0NXZzZnV2V5Q09kS0l0YlhPZ29P?=
 =?gb2312?B?R242ZnVsRmNkaExQOGYvdFNPQ2VIcFZJRjBHNElXZkJ1cllYQ1Nkbm5PblhM?=
 =?gb2312?B?TmUwblIrSTNyM05BVTBlVkYwUjI4Q3plK3JhazA2TEZNejZOK3VPN2ppV1lG?=
 =?gb2312?B?YldlbXJMeEdlMWQ1L0N1SCt0dlpkY1FKZDB3czQ5dStYTWl5UExvUGFFVmpp?=
 =?gb2312?B?eFlTcVp0Q2N4aCtxSGcvLy9kNDdESG00UVVRVDBZNm43U2xYQ29WNDlzOTI2?=
 =?gb2312?B?YUp5T2lxZWdBNlFqOHJGY2NGSTd3RnZBMlRhUjFwNGZXWERJKzhsTmpXVFJY?=
 =?gb2312?B?bTJNYXRzbThWenN6dExNRXFSMWZTR3FhQ2tsUnVlVFpjTUpNNE9ERlh2Mzlo?=
 =?gb2312?B?RTltcVlJbmpxaXdNRk5CNmxMQlNibzRnbU9qd2VwQ3dHSGtzS0JJeUxQc0pX?=
 =?gb2312?B?dXZzVkY2cFc3c1YrNDFnQW90WHlLRkZkekFudWFKUjJsUFo1djROamt1akxt?=
 =?gb2312?B?UHRINTJSbnNOMFpjeXVDTlhsakN1TmcycXFCb2k4YnhOZ0toK0hPS0ZHcXRT?=
 =?gb2312?B?bC9DaktwdVhzbnNkSy9WYzJ0S3VDK1lHOTBlODhFaXlTQUpIL0FpSm9laW5L?=
 =?gb2312?B?UFhtL0duRFc2Y1BtaHRFRTFQa1pxQjRyN3NZYjhCNWowdUR2UzlzM2Roa05u?=
 =?gb2312?B?cWtpdE5aM0s1UVE5RkJWSXFMR3Jnbk1WbjVtcVlaYkpxajBtOVpCd09Sd3F4?=
 =?gb2312?B?YldNRVd0Z0tJVm44R2F2TlJPV25tU2VZWG5mZEhLZXhhNjMwZWhwckZLbGMy?=
 =?gb2312?B?ZGZrWElDZmd0VTB0RzdoK1Bhd2hORnJ4NHlsNGZGeXpYUkRIQ0VqaGdkTkxm?=
 =?gb2312?B?bHI0TENvUGlybTJveU5MSUFueTF4cUgvdDVRbFdBZE5lQURQWGRCSHVRM1p0?=
 =?gb2312?B?QzhNWHlWbEh5SXczQ2RWczVGZGdvQTlYSzg1REhRaDUzZnppZ0JyRmxlbVpi?=
 =?gb2312?B?RU9yYVVNTXJLYVZRZ2Nra3NrcjNxRUVIbStWT3FPd201czNaMVcxK1pPMVhm?=
 =?gb2312?B?enJyTXk2Zy9OV1FJTXpHcGliVUJKQ0xSL1hMcGR1K0tTQjVMMTFMOXFLWnVO?=
 =?gb2312?Q?UBvzUHb9Ggloak4dAU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eDlVMTBnTjZZTGNZM3Y1THRMcG5aVHo2bDNsdGhuQkhSWHFhOGV5UkY3WDBI?=
 =?gb2312?B?dkRUZVVKQnYyeXpDc0VLaWo2L1pYSkF2VS9LdzBNcFJZdW9QQVBrSEdDSmlH?=
 =?gb2312?B?akpReUZWOThFVHNNR09ZWEFJV3BXcktYeGZ4M284K3lJNTh5aHl6djZWU2F0?=
 =?gb2312?B?K3I0K3RjbHFzZFBYWmE4V2p6eDF4MmxEUXFYRWsxT2s5UUJQbVBZamF3Qkx5?=
 =?gb2312?B?b2xYc2xMbW81YnBic3E3R25iQVFhenpVYzIxdUV6T2wwNVNzcTJyOGcxM0FC?=
 =?gb2312?B?dE1iRVFMNGlJK0hWLzZNNmtaRnhEUG0yZXU5Tm5lL1A1L2k0MDAwWWFCWFA5?=
 =?gb2312?B?cDhZV2xhS3hkeHM1MmJMWUs3MWk3c3B5aW5KTGg5Qk5WVUsrcitWRkMyTVIz?=
 =?gb2312?B?T3JrM3QvbzQvazJYYStUbGdodlVnZ2NkYzl6aWNJcHA3UEJ6MHJsdWNnUWJz?=
 =?gb2312?B?RWtVem9lektvSWxhZzFWZ0JTNDZRSm9PMS9RYkxKcHE0cm1maXBadGZDSXo4?=
 =?gb2312?B?OVlJRDhISFR3OEpwSHZLcWtyRW9VS3QveTNTQm1sWk5DOTlFa0VQYTI1NG9a?=
 =?gb2312?B?SkVESFpnN25qQTYybkRuTWN1TmZVajlWbWpEbGprKzNiUWp2dVFzeHZFZDAv?=
 =?gb2312?B?S0kwckJmbGhpRkdEVHNwMmZybTJWRVd4YVVVQndDWUNpd1RzOWRkNHgxa0d6?=
 =?gb2312?B?cGovUElaVGZ1YjJYd0VMTEEwelQ2SnRucVhQZVpDMUMvSTYvWmUycERyMlFr?=
 =?gb2312?B?WWpYUjYvMzJhRWx4eC9aR1RDRUl6RmpzbUE1SjAxcGZPSnFuVEhDVDl0UGx3?=
 =?gb2312?B?cVd2Q3BuWDhkOU8wOHBibjJqbXdScnNPNFhIc1VheHV1bnZ6THdheTN0RDBz?=
 =?gb2312?B?U2lkOU12a242bitnaGMwMit4L1krbEN0ay81ZHQ4Qk9ZV1ZrdU42Y29QalZv?=
 =?gb2312?B?OEx2eVpWcGFLZE9TSzdZYm5zYXRoQUFFODBWWk9CdDR5ZzRMUkNjU2ZCVnJo?=
 =?gb2312?B?WElCRDJzUnNneUV0ckRqQXg5czVjVzF0YTdPTUxOUG53UUlWdU1raGp0Nk1o?=
 =?gb2312?B?NTBGNzJ4ZlpsdGhUQzBaWHUxazFzNU1zc1J3WHRhNkdLUGVYeGZDZTcraXBy?=
 =?gb2312?B?WnRISHgyQzVDODliMWJRNUxYWXV3R1VESVlEbXJrRWRpUllHdUxkS1Zka0NH?=
 =?gb2312?B?S2dXT21PRnVqdm44ajRhcVZGa0RJU2srMkw5UUJrTERVNm41TTJyMWdIN3lt?=
 =?gb2312?B?RmY3ajF6RmN0d21oZHRYMGNvRUV1REhTd3JhM0xDT3Fza2UvTCtGdWloYWRi?=
 =?gb2312?B?RnFBRTB4Rmw4clFPZ2FLeHNXNThleUlkWkNiR3RncFNZVU00a2ZhMGZ5YmFK?=
 =?gb2312?B?VE5OU2FGNnBiaDNXc1Z3RllxM3dkVjZvcE8rYXowNFJVTG5vRGhhVzFBQTdI?=
 =?gb2312?B?WFRBdndJSTUzcTZvRE9kbk9ZSVFmMXJvWWRYVjRkTjdEMDlsTVJBcTV2cldZ?=
 =?gb2312?B?RjJsNms3SmtqaDdMeTZnNmpibklucit1VEc5cjBtaVpiYmNmM1RCTkk1NVcr?=
 =?gb2312?B?b01DUGlFYnd4SnozR2c4cllGbm82TlQyZUZGMk14ZEw4ZENlRGlYVytFNEtR?=
 =?gb2312?Q?ODPZf+WqBxN+XWD3annIMYdvoeXMc5k/BzF8yB9Vhs7w=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB5158.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1417d155-526c-487d-ec2c-08ddfdb87271
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2025 11:24:39.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6643

VGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBzaW1wbGUgdmFsdWUgZm9yIHB1c2guZGVmYXVsdCBkaWZm
ZXJzIGJldHdlZW4gaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1jb25maWcgYW5kIGh0dHBz
Oi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtcHVzaCwgYW5kIHRoZSBmb3JtZXIgaXMgbWlzbGVhZGlu
ZzoKIApzaW1wbGUgLSBwdXNoIHRoZSBjdXJyZW50IGJyYW5jaCB3aXRoIHRoZSBzYW1lIG5hbWUg
b24gdGhlIHJlbW90ZS4KSWYgeW91IGFyZSB3b3JraW5nIG9uIGEgY2VudHJhbGl6ZWQgd29ya2Zs
b3cgKHB1c2hpbmcgdG8gdGhlIHNhbWUgcmVwb3NpdG9yeSB5b3UgcHVsbCBmcm9tLCB3aGljaCBp
cyB0eXBpY2FsbHkgb3JpZ2luKSwgdGhlbiB5b3UgbmVlZCB0byBjb25maWd1cmUgYW4gdXBzdHJl
YW0gYnJhbmNoIHdpdGggdGhlIHNhbWUgbmFtZS4KVGhpcyBtb2RlIGlzIHRoZSBkZWZhdWx0IHNp
bmNlIEdpdCAyLjAsIGFuZCBpcyB0aGUgc2FmZXN0IG9wdGlvbiBzdWl0ZWQgZm9yIGJlZ2lubmVy
cy4KIApDb21wYXJpbmcgd2l0aCB0aGUgZGVzY3JpcHRpb24gaW4gaHR0cHM6Ly9naXQtc2NtLmNv
bS9kb2NzL2dpdC1wdXNoOgogCldoZW4gbmVpdGhlciB0aGUgY29tbWFuZC1saW5lIG5vciB0aGUg
Y29uZmlndXJhdGlvbiBzcGVjaWZpZXMgd2hhdCB0byBwdXNoLCB0aGUgZGVmYXVsdCBiZWhhdmlv
ciBpcyB1c2VkLCB3aGljaCBjb3JyZXNwb25kcyB0byB0aGUgc2ltcGxlIHZhbHVlIGZvciBwdXNo
LmRlZmF1bHQ6IHRoZSBjdXJyZW50IGJyYW5jaCBpcyBwdXNoZWQgdG8gdGhlIGNvcnJlc3BvbmRp
bmcgdXBzdHJlYW0gYnJhbmNoLCBidXQgYXMgYSBzYWZldHkgbWVhc3VyZSwgdGhlIHB1c2ggaXMg
YWJvcnRlZCBpZiB0aGUgdXBzdHJlYW0gYnJhbmNoIGRvZXMgbm90IGhhdmUgdGhlIHNhbWUgbmFt
ZSBhcyB0aGUgbG9jYWwgb25lLgogCkluIHRoZSBmb3JtZXIsIHRoZSB3b3JkICJpZiIgbWFrZXMg
aXQgc291bmQgYXMgdGhvdWdoIGFuIHVwc3RyZWFtIGJyYW5jaCBpcyBvbmx5IHJlcXVpcmVkIGlu
IHNvbWUgY2FzZXMsIGJ1dCBpbiByZWFsaXR5IGl0IGlzIGFsd2F5cyByZXF1aXJlZC4=
