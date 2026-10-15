Received: from loire.is.ed.ac.uk (loire.is.ed.ac.uk [129.215.16.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90C47606D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=129.215.16.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050610; cv=fail; b=PIguhuV0X/ahwtJm108kcA0BprwTiGJdBn9DtfoeWuHDFNZ+O7/7pNyiwDVoG3gqVFhSs6YPgj8WA3r7V4+eBQc1Cn0QiVCPj27FS0ju/71BsDeWLqNA0hA7/SobkAUoZs1EOcSiKMWHydH36/odJ1keiS0yPYrVGMMFV5Ep1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050610; c=relaxed/simple;
	bh=UWpeBhgudcwURbtWl7Km+2ha9sjfT0w3hFRzy6nj9vM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NBMUqErEfJnttpekcXIYCnViAodrbNfzt7won+BwFY6jx/E4F7dGn4Gw63aRPrVK5Q2oDKgOEqUiWHI+s88oPyK28zqgPV8nywF1+vOy0HuDRQ1dc6kfSP4Xgl6A1VX7r0W9TPxRrTgjFXNAO4UxsfA/wXUOEGSR4yhboGIg3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ed.ac.uk; spf=pass smtp.mailfrom=ed.ac.uk; dkim=pass (2048-bit key) header.d=ed.ac.uk header.i=@ed.ac.uk header.b=Krvxn6n9; dkim=pass (2048-bit key) header.d=ed.ac.uk header.i=@ed.ac.uk header.b=sCzkaBIg; arc=fail smtp.client-ip=129.215.16.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ed.ac.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ed.ac.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ed.ac.uk header.i=@ed.ac.uk header.b="Krvxn6n9";
	dkim=pass (2048-bit key) header.d=ed.ac.uk header.i=@ed.ac.uk header.b="sCzkaBIg"
Received: from exseed.ed.ac.uk (hbdat4.is.ed.ac.uk [129.215.235.40])
	by loire.is.ed.ac.uk (8.15.2/8.15.2) with ESMTPS id 69F7H7gU2942437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:17:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ed.ac.uk; s=relay2;
	t=1792048636; bh=UWpeBhgudcwURbtWl7Km+2ha9sjfT0w3hFRzy6nj9vM=;
	h=From:To:Subject:Date:From;
	b=Krvxn6n9YWQ4rJUf8TXiwCIi+xX/8u9yZQufdG3BPLquo84Qp1UUGm5xu4S88OqYf
	 VRI/4UlHPAdjYt3ff7dU2+nw2Jz8hxoTTaxIh2aJBYy6HJ32rUoXExjUnCftmW/j3q
	 66MpdjreXvXOeSVrYju+8G/UiST0ZpD9mUYHNLNbV1WRUj0hbKi9EykvILHsmeyDgO
	 1SYtFOQ4FgMaDss0ZiWEXse+Si7kL4QxqshOUBabdyMBZa2DxkOFGqgoSPjAk5Sc3c
	 4WJi9cBCQ31ca8sGMY+KgNtLlBWvtZy+pb1MTii17KJo8NjHzpw2SIG0Ph8zJI8d2v
	 1kO11STM4cJsA==
Received: from hbdat4.is.ed.ac.uk (129.215.235.40) by hbdat4.is.ed.ac.uk
 (129.215.235.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:17:12 +0100
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.90) by
 hbdat4.is.ed.ac.uk (129.215.235.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:17:12 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6PGjuIxL0wbwgDcvrzTlByLr0l3gP2YW6dXadEQpS9YgG2sJiW1SME7tjPLaZfe+s2c9eKjjUnHZHyXIDpeq/nJIFAZzL+jYeTLZMP3qG6AFVzVVAGzrnQWMp8QaP1Exb1Rfjt3gXCzOQ/TnsryIuSiUWLelrNYZqZ68TODmcNBDdWnCttLHxKT4aaNccDKwFfr1xbIndzWTIws6uGo9VFINxwdckVYmNIJT7pLzWTnc+05eV/zRitlCvb1iPaIY1Z1jom8RSagagAdyJxjlujOcoyL/DzrEQrZWLqunmnBQnAM3xSPQwZrj47eKTT3pp5RrtlCyJuo/AwRDHH33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWpeBhgudcwURbtWl7Km+2ha9sjfT0w3hFRzy6nj9vM=;
 b=F83gjKOGzFgjvKXigksahzwjI46zerg1hf+mfrGjs985A5ch3s5UXT9NH2E58wfWdgyS9J14KPpyjL5P05MlOeKhnsJTfeAd0rv9h+dlRPyDFrFIyt0zdXHlXxyLGmnL4rAqLHQQot5M2RHrZM+EGZmyNh2z5jRFI6FrhNg6xkvlRHfPbJZPqbdxH70uesUbgBi4pAORHL5J4vV4LLZV4/agfWD2EbEQtFr1uLPgBdBsv7LCZrRvYEk90sFEMX6EQxLgH4tQ8f+/xyZwz3QAmN8Qt6EzthsSGlkmh5mFS078odYHHV2/RYlDfnDazuGrv4vJCS5I4m0egyeHaKb2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ed.ac.uk; dmarc=pass action=none header.from=ed.ac.uk;
 dkim=pass header.d=ed.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ed.ac.uk; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWpeBhgudcwURbtWl7Km+2ha9sjfT0w3hFRzy6nj9vM=;
 b=sCzkaBIg++/37KT0wGOPk4C0yhEtp6UKeE8GY09l57m3Ke+RDk2bZ2wWZXplPHfpEgXTzZG9gkgskXOep2y+l2NMyRtfaTPcgUc0BFnQvpV9Hju1jCt2Osy4apZtwSLxczfOUWRzRwVl9OiP6Azuxa/bvE9n6D5JhY3eXObkUaUjkFIdPvwTg7UrG7NUGygNVY3ueyLICSSQW7EFT5JDXPw1b+PUSwX1JYq5Pio8xzoIcuhgkUqaWzqS1KAWPzdeUHpNT1YFmFUuUZUTs/Cud5KMZteGwg6sQhBSYDBxNWKsYfMDAAd31DqcyLQFmDxL3bN+LYmB6U0Jc0b1r3Q63Q==
Received: from VI0PR05MB12991.eurprd05.prod.outlook.com
 (2603:10a6:800:30d::24) by GV2PR05MB976980.eurprd05.prod.outlook.com
 (2603:10a6:150:38d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:17:11 +0000
Received: from VI0PR05MB12991.eurprd05.prod.outlook.com
 ([fe80::7671:d4e9:39cb:880]) by VI0PR05MB12991.eurprd05.prod.outlook.com
 ([fe80::7671:d4e9:39cb:880%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 07:17:03 +0000
From: John Wilson <jwilso3@ed.ac.uk>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git help user-manual looks for incorrect filename
Thread-Topic: git help user-manual looks for incorrect filename
Thread-Index: Ad1WOgADR9NtCKftRCymJ2vja6mnog==
Date: Thu, 15 Oct 2026 07:17:03 +0000
Message-ID: <VI0PR05MB12991467F7BD29308AE8D5F4ED09C2@VI0PR05MB12991.eurprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ed.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR05MB12991:EE_|GV2PR05MB976980:EE_
x-ms-office365-filtering-correlation-id: b8759fa6-53ec-4327-847d-08df2a8c4fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|23010399003|786006|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003;
x-microsoft-antispam-message-info: vENO2Etfwd+taoLM5K26c/sLKjcSUJgWOhrxBgruDi6jof8DJNVQMNfZprYQ36jLSfNSrO4M2fEs+XMhDPfYtGKeJZ6JyuaW/D+SSfiKn0Wkkt0c3j3lL2vBzAJy0ELn+00/6o/RQuh5CFGrhYuxRVCWjDcHoKcfwsQfmu79qzff6RWjcgSkCsZ9Hog8ltDhllfUmbQ+TjFId9jSe1hpe2TKzNtFvaAXaXZaPxoL8GFAKlw06buutmSsixyy1+kzfu3BW4BLbgHaTHtJdjDCnXphVHYmu+Ysh2zBffkqRJ24evWTR00MW4N0fU7BwiDEO36+QA6QFHWYF0jRwgs0wtn4z91fC2cSJ/JtPUIOqpZYWFmhdEcsOUCJVtzs/CvTSiNgaiqhiNn3OFWRoQykOU0jFy1R5HQbToJ1lvkjraY3EMVo7b5jWEzmWXFDkCaBhqQZtOZI4zCjt7LYH8ToOKhnl+tsmdMq0crPXoDIzoREGbHNwg4EzAW6UQ9RuvT/JwbUEClQ7AWDImmQWhUplz2BULhiZNoMLGjO7sioTK72UHw+NIrYnY1w7u1kyDHggEKlcKersC9nMAhQrMg0O0ACkE0lA4eH0n1Tc6pZqvitnQJ4ZCp5pr9oZHZYcmsrsf/VzJILufiQh53jgNKUiQh0sLFa+1Y1g+EDUC3T5oU8ET1RUKaIwYGj6imUDqMmvsLHAgzhsUjlCdnBRHTp2NvuSu0Mxn/iyFshIwqAPBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR05MB12991.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(786006)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjVESG5XWHBrMTA5MDA5NHhESlh4VDZFaERqUnBkRWU4SHRLUm51d0xIOUZv?=
 =?utf-8?B?ZnRFNlNyKzhyL2VOOWFoeG5NUHViT0RxcUhESDZFMEVsN3g1VDlUSTFvT21m?=
 =?utf-8?B?ZGVUSjFTUmpySkRxUEltS3BVSnFHVGdLdjVWVVBLZ2R4WmRRMjhEK1IwYjB6?=
 =?utf-8?B?a0tuQjdnRlNwSHgrOXA0RUw2M1UzWXBjQ05pcktKSWJ3ekttRitNbzQzS3BE?=
 =?utf-8?B?YlVQU1BIeE1BczFRSFhRWTlBNFdhL3M4dWdTclUraFFReWp6QmFYSG9MUXgr?=
 =?utf-8?B?Smt5TFFvWFlWakVlT0w2NFBnSUJKZXJnaVNVMDBnSGpFVzRKZUVFMi83YkVK?=
 =?utf-8?B?Y0xXS3lmeDRIeWVCNERWTXV5emJNTDNYVWxYNlRNQnZMVGpSQmFKSDZHZU5n?=
 =?utf-8?B?L0Y5U2EwTU85dGc0bklSeWMzVUJlOTNTcndFeDFKU1ZueVphc0M2bmxxcUZZ?=
 =?utf-8?B?ZHZITWcxOG92VHdDUm5BQkExTFFHbWMzSXdzQ01aUURXSE1CZlk0VkhwOUww?=
 =?utf-8?B?V1JJSFNpOHVpaEZmUjl5L0E4SEtEQWx3WEQ2cjhnVmZld2VORXA3bUhGeVdr?=
 =?utf-8?B?NzdKblB5bGRqZE4wQmRCOVdKRHNYNlFzUlgwK0xEcUM2MUVpMXlVallLVFRD?=
 =?utf-8?B?ajZFaHIzK2dsdjdxTkZWTTNrenhHdjhuMTBBdHBXRkg0QkMyN1hsSldXOHRI?=
 =?utf-8?B?bDZpUnpab2hWUzU2anZZL045UFZZWm1hbFdKdnZwVDNSa3lXN2xUZ3EyeVJB?=
 =?utf-8?B?MGZiaTdnanJ3emRUQXFBYThKNmpBRXF3RGhLZzM2cE9GY1ovWEIvS05QYkh1?=
 =?utf-8?B?N1dBblFmcWFzbTU5WDF6S0RnTmNCMDJ2bkFRMHZhTzRqVFg0YmxLaXpVOUZR?=
 =?utf-8?B?T0tQT3B3N081ejlDUkliRGVSZGhxM2t0V05UcVJUOGx0RE1TczFjVk83cTV0?=
 =?utf-8?B?WmtJVkl2QlJiV0J6eG9ueEwxRVpLN1JsU3dDRHgxRG9jeXBncjJrbWJ6dUMx?=
 =?utf-8?B?bUlCYmtiZE9TbnliSmpSSTFUSlVWUEFSTDZ1aDdvTDcvdEhlOGZ4TXZjWWMz?=
 =?utf-8?B?dkRIVTMycVhFK3lKNzZRRVRtZjdpNS9iZGxNRXlOYXdTZEJoZ0FSOW52bWNa?=
 =?utf-8?B?K1lVc3NTS05PMWpiK29uSTFnRmNCYUszS2ZpRUZnWm9FeFdGalhnL1R0N25H?=
 =?utf-8?B?alljT2VCaHJmNS81Q2JsdUJZT0ZYODdnQlBWTmt3Mlkrc1RtV1hvMFZOSzB2?=
 =?utf-8?B?MjlNaGF0UEtSQnZlbHE0RWZFc0pkelNDQXJ3TVBrd21ET1lscjQ5NEd2a0JR?=
 =?utf-8?B?MjN4NmErS3BjNjlhMVIxZG1oNm5paFBIcnljZkhmelM4SVp0QzdyZ2QrT0Vu?=
 =?utf-8?B?YjdkaGNicWRzNFVNTDNxMDRhdXBVekszTFdwUXdETnNsWGlZNjg4cmtTTTl6?=
 =?utf-8?B?TVc2amV6Zjh0ZEJENTVBLzNVNWpSMnUxeXZEck1VRlBpZFpmMzIySE9ENWlG?=
 =?utf-8?B?cUVsRGJDMTBRb3dydzBnb2NJeXJrS1hQNk5Wd1J0UG5pbXpJQW9pV3lYUlds?=
 =?utf-8?B?VmJVWGs1L09jQ1hhdHU3eitiajZHdWVVWnN3V1B3WTgzVFZPV2FFVStuYWhw?=
 =?utf-8?B?K3dwYjlqeWo3NjBnQm1XejU5L2NuSkdzZUtqU0pSOFhUYlU0dVRIUkEzOGND?=
 =?utf-8?B?V3k5VVBhZ2N1TFZLMzhoblRxRCtXeDNWL1lVamFZWXh5ZFV5U3FnSlh1Uk5Z?=
 =?utf-8?B?YmsvY3pIKzB0TFdyeDNIUTA3UGl6Tkg1S283SmEwZURESmZwZndHVGFpaE84?=
 =?utf-8?B?RXFpc1RSczRtT3dGTEo0ajZvWENiM3hYdG41ejcrRTVwZnNJam1INWdlb21L?=
 =?utf-8?B?QllkK1d2Q1lPamJjcEsxckdoT3ExQ2xURXZLbUVtdXQrUEdaQnlXRFlRZ1V4?=
 =?utf-8?B?MlNBWjZSZDA1MHlPd285Z1lQbWFmbmN1eTRITU0zbmVVRkdreE84NG9oWFMx?=
 =?utf-8?B?TEsxeEtCZlIyTXdhdUdyc1NkcjY4cmdSc1d4YXNsSTdrT200V3FadXcrMHdR?=
 =?utf-8?B?ZEl0RjBpNENkN1hVTnlLUkFWei9Mb3NKWjVpajFqMmRyWXN1bGJuSUZDalRV?=
 =?utf-8?B?SEJpRjVYYUJOc3hwc3cwN3RPUloyVVhQZ2piVkZ4UVExVFdUR3FlVXUvbWpn?=
 =?utf-8?B?K043WWlwc2RZeW5BSHhoTlpiSWdPVzdCcWFBNGVsS2cwMWZMdTU0WDhjM2Fv?=
 =?utf-8?B?cnUxZHkzS29XejJKZVR1Q3BRZlRNN08xTmQyWTl3R1RLcE9QMkZBZ2x1aExs?=
 =?utf-8?B?UVg2aWdZSHNDaFFoc0U5RGMzUnZjUVZjZVpHQ0ZnV3o0Z2pTeUFVM2phRjYz?=
 =?utf-8?Q?Xk9UD1Ww9OO+U3Yg6I14A8M2IaWW+dL90x2mI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kv13zX+oNRUXB1LWa6TJMjjgR9Wj8LXAyFEaDOgc1BYSdjaJxKPGmPsFDBjejeTEDIeYbqjVefv8Y737GcCwmILUBPKeyRXGj8AAbLd32h8er60EbieowDmSRhvEzresYl5k94sefkZf1/6S14rpH/xEpQ8GIyo4Bw0MvV6tIPPtPdjHd+5Y31MW/4b/VjX1/jyuzXPKEXaVEUR5J3giyWKDdK+uMC5orPR0W0CBYLboym2uRHkigaUUP1poAdzZHDBmLE+Qs1UeNj3DXIqnznF6Wkdatcwe21LVeyYjg23oCW1EuiFLhXi7wi4i/eTd97n+Ze3O6cNHDuHGtkN+tQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR05MB12991.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8759fa6-53ec-4327-847d-08df2a8c4fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 07:17:03.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e9f06b0-1669-4589-8789-10a06934dc61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFk8Cur2o1USGYblEgIwdT9HK+G4qTUqgW058O9Y/MZaZ+alX1OqV4zR2XBJRXoOugced1iyfEAm8pl+7zDXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR05MB976980
X-OriginatorOrg: ed.ac.uk
X-Edinburgh-Scanned: at loire.is.ed.ac.uk

SGksDQoNCkkgd291bGQgbGlrZSB0byByYWlzZSB0aGlzIGlzc3VlLCBhcyBzdWdnZXN0ZWQgd2hl
biBJIGVycm9uZW91c2x5IHBvc3RlZCBvbiB0aGUgZ2l0LWZvci13aW5kb3dzIHJlcG8gKGh0dHBz
Oi8vZ2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0L2lzc3Vlcy82NDY2KQ0KDQojIyBJc3N1
ZQ0KDQpPbiBHaXQgZm9yIFdpbmRvd3MgZ2l0IGhlbHAgdXNlci1tYW51YWwgbG9va3MgZm9yIHRo
ZSB3cm9uZyBmaWxlLg0KR2l0IGxvb2tzIGZvciBnaXR1c2VyLW1hbnVhbC5odG1sLCBpbnN0ZWFk
IG9mIHVzZXItbWFudWFsLmh0bWwuDQoNClRoZSBHaXQgVXNlcidzIE1hbnVhbCBpcyBpbnN0YWxs
ZWQgYXM6DQpgQzpcUHJvZ3JhbSBGaWxlc1xHaXRcbWluZ3c2NFxzaGFyZVxkb2NcZ2l0LWRvY1x1
c2VyLW1hbnVhbC5odG1sYA0KDQpIb3dldmVyLCBnaXQgaGVscCB1c2VyLW1hbnVhbCBmYWlscyB3
aXRoOg0KYGZhdGFsOiAnQzovUHJvZ3JhbSBGaWxlcy9HaXQvbWluZ3c2NC9zaGFyZS9kb2MvZ2l0
LWRvYy9naXR1c2VyLW1hbnVhbC5odG1sJzogZG9jdW1lbnRhdGlvbiBmaWxlIG5vdCBmb3VuZC5g
DQoNCiMjIEFjdHVhbCBiZWhhdmlvdXINCg0KJCBnaXQgaGVscCB1c2VyLW1hbnVhbA0KZmF0YWw6
ICdDOi9Qcm9ncmFtIEZpbGVzL0dpdC9taW5ndzY0L3NoYXJlL2RvYy9naXQtZG9jL2dpdHVzZXIt
bWFudWFsLmh0bWwnOiBkb2N1bWVudGF0aW9uIGZpbGUgbm90IGZvdW5kLg0KDQpNYW55IHRoYW5r
cywNCg0KSm9obg0KVGhlIFVuaXZlcnNpdHkgb2YgRWRpbmJ1cmdoIGlzIGEgY2hhcml0YWJsZSBi
b2R5LCByZWdpc3RlcmVkIGluIFNjb3RsYW5kLCB3aXRoIHJlZ2lzdHJhdGlvbiBudW1iZXIgU0Mw
MDUzMzYuIElzIGUgYnVpZGhlYW5uIGNhcnRoYW5uYWlzIGEgdGjigJkgYW5uIGFuIE9pbHRoaWdo
IERow7luIMOIaWRlYW5uLCBjbMOgcmFpY2h0ZSBhbiBBbGJhLCDDoGlyZWFtaCBjbMOgcmFpZGgg
U0MwMDUzMzYuDQo=
