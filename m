Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0773341ADF
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971584; cv=fail; b=ecjMuNcxZwlR60LN3ctxrRWg5VeBxdC07F8MU2aWcxB8h6j8WytKRwRQMgdHPS012O8woNKYMGTQZ+MRV4BhFoL0GRpgF1RMfua5hz15TPSr9G9WF+j7A1CV9X2Nf8YHC9sxUYgg2w2JqbDAcAM2jRVV3yfmQQJJX6n1uprd+rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971584; c=relaxed/simple;
	bh=2li8+b1e+Vj5n+U7M0rnhCizLFH5qEhi9B4t5mxfNLU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wfc/NWtrC5IO5oVie8wFibssaAHso0bkcMZo7UcsOS/NgYS8XUKQ6HSnFigCJcoHLhnUwZ/rCNhrQXXFCGT5iaSVC4vuarVqDI7UuEwJuUN1pE55fl485/IuH8Nz0QM10p7IQMYrMeYQKqxE9xbl/jPNwJyokwbKa8b0ZwWPlIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZLLh6r+; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZLLh6r+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771971582; x=1803507582;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2li8+b1e+Vj5n+U7M0rnhCizLFH5qEhi9B4t5mxfNLU=;
  b=IZLLh6r+heLbZXefNGgoIuhuhzuvxStM6PFFSpQZRI7nQlYTa5/CzeU+
   AxiZdQrsJx6KBZ5GywZ9CvP96huGSjuBWRkRPfNeXrFnlFxMnFUBv5vDw
   dS2AHpUsK7tgQj1D/an7riU5b7gGpD2bECu2yYvqf8keALaQV0DhVJ2Ys
   NzRrP9wua/1MPCXs9anlDHPetsGvwe//P78yIRhY79B2/ykWI/f7o/51k
   j70QBF68AOfAJtSbw4xyD9pGiR+ymVLVN0O/hOinIpaH9Bo8G86zVni2V
   xUA1SvvFnBNsJ8kZoVaJ8o7W94BTyJVYHJNtP0De68zPimemrDID6b9xn
   w==;
X-CSE-ConnectionGUID: Dp3m4q6uSLKbA8Qo9CqmLg==
X-CSE-MsgGUID: J4jWek3iSLGNtX39F4t7hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76835469"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="76835469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:19:41 -0800
X-CSE-ConnectionGUID: U4QjYR/qT9yrV1EV27Wj4Q==
X-CSE-MsgGUID: fL1/nFE9QrCfbxcwNEZlog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="243918909"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:19:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:19:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 14:19:41 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQJczUYkY27Ge4e0O0Wi/PphO/ASUp2AMUGJc9YfKSFHMGgD3570nF0AJfGVqc25Aaz8o/ef6nCBW0ejGEUIixXwEpDnxAqtdkUhRB5E+kxCzzqlYV76oGdMdtpCvPvHmPLmS4I0vFrjfTKGmQ1kGSD3WK6jW8AskQOJ2CjwHX/q+HdS/So+5YNKQiyYH/kMOoTcJOc/BPIH58pewLh2KcE4rxQIf4DeWZXAx3sN3vexL8/YaVu/7M4cTa3//N3swv6JdS/GbCiANq9rjBnRr848UACSO7VmE1N5Lsggn4w1QOMbrgUBCYJc53o/oPcuFk9pTgMfsrYrp3ASBAEa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNUUOpqIg8lnFckIPK6WTpvtB913U2Yj3hlYFmDgm50=;
 b=bFoKEo2Rt8sXH8NAfIHRpr0Y4eLuPIm/nxlu8oaFEqRNIuXpgRbSTX6LDAA1dgIYFMkO8iQJ0F81AV0IQrg4Qldx67gzGRVxM44du+J2JR+DjZOh1F426OS+NJ2qEWpExpaiJ+N067f25zj+yNEbCny2DX5JjH3AYelf/5g6oUovbrk6FBPFC3WmchDrhfdtMACKn+UkJ1Hxqj7MQef3Ylzu8G2R9u+enW2q3ATwiCDHRnlNrfLqYmgHD2fGiYo1sQj/idGQ6yhNZdgc2iLnS6YxdrwGYLRa9OUb2T6ndc5FT+sJpq8h4xZVE4Bh1qJyBBpj4uaHMAIrD0/b5I4JMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by DS7PR11MB6061.namprd11.prod.outlook.com (2603:10b6:8:74::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 22:19:38 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:19:38 +0000
Message-ID: <6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com>
Date: Tue, 24 Feb 2026 14:19:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] help: use list_aliases() for alias listing
To: Jonatan Holmgren <jonatan@jontes.page>, <git@vger.kernel.org>
CC: <peff@peff.net>, <gitster@pobox.com>, "D . Ben Knoble"
	<benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-2-jonatan@jontes.page>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260218215737.1181147-2-jonatan@jontes.page>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|DS7PR11MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 838d76c7-17b5-40a7-57a3-08de73f2cc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0p5cWtUNW0remFCa3MwanVqUEZOakkxNmh1aURTRk5zTEd4b1dqMU9taUdE?=
 =?utf-8?B?QlBnc0ttUHh2amxUYjVXZkRvVVNnNjFYRmlTeWY3MDBLUTJXYWRxTFE1Sk5n?=
 =?utf-8?B?RHU1QVM5RDFjVlBMa3hnRU5NdlFDVkk3YkxJcWwwMEJWRFh3UkdpY2JKWkU3?=
 =?utf-8?B?Q0g0OFA1WWhpdXdYR2t4cTRWOGMrbjhRUzdmMFM1RGRzKzd3OEJqdG1SSTZu?=
 =?utf-8?B?UWhYbUdQMERtSkRjQzhqZ0lteW93blEyRFlCY053cUtnMjlwa0xmWVcyc2pO?=
 =?utf-8?B?cGxWbzliRUpsRzdBbzkyakY5Vzg5Q2RaOFJ2SEFIR0pFV1lLQ0xjN1drTW5u?=
 =?utf-8?B?T3BSNUJFTG00OFhIRzZUU0JLbDNIN3Y0anNkY3lnYnArRmE0MVlGbzNYN1I3?=
 =?utf-8?B?aEtrSE5IK0tzaFNnRkgrOWVXR0tnQzZSUWxINkU2T2wxamgzZk9zbG1sbFRW?=
 =?utf-8?B?RVpWUXJ0T1NZakxJcmlDVWh0VE0rblY5dFVjZVVSSlZCWURVUTh3RHZaV2tr?=
 =?utf-8?B?ZWpTZmx3VDRtcFNWU0pObXVxbmJZa1J2VTNTSHVnT2pxTXV6NXVzbTRzSDhR?=
 =?utf-8?B?cVpsYW9TTjYzOVNDY0lFc0xleUJpeklpd3dYNkZIYmZRRUNaVzhMZXBETEFn?=
 =?utf-8?B?eEx3VEMrSU43Wko4ek9WZ2NuUzM5cWRlaUNiaTJhWk42WHhKUjdZekdpYUty?=
 =?utf-8?B?MGtVeXBrU0NzL3JvdUtIUUpQV3BpOGVpZTFmMW5rc2ZYaGJlTmlrWHVydk53?=
 =?utf-8?B?THVFY3M0YWNYUjcwQVBqdXh5WGtUL25hVFlVSDlnTU93ZngvS2MxMmYyZ2xS?=
 =?utf-8?B?aUxOOXJlcklRM1Q5N3VURFlxN3YzZkt5K2dUM1RCZ3Z1d0FkTjZ1L1VjQTNh?=
 =?utf-8?B?clYzOUFQQWVRZ0xrVVVrK0xkdUNTT3pKRy92NXkzaWJwQVBvbXRVbDEzT2Y1?=
 =?utf-8?B?UGpnQzIvWk1INEVydVNmcDRlVm9rSWFwcHV4WlNqY3loT0hyZk9pZ2pJdENX?=
 =?utf-8?B?WXJLTE5sZFhwTjBkNGpFTDZFRFlnano3L0FiSnJsY0J6Uk9ZRmp6RW5WdnFi?=
 =?utf-8?B?R0pyU09sakk5dS93N25TY2NENlFPY2w2UGJ3OVRzUFQwRmRtYU8rTzdFUHVQ?=
 =?utf-8?B?dWZhUkI3TzBLU1JrZjAwcUtYK0N3ME9Udm5LdUdpYm9YL1FYWHlNR3BPMGRh?=
 =?utf-8?B?Y0N0S1c0WmVxME9KU2ltazBXNkFqdFN4RVR6bWtOOENQd2dBQzNvK1R4Ukph?=
 =?utf-8?B?MTB4NnJJRGdmNDdOSXNZRzdoWFdGeUNUZzBFODNHaHpXcWw1RnFIdjJZbVJa?=
 =?utf-8?B?SEdDYitKT3ZML3FOQWJseFgwZ25kY1FsUEZrVEl1bTRqa2UzMVhNbkNtckpq?=
 =?utf-8?B?UUVpN1ZSQ3ZudGZFZnY0ZFlJalExSzBVS1BtRDVnOEx3cEltTnQ3OUVPWmYy?=
 =?utf-8?B?QkJXelIrZXdHUzlwbTI4aW5LNDRwbE0wNEo5SDRhakNMOWFhTWV3cmp0WVlM?=
 =?utf-8?B?RlFLQXc1TnVJOXh1TFo1dXNobFMrMkhhbXEzYjF3V21tYlRVN3FRckFtL1A0?=
 =?utf-8?B?MFM0cjRGT0o0QVlpZEV6bEk4aWJmTEZTT1NGWXdzQjNOZjY4YVplRDZUT0xM?=
 =?utf-8?B?eTlhdTd0Skk1R0ZNMzlJb0gwL2VNMVRjTmZMU3hHcm1WSk1kQVdueWtYM1g0?=
 =?utf-8?B?dHRPbE9JSTBWM1lGOFlBQkI2U2VFQzJndTg5K1ZseXYzQkZ3RE5OdGJHdUYz?=
 =?utf-8?B?VzIxYm1QK2p3dVROMFJXY3R6NXVKcWlFeC9DOThEMGJ4N1FOTmswaWFKMEl1?=
 =?utf-8?B?QXpvaVM0UEFmK3JaQllzTmppOHNKUkZQcmQ4TkNhUnAvTlFqRmlHN1hub25Z?=
 =?utf-8?B?UnZSMEdiNVk2dERBZTdvVFVOZDc0R25NTDhnVkVmSE1hMkNkVlR5U3VsbUhN?=
 =?utf-8?B?ek5pWXdEUUJnZW9ya3QwMldScU5WRVphTEZvTzdCYUc2alE5OVFKQm1XdTY2?=
 =?utf-8?B?b0E2ajFSZ3RtSHo4TXI1V291LzNBZVJtdW1SRXNsZzJLVm1McTFtNHVhYzZE?=
 =?utf-8?B?by81ZkYwbkZaRDdnSS9FVHpmUXQvU1FuNjlMNWxDSjJYZWFBY0lXc0xsdm9i?=
 =?utf-8?Q?S8cg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVGSFRNbkgrR1ZxbU5VQTlmT3pUQ3ZHeml2SSsxbHVpVWxmVnZ4Z0tkcW84?=
 =?utf-8?B?QklJaDRLVk95RW40TFlqNTlyZGQ1aGE5TENaT0RYT0IzanZlUzhDRVN5b3RN?=
 =?utf-8?B?a1loQ1QyZ2Y1Q3ZVY2dKOVVzWkJ6Qm1ud3F6VkFZQTZMU2xnaW9NeEZhdzYx?=
 =?utf-8?B?SzZTYlFlYVc1V3g3TVZoYWlPUjh1UGJscjNTQnp0RXFxRXJjNm9XWmNFclQ3?=
 =?utf-8?B?c2U1cWdqd2V1Syt4bTBVeHUwZ1hZOWwveUlNbUxPb1UvbFg2UEt1cnA4MHJ4?=
 =?utf-8?B?ZXBtMm1VTXloeDdnNXRDa3F3Y2lQdkxIT29YOHdES2ZZZmRUdGhpb1l5Mm9P?=
 =?utf-8?B?SW9SaGVRUjlsUjZvK3JMbU82Q1JKM1A4MG9zMWg4ajNweFNMSHZzT3czQThw?=
 =?utf-8?B?cEkyem44L0JiVGlkVVRkbGdVN282Y29vSEJOUEJwV2RaTnJuZXJHdUtCTmdP?=
 =?utf-8?B?Y0lDVzU4cDVMN05YcFRTSU9EOE1zZVY3MmVrRnpBMXFKRTRMR00wUVNZRnJP?=
 =?utf-8?B?RE1PRXI1T3hYb2RSZ1YwZGdZd2t0Qk9CN3VmVDc0N3l1TE1BVUdGRTFndStx?=
 =?utf-8?B?SkY3TkFkZWpOcExWR2FybGNiMnpjZ1hJanV5WmFDZkVPeWl3dlpuOUdISTFT?=
 =?utf-8?B?Y2hwcW1yOVFlQ2ZvcHg4RndBSUNUZ0lyaU03ZGQ1TEU5V05tZ0Zlczd6bVV3?=
 =?utf-8?B?UDdZRTdHYUU1OG9YbVpsWS9KdGVhSlZ4RVZFNStzeDBNQXpjVi9ZT3dRbXZT?=
 =?utf-8?B?MWg0c21rMVpXY0ZwazE3cW9XSHV2YittckpweEV5QkEwbkRVNTA1RlhIQXJM?=
 =?utf-8?B?Nnlzc3RTT1NVaVpQK3JqT09BQVM1TS9rc2JVRTFORTdRdjY4Mk54NGtFSlN2?=
 =?utf-8?B?WnhnVElaVHArZkJPMlEyRytsU1U0NCtHR1pKWjVHMGtXWWpTZS85Vlg1dEsr?=
 =?utf-8?B?ZEYzMnpsRm1vZ0J1eGh5Yk1FeEpxb3Z6Sll2bERFaGU5TTRCRTNKMUw4VDdY?=
 =?utf-8?B?bEJ6d3c3eEt0c0JtVm5DcHljOTRSU3c2Qjc5RWpMOHhpbllDY2QwaHJiQnJU?=
 =?utf-8?B?L0EvaUpnQzBScmYxUXNpeVpMTFhMc1Q1S290c1VqTGhLQy9PSHBFemVVMWY0?=
 =?utf-8?B?eldKZFh1am5lYnBOcWFtdXNnYUl5cjh3QkFsZVl6Wkt3MzNTNGtUaTZ5Q3B0?=
 =?utf-8?B?cnFxRlQrblN1Rk4xNlJZRk4ya2xSek10RFA3c0djOEFWNzhjYUsyOVJFT2tx?=
 =?utf-8?B?Nk96d2o4WTlHOG1WbDM2VS81YWtRSGNvVGNmc0hFN3U0MUo4cEtNeTZZZGpy?=
 =?utf-8?B?dzcvN2tpUkR0ZmlVTTc4KyszaW9ZYmZKb0tydE1FckpNMzdsSjIwUmhpVnh4?=
 =?utf-8?B?em9uVFd5ak9QWC9MVnFOYVpud3daTk80Ri9CbjR4RVBuTEliYXdxRnNYOHlN?=
 =?utf-8?B?OEJITklsU3V5Y2hXeEY2WEF2VXFKU3RLZzNtWUVBU045cTNYVVYzcWIxZGFX?=
 =?utf-8?B?Smc2RXAyeTB1OE10eWdNRkRlc2JLM0NoYUEvNEhwT200a2JlcXgvMkwzMjlw?=
 =?utf-8?B?T3VidHNNU2djdU9RMUpHcWwrcURZOXF0ZUJpeU8rbVhFR01JYXplVkpFY3A0?=
 =?utf-8?B?eUY5OXA0dml0SWk1Y2VzYjhJNTdZSmljMzYzcDRScTdJRVBuME84S3A5UlZQ?=
 =?utf-8?B?Z2xDL3I5ZGpaWXhudW5keTQxVEhIM05qRkZlZ294TnR1L3ZQUlBRODk0K3N5?=
 =?utf-8?B?dkp4TG5DUGdBdFB0bmVRM2FSMXpwYVNoQm9wanNBbHFNQ3ZYRUxZTFFjUzNp?=
 =?utf-8?B?NXEzRkpWaGYwSUVzM3NkWFpETlJoMWZ3Q2o3TElRVkNBZTVpd1RpSE1mTmU5?=
 =?utf-8?B?OGZ0Y2pWczdaNHcyRDVtcHVxYjlQN2dOMlp3U21ZalJJU0dtVXN1L3JpaXhx?=
 =?utf-8?B?UVd6UERLd0haSlk3YUlXM2NJeTUrbEJNTmdKTU5Xb2s0aUlCU3p3bjI5bUY5?=
 =?utf-8?B?bVRhZ0lYWG9XTUFpVVRrcHQvOGtvM1dXTnBnSmhIMlpqM1Q2d1RmdjVmMDBq?=
 =?utf-8?B?QlhVTTdjbGFGTFdyeUdaYVhITXBGWE5mNUt3dWNndVNEVkQ4R3BnT2x5RWpX?=
 =?utf-8?B?UzIwbGhGaFJPa00vSVQ0eEQ1NVVYV3ZQR3BkY3VycG92U29qbFdaUW8zaHll?=
 =?utf-8?B?NEoycFY4MHZ2OE5ZMTcrN213eHVMWXZtTHIyNVo3dWlndGdLUlV2QXhnUkw2?=
 =?utf-8?B?RnhMU2xta3d5dzFLbTI0UUlrZFhGYU04RzhQZEs1bFZJZzl0OVVsUUgrdUdx?=
 =?utf-8?B?aVZ0ZTh2M0UvV3VlN2tGTGNUUk5QQVFPZWVRSXFzK2hNbnlnVDFZZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 838d76c7-17b5-40a7-57a3-08de73f2cc56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:19:38.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ly/0hUNLabPGd6xXzlS/xZn/1Bl3jEq8AkMsHW+UVNiYnSV7wjFnScgxBluzZLAjSRNmoNXdHiUnlqbnW7JV8lMvj7FRaIFK4yMevkWuAOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6061
X-OriginatorOrg: intel.com



On 2/18/2026 1:57 PM, Jonatan Holmgren wrote:
> help.c has its own get_alias() config callback that duplicates the
> parsing logic in alias.c. Consolidate by teaching list_aliases() to
> also store the alias values (via the string_list util field), then
> use it in list_all_cmds_help_aliases() instead of the private
> callback.
> 
> This preserves the existing error checking for value-less alias
> definitions by checking in alias.c rather than help.c.
> 
> No functional change intended.
> 
This results in a memory leak with git --list-cmds=alias:

==2244105==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 1453 byte(s) in 37 object(s) allocated from:
     #0 0x7f9e268e0ca0 in strdup (/lib64/libasan.so.8+0xe0ca0) (BuildId: 
25975f766867e9e604dc5a71a8befeaed3301942)
     #1 0x00000115997b in xstrdup ../wrapper.c:43
     #2 0x000000841299 in config_alias_cb ../alias.c:62
     #3 0x00000098df73 in git_config_include ../config.c:429
     #4 0x000000973616 in get_value ../config.c:919
     #5 0x000000973616 in git_parse_source ../config.c:1114
     #6 0x000000973616 in do_config_from ../config.c:1341
     #7 0x000000975f5a in do_config_from_file ../config.c:1370
     #8 0x000000980c9b in git_config_from_file_with_options ../config.c:1393
     #9 0x0000009827fe in do_git_config_sequence ../config.c:1556
     #10 0x0000009827fe in config_with_options ../config.c:1615
     #11 0x00000098313d in read_early_config ../config.c:1670
     #12 0x000000841935 in list_aliases ../alias.c:81
     #13 0x00000080b12f in list_cmds ../git.c:102
     #14 0x00000080b12f in handle_options ../git.c:336
     #15 0x00000080d570 in cmd_main ../git.c:955
     #16 0x00000044a54f in main ../common-main.c:9
     #17 0x7f9e25e105b4 in __libc_start_call_main 
(/lib64/libc.so.6+0x35b4) (BuildId: 
2b5beec0fd24fe9c9f43eddfdd5facf0b8a1b805)
     #18 0x7f9e25e10667 in __libc_start_main@@GLIBC_2.34 
(/lib64/libc.so.6+0x3667) (BuildId: 
2b5beec0fd24fe9c9f43eddfdd5facf0b8a1b805)
     #19 0x00000044c944 in _start 
(/home/jekeller/libexec/git-core/git+0x44c944) (BuildId: 
674cf04ebc1da782eede3c3be79a0c15f372df4c)

SUMMARY: AddressSanitizer: 1453 byte(s) leaked in 37 allocation(s).

This leak occurs because you now copy and store the value of the alias 
in the util element, but the call of list_aliases() in list_cmd() 
doesn't clean these up, since its string_list_clear passes 0 to the 
free_util argument.

The following fixed it for me:

diff --git c/git.c i/git.c
index 744cb6527e06..aeb099ab1162 100644
--- c/git.c
+++ i/git.c
@@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
         }
         for (size_t i = 0; i < list.nr; i++)
                 puts(list.items[i].string);
-       string_list_clear(&list, 0);
+       string_list_clear(&list, 1);
         return 0;
  }


