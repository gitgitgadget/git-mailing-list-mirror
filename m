Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885002F49F2
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268521; cv=fail; b=CdMwzdr8KDg+GriPhwVZYAaUI9+ydfWBL/fK4xc2BUaEfSX5suQ16frf+6yriZaL+DvUeUz7iydLiFiGP8kGuODxM3URVn4tlr4THPLxZHKc6JxBgtSmkGcc9ey5TaAkf1iczZzDsnVRmaeUAwe8rsj12V4IdIFrCDrzgR5H1qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268521; c=relaxed/simple;
	bh=RIioLJSI97c7PpVGdj4zhyVYADhZ5rPrcBYYJKUi/sA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qMI9msum2nh2TswqqAWMgkwLkbKKGttJcB6goMXw30ZSKJP1/7VMrSJsnAAl/7ZSnZwQo5K4flEYE/j0A6fQEComyJVt1mKxuL5W5mb50+rJmNEJqvDYmUVVxnz/cGwU1swrHzPLWiOeDhpIwM6tA33uSbd+4+ABZxZUPx19lUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifFv6wLC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifFv6wLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268519; x=1781804519;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RIioLJSI97c7PpVGdj4zhyVYADhZ5rPrcBYYJKUi/sA=;
  b=ifFv6wLCQnYNQYkMJjRCA0Xwxmm+JdOaJQOMnRccCZ8rB387+daAbsk4
   gYeQYpej637fS5sg80hLmUNlLpBcdhNTfAjD1OxwfztWV7E2Bsq3Xzkk0
   f8RxB4M/sEs6q9OA8kIc2FopxV/jFxNV+WwBCeMqV7tWqwj1AW3BvxoPT
   YxbUIDurNdTstxh/EI/ysp2KSWG6QBVil06KKJYE5TuB2IShaA97YyoQ2
   UDHALOd38fLLIkNtcGbuU52Gy+f2xxjk9/iKV9Bn3B7ERRRqAhel1lxsr
   OGBEiJqfJwkxRiaFTGtolvcPJ3Ck3r4R63uYVV2OdHW3V9cOepUFf10eK
   g==;
X-CSE-ConnectionGUID: bG9F1mk1TS+JkhRu1pptog==
X-CSE-MsgGUID: MJ/6TRQiSf6BbKgD+MVtGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63180881"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63180881"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:41:58 -0700
X-CSE-ConnectionGUID: WdrYRsf1Rsua7FT0G2W5zw==
X-CSE-MsgGUID: k1cEwWGXROu2J6YZstpPiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150048291"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:41:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:41:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 10:41:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoiinuWLaXYZAdcFfzKpZTcqZ1QfOXN8RbqIxq6wFDys8UBuwXnowesskTGCNw819evlV0c22dfYIcjbsHqF7o3w4mgvK48pF5JJOmrHlKlCunP1uZjchS+OeKlQnM8WLZHSYQxlLjBcUu/TKlZBzxgQntCZp2um8Ds0zM5uJ2SYYmHtByAIsfXxJQoZuvobIWOYIasBsSpEPzuXdiTGDuEMwZcJO9fWLbePtDgZpikz1U1BEKAPiSR8v+Qlu1ggyU42U/K7jP1/RN1MNNKYzEOPuFJ6wls1Bjoc7BrC+MLoydH+RGikhcxPZMaREWQcT1dP694jk8bXG0E7cNiXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOzqeQMs66UZM1bCaoIp6UOco37eVrsKiO3Zwae02BI=;
 b=x7x/a59OHH1gPPCXF2Myd9wx2DvFu/EBYSzj0LtEvhBLRuvKCG34p8hbhujx+Q41MaVcajkuSTPD7jj/Xnn0ntsIOmG3li6klV0bmEfrf2a5PL8/cxgI5wnG6eUHJsi1xBdJoAyhtlIg46e6iEYOwt6vEbMtmALEAXF2zWMLuOsM6kjl+C0zmQENo8UQoLTLT47afknlnJ+sSaNLBuwwG155D5OdEd45RrPegrkfzgyFaeJ4AMQ2IoqtnWRhMwYTfTXy3nxKKjVGluYydTw/IGDMfQ1TUiwPbgdUu3yLFoI3Q48Gt35fCLanlTYYz8piET4M6uU/yqY3Ss3YyO7gRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF6D09CA9CB.namprd11.prod.outlook.com (2603:10b6:518:1::d2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 17:41:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 17:41:54 +0000
Message-ID: <119590ce-c994-4875-addc-6f395990d708@intel.com>
Date: Wed, 18 Jun 2025 10:41:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and struct
 remote
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, Lidong Yan
	<yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
 <xmqqcyb2uhth.fsf@gitster.g> <d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
 <xmqqldppu98s.fsf@gitster.g> <xmqq1prhguu3.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq1prhguu3.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF6D09CA9CB:EE_
X-MS-Office365-Filtering-Correlation-Id: b01c2edb-a550-4c55-69f8-08ddae8f69ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGRBUmpaYWxWNFo0a2h6OFU2eG8zSzRZekplV2VWcitoa0pWSWFwb3ZNaVgy?=
 =?utf-8?B?WGJnN2xCbXNWR3BMSTFzZmYwbE01TElDK3FyT0hySmJBVVlEWkw0b012aTVi?=
 =?utf-8?B?Ym1TaTAzRllNMitUVkZnaUN6SUlQcG15S3c1RFkrbWVmeGhJajYxM0MxMmdt?=
 =?utf-8?B?TjhSYWxKSkRyV3JNQTZaaGFWV1pUak0xZmRQaTBKdm84QjNnUDJ1cEJsNFB6?=
 =?utf-8?B?YzNZdEJSQ0g0bnBYU0ZhOUg1OHdOcE5xRTFWMlJabnl2ZFpZRzZTNTZtU2dW?=
 =?utf-8?B?VjliaXA1eWpaK090dW0wSk1vd044a3JWQkhRcjZnbVhVSWIvTncvTS94ZDdy?=
 =?utf-8?B?Z3B2endSMXJJNnlSOXhIcklJYng3NklCU1RWbUxtZUEyNGxrM1daNWZrd1pj?=
 =?utf-8?B?S1o2YjNzTVU5RGNwaHYzeDNjSlllV2NCZWdheFpnczFadXMxYnIxczk1aU9v?=
 =?utf-8?B?dVMvc0dsYk55d1QxLzNNa1BvM05Odm5TYkFTbHhZRmFOdEJFUVZidmlkVTMv?=
 =?utf-8?B?dTY4UURUcVhFZ3FQaWgxZ2sybFdkVTJGcDRiR29vWkVHNFNLUkFoSzBMaEFw?=
 =?utf-8?B?WkVFN1hyZnFLdVNCVUVwdDJPeGgxNlg3cXorZzdaaVJnWVdQU3QxTFc0Z09y?=
 =?utf-8?B?SDNJUXAwZTVzbGF2dFN1RGpFRmhCeG8vQk9tcUw2L2lhZURFYmpsSVAvQXBt?=
 =?utf-8?B?bU5yMW1LQTdZN2xOVEJ5Y083TXRkWkZMYTliaFFzY05oZzc5cWVReVA2ZVJQ?=
 =?utf-8?B?ZmY3NUFidmcrTVZRdHBybm53QjI2MmhYYXdJR0NweHJtclk3TjR0N2U4SEN4?=
 =?utf-8?B?RHd5S0JWeW95bjBrVmVXcWh2THBIMGJFdzRqcW1jLzNQR1F5cDVqdURZUlpR?=
 =?utf-8?B?aVpzbEJrVmNRbzB3NXZGR01FTzlqeVdPUm1qTWdTbmNJSUlEM2RyaHJjcGNG?=
 =?utf-8?B?M3B2Q3hLbWZkeEdyUUpqa0ZDb090anl4ek8xTWI4L3dWdVNMZ1MyaWd0d0NH?=
 =?utf-8?B?SGV4dlBRem1lcGgwUFJTNHptbWI1bzhxYWlFV2duWXZnWlU2eTFtb09QVndo?=
 =?utf-8?B?UkREU1JZQnI3V0E1YVhkbHA5Z1R0Z0VuRFFMTFpxM082T2JpcEI1MnlYUGZo?=
 =?utf-8?B?MnhZRnU3SWZrNmhJZXJ0RUlXTWdDNjlXRGptL3ZKVXRpT1JpY2RheEZ3aElp?=
 =?utf-8?B?ZFljalhlY25GQWladXlOOWhqaVZMOXY4MDFHcGhEQ0w4cm8zUHgyV2tiUmtm?=
 =?utf-8?B?c1BDTUtDUmZFZXg2ZGlQUk5PaE0rK3hEd3lBY082Sy9rN0o2cVoxaEhOeWg2?=
 =?utf-8?B?NUlBdnM0ZFMwalUwNVlOdno4SXZMdlRMd1o3ZVJ4SzV4RmtKdldKTEJERktP?=
 =?utf-8?B?RUNpQW93bFh3a05OZU9mNjh0cTAvTWNqcHRRU2crZnVEV1hVSzk5ajQ3azhX?=
 =?utf-8?B?V1NkaCtwWkpJWmVFVkpreE4rSWNkYzdRcjl4ZFI5NytVQnR0TDdPOGtpSEhv?=
 =?utf-8?B?OWJqK29rSkdpVStmbUk0Zkd6VE9VWWxId0ZBK3pKdmhPbUJkYitYcXJ0Rm4z?=
 =?utf-8?B?TDVoRG96RU9ySEZ5WSs3T29GaWUyeG96ZjJrbHZjVlRpdWIwQlJBelhMZDFt?=
 =?utf-8?B?a2dDR3pJTjl5RzIyZ3BKZjRLZXNtVkZJNHRGTVNYTjYxaURsSkdkRjMvUDI2?=
 =?utf-8?B?YjYwVGd3ZStDWnVKWlFBZnBhUDloVmQ2N3FKUEYzc3J5aGJseE9pcWh5Wnha?=
 =?utf-8?B?dnpISnZROEtuNFRMY3I1UjBhTE5rTHJ0WTB0RGRIQTJTUkQxM1ZaTHB5WnlQ?=
 =?utf-8?B?WURYN2hDOGRrRHQ3UnFSYkowQWdjaTExTGUraTNnOGIvajUvYXpqT0VocGpQ?=
 =?utf-8?B?SzJSM2c0bzVPdmswSmxadXY4MXlKQzVBM1gveS9sT0hoeXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmd6UlYxNWwzMmdjQ2xMUldnVTlmbmg3djE5WmpZaUo5YUtncThnZ2I2UEd4?=
 =?utf-8?B?RW55d3IxYlV2aEhmT1VaeVUwSFJST2tuMXo5OUxvMXMyNTJnOG0xekY4Uzhv?=
 =?utf-8?B?ZG42L2VZaEkwS2tLT2R0NTlVTEJ6bGpEeW1Qa0VhZ3pIejBuYW93QURoU3Zn?=
 =?utf-8?B?MzlmNUQ3NVZqUURVZmtLRUlFQzZEK1VPQ0I0eDBKeFpmaGdoQmdaMDJNNUNB?=
 =?utf-8?B?RmNwejdHYjI0eEFSTHBmOTlzdWNmWG9aTGF6TlB0ZDFJSFlCanNhWkw3R09O?=
 =?utf-8?B?djVNT2ViUnFMT0N1MlMzZmF3Ui8vOWQ3Mk8venFTeW5Fa1ZWRVJCblhEMHh6?=
 =?utf-8?B?TitqYUpkTG04Ri94amlORnBYV0RDN1NXQ2xZYnhjUjFHWWVqazl0MkpxSlVw?=
 =?utf-8?B?TlZ4NitVV08yL2JFMjkzNlBOZy9xNEtMWG5EZ2o3b0lDNE4yNW9TV2pQQmw2?=
 =?utf-8?B?ZUJmTnh4M1RrSVNyRllKVnhEYm9nZ2tMU1k4ZVV6RWhyYWt3dXlRZGpXd0ZH?=
 =?utf-8?B?Q0FEOEpWT3E5TWxnREhFRHRjK2pqM2tyUWI0Y2YyRHh6bmhlbXpHWjBMUi9I?=
 =?utf-8?B?MEhGS2RPMWgvNU0wQjNaRTZvWTR6N1NuZ2NncVVaQ29Icys0Zk56TWUyQ1NV?=
 =?utf-8?B?anh0ZmtrRW5NbzI5S2RGSmh4WmJEQkQyNTFobnJGdjRBeHBKdG40Q29pTWVB?=
 =?utf-8?B?eTNiTFFRNU9oK3B3ZUJCbFVGSlJoamx0Z3d6NzRtaW0rTGR3S3pRdTZoUUJN?=
 =?utf-8?B?UXVkT2FWY2lNWVVISWh2U0tnTW52V0VvdXM1cmQ5MjAwV2xpdjdBNEU5Tkh6?=
 =?utf-8?B?QWZ5V3dZK3N1dlV6RlpmemFTSkFWckpUUUxERWdVWHc5YU5HQTVPSEhYTjFs?=
 =?utf-8?B?dVkrMnhEOEJFcTg2ZHg3QlJYT2lPalFjOTVLOGxzKzNNdEZRRXlyVnIzZG9G?=
 =?utf-8?B?R2JoSzRrRWRUL3Nid0VDZDJZa3NqTWsyZzVXSjk1bkVGczh6bTB6SUYyUWFk?=
 =?utf-8?B?WENWUFlIVzFMakpJUWYycVRrQVZWSTA3MWx6dWZTdlB4bDducHJ2bTczc0tx?=
 =?utf-8?B?VDAxeXFkM001NWVVWXIvemFoVkZWUWs3K0NSMTU3ZUMwV3NsTDVXYzhRaG1B?=
 =?utf-8?B?aEZoeVJoT0pWVk1OeHd1QmRLaE5na0pvR2taYVFCNlF1KzlXVVRXYmhZR1Bs?=
 =?utf-8?B?Ukh4bklWYlJGdExJNThUZ1dTY1hodlZhc091VDNNNUl1alZJSFA4VXJDdlFh?=
 =?utf-8?B?d3p0cExMcXp5R04wTWhFM3EvSFM1NWsvSmRKOVUwbkNCNFpFZklaZmJrUjg1?=
 =?utf-8?B?ZG5xRXczWlVCRVMyTkIvQ0tOTUtQUndVK3FOdUFPbVRJK3BNWXR1QWhjUmtv?=
 =?utf-8?B?M3U5OVRoNUM1VVRVVi9EdFpVVmFPdElLZEVNZmFqZXFkeXJHMkZwRm9ZM3NC?=
 =?utf-8?B?QmYxN3krSU00WkZxclVVNEljbjcxSUp6Q2ZNMVpjQWdnVXlVMzZqU3JRZlVW?=
 =?utf-8?B?Uzdybkk4L3J3YzZGZEhYOVN0d2kvbkQ3TW9MeEZkc1JDUzd0eDVaTnYrWjBB?=
 =?utf-8?B?RTd1bTFhZ2tnMFBzL29NY3haSGJWSXFPUHpPcDFUK2l3MDRjdEhscm9WVU5u?=
 =?utf-8?B?QUd3Wk9wWlJ4VGVDMmU0TktITXUzK2dwVGVsb0h3WUFaaUd4THNFM0JSbVVj?=
 =?utf-8?B?bGk1Z3JCS21xNVZUYXNYZVcrQURTdUdySVpKVkM4R2VJaW5ZZGg2UzBpaCs1?=
 =?utf-8?B?MklsZjdvcFNWRFBiaHJXUFFSa2l4a0lmTDgwdFBVS1ZPMTY5L2xuaVliTVI3?=
 =?utf-8?B?YlBLajhKalVXOEo0cTBBamV6cDd2cElMWnRYanNXSlJjbkRWNGhjWWhnbkZt?=
 =?utf-8?B?bCtFZFZpNzF2Q0tmc2NETEZXTkVrczRoQUlPUHdRcjNsdnlpSkV6T0V2elda?=
 =?utf-8?B?dzkvcUswTEJ0NDNFdy8xVHJhWWxZTkR3REZZL3pYZ1ZoVmlHb0xMV2FyT2Q2?=
 =?utf-8?B?MUtJaVZFVmtuSXgxOTFnQnBEaks2SmpKV1pkdVpxWXNONEtzMGwzNEtzSjRy?=
 =?utf-8?B?MURMTGZ1cEQvZHYvUytuYkZ0cUYrbVRxWE9IYWE4K0xoSGlKdHRsRDlwaWVD?=
 =?utf-8?B?WUgwMzkyckZVN1hyTDZCcE5iZDQvYzB5VTloVGtjWE1SZ2JuQXJmSlpzcnIv?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b01c2edb-a550-4c55-69f8-08ddae8f69ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 17:41:54.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxP5dMBscekfs+ux1CzQsdivwqozV92heKzTiFn4b4v8EXUMwqOc5shs5yUNT3aqYbypTkMLhSuVhMD3w8ovvieEaCrnbTUPmN7IkB+BeBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6D09CA9CB
X-OriginatorOrg: intel.com



On 6/18/2025 4:20 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> We initialize branch->merge with set_merge() which is called by
>>> branch_get() and which is the only way for callers external to remote.c
>>> of getting a branch structure.
>>>
>>> The issue is that merge_nr can be non-zero because if no caller has done
>>> a branch_get() on the given branch, we still have merge_nr is non-zero
>>> and merge is NULL.
>>
>> Meaning merge_nr and merge are both uninitialized and unlikely to be
>> 0 and NULL?  What values do they have, and if they are left
>> uninitialized, shouldn't we be initializing them to predictable
>> values?
> 
> Ah, no, I was just being stupid.
> 
> We read configuration files and accumulate things in .merge_name[]
> while incrementing .merge_nr but until set_merge() is called, .merge
> is NULL.  We need to clear .merge[] only when it is not NULL, of
> course.  And for that, it may be more readable if we had two loops.
> 
> Thanks.
> 
> 
> 

Right. I think I like my solution of just eliminating merge_names
entirely. Unfortunately it looks like my mailer marked that content as
quoted when I pasted it in as an inline diff.
