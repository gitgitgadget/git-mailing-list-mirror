Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6727E7DD
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288732; cv=fail; b=R8cILM0p33rwhgf41EY+M4oGWKDr3SVdKBNkowf7oLgb6mkrnG9Eaai2KTMLeeEBEnlJ3SQnbfT3YwD7PRlu68MjxgVaQNXIAnB5hEWnuw9VLIxwo22R28l1qWZ1hwhuMckUqbDI9lloeY0uwvZXYtPWzU1TrWO6aM+29vD8gL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288732; c=relaxed/simple;
	bh=KJA9lIXKoAWJcJL1Qae6SbzKzd5nbDUFRTe/XVNDD2s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZgvujgXVv8v1cIT0XZTVJO2Pq+dR0lweHydVPSGe5Lk3mY9MS3iFwCroD/uthuNrjWGpz8TlomSqCr84Fq1Qh5JojEjmB9shUIZv426m4aie8JeST6Ne4N0gftkO36mpMbHueSL5OAyW5Hu0QMyEZnmmogHP4FAUqigTJnJuw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv36Dm8M; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv36Dm8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288730; x=1781824730;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KJA9lIXKoAWJcJL1Qae6SbzKzd5nbDUFRTe/XVNDD2s=;
  b=Lv36Dm8MXnfewRt4Vx+JTZqrKEFKETvLTehPCqpJJh/1BmSv8NfDWUjd
   7M49I2s2u0qCcK7DONRmALbfBqNrbvNH2CfKmG5l2qV4I9ps/R4B94sBd
   GoOdFgUdWZTf6gXEc/5Tz4WdKJkBRp/Me7UxWh0E40AhqZhPrhV9wP5Cs
   3kT9BfjDPQXkQH+MLTSEcAohq4pABLJVRlaO+V6UNJONiToMrk9gmifn6
   9csi2p/jlY/mZsDvdrzxyrbRzVcjKI6AH8pNoCIQFJUXvn//o4Kie2zE/
   IEz4e6pitmCTkoopyDsFjr+LpH3xf/gjHff16DeJHAtkafoZjahO9EDVF
   g==;
X-CSE-ConnectionGUID: Ehkja/agQw6S4AhDTX0QyQ==
X-CSE-MsgGUID: /jFR8e1dTsWuarL12iI85w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63572369"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="63572369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:18:50 -0700
X-CSE-ConnectionGUID: 06pFZHSlRcWXxi/oTtVHJw==
X-CSE-MsgGUID: v2i5ju2xQlmV3kW33cZSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="150971323"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:18:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:18:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 16:18:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/yqbM+OBMQwRWRawtnnBXrnRkdIGKwuVx/ZvLmSksYAN0kHMSBNFJX/N/Vy0X1z4dEGZIbZR9zMXnqpplPfW35CBCKpWdkMGjeTvIIhIRY5Ew1l2ynG2jLyhuQnlPh838ommaQx8LxVi3aTQ8ZMu7F5GNOI1sgyxSJopdUhfo+4zBQRtt7abIUM83zlESdYxCXzUlUzgVDRiF/LJeLUs3l6NVQwv+Evon0oLS3mrDYTQ0Vb1d5KoRLhh4pbWA97gKcIzhu0zLLstCYMTp4xN/jVVTBRSpG7AduJDiCCbkq/DhpbACZDma0jwYbIzNyeRxupqZfw2rYFY74i3+j4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o6CbFM3AURFl6jM6My89W+MA+T4Ddw4E91YuU5yjHk=;
 b=bARc9NpLm2NwomxYgA9UcSp9loZg6CJsdn/KsTr2Mbu9OAjtfVIlbdmjxKvBGMuIH2AAbhMSP7gA5aRLOlKh9f0DMXrtVAaZKhRMa9Cki76oCwUqGL0PyZMUjr98S2+z4UeZn/O7empMP/I1SeMYaikq+YcaUYdHJVvqxenmrlaFxIJ2sPjL2CSjjh3ekJdlm7VLGCxqHb0cCHzfJqeDtKBbom6E7M63xsbFPBv3Nt92G6v4xRPuK52V+uYbrB2OcQBNlGlcMRBlbQ+Z48ooSII76S6fppnwkqqEiSHjDfxAbDkeTs2FwR+AiWXMr+rtsTYn+E66/JVXusAuBnbiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Wed, 18 Jun
 2025 23:18:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 23:18:45 +0000
Message-ID: <905a668a-af3f-4b25-b35b-ba1f7e750b26@intel.com>
Date: Wed, 18 Jun 2025 16:18:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
To: Phil Hord <phil.hord@gmail.com>, <git@vger.kernel.org>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <20250618211024.2332525-2-phil.hord@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250618211024.2332525-2-phil.hord@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b110bcd-7ff7-4f0e-aefa-08ddaebe7823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3BYa2JpSnRtM1V5VzBOaytwVWZyL3p6dmNmdFdrSkpzbmp3YUoxcDFwQjR4?=
 =?utf-8?B?QzVydzNIeW1zNzZGME5UdWFFWnc5TWhWTk1tNWFHSnM1emhDd2dVejRjcjNt?=
 =?utf-8?B?U1lhWkF2dGd2d0diZnl0djVFUVBnWElydTVpMU9SVngrV1pFNlYveGp1cjlh?=
 =?utf-8?B?RCtUQnIzRmlyL3pHUWhad1VLVnRzZktqdnNpcmptak9IZHBJbkVYdmlvTVJ5?=
 =?utf-8?B?VFlvRHN1eDNwKytUdGZUYjFGampGUmw2RUlqTURhUmFVU2xFZWNzd3B5dkRF?=
 =?utf-8?B?cGpwRkh3YTlDdEd5ZVpKQlIzTTVJMThXbzhVMGorM1RTTkd3cFFpaEdUNkdL?=
 =?utf-8?B?YVpBWXpEcWhCVkhVWkg2VW5UQ3JlS21uTnVEWEwrdmVHMG5XNXRBdTh0dTFC?=
 =?utf-8?B?Z0V4ay94WkNtTFMzd0VrWUREMkErSXhadUgvR0NUOVhsekphckpZY013c2tP?=
 =?utf-8?B?TlMrcXQwekdGZ05BL0FCeE1rR29oZGYzNFNWTHZXVXY0azZaazJsR1grM0lj?=
 =?utf-8?B?TVdXdVgxejRURi9hWHI3cFVoVTgrRkNoZUU0RW1zOUIrM1dnSExGR0U5bWpL?=
 =?utf-8?B?RFlxdVlSLzE3bm85Z0NHQWkzeG1DS3FLd0ViRkNPZGVDclpGS3JHeHVMN0FK?=
 =?utf-8?B?ckVYOUhqeHdhWlRCZnNKMjc4TXFWWHBsQlhuR2xlYS9UQXZxQUNWcDlMNDJ3?=
 =?utf-8?B?cEhaNkVCN0NpdU10QmpmeTlkSG9nYnlBdW9jbHo2WDdJNVkrR216Tm4xek0y?=
 =?utf-8?B?SW9iQ0o0eFVhVXVDUzNqR3BYc3RkSzRqOWZoZ0ZjYk1VYzBKKzJ6dFNCbzR3?=
 =?utf-8?B?MzBPMjVkR05LYUN2ZlBpU0gvYkRJbEJ0anZwY1BLczdnU3FiV2hMUlBQMTJL?=
 =?utf-8?B?NGZRT0VnQzFqVEVld054bDRQYTcwQnZDL2lqSkhUai9pNDlSN1FqcXJwWVRx?=
 =?utf-8?B?czgwcTBnM243M3FlTTZtZ29Ba2J2SHRpL3Z3dDNDY2pWU3ZzQmR1MWxYZGJp?=
 =?utf-8?B?LzJiUW9aY0p5cFNleGh6YThoSlVvU1o5VjVoaWtOdE5tcWo5NGswOCtsbFhk?=
 =?utf-8?B?R0hxVlpsM05UY1ZpKy9CSTBrRjU3Q0E4dElaOVI5bUpISW1VRDZuMkw3aTBq?=
 =?utf-8?B?cXZaSXBvczdJTDdCV1U4OTdGZVVZcTFpY1RXa2FKNmNmK1pWaFd5SXBBOWlH?=
 =?utf-8?B?YVZvWGNSczFYTHZXOXkzK3ZwOGUvTU1HcHBGaFFvWElnd0tMTFBIbzNpRU1T?=
 =?utf-8?B?U1NwRWhlSENPTWxwYUZ5ckEwWkhZc240ZlUyMWRDWXpiQnZ4RGF5NWE4WDhy?=
 =?utf-8?B?WFJZQ1pxenllRUt3OWhGMVB4SmpRTG0zUHdqekYxaGxrblh1MmtmZTFqU1lw?=
 =?utf-8?B?b2c3VG1COVl4Mll6ZXpOUkRZcFhid01FQ0JnQVhoZmdhQ2g5UUtOcWRtanh2?=
 =?utf-8?B?cFRzbVZyZ2txeHIzQVRKQWFVQ3l6dnYzVDJDNkVJK0VwMnVMMGdwbG1SWnBX?=
 =?utf-8?B?SWE0d1Z5SmdYSDJpR2d6WGg4K2RaanczejArK0lWQWVUWUNRL2tHM09ZdCsx?=
 =?utf-8?B?ejdMb0RTUFBLY2lsanlDNkR1ZW1oVzhEaFYwMXpnakFxK0M5allNemxBTE12?=
 =?utf-8?B?NlJIM3htVm8rb25tMFlyQ1pLMldzZldidmVFUHNqQ0VqRzN5TUxoY213MUxn?=
 =?utf-8?B?UW5xSmdSNmtwenlPcWI3SDBjZ000NU12eCtVdExYdWtpaXVhWXRPK0l2WmRs?=
 =?utf-8?B?WTdsYkl0MWlXVUtiSW96cUVoTkFDMWNRcjJtVFZWYnFncTl6NjZqSzZXNkZD?=
 =?utf-8?B?aHorZTlBQnVqQ3JvU1FUVFdPZjd4VnhPTWkxNHdsd3A0eGt5UzF5dDJpb1Nr?=
 =?utf-8?B?ekdHSEJjQzY3SEJacG92WGxTMzAweGZOSCtnekVtOGkrT0ttZGhDNHFBY2NT?=
 =?utf-8?Q?hn+kHazC4kI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhPY2JRbTVZYzBudHF6ZDlraXRweThnSkVNU2Fyc0pEMTZHR3VnL240cHk0?=
 =?utf-8?B?dzBvcGNOdWxRbUs2VHR0Wm40Z21PQzlMNkM5N1M5U1ltYk1QRkQ1Uk5qQTRi?=
 =?utf-8?B?T1RvWXNCeXZUZURwWjZHaEUxbEcvYUl0WitHeFZPcGJQV1VDRnNJeEZlUnRJ?=
 =?utf-8?B?VmdzMmhLd3JPWEhYdU1hRDNjU3NCa1h0b0tuQWZZLzRYUjI4a1lSTmgyRHdh?=
 =?utf-8?B?R3BOM1RVK3Bnb3c1c3hGajF1ci9HbmR1TzNueElSN2h5bmVkL3Q5NDE2dThn?=
 =?utf-8?B?YUJlMEsyRk84cWxoYTZyZEUzU3RKVGVuaFdBdzQ1d1c3VFYxYVNtVnVkajhT?=
 =?utf-8?B?ZjFNVmR5L1dLOHpFRDMzS08ySmFYM0NUNTZjcjlZcUFwQjFIeTZyZnQwaFNB?=
 =?utf-8?B?UXdxdllrM3A0UXFhUkdhaHNrSmMvYTVMOWdOZ1JKa29RNDUyblV0bUdCWCtt?=
 =?utf-8?B?SnpVMzdaaGNlQmZOSVh2by9vM2N2TEJqQVEvbHZzdEdIelBlRzVoMWxsbWpZ?=
 =?utf-8?B?M0lTemV1L0doWDZYRUoramlEcW9INk1wS3VuVkNjQU9nUzZXTTlsU3B1dTI0?=
 =?utf-8?B?bTZNT0ZsUm52cksrZU1ITDUxSUUxZW4waUNQczgzdGs2a3BoS1dUMEVSQWVh?=
 =?utf-8?B?UEFJSC9wTDNFNGdIbEdvWVZJNHpGL3dyU0RHUXcxQms0a241Q3JPMWd3cEZE?=
 =?utf-8?B?TzZ5emg3cTNVajFhQmwweFJ5aHFvUSt0aUVCVjdVN2tpU2RVQXQxV2liaXc1?=
 =?utf-8?B?TnhlOWY3WEVpWllJLy9CTFJHMGZUd1Z0N1BLUzVXY1BKVGM4ZE9Xc1hsY3pG?=
 =?utf-8?B?OEdtS0wybjRjMFJ3Tk0raDBjNzhUY095Z3JxWlJpcjVuQWtpTUQxR2Vvc09E?=
 =?utf-8?B?VC95WktpdWl5RWg2cDRuUTI1TVJwb0ZIQnk3ZE9uWmx1ajlnOW9tRm5lMHFT?=
 =?utf-8?B?Mm1OWmhkSGY4MDdiaFVzN1FrZVY0K28xaGt1TWxRdTdrNjFNY2E5UUtqSUFw?=
 =?utf-8?B?RVcrQTltWE1ORHJGUVQ2V1pDeUJ4VnNPQUtjeFpQNHVxaklmZzNjWVZGb3Fj?=
 =?utf-8?B?MmZSVk1waEdyZWtJVnowQm5icHB5K1NFcnIvY1ZaZldnM3Nnak5iV1gvRlFH?=
 =?utf-8?B?dzhBV0ZuQ3NteHQ3QzFoL2txSnJqY2xvVnQ4amNTRHJQK252MS9iWXVnUitq?=
 =?utf-8?B?QWVybmZ5NGExSmIzeDk1R21PaVAzb3lMaTNkelpTNGM4RFVxb1RZZU1FTVVo?=
 =?utf-8?B?YjhEOXptdStaUCtvQmZydjFTUXROcHlnUmdCTml1amZPc1NNTDRYNFNnaldZ?=
 =?utf-8?B?Qi9pcU5wd3NvUHBzSHlkdzA2NWkyMWRkZGpGN0U5MWdZeG53RU9PQnkrblVN?=
 =?utf-8?B?QW42N0prQjEzSGtGQ3psdkYvekVEZG8zSnkvWVowMWRtd2E1OFM4THlJaE9v?=
 =?utf-8?B?MkJKNGNTM3k4RHBUZ2VmUWZyWjQ1WWVqbHlpbU1vTTc4YUFteTVGczFKdjdC?=
 =?utf-8?B?ak84aW5SdUI4U2k0UlZiQ1pnakpTUU54SXhIREkrVWxadCtDRnp2K2RXcmFy?=
 =?utf-8?B?U2I3elYrb2lOVTJINFFrQXVBays3cDd6YjdYc3RpWlkwSFVxaGwzM2hyVVUw?=
 =?utf-8?B?OWJkcFRyWEhVR09zbHd2VTNvQW5ySjNsVzlWSkZPbVo1SDE5d2s5YVBmcFM4?=
 =?utf-8?B?WGNBaUE1S1VublJEZS9TeElvc3BXRXlTTGZUTkE1U3MrRzdwRmk0QXR6TThp?=
 =?utf-8?B?YjFzQXdxV2M5OWZ3Nk5RWGFxMEJON01uN3JDMEVGOXhuTEUyYzdiVlpUYi9C?=
 =?utf-8?B?V090RnZYOVE0RytQR0FPWjk5a2JueWladjJVLzNjSzF5Y1hvTmZOS29wZ2tV?=
 =?utf-8?B?WFRKVE9EMXUwY2ZRUC9RYnQ4bjFPRFlyNHQwY3dkREg4Y1ZSN0pVZTBkU2pv?=
 =?utf-8?B?MUNkYkFJcis4T0RwSlJNeDI3SkpBbVdUdVJwbU5XSk54SC9XbHZKa0NnRFg1?=
 =?utf-8?B?SUlDN1pPOUNTUTF0cW5kOEtuSFlqTDF6bUc2c2xYYndnMi8yQ0JMSXVYWTRr?=
 =?utf-8?B?V0FUekdUQjNJUm9sWUZIeTQ3WnR6TEJGcFZCbVoxRFZydTB2TG1TRmVQZEov?=
 =?utf-8?B?L1dQV29LRDlHdjV6UHBjN0x0cjFQV0RNR1ZtdlNxZitYYUt4QU8xVitmYWFs?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b110bcd-7ff7-4f0e-aefa-08ddaebe7823
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 23:18:45.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53kz10POg6m6zaUpQsAQDb2GJ8z38U67VQ8oKIJSzeCpsz9aW0Gm6mTYN1aGz9F5Hw68HiNDxjoU3Y6lWKq3z/cZzaJQ6v8fWQk8t87I14E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com



On 6/18/2025 2:08 PM, Phil Hord wrote:
> From: Phil Hord <phil.hord@gmail.com>
> 
> When pruning during `git fetch` we check each pruned ref against the
> ref_store one at a time to decide whether to report it as dangling.
> This causes every local ref to be scanned for each ref being pruned.
> 
> If there are N refs in the repo and M refs being pruned, this code is
> O(M*N). However, `git remote prune` uses a very similar function that
> is only O(N*log(M)).
> 
> Remove the wasteful ref scanning for each pruned ref and use the faster
> version already available in refs_warn_dangling_symrefs.
> 
> In a repo with 126,000 refs, where I was pruning 28,000 refs, this
> code made about 3.6 billion calls to strcmp and consumed 410 seconds
> of CPU. (Invariably in that time, my remote would timeout and the
> fetch would fail anyway.)
> 
> After this change, the same operation completes in under 4 seconds.
> 

The cover letter said "under a second". Is this a different example?

> I considered further optimizing this function to be O(N), but this
> requires ref_store iterators to be sorted, too. I found some suggestions
> that this is always the case, but I'm not certain it is.
> 
> The current speedup is enough for our needs at the moment.
> 

Yep. Logarithmic scaling grows slow enough that this is probably
reasonable unless someone wants to put the remaining effort in.

> This change causes a reordering of the output for any reported dangling
> refs. Previously they would be reported inline with the "fetch: prune"
> messages.  Now they will be reported after all the original prune
> messages are complete.
> 

I think this is reasonable especially for the speedup.

> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  builtin/fetch.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 40a0e8d24434..11ce51da780a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1383,10 +1383,14 @@ static int prune_refs(struct display_state *display_state,
>  	int result = 0;
>  	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
>  	struct strbuf err = STRBUF_INIT;
> +	struct string_list refnames = STRING_LIST_INIT_NODUP;
>  	const char *dangling_msg = dry_run
>  		? _("   (%s will become dangling)")
>  		: _("   (%s has become dangling)");
>  
> +	for (ref = stale_refs; ref; ref = ref->next)
> +		string_list_append(&refnames, ref->name);
> +
>  	if (!dry_run) {
>  		if (transaction) {
>  			for (ref = stale_refs; ref; ref = ref->next) {
> @@ -1396,15 +1400,9 @@ static int prune_refs(struct display_state *display_state,
>  					goto cleanup;
>  			}
>  		} else {
> -			struct string_list refnames = STRING_LIST_INIT_NODUP;
> -
> -			for (ref = stale_refs; ref; ref = ref->next)
> -				string_list_append(&refnames, ref->name);
> -
>  			result = refs_delete_refs(get_main_ref_store(the_repository),
>  						  "fetch: prune", &refnames,
>  						  0);
> -			string_list_clear(&refnames, 0);
>  		}
>  	}
>  
> @@ -1416,12 +1414,14 @@ static int prune_refs(struct display_state *display_state,
>  					   _("(none)"), ref->name,
>  					   &ref->new_oid, &ref->old_oid,
>  					   summary_width);
> -			refs_warn_dangling_symref(get_main_ref_store(the_repository),
> -						  stderr, dangling_msg, ref->name);
>  		}
> +		string_list_sort(&refnames);
> +		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
> +					   stderr, dangling_msg, &refnames);
>  	}
>  
>  cleanup:
> +	string_list_clear(&refnames, 0);
>  	strbuf_release(&err);
>  	free_refs(stale_refs);
>  	return result;

