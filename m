Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90B1FF5E3
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743887; cv=fail; b=YC0tIVZVyPfszlEfo9Rl7oeElyp4z4r++M5X42sN2fanVxbgEsUZjNLwXLCxOfNuEsBGCBxT8lVzIgr9pEEp4ju772U6XHCzu4nWY9BsEiab4BtxIh5toNt0h6gMQENWKEoOtwPu8igylGUuxkR2oRyFzwQpYT6+k0CRhYN1Abg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743887; c=relaxed/simple;
	bh=UobW7uEsFT8PWJYcJvH80Loh6zMkGHyUDCjLj/ezHf4=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=bbVZ76miXAkOFKMHAdoFrDgZizUKGHi53ba2m+YEOIfaTr3/q8mJKY2hqoNBw74vmPyUe9stDgZCo91SsasJsrZHvkaYi0Pqs1EMVPtMSVM8TF43p9du73syHo2lizvXEfGgoGlDLpTjriTpdCqeSZBnL33XqlW69ggeg7BfLD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0Bu/Wvy; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0Bu/Wvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772743886; x=1804279886;
  h=message-id:date:from:to:subject:
   content-transfer-encoding:mime-version;
  bh=UobW7uEsFT8PWJYcJvH80Loh6zMkGHyUDCjLj/ezHf4=;
  b=K0Bu/WvyQ+npCmhhp+0FBfl0CWf/jJsQfjv1U7fErcwlG0PAIuLZbjF2
   +aVXhB8ToRKeflYJMBYB/MBeijXVQkWKJmbu6qTO5lyKycKMw1dM1fnQg
   oKbBT3gWriF6Gpe07KVMr5/BONa6X7NnBPNYCEUuS7irMA+OeFKxHsqOF
   5SyA+VLqJ2HLQhNdSIfiO13/8Vn/lUSq/8vSaw+Cyq3ZISUhGDdZRA4lp
   lL+GlHwestucWt3jMTA4SGGTJAUgBUyRky6RjczkXrE2e4RRaoGhNJluc
   RgDOkqah/JdM0zFM02E4GZVT8UeHWDHNGe3+dsnsFJiptuIJBtx0QANJX
   Q==;
X-CSE-ConnectionGUID: 9G0LL9O+TdySF+2cTSCizQ==
X-CSE-MsgGUID: NVsVxtXKSCGs/LHJ35jNzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84928640"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="84928640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 12:51:25 -0800
X-CSE-ConnectionGUID: RGFiU7UMT9y9QvuyC6wVRg==
X-CSE-MsgGUID: 7BlCHzm2QwKS70exsE2C/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="215985095"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 12:51:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 12:51:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 12:51:24 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 12:51:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp4Gtr1304xFXOqt6Hj4s0G0AMjAzR2GduLhRwcuM2bzEc8UXqOn+lnCTThoaREM0PAYodXAxdyLqVKg6uTvBn+WvpAg/hvnfUW3GicKazfNyOY7GRn4D10Jy09T8BuX40msELfkBI0UQJbTIIsRtp4jCFwr5liEPPtOVemzW1gCVAsf+fnQ/9AU2ozJ/uHzTh4bVh+aDRpcu+e8+XC3QrRnjBXdCcgXv1oBnGNHMiWuF7FcNOfQr1mcI1vqwzpWG7sPl3C0cNk1+S2ARc1B3cutuBWLxwZ9VN6M74NrRRFOI92kuT5tRoKudK+CaaaZ4DVf9RmBrfU8DBnVd3zPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bQBvvhG+w78e8QB+mBAiCdYZ4w69maGueUHM9WJhc0=;
 b=eO++iOuriexYpdZl+pBOnBgqjnlCo4n05IA8Kp4CUJiy1jp0ed46BUufZ6VwDoFHC1ew0PqUG1TESSFRdBZyinpC81DHeyur8o6n1idqkV+3rd9o+tBk0bw2IG+Q5wfsm02U+weRxjzhjA3WFixyOU3Gn1wJaFtao1ay+lGlqFgorjhShdyXB9PvviRUgXykxl0XiP6XclftEg2QHYFOds9Pt/l/C7DjBwklHR2bUGsmdXIiYf96wiLGF1skuqVsLexydE+reKYrWQXM9Gdx0YBz+QVgXyufIkJdWelhG2pF0bdTq/jnP8/1xODtCoCsUne1dl+gOKaAZjNnf6xa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 20:51:20 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 20:51:20 +0000
Message-ID: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
Date: Thu, 5 Mar 2026 12:51:17 -0800
User-Agent: Mozilla Thunderbird
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
To: <git@vger.kernel.org>
Subject: memory leak when cloning a repository
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH0PR11MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: d867483c-4f52-46b3-5797-08de7af8f440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: JhW9maqgFDzMD49KzB1A4MbCiP4iAELw6jx4n5N7uJ5EWc9ZsT5gg9CDf6lty6+erDqF53vO4rLPMcsdMR20PSLfDtD6IzmvYl62umYrdmriBJYPgNlKrohIjPiaKHOCXDp9KaCkqawcGaPwZAKAfKPGny1YSBqwrOAFHVb3yq0HejB5YKqHTnutQYkyVdwTLrmd4LDc/sw3IcBaASG7oHrOKOD9MOxyawLtrD6Ava7/y+FaJJmgpzMD4EVMNKbaPXYUXesM+9Nxs2uJjhBGzMSqoPfV6lQARJau6lPqwMNjRVMxhR0LsJf4xD+Xjm9PV92NHg8U0tJtciF32hz7VoeC3AGdxb0LWArBtBMPK1u3cQoXxcqIDW9qvqG6I4Tc298yho4YR68HUF9m6sSEf+XLg+BOTUxsLpZXxmR5NZcxJ+PVUpQaqgMC0BbcRJ3fIVBP9zfXqNqq3SlK474SS7VIo6FHYJJBFU/g4gouuLgqTt1PY93bV/P3J1qBGZevnr54tAdxpmAPOymqA9/0EqAwncxn6Kg6nMvrjCWzaCnguTsoysJgyzbQj6qwL1P5DmmJlPa5Y4DzxCiXUiQmKAUkxptbLX0O9Ph3+vkQw9DHGEr0E/Fjjx7dsGfaxdt1Ajf0CPwd7LMB9bnwXMkS0UGCEBmt3pM/4TxFi0+PYqmR2pevNc47Q8rMFQQJS+Gt9JGKe+uM7FekS62qICn+5k/bZzmoYLp5hW2rCJg+c64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFNSenZSRHJ1aDloUTRkUjJsOTFPdGZuK2pET2lKSnpDdVhCM2tPWmlBQjBr?=
 =?utf-8?B?a2g0NVhVeXY3VHY3ZEVpTmRBNkRvQ1A4cGc0RVFjWXpQMU00ZVAyN1BHcjZW?=
 =?utf-8?B?cFpJREtuSE90elNBaUVPSjNFVkE5UlRlSCtLdWtNNCszdzVSOUhSbDZFMVQ2?=
 =?utf-8?B?cWFESXZGa0NGVWNaamZhRTh0QXIwOFJyNFZGYzN5bWdQallEQ3RPeXlLYzk3?=
 =?utf-8?B?MmgxZjNsVE0wSnRsUUE0SjJSR3FIbUdPa0RSYTFwd21oL3MxM2hrRFV4cVdJ?=
 =?utf-8?B?endsaEZsLzJRTTJXSlFGK1hOWlkwb29Na2RqeXA0dWthV2dxRkgxVGpINFFY?=
 =?utf-8?B?bzRteHY1U3BjYTk3NlkzbEV5MUZ5TS9YMW1RdWVJOHRDOW45cmptN2RsSjQ2?=
 =?utf-8?B?amdEQXRXSlNlaE1vUmJjWUxlUG9vMytEWE1mWERNSE44eEZoY2JmV3lNcFJw?=
 =?utf-8?B?YVNKb1l5YUs2NG5SZDc4MDF6MEF1bGc4VFRDK1A5T1o4ZEtwY0tNU0QxZVE4?=
 =?utf-8?B?dXZDbWNkd3U0cXE5a1RQUTB1RGtaWTZIYkVsYmVBVTRUUEIzQnNSUk5FYlJ2?=
 =?utf-8?B?cWFpQmhLallBclEvS3hmK2xGaDBvRDIvUjJnNGJleWZoemhIY2Z4aDNTUWVp?=
 =?utf-8?B?bHVRSEdLcWJWN0ZPaGdUcnYzSll2cHZuR1E1TzhIZHQvaXA1NlI4UkxxRlVJ?=
 =?utf-8?B?Vzc5a1dlV1RWZmlsSkhBMDJNUEp3eHU5NmpNcHBsUjMvUWtOZkxQcmZRNFhu?=
 =?utf-8?B?T1l3Y2VhaVhmSDltczdnQytzT01zdFNkNDdMWVhrWEk3eFIwWE1memU3ZExP?=
 =?utf-8?B?UkJYdlRuSlhwcGhDdFdpUGN2a1lnQ1dPSmNPdVF2azE4NlgwSVp5bGcyd09s?=
 =?utf-8?B?UmlZZEZGYUEvaHYzZmlFbHpCVEo3dUM2bFl4RVVSSmFDRTlQUnpWQ1I5NHJl?=
 =?utf-8?B?cnc5SC8yVGZJUG5nNUtJZUo1MDF4TVVmYk91U1hBRGkyeFBUQkRrbnNkbnJz?=
 =?utf-8?B?eHZsMTJJVUZucnhyQnNIQWZEb2VZbWgvSlErN250bC9EaDRIaFF2dFZQS3Y4?=
 =?utf-8?B?WjZwc0xSM29JYkFjalhUQmY0YTRUWkZJK1luR2JJZXBJZFdyZi9DM2tLNDZ1?=
 =?utf-8?B?TDNsV1VYVWp4V0xDTnBrNFRrOVhXYTVoRzl0b212YU1zQjRxc3paVGQ2b3o3?=
 =?utf-8?B?bGJrcWhiNWlXd0luL25tZTc1T1VHL0hLUHlzcGhXZHp2Q1NVRm1sa1gyV1J0?=
 =?utf-8?B?b1FsSWhqZTZrdmxsMGlBRk9ZdGp5ajZ0NitObTBESFpGZFBnRm1UeWxZc0wx?=
 =?utf-8?B?MnIramRsK25jUzB4eHg3QmpRS3htNTFuSkM2Vi9tL3ZCMzFCVEp3OWxSVThr?=
 =?utf-8?B?c0UvUENVSEg5VmZlS0ltVnlsaE83azFWREgyV2lwWDh0NExZSHNiSzFWQThz?=
 =?utf-8?B?dmVWUzh1ZTJSYlpra0RzYkNvS0lwNHBzNWZyUFFxc3FQZ0RuNXR6d1NLYmZG?=
 =?utf-8?B?Q3NVMzlDK2t6VnQ1Y2MycEZ1TStyZGpkNG45VVBCQU1yeWtCZHFJOEtGdFBQ?=
 =?utf-8?B?bXFpN09QV1Fla1psZDFtejZjMVFGOGdOeVdmS2hkZEgwcWJwRkdhVlhZK3d4?=
 =?utf-8?B?T09qOGxYTHVmYThJcGE0MTk4UXN2ZGNwMDNUdWdwcmFBTElRYkJFM2RERzFG?=
 =?utf-8?B?MzcvUlQ4ckl4NzkzSTBFQ2I2RmY5T3NIbFZpZERKK1huMGhZRWlSdFpTSW1n?=
 =?utf-8?B?Rmh3c0dpY1BYOW5Fc0QvZTk4b04wYkxPQ2hvWTlsZ1VhbEpobHBIRi8xMEhN?=
 =?utf-8?B?Wk9Jc1h2M1p5b1NZYlh0aytaNjZJcDdteTNhMGhwdGRYYkJkdGxkVE9VRjdi?=
 =?utf-8?B?dWIzT0hLaWl2aVNVaEFoWUE2LzJWbUR3SEo1WUxtdjh1ejYraTJqc3VoWmZt?=
 =?utf-8?B?akZGNmxJekVUcTBaOEUzQ2M5RmQ0TkQzazh5bmFpVnpqSGxveHNiaThSRjhL?=
 =?utf-8?B?RGkxUzBEQm52c2pxa3hXT1ZRMlR0R0RnN1ZabThITkNOTm1EWS9lQ3JBOWFU?=
 =?utf-8?B?R1F6dFVUVzFhcWc1TzhkeFVDUEt3TTBPVTF4NmtwMjVDejRJWWhwbGxEOGRY?=
 =?utf-8?B?amV1U1hidXZ3NUoxcTB3YjVGUWFKWXBUdHoyek9hUCtSRUl6TnFJQWQ2dkdu?=
 =?utf-8?B?bVZkZHNJTEJrNVlpRXBQaWhhY3g5N2FXOTQvSGh3ZWpqWElIWVJla29TeUlt?=
 =?utf-8?B?Rkd2SGEzbUVQUjExRUs0UFJUWmNEUWNEZUhCcWxHQVVza3UyaE14SllyZGc2?=
 =?utf-8?B?c1JYSWZWZGw5ZEJ3Zm5vL1R1N3ZqVGdVaDhPTHZ3QXRacFFzeVdLNy96bWZh?=
 =?utf-8?Q?fBFeqUTibn1EUUoU=3D?=
X-Exchange-RoutingPolicyChecked: BTukKwUWFPRX9bXtnJbuWEq0C4yzL/pGC19Ny8/RCVbZ8IaEdjAVPnuGfayRCubC/z5kH8P5nyAOyhZo8JRvCIsCkIJUT86leFYIjweuiR8JEt0VCjjeRSVPQ5nd0PYN2OutpqX/vjy//gAMEK+PPdc36YCHxmN61oyEyBoxOCqmz213NkZjMjxvcmI36+tNskcmct54v3meKatPvtFbQl7p4ER9EsVDnVKrGKulM8uXu4aYVFDusQilu4yFnnV+dL+qwVhUY1oOX4QtDypOIIEoJMNGJtiQdkiI0jF+D19IGSCd6pXqs9SfKah1RPBEc/9De3uRem4eEJo4TvUyBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d867483c-4f52-46b3-5797-08de7af8f440
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 20:51:20.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKAVlev3bSPQj4tMPNJ01O7OC9PMO40zrGOdkxHLxhMYlDLywhWDuWk1YRMa+tWs6k/PUrCO9I7xykh4ngCNEusiHbGWFkYSpmLSqyqsx78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com

Hi,

I recently ran into a memory leak that appears consistently when I clone
a repository:

=================================================================
==581989==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 27168 byte(s) in 1 object(s) allocated from:
    #0 0x7f0e100e6f2b in malloc (/lib64/libasan.so.8+0xe6f2b) (BuildId: 25975f766867e9e604dc5a71a8befeaed3301942)
    #1 0x00000122ab77 in git_mmap ../compat/mmap.c:15
    #2 0x000001169466 in xmmap_gently ../wrapper.c:884
    #3 0x00000116959b in xmmap ../wrapper.c:907
    #4 0x000000d168fd in check_packed_git_idx ../packfile.c:179
    #5 0x000000d16cce in open_pack_index ../packfile.c:282
    #6 0x000000d25273 in find_pack_entry_one ../packfile.c:2078
    #7 0x00000099f969 in check_connected ../connected.c:148
    #8 0x0000004dabdb in update_remote_refs ../builtin/clone.c:550
    #9 0x0000004dabdb in cmd_clone ../builtin/clone.c:1602
    #10 0x00000080a9b4 in run_builtin ../git.c:506
    #11 0x00000080a9b4 in handle_builtin ../git.c:780
    #12 0x000000810727 in run_argv ../git.c:863
    #13 0x000000810727 in cmd_main ../git.c:985
    #14 0x000000449e6f in main ../common-main.c:9
    #15 0x7f0e0f6105b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4) (BuildId: ff0267465bc3d76e21003b3bc5598fd5ee63e261)
    #16 0x7f0e0f610667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667) (BuildId: ff0267465bc3d76e21003b3bc5598fd5ee63e261)
    #17 0x00000044c264 in _start (/home/jekeller/libexec/git-core/git+0x44c264) (BuildId: f75e04052d9435ea15ebf4480b490fe2eb150d92)

SUMMARY: AddressSanitizer: 27168 byte(s) leaked in 1 allocation(s).

I tried digging into why this leak occurs but so far I don't have a good idea.

This happens when running on next: 7842e34a6654 ("Sync with 'master'")

Thanks,
Jake
