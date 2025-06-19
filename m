Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3951D555
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292391; cv=fail; b=J1AqgUF6E6dOz82k0sAOzVciv1Lts0M9/esDv3mjaMBULrU0tXYumuVNIztRguG5qZnabA/wxLD1lB6Y7IBHHFG2ZaDen9FtbtMYCGzaXzrllKWSwCkStubzWa9cLaAVrjM/JXWAoOIbssyh+lrIFcu5gFp++0UJfMGU9iz3Fd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292391; c=relaxed/simple;
	bh=ZJqZXyasB3/wVpR0GhCGYz38KrxRxaShNOBlnFokwYI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qdLlddYRzq/4mdxkkI8DZ4tLK/na7bs0nVeEBChq+p3VsZOnIu1HX/9JK0KfbJdUkDX5cbVg41j1SxKQKr7x/SaUgRU33bvSiIBD3xo1L6A9LNKwTts8l+XNgSpa242IaUenvrDFzIuaOkAIe6NlSn4XfPo3KZ/S5xCM0rUnNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5YpvUFI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5YpvUFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750292390; x=1781828390;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZJqZXyasB3/wVpR0GhCGYz38KrxRxaShNOBlnFokwYI=;
  b=j5YpvUFIHPXTnMx5g4ZyF9zpyD3siX93IcaoywXTx+0zsTk+eLa0br3S
   0G9cxuLmky/gU45pppziR/ROI/1PZkaDNhzUl24j7g3x7yupeF1ouYDjM
   0US5Oq5JRtnj8er0TibWnz//mOVtutnrdSmcUKarCYpMejini3NreQMPb
   6uPiqXLyr+pYMZdjaK46MN7VE3VvtvobA7/JS89+JSvkPyhhx5iJX2w6o
   hofZHHXQoryZ2IFzCp7DqeYFHUJg4IhOxBZYRkax8PX5Tc7Ik0/tV9ay2
   PpHctdyMizBZqswjIyCiEC+iQ+z2OR+1U+x6UteZufP8pKTesA1dj2tI6
   g==;
X-CSE-ConnectionGUID: maNw694vSSGsDx0TfsxigA==
X-CSE-MsgGUID: qlyQhdE1Sm6MeQHQp5ewHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="70105278"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="70105278"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 17:19:49 -0700
X-CSE-ConnectionGUID: G8yUwPjnRr2kqL0XR5qhGw==
X-CSE-MsgGUID: q+L9UHN9Q/KbyuO8v74FKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="150802413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 17:19:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 17:19:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 17:19:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 17:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsvma+/YMi/lDSOi1dIyUq0SilG1ZAhQRGzcVVj8eaC1bAAFzMZzWx+mu6QNYlyc/PbLGMgOpJUKvygUQtiksr81e5/N/aI6dLL+0AKntpyVIFWMylCeFDj/MaI1uW6sHADYD7k4ODigNo1ZycMKL1NDYwow1TfMYKbc3KiiSK+nIaO5Pb4fppuwnHn77I9XKyNSXX6VI1pTCoEaDfparcv73uEwujcz7I2ROUK5RfLWFqp2plD7iO4o/oqG89+PEB+fAlUq7VaSEA/5OO98DURt1oO3D4syJqSYLNwc1HAuUzlZ7RpmuGmPMWTjddVw697S7hOMnipDYk0HYwOLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0XraIA5ePUt4u9zkddZX6ntuoZXsxwCJkzIDCKcQlY=;
 b=xg1DhjetXr7vhWyzVHuy2x/1tfb4Ap+MBS/Me7TEQk8BlYhrxS4mdbQiHrbssEA1nz4KeGwBUk/R7wfhnqWCOZWwFkvid//9Nb2ewcfOiS1bD3VgV9Fps2T9nQMk82mopv1Nt6HlznNm0B5bMl2ENdQS8Byl2E7ERCV9NlsUgUeI4qEWtekBMMRNt1YyDPgB1Hr+NGbUXyZxiUKXp2sUQvk3115lPfmN29GV7kzDVcYgHiX6bFON9HNC0jmdUNARc1AtM5Q9+9hK0alQRlORI56Nxkqd29y1PL6BZFq4w2rKAzztSXJRq+TV+4YPpVBvjPq9abQyw+4/cihXYCWnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 00:19:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 00:19:32 +0000
Message-ID: <30cf835f-925c-4d33-a353-ee42e712fed7@intel.com>
Date: Wed, 18 Jun 2025 17:19:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: bug report: I was allowed to "git checkout -b" while mid-rebase
To: Grant Birchmeier <gbirchmeier@connamara.com>, <git@vger.kernel.org>
References: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2f49d4-4e7c-403e-b894-08ddaec6f6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEMxYndHK0JqUjMxL1lpMWN5OEFEK2tJMW51QjU4QWhSdzVBdW81UnJSVTBZ?=
 =?utf-8?B?WGFEaUZmTkV6NUJubXJ3c2R6RDBmMkhraVJ4ZlFpVDFtYnlFUlZBMWtaa2Fn?=
 =?utf-8?B?NEw2MWVTQTJwVklCQmtqakF6WFg4Mm9MRUpKUitqYmYyT2FEZzgva00wRlVD?=
 =?utf-8?B?UjYwVk9jbGtvVHdRcHdUSFNVR0EwZURtTzlob3plT09IeTRMT3l2amRiUHpT?=
 =?utf-8?B?eGhmV3JvYmRTMUMvOXdTdnlxVDlUdWFWMnBNaFBOOHdVUW1BL0EzRXVJc3Ur?=
 =?utf-8?B?R2xmUlFVMmx3MGFBT2NPK3p0VE4vMXBWZjJUSEZZVFhnR2ZrZXV5SmNKMHhj?=
 =?utf-8?B?OE9aVG9QZGZhTW5vR2ZqTHZva3ZuUVhWaWFlbGUxdmVYMVNwZTJCMklEaENU?=
 =?utf-8?B?bElFc1ZoVzY1L2RKaFBBZUtWSFJjdzRWV0FZTldiNXgvMk02NWtZSE5CMFRq?=
 =?utf-8?B?aGY2RFJaTGw2ajd0b1I5MkJyamVjVFRDNWJHZ1JxKzFTWFdYdlozS3BtS2lX?=
 =?utf-8?B?cUo4ZHBXTklXT1lZeVFiVysySmkwVEhYdEhMVWtORkRDN0NPZkZDT0o0MUI5?=
 =?utf-8?B?cTh1RHpqc3JDWWpRTGtFSlZKeGlPcTQxQ2MxTkozakFUSVRPQTl3MDhwNnpn?=
 =?utf-8?B?L0o2TVR6ZGhZS1h5bVhwWld5a3U3MUk1YkJ0bHVnaXYrdS92NzBUbFVqelpJ?=
 =?utf-8?B?QlZTcTFkWkZDR1IyclFLTWpDZTg4QmNsNndJUGIzbDVubWNITzZHc1pMVHN2?=
 =?utf-8?B?eE9wcy9NWVZSRUwySGVWTmM3a1VtdXZZR2lOQ283Z28yRVB1NHBYbkZuSUt2?=
 =?utf-8?B?bUFUQnBpd2JPY0d1enY3VDdnRmJQOVNueUhUY2F6WURzWDliNDYxWjRpbG5Z?=
 =?utf-8?B?TWZpOFFsN3VnQWtrV3pkMjBDcG5NUHY3Nko4OUxlN3NoOENmN0k5MHN5L3Ar?=
 =?utf-8?B?eDVMN0JVNUJyQXM2UW9HeFJZbmdjTFl3RTZGVTRwSDZEcDZDVXFpeTRxZUFk?=
 =?utf-8?B?RkFtUTBUVG9pcW5QRHpwMnkrd0wxc25RMGF2UlprRG5lRWYzNDBVNE1GRDNO?=
 =?utf-8?B?VXpHc0NTcjlJSWxvbEdtTjREMkFoNm9LeUFzNXIrNGNyaXliQnptdE80dWp0?=
 =?utf-8?B?bzkrdjQ4VnJCUG4yTmc4UFBRMDM4dFpFRG1mbHFxTmJmc3Y4QkZWN1NaeFBv?=
 =?utf-8?B?Y2pNSGtQaFVmNVBDY3BjQnVFbzh1V1BrRWptam15U0VLY0k1aElyQVl4bG1O?=
 =?utf-8?B?NzJETElraFhxT3JIT3VTUEZzZjdOL05yaEpKVmVFb0pNODhPUHRuVzhwVEpl?=
 =?utf-8?B?aFZHRkI2Vkw2eHRCR2M3WmtycjBNM3F6MTJtVDY4SGxBeGMvSW9oYUl4OCsx?=
 =?utf-8?B?ZzQxTEg1SHpSamNDdGhJcVpYUG0raVBYRWhwRjQ3NFFrNDRtL3hlSk00M0cy?=
 =?utf-8?B?UUdSc1VrMFc5aU9XdzNRYWdra0c0NHRTc1N2OGE5L2E1Y0d3Y2dQSTF6Mk5S?=
 =?utf-8?B?dWVkSDRHWmlrcmRKTjdWcStyM05uYlN1VnpUcnN1dk1MYm5UbzJReUdHTG5h?=
 =?utf-8?B?Nm1aVzhaV0psbTBHYTQrTnBTVS9hTndTWitiL1RvZFBUMkluWjFMeDZlWmcx?=
 =?utf-8?B?bVlBaE1OWDZQamNkdWZxSnkySXZIVU1zd0h0VXQ5aVhmSXowcjFXNVdJQVJM?=
 =?utf-8?B?UU5VOHFOb2tPcWlNb3lxQUI0QkFWY05XenkrbVNUcDVNcTRBcVl4cEF2RmZV?=
 =?utf-8?B?MWtPc1lCRDFCSE9mam8zSFFJMlZESk9tTzZQT0FGZUs1eWNuY3VucHFRaTZy?=
 =?utf-8?B?dkFGOG9wdmFCYlhlMWJZNGNwK055bU44bko3dXRDdzRFTnFaZi9YMXRFTVBZ?=
 =?utf-8?B?dS9FKzVNZTZZOWlwZjMwQmwxUHJoL0lQZk1aYWQzL3dIMVUrbHFNQnQrRjJX?=
 =?utf-8?Q?O/dFoPaYZyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtzVkFPZnBMTGtPNFVvUk5wTG51UVd1bk1ZbmtXZWlJMHMvaTZ0OHdoZ0NB?=
 =?utf-8?B?RnFTOXhjeHhRUG0zYjlzZTRhbWZ3NnA2U0R0K0VNNTlpdEJaQ0VKVFk4OFNX?=
 =?utf-8?B?NkRLSDZ2MDhyYVpRK0I4SFByczJ1bllOdVV0TEIyZTZ6Q2JwRDZ6SUROTUVC?=
 =?utf-8?B?WVNQdTRuakpZQm1HS3FDMUdaNkNmYUZRKzZjeUJGMWc0T0ZUVE9MOGNLNS9q?=
 =?utf-8?B?bzcyUytya2h0bXB2OVRRSkMwSlJOZjdSdGdPaXdvVXRFVHlNWXBjWUplN1BR?=
 =?utf-8?B?ZVRXWHhJV1ZlK25MdXRvNVRlQUM5aERPd3RnLzE3eVJiUEFsL0tmUFRkaXRv?=
 =?utf-8?B?STZ5V1Nva2FUN3ZJR09pMVE2cnFRTDZnZ1FWSjhLNmF6RG1yNDJjVllkNGZK?=
 =?utf-8?B?bEpjNHhCamFlNXQwdktRc09xRVl2UE1xUFg4YTFXMzVnZXNpdjlhSnNyZWYz?=
 =?utf-8?B?MVRzV3pjdmE3eUxIY0FMaXZEaXl4ZDF5dnVnc3RzdHNNZzE5b29WMGNGNW5O?=
 =?utf-8?B?cEMzN0hCMEN2Um4rK1BWNTZNV2k4UExIZVBwVnM0U2xyTzZBMSt5MjBiVlpO?=
 =?utf-8?B?SkRNRzlDUnZwaWgwUVFPQU5ESW5pd3VNZ29aazlPNk1GVDBRN09QV2pRK1VU?=
 =?utf-8?B?YWdUd2NjanF2RG5FZ2FHWHNUY0dUckNPZGxhcS8vQ2ZFWGFUODJTUG8wSlk3?=
 =?utf-8?B?U3IrZGpLYTBab3U2ZU10eE96NjhpRnN1Zk9lM2djL0t5WVIzbTBUWjVKaGxr?=
 =?utf-8?B?RUNidzRnWEFpcThwSTA0VFZ2VmNrMThzNnlCckYwRFlGSkdMOGxGZ3ZEcEU0?=
 =?utf-8?B?MGRLbkVFblptd0kyMHBkWXBIWUUzdE5Sdnp2TTI3dXNwSmxNbU9aL2lnZkp4?=
 =?utf-8?B?aUcvWU56MGdsbVZ2dEkrWWFTNExjbldaZDlSUy9tMGNMS2ZUSGJqaHp3aHVV?=
 =?utf-8?B?VXlORlFIYytWcGw1dUV4VDFDRGQwN0lGM1pLY1JacGhDK1E4a0sxaEFtT1ZZ?=
 =?utf-8?B?aVBpakRXMVdRTTlndlZaOXpTZlgrRXVwZXJRN0owbWVkWmg2SndKSnBXbHFP?=
 =?utf-8?B?WXEwdDdoMHNCTGQ2ZXhYTnk5dFFRLzVuS0FLcnhZQVdCMXEyQXN0SlRkWENS?=
 =?utf-8?B?R00zYXNhMHJtUm1taW0yRzRvMkhQcGg2TFFCcTRyWENYbXZEemlaTkMrUWM5?=
 =?utf-8?B?bjc1NzZHMG5RNEFGaGY2WkZkTVo1cVhFNkxUam1jMWZjaHlzL29QOVloVnVN?=
 =?utf-8?B?RnF2Q25kWEhzOFVHWU50OVpYY1pSRCtSN1c4YXFRNVFwYjdFTExnd1BaSk94?=
 =?utf-8?B?TzVBOFIzN1BiVWxjeEt1NnZiMWRUWEZXTFd6ZzgwbkNwK2I2ZmxtNy9xSmJC?=
 =?utf-8?B?YnFybG9LMkdwam9SdU0rRDMzZEhldUVBZ2xxT2hlMHUvRVpoR1RxWk5qM1ZW?=
 =?utf-8?B?RTVzbWp2by9JOEJRcWorU3hFRDQ3akkxZi8wVWxpNnZZZm9vZmUwK3VPZHFG?=
 =?utf-8?B?eWE0S2R3OW1JdTl4Z1FSMjFndkJCNzltVFIvcUVsMlZtcUpXNHhxc045dnJ4?=
 =?utf-8?B?azVDeWF2dW1PenNha2FPNW1ybXJ2SlhHdVR1TytLT1lWakZyRlRjU1BkS295?=
 =?utf-8?B?Q3JUMFR1V0Q1S1JQajhPRWM1aHF3Qk1sWDNaWGhoYSs5SkNlTTVRaTVBVCt0?=
 =?utf-8?B?WFlJbWVyNlhaQmYrQUptUzNKV0dWbHpucld5amZrYlRoeXBxTGZXL25uZzJO?=
 =?utf-8?B?RXlHemhRc0dYdzd6WE9POTh6TXAxWmJjQ2I3cUttaHZSRFBmV01tUzU1Y1Nn?=
 =?utf-8?B?b3phNnViRmE3Y2gyQUFXcE8yZkd6UUVFYVViNWhpN2Z0VkNYN0lMdVQ2NjVC?=
 =?utf-8?B?eG03cTNpdDg4WVkwQ1ArcG5BWDM5WGsyYWprbS9sS0FBcXA0MzE1YnNGL21h?=
 =?utf-8?B?Wk1lT2VsTURXVUM1ZUhSc3EzTTRVbHRnd3V3S1p0LzNnWFJVZnp4V09BMmZ6?=
 =?utf-8?B?Y2VmbWpDbVJmRnJUbi9rLzY5bWpkU0NiNEJBWHJyRVBabllhUGVKdEtEajE4?=
 =?utf-8?B?dDd6MU54WEpFd2NVaTNOeTVyZXlpcmJLWnhEbm93NGJ5ZW95WFl4ckI5SjdD?=
 =?utf-8?B?NytZeVdVSjNFMnV3bFZsbnNpZXorUG5ZOUFTNDdTQldmcTBoZ2oreVZJWTky?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f49d4-4e7c-403e-b894-08ddaec6f6a0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 00:19:32.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BUPQgc8pMZZnIGkhZYKpBOI9m9zKzC0PDWJQ8JS5Rcbmh8zk7S3VQkcbPs+0G7CymGto8NffAqXRngd0s1HGqyzju2V2LKEtnw2lLT/5Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com



On 6/18/2025 5:12 PM, Grant Birchmeier wrote:
> Hello.  I've attached my git-bugreport, but I'll copy/paste the salient
> parts here.  Thanks.  Let me know if I can provide anything else.
> 
> *What did you do before the bug happened? (Steps to reproduce your issue)*
> 
> I was rebasing a branch "ilogger" on my master branch.  While this rebase
> was still open, I accidentally ran `git checkout -b net5` (I meant to run
> it in a different console)... and it proceeded to switch me to the new
> branch even though the the rebase was still in progress.
> 
> *What did you expect to happen? (Expected behavior)*
> 
> I would expect an error message and a refusal to execute the `git checkout
> -b` command.
> 
> *What happened instead? (Actual behavior)*
> 
> It created a new branch "net5" off of my "ilogger" mid-rebase branch, and
> changed me to branch "net5".  I cannot change back to "ilogger" ("error:
> you need to resolve your current index first"), and it appears I will need
> to finish my rebase on "net5".  Even after I do that, I'm not sure what
> state "ilogger" will be in.
> 
> *What's different between what you expected and what actually happened?*
> 
> I think the proper bahavior is for the "git checkout -b" command to fail
> when the current branch is mid-rebase, just like it does when you run `git
> checkout` without the `-b`.
> 

One thing you could try is "git rebase --abort" to see if it can abort
the rebase and undo things. If that resets the index properly, then use
git reflog to make sure the ilogger branch is restored to the pre-rebase
state, or possibly use it on HEAD to find any intermediate commits/edits
you may have made while rebasing.

