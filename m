Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F81F4C96
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788657; cv=fail; b=rUma5tMgfs98rlOb1MjyJug7jkgk4u/xmd1Me63dIBXcYJhWgStcMRJM6PRGw4VcyIIT14hC0rytDEJqLR70Kzrqb5LyzQAefcAHy0z7cn3dnWgC2D3CjZANdFJzSFtFhWeXRb81SazGECbGKF3wNWKp1EyrLFzOV2fgWTs0Etc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788657; c=relaxed/simple;
	bh=cKe66tctDAeE5FS2g6DiR62gbO1r/HSf8j3jYUAZ2Ww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuibJ66VuVQ2Cfk7buFWNOMskBI+unW6WbXDBN74RqigIGKoXb0180oRPrsz++tJPgyBU+j4UN7VyIy8rhmyjDRIOIDavxZ+3VjyrK8YioHnKqUXQpr+VfR8Np0Fbymj8PKHY6n2em/E0x1jSymQPkVmBCH7bcyoIWfjaPxifaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsHu2gFT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsHu2gFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772788655; x=1804324655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKe66tctDAeE5FS2g6DiR62gbO1r/HSf8j3jYUAZ2Ww=;
  b=TsHu2gFTsQKePvBaS6an22j/3rkL8dRvjfuCf3lY07hs1m4VsDGDiDGy
   HYOJMY05BYejDgIJrTxVeIz8AK4PV6+AlY1s4D1MA8WSoyW1fz+7oTg8l
   Odvy0szD3s+B91H04FnUYdId0q52VnIYxdij0mqQ/k9rfD2M2RYp5eDCP
   DzwEofyNcH0hQ0p0xlRzR1nmQw1nYp2p/m4Z/W/eoOLy9D6fEUuos8C9w
   n+kZnhg2hdhcGJ8o003MbRoFK7LyIwo8Eb4OT8fAU78tt/ez4AI3CFmDi
   RK0bt2Z2oG00m2VgI1UnTpu++FLg1Hq7K0rjrkXt78kLDsVpaP/OGx6BO
   g==;
X-CSE-ConnectionGUID: IsMbR9OXQW6v4JH9HD42+w==
X-CSE-MsgGUID: x5Bvf1ncS+OLYB5B56voTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84977539"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="84977539"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 01:17:34 -0800
X-CSE-ConnectionGUID: H1TnWSodQWifNZRv6UWpww==
X-CSE-MsgGUID: bVU/bQCySYC4krjpA54O1g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 01:17:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 01:17:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 01:17:34 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 01:17:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHRg2hSqiak2fHSIeipRyhSnIcx5vgZo8V9w8CiiHvGesz3c6F7A4kwZ/jv3Z0m5+t8C67URGVyupRz55bPwMoTk7t9A5UUkBrIGegwTPq7c9gLU+Cx+XPx97voMwtUewwAOBP1NTAYXXjOotjTk+sTv+vbq+M07p4xbw9kjmMsPJ5DoSo9Lh9SQK9Az8LfUVW51yiuo1d5SQiIG9salrS+6OoN+nrU4rLVTtHB6lW/Ht29+cuPxPhXJyu6XR/xb2ccn9q6fegOmThzT+4v0f05SxHswQW2JQ8u0wMk+dKytrt7QH1By08rCE59OKC2STBnwDTVsWy+015JIBfatkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntnjQw4ul0BSI/CfKOOGRuP3V9Pfc62Z9XQGbkuKXRY=;
 b=hGljkB1QOSbxlhhQy41g6KoCGXynUTnMcDZZTYQNsesSpirmuxhoNwxf43Dn8AYLo+mPNOk1J5IAjKvfkKMkrzJbjKheDvUV8RrPE1b3qkPX08b1cnXelsqesKUMnidpJiYxaC6OCxfvomdWB54avYB3EE5I/HCWCZdn+joUjiT+N7ErYcKRVitwRUUHF6GxSZkSJBe7oLXlw6TqNKn02I3y7+DJFEpzd0x1tLx1NNDKUk1gorK2UW3qK7O19k7BDraU2fFOwC81I+Wtg77lnTHvo49MQgU0iVu85b/CkGTFanzqmGt0ko4aAAgs1/9pQf8IkieT1qMSaC42hjilig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.5; Fri, 6 Mar 2026 09:17:27 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:17:27 +0000
Message-ID: <796110ee-d795-4445-9d82-7026370a88cf@intel.com>
Date: Fri, 6 Mar 2026 01:17:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Makefile: turn on NO_MMAP when building with LSan
To: Jeff King <peff@peff.net>
CC: <git@vger.kernel.org>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
 <20260305231305.GD2901305@coredump.intra.peff.net>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260305231305.GD2901305@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 084064c1-4350-412f-90d1-08de7b612f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: CHxmxWrL/H9SCJbBm87xNJ2Q7eJO0AL3y80s1YENx4ckr/cuaxe+Rl0bFJnFkU3V2vwce7JcqDog1JWRpWSx9MKJI0e17wWfMFUwR6ufna8aP7KsI2yiy1QaOyk76zcp1YP1GHV4b1snWW6W25Tg4UFXr1WvfawcdUN+6cTHMXix9xTLRBiQhj19430te+pmhJMMe4fQwTSL3xp7gbQq3nW3i9fLchM6MS3hPFqG+trlVpqTqN8HiDbpYy+qTpLkI2u2/wWhtMArdHInV353deo+e1eK2or15B54UlZQNIKx+99lbIQrtqNQVkUHl5By+yZiOLb3zeoR9HSPAB+dykPXgxBWcKShqeD9ubXQvSD/npF2mJS06RPgHbCS8zOfqluun+JApCFBeocAsYW8S464osYehsL1hM+OA0lEF3lNt5M4CsQFymlpY57FhUFUij/EFf+AsONFwVZpZqd0MjjUyNcwYOh4/dClO9/nWuAt0xTkvjjTz5mAa0q1B/ekyqomLw1fIiKXNGML0mBkE7kp7/baYwP+j3M8FYkaglprHpwqlO+uw9Zv6OybwfoxcorBNWBMFSGfLw+T8UmkjXQ6V9uMdJIp+m7W7YWTi2xOrq+ZUhyB4/jdz2jawR+HPiBVk1NVbR57buJ0nmqpV/zgocMj/GGJKDD9yDvLCzZQ6T6V1iZyBpq1Ke9Mb47rSQ7Pto6diVNdabq0tWIsrMXFBwPTjgLF8LGKN/S1FIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdFVGFWUi81b0RZWFdsL2lmVWtOVVUxckFBRTFVclFTL2ZrbVcwa0tBMEth?=
 =?utf-8?B?ZXBqek5QNTk1bHZUZHBoKzg4aFh5dmZvZnJZeVFnNTZ2V0VyM2poNjBneVV2?=
 =?utf-8?B?cnNIUGlncUFlRmV3TGFwUkdqVEZ5dWRYRXR6VmQyR1QzMC9YZHRxUHpXUzNT?=
 =?utf-8?B?OS8rYkd6R0lETmI5UmQwQUwyb2F5SVFaN1pCbGo0dS9Ob3VmS0ZyNXJONGtp?=
 =?utf-8?B?NnpkSnJCQ1ZlK3NVY2xEY0NMM2tYdlM0SzViR240ZXg0UlNmcGg2cS8wblhI?=
 =?utf-8?B?OGw4azFuSll2MGNGSElsMkp3TTI1b2x6bThvWllQMlRjSXdlQ2xoTExQUVpY?=
 =?utf-8?B?Y3dxL0RIOXlkcmVRYi81eTZURm1DZFJQQUg4aU5nUW9OTkdxQjR2MEwvcU9X?=
 =?utf-8?B?SkVJL3VEY2VjenEzdkVUSm5WUEc5c0NPZHh5V1dpVnVxVkd5NGpHS2hKL0pF?=
 =?utf-8?B?M1RnNVdOMWdyZUkyZi9WdUJNL1kzbDY0SU9QTEEza0FXWCs2d0xBQmM4MFlG?=
 =?utf-8?B?NjFUeWJMcjd4SlIwNmp3NXFvT3h6UDVGZUx4ZllrLzdRWVZraE13alJqNy9Z?=
 =?utf-8?B?R2F1dDErdXY2OGJ6NGZtd3phZlF2MzRITm5mV3VIMmR5RFF5WG1LTXdIeDdB?=
 =?utf-8?B?Si9hczZWYjJVbjRnNTd1YWpYaWw0Q211c0loZStyMXhaUncrQkFNU2lXRUx2?=
 =?utf-8?B?SmJMWWVCd1A4YmVkT2t1cmJPTWVkUVo1Sjlzd3B5NlFLREhxUzlzLzRvY3dm?=
 =?utf-8?B?cUlRcFRjd01Kdmc4YzNPZXV2V21xYVo2ektqVXNLN0JOL2NJV2ZzRGVYdjhZ?=
 =?utf-8?B?YnBFdUJVUi9OdldEV1ZOQXZJZWVpUEp1c2Y3NnYxZmduUzFxeEt1QmRadnZz?=
 =?utf-8?B?dkFQa1hHUUUzN1VXY3dFMTJuV24vQm5YbmNRa01VSUkxeUhWeHMvWnZ3c2JH?=
 =?utf-8?B?K01NSm5tQmgxVnJDWDVBd1ZSamRoSi9QenRLck5XUFJxM2xNc2NCN0dBY3M4?=
 =?utf-8?B?Sk8zVFRTejF0OVNZQ3I2OTJsbitCMEtqb3N2Mnkwc3E2bFUvN2kyOVJ6RWd6?=
 =?utf-8?B?MEhVM2hRdjE5Y0d5anBGUVhnSnByYmo0a0dBNXMzNVl3eTZBd1QremtDUmJ0?=
 =?utf-8?B?NnpzZjUwVXJ1N01KejdrUU1OWmN3dWFVODFUdUF6L2JGSlFKT0xqVEQ3NTlZ?=
 =?utf-8?B?Tjk2UkRLb3hPeml3ZXFDR3Fxalo0N0U4em1TWm1mVVpIcExveHRvN3EzUW0r?=
 =?utf-8?B?UUxNZ2w5RTZLYmJFTmlQSUxzNGp0OHJZck02NlRNWFRmODFiN0JYWXZyQUR3?=
 =?utf-8?B?SytzODVlYmpsYTMwOEU4aXdKWWN1VmRlZ01FY21TZ2dVZlZ4MEMzNjNrTGJB?=
 =?utf-8?B?Q3pYck9oMEMrTFdLNWJDVGVkQ1dLU2ltUjF3UE9pNWJFc1ZycS9qSUZCbkc2?=
 =?utf-8?B?cWJMK0xoZlArMmtiMHNRV2t1ZExyTS9MODdEUXFPYmxPL2szRHBZVFFBZGJq?=
 =?utf-8?B?R0pKclRlVmF3M0g0b1M5SnREaUFPM0RzKzNaSDVndEJJUlFKZXdwWmU3dFdP?=
 =?utf-8?B?V0JHUzZnNFFJTHh5d0dlOVgxZU5OWmZtSUNqc05YVDQ0M2dZTmFwVWdoa3k2?=
 =?utf-8?B?SWw3S3puMHVxTkxscGtZYUoyRCthblRNMjczUTFqa2VGLzM3ZVYrcjNQaVVH?=
 =?utf-8?B?QStPUUxmM0pYYXpVc2w5N25jN2RsNDFuSkhWcFBtWlRXTlFtaXZpc1hMNVZM?=
 =?utf-8?B?S21PTE9TeEsrTE9uMHdOUE5ycitORy9CM2x4Rm9CSWVaN2VzcWZwVENQMmla?=
 =?utf-8?B?Sm1kaGNnMFI1bVFlbVo1Y28yQ2dhaHU4aTRKdVhBbXNrSkE0SWtKUWtCRVVh?=
 =?utf-8?B?WmdaWExvMGNxVFMwVkRzY1dlR0tGT2VoYmIyRVRXK211bjM0eC9TeDA1Qk1P?=
 =?utf-8?B?MTFaTjZyemhPalZhWHBYV2JKUXRHMmtDRmVja1hWNVN5N2FEVWFJNG5uTHVp?=
 =?utf-8?B?RXZ1Ky80czZqNy92cTFxK29nbTlRNTVIN0ViSmNMVTNtbXd2N3liYStyY0ow?=
 =?utf-8?B?VHhjNmd2ZC9SZkVrYURCV0RNZU5SRlNVTTdJZkJrZm42Y0tCYnZHR2dkYk1P?=
 =?utf-8?B?MUVSRGJBNEhNUkJNTGppZzRKKzkvNnFWSzl1eU04YVY1R2RjWFlHQk41M3B3?=
 =?utf-8?B?RWtqdnNDSmlxTDMrVlFuNmlkbHVxVUlXek5ieGw0cjQraXpucHNpODhVMnls?=
 =?utf-8?B?V3J3MzZiWmVnYStIdlpJMHdEV3BNLzVVUmZ3bnB3MEJHME9wVE54MXd4ejI0?=
 =?utf-8?B?TW5mYW9PR09NdGNEWFJGOWRxell0UndiNWtMSTc2em9KWERDRExvZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 084064c1-4350-412f-90d1-08de7b612f3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:17:26.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BziYuVZ8vKSWPnEd5rmM8NAgBiSidBDVL23dWQjn1k/7WD8iMYE+2ppCbOm4JM6TFYzTJAsWzvVvWhIjICZQBZ/quaqD7mROTSjYH1OLl3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com

On 3/5/2026 3:13 PM, Jeff King wrote:
> The past few commits fixed some cases where we leak memory allocated by
> mmap(). Building with SANITIZE=leak doesn't detect these because it
> covers only heap buffers allocated by malloc().
> 
> But if we build with NO_MMAP, our compat mmap() implementation will
> allocate a heap buffer and pread() into it. And thus Lsan will detect
> these leaks for free.
> 
> Using NO_MMAP is less performant, of course, since we have to use extra
> memory and read in the whole file, rather than faulting in pages from
> disk. But LSan builds are already slow, and this doesn't make them
> measurably worse. Getting extra coverage for our leak-checking is worth
> it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index f3264d0a37..4cf1afd395 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1600,6 +1600,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
>  ifneq ($(filter leak,$(SANITIZERS)),)
>  BASIC_CFLAGS += -O0
> +NO_MMAP = CatchMapLeaks
>  SANITIZE_LEAK = YesCompiledWithIt
>  endif
>  ifneq ($(filter address,$(SANITIZERS)),)

Should this patch also affect the meson.build?

There is the following in meson.build:

if host_machine.system() == 'windows'
  libgit_c_args += '-DUSE_WIN32_MMAP'
else
  checkfuncs += {
    # provided by compat/mingw.c.
    'unsetenv' : ['unsetenv.c'],
    # provided by compat/mingw.c.
    'getpagesize' : [],
  }

  if get_option('b_sanitize').contains('address')
    libgit_c_args += '-DNO_MMAP'
    libgit_sources += 'compat/mmap.c'
  else
    checkfuncs += { 'mmap': ['mmap.c'] }
  endif
endif

This probably needs to also check if it contains leak, no?

Also I think this might be somewhat less flexible than Make since you
can't forcibly enable mmap even with sanitizers enabled. I suppose thats
not a big deal since enabling sanitizers already has a high cost.

Thanks,
Jake
