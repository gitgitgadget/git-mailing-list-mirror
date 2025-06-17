Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2C2F532C
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202726; cv=fail; b=joxqYNnsTU8tnR6HuoM4Ram8RgONeC0RRzXAUKyXbn5tGV4xxxxHvEU7xBeEj1I30iX4dukBuIGkrL7m3f+RNSVtKsFRVKnvrBDW995dTsqFb4BEToSVxjGYWrNrkJUjpoL0oDuhsxDT6Ntj+3osTrDkFd63g47641z2oIwHFAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202726; c=relaxed/simple;
	bh=4Z+a/RL6Vs2Abf+dsM6uXlThJ1E6U2jJTP7W72/zC2E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lorqT3RZrC7qtHvbdjxOTzoLrviRtgUmt+PO5StA4wmZoUoz5o4A0ASLcUpZ80aSJomp6ce/UqKgIV37iZUXlf/a+2GDglM0p/exylIYtSJqwg+w9iBtsGz/tmbqSinGeAT93XphN8fOE20MxOP0EVaA6t0lXf4OTacrcnLgkbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRwIIPYm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRwIIPYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750202724; x=1781738724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Z+a/RL6Vs2Abf+dsM6uXlThJ1E6U2jJTP7W72/zC2E=;
  b=jRwIIPYmw9DNzw0CDdyDms9gY4d9Z+IywmQvYDLZffrkOcRrjZY7NjTT
   8mK4oo3iZLc4cJIkxTNEaK/RpaoeERH+MctxqsWn/hlNz3/ITPXGroR5Q
   nkWHjE/SomtmUT/Eb9GG7gkIxU2dvarPuD4UFdGACP1nGuOjPQOyVqrZc
   pt6JsS5Oj4Mks3r6g+eU/YMkp6+zrDtXsGH288D+Ujz1/Hy1+GhqcHBld
   m3nEnvUcX58j/OGB94xB+25QDaMzSYqvZWNr6cc59Jp0KHJ8QeY+tOuDv
   Vdh50wGCXNqhZ8OV/Aq8ZfZertgbQBIeH2g7YD3sw5Qp7Htdn29ydviJs
   Q==;
X-CSE-ConnectionGUID: YzbW4/6BSnqCpyAgr7TuJQ==
X-CSE-MsgGUID: b/2zdGwTQS+GkatUlDf50Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63821912"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="63821912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:25:23 -0700
X-CSE-ConnectionGUID: pelW46P+RuCqPp+eMRxR6Q==
X-CSE-MsgGUID: 7s6rmgLWT0GJWXK6YaTUEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153715542"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:25:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:25:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 16:25:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUecJcuN6G5Pmd4nPIwvWxHt3IiFF9v6Uu5G/NPRmYtsYmWmzN3vwTGijJ3UfIobgOnUSPfr0R/+hi8a8YRmQGqP1SmcZSdLXvLi7wMoWueo/QSIus6AJgL179DmK0pO9f/aX7X8sekqABKMciqpPg++MsjqmFi2pZb/Pm6Vyu8XeFbCIbQuK9no25B+Xj/tr+SUwfyYlCjX2JbYjlaJ/AmwZ5VGr29l3vLjLrzSS4VqYPmMUjsHIxHrbCMVQS92XFCAPcPbm4cKDzP0YHA1nCggUiB/ZXZOfMpCMx6aXuKhUkNHvK+xbkn0kYA8JONlCmI6fXB40u/9pKwDnzOn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXOlsV75PyL5mlW/dHfN8m/ciShOoVWqwkNac2+b00U=;
 b=eX56D+0QpiknK7FBeiKEGvRozm/javcDws1FJ6o3KVyPi4tD7S88lExbigdUPstCuVKeaH0LT8Vptj8VjX1fQWy0H4z2YwEaFzQdejZojDCp//3i0+/X6k4rzu61uuj3yU4M8pnuLK3SgkYBLKLsYqwtLdyKg/r69ZPO9qruvKHtY52+WrtSnuXybj7/42XEmCgsmhM1b85nbC6DYw4HJZrf6n6l3pKGoxeXppDdbKTm1/ZLSl293wcawOJdruWrvUhEikKDAVw2Yr2QSDXGwXHXYg/9JcUPZ9vC1D4BRiyubMr11NsX9jxwXbsc/xdmhF/JUS4+ASlw4bwkqMPd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 23:25:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 23:25:18 +0000
Message-ID: <d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
Date: Tue, 17 Jun 2025 16:25:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and struct
 remote
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, Lidong Yan
	<yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
 <xmqqcyb2uhth.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqcyb2uhth.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bffbbd-98f3-44ca-dd88-08ddadf638a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk1TZjhlMEliRUg4NTFVOGtMSG03aEdVOTFoWjJOT2dOZ1lqZk5xUXMxOWtY?=
 =?utf-8?B?OVhxMGtBVmVyUGFqUUJML2xwN1FNNlVvTEVDVThHbWs1R0llZCtxZHVyWHpt?=
 =?utf-8?B?OWQ5TFpxcU9WZDVPTU5GZkQwNGxBcmtSNVZkaEhJRFlaSGVBejlnem51OTNa?=
 =?utf-8?B?dnVRQTRMbnVTTzJWNlpPQ0NEdXUwc0hZbEpDVWdReFJIUVBOUk9CMjhNb3RL?=
 =?utf-8?B?ejZvY3NWS0o4c2F3UHhpM3NLeHRrRjVFTWtvYm1yZ1djNVNZejRNaDBWYkE4?=
 =?utf-8?B?bjhHVE5aUkptOGFrc3hWUFJSNms3emJCSUIrU0ZFeHcyL3RtZnZnRExLcDFK?=
 =?utf-8?B?Y09UZXhhTmhVUTNSbCtaTE5IZnZWNGRJUDNjak9TVVdHRFY2cS9YV0pCNitj?=
 =?utf-8?B?RGtQNm41Z3VOa3NHa0ppdDNNditzamx5VFo2cUZtMnZYbEljSnVlRndxdisx?=
 =?utf-8?B?Qm5wZThrNW8zYXBjUEJ3M3lXMjN5a3FQNTZQdVFhZmEreG9hUVltZUNJQ3Zu?=
 =?utf-8?B?VkdCZ00rVFA1SVFRa0Fxa1g0cWV5L3Rudm1DdGN2VWVDMnNjUkZRenpBVmpm?=
 =?utf-8?B?djFsSlh3ZFR1c0xNMW1KQlJnVTlxOThhMSttcXhYWHlHd0hrZU81Z1daZUFu?=
 =?utf-8?B?NTBScVdpWFNaZ0szOXJ2WTN6M0NCbXpxVFZkQ2pjeGZxaUVSY3JGd0JJaWNu?=
 =?utf-8?B?TUZYK3FNU09iQm9aVjdWMHU0SmdLMk0yQ2lWMmdaY0EyMCs1SmpVZHpuODdC?=
 =?utf-8?B?TVp5d0JJNU4wQWRHRnhRZDJxS29DTUhZSzB5cEJmQlhtSVdsTkFoUmxMVmRZ?=
 =?utf-8?B?RkczTEMvOTZidXFrSnRnK3JCWG9PWU0xcHYrQUZ4KzVkZndMYlpLUzU4Wk1F?=
 =?utf-8?B?OHg1MEpvYWdzSCtFU1hUR2Fsdm5mbWlNL0JmVVAxTjVOTExtb3ZHVzkySUJ4?=
 =?utf-8?B?M2JGT1plMFhXZStDN1pnY1JQT3F1S21SRTZSeGJZUEwxNzRQQmhRRUZKTElp?=
 =?utf-8?B?MmtMWE1GVVpSaVkrZzlVeWFLL1BieUFkU0x6dEozVXBCV3UwQkxWbGhVdkwz?=
 =?utf-8?B?U0MwTi9JTmM0THFoN1NBK0NwQzduZTZBSHpyZjZQaDlTaHV1a2ZldTR5U0NY?=
 =?utf-8?B?STVKbHZsQlBZQ252bVdhQXA2M1M1YlJwNngzUVNGSXdmKyt3NEtGNDVBczVy?=
 =?utf-8?B?ZnNWZDJKOE5zd3hkeEZzWWRuNVBiN242QnlSV3RIMHRkaVdHQ09UVXcwc0s2?=
 =?utf-8?B?Z2RWb09icXYwMERyMjZFemZUVExsei9LczVyN2Nud2RtZWhxUzVYRUdVVmRE?=
 =?utf-8?B?ZzNoeStrMGNoOTdlcnpsQnMxUm1nd09kQ1VXTFVjTS8wV05DOWY5Rnl0ZC84?=
 =?utf-8?B?c2V3SDBLSzFsT2tpajhUc1ZVYkZrYU1CTFJUc1NFMzBpMnZpazFGYWJ1TG5P?=
 =?utf-8?B?R2U3MC9XNS9heExERkpQbzNwTlM3aFVjbHhwWlYrcHNWWXdBb1psQ3g4NmFB?=
 =?utf-8?B?eTczSC9mbHRGbjNkWG94SXF3MGtzaVRjaXd6amh1WXM0QWttVVB0Wk5EcDZ5?=
 =?utf-8?B?cGxnck9IaW9CN1dGbnpjZkswdVk1c0t3SFJKcTNwRCs3TWZCV2RVQVhZNng3?=
 =?utf-8?B?S2hSME9hbk5qdmRuVGdBQkRrdUs0YWVidFRmNmpueFlOMzIveDAwZjM4cG8z?=
 =?utf-8?B?QWtJY1dzK2FpMkExUC9CN3BBc0JsMW43U2hLeE1SS0h0TEIvYnJ6blF6bGVZ?=
 =?utf-8?B?TVVwVjNCUHpEUUxzTDJ2QmNrUUtoNmFaU2Yra1EyY1ZUa1FrTFA1QUhaajQx?=
 =?utf-8?B?d2RNQWZseDRaUTZjcVM3MENUYmRLbURmamVBOGRIdjV1WWlpbWJ1c3htZFJs?=
 =?utf-8?B?VnFGanlOYmE0TVladFJ3YmF4aWZYaDkxcHZxMmZkSFRtNUVreUVTMEp0a1U5?=
 =?utf-8?Q?jXlhDrLcdJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk1lcUhseTMxZkc0NWFGYkY0N2pYQnBEbDNYand0OHBKS0NjakVVWE9BZE4z?=
 =?utf-8?B?M0g2MTNqODFEaHdOcklRR0wyb2xMV2JFcDk0R2F0QXhIV2tQWHU5bTFyYXVR?=
 =?utf-8?B?R1ltMVJlU0RWMzVGTFNURVJSTlUydXhGT21jcHFHWUo5OWlsbmpTSHV0K1lo?=
 =?utf-8?B?NDFoOVdlSDhyWU9UTHkwU1I1RG9nb3QwRm5PTmRvckVpQjdMNFlVOHlha0lw?=
 =?utf-8?B?aXU4d3ZBZ2Fxb0htOW9HSkVOcGh1ZHlTZkluL2lETGEyY1h0c0hvMnczS214?=
 =?utf-8?B?NHlNRGRkcGxKTWM1K3RoTmZ6cWFHaEgwU2pIWkQrS0t2aitDc3NKTFJPbXZz?=
 =?utf-8?B?RFpLVlBxUkpVclh2c3NxT3M1VXVQaWRTQ1lldGMvd0w4T2J4dC9Mdk5iT2RB?=
 =?utf-8?B?YzB2OTNKblAzOUdLS1BubnQxS3Y3UDBjM3BMOWx4ZnRrbDk2YnBxdDY4bjZv?=
 =?utf-8?B?dnFrKzF2RjhVbGhkc2ttRzQ1NVk3bHJFYkFZaCtINEdlS0lmdXdoV2pvM3dV?=
 =?utf-8?B?bzN1VEJuVy9LRjJqbTIvbFBia0NTdndoZXpMeWRXZDU0a3c0clBTYkRJcWdw?=
 =?utf-8?B?OWpFWDNUQ2ZUUzdpZU15YmtCV2s4Skd4cmZqT3lmOUJYYmhabEZVaTEvN1By?=
 =?utf-8?B?YjhrSjY4bmNVdm5pZzdDeW9EcDlPMzhnZUVyWU9CMzBPTi9sQ1diaEk4Vjla?=
 =?utf-8?B?TXBWYWlqNFU0ZW9DdWRFL2hzRUlCRXprNGJxL2tHaHBnNVQ2a0J1M2xDZ0Yx?=
 =?utf-8?B?UXY3MWVnaHlWM2NqRXhmdzcrbEE5R1d5bWtrU1hXTDJZcUJwNERlZlN3c1NK?=
 =?utf-8?B?NkthVWtxT2ZRVzJvT3o0OXN4L1VDQm9Hd3FhSnF6a0lGK2hoa1djMDY4OHo1?=
 =?utf-8?B?aUw3cVlwYmt6QmcrdHQrMTZkWlVYQVp1U2RnUnAwSzlZNDg2cUNzei9rRlpx?=
 =?utf-8?B?QkNXT2RvV1NzcUxUTGxWUWZTRHpPZGpjTGNaVktCR1NuUEpXd3NnbEcrRDFo?=
 =?utf-8?B?T2hjQ1o1VFFXcS84R3JjMlZvdm4wcmxTRlZWK2FaaFA0eGRHbzQ4MEcwYlNh?=
 =?utf-8?B?cDluVVEzZkNxTkk1TTkwMU1MMGpYTlQ4NFpOUFpnYjBMb3FubDJZdU1GVjFj?=
 =?utf-8?B?bHRhQWlnSzgxcWhNRWZkRWl5VHE1S1pIa1B4VllNbURzL3cwT3FJcGt0OS9n?=
 =?utf-8?B?NERxK3hkVjB1KzFnZFMvMEc4STF6clNNM291Z2hOZVVnU2U1eTBBSTdvVnJJ?=
 =?utf-8?B?dTdZdGNxa0g4akEzVVJCMVFjRUdlMDArMnUxQlV6MWJzOEhiVkRucG83QjlQ?=
 =?utf-8?B?aXdoTVhSMzFiNEZwRE1kTzZkRE14c2ZCTnVVMFZXdHlidnVVcnQ3R1V5SUVl?=
 =?utf-8?B?MVJFNVlseFdvT29OY1NORUduMTMzT1VDQW1ldnpod2xBdVFVeDVJRXp0VkF0?=
 =?utf-8?B?a3Q3NWpoTVl1WDdjTEo2TUw3aC85bVdxS1g1dCtiTTlrNjNtT0Q5SlVWWWVZ?=
 =?utf-8?B?TnFkeThWaXp6MUhhU3NwM2FDNGxCc3FkdWFQQkFkMGxuMGZCMk43ZU1ndG1T?=
 =?utf-8?B?VnQ1SEVwallpcjJQU2FOY2w0Q3ZRdU53Qkl0R0NidXhpMDR5cTloWHg4aDJi?=
 =?utf-8?B?NUQxQ3NTekxUYmRWYTlmd3EwaitPL0l3ZVNOd0NPTFVjZk4vcGpIb1hwcmd3?=
 =?utf-8?B?Z05SclFtZDV4VTBJa0VmSDNucmpCNGxEK1JxZWNPVE5JbFBrWmxEYU9SbFUw?=
 =?utf-8?B?ZkFkQWI5SGE3WEJVVmY4YnEzWDJ4ajArWk01WXNqVTB5MEdyWmlkc0F2Uk5Z?=
 =?utf-8?B?ZEowc1NmOThjRnEzMG1peTI0dGRBUU5sMVV2TXlZSG9xbTl6ZlVwRUFqS3FJ?=
 =?utf-8?B?WWlnMEczbUpHc0RTekw3cW9GM2s2R0g4YTJXT0d5NmtIQ0Rya2svRmNJcXhm?=
 =?utf-8?B?czVvN3crSlRucXRHVHlaZmxqOXdSZEovK21lSE9WbUJPYzdFYWduT0dJRUpE?=
 =?utf-8?B?RmYvaDNiV3prZE9veDB3Zlc4UFovdUpXRCtHYUV4a05tVTYxdEVYbnkxeU1p?=
 =?utf-8?B?MlVtVCtkcGQwbnNiRDBnQThKVklDelVZaVN3d2c4a2xqRmJuZWhMT1lhQzI1?=
 =?utf-8?B?OTc5UWtQYndSZWVRMG9mU09LSWtvMnZlRXZrbXlwcmhXZVBicVRWZlZKb0dy?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bffbbd-98f3-44ca-dd88-08ddadf638a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:25:18.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLjwvVmhEoxMcapQ60zm6M5biYcb19lapV+wj/ArnhIUt+yr0HWadgW4/Li+IYS6tBqc2hJ3K8nEiWbqLttH1W2WOA6K/1BQcqvAFRh23fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com



On 6/17/2025 3:25 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The branch_release() and remote_clear() functions fail to completely
>> release all of the memory they point to. This results in leaked memory
>> if you read the configuration for an arbitrary repository and then
>> release that repository.
>>
>> This should be caught by the leak sanitizer. However, for callers which
>> use ``the_repository``, the values never go out of scope and the
>> sanitizer won't complain.
>>
>> A future change is going to add a caller of read_config() for a
>> submodule repository structure. Doing so reveals one immediate issue due
>> to a bad NULL pointer access, as well as the mentioned leaks.
>>
>>  * The branch->merge array is accessed without checking if its NULL.
>>    Since this array is only setup by calling set_merge, it may in fact
>>    not be initialized even though merge_nr is non-zero.
>>
>>  * The remote->push and remote->fetch refspecs are never cleared.
>>
>>  * The branch->merge_name array is never cleared.
>>
>>  * The individual elements of branch->merge are not released.
>>
>> Add a check against branch->merge before accessing it and calling
>> refspec_item_clear. Update remote_clear() with calls to refspec_clear()
>> for both the push and fetch refspecs. Add a release of the merge_name
>> items as well as a final release of the merge_name array.
>>
>> Freeing merge_name elements results in a warning because we discard the
>> const qualifier on the parameter name. These values come from a call to
>> add_merge() in handle_config(), which always copies the names with
>> xstrdup. This makes ownership of the memory difficult to track in the
>> code.
>>
>> Move the call to xstrdup inside add_merge() so that its clear that the
>> memory is duplicated here and must be released when the merge_name array
>> is released. Drop the const qualifier on the branch structure to allow
>> calling free without an explicit cast.
>>
>> These changes make it safe to call read_config() on a submodule
>> repository without crashing or leaking any of the memory when the
>> submodule repository is released.
>>
>> There is still some confusion with the difference between branch->merge
>> and branch->merge_name, and the confusion of using branch->merge_nr for
>> both. That could probably use some future cleanup.
> 
> 
> Nicely described.  One thing that puzzles me is this part:
> 
>> @@ -253,9 +256,16 @@ static void branch_release(struct branch *branch)
>>  	free((char *)branch->refname);
>>  	free(branch->remote_name);
>>  	free(branch->pushremote_name);
>> -	for (int i = 0; i < branch->merge_nr; i++)
>> -		refspec_item_clear(branch->merge[i]);
>> +	for (int i = 0; i < branch->merge_nr; i++) {
>> +		if (branch->merge) {
>> +			refspec_item_clear(branch->merge[i]);
>> +			free(branch->merge[i]);
>> +		}
>> +		if (branch->merge_name)
>> +			free(branch->merge_name[i]);
>> +	}
>>  	free(branch->merge);
>> +	free(branch->merge_name);
>>  }
> 
> where we iterate over branch->merge[] and branch->merge_name[]
> for branch->nr times and each time we check the NULL-ness of these
> two pointers.
> 
> merge_nr is only incremented inside add_merge() when merge_name[]
> array is grown by the same amount.  Do we need to check for the
> NULL-ness of branch->merge_name?
> 

Probably not.

> Near the beginning of set_merge() we allocate branch->merge[] 
> only when branch->merge_nr is non-zero (the assumption seems to be
> that we accumulate in the merge_names[] while reading the config,
> so as long as branch->merge is initialized properly to NULL, it will
> never be NULL if merge_nr is not 0, no?
> 

We initialize branch->merge with set_merge() which is called by
branch_get() and which is the only way for callers external to remote.c
of getting a branch structure.

The issue is that merge_nr can be non-zero because if no caller has done
a branch_get() on the given branch, we still have merge_nr is non-zero
and merge is NULL. I suspect you're right that merge_name will never be
NULL while merge_nr is non-zero.

Really, I think we should find a better way to handle this than having
two separate arrays which interact with merge_nr. I especially just
noticed that set_merge will assign merge_nr to 0 if remote_name is bad,
but it doesn't release the memory, so we'd leak on teardown in that case...

I wonder if it is possible to just get rid of merge_names entirely and
only have the merge array?

> Thanks.

