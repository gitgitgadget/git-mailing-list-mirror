Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60279229B15
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721572; cv=fail; b=e356GFuswDBEaGlcjW+FDMg89O0wd/8FapfaDVDOVlCYOzGRv+wXkZ3PgzBn8DdLgk97FZbb3CnEw60nIKClVoJn2VS/wVrqwFc8hT9gh0KjxvNQfLOVmOR+vNUqo8LpfZOSnRqcvk6p3wPZ+smKC6p6dIDcuRTOw2uzaqWJsHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721572; c=relaxed/simple;
	bh=nc03j516I23pY1r7UVNDnZiUlGsW3UyAv7en2AD8XoM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2yOMB+cS9JGlqqVFIXPWinv69HJA+Dp6Y5VlwBBCoKmuvxWGdLmwM595wR6dqmzktcaRe/3IEEl2Dwct8rFpG2yyv4oV7938IUOHwrRgt0GJVvPZEcYFFjZXSYogAu4dKd4zNPlj2xidQyB6VWSjCeRHNF83jhKbG6UufWvEsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpuwujvK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpuwujvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750721571; x=1782257571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nc03j516I23pY1r7UVNDnZiUlGsW3UyAv7en2AD8XoM=;
  b=EpuwujvKckzRHZow70lXmOrOD0XrXs6/BOYLJ+XrrPcZ+9FnyUpi6kxi
   VjRcAbMxrWIUq3yJS7nQDCZwyvXNKXaL8isrBqinTl79C1drtVfQSJwMa
   9HePbfYLjuYpa0TwtYMIJmUalkrSlONHm/4Yh/Z6d75fxBsk4HJaxkNUU
   In7JoXPQygrEcWRZ1NPBbtJTHQ28xugKibX2CX9hp+ckweiWaJWKGbnUW
   BbiBTn/ZHZRzjmiNmgZK1/6JEC5vlAKE4pswBra/U+n9yPMZst8gIZETg
   PNy87Ard4ylF+IRFpfNxMd4sIV2M2/NdTvDosJfJs7bwo+5N7ytbFaDmB
   g==;
X-CSE-ConnectionGUID: rPSpRd6lQq+9jGXQdxLtRQ==
X-CSE-MsgGUID: nBh69SysRl6vvYnRRLYyBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52817100"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52817100"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:32:49 -0700
X-CSE-ConnectionGUID: ZFg2LkmdQeGpJBXp8Nek9Q==
X-CSE-MsgGUID: McyYIkNmQrSfCEt7GAV8PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152436169"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:32:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:32:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 16:32:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4uWDSzGGR7bxdwE9aEqc20oE3oJUUqmG8lKQSLItG9nn2ju4CL0uIhwrad6yc0a/bKayv8n5QigD1UJkLa409CVnXN21r53aeFUHNMm0dQEBbl1w0WXiMNvwf8BtwDVxGQEinWvWYDO8vJYPvM/QLshJbp4ib3G2x2F5uMul/mXRNqpoX0ZhrbBHpC1gWmPCOVvGSxp22cpqSYQU8K9BSrqxJL5IuuB/eOPTIURyL6uIwusT1zvbCdkmPZ+gh5R3/UvShkqVLQhy4RDDob9ZJ2AOlrGUPwPPhBP75T1UZjUo8lrqFeHao4nkhIhavNKvgcgW+ufjVKidmzxUhTtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiD2VG+91rigzgMVcISZHFuYXVZHpDncpuxomTXO8z8=;
 b=R7iTfFYjE4OCPhxqqYi5cpiUxlRMHmzthvjVb4rVAccc3r3tSVANkZ577w7ya7TUGjlWuz1zukWhMxl0eFnfOYcfkc2FzOgLlAw+Q16HNat09MtOI1RbYi8cPjUWXPwIq9vqQVhJ7O6YaN5FruP9we58Sa9URJiLTTmrlNHESYnjTZDxqXm10xWelGZa0J4mCrkK8AcTPL5Cs084QV8br4R0sQ78hAwsIRA4F1klYVgCN7D2iDLARpHnjK8ZhU+yAyuKhXdr0Qq0qvf+o2sxj6MhQJp166ze1olE4qBg53VA/8MTRv9BXN/M5u2jNAXkYkyKfnDDb4gjMhqeQON87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 23:32:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 23:32:36 +0000
Message-ID: <f11bf463-0005-43d2-b642-ede130d1f44c@intel.com>
Date: Mon, 23 Jun 2025 16:32:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
To: Phil Hord <phil.hord@gmail.com>, Jeff King <peff@peff.net>
CC: <git@vger.kernel.org>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <9cc42f04-856b-4967-8668-a47271af061c@intel.com>
 <20250619033746.GA1801319@coredump.intra.peff.net>
 <CABURp0p4d0JPg=-cW1OZdFQJ+vNT_0PDd9Rv3oz6toFGqGv5=g@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CABURp0p4d0JPg=-cW1OZdFQJ+vNT_0PDd9Rv3oz6toFGqGv5=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cec6f6-ea1c-448f-cd5e-08ddb2ae3ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWNiQnNHQVVidTZPWkRMaVQzb0FOYTFTd0ppeUNmOElwc3NqdEl6Nk9NNkFR?=
 =?utf-8?B?c1FpMUZjRG0ydXpzYXlIS1JsWEsxVlRYSjZXdjRGMXJsVVcvT0xpcHpGOW93?=
 =?utf-8?B?OWV0V3VJalVGT21LL3VXY1BQQUkvcmJTSUpDcFpER1hITlZXT2tLaDFqWE1F?=
 =?utf-8?B?RndpeVlVQ3ArNWtvTnlxTGlmVHNTa3RHZEJtZzJqcXlzaXphUTM0MmJaYTRZ?=
 =?utf-8?B?SEkvclJxK0RrNEY1VUNjZTY0MForNWZERmRsN1NzTXZ3SS91YjQ0Smlud1pC?=
 =?utf-8?B?QVZESHovemF5aFFGMnJMbzB3S3dOd1VFMWkzSHFISE9kQlNMUEhsVnZ6eDEr?=
 =?utf-8?B?ZmtUd2l5N29mVUo4N2Y5dzk4WUhCbzgvOGo2TGFONTBEQmprVGNkN3o5cDRU?=
 =?utf-8?B?TXlnbzRTNmZQVUpCS0ZNZnRIdjVUNTZtQXVCR1BGQTE0a21HTUw2SjE5bHMz?=
 =?utf-8?B?WjBwUzlaa29sWG0zUjRTazhXblRBeWw4Q29KZUJrOWVyMFR0UEM3Vmx4M2xH?=
 =?utf-8?B?Sld1YnpQQTZyZXRqaTRjNHVmUFpIemFZQnltZFMyenNFaXZ4bW5RQ29mOGwx?=
 =?utf-8?B?RXJMWDBxMkp5Sk4wcDRPUjczZE9qS2dvcHZZRWVXWGZSQWxaSVQ1T05TdmF2?=
 =?utf-8?B?QmduWjVTb21KemkzUktsZkVOUkpYVTBvdW1tck4wZGlGMlpKOEFLTmViUnV5?=
 =?utf-8?B?ekFud3FuYm12NzFMdWpMMWJ5QytzMXVKNWlQQktEWEY2L2E1SmtBKzA1NmpX?=
 =?utf-8?B?UXAzb1I4UFpmWFBMdUF2V1VmNXlVZjZHOERIUTZwYnl2RlRPKzdxVlcyNmhP?=
 =?utf-8?B?eTJIRHcwMW1DZ2k0RFRJcVhFTVIwSmJqWXM5VFdjSHhzNWxYNDRPdktGV0t1?=
 =?utf-8?B?SzNXK21yTFVQMWFhOG92S1ZZaklCSzFtRkQyUCt0bHVzd3Y3bE5aT0xlbG50?=
 =?utf-8?B?Zk5OV3VtUCtxQWN3L3lTcFV2cm1oYnFiaXdEaElROHBvdEJ1YkUxN0JaRHJ3?=
 =?utf-8?B?MGR6U2RJZDVQTVR5eVFUeHJOUzBubi8vblZKK3pwNXcyRkd2WVkrUFBJcm1j?=
 =?utf-8?B?T1gxZ3NBZmZQL3JaZlMzWi9lZXlKK1NFc1pxYWpQUGNBZnNqOUFUMUZheGJ6?=
 =?utf-8?B?TDNua2Z0bHNCSGdWOEVPQ2hrdEE2NUwvZXJIMkY4aGpoak9aWTdvUE9LWG5N?=
 =?utf-8?B?bzcyaGpmMlhyb284OHBFNFRoVU1sZ0tFcEYvWnQ5QXpuUExZTjNsLzhwTUhQ?=
 =?utf-8?B?d1psVVc2OFY1QlBhWk9GaGhoNndxa29vVGp2Z0dNQ0tNSW5Oa1dDUTkwNmRh?=
 =?utf-8?B?dElVYVFPYmFqTFY5QnhhMTRxcG5hVjdYWGxNSTFsbnJKdDNzTGU3bWROMVRj?=
 =?utf-8?B?UkwzWGNZYnhSaDVXMmVROVgzUStaUEVXVERZWXdGVHY3RGRWbkwvQk9nUURq?=
 =?utf-8?B?RUZrTytEdEFUNE9Ua043WHlwa1NTS2RkUzNwVVJQQnBoM2p2dzJCcW15aFo1?=
 =?utf-8?B?cE56azRFQXJ4NWdEVTAwUmRpQVd4Y1NYVkxhRXovNGx0YlhOL1BjcGVDVkNi?=
 =?utf-8?B?eE1XU2VwaDhqOTh4RVRidzhlY0pKSDBiWnB1dk5SeS93RXlPMVROSXVJdTNH?=
 =?utf-8?B?VTZnZ0MyQUVxWVZCVmxZcmJpb2c5YUMrTFIvSjRVc2xOdHVDM1FCOFFvVWg3?=
 =?utf-8?B?K2tyaTVONXdEKytZSTVmNjJLR3llUDNBbUcreDZkaFhZSjRGRSszT3BhNk9l?=
 =?utf-8?B?NXdiaHBCbTA2KzJIZHNDWCswK0JGVEdiQWcwcHhJcFZBSjVvT2dscU1MZkZ3?=
 =?utf-8?B?b2h1NFNQNy9kM01YcE9sUVZQc2IwRGZVb3VxL25hZXpJS3dWak5UT0NpSEdu?=
 =?utf-8?B?Z2txT3pnMEVTUWppR0lEb2JtcVlwN3RqaWpYY1g0UUIrT05VZVNscVB2Mkt4?=
 =?utf-8?Q?7WoXvAH0c1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVOdklEdG5kNUppZElmMzRRbndWUkpPL0ltRVd0bkZPMkEvcHNFaENjbGJs?=
 =?utf-8?B?ekdrVDN6d3l6ZUJZdlduVXJ3SFhXVWxmaGZrS3kxZnlSMzh5bjZKL2hGUGJh?=
 =?utf-8?B?dlMyMURXd3BrQ05GVGdCdFY5bkJtN0RwY2dkWDZuNVhVV3E3TFZvTWdRcGtE?=
 =?utf-8?B?UTJEc2RhQTFveFVaQTFjb29rWmpVY1VnZXErd1p3eEt6RFNoUVRHTGxhQ3FP?=
 =?utf-8?B?aWNyMWduTnB1UUgxOXArczk1bmNOb1VaUkVIS2tnOVh5WWZ5eWFlWEVKQ1Av?=
 =?utf-8?B?dG05QlZBM2lEZk1uS0hmaTlEWnpWZGl1RkZQakF0bHBpZU5Od2hBd2ppa0R0?=
 =?utf-8?B?N2ljOFJoWlpReEhBUzF6NzNFM1JvSC95UlFPYkJjOVRxSU4xemNzQVVQRkxM?=
 =?utf-8?B?bjFYT2Mxazc3ZDdkV2hJTHFKSHR3Ym1CVjRmY1RUZUQvUjhkYWpMVFlCY0xx?=
 =?utf-8?B?U2tPS1NOSFVwL2M0bFlkUDIvenNTbnBvOGQ0MUN1Q1hMZXJNbTRrWXIxWVBB?=
 =?utf-8?B?MHo1SkMzNllUWHJ5MVA3TkJwS2g3RHVZR25RczJBUDQ4dDc2cWt6cmppYlh5?=
 =?utf-8?B?OUhzODJEUjJyMmQ5OGlDZ2xPa09iRjNKNUJSUjRkYUJSRlZGS0piVURtd0lX?=
 =?utf-8?B?UXpkc2FwTUVlOTRrdEdwZ2tyaytzV0JTVWlJWGFIV3JHbEY5bEtKekFGcGJI?=
 =?utf-8?B?dkhBbFZLem9hclNLdlZrM2Jtbnl1clVwaVBJZGI1d3g3eWZtbHFoVXlFbHNx?=
 =?utf-8?B?cDNUZVFwcUpONTdJbjhvdGtKbUJLMkt1MDB6dEJacVgxMXp5THk3N3RRQVU4?=
 =?utf-8?B?Y3FFeXBnd1d0a3BpS0U1M1lyMm9vaVM0SDRlS1hzZDZvNi81S1YxSmh3S2Vr?=
 =?utf-8?B?QTllQmNBaFhxK3NkL2J3emxPbFlrOGRzdzBkblo5WXN0cVZZNVVEQUZXM2Vp?=
 =?utf-8?B?Z1RFZks3N1FiMFR3RHN0a1hjYzVSZ3JDUU9Ba3FLaUIxeEx5alpmbDFsK2xV?=
 =?utf-8?B?VWZkZitmL0YwOUpFOUdvd041bEJ0VXNwMW4wNUhGSGFwZG5JOS9SdVlyVk1r?=
 =?utf-8?B?a3FwUnN5KzhpMDRqQ0M0UVFKVWh0NTd0N1ZRblZDT1ZHcHFXamRtb0Nmb2JD?=
 =?utf-8?B?SGdHM3dGODhibzA1VFd5T3U1dEZtdEo4c0NTeXJobUxheTdwRlV4S1RiUlFx?=
 =?utf-8?B?WHhHbktmK0p6NnNkaVlTOE00Yy9maDFCWXdLaTV4VGIwS3dyb1N4NmdGVWNn?=
 =?utf-8?B?SWZIYTJaRDdJKzIrVmVOcnk5emNLTU5sU09iclJaNzVSaXQ2djAvc01QVnJL?=
 =?utf-8?B?bTFpL1YvUGRiMGt5emxndXlMSWxWaW8rWTh3aVFoWDV3ZzJpUFNJUXgrUUJr?=
 =?utf-8?B?eHkxNU52ZVhleGZVTmNMNktNODF0ODlwQ1hOOWFmbEZCNXFVc0RkS3o1Tkow?=
 =?utf-8?B?anlDdzVSNzJDSU1HQ2diekVrNGFOU1E1NHJVbUQ1Znl5emxpTGJoRnU5SUVw?=
 =?utf-8?B?Mi93OG4wQzBMMlMzWGJzVDFqWHRPR2srK2QzUUlXNUw3YkdTSE1WeFl5WGF2?=
 =?utf-8?B?N0VuTkE2Y0NYODBlR1V6ZFI5QzBCcmpjNUU3OEZvKzhzdGxiRU9obXQ3UnpF?=
 =?utf-8?B?Tk1jVk84dGl1MlZPbnVFSUIzMTZQMHUyc2hvNU5Yd2ZYTkR1ZEF4dk41L1U1?=
 =?utf-8?B?WFhpaDRFUjkwWnltZW80aTRHT05kZS8waGZrK2o3WUI5bitHL094Rko2WXc3?=
 =?utf-8?B?VWVqOHBYZzhWUUluYjZzNmtpTEV5ZVlzSGJxSVZjZWh6VVdQSUxjWVV5K1NL?=
 =?utf-8?B?QklNVy80VEpHZ09JYjVmQTcrMFBGd0RIcUVNWVl1V0hqZFI2d0JOQlhmUHNi?=
 =?utf-8?B?RnArZzR4dGJOODdpbFN4RlAyR1NUSEhKRERzS3htVFJYOExIZlh3TWV4WFYr?=
 =?utf-8?B?TEhINnEyaXdwV0hsZkg5bEpSQ3FpZGlXQys3SzljVzRJbUhlT2I4MzFyNk0x?=
 =?utf-8?B?MmNmT1o0dkFqNUpIQkVpYm5CVjMvZHlYTkJRY3B5WDh0b041T0FaeVRHQ1dI?=
 =?utf-8?B?TGIrN3dYMDdPb3oxVU1QeFdUZXFscHhOMXhKYTM1QnZlV2dicmdxeWZUcXZr?=
 =?utf-8?B?MlZtdFlnVUdvOXZidVVmN1JobHBVTUxWWWMrU1VKK1V2Q1JGQXFPalhXdTFZ?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cec6f6-ea1c-448f-cd5e-08ddb2ae3ca7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 23:32:36.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD4m81640EZHcQo6OCxjnAiujb2/1gZHvYGVjfSqseuLMknUvneKmzTmwPXyj2+fkt8pTPnL37OaWkf37ISJ5zrhVuu4eyy7PDoQnwtvm10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com



On 6/23/2025 4:11 PM, Phil Hord wrote:
> On Wed, Jun 18, 2025 at 8:37 PM Jeff King <peff@peff.net> wrote:
>> On Wed, Jun 18, 2025 at 04:15:03PM -0700, Jacob Keller wrote:
>>> On 6/18/2025 2:08 PM, Phil Hord wrote:
>>>> My patch fixes this for fetch, but it affects the command's output
> order.
>>>> Currently the results look like this:
>>>>
>>>>      - [deleted]     (none) -> origin/bar
>>>>        (origin/bar has become dangling)
>>>>      - [deleted]     (none) -> origin/baz
>>>>      - [deleted]     (none) -> origin/foo
>>>>        (origin/foo has become dangling)
>>>>      - [deleted]     (none) -> origin/frotz
>>>>
>>>> After my change, the order will change so the danglers are reported
> at the end.
>>>>
>>>>      - [deleted]     (none) -> origin/bar
>>>>      - [deleted]     (none) -> origin/baz
>>>>      - [deleted]     (none) -> origin/foo
>>>>      - [deleted]     (none) -> origin/frotz
>>>>        (origin/bar has become dangling)
>>>>        (origin/foo has become dangling)
>>>
>>> Personally, I like the later output. I have no idea why anyone would be
>>> specifically scripting something that depends on the ordering being such
>>> that dangling messages are printed immediately.
>>
>> I think the original ordering tells you which deletion caused the ref to
>> become dangling. Phil's example is a little confusing here:
>>
>>     - [deleted]     (none) -> origin/bar
>>       (origin/bar has become dangling)
>>
>> because the name is the same in both cases. A more likely output is that
>> origin/HEAD becomes dangling (since it's the only symref Git ever
>> automatically points at a tracking ref). E.g., in this:
>>
>>   git init repo
>>   cd repo
>>
>>   git commit --allow-empty -m foo
>>   git branch some
>>   git branch other
>>   git branch branches
>>
>>   git clone . child
>>   cur=$(git symbolic-ref --short HEAD)
>>   git checkout some
>>   git branch -d other branches $cur
>>
>>   cd child
>>   git fetch --prune
> 
> Thanks for the helpful demo and clarification of the real output.
> 
>> The final fetch output looks like:
>>
>>    - [deleted]         (none)     -> origin/branches
>>    - [deleted]         (none)     -> origin/main
>>      (refs/remotes/origin/HEAD has become dangling)
>>    - [deleted]         (none)     -> origin/other
>>
>> and we can see that the deletion of "main" is what caused the dangling.
>>
>> That said, I'm not sure I care that much. I didn't even know we had this
>> dangling message, and it's been around for over 15 years!
>>
>> If we did want to preserve the ordering, it could be done by taking two
>> passes (the first to create a reverse map of deletions to danglers, and
>> then the second to print each ref).
>>
>> Alternatively, the dangling message could just mention where it the
>> now-dangling symref points at, something like:
>>
>>    - [deleted]         (none)     -> origin/branches
>>    - [deleted]         (none)     -> origin/main
>>    - [deleted]         (none)     -> origin/other
>>      (refs/remotes/origin/HEAD points to the now-deleted origin/main)
> 
> I have a new patch that produces this:
> 
>     + git fetch --prune --dry-run
>     From /tmp/repo/.
>      - [deleted]                   (none)     -> origin/branches
>      - [deleted]                   (none)     -> origin/master
>      - [deleted]                   (none)     -> origin/other
>        origin/HEAD will become dangling after origin/master is deleted
> 


It is a bit weird that this says "will become dangling after <ref> is
deleted" because the deletion already happened.
