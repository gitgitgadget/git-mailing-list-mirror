Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE122EE3
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233113; cv=fail; b=ifMj/K5unJtwdIRKf3KajgBs0bGOtuYCvs4cHW+pWqJjJJZfRS1GX3BOUEnHafwtl6AT1WzuLTYlX81A42DUsLAYFOdGJ0AaWRITg4g3V6j5bxVHzbWDFTRhCJly8J7y+Xmgc6LK7U2t9nLdvb4vKq6Jb2kElq5etltOWoKVodA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233113; c=relaxed/simple;
	bh=iyqvZ3ItBKGZWTDjaPRE6+++lgSOwGpNxf7d4HI3lRQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LnQPj6Wcz+kVMF4HpJmEwVArfl58t3w1Y+86/f4NTophTqrBFU8aRwnIzzxFqz+IqGc0H5Gar0RsnjmSA1l9Dnpo6ObH01ZWd5yAT3IQrCcaBqoNJvINKosOxCKCAfEIOj88rEKWSJkX9VVhzEDKjRgv9Lnn12a0aCI/8Mg3goA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQUUKLWd; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQUUKLWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723233111; x=1754769111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iyqvZ3ItBKGZWTDjaPRE6+++lgSOwGpNxf7d4HI3lRQ=;
  b=MQUUKLWdd70iRIq87XXT6speldJmrVQ5Boc03mrBpNuJxBYCyuC9AGV4
   ZWd7kh8oG0vlw8o6U7oouXwrQitw2O+XNbx6YTSD74QVNmS40tz5Uo2bG
   4fobVQ5uBvdxhkfmlfszUpFCjymACOhRyi6RN5D0oSx1h+Ml2T291ls+s
   uPj52PHvw8qVQmwGUOi3TN268dBczkeddgi1YrIbSE0xk/riXZHT+pQ9m
   9PowcUiN9NUEjwF/bwtHEy/MsaRA7w1fzUG3f5SbBuokq96YT3d4oGsh2
   EG6L8ZHvlSa/Thalg32qAh/FI1oRCRZwEicXfEdk9l/Xef/Lh4HnppnAd
   g==;
X-CSE-ConnectionGUID: L0QP9NncTGCDiPinUHuMxA==
X-CSE-MsgGUID: anBAQW27QYKvA9ZfgkgC9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="43941782"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="43941782"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:51:51 -0700
X-CSE-ConnectionGUID: B4MYaGa9S7WhQDAhABknDQ==
X-CSE-MsgGUID: 5CC7rkAOQqqH+cho0JAujA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62313859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:51:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:51:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:51:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:51:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZbxNDRtZH+6oPuKttEh8iLkRW+gbwBFajjSg4EpZqmAWeBRDzVKK/AhjHFDUbCzt+c8n07dQ0p3sTTVW9hUePCwVW6jHPfPS3lUuD/+xMpaZa3S8qXVYxC4oogiyGIeGFzfsYHFNTu1Sq8PuzkJc8IW7C4ywOuoHVY3oZ0Q1TJlufeKjFEBlfPKya/RQFjQmVZ+uvP9dXKn5WX82GrQZJjEXBSkGeg3kRg8YO6GlXnEDt969yRSuVMxrITdZsvkAgf+OOMTsMmsbhFlYarg1tzDquD6KM3ei+xKuia9QgrKzhNnIlSHv2yacryGnI6evGaXpLbP1T6dEYVPXwKD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUlmOzq8GFUSHX/Tvk2tCP/QRD9GKli0IRDAfb6MnuE=;
 b=p+x69ptIFMQ7SMC4eOIZHXuud2mcTXWWeR001HMUioamL+ey9YoNOVKMN1vEYED0SP0FoFYfamX3z1IyHBh3lUj+6DyHrTG0GGQOYDJpxJ1spZO9/s7GDajPcwPUiMzMnuHHGa5SM7xUqe00yXqUbFYd+Cjqt/BZ5+CX+lpKU0WD24GdOQnP5vPIFaExfxLU4R0C4vliLikLhb4WMXfhca8pYNKhhHUDUu7EqJmezZydMSzWk59h+T2VbvIbmUfCZzJHutQjSf7e4+8WRyIzwkvhIp8PD660d1FQ0NTnIjtkx0Jha1kvzx2S6RhbvxvdCzZfpnDF/6xkM+a58Gfehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 19:51:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Fri, 9 Aug 2024
 19:51:47 +0000
Message-ID: <5ad39a07-a2d4-45d2-9b5d-0180cb903801@intel.com>
Date: Fri, 9 Aug 2024 12:51:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to translate
 aliases
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Konstantin
 Ryabitsev" <konstantin@linuxfoundation.org>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
 <20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
 <xmqqttfufzkj.fsf@gitster.g> <328fb497-d16e-4af1-a816-7b4aeb531504@intel.com>
 <xmqq7ccpcx9e.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq7ccpcx9e.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:302:1::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: a05afe15-576b-461d-78a6-08dcb8acb3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHA1T2ErTjNiUEpQYVRiTStkSllrSUV1YXBhVkVGemNuenpZNm5YalE4SlZT?=
 =?utf-8?B?MFBic25GZFFFZ3BKWGRBUVA5ak45ZUxmUHVWS2RSZW5qSHhxNjJsV2ZXeHhv?=
 =?utf-8?B?clBFZEdyTHJIMHJwRm9lMHFmZmU3cE80SXhjOUk1Zi8zWVZibEpzSnVxcDNh?=
 =?utf-8?B?RlN0a1IyOHlTalEzbFRUOG9qREVkdFVsODNGUTBFb1FtNW04RGRZUGliUkRG?=
 =?utf-8?B?bDhxNy91dHBlc09odGlTVFZvamdKb1I5ZUFIY0o4TDkzS2paSk0yWEZFQ2s0?=
 =?utf-8?B?SWJGVTBzeG1xQkV4ZGRWb0VheWtUSGRaMGJiMDVHRzdKU0JNdWZ4MVZmbDBE?=
 =?utf-8?B?anhDT0VGaWhNc1Z0cU1yeXhiMDIyL2loeEdhaTJkOTlCeTV3RGlob1FuUSty?=
 =?utf-8?B?My92Qm84TWpNSjRyYkFoaXh0VFRsejc1R0YyQ1V5S3RHd0U4eHR1ZmhSaHFi?=
 =?utf-8?B?RjVwSG9NZFlJSWpTV3pvMlZScjZvZ1pwV2hxQktTZFNoQ2lCNFdiS2QvY01T?=
 =?utf-8?B?Nmk3RWtSTjdsWis0VEpNNkhRQzUxQTcvUVd1bUc2YUErbVMwb0wwWjlQdGJS?=
 =?utf-8?B?b0lURkJ4ZUpCdldhd0h5c1E1QlRDdEY0Q0hobGdHc21tWmhja3ZGckZkaWp3?=
 =?utf-8?B?WlBpNU5LRGNQYnBtSnpmZVZ5R1lEVG9OTVppR2RrU1lJUHp2T1ZTK05qZHda?=
 =?utf-8?B?QjQzcUt0YnYwcC9RdDBUNHMrUVVJOVZnTzZoKzJoUlVRaU5oU0U0a3pKcTh2?=
 =?utf-8?B?QlRHNC9yTlNlditDZzUrbTZrY3JKRUhXeWQ1TWNSUGxsOElQRlExYmFSUTg5?=
 =?utf-8?B?OGJTNXcvSG50cU5MMkdvRjY5SzI4SnI0RHBVaFBKdkthUm5IdmRFUWgzVzRP?=
 =?utf-8?B?dVUzU1IrR2RXelpkbGFUQUV3L2FJNU0wSnJ4WTBhdHJKRDhMaGZzbE5HOFhp?=
 =?utf-8?B?cEg3YnZpYy8vOHZpM3hDS2pncVhuUUpXZWprbXFLeTFMY1BVZk10L3NBaGUr?=
 =?utf-8?B?emdoS1REQ2lkWUptdURzQkRNSFZOcGYxUk1SbGxHOEJ3Ylp0emt6UFk2bEJB?=
 =?utf-8?B?Mkt4TnR5QzZ4SjlHMkk5VkFQdTZ3N1pGblFYNG8wSzlnY2JEa0swTmFPRlFG?=
 =?utf-8?B?eUJxWE9wQ05rWFpjZzVnN2x6Uy9TQ1BrTEo1a1BDdlNUSDQyaWNzckVQQ082?=
 =?utf-8?B?VEtMZFNMMnZ1S2QxL2xDeGNDVHpicWJQRDVobVJ5ZnY1MXdVSEVlQyt2cHBH?=
 =?utf-8?B?YUpjR2hDNExFWnQ4dmhBdFVKQ3ZlTmR0MDNHaXVNTUxVR2ovSG1obTZmYUJY?=
 =?utf-8?B?bmUrNE1sVXdiSXVuTFhocGJ3ODJ0MVZCcC9HNm1qbjMvQ2xSS3FRVWxWMmNk?=
 =?utf-8?B?YnR2RnZVM3ptRGZ0ckE4bFoxOWJRZXVpWis3aTZhUVBsTEpWVFRQbTY3OU4w?=
 =?utf-8?B?dS80YmRYNUFlM1ExWjlEVWl0L0RiT2R6cGJ3U2dEaUJ5S3V5Rk91T1FNaUxt?=
 =?utf-8?B?UnpkZTlvcXR4Vjc3cjdSTGZMNVZKZXExNHF4THpwZzJIMWpSbmM0SmFZbVdr?=
 =?utf-8?B?a1piSW04SHZYNmRGRjUxMzcwaTcxZUVuSFQ1WDcyNjBhWlh1SFRuMVU4dVJj?=
 =?utf-8?B?bGxpYW13ZjBVczlCUmpKL0RxY2tKWUwwUldCcjhLazBpWG5YM0srZXloR1Rq?=
 =?utf-8?B?LzRIME9Nd0dyZEw2VWNvTVVURDk3cVJybzVncGorQUpOVGRIb0pMNTZrV1Vm?=
 =?utf-8?B?cS9NUjNBODY2OWVIRkkwa1lnczJTMVBmOUdHRjIzTVcwNVBjYUl2cm1YUG1L?=
 =?utf-8?B?YUpzQXh2WDdQbDZNREs4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUErYnM4K1JDa2JYQXk3KytvMkJPRjZVUHFSZ3ozWFVMdkFuVG5EamNwbkgr?=
 =?utf-8?B?YzJlbXVhOUE5MHJPMzh1UEx3UkJxMUFkUXJVb0dMYUhidXJBWFN2RzdaTTNi?=
 =?utf-8?B?bWxXdnU5WHQrUHF6cjlFdklOVGRqdTUzcDdVVTkySGgzWGRrS1ZIZi8xdyt4?=
 =?utf-8?B?bU1VeGxEenkxWHRneEwrQm1SN2lac0tFMG50OVMyK1ZvalNuSnJDcS92OEpx?=
 =?utf-8?B?aEx4eDN3SDNuK2FzQ2dkeFV0SnNraHhoc1ROa2g0aGtjVWR1K0lqUGVNVnpo?=
 =?utf-8?B?ZUdNWU9Gd3laWUdFWGt4NmgvZjdSdWxVdmJZN0ZoS3R4VVNPdGRiY1ZYb1NV?=
 =?utf-8?B?WTVJNjVOVGFCODY3UTQ0WkwzV1F3N0pTVkhIWUVXR2ZMQ0NBbHY0UU1IcE8v?=
 =?utf-8?B?WCtoUTNDRkNKMDNQTXZPMlpaeThtNE9SNUluRSt4Y2RpenNYU1RleWhOWHp4?=
 =?utf-8?B?R01HREpVa2FDTjdKRWRsMnpiS3BYcFBkcnZEbTVTNG0yZmZHWmNMbFkzVENi?=
 =?utf-8?B?QnNxZHI3eFV4eXQxT21qdWtFNVhlazhtRVp0clNibHlHUDByMnMxQ3hYalVV?=
 =?utf-8?B?OUVvQUN3SjB3WG1rWUZ2ZGw5V1p4UTQxNUdiWklqaEpKdWE0MnVhVVV3TlBI?=
 =?utf-8?B?eW1nVzBJTHFmc0VBZXRjUkhTbkh6cTVub01TSFhEUmFjdDdUNGE1TGh2aXdB?=
 =?utf-8?B?RTI4ZjNLaTdvVUdhMi90U29SRHZrOUdLTzhIUmNOaEl2TkhOOXAwUDZjS1Iv?=
 =?utf-8?B?L2VVckVCN0FwUVgyL3hTK091K1NDa2wrYkhPdnlPSElMS0xwek5LVnAvOUJv?=
 =?utf-8?B?M1VXaTRwYWtkVDJoN0FyOW9FdVRDcUM2cFFKVHh5UUNVVEw0bE5VbVFCM3N1?=
 =?utf-8?B?eDBCT2sxK1RVNG5Lc3VLKzE0azdvWkVQZitwei9tMlRFMTYrcXRRUTJpS2d5?=
 =?utf-8?B?QjhCcWI0RkNMNmFmM1lRMmJPUkpYOVA2aytRWGxoQ1FPV1ZaVGpxQ1IxVFJJ?=
 =?utf-8?B?U3J2WUU0ZVdjT2Q2OW9ROThOTTNOTEJwV285SnQwaW8vSGhnTG0yK2w5UTMx?=
 =?utf-8?B?WnJ3c3FhZTFiVzFZaE5udklyb1lMNG1xZFgxSFQ2UlYrNXBBblVyWmYvMXcz?=
 =?utf-8?B?bWNpbHR6ZWU4WVNYeEY2OWZ2c2loa2Z6Z2ZrckE0K0xBVG9IR3hpVFBnTHlX?=
 =?utf-8?B?dVQzK21QaURYWE9rQWhPbVRPcXk2WjI0aWNibTMzL2ZpRGRJN1RMYWxKTU5z?=
 =?utf-8?B?dlFIb2NJVGgwWFJwdzdKWExRWE4zcElzVXM1STJkdW16cXhYb1UwR2ppNys3?=
 =?utf-8?B?Y1Z6TkZQL0h6ZmpreVA5K0dpV2VrV3ZBR0YwbitTeWlEY1B0b3JvMW5NOUt6?=
 =?utf-8?B?Y2l1VWpyS1NiOVR2amxlWFRxbEVjV3ZJMVRGQVhiN1lza0s3bVZQamd1dHox?=
 =?utf-8?B?c1pHQkczV1VOVmI3dGxhRUZXeXo1VHZ3V3FwbXNQakJyRmxLSWd5VGwzd1J3?=
 =?utf-8?B?WmNYd2JRU1VsaUUvd2d2bHpoVVBqb0dPbmQ3YlNLVDdhS2FGRTFmL3N2TEdY?=
 =?utf-8?B?UVYyZ2VyZTNpaHNsYk8xbStKMkxGME1zMzZKK09LSlpLSHhKelk1dXlpdThL?=
 =?utf-8?B?cmRkRStacktrZ0hZR2doQ0kzRmV0dEp5Q0p1eGkzdThOZU8zTnIrRml6MUhs?=
 =?utf-8?B?QUZ6UVpxdDNYZEh4YmxCVDNFSzlQVjFmOGlya0Q2MGJpdHU2bkNtcE41U095?=
 =?utf-8?B?YWdlZE9tRTRyLzJhRlVVRjMyS2Y3TDlhbElxNDA3RlAyTml6ZzBoVE95MjRT?=
 =?utf-8?B?eGtxdnZRc0pockxSTmhuTTZCL1NnUmdSejFaQnRqMXhDM0d1L2RqdzNyemdm?=
 =?utf-8?B?dXE1RG5nUGRabWF3RHNIMnVaeXlIVkpLSytUV3RSVUpmZUpIUE1JaVhEYzM4?=
 =?utf-8?B?bGpadzEzbjc2QkpWKzVBcXNnaDBKVUpGc3B6WnVNZWQ0ZHlYakdTazkwQlJV?=
 =?utf-8?B?Ly96dm5qZGNMaENDcDlRbnpNaWtaTHZDWEs4dkp5UHA5UGE4ZW5lTjhEQWQy?=
 =?utf-8?B?VW9paEdzYllFRnNydXZiTjZEUGRaVkJiZHV4MzlFOTUzbHI0bzNOSVlpVnQ4?=
 =?utf-8?Q?ZXNBPYWt1B1okOXj0/bTx5KPo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a05afe15-576b-461d-78a6-08dcb8acb3c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:51:47.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z613xI8PrE8FzPOLg74thQvqjFyimV46Iwq9kNK9VdGr0whTJURfPG0Q8t+70zQBoXeNcMFxlNqvd/QVNPzI02w1lfLjuooi2DbB8LRsd1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com



On 8/9/2024 12:27 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> Dump aliases handled this by checking @ARGV and immediately bailing if
>> there were anything remaining after the call to parsing its inner
>> options. This works but does not work for --translate-aliases because it
>> needs to treat all the remaining arguments as aliases.
> 
> When GetOptions returns, shouldn't these "remaining arguments" be
> visible in @ARGV and you can iterate over them yourself, perhaps?

Yes, that is essentially what we do by skipping the call to the
GetOptions for the main set of send-email options :)

We still need to go farther down the program in order to call the
functions which parse the alias file and setup the alias map.

I guess we could re-arrange the code so that the alias bits are handled
before the options?

We also probably want to reject other option-like arguments which
ideally we would have GetOpt::Long handle for us... I think if we
disable pass_through initially in the identity/information options and
then re-enable it when we call the second GetOptions that might work?
That could get tricky...

We could try to implement scanning for options ourselves, but I wouldn't
want to break things like "--" to make it treat potential option-looking
fields as aliases...

Or we could completely change the overall behavior to do something else
like take the aliases on standard input instead of the arguments?
