Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519C30C60A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738016; cv=fail; b=jdhHtQFM5u0zemlJEyqL5Lt9+ctWGsro92f+y2kv61a6wFhl1K3F3G1f9GQUC5aJHIGLlwcBbVqnYP4/YqOQTF0XAHkgfx+s8xTwRxuFPs+a1o9KqzS+hZXCG/5BcFh5ihuAs115/E+3yAc6W/+LGbfiW1n8g9B1C/8/Dlzk5pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738016; c=relaxed/simple;
	bh=45P/7DfvMyWfPqYByU+AmQR7ny8yDqr880cR/Pmo++0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejuJhRrfJ9SUf1UkOkvutPU6Ftvt5l6SckOVK15Sl00v688x6xUhqKC4jmUYGeIHYNGU/2nVIjBfxahvIZN8ImXgEFeECehPrUmzXAwxIpjDZVGXG0w8gVq6xTZiz7gq3vDUBiawp+NJIjByhvQ/yiktrXbN6I8WQybWpBuEw98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJBpC5Si; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJBpC5Si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758738015; x=1790274015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=45P/7DfvMyWfPqYByU+AmQR7ny8yDqr880cR/Pmo++0=;
  b=VJBpC5Sik/e5JedIs/vKbO9wewGa5yqrAABkOD9BgS1c5F8QNfx7lZ2o
   v1ffLuw0nMAn/hRRINxWyAskSZDGIg65VdCE6QWcTr86+FbEiWKiKA+bN
   pWRLChTIzNgK1NIuVZ80YcXIVyXjrXqSEh01SnHhADeIKsviK1hG2k1qm
   K99N1ln8QCB2W+0sFEgcTiim8t5CtBCcxbJnFHf47kl/sM8YZSYQ+rgMZ
   PLhCPvoWpE67aLuaNoTIt/+owLg4mdPlP5toxd4SyaT9t1qs2fT/VtVES
   Njs3DEQRIlG5514OOiVg7YqolpVAUMP6v1AmjS8cf7Z/drTaGgChzHbhN
   Q==;
X-CSE-ConnectionGUID: kaB8tMlcRxGHNPuZ9kN+Ew==
X-CSE-MsgGUID: n+e0baQ8RwaMVy26mjKKEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64883164"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="asc'?scan'208";a="64883164"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:20:14 -0700
X-CSE-ConnectionGUID: dr724QNbQqOAHswc1ifc4w==
X-CSE-MsgGUID: cvgnei6+Tx2itRE215Zqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="asc'?scan'208";a="181484444"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:20:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 11:20:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 11:20:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 11:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf9PQl8ZYGXFI3N6s3LRb0myxD/K25ilKohWyD7ICq5eMrI7eZ7PfCer2dbM9+qheoVWvlZvb0Q0KXh59j1ZsCXHd7la+mJQ9a6Szm+QSuWSO0NfF+jiYpqUpgo/86O7JZsgvYAxEivyZSg1HLREOHT27LCWYAayFUf2Q9WxMfIrWWe4FtKQNPQMcpv46ekh+zjH11oqnk6N/cfxjE5WP6EwchcEfXDaQwvDA6fm/GUyMKRbFQwcItmx7qzIYNZGNSr5EG+VvSRaD8LFRWkPFyX5kj7RvB7rfAh46Xpyp4/F9+MmobjAaTwmOjFQwe8PZ6bLaNUXY4fidpm/Beasgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45P/7DfvMyWfPqYByU+AmQR7ny8yDqr880cR/Pmo++0=;
 b=W6o6uswnI1r8oIlyZeBRmnY1rH/xEb//QNeO4pXGD082sABrfe9jp9uPhvUn6WFtSo+dbgCInr5iGck3kWggYycltffFAsKwPwl/1kASg/Y2LNbTEImjHwbhwpa2/r4eDdsR+9FR2Dkg1y8mN80xCyHH0q7r1e9orC18vstHtU0Zl4UJRDgX0LB0Sxr+YjO08UwL9iXQSVnDNThgkDViGMbjXk6uqyNbw0hXf+6fNe8UT62cAIT8RQE2hfc1U5FzZ6xB3TORNij3YVArsCFPk5Tf9XjkcAESzZ92fI54HV7DT/jG89pzYwB6x2RfQ2ztbuujzYGx5BUtNvR79KJxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 18:20:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 18:20:01 +0000
Message-ID: <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
Date: Wed, 24 Sep 2025 11:19:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
 <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
 <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------zGlBEOOM1NrZhKO0dsxHf60G"
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6298d3-1f74-4ae5-c015-08ddfb96f8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjBOa3NiZjlBSk1yQklQb3Irajl1bXN1NXFPSjkzcDVpY1hhdmsvOFZBa1BI?=
 =?utf-8?B?bVVpRENMMEZma3lBMUpldEdRVlFzYVVFd3FNV0V3OUJkNFJjUHMwRXFRZkFH?=
 =?utf-8?B?MC9DVzVhc3FVSHgyVnYwbXRvbTRPSk1FRWJpMFQyMG4yUlI4N2dMWm5GK2NP?=
 =?utf-8?B?VlZmRXNBd3MwRzEwbFpzT3FiRnpLM09GY1VxcVRuR0pjOHJHakgrYkFvVXlD?=
 =?utf-8?B?RWxXb3pNdEFpZ0o1aVcySXI2azB6SVpkb2FkYWdTZVRYK3JxSlQ1djZNRHZZ?=
 =?utf-8?B?d3NpcjdPQ1ZvMHg5TWlHSHlmblJlNXF6NVdnUVpwcnZtWjJ4NDdmK1ZEU0tL?=
 =?utf-8?B?NnZjdU5OYUhwUVVxVFZyMlhlczBrMkVnVW5uMTJPRHJsOHhOUmIzRGNnLzRQ?=
 =?utf-8?B?aHh5SzJTblladFAzYWRFSFc0UjhvTnhoam5LTlZlaDNiVlNUQ0h6bWkxWmVF?=
 =?utf-8?B?bm5OeTZTRGJRbTJVYXJSSlR5OHZBQjNxelg5ckhWVktoNGlWOXh0dHIzeFp2?=
 =?utf-8?B?MndYZzJUN1laYTJCMUdhb0NIc1ZPUXhXUEd0Qml4d3Q0eUpGZ2lHcFgwR1Q2?=
 =?utf-8?B?alNSbDQ4eXhYTWZGc1J1WERWTlU2emtuR0VRenZiOWtqSUdwcnlpcmRya0My?=
 =?utf-8?B?WmhXdWNyem45Z1VBcHdXNWIxNG8xZVU0c3NTUytuSFRMMElHK3hNZVZJWDRW?=
 =?utf-8?B?TzZmcWNKTFM2SnQzYVNqTmtmOXZHUW8wWnVWeDQyRlUyazJtOHhoMkYyS0c2?=
 =?utf-8?B?YUZCVHdKMjdtSGRldDIwajRCZk1yUlpoRmsvMTdxSWlSdUlWWktJSXVWUmNJ?=
 =?utf-8?B?ZGxRWGRYeVExSm1yTHNYNmZ2QTZmM3RkUGVGNk9EblozMmFUYzM0b05oZlBa?=
 =?utf-8?B?ZHRlL3hxS0FvTW9wVlRVeHpmdE9sUkVUYVhKSTFUN2ZIZlBGMWNJcEVuTmhx?=
 =?utf-8?B?NU5VOUNUYURBQUxwUndvU1hld002MXpySVVyWTJMd1JoUXNWdVRqbDBXN2po?=
 =?utf-8?B?TVVKTGpIMktwV3RpNFYwMDAramFtbWVVOVFoYU16YmtSZ29PcmJTTFpoTmth?=
 =?utf-8?B?KzZ2ZmFtRms3SDNQNFYrL3picGJDemJlMklNSXY5d2FmR3Zld3E0K0NUTHpX?=
 =?utf-8?B?REhBbHdaYllVMDJvNnloR1p0RE81MWQvTjN5QXNydEV2Vk1SVmxPeXN2a2Nw?=
 =?utf-8?B?SUlqNm4vei9ZOXpRY3VZdlhNdTZ5Tjg1NnJqTnpzZGUzNkluV0JJNklOMUtX?=
 =?utf-8?B?ZmtPbWlEVjdESXc1dlljQTFZS0NnMDg2ZEhlOWF6T05IRDVxNW9MWUI5ai80?=
 =?utf-8?B?R2dHMFU5SDVYTmJQZXgxbnJaVTlYRCtTVlNRWWFuS01nOHFJam5NSGFVYk5a?=
 =?utf-8?B?UzZ5S3dPMVN1MUtYMzh1VzRDMjN5YWpnSkZ4N0ttL1BmY1NyRE5xL3JUeGRE?=
 =?utf-8?B?M0pnWFQ1QkNEa0xnWmxHSFNGS253VWRvR1VZNWc5eElDb05yQWwwejVXRGJ1?=
 =?utf-8?B?VXZXRDBIclg4enZpRXllSzhyL0kwSUg2RWIrRkV4OHg4bE5ZdkhXSWpHVXlt?=
 =?utf-8?B?Um1peHBkVXVWTzRxNURGVHRCZ2l1cWNPOFQ4aXpPTEx2RGU1UmIwalUzOFJn?=
 =?utf-8?B?WXBVeU85V2doZS9HaThNQnRnR3Q4Skc1RXQ4Y0FseE1kcTBKcDRkZ1QrMHVV?=
 =?utf-8?B?aUNVSCtSaU0vUHFieWNDYUNVdFYxVUhZYWxJaS9PbGZ6bTYrS0JOYmlhcU01?=
 =?utf-8?B?U3RzOTVVUFBqRHVpMi9WODJacDJ1bmxBemFwNW43YWtQeHFpSXZybllUQkVQ?=
 =?utf-8?B?d2lQSFVmYVNnakdQdjRxREZzb0FXaldvWTlXemNSZzFyb2s1S2JDcERDejZU?=
 =?utf-8?B?RGZISUxKR2FEc2ROZWNLTHZWU3ZSRTlBWUFqS3BaVldnYWRuRmpBaXdydU53?=
 =?utf-8?Q?RrU3K7753rY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkYwMGs2ZG9zU3ArUEQydmUwZ2JmblhSOGRSY1dKbWViWTFtNlYxd0hOSEpZ?=
 =?utf-8?B?SHpVQkRMT2NhcGNNNVJCRjhKbzhuTXZVM0RmRmViTlh5M2tFUzdpcUhQcDEx?=
 =?utf-8?B?cGdJZ3pza25oWW1PcUNyNDhRaGV3SVpkajkzMVpvSmNGeDhzUklHM0JoRDZK?=
 =?utf-8?B?MFhYM2t2bEJpUjJzd3Y5M1hFUVNUY2lybVNqT3VkZUlXSkQ0ejhScDM2aW1X?=
 =?utf-8?B?aDVVTWUwOWZwWDRpOXBGTEdqaTNtMFErL1BxenY1d3psUTZJY2s5OTFXZCtP?=
 =?utf-8?B?U1FFZE9OeVlrZVNDbFZZelhoc1o0WkRwUU5TZituWG9oZjlLS1duQWh2UFRo?=
 =?utf-8?B?SUVrWTBYYlNXSXE2RXZVeVNTUm05eU5XSzk2Ry9zMDhDMlFreW5kM2MyZ21m?=
 =?utf-8?B?N2RaRFljSXdMYmM2VDhMbFBuclNuSHErbGxsRmgxUnYrdW1zWUxQOTFGUi81?=
 =?utf-8?B?YmZwYkdFQjZRUm5QTFI5RVU3K3ZRNWt0UUU3QUZHY2ZOVGJxbHBWQytqUzhn?=
 =?utf-8?B?ZVdubWhZUXphSG02QnVkRUFBeFI2c0ZGbFZvTGtZcUVwK1lmN1A4Y0VJMVEy?=
 =?utf-8?B?b05VeWFQc0cvaFdLc0wvWXdNZGR5MWdhTFJ1UWV2a3JqVHhwZ1JMbm5GT3hh?=
 =?utf-8?B?R3ZaRVBEclVMbHhXVzZKRlVSOFlmNlhEelNCeDBHZ1ZWQW92NGlWekV6WHdx?=
 =?utf-8?B?Vk05ZzlvOVg2NFVndGJQL0VwRERRNVZwM0M1ZktiM0p0Z0VvdzdYV2hlZ0RU?=
 =?utf-8?B?SXVneEs4MlViU1dSa096Vkc0b0hhbUdEZkg2aXlNZk9TbHE1bHJ3M3hhL21s?=
 =?utf-8?B?alJJbHBua1RhVUNHYUFGblp6TWdQdm9XVGlFcmNzaEcxc3ovWVI1cXRTU2pN?=
 =?utf-8?B?THo2ZmdMbTE5RXpnZTVlRGpzNXVnemNHVHJTdC9qSkFaZ25LVlJZcSs2Vmht?=
 =?utf-8?B?MnVodHg3S096T3Z3YWp1T0R1QXdXTmJCRzZOOFBrUkFUVnE5OEJ2VTVYc3J6?=
 =?utf-8?B?VzdIeFZra1BEUTBoQVdOMFZtSXlKN0U4QkxMTTZVdDIrUWxsNzB0Z1ZuTVVS?=
 =?utf-8?B?SnI1Q3Z6RGFKc3lUem5yc1JpVnVLUVZ5L2hrNDk0QnpxY0JNMkEvSzM2VWk5?=
 =?utf-8?B?ZG9XNnhxMjB3dUNqQ3l4djl2Z2g2UUFIbmwvVHd4ckJuVDZNb0NOZXF1Ukxj?=
 =?utf-8?B?L3U4ZEZreUUwMHgwRVJwQ1dDYi8yUm5CZ0IzVXlVdmxqa2lqaUtPTmdhbU0v?=
 =?utf-8?B?blFuQ0l3dlZZRS9hRzZJWC9ZNkYrQ1VwNVhROGNCTXdZR0FxTk5WNWJJS3BX?=
 =?utf-8?B?WEZ2TFdFZlBHM3hQQStTVm5VRUFTbSsxYUJIV1QyWmFhYXpUTWd5MXY3dW9h?=
 =?utf-8?B?QTZiYzROazh6N0RNYWZEOFlaMUZpM1ZnZUxodG1HTlJxZ2h5MHdkYzVPUkhr?=
 =?utf-8?B?Q2tHRjJmM09ENHFXMEZWNE5mTDE5OXJuNmRwZGVod1hBVkI2TUJaUldVSlFu?=
 =?utf-8?B?NDQ1dTlTSG1BS1RkYzVpcDQ1b1ErWUx1cGlXVnpZbWdWN1FFRUNuZVg4L0hG?=
 =?utf-8?B?MDJvcUh2cVlIeTg0cTVLUklXLzhqTTYrM0FzWDJiNitVMklic2tGajBzUi9q?=
 =?utf-8?B?cFIzR1FRcFgrQTNWQ1UvUGpVOGhIYWNNZGZyMFVDK2NzYzl5YnVuSlQ2V2Vu?=
 =?utf-8?B?eHVGQXV3K2VyZGpVK2lTOThIclRiVnA2ZmZHdFpJSGNYWE1HNjZKeGhXd2s0?=
 =?utf-8?B?dlNFNkk4d2t4NkFtV0tKN0xyRHV3b2w5ZlFVaExSK05ncUlWTER5VWJtaGd4?=
 =?utf-8?B?cDRtaWVZdHgyb2cvTitYNkM5UE91c1BuTzhteXMrZzV3a0JEemUyQy8vc1VL?=
 =?utf-8?B?Q2tkQjJFQnNMV1grUHd6eXBGNnJHTUNvYXRaait0YlNGZzRoYnJqMlp2dmVY?=
 =?utf-8?B?RkxYaXRIbFExbHQwNGNhcTRGRjEvelRJdGZuNzdqc2lON1h5bHg3aVBJUFVU?=
 =?utf-8?B?ejYyRC9qck53NlU3UHVqanRTVEd2WGIrOFNkWjdoZkJvWXpvWlRMd21oaisz?=
 =?utf-8?B?d0xaalMveDVpb2JnQXFGWjJsNlVEMHB1Nk1zQnVnWUVIZTJWTC9CdXBFZ3My?=
 =?utf-8?B?MkppOHNXN1pHNG14Q2FIYVBwcnhsQkJKeEw0VHNCWWsxM1dtNHpQOGFRVjdx?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6298d3-1f74-4ae5-c015-08ddfb96f8ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:20:01.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZVBBcgepcDcZiYONXoZB5sXRHMOsTadYuaSaFHdvcnDHFgeoLH+rPvP4HrjrcPIpUTDifvxED3gHw/WM+ndLFE0e51NeDpUZoWBTi62+88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com

--------------zGlBEOOM1NrZhKO0dsxHf60G
Content-Type: multipart/mixed; boundary="------------Tfzzpj1txNlubRF8t1F8y1cD";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
 <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
 <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
In-Reply-To: <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------Tfzzpj1txNlubRF8t1F8y1cD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/24/2025 4:19 AM, Johannes Schindelin wrote:
> Hi Jacob,
>=20
> On Tue, 23 Sep 2025, Jacob Keller wrote:
>=20
>> On 9/23/2025 7:57 AM, Johannes Schindelin wrote:
>>
>>> However, this makes me wonder whether the logic itself is sound? It i=
s
>>> not immediately obvious to me why the `paths[0]` and `paths[1]` value=
s
>>> aren't matched against the pathspec yet their entirety is seemingly
>>> skipped in `read_directory_contents()`?
>>
>> I recall fiddling a lot to try and get this working. The idea here is
>> that fixup_paths does some conversions to handle the DWIM logic where =
a
>> "diff D F" becomes "diff D/F F". It returns true if both paths are
>> directories, so we only enter this block when both paths are
>> directories. (Which is required because we only support pathspec
>> limiting for directory differences).
>=20
> I do wonder, after seeing that `read_directory_contents()` has to
> (re-)construct a complete `strbuf` in every single invocation whether i=
t
> would make more sense to construct two `strbuf`s in `diff_no_index()` a=
nd
> pass those along to `queue_diff()` _instead_ of `skip1`/`skip2`. The
> `queue_diff()` function would then have to extend these
> `strbuf`s as it already does with `buffer1`/`buffer2`.
>=20
> That would avoid appending the same prefix only to remove it right away=

> (with a not exactly cheap `memmove()`) during every
> `read_directory_contents()` invocation, too, in addition to allocating =
and
> releasing those `strbuf`s over and over again.
>=20
> Ciao,
> Johannes

Something like that is probably simpler, but I'd need to figure out how
to do things right. I'm also not 100% certain how much it would save on
computation.

What we ultimately want to construct is the ability to figure out that
we're given A/B/C/D path and a filename E and a prefix A/B, we want to
get C/D/E for use with the pathspec matching logic.

So we still need to do some sort of prefix matching here, because
queue_diff gets (and indeed, needs) the full path for its main
non-pathspec purpose.

--------------Tfzzpj1txNlubRF8t1F8y1cD--

--------------zGlBEOOM1NrZhKO0dsxHf60G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNQ2TgUDAAAAAAAKCRBqll0+bw8o6BDw
AP9LrGPVptbVV7aC4nDMjhx2EA3HCPRf7Dy9ZtGra2DChgEAqACO1CkdBiETtlYoEu1t+E8t9Vgy
5eH8qYPDetaPZAk=
=3vdT
-----END PGP SIGNATURE-----

--------------zGlBEOOM1NrZhKO0dsxHf60G--
