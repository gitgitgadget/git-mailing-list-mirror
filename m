Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013079.outbound.protection.outlook.com [52.103.35.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920B359A6D
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278944; cv=fail; b=qkdlk9xVGYEVlGGzCsmWykcS9kuQsZucqwfRm1WCV1awlvT5l8gm9NDac4xJlfFooezXUbhL6JpuON0XFU2N61bdrAgijBS3vp4TdQWAlxva3F9HlpCczRPayNxRo1aJOdtwrTVtpHYXqWcJuSxv9+dX5oLOID4iAbvGYuaMjwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278944; c=relaxed/simple;
	bh=Vi67/qnNN8ETKe0TNVECfZvRcoRdaTe9Opjx1DfYzvk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tD3H1jJWDXwknn8HfZEReSSbnu/rGelmcrijQBRUWIPJnRaUQnfJnBU5ZfzB1sLts+sq8Po54enS6YBj6oY/xuQaVEreYXc9DFqtsO1gDHSOqDQhnvAWhK6cMn9XWaQtp8/D6nI+ZbXoIz3I/1KFqJ422Gw2obH1G4RUxWdrQHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E9AyXJoo; arc=fail smtp.client-ip=52.103.35.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E9AyXJoo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBG/qMsZCknUKaQZzL031rPdoU8T8xrbXp8kCcvPYJNZ3WSUskEY+Smzx7igYWlOxtNu0S+tHe1+gjFgUIefdCk1pRCWNJWfq9nAs8py7EHq9Buka0XVQ7byUA1mJCjSqiA+VLSyUIQ81EY1JchjCbtdV8aOry8BoaVdE4xim2goN/886c/30ioLSAsjxQEPycJIyGyiFPSW2mOnwL1eESlHdiRFzQnVqIkdK65lPYHsqRl57d6wk9IYCmTE510UTtJn1cAXIfHsVhWQoh14l2YPIYGosSlzRfc1p7b5J75ubHvwFHWNugih8WNudGBNRcLSlinpvNAt/3/ePrGSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8h9hB9/Ltj+Re16J0KfsJL/Qu6DosLM7gEm0QxVutc=;
 b=nF7SSfSCTtkp+qluihLaU1hSyhgg317B1v4815YvNP2VJFtyma4TOtZBt9ytoM9NS6jTgyOp5QBKPz4ovSGdKBdRiJjl+N/xN0itLTqFv0do32wpBhvX7a8Yu359a806K0aLtE1iGKCdJ/Tr0JLQwnpUgNfdHjg8ZeBYgIwit4vyrXl/GCJHxFlEk8zQhmDJwnXxp+RRUMsvfQCbUl+tJJhEFGexZ/zBNOsBEscDzac5zAdx2N/L+dHZHOaSQgO/XbStVTy5QERAIYwUe+3tm3sL+90UUkxEhKPDMgjZS9OH0x4+Pr7s8yJJGTXWWiS6yWXfWERctOlVSr0oXGjc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8h9hB9/Ltj+Re16J0KfsJL/Qu6DosLM7gEm0QxVutc=;
 b=E9AyXJooFC9ETZCnxFoDqUW8qxiTVj/us4pOep9sShRcVAxpHVIMZ2SLayH4n17sbhhvk/gteJ3G+6GQuEzIQ2NVUJigEqoQJ3ex5iRIMUi9vbUY3cCV+qHrGEIkwKc8qMq8Yin7dvfs6X7WGmmZXB0D7aFXoQPpWdDl5ZbXmaNFHPEVZdKPftZmlgkHCqHxVDhdCoZ5JJKeUuQdH+S53AhrvoUJL7JxkBhzmyyaQy2+Kt+YJPGksGebohDjqFNU/0QM4RIabY1FJ+S2N9KyLdMjVqU4XLnKC1Y5TnSYvDbGvCbkMMivQGj2WX+dgZgpMFM/oEJHeRa4q4lRlR346w==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by DB9PR03MB9736.eurprd03.prod.outlook.com
 (2603:10a6:10:451::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 15:42:20 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%2]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:42:20 +0000
Message-ID:
 <VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Fri, 12 Jun 2026 16:42:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: t5563-simple-http-auth failures with v2.55.0-rc0
To: Todd Zullinger <tmz@pobox.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>
References: <20260611210456.XYfhytSL@teonanacatl.net>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20260611210456.XYfhytSL@teonanacatl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <718b707a-0c78-46c7-baa7-c4c4746f37a0@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|DB9PR03MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2defae84-d43e-43b6-483b-08dec8993070
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|15080799012|23021999003|5072599009|6090799003|24021099003|8060799015|41001999006|19110799012|10035399007|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9xZGtqdXAwcytHUFNxSU1YSlRhNVZSblN2RUN1RHZacTN1a2NwN29jb0Ux?=
 =?utf-8?B?ZnhwQ0htdTFTS3gzV1ZrbnRsR1pFMDdvRUFtSkRUUWtuejFncFpnb3djRkZC?=
 =?utf-8?B?ODlFOW8rSlpvV1FON3FDVHl0QmRQb0FUSll3bTlIdGM1ZnQ0QklNVHl6QXBS?=
 =?utf-8?B?VUgzV05LSjFxU1hMR1pIb1V2UHdqT3R3UVkvUlJEcE91QUlzU3V3c21SNE0r?=
 =?utf-8?B?c2VjUnNNbHRLVHV1SkhIeWlDdGZBTGxTR1BBZkptTDBIdU1Nd2FhaVc0YlJL?=
 =?utf-8?B?UTJHUkR4NzZ1Wkp3WWllSEFYUUFOd1dDYlppWVJYN2sxZFFOZU5tZ2xOcUIr?=
 =?utf-8?B?ZklaZmN0Q3dLbjZUdVpuWGpoMVJ4ak1ZdDgvREMwZ215YS9WTDJkVlJZOU03?=
 =?utf-8?B?Wk5VNVUrUXI4K1J0RTJMRGRNdDBzdWo2dTk5RTdQSi90dVFtSjh0emFEN0po?=
 =?utf-8?B?YlZ3L1h6VlBlVXZaRUxKRm8ycG5WV0Jhb2RLeWNLQVBYYUl4bDFmdk1nVDVn?=
 =?utf-8?B?OHA1VGZwZ0tvaS9xRVVTZHg0WWFGV0FWZ0dPT3BYengva2VJRjE4R1hHZHE2?=
 =?utf-8?B?MHNOZUc0aTdYdlJEM3RNTWpZUE9NOVJCRTkveUhFTTR5aXhuNDdGcGkxclVq?=
 =?utf-8?B?VnhlTXNsbXJSTE1oYVVwNFVMbVNBTUJtelJwSDBTaGRza3JoNnNlbGcvRHNj?=
 =?utf-8?B?N3FOazcxQ0ZYTS9kbVIvWnh1aHZ2MmtXTWlBNnJ4akNvMTR4UjhuL0U3aXdT?=
 =?utf-8?B?cm05MDNiR2FvZzAxekZSdWpMdHRnNEtTdFZRRkh6Ly9ITFNyQlI3dXRNNDFT?=
 =?utf-8?B?d2JGaDlVUktFMGk0bVpFUmRCV253UERsUnNWekhrRlFWa3ZGYll1cXI4N2ZS?=
 =?utf-8?B?czBvUWVoUE9jYUpXNlNyalFXcVpCcEdiYldreGpTZUZQTklxYXRrT3pwWkIv?=
 =?utf-8?B?MEVaYjdEeVY4RzVzOGNWcVcvNDZoZS96c0xadVp5dWRQaHExemwyOVI4SnRL?=
 =?utf-8?B?NmppZ3Q1cHdpVXAwYmxhYTBuQm52em9HWktwVnBoRnZtNXpNcDQ5WXJzMFFu?=
 =?utf-8?B?dE5qV1ZtTHExbDVDek1XRXd6cTIyZEVlbUdsS1NTcDRRMTNneGN6VzFjUU8w?=
 =?utf-8?B?QW9RQ2ZzNWVIWHpMdmVacm9mRndUSW15MnluamM4R2ZEYTlwR3V5SnE0d0d3?=
 =?utf-8?B?a0R4cjNhRW5yR0wzb3JUZi8vNTc1aGZhVlRHNG9oK1pJREFzckxhYk4wVThY?=
 =?utf-8?B?eTA3QXg5RTZZbm05OHFieVFzU20zY1lLOGxqZDlhNkdmcEwvelV2SWZESTBI?=
 =?utf-8?B?VDEwVWI1K2VGMjhSWS9xcjBIb0thV3dZUUlhT253ekNIR1dvSWhjNW9UN3J5?=
 =?utf-8?B?NHV6SEY3MkdqQmoxZGphTUdtWThxK0g3VWUvLzhtalF4TGZSNVhSdmJBRmcr?=
 =?utf-8?Q?5NoyKs7Z?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3hJdlVXOWpGNVVtd29nZG8vOEhBVlM4Y2pKOVVsZ3ZqUFhqT0MxbGc4di9B?=
 =?utf-8?B?OWJtNjBIeDkvM09FUVEyTk9CYU41RTdwdXRpWi9pNnYyQ2RiZ1BYSGVveEVT?=
 =?utf-8?B?WmlIa1grbC92RE5Ec0lGUjFsN3BlZjk0MDU4d3RVT3UrUHlPeDJwdXNreVVF?=
 =?utf-8?B?ajlncWZobGN5TXRpbTVpblYzUjFwcHBHS3RlVjhqTCtLY3pJcE9UY3R6UnFU?=
 =?utf-8?B?UU41T2VFb3MycHVmYUFMa1FDR0YwVU9rRzRwOUVDSmRXSnVjeGFsZUZTTmJp?=
 =?utf-8?B?V1dYT3N5NktsRlRlSWZZZzdRZnhjajdFT2JKeFU2MnUvLzhNOEdVNnl5SmhJ?=
 =?utf-8?B?WUhLcENHekNXMHRKOVo5SHR2MGk0T2dCZFRBZ0RUZjU3bXV3c2VweGtTL2dI?=
 =?utf-8?B?QVR0ZllWbW0zNXVQaHpBZUljb01qaWhTWENYQUlIemVWbUJKWi9zSU1BMVB3?=
 =?utf-8?B?a2lzY0VLTGpOUW1kVjZhejFLUEZSMFkvbTdmVEVSTTlISG5kcis4NlZWdU1u?=
 =?utf-8?B?Rmx4eHBCc3dKQVQ5SHVjYlZ6QWorUEN4ZExUYk41am5vWWJjV3F4NDdnQmlr?=
 =?utf-8?B?M3FKMGVnSW05Y1lnNTZUenpLV0FFRVNLNjVFTnNoOEJDaVBKTWNkVnhYc25j?=
 =?utf-8?B?MTVXWGtFaVVEc3hxSlF4eTBZMEh0OU1NV0t5ampxUHYzajNmV2xZMlVMRk1j?=
 =?utf-8?B?Z2duSitTd2pDS1pUazhLeVdxdXRvNk5uY1hMWTltazE0UXhHaUxaa0VRemxz?=
 =?utf-8?B?TkhGSmlzMnFVdVNBR29Sa2dJblk3Z1hFME5iOHUzajZoL3c2MUltalFEYksr?=
 =?utf-8?B?cllzSUlIV2dmU1pZNnhsbWU5WWVTblRqOFJpUitDN01NeDhGZ2JpdFpkRzZt?=
 =?utf-8?B?YWRCUE1zMXlEWWg3eTFBdW04S1hIUFFZQ1pMZ1cvZWFmd00wNEI5UGVFVDBt?=
 =?utf-8?B?MnBHQnZ2c3lSaFQ0L2locTc1bUJ1eFN4blZPVlVvdEc2UkdGSmNVZ0s4d1FS?=
 =?utf-8?B?a1ZPaGlWVy8rQmpjUXZBa282d3lUM0VMb0RmM21odmZndUJCSDBCWlVaSGFJ?=
 =?utf-8?B?WW1oMFV0aVNpeFZlcXVMYWcxRk5EZ3d0R29xOXZMMGF2SUZjVFYwSVFYUU40?=
 =?utf-8?B?UUNaelhmUmthLzFCNzNIKy9HQzM4NkxaaTRteTlIdFIxUUdORWNETkN0QU5G?=
 =?utf-8?B?YjMvRUlEUmFEZGluL1BDV1dmTXBzbytDQjJLVlFFME1FRGdiQ0pxVEsyWVNN?=
 =?utf-8?B?UmFxUTloVzJONkZVNFo5OG1LQ2NBVDRSWXA3c0pmd3Z1Y0xyalYzS3ZNVEpt?=
 =?utf-8?B?S3ZXZTVmT0w1aFZ3RHltZ3U3WGpOWG90cEtwdkhrMDlRTkRXbllRbUpTbFYz?=
 =?utf-8?B?clRJM1ZiSFBqRkpRZWZVVTZaVUZ0R2lpdXdPUTlqNzVVWnhDSE00WWt2anBV?=
 =?utf-8?B?ZUhSKy9MZGJLRUtPeEd3TXRoQnJra0hLeThyOXB5bUNEWHBNTEF4OUJtRXRG?=
 =?utf-8?B?YXYyNys2U1pMcFh1cEI2eWhNM3pyMHJqdGtOZVVSK3BkbTlxK3RycjFHM0pR?=
 =?utf-8?B?M2hVZzBjT1NTbEpuak5mY1M2V3Q0QWJGWHhqWFFaQ2RUVWxKQTVKOGt6WE5H?=
 =?utf-8?B?Nm5CeUpMbUpoeWZnMXh5S2VWSlJKK2JhbWtaYkt2aVVFTWdaN1UvQzBGOUMz?=
 =?utf-8?B?RWVOa3dRdkplQTVYMHV2Wk0wTUlTOXVtMEx6TnpXOXU3MjJCRWlrTWFwczZV?=
 =?utf-8?B?eERaNUVjTlZKWHZ2Zm56RTFaOW9ia2hGeCtZKzlETUt1WHFXa1dKNXhmRFNV?=
 =?utf-8?B?V1RKRlhhSU83RFNwK0tpUmcrcWdDV3hhL3JEdVB5cWZuaVAxKy9aWFp4UXJw?=
 =?utf-8?Q?6t2BuDfRcrcgE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2defae84-d43e-43b6-483b-08dec8993070
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:42:20.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9736

On 2026-06-11 22:04, Todd Zullinger wrote:

> Hi,
> 
> I tested the freshly-tagged 2.55.0-rc0 and noticed some new
> failures on the in-progress Fedora 45 (AKA Rawhide) for
> t5563.18 (http.emptyAuth=auto attempts Negotiate before
> credential_fill) which was added in 9b1630b972 (t5563: add
> tests for http.emptyAuth with Negotiate, 2026-04-16).
> 
> I notice that Fedora 44 (where the tests all pass) has
> curl-8.18.0 while Fedora 45 has curl-8.21.0-rc2.  The
> version of httpd is the same between them, FWIW.  I didn't
> compare other package differences; it could be something
> else entirely.

Thanks for the report. The failure is not in Git, it is a libcurl
behaviour change, and there is already an open upstream issue:

   https://github.com/curl/curl/issues/21943
   "Negotiate ignored with --anyauth" (Dan Fandrich, 2026-06-10)

Dan also bisected it to the same commit I had locally,
`8f71d0fde515` ("creds: hold credentials", curl PR #21548).

His report describes the regression at the `curl(1)` level (`curl
--anyauth -u : ...` no longer attempts Negotiate); t5563 test 18 is
the same regression observed through `http.emptyAuth=auto`, which
under the hood is the same `CURLOPT_USERPWD=":"` pattern.

Dan also notes a workaround: replacing `-u :` with `-u
literally:anything` (any non-blank username, real or fake) puts
libcurl back on the Negotiate path. That suggests a small Git-side
escape hatch is possible if we want to unblock people running
against current libcurl while we wait for an upstream fix; I have
not tried it yet and would want to be sure it does not have side
effects on other auth schemes before proposing it.

Daniel Stenberg has acknowledged the curl issue but has not yet
posted a fix. I will follow curl#21943 and, if the upstream answer
is "the new behaviour is intended", come back here with a proposal
for what Git should do about `http.emptyAuth` and test 18.

Thanks,
Matthew

