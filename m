Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CA171A1
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061723; cv=fail; b=ViRlNVS2HyC63vymHBZXvlzQdG6lHqIN6sW9KnzLr5XUCvVFS5JhRxJfUOptvh9pEKvJjYtFZ2zK8VdDG+hPmHrlvgPeTNDjh1ql6UG3OfmXUIBrtHS4tnGF94+aS7znHU5cio3+Ggv/2FecmQdLqrk/BXFJqBnc4GreG27ugkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061723; c=relaxed/simple;
	bh=cs/7t2vSFOfAWmFv48Z4dXI6X3BWB+3LtdF1Fn71GMA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKhyZHxBZ5p+Iv3FmGrKVLpRptnxNI1YsyiOavXQ+O0PvU8K2xzkDC+1zK4fhzx4euHPoo23jQHuoIBynpImRa2bwFGtb5H5bcZNF7rkaEOzc2WOfPFiMw4HO7ODHUTV9hTRfarz+xyDAqzCd/YudAGYPdB3jssycYQWIVnhXTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHu4P2RZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHu4P2RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749061722; x=1780597722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cs/7t2vSFOfAWmFv48Z4dXI6X3BWB+3LtdF1Fn71GMA=;
  b=UHu4P2RZCK1k9kQke0mw9Kmq6eTeEiI/Mr5SDO2zSvt/VEsfCpnohU20
   Xx9zPFdpS/TxesnG5fFclg0Au1MTLnx4kaal/Fnj0ZTqVbJzKNn2obwS3
   dZNx2R73QGFmb9ZKAiAjkn0852CUhvKq4otbacH87ZgD/OzfvExfuctat
   s3W02KCoA4bWOHBLJaPf9Dq0HmII7jqUOGYoEXLrPHgkLI7kAz2IEvXRS
   kkNgh58FF5R/kJWzkr4RJxV/FOQRE63BpBHCh0WCAjylzYtVIcfRuUtaW
   dX+R21PfqkvxkeuOFtmF3JnS/jXOQl8xhtXy1QWdR2crq0+Y1VwD6b/bo
   A==;
X-CSE-ConnectionGUID: hjb8ZJ+KRF23op99V/+f+w==
X-CSE-MsgGUID: 5FtzDPooSY+1PbCp/4NwZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50854775"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="50854775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:28:41 -0700
X-CSE-ConnectionGUID: s29KdCJsSHu1GmO10xF34Q==
X-CSE-MsgGUID: 1/8W6gJTSNenY7Y7NLs9IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="146255645"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:28:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 11:28:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 11:28:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 11:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHzIfKNljG1nf8nClg9vMl/YI68SMTwAU/S+/eXmo/C/VVP+fcnauP0RisZFnetZV9HnrT9HX/7r/Bm5dBbYwJ6prMZojQWA9+sm6jpBRZvH0Q6aSGwN9Uy/jp35CSdjJSVwoOSZPTTpCyW962WMfkCajGWT83Of79I4X9pw5T85aNwzPMQ8QFZu0kk8Jz1eHLSIKq8NeXTSIiDjFjmz7X/gFcvozY55csxC5H2c55mTjiRDJFh0bw6i6thn2i55oxIGtKfUT2aLeHOQVc7IpJNOL3Bxlho4d5KZQwq+SmYwSbUZDQW9eN9HLJCniEh3LqfC/jqOq+JeuqlkC+KjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jdLp1sjkM/d2JxseYLEyo93BFiaK0sC509fh1gHzaA=;
 b=Eerqf5rpvgmIcZsk3R0qfJta96V86IAq7M8vu7Yi3lO43VisZpcajCWzfGPs4FKQo4Y2ho53ZHIfUwJ6P8rl32WUwX56bWh8GGPswSToWZ7RNfRHOw4K/bpzwgj6Li2OF5jIeNei/uF2+5KpHc6raXouYNq0YmszFHwqyCO7Pbyblwz3C0RyrW8f3/DZ221IXeaEpD0nHaPUsjT6XFUv9efuODCqQsoHCqbOLBwrZ+u1ObC+PXmrX1V3c5Kbd8oBao0CebzW1QG0Epzj1guE6r5Iu8RpWp/JGwUd3Y+f2uLEmRZq2x4BPkeKuG0Vs8JUAvrhJiYWgImYYbg0NlNmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 18:27:57 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 18:27:57 +0000
Message-ID: <f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com>
Date: Wed, 4 Jun 2025 11:27:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ5PPF7DCFBC32A:EE_
X-MS-Office365-Filtering-Correlation-Id: 334b97fc-e9d9-4969-a930-08dda3958725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk1iZUo3Z2c2Z1VWYjEvS0RqazFMZi9Wd1AzRGNnNzluMmpFUmlPU1dMazlD?=
 =?utf-8?B?dFNSMzcyZ2g1QmptcWpzSmVSU3l0QlVCWnV1cWx1d1g0VEUyMGxHUjFJajV2?=
 =?utf-8?B?dUp4Tml0MUlPTEVqb2lMN3Ntd25pazNqeHRJOElwaExEdEJhbmlqMGVSbldk?=
 =?utf-8?B?eDRHSUEvZWZvSlVzWThvNm8xVlhxR08rS3BUMHZzUkk5clptdktLSFMvQTk0?=
 =?utf-8?B?VGFnTXZJZkVOeTRlNkhUanprWU04c0YwNGVnc3VYOUNjQ0xJOU5wUFBBeXFZ?=
 =?utf-8?B?WVM2RGNWZlByZU5UMGx4MlRGMzVKcnYrUEUxWU4zM0pVMjhjRjl3OEtscmFP?=
 =?utf-8?B?YkZwRy94THFSb2VqOStaWFFpK0FMVmtvaUJvTW9qaWxtVWdTVm5ZNXV0K2JG?=
 =?utf-8?B?UGUzaWR0bHBONDdhOG5sVTB1dDVmR09GMy9aZm9URHZycnQ4Z01LMHY3NW5G?=
 =?utf-8?B?UFJWd0hnN0sxOU5pSzNoK2pVajN6eEwvVi8rWFl2eTBGRmdBRE5WSG8xU0JC?=
 =?utf-8?B?Y21BQjZVRDZCNmNkcnFzZUFnclE0VmdsNmkrZ2NMUFhLbjQ5b0p4S0wxUk5i?=
 =?utf-8?B?cDdEZjBYTDk5YytqR1NaNTBsaVczOWo1MUozdG5PRnpKQTRWYWV5YVZzWnJj?=
 =?utf-8?B?bGNJUy9QT2hJOWd4MEE3MGFhcC9QNkZCYUtieDdad0VJK2FZa0JGQXphYnFT?=
 =?utf-8?B?c0FHTTZqTGNpT1lXbXJTeE82N0ZNQVpKWWRlNjZ0dWp4RGVPK01GSkphbmds?=
 =?utf-8?B?ekpvZHJwTm5adWl2cXB2UzJhd2R4U2RHRDIrYVhFWmFMTDRMNjI0V1Z5MlNF?=
 =?utf-8?B?dEJCckJoWVNtcGJKMXc2OGxJM0psQTNGT2hYcEdLVFk2Z0hjdkFxN3FyYTVi?=
 =?utf-8?B?WkpVTS9IRHZrZmh6VHJBQXNEa3Zxd2R0Q2l5MDdkcy9OM3hPRG0rYTRNNkFj?=
 =?utf-8?B?WU1RdXJ4ZU1RTUhVdER6Q1FXUU81czZOSjV5ZnJicWZUWTNIMFliN1UvTEY2?=
 =?utf-8?B?ZFBOVTdxV3FRb2VuaGZWY05TN2xNUHpJVGtRQ2NPb09Hd0lHZ0VGcER4UTNX?=
 =?utf-8?B?RWdJN3pOc2RpN253aGdnblNmTDIwRnVuby9zUWwvVFpDODNuVUVQL0xZNG1O?=
 =?utf-8?B?aVkxOXFJTWU1cVZ1a2o1M3RLVXFDNjEyUG1rd01vck9aL3MzOEZuQlkvOUhD?=
 =?utf-8?B?ZU9QajdDSDVidzlweFRHaVhRMkZhWDRBOEpySXNJQ3VGYmxORnFqWWZWY2Va?=
 =?utf-8?B?MTdDOWtjSG5kdStoOUtTN0FWVUswMUpQWFd4Wnlha3dPZHJpcG9YMXZUZ0cx?=
 =?utf-8?B?OWEyTDNlWHFjN1E5WDlyL3FTTlJFeCs2Qm03OFJyT0Q4ajdUWkNYT0VwVEdC?=
 =?utf-8?B?U2lnS2JzV3U2RHVLamxiRFMydHp3azdObnQ5MWtZbkNxRHUxRjdlNlRyZjVZ?=
 =?utf-8?B?ai9TZFh5dTl2MTlPbHdid2NYU29rMHUzTXZ6TGVBTG5mZkFRMTFMdTZIZHRR?=
 =?utf-8?B?OHlKdHJibCt6eDNON1lnL0ljQjZrZ3lFZXN6VE16MVhmanZmaTJYQ3VWcEhu?=
 =?utf-8?B?UXNOemhYTHdTNDJqa2RDSFZTTC9ianNPdVdtaWpEcGVOK2liaHNUSGw0eGFW?=
 =?utf-8?B?bXU2elFmWVkzZ2Uwc21xTXJVNFJRRGFXRytBUm5OaFJhcnZxT0xCTjFHMGhi?=
 =?utf-8?B?c2ZQUXZiNFBuMHRDc3puazB0QXIwanltQWhkZnVydEpGKzUya2hNYm54OXRC?=
 =?utf-8?B?Z0ZxaVNDeUVZU2haNWNvVUlZbGlGa0lLY2JIV3hLeDNFcWtUdXVnc2VvYjd2?=
 =?utf-8?B?UFIrdXFucTBDbW94UG9qYStxSG1EVXlCY1N5UXoveG52bytzdTA1K01lN3BI?=
 =?utf-8?B?eHVyQTRnUWlCOC83ODV1bXoxd0V1aW5VNU1oK0tlMjUzRU5LK1I0TThXLytQ?=
 =?utf-8?Q?yq/VLYSti3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdodlA2Q1gyb3ZVS2tLbFdWUmM5YUNpaGxTL2VWTHZrdzlyb2NkRmxRbDhi?=
 =?utf-8?B?Um1QV25xY1Q1K3FoZUVBWU5Ya0F0UGc2YmY5WTRqekNxRWJDNmVJRjZ6Tnpa?=
 =?utf-8?B?YWtBN3pGUVBzQWRUVzM3QU10aU1yM3dTYjBRdkcrelN0cXpXOVBPdGhFZmF1?=
 =?utf-8?B?dmVVNEViTnlVaTNXVG83WEhnWCt2V1R4RFY0bFlOVEprUU1nelM2ZE5xY0hw?=
 =?utf-8?B?elgrSWVKTHVib2t6REh2eElXY0p5ajVjWndvcHJrdndKZFlKWDdVeWh1bkR2?=
 =?utf-8?B?M1Y4b25pL3QxYkRpN1VRejg5ZVdqN0x0WXBRUnFRMXI4aHBGdHU2OFFDN1Zk?=
 =?utf-8?B?cFc3TCtrMjJQS2xHdFNwT1RzRitjRjV6S2FMMnVvMGRXd0xXUEJ2RWVuVzZr?=
 =?utf-8?B?akFwQVo3U1gwMnZReVRqSGhZYTgrbFZ2eFRuTFg2ODYzZk95dFVHc2c0cUc0?=
 =?utf-8?B?N1NhL1VhK1VTQWx6R1NKOHVPN3BKVFZGdmcyOE11K29oM09Eakd5b0drUmpa?=
 =?utf-8?B?cWF6VE95bloyQlIyK0g2aTV0ZTVIMXE5K2tmS2liamVIQkc0bEZrQ2kybVBr?=
 =?utf-8?B?eHlIVStEK0dPYWYvRnBjUldzd0ZoMG9FSWpOMTFuZThZUVFLKzd3aTFib3JR?=
 =?utf-8?B?ZWIzT0VyaGdsa0dmdzV4QVBwVHhuMC9RZENkbnNZYUJubXlTWm5maGhoYkRm?=
 =?utf-8?B?SHcyZ2Z4cy9wNFBBdXh6SG9tU0tJbGdXODBhNWFJNXVPZ0l4SGRxVjNXTmdF?=
 =?utf-8?B?ajFWaS92dWppamxuZlQzTk1RT0lsai9hSGdubk95bjdNMkxsSytNRzlHYVph?=
 =?utf-8?B?TXhUaXhwbGo3R0sraU80eTJ1aHJzRGZQR1hIQ1RsRnZQcnB5eUV2aHZ6b3dl?=
 =?utf-8?B?MWpIUEJvYTVGQVBMRzlRdUsrMnduM0FoVjJjS0pPTTl1bUc3aHVkWlpDNTFt?=
 =?utf-8?B?ckJQUzRQVFRqNVZUeGUwUXlnb0xMWVlKOUg0cEloYkJDM0VWZ0tWVWhNbmtz?=
 =?utf-8?B?YzZ4L3dEcng5SU1tZGE3RjFJa1NxYnBoVWxvK3BSVGY3QVc2b3E3OE11djI4?=
 =?utf-8?B?RllFWFExajlOMmlNNjFsY0s2VHo5U3ZCUVVqZkZMYkpiVHRISzdwNDl4eGR2?=
 =?utf-8?B?dnc2a0p0bE1wM1NpalVsOWhST3FzR3lTcjAxblVUL3ZsOTJLL2FIOGVlR2NG?=
 =?utf-8?B?WjVkNjBJcGZRalhZNWFQNHFUbzJXR20yVEd5emV6TTlsaUdubUdxakh3aFBE?=
 =?utf-8?B?MmNGSjBiS1R5UlowRGRiZFBhcE5iYlpaYWFvcDRnVCtwallKS2R6dlZKVGxl?=
 =?utf-8?B?MkdzWjd2K2N0S2srNUJUNVpWc1ZHdGNLazhFaUhpVzFEREhsaldRa2ozOXE2?=
 =?utf-8?B?U0dBeWpTUGc2Tk9qdTJOektQSzVxQmV1QytjREdwbkp1TnZTSVRXT0hXOWUz?=
 =?utf-8?B?Ri91NEVpN2RObVNrVWwvTDRXTXJDUTRCZUlLTGF5b1Z4WlBiQmx1MHB5R3ZL?=
 =?utf-8?B?UElLWngrL3Y5cWIrUTZQeHdNWmt5Y3V0c29KVGxTa2FYNmZBc2htTjV3Z3lV?=
 =?utf-8?B?N1hmZzYvejczMVVOOTdFNU85YXRmQ0NsSmdSN2N4aHBCbmk4aG9QRjRBY3kv?=
 =?utf-8?B?dFB0dDl2RmsvNkZuNjByODNhUy81QklSUCtJS00wMzlOeHZjZTNBL1p5YURN?=
 =?utf-8?B?Zno4VFdWR2I1RjJKM0E0am55TXAydHNZTmxDSFE4QytrZVhLVVJJMXdsUFVk?=
 =?utf-8?B?bThYYnFZay9jWnBic09QVDIwRTlJdVhCYWhoNnpjUUNYallNdnlXVkkwdWlQ?=
 =?utf-8?B?SWcwNlY0OHFDYWVnQTN3L1VqeHEvUzJRNlM2UGVURkYyejVveTlsb2pIbWRQ?=
 =?utf-8?B?YUUwZG5yZmRMZzVTZERvWHR5d0dVOWtFK3VqTGQ5VVZZR25odkR3NEcxUUs4?=
 =?utf-8?B?OTM2bUJoMVRYNy93aEptN25iODY2Q0laM3pxZ3VXUWNEUGVGdloxa1JObzN1?=
 =?utf-8?B?YUZ1aWNtOFRpL0dpZTFMMTVnRmx1Q1FmcUpaY0U2RkxJMnlpWkwvZWxKMUxR?=
 =?utf-8?B?bHZOYzhPRXgySVkvOTFYRnlvNnRqTmJMQ3dOVXVXSnU3RzhvSGZYbWFtb3F6?=
 =?utf-8?B?ajFFcWN4RFhjMnRVS2cyaFVRQ3NoWlRNWStxYXNFN3VMclhZZWFWTkh1QTlk?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 334b97fc-e9d9-4969-a930-08dda3958725
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 18:27:57.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXYJ7O+FjQZPSnpyDuGQR2cfJ1TEgzqo6xnO2swGSMEPZvNOIk7N8ZFXuBFh13GZyWpbrnQ1nC1P7r3DrOTmpBVsBC0QE7vTgjkLYPhTxWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A
X-OriginatorOrg: intel.com



On 6/3/2025 7:37 PM, Ben Knoble wrote:
> Actually, one comment :)
> 
>> Le 21 mai 2025 à 19:29, Jacob Keller <jacob.e.keller@intel.com> a écrit :
>>
>> ﻿From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The --no-index option of git-diff enables using the diff machinery from
>> git while operating outside of a repository. This mode of git diff is
>> able to compare directories and produce a diff of their contents.
>>
>> When operating git diff in a repository, git has the notion of
>> "pathspecs" which can specify which files to compare. In particular,
>> when using git to diff two trees, you might invoke:
>>
>> $ git diff-tree -r <treeish1> <treeish2>.
> 
> I do find it slightly confusing that this series and in particular this patch is all about git-diff(1), but the only example is about git-diff-tree(1). It’s not the best example to me, esp. since it doesn’t actually use the pathspec machinery (deferring that to prose only). But I get the gist, so not really an issue.
> 
> Rereading a bit, it seems this message goes to lengths to teach readers about pathspecs for git-diff here; perhaps we can simplify those parts and assume the reader is familiar enough with the details to understand the implications of « no-index mode doesn’t support pathspecs to limit comparison »?
> 
> Nit: Should the diff-tree command end with a period?
> 
@Junio,

Would you like a v5 with an updated commit message?

Thanks,
Jake
