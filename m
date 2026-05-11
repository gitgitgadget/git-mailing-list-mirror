Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E7361666
	for <git@vger.kernel.org>; Mon, 11 May 2026 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543923; cv=fail; b=L7FhOyoNZZTukv46Y++QPLiH2mGEX4Mc5mQigEdLglM+bm9AM+KcW37lIq9QFaDyZyWsNrKnpDLyqSPbAmzOsi0+sAcMeD+mkUCMxAez7m3n5rCmqQBR8kU5MGJUkcFXOg6MOrpnR+ALPhKz1SR3un1J/TLpQRdgl7Jj5RwmoVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543923; c=relaxed/simple;
	bh=zCZT8ht+PtBJMyrqbrHD29mi/rKlnBUjwBac9xMgEKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VydPcRgrC7we1NwZf7YiPXDynXSZ86ZxhdSfibrMDeJIZEjj20iW5w4EPrkgmOIYh9vK2Hngk55g1p95XAgIP/FOwhYzd/yMTBH5jC2dcCEVpNmesn4+4I0D1yuzd1/N8TYX44T2Oc3IO+oMdjQQ6RJbd0VwVTInngcuAL4Q7fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbCHQsxr; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbCHQsxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778543921; x=1810079921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCZT8ht+PtBJMyrqbrHD29mi/rKlnBUjwBac9xMgEKQ=;
  b=CbCHQsxrP8jCWTc7myXSPQqFMMS+lF0c31V0Ip7VNwfWlEigkeGjR8/7
   ubn+mCtl7mHPC43ali5qVEkwiCWpEQ5/nFIahZQDxwKpSc1yBC2JugHfi
   8+5/h257iv58uW/beV81u4cRcZqNGhwJoFKAUenxZDpuPl/Iyjmj7eL+/
   OxDWWiI5+zuO16ysRS88mERkCoZ1Fm5UQrEHZl10joT0k7JjoTwGbuXjc
   Xv5DDWnmZMNVRPbvLrsI4Kh/WvGNJexX90CH19sCDPI4ayGs6VmSwhjFc
   xZ4S+Iz30/j0jlRyzv0cQwj56aiQ5jJq4vkgnDANllZ8Q53ExINbcVc2u
   A==;
X-CSE-ConnectionGUID: Ka5K6tcwTha+CArYfAXnjg==
X-CSE-MsgGUID: UxSVGNENS9GaSPgVFgbxNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79305106"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79305106"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:58:41 -0700
X-CSE-ConnectionGUID: 7vk2NRrwT1qk900zWTKgzA==
X-CSE-MsgGUID: LPaoIb1tQr6v+05rP0Xqzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234934232"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:58:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 16:58:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 16:58:40 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 16:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2szXsRO4xDgjVKxCZM+TDA/EQvJT6QmTvoe/iW9M6GXPkggx1EMgr6bbViqG2c5V4LoKHUF6KW/liLMHDhuSbfP1jcktryEcUYt3gKt+7B1T1tq/gymAQ8lXb1s//e4i2hf4JSgoRmQPmwS3GlTtHfJZt1zxfpF3y7fE9ZTgPxqvWDO/P7++Rsz95xMjz3ol7Ldk6wzk8SQOjlB9yxy/ydcGlWnPKtjHMsHsZ/iD4upRHWx7epuAstJTXb3PLu/UIXDBpXkyZnWDfHmxHgxvZ9JfEQqbK2e3IKGEkDbXjWLLHAMYCyxv1lHLPyv0+gK3uQIVF8oMfxSxsz/RwKKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSh21tGX3tKMFo6F3O7c0x8Oeem7TwCZNhy3dIH1Ehs=;
 b=KuT2vEN46ND3nzojgsZ/qsik9ghlg3E89yni51IBThGzIA/Tbpw40APql6nCZFdvVNTBegQi8rJ99bn10Abd2lKGEj4VT9KKO/W4D9hcEnO0XFkaD/2JQeK8i40pZjN3L1fDNdKLpwi4Vhdp0pkNtiF3Zpf1RmKx9Y5pLxmmXXBJX2OhRrhXf7oQjA9qGkuU0fAJ1D+XcUxBbMEIfOYs+sEVbTy217MU3w3qvJVWKFToZz2P0ZnPeGfvkkTNfz7Cj4quS/QFM7ItrJfDJIuZAwjR0jZc/J05RGJPfokyAK50j6JE3m+SkHYShPAR13tTnVVTDDHNQSAQ2iWtgsvgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 23:58:36 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 23:58:36 +0000
Message-ID: <d769b895-4388-4c5d-bc13-52bc80ca6b01@intel.com>
Date: Mon, 11 May 2026 16:58:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
To: Jeff King <peff@peff.net>
CC: Taylor Blau <me@ttaylorr.com>, jean-christophe manciot
	<actionmystique@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	<git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <20260511200112.GA22912@coredump.intra.peff.net>
 <590781db-7c19-4aa8-8497-e16e5eb5eba1@intel.com>
 <20260511203502.GA25510@coredump.intra.peff.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260511203502.GA25510@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: e60438f6-dd4a-4358-5557-08deafb93741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: PS17S0glpwKiOxicnDygnONJ4a9J5J0kE13lvRjJeBtmWFd0wjSNREAqN2eR24yiaHzPBa6xJEK6TTi8l2e2l6m6U8fW8HlksDgEztngAgPtI2bK1cBjeJlLcXjK6U0ieGBe/SrweBHmV7v72wpW4+Xv0kPdhXQhUCuKqcA4adZu34CZ9SfLk+S7gQDNSysf9Zptevv61e0XVzAmE0kyWEOFxFaW+ibnKXf55Yk1JhGUAluMVT2yr/7LjSN3gQu/5lk5hym6WAskTGDAGGzum9tC2Do9i4SvNxyZRXRaqv+09TOAQ/DhXvpz7iq6rGq+NTbvb/MI7pA1hD1JwmibPBgreT6J59MvLOQJZQFH/++7yJlUnk64clMaTKvDqKMlrvhbFMf9iosUCP98BLLIGPmsZkCmd89TiX9ztSyUCO6AIq+GggSxOFjyMl5nTPFQ7SXbIy0SsrnZkBex9daiv02KhKk/5OfboVxm+XK+HxDtnRYc+Z4eku5DliQQHhsty0KL5nLMIVK5BpBF99cJtuTCGOurg3NEZWSaQ92ScJc9FwAml4TItMGmj8U7r91ndBl4yrv6UgFZbu3EyiKSUbgNN4VWwStpvVovXy44VnEiGWm6Py00Fl43K9enA+EOMT2YaBxSWextrJLyHQWsbPAqKGx/ezAHnffyl5INTZaxD3kZnOaJu+GWd3UwPDvT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNGck81VXJjSW5iZ3krQUZkQUFoczF0SkZvS3drR25uNEVTQnhzdmJnNlZt?=
 =?utf-8?B?cFJUTGFiUkRrOUlDeDg1MkVvUjhab2g0WVRybFR1SzF6VlZjc3gwMFltMjR4?=
 =?utf-8?B?eEtMN1JTemNRUWFyK1pLTzZSeXlWNUpyMWlpMDljcEozb1hBU3FjN2R0aTlH?=
 =?utf-8?B?TVl4R0F0aDlxYitBeFJPSDdLNHlsUXAvZnpuOU1qUFpraUhOLzNsYnlDd0tB?=
 =?utf-8?B?MW8reVFRT3RUUmlkZGU3eE45NkxzOHJjZVVRakhRRW9STFp3RVk1SjhYSXBv?=
 =?utf-8?B?ZUFLZVV6VytZVVZweWNXaE5HWmpDY2dMWk5SSnhhZlduWVVrN1hNeG1FRThk?=
 =?utf-8?B?TUcyeHVvd2s3ZlN5eUcyOHc4YWR2eFdSNHA4M01pamIrMytHQ3lzVlMzZkZw?=
 =?utf-8?B?Y2lJOTh5K3hnaWZpZzhjT29GVEUyWk1aeHE5QW9WTHZWdzNGKzhCNW5xaEpH?=
 =?utf-8?B?WGlybjY3U2Y5L3lMRmw5bjJseE9LQzl2MkNrOXJmSVBHN000YXc5RlBxUnhC?=
 =?utf-8?B?TU9ERlpEOU1LS21qd1RoajFMWThHUTgxOVhwNTg4VFN1SndTZHhtY0gyTXVr?=
 =?utf-8?B?cktQTFFoWjJiT1NJcjJURVNpOGFDNFN6cGpYQmVtL1VwaUxhblhibGxkV052?=
 =?utf-8?B?cnlTQ0dPTjhmZ2o2MHBtMnJNWDg1WkpzeXFxMGJta3JhVEN5Y3NSZmFlSmxh?=
 =?utf-8?B?UW1xSFA3NDhEeUZ5TG1Wd3g4cDZHZHBBL2pCMU4vc2p6MzJRcURLSldEc1lQ?=
 =?utf-8?B?dHU5WTFROTFNMnc0Nk9mSzVmN3VvL0FxOXIyUis1RnB0RUltUC9KMmxXdkhT?=
 =?utf-8?B?V2lTZHdMNmpkclJEcm9LRXZLUHA3OUE1ajJxQTV6WTh2SkxJbnV5Y1ZuWmF5?=
 =?utf-8?B?TTV2aWtHcXVLN2xWSnE0ZDI4MVpkSS9RMUR6NmNGaDdNUHNnVUc1aGprUEha?=
 =?utf-8?B?VVgxSzRqK1VBTVdVam1JRk9ZSkgwUGJyeXR4MENMeTgrWURrRlB6TTdvRDdi?=
 =?utf-8?B?R1RudDRLVGk3K3RWTFM4amVDa1ZGNjFXREJFWitiTHVYTG5iSUdUejdKeldL?=
 =?utf-8?B?WmxVNVB3c1ZibzlCVEZaaGtweUUwRWpIUkJuaXFMOUNaVmRuRFliUUxjOWx5?=
 =?utf-8?B?d3YraTJMcE5mTWQyVjVHMVZETUdFUCtpQnJDV1BvSUNrVmc1SStpaEpsWHhG?=
 =?utf-8?B?dDlGTHFVYk4yeUVpcU52VFppZ0tKYlYrenRkamNCVzQzOGtiSTNYdFdVMnI1?=
 =?utf-8?B?QW1QbUMzNUdMSHFON3FOSGI4amNrUzVOUm9MVzhqeFhZMmF6UU9mNGdoSDdw?=
 =?utf-8?B?M3U0N3phRmo5Wk1haUw5TzZmMzBMTkczbEc4K1RjeG1SWjRJTUdZZGNSR3hT?=
 =?utf-8?B?Sm1jcHdwTUU4dktJcUxpWlNNazk1d3ZXcXhTY0Y0T3FEZHNXWWNrdG5Ldmx5?=
 =?utf-8?B?K3IvV2ppQ3NERFFEV2h0enpRS1JiOHRUd3E5RmR0MDRPTWFTbTNYenVNdk1y?=
 =?utf-8?B?dkVNbWpyNkM2ditQUDQyNDZ1TTl3b1J5SnpLTDlkdy9uenAwdUh1eFZVZG1T?=
 =?utf-8?B?NFpiWWttaFRhcHpWM0NwWWM0dCtTKzJtdHN3bE0rVG5sU1AxUUxqeS9QUDNo?=
 =?utf-8?B?enRNeEY4cDBSNXhQMVBDOXRWSy9EeUhhalBVZkxNSGZqM0hvSHVscDQ3V2Vt?=
 =?utf-8?B?VjdLTThta2JFQ1Brb29qRFoxeEIvRmwxMFduRldqTGg4ZXdKZytoTUhnL0g5?=
 =?utf-8?B?bis5UjN5ajc3dVg3bGdNWVh4ak9xUXJwWWkrNFJRVmxVYUJIaU1ITjNSd0sy?=
 =?utf-8?B?TTlHL2FGRSsyZUpaQmhjK2NmTWFjazdIekRPOC9DcUE3RjJacW04TVZUV1Ni?=
 =?utf-8?B?anJpdFkxd0NqYzExVTRhT2kzRDRpd2F1Y3E2S21qRnpyM1l4dXZiVkhxRTV4?=
 =?utf-8?B?NmNMZGNmeXRwcDBGZHVialhHTEYzMmdBZzR0WUF1VTZVcWVyc2UvcUJIWDEv?=
 =?utf-8?B?ZXJaYlNmS1UxUTJLRUh6RkxWQ2Z2SnNNZ3VRb3kwSnlscEVTcjdNcWhHejdF?=
 =?utf-8?B?Szh1dFBDS2lpNFZNVEdSNmxjdnQzTWYwajVjRWRUVGlaTnNxN2Z4NDJhN1Jy?=
 =?utf-8?B?OUdWTmlGSm9ZUEpGc2tlaDc1M0ViNGVSekZzdGI0aVJIb01VTlJKVGxRcFpR?=
 =?utf-8?B?RzJQYkRadEVlekx3c1NzYmhpRlFlN3FvOFdrVFpuYnN1NzNnbklmajlDdU1i?=
 =?utf-8?B?MHNrU09mLzZmMXltNTZ4bGppOWlYNTI1MWFXTCtrbG1nTElpaHJYeXR1Y3ZI?=
 =?utf-8?B?S244VnNpcHlFdnQ3anZHRzlhNEtDWmY0T1NHRFFUYjRGb0QvNDlNQT09?=
X-Exchange-RoutingPolicyChecked: ixIwuPAqkjHrrbFqElH+LtIKPzyr09xfWQKOn787WwkaU3Pvox4hinRmQacUOVT9IPBW5MGmwuHd8QICVFYISOm/kn+5wwEpW9S8PGjwXyom0LZZ2HEOw2TZyALoPHQWpN/YHSy0uWcDFVCvIEEhrtzhWsMQ19c3B6hXWgvgU5Oy+1LBCP9x52pH7S7Yqtr2APQAwjEaJvl/6iZSZvSUzcrox7plRxn8LJ4yEHJ7zm+vw+TTO6mRE0q59P+tmDStoMXiUtpJRPKpisd02OTTo9ah2F5i2TqQAGJGTszTUYc2U2UlUVQg4vuGMLXsHxqK9J5Rjn7+nJB27xBrhWiulg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e60438f6-dd4a-4358-5557-08deafb93741
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 23:58:36.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77xMECfXQFwZlsRCoc1CnixCWFxzi1cYrZlXfC/OIhvbDp3XA1XVLLPdoQpvUPt5G2oItn4fKZkeWP1yf8aSedW4e0rNdyYLpboc3XdaWUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

On 5/11/2026 1:35 PM, Jeff King wrote:
> On Mon, May 11, 2026 at 01:21:37PM -0700, Jacob Keller wrote:
> 
>>>   - If both claim ownership, it's mostly OK, because they'll both try to
>>>     unlink() which is idempotent-ish. Though there is a bad sequence
>>>     where we delete somebody _else's_ lock, like:
>>>
>>>        1. Parent forks, but has not yet reassigned.
>>>
>>>        2. Child calls reassign to take ownership. Now both have
>>> 	  ownership.
>>>
>>>        3. Signal kills both parent and child, so they enter cleanup
>>> 	  code.
>>>
>>>        4. One of them (let's say the parent) deletes the lockfile.
>>>
>>>        5. Some other unrelated process (let's call it "git other") takes
>>> 	  the lock.
>>>
>>>        6. The child deletes the lockfile.
>>>
>>>     And at that point "git other" thinks it holds the lock, but it
>>>     doesn't. It's quite an unlikely sequence in practice, though, I'd
>>>     think.
>>>
>>>   - If neither claims ownership and a signal kills both, then nobody
>>>     cleans up the lock and it is left in place. This is annoying, but
>>>     also something that can happen occasionally anyway (kill -9, etc).
>>>
>>> I don't have an easy suggestion for making it more atomic, though. You
>>> could choose one or the other direction using some synchronization
>>> between the two (e.g., child reassigns only after parent signals over a
>>> pipe that it has relinquished), but it's all kind of ugly.
>>>
>> Ya, that seems really ugly. My first thought was some way to disable
>> signals temporarily, but I am guessing that either has no good way to do
>> it or would introduce even more issues. Plus there is always kill -9...
> 
> I guess the parent could relinquish control by reassigning to "0" before
> even calling fork(), and then taking it back if fork() fails. And then
> worst case is that nobody cleans up the lock (if the child is killed
> before taking control), but that's the least-bad outcome from a
> correctness perspective (though still annoying).
> 
> -Peff

This seems simpler than the suggestion of a pipe signal, and the worst
result is only the version that is possible no matter what if there is a
well timed kill -9.
