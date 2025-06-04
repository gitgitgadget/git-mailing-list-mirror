Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB91DF27E
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071109; cv=fail; b=IxC+uwC9w34+v1qMDKjTJlGPIXWJMKWE5BvtE7OViBpz3PDGZbVHggTJmao9KUjPHMpRa3QBJgqM6y/oLBU/IO1R9Ev2JBGc3/ZsqUwjinWgFrZ0MQpCo3gb35iftLU2aMIVpnuR7Th0U8AxHiL9LYIraSx+apQ9xhMCFPZxt9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071109; c=relaxed/simple;
	bh=rcQZ37biSW9mlnK34VQrocXOIxgbqcXc0vMKC2dVRio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVN/xbmZimEA8G0wMHEg+BL105CqwdrMCfAXzubBEZtmvYTn94A7ynyJ+WMW6b9O0rRktJRt7qMskuiAwhNNbLpzyvF2u0pS0Ywp56IcMkVJBqnZmxJj+sinq6cwf/6xfdcpTFfd0FXobWhspAAkd2/q8Bvj2SshdI6NiVtwo28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8+UdW1I; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8+UdW1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749071108; x=1780607108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rcQZ37biSW9mlnK34VQrocXOIxgbqcXc0vMKC2dVRio=;
  b=H8+UdW1IwrhPuaeypOJQ3hCZ2EkzesPHdPE9Hp4A8q+gbqh14l7GxYf2
   fE4+Nk066uR87PKVApxS3RMpSfevmYR/sBl51mQK2fFBZ72K5zCpkpJha
   ClezD7cdP16w4Wi+/kn6dDVK5xK0EDqEEA3zuY4IQqH4ohDETrKIzJMwv
   KfheSUvNzKfHFFP7pQPFTuhG4XoGX6hyg+gaHirGq0KrCnDLtRPRxi5j+
   yFoXIN9KsMROJYtusDk1QAEoowM1/gvPuy5fSyIPSE0fSnMbz2VL+/dDC
   ftSYKgWJkuaKbiA2kWq9746RE6A3myHZkTzrk85fOCNFC1AVt1VYtDt6F
   A==;
X-CSE-ConnectionGUID: 8QrjQQ2WSeWoWkqm2CGyDw==
X-CSE-MsgGUID: VCb5To7bQH+N4yHUvKyFgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="76570567"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="76570567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:05:07 -0700
X-CSE-ConnectionGUID: c+hMgWXiQ8iIdyHxoiJwjA==
X-CSE-MsgGUID: ettIEPdHS1S1O2Kcyog37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="145259907"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:05:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 14:05:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 14:05:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 14:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt7Nxbr40Z8R0g39ZFhc0xg9OVB4dmEclNcCjLYWSEvRnG/mX0VjPE9fy56ayYSdmca0SW1AiqZpcfu6RkXVkRHiqcsuGuD2DaW9QZ8p1mZ77nN2edIXUn8MtfibD1ubNDTIqpGZ9xyev7HWMqxBT0bPl6+OJVpAC6ZdxsXdPXM7t+hdNn/2TuPoUb4mPzaRrO+RF4XdINsj+/LJ5Fwgafibt1dEgKaWLxk/ex3ar/gHRgbGHxrO5tGjRlHfVXVTR4aeODb6WnYnplNC+wVlrKBl9ZmagO1RqhInKjxiKB15qtGaTTcEfpvl1NYvu7MRzOx2f+EziKGJ3wcVS5nGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ4yvVeKY/yX2LU1pRtH6tJIHn7G/chyjQFYp2t1wsg=;
 b=IQMlSR+ndY5frLucktoAm/+4g/okuxdnKsX/Jol1OCrMYWSXzV429PJ5Y/4fZMTTCqyoJ0ZGPTTPF65d9IrQ6IVov0bzgC2jgeFxrWkS4Bumm2bEZSTRQOfAdRsUw0YxpSH3oKHuxb35VQg53WFXOs2nYhGPnB2qsTcC0iN2rVm3whEjiU7MFbdKZLy3ZMfBm/OljU2JlFdINuNRbJnuIIY+yQu1q6tzN3dIIwBH+X/VZnUYjKn5lr0JmNms1fwRtFAeWCtBBGPIRuaTd3I/Lub5YO3ewsJCqBRj3RspIJJCLqB7KnPlEsXl8AHw+TDLsUDg4HlwbIwHXz2L5P/rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB6656.namprd11.prod.outlook.com (2603:10b6:806:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 21:05:04 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 21:05:04 +0000
Message-ID: <04ea6073-16fe-43b6-919a-08187de030ba@intel.com>
Date: Wed, 4 Jun 2025 14:05:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Junio C Hamano <gitster@pobox.com>
CC: Ben Knoble <ben.knoble@gmail.com>, <git@vger.kernel.org>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
 <f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com> <xmqqcybjb6pk.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqcybjb6pk.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c2efe3-a72f-4507-c9be-08dda3ab7a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enlTZU16aitFbE9RcFY1OWViU2p3TTlvYytJSTUwS3JkMzRaL25ONmFJQWNa?=
 =?utf-8?B?MEw3by8yNi9XT3BqaVl4dGhoQ2k4emRVcUc5TTJLOS9CK3o3bzNtTHk2dFpT?=
 =?utf-8?B?a1RiR3MwQ0xXbXVwM3BQZ1k3WHpaNG0rNGNnRWYvSnNoRHgwQkhkZXlhQXNs?=
 =?utf-8?B?RU1NcXd4Q1JlR0k2ZFlUS0ViSkZLakRrM1Nwak5Ub0lTK1ZIRVRiUGozaHpR?=
 =?utf-8?B?WGRWaGVvNkdCK2VtRWdLaFVmMVQ4azdudVBHUVdPRXA0SWowZkNVRkwxZkNN?=
 =?utf-8?B?TVdkdTMrL09EdU1WRVlqTFZwQTlwVXNJYk5ETFUyNWI4OUZOUk9seDR3VVdy?=
 =?utf-8?B?ZDIzODIxc3hRTVVhQUVqSElLQTIxMnRkQXFVcHZ5U05qZHhZOGw0UExMS2Yr?=
 =?utf-8?B?Um9FQ1FSaXo4bFEvUGEzRWFFZzdtclprRW1yRG84RG95VG4xMXg5bEdyd242?=
 =?utf-8?B?UTVFTzhpODR0d2xnTHl2MTRtUlBGNkRaZHl5UFB3bFVHRDNRb2pIRnBIdnJi?=
 =?utf-8?B?VHM4Y1p1OVJVT2Q4TU9UMi9UOUVYOU1wMmo0NHBPWnNUU3o0SFk3dWw1ck04?=
 =?utf-8?B?T3dCNklDUEY0cU5KQlNYS3g3N3gxdWRnK0wzVFphNTUrMEFBcDJGU05HNmtn?=
 =?utf-8?B?aHZQTGErbDVublQwc1JWZWhTMGhlQkdXQ1p1UXdoN3lnRW84UnNabmVnRzY0?=
 =?utf-8?B?MzVYR2Q3aDl6eTBrVzA0NFBSTDlCNXM1ZWljVFladkZ4UFprbFE2cUJHT2x6?=
 =?utf-8?B?b3NkQmhxTEIrNFFFVXNnenVBOGdvR2hmcFV1WTdjVnRCSndYd3grUWdTcFJw?=
 =?utf-8?B?dTJQVWdBNTZsSmdXbmR5OWRiRTJSNklMRlUyMkpYMHcwY0FYS1Q4eG51UHR4?=
 =?utf-8?B?alh2Z3Y3QVZHY2VMVmpaZXdaUDl5Z2RKcjhpdlZBNE53NTduSFA5ZzNMQUZF?=
 =?utf-8?B?dE5ieFo3VFdjUmFsa0lFeHdDSHoyRnpTRXQ3czlkaVNvVzlSeHMzdWdSWnFB?=
 =?utf-8?B?US9MWDBadzJ6WFZvYWlsT1B6bE5uRWhRMUw2TUh0Tm1ldnAwWVB0MmZOYm5l?=
 =?utf-8?B?NXVaSG94N0JXSnBNVzk3Y2lDYmNpTW9OaVNaRndLWGVNWFR1dndaUFEvK05x?=
 =?utf-8?B?Z08rMlpqMGNaTEhmVXF1RnFwTDY2eStpN2YxQWtMbGMyOEJKNHZXbTBaU1BW?=
 =?utf-8?B?UTRzRGFtSTdLaytNcmUxaTJ4bUd2ZXZQVWk1SzhoMTNBS1QvS0M0VW44ditv?=
 =?utf-8?B?ck54WkRhb3EyYU9MRWwrcUk5T0hkZTRFREdGNkJQaXBnSi9sZ3dUaWlYQTFh?=
 =?utf-8?B?RGM5Z0taajh5QnhWYTdNcVVtdXcyNzlxTkVlYnlkd2o3bHVQOTZMWnRXT3Vh?=
 =?utf-8?B?MWRIZUo2NFhLUk1rdS90M2FiYXlSaFFvVTJVTllyb20zcXBISG42RzRCblBi?=
 =?utf-8?B?UUdyV0FjdnNkQWwrb242QjR4cC94bWhLQjJEdDVUdjdmM3BHOTBJSWl2MmN2?=
 =?utf-8?B?WkdwbGFzM0lyN0xBd25sZnVRalZlVm1GRGdIWWJ3OS9GQ2Y1b0poVTB0UDA5?=
 =?utf-8?B?SkZnYi9zRUI2RktQd251Z3dDMVVLd1ZMSFNzNHZlb3RaVGt6UTVvaTZYMDhL?=
 =?utf-8?B?dVgvcDc2Z25mWnV3REhRRG1NLzBldmFXSE9ybWM0bTE0bVI1aWVkQjQ2MkRE?=
 =?utf-8?B?c1FzMXN4ZG8zbmZFUnZuRjBycmFZcnNZZ0JtYUtaNWlOdHdMd0xkMDFTN0lE?=
 =?utf-8?B?d05aekdJSVBOajRqLzE2S29wNmhGNXBpZm9BSnFCcm9iUDlDNGIwTDhUU2dU?=
 =?utf-8?B?Q2Y5ZXhvMG5HUnBNckZEOGc5SjFzM01JcDRFVGpIMTU5RzlnTjhOYzd2aHUv?=
 =?utf-8?B?NDUwUHl2dmp5TCt6cnpxT2RQUGVGSERNaGJkc2VWUHZZRU9LaVV3YmFaQVZ4?=
 =?utf-8?Q?dy7MhFIOwIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVp0dGhKRWJkMmNOb0hnVEVwNUpVTklUNXJFY1ZNN0VRQkdxMEdmNFhvMWVx?=
 =?utf-8?B?bmNRdWsrMUV3N1IvU29tayt5eWZsZXVzdE9jOVlXUCtjUnlZai9XaDF1MFRB?=
 =?utf-8?B?MW9jQUZQSytOaTJtUWVRb3NwLzJhYU9QVzNWaHl3c1VLK2pHSlNzckNOd1ZD?=
 =?utf-8?B?anV3cnZidWhocFRDSUJmTEUrUWlDZXVSTkgzcUdLcVNJMGlKcy91dWM3UG05?=
 =?utf-8?B?Q2hvTk12NDh1VWxXdE16Y2Fja3VNVzdqVDdkQWpuY2RzbTRNOEl2UGFHS0pl?=
 =?utf-8?B?Snc3VldNZ3AzY21LUUpTTWdVK08zNmlsU25DOUhxSnZ4VzM3Z0dNZU10TlpQ?=
 =?utf-8?B?ZENMN0ordTZPWVV4YzEvdE1ZM21IUzZyaUJvUVl0NGNZSmpKNFhEN2NwZytu?=
 =?utf-8?B?QXZ2YUdSSldLV1J5ZkptRGQ4NGJXc1BEM1ZBNG9RQ0tMK1RtQmVxQTh6NGNC?=
 =?utf-8?B?S29tY2NzQ1RkWE5ZNG8rK0F0aUtuamMyeFJwRTBtbHU1V2I5cEZYSnZSR2Rm?=
 =?utf-8?B?cnIvUnhhT1VZT3NZOHgrbFdRTWZkVWRkSkRYMDhkNDh3MmNDaGVKYksrQ20w?=
 =?utf-8?B?VWcvbm1UNVg4ZFE4WVVCK2ovY3VEVE9HMlQ2UFZBdzJZdEhQR2ZEeVlhWUYy?=
 =?utf-8?B?L2N2SGdOUUNGZFhUUzNPaUdHUlRLQTBYRVFCRHRwQlRXZUV3U3lrMDdWUW9x?=
 =?utf-8?B?UzVRY1dFd1haOHhjc3dpWENVb3QrUmVCblFmcCtPSjlqUDlGQjBzME5vMy9P?=
 =?utf-8?B?bS90TlhDQ0dxbUs4QjdnYWtyeEhFUFpvNGNOLzlkQTBHWWNIMnJBeUgwK1gz?=
 =?utf-8?B?emNJTW9NS242cXRINmZrbVhOZUpuNDVYeVZCZFhTS3pEY0xxR1NvQkFsRVAw?=
 =?utf-8?B?bUtEK096bWlBUWhsY3I3Ry9WMGVUR3N2WTJhZUM5R21jaEhBY2NBRlBGeGE3?=
 =?utf-8?B?YXlISjJFcDRlQS9uQXRVaVB3WFovaXVCdGt5bFBpL2hhZFl3cExZNndCc1Fv?=
 =?utf-8?B?blNFTVgwdzFoZ1UyeUdzekRYU3dqTy9MMDhyV05DQnBPNHkzT2YyaCt0blVM?=
 =?utf-8?B?anFOaWZmS2VhNTNzMUYrNVhUYzlvc2tNTUU5NlkrYzUxSWUwNHBjKzlHRE9B?=
 =?utf-8?B?dENzSFJSM3UyVHNCaitla0NvY3NkN1hnSno0N2cwRjFBOEFnSlYzWU9mcDcy?=
 =?utf-8?B?bW9jQm9yVHd6akd3SlNrRXpzMU56VzJRR0FMTExmK0ZLOENzY1J4MHZEbUtC?=
 =?utf-8?B?bWExZHFNMEZ1aG01WHpBRDZMOFdyOXpMZ3ZESnJJU3ZZSkRGYzVtemJ2YUVI?=
 =?utf-8?B?TVM4Ykl6aXljZ0g0ckx0VzZWRGVmK1BRK1RDYWpzNnhROTRjSFhqQTlVMnJz?=
 =?utf-8?B?bFl6SjJocG0xRjlHdFpLM3ZqSHBOSXlLLzJKRlozSVRIMUlzUmR0ajc0Q0tw?=
 =?utf-8?B?dUlGbGwwWWI5NlhPTUVrdTY3bDEvRnE1TjZ1aFl1T0o0N3hVTElTdjlrVUZJ?=
 =?utf-8?B?dmhoRWE1TzNuWmVxTm8yYlY5dGtGM2xBZXFlNkp0UlExZEFldGU3K0JOTVpu?=
 =?utf-8?B?LzlQc2oya3lzNjhITzNrZk9nS1R0VW42bjNPLytNR2Y0dDMxM3VCSk8wMmRH?=
 =?utf-8?B?THpoZEozdkdEUUJnbDdVZGxJUHlwbjQrcUpLNVI5N0tUUFFURWtoY09ya3po?=
 =?utf-8?B?TkxZMldZMVN4cERGa2d5VkxKaVM4aHd6amxiNmJlZlE0YkF2elovUFR0c09y?=
 =?utf-8?B?RWVjekVXZzl6R1hnRWpwUGdNaUdqTDh6Z2Iyd1pRa3d0U3BBaGhIN1BaNVRx?=
 =?utf-8?B?cmZLTTRDb1crbzZzQmI1YmxOd3pJdWN1cWQvVUdabHFlVkd1OGlKcUpBRlZ0?=
 =?utf-8?B?WHdWK245K1N1REFxTk5uclR5amRkZnRDSitiSmhFS1ROSnBVdkJ2TlVFcDRs?=
 =?utf-8?B?aHQ0eUg1aXBWc1QxanJGbnFwMnp1djh3QW9ZZkYyeEl0Z21EbkNkK3c5Nkda?=
 =?utf-8?B?MlptUmlmQlpnaDhBdnkzeGNtRit2RlZ5MWJ3SjloRk9EcC92ak5kY0RLTytI?=
 =?utf-8?B?Um5PNFRieko1QnFLTENPUTRTUElGeFV1TU8zWGhTMG9PVXpxUnI5d21HUUQx?=
 =?utf-8?B?bk0rQzl6MFVQdVFGeWc2d3BVbHpBeVNJWTUrOGo2UytTcjdVWmR5Ym0yZGQy?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c2efe3-a72f-4507-c9be-08dda3ab7a03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 21:05:04.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0mIUxsbICZuUjNq586sgxphTI5OXBSIgt0Ct2JOdX0OGquDl1AMWQ1hYgaMzEer6PM4sUF1zHc/VKV4BDTabnaVwnb5JoFMLwIi7rv0A+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6656
X-OriginatorOrg: intel.com



On 6/4/2025 1:19 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> Would you like a v5 with an updated commit message?
> 
> What we had was already plenty readable to me, but if you think you
> can improve it further, I do not mind waiting for another round of
> update.
> 
> Thanks.

I'm fine with it as-is. I think the minor nits from Ben aren't worth a
re-roll since there is no functional change, but wanted to confirm my
opinion :)

Thanks,
Jake
