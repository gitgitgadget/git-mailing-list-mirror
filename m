Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA175221F11
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116061; cv=fail; b=mu3E0nyxtNd8IFz1uauVWmfBWuANcFTSSmdU7F9rpQE+0flEhqeTaYWmPH8Td5Lbg7jl11E2sESZOKE0L3KSA9/Rw6bGU2b1+ZzgCerdsbcUXB9TiMYrOItJ/ayscb/FtYWmMTcXGdDMVoaw9Vw8u5UgzqCZEwqODlNXBe9huIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116061; c=relaxed/simple;
	bh=QvJTKWdEzYCLQR8mPNaMko5HzAWMVfLYs5kbp1J3ZD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUZYJtTCUzbR5/oKfu3Y9utNTzArqTIsWcXYXvZCIRib9S2UJs+WWgjThcKj8XjPiOO37kRCDSGu1xNadJ+170Irr1bP8i1acnBSYoc0fpy/nG2KHpxYzaZwUs95reRLnF3gidKhz4X45+IVlt10r2P2lkdR+59Cd5QH+2UVktM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RX0MD5nA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RX0MD5nA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750116059; x=1781652059;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QvJTKWdEzYCLQR8mPNaMko5HzAWMVfLYs5kbp1J3ZD0=;
  b=RX0MD5nAIv2iSsMHtkTAf9IHNHG05EuQsnZzmeKrV5cPSWuxXcAIScgY
   sGCqVmc5wzbN7CwPn4N72qFOvXOPkqNjjyhmg/It0vYRV6emj7v+xgm57
   OPQEf2IVLfta6FXPPfIUc+peyMP6zWDFkRMnMu7aE+BRSDv+aGwuuovSk
   FVm2qvO37KGf4kgelmshfpvjoDL+vPwSShsZdlWo/P0uai+iAKyuVEByk
   2Op3daVWajLjKv1lXUQUVOJ4P9afn9ODJWN2HXLnBqd2hKgBxYl8MhS/Y
   FJm3gQKbPeUSHq5yjBeVH4UR3w/lnndF4WMIeOidlEHTmzk10BGJ4jti2
   g==;
X-CSE-ConnectionGUID: W72QCvqVRBOj+xtRr+G7mw==
X-CSE-MsgGUID: yrHcwBziRoKmNNDVXbj6Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="56076738"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="56076738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 16:20:59 -0700
X-CSE-ConnectionGUID: fA4TEGI8Qay1NMJHzTbr0g==
X-CSE-MsgGUID: GoPerKUzSXuTWSSbbHdykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="149143312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 16:20:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 16:20:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 16:20:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 16:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLd23Dl2PIw8T+RAPAL5cq6G04juinFwDhBphQ5FVW6ngn47t4lQf4xL2YMh3rbbKm5AyhOeA1LrSIyDcD3T2sud3uchyBxNOkQbnZIff2ctDcoCuepkfo/hsL6Lp6c82f6DEv0gcwi+r3WthLhGUpjPn13Btpm5G65lCN1edHY91p9LajmpwfDRy9MoRvNpkuCPm7u8Oslm94ciRTmSEj7rAClIfr08bLUipAHjH2IuTLwxB0idzLyulrT0/8Rnil1NgLs5NGK59xubUPlTqKa4MNx/DLGoktbfBibnGRFym50iDhWBFxWIYtGTGwFVZPgCLLM4qRRhPDNHwK2Qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDI2UypUo1lbCbhfWwhsmI3ilP4e2fGhauB+BZ1pUTQ=;
 b=kOu7dHTCdNYaKireih7COsfF5fLtSg71p0mvBldxwYuSmUw496LI6WoluRvRDrGW8zauZHkeF1q/Ey+QzAiWWckKYBP+A9p3qLdm8ceKG0UfQCRVJ8zniN2nlqwYwS5yEUvs1/G+W73AR91l9lIJOBC2UE+O/Q3pwwreBr1Rfe1ALSiSRi7+g5shmkNrnEvg23XsOUPjjUEUTzNgyoy6PBU4R7raQMkuhVk7/7ocCNAMJzDQEtc1wcDJNJ61k50BguJht4h2RIiZe6e/MyaY+Du/Wyl2X+OQHhRtqgfro6I0a9r8/I+iqczrIwtvc6TKiczaE+/W6looJ8mkIVWbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9133.namprd11.prod.outlook.com (2603:10b6:208:572::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 23:20:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 23:20:34 +0000
Message-ID: <83af9bc9-7884-4ce8-a343-28dbcded7954@intel.com>
Date: Mon, 16 Jun 2025 16:20:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Patrick
 Steinhardt" <ps@pks.im>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
 <f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com> <xmqqbjqnz4ve.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqbjqnz4ve.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: b8003749-dbc5-427d-415a-08ddad2c6539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlFZWG9VRitBR24yWmFZL2VEOE1NZ2lvWGV2cnhDL2R6S043MDczMjNpY2FK?=
 =?utf-8?B?YXRqNHB1bFFsL0EwSURVOUljSkZiR3ZpbXpmMjZRYmhqWC9DVTZlQjRtdExy?=
 =?utf-8?B?U1VBOHlBM1JsMWJ5dWJ5NitPcFhXanh2SzlKbDVjRlczN1RrSFc1ZGFRdlIr?=
 =?utf-8?B?c0trdytKQWhXSk5EcmY4a001a1ZnSjd5ZWNTS2ltWkFnUmJ6eTR3NGxnWEhm?=
 =?utf-8?B?bWxtMm1sSzFLMHB5bHZEbjhsMUhnZ204bVkzak12WHBCZUtKUi91ZVllZDhl?=
 =?utf-8?B?VE9IK0VpRExGSHg2YXBrY0VjZGc1L1IrV1lUbmUwNGcrUFNxRHdxLzRkVVpD?=
 =?utf-8?B?UTBlK3hLNERodHBWbU1IQlFyTTl6NWVYeGJpVE5xU2NwbDl6MDVvTkJoQ25j?=
 =?utf-8?B?TThwSGxrZmRsbTBseTVkUmJudjgxNDVFUmFDV0wwL2Q1N2VBY3YwckhpazFC?=
 =?utf-8?B?UkZkVHcwbytvMGdCbWRjMEdxNWFjcityME9xQ0piWmFJMzRzR3BYQUo5Y0Na?=
 =?utf-8?B?T0dqNEJONU9NUGdZZm9abGs0Z1YwV2RDTWNDL2JnckFwYndyaWFVbEdzbURH?=
 =?utf-8?B?d2J3eTZQcTFSWVZ0TGgvc05KdEc5Q2hBZU0wTG5XZHFaMUdITU5UbitXRU1G?=
 =?utf-8?B?UjlzdlVYODl2M1BVODNpYmRvSFRWSWhyMUpCUWZHSnBCanJwbXcrOUZ3aFBH?=
 =?utf-8?B?ZEk4Y1RVSUZ4N0lWUUYwTWx6dGN4cWkvcmVEQldaTUY2RjFaRmVjTFcwV0M4?=
 =?utf-8?B?RkZWOGoxRk1uQS8remI3VkFzRVNMVkRNUkpyQk9MUndXc2o2NzY3alhoYmxI?=
 =?utf-8?B?enRzVFVJRFVock1KZ1RKcEtjSWUxUEZjQ1JCVkw3MTNHRXFndThFWkZ3MFFN?=
 =?utf-8?B?aVo3L1BXVUtlZWoxaWY1WnhkQ29IR1BoNFRkT1VTUEFBc2RiUzNBNCtaekpQ?=
 =?utf-8?B?UWNTVjk0SUd0bzJTMDVWZ25uM1FreFB1NHZwMEFkTE9RaWVrU24xSkVpR2F0?=
 =?utf-8?B?OGIvbHlSaGplVE9pSFAxSzk4NHp3a0NvdWZGQlFLZVNIalM4OUtCTTJ1RGpG?=
 =?utf-8?B?M1ludkNpaUhXTHlrK0FhenByQ1VRd2ZKOTUwK1BPWVUyK3BIQVgyT0praE5Z?=
 =?utf-8?B?NW1maVNUeEV3NDNudHo3NEJIMVQ0VUR1bVdhbW1VSVhjazBvKy9OcjNCZTRj?=
 =?utf-8?B?cXdOakFJbFNKUDk0dXZXMjZyQi85cTEweGxBWlBPY3laaXhQQkt4SDJlckx0?=
 =?utf-8?B?T2R3Rmx5SlhKcVBBUnBXMlVtSE50NGs2a0hCZ1hGODNXNHhCWi8yR3dHQytx?=
 =?utf-8?B?aWFjd24vS2c4UkFMbGxuVFJHa3hZUXgzSnpsc3hTRVkxbUZhQ2h2NzQxZWtM?=
 =?utf-8?B?NmIrblh4Nlg3amJJdUlXclE3Nk5CMkxFbnV1cENVVHZ1ZERmM1Z3N3JPa1p4?=
 =?utf-8?B?Zlp4Snc3eFZGV21PaEszRlcyR0hkMEpHQWVYbFpEem9qanpabzhSaG5aR3F1?=
 =?utf-8?B?NTUxK0F5Y09KamhWSU5GQXVySmY2eE1weEZ0VjhTeldnUCtKc2xLQkxobkl3?=
 =?utf-8?B?SXYzci9PYVoreFoxakpZVVJtbFZIeElPU05JUGZpTEF4NnFNeTRUNDZhQ0Mr?=
 =?utf-8?B?bkpEelhacUUxSnlER3dtaWVpSVN0Y29WQkFSaWdRUXRMSlJjWDhCRFNlK3V1?=
 =?utf-8?B?STlwUHFRTms1MXNMREFMbWdrZTVEZ01kcWpFNHJxZnJBMXZGUEVBMTRnbHJu?=
 =?utf-8?B?cGF0NlZKSTRlZU05WFdkRklIRzFUZDA3cXJoTHllQVhMS1RFVjNURm1FZmhH?=
 =?utf-8?B?T25ybVFtc0NmOFFjdDNpVURWVFdCTDdBQkZWYUI2MWJ0MmJyR3h1WGtCbUJF?=
 =?utf-8?B?VHA2dVhvcW0xVTJiTi81UGZkWGJoSjBWRGx0Wm1zdm5HVTE0MzhUTExsL0FZ?=
 =?utf-8?Q?244fhe7Tc4Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZIZWRCTjBzV1JzQnB6ZmxKMWtUTUkzMXN4bENvZmp6ZmN0QU9ycTJXTTlF?=
 =?utf-8?B?VVdzYk9aclNKNjVOWlQ3QTg5QnhDZkhrU2dJaWlzMG1nNW1NSm5PRTFjRm5S?=
 =?utf-8?B?Ny9yQXBqYnZVMmV0U1F6R0hpWGZZK1hjd0tueHVBWlFwaVp0K2o1SzFPQmtC?=
 =?utf-8?B?ZHhYS3Q2dUlQcElSM3pVQTZ6ZkpPNEVwb0hFcWRvMFE5M1VUdm1mK3N0eHR2?=
 =?utf-8?B?Rk5iQXQ3b2E3aWlTd01pWlhDRDlTUXJzRlNVbE12c2xhcEFJOXRoZHFDY0kr?=
 =?utf-8?B?MmJqbk14RjVIbFUzeTNlNlU5VmIwTkZtRXA0QU92NDJyTE1YWUFKRDUyaUhK?=
 =?utf-8?B?Y1pXVXlFeUt1bUw4WDJDZjJHaVZINVRlY3QwOXdyNmU0d1l1TU9sMXZ4QSsv?=
 =?utf-8?B?eW5IbXAvdWNZbThnbkdPREZFUXFlUjh4cFk2TWprVjQvMm1lWkxpUHRiMXFC?=
 =?utf-8?B?b0FNekxmcDgwREdoMGdYTGJtWkp0Qk5GTmNheFlSeklZN0lTWjVKL3d6N2o2?=
 =?utf-8?B?dE5tL1Vyb01QOWtJZ2lHYkZTU2hxenYvUmo5N0RQQ1VTZ21sVTY5ejZhcTV2?=
 =?utf-8?B?QkRoQVBnaW5HdjdZbk14TmswYnFMYzBtTnRNbkR2Y2V3ZDNTcWNLR3ZKU0J2?=
 =?utf-8?B?WFlmNXd3dzhNWmZtam1DdTFXUTZDWDBNcGFoWDNlTS9ndTNmSlpYVDdxVmJl?=
 =?utf-8?B?MnA5dUgvQUM3bm03ZXVyRDh3WTNaOHllcE9aNjNYQTc0ZmlFck1JTCtOOEhR?=
 =?utf-8?B?UU1GRnRobGp5bnVlR3Z5d0dJVkltN2JJTVlMWUQxSzh4aWJEUHB4Z0EwYnRN?=
 =?utf-8?B?V1YrWEwwVkJQZVl2OUVkZFQ3a05hWGdnRVVYa3ZqTXBnd0ZBNXM5eFJRS0Yz?=
 =?utf-8?B?VlF5QVRDdjBmc3hkM3JNdGJaSTAwTGZmNkNyQThJSTA4enVTQlhyNWd6WEw1?=
 =?utf-8?B?ZSswWnNQdGZxWG45N2JFQjBvTmJxdVBYanVwZkxTVFlnUDRIUmt2bndhdGhz?=
 =?utf-8?B?MXN5elNBUG1KVzZsRDNkTEFWRmt0ZXV6VFJPM1ZRTWltVXRQRXAzcnZ6NmpP?=
 =?utf-8?B?WC9VenJaRVE5QnNZR1o2RnVZSThudTZ0R3pLVTVnY1NKZzB1eG1Za01BOW94?=
 =?utf-8?B?SkE1OXhpczZ0dm9YdFp5dUFxQXJaU1hWSmdySndWTmpGY3ZWV3Fqdk9UWXY1?=
 =?utf-8?B?Z0creERnQWc3RXFMaElaK243UzRKcUdNVEtYM2l6RFR1TGhQWTFYeXlqeXp2?=
 =?utf-8?B?WkExTzQzemVCOHBLS3k1MGtKdVVBOTR4WDRHWWxYYXpVOGg4cDF1T01JQ2Zi?=
 =?utf-8?B?TFM2aXdTU09vNjIrWDdDR0ttWTNDOU1XR0t0eTd0SmR0anMxVzVYUVFpQ3Vn?=
 =?utf-8?B?aGM5ejlZalcreUFJUEl5YUpPTFEwK01YSldHQlhveWx6dE5Na3lLeG95N2Zs?=
 =?utf-8?B?TlFyZklZTk92OUVTM3p2QTA2UDNGT2hDSmhtNXpHTkRYbFFlSnZ1WXpJMCtF?=
 =?utf-8?B?Tks0YjhtNFI5ZkVIWUZNZVE0OUdFWWVocUx2cWE4c3htZDB3M0N2ZG1vSXBr?=
 =?utf-8?B?RXA1UStWWWNEUlNtUDRSQ3k2TzNndWFaV2kzTmNRM2R0STM2aXpjbnFPVEhn?=
 =?utf-8?B?V2ZZUy9QdlhzK0lUTFVyMVJtbWdMK3liOTZvZFdoK3I1OG15S0pLb0lJN084?=
 =?utf-8?B?d2JRQmhkWEZtNnpRWm5aK1RlTzdYRWJVQWRsYWxxd3BmaGViVFFuQW9Qa09z?=
 =?utf-8?B?RjNzNFNxT1htaEoyZG5FTS9FU29PUS9YMTk0RTVHWjdlSkhZb2xvellySWt6?=
 =?utf-8?B?NEJzVHVPQVNUQmVDb3Z3T25WcmM1dDdlL28rR0pIcCtvb2dKVGRtSjhNcWF4?=
 =?utf-8?B?VlkyV2IxZ2NVMVc2NWpnUFkraVVDR3B2RHlZTFZpZUJMd2h3b1lGRnBIY1Jy?=
 =?utf-8?B?WjJMUzJnMTVCQkpEMEVjb0hDT3Foa1VGQ1hoOUtreUF0NFJOczBPK09SVnZv?=
 =?utf-8?B?NUs5T0RCQWlMUW9ZN1h5YXF0RnE3T0Z5ckdGbW9oRjllWHY5VGlpRStyMjQw?=
 =?utf-8?B?R2Q0TVJEbmhFVzdzQ2Vhbm5SZXRFRjEwZFpRV0k0dld0VlpScTNUNWFPblp0?=
 =?utf-8?B?bEFmT3BmckxoMklWdTdrVzQ3RHhna0pJcFVNVDI0UFJxRTJXVWMyQkxXR2w1?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8003749-dbc5-427d-415a-08ddad2c6539
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 23:20:34.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE1kzS/6wDwXNs1nn5LYd61PgeHDJmRLEpvRJ1gJPsy3YRr1ZiJOzdQTq6klPiGVd2Ktii0f1NttS2RI0Ksii6WSTf3eh3OtBLevwgymrTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9133
X-OriginatorOrg: intel.com



On 6/16/2025 3:41 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> Seems like there hasn't been any interest in this series? :(
> 
> So far it seems, but we have been in pre-release freeze for a few
> weeks combined with slower summer (in northern hemisphere anyway)
> season, so it might have just been a bad timing.

Oh true. I can resend once release freeze ends :)
