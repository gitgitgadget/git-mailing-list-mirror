Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD827FD43
	for <git@vger.kernel.org>; Tue, 27 May 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368661; cv=fail; b=UAdFF7tXioRQSzaDNz/Q23hSRE+wP0Guqw0CllJ34j6jMeprTteyhw6w5honLciPDsCdDdxBw9pudh33iPC2Qj1eTxVQ3qGx4BU/YdGCprKRP3/OD6uRHoDc185rEZBg68haKR20i8FXK34UMuzB2oUfQM6NoDAwZHCq0ldwPWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368661; c=relaxed/simple;
	bh=Gu2G/6AJH7JzIKpSO64tHHxOZHpFpZyLmZwpD7pbHGc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DbpXelO43XOTaSneaQZ4GNLEXR3XCtkIWoTwR/WcAwnrHk4hw7XPzjwxmU4yx+pJm6qoEJlb+mcgaTD1THJ/mBsiwokmz2wHuQSdDTD5Q37Znrz6kiIMrQQc1BHfkJ/fZuIXT5+UOkSVlhoejNO0nrRY56BQktJBUQRh4g/F7Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DIVwiQFK; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DIVwiQFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NalYMRCvjEdevXZgxoFQ4VG+6ffahsPKmovNmS/gInR7g7rCiXbVcuclNyZf8wmR6Wzx1+l7A04rjeaHLXnXyt/IS5KiTFNK1SH2vM4rAR1/8SgPmMTwjvIi5tZo5+8LhOiH7czKBikPPUA8G/2D1aVZr3ORUE2nbXdesci/PANXGABIwDpZsbW7t8cM+UeFw0c17eiQTUJZS1AEVna9sxWqKvnVL83/EEZjAxMmVvvcLDWxIFafmKKvKVfEASDdsTA3e0+32DghfIkruKktOCH/apr0DRt7605ZOLKjEvrJjnsn1pNm5VGCD124jBohqP16kqfzVbFl8F3Niz469Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEFN707ppmSw1eZmQQzGtc4y82c5IDc0hxFekSzrdUU=;
 b=jsKZWKQOdNzoH4a8RUiauJWOqLPk8SxZ2lYSfIPXiy1pXpl3wsLJvAX8MTBTkelEbr/nxQc/yFkE5j7gLuudM8HB4qVauUQIpBkEfKEM0Xx+Ly3AVw4J6I0GHDX/WESTw3bnNaR8rjjeWnoq6zoaxLWtyC7eSUqE0oxu+6SHJRa1YflhFR3fkST+vU+ui6/5Gusq2JevSHUbUlnUboAxd2IbXFPhwYapJOiMk/ce7ZiHiqE6Ci1Jf1gqJShCCgPLLVgT6q5L2jUPnVYLDeMW3Xe13fFdfBy5VqyxmVihhs1I1QtyOi26U3j34Vg8YryfDU3MYMS20st21ANtL/+DYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEFN707ppmSw1eZmQQzGtc4y82c5IDc0hxFekSzrdUU=;
 b=DIVwiQFKm2sP0vaiSydCElEpcrylznHh/4gyMJdXViUeBl5jOICr0VrFfbti+vAFt+WtK4KIeNrA2itcCLt5219SieNttNxH/THiCI1L1GM2NBb1ah5F6uEBVDrOLQWYs1J4sgNJCLhtOfZQcRsyPGeMOUnd3dCggc/B4T3eST05cBYXQ1bwiLSEXnADjZ0vF+du/V13yKTwBttHLrggcMI6enCKnwHv7w2O9PasoRf5V8R0E6pzrTTes1HbrGdINAPpsxk0rl3wXkCchoqfoGzItj6MQLT6h3FmPueOb8moFC67bZfgoYOhpuslamRQMMxdsJBUbAfAhb0LHCbMxA==
Received: from SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:284::8) by
 SY8P300MB0151.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:261::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Tue, 27 May 2025 17:57:36 +0000
Received: from SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a2e2:675e:247a:cc33]) by SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a2e2:675e:247a:cc33%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 17:57:36 +0000
From: RocketDev <ma2014119@outlook.com>
To: git@vger.kernel.org
Subject: Git hook for pre-tag?
Date: Wed, 28 May 2025 01:57:19 +0800
Message-ID:
 <SY0P300MB09101E749C9BFA924E8275B2EE64A@SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; boundary="nextPart13785371.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:284::8)
X-Microsoft-Original-Message-ID: <2240250.irdbgypaU6@archog>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0910:EE_|SY8P300MB0151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6a8a2a-c940-459f-f59f-08dd9d47f67a
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASIScjX/aS/OnauL17RJFM5JfjcjQVaWyP+UVkynY/KVqGI+T3coFngCMmhuTEKKzJLlMDNp09oCHYsKDe9ObVBOTIf/UFs2WAc2iJCEG3uEYWuVK8Zr2C9TTkiqFMrjw/RZG0y5DypYf8j5noYlJTp6CyoEuH2kcLwBIv/kDIK4S4p6MhFgDJAC+Wws3odrgxcxUUpB4523dgr9aoTFHxVG8JxejRg6+9Vcbgt41EysbIgIlZLP/aQRD7BZh23JtIcEBUreiEBjW7xaXapv8dIcQ8P85rLXoP/SpxSEtfvA9ym3zio75LsdobnODiywsOBat8t8I1osOOuAftf/KW3wP8/XqV7dOPL0omzp8HySJ55PG6LXHigzopGqnyuu1n6y3pBJb6yia0tAA3nwJN6SQ6SYi3N0SqJmOgq1XY+1NtJuh3gRMrFesockIxFmj9/q34RUGgQsCpQRdWXRFSHpTSTd7iqHEFUcCj3nYVWSbO53wMyCDN14n6IE8s4A1DczWVXkbNOYwkvKJPhj/g2aKX1+2CdPwOQqPly+UGKQGWbCOdmjbjQcvLfDV/zbDQFx8XbtbSYNn3chCz4K2g+HGBbdEIbN70e/qwXcUblm2NbVSWIGSzLec6c8zUhQ23riMywMNAAoMk84E+8R7BF1wtPMZpjO3AV5jJyZK4rwzwc3FpFXGuRLky43XyDFD63cHZg14HHf+Q==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|12121999007|15080799009|5072599009|19110799006|5062599005|461199028|3412199025|440099028|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGtjYUY0d0FxN21xRE9OcnZzS0NCZzd1Vnc1dDdtNDZLTG9rU1RYQXBmUDVa?=
 =?utf-8?B?MlRmV1BDeTlmL3VFOExGV3dLQXBJUm9DRnpUSlk2MkVyUzVBZUVzSXlwSGxQ?=
 =?utf-8?B?c1RkRTRrOWN0djhnTUZoVFROTVZhUndrT0IvSThnL0V6a2cxSHdNcmk3TjBm?=
 =?utf-8?B?a3VQZmtUV29hSjRFNU80bjNUQS9iUWNuNHowa0tjY295M1JVSWtqanhaM2NO?=
 =?utf-8?B?ZjVVU2YzZmxvTWtkYTBnYTlBZjF1RmZkblBQb3BoZWg1dlhwM1gxWWRwaUJs?=
 =?utf-8?B?TFV4UGFtUEt4MUhNakRaSWZEMlhTS3Q3bHRVUHlwZnc5N25FaHZ3aE1rdVln?=
 =?utf-8?B?ejR5anlsMDBzVS85bXpSVkxvbEw5aHladmJTWVRGc0xieE1qcmhSWDBpZzMv?=
 =?utf-8?B?M1gwKzMyL3JOWFpGSjd3OGF2WitXZjVwMFcwMndLSFVScFhBUDEzdzhtZ011?=
 =?utf-8?B?ekRVMVVJRUFBb0EvZGFSYzdyQ0N6MzRtSUdoR0h0NmRtRzFCMUhkcVdJTzI3?=
 =?utf-8?B?ZFNZZlZkcWNQWVREak5meXV6VUZLcE4zb2lGRG5FTENCVGtDUGJiQzloSjlp?=
 =?utf-8?B?bFgyZWRhM0tXLzZrYjFRbHhpd2ZHclpLcGlhaUM4QnFnVnAzRGFxcjhGdGRW?=
 =?utf-8?B?R3RsNk5yaHdCY1Z1eExtTFVsd2ticnNoMFFrbWNoVnhYNklVWHZzc1FPQnM2?=
 =?utf-8?B?ck50Nm1TQTdZR2lIbGRjZVZrbHJ2WXNVbFd6Z0tDQUNDZlNDNkpoU2NrcmZm?=
 =?utf-8?B?NjF3dlhVUFdDWHpUT3ZrOENUK3NvMUo3cTFIMkEyWHRkcTQzN3g3NitBNkZL?=
 =?utf-8?B?OG9uSiswUjVCQkRpVHg5ZlJQaTlJYmZxTmJFSVZveCszZGhBN09OSjJNRWo2?=
 =?utf-8?B?dHpMU3dPWG03V3A5ZVFVcjlrYk1jQXRmMmFtNENOZys5TFIyWnY0YWdoNGRi?=
 =?utf-8?B?Q2RlcnR6amRSaFRHc2x6U3ZXckpvcXg4TllaYzhMK29rYlE4cmd4UkR4ZG1G?=
 =?utf-8?B?Z3ovcDV2VGlaN3k5YzVRWlhwQnZlRGtyVUFJelhoUWt5L1JhTnZrYVFNVys0?=
 =?utf-8?B?akhOK1hGNzZjT0V1NHB6WlVRUTJHSTd1MFBLNTJxc2FMMmcwM2pmU3dOVEFi?=
 =?utf-8?B?MDFSdFBtRUdFRVAyRmFJSTFzR0Y5L1lSMk8vdzNvYlliMTBSWjVMNkV6MVhz?=
 =?utf-8?B?RFpjVTFjemNqdDZUTlpsTS9LT01NcGpJM25vNFFxVEplNW9TYlJ1MXJDUW5U?=
 =?utf-8?B?cE5xUC9SeDVQR3VOMTdwS21wSWN3Zlk3RFBqVXZOd2lYMnp3ZkswcjJvU25S?=
 =?utf-8?B?N09VQko0eGRBMVdCVmhHYzVlOHg0UjhOcTBDZHhjbGtrNThHd2VxL3JjUVBH?=
 =?utf-8?B?UFVIc0tZcHhNeHZhMXhMWURNNDUyb0RqQTVtLzVFWjdaVzJoaE02SUNKQy9k?=
 =?utf-8?B?bElWNzM1K1F2MDBsSXVTWDBCY1d1Y1gvSTMvVkIwMWRpSVpYVjhjWmwySUJQ?=
 =?utf-8?B?YURSRlhPdVY2emc0cis3RFA3V3VXN3MxR2JnUVNlS21sczhMWk5NNW8vc3Rm?=
 =?utf-8?B?Smt4SlVKWHNQSmdaZ1pUc0NoRExoYlNHRWNqU2VWU2wxdnV5ZEUxMXI2VEV4?=
 =?utf-8?B?cnNUWHBpRmNMRHNxc0doNWtDTTg4dVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzE4eUdCMDBVNG1jNW5XZ3FxVVNXYkNKN0FDVTEyQTFWR2U2Y1RNTGtGUFF6?=
 =?utf-8?B?NHhSVXBXdURNTGVlaHVYMUtseWQ5SkFvcndmTEVIdTJzNno1RTJXdWpucG1j?=
 =?utf-8?B?T3pHdmFYQk1FVFlPemhySExoWlg1cS9IbytWUkRPRlI0ZGt2WVdFMHJjTWxX?=
 =?utf-8?B?bHVvbWpETXZuTGVUUUlXTlEvVnlFSTl3YytFV3Q2Nzd0b1pZYlpoV2lzV3U2?=
 =?utf-8?B?cUYzZUdpSHRldmc1eVhROCtLMXNkUkxvVXNBWjkvSlAxbkxzQXFhcDF2aUEr?=
 =?utf-8?B?OXV3dnQ2NUxWYlJSb0hSMjRzMlI1WVBHVU1ITk9YZy85VzV0dk85QW82YmMy?=
 =?utf-8?B?UzlxYmsvczdpcTRKTmRFc3JYLzlkME5XWC93Mi9oRWRwcXRrVkRBQlBsUHg2?=
 =?utf-8?B?K05SbytIUis5VlhYbGlUV1dWbHFuWUR3M1BPcGRTZHlNdVlYTTBGWTN4eVZT?=
 =?utf-8?B?Z2pKWlU2UC9mZzB0ZklRdnhwWkRPMnJqUW5wUjZuSWxRb0VmNzhkUElMOVVU?=
 =?utf-8?B?cy9WTzI0QkI5eTdENFUxdXpndzc4aWFYdGRoUGUvVmtMdzNOQjM0YkpEdkh0?=
 =?utf-8?B?S0o1bGlWUUZ2V2JKQXFWbWtlNmIwZWhMdVZ5ZkwxbkRCc2RHdDVOWFp4OW5X?=
 =?utf-8?B?U29IMmJnWDRhN2FTalY3Qy82dElETFY5Z1lHRzdDNmNCZm0zQ0pYVDF3aFNl?=
 =?utf-8?B?MVN3WGZCL0duZnduajNyRzR4VDh5VGFZVmFVbXg0S1prR21yMFdMNnBnck04?=
 =?utf-8?B?YXc4UFU0b1hwUU1nV1dUMEtJbDdDVXR1L25BY0lVc092UG5pTnM1NzJGV1g1?=
 =?utf-8?B?YklPcmo0cTFsTDQydFVkbU8xSHYyRUJKUGVyaXlKWFhGMGxHY1NuNlk2TzNY?=
 =?utf-8?B?NEdiSVJidlF6QkI3eFZDMCtvcEdYMEN6NWpxS1JEL3RSZzlFL25XdHJvVWVi?=
 =?utf-8?B?Vkh4dFNSQ0gyME1XaVBPait4eVNSUW5wdjQ4K0t2WEdRNWlicWFzclF2eWth?=
 =?utf-8?B?TEpQcFJPOTlXcUozL3V6TnIwTGxYeVV3OHJxdk1JS2Q2Tm9XemJDY3B4V0FT?=
 =?utf-8?B?YkZkR3FZQUYvV0VLK1QvdnNUYTlnN1lJQjNReXNPRUJ4OWp2ekVjMk9NQm1v?=
 =?utf-8?B?UkUwTGR0RFJDaHppck9MQzgxRVVaUFV6L3NmRlV2M2ZocWFBNCtld0JRVCtW?=
 =?utf-8?B?UFRVdndLV2Z1MFFKVWN1U0pHeFlod3BSM1FlQk1nNU5WekdEVEVDTGw5Q1Zm?=
 =?utf-8?B?bUdVMCtqbm1pZW5ucE13S21CZjJzMlZCemhoWHVLRlllcXhQMEZCekk3L291?=
 =?utf-8?B?M3A3RUhWOExIeFpDUElVM3FpdktTbHgvNFFZYi9oaTErUTZtbHVuRE9xL28y?=
 =?utf-8?B?SldGV0JIWUZ3ZG1wMzRxM0xWSGZuNUg3YjN6OXBmaDcvc094dncxUjlCU0Vw?=
 =?utf-8?B?bmw1KzlnSXAxUlZwbXBTN01hQWFJZFYzWjRBMEdDR0NyS1p6dkNGNExOd0ZF?=
 =?utf-8?B?VDJ2aUJSbWJXMjVGdXR3czN2NjRNRlJvajBlNk8yZWNKUkNHczJCSDF3c3pY?=
 =?utf-8?B?aWNsMUE0dUFsSEVjaUVKRElvdUFnMFV1NEgzMlFKNmFmTXNwNDRSczQxSkYz?=
 =?utf-8?Q?DXvCsJ4EgXTuSzunIi6+BwtQevevJ8k2OdQN1nqAD9Y4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6a8a2a-c940-459f-f59f-08dd9d47f67a
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0910.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 17:57:36.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0151

--nextPart13785371.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: RocketDev <ma2014119@outlook.com>
To: git@vger.kernel.org
Subject: Git hook for pre-tag?
Date: Wed, 28 May 2025 01:57:19 +0800
Message-ID: <2240250.irdbgypaU6@archog>
MIME-Version: 1.0

Hi all,

I am maintaining a software repo and upgrading it by manually run git-tag. 
However, it bothers me a lot that sometimes I upgraded tag, but forgot 
updating the output of software `version` command. So I go for git-hooks, but 
do not find such one.

I wonder if this case (no pre-tag/post-tag hook) is by purpose, or just nobody 
implements it? Or maybe there are some other sorts of solutions?

Thanks in advance,
RocketDev 
--nextPart13785371.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSnrMw4bBXjxVTTSz6rCPmAkqRWuwUCaDX8/wAKCRCrCPmAkqRW
u282AP90hS4kTSwtWxBN4i+KCtDoxonGSHl5mY1Hn5BvQJ880wEAgysC2mfo+/3e
ue1GTwD7lhyeu1P+cKrT3LnWTA+aBA4=
=Cd8r
-----END PGP SIGNATURE-----

--nextPart13785371.uLZWGnKmhe--
