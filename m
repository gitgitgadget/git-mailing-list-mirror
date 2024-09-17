Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011076.outbound.protection.outlook.com [52.103.32.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39171B85EE
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559566; cv=fail; b=bDGVqRGFZhO3RKAYvFtjhZ/IsAR5fih74Lmux39nfxhm2VrKM1vjePUtTi3nANyCzBRtutvkrqgjQlcoZDinDUMFnwBuk5aUAxPamBHsJUA9gQ4aQvgoD+KBc14+xGN8aCekYuXbCp3qNdPnoj+vH1grOmbPq6GQIrPiAIC9xnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559566; c=relaxed/simple;
	bh=qB5xUZjFtWqW6qZ2bTZcq7a/6O9tnay7St6Et9F6eBM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oep73gsFlM1Oox/5wvm+iYGyNdYxaBsVSgXf/4TVQteo2NEqadEMmZ2jA7JVsahCyY9O4QFLEj+ymp/vEAv2un4oAIZzWw1zWau+K813OPdizjtDzMblhi3XyROkqTUDdxYnvZpEdE9Psk8MBBydbKrMj8a136DdfvmwHQYkAgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=EHXikUfm; arc=fail smtp.client-ip=52.103.32.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="EHXikUfm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS41wHZ3g46eFznOC9kGaVT1NhYrTWKiF2ltGjrkvpkOSZFXyzFolx3KFFR7RlMm7Nn/y2uTETr6IwDkakZgDf3rp7XxUMukrLzMLbqrmYGuURvHuyCfWRuqdCwNvKlI+MpMIMUsjCptaKLaUTOwO0tFYy3BQWJTo8Lc0ntPCyS9ob3i7sWYuzjjgjd4XZBIt8vzyEpiBJuP0oyOF8NBPKWGxSeK54Y6Osd4EVerodqBiFiyFhkFHKgl4TF4KnU7BrQs3wsEGDs1wJHtSJ/XhZIwGHtg6sOOz55wMsmWxR2zkMf+EH63M5VZpK9kGdKZTFzDJSrC9gXXqz+FsOT0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB5xUZjFtWqW6qZ2bTZcq7a/6O9tnay7St6Et9F6eBM=;
 b=HfPdcCcBNbudtyra9PeK0vTIg7G5S7U1OtjyarIE1ckL6wTdI70xZOvzmNgUZB7Md//UvKBoWESGBnfl206RzqEnAslCgXshGyo7PafH0eavHxTKtepLmSFydaF5vN0Xl7QlGhkXse3r1R2J6np4lvUkddh4CnChrGwWvXe40mIVXHwdYPICcY440n9PuBCe4fUC67ut0ZyhNn+/T9CBqPguGS+nlcvLPv0tPRWM0+xY7jo9WrlT0etMXikIPLIRaKSHd9E33eqrxBilk1jGQy5wzmQylQ6Ogmgufj5fT6qpBJJ11huhLv8zGGVafTnWIrIfU2w2779brzILGXFKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB5xUZjFtWqW6qZ2bTZcq7a/6O9tnay7St6Et9F6eBM=;
 b=EHXikUfm2bxbYsV5L0CQRwUG785cvx0XOWbhLVJpqrJ44Ov6T7Dvoy4JII3xIdH5/Ox7fHK5Vh61+GHjmX2U91zvUSfc+/z8B1CCEO2vlKTiFjGh2IUP6Opz5uczRVxCLmm6sKgF6gOXOHu4Ne3YWrklN515wDadtw7unJeOOh6csEUS9cwZ4Zb/BayfzxGcxci1T3x2jSJPUJhtiqbcrIhEHFqwksx0iSZdfAkDzx4xqpX4wVk0qWoNFxNU186L/zJV4CFuJnZoEFmZfMlNMXw/vcaDbw/b1s7uITpEN/VSdKQwIH0Ec85VCe423AczO4pdpB/TkRgDBo9z71RpLA==
Received: from PA4PR02MB7040.eurprd02.prod.outlook.com (2603:10a6:102:106::24)
 by GV2PR02MB8871.eurprd02.prod.outlook.com (2603:10a6:150:b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 07:52:41 +0000
Received: from PA4PR02MB7040.eurprd02.prod.outlook.com
 ([fe80::d593:39ef:6783:7a10]) by PA4PR02MB7040.eurprd02.prod.outlook.com
 ([fe80::d593:39ef:6783:7a10%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 07:52:41 +0000
From: "Mr. Manuel" <mr-manuel@outlook.it>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Push to GitHub HTTP repo fails (>v2.45.2)
Thread-Topic: Push to GitHub HTTP repo fails (>v2.45.2)
Thread-Index: AdsI1dEvlCmFSLKcSLu5aHL2whWzoQ==
Date: Tue, 17 Sep 2024 07:52:41 +0000
Message-ID:
 <PA4PR02MB7040A36E17B197AB8DD7BBFC8C612@PA4PR02MB7040.eurprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR02MB7040:EE_|GV2PR02MB8871:EE_
x-ms-office365-filtering-correlation-id: 8fdb12f7-1fa1-4c83-7b76-08dcd6edb555
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|7092599003|461199028|19110799003|8060799006|1602099012|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 uxVHTpzrwo0lKwP95wOe4ftQhLF8gT90J9q1CX0XOKX0ksD9rlC9uQ9Edt0oyc9nook/OFD8sICbbStuzw4ZRKVmziM/jz/6cnQV4amRUxEFEGPbXh+LKGFVT9FxPImBrsAJpGrj6OumpWZKGJ5KCakHkZrZyga0r/RcSUh45bb69Y+Ncx6Byuwu2XSdbYCCfto29zWqwHub3r20qXL+I9Am08sOZtb7zp/F6sE2YxkDuGITlKh59cB7rdH+szNuvh7K/MjEcjcn6fXMsfYVxbqSMjJih5qC81a7XyU0kqDUQp5h1MkpviGTpZMYdFnmH4D4zLnLKOsyLBw+GP1qp0dag9C87eOufz+KDpenKy1CdgaslrS06TAoZmlq2RipREdRlOGUJJ11jtTGDb9CdQHcuidnwTV4xHczYOW4RJuxxcU193/O7uELQJeMxCyTtk3u+qaD8jkf23hAPmObnKqYqOUjQZN9eaIYIM35hboijXclCeiSqqhu4or9Tb9H8AcscmaHrPobsoE+Z6keZBB9GZ/De8Zvz6q7RUH4DsblQMVYnGCL5AC8dldEZXwhHdhKuoFa+MlPh0D1xWIDOIRgvRD8p6yqv7uP3UcfVkCLjWsBM7obsvwKmaMuakDbsTVkBM2iUdj4rUJz3fAQJ/DTL39DIV5SD2ANIo4GOpKeI2dD5n5UN0s+cnFfGZZgIjFdS1+eUDXR9mvU3e0skZwQkaAIfxJdTZuMsZXLVP9gthEf4JwkeNgfzeVTWEB+YkZ7rEpN5MhEUwaXUFRtiQSFGM2rR98qEcnAzcsPkcxgCtETtZf9rQx+nh+rYn74lpYLyLNXrdG0yuJKbYcZuw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0RxVDFqTzRrVk5acGQ4bWNKZENaTE1WR3JoZUVyakkraVhkc2VMZ0tnOHIx?=
 =?utf-8?B?MWF6NjRWcHZPSm5XSlRFdms5dFZkQ0NRZHpJbDE4TkthdDc2TGFFSVhhOGhh?=
 =?utf-8?B?ZFlidmxNc1diWTdnZTl3cTNlRlJ5c1EzT0FWaStmVW5LUDVJUGlyZCtZME8w?=
 =?utf-8?B?cHpzRW9DeWxmMnZQNUUvSTF3Z0dKQjhtQkV1SGNLeHJWcU9qTnZKWlVkK0RY?=
 =?utf-8?B?T2hiZEhtSjYrQlpDaHU4L2MxeDM1cm9DaDN6Uzl1azB2WVZLTm1sYkVIN2x0?=
 =?utf-8?B?QVBUTFhNOGo2YlA4VDM5N09rb3ZwM3lVaFNJTHBabnZIWi9CbTR1c3NqYVg5?=
 =?utf-8?B?OFRDeUxSaWl0ZEV3UzdLTzEzdHI5MDB2UzBmWnhPOFM5a3Z0dFhETGRwQnBF?=
 =?utf-8?B?eEo0c0hmU2NiWUxZcFYzbkh6M01tNnpwVFIrRUVZRFZiak0xekpFK2RkYWhZ?=
 =?utf-8?B?MXovcTJ3M2t4WlFVQ29RSTkzT29IWlorakg0WklIeVNlS3VtTURVOFE4eW1R?=
 =?utf-8?B?bHRlNUJrUUNmOGFJZTlaeHdsUURPZ2xEWndGTnROWFVQYUpsWS9PekdYaGtt?=
 =?utf-8?B?QVRES1ZEQ1ByUU1IRFFNeVRlejJ3Q3luT0NiOEFYcXYySFhybmRuNkNqZnUy?=
 =?utf-8?B?eGNWSUJxQ0dEUEJzZHBpODB2UVBvTUpGUWVadGtoVkVzZm9XaTd2TGM0ZG5r?=
 =?utf-8?B?TVM4TnVpNTY0eVR4dEJRZGdnZGZ6Y0NrNVg5d0xGMnk4cFlQVTE3Y1hDM0lR?=
 =?utf-8?B?SE1rbTlsRUJ6UGQ2Ly9qU0NvalQ2eXV4SDJKMDVGdUtPT1FtYmllYkdQWlJG?=
 =?utf-8?B?MEJ4YzVFRkpoQ1FjQzFTSXhOdjhXU25wZ1F0c2FIaEl6TEhXMktRVDJFSzdY?=
 =?utf-8?B?RzV0WVdTZVBrT2w3a244MVRVS0x2REF3Mzk4QjBYUklEZkVxMzFqRUFyVlRY?=
 =?utf-8?B?SzNic1AzeGIyamxlb29WNk0yemJEYTRXZGNQZlVFNkhyTzlJdjN0bHh2WGNN?=
 =?utf-8?B?MGNYM3Z6NVI4NlkweUdwZ2c1UW9Cc3VNcXVSejdBaGViN2drTW1GZlgwU055?=
 =?utf-8?B?QmphZVNkSHJsVHJwOExXUlRBNjgrKzNieGhGMkxIaWlFbkdZSzdWVWhQazVv?=
 =?utf-8?B?ZnZmVHZZWFpVYmlWZDYyMGNYUEdKVk5DNDNzN005WFp0cWZySWthQ2d4OXFH?=
 =?utf-8?B?dFZKMk5RWXM2Zjh4V1RLTVIvc2VDVkdPZGQ2cE40UmRKbkxVcS9NQ2lqNXF0?=
 =?utf-8?B?a29NWEhIWFExd1VEY0xuYWM3TkpXckV3dzNxQWxEa3c1cHMzK2hhL3oxSGJ6?=
 =?utf-8?B?QUFYaTlZWURVQktMSHRPdVBRRVN0d1RwRW9ldGk3ckVYa2svZ0V6R2tjR29z?=
 =?utf-8?B?Uk11VnAwVXlPclRQZGZVZnoyekxBWm5KQ0FUZ3FlWngyVXkwKytjU2VmeXRX?=
 =?utf-8?B?Z1V2UFRmZGtDbDcxaWpTS05GQkF5OWRmdlQ3cGovb25ycjdLWVR0eVUvUlNK?=
 =?utf-8?B?SStNUzI1a0h5alhlQ21FZXcwZ0RmWWg3MldtYTZYaG5yekxLOFluMXVrMWp5?=
 =?utf-8?B?dUwrTnVzMHptU3hoRm1GOCtRZEVZSTJsQlJHUzBsbWlUdzRTUXR4bTlLK0dW?=
 =?utf-8?Q?ClQuCKDBzP6Gitu0eds8ndD83HZ4uEf0sUzd/Uo4csSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR02MB7040.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb12f7-1fa1-4c83-7b76-08dcd6edb555
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 07:52:41.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8871

SGVsbG8sDQoNCmFmdGVyIEdpdCB2ZXJzaW9uIDIuNDUuMiBJ4oCZbSBubyBtb3JlIGFibGUgdG8g
cHVzaCB0byBhIEdpdEh1YiBIVFRQIHJlcG9zaXRvcnkuIFRyaWVkIDIuNDUuMywgMi40Ni4wIGFu
ZCAyLjQ2LjEuIEkgY2FuIHJlcHJvZHVjZSB0aGlzIG9uIG1hbnkgZGlmZmVyZW50IHN5c3RlbXMu
IEZvdW5kIGFsc28gYSBlbnRyeSBvbiByZWRkaXQ6IGh0dHBzOi8vd3d3LnJlZGRpdC5jb20vci9n
aXRodWIvY29tbWVudHMvMWYzeG1ubC9lcnJvcl9yZW1vdGVjdXJsX2Vycm9yX3JlYWRpbmdfY29t
bWFuZF9zdHJlYW0vDQoNCkhlcmUgc29tZSBtb3JlIGRldGFpbHM6DQoNClBTIEM6XFVzZXJzXFVz
ZXJcbXktcHJvamVjdF8xPiBnaXQgLS12ZXJzaW9uDQpnaXQgdmVyc2lvbiAyLjQ2LjAud2luZG93
cy4xDQpQUyBDOlxVc2Vyc1xVc2VyXG15LXByb2plY3RfMT4gZ2l0IHB1c2ggLS1mb3JjZQ0KZXJy
b3I6IHJlbW90ZS1jdXJsOiBlcnJvciByZWFkaW5nIGNvbW1hbmQgc3RyZWFtIGZyb20gZ2l0DQpl
cnJvcjogZmFpbGVkIHRvIHB1c2ggc29tZSByZWZzIHRvICdodHRwczovL2dpdGh1Yi5jb20vbXkt
Z2l0aHViLXVzZXIvbXktcHJvamVjdF8xLmdpdCcNCg0KUFMgQzpcVXNlcnNcVXNlclxteS1wcm9q
ZWN0XzE+IGdpdCAtLXZlcnNpb24NCmdpdCB2ZXJzaW9uIDIuNDUuMi53aW5kb3dzLjENClBTIEM6
XFVzZXJzXFVzZXJcbXktcHJvamVjdF8xPiBnaXQgcHVzaCAtLWZvcmNlDQpFbnVtZXJhdGluZyBv
YmplY3RzOiAyNywgZG9uZS4NCkNvdW50aW5nIG9iamVjdHM6IDEwMCUgKDI3LzI3KSwgZG9uZS4N
CkRlbHRhIGNvbXByZXNzaW9uIHVzaW5nIHVwIHRvIDggdGhyZWFkcw0KQ29tcHJlc3Npbmcgb2Jq
ZWN0czogMTAwJSAoMTYvMTYpLCBkb25lLg0KV3JpdGluZyBvYmplY3RzOiAxMDAlICgxOC8xOCks
IDE0LjUyIE1pQiB8IDIuMDggTWlCL3MsIGRvbmUuDQpUb3RhbCAxOCAoZGVsdGEgNyksIHJldXNl
ZCAxIChkZWx0YSAwKSwgcGFjay1yZXVzZWQgMCAoZnJvbSAwKQ0KcmVtb3RlOiBSZXNvbHZpbmcg
ZGVsdGFzOiAxMDAlICg3LzcpLCBjb21wbGV0ZWQgd2l0aCA1IGxvY2FsIG9iamVjdHMuDQpUbyBo
dHRwczovL2dpdGh1Yi5jb20vbXktZ2l0aHViLXVzZXIvbXktcHJvamVjdF8xLmdpdA0KwqAgwqBj
N2EwMjQ5Li4zNzkyNDZmIMKgbWFpbiAtPiBtYWluDQoNCg==
