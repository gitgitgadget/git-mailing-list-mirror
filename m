Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7343126CA
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353317; cv=fail; b=Og9ZziM31KkPydLKTihOY//9sA9uEWaXK1q2/DG+hjYhy9Xyrf4n3ujFzRrGtoM5OU4u9chmIy2k4lniUb7k08ldvVC9Lh8psQltnibhlZ86D0g7ym4JLyldUkuDGYIwLGC6Jfnu4PHzgMznRh3cKrP6fBKNXnjIdVrCRPW2r5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353317; c=relaxed/simple;
	bh=1SaCPbMpwqhitA/fnDR8l4WwpaQyfJz0nDO4mBwQVrA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MYAJC50VSL+8a2DzH8GY4+WeH76GnOyxRV8z5tXPoalUAxJ6d9oXonbCUGFTW5rfgGwn+QBsSE33XyPGFnAgNG9IahrYQREmtSPXOHpOAl7TEnQzrlwQMC5VLxrIFCIARNxXt/s/IcdAZkeUArOctV/wI4Xu3CVKXh18+5KaYLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7jtaBqi; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7jtaBqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780353316; x=1811889316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1SaCPbMpwqhitA/fnDR8l4WwpaQyfJz0nDO4mBwQVrA=;
  b=C7jtaBqiIueuowj5iC/7SeuIe72GdryFzirTnPajrC2BvFGHd4kxnDg7
   rVYZ5Et+fRHBFE7xIlQypKxm8Y+w9PkN94TveY5IKP9/EndvNVwKOV6SE
   JVSYNZVQmN/WEwB0mnWwF9VLbQGehg9YkvMkG878mMC63KgvWpuoYHkmK
   yMmej0fh54Lc6UoCRUN1sdAO4khVYXD9eGB2llUrD9yJ+CtDY9szmADY6
   AXMHX2YN7MdkuX9mAbKWrjXO0HbkA71u6RTgxA4AuAHPvV0V+hWepu0n4
   MRIL/0D7jtzqU3zi3CLb+KsZ+CQYNCLI1ewmtZnKR0U3gtuH1PqjsnPB/
   Q==;
X-CSE-ConnectionGUID: raJ2uYtzQzWZfapB73PFdA==
X-CSE-MsgGUID: WQjULtEQS1+AWW+6szD2VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91694667"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91694667"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 15:35:15 -0700
X-CSE-ConnectionGUID: mlIwAnj7RFSYCKEEcVdCPg==
X-CSE-MsgGUID: efMZjTDGSiePk5NVGpJpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248633942"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 15:35:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 15:35:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 15:35:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 15:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX7BNoHSA3fMYICxLhQ1cWTB+34rPwLBlqpQLRwB2hkZ4F8f4jzbEIPjSylh7NGyQbeVQzSTi+Y+X0eUcH7mKWhZPS8uDzspuYFi7YOuoXLIdJCq2jxjfggYVphf3ORH9Mo+nwFbLk0EB9Md9AUfNE0gBr3oX5dPdgWLwiIUXjLIjj9wDX8qr7ve4CX1ZZl5NRWTAGT/zrvj+RoVtoJN1bGUuaaS9O1zLrok1B9guldYffaSrw3xCQBnOIUdt+FVFZ7V1EycKJmXzmxz4F4G49nMOOUVl4X1//YI1md18jb/FQFx52SZ3AsmV/DIRGahEvT0QjhpzHtpa6cNalzokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUEL+alA/mun6cepWE9D1v2HNWcgDzd9BPLjNRrPOIY=;
 b=iXw9j8vpbWa15Sh6Wp+tISPc5aRHD7G+/tNLnSZOASG/Zer6y28XmsfGDgQA0Kmadc1hDzC7MYxByeIy8f0R4RLzpQX8vqRnUmYhtjw/INqhGkXxI9HPz3OKB91Qk4ttPCXT7KMasidv5s6CRYpS0gF+PLwYAhpm8IY7MlE565GslnszposNv0hEvsmGCps3Nlccj6+8b+BxvGpBAhgUa27gWdyLQriUmMxT25/Y7a5zL/lp9YN9vKm/LNeYTXCvAChiFCr2COTZ/08IH+KbarTaacq8psxou814iFNxSw+8+HBpYfjXOg4TGQXu2V9dHwwHFnJKZeYrZq+DYsV2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 22:35:10 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 22:35:10 +0000
Message-ID: <3ad3a7ad-14de-4972-acbd-433ad4ced7f8@intel.com>
Date: Mon, 1 Jun 2026 15:35:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: fix --exclude, --match with --contains and
 --all
To: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20260528232950.187002-2-jacob.e.keller@intel.com>
 <xmqqo6hwcves.fsf@gitster.g> <20260531234644.97LRl%taahol@utu.fi>
 <xmqq33z7ay9e.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq33z7ay9e.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de0f93b-dfe6-42dc-88fa-08dec02e0a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: jzS64D5aOHERQKTnHKvzzddKh2ElvGhJffZUaKdfgMI3f9zU6d/4IjEOQ0EKHqi3yn+OGjAO6iUx4fgI4ztRORtQ3WXpFcD1q1M0GfCmgEJH9sN029pebZjKwnnGeR0AY0Bo9AmWYk3buckb93XxUhM+MmeE/hLQw8q4GrFUfZXU5D5ZNXOd+D+cUPI6LLgLUODNy5a9FAHyEB3I/koZQd1w9Qt8bymhfBcpZyVJdFUkfzV46ksuwi0qDtQwOFsXnsfdds43/FQPk4S0aPyy+JOUvs10XoOp30gTtGUhHmtEBFbgxNGkiOFEPrPBWNhh48Id2gupavqRjynlsscV9GeIfW68O991wtH+3aRlugIqA4NpwqxBFqENTqspwi8FwSf2HuiQb4Gd7zp37a89gS0ZvKYv1KE337kYhXfUXPNTEsDGn6wiDz5Sn4IsNUc04OPKuL0K6RwISvIb+ZJdqHu0+BeKFZFlEYVOrEsgZXigNhB7fuNPx5Tnj8zkSmeTOjlG7ETju2ZvhdvKUNFBBZ4F8hMLIN7DOQTUD6Z+EGEWXMlxIXjGPv71gFcoF8W305cJjPpXaz/wCHO/NhmMLerU1JFjGDrOaANZ1MpgH47SBcvvMnbm9FLTr1o665BC/PnT9ZV+xBhSxRBEbKaoaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFg1a3hMQ0hoUkpsKzVPUEdIemUwYU81cUZEL3NQVVJJcVA4MDVkNUdta3FQ?=
 =?utf-8?B?VkpUbjRXdStCejg2ZnJyOUxkaENIV2wrNmR0UkJoWjc3MjlZWHFnelAxb2Vh?=
 =?utf-8?B?MXZYelpVL0RaNVVxdWRLaExscmNTU2RMTjFmM3ZNSEZ2NkpOVzhIMDRIZjNZ?=
 =?utf-8?B?TW1oNlZPT1NGY1d6TWRkMVZmdS80Z0h5TkV4S2xIc29LWTdzdFpLaVo1czlD?=
 =?utf-8?B?QVpnMkVtRWNkSFZ5RlFrSUJpTkJ0MUp3U0tRMklJSnhOYXhWalNpKy9Ob3Iw?=
 =?utf-8?B?T1NXUDVaVDU0OTl2WnMvWlUzdjBPRVNlTmJCRVBxSFk4U1NtQWIzSlZCWVQv?=
 =?utf-8?B?MkFERnU5TVdOMTVYRmdNTjNEYjY3dzJRTlV2cWZIUW9RM1dCeWJJWXlNNDh3?=
 =?utf-8?B?d3lqdHFnSjI0QnVwN3U5YklFSFNGWFNET0lVT1RhS3hPWGp2eGNEakYrdFlD?=
 =?utf-8?B?eW9ocGVFanpPSHRON3E0Ui9uTlVPSHdpUUg3c1ZjUkhZL1lHQ1BCNE8zVllR?=
 =?utf-8?B?SjV2dXVIeFJTSUtYOXArdzBCb0lxRlBsdjZlR3Z2VmdNWDJLUU0wUDhLS2NV?=
 =?utf-8?B?NGM1NzBUUU5pRjRiVEZHc3VLQ3NENHp6Q0ZuNERvajBBNlFNVE5hTXZqcWdH?=
 =?utf-8?B?SWJxN3lvTzZLcXoyeER3bzh1enNwZk5SdlBoZVRGdGZ6NkpxeG10alhTcDZl?=
 =?utf-8?B?eEp2RFVYQVRybTQySEViUXRXS0lPZ000Z3V3V0NtajZmNEFSS01xUDl6QzJs?=
 =?utf-8?B?R0Y4bHZET0tuenA1aUdPZUoyNTB6QTZyRmo0NnA4TjFxL3dUNjlDTDZvZDRZ?=
 =?utf-8?B?cUJNMnNIU0FINGtrYUJhU3hUb2NCSFA4M3VNMmpFTU5zZGRzN2pROUhOY3RF?=
 =?utf-8?B?K2F6WHNaZ2dhOFVjL244ekdXdGhoRFEwbk4vZm5lbU5CUm4rbk84WkI4QlpM?=
 =?utf-8?B?aTRtaTUyeTUrRVVJT2JHelFQSDBhZi9mVzV2QVROWnhQbHJ4Z0pVZkEwNUxy?=
 =?utf-8?B?ZDlHME5pVUhmQ09OOFQ0YWdORE5zS2dtSEhxTFAyblIwM0k5R1BYemZKb1ha?=
 =?utf-8?B?VW8yMDFRWnhBaTkvM3pLaG8rZGlqb2JwWXpUYzhsS3pBSE1ndHUyT1hLcitk?=
 =?utf-8?B?eGlGMzJDbXZZbWJXcUlkN2FIeWJ6TDNNcm9CUTVCTVRqUVpXQ2ppNGlhNTAv?=
 =?utf-8?B?VmRCQTd3Nzd6N3pPRWNVUmRjbldHdTFvOTJRYUUrK054MmJkYUtGamtFcllD?=
 =?utf-8?B?d21McTFISUwvM3BNaE1oSmlpWllTamRhTktzR0tWT1BGc2s4RU04UzR2RHZ2?=
 =?utf-8?B?cVNTRVdtZCs5OEl6TmVwMzBnckxjNmR4ZXR1a1N5aCtobk1neERuWTZYNlhP?=
 =?utf-8?B?aU9SSm4zSDhsUVhQUEh1VGloNXI0SXJXbFBteEVWT0VicGtiNFFTbjRxL29G?=
 =?utf-8?B?eUJrU2xTdWFVVlJGWi9FZjVBRC8reXludWJBbGZFVWNYdDd0RFhwTUZYcTFC?=
 =?utf-8?B?WFVROEg0N2M5dy9MYURhRW9kWk9zb0ltU3lCcWpuaVRpYUhOYmxlTERubnVV?=
 =?utf-8?B?MlNBMWpiRXJCOHBrZWVqWFB6NkV6OEFVRVE4TE50YVZ6amZ2bWpwS0NzYm5O?=
 =?utf-8?B?dUkrQ05KT29XeW9LdmlMRjlsWVpKd1lDNFBvMVdlYm1NeXpLcGFBa3hxNXhq?=
 =?utf-8?B?d25oVzArWmVyd01lWWRYaEw1MTdtanpiRjBCZWRMOFhHZkw5dHVORm9vZjJU?=
 =?utf-8?B?aWVkZmphUEpDTno4OWZ0Y202STlBUG9vSEdsWkltVW5va1hzaHAvNWJVcEhI?=
 =?utf-8?B?cFRMSDZ5SnM0VHBTbWVhS3dwZkxMNUI1djN4ODlWR3dCc0tDT2Fzc1VOM0JG?=
 =?utf-8?B?QWI5MW5yWllxc2RRU1VxVzVNRnA0QnFwM0ptSW9lcWpqRWVPKzJWcTArbysz?=
 =?utf-8?B?TEpzN01YaUYweFBUWUJ0d3poay9oZHUzZGp6dENEMnFlUTd2SWlBK09Jc2ho?=
 =?utf-8?B?aHc3bmR0OGZFSStMNG9wUUF1N0xqRlB3YmpHamswYTNMWW1JT21aYWdUNXRs?=
 =?utf-8?B?TWNka0EyREJqYm1HY3FnN1ROZHpHdXhEZGRDUXIzb0hVcXR5Y2x3bEVmbnNF?=
 =?utf-8?B?QnJOTFFIUHV5RnlDQXhmQ2NkWCtNa3lYcmlXeUlyYlRTd0xJeEFvTmwyVm4y?=
 =?utf-8?B?QU9pZzNKVk9Fdm5BbENsUFBRbHpHbzRsTlFwaFpoenhzbWVXSnJ3YnpJYyts?=
 =?utf-8?B?WVpJRzR2V0h4OUpxSWhtV3dNL1pFNnZmQmJPVTZpUWJ0alMvTWpnOFFoRGQ0?=
 =?utf-8?B?N0RTZDFZeUdoQUs0dXh1L2RmeE1mZkRMcFpMN0FKZGxOQjN1RHZGUT09?=
X-Exchange-RoutingPolicyChecked: roi7QIjhLYEeedPz8n5dGaGohCvdB7JcGzT2yJeolIBY+NzoHoTf6vZB1f/eJn2/5KiKxYEBMXi6WBSMGJiuc/H09jDSSiE+qstFWAzQpbgdWbEUObL85+wxI0rfzCAmdkBf6+ruBVVkxKSHoF2cOSCRrOYf5roHEzyzAFqfrtdoMJmeYN9K96TOjyHxUaloDCkQuXev3aXMh2o2opc/Oxta/Nd7x/5kbQitDSPsypIdx3Cj45uH3tI5f/4af685PBLlBuLyA5ULF9LOQ7sNLpU0fXogw7neb7+IHgruyAemouFCFn0h0GERoBrchliDTNlDDSOOd605wfXwIoy6kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de0f93b-dfe6-42dc-88fa-08dec02e0a25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 22:35:10.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMfYUoPFIWsWrqzwCN93kEVe69TGu/fzDjrgBCgRxwULNsgyd/Ouurv4g35vgtoUHVP0ooZYlR+2KoWcjF9At1wxblSHLO9UMplDpHe1B1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

On 5/31/2026 5:40 PM, Junio C Hamano wrote:
> Tuomas Ahola <taahol@utu.fi> writes:
> 
>> Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> It is curious that this fails in some but not all CI jobs, and even
>>> more curious that these failures look the same.
>>>
>>> e.g., https://github.com/git/git/actions/runs/26671595367/job/78615760984#step:4:1984
>>>
>>>   +++ diff -u expect actual
>>>   --- expect	2026-05-30 02:21:23
>>>   +++ actual	2026-05-30 02:21:23
>>>   @@ -1 +1 @@
>>>   -branch_A
>>>   +remotes/origin/remote_branch_A
>>>   error: last command exited with $?=1
>>>   not ok 70 - describe --contains --all --exclude
>>>   #	
>>>   #		echo "branch_A" >expect &&
>>>   #		tagged_commit=$(git rev-parse "refs/tags/A^0") &&
>>>   #		git describe --contains --all --exclude="A" --exclude="c" --exclude="test*" $tagged_commit >actual &&
>>>   #		test_cmp expect actual
>>>
>>> Rings any bell?
>>
>> That's way out of my wheelhouse but this seems to fix the failure
>> for Alpine at least:
>>
>> -----8<-----
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index d6594ada53..1776ffab46 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -416,7 +416,7 @@ static void name_tips(struct mem_pool *string_pool)
>>  	 * Try to set better names first, so that worse ones spread
>>  	 * less.
>>  	 */
>> -	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
>> +	STABLE_QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
>>  	for (i = 0; i < tip_table.nr; i++) {
>>  		struct tip_table_entry *e = &tip_table.table[i];
>>  		if (e->commit) {
> 
> Ah, OK, when the test has multiple candidates with the same score,
> of course emitting any one of them as the answer is a valid and
> correctly working program.
> 
> So switching to stable-qsort here may "fix" the test breakage, but
> it makes the real-world use cases worse, doesn't it?  When any one
> of the solutions with the same "goodness" is acceptable, the change
> makes the code behave as if the elements in the table before they
> are sorted have an "if same score, earlier the better" kind of
> relationship between them.
> 
> I would have preferred to see a tweak on the test side to avoid
> having more than one answer of the same goodness, or perhaps list
> all the possible acceptable answers and instead of using test_cmp to
> check for the exact answer, take any of the acceptable ones, or
> something like that.
> 
> Thanks.
> 

Ya something like that is probably better. I'll look at cooking up a v2
which improves the test here. I think part of the issue is that the
previous tests setup a bunch of tags and branches, so figuring out what
all the possible outputs are is tricky. Probably I can just add
additional excludes until there is only one answer.
