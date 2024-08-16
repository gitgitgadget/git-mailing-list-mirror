Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E335B661
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852179; cv=fail; b=hz2zMXWNcEhhUJgfG2+dOzSKlZXSBwtkDjPD1dFsCXZ4/KjfKfoS+vASrvYGNkxOHtnWglYl/hA+85wRbqySVKo8TzYCPMUoVenMyb8qxSX3fUUYsQThrZlnKtVtx+MLbPJLXyQxmZoVksfaLYZKK2axpw8WtqcIUC5n9AIN2g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852179; c=relaxed/simple;
	bh=SRJxO2vScpxM5bxsG0+xC3FZZpApUf6wZTNMvHslcWA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekgfqxPqdVF+rWNHbJa9ckKwctDhzieqLQeVb6VlZvn/AFibEcN3kfcXF4LE0wG6e4GqtwkjUcXzIVGXYfu/sxW5vupjE3SBsp1WQhqADyLZ5zLy22OjlMjvn0COUW+MKiR1PiAiUz8n2rzkja64snkPTJgJc33JBqHFk7pw9ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CT+cmXfg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CT+cmXfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723852178; x=1755388178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SRJxO2vScpxM5bxsG0+xC3FZZpApUf6wZTNMvHslcWA=;
  b=CT+cmXfgDCOYIn7TLFLuuQH1P70ZS482pU0qfCQfYjPlCnEDOowEoUXv
   JAFE0GXphWsdmR+QR0abpHb5u0BZL38Hooj74a1M3jBBuWgXaamVhKzWi
   v3vciBYl9JN+8yxlFfEhdm6r/E3TtUDk6FlOk5jxznOqE/rA6knotDn7I
   NZ/uO5F3EPq3mCEluZIiS3J7egRlNalla0pqnwCFiwPAYQ/SXAd6je+vH
   YILySMT0FWbouG7WHo2lzWAdw4iH8Ll6Zbzr5JJFugC2w6G/chnsGTghn
   Hw77aPWXCXVZ9TE41sotFHZknU2KNQM0+VGYSnDzZWW7vNeNFGsqjo2dG
   w==;
X-CSE-ConnectionGUID: AHvWH5kqQnKeV/Au4tvhLw==
X-CSE-MsgGUID: 6ADcswnJQ7+gCs4M2zyDqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39675877"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="39675877"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:49:37 -0700
X-CSE-ConnectionGUID: bn7mS1e1QtyvQVnF02R1Qg==
X-CSE-MsgGUID: rCeqUgy9R96+BXISOBBi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="97317471"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 16:49:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:49:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:49:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 16:49:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 16:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp4/inyn5eHaoZvO6vnEu7i2ZRbqvsfLKqJ50SwCnCmtNb7OQjQz7pUupJq+Sh0M7lWPT7nalgPrDsfzRsJ1W972lRiOCDSXQ63I0WGX4R39PcDexdLrliNo9gJXXSi1lOh1l3rKc4agTCkQOjFldvRjtVkB93ync9L4+U5gJXKGrqlPE2C8QtSbHb2UFrOg+1MFFHwMoLT/PDB7Omxi+vTs+GLFiYc0p+vyJr55D98wfyHOLneJ/kH84IluOanD2mVGKXKi0v+7aQ33Dk6WwXF7TXLry7qoHM2dqbGr4Ql2rbLgi2s5PCRxdshi5IdNL+/G2e4Tmplam22WoOFgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSq7VrYiZSX4ub1MqN1OmqGdn3IE6uIfQl0ZSlktmV0=;
 b=ImLsVUJXbdYmoTFGvdUTO7/q5Ra3B2vNRBqiZGBm/cUyJicN+Duikfy/pZ0FkOX5AhbZ1x7kz2dK5WchBlRokpQWDP2+AMWIQUFQWIHhcNuOQ2apSduFFpmtgS1ggIXdBvQ5cr8CC4Z3u81WgDQ2UjMe2a5y3p+YNhK8t1xjlIEkdQPOBtQMqyxQq5OQEWt/Q5n3UePT6oUWR08s/d+g/KYrf6XcXLMQlPZNnr+lhJqh3ObOF5JDCu75HRelzDX6CH8HgFa8YsIFA3ADbHcEzsB6sZzW5pZhy2SL4bsRW0si2u2SmuYPST7oYYifGIDMb7Pen653YvtmH+A4G4JNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 23:49:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 23:49:33 +0000
Message-ID: <b706f695-c1db-48df-9095-664a13293f99@intel.com>
Date: Fri, 16 Aug 2024 16:49:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] send-email: add support for --mailmap
To: Eric Sunshine <sunshine@sunshineco.com>
CC: Josh Steadmon <steadmon@google.com>, <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
 <20240816-jk-send-email-mailmap-support-v1-2-68ca5b4a6078@gmail.com>
 <CAPig+cQr+n2dTN9OAbmCVc30GwUH2K67X-HGaF=-LazY1y+2bg@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAPig+cQr+n2dTN9OAbmCVc30GwUH2K67X-HGaF=-LazY1y+2bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 283390d2-ac8b-48fb-54a3-08dcbe4e142d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVCdkVFWTZQVkFlQWVoSERjWUhNWjNPNnE4WXl1OXdZb2VOVW45V1RCY1JU?=
 =?utf-8?B?a3dOUEFCRzd3R1E4ZmxnTTQ0bUtOUzdUOXlxbjVMSWhRTHlmSHF3bkplUmx4?=
 =?utf-8?B?c01ndHZTdVNOaHhZVFR1UTUySmtoNG9OZHRLb1FnTS9OVXZ3Z0tQdWgyTlRW?=
 =?utf-8?B?a0p2OU02M0w3UDZoZ1lKUGVORWJkdWlJQkpkTlMzbnVGOEFEbm9SOGxiM21I?=
 =?utf-8?B?RWVYSzJyR3ZoWEYydnN0QXFlbVVkSmVtVDJqMnNjWlVES3ppQ00yYjdnQmV1?=
 =?utf-8?B?SlhsVTQ2OTFseTdINkJPSGx3b2lwUzFPOW5xRzR4M3licXIrSTN6WWVSc2hp?=
 =?utf-8?B?b3hnL1h6cUZsdFZ1dG0zZGNjWllkMXNJc2cwMlhmQ0RPZXZjd25DZGFLOGpB?=
 =?utf-8?B?RFU2ZFFnNmJwNDMwYituV1BBeEc3UWsySG1EdTlOSE9OTDVab3JzRjYyd0Nz?=
 =?utf-8?B?d0xON04wcW1MMU13ZythU25SSXRDM1Fnd0s3Um91VUhCN1JPL25CQmVXY2ZN?=
 =?utf-8?B?TERzb0MzZVhvbXVyd2l0VW8rUmJ1bTU2d09yeTg2ZUY4RVE3bGFxQzhrSEFO?=
 =?utf-8?B?NklQY3R5NUxMejdScVh2K3pnTFlaN2FLd0dsRE4vRG1IZ2F6UDZjb2x2Y2JG?=
 =?utf-8?B?ekJsQjJlVVdacnhtdE10azQ4TVpLcTNTN202OEdCd2UyWmhWOVVJMnRkQXNU?=
 =?utf-8?B?OEZzbUpyQnFVVHpNZjVPNnQ2L05nRzhHNXljejJNQ01iT3d3YjdRc2tWYXhJ?=
 =?utf-8?B?VTdJN2xnSm1PaWNXZ2h1Q3BXN1VMbERJWGpWTUV5cG5HVjhwZTU3VmRGWWww?=
 =?utf-8?B?bkltUmpzdi8veU9SM2U5Z1N3ZnVkNm1BTlBwd2g1Nzk5K2hkME14MW5PK2NW?=
 =?utf-8?B?aDl6L0hEVG1zb09rTzZwV1R4SlZwZjloN3RzWGJPRXVOZGxxWk1QK1JVT1k5?=
 =?utf-8?B?RzYveXN0VGxhQjhXckdNeE1iTkkzQ0duOUxxUm1qWXQ3alozbkpiZjVjK0RH?=
 =?utf-8?B?L0JEUVozWEZmS25nOGQ4YkRDR0NhLzZzK0NJdzNqcDVoSE9uOHZTT1hqWlF1?=
 =?utf-8?B?d0k2WkhKNjFFOHp1UUtvM3VzU1huR1cwZ3lBN3YyTmp0RStYMUtRU1VtYVJu?=
 =?utf-8?B?NjljV3JuOGgreVlvR2RGYTllNVpWV1JhNm4zQVBDZ2dMTDYxaDZ2cjNKME5O?=
 =?utf-8?B?TllEdW11UUQvdXdIVUVoSW9HeDgwamtQRDkzMXczb0w2Z1pZSlhyUnN4Smlu?=
 =?utf-8?B?dUhkcktzNzdTbU41ellNRWFTaU9xTUVWVUs5SlIzeWNkVGE4RlNEWU85VEZK?=
 =?utf-8?B?TGk4N2FDSWx4UEFFc2Y3d01jZXJPaDE4K0p5VWhGRDBNU3hPVmZJdzU3Wko1?=
 =?utf-8?B?U2poTDVUQ3ZCTm0vTE52UXR4NHJBYlRWT3hoU2tpeGR3c0xRaFRWdUlLcFlL?=
 =?utf-8?B?NThQVG5wdmQyVkU5dEdPb0I2QlZyUjcvcVFkRktOZ25Ra2FhcDNCQUhvRHNs?=
 =?utf-8?B?RUNMV2lCbS9yeU1OREdQUkwrWlhOckFka3ZwU2IxOVM3dFhyT1JkQzlnRDg1?=
 =?utf-8?B?UGU3MjFxcmQ2by9NNURKY1ZibFpFZFdGUXpXS2dsR0xmNEpscTJwM3ljcUtz?=
 =?utf-8?B?akJrT1ljdElNdG9maTdCZjk3V1RWV0hTYm45SWJnbCt5aS81MkMxS2phZ1U0?=
 =?utf-8?B?U2ZOYmFZTi9YSnJZU2FrYnRqTExLV3RsMzVBNDhqaVllWEJjVnppbmMxdXZv?=
 =?utf-8?B?YkFDcVpUQjIvZ2FxUEJCNnRYZzZMSFJzV2I0YVIyK3hUaElaZmhUNEhEaGZ1?=
 =?utf-8?B?QW0xbTVES3BacjZXaEFRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJkVldvYlBlNUhEQWpTWWRneGYrNXE3SGpldXpzemlBNkZod25wQUc2TFln?=
 =?utf-8?B?MHlJL1E3M21JZ2NKTVl3a0dhVHQwZUcyMjk5d2ZtWm85NjZDYlVVeHRUYW8w?=
 =?utf-8?B?U2owL3BjTjhyeHpjWlMwV3RnYW5YTFBHSUJHWWJmWWE1VnFKc0UvVWxnYkZ3?=
 =?utf-8?B?WFp4NmY1NU1qWUcxMWJQRDJOQTJ6OWVqVkYyc2xmNTBMTlkxd3gzMmZHRm5B?=
 =?utf-8?B?OVlpSFVWUEl1M0F2NFJ1MXU5SkVHMk14NUtkZ0pDUDZWcDk0cmZyQVNuRlR4?=
 =?utf-8?B?dytKZUdic2NtWW85cFNUZGxqOTl0S09yNkU5Z3FwOUhCT0hSY1IrbDE0dVVS?=
 =?utf-8?B?OVl3UWhISzlUZTI2VXFLbVFHOEpIdWQ4Nzl2aEJvMW9PdmxDYjY0dzBlbG5o?=
 =?utf-8?B?Tkk2TDhUbkhPbWZMVzNjNzF3a3BLY1htY2FvZ0FsTXFaRlYxOXlwTDFvT0FT?=
 =?utf-8?B?RHFpaFdBdDQ0MXBydkFGZTRFWEliTHJRYittWHdJWEl6a1NoZy9TcjEzMGFh?=
 =?utf-8?B?QzV2V1RFQW4zVnNQeEpkblhybjlaSmxpVDNibkVLc0tMWUd2T2NhaksrVmlG?=
 =?utf-8?B?UG0rYXpla2ljYnBpSy94NytIaUVOZ2lKT2xZdmxVMVE4TWU2YXFQOUNTelNy?=
 =?utf-8?B?MTZlS01ZUWtQNUFUeC8ya3dSMC9HM3Zuc0l2ZEQzeG5kQTJYVk0xb2FOUnk1?=
 =?utf-8?B?S21HM1JNZEZ4WEsrL0FNSVVCZU5XTlB0UGU4MEJqb0NjbTJPcktSQnFVbXlt?=
 =?utf-8?B?Um5vUWErUEVqU05NQ3hwaWZGbkRER01NRDMvVUhHUDB4WjJCVFB4dkxGWXNS?=
 =?utf-8?B?TEFCa1pobFpxV2Jaem43bFkraHkvUTJVQWtPRkRPT3pRUVF0dzNLNy9wTDVs?=
 =?utf-8?B?V0xSWDZ5Z0pFczAyWmZjem9qTEJuVlgzaDBrdzdxS0ptV2loK3FzejE1eHNF?=
 =?utf-8?B?Y0NJOFRPaXB6S05Qd0pFOVVETklvVE9od0tGeTM1T2hDL3RsNCtoZHJTaHBR?=
 =?utf-8?B?YWdYSDhzMjhTMTZGYXJQbW5CLzBmV1h1bU9PU3liWWwwRWRkY2Mzai9HM3Qy?=
 =?utf-8?B?SEFsSlNuaTc2UnJpZTRUdnk0TmxySktKTHVlWVpXUTVHMmp2eW9IaU5pN2pv?=
 =?utf-8?B?THFVUkNsTW91ZUhkbEdzSTM0MEhneTluTFY5cStmWEg3S25LNDV0cVowZGhr?=
 =?utf-8?B?Ump0UWFXNzg1YzN2V2Rmb3hEekFqSklsZjlEaytUOTcyOHliRHJtN0lxSFgy?=
 =?utf-8?B?NTlFNUFYOUcxVW9CTzR6MzlIQlg2Y3BteVpkdEo0czlMQ2dCaDltalhBRThj?=
 =?utf-8?B?cTF4ZUIzWjJNMTRlV3J4Ym5OdWI0YlpnRzRMaTNJMUxOZGk1OTBwUEx0VE96?=
 =?utf-8?B?U1dNMkxGYnM2c3Q0RFZ4WWZqMFBYaFcxZlBEcGhqdFl5ZjBENjM1NXZMblNi?=
 =?utf-8?B?TUZJQWNqOElYQXhVRm1WdTBKV3RkaUlIZ0dUT2pBQzlQd0IraDM0KzJIYmNG?=
 =?utf-8?B?TDZPdkZMT3lkNXRhbm9mcnB2Q0hhNkxvVDlzSnlQbEV6TUpMK2dQQnI4QlRI?=
 =?utf-8?B?blE2OVhrUE5tRFkwclorSU44NlFJOXlHVE4rTVBZT2sreFZNSjkrcnF3Uk9r?=
 =?utf-8?B?Q3I5SlRWbldkNXNTREM0ejB0a1hVaFJDckZHZ1AweUxCMXZ5L0hqL3ZBUUZR?=
 =?utf-8?B?YWN2c3g2M1RTV2p5UVpFbVlPRnlqckw0T0FUSzVMRGVvWGdldHBJNnlYYVJj?=
 =?utf-8?B?TkwvZ1d4SmhHK3pUZ2JCNTVaamtENTR6aWtDclFGb2RrbWl1aVBsT1RyNWJa?=
 =?utf-8?B?K2NDUW1jZXdtTzllMHA3MHBsWnAvaVlyM09TL3ZDYzhqQ3JkNDM4bUU4M0pP?=
 =?utf-8?B?RGhXU0wwTW1DUTV4VStkd0o1aFRyYWV1bkxKQ1A1d2NSNUFSdFN5RDNZOFo3?=
 =?utf-8?B?cTBzU1FZY0JDejZNOWxYYjBTTXEzVUphM203OTJpcWpmcGdsMnFyWlFZNlBR?=
 =?utf-8?B?R0NqdmNETWRLOEJvSGFWWTRCemR5RWNjdnY5cUFBWVlqSlYwaFJVSTVNTFo1?=
 =?utf-8?B?Mnp0dFYwMXRVd2FYblZZOTlxM2N6UHFSaG85aTh2YjNVQndVUHMremxwTExR?=
 =?utf-8?Q?ZUDSRO1V62ig+IGKqMpxHtloi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 283390d2-ac8b-48fb-54a3-08dcbe4e142d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:49:33.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GtEI7f7qlrlW4scdWCE41ew/tjplhJKosUGLvVHC5z/5gStrG6VHTAR/o/m3aUzqDRv+zKIawb12tLT/nl596yHlM/EOj/pCwFY+Q5MytM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com



On 8/16/2024 4:41 PM, Eric Sunshine wrote:
> On Fri, Aug 16, 2024 at 7:06 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> In certain cases, a user may be generating a patch for an old commit
>> which now has an out-of-date author or other identity. For example,
>> consider a team member who contributes to an internal fork of a project,
>> and then later leaves the company.
>>
>> It may be desired to submit this change upstream, but the author
>> identity now points to an invalid email address which will bounce. This
>> is likely to annoy users who respond to the email on the public mailing
>> list.
>>
>> This can be manually corrected, but requires a bit of effort, as it may
>> require --suppress-cc or otherwise formatting a patch separately and
>> manually removing any unintended email addresses.
>>
>> Git already has support for the mailmap, which allows mapping addresses
>> for old commits to new canonical names and addresses.
>>
>> Teach git send-email the --mailmap option. When supplied, use git
>> check-mailmap (with the --no-brackets mode) as a final stage when
>> processing address lists. This will convert all addresses to their
>> canonical name and email according to the mailmap file.
>>
>> A mailmap file can then be configured to point the invalid addresses
>> either to their current canonical email (if they still participate in
>> the open source project), or possibly to new owner within the company.
>>
>> This enables the sender to avoid accidentally listing an invalid address
>> when sending such a change.
> 
> Nit: The final two paragraphs appear to repeat what was already stated
> or implied earlier, thus don't seem to add any value to the commit
> message.
> 

Sure, I think I got a bit verbose here.

> Nit aside, similar to the question I asked about [1/2], are there
> downsides to merely enabling this new behavior by default? It seems
> like it would be generally desirable to have this translation happen
> by default, so making everyone opt-in may be a disservice. On the
> other hand, starting out with it disabled by default is understandable
> as a cautious first step, though it might be nice to explain that in
> the commit message. Similarly, one can imagine a world in which people
> want to enable this and forget about it, thus would like it to be
> controlled by configuration (though that can, of course, be left for a
> future change).

I definitely did it mostly out of conservative: "don't change the
default behavior".

For a general mailmap I think enabling it by default, with a config
option to disable it. I think it might also make sense to have
per-identity configuration, so that different identities could point at
a different mailmap.

For example, one of the use cases we have is to have a mailmap file that
takes the now-invalid addresses and points them all to the current
maintainer. This way, the maintainer (who is sending these patches)
would have all the old addresses automatically point to him instead of
generating the bounced messages as currently happens on accident. This
type of mailmap file likely does not make sense as a general-purpose file.

I think for per-identity configurations, we would either need to add an
option to git check-mailmap to pass the mailmap file, or I would need to
figure out how to set config when calling Git::command() to force a
specific mailmap.

> 
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> @@ -1085,6 +1090,14 @@ sub expand_one_alias {
>> +sub mailmap_address_list {
>> +       my @addr_list = @_;
>> +       if ($mailmap and @addr_list) {
>> +               @addr_list = Git::command('check-mailmap', '--no-brackets', @_);
>> +       }
>> +       return @addr_list;
>> +}
> 
> For some reason, I found this logic more difficult to follow than
> expected, possibly because it doesn't feel quite Perlish, or possibly
> because in this codebase, we often take care of the easy cases first
> and return early. Thus, I may have been expecting the above to be
> written more along the lines of:
> 
>     sub mailmap_address_list {
>         return @_ unless @_ && $mailmap;
>         return Git::command('check-mailmap', '--no-brackets', @_);
>     }
> 

Ah, yea that makes more sense. I had been trying to figure that out but
I am not as used to the unless syntax.

> Of course, it's highly subjective and not at all worth a reroll.
> 
