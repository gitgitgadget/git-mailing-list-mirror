Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8310FA
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594853; cv=fail; b=Yt+3Lutd2tfIsRzp1xgMPpfCaWRYJXB2I0rgRrtcUSKejXhGWnFp8X8LYJfLuPiQgbEY+57cSr8NzkQ7vu8pREcLOPImziwH2IHyCgTotPhJ6SJYntFk2kflRi1XsVXkDtkrSeFcswlT36YdbXueIYVmmTK85zudJEt7nMCSm/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594853; c=relaxed/simple;
	bh=6zc8ftU+Dal4VjKvaDBnjBkUWGKIlsOZBYYuWdAIVqc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bESe9XzdkjyO7ewkJxdNNGkYrc5PG/Z413BTerJkarPSib2NMDEZeBHfxxjqrsDDgZ5PfFp+QgXUk4H3yimiQpa9I8Ldk/f1oHBYh3AFOz0h5DCaZ7VCJi/8Tin9kZlhrq4GlrUmM3aipBrYgHgQXn3/6O+8jqAyBX9XyXTjPqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxsMLA1+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxsMLA1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723594851; x=1755130851;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6zc8ftU+Dal4VjKvaDBnjBkUWGKIlsOZBYYuWdAIVqc=;
  b=IxsMLA1+ShHp0V3md112G3sWtUh0HntQuc/xA3/X3RpwLz9WECLTjfea
   K8Jcxdz8yDMb9vwbtbyKD2QXS6tdQl+wGKDdYSDU3UM/g+tFfXhJy+Iz4
   6G4fBfEIy32ObVgGW9o3ewcHM0Un3vxANpdG2Q2+IjBAl60VibsVlbpYz
   XskDkXJnaUNNFeYeIAIt3Y0YKPqIV0jCWv7PIr80eYRG8P97FIK6vI5MB
   DYRl8uPquJJd8aP13gZNQgSahnQWTR5KURWCndT3GIeAtAFB6Fe8Ft/PL
   vgk+p/C8DXvPkjqTnhUqA6VnckYHk4CGvTNE38O/kuskR8lEGS4Ndygrc
   g==;
X-CSE-ConnectionGUID: rVfqcz9MSlCgXHbJq4mQjA==
X-CSE-MsgGUID: rSvoSva0Q/CtDJ4uajItHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32934288"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32934288"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:20:50 -0700
X-CSE-ConnectionGUID: LRIYh8x2QFOVt3kSQc3iCw==
X-CSE-MsgGUID: dy2BpCp4REOtL1FBSx+bAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63771889"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 17:20:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 17:20:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 17:20:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 17:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOeZoz/w5orjug21i/brkmf5NOdJo+VpI3l9+earCJmb/Kmyql7qh8Zwww3BFGgkigdz0eNKCGsRo5CTrKN5hhF3LHnV6oXOW8tuwKt92B5FDAC1dqYniYhJ3lLJDruk5YQDpRIKpjOzXclskiZFYq2oEKRMdE++3Fk6FwITE4OZFgi5QEQyDF91ui37v9E1JLMvSEXLO4iclYEkz6WGuH+++qF53kNN5Ee/YDXBCPdnqaOUL4ctMN6C23DiXVmOKZub+AqfsfrhRyCKbhBHslL4CoQl+eG9+vaK8IZ5x7FOsN7FQJ0OY7XBMOIR0FoZgmqCx2H75QBFCCDWqMoMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+50qD47E3Q6gQSgmPWgB/qWGHH+xX1MEVWm03PmyS0=;
 b=tMFLBT6dglmB5ZSXxHw3hBD9cbVqYCgfJ3ckGEFyHHuR+Rk2BD1k466JrgJFOW0N1CipoOXgYKouv41F/4d/t6AsrWBHZKm36fzXUOQzsLO6SKQrvHfmBZPRmZw1dolBNNz4m77Gfz2Bzcl8Il6g33jAkZot6Da3y37K9AnXA2tvXY9+7bHtlPCuB254A8X/Axyo4Tlt55x+bWRlIDDbA0c8GAjjyjePy3VMZtpp+MP2+2AGSRDLpvGYxf0qm+o2KSCY3D80135WXRBTGnwyXV0xbXQKMAubWnWnXe71zfA+KgsKqXQBmh9koVi6aHo22pX+hdfSR26MsQuE149KSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Wed, 14 Aug
 2024 00:20:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 00:20:44 +0000
Message-ID: <c0724297-1748-474c-998e-803e6a062a12@intel.com>
Date: Tue, 13 Aug 2024 17:20:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] format-patch: add support for mailmap file
To: Josh Steadmon <steadmon@google.com>, <git@vger.kernel.org>, Jacob Keller
	<jacob.keller@gmail.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
 <2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a768d3-dfd4-42b9-e09c-08dcbbf6effa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1pCaXpFNHl0QUxkQlFTL2ZOenJTWHR2RlVHVktUNVg2T0NsdTFXLytJa2xz?=
 =?utf-8?B?dWhQQ0NxTzN3NUI5a0QwOUpiZ3l4Q0hBVUN5bjBIc0xtRytkNjlINTRLL3hF?=
 =?utf-8?B?OEJ4QjRKZHRyOGMzZlFTVk9SRUFINEV5ZmxJRHhTaTBpZU9VYWNNNjZWa2g4?=
 =?utf-8?B?VU5UYXozcTRGRWpLeXBTZml1c0JOMHRGVXA4ZkV4UTZqZ2locEhWNzNKOEhK?=
 =?utf-8?B?OWlHKzFYcXlYRWdWYmtnNVFVUVFqUzFYNkVCYTdBK08wQ0JDQkVjQnRkTlpq?=
 =?utf-8?B?a0syWjkvN09DVE1KQkJIWWNmSVcxSFJabC9TYjhueDhuN3JlY2hNamdrTWF2?=
 =?utf-8?B?VTNaYm1ySUo2UjB4OTVtckhFTVdHS2FBVXJ1aVo2a2h4V2FXbU9JNVRWeFB3?=
 =?utf-8?B?cTUrVkpUcWt1a3F2dDdIWndMbWtJR1JsdGFibjdsUGh1L2pLNHlCdVozQ0M0?=
 =?utf-8?B?VG9NVnVIa0tYN0ZZYWVGNlQ1aVBHdndybm5Yc2xrR0gzKzlpLzIzWndENncx?=
 =?utf-8?B?Yk5FbkxhcU95Z2t1NTA2bnhhNFovWG05NGQ2bHNNdXdMMFZ2bFBYOGJ2UnVE?=
 =?utf-8?B?aSsreTFIV2FSNUVjcThJTjZmQmdqVldFUFBYcHkra0QvTXl2R2NmVkdxUUY0?=
 =?utf-8?B?YkV1bXFkL1NXbEJBZnhrVmRKbVl3WjJQMjFvUzQ3QVVGeU5Za1MvZnNZcmxC?=
 =?utf-8?B?SU9zYUttL1dnWGJYK243SUhQQUhlMVBuYk0xMis4VWMwTXVCM05BYTF1Nmlt?=
 =?utf-8?B?d2dLSld5bHNlZThCc0NDNlIydGNhZjMzL1dBWi9KUUxhcytuMXB6eG0xa015?=
 =?utf-8?B?bm1nejBoSFBMa0lkKytJbkpDSXdzTjR5WWdnKy9USGJJcmdzVlpLSVJEKzcv?=
 =?utf-8?B?WWhuREtLYU85ZGl0M3hUU3NGckQwa3RhbnIzNE9TVGZEd0VCZUNIaWhrQ1R6?=
 =?utf-8?B?dkdML3Y5QUt2bzRydnhZWjZ1a0ZFb0RtbzRrZFZqQTNzUitVT0JnQXdxN1pa?=
 =?utf-8?B?M3R1UFVrRkNOK3YrZG15OGFEdXFiK0NPWXVhdWF2Rk5Md0V0K2VoUDBpRHpw?=
 =?utf-8?B?c2pEeDk2Y1pRVGxtRXNwaDR3aDJFeEFSWmE1VWo2N25iVjIyWE5teHBERFhZ?=
 =?utf-8?B?Qy9sTEovTzdyZFU3L1ZWWllsdkFpZjc4bHlnanY2cW43ZHdTM29jM2tTMlRo?=
 =?utf-8?B?Q0g5NW1vYlBNOEJLOEhCckd3Z3o0dXB4MUdkTnQyakpLQkRsbkxKTFBMb05m?=
 =?utf-8?B?R3M3TXdnVFJkOHk5NGhMaVVUQldkVFBaR0dFRkVqZXUrdGtpZHRIS05QZGpn?=
 =?utf-8?B?cVdWUkFZRlp5anpFWTZ2ZFNTeXBjRGdPbzhrbTgxb3g3YmhJM3YrdFlRODYy?=
 =?utf-8?B?NkxIUm01Yi9xOVFuaVpGQmJBSjJEKytnV3JCK2ZMLzlPUWdEelJxNWprM2xu?=
 =?utf-8?B?cVlzR21oY3hPcnNURWd4U2h6QVJGTXMvTnF6c2RheklOTVpBTGJtWXZhRXFL?=
 =?utf-8?B?R3ZsY1FKc1VKck8rbExUN2hjNGtZUWdNOVUwOVZFZlhIUWtPY3NSUGM1cThn?=
 =?utf-8?B?NUxZVC9rZEJTKzdFWjB6NkpjOG5VTEoyNDR4bnQvOFJ6TTNiUHUxYVdoWnZH?=
 =?utf-8?B?SHprRytVdXgwbGtDVWpydkN6WStEOE50RzFIYmEvUDF4ZU9oL1lld05WWExw?=
 =?utf-8?B?SnYxV1h2UGxvOGxVOVoxRXdIRjhZd3NkL0ZKYUNPdTM2S1ora1YrVUdSMVlq?=
 =?utf-8?B?aTZQL1BZNFJvUzRiSDlsM1NmVTJuUlFVcW1Vc1JXNWJMR25JeW8rbmZEWnlQ?=
 =?utf-8?B?MlNBL2t1ZzdVWE9pcHIxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW94QWhjZGZkYzNZNGhiSlZEQ2wzclpaZUdUcDFXR05Qc0xHOE0yMDFGOHlQ?=
 =?utf-8?B?SnZzTENjMEdvRzhyZkdxejlkeW5Hek41N2lhRmI0Z1M1Y1FjM09mb2lmMGRt?=
 =?utf-8?B?MHF2NzVTZ01TZ0pSMWR2NWRNSHp1dW1udk9MdlFkZUpSTGR3eElOU2dPMkt0?=
 =?utf-8?B?aFVOU0d2T3Y5dkI0VTZza0lNcUhGSVo1WHJNd3lOcEJTaEZpQ3d3WTMzSXI1?=
 =?utf-8?B?MUxLR0ZFRXFmVUdjamNrNTRDSTRtOXB6ZzAxc3VOcUxBZEcycUluMEpsckll?=
 =?utf-8?B?ZnNUTExva0VOTE9wWGZNRUg3dUg5dkV3dm96ZzZDQUJ0N05kaWtnSmNVbjJT?=
 =?utf-8?B?dmZ5Q1lkOFFTdFlSZHpZWXIzd3JMaTZsM29mWm9XNWp2cmExMFBpMnh3Vjlw?=
 =?utf-8?B?S2FUUXpuTk41QmEydjB3TVpoT1J1dmIxaVZPa2VPN0Y4ZEhlb29ETk4zc2ll?=
 =?utf-8?B?ejNmZWhlbFByRTYvTnFmRDlzaGQvN1pNSTZOb2NrR2J1U3I4U3RrdEQzeHlv?=
 =?utf-8?B?L2pERTR5VElvTk95UzBTOHpqd1pPMzBKMXUrcnBlTFc0ejAvTHg3ekxZdDdq?=
 =?utf-8?B?OHNFUkJFN293M0J6aFJ6dTZIdUpWN0FZem81Tk1iWk9DRm10Yk5FU0E1MGZY?=
 =?utf-8?B?VnErU1RURm54MUZXQkp3Y2EyOU1wQW9FSjQ2SFh1T0xVRTVVZkpnMzlGd3dU?=
 =?utf-8?B?amQ5c0JZck5KdnFoZGwvQ1R2TytKWjFtK05VOGppRWRHQkZIc3Q2cURJWDI2?=
 =?utf-8?B?dTBHSWY2L2VKZ3BTeUdZcDRuNm4wRVFXdGFOa0d0VW1TMGlFNXB1VHBLbE8y?=
 =?utf-8?B?ZzdzZitBeHl3U0dRVWx3ODVldngzZ3RBM1VpbG95WCtSY2VwMVc0MWRNeFZn?=
 =?utf-8?B?MW1vaUZ3Y3NUdWlCNGp0QlNYT0ttdmVETGNLYlliaG8zUGxjMHh2dldVVjUy?=
 =?utf-8?B?cFp6RUc3cXdVdDRxa0FSWTFGeXZIWjJlVk5ES0RLa05kQit6d2d0Zlp4YXB6?=
 =?utf-8?B?UlExK1BUS2Y0bzhYV3V3UXNDdTRnbjBrRFJvUE1xeTVDeHA0VXdRWGlUUkpz?=
 =?utf-8?B?NFRvNDk5b0dFbTcvb3VjcitFNGVRVUh3UnhiRitaNTRwTWYxS3R4eCthS1N6?=
 =?utf-8?B?YkN2NUhteUlSTHNFTmthK25ibjFDMUwvT3hVRDRFL2w4SDR3YVNVTzU0VnZY?=
 =?utf-8?B?clo0b3ovUjMzZjl0T3RXYkFrOUhkTUpBNXJ6VDd6aDFFR0xTU3hOWWk4VGEw?=
 =?utf-8?B?c3lmb1lyeTFzaGkvbkk2c0tlTWxZaTBvRmhVQW55aVg3bWdhaEVVa1kyT00y?=
 =?utf-8?B?bndFckZsS2o3Tk5VTXYxbmhicWdVSkorUmt1WHY2dUJhaGZWb0FmcXRyYU5N?=
 =?utf-8?B?S3ZxL29WV2hvc3R0S0lldGJrNUtYNWhzdXhZNVZvNGdRY1hjakczcU8zYzB3?=
 =?utf-8?B?Skh2bFo5L05UOFdrcUxIbVU1NncyWGhEL29OVEtQUDZCODR1TW9CaHJpZkdl?=
 =?utf-8?B?NDJLMGo5ZWswTXo5R1hRSFFsc09FVzFOT3N2MUxwMk9Eam5CcTVPSEhKREMw?=
 =?utf-8?B?VlNuRGNCT1MzTmdYSXRyL1pRMnpvZDh3a21Mb3VTZzg4U2lneFlRWmNzU1Fs?=
 =?utf-8?B?WXJwalFQeS9udUdjWUxTL2xCUFBQSXBqWEdsL2dRdGljMUZCbjFBK1Z5VTVD?=
 =?utf-8?B?b2Z1NGRKVHBoWjR3dmZWODBHU2w0RURIalFOMzlYaU12TkYrSlA2SGxGc0R3?=
 =?utf-8?B?OE14OUV1UHk4TTVMUk1xdGZGVWpqZXMzOVRhMzJncnN0YXZya1U2djUwdjUv?=
 =?utf-8?B?NTVsdmx2R25DN3lYVVZJNnBGOCtqZmdzNjI5M2hmc3dOQWRlaHFzNlhwY1Rj?=
 =?utf-8?B?dDdjOEJETEEzMlc3Si9OWlQwZWVMYnVJOHdzMktlRWxHOXl6bzdScjh1a3RH?=
 =?utf-8?B?WDFWbm1KazU3bEtNclVuWHRYeDJXUlZZMlUvaTJWMHhObVpCamlEK29Jc1A1?=
 =?utf-8?B?ai95Q251ckdBYllTM2luVkkzOFFhZnlGTWlnZmpqaVBqWXcvUlZ1bFFRUnY1?=
 =?utf-8?B?QS9kdlIwb0gzYzhTRGg0UHdSTkpnb0FpMHZqVXlMa0dLWDFvUXZ4WEdScnU4?=
 =?utf-8?Q?7LYMOPp2elJpEvb07LywYtIgt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a768d3-dfd4-42b9-e09c-08dcbbf6effa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 00:20:44.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmkpNYYPhsaR9Cbd8G4TqPFTMwnd5Iaeqn+UAmqvt8tz72OsFqOjb86oaPPw6AMkvQ2i3Djbf1eOWa+lbgwUQJQwPpdTsYwxvcGVoqG9DQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com



On 8/13/2024 3:45 PM, Josh Steadmon wrote:
> On 2024.08.13 14:45, Jacob Keller wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Git has support for a mailmap file which translates author and committer
>> names and email addresses to canonical values.
>>
>> Git log has log.mailmap, and the associated --mailmap and --use-mailmap
>> options.
>>
>> Teach git format-patch the format.mailmap and --mailmap options so that
>> formatting a patch can also reflect the canonical values from the
>> mailmap file.
>>
>> Reported-by: Anthony Nguyen <anthony.l.nguyen@intel.com>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> 
> I am not sure I understand the utility here; using mailmap at log time
> makes sense because these are old, established commits that may have
> outdated contact information. But when writing patches with
> format-patch, presumably these are still somewhat WIP patches. Is it not
> better to just reset the author information before running
> git-format-patch in this case?
> 

I suppose that this is rather an uncommon circumstance.

> If I've misunderstood the use case, please let me know.
> 

I've had a few cases where I was formatting an old commit. The example
in this case was a change made to an internal tree by one author quite
some time ago. In the meantime, that person has left the company, and
his company address is no longer valid. We still typically put the
original author on such a patch in order to give them credit even if
they're no longer on our team when sending the change, as patches are
made by people, not companies :)

If we left the address alone, it would cause a bounce on the mailing
list if it gets included in the cc. In some cases, the upstream project
mailmap already includes a mapping from their old company address to
their current public address.

The internal tree commits are already baked and can't be changed. We can
of course fix the generated patches from these commits manually. It
seemed convenient to get mailmap to do this for us.

I guess this is not very common, and may not be worth the trouble to
maintain in format-patch, I can understand that.

Another alternative we considered was something like a "--no-cc" option
or configuration to prevent including CC for a dead email address when
sending such patches. Given that the original author no longer works for
us, it is not like we expect them to actually respond or maintain the
code, and in all cases the patches have a sign-off from someone else on
the team.

Thanks,
Jake
