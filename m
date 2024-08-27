Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE629473
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739490; cv=fail; b=eFjdUoypatk7RVJ6BhWwrXyDGE8Zd95W2PBrev5TZ/E/BZ2yRXwANjmWEMuxPQsfFtB7bX65Z6N/hX9jyrCSygnn29a1OjTy5PBcfHNYZV20lyx7/33PA6kAikfKm8mHh9a5DYn+rg/U9mW0geq5RAteP/9iB7KyVIq67KwdKBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739490; c=relaxed/simple;
	bh=PIUxU38i9hbcUhg9j91HTZxL4jdONJrObIgwR6NDavQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nY/RFMCSdDdN7ZmWJI3IV1ZbIHTb8FhrRimjH6wutMnN4pYdLl/5emXvGRF5TMF4p8Ve4gu/lQuz8x3cDQtmPUqE9I3ZXXhfLEhH4DbNcVSg1/VUFFHN2hPAyp2naO+HzoouGmUOzsCmGMpLgZpyCNKIt9w14qte50CQOaP3v1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T1j/DyaD; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T1j/DyaD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1tMEA023790
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 06:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version:subject; s=
	pp1; bh=PIUxU38i9hbcUhg9j91HTZxL4jdONJrObIgwR6NDavQ=; b=T1j/DyaD
	jUkQf0aeshhk60NrYwnzANOK45ADFCt1F89LgZxbKt6fHWQF6yFv9Zdz6lnpp122
	p9VpnCNqIEnpDXi0Yz/UySNFQnPrxkY7ocoWeI+awK6GNgLRQI7XYu/UleKzJ9dQ
	J5PXuW3LgmS8W3qKe9YGzJHtzgiWHVFwoLboGBahpQkPWS25KP/ZlcjOWlEDzpV5
	qxKPNv1tm9G+UcSiEF/gexbnmzMlrS1wKqud/EUo3+GwGtIf2e01Do6jq8z3dD0K
	LYBgSWAvMRbVhD741deeTHNkgEPgX6B4QawCqJkQwjUniUnKQ6xEeCaytXtp/pef
	EwX8pY6Cq9NMmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417gr3a4y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 06:18:06 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47R6I5iV007466;
	Tue, 27 Aug 2024 06:18:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417gr3a4y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:18:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAK4pMoDRthOxIuiYHTbfxmNp0Z2KQTJSfcxUpGxnXLaI9X/p6C8oDjz38mK1Musz2ehYZeZuteOBPPXUAUKa7EQ0faWskLwSRAHFAX5ZrhMYpwLJvfV9g2GSLiu2TbPS6tfRiNGJLd3yxArmNEViq3WmxqZwYj2yb5zaVAEdM6tJ8/5du89Q5iNFL2nYvBIGK6qlubdPLqRlnmOcZyoOY9w7I3JbNFeipBsEOtR47LlqIEA/DWk8K3JWhPc3wuJFIfvrz9LP9FRyXyECexlT+hXgJWWDuGBLkAHsWnrUulvT9M1VDXs+J+LJcuHQPJaauEzEoT42uGwI33v80rW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIUxU38i9hbcUhg9j91HTZxL4jdONJrObIgwR6NDavQ=;
 b=gPSksfr/GHvx7i8jCdaFPsUwVaFtnvVwzz/rcEiJpb5X2op2KhRH/aJzsGYS6yZDmXvttFolU45BBt0IWCGFtRmlJs0l+yo7DvE2WC2jfyJAhZ+AVy3WFV57mimGQNUTW1fIYrj8GyOv9/JQZf2Xi8kK0fY3q7+V8Qp4Rmxkka9Yz9mI9F/kvsKrBwKO0jQTqNlkr02M3ar4i8bQePTcu45nBEoCcHuWxJGr0K2g2PYVY/YsTX35882Tsx8Ji7bQ2CL4JaHRS5yWdbKPecfWa7kwHd7yvXylUaHPqpXSjEgQqzCGtNpX+0LhtztpC52CmEn6YY644DWYjeAwRXwJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 SA1PR15MB5000.namprd15.prod.outlook.com (2603:10b6:806:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:18:03 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%6]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 06:18:03 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: Junio C Hamano <gitster@pobox.com>,
        Haritha via GitGitGadget
	<gitgitgadget@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] exec_cmd: RUNTIME_PREFIX on z/OS systems
Thread-Index: AQHa9KwbMNSmQOnoF0yTGqGuvZoQKrI1Ed9GgAXyuQA=
Date: Tue, 27 Aug 2024 06:18:03 +0000
Message-ID: <EF383555-7AB3-4253-9136-FDC798568B0F@ibm.com>
References: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>
 <xmqqplq0tur4.fsf@gitster.g> <xmqqa5h3p46t.fsf@gitster.g>
In-Reply-To: <xmqqa5h3p46t.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|SA1PR15MB5000:EE_
x-ms-office365-filtering-correlation-id: 4cc622ee-a5e2-47f4-6ad1-08dcc6600214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm5qSTh1QTRySWoxS2JsaHJpY2pVV05EQXlIaElyS1RIUjdrR0IrQkFZQldV?=
 =?utf-8?B?c0JudWtBdVEvOHcxRFY1VWpGNW1aYm9VcjZNaGJzOG8rN1dQaWtSZll6amw1?=
 =?utf-8?B?MUdGR1k4Smx2Q0IrSS9yd045N2RiUEZmM2dCQnBLMEpNZ3pjaTlEd1Z6UURl?=
 =?utf-8?B?cVRCY1VNczlQeFhNcngrVnVkL2FsQkw1SGlscHlhSU4rZXBzNXRjQ3R5aW1Y?=
 =?utf-8?B?Szg4ZzNqMmcxbHRyckZVc3B1ZkZuQ2trL3MrOXdWZWZKQkdaaWF3bXF1SnVB?=
 =?utf-8?B?ZFlXVXBMbWxnRVlFVGJVZHZheTRlbW1MQ1FMMmZybmFPV1lqNzFhUWJIRmx5?=
 =?utf-8?B?aEFYT2VCL3ptSjN5aGxxRU1TeDNYT2pqUXdMMzNHeGFFdHpubkp5Z20vQlk3?=
 =?utf-8?B?U3dCK0poWTkzajBZb0UwRDVQQnM0WGxGNVBFLzNOVGM3SFdQUnV6OC9YSkow?=
 =?utf-8?B?a3k1dkY3VytQd0RQL3VqakhQN1lFTjZ4dWlseTlLc2pVaXBXN09oQkRpREF6?=
 =?utf-8?B?NHFDTlpXN2xsU3p1Tm9pcnNUbmwzWnBBMlZvdWlYdFFXbllaYXlNVE9ZS2Zl?=
 =?utf-8?B?bVhER1p3OWxGbGtUdy94ZStoMXV6NWcvU00wS21najBnT25ucXZSK1dMVG1L?=
 =?utf-8?B?djAyVDM2U24zWEk4RjFmNlI5Rk5LcS9LVUZqLzd5aEJjNERCRnIyazRvT2xy?=
 =?utf-8?B?dENFWkVlMEFMTTVXUkRLZVNpNXlDVTZ0WFloblh3NUIzNmwrdnREZVJhamtk?=
 =?utf-8?B?dERTdDRIQjg0TWxXeit3dW5KSmJTK3RCU29BZ2dFTHB5aUgvSXlBTXpNM3la?=
 =?utf-8?B?VVkvaHVQcExqNWFsY203a3A4Zlh0enNMc3EyMDVCVFJ2NU9jY3o4MG5uRlp6?=
 =?utf-8?B?andHd2QrR3BuZVFzdDNUNlMvWnM4QmdtUWlRRFBRdmZoRDFHeEpaVXpxMDFi?=
 =?utf-8?B?RmhmTDZjSlRkQ29DRFhIYy9jbzJBZENZUm56ZEl2ZE9hMk51V096ZDk3YmNI?=
 =?utf-8?B?ZDlEZ3AyYkFwajlNN3ZCTjMzTS9MckNKRXhKMHlYNWVORmp5RXBIMlh2Uzkz?=
 =?utf-8?B?RmR3TEVMTUdYV0hkaWFXemY1ZTNWdWlPb2dKVUdTMjhVd2pUTUhpU2VjemRP?=
 =?utf-8?B?TXkydkJZWC9FTjRRWlBUdHc0K1FmbkdacThUcXJDWDBUR0ZMcllqdWVyUVg5?=
 =?utf-8?B?Qk9JcXZEZURWaVQ0d1JiMXdicUs1REpySEZsR2NPc3c4eHMreEpDanh6clBF?=
 =?utf-8?B?NDNiL1FXL2o4U2w5WG1yTEl1bTBuY3NXTHNBTFcrZkJRVGx5K0ZIb1liQTJ5?=
 =?utf-8?B?N3MyOVBydFpCbHc3dzJuVDFCZTRPQlgxcS94WE5Pd2R6aWJoTlNURGpGNzlX?=
 =?utf-8?B?Ty9hU0hRN25KU0RDRzlZenRoVEg3L2VsNTY2T1I0Mm1zdDIvU093N3pKR1o3?=
 =?utf-8?B?RVg4Y0RLMWk3aDlYc0FOQzhrbXhKWllDbENzQ0EvM1V4SlBlY2VrR3E3NEJM?=
 =?utf-8?B?N1cvYXdaOFEwNlZUcEhQTDhDWk03YnlJajV1RDBXQnJ5SnIzL0FmMnVaRnJ3?=
 =?utf-8?B?WWpLSXlKcU9lMEpLak9FZnRLR2ZyblQzMTZ3SWJ2KzZUc29rd04rMXAyNXBJ?=
 =?utf-8?B?cDMzZDRpa2RlY0J3cnd3eXRqNXI3UjRzWkZRRW1YNXhMY2U1TERPcnRCcnpU?=
 =?utf-8?B?bVEySlk4anQySVUzYjd6Z0hIc1B5SmFhYnU4YUpteUN2a0UyUW96RGxESXNN?=
 =?utf-8?B?Y0hUaGJqTndsTkZGSlljU3ZrZEtwM1dERVZzbVRFL2Fybzg4U2tMWXdYaWRF?=
 =?utf-8?B?MTJFdVhhRTJSdjYrRExIVGdnMk14NGgycXJqMW0yenhIWGlDR3hscm9yWXVO?=
 =?utf-8?B?WVhLQURROFpGQ1U1TkpjdXNIZ0x1b0ZrNkZQY092S1JmU0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlVOemNrK0RWTy9NRlZCaVdsTVIxTWxUVDJrbWdpTUZMTEtUcXpXcmFsTEpq?=
 =?utf-8?B?QzRVYy91aXdVTk1mN1lVRVhSalRJNkhPM2ZyNUtsUld0Z2pBMmRTTVNwUWRZ?=
 =?utf-8?B?QjNJUkMzYnhUM2FCOVpUcGlWV0xrblZHYWcwSFZsTk4wcnhHOEc1MndvSCtD?=
 =?utf-8?B?TUdCZkhJbHVmUDV2ZktHVVFNVXUwbmpCSjZySVZXQnN2Z1c3YWk0dVpwMG5D?=
 =?utf-8?B?WTh0d2d1Q29nNTJHTzRjblBVQUdxbWJURkh5b3JPUHFNRU9iTWl2UmMrUlZR?=
 =?utf-8?B?K0hoQW1tODdCUVpBTnUzRXViSW5OVkhMd1BaN0JKQWJoVURIbGxwVFRqVmF5?=
 =?utf-8?B?KzM5QnVvTE9kQlU5TG5kRVdqbXM1Um5JU3hhSmVpV1lBSVFrNWMreEdYbkl5?=
 =?utf-8?B?NkI3ZXcxTTJsTlUyQnQ5MWcvVWxrb2NGbW5VdStaTU9SRFlZdWNhNlRCUURK?=
 =?utf-8?B?V1M0dDNDVHNXVUx0QUdJRjhqYTZFbE13ZlJndDM1OGxaeGtYMGlvWmk3QkZ3?=
 =?utf-8?B?VXNSLzl0N3JGUVk1VGptdWtlRjJEd3pSYUQzT3VPeUVvd0d0YUFXdTc2QmlZ?=
 =?utf-8?B?MTNUdEpEa2MybFY4UmFFaEVZRmtORUdSUktjanNEZVAwazJVdFhHbHpjbTZo?=
 =?utf-8?B?cVREd0xkZzlzaG1yWWIxeU4zaldoWUVIOUE2TDRsS2hBeGtMQlRqOEtITm1L?=
 =?utf-8?B?WktNU3loU3VpcnRIandodFEyU3psbHQ1MjlXanhJZjNNMDFFV3BXYXorNUNG?=
 =?utf-8?B?L2hOV0lVUWhvNGhoNTlFWmM3QjFIMEs4UHVBOUdnbEtHRUtvRENHL25yNHcv?=
 =?utf-8?B?ekZENlhFdXdzK3VyYzViWDVTZUtUV0NzREdzUGlEWHg1Y3RtTEx6REY5TnA5?=
 =?utf-8?B?NFIrSEsxTWxmdnN1VmtJVlcvZ2tEdjkzOFRBbHFjNFlmVGFoMUJEM0VaTDI3?=
 =?utf-8?B?TmN6VFI1RDFkdFN5d1kzaHdic1p5VU4zSWZIVEg4Ty8wNVpaMy9RYzE0TnBO?=
 =?utf-8?B?Q1BVeHQxRDMzRzI4ckJTZXFRRWxHcmQyMlFvR2NvakRSMFBIOWc5YUtqbHVG?=
 =?utf-8?B?QjRlTTNOK1dBSGFsTEdkUGNlR29uU0luK0RwNFZNeS9XMlpCWDRZbEdFemFw?=
 =?utf-8?B?SkVORzFLbHhVNldSbDRZelUzRXI4aU9Pb3ZvTmU0Y1Z6T2EyZHgzbU84V0xD?=
 =?utf-8?B?QStGckpESTE5SlJ5Q2s0Y041a1REOHNCTzNySHFESDZnNGdobXk3MkJHb0V1?=
 =?utf-8?B?YmlSU1pWSEQ3NGZZYnd1VWpBRnFJSlJNKzAxYmRLMURva1E0TWd2elpuQ2hY?=
 =?utf-8?B?YlBRNWFnTHVDQkdndERXd0JTRzg2ZGJSdTlhMWlpMlB1S2wzM3dBbVhiTXYr?=
 =?utf-8?B?Nk5kSWQvL2RYaFRlMWRqS2E0Y0lqTGd3M2FTcXpjRERRMUtxODVxaEgzR3pS?=
 =?utf-8?B?UmdWLzlYdExoZThYR1BUdGExR2srT21QV0RHZ2FBZDQzZWsxWVdZUmdWa1o5?=
 =?utf-8?B?Z1I1RW9jRGhCR2M3cElGd29MaUJzQzMxVUd1WmxNWDFXQ2g5dTFMQ1hvc2xl?=
 =?utf-8?B?cktLVERrUk15THBUYlhFbzdQZFhIYWUyS3BrY1RqWXFwRFBvdHREQ2ZRMitr?=
 =?utf-8?B?UFdiNEFHcXE0cC9CMkQxdFM1L1dja25abm9XNXJabEh1bVVrSWx4SWNYekdz?=
 =?utf-8?B?c3J0NDZNbndvck10dXZIK0hQbjdERXZ5QmFvRkU5WkJzYU9pcC94M25QUnpY?=
 =?utf-8?B?YWFrWU1idlF0b2tmSXY5QXlmcGYrdlM1c2lJRXcyYVhVM1F1aGcyWVFLZ29r?=
 =?utf-8?B?dktVWjFlUGEwSWpFNWxqODcwL1R5alA0ZCsvMjIrSTNYR0dlYkNIcTFYSWZn?=
 =?utf-8?B?bHRVTkNVaUtXS3BDa1IvYzhXQzlHT3VuRWVyQThnTEFiUHcyWHZhQTlUNUt5?=
 =?utf-8?B?cDF1MDVsVm1YQzJBaU5pWnJSdFBSUjVkRTl0VWxaUjZMZVphVk5MeW51bzI2?=
 =?utf-8?B?aVlKQjNoeXJvcmY1WUxEYjRTbmNKVE9TTFpPQ3FVcmwyUitXVDQ1M2pNcEQ1?=
 =?utf-8?B?TEdsYk1VaE9DbFpWdlBkeHdyT21qV1hQeUpXUVJTTENMelh1UTB4Z2NmR3Z5?=
 =?utf-8?Q?xgikbud4DOHNtxBJ1krpCX9Dh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC1316DB8D596C4983181963176889ED@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc622ee-a5e2-47f4-6ad1-08dcc6600214
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:18:03.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sEQ+fU+7fBVdz8ZfGf3bGaz9XZ3c3n24u/3TE3b6g/e/TC0+xorv2/0NZ3wHqxeYw+r5xiv31SJNsKU2L32aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5000
X-Proofpoint-GUID: FZoX_ImWS6NQqh3PO-2ts3X_N6mtTBow
X-Proofpoint-ORIG-GUID: 3ZEk2XL-h2OXQwIijSxhAEmDlswhDKMR
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] exec_cmd: RUNTIME_PREFIX on z/OS systems
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270044

SGkgSnVuaW8sDQoNCkkgd2FzIGF3YXkgZm9yIGEgZmV3IGRheXMgYW5kLCB0aGVyZWZvcmUsIGNv
dWxkbuKAmXQgcmVzcG9uZCBzb29uZXIuIFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIGFuZCBhY2Nl
cHRpbmcgdGhlIGNoYW5nZXMuDQoNCkJlc3QgcmVnYXJkcywNCkhhcml0aGENCg0K77u/T24gMjMv
MDgvMjQsIDEwOjI4IFBNLCAiSnVuaW8gQyBIYW1hbm8iIDxnaXRzdGVyQHBvYm94LmNvbSA8bWFp
bHRvOmdpdHN0ZXJAcG9ib3guY29tPj4gd3JvdGU6DQoNCg0KSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tIDxtYWlsdG86Z2l0c3RlckBwb2JveC5jb20+PiB3cml0ZXM6DQoNCg0KPiBU
aGUgZm9sbG93aW5nIHNob3dzIGhvdyBJIHdvdWxkIGZpeCB3aGF0IEkgZm91bmQgYW5ub3lpbmcg
d2hpbGUNCj4gc3R1ZHlpbmcgdGhlIGV4aXN0aW5nIGNvZGUgdG8gcHJlcGFyZSB0aGlzIHJldmll
dy4gTm9uZSBvZiBpdA0KPiBzaG91bGQgYmUgcGFydCBvZiB0aGlzIHRvcGljIChldmVuIHRob3Vn
aCBpdCBjb3VsZCBiZWNvbWUgYQ0KPiBwcmVsaW1pbmFyeSBjbGVhbi11cCBzdGVwIGlmIHdlIHdh
bnRlZCB0byksIGJ1dCBzaW5jZSBJIHdyb3RlIGl0DQo+IGFscmVhZHksIEknbGwgcmVjb3JkIGl0
IGhlcmUgb24gdGhlIGxpc3QgYXMgI2xlZnRvdmVyYml0cy4NCj4NCj4gVGhhbmtzLg0KDQoNCkkn
bGwgdGFrZSB5b3VyIHBhdGNoIGFzLWlzIGFuZCBtZXJnZSBpdCBkb3duIHRvICduZXh0Jy4NCg0K
DQpPbmNlIHRoZSBkdXN0IHNldHRsZXMgZnJvbSB0aGlzIHRvcGljLCBJJ2xsIHNlZSBpZiB3ZSB3
YW50IHRvIGRvDQpmdXJ0aGVyIGNsZWFuLXVwcyAodGhlICJob3ctYWJvdXQiIHBhdGNoIGJlbG93
LCBwb3NzaWJseSBhbHNvDQpyZW9yZGVyIHRoZW0gYWxwaGFiZXRpY2FsbHkpIHNvIGZvciBub3cs
IEknZCBsZWF2ZSAjbGVmdG92ZXJiaXRzDQptYXJrIGhlcmUuDQoNCg0KDQoNCj4gTWFrZWZpbGUg
fCAyNiArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiBleGVjLWNtZC5jIHwgMjAgKysrKysr
KysrLS0tLS0tLS0tLS0NCj4gMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMyBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBjL01ha2VmaWxlIHcvTWFrZWZpbGUNCj4gaW5k
ZXggNDFkZmEwYmFkMi4uOTEwYWVjMDk3MyAxMDA2NDQNCj4gLS0tIGMvTWFrZWZpbGUNCj4gKysr
IHcvTWFrZWZpbGUNCj4gQEAgLTM3MywyMSArMzczLDIzIEBAIGluY2x1ZGUgc2hhcmVkLm1haw0K
PiAjIFBlcmwgc2NyaXB0cyB0byB1c2UgYSBtb2RpZmllZCBlbnRyeSBwb2ludCBoZWFkZXIgYWxs
b3dpbmcgdGhlbSB0byByZXNvbHZlDQo+ICMgc3VwcG9ydCBmaWxlcyBhdCBydW50aW1lLg0KPiAj
DQo+IC0jIFdoZW4gdXNpbmcgUlVOVElNRV9QUkVGSVgsIGRlZmluZSBIQVZFX0JTRF9LRVJOX1BS
T0NfU1lTQ1RMIGlmIHlvdXIgcGxhdGZvcm0NCj4gLSMgc3VwcG9ydHMgdGhlIEtFUk5fUFJPQyBC
U0Qgc3lzY3RsIGZ1bmN0aW9uLg0KPiArIyBXaGVuIHVzaW5nIFJVTlRJTUVfUFJFRklYOg0KPiAj
DQo+IC0jIFdoZW4gdXNpbmcgUlVOVElNRV9QUkVGSVgsIGRlZmluZSBQUk9DRlNfRVhFQ1VUQUJM
RV9QQVRIIGlmIHlvdXIgcGxhdGZvcm0NCj4gLSMgbW91bnRzIGEgInByb2NmcyIgZmlsZXN5c3Rl
bSBjYXBhYmxlIG9mIHJlc29sdmluZyB0aGUgcGF0aCBvZiB0aGUgY3VycmVudA0KPiAtIyBleGVj
dXRhYmxlLiBJZiBkZWZpbmVkLCB0aGlzIG11c3QgYmUgdGhlIGNhbm9uaWNhbCBwYXRoIGZvciB0
aGUgInByb2NmcyINCj4gLSMgY3VycmVudCBleGVjdXRhYmxlIHBhdGguDQo+ICsjIC0gZGVmaW5l
IEhBVkVfQlNEX0tFUk5fUFJPQ19TWVNDVEwgaWYgeW91ciBwbGF0Zm9ybSBzdXBwb3J0cyB0aGUN
Cj4gKyMgS0VSTl9QUk9DIEJTRCBzeXNjdGwgZnVuY3Rpb24uDQo+ICMNCj4gLSMgV2hlbiB1c2lu
ZyBSVU5USU1FX1BSRUZJWCwgZGVmaW5lIEhBVkVfTlNfR0VUX0VYRUNVVEFCTEVfUEFUSCBpZiB5
b3VyIHBsYXRmb3JtDQo+IC0jIHN1cHBvcnRzIGNhbGxpbmcgX05TR2V0RXhlY3V0YWJsZVBhdGgg
dG8gcmV0cmlldmUgdGhlIHBhdGggb2YgdGhlIHJ1bm5pbmcNCj4gLSMgZXhlY3V0YWJsZS4NCj4g
KyMgLSBkZWZpbmUgUFJPQ0ZTX0VYRUNVVEFCTEVfUEFUSCBpZiB5b3VyIHBsYXRmb3JtIG1vdW50
cyBhICJwcm9jZnMiDQo+ICsjIGZpbGVzeXN0ZW0gY2FwYWJsZSBvZiByZXNvbHZpbmcgdGhlIHBh
dGggb2YgdGhlIGN1cnJlbnQNCj4gKyMgZXhlY3V0YWJsZS4gSWYgZGVmaW5lZCwgdGhpcyBtdXN0
IGJlIHRoZSBjYW5vbmljYWwgcGF0aCBmb3IgdGhlDQo+ICsjICJwcm9jZnMiIGN1cnJlbnQgZXhl
Y3V0YWJsZSBwYXRoLg0KPiAjDQo+IC0jIFdoZW4gdXNpbmcgUlVOVElNRV9QUkVGSVgsIGRlZmlu
ZSBIQVZFX1dQR01QVFIgaWYgeW91ciBwbGF0Zm9ybSBvZmZlcnMNCj4gLSMgdGhlIGdsb2JhbCB2
YXJpYWJsZSBfd3BnbXB0ciBjb250YWluaW5nIHRoZSBhYnNvbHV0ZSBwYXRoIG9mIHRoZSBjdXJy
ZW50DQo+IC0jIGV4ZWN1dGFibGUgKHRoaXMgaXMgdGhlIGNhc2Ugb24gV2luZG93cykuDQo+ICsj
IC0gZGVmaW5lIEhBVkVfTlNfR0VUX0VYRUNVVEFCTEVfUEFUSCBpZiB5b3VyIHBsYXRmb3JtIHN1
cHBvcnRzDQo+ICsjIGNhbGxpbmcgX05TR2V0RXhlY3V0YWJsZVBhdGggdG8gcmV0cmlldmUgdGhl
IHBhdGggb2YgdGhlIHJ1bm5pbmcNCj4gKyMgZXhlY3V0YWJsZS4NCj4gKyMNCj4gKyMgLSBkZWZp
bmUgSEFWRV9XUEdNUFRSIGlmIHlvdXIgcGxhdGZvcm0gb2ZmZXJzIHRoZSBnbG9iYWwgdmFyaWFi
bGUNCj4gKyMgX3dwZ21wdHIgY29udGFpbmluZyB0aGUgYWJzb2x1dGUgcGF0aCBvZiB0aGUgY3Vy
cmVudCBleGVjdXRhYmxlDQo+ICsjICh0aGlzIGlzIHRoZSBjYXNlIG9uIFdpbmRvd3MpLg0KPiAj
DQo+ICMgSU5TVEFMTF9TVFJJUCBjYW4gYmUgc2V0IHRvICItcyIgdG8gc3RyaXAgYmluYXJpZXMg
ZHVyaW5nIGluc3RhbGxhdGlvbiwNCj4gIyBpZiB5b3VyICQoSU5TVEFMTCkgY29tbWFuZCBzdXBw
b3J0cyB0aGUgb3B0aW9uLg0KPiBkaWZmIC0tZ2l0IGMvZXhlYy1jbWQuYyB3L2V4ZWMtY21kLmMN
Cj4gaW5kZXggOTA5Nzc3ZjYxZi4uNTRiYzdlZDMwNCAxMDA2NDQNCj4gLS0tIGMvZXhlYy1jbWQu
Yw0KPiArKysgdy9leGVjLWNtZC5jDQo+IEBAIC0xMDAsNiArMTAwLDggQEAgc3RhdGljIGludCBn
aXRfZ2V0X2V4ZWNfcGF0aF9wcm9jZnMoc3RydWN0IHN0cmJ1ZiAqYnVmKQ0KPiB9DQo+IHJldHVy
biAtMTsNCj4gfQ0KPiArI2Vsc2UNCj4gKyMgZGVmaW5lIGdpdF9nZXRfZXhlY19wYXRoX3Byb2Nm
cyhpZ25vcmUpIDENCj4gI2VuZGlmIC8qIFBST0NGU19FWEVDVVRBQkxFX1BBVEggKi8NCj4gDQo+
ICNpZmRlZiBIQVZFX0JTRF9LRVJOX1BST0NfU1lTQ1RMDQo+IEBAIC0xMjcsNiArMTI5LDggQEAg
c3RhdGljIGludCBnaXRfZ2V0X2V4ZWNfcGF0aF9ic2Rfc3lzY3RsKHN0cnVjdCBzdHJidWYgKmJ1
ZikNCj4gfQ0KPiByZXR1cm4gLTE7DQo+IH0NCj4gKyNlbHNlDQo+ICsjIGRlZmluZSBnaXRfZ2V0
X2V4ZWNfcGF0aF9ic2Rfc3lzY3RsKGlnbm9yZSkgMQ0KPiAjZW5kaWYgLyogSEFWRV9CU0RfS0VS
Tl9QUk9DX1NZU0NUTCAqLw0KPiANCj4gI2lmZGVmIEhBVkVfTlNfR0VUX0VYRUNVVEFCTEVfUEFU
SA0KPiBAQCAtMTQ4LDYgKzE1Miw4IEBAIHN0YXRpYyBpbnQgZ2l0X2dldF9leGVjX3BhdGhfZGFy
d2luKHN0cnVjdCBzdHJidWYgKmJ1ZikNCj4gfQ0KPiByZXR1cm4gLTE7DQo+IH0NCj4gKyNlbHNl
DQo+ICsjIGRlZmluZSBnaXRfZ2V0X2V4ZWNfcGF0aF9kYXJ3aW4oaWdub3JlKSAxDQo+ICNlbmRp
ZiAvKiBIQVZFX05TX0dFVF9FWEVDVVRBQkxFX1BBVEggKi8NCj4gDQo+ICNpZmRlZiBIQVZFX1dQ
R01QVFINCj4gQEAgLTE2Niw2ICsxNzIsOCBAQCBzdGF0aWMgaW50IGdpdF9nZXRfZXhlY19wYXRo
X3dwZ21wdHIoc3RydWN0IHN0cmJ1ZiAqYnVmKQ0KPiBidWYtPmxlbiArPSBsZW47DQo+IHJldHVy
biAwOw0KPiB9DQo+ICsjZWxzZQ0KPiArIyBkZWZpbmUgZ2l0X2dldF9leGVjX3BhdGhfd3BnbXB0
cihpZ25vcmUpIDENCj4gI2VuZGlmIC8qIEhBVkVfV1BHTVBUUiAqLw0KPiANCj4gLyoNCj4gQEAg
LTE5MCwyMiArMTk4LDEyIEBAIHN0YXRpYyBpbnQgZ2l0X2dldF9leGVjX3BhdGgoc3RydWN0IHN0
cmJ1ZiAqYnVmLCBjb25zdCBjaGFyICphcmd2MCkNCj4gKiBhZnRlciB0aGUgZmlyc3Qgc3VjY2Vz
c2Z1bCBtZXRob2QuDQo+ICovDQo+IGlmICgNCj4gLSNpZmRlZiBIQVZFX0JTRF9LRVJOX1BST0Nf
U1lTQ1RMDQo+IGdpdF9nZXRfZXhlY19wYXRoX2JzZF9zeXNjdGwoYnVmKSAmJg0KPiAtI2VuZGlm
IC8qIEhBVkVfQlNEX0tFUk5fUFJPQ19TWVNDVEwgKi8NCj4gLQ0KPiAtI2lmZGVmIEhBVkVfTlNf
R0VUX0VYRUNVVEFCTEVfUEFUSA0KPiBnaXRfZ2V0X2V4ZWNfcGF0aF9kYXJ3aW4oYnVmKSAmJg0K
PiAtI2VuZGlmIC8qIEhBVkVfTlNfR0VUX0VYRUNVVEFCTEVfUEFUSCAqLw0KPiAtDQo+IC0jaWZk
ZWYgUFJPQ0ZTX0VYRUNVVEFCTEVfUEFUSA0KPiBnaXRfZ2V0X2V4ZWNfcGF0aF9wcm9jZnMoYnVm
KSAmJg0KPiAtI2VuZGlmIC8qIFBST0NGU19FWEVDVVRBQkxFX1BBVEggKi8NCj4gLQ0KPiAtI2lm
ZGVmIEhBVkVfV1BHTVBUUg0KPiBnaXRfZ2V0X2V4ZWNfcGF0aF93cGdtcHRyKGJ1ZikgJiYNCj4g
LSNlbmRpZiAvKiBIQVZFX1dQR01QVFIgKi8NCj4gDQo+ICsgLyogZmFsbGJhY2sgLS0gbXVzdCBi
ZSBhdCB0aGUgZW5kICovDQo+IGdpdF9nZXRfZXhlY19wYXRoX2Zyb21fYXJndjAoYnVmLCBhcmd2
MCkpIHsNCj4gcmV0dXJuIC0xOw0KPiB9DQoNCg0KDQo=
