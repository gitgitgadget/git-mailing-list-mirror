Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BA25CC46
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780754; cv=fail; b=J2Mak6DyrnMs6bPsn1cxPd9TsAYWlrjTG6a+0/fq0Uj/7WnhtmILdrCeorMkF3oiEVJ31CJNCx/Tcb2j60ARR4XLQqGO76Ysv+iDlQhEcEEO0KsPc2r3vCxBjO3jnBNLx0UR2lRdJCLDn2uu3WvraGQCOCBMSurwSMCJN22HZ2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780754; c=relaxed/simple;
	bh=nrCa0ASUBP43jEakpfWyzTkhTjQGxZkGE+1EO7p38ZQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVl8Zgp9uBov7iJ2/0cBBqZG/Mn58i6qg5H13P5YUyTLeTligccKSwpV20hxCiUfNaBLBP4eE9W9h0JprIPS77SH0VCeCK1sF1dKHKY2z+Y0Z+IJIgaycaC97kgkNVbPNsxNWTqDVMHcZJXNROx1D0COYXnQSiry0b5KsMGVbfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpACrk7j; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpACrk7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780753; x=1779316753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nrCa0ASUBP43jEakpfWyzTkhTjQGxZkGE+1EO7p38ZQ=;
  b=MpACrk7jnX+uWLBC++QdY1KEJu1X9BVJKI6Rn2gZLqURoficseA+ySk3
   Mbis4SK4uKIwjfr9lPg4Rn5ZNcBkyglwnLB++6UE9hQTST3vJK4qMHBow
   ALtlv0ilIKkOHk9P3MP+wR6g+/oxYz0YOZtkgqO4KtxpVst2qHybMEsF2
   N8gDG0RRDZKxYZhu50jPwl9cmKPxeTKYMfHLyILD/0VyhbCVZKOV7nXKL
   z9sm0Zx9jaJi1J6mubwhO4UaVMEkOrJtIHcfvGtVgilKtcDboG52a7mkK
   UZ9mbHoO88DGZStbFieKl8uQsegl6snRS3C1zQFFMtDdwnyk5n+RXn0mU
   w==;
X-CSE-ConnectionGUID: l1czC7+pS/G8Paietvd1WA==
X-CSE-MsgGUID: qKrncgcGS1ymJgOhVVU+iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52364211"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="52364211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:39:12 -0700
X-CSE-ConnectionGUID: gAaTUh3GQ0iUts7edcxhgg==
X-CSE-MsgGUID: MjyO8ai7QQCrLEF+HHI2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163110678"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:39:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 15:39:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 15:39:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 15:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvaTnmvwFHdzaF67PfPAIhtrG/VKwc3qFj41u+/u6HbZ6nQpcO0GAmPbRCYlVBz8rI7GOIyozX8m53AK31Hu/xu0axSYxWUgHGQp2J9gf4jxUMFZ3HxgldMpvD4k6E+ABMpyhqTextC3L5Mq9UmDA7i4ZmmivzyMM69va0n7J+u3vnv6Jfpj2J8IbNrZofB7kBmB8bTaxj4KANSzZhS6gITCn3SBM+Bos+CEi7w4rS1TAHR/KHbyd+ErEX7FeucV2W4p8bDDY0Qg6UTCieBoySXE4KyRPAxNCKoQV1y4CUOkuGL5bhJVPyJOpD4beibCrYN8cWHy7QpRVc6CQ2sEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMTM7BhzId8VzKNEivcD9i6XK4Uv/bAD96RCSysZC1M=;
 b=RYR71A9vWN29c1j/Z2/2vQNcKJeYZbAUoRHRchyVlIflEEw59+PI5NxQp072LJHYf34p1z0ua0Gic+T3WXkB7RtwwJMw/nAsrZGDMjihCsZNSeqbbg5o8wii+tHlZn1wwoI33mEOufs83TFouIPH62UR6wVZxDxB/ldARqM5f1IA+6L8mpJ6BvT2ynjZprppzswoizs5Nq4kHsGCI6ZHpshy3biRT8YYlppArmROxsYqBIPYBvEVvcBmffNPzmK8CVllt05hhvB2YqhPsRyeg51aEw0fX1RlP8UuZ+D7ghzDSJYCNKZH0J5E72ARADySGLAlclny7QWmOj9OTVD81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 22:38:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 22:38:26 +0000
Message-ID: <70e459b2-b80a-4de6-bf7d-47606b60608f@intel.com>
Date: Tue, 20 May 2025 15:38:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] pathspec: expose match_pathspec_with_flags
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
 <20250520000125.2162144-3-jacob.e.keller@intel.com>
 <xmqq7c2bl51c.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq7c2bl51c.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eeade92-361b-4fc9-2b19-08dd97ef08e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG03WkEyaENGbmRWQzBCb3Rkb3JqNXE5Um5aZjMrcXF5RlN6eklEak16b25P?=
 =?utf-8?B?L2p0dVNFa3Y5K2pRNTV6MHFsbFptSW9XdVByNzhTVGJzeGpRUTdXRmVOZ3g5?=
 =?utf-8?B?SEJ2VFJTSzRrVkd6MytTRndWOGNTOHk4TVIySHRUQ3JPYkk2WG1HWnNyU1lW?=
 =?utf-8?B?Z3o4ZUxBRTI5TEorM3B1Um9QbGF6eHptRnJEcjZJOEFOQmFiQzR3R0hYcUtL?=
 =?utf-8?B?bW9EVEhYL1Q2L3NPNzRDa3dGTi9PMUE3b3pzdGFINGlZcXVxL1h2eEJ5ZTFh?=
 =?utf-8?B?R2wwc0dIVW0wbjExRnZjemlpL21Ma1hJaFpQRHhpUHlERXZ5MGIwNDlMTjg1?=
 =?utf-8?B?WGFwZXc5SXVYRWRQTzYwTzZ0U1lrUzhMWGRIVGpUa3NNWHpjUXF1VHpJNFVt?=
 =?utf-8?B?cW5sM2Evb1BqdTFqSmFuRFVrOUpIUDF5OU05b2ZteWFWaGtjYStObkNQQjNz?=
 =?utf-8?B?andJcngzLzF2RlNKWEREeUtqaWhicjRaT1htV1ZJVjFmNlVjRnAvTnhjeGow?=
 =?utf-8?B?Z0F4WHlrcDdGUHdlWExDTmprajRWTmJOc1o0dW1zcDFVOGZUUFBGVXFGWTRj?=
 =?utf-8?B?MGpxdXJwSFdzbDV0akk2RWl3UXhjb3BnbGkzWCtoY1VYV0wyWGppcGNnRkJl?=
 =?utf-8?B?WWV1cFRWTThVbGluVkpZRGY5RmlHVGR6NHBNWnhWOXJIc0hERzlDQVlFakhP?=
 =?utf-8?B?bjRITzNXZnJBVzhEYlFKRzA5VUMwbkxZUVcxZGxsRWRZbHA5c3Y2dGFyZ3l6?=
 =?utf-8?B?Q0NYdWtSRFBhUzBOK2hlMTFCSWQ0ckJtVGZZSWFHUzNrNCtxaEJFU2FvSTRU?=
 =?utf-8?B?WEM5V2owOThFc09NblNaV1Zzd2F0cWxFaGJ2M1p4djFYSTB4Q1p1VUZxN2pv?=
 =?utf-8?B?OVUxTFhic0xFT1BGK2VzWnFITkNUbjJUOFl0WHVIQWhHRk10bGxVUFpIVG5o?=
 =?utf-8?B?NFUrSTlkenJSeUV2UlZGeUFHQnFnS0Z5dlBJdDVOdUtiaWhKZUlFNzRkbnBJ?=
 =?utf-8?B?K3grY2F3WEFYbDJheUM2eWF1Qm5kdFRWcndSZG4zdkZWYjJsQTY0MkFzcnpR?=
 =?utf-8?B?NDVCTW1NNTdRbVVVSndtV2doRlZtMm1jeXF2WTJtOTRXT0FvV1luU1UzQ1NV?=
 =?utf-8?B?Z1NHRkF4UzdaL0ZyTXNVYlMwLzVxcDZvSTRUY2FQcHFQRzVYMDRRZWw5VkY4?=
 =?utf-8?B?aDRKSHBnRmUxSXgyQ2hLSVRKK2pQN3Y3enZXUWxOZ0N1RHZHMDNzNDhiUkZY?=
 =?utf-8?B?M3FnMlJJa1lKaU9xUEpnQXEvL3pydWxob2RLZE1GYlAvSDAxUE0yTmhGbzdV?=
 =?utf-8?B?dFl0eUQyRTd3Sk9WOGlXNzVuV1ROOGdoRjMxMjRnL1ZLTHJ2TXo3N1dpWGZ1?=
 =?utf-8?B?VzgrRzlwVllvMkVJdjcvWFAyQllsVmp4RkFrKzU2SGZSNFdyR01xYVBySjlO?=
 =?utf-8?B?VEgyL0FVVTdNQ0JWaU5SZk9UbkFycXJTUDhqWUlYVlBqNjBVclZwUHJjRnhj?=
 =?utf-8?B?b3ZnY3poaWhKVk5JOExiZWhRVGdDY2Y4eUZ1ZzM4c01ZVEQ5RjhnV0pzMEl4?=
 =?utf-8?B?MEpNdWtxWkVFY1BMSExmdmRTNDNEaXpiaEw2Z21tYVZ6M3ZweFlTekhCdTln?=
 =?utf-8?B?Q2w2K1BDaEZSWWNOMVIramNpVFdvckp6ZWdobCtmTlRvZGk2UUxLSGgrM04v?=
 =?utf-8?B?UWdrK2hmVWU3SUpGdXJsS3BYbmgxbEhlZGkvdFpPUWx0OEFMcjhXdW9uYTJj?=
 =?utf-8?B?SVVDVjZ0cWUwSThiVEJOWVNUS2ZONGx0U3daakU0Vzk1YlVXNVAyTjE4cC9r?=
 =?utf-8?B?cWNMNmMrdlozZDJtTTNVZFhzWkFvM3I3UzdoS09vbmI3M1JzYVFqODVGUVFp?=
 =?utf-8?B?OGxRMk8yV2h0YVI3eEZKTnhKVGdJWDFNMUtjRmJBcmlOaFlvQWFPOFNvaGYx?=
 =?utf-8?Q?5HAnRENBQ18=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dxLzJveHJmdHBBc3Y0UWtUSml1ZUxqaXBCdUY1N05sUTZrNldxRy9jMFhL?=
 =?utf-8?B?WHF6dWd1Vnk1cGxGWmdVS2pzRERndGcvK0lmRko0akVaU2hseTV6eFBGYmZk?=
 =?utf-8?B?TGdYeUlsdTUvanhxSVpkSjNYN2E2L0RBMHcrN2JNZTU3MWUyeHVUT2ZKbzFv?=
 =?utf-8?B?QURucjdJSGZtanczblh3NVVrRFpjRTZYdGZpbkZCNlA1L3FhSDVjL0Z4OGZu?=
 =?utf-8?B?cTcxSFUxbTUxMVJOLy9rNkx1bk5lNVBseDc4cXVuKzZCZXRYdkIxSFdOTTdh?=
 =?utf-8?B?WW5LUE1tbTM4MzdaS3RzbTZXWTM4K2QwYU1ETGxpVlN3eHR3Yy82dmZIOGV5?=
 =?utf-8?B?ekQ0Y0NITmRubTFzTVRxL3IwT09XdUxxSmVHSTR2eDNwVDd1UUY0dlQ5UVRS?=
 =?utf-8?B?MHprYVVjTS9DYnhXdmdMQkRrZTFNN1ZtbjJLdTdpakdaajRKT245dDlWZ1VV?=
 =?utf-8?B?dXhmZm54MmdUQUtjSjBTNGRFUnpiVlhEZTNSKzQxdGVHeTlFbFU1eldPeXRO?=
 =?utf-8?B?ZkNTUE8va2Fvb1o4cHJHc2hSODFPUjRHaXdQa0lRTEpxRlg2dFZlR0ovVDdy?=
 =?utf-8?B?UFFFWTJweTRhb1l5UkYybFFjRVVnd0xVVEV2VHlPM3pHOEVhMEovamxBV1g5?=
 =?utf-8?B?QUI4TkFrU0JYTm50OW9QTkZPMExyWUs3Vy9MbnpMa0lkTnpZY2FtTWJ2L2R6?=
 =?utf-8?B?Q2Fld2FYQVI4V1NKTkNScTdSWHVDczJPK2sxelgwVldYRlZ3dGFHR25xMzZ0?=
 =?utf-8?B?clhtaTFnUXRzQWJmdCt3UkUrclB0aGVuYTUzQ1BHM015enhDOGZlQXM4clcw?=
 =?utf-8?B?V1dLcE5Oc2MwdnVCRk5PUTAwYnRvK3Z2MzRTeklPNE5kVXRKaWQzeEExRnFi?=
 =?utf-8?B?MWJPVFZEN21Hby9oM0NVUERsQ3o2OVVISEdFWm1jTlhIbDQvNlpCOVRRN0tz?=
 =?utf-8?B?VGxEKzJEWHBna2hOMHFiVWYwQmdVejA2Mmd5QTRjSlRaRmZ1RFg4VjRQRHBM?=
 =?utf-8?B?T1A0ZjFQNkJ2bWlnVTVTaXpha2p5c2liK2dMakFjbnVPSjJmQWNWOTNCNWs5?=
 =?utf-8?B?eHhHY0ExRXl6Ry9uelM2b3ljVVFydXA1MjBCdzVwbnV5cVdYRjRlNWR0WjVQ?=
 =?utf-8?B?bExiNFRoTU5jTEhBd3MwYmFSYVFJVVo2aVlkNUV0bTRTNzJDTEhCSG03U1U3?=
 =?utf-8?B?L0oyT3lYdG5VUDRVcy9MRjJEeTFUYy9BeWd6UEdFYWllNTFOVis5ZEhFeTJ0?=
 =?utf-8?B?enN3WHd6YmRFQktkMmdia0R0OWp6WlUvbUpLdFV4M2pzWWxZMm1XQ1RBSEsv?=
 =?utf-8?B?b1Q0TVE0NWdwdzkyUUdFVXA4ZnROcVgvUlZjd2NqSnZNRWZEcVJ4RUttV053?=
 =?utf-8?B?VTBsSk5ZWlNIaHF6bHhSbFZEVVhlYmZEZTRySTRUT1RKMDUrWjBKMlpXUGhv?=
 =?utf-8?B?K2dFV0tQUmxIeVZHOEgzZFZ2dytldFZ3THZRdWN0dTZwUFcvZ00rQitnTHlj?=
 =?utf-8?B?TytUR2N3QU83WEpFWHIyS3V6M2JRRnM2MXFJSElMVnBPdzdSR1RIQVR1dE13?=
 =?utf-8?B?cjdCNjhQeDNPUGVWdlk2NlpRTUZlaU03OGFWUnB1U3Q4NEFyNXVxWDBrbWNO?=
 =?utf-8?B?OHVWcUZlRDZ6SEx1dVphRkFCL21DNlFDT0t1UlpZYTlMbkIvTVJvTFlLbFVt?=
 =?utf-8?B?WjdKbFpudDhYUWdhMEZxV2pLL1dZUndzTmxsc3VBcjJqcEw2SmVmQ0hoSlFy?=
 =?utf-8?B?dHVzL1R1dmloWm04UGdYL3pLaWMzMThXRElYMkV5dGNaTVB2N0FIeW1GTXVr?=
 =?utf-8?B?Z1BJTS8wUDRhUTV1ZlhYOVJkQnN2eGxXSVJvano5am5WZjVHRmw2OEYveG9K?=
 =?utf-8?B?TUN5dzZRUlpQaFd6S1BGeWhwbjhpbnRVaDBjam1nOFhSdTNOcnV6MVpNeC8r?=
 =?utf-8?B?K3UrSGV0endXK3NYS0ZIVWJ5NitoN0VqU2tmVkMwSjEwZURNTFpVSTczVFVP?=
 =?utf-8?B?aWlQR1ZaVHFSMTI2L1VqSDRzdXoyV3JRcUtnS0Y5dzAzQitBdmRzUE9ydXkx?=
 =?utf-8?B?d1hhdi9xSzNibVNtV0ozM2lkM0tsNXhwNHZzYnFNQVVVbWpIcUFJWTU3R3U5?=
 =?utf-8?B?ZzJIWlp6cDNpNHhrMXl2cUxNTC9DWGtaOFZyU0h4cEJSYURkYVp3NnBhSVBr?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eeade92-361b-4fc9-2b19-08dd97ef08e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 22:38:26.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pjmn42rJofhNDUPXlXz7ypNVj3J7H7qe6LWw3jUBHdZljLGGP/+MPQhsTMz/yMR9b6n7KoOnLlqdnoQX8DhitGeBykQCuyLrC/8q8f+kFZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com



On 5/20/2025 7:39 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The do_match_pathspec() function has the DO_MATCH_LEADING_PATHSPEC
>> option to allow pathspecs to match when matching "src" against a
>> pathspec like "src/path/...". This support is not exposed by
>> match_pathspec, and the internal flags to do_match_pathspec are not
>> exposed outside of dir.c
>>
>> Make match_pathspec_with_flags public, and expose the
>> DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY flags. The
>> DO_MATCH_EXCLUDE flag is kept private in dir.c
>>
>> This will be used in a an extension to support pathspec matching in git
>> diff --no-index.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>  pathspec.h |  8 ++++++++
>>  dir.c      | 11 +++++------
>>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> You use diff.orderfile?  Not complaining, just finding it amusing
> that somebody uses the feature ;-).
> 

One of my coworkers asked me to set it up so that header files appeared
first in diffs. I kinda liked that, so I stuck with it.

>> diff --git a/pathspec.h b/pathspec.h
>> index de537cff3cb6..d22d4e80248d 100644
>> --- a/pathspec.h
>> +++ b/pathspec.h
>> @@ -184,6 +184,14 @@ int match_pathspec(struct index_state *istate,
>>  		   const char *name, int namelen,
>>  		   int prefix, char *seen, int is_dir);
>>  
>> +#define DO_MATCH_DIRECTORY (1<<1)
>> +#define DO_MATCH_LEADING_PATHSPEC (1<<2)
>> +
>> +int match_pathspec_with_flags(struct index_state *istate,
>> +			      const struct pathspec *ps,
>> +			      const char *name, int namelen,
>> +			      int prefix, char *seen, unsigned flags);
>> +
>>  /*
>>   * Determine whether a pathspec will match only entire index entries (non-sparse
>>   * files and/or entire sparse directories). If the pathspec has the potential to
>> diff --git a/dir.c b/dir.c
>> index a374972b6243..2f2b654b0252 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -329,9 +329,8 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
>>  	return 1;
>>  }
>>  
>> +// DO_MATCH_EXCLUDE is not public
> 
> We do not use // comments (outside borrowed code anyway).
> 

Sure. I don't actually expect to keep this patch as-is anyways, since I
think we might want to do something else... as exposing these flags
seems incorrect to me...

>>  #define DO_MATCH_EXCLUDE   (1<<0)
>> -#define DO_MATCH_DIRECTORY (1<<1)
>> -#define DO_MATCH_LEADING_PATHSPEC (1<<2)
>>  

I actually almost wonder if we should set both DO_MATCH_DIRECTORY and
DO_MATCH_LEADING_PATHSPEC in match_pathspec when is_dir is true.

The DO_MATCH_DIRECTORY causes pathspecs to match if we have a path like
"a/b/c/d" and a pathspec like "a/b/c".

The DO_MATCH_LEADING_PATHSPEC does the inverse: if we have a path like
"a/b/c" then we match a pathspec like "a/b/c/d"

I guess it really depends on the nature of the caller. In the normal
case, I guess we don't check intermediate directory paths and only check
the end resulting files. But in my case, we're checking "a/b/c" before
we descend into it to check its inner contents.
