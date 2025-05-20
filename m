Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A164253B64
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780496; cv=fail; b=vDOOnwd6pNOPpb04sAN57QqUltuuOehwguofb04HW32PQCrgpmI6EEqJlY2XoDngaDWlZOjPCGVqsZfrawA9/Kvyq8OhbZ45PrkS++RqthblpkX0DTYx5QYTeh0oen8MjgiiZRKGCNYIbX3jbA03d8IJ42XDpzaDml4KJOmJW08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780496; c=relaxed/simple;
	bh=E5cvhQoIUVNvEojzN2XpyF2oAqREj1hzi8lLEr3LZRo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E0RaeDnyT99yWm5hxNvc9ghXmI3wKsyMDcmL5jslTFDh56WsAlPX22al50PBBW+R1UJlg3rMRoBKybIADvp9D0/WBvpa1WCeq9AjTRUKuvO5ob1yVZlOpK2EA6bhWPyvxk5r/2WVNO/EslVt94nBjXX/nHsjffEv/VwsR0cEqyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYAokPji; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYAokPji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780494; x=1779316494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E5cvhQoIUVNvEojzN2XpyF2oAqREj1hzi8lLEr3LZRo=;
  b=FYAokPjiN11s9aAhuwx0g0WvDTPfYlOrCBdsFtOCxxcV+SCu8fT7I7pE
   Ox9z7V8JW0HXDWd1Rd3HoCnmkJVxZx/FiInopJjqzR9D0LrTGTdJPH1M6
   NMZExNe8Ugc7KMwmwWtpwmUWtSfMlRF2/Uy9QsMLkhs93IjVYgV7G0rRP
   aSe3Wrisyi7lEgUNCPucNZeJiQ/ablSCf3pZKFlr+KhZguVywiW36wrvo
   c5gzNZj3+iHc8HyDxND76CXIfIaimc/A4ltS38ANYwYcN9baknCTpeG0y
   boFFmxhpNFKOyRXbQdg8WDWMglXK2uzL47Wm/gx2nOrkZL46gN7xnOIIo
   g==;
X-CSE-ConnectionGUID: LZnjUhLaT+WMcNJpNjMjhw==
X-CSE-MsgGUID: 6kH4aSisTPK7ftl9tQkPYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48853894"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="48853894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:34:53 -0700
X-CSE-ConnectionGUID: llBLgwOqTbaKIuQcJLkzTg==
X-CSE-MsgGUID: T5CwrT6MR0GCsvUMYkAdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="170842993"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:34:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 15:34:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 15:34:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 15:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO19jBVtl2NAA56iAdhYm68hrWajSDvPlLSKo0r20Mq04D3eoMfWFanV4Ib0KTHurej/yXRRDmasXKHUkpJgNinpo9itzqbLwXOsElVWFR/sI2ypZdDSPtKRd7WgXMsJpA0KPYY5ANCxKuCs4F1uA5E8i3f3fa1wr0pPqNVFGY/KtIPegqU2hmJ0JJoH7zY66V2530ItBGjk20o54TUTNez5LIEtJA2oXF1z6a5PUizJ54aPow0nz21vhmf+4AO+k+QMDEuWU3Z7ucq0tU6bv0l1VHOiQLvNe0S+ESm+ILhhMLviH/xgyTrVlnFLYzuubLtn7mizQe4HVXoxYWFVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUPMLhmX2Dat41DrOOsrWmIEmcDQRIiHB21wr08jEcc=;
 b=PiwTulmJnd3T6mT5R8TUbwMTp7fLks0R6kaIRngOZEd5hY8Iwak2iOFSO7KkC0X6uDNS7KiDMoMn2gA0fCOfeRLZy7SixO4Fm5i7phhm7Aenb+Bg8bw4bF/5YGt4WGr9e/a8XncLwaXn+thWidRdtlGeKXdUxT8tgE4mvrhhEx9fekHwc6sy5uoZk4ge1CSEcPKCzllY/LKF1LciQ+Luqkg0BWhBIem7QvzCmvdmHahYhvHiiAwO1iDEnuPkeAJgISX+iuI5Oa6Pq4NASCbsBA6n++tkmploGg1GI0Q0zmdWgve4I7Tyv+D0pOi5+Vy6JQJ2NFy0jhmfouYbg5V4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB8991.namprd11.prod.outlook.com (2603:10b6:208:55e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 22:34:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 22:34:50 +0000
Message-ID: <6e94605a-6706-4374-baeb-7e87d27f1bf9@intel.com>
Date: Tue, 20 May 2025 15:34:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] prefix_path: support prefixes not ending in
 trailing slash
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
 <20250520000125.2162144-2-jacob.e.keller@intel.com>
 <xmqqh61fl58v.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqh61fl58v.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 32eb5c62-c7f3-4fc7-fd56-08dd97ee8842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVFOREtCUzBDQit4eGRsYjBEc2ZBdDJXNDc5bGNWck1DVC9hVXpTczNSaWlw?=
 =?utf-8?B?SjY4cjFvTVBzU3IzOHBDWWEwY0lsLzMyaWE3NTZIaWhRbmU5RWYwRlIwVkE3?=
 =?utf-8?B?bmxxb1hJSkF1a1EramxRNnp5S1YrZXJ1QnpRaGprZ0d2dlhkdjVNQ1loNGlp?=
 =?utf-8?B?YmFCRUVWRmsvcDhoYjErV3gzdXR1Y2lUaDh0eXpyWUNML3hUcUlUOGhYMWxJ?=
 =?utf-8?B?OGphSUVGeVl4YjdLdURmY1I5cU1xbWlvYnNmNlpYd2FPODVLR3d3blZyTHlL?=
 =?utf-8?B?UThkZ0NSSFl2VUFaMGk5RjZnRVl6Q0RjMloyQjJ0ejByWHdvYUNnTjB2Rjk5?=
 =?utf-8?B?NXkzU21RWFJmMGF0UFpFM1BNanZ1MTZ1S1hKbmNQWngrcDM1U3Nsd3NGTDdF?=
 =?utf-8?B?ZkR2dmhYTkFlMGFwdkRjcC93YjI3Z3EzdGZkQjBDREh6dWgvUENwOVJ3S0RW?=
 =?utf-8?B?OGhJR0hyaFB6Yi9MSUNwRWtiU2RkQ1FEdGV3SXh5Y1B6ZEgrbklkNEhaVFQz?=
 =?utf-8?B?QlVKOGdrTHdnSnVjb1ZndStoYVhLc1NSaGQvNitHRXpwUHBaK2dEMEw1c2Uy?=
 =?utf-8?B?RHZSMFJoMmFmaXhPUm1sRk8rd3RiRmRWRHB6dlJhUkV3UzVHSTVlZjN4NzN1?=
 =?utf-8?B?LzdSdFB1eW1nTVV4dFVPZmFoTEZXbnNKa0cvcW54Wk9RQ01XVVFZeThYczN2?=
 =?utf-8?B?bUhOM0xYem5aMDNnVERTOEtEOStRd1RaS0J3VUVyblZXUko5TmRXWDdkZENa?=
 =?utf-8?B?bWNSbStnM3NWb2NMckhWeVhkdDd2RDRoSE4xaGdrK2I5N0hGT1JVdVVMd1c5?=
 =?utf-8?B?UGJRWk1RSDFkUm5Ma0NwbWRaVWJpcGdFVll5clc1Q2dYZ083Sm5kZm5YaktF?=
 =?utf-8?B?cW1WelVIb2hqUmZUc2FURTBjQW54MDZ1cXlpWTdEMWpCcHoxZ3psV2hQejMx?=
 =?utf-8?B?V09veFd2emlnNWI0NjVWeFZ0RXFYRGVlbGRYa2Y3VS93bXB1N3d1NXk1WTZz?=
 =?utf-8?B?ZERLUEkwRkppKzM0ODY0M3RvNmI1QmVUSEg4cngyeHEzTUZjUDk1TXMydUFv?=
 =?utf-8?B?NWZ1cnR4UTNpU1BJckZuQ2VkYnlsTGhKVEhqOWxLRVRsMGNKVDc3RHdURUcv?=
 =?utf-8?B?QkxDaEpYY2dSKzVNSmtqRWVIWHVoNGV2eXRXUWc4cjQzM3ozMXkyaHRtQktQ?=
 =?utf-8?B?TVB4TEg1Y1ExaFpCVEVMVHRiRVJUS3E1SVlEeWFtQUVoWkFsam1MbHpRSUJp?=
 =?utf-8?B?Zk9HUUhEQzVlL0VxajlwZWhBanQ1V1FaYXAvSUp5RWsvUlViVTRsUW1CN3B2?=
 =?utf-8?B?VFREdy9FOHROUHNDUjgwYjJhV3luMytyRGFGMThCT2lsMU9kVm1FeVl0Z3Az?=
 =?utf-8?B?NzdJMmNyY1F3a05RRVZkU0JiUys3QmVqMVh4Q3RCVW9vQ0xYSDZVY28xK0xZ?=
 =?utf-8?B?S1VMKzZtcTI3Q3RDWnJFNmJMcFFhc2dvN25GRll4OExqTThxV01Ed1VpKzFW?=
 =?utf-8?B?bi8vcmRwaDFYSlA4OW9naTZIMys4bEhta21VVElodnF3bTJRUjFrV2NmYmsr?=
 =?utf-8?B?VzhZMVhJN1Evdm83empBejhFcWg0QVVuRTNtbjBoMnFDUSs5VENoc2VLbmxn?=
 =?utf-8?B?Y01KTlBlSmsyQ051L1pmNDdOL2VIOGZKc0I2bnU4RlNjV09EYnoxekRJL0pK?=
 =?utf-8?B?M1R0YTdKOE1TalFpSTZqMlpENDJaNGkwQ1FlUURPRjdWK1ZnUm5PUmIrMjVs?=
 =?utf-8?B?QU8rWjhVRUJqbTVnMDhnTFJwRWpLaFVVSmJRWlUrN0JzR25IZjVhcVNFSU5h?=
 =?utf-8?B?SnJrUTFScE1GNi9jY201OXVsVjFWbXBBd0tZbHdtaGt4aFhyeW5nTmN1WVY5?=
 =?utf-8?B?b0xPUGt4Syt3RjNUNm4zSXVaRm5kdzljQzV1TUVhMUlEcXVNNUJKa3N0VEx5?=
 =?utf-8?Q?ysL+Bg0uuXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmt1WWplaEh1bjM2L2tBOE9SQVgyUUM5cS9HYWI2YktpdVlSMTRxTkZ6dHNi?=
 =?utf-8?B?RGZUa3dZQ0MvM0FXMEk4S3RwT3JzTG5FSUUveXhCZzQxaXc4c3Fvekt1Rlkx?=
 =?utf-8?B?MTVUdXBYVUxBdFd5R3YyT3BzV2tnQ2hhVnVydUVRU1ExWDg5ZHNvdTUrU3Y1?=
 =?utf-8?B?cjNRMXJqVFdxVlAza0FneHFuWW8wZXVMSXhjd3lWQS9TU2Y5NU0zZlcvK2xk?=
 =?utf-8?B?RjJXZnpjUkVsdkorYU1wdVhjYWFBbTRNTmFsNTMvbklJMVNHTHVBV2ZkdnNw?=
 =?utf-8?B?dmcwc1E4d0picDFwUFpJdDBZWWw3dmhESkx0S0NrWFRZekwzcG5acW1PQWl0?=
 =?utf-8?B?d0RwV2djd21mdkdyQU5qM0V2K0J5cVZxREdrK2xueEh3Ym93L1NYZE14UUor?=
 =?utf-8?B?NUtBUkE1dGVKb1A5WW80UW1WSzdSWlkxYWlEOXFIRUxhZzZCOUQzV2o5ZkhP?=
 =?utf-8?B?S2RRTTBmN3MxU1pQY2EzcXhFdEdvUmZ5aHMydCt6TWdhS0x2QlhqeUpqcFlr?=
 =?utf-8?B?Q2pLZTg5R1ZmdWJzcitpSnVxdUlLNU9USzhFTDlieFdySk5SdUZ1eXNBdm9a?=
 =?utf-8?B?ZWJQbTlFc3ZMbkwzVVhPaDdFWkJTU2JCVmZaN05GNnVvbDdxbkhkOS96UXBs?=
 =?utf-8?B?b2d5MVRlSVZWbG1BazdIa0cwUVhFaWl5cHUrMU13TmpZM2hzczVDRXNkSWNk?=
 =?utf-8?B?a2o5clgrTmx1dS9WTVNEdTlYYmhiTjI3MFljUTVuM1VKSEZ2NE5lSXlxM05O?=
 =?utf-8?B?YjdhYi9pMnU5eCswcWJJemVLUmdHT0lHTTJYcEVsUi9RbmtGaVR4d3Z0Tkhi?=
 =?utf-8?B?Y0RHdjVzaEk3eThTTkhOVy9pY2NFZDMvMWVSditDZThwTUpiUTlmMXRlYkl6?=
 =?utf-8?B?RzZwbmEyVktrRHN3c0xrRmZlT0xtZSs4RHRjcTNsbXQzLzRMeDZpUHZ2OE96?=
 =?utf-8?B?blhPZ2krU2JEYW9WSTlMWDNxTjE1S3pEZ0JIQ29CZmt1QnFZdWRDNFFoQkp6?=
 =?utf-8?B?RXRGYTBqV0t1NHg3bGVsd1Z3MHBNZUdQUUQ5c1FkUERWUjRTdzlDOVNvc3Zt?=
 =?utf-8?B?R2lHazBnOUdtcitURFp6S1UzMkxteUdONmRrTk9UU25TbU85M2pyM3NGbW13?=
 =?utf-8?B?endPODJ0YzFWakJDSGdsVmMvTW9xY0d2Ui8vL3VveHBhMjNhMThkMWs3Q3Vj?=
 =?utf-8?B?YjVSaHBIUjNKV3ZnWE1obnBHOHRzb2tZVjRHOUVnUDVQSHYreVNXMkkxREZZ?=
 =?utf-8?B?WXBodDJXWUdSRFY2aFc0UHFIV3B3U2xRcTRMR1dlY2pxMm1KeC9iWXRqcUU5?=
 =?utf-8?B?Yi95dDNiY0l3Z25vWkUvTWVVeDlZTHBPd1YyM01WaFM5aHJLYmY0eHdvZWpq?=
 =?utf-8?B?b1pZUmErS01TOW8yVGFnZG9HanhIZnYxdmpWN05xcjF6MUUvdy9IVVNkWTd1?=
 =?utf-8?B?TlZvV3ZyZzBiQVdJUHo3Q1V5ODdhSnVkUTFDaFk3UTBPNjlXbm4vL2lJWlN1?=
 =?utf-8?B?TDZnUHhpc0tYVWN6eWhtZUlOZUxzVkI1ZGlWSjFTUDAyMXJNOW1qamR4aHFU?=
 =?utf-8?B?V2ZITkh6TEZuZDE1ZHNKZEw2T0RnU0FmSkZnYklXaVUvWHNtSmVzT2M5eHpH?=
 =?utf-8?B?VWJrd0U3NWpDWWcwc3M5cE5McWJDUWtmUTlSbVhIRHRhMjlwZzdNNGl2dk9Y?=
 =?utf-8?B?WjJDczhXMGttQTFqOGJDV0dXbjUraFNwVTZUUXNmR2NaUkkyYVEyaURveDh2?=
 =?utf-8?B?S29FbmFOcm1UbkdDdWtuYjE4MFRjYlM5ME1vWDBTMzlLb3o4N3c2S2xiV0NW?=
 =?utf-8?B?YjZwWUxDcStmZE0xdmYraDZocTdYbjNIZnM0Z0w2ZW8xZTNOb3NxdGJadVVJ?=
 =?utf-8?B?eXR3aDU2MGhxdUtqTGpSYUFnbmc3a0ZFQ2hVTno4aVZBT2F6Zzh3OU1zSHBB?=
 =?utf-8?B?R2l5aVVpWVdOQmxNN1dqK1FndG1ySkNxUEVPdnNWYTQ3ekFWRDRtZ0hGcE43?=
 =?utf-8?B?QVZwV28xWlpMOVZTNnBubG5sKzBocGsvSGZhU2FJRXVpU2svcVMvektGZklp?=
 =?utf-8?B?Rm51bXEwTkNnWEZvdWZmVE9ualkxMDBleGhnd2dCODZVa092Y2ZwTVNiSm1R?=
 =?utf-8?B?Z0g2WEE5UHBSUGpwYVR5OUNPU0FiY0JzZ1p4VDBZMEdlcEhyWmRhTWZhMm03?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32eb5c62-c7f3-4fc7-fd56-08dd97ee8842
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 22:34:50.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q/mKbn3xUBw85rWNHD81+Oa/07oCd8al70M89tIzxIDzPUdIAa2BEJ+/1PtcTitBdy1KPkufC4MhxTMYxnJrtgplAqiidLEixMrXEN7Wac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8991
X-OriginatorOrg: intel.com



On 5/20/2025 7:35 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The prefix_path_gently() -- and its wrapper prefix_path() -- function
>> normalizes the provided path and optionally adds the provided prefix to
>> relative paths.
> 
> I find "optionally" confusing here.  The original intended use case
> of this function being that "the provided path", which comes from
> the end user from the command line that names a file relative to the
> directory the usre started the "git" command in, needs to be
> adjusted after "git" chdir's up to the top-level of the working
> tree, and the way to do so is to prepend the "prefix" computed by
> "git" (which always ends with a slash).  Adding the prefix to
> relative paths is the central part of what it has to do.  When the
> end-user supplied path goes up e.g., "../file", we may have to lose
> a level or more of the prefix before prepending, but that does not
> change the fact that the helper function is about prepending the
> prefix.
> 
> And as you can guess from the above description, if the caller
> passes prefix that does not end in a trailing slash, the caller is
> buggy.
> 

Sure. Part of the reason I was thinking modify this here instead of
adding the trailing slash, is because to add a trailing slash I had to
convert the path to a strbuf, where as by inserting it here thats
handled by the format specifiers.

>> If the prefix does not end in a trailing slash, the
>> function will combine the last component of the prefix with the first
>> component of the relative path. This is unlikely to produce a desirable
>> result.
> 
> True, and I do not mind being lenient to buggy callers, but given
> that the majority of callers (i.e. all the existing callers) not
> being buggy, I wonder if it is better to check and append a slash to
> the end by a new caller that feeds a prefix that directly comes from
> the end user?
> 
> Unlike prefix that is internally generated by Git, we'd need to be a
> lot more careful if we are taking end-user input directly and
> passing it as a "prefix" (I take that the possible lack of trailing
> slash as a signal that you are doing something like that in this
> series).  We may need to check and correct that they do not contain
> "./", "//", or "../", for example, anyway, and adding the required
> trailing slash at the end sounds like something we may want to do as
> part of that input validation and massaging _before_ calling these
> helper functions.

Yea, I think it boils down to me passing the two paths from the user in
as the prefix or root of the pathspecs in parse_pathspec.

Perhaps we either need a different function to clean up the path first
or modify the pathspec code to not use prefix_path here at all and use
something else instead.
