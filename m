Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBB10A1E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310898; cv=fail; b=RXcm6bht3YSAs9hyOxvKzys6wt5jGE3/YqceFqbLiFxwK5D9uEVjTXC3B69rjBuFC1uKKu2QtPy/xHb/TS6Z641Thn2UoMDGUobGhMnC71APagL1caYgEVMaFBiC8BXSyoNWj2aWpe9mwVvGVMIgqfdV/YqIHoc+frGewvIxt+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310898; c=relaxed/simple;
	bh=1AmhBFF+oKyf2IBWC0zKi0NwbKP9VL56I1q9LJyCCgI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gDKGROqxe2NpyQq8vtsKkIGSaQ3dl1C+3ZYBr/m7LVlh2k9budl5gwO8JLoEetFnVVtN4QOu5Qbl9Y3KjZGrLqCJARDlsUgG24p3ZijsIptBTgwBrTzNl/qi2tkVC6cLx2BXJwpiWM5XbMrReQBRZtWTyK9aO6sE9ZHzLUUGhvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BaUNVsVs; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BaUNVsVs"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U2xhcU011976;
	Tue, 30 Jul 2024 03:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version:subject; s=
	pp1; bh=1AmhBFF+oKyf2IBWC0zKi0NwbKP9VL56I1q9LJyCCgI=; b=BaUNVsVs
	ehg1TUy3uzbllPpuXBpwLs9jmiMexFsIMA0gQkvbPdpidpNdyILJh5Jrjqhpwnz8
	MagnRYvgDte8grYPyCc2vXFfi/Qc4mXpRiLLcpsOyEFo1Y7G4zZgyMurQDOcajGN
	m3Ca15zzWqqmbibE4xj0A8BR87Ut7vn/HGgXKwepXA2Obyz+DRCt+94hj5kNesmI
	eEm7vQm+XA3t/mjLJ6vnjvD1YxOMutmGDfSwTZm0k8/n1Z2h0LPF4vwhStf2Se97
	NFt7L9U3p7l/Ik+kASsGlUzp8d6m5KpQ7AzNnSCXIKNzZrIqrzDBBih1+ySMjcpX
	j7a6t7WTEJrMGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ppyur4uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:41:20 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U3fKY7016356;
	Tue, 30 Jul 2024 03:41:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ppyur4us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:41:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIFF7ugBg25yTq1jkkRAwMh693DORZTuXatuOtvhxEO9whKdiz9pNbRO7qaOvaDKi7P/bo1qdDbMOmKTULM8p1qIn1fjs6lEhGIDyxmuMHC0QAIPFtvNeVETSrZR/PjPYeGzc4/X4a/pMVYZk9KlN6RUTOfWfLZGL7pnw2/sJwuVHzoHUYtny2c2zoj/cgYg3iT/GWXAkryYuResB/kYLcNnR70jyG7BL6WDZ7Eo7oA6CuHWuzaRSkzFl7m/foDmJ37hoeQ5KolEX+ojBDz8M28etX4jPo7FisCyS5YGBr1mjTsnWC9gKmBN43OsWKQ6CFh9njiELxnCwxZHv9WfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AmhBFF+oKyf2IBWC0zKi0NwbKP9VL56I1q9LJyCCgI=;
 b=ATnKI72JY+pRSivhgQBR0ngAfh6hwOUOWcMogGqPD15DAolfInJI/Mzrqpma+LhbuW4Arf2utaSzBk0wMpKADn4cNEE002kXnvCSqmjaLs0kLsgpVdIgzctvIDn0BXQ8pGdCP205uBOMXGGtyXSmYwbgZwVZN/dvczpMybDhlRV0VSJrAS/z9kwOhfv5IAIPWh6uqYaqDpIPlV5k3/UiaX+A6FZspaTIRFr60iKAquTuwyGmaUUub6TWyEZ+6RKJk5Sv95/1pwzLj3HQYqlPphJYk9M+LR+HPXP1bxJ/tllP85Zlk/s7EZRjwhfSBmpAuUqIEiCUSmIqPkpl+JuOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 MW4PR15MB4459.namprd15.prod.outlook.com (2603:10b6:303:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.29; Tue, 30 Jul 2024 03:41:17 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 03:41:17 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: Junio C Hamano <gitster@pobox.com>,
        Haritha via GitGitGadget
	<gitgitgadget@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Jeff King <peff@peff.net>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] Fix to avoid high memory footprint
Thread-Index: AQHa3244v7NltrrEFUCgyhPjAFL+gbIPAgAA
Date: Tue, 30 Jul 2024 03:41:17 +0000
Message-ID: <B292440D-119F-4D87-B308-EC90027EA63D@ibm.com>
References: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
 <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
 <xmqqa5i4yypc.fsf@gitster.g>
In-Reply-To: <xmqqa5i4yypc.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|MW4PR15MB4459:EE_
x-ms-office365-filtering-correlation-id: b44450ce-ce35-4a99-e200-08dcb04977ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MExxbEZOOUlnblAyVGtOdlN3T2lodnEyZzlsM3RlMEQ1dzFPNEhzZHlndW9U?=
 =?utf-8?B?aDE4ZEFCVXBqRUhlOVdnSXF2YmxoYUJjVExwT2N2S2c5K0J4QjNxajNYSFdo?=
 =?utf-8?B?eVdTbjZkT3lvLzFmVVJCUEF5cEdHNDdJOWY0bzQ2cXF1amhrZ0RmbWJOL2RB?=
 =?utf-8?B?SmcrUlNHWCtTNGtRd2plbkgrRWNpWE9kK0wvcFVVUGs0MWdzWmNPSjU5R1dQ?=
 =?utf-8?B?amZKei9DZjJQektIeGI5cVBCY1VmYVY5bWdVeFJaVjl3VklRTm5QTzZhMUNt?=
 =?utf-8?B?VnNvd2xIWjZCdkxTY1N2RGN2UXlpYkY0NzFkVUI0UVQva1ZRNjFuTnlneStL?=
 =?utf-8?B?TjExZXZ5YUZ0VXVVbFBWRFErZmtjTEdtd3c0TjJKcndoWmxMVTc4YWRsTCtr?=
 =?utf-8?B?YlJXWkU2YzNwMXhnb0hiT0Q2SU8zdzRLd1FaUmJHdHFST2M4dnVwVVRNaXlG?=
 =?utf-8?B?WVhOSmhsWCtaeEhndnFCc2ErMm9nQkJHNkxJVDJBOXFwbVIrZmdmQUNPL21K?=
 =?utf-8?B?a3dyekJrZlNnZzJXUGtQZU90cGlVVmtGYmlNYnowdHZSODVMbzM4Zk1UOHlE?=
 =?utf-8?B?NDRld2g4Y1dmOVpiVDgzQ0xJaE5KTjRMNVhVSjQ5UDU0UTBwUm5LeFNhbDgw?=
 =?utf-8?B?VmZrdkkydWlnbDB5ZEVVV2J2elVUVExkUElUMUEvS2xrc3p3dVhqb3lCeUJH?=
 =?utf-8?B?UTRrM0FJalU1Tkoxd2NqQm5WVUtKeW9MNDFoWEhTVE94VUVFSlE0MWZvU1Fy?=
 =?utf-8?B?Ly9WeHR5ZGNndHA1ckJtTFZZalFkS3JBb0tkK3g4SFhVbEJneFY2aEx3SFp5?=
 =?utf-8?B?NXBsd0ZZaG9yeUlpYVZmeTJ0ZnRteGhvRENTNFE2MW1BNnJLLzMrQXlJM09t?=
 =?utf-8?B?WS9EN0lMVkt5cm11dVBJaTVlM0FxSHRZVHRUZythS0JrREttM1ZzV0xucVBt?=
 =?utf-8?B?YkFKOFJzUmZxa1o5dEx2bkdHZ0k0VC9BVFg1Mm5KUG01WUx6WnVWU2JMQlJu?=
 =?utf-8?B?Y1dDWGpabE9WNFkxSGVSYkhmSE4xN3FxWXJEVWxucHpUbDI1MVh6bkx6UmJW?=
 =?utf-8?B?d2tTeTdieEdWN2NwWFllKzFPNXZodjFCTWZqdjBPTHZSbXBlUVdKSXY0N2pH?=
 =?utf-8?B?YWFRcjBub2lxamIrZXZDemh1TmQ1dFppaVFscmFBTnB2cnpwcXdJOGJBeVU5?=
 =?utf-8?B?SlZDYjdNNzV1VkcyaHlJanZKWUkwMXg1NWJDcHFTWmpwdkxNRTlwSFViOEZm?=
 =?utf-8?B?TmY3Mk1hOTE3RklhbUVOWUQ0MTUrZUlrak1iSkhDVFBxaDVJOGszaWQ2Yitp?=
 =?utf-8?B?MjQzbndLZy9zSmhGSHhEWENvcGFnU3JXY0U1WFlnM0JRekpIbUk1OWVHYWRR?=
 =?utf-8?B?OXBaWHErNFI5YXdhYTBRWDBzUHp3bzVQUWU4SXRIckZFYTdKak1Sak1Eb1Np?=
 =?utf-8?B?Q2tRdDlWZ3lzSWRyWnpEaXlIcU0zLzB0VHpDdkpFZjF0TWxyVXlGcXRBbnIx?=
 =?utf-8?B?QzJZT1JPOS93WEtXYW9XY3RSWjlXK1U3enBHOTZUUTlMMFd3MFBqSnBMVTRv?=
 =?utf-8?B?ZUFHN1hDd0tvQmJGTU5zMldiZitvYzFtcVNUUkJYanpQSzViVEJWMGJwa3l4?=
 =?utf-8?B?TDFOSFRoRXZENVZRalRqYkRhYnZEWCtoOUl5amcxeVZBRCt1SHJjdVAxMUlK?=
 =?utf-8?B?Sm1lTDZZck9pWVpSTlN4eFFiYzkyK0dPVzRPRzc1N1drWDVva1MvU1Fpalc5?=
 =?utf-8?B?amRvbGFkQlIwUldvcHFKY1NUbWQwR08wK0d2SnU1OTBVWnN3NGcvTGV2ejky?=
 =?utf-8?B?anhkWWt4NUM0ajE0WURISHZIUXBvYjZsbWVIaEZhNU5lMVhhRHNFeU1aZkJ4?=
 =?utf-8?B?bE9LNXdQd29vR21NMHJQZnk2WWdhcUZoNEtYU3FPdGhCRmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmxuanUyTU5hSDdyYlBFU1hHclpFREV4VUpqeFRZTEs3R0hkTXc3NHhBbEZV?=
 =?utf-8?B?L2xtYnFZRDVjWHl4eG5vVy9TMldHNjBld3pGMkVXRlI1OUZOUTZyVGduNkVj?=
 =?utf-8?B?ZzdLK0pGbFNVbU5zdFJIbHhBVXpJV1lVdjRuWGVYS3J5bGdRL215S3V4Tzgv?=
 =?utf-8?B?OCt0TkpIN3QyL2NJZEtLR2hvcFJqNG1tdFV2UE9IZHpFOENYbUN2SEorYVRw?=
 =?utf-8?B?a3RHeENJNUFPQXBoV3Bxc09ES3dXL1M2U3JDYVlkTnoxN0xKb0liZGU5RUsy?=
 =?utf-8?B?NDB6NDR1cURRSWoxNlJ5RWNIclNpdnFoNU9jZWx5U0k5amx3UFg2WG5sZXFW?=
 =?utf-8?B?OXRYTXRIL0hLa0M5S2hES0FPQWl1UHY1OVFVWnZPeVdmYkJRY2J5RkhPT3pR?=
 =?utf-8?B?SWxOVEUyYVAyaFJPNExoWHlHSTIrR3JPUjA1MVR1OGxPdFF4eU5hVnQrNmRH?=
 =?utf-8?B?Ump5dGUydDdlbTNqTFhSM3Q3V0FHVFczZUxPTVFjS0tNWWpxYVNIZXNjOXZY?=
 =?utf-8?B?ckNtc3hvelRKeVBXSkIyZm1hRHpwVThLQk1JVTgxaTdSc1ZhMUZaay9wY2Fl?=
 =?utf-8?B?eHBxeUhUWEVnczRzWW5lVjJMOU9tQkYwSWZvNzRrc3lEY3lnbkNNallnSGRl?=
 =?utf-8?B?ZUZvRjVSeGhoSU1vSnBJejdrSURBV1ZWQlNoQmVFYXpmc25kdy8vYUprOXlG?=
 =?utf-8?B?eUFZOXZQN2pHNU0rUWhmMndOcGl4ZmtKQXVKSUxzT3pTSUVaSm1DSFlFS2Zt?=
 =?utf-8?B?STB1S20rSHZZZHdCdlZaUXJ4dE9TSG1iMVFxOVd2eitBbGUvOFE0NU1LVzJI?=
 =?utf-8?B?UTczYW96ZEhGK0o1Y2N5alVzNkx1T0h1Nkw0TU1uZGNpUElOU0pFMWF5U0ow?=
 =?utf-8?B?WXVBN283UFB1OUJLMTNPUjUrMGxjMVlCQXhkMHJ6UWNvRkQ5UEkwbHU3Vk50?=
 =?utf-8?B?bUp2NUUxaFc5a2lSK1FYMkRtZzVNRUpKajZ4TVFxK1FEQk12dnpndGxOVHM4?=
 =?utf-8?B?NW1TdWo0TGdPUEtPSUU4aEVxYm5CSWY1S0IzaEpyam44L3dDVVp5YXF6MWQv?=
 =?utf-8?B?OFE3WEdiWDVMY1pSTGVrVGNiRDlNN1pEQitaS21UKyt0MkF6QWF3Z01Jd0Vl?=
 =?utf-8?B?Skk3TS9UQ2RtOHZZcHhKQ3ZGVFFwdURDc2ZrRDhjK0JUQ0NhVlc5SEpsM3hj?=
 =?utf-8?B?UlJSQmNOYkhUdW1CYWhDOERocmpGTy9sbzlYWUFOK1gvak5scktmazM1RmR2?=
 =?utf-8?B?UmpoeG9OTWJ3OW9uWDB6MjNoRnNPRVVQNGhOOHJtZWkybHlsNGVSdkcyd3FD?=
 =?utf-8?B?L0pJR3pGemFYZlI2b0pEVWFiTVh6QTJLOStXaUNIMjhuUWNIeFdlOVBjNlQ3?=
 =?utf-8?B?R3ByckRFOFB4U2tjSC91dTk3dTQxS0ZLaHRDUGltb1VGUDhqNnphTHFVWEVY?=
 =?utf-8?B?amY1bTJBclBYTkNSSEo1cDQ3NlV3Q3pYVzQwaC9mRUQwRWNlcUwvZ1hFdHh2?=
 =?utf-8?B?SHdhd3V2N2U2NWlWZ2o2SFE0UURJNkhiZjFRVUlhNDZJaHB1SHY1RUFXY25Q?=
 =?utf-8?B?TFFBNndOY3VUWkJtZjNYZXdUQmpYNUp2eUNZTGV0WUdPQTNQRzdTQmZBRk41?=
 =?utf-8?B?UmJBaE1hWkgzOHpDanNGeXUwdVNZZng4M2tjMS82YWNkU3hnVzRQZ3h1SUZ6?=
 =?utf-8?B?d3lrOHRpWVYwbE5IQjlabkZQOVpVZEVFWEluZVpZMEZGZks1TU11OVQxYzJs?=
 =?utf-8?B?UUtoMys0RUkxdk9QVGJLS29KWitYbXBCL0dRQmtzcVhGY0NrMXB4ZWZlNkF1?=
 =?utf-8?B?OEtibm16Zkx3YWR2V2tDcm0yZGRYaHFaNUNzZ3Yrb29LTzMyRkNaTnhtUEd1?=
 =?utf-8?B?WXRoTTdMQzljR2piZnBVaTJBaXlsMjFsNzk1ekplTXkwNFhWZnBDU25aNjZ0?=
 =?utf-8?B?aWJuNWdVWG5TYjA3dEoxRTk0cjZaQ3I2aDRsWGFtUDBnWVJ5SE8weTBFajJU?=
 =?utf-8?B?bCsrS1VKVEp2Wi8zWkV6aU4ydHRPekJWb1FaZVF2eEY4eGhTM0RkUC9rNjhV?=
 =?utf-8?B?bDcvbHFSZmJkTTQ1ejRUSGFLZHhLdEJSTDcxSHdYa3EvVCtmQUNaeityS1hY?=
 =?utf-8?B?ck5iNXVKRWtJcGZmcVdHUXo4K29CTFFUa0VUbFRiUXNteW12OXprckdlaGRM?=
 =?utf-8?Q?tybupVn6f9HW9lRtv1k/so4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05826FEAEEDFB14D843680BF788265CE@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44450ce-ce35-4a99-e200-08dcb04977ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 03:41:17.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5XuJYVIZxOywVuOb0qeTxO9CyF1mZ7raDOAZpdiNbxXQjtHqqTDy1ZfTVLpXeVeJM+ys4IB+DTKmgc/xDqSIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4459
X-Proofpoint-GUID: L5hHcowBaBA5tzAs0JZm6MdU8vie4aBQ
X-Proofpoint-ORIG-GUID: njJ-wxehxqwRnGdsO5br_UqC66GR3htS
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] Fix to avoid high memory footprint
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_03,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=926
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300024

SGVsbG8gVGVhbSwNCg0KSSBoYXZlIHJldGFpbmVkIGNvbnZlcnQgYXMgcGVyIFRvcnN0ZW4ncyBj
b21tZW50LiBSZXN0IGkgaGF2ZSBjaGFuZ2VkIGFzIHBlciBKdW5pbydzIHN1Z2dlc3Rpb24uIA0K
DQpUaGFuayB5b3UsIGV2ZXJ5b25lLg0KDQrvu79PbiAyNi8wNy8yNCwgODo0MiBQTSwgIkp1bmlv
IEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5jb20gPG1haWx0bzpnaXRzdGVyQHBvYm94LmNvbT4+
IHdyb3RlOg0KDQoNCiJIYXJpdGhhIHZpYSBHaXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21h
aWwuY29tIDxtYWlsdG86Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbT4+IHdyaXRlczoNCg0KDQpBbm90
aGVyIHRoaW5nLg0KDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gRml4IHRvIGF2b2lkIGhp
Z2ggbWVtb3J5IGZvb3RwcmludA0KDQoNClRoaXMgZG9lcyBub3QgdGVsbCB1cyBtdWNoIGFib3V0
IHdoYXQgYXJlYSBoYWQgcHJvYmxlbSB1bmRlciB3aGF0DQpjb25kaXRpb24uICJnaXQgc2hvcnRs
b2cgLS1uby1tZXJnZXMgLTIwMCBtYXN0ZXIiIG1heSBnaXZlIHVzIGdvb2QNCmV4YW1wbGVzIG9m
IGhvdyB3ZSB0eXBpY2FsbHkgd3JpdGUgdGhlIHRpdGxlIG9mIG91ciBjb21taXRzLg0KDQoNCklu
IHRoZSBjYXNlIG9mIHRoaXMgY2hhbmdlLCBpZGVhbGx5IHdlIHNob3VsZCBiZSBhYmxlIHRvIHRl
bGwgdGhhdA0KdGhpcyBpcyBhYm91dCB0cmFjaW5nIHRoZSBjb252ZXJzaW9uIGNvZGVwYXRoLg0K
DQoNClN1YmplY3Q6IFtQQVRDSCB2Tl0gZW5jb2Rpbmc6IHJldHVybiBlYXJseSB3aGVuIG5vdCB0
cmFjaW5nIGNvbnZlcnNpb24NCg0KDQpvciBzb21ldGhpbmcsIHBlcmhhcHM/DQoNCg0KDQo=
