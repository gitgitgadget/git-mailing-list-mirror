Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333F1F875C
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780943; cv=fail; b=K3zxl6+tFuRbqjYk0Oc4hxkaW/t8jHi7dS//qbO1SlozhUX8bQTpezr2eqI831/CeOUu9x3D0scPCMO9KBaI2JfTELA+eoH5xOrEe5dPXr+ZqpLlWo5Ny7LxsX43w+E7XWzKy3/PSTiajQEBRyrgmA9LQeLkDw4odhEleJR16Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780943; c=relaxed/simple;
	bh=NpSuq618YTqzbB7Ai/5GesYlgC3gB97yDt1Ly4aPNRw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YMxxvyzYU2b6Na+rB5aG6e5HH6tZSgj0Un3e/McpdmZwri+lhUUAjuhmulProvt4fdtp3QSNSamwi8EjALJHqxhhjNDI5JBu7mlhJ90ZKV1JN4w+/AbmajmZRDDP5yFSFbaBuFyGeFSoAmiRuj5xHFx1vR0hCCjMo6Mr0AjYHtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyPfjexu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyPfjexu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780942; x=1779316942;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpSuq618YTqzbB7Ai/5GesYlgC3gB97yDt1Ly4aPNRw=;
  b=AyPfjexuva3cFhJE3RujxyWq/y8sbQ9Xg0aDyyGzLzv2lP+OIXyaovA0
   ry/jDhzGU7u7NHFdJuynmI41u47uW8wqPGNFXr37/RkXwzIuXuJ+Qovki
   pBRHWn/p3ls95h+Bx98s3CvBFr8qndOdO8CsvTX/lJYJ5L7GXejacdmwR
   qXFrib4SbYf1yd956BDGhgfEvKh4zu6yh55GAycMDHuUkIOxYkolcoVBs
   npnZBKTEvJev3mXzoJ6+rXRXO/DDyWUwjKYRjyA8wNuOSgODVQjIkWP62
   AsXEGpDshLhKo5S9gUJ7MFpbfn4ph4s9zv06C4pPxKXLxkohoUYEPqO6l
   g==;
X-CSE-ConnectionGUID: wMG6YotUT/C4qjeEQqzJqw==
X-CSE-MsgGUID: uv9MXz7zQx6fLLn5TuY1mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49719827"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49719827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:42:19 -0700
X-CSE-ConnectionGUID: bRjhrJUfRAe8KUBHiZPNwA==
X-CSE-MsgGUID: yxuwruIDS0ycuDYW4cOSTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140760451"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:42:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 15:42:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 15:42:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 15:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijdG4OD+oaoES5LxDNQt/XUNaNci6hVPz7wpBKudrLWJrEBGtzmsXbpqkZ4Af5+UHfUoWiequ6h6VLVS6XjebfpZp019r3OfsN6iERL5DYfNDDIWbNIhM2kUB21hAxoZguUurpdWDfJLuKhgZ6ASELh5dDDt3XtYfbBAE/tgsAXe5/Npkxltg4Na4vTVi7+jfHLtWM8DTpa1Glj6RYWZsX7nRXxM1rxqM3VYHq/TTk8qqgtNgBVC42ZMc61Dw1vI2Ay/Kw9oU9ehWESz5TY2iDWVrWkFPul5h0kI82y9cqeHjPS305F/eRmyTwhkkbew7gUbhshjh5TUQc0TVuEEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8q76py3zKQpoEqvPXooGfTb2wri+fj3If02TVAoBvg=;
 b=vWp2kuuAsl1IvPEybgRuPhR1kMkjUGEOBRcAAtrJB7mUQco0mLhvqW0TssIiE126o/VvrcymICOt4opvxTbEyyMJhUnDPW3hqu59mr87zdvlMX7KFdI6HoHsWe3qR1wYHvovmmjlKixeB6NEME4n4dkgsbUgIC6HBgwjGps3NjFn15gxOsOErT5HqPTfssFtYepzXB9st3gqOr/a2AYNchOg21UQiV24qZb4isjRlYaovxYTjk+R6FaasuvcZIX4QSZDQJkvpKGqhNWZIcEUp69wyCHGksI5uNRcbs5+0kC0Fd+GWRYS5gm7ESXr6NFfDhibexuWA18Qdh2/s+e/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB8991.namprd11.prod.outlook.com (2603:10b6:208:55e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 22:42:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 22:42:10 +0000
Message-ID: <85b74be2-6fb9-4a00-aa8f-f6e25c383e91@intel.com>
Date: Tue, 20 May 2025 15:42:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] pathspec: add flag to indicate operation without
 repository
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
 <20250520000125.2162144-4-jacob.e.keller@intel.com>
 <xmqqwmabjoww.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqwmabjoww.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: f73dee8a-1e09-443b-c981-08dd97ef8e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3IxVlZJcDdQbi84Sm9Ic3JCZlVxU0tkb0RJTWMwUmM1NnEwV3pWc2syUEEw?=
 =?utf-8?B?NW5QdnV3S3AvbHE2K2JnUktzVE9TeU40bHVWMDJ1ZjVBNEVFWE15OVExOFMw?=
 =?utf-8?B?YjNBNEFGUHVTSnI4TEdnRSsvUzFwSThIY0RwZDN0bElIbElxOXRkRU5zT0hZ?=
 =?utf-8?B?R1owOSticEVvR3FkZEZKajNESnpHYkV2eDF0d2VkZDZwMTdmN25TZ0VPa3FK?=
 =?utf-8?B?a1NpSjh3N3FZV0ZPVklMbnZqWER6bXVpZ2tnY1BJK3Awa0dHTThkSjJtQnFX?=
 =?utf-8?B?dFd6a1loNmV5b0c5UHdRS3JoUWRMVGhWck5IOS9hMU5vS2ZCR29PNWxYTlJ3?=
 =?utf-8?B?c3hqdnIvSU5BVHFTNmFaNC8wTlFFTjB0OXBsMUxBVlpTVzhwVGRQc0o0OWgz?=
 =?utf-8?B?ZnJUS29ERHpPK1Q1NnlIeEFHdFc0UndwMW4wd0hkUG0vZWtxK3JNcE1CZEFR?=
 =?utf-8?B?SHl1aDdMWlI1dkJFbUFISnArN1ZBYW94MGdGb3dTcTBGTGNDNTNUUzNNQVcz?=
 =?utf-8?B?Szh6S3htN3NwckpHTVBTNHNqMVg0RGF3VVVRQVQwdUFDMDBaVEJabm1YeUph?=
 =?utf-8?B?UVp1N0RIdVVHL1BzMmpyUmM0R2lKSlJXUE55U0h4SEdOK25vM2pwdVVuUEVp?=
 =?utf-8?B?cGtFbnVvV3RLUEJ3TTA3UVRPVGlaRzBiSTczeDREaFFucjZIUWhGWXJXVHl1?=
 =?utf-8?B?Tm1VeGdmOEdxdDV3S0I4dVFYaStZeHZzZWdIWitoYlI1WFlvcGpUY3JuTitm?=
 =?utf-8?B?NmpoV0JINWR4Zjc4eURleUQ3S3FESGg4bG5rbm5ZSnZZa2pUcXNGYnZzUGJX?=
 =?utf-8?B?SEpJUDBFMkRjV1NMbHBNOFAzY2pkZXJJM2c3SEx4ekV0WEFQdFp1NmV1MmdQ?=
 =?utf-8?B?cml1eFUvQmpMTVo5Qkl6Q1Q0b0ZRSHBkc0JPL0UvMVhGQlFwN1hHQ1MxdVVv?=
 =?utf-8?B?eDZRbEY3T0Z0R29BdndSRmJDRjNKOHBqK2ZOOEJZeU5jL1BIVjVKcVV1cmF1?=
 =?utf-8?B?NTEzaHZ2R2NCV21TeWJJWlh3U0RDQXNSbUxFckpMdVdYWUZqbnEyNkxhV1Q5?=
 =?utf-8?B?T0FudDR6dlp0cGt0enVkeW42bjJmbGYyenVGS3ZibTR3VEQ0VUZLcE1QU0Qx?=
 =?utf-8?B?SnJMMkc5L0l5bnF3Q3pEOWIxTW5TYktpM0U5YWtVRmNNS0I0Wk5ZYVZNaXpo?=
 =?utf-8?B?MnQzVzlUaHJraVBOaGwxQmhVNC95N1J0OXBUWjNVN0JtYTJYNE1YV2dVeUJo?=
 =?utf-8?B?bTN2Tmpub1NMOHNhSjBnZmxZZjJkeWpmMk42OFNlT2FJbXZmaW1iUmxxTmw2?=
 =?utf-8?B?NWJWV0tFb3k2VldsUjM4UTAwTzVaMDZIREZxNzlScEVza29MZmxsVXhLV00x?=
 =?utf-8?B?WGltM2N0L0dZNC91SFRZS1JYTEJ4aHVCUEw2c2FyMlRQMzF0ZCtiZm1MZnRF?=
 =?utf-8?B?ZlpZVVptMnVDaHYvaHErN1Y2d0Zob1UxTFZPZGplbXFGQzYramRvK0hRNUJp?=
 =?utf-8?B?TG1qM2p6UWV4V0dsUVVyRXJqRXZQSHpQRUI2K1AzV0NuOU9qdG4zaEhFUGJP?=
 =?utf-8?B?RGNkR2pTK3ptblk0NENScmpLYmY1Qy9Ka1lyeGZPeGNMc0ZjUVF3RGU1dGE3?=
 =?utf-8?B?a2NuRFZ4MFFjWHc3ZmFlWWF4bm1aeUZHbFV1RnB5WDNEdHJhejBGeWs2WCtN?=
 =?utf-8?B?WHNNbUdSWWxFaVMwclFsRlhpcEVTenRzdlN1UkZmYVJnMVBHZWttN3lnaXdQ?=
 =?utf-8?B?bDNiZ3V5VnJZYW5sejhiZEh6QnRqaUNmcENER1lqWndXSmE5Zi9lV2k1K0JE?=
 =?utf-8?B?R0UzTlZwYTNoa2ZhQUdmMzRjKzZNTzNBeVlpckVjZlJJWjFwUUNLbXl3MTJw?=
 =?utf-8?B?QmlqV1dnRENxVC93OGorOC8xRnZZeGdQVEpQVi9wUG5nR1d5bE9aaUZ5Z1dz?=
 =?utf-8?Q?sale/IPWquw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmJqV2pxdHhhTUl0OWRDZDFqVUt6RS80VU9HUHR3Z2xpUG44ektvTFZhRmd3?=
 =?utf-8?B?RlQ2V2ppMzhISitiS2lEcW5lOTlUM2h6cXRDVzdOOHYwdHl5UlRZOEhUY2Fm?=
 =?utf-8?B?N1VHUTRCRnhyR1FCNTA3R1pYNHErRCt0cmZqSmtiVUI0QUtoOHhwSDJhK2JO?=
 =?utf-8?B?b2JpVWhMUUFyMmRqb1NHcGQ4TEtweUVjSFk2VnZNaGlGcDRZUVR2bWJJL24y?=
 =?utf-8?B?clU1bllvV2U3Zm5uWjZkOW9rZExDWEFpNEcxcFlubGxMaXh2N2FDUUNUVjNT?=
 =?utf-8?B?VnhPd3ByWE90dGJxbHdHelBTbGFta1oxYkRDa2tQOW1STzM1d0M0dTVCc09O?=
 =?utf-8?B?NVhJam1HOHpBaXMxYVJ0UWVrT1J3ODZMU1FHZzlDK05TQVVTTjBlNmZMWWhq?=
 =?utf-8?B?bHNMUXVhMFBTVWJiU2ZxdWR0VjZzSXZXWVczQUFxUDg5eTY4ekt5MU9POWND?=
 =?utf-8?B?ZDNKMHdLSkllSU1nbkhsT2RLbnYveXB2NkZSSWI1RmhYenVLMXFKOE9rVEtQ?=
 =?utf-8?B?Znc0djUvUEwyREFlVjhCekJKUHBRUFlGWkhjOVFISFNiRHp2Q25icmpCQXJ6?=
 =?utf-8?B?MWdiSDJDWWpydHVQVWlkc25vZUZZMjBIcEV4Y2ZEeEtGSXB6VzJ3U014K2ZS?=
 =?utf-8?B?Y2ozQnhRejNEL0J4VkNMNE40d3JKT2JjRTIybm9lV09QWUp0bVp4UDdvQTgz?=
 =?utf-8?B?UTZBb0J4Rk9aOW9zc2l0TkRnREtSck5CNStxM2wvUUZmNnVtSjJDTHhQNzVz?=
 =?utf-8?B?aFR4NTJhWkVlZjBBU2p3RlhabUl4bXF3SXdKUFpFTUZ0VzFPZnFUaHZSMVFm?=
 =?utf-8?B?d3E2em5FYzJJYVhRd0lPQURIOGM0WUx1NHJBVW9UN3hTV0p2dkl6VW1TbUk5?=
 =?utf-8?B?cEdYUjJNci9MZit4S2QyMWVwZ2NKTnVvRnlRSWw3WU4xcnFXcFhlbU9aZEJU?=
 =?utf-8?B?eFQ1UlF5RFJ2Wld0cEEzT0dTa0owUUtQdXhvVzJFbldURG40b2lRSHhyTDVX?=
 =?utf-8?B?TTRKWkQrTGF0NXIwbWFzbjErZlJOaHBlc0dFaWpKMlVzSittUHgxTlFCZVlm?=
 =?utf-8?B?NkFiNW9jQ1ZpTXp3T01yVTJ0ZkpQQlBuWkVRTXZjb0Z1aWZLckFXSjc2NUhm?=
 =?utf-8?B?UDVlcmtzWFFLeVRDL0tNdnZ6M3pZaVZlb2g2YnVDRDNQWU9CaDZkWUxoUGVh?=
 =?utf-8?B?VzZueTc1TUx6cFptYXJOWU9LNCtKdUp1ZzJucGpBM1N5a09DLzJVUmtkVGNp?=
 =?utf-8?B?YXhrUjlvaUJkWVlmYVAwVXEvd2NPZGlvVHRHTXlHVUliZ2FqU1NlS0dtTHNM?=
 =?utf-8?B?WXBjbjJTODg2TkhiWTgzSUZ0dDZhL1hINmxqTXlsZ1VLNHlXYklWZVl6SEdz?=
 =?utf-8?B?T2F6SmgxWEY4amtFRVA4MjZyaEZ3d0pxUS9kTi9FZGY5RllpSXdxVStOTUFL?=
 =?utf-8?B?Qk9wNkRRcFFuUjRWZ2EzUjRzYUhFOUhNS2RLZ3plV3kyUWZjdzVXcU9vTU5i?=
 =?utf-8?B?T3Zqb29JM3M3Z2hGUlBKdk8vaUFoZUF3ZExXL28xVFIvb29pYXQ0REdHSTdO?=
 =?utf-8?B?WGpXL3U0MncvU0krSWcwTVNCN2lKcGN0OS90VS9qb3hEdGd0RUxta2RYeHRr?=
 =?utf-8?B?YlRsWVJvL0E4Y1dmWTFnOGZPREJJTlhwMUpHaVM1T0d3SFA2L2krd0U2S0RI?=
 =?utf-8?B?ZXR1b0dDZjI0QWtOR3NhS1NNeEhxV2s0ZWFLWjBLQloyMDh6Ujl4TElpUHNK?=
 =?utf-8?B?V24zQTNjSjIrWHZwelFvM3gycHU0N3R6bHVVVjQ1TjQ0TytVYXhqbkI2NVpa?=
 =?utf-8?B?Mm1XM2VJQzlVNUNTUWVFb2VTc245am9xbnFzekJ6VDdCMVpWSjAwbElTL2ly?=
 =?utf-8?B?TTBDL2xrS0crMXBrajB2djJ3dXRxc1BHemlKY2gwUTNVa2x1L2pta0RHcGJx?=
 =?utf-8?B?aW15em52NVM1N3dCSUhyWlhyYmFNQ0p1VWlJaDNOMGNrWCs1RHhOMnJhRlVY?=
 =?utf-8?B?SnVnVk15M3NZUXMrRVg0ZXRRLzJHbGVOdkx6REtNVktDRkgvd0d1T3hUNk1V?=
 =?utf-8?B?enVEMitUUEI2a3lpaGhEOUhPVitpeW9jbm8rZlE1ZCtnSUkwYzRLc0RpaDFU?=
 =?utf-8?B?NHBTd1Q4N1V0S3hURkkxMWhvakRLb2ljMFVucVpONk5VanJrME9udXhmZ1lY?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f73dee8a-1e09-443b-c981-08dd97ef8e8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 22:42:10.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+wKs4KzMPg+kY/grOHSnT1bloSGIy5z7IB/hlqV0ER+BkT0B/xk/aFefw9MYqwkkiBgE3iRz4cKv53e9ZS6gEpVAV1CRfdl9tzAqv8M+4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8991
X-OriginatorOrg: intel.com



On 5/20/2025 8:13 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> A following change will add support for pathspecs to the git diff
>> --no-index command. This mode of git diff does not load any repository.
>>
>> Add a new PATHSPEC_NO_REPOSITORY flag indicating that we're parsing
>> pathspecs without a repository.
>>
>> Both PATHSPEC_ATTR and PATHSPEC_FROMTOP require a repository to
>> function. Thus, verify that both of these are set in magic_mask to
>> ensure they won't be accepted when PATHSPEC_NO_REPOSITORY is set.
>>
>> Check PATHSPEC_NO_REPOSITORY when warning about paths outside the
>> directory tree. When the flag is set, do not look for a git repository
>> when generating the warning message.
>>
>> Finally, add a BUG in match_pathspec_item if the istate is NULL but the
>> pathspec has PATHSPEC_ATTR set. Callers which support PATHSPEC_ATTR
>> should always pass a valid istate, and callers which don't pass a valid
>> istate should have set PATHSPEC_ATTR in the magic_mask field to disable
>> support for attribute-based pathspecs.
> 
> All very sensible considerations.
> 
>> diff --git a/dir.c b/dir.c
>> index 2f2b654b0252..45aac0bfacab 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -396,9 +396,12 @@ static int match_pathspec_item(struct index_state *istate,
>>  	    strncmp(item->match, name - prefix, item->prefix))
>>  		return 0;
>>  
>> -	if (item->attr_match_nr &&
>> -	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
>> -		return 0;
>> +	if (item->attr_match_nr) {
>> +		if (!istate)
>> +			BUG("magic PATHSPEC_ATTR requires an index");
>> +		if (!match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
>> +			return 0;
>> +	}
> 
> It is a bit curious why we do not check PATHSPEC_NO_REPOSITORY here,
> but it is OK, because it is a BUG for istate to be NULL when we have
> a repository anyway.
> 

Right. We could check it here, but I actually had added this BUG first
before I added PATHSPEC_NO_REPOSITORY.

>> diff --git a/pathspec.c b/pathspec.c
>> index 2b4e434bc0aa..a3ddd701c740 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -492,7 +492,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>>  		if (!match) {
>>  			const char *hint_path;
>>  
>> -			if (!have_git_dir())
>> +			if ((flags & PATHSPEC_NO_REPOSITORY) || !have_git_dir())
>>  				die(_("'%s' is outside the directory tree"),
>>  				    copyfrom);
>>  			hint_path = repo_get_work_tree(the_repository);
> 
> This is a part of generating an error message.  We die early to
> avoid having to call get-work-tree when we know we are not even in
> any working tree, which makes sense.
> 
>> @@ -614,6 +614,10 @@ void parse_pathspec(struct pathspec *pathspec,
>>  	    (flags & PATHSPEC_PREFER_FULL))
>>  		BUG("PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
>>  
>> +	if ((flags & PATHSPEC_NO_REPOSITORY) &&
>> +	    (~magic_mask & (PATHSPEC_ATTR | PATHSPEC_FROMTOP)))
>> +		BUG("PATHSPEC_NO_REPOSITORY is incompatible with PATHSPEC_ATTR and PATHSPEC_FROMTOP");
> 
> Hmph, I am not sure if this change is correct.  The magic_mask
> parameter is passed by a caller to say "even if parsr_pathspec()
> parses a pathspec using a certain set of features properly, the
> caller is not prepared to handle the parsed result".  If magic_mask
> lacks PATHSPEC_ATTR, that does not necessarily mean that the given
> pathspec contains any pathspec items that do use the attr magic.  It
> merely says that the caller is not prepared to handle a pathspec
> item that uses the attr magic feature.
> 

Right. The magic_mask is a "these magic types are not allowed". I'm
checking to make sure that if you set PATHSPEC_NO_REPOSITORY, you must
also set PATHSPEC_ATTR and PATHSPEC_FROMTOP, because you cannot possibly
handle these pathspecs without a repository.

> If we are going to add a call to parse_pathspec() in a code path
> that is specific to diff-no-index, isn't it sufficient to pass
> PATHSPEC_ATTR and PATHSPEC_FROMTOP as magic_mask without this
> change?
> 

Strictly speaking, yes. This part is really just a "this would be a
programmer error we should catch early".
