Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692D13A24D
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267276; cv=fail; b=h6UePHgdNJAfmES84o95NIKTMj19SlEOgPeoeyumr1otQ7xdND6yxuLyp2rQb5vpsf+0e3gXA1gXAW64o4SSIhDW92M6MzX5z2euLbytTuee+a4wmAO7aMjddpDy7xJ3ZgW+0+PVvbnLQnU6SvrLWEUx7v3SwqOJXX9YT1BV6YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267276; c=relaxed/simple;
	bh=HGMv5F+FuOKNuP5yQ2uzjZHyQIMY7UKbqqOWd3TsUtQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJc74X2VWZGn6MUuX1JReoglmxHU3Yrl/9YMSo3gS7PlF0pNuHLiI7GgouY1+I5YDRz9vsWZPaI2r4iAlmBwow502e80s3cXdpV8yt6LLgg+zpyTtF/e2/8qFcMJCWJ+I3tkLC4VVSdQfOuKunxPklSkO8cV7jcB9XIo8KSumjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6xf+ZWh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6xf+ZWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267274; x=1755803274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HGMv5F+FuOKNuP5yQ2uzjZHyQIMY7UKbqqOWd3TsUtQ=;
  b=A6xf+ZWh7STpfKSYSsbc7sX9dWE2XkaTAKiVL8ZR44ZnevhLG6gd3T1c
   1bPTzg4K233D7VFBWPxRWma5Mzzn8W1uIUHjp1cnE7Lh9BBH/xewYqOUI
   lOBH5m61YvlM6P6G10Uf2xCofJ01m4aI2pQOtpTpgJIKx1arGHeFAA9uN
   v7YeWJWv7XjX8LRB6IPBgT612VpujIt9vQmM3CGX72wx7UchKfJtymFlu
   Eyn0aNYyX7A974yJx34/LqUO81Nnnzlp57acea0+xX/itIeBa+lK/4HGK
   fd2vf5sCcr7BxD1q+Gmr7dYxc9uRkyOZRNn5jyAQx8vbIHAU4m9wUpVGo
   A==;
X-CSE-ConnectionGUID: C5KDH4hOTliiux7fvoGDhw==
X-CSE-MsgGUID: 32RAmQfGTRqf1hTaispxXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34033217"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34033217"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:07:54 -0700
X-CSE-ConnectionGUID: btiiAxg/Q52cUvC3ul4yYQ==
X-CSE-MsgGUID: G2CbnL0ZThWDBOCKgm+jVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91917027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 12:07:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:07:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:07:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 12:07:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 12:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayvs2wQvSbuJp0dDth6CcWhVAq3oK4SoIBEXft2W86POED2/ckV1By9qwIsHYEAbbU5iki+FPhRo286TH4Q8djrBlq6hwT4Bx6QmYmzs5xv2aDydxxkVHnwRLtb6ghdTlGB0bLyRmHiGEYNSIbvrimTvdQZMFN7Xkes9UJAOW4aUCUkaK1sgItRO7dM+FkXIjb4+P0oB2HKW6fYRrAVSx9VqT2SunPh9ncCF6QjS4mwXImymyTKaCbazcWUVFNF6rHjCHlb5WD8XOHlE3zRal3RcZPSMYmQfgUhar/ZGsD8QEhktvOTQlTEfidVBmf1b1r5O1ypXEBPpXuAJotTyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/UtnIi/VlqAS/Cu3kq8Bvxklcq+8xm79xamM87oU4A=;
 b=lP/27+fvkn27WMFmCTFnY23ewpi89fwsx5EudiYWELoJMgKRoKFo9bSIXOs+RfMuO2I+sOt7swpWYJo/NPlO5aYPYd55vn0ESdNdBIi+V3U39Y+7DUsohr4EU3Zl0oYv0XL/WVBcp6MzEWmGvjf09Ts77c2Sdgrq4dhGbCRxLeZRETEGfU5G7KUQxLQb/LeNfQwUtDiBEeeg482OyriW6+nX0+GxzvOIz6qdh16+rRG2hH5GrhTekDRMxu9pJ2RTnnqykqQSx38ODaF0K+0dLtSNpU6aKJjExcki5pJKVP13U31gmGwIYZXS4jH9FH0xUeDMAVBnRsniEP0vSFoVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 19:07:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 19:07:50 +0000
Message-ID: <f56b68b8-b5cb-4930-9139-da28bfae2976@intel.com>
Date: Wed, 21 Aug 2024 12:07:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
To: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
 <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>
 <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
 <xmqqjzg9ybpd.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqjzg9ybpd.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f579cb-af9b-4716-d9e5-08dcc2148d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmU0MmE3a2ZYTGJFck9rUkpuMSsxZGZnZnFKWTA2SWxBeVk1Szc0RWhFYUlv?=
 =?utf-8?B?eG1CblVZZXQxNTV1cXdzV29USGhsVVJkaFFLWTB2K09jKy9scFJlMWo1MWtq?=
 =?utf-8?B?RkhOMjV2cnVaRTNxRWhnQjRuNituaXN2UnQ3TTZPdEg1WHNhZUJqTWVkT3p3?=
 =?utf-8?B?RVBYVUwzUlM3T2IzdEZWT2lQSXdjOHJKRkFBMjlEdmJIaEcwSm5vM3gzZUFS?=
 =?utf-8?B?V0FFL3ZmdnVjZmtmWGtDcUNoek15MGRsYkRnMlAxY0xDOTJnZkc5N2lSbVVN?=
 =?utf-8?B?YlUvOHhBOHp5a1VyZEZiMHphMFZ6WlVITWJjWGx4Q3dpRDA0dmkwdFpXZzVT?=
 =?utf-8?B?R1hRQ09aMXg2dkFXeXJMblRyQ1FFZFN5U2tMQ1hOdGJRbG1TaUJDeEQySUhx?=
 =?utf-8?B?NUFrdXdJQzZ4c21OSjZrNmUrOVlyQllBdEtXYzhwTzZpTTh4YkFjaDRhSlE4?=
 =?utf-8?B?WHJBL2NCQ1gwZnZiMDVjajUySmQ2TzlXMTVtL2k5RW9uNHo4dEhWSTVYN3BJ?=
 =?utf-8?B?QUsyZ1hsakhaVkFZWjVaSFBsNUZmM1A5MVNDSWo3RFVJTkljd2ptLzNWSmhR?=
 =?utf-8?B?Mk1QUjB0YWFPeHpxRFJsQUJ4QzJSMFBKYU8yU01SZ0h5eXV0WDM2YXNzbHhM?=
 =?utf-8?B?L25RbitVUm9EengwRE5MMVQvTHdDQ3d4Z2ZMdVArSHJaNmt4WWhsVmxqWUV5?=
 =?utf-8?B?RXlzWGJmSC9DaVFpa3EvZXhzeEpnVDQzd0FYMmZTY1F5Z2xvWmF6aGtSUElN?=
 =?utf-8?B?OE1mMmNSemQ3ZzZ2dEZYTU9qTnk0UU45QlpKNkY0OExmTUJHemFHckdtYXZu?=
 =?utf-8?B?czkrT2Fhb3BYTXFWc1V2R0xLb2JwNFFjcG51QzNkU01QRFlaVUpFenRFbmxM?=
 =?utf-8?B?K2cvc0p2QXpaRnZGcVdOZHQwYUErTDd6V1EzeXBQNmJMU3Z2bkxMSWV5MmUz?=
 =?utf-8?B?UEpndDlCK2VtSmNqM0hISnNpMUVqL05lOHlTbjNSRWpMb2I5MkZPVmZIMGFx?=
 =?utf-8?B?ZkdadnVITm1Zcy9YRmpMd1JBUVRob0NSekNFcTllcHR5c0pPZm0zYlVhelNY?=
 =?utf-8?B?d3ZZNnlacW00ajlkQnVicUNMOFdaaU1JVnVycUJtZkY4RUd6Uk1kcXlXN1BM?=
 =?utf-8?B?aVBQaFdjLzQ2dFNPQmNkTi9JeGZLVTdEQ1IxRU9NM0Vrb2FIRktxWjZpS0lF?=
 =?utf-8?B?cDI1Mmg0OFNkVlFoL2hqMGZMK2ZtUjdnb2k1bVVXZE01Y00rWWlCNjJjM0Vr?=
 =?utf-8?B?R0tZcHk4Q1VIdEV5TWM5bXpaQ0JLQXFza0JvSVQwTEdmR0x5NE44Y1NST3pH?=
 =?utf-8?B?VG1Ka2lCZmFnR3NLSnJVWEpWTFRYU01nWTlTNVdIODdvcExCT21CQXFNYzlN?=
 =?utf-8?B?Nlc2ZlpUTVJTd1JHOEY5akxOcDZGbXhQZ1pHUWh3NHRaNGFGVVhMN25yMTN6?=
 =?utf-8?B?clBaRXNkQjR3TFYzK1B0L2RpMkpFYkVnNkJZVU5aMll0LzNFNWNSdDd2UGFi?=
 =?utf-8?B?TzhxMFRnRFZTUzdZdlQyMTdYSlFyT3lPaFpXUzQ0a25aZGtSd2ZXWmtJd3VX?=
 =?utf-8?B?MEtwbzk5clBONTcxMGZkZHQ0VUxLVS90NkpicG8rbWFGT1lLMWJjQTM2Wldj?=
 =?utf-8?B?dFJRaHdwekFyUXJkUXVQOEVxVHl2cWZueTZ5aWc0b1dFdnVZbURKVzYweW1n?=
 =?utf-8?B?c2R4Z05DWElxeG1MR0gvL002aUNWWVpPUjNMbjhrSEd5QjJVaEZHemF2MTNv?=
 =?utf-8?B?dWRXa3VWRWlYM2pZRlUrS0VNUHEraGJ2bGFJZ0FHclg1dFcvenNTek5sWE93?=
 =?utf-8?B?UlEwaEFNZ3NEcFhseW5JUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SSs1N1lVYVdPT0JWamovSFNQV0p3R3ZYTDJCSWRYTE92SU4yQlduYXhLSWhH?=
 =?utf-8?B?LzdjU2xXZi9SSmVuUHgyVW1CTWtkNC9KOEc2NXNlaTFPRDBranhYQ1h3Q210?=
 =?utf-8?B?SWYyaHFRNWI1VHlqc3BiWEF5SHBxYXgrUGlrQUZxSis3bnZRL2JVMFp6T0k0?=
 =?utf-8?B?QS9SOVlNZ1BxRmRZZFQyZFZ3K0c1Z0IyRmxxU2s0SXZibjVJNGVPd3JTK3VO?=
 =?utf-8?B?aUZkdzJrYVBOSld4NlYrM09FanJGY3Vua2Nsc0Qrb0RHTjBDbDdxMjJUK0Ns?=
 =?utf-8?B?NU1aODB0bU5GbGVpN3N0OEVhUnJkUTh4cnM4QlJkZ1dLQW1ZdHcycTlZa2kv?=
 =?utf-8?B?MnpJTlQ4N2FHQXRLNDg0VHhGRi9ha1lRL3dtNFBGRXFuNzBqMVFBUStXcnpZ?=
 =?utf-8?B?QVoxTTcyRHJva3BVVkxCS1V2NGRienh4M24rL1VqQ0twVnkxcEUxR29OcWpI?=
 =?utf-8?B?ZEFPa01uMXlvWjhBZExpZHBaQys4bWRHT0VhZnVUVGxlckdQY21XOFZjYUV5?=
 =?utf-8?B?amZuUG5PZE5yYVVJK09mb2tHcGJlMEU2SmRueTRPWnVMa0VqRzVHZ1NHeFI3?=
 =?utf-8?B?QTB4Z0Y5VldYT280QVh5SkE2eUZTVDBxektFbWhrS1pzOWVlTlF1MUN5N1Bt?=
 =?utf-8?B?VVZjWkhhcWFzMW9GQ3NTYzNjRHV4V01lZWhobG9MV1ZxcWJ0Q1pITmJLNC8z?=
 =?utf-8?B?eWNjamVGNkt3NWd2TFhub0lMejRlMW5oRGtxbkxHWjZKWlJUSnVSUDc3U3J2?=
 =?utf-8?B?Y3kxdEdKUDc2NnZIdk1IOUJ2QXpTVHh6d1c5Q2twZms4Z1dJQy9XYUZFUkRG?=
 =?utf-8?B?LzY3cUlMM1JqSysxNHhCNTNmVmhzQk9uZDNkT0VZZWZER0twZ0hidWxMbzNu?=
 =?utf-8?B?OHRhWWViaDhnK0hsYS9ybENtUHJzMjV1djdHUVZwUDBOWkFkREpzZnZGRzRt?=
 =?utf-8?B?MEYwaktMZjZONk9BeGwxRE01cHZ3R0lhWmVydFZhMHl2MGxxaGNLT2EvMVBk?=
 =?utf-8?B?SkV2RDdRamFmUmZRSXVqZWx4cEtPTXUrNXFIUnBQb25VWVVoMUlER1haMytL?=
 =?utf-8?B?ODJoSXZ0ZVdicEs2WTllc1hTUDc5T2J1b3pXVW1ZQ3ArN3BianFtVGNHOFAy?=
 =?utf-8?B?eEdlekQvQkM4dnNvZ0dLUXNWdEJYZGFpRkRFMkhkbCtyMVdtb1VvNjJidHpT?=
 =?utf-8?B?NElzcnBNQXNQaVBWS0NQR1MxS2lNczVrdVlEZUt0a1pOUXVyK2Zuc0ZrVXJ1?=
 =?utf-8?B?MlVVU0hDd0dRc2ViVm1LMFhndFI1bWRsS3lqeWZib0xZaC9lRzBtVXRtdHFv?=
 =?utf-8?B?TkgrVExBeWl6ZTZtWWJCM0p5dVN4cDVLTmMvV1pVcWxzbUV4d2s0OGlMdGZk?=
 =?utf-8?B?c0F0Z3FSRVI1STFEYkcwU295bVVFSG9VekRRdHk2VXJWVWk2bWZIb29ic0Rq?=
 =?utf-8?B?NGpnZWJWSE1DSUgvU1lmU095ZCsxTmhENDNKTmt4YmI2dEVLYjIva05VTm5m?=
 =?utf-8?B?TnFid0pPci94N0ZFUTQ3ZTlHdzN2bkNYamJuWE16aGRZN1RIUnk0WUJja2dU?=
 =?utf-8?B?R3BIRERXS25mbU9Yc0MwWDFPb0Qyek9TdHpkMHo0MER0SDFqZ0JRMzYvSGFY?=
 =?utf-8?B?YlJTOFN4bzRNalpZVmFJWHVWLzJ1UnRvV0tIME92QjZ0QXNUaGFjSmdMcFFJ?=
 =?utf-8?B?NEdLZnhaSkF2clhUVSt6M1VkYitlUlJlb0NtOEx3MjJOQit4STdYYjBGWEdJ?=
 =?utf-8?B?UmloajdlV3A1ZWhKMjd0K0VkV3I5OURIYVkyWG9nd0NIbndDeDRGS0RJc0I5?=
 =?utf-8?B?WmcycVMwOXh2SU1PN1R3UmJiVkJMb0ZCNDZYbkdHaC9kU2tMa3p1R1NFcEdH?=
 =?utf-8?B?SmJrTDM1eE1PVkMyRW1oc2ZldnM1UDRSaittU0JaY0lHRnhlanY5N1BjL2pR?=
 =?utf-8?B?cWo1QWVGT3F6TmJiKzlvYmI4SHRCcU14TXRxRVF4Q01kZjFFeERCUGoyN1Zr?=
 =?utf-8?B?V0JqdllIN0ZtUzU3MXRLVVBwaVZXd3Q5WWswL0p4ekwyTnV4ZDFkaHFheGRW?=
 =?utf-8?B?VzdIVGFsUVM0TDZoQnEvbjJTZjBRNVphTUNDazdWU1dYbmFqNkc0cjZzYUFz?=
 =?utf-8?B?akZzZit4VnpySXVHcmxqSU1jcjhtWlFsWGtUMjQ1blFLTE9HMHA5KzlUUW4v?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f579cb-af9b-4716-d9e5-08dcc2148d0f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:07:50.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0bff55iBsmV8Zo1OpQww7nflWHZ1FP0/e3SgdkUKgAp4wfJK5Q8e/7DJ/3ACd16hIQXGd1Dr12ZIWMqmMQ0tNgubaEqHz07jUugqR0Sjf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com



On 8/21/2024 11:26 AM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>>>  test_expect_success 'check-mailmap bogus contact' '
>>> -	test_must_fail git check-mailmap bogus
>>> +	cat >expect <<-EOF &&
>>> +	<bogus>
>>> +	EOF
>>> +	git check-mailmap bogus >actual &&
>>> +	test_cmp expect actual
>>>  '
>>
>> I think I'd just remove this test case altogether, IIUC it' doesn't
>> provide any additional value vs. the "check-mailmap simple address: no
>> mapping" test below.
> 
> Sorry, but I do not follow.  The other one is <bogus@company.xx>
> that looks more globally routable address than a local-only <bogus>
> mailbox.  Isn't it worth ensuring that we will keep treating them
> the same way?
> 
> Having said that ...
> 
>>> -For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the command-line
>>> -or standard input (when using `--stdin`), look up the person's canonical name
>>> -and email address (see "Mapping Authors" below). If found, print them;
>>> -otherwise print the input as-is.
>>> +For each ``Name $$<user@host>$$'', ``$$<user@host>$$'', or ``$$user@host$$''
>>> +from the command-line or standard input (when using `--stdin`), look up the
>>> +person's canonical name and email address (see "Mapping Authors" below). If
>>> +found, print them; otherwise print the input as-is.
> 
> ... it seems that <user> without <@host> is a supported format.
> Should we update the document, too? 
> 

Its supported by happenstance, but i didn't want to encourage it.

> If the @host-less name is meant to trigger a random unspecified
> behaviour, whatever the code happens to do, that is perfectly fine,
> but then we probably should not be etching it in the stone by
> writing a test for it.  So because of a  reason that is completely
> different from yours, I'd support removal of the "bogus" test, if
> that is the case.
> 

I prefer removing the test. In an ideal world, I think we would probably
only accept actual <user@host> or user@host, but I did not think I would
create sufficiently correct parsing for addresses, so I left it out.

I did try looking up what the rules for addresses are, but it looks like
it got pretty complicated. I guess we could do very basic "it must have
an @ symbol, but anything else goes?


> Thanks.
> 
