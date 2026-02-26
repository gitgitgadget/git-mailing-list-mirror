Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C13161B1
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148833; cv=fail; b=ceT65tyU6UGh7N1qQoas8XjHMzCiPOtiCKy1IfhK8SzhQrQPSM7sczXqj04yzIp+8+kv7Eg3DpE6sJxLWTVTpZGNH3NdmjFmzp+nhSNjhtV+IYTTVxMa0Vg/dHUrnwekQwgY2P3nYBvskE4vQWl0JVNeyYOIwmsbQ2CI4+rfww4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148833; c=relaxed/simple;
	bh=bLvdCVPG73EvcoBEN+eG7h+NgVmjSUvt7c/kyQKo3ec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLq+J7nQaUFVv1r8vBVdkPkggbCB3IQLoQ3Bcr66v/YrQJCJXpywMh5eTl5Xin3m0w61ZN+y+wk+0xnoxZ4BS0ZvzfWk1CMtdH2VqKq80Qkks5fv+NeO4I8dhBfcz4aCZCe79VeeTrAZp9fZHUZ2MwPp9uCmxBG+bC5sRXV4Eyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE1aYVdv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE1aYVdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772148832; x=1803684832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bLvdCVPG73EvcoBEN+eG7h+NgVmjSUvt7c/kyQKo3ec=;
  b=jE1aYVdv+DFmL2mjzgUV7fndmG2j21rxhut+IMIgUFL2Xq+mG4ohlZKP
   +nLV/PsGGJZ6OXVSGIFN7A7N2x1buMygYMBasa52rI4GUE5sjzHBR8xlv
   3dEPVujxSBUNYvNxD82ZE6A4hxUS8vTE+CqIir10eQNUixDXcsmDkTA6H
   c0tHngab4jyO7ELWiKNXDnTE72z22BizUzf+IqajAULuk1FIbhLbhcExG
   lUBZq7ubi6RhS2gjTsVX5HtCUoLUC0K398uQmgzx2WzeJFth+PypwAQpc
   25uJSQItfIJZW1duU5QoY+G8cx5F9T/gePg3Px2RuaYcTvKonEeUpogyq
   A==;
X-CSE-ConnectionGUID: RvPMTEb2T5+QXLq1RMhnYQ==
X-CSE-MsgGUID: VLomsGLaRhiSwu0nF5LfPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84688676"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84688676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:33:51 -0800
X-CSE-ConnectionGUID: 8eF7kVruQN28uqyeoippbw==
X-CSE-MsgGUID: WV2+wpX5RKy8qwdHKE+8ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216844661"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:33:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 15:33:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 15:33:51 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 15:33:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv+swHMKby31nPqNiBz/bU1gjwnSvjosuw3IFYQIgP89dlvShculj/g4YHK66kg9Z7M+dridWYZf2uv7AkH3ubWx/40KK/Jixw2ei3kmjtR5p89cUW65qraeVFsCfJtZgju0gG9a4tPNFPWYfZRFGKiDtOCQ89YWV5YWA+hRVShnsmglsYyW+KYMV5l411dFPyII10oWGA/cVSfrQvhUI5cm4zI6Sx1gu6vJb9TqyYU72m8pch+SrJ5ZA/m54niRd55Vo/HJOAkl9SRkImX3xGvMNihQqJpFapTn7uFY0ncZGu6DAtton4N+4uamtEwOwlXQfUZ3uZHOSHVFcBY4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4AOgmPLCKQo/v7QXngmC7rojel5Dwl6KgkwrckirUI=;
 b=e7z9w5v9ytHBzK2PSV+NUkty5ppE++eH6WO07lp4sCFmv7wmYU2WvpNBO3G+b9LlItDlFKHFSsSstUprS5DYpDlz3N69fos1yrg6LTr2igGKWwSKaAAdiG3Pny+OPiXWxBcCqtLOYDMJTUuuZunub+SO6AYbdnBMEtxCCxO4SJVk6uz/E7WgC4D0sIiVSV+1nDbYPJEJeiEkkc40XdeizcCYCifZD5oVNDBcWU/3xp+OsKLdhiYh7a25U1KX+ExxClIW359pNJA7nzIa1HjGlndvOaCuZxJHvoX3Bp3eOqdGbQJvx7Wy2X1vzqPIxinpVzMtsfT2MwW5UwuUU3EvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH0PR11MB5806.namprd11.prod.outlook.com (2603:10b6:510:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 23:33:49 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 23:33:48 +0000
Message-ID: <71a2c638-9dc4-4add-9306-b4110e6c499f@intel.com>
Date: Thu, 26 Feb 2026 15:33:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] help: use list_aliases() for alias listing
To: Junio C Hamano <gitster@pobox.com>, Jonatan Holmgren <jonatan@jontes.page>
CC: <git@vger.kernel.org>, <peff@peff.net>, "D . Ben Knoble"
	<benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-2-jonatan@jontes.page>
 <6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com> <xmqq1pi9epc9.fsf@gitster.g>
 <xmqq8qcga6ya.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq8qcga6ya.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH0PR11MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda3b13-a1ed-4b94-4690-08de758f7dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: q0Ogt6/4LAf5TkqZPPxZPOMCk77E8f4tgRk6zy0avD8F7mLUKTPEBIR2eaIOef7xxpe0J3MJUvBrimz2IR1MI/nWOKrwzCmtdmrEUh7JhpC+YGTqtFq3BxzR+8PWPqOSr09CqIB2pLyOT61O/re2yD2aSXNbdIRK8EMGpufx5M7gF8i9t2hZP2SZriYEe7L+/0Yxq54qqX1OYaOe2sGn8n6cwl9mlGsDHCkd2VmP74BTkmckxoIqc2/cFK5l74QEDiqxya00VcryFQUQ3qvGll9ntfTkQhL3uN/tp9jpWxODfBZrifEb6Wqs7cMIaHr8EGuRJChFZlzpRvO43OoChVIG9IywiWX6nvG1ISX9+wjpyF7MV7ohqj0lbtfKg+WUqYB6ZKiR3dR4IJVRPqe7U+roWMwUgcGyyx65aUuVulEABU2No1eqjmSVHsCjqacOQ6EKc0uLH9/IfEjf9jjHIYJxSVXXeifVdnxYsbeOhSc2d5hb1hmN8vW/LJCqn0XadUv+zIFwSg7/E6rkEg0EHSt/xrsXGSFfe0j4oPk8OMRJbh5AMsEMR2hqDZXxUGND9PejDXU5xeHAoGOMqQRqbZYXW8Iq5ehJ2MT7eZRITJhxN3vYFRWv/jO/msQSljcf/q9dnKZ2u0QFLisUICCm99I5haEcXJ8ZK36dZPbwLhQLnSILj5yCMMLdaeP/tKALkh+ZJbR7kucF25HAlgAjkbKb4mo9EGlppZBSaG7OPsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NiS3ByTHVRT05JTzBmZ0htNXpBdEZ1VDljMUoySDJtYnRSOTk2NkNGL3Iz?=
 =?utf-8?B?Qm9MRzR0MW8yVHZJTnE1eVFIYjM2WGJMSkQwVklRUFkyZVp3MzIzZ08rTHAr?=
 =?utf-8?B?TmIyZUV1YWFJakh4a2FHWGptMm9tdDk1R3AyWWJGQzNzbVZDQ00vOGZhdGo3?=
 =?utf-8?B?aklZejVCaTFHa1RiNk9BemdmRjB6MS9LaGJ3NVhjcjNUbnduM0NESkcwZGZ4?=
 =?utf-8?B?VVlDMGJKZTcrZ3FEdy9GSGYyTlRKL01waDA3SjJ4ZllDK3BqZlQvdkN2MGY2?=
 =?utf-8?B?OVBJQ05KMnRrU0xOUmJyemlWZHdmWU9qMkVSTzZ5UnNYVk5LeUcxZ0djMkhM?=
 =?utf-8?B?TTVlaXRURTRaeVV6WDlnZXh5UmdZeXBUMDh2R3hPcDlYMHZVWWI2cktYcjJE?=
 =?utf-8?B?MTV4WnhlTTJiMHNDTXdBZzE0SHpobzRNbTgrNUNIL0t5ZkYybWdDdkxuWGpG?=
 =?utf-8?B?VXdNQm1MKzcwbitzdmVoUHI2QnRISHhhd084bUhVYjYxcUxNZjM0OTR1M05S?=
 =?utf-8?B?VXpNZk4ycFJYU2Z3ZEhtWlduK1NUNm43Q29iekFIaGdMOFQ4YWlxdzVvbW5N?=
 =?utf-8?B?SEtBU1JYWFlhQ0xyRG1TRnF4M1lnVzU0dUlBUFhJeGxqbWw4WGVkeHBSVlI0?=
 =?utf-8?B?d0svemtlUktCbGd4MElEZU1rUXU1MTc3RGJVcGVKUHZjdWVpUFR4OVNFempC?=
 =?utf-8?B?VkZ5UWZ1WTRvYlk2Z201N3A1MCt0QUVRS0pMblpYUUx0ajk1dE1HaVBWS3Nk?=
 =?utf-8?B?S2tudmtWUjB2NDFkUFMyWWswamN5djNSOEV6eXAxaXNyNFZLZUVzcWM2NG1E?=
 =?utf-8?B?eEpYbU13YWM5YjczcGdqUFQyeHpERHJQcS9QWkNYT1VXcFdFTFF4WEkvRmRz?=
 =?utf-8?B?eU5VaGcrZlAxYVhnVHo4dXhnZ0VsTkplL3BLazJPd2tnT0c5RmE2eVVJYXJx?=
 =?utf-8?B?M1dMek9zaWdOcm90V3g5dUg0MC95S2ZSTDJmMGF3U1BvM25mVkM4TjBnWHht?=
 =?utf-8?B?ZVJYNzlHbTNVelcxaEVxTERINVBzL1o4MUtxb3o1aWJiQlNIWitxdy83dmpX?=
 =?utf-8?B?S3o1S0R2K0hxTFBod1pob3lLRmtxdUx6MUJseHErVVU2WEw4V1grd0pYWHRr?=
 =?utf-8?B?Qi9PY1ZxbnN5TVBSR3d4YjVpKzdXWklUYnZBcE14MVhGMjcwRTRraTFwMFpO?=
 =?utf-8?B?QjhuT2h3dWZzeU5CYVM2Sk5QaGhrb3Y4cmZCMkJlVWE5eTFnWmMvZWt3V1Q1?=
 =?utf-8?B?RU13SElxbTJzQ2lFNEZTMVFNbmYybk1VNFFFY3VTR2duTWJUV05LUlVmcCtl?=
 =?utf-8?B?WXRSU3ZCSzhGSmRZVThEaHoyVHJVVUJFeitHRjEwdDBuS1l5ejQ4MkQ1andn?=
 =?utf-8?B?YjF1QXU2aU1jQldac3dXcWxNMzIzcnB6OUFhRU55Q0x5eEhOdVpiNE0rcEhB?=
 =?utf-8?B?NDNjdTVTRFhGaVhGRHhBOG5YZG1FWFZ2TWVUb3RIQndxcW1ZSnV5ZTZBSldI?=
 =?utf-8?B?SVYwM3JBdDZuSng2NitXaU5OVW40Vkczc253QVAwODk0SDU2V2s3Y0pTUmM3?=
 =?utf-8?B?U1hkZ0UrLzhwSlFTa2J6SWVDYXRRaWxKSzhCandQem0xeU10L1BPV3pwWW9a?=
 =?utf-8?B?REM4Qk8zQlRmMzh5Y3U5cFR1WjBUR2hLRUE1aVh2Zzg0NVVvSk1WbjlqRTVJ?=
 =?utf-8?B?NEhiV0RYUE1NYXVURmE4SHRrOU1XWjZIdURRMnh3dG1TYVNYYjkwc2txMUZV?=
 =?utf-8?B?UXB4OUtVSnp0aHVZc1RrUms3VXZFb0E5eU5LaDd0eFNwMVJGU3dWTFAyZkV0?=
 =?utf-8?B?blFENmJPOStsU2NIRzcxMDB2SHA5MWNhb0RqZ2dCMFRuNElWd1d0VXU1ZEc1?=
 =?utf-8?B?bkdVa2xTUmZLckNFVU1QWVlFcFhYa0lqTlVVWUVGNUJpdjRTRXFjVFpHQzEy?=
 =?utf-8?B?bk85ZElSRi9RbXIyV05Mc1AzbWlKc3dPTUpQS21YYUpITk5lVk1lMmFQdGxa?=
 =?utf-8?B?TnlUTWY4NXBiL3hNNUVST3B1UUY4TGVYYVRkWUxOK2V5T1FxSk93cHFaMWs5?=
 =?utf-8?B?MitMS0ZUNjJoRXp2K09nRk81ejgvK1J4VlFUV09JZTZSdkVmN3VVS0RhdE9P?=
 =?utf-8?B?UlNpeEk2UjNkTHkyWEZ0cmt2Q0xCZU1DNlE2VUNhdU5IU2pBL2d6emltNGhJ?=
 =?utf-8?B?aDhGcG4zb3p1M2svYmNHeGxGTlJGcTArZHE2RnFTT2N5clIvdVJDWWhDR25r?=
 =?utf-8?B?YTRpMFVIU1A1WUgxS28rMUovMFllbXdFajBCa2JDMzNVR2JSTFlVQXFLT2c1?=
 =?utf-8?B?S3FNUlR6V1JFUEtIc3JscHpwcnBsQjFvS1ptaUxwbGxLTkxDamgvQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda3b13-a1ed-4b94-4690-08de758f7dfe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 23:33:48.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jv0ZkVNtMeAlhv6GwNSudgB+n6Rqnef760rAW3GRBHDDq0/UE+Vmn5+QqitsWsq9kvu1qvXzdl7dseGRhzEF3px282fmCNaD4N4kOEgQDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5806
X-OriginatorOrg: intel.com



On 2/25/2026 12:45 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> SUMMARY: AddressSanitizer: 1453 byte(s) leaked in 37 allocation(s).
>>>
>>> This leak occurs because you now copy and store the value of the alias
>>> in the util element, but the call of list_aliases() in list_cmd()
>>> doesn't clean these up, since its string_list_clear passes 0 to the
>>> free_util argument.
>>>
>>> The following fixed it for me:
>>>
>>> diff --git c/git.c i/git.c
>>> index 744cb6527e06..aeb099ab1162 100644
>>> --- c/git.c
>>> +++ i/git.c
>>> @@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
>>>           }
>>>           for (size_t i = 0; i < list.nr; i++)
>>>                   puts(list.items[i].string);
>>> -       string_list_clear(&list, 0);
>>> +       string_list_clear(&list, 1);
>>>           return 0;
>>>    }
>>
>> Thanks. This looks like one of the right things to do.  I checked
>> all list_*() that are called from the loop in this list_cmds(), and
>> list_aliases() is the only thing that uses .util member of the
>> string_list_item instances.
>>
>> However, we need to be a bit careful with list_cmds_by_config().  It
>> sorts the list accumulated so far, uses remove_duplicates() on it
>> without passing free_util=1, so there is also the same kind of leak
>> there, I suspect, until we adjust the call there.
> 
> FWIW, here is what I tentatively queued on top of these four
> patches.  Hopefully we can have a small and final reroll for these
> "Fix small issues in alias" patches and merge them down to 'next'
> soonish?
> 
> Thanks.
> 
> 
> diff --git a/git.c b/git.c
> index c5fad56813..b5eb740e83 100644
> --- a/git.c
> +++ b/git.c
> @@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
>   	}
>   	for (size_t i = 0; i < list.nr; i++)
>   		puts(list.items[i].string);
> -	string_list_clear(&list, 0);
> +	string_list_clear(&list, 1);
>   	return 0;
>   }
>   
> diff --git a/help.c b/help.c
> index 82fb2eaa3f..725e92a195 100644
> --- a/help.c
> +++ b/help.c
> @@ -423,7 +423,7 @@ void list_cmds_by_config(struct string_list *list)
>   		return;
>   
>   	string_list_sort(list);
> -	string_list_remove_duplicates(list, 0);
> +	string_list_remove_duplicates(list, 1);
>   
>   	while (*cmd_list) {
>   		struct strbuf sb = STRBUF_INIT;

This looks correct to me, and I didn't see anything missing. Thanks!
