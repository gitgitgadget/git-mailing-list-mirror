Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4F23AE93
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868840; cv=fail; b=L/4j/HICMSBzk7Yky5tmuBWU23JFdaNlVcEJZwqCAuHcqo1QtLnQksv5XG1egN5/EMoaU5s9D/hJOoYGVXvyux8G0jde7vrUiQtVyEU2HNfXYb32H+gz3ExTGxKtfhsX4/eqY13aALUTes2UBl3amHH73Mg33SoAqnXQdSGWki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868840; c=relaxed/simple;
	bh=rYCpU+75jrJHtQgPrGu2q8vLE3AXCmJz8qrWzzregAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=se6MKEi4BclJPE8RoCO+6h7C5YKKrmLYc2xor008h6meGT9i9ZtC7KJTc5PAEEtDj+rY1kQeeGIl7r2S4kvSN66nXiwpu+NxSw8wkQqpashAA9Dg7D2SjaGPDdoegsoDLqmybavhAeDsJLmqczQkVQK8cLwFVr3jyBOcVZdKGF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3jkCEAW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3jkCEAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747868838; x=1779404838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rYCpU+75jrJHtQgPrGu2q8vLE3AXCmJz8qrWzzregAU=;
  b=W3jkCEAW0Dmo4XmdtrwY4Vy38AdH/G8Um0lcNJLB45xVsU7RQmW7uNGV
   Z0eQaWM+dqaI5hFaGWcZAB/x6BkaPxwIXCumrCiMMYeXMZawrtAlkMwAM
   kZIsFDfpRGHGEybSIBNUltjA8y/HdgvIO56QqWwyk/2It08u2WAIp71rK
   5xk+tfzKe6PBb7gSKcSQIUoiJmVrTKDwurfD5oBfEHrkM9sweK2NmYTE8
   FDS4JuIAKgRIVRheJIgicJTkmAlQxC+4yo6vt7BGv1kBb87ZEi5XkefK/
   HQNdapRVWliEFLCVT59eoTDWpOoEHRwSND3zOhzGv+opbaaYmwxP//U8w
   w==;
X-CSE-ConnectionGUID: AiYYvi04SHyIlFdjPzY6gA==
X-CSE-MsgGUID: t08V79/EQ8yr2aDEgFo2DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49578246"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49578246"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:05:15 -0700
X-CSE-ConnectionGUID: eCO4UJlkSqOQtAt+xknvXQ==
X-CSE-MsgGUID: GiAyVU8SSgqwkSOwsKkE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145267130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:05:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 16:05:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 16:05:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 16:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0jApqDcb0TdAPrJQ9/2x+aVCd3z0+sWhlf6U56lRzPvjuCTxj/xT5puZxajLhcvp2u0AM2QQJ0JgRSzRa4sl/2a2ZNz0lQgHJ5k9RiDFlCU1GpIRbFKGPheJ6uYefAQCht0yk6GPmuLVfbLTX4HM54GQ4r6tzDYUio0G9ty4Um3rvVCfI7i2HTbvpQEPqF0/oSXn6hMAojD3USC8NnwnzgzRojf+CkbmvZpq6ItzmUZkTTfJyrUxszWoQBJ9liWhSUQwwMbUrGhp+sTcNeHDAJ7eT/M+qwG+Oy6tYt6xabJh6GdOKPWCAA26MIPKFg8tTA1OcveI+Kq1c0zS8IYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx9H+FqWSiZj64EvKS/NNOVc6dtLg/hlguEWZc68kjQ=;
 b=kM2dKpH0DvueczZC8MlvefmMSu2Md+YSwdLrvTEo2FqaJE1/J4DgazN0Jj0QHWrobVHb5w9OAt3v803kT/2PqJJHNi/h9ZgWjBqBJFspAXMjv6U2pLexTFtkcAd8hzJ+zBLsb3/oaoVI+s0toJ/kJouwsN5Qp2bNw2+5pugNCwtZUfKcexyvhupRSZlJowAIk2kIj9r/0XRitKVyKavwzlko/KfwVeJDzKYKXvhagbjvnYlstF9ZNa8+DvUuk0ecI15TeGTpfuScNxaSQqf752/oPeXbqmSDu8qZAiCWgXtK6Q2xXR0wilP29n13yTvkpNv5DkEZ7MzQWnGmQ4t4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 23:05:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 23:05:11 +0000
Message-ID: <aa11a7ae-d7ba-445f-b3fa-a180843682c1@intel.com>
Date: Wed, 21 May 2025 16:05:09 -0700
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
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 531bb157-5f76-458e-2411-08dd98bbf018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlJ6Z3JmNm81K3o2V1NBNDVwc2dhQitVMHVLOFBadlRxaE1Ra0I4ZUZaajdH?=
 =?utf-8?B?NTJCRFhETnVRMmJJUTVRc1NYTS9Ba1Iwc1BYT3Y4OXZsTUE2LzFlbVRJdTR3?=
 =?utf-8?B?VjBQNDFYcW1kQXkxVTI4UDY3OVNrMlhkTnNMY0p2bVJ6OS9YL3g4dmJRbkNV?=
 =?utf-8?B?dnJnRlZwMzMrVE03ektPY0JTZmw4NDVnUWR4VlpTTDh1VGcyOGpzTkhpb2RM?=
 =?utf-8?B?RWJqMGJYeE80TTNDaXhBUG5oWWFYWDYwOXIzTTlwdVVRUFk4RDU2cUwxMUtH?=
 =?utf-8?B?UWZjTjZxQW5EYVVCd2pHb0o0TEg2eWpVUXc2dnZlazRTalBnWTlCVW95M3ha?=
 =?utf-8?B?NXNwR1p5Nmt5OE5hVzRrei84NDFmMGZJOGtaWHcwN3h3MWxuNk8wcHE4NzYz?=
 =?utf-8?B?d21FSFZXdXNhb2VheE11T04rOUp5SGhQa3lNdG91ckZYbTMvVTJUNDFocHN1?=
 =?utf-8?B?MFpvUHR5WExCY2NFRU96QnFKa2tJMDF3WXdNd0tkcXBWMTNiZXNYK3pFQ2JT?=
 =?utf-8?B?Y2V2Q2kwSy9FbDJMeWNOVGVjdTRyNnlyZzEzS1JiL3dQN05ia3lpYWNVSEZ6?=
 =?utf-8?B?MjJHV0d6WHh0aEFZYkFpMStWemtMUFRpWjVrQkV2K0pCQnduc3JPczYwN2ww?=
 =?utf-8?B?SVRlS3RKd0ZvQk1FSUFpaHNBVmxDK3dNc25jQ1pOTkZsSWh1N3ZTSFFIYnh3?=
 =?utf-8?B?MFFpenlSUmxKVVU3bndTMVNzQzBEQld4NUpTRVptclVKSnhmbHBNVU5SSnMw?=
 =?utf-8?B?eFdKMnhRcm5WekFJb3BBck9Tc0w5VnRFZW5kRjZBdGh5bmFlVWRzZFk3OHpW?=
 =?utf-8?B?VGI1endaOUQwQUppSTcxSGNTUXlkWTVOMlNIWm9NN0JmREtHZm5yOXljWStK?=
 =?utf-8?B?RC9BV1ZuNlhUNlA4UWp4SEtEZVNieDA4RUNvaVRSdnpzZjBxU1lQOXFBcVFT?=
 =?utf-8?B?TTlGekpWVkIxOGU3WE1xSzc3eGpINUF2VFppLzNMRjNlbXhta2lFSnVPRUhx?=
 =?utf-8?B?a29XTGRqS1ZtaGl2djc3WFlkWHVZOWt3bThwQlM3NUJYWVphMVJUc0M5T1Vp?=
 =?utf-8?B?U2lyeXdmbFAwSE1ScS93VDRGcWRiOS83eWFiSkhGUTZFSlFIVXAzOVBOS2lC?=
 =?utf-8?B?VmVQekRVdFh0OEhud2VsOXBFM2Z3MlVjakV3cFFGd0NpcFhIc2RzQU1mTm1a?=
 =?utf-8?B?dGw3OTlRS3EwcnhTZi9DWUJSUldEZG1vaVlZN2tCb09PY0VzaE9vY1lDRmpP?=
 =?utf-8?B?bWhMUjl6NWJ0Q0JCR2tWTXFnMDZNbFVRRTBjb0YzZUFUbHdBVmxrN3g0Yksy?=
 =?utf-8?B?NXJ2WktqWm5TNjAzWVdoVXFXN1pGTVE5U1liQjVKeHNtM0xtY0N4KzJIUG05?=
 =?utf-8?B?Y2RvSWJzenFrTTYxM3JyZFloaCtlcmdXb3NHdDR5MHYzTFV2c1ZaWkJpWjJj?=
 =?utf-8?B?Z1ozWkhwYnB5NGtUc3dmRVlwUlNwR3JKWUdyYS9hcDFQQzNQOHFpeHJ1Q2RL?=
 =?utf-8?B?SEI2WUhvaWhzblAyN2lnYzRhUnc3VzBubnBsdTdnMXlvOFFVQ25paFUycjNT?=
 =?utf-8?B?c1VjdjZscHJDM0MreWR2eVBWNys0TkRWNmk2d05LY3JuQnMvS2NwSk9BZ0xy?=
 =?utf-8?B?V3RCUi9DRDU1dWlSK1lXV256Y1JqWW9tU0FPWmx5SkJkOFppRk1VdHd4ekxq?=
 =?utf-8?B?MXNmL0ZFQTRhMVVYVExwUVNLdnRSMytxenBhRmlNVHpuODJINjA0dHowRHJX?=
 =?utf-8?B?akhCRVQ4Y1JKYUFpY1oyQTNZWGhQT2dLUkxhRi9LYzhERUVEZ01iWTUyUzcw?=
 =?utf-8?B?Znp2bEhmUWpPY0hleFJ0OFJEZ2NkZHFOK3hCQkxZdXRvTVpoUXB5YmJPdlds?=
 =?utf-8?B?eXNTaFROMXBZZC9DY3I5NE5yWHV2VjJiRklodnN4enhSejNzQnRreGhEMVdz?=
 =?utf-8?Q?UlWlufeWLos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1nTTA1bmlSbWRhZTFWWDNXaU54YWtqWi90ZTdGL0dscjF0VjYzeDR1WGFF?=
 =?utf-8?B?OFQ5VGlrODJMUXZUWmw3N1RQbEdVY3lDdUxvMTcvMWMzK2FHNkJGZWRwRXhj?=
 =?utf-8?B?bjVCZXBPNFhXQkxCLzR2cHFqOG45YzBRK2JmOE44dGNhRitaaExjVWI3Q3hp?=
 =?utf-8?B?eHAzQ1ZpaFhvYU0veFVnU2pGNnRTRzVIS25jMWthbXBXRmlWTjc1dkdtZFVQ?=
 =?utf-8?B?Q2c2SmJwOGtHWHRwQUlvUm9SdUNERStscUlPWE9BdWFMWVpXRmI0MVRTVTB1?=
 =?utf-8?B?bzZHOHdMQWhIR1luN2RLOWNDNWxWdmVsNmRlYkptcVpZNjVrVlIvbnlqb2Rj?=
 =?utf-8?B?di9Pdk80RDNiRDVrRjVEV0RTekNGZ0tLUTYzYlhMSklFbWdYUElKYVZNUzJF?=
 =?utf-8?B?NXB3N0lzSzRpNU1ZUWtXcGFoWTlBRnRkbyt6UGovR2pTMUllM1pSWkxRdDFK?=
 =?utf-8?B?VlBSejF6Y3lDdDgxUGozdnNLSHNGaUhISHFHWUNvc2sxMUxlc09aT2RGMW44?=
 =?utf-8?B?UkZVR012TDEweU16UWtkMDNzTkQwNEdyOFpYd2E0dHJxT0RjRlltTVZkOEth?=
 =?utf-8?B?eGhqTDVHcm1JWTRTNWxoc1JzbUJzMHE1VlVkQ1gzZnA3cW5CVkYwVmp5WEho?=
 =?utf-8?B?RVJyYSs0MVhtS1hKQ2VVeE9VVG9ZZUhzRUpNaGFaUUYrZkpDZXkwNytXNnJO?=
 =?utf-8?B?VXgyalp2T3diRGNpd2FhcEowVkhkUmNGK0RaUEJrcUVtYjZrOUZyU1hvN0g5?=
 =?utf-8?B?K2kwYk96c1dJeTZxMTk0SFdHZGJ3RUV2blpydzlPTEVGdUZyQ1JFWWpWLy9Y?=
 =?utf-8?B?OTQ3dXRLd3dycnVhaCtVMVEva00vd05Wdm1uRXhWMVV1SU1hLys0b254L1Zr?=
 =?utf-8?B?dnZENlNQbDltM2ZBc1B1Z2dET2lQSFY4U0FuRUE4bm1lMTBad05wTW9PNTE0?=
 =?utf-8?B?dzlETGplaTltUUZrTE9PSjJLVElMZXdjUStyQzVnaEZiYVlXc1R4U09HbEUz?=
 =?utf-8?B?cUJ3QXNCT3pZNjRya2hKYzlxcExKRkVXbjU2K1B6eDh6UHlEVkk2Qk5oLzVk?=
 =?utf-8?B?TEVUNTl2a0ZWUjYwcGdHeVArcFVSNTBDaEU3aHJ4SFExVFRTRFpNdmFNekJD?=
 =?utf-8?B?SWlxem9iM2NBeVRqbUF3TTdCbkg0TWh6SFlhWHpObGFRbmlVUWN6N0ltVUFM?=
 =?utf-8?B?c2VCOG9NVzU3SnF3S3I2RUJiK2k2REx5b3YrbGZML01RcnVjbVFBNldCR0h2?=
 =?utf-8?B?VDlhc0M1dm5Ldks3N01HVTJSRnNLSjVRWkFsT3NWeHIrTHVyK0tOcG5zRlpG?=
 =?utf-8?B?K3JMeEMwSTFWRkVEVytXaHNYaUlOK3dCcUpDd0hlTi9kVXVUeWdEdnJmN2ZT?=
 =?utf-8?B?c1JkS0t4Y1FOQ1F0QTJDK2FVSnhtcnAzc2greVFHcHVrSEZWbS9jcmFvMXVi?=
 =?utf-8?B?SDVHLzlEWFRVdnNpb0RGb0d4bzg0UjRmYzFndzFqZ1hDK2JBV0IyR2MvY0Iy?=
 =?utf-8?B?NEpBZmdGK3pOdVlKTHF6bm5pVFM3YUQ1aDhYVWxvWmI5eUNHRmR2QjIwQ0Ry?=
 =?utf-8?B?UzJlU1VjNFc3eUpIYmpMZHJkMVpFeHN6QzJLQWYyZktDZlhiNFVHNXl2anRN?=
 =?utf-8?B?eXViNWJMQldTNHlWTGNVYUU2Q3hTNEd0ck4zdTh6RzAydGFrR0RTVDNxOHcz?=
 =?utf-8?B?aXF1RXBiUUdCaGRnbTVPL0Vrdjhsc2NOaGp0RTRObzI2S00xN2RJZVJhZGI0?=
 =?utf-8?B?NnpQdjYxcVNHbFZMbDVYZVBkaWJROHZxOEVEeWVubUxJWGlKU3JZeTBEb3B0?=
 =?utf-8?B?N29xeUQxTU11T0tOS1lCbVo3dzFUNThlV1BSckdRYlR3U0hhUy9EVFo2a1h1?=
 =?utf-8?B?Mjlmc0ZLYTlLL1N1Z1IySFNVeGpQQTgwZ2hQM3Ztdmk0Y1lnNnRlN0tvdDBp?=
 =?utf-8?B?bTV0UUJuRmVEaTRYcXAwRFowaWVZTzNNaWdveElQaGRYSUZiZWdFdGdlek03?=
 =?utf-8?B?OUlZaGU2MmFWSlpvbVBsWnhxTmY5L29ZT0Q0Q1hhQmk0SVcvNExUOUVvb3VC?=
 =?utf-8?B?U0lJcG9aU1RBOEZvNEdBL2NyRWlXbkhPd21UZmNjbnk1WXN3bTdKQmI5YlIz?=
 =?utf-8?B?SkZNRUF2dTVqaGROOTV0WU9uTmZUSGE2MkxxUU5mSEFQQTF4MGdLeGVZWm5i?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 531bb157-5f76-458e-2411-08dd98bbf018
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 23:05:11.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzz+shkeh5MlpRI/ETg2bIdQU+BQwnwA3lSzoTklfteYj+nxgLO9gAeuR3N3suPQQKuY9F7fMfmZVLreUl5w3b8Qm9ouG9Q4EulvBYyC06g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
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
match_pathspec doesn't take the same flags as parse_pathspec anyways, so
we can't check it here :)
