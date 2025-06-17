Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1553BBF2
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182810; cv=fail; b=RcVGXKkAT3bJtfC4DWMrhs9OfUfRgYw/ve+Q6TZF4Cp3zKmiPXgtgBWkOHrUzbyQQnN6B2tGjXCfeCHXkDT4Cbn0kADqcnmqRdVJiEV5XZJKMxqsl+I5SYl/j3Td8esQMobmIBqoymF8oUsKXvsK/O+C2NdNl35B2HlU7TF//kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182810; c=relaxed/simple;
	bh=/i54tE+yB3CIzjY7ER5qA3/ZDxXIl0NMNIx7bjcLS34=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LzFDJWJyzRwwu8ZoONukiLzG9KdB62tZ4LVG8fq8szsMLfZNXJnh+YE0b2LwP2+zcn3rJjMij/TJPbRuJatJnUpMJUFDL2d/O3s4SLTSn4pKMlK+inquP79UAs3uoM0OK6A4TEEioBD7byN10VPY8DJAY2kK2X2S78wgt06ncz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OU9X7NZx; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OU9X7NZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750182809; x=1781718809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/i54tE+yB3CIzjY7ER5qA3/ZDxXIl0NMNIx7bjcLS34=;
  b=OU9X7NZxcOiKjyseBQSO/7vxPKjXXJC200TXq800DTGnmYyULaQWavbt
   CekSGpU0HGI14FRCgTd84FNzOHYgfheuJcrWKWEiWlxikykKTepWJ15pA
   y295rHZWlmT352Rij23D9weO823PVlEKK3hUooZnT9QywckIbbayKLavt
   Y3/mbF2ni+dEz0HLNjTLJfQTCg9YVgcXZa2qqvVg5NLw4iY1EZ0HJAD5e
   I+1MLcLVAZEJviDCukTYzOUOa5cL2pC0Quc/fMinCitZqHd5rXJ1IXcUe
   iqlQ23Sgt9BEEQe7ioQax31HT1XsH+mFNpOQfcpGsVMjcSDZ5KSFN8nf0
   w==;
X-CSE-ConnectionGUID: ovALDX0NQaCsD1D4AocCkw==
X-CSE-MsgGUID: pAr541qNSmuMYeZ9+1h6Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="74912038"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="74912038"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:53:28 -0700
X-CSE-ConnectionGUID: oGiuCa/+T8KnXe657tAJwA==
X-CSE-MsgGUID: xLPsWluUTGSmcBm7VoLCIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="179749879"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:53:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 10:53:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 10:53:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 10:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm+9ENXcbT95xW5t7DK0UGtLXTDugv4kHFaFtYpYf3wdo/Zr2kNaJFT0UlABCqunwGJaZVhAJHN4TNb8qP4TqpTdGn0h7LY1iVCwryBYVUlOIiD/Hnk4PatQ9+/a44ss/ChQlFVUyZia2qdC81jOczTIlC0JCqZBi2jMzx54U5pT8m4i6P37FxFra+BA/AzhukizbRtq4kqTzD3Zv4ePYqNN/co45UQw2vEKRAPgp1QalHWZX9+qNk4rdP/nMTBFlFeYWHCAE5eDAOdFCsZXAVOUO60ZyhEnezQ40e2a45prkT3AVpTV5gOej5nSjMO+66kLcRZDezYZmhuwYQAnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Ao3NsWVevBkDIt0HMdZq9EVtT1XveB5iA/CPE0pW0=;
 b=XLKj/U2bV5qq0YwqyyFAQylrdYWvIfDyzJZnZyFMqiWAagIYzoi15n/i88tgtFoFg4RmK8UJ4rO7coMg0rQJRwh09eeFZDEkbmeP00OL0JGxGeF6amzWbIPjiyqZ47ryZaI5hotsYIkhkHlvWfUdDhztVEyl8eI3Z8F8fbTk0gEK0/Ru1OE4hr9fEvBzVaocxH5j5TSLyxAv1+rk1TjyKFX6vZsrnn7r4kr85jzM115yKRWTt8Wx4B9jnyqTf4uXBxRkg1vORuCXOkAfNkKu4oEP1aqs03H121UC9+uLFkcujFympqcqzIxvQaGfCW8nPOGYhETqPNHx2wVkGFo+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 17:53:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 17:53:11 +0000
Message-ID: <974293a0-6f5f-4077-9977-84c07fe431ca@intel.com>
Date: Tue, 17 Jun 2025 10:53:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] submodule--helper: improve logic for fallback remote
 name
To: Lidong Yan <yldhome2d2@gmail.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Junio C
 Hamano" <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
 <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
 <90B8957C-9469-4D46-9026-46407AD2EC1B@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <90B8957C-9469-4D46-9026-46407AD2EC1B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: c6986a3c-80f5-4b55-7285-08ddadc7d360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEdXdGV1UVZlckVIMmNKQXRtVHpSc0dXNDdIL0ZORktMeEduK3lsRzlKOWZk?=
 =?utf-8?B?SWUzbUdkcnkyTkM1NnhnaU9CTC9QdWVqOGZuVFlyYmlydWhWQjgxTmpXQkEy?=
 =?utf-8?B?ZXhFeFdnU24vY04vb0czMDYranYwYWIzY3U3cFdFTitCNWpYbnRIa3d1cWUv?=
 =?utf-8?B?RzJNVXRtS29sLzNVVEFoekI2cHFpRDF6VVpVTXlCcjFZc29vUzhuTU5YUm9Z?=
 =?utf-8?B?SHJXRWN3YnFIRGhFamt3Skl0QnZJS0FOWmFZSFdUQzllVHdtNkszMkFTV0VL?=
 =?utf-8?B?NmgybFB1YThmK1pCQmxaUGsxQnBtTzJVb1Z5eG5LNFhpZzNYTWorOFBPRlhl?=
 =?utf-8?B?NVZoZjRTc3hyZFY5ZUhuZWcvUEZqdFBaMlZLY2hTcmZ1Q0toVGIwQ241bXN1?=
 =?utf-8?B?L1N5d21ETjlpVmhyZ2VZczF1KzJweGo2Rm9sRWlPQnFhVDFwUE54WHhxZjV6?=
 =?utf-8?B?YWlWRzBOc1BON2Q3eXFnd3RYZlZoSEFvdXg5S1lvQWhFc3NJSUo2OGs2MmlE?=
 =?utf-8?B?QzF0QkN5VTdZSkJGNFVSYXd0c3YydXRSRUR2cktZbnlhbVdZK1YyaVZMaENk?=
 =?utf-8?B?ajJySzJIMVIydmtOcWdZbkZEcEhrTlNLaFRHR3I5aXM0YVNzOHlRaXVrelJE?=
 =?utf-8?B?ZUdLSG1CT244OXRiRG81WVFHUHJrN0dIdE41L2tUOXZVbFhPVTlIMnhLZ3lY?=
 =?utf-8?B?dVVJaTYreXE2eTRRZy9aMUltenp4MVBIU1Bra3YzOVFHMzJrYmNaVW1Ld0dH?=
 =?utf-8?B?TXZyd1RtQkI2YUljZ2NWVzFQU2tXb0pGWGFqeFk0Q0FRcFMyRHlmbHZjMlpB?=
 =?utf-8?B?V0MxeUV0b3RHZm5STUhSRXNPaFJOaHBaQWpyS0UyVDJGT3NxYXBnbmpXWm1V?=
 =?utf-8?B?NDNwMmFUMGpNQU0vSElsQTQ3QTEwQXh0WEUxQjF3aHdZUkEvaDgvekU3QTBJ?=
 =?utf-8?B?amt4Ym15S3QyT1RJblZMVG5JMkJnVHhHZ3F4S3ltSllZanpweTA5SjQwdjEv?=
 =?utf-8?B?bVVvS2J6UENjMnlsdTRzNm9QaG5tclVnS1I0djcrWVNPYVF5MzYwS2MvY2ph?=
 =?utf-8?B?am1sWGJEUkQyV1A5bEhmblp0SjRFWDRvS0o4NytJdnNJVWwwMDRvQytGbjdk?=
 =?utf-8?B?a213ekpXd3M2U2FMdkFzK3liQktLeWlhUlQ1YmtNa0VEeFZ0aTdKNWFCbUdt?=
 =?utf-8?B?aVdLYlJRQ1RCSEJnUmJNSHhBWFRXNmUxbzlYYWRrQTFJK1UwL3lGdXYyN25h?=
 =?utf-8?B?QmpYOEdyejZlb3FBbHdHaisxY1pZMWVMTnJVMU9LMzRUUkpTdDFjNVdsNk5y?=
 =?utf-8?B?K3VSU1dFcUo4OFQ1REZKSGJQcjAvSzMvWDZPOE9qN3FwcG5heHVyT3FISjEz?=
 =?utf-8?B?SUpaWXZHQTVtbkM4cUlQdWZLQmVrQmxyc0lCcjFZT3U4Qk5HQU5pSitrV0Qw?=
 =?utf-8?B?Ymg4UHV4MXJXSmZpdkNtaE45QlBJN1BzVWpQOGREd0dHb3hlaWRKQi9VSlpk?=
 =?utf-8?B?K1pQdmxScXpsN0ppRXhWUmNXRHJOcVI5WTJXR1k4ME1UK0Fsa2JOV0wzaFF3?=
 =?utf-8?B?UFBxOGRkZ1A1dStsbjhJOEw5NTlaK0MrUWJtbGMvdGNzNjJiTnpnMXR5NFd6?=
 =?utf-8?B?MUVaVmFjeDh2VGZzOWhkMFQzVFpoY05EbGNqOCtLdU43WGtqVE92YmlUOHdn?=
 =?utf-8?B?N1lGK0tvTmRUbTlqVkpIL1k1QmROdytEVXBKNHFKZ21kNzNmcjB5TFpNUTR0?=
 =?utf-8?B?YmxMa0F1SHdNaUZlRkJERmR0SGIvUUxPc1hSSFlkVDduc1ZhN2RCQ2dXWGlX?=
 =?utf-8?B?MTg1U2NtOHJVMTg0TjVRVDkxaTUxSVhiQnJCdnBBaFoxQlhHTFFlUTJIa3BN?=
 =?utf-8?B?MVoxN2JMMG9mWDRJSldEcXlvRlAreFVWcDVTNW1ITVhUR1ErV3V2QnkvZVhD?=
 =?utf-8?Q?lsNRr4yjr4k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uko4aHE2TjlESm9RMHhPMTVWcjh3RHVxVnRhNStIRVd4UFljWmtBUXVReHRZ?=
 =?utf-8?B?MkEzYUkydVhmQnorTmh0dzZ0VEhXNG01cW5xNHFreFZVM3I0V1UrTFdnSS9s?=
 =?utf-8?B?R0xSL1IzNTZUcG5hRU8wTjBIWjZpcnVRdUo1anRoV0xSVXJsRDRCOHd0MU1j?=
 =?utf-8?B?MG5xaGxJRTRFcnQxWDhsTElOd0xBYnR2UXJjemtIaVBMUEFKeldCQ3czd3pv?=
 =?utf-8?B?L1dXMTNwTTdlcVNSREpUL1QwOUw1MWVGZERWQ1lwelY3a1AvVW1ZSlFDMUhn?=
 =?utf-8?B?OE9INEJ2c29oSms4QXY0ZkJhYUhiT2xhMDJSYUJjTEJuRnN0MG5PRStTWVZO?=
 =?utf-8?B?bzdTZHd3UkRNS1ZISjZEeWZ1KzE5dmVic2pGYWMxVEJpK3JJRUlobk5WK2ZB?=
 =?utf-8?B?Q1krM1ZKN24zSXdsVkxoVC82aU1oUFN4RDAwNEtkOElQdG5zeUoyTmh5OEw2?=
 =?utf-8?B?WmNPOVhXWlpsVUw1b1ljdHFhaUZmeFE4ck1nOWpwVElqckFacTB1a1dwLzJC?=
 =?utf-8?B?bEZta2wxc29WYXZqU0VYMkNkZWVqS0hKaExFdzJrd0RRNmQycG9FUVdWV0Nn?=
 =?utf-8?B?bktRemEwSUpIQ0R2OXVqcktnUHhnS2xtdTZzWWZXbEMxSkkxVVJxL1E2RlNz?=
 =?utf-8?B?YUhnVHJvbXkvTzlWZjluays1clg0Zmw0QURTWUYxYm93T01CN1AyVmx3SitO?=
 =?utf-8?B?UllManpYdlE3aE9LNTdnZmFWMnYyT1MxVUlMcnVxdER5K2dkZ05ha3B2UXBX?=
 =?utf-8?B?dmdUTm4wT3pnMVlHOE1iR3hPcytwendpRWZCMGpsZ291Nmc1ZGsxVTZhRnNx?=
 =?utf-8?B?dHM3SnJCcFR4TjQweFA5bGJNc1MxWGNMTk53cGFiMjZxaWE4VE4wdGg1VjNC?=
 =?utf-8?B?bkpvNEJna2h4WkcrbGJSVGNPWTFlZWo5dXp5SW5UVGwveGxZZmlPTnFPcC9H?=
 =?utf-8?B?Y3Q0MWZaS2wvRHNEc0kvdnFtRENZdlFSWDRtWTRSaEdKQkxzeTRRbjNHcnl1?=
 =?utf-8?B?bk02cUtTcnBhMENaYW1aT0JXRk1NSDVzYkJWVXZKdjBnczJadjFpSUZCTEZY?=
 =?utf-8?B?U3c5OE04NGFaT2xDbzk3THpqWm5sWlV5OEJHOWU5dTdZdjJ1RkI3NGZZN1pN?=
 =?utf-8?B?WGJacU1pMlVkWXUrcGtScG9BQlU4L2lFQWkwNDJ2eXpBUElkQXl1aXFNVTVx?=
 =?utf-8?B?S1FESHRXNFpCbCtKTkVTbzB4YmdFYnV3QkNzYXF4TjBUbW0xRnZyT0VoN29N?=
 =?utf-8?B?MksyaDFZdlJiRFFNdlRKazNyUjZKK214WnVQOTU1NG0vRTNSOXVxMnhJcENh?=
 =?utf-8?B?d0JDakdPVERIUUR3YmYycUN2cXdrR3hhNGRWZm1LTnNFTzMwdEJlMFFLVnpo?=
 =?utf-8?B?RklYekVZbStVdjF6OTVFeDBuMDJsMklIemNXN0pmSTFFOGUzWkttSTcrMDJO?=
 =?utf-8?B?bFV4anFBTE5UT3doV1BhNFBuTFdVQmI0VzZ5Q1k0UVNFSjRvRGR4VHEwUjFT?=
 =?utf-8?B?aUxIeUpMMy9hN1dpSUlKcmFwWkFPZW9zTnJtb3JpcDloN01TUXUxeStubkdB?=
 =?utf-8?B?eE1iT012QnlPeVhvUEQ1UzRUU0lsM3RRYzdad2RoM0hGTkJmdmlPRkZySFlp?=
 =?utf-8?B?ZWFScjllamFPVStmcnNLOXBteVBBY1U3Wi9vS2VEZnQzaU1JVXkxdmJTQjdr?=
 =?utf-8?B?aHo3V3p2U1RvODQ4eEZqUXJFU3pMTGRWSHFCY1VmSVBEckVTWnczK0c3cHV3?=
 =?utf-8?B?cDRsb3g2RzlYSW0xbUl2a3NKWG1RZlVaNTdjNnlWMDVIUzRLQUpkZXJ6UlA0?=
 =?utf-8?B?enJpU1pPMUxOR2F0dXV6YjBvbnU3WHNkK011ZE55OThGbFNKVjNDYUpPM1o5?=
 =?utf-8?B?eE5LV1lyRnBYbnBxL3plaCtTMmtGd3dKYUZDMldJZWxOSVh1M1owZC9VWS9J?=
 =?utf-8?B?SFhwSHZPbVVhdk85djRqM2ZxWGx3WVZjdGVrcjMyRXB1MzZDYTJhOUxPMy9U?=
 =?utf-8?B?dElndWRMdUhPVldNY0p0RGxwQTdNVmJSZnNCU29CbTJ2WDlCNFVocDA5eVp4?=
 =?utf-8?B?Z2FBTkhmYnBQSnFyS3VHMENnaGJHRVNWNWwzdU9iSWFHZHZ3Z0FGM09YM0Nw?=
 =?utf-8?B?eW1TeWlzOWRjUm0zVVFzODE1UHZMcmdMdDRxV1BPSnhEZGJUMllBbHdnSUVy?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6986a3c-80f5-4b55-7285-08ddadc7d360
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:53:11.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZjZQfFWLbDtHRyb2qQQw6vx9YbOSG6Et2crTAQVEEDzHgB8E1/s77/RcTBE6tqxAhV8vNgCo+TUIqTcrbDMOYMCcGlXAsvy0LdoOTRDicc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com



On 6/16/2025 7:58 PM, Lidong Yan wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes：
>>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The repo_get_default_remote() function in submodule--helper currently
>> tries to figure out the proper remote name to use for a submodule based
>> on a few factors.
>>
>> First, it tries to find the remote for the currently checked out branch.
>> This works if the submodule is configured to checkout to a branch
>> instead of a detached HEAD state.
>>
>> In the detached HEAD state, the code calls back to using "origin", on
>> the assumption that this is the default remote name. Some users may
>> change this, such as by setting clone.defaultRemoteName, or by changing
>> the remote name manually within the submodule repository.
>>
>> As a first step to improving this situation, refactor to reuse the logic
>> from remotes_remote_for_branch(). This function uses the remote from the
>> branch if it has one. If it doesn't then it checks to see if there is
>> exactly one remote. It uses this remote first before attempting to fall
>> back to "origin".
>>
>> To allow using this helper function, introduce a repo_default_remote()
>> helper to remote.c which takes a repository structure. This helper will
>> load the remote configuration and get the "HEAD" branch. Then it will
>> call remotes_remote_for_branch to find the default remote.
> 
> Just a thought: since repo_default_remote() is only used within
> repo_get_default_remote(), and the two have very similar names,
> do you think it might be clearer to inline the former into the latter?
> 
Probably, but I can't inline it within submodule--helper.c because it
needs access to static functions in remote.c which I don't think make
sense to export.

I could also either move repo_get_default_remote() from
submodule--helper.c into remote.c, or try to eliminate it entirely.

My original thought was that it does some submodule-specific checks
which I don't want to remove but which don't seem to make sense
in-context with how the other remote.c helpers were implemented. Thus,
it didn't make sense to move it into remote.c, but I can't put
repo_default_remote() contents into submodule--helper.c without exposing
the read_config() and other static functions in remote.c

I'll think about this while resolving the memory issues and working on
the next version.
