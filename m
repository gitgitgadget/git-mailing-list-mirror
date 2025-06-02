Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5419F48D
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900554; cv=fail; b=mSt36HKlVNIwU5Q793bXxY7Sz9sE8sMxzddUMsUlG7UHREhYAwmDXjkyQUksdi4M1b/iXV/yhKrVaCHDoTua6kXhORfgDFpIylo+XGBljBaH0I3Tp1jFYYc/W1x+VUO8NMjDG4BjS8J29v+JtftciXTgHHGnYz+hYscWkc/bqNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900554; c=relaxed/simple;
	bh=TBq4d9/9HzWcHZMCuLMdfhD8fz2OwPVDFiVXiIiRQvM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aWqXNxsZZs5upHXVGFxpFLBo3T0ZL9L5/toCs1ZeGb4STE3La8fMxlncU2ZZLEMcenRkUwItFD+73CBQiIiBT2khAw8RvsbRnpDG82CtATKfkNgi/KaWYk2HNY3zp6Mqsj2XwDiYj8ttYvKl8E1wtY4sst2Y4ayKofgAPNIlHgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlQEk8TX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlQEk8TX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748900552; x=1780436552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBq4d9/9HzWcHZMCuLMdfhD8fz2OwPVDFiVXiIiRQvM=;
  b=PlQEk8TXJSpsiOENY6yh388h1hbAfjTHKmND9n43y0Zig8yhrIx7sWn3
   9mQf28ZI9lP11/VVQpgRzIlMVX++VQ63p5kC2VKMG/Y8soAm8tYn9WZaI
   rtOiao/RmGfwDYHRm5pOJwYRz6FktkOofGR/Q+SmQvGIKH2TXffHi1Pn2
   TYBzZUs6vT2d+pmcIVn8Nlngg8s1xfHjjBn1rboZOucjJRvExSwrNnVFW
   piWnfCYMvA2zCX+l13GVRGv8XvcijTIVVfeldMauBDVGPE/nb6TeqUEEu
   p4Vu+mDf5V+EXO1ZylKH9gV/ZO7xTiRnN7yQ6mEiYFg/jI312UNk94GCY
   A==;
X-CSE-ConnectionGUID: TWbcs6UtS7WWd2t/j9FmWA==
X-CSE-MsgGUID: jzgRLaeCQc2Cx5ItGWp80A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68352162"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="68352162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 14:42:32 -0700
X-CSE-ConnectionGUID: zJ7iG1cPS/OMZ+RSEKCQfw==
X-CSE-MsgGUID: axa+wJyTR1yH3qJIH5p2IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="144684238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 14:42:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 14:42:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 14:42:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 14:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqg9G5ljGinVE8F5ZarG9DRRY0SGAmMT1rxH4fVyyOnuTRGbstpDGAaZjozjvgK3b4YOazRKHQzXZxtKGIqrSEeefQ+FgK192wSJFfgNkd1lwzcW9dnOfVzSC36M7g8Y1btJ6B3SsMx3rMMmqF1UBtgLvsQy83MuO/ZJS2gFY6c5gGIH5Ao4X7NG7StC12d514BuKanI9kiRAd6a0ndXfjlSRNCJ3x7XHM2W7ciezSvU+hVWC7G69sez9m3Wef1WRbDekM2ZyJK2ZjfdGY+UuXHoWvT3r9Tm+m3BI20fkbBmIoDRXg+MBK7hga2zLDZ3wbGOBUFAtDM1/57zcK/X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFi6H4YYoOyjL8Ktej0CzmTNgjgJxGgXsCttfAxCU6M=;
 b=G2uqjk5U8q2SWf9VkoTSAjw4+gccT0EW4sG0zUd9WudpquyHiC98j9oLxn0wGPdsujhlKtuqWRYEQM6aelLzY1TTJjKwS2BaDq1p/BkgiCdTjQinkNZdKTqD5oFClXINW3cRSHb3qEHf0aoZB0hgIpwvbaSIXvOtc6iYedgPi9F1xNDLMa4jz2OCQ/duh++IZNQeFJiMRFImPwomZ9icA5DUj+GgVdJ4ljnMrIbFM1fEeEnCMSYS119SX6yUNXWtB9+8OU/FdtCEluFHFfMJyglbP9fW1q2Qd/qQ9AlK5emXcq97yI6WAPVGda2gzdMo+QyWKOaheL4KicQxqJQRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Mon, 2 Jun 2025 21:42:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%7]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 21:42:28 +0000
Message-ID: <e6a4b604-c5b7-450a-b4f5-3863441e0c6e@intel.com>
Date: Mon, 2 Jun 2025 14:42:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] completion: Make sed command that generates
 config-list.h portable.
To: Collin Funk <collin.funk1@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
	<jn.avila@free.fr>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
 <1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
 <3631972.iIbC2pHGDl@cayenne> <875xhducs7.fsf@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <875xhducs7.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1db90f-93fa-41bc-0f65-08dda21e5f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVJZ0I0RDlHWGd4ajMvQ3VRbkZ3a1ZMYTI5dnJSMGVGTlJyRnphb1pJYTd2?=
 =?utf-8?B?VzNONDlyVSs3Y2RIbUNOd1RXWXBpWUNRZUpJMTN0MG9lUTRhaVUyN2hzUG1m?=
 =?utf-8?B?V29udG5KbXRqN0JPT0pJRHpTeXJReFBvSUlFclprbFlBZjNpQjMzMFlQcENj?=
 =?utf-8?B?dnBxM2N0YXNUbFZOTllBUWh1cVV6d1huR3d5eS8vTGd1NTdHV3pPTVVkbG03?=
 =?utf-8?B?bEN6RlZpS0lSeVBrZTBSS1NWZTVQa1IycFE4WU9FL1FtSWs0aXNIelR0Z1l5?=
 =?utf-8?B?U1FKK1RwcUM1Tjh1c2N0aHhtQ3QzZUNyL2JsVHdLRHZ1SEpPbDFnNEVSR3FW?=
 =?utf-8?B?dHZybmdyL20yUWhidWlsU1JFdENMcTh5WEVYVHZzYnBzUW5YeFEvbTd3U09Y?=
 =?utf-8?B?NEtSa1Z0ZFlYdkxXUFg4STd3N1JUOEtTWk5GMXoxdDJZU1ZoRnpSNHM3M09R?=
 =?utf-8?B?SU96bU9kMnJXL29POFR6bmp0L2dxdm4wY0lDc2pCcUlLeHdJZEhZeDRxRWxm?=
 =?utf-8?B?UEQ4WW80R1RqTnJidEVaWXY5bUlKTXUrYVVMZ2RWd2dNTTFzU3JBZ0RwWmV3?=
 =?utf-8?B?ZGh1SkpKUGtpS3V2akVsNXZaUXcxVDFRMWVBUWZ3YUJCMnE4S1VPRG8xNTY3?=
 =?utf-8?B?NElJVnowdmN3SFNFeEpqd1Jab3dFTVdIdnRGQkQ1MlZpQTBhUDJLQ0kvc3Rj?=
 =?utf-8?B?M21LcHV0NG9RK1d2MXlRT1RjOExGb3ZwUTN0MlpPUkZtdys0ZTl2elB1MWpE?=
 =?utf-8?B?cmh3VWZmT3JFMGxYNW9EZmJUbTNHSkFXNVNhd0JPMkdRQjFwUHV3OE5CRWs5?=
 =?utf-8?B?Y3NZaFNVWk45dTZSdFZiYVFnWHhTL3B3WXNZVVhRUlh4VG5lUmZSUVVweXRj?=
 =?utf-8?B?bVR0QVBsd2luQkErc2V5Zjc5amVSMCsrczFDTFBIUU13dFdweTlmRTRUdHE0?=
 =?utf-8?B?U3NkekdTV3ViUnY3ek5nbExqdWIvSW5IZGhjb0thQ2dWS3NBSzF6YUxNakJz?=
 =?utf-8?B?T3FxV2ZaSXNhOGJQVUwvV3JBNzJTL1FzV2Zua3BMUkNtYzZxcjdHaEU5MjhL?=
 =?utf-8?B?NnJGZkJmQkZhNHJ3MHpVSXgybTY5QXAzYXF5eDdBN1dlTllhZDFuUUpSbG1r?=
 =?utf-8?B?NnYrWW9vb2p4bVJ0RWdaLzJjTHZ4RHEvaGdha2ZlUXg1V3M2WXJJUkxjYjNi?=
 =?utf-8?B?NTI1OUN5dWZCb2VNNmlNTmJxUEdGQ3p3eDFsWUhvZy9oaEZGd2JUOC9XcWZ5?=
 =?utf-8?B?NXlVeC8xSzEwSU90QWlYTlg2MVZhdVhZSVk2NVlDcDZNbThoQytoRFF6bkpM?=
 =?utf-8?B?eStRYlJ3MmVaNGZoN1JiUVRQdGZEUVk5cHRFKzNXdTg0Wnl3NCtoSjZETnR2?=
 =?utf-8?B?c1p1RXc0UVpvcEFldnYyc0ZrU2dnSlpXTTBzaldGN3AweFRJZVJ4Rlo0d3Bw?=
 =?utf-8?B?UHRvUUZWMC9jWEpkSGMwK3JTd3R0UlNnL3dBNDl6VzZqUzVWNE9WZHBGK2dy?=
 =?utf-8?B?ZlJ4M2hXNCtYRnVwOWM0bGZ0RVBHM0lpVVB5RDYrcHlCQTU0RzdnRDk4U3pN?=
 =?utf-8?B?V2FnRmxvSnZuSVlPV2FSa1FaQVE0TVhDWGtxYk9wUjFkZ0ZUQkhqYmhBRlVZ?=
 =?utf-8?B?YUdxL3V4YUswNVY4RlpGL0l0L2FjalRPWWRZbmxCdWlHMmJKQjNSV0pwbXM2?=
 =?utf-8?B?SXRtSGxyUGNlMU9nVmFQRG9JNk9ZNk9DUEtYTnk0ZCtwZ2Zrb0RDZ2JpZTlm?=
 =?utf-8?B?TlZzblpuKytFWEQ1eVovMmlZY3Q4SUx1ZTNDeTBFSmozeFJGN0FnZFNvOW9Q?=
 =?utf-8?B?OXppUzN6bTRMVGg0T0t1Q0hsMHNteHR5UXZOQ3M1dlgzY0NSRGpWNlRLNENp?=
 =?utf-8?B?UHNCU3dOZ1k4ZkRjc2NwZE9YTDdyWC9hWjJ6VVdyZURDVWoxUVVvUHRhYmFW?=
 =?utf-8?B?c1I5bkJkYmZ6N2V5YktsWFlDcVRYZzBYKzA4bk9ZL2ZBVVNYVnFEQkkxa2V3?=
 =?utf-8?B?ditsNXEwa0FVb3EvdWhWM2E5NkpBbTFNYVVodmFUdU90dVZPbG9CZEJUNTRE?=
 =?utf-8?Q?3Mq+SB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEp2UnVZdnBBYzViZE9MZllGTlNvZE5ubURVdGI0VTBpRU0yS25xNzhJK1d2?=
 =?utf-8?B?OFd5N3FwK0MrR0NoZkRSc2J0N3ppd3FSMjZyN0p1cmd1dVhuRktuU05GZlBn?=
 =?utf-8?B?dWVISEpnVUFoM2tMcENVYjlWVmRXNE9kVnQ5TXNPQlAyMWw1bGZ0a0ZNbDZm?=
 =?utf-8?B?dWJmME4zZ0JkdjhsbGJnbkdtTkNnZS9BaFJPT2U5dUVPbW1rUUJMNERidzQx?=
 =?utf-8?B?V0hVOGU0b3Y0SnoxeGxFa2ZJTU8xRVBCZHJNT21RT25BanRRQkpKVFRjTEJX?=
 =?utf-8?B?MTE4ZFhYWjJ3TldqWWt0MDc5OGg4dkE5OEJWQUYzajZQMzhpc3cyR1NCMVh6?=
 =?utf-8?B?bHlOKzhwUmtYY1BobXRGdlI3b3NkcmNxUkNIYURwcFdic1kwYVlwejV0ZXlR?=
 =?utf-8?B?aUFoWXJFTlg3SUJEd3dhV0Urd0k2VGt5amhXVUJFQkM1QmVCUlE0dms5NTd4?=
 =?utf-8?B?SjN5TmtyU1ExVjVLMzBPbDFDKzZKOUUwcllUVU5LbWNhNG4xTStHNG54U1dn?=
 =?utf-8?B?S2U5ek1HY2pkUHNEM0NCRDVMRXBKNjFTWFRYNWZMViswWWZUNkNoTDZRcmtz?=
 =?utf-8?B?VnBMZ3VmbFBQOEtVSE8valpHR3YrUERCYS9ZdlJ5WmtmUmRaTXp3ZHNxb29G?=
 =?utf-8?B?alRNZFdOUU1yQ2FvaVlmS2N1Y3UwRUJGNGIxNnp2OWNCZE5VeDAyNWNyVXhK?=
 =?utf-8?B?R0duNEdnVHhTeVRmWlRSNVNsWGV6N0FNYVExak9SRUVIZkx1bFdnSmp2M2Jz?=
 =?utf-8?B?K2oxSmthaTlUTVVlQkZuZnFWZFVQc3RreXZQbytKZzBzL1UvWWF1WHV4RS9t?=
 =?utf-8?B?elNUMURwcysxUXZFeUNXYUkyMkdRVkExdEh2cDFzNVQ3aVdLWUNIVy9LY2R2?=
 =?utf-8?B?SStWRHdpR3JpdGtpR2drL29iRk1KanZxTExvMW1MUjcydVRaOWlnb1lTNXhn?=
 =?utf-8?B?WHJGTjN3b2Q2QzN6S25NZkdZdDNVWE9Ja0xaMlo2THRYdTgzR3VqZlg0SU90?=
 =?utf-8?B?aWtUeHc4R0lDWFlzY2N0OTRHNTFhVWVuNDdOMWFadG1vQmtvdjVGYUo0d05y?=
 =?utf-8?B?a1lqV1dmeWg2TDljV3BBSkx6dk1BZ3kzcEswckluU1pLZHA2RVZCVU4vb2Nz?=
 =?utf-8?B?ckZkZE9NckVVUFFXTXdjYUx1M2d5TlBMR2s5b1JLYk9UNEY0aVk1dzdMK2hy?=
 =?utf-8?B?NkxGVzZqdTBTc2FSR052ZjdiUkZTaGkzNUtlMnUyaTdkcWU1Rk92bmptTzJp?=
 =?utf-8?B?eWlpWUhaZlV6d3p1R215Q0UxQkJvTCtsMGkrZUtTWk4zaGRpMVloY1doQ0Zn?=
 =?utf-8?B?UllCVmIvdDAwMm54NjZ4cUNJWERQWk5zbXYvanN0MVRiK0U3cU9kYjgrd0dE?=
 =?utf-8?B?YndBNVVyMjB0dTF2UjFOQnd2NjZiUmVpeUpDbmF4VW1ja3BDa0RxQjl1ckFw?=
 =?utf-8?B?ZXVSVUhOTkhJOEljWUdNbmsyRnlKY244WjRVSjJ6MDhmKzBxT3p2NkdhUkR2?=
 =?utf-8?B?NlFzazFZVWdwMXNwa2RvR1dDRkxEc0JYUTdVVkVJbk9FTjFmZ3NqdE9NMnhC?=
 =?utf-8?B?WUptVTNZYlBndUZLYTR1Vis2QnBQQW9rWG9xWkRSbG5MSmVRS2FlV0VDclpH?=
 =?utf-8?B?WVNmOU1WVFo3ZlhqQVdNK0t6blo4S1NNVEU0bVVJdnhsd2hvVld0aUVlRy9V?=
 =?utf-8?B?L3VVSXdvVFYwUVdPd2tKdUs4bjRlTVdkYndTRjRjb0hCTjNLbm82NDVMTDFK?=
 =?utf-8?B?U3BnT3d1M0VmZlJGQXBreXo0dFJuSWZJL0tjVlQ5NjdWTHVseGJESHcyalNr?=
 =?utf-8?B?RGZHazlVYVQwMDFUbUQxVlNDTGc2YkhweVYweWFWcE9MVzNadE9NNk9vT0Ru?=
 =?utf-8?B?WWRUNzdMaFpXUlF1MjJkTHVvdFN6QUU5UXlFYVNGV1c1akllVlk5M3R2dnlO?=
 =?utf-8?B?NW53ZlVkV2tlM0YxMjk3S0hiVTJ1Y1RqWTdnU2RQRmtrajBCa2J2Snpja0d1?=
 =?utf-8?B?bDRoSGJYMmEyeTVKd1daTDc2aXBRdFJiUTEvRlFFOSsrYWhVWnFyVXNkNWFS?=
 =?utf-8?B?cXpmZWdtN3V1S1ZEYVJwenJqZHNWOWlJcjZJcml1U1ViRUhHSk5hRXF2bHlH?=
 =?utf-8?B?a2ZyK1A5Rk11OHE5blU5YlR2S09LTThCNGZTTTJEa1N4b3N2S3dDRm92OExl?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1db90f-93fa-41bc-0f65-08dda21e5f33
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 21:42:28.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKumNGe1nIVvEesfHv0n4gqip5imXJgs3uyvP/pcPjxJ+Xi6Hc6m5yUJihlMfGfUSHD31MK0c4E9aOjH4pTt+ecpXA6rGdnC1/vffGSBzGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com



On 6/2/2025 1:08 PM, Collin Funk wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> 
>> Your commit message has some issues:
>>
>>  * upper case in "Make": prefixed commits message must be lower case
>>  * to be correct, the bug was already there at the first introduction of the 
>> generate-configlist.sh script (3ac68a9). The '\n' was there, and the generated 
>> .h file had two wrong strings such as
>> "gitcvs.dbUserngitcvs.dbPass" . My patch only put it in light by breaking the 
>> build.
> 
> Thanks, I will keep that in mind for V3.
> 
>> Maybe an alternative way of fixing the issue is to just rework the 
>> documentation on the two spots where a comma is used and put each config 
>> variable on its own line.
>>
>> What do you think?
> 
> Regarding readability, it is not any worse than it was originally. But
> maybe that is because you are much better at sed than me. :)
> 
> But we could put configurations on seperate lines like so:
> 
> diff --git a/Documentation/config/gitcvs.adoc b/Documentation/config/gitcvs.adoc
> index 02da427fd9..31d7be3992 100644
> --- a/Documentation/config/gitcvs.adoc
> +++ b/Documentation/config/gitcvs.adoc
> @@ -47,7 +47,8 @@ gitcvs.dbDriver::
>         May not contain double colons (`:`). Default: 'SQLite'.
>         See linkgit:git-cvsserver[1].
>  
> -gitcvs.dbUser, gitcvs.dbPass::
> +gitcvs.dbUser::
> +gitcvs.dbPass::
>         Database user and password. Only useful if setting `gitcvs.dbDriver`,
>         since SQLite has no concept of database users and/or passwords.
>         'gitcvs.dbUser' supports variable substitution (see
> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 67393282fa..9da5c298cc 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -289,7 +289,8 @@ for most push problems, but can increase memory consumption
>  significantly since the entire buffer is allocated even for small
>  pushes.
>  
> -http.lowSpeedLimit, http.lowSpeedTime::
> +http.lowSpeedLimit::
> +http.lowSpeedTime::
>         If the HTTP transfer speed, in bytes per second, is less than
>         'http.lowSpeedLimit' for longer than 'http.lowSpeedTime' seconds,
>         the transfer is aborted.
> 
> This is similar to how options are documented, for example:
> 
>     $ head Documentation/pretty-options.adoc 
>     --pretty[=<format>]::
>     --format=<format>::
>     
>     	Pretty-print the contents of the commit logs in a given format,
>     	where '<format>' can be one of 'oneline', 'short', 'medium',
>     	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
>     	and 'tformat:<string>'.  When '<format>' is none of the above,
>     	and has '%placeholder' in it, it acts as if
>     	'--pretty=tformat:<format>' were given.
> 
> Then go back to the simpler sed expression before your most recent
> commit. I will wait for others thoughts before posting v3.
> 

I like this approach.

> Thanks,
> Collin
> 

