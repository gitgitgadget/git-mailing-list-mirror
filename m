Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2012.outbound.protection.outlook.com [40.92.47.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BD182AE
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056871; cv=fail; b=eV5jBPHjJ/6dIlJaCUhxzm6qPD8M3cPntxe7XS0uik8u2CfQ1TC9Yr8bEVHPE3KUdpMd1szurSowDju7pMPWqTAsnPzAN3py3pNP8y/moQ0eUDtr96lER64fufgsHHFDX+FemRrffTG7P555nx05QMB1XAj1gqlMNGrThzRXzmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056871; c=relaxed/simple;
	bh=wiHT5dDpfwi/J/g4mH3B3cvy948gf5IXhvFQaHCJL4s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OKCt63XvxZKxq+sL1gL32bMUka61R7hY3CyD1CijN6xf8aYQwQDH71PeZX1PUASXE+ksxNvACI+EhnHLPAVfVeZCsgBGJYDF6uCn74ONtdM81Z6/W5zGboPw//+11ZcBg/3mIddMQVucGEpXujQoncYxfbCh6CHk6B2MCJqu2Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kinxi6v6; arc=fail smtp.client-ip=40.92.47.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kinxi6v6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z61Z4z94F2X6bRMtF4gubWHvRPwkxUHCcCacY/8Sgbs9IsiAgxkZzJSLDzIrWQ83Jw1onKs0EO2SN2+Qu4x1v8O9QiuLuZh0t3uyfLbeMaEXEOH6VTy7eGSq9T336gObJVdk6eyUzxEaMh3SwMzRa3p7owsaEEnHezrno/WgNZxykztgTRiv14CZJwQ0t5pYpyvQIcIBlwKvFzzFV8oow4DEY0Htbcs89Wl1OJTqfa2zipY5kZDDtMgm0LY3luWyEjr4MfYgeemYa8DZaVmO34Drdn0/POPTG0DUj9U0gJvoUAyRLKZ+eboQ7FyjGi+wO4OV/ezW0fPAZEqxg9u2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiHT5dDpfwi/J/g4mH3B3cvy948gf5IXhvFQaHCJL4s=;
 b=dNNFR8EJRfEhspCTg/HkhqIF3+XrtXBhrFCrzHEZl2qhV6aKW8RDhN4Ohg33CyiPKKzf+e9unx7rdNUoKb90u/jHcYsWkk05rRZ3mKHiDt7777DYdDeFrqPxWrQVqK58oAtk7tn0PCpp0NP9F6+cajZoUQslDKgXGZRM3e0Boxh48ZCq7XAPDiFnNilmvlDhGx/lF9FMznc2N/yai2EtT3gym/Bgt/MIDPTpyFw/P1QsyP7sMrPrPGpirzTAwOqBNB4jeaX561NvI9F/xFW+Eu5QH6PkVW3mzQn0eC429Q21NBjswE8v4BELE4D3l4HQG4BGQCBzUrcJ7qNdrOvTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiHT5dDpfwi/J/g4mH3B3cvy948gf5IXhvFQaHCJL4s=;
 b=kinxi6v6b5EDjmaq0tRmKEyhqBk5kNv+ymcX1uEKENakLNH6T5iFrBBeLJ3KoTJrbr/ktQS2GGJp+R/WVm2YXHGUJRORwB5iFTeO2JSVatnKaCLB4nKxELolnHDFN9Uds+4lESyWnhj5MkD1vc4rCGxTqIS5WaJam9S+HsQQePsMuTZsk1whtS4vrsYlavaeJnVQD8JpQWrKCTWw4V2atyHvzvkbItagH2pd+lSCE12i9SBJ/bvNRhGJb3T0TmjgbQJ1up88Px6BB9+c42T8II7EWOVtoyze1yLADM+anGWFlEvWuMXKDRIFb5Dlrnvo4XIZFYu9nT9ScA3YfqlBLw==
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d9::7)
 by LV3P220MB1657.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 04:14:27 +0000
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9]) by LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 04:14:27 +0000
From: ross nicholas Oneil thomas <rossrecovery93245@outlook.com>
To: GitHub <support@githubsupport.com>, Github email <git@vger.kernel.org>,
	Legal Notice <dmcanotice@mozilla.com>
Subject: Not aloud to
Thread-Topic: Not aloud to
Thread-Index: AQHaYI6ha4HbhMDDMEKhTinbrOgv1w==
Date: Fri, 16 Feb 2024 04:14:26 +0000
Message-ID:
 <LV3P220MB1286928F0963894B142D8657FB4C2@LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [K3X4oluB4pnKCiuCVbtX2umCRbMKm7bKWiA0hBx4Vpg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3P220MB1286:EE_|LV3P220MB1657:EE_
x-ms-office365-filtering-correlation-id: 04893082-656c-4d82-be4c-08dc2ea5c3d8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iV0diYoazZyu9Gm9wqvsqJGsUbX8Q5ajngMoWUHjdjjAOLmmiMaCOJsdEwLqz9uJCd3V08lyLmpaR3JwdKhD7FKYeWiAzmICH6bVemDkaOlazZzAaWPcGhBhy+XN+8rvoq3XvNjSoDq9Wdy8yHI5saDCULS4IrBoaKrEYMDP2LzzYctj8RgCGPjIxv1/aSVXPe1e3p96K8VvVHGy3/GtTzcb81Z8RIhlzJR5+qfDojZ97bdDhkgzeavOntTSm4mhcaUvcfHqK8aEH0VNxZ+W8Dm/HJr1AIVWn9VcXEcr1syolkjiqCR89O79jEzDDn7/ULe2hs1kHXQT13PjLJkz82jC+6Vb6SbREQljsTxHSRTBRyKD4B9MVpTdJU2abvlwXu289bYFYxw7HctNuvPByuZtbilhVQ6lFPSibZr4Tvde0IIuRgYw4gPFSRwCAXKGCkPYtAVVLz3x0HVnWVFXjVneWu6GIv3tT3sjkpdpzZn9fVMJz6HXt8ujWZU6mAax+fBVK77e3LAcoNMuVPLeoee2PICVplORXtSHGqqFAIj3pDSR05M7LTh1xmrUAFkiY4eYV7SYu60Ji1oszGol94sEmkZhNUfIdWVO7bFcuK0eNb5YgVRFqsIuBM45MuQxb97jNkrgPD5BCPuSdOST3g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sSx2AJ/JRQQA8bTxCl+E3aSBy5Co9DePkBomxE6pUl63dm7LPK+H7Ek2V78h?=
 =?us-ascii?Q?NLf44epV2ArEZ/ImBivolmc+DgW5GmmVAKQ9EzQ4g/JLFTKHLQBYTCOy7ncL?=
 =?us-ascii?Q?TkBaX7dwWHiXdxssggcdP1TVHyQBnQ4PEUg3T/GxbHrahCLplq7q6ZEtp6Dj?=
 =?us-ascii?Q?jZdSS9ybbar4Vq6xOZaTlmWXSpQCo0WSpKsS+jCMDyTyQXh5PMKRWHqcd01Y?=
 =?us-ascii?Q?+dnS32FdsIlstHceMCPQufUljB4+vMyqYF15ImPYpkZ9KHuax4nLVHI2UUBh?=
 =?us-ascii?Q?OjR5losBXXlAvv9kfrp00GkNPbUayGjoCQh3iXH2WLaRu49nvOAgIkja246J?=
 =?us-ascii?Q?SF1lfzwHUy+E5VI0a+I37awW9eim2lJIyMzTIdsyIqxAb5pZv7VCxhQyq5dU?=
 =?us-ascii?Q?vZ8NZwkdvcU/mtYWGEGFbq/76s5i4E931WLD7CiK0u0xcBA9rOh2dyWrtdcb?=
 =?us-ascii?Q?ApVRCnDcJ39WeRTO6zRNXMv3VJ6x04IcKwKjaURmjndqXisdxG6HUJYxAW9l?=
 =?us-ascii?Q?qup36VcerLj59GlqKEKmyqCzeVsMW5Dq6WGAyIaT2lWncDDJmC7u5D9LKkDR?=
 =?us-ascii?Q?cxdBQIe+TxXR/suGoqsDTlaD2V6RpDkj8+ZbdjEp0BryKHXgK6KpnQ7hvMm4?=
 =?us-ascii?Q?24qyRRR/gThm2+/yxa/9uXyvb6TWwu55S/5G/O2NLs6LXy76Dx64VrGkpyqH?=
 =?us-ascii?Q?KtPrXznb95Lpaot+TOXi84SCIlS6DeUQtQMWHmdp1iM7ePG2NV6g9JK/3jyL?=
 =?us-ascii?Q?bO44FQHbRa5GYFRStjrZyT4ipbMhBwFmOASYxzTDpJz4t5VlZCaDuvFJmoBM?=
 =?us-ascii?Q?mXLuUmFgwagpjviLJSoaf/mWYd9ERmc9v47eP68hs9/jfvJ2v2VSabvV4Ny+?=
 =?us-ascii?Q?SfeSlHork69PLKOyIXCG/gkJnVl/MUf8zom4Peci5RVAsJ85IdEg2G55/j++?=
 =?us-ascii?Q?iHufAVQVyWdkLdHl3Dyoc6J7WtKIwjhT1uPMSMOvydfBPujdiSFk0Ea5A8P1?=
 =?us-ascii?Q?ifyd3Ni4RROdF0wv8WpDi/ZOedJIrOGDUUiXku7UQDv/ZqO22R5isF7vMVIi?=
 =?us-ascii?Q?kFHxiRez8Und+ZN/FyrGq7WPa9Asmp0oexpmZeUPPK9aWrY7wk+2eoUzGwVZ?=
 =?us-ascii?Q?ZUYdzbn3b1KMKcyY8YZxUIfjQJIUXubLuIG3Bu+J5Ml1x+671IZjPgbERw5G?=
 =?us-ascii?Q?oapufnxV6d3O6uKrFta/lr8W6zBCFvuvJLFPetvD2MChSUvEpR6iMHhhAD2P?=
 =?us-ascii?Q?eHYq2+7hE4kQqUQXMwYD0GYM2Nefok9PzDPV6T6CJw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <CBCDC02F0A44CE41BF4C227367F5336C@sct-15-20-4755-11-msonline-outlook-3458f.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04893082-656c-4d82-be4c-08dc2ea5c3d8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 04:14:26.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1657


This is unacceptable for license

https://github.com/chromaui/chromatic-cli/actions/workflows/check-labels.ym=
l


Ross Nicholas Oneil Thomas
ownership of:
www.github.com
www.coinbase.com
www.jsnull.com
(559-816-2950)

