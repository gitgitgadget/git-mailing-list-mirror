Received: from smtp-out6.electric.net (smtp-out6.electric.net [192.162.217.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152091E1C17
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.162.217.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500013; cv=fail; b=pUYDxv7wyPNB58/7UzPIf4zSwXzClPw87GnJvRylX8gHQew2q94uiA2/bT9gx8mVbfwyT1Xl1KNGgMSz9JS89NPm8Cpp2FF7kZirpoomYuLzUVxX+CqP73Fa1xM+oDUgZqni3zPCVZ/iK/jX1SHPw04qr5OzyRIrxpLO+KjuEy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500013; c=relaxed/simple;
	bh=RoQ9hNb0POlxjzUEWKRC1vArm6uTiFICaIJ6vWmGd7o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5Za/fZC2hLl7P8sAkM58TuJIn7NuJVSCIFZqNY2n03d+Bxo2IyyoQFjyZFTlxkeC4J4QJk/VlVWPDSkJdsZvpVszuX2HGCG0PrNeWrNCnDpoWZd8pt35loPKcdkw0BCAqc/awERYh5oVIO6Vkt46BKRrYLaVDU10MAupbAc9os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alexander-dennis.com; spf=pass smtp.mailfrom=alexander-dennis.com; dkim=pass (1024-bit key) header.d=AlexanderDennisGroup.onmicrosoft.com header.i=@AlexanderDennisGroup.onmicrosoft.com header.b=hBlZsZO3; arc=fail smtp.client-ip=192.162.217.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alexander-dennis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alexander-dennis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=AlexanderDennisGroup.onmicrosoft.com header.i=@AlexanderDennisGroup.onmicrosoft.com header.b="hBlZsZO3"
Received: from 1t2nwf-0000000CfxJ-Itpp by out6d.electric.net with emc1-ok (Exim 4.98)
	(envelope-from <david.fullerton@alexander-dennis.com>)
	id 1t2nwf-0000000Ch3W-KusY;
	Mon, 21 Oct 2024 01:39:21 -0700
Received: by emcmailer; Mon, 21 Oct 2024 01:39:21 -0700
Received: from [104.47.85.48] (helo=GBR01-CWX-obe.outbound.protection.outlook.com)
	by out6d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <david.fullerton@alexander-dennis.com>)
	id 1t2nwf-0000000CfxJ-Itpp;
	Mon, 21 Oct 2024 01:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnCad8am7tXawK/GEIW26ZTCBXkVh2oodKQpNWtCN0Q7AfmJMkvsq5WhV1L+0XfOnQjFUxHUfSb74Ddvg8hwNJH1TpYdb4bAD4vRfFCgrOr0oeZDagMZ4gm1Bg4vUun4qr7lUpdyozYfFzE6vQAiH1wA3W8Cm9JZYrmrYmgia7/seKfX0ssHtJWigxHlVR4SL9abZasAc2/l5EyYHmfddHVqVwKUmBRfLOBH4yUGKsZmLVEGVKbiqPYnIzpciozSWvudLbrciZ/TJDFx0NAX10MAtechimUmu9sMcGbk2GBzJgoeY9/ES+rADCGS7fEpDUqpodlXlQSiGfXdJAzCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoQ9hNb0POlxjzUEWKRC1vArm6uTiFICaIJ6vWmGd7o=;
 b=ChFNW0c+4X+0PJCemJ2HhdlySfV17rG+NIpA/9DQc5XZkBvHPJWI5e2+UsAYnzXR9HfsV9vcht4+3TtIHpOksOxzsuRY8a3vzvr4GCnp9xSRTDoY09GFmLgSa1rK8OBCy+VQf+x01tO70eQ7sLgxvH7x3PfiGtggIMQi9VUZpThQhzlJ+9rKPqUELr00k2xZu/m+oH1b7CoNm9M1yPROFN+ZTA8O2gqSupWJDdlvOJ7hhKVf/+bdxguUV7elvxlpUwRSjDVLPNre0hskweWKcidpYlMC4XIOcDOF0cUgiGLtLRSR45stDSm7hmEF7gx8B7zz/W824DidKL40f6fUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alexander-dennis.com; dmarc=pass action=none
 header.from=alexander-dennis.com; dkim=pass header.d=alexander-dennis.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=AlexanderDennisGroup.onmicrosoft.com;
 s=selector2-AlexanderDennisGroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoQ9hNb0POlxjzUEWKRC1vArm6uTiFICaIJ6vWmGd7o=;
 b=hBlZsZO3VI2yZ6DWq8jNKMGhewv86Ji0zzi2YkuSsCl0SM/TxAjB1GtBkRkPZZSpU1eqlT/+csMKCkE4/Ca5L87cvg6C9r/wHutKlxQ7IFZG3fijupXRTPWFPiz5rIs9nu0o0ReQpynafQePW1jwc1iPsxE8E57KoNo6sA9H7Q0=
Received: from CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:110::8)
 by CW1P123MB7966.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:39:00 +0000
Received: from CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM
 ([fe80::528e:4fd9:c85a:5f26]) by CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM
 ([fe80::528e:4fd9:c85a:5f26%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:38:59 +0000
From: David Fullerton <david.fullerton@alexander-dennis.com>
To: Taylor Blau <me@ttaylorr.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Install Error - Failed to Expand Shell Folder Constant
 "commondesktop"
Thread-Topic: Git Install Error - Failed to Expand Shell Folder Constant
 "commondesktop"
Thread-Index: AdshPMlH5iXl/OXzSUC/MEBpW3MS5AAU5SCAAAQ7BIAAfMZiMA==
Date: Mon, 21 Oct 2024 08:38:59 +0000
Message-ID:
 <CWLP123MB4691AF6D050C969E8484FCEDCE432@CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM>
References:
 <CWLP123MB4691D6EC228FA467749267FCCE402@CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM>
	<ZxKw66wR3UzCuj_b@tapette.crustytoothpaste.net> <ZxLNT3GSPrUVJVF1@nand.local>
In-Reply-To: <ZxLNT3GSPrUVJVF1@nand.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alexander-dennis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP123MB4691:EE_|CW1P123MB7966:EE_
x-ms-office365-filtering-correlation-id: abd5a338-1b79-4c4b-c0bc-08dcf1abcf3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmEyU0FMTVZNZ2R5M1dCZ2xPcHMyejNibWZyODJkZUN1TkZ5T2dmUDE4eHZW?=
 =?utf-8?B?ZXpycnI3WnRZV3hkb2E1NURxa0FETm9HdnRER3lpNXlZQXZyanJSRzIrUE5E?=
 =?utf-8?B?ODRTb0V1NkpGWnpRRGVFdzg2dnhlOHZJNEJ5Slcwb2dKeXhRQ3l3MnRhb3gr?=
 =?utf-8?B?SHZLSmJVT2pMd1BrYWplUUowd3hpU1J2RVNxaUl2bDl6d3FyRTk5ZXQzNGlW?=
 =?utf-8?B?bkhLWC9BRHZWQTdUTHZLZ282cjN2Z3plTDI5dDRCVVNISGp1bFNlcCtTT3J0?=
 =?utf-8?B?SFFxRUpmcEZiWjdMYTE2MUtVUDQ3RVB4ZDI2T1kwNnZlQ01hOWlMNVdsUWRu?=
 =?utf-8?B?VmcyUDA0dU1VTDVyOWtqb3MzQnd1NzU2S1ZWNUxhSW9pbit2dEc2Y3c2SHJv?=
 =?utf-8?B?ZjF4MjBtYXoyNVhqMHNxMjlYZmdwaFN6VkkwVGEyMFRBYVNzWFFSTU1lbEIy?=
 =?utf-8?B?SGdLaW1nWUl5eXBnSUZMeHZiRkhoUHZIRmt1MXF2RXBQOG4raVJGd1BGRWlX?=
 =?utf-8?B?QVU5VThQbkM1RUx4STMvQ2ttN2ZmeU9xQjJpc25kYVR2SXNYK3lIdTlHSnJU?=
 =?utf-8?B?MWhQdTJ2UkxlYSszM2kweWxNZUxZbW1IdEpKV3hEbXlLOG0xOTZjUzZ5K1R6?=
 =?utf-8?B?TjNNeHhDK0FSa1JzRndyTTV0VXhJaC9GeU9yeHB5S0lYKzZnY2c1VHRSRkdY?=
 =?utf-8?B?OFhhRyswV09tK2p5dkJKeDNsR3FMZGFOLzFJbG1laDU0Rm5TdVNuUkZGSTNu?=
 =?utf-8?B?MjBzalhrWEFkWk1YdU5VbkkvWG4wK3JlbEFDT0NkdjJ0QzhZSXBwUGpBQk9t?=
 =?utf-8?B?QW1WNmJOZ0dGL0hjYXBRUHZlM3l6WDFlRmJqVFZESFh0M3lUaDB0ektjN1Ix?=
 =?utf-8?B?VU43dlFvZ1hYUnZYS2taM2pnMDhDaWJlaDFwakMvdk5ZdWxQc0t3QWp4d0dz?=
 =?utf-8?B?d2ZWZ1FlSUtVbDVLYWhicDB1aFluSUlDUlVUdjBOTUdqZVZGV3JTU1hoUTYx?=
 =?utf-8?B?amc3SEdYK1dSNkFHNGZEWXNGNmY2UWhzN0dUc2JqYVAvNUlDRVFYaTBxdHYv?=
 =?utf-8?B?S1g3NkRMMU5TTG1udUUxOXRJRzFJTjFNam5NU2FLdnpRZzMwMVZHTU5GK1NH?=
 =?utf-8?B?QXRRbmsvUmhCMFIrcHZNMlpqcU1OQ3ZqZjZHTFZ4VFN3cjlwWFc5TWtocC91?=
 =?utf-8?B?azhRaXdCMy9NS0JJMEM2d0MwamhQK1kvTExFejRrS3NFK256UEJFbWtpdXZP?=
 =?utf-8?B?Tk0zZS9iT1k0Q0VUNlNZb016MmExSzVYRDdIM1hxaWNNV3FKZnNOc2ZPTmRW?=
 =?utf-8?B?UmtPc3AyUk5QTDlEbGUrU2JETlZaTTA4SjIwVTlGcElJQXJZcFJqcVNaQkIx?=
 =?utf-8?B?UEgvRTJIUC9ZNHAyWkYrQWJWa2RNNUVBRU53NE1vSEszaTRyM0d6R3BJVitr?=
 =?utf-8?B?bTI3V1dUTjhEZEJhZ2dhS0JxS3ltSmh1eUtDYkxIN3ZiNFhjbEpsZzFPYnpw?=
 =?utf-8?B?LzB4Tzd0ODQxQ1I2dnFVUFV6TnBRS1hCSW5BQm9OMlU4TFZKL0NJczV1bi9p?=
 =?utf-8?B?bVVIay90S0VDUUFRMDR6U0V6Vk80cnpZK1c2MWdKcE90RlJmejBMSW1KY2xu?=
 =?utf-8?B?bmpzWTIrV3hjOUNaVUJVOG81Y0ZYRjZuYTBxTGdaWWdRWkZPazJMSzNIOU1F?=
 =?utf-8?B?UUU3dEpzVVVUNFZqTTlzWUk5RTZoc3NQRkxzTWx0M3pVSG5TOExoZFk1NXJp?=
 =?utf-8?B?QlZrTm8wb1lram5Wc3ZjRUxpa1RMZ1VWMVE1dk93Mldabks5RlZTSjZuS2Zm?=
 =?utf-8?B?azJZNEIvbjU1UjQ1c1lEdkJJU2FZNVlsTWwwZXFsWGhNdjB3OUVkYVFUWkZi?=
 =?utf-8?Q?CzxTyqCOt/2NE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWtaWmtHT25pb3lCMjJGQXNpamRwbnJoaVdSWXRxbE8yQXVRYmdVbFpUTjVt?=
 =?utf-8?B?MXlRaVYwVDJTNWJkNDV5WUc0c2EzUmFwYWVBOEh0Z0ZNKzh1QUtSdUFTSCtn?=
 =?utf-8?B?cEdXbEZ4V2p1OUhURDlLWTZKZEd0TUtvbHJaa3BIclh4QnBGR1ZXaS96VHpT?=
 =?utf-8?B?TDF0Skg1VGdnNmpUY2RNVTVRaDYwR0JEbFBlczBOY21NK1VyTUpXaklkdmd2?=
 =?utf-8?B?MDd6WXRJcGVaL0wrN3lucC9mVDNFbUNHbjJFRVN6alNPWFJ4M2xsNFRKTHRF?=
 =?utf-8?B?S2llVkRCTzc2MlZ0cllpSDZrMlNXQ0lMelNpc21DTkFOTFFqeW45bGg1Tmhr?=
 =?utf-8?B?SlQ3ZnJiY2U2cHBnZXNtZ2Fmczg3THduTkFXczZiUkJyMlZzRVlQSmp2T0VK?=
 =?utf-8?B?USt6T09OVnhGSjFYVWt4cnZIUVFsdFg3OTB6NlVkYldibGJONEhZR2x6YTdY?=
 =?utf-8?B?Zks2d0llSStBcTdreEgvdXFMMmhIdWZUbEcrTjhsdlJadHM4VG5qQVdINjhP?=
 =?utf-8?B?aVdCdFVuK3VEY3A4WDl3K0pwaXZRWjNZazhLVUdsQW9xSVNKN2JyN0EyM1Rk?=
 =?utf-8?B?MU93d2JsdittRVQ3NXBtWXpyVzJiUzVyTjhjRHVJam1oc2hyN3pOZHdsUXE2?=
 =?utf-8?B?bFc2c2xlSno1KzExSjRiWkVJRUFXTTFXeEFMbWlTNk1xNHN6QWw1cGJKcW1V?=
 =?utf-8?B?TnRnVEhaTmJaTnZqdVN5M1d1ZTFtNHhEZmYzNXEyZ3BnaTg3SWNSd3JjMWJa?=
 =?utf-8?B?TmYraU5RdHhIZEJTTkVSSEZSK1BPTmd3R3psQklqRTVxY1ZHT25FTGZvQ0JO?=
 =?utf-8?B?UzlDMjg0SUw1RHNDZTB6RW4vN3piY05GMjgvRE5WQ0tvbTVOMVhTSENvU3pr?=
 =?utf-8?B?OFhES3M3Q21NSXB2K0MwRVlabmxXSFEyV2J2WUlHRFQ2VGFlRThFNnpFMW1p?=
 =?utf-8?B?Z3VtVVVPWElobkMycFlWamNNWFU1M2c5bDFaV3dCelhZV3Bqay8wNHhzZlZz?=
 =?utf-8?B?WW1jdzdFVGlINzVONVdKclF1WVM1bjZJZTJNQXlFWDRMMkFZeEVwaXB6Yzl1?=
 =?utf-8?B?Vm5IUE0xVkN6Zm9kNHQ3ZjJJblZ6aU5ZUkM3RCs0SldmVENrQXJqeU9reVJt?=
 =?utf-8?B?QnplN3k1bFNxcnNmSjJ1eHlUMEN6WWs5V0VyaGhhTDFmM0dPek5WV1orRG95?=
 =?utf-8?B?Z3hTWEJjR2UwbThzSU4zeXdLZjBYOEtxL2JnamRqQ2Z5UU9sOURpU3hPcE50?=
 =?utf-8?B?dnFTcFdiSkFpTFdRRCttazl1MEZUNXdhZjJOS0NoZERtWGYrajloNTdhWDd5?=
 =?utf-8?B?UXAwbTFwMlBNVXYrVExCOHdKbkJuUzZtV3JTTlR1Z3VnaVdHRUc0N0syUldX?=
 =?utf-8?B?SEw4YmFlanJ3Q3VDb25GaXhDd1FUVEtjS244bkJBRWZ0QlEzeUpTWVIzSkp3?=
 =?utf-8?B?QW1uMG96RDBRWVFYUWVaelRYaGZnRHBZNFlucWRBeTNScXpOSzZ4ZW13dXV3?=
 =?utf-8?B?MFE4cmJOVDdsUWFjTmNRdFZ3ZVBWbHd4ejN6YkI2ME1zTnprY3RFUjlaZ3Jw?=
 =?utf-8?B?dkErSnZyc1YyZUZrZUFvcG10aGhBNUk0SnRHcUtKNndVYnlPaGlPbjFzWndD?=
 =?utf-8?B?Rk5hVUhlV2l0S3FNRExIaXE5eXN5ZUhYN3kvaVduOVp5TkF5ekt1VWFVSVlF?=
 =?utf-8?B?Z29MbnpUZDF3Y0tzWVRRMzFZSlZWWVhneE9VamV6MG15WjQvTXlSY2VEeHhB?=
 =?utf-8?B?S2R3amFhblBPeVRXL2k1VHBhTDk0bkxTY1dyZnNYUzVyUVJOZmsvL1orblJQ?=
 =?utf-8?B?NzVjZEZKV1hSN2kwY3J2YjRFcVc4NkVSZGFuMVRUUjdlVGZuZTljeHBxYnNT?=
 =?utf-8?B?WWVUOWwwRENMcTI0R20wRTNoZ0dHRTN4ZnFxVTBhOWtFbGUyZHNqK1ovNE1M?=
 =?utf-8?B?WEZNU0RobEJVQTdRSWNqcnFIbmczeFNKOEFxbDgyQm56djdvRW1HYWZiYVFC?=
 =?utf-8?B?eTJWUHZPbUZlTXc3VFV6QTNpdmgvUk5xNWhsYS9hQ0ZRbDZRbmllYVJnQ3Fy?=
 =?utf-8?B?clgvYlN0ZEN5SUlXcGtaYWtTWGNEVEczQkN4TEVuTnpCWERwbnlkUVZPS0Rw?=
 =?utf-8?B?VVdzL0REaEw4N3VOVThZNHQrZGFEVkpxU0hBMWFYWEEzUjRwUGNsYXlFVjFL?=
 =?utf-8?Q?pg0c2xgfGajePyUL2N4vWYA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alexander-dennis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: abd5a338-1b79-4c4b-c0bc-08dcf1abcf3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 08:38:59.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f13db93-7541-4653-851e-e360d5774495
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/UUdm7LDMuxnL0gIEvHMXYdzXHW12Q2vE96pb16AvJWk4Xd1x5KXRH3FKyaH3snYURcj59O1y+LKn2q9K3xu0iOC8AfLqz3zO7UysiwUxsbnN0tzS/NeHY8C48lPBhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7966
X-Outbound-IP: 104.47.85.48
X-Env-From: david.fullerton@alexander-dennis.com
X-Proto: esmtps
X-Revdns: mail-cwxgbr01lp2048.outbound.protection.outlook.com
X-HELO: GBR01-CWX-obe.outbound.protection.outlook.com
X-TLS: TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-VIPRE-Scanners:virus_bd;virus_clamav;
X-PolicySMART: 25078178
X-PolicySMART: 25078178
X-PolicySMART: 25078178

VGhhbmsgeW91IEJyaWFuLA0KDQpUaGVyZSB3YXMgYW4gaXNzdWUgb24gdGhlIEdpdEh1YiwgdGhl
IHB1YmxpYyBkZXNrdG9wIGZvbGRlciB3YXMgYSBibGFuayBmaWxlIG9uIG15IFBDLiBUaGlzIG11
c3QgYmUgZHVlIHRvIGEgY29tcGFueSBzZWN1cml0eSBwb2xpY3kuDQoNCk9kZGx5LCB0aGlzIHNv
bHV0aW9uIGRpZCBub3QgYXBwZWFyIHdoZW4gc2VhcmNoaW5nIGdvb2dsZSBzbyBJIGNvdWxkbuKA
mXQgaGF2ZSBmb3VuZCBpdCB3aXRob3V0IHlvdS4NCg0KaHR0cHM6Ly9naXRodWIuY29tL2dpdC1m
b3Itd2luZG93cy9naXQvaXNzdWVzLzQ0MTYNCg0KUmVnYXJkcywNCkRhdmlkLg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVGF5bG9yIEJsYXUgPG1lQHR0YXlsb3JyLmNvbT4N
ClNlbnQ6IDE4IE9jdG9iZXIgMjAyNCAyMjowNA0KVG86IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRh
bHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+OyBEYXZpZCBGdWxsZXJ0b24gPGRhdmlkLmZ1bGxlcnRv
bkBhbGV4YW5kZXItZGVubmlzLmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJl
OiBHaXQgSW5zdGFsbCBFcnJvciAtIEZhaWxlZCB0byBFeHBhbmQgU2hlbGwgRm9sZGVyIENvbnN0
YW50ICJjb21tb25kZXNrdG9wIg0KDQpDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJv
bSBvdXRzaWRlIG9mIEFsZXhhbmRlciBEZW5uaXMuIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXNlIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4gSWYgaW4gZG91YnQsIHBsZWFzZSB1c2UgdGhlICJQaGlzaCBBbGVy
dCIgYnV0dG9uIHRvIHJlcG9ydCB0aGlzIG1haWwgT24gRnJpLCBPY3QgMTgsIDIwMjQgYXQgMDc6
MDM6MDdQTSArMDAwMCwgYnJpYW4gbS4gY2FybHNvbiB3cm90ZToNCj4gSXQgc291bmRzIGxpa2Us
IGZyb20gdGhlIG1lc3NhZ2UsIHRoYXQgeW91IGFyZSBwcm9iYWJseSB0cnlpbmcgdG8NCj4gaW5z
dGFsbCBHaXQgZm9yIFdpbmRvd3MsIHdoaWNoIGlzIHRoZSBtb3N0IGNvbW1vbiBkaXN0cmlidXRp
b24gZm9yDQo+IFdpbmRvd3MsIGFuZCBzbyBJJ2QgcmVjb21tZW5kIHRoYXQgeW91IHJlcG9ydCBp
dCB0byB0aGVpciBpc3N1ZQ0KPiB0cmFja2VyIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9y
LXdpbmRvd3MvZ2l0L2lzc3VlcywgYWZ0ZXIgZmlyc3QNCj4gY2hlY2tpbmcgdG8gc2VlIGlmIGl0
J3MgYWxyZWFkeSBiZWVuIHJlcG9ydGVkLiAgVGhleSdsbCBiZSBhYmxlIHRvDQo+IGJldHRlciBh
c3Npc3QgeW91IHdpdGggdGhlaXIgc3BlY2lmaWMgaW5zdGFsbGVyIGFuZCBhbnkgaXNzdWVzIHlv
dSBtYXkgaGF2ZSB3aXRoIGl0Lg0KDQpUaGFua3MsIGFzIGFsd2F5cywgZm9yIGdpdmluZyBvdXIg
dXNlcnMgc29tZSBoZWxwZnVsIHBvaW50ZXJzLg0KDQoNClRoYW5rcywNClRheWxvcg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KQWxleGFuZGVyIERlbm5pcyBMaW1pdGVkIChB
REwpIGlzIGEgbGltaXRlZCBjb21wYW55IChudW1iZXIgU0MyNjgwMTYpIHJlZ2lzdGVyZWQgaW4g
U2NvdGxhbmQgd2hvc2UgcmVnaXN0ZXJlZCBvZmZpY2UgaXMgYXQgOSBDZW50cmFsIEJvdWxldmFy
ZCwgTGFyYmVydCwgRks1IDRSVSwgVW5pdGVkIEtpbmdkb20uIEFETCBpcyBwYXJ0IG9mIE5GSSBH
cm91cCAoaHR0cHM6Ly93d3cubmZpZ3JvdXAuY29tLyk8aHR0cHM6Ly93d3cubmZpZ3JvdXAuY29t
Lz4uDQoNClRoaXMgZW1haWwsIGluY2x1ZGluZyBpdHMgY29udGVudHMgYW5kIGF0dGFjaG1lbnRz
LCBpcyBjb25maWRlbnRpYWwuIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVh
c2UgaW1tZWRpYXRlbHkgZGVsZXRlIGl0IGFuZCBub3RpZnkgdGhlIHNlbmRlci4NCg0KQURMIGRv
ZXMgbm90IHJlcHJlc2VudCBvciB3YXJyYW50IHRoYXQgZW1haWxzIHNlbnQgYnkgaXQgYXJlIHNl
Y3VyZSBvciBmcmVlIGZyb20gdmlydXNlcyBhbmQgb3RoZXIgaGFybWZ1bCBjb2RlLCBhbmQgZG9l
cyBub3QgYWNjZXB0IHJlc3BvbnNpYmlsaXR5IGZvciBhbnkgbG9zcyBvciBkYW1hZ2Ugd2hpY2gg
bWF5IHJlc3VsdCBmcm9tIHJlY2VpdmluZywgYWNjZXNzaW5nLCBvciBvdGhlcndpc2UgbWFraW5n
IHVzZSBvZiBzdWNoIGVtYWlscy4gWW91IGFyZSBzdHJvbmdseSBhZHZpc2VkIHRvIHZlcmlmeSB0
aGUgYXV0aGVudGljaXR5IG9mIG91ciBiYW5rIGFjY291bnQgZGV0YWlscyBieSBzcGVha2luZyB0
byB5b3VyIHVzdWFsIEFETCBjb250YWN0IHdoZW5ldmVyIHlvdSByZWNlaXZlIHRoZW0gYnkgZW1h
aWwuIFdlIGRvIG5vdCBhY2NlcHQgbGlhYmlsaXR5IGZvciB0aGUgbG9zcyBvZiBhbnkgbW9uZXkg
c2VudCB0byBhIGJhbmsgYWNjb3VudCB3aGljaCBpcyBub3QgYW4gYXV0aGVudGljIEFETCBiYW5r
IGFjY291bnQuIElmIHlvdSB0aGluayB0aGF0IGFuIGVtYWlsIHB1cnBvcnRlZGx5IHNlbnQgYnkg
QURMIGlzIHN1c3BpY2lvdXMsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYnkgdGVsZXBob25l
IHRvIHZlcmlmeSBpZiB0aGUgZW1haWwgaXMgbGVnaXRpbWF0ZSBiZWZvcmUgY2xpY2tpbmcgb24g
YW55IGxpbmtzIG9yIG9wZW5pbmcgZmlsZXMuDQoNCkFETOKAmXMgdGVybXMgYW5kIGNvbmRpdGlv
bnMgb2YgcHVyY2hhc2UgYW5kIHRlcm1zIGFuZCBjb25kaXRpb25zIG9mIHNhbGUgKHRvZ2V0aGVy
IHRoZSDigJxUZXJtc+KAnSkgYXBwbHkgdG8gYW55IG9yZGVycyBzdWJtaXR0ZWQgYnksIG9yIHRv
LCBBREwgZm9yIHRoZSBwdXJjaGFzZSBvciBzYWxlIG9mIGdvb2RzIGFuZC9vciBzZXJ2aWNlcy4g
RWFjaCB0aW1lIHdlIGlzc3VlIG9yIHJlY2VpdmUgYW4gb3JkZXIsIHlvdSBhZ3JlZSB0byBiZSBi
b3VuZCBieSB0aGUgcmVsZXZhbnQgVGVybXMuIFRoZSBUZXJtcyBhcHBseSB0byB0aGUgZXhjbHVz
aW9uIG9mIGFsbCBvdGhlciB0ZXJtcyAoaW5jbHVkaW5nIGFueSB0ZXJtcyB0aGF0IHlvdSBwcm9w
b3NlIHRvIGFwcGx5KSB1bmxlc3Mgb3RoZXJ3aXNlIGFncmVlZCBieSB1cyBpbiB3cml0aW5nLiBF
YWNoIG9yZGVyIHdpbGwgYWN0IGFzIGEgc2VwYXJhdGUgY29udHJhY3QgYW5kIHdpbGwgYWx3YXlz
IGluY29ycG9yYXRlIHRoZSBUZXJtcyB3aGljaCB3aWxsIHRha2UgcHJlY2VkZW5jZS4gVGhlIGN1
cnJlbnQgdmVyc2lvbnMgb2Ygb3VyIFRlcm1zIGNhbiBiZSBmb3VuZCBhdDogaHR0cHM6Ly93d3cu
YWxleGFuZGVyLWRlbm5pcy5jb20vdGVybXMtY29uZGl0aW9ucy8uDQoNCkFETCBwcm9jZXNzZXMg
eW91ciBwZXJzb25hbCBkYXRhIGluIGxpbmUgd2l0aCBpdHMgcHJpdmFjeSBub3RpY2UsIHdoaWNo
IGlzIGF2YWlsYWJsZSBhdCBodHRwczovL3d3dy5hbGV4YW5kZXItZGVubmlzLmNvbS9wcml2YWN5
LW5vdGljZS48aHR0cHM6Ly93d3cuYWxleGFuZGVyLWRlbm5pcy5jb20vcHJpdmFjeS1ub3RpY2U+
DQoNClBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMg
ZW1haWwuDQo=
