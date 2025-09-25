Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40F30CB22
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820687; cv=fail; b=KXIa4q6UZT3YwyRVgEHibA+gB9o0gpTF3O3299vuusPhgV0FLauV23pejC/AlK3a3X0mUrO6RISojifIIx+I7cU2Ivyi/p8NuHpVjRL+LxxoieLkfbOk00Aaxj0IRH0xgPhdGvaSCyeVJgnrsOpIk0W9pCM3FQtAN9LG9MQhUbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820687; c=relaxed/simple;
	bh=dHc6/oqcEqn8XfbJYiwaY2zBTwj6YSgS7elv2s5k4dY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgFNEcwJpuDm6RKh38DkcrjYdtwY9VpyxiYokmDDxuS7EyCcneXLbC1v/fYlTFBr/bAft/yfoN0s03g0du4ZMUdGSr0KRMJNOqj/NbUIUe/5nZDlu4X/IGzZVXMAyi+JUL0yTCdAERJJsL9jitg7UQGkd4XOJk/Saa2PagTbhQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSwJtHAe; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSwJtHAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758820686; x=1790356686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=dHc6/oqcEqn8XfbJYiwaY2zBTwj6YSgS7elv2s5k4dY=;
  b=NSwJtHAeT5HMv9ClLjg99KGWz9BE0HjU6UnOeGlKqaKS/Wv1ZnHry8xT
   qHd6aNaJUo+HxscK6VeowJ0Ipue2DxjKcot9ftJxtNwkaQTJEJK1UMziJ
   SgRrf3/q13NSLLci+9C16ZPGFW9MMqvBWmn+8PUR5IljceGpHXk7El0b7
   vb8aBT9rsFAah9ncnhkpjXn/E/uTTNcRiXJmkfzYejNmPWLhP9TGSrnR7
   blC4HFTue1P/fyyg9AiL4X6RMlA7uUYMihuSx5lmvvyI9n56FSE/XuEQW
   /Yy21K8cqrcZUBl9Jg9dPY9jS0tIwJ/E6oI5au0h27V0ThH8Z9E7v2/XL
   Q==;
X-CSE-ConnectionGUID: 896OtI2XQCe7xr/+Ho+ZvA==
X-CSE-MsgGUID: 59ZuKRn5Q4m199W7nA+dwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72578697"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="asc'?scan'208";a="72578697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 10:18:05 -0700
X-CSE-ConnectionGUID: fJbZ61lvQW+9fLXv6IbmSw==
X-CSE-MsgGUID: Dp4mjv/aQ52CZkC3DoOExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="asc'?scan'208";a="181783678"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 10:18:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 10:18:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 10:18:03 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 10:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYiiWgcEwWVCMKuQ9HXRQt319A1kDchHQdmGxi2cw9jDWwq1dWVr+WxVrd5h7L0SOfbz51N274p3XrPlvaUN2oCiQ3xBW6SHiX8julwDuGzt8huRxPqgTlvWitNyIgnNqzqkfrV+9nRvptodCt0AfRToA2gGPN3x3O6+gTm9GYQaH0J03pTmKorn/bU3I4jdJRHJiaodWgrY24BMHYmPi2OjXFOVC3PCAjNcpU3cwqOAtD3j0XbAoMcnYgbMPJltGH50xMJN/sKnwShSrzKIPaMzmjpTAdUhXN1K1O8E4A8gnUOIygvMjkz8hf3bKno8+Heza7DwZBTV5Tvs+i2Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo627qSw5+mAEMFZcze5jAIVQxtk2IVFNi9k40m0wMQ=;
 b=gA1modLF8kIOrnl2rhJsqyOOum/8q9P5PrmpacjLZL6SuxZnID+P87BkQSyPgjBKkRDu5nN3P2JxL0kk7JLCmcx8LaDbGiB9bgaj58bbIIhbMy5wR5Mi9HqRtUPSO9u1DeJUw9S0/6Qk+ooBRpBdWE28RhzPEGhfsL6uE1E//ERFGN731kuRJZTusPh6zNWTJ3/NzkfGoypcssSIiyH/P4DSAT+QMVp1ZWwXOhmp/KOqa/Trr1kALHZ5mjvK1TQpKwYDcjir+Fo1br2dRx6I/5wHq1STfoJsqHF7b93M0go5SZpltk3U6IyPpf2V+7af2s7qt0KYJeZPtU/+ZgBEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 17:17:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:17:56 +0000
Message-ID: <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com>
Date: Thu, 25 Sep 2025 10:17:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
To: Junio C Hamano <gitster@pobox.com>
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
 <xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <xmqq5xd7jxpq.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------IjGXJNo8R3Ko0pSZUI9jGgaW"
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: a54273fa-ebf3-47f6-9be8-08ddfc5777da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkZQSUxaS3ZlRUZoaU9aZG50TDN6MnYwcWdiQit3NDVVVGgrMTFhNm4wSTkv?=
 =?utf-8?B?OW1zbEQ3cFpYcEViR3hpdU5ESFY2UnUvc3dqZXQ1bmtaaTkwai9OTzhWMlVT?=
 =?utf-8?B?MXFmeUh1UXUrMXJmZ3RuNC9ueHoyWVhpQ0tUM0lmMXgreVRSTzhuRldtSjRi?=
 =?utf-8?B?ZHdNdHNGMlJHUHdjbDhTeDU1RGg2NFJ5ZjFBcTJ0LzYvS29FcTZqVkxLKy93?=
 =?utf-8?B?NGVkYWxEWm8ybDYxRHNvbjhLQ244eEdnNThtQ3Z5N2dZanA5dDZWckdENzg3?=
 =?utf-8?B?UkFjMm5zZ1kxcEwzWG9MYm9yNmRSWHBMVUlsSVNsWmNMLzI4TEFlTllJaWFo?=
 =?utf-8?B?eUtya2NNb0xOTXB1eXRjbENESzJJQnh0R3RZMFNLV3ZXL0p2eU1CK0NTL3B6?=
 =?utf-8?B?bmt6cEIwNE9XeE5Ja0xIQm5TRHZvV3Q0bGhFV2pGMFZjQldZcExleDBSVFg3?=
 =?utf-8?B?Qzk3QkVyRXFieUJlS2owZ3d3dHpuMUQzZGxBbElaaWgxUXpadmt3UHcyZzRi?=
 =?utf-8?B?ZUUwckxIRHcwSDc4cm5qclVLYnhPQWJHMTNsbzdCRWxTNmRIRlJaTHp0Qmo3?=
 =?utf-8?B?U3ZxQ3gzNUZ5c00xMWJyUWgrOFlZQzBWblhYVmNaM2xKN3ZzQU94WXB3clBC?=
 =?utf-8?B?UzZGNWV2bDNld1g0dTB5WUtqODJmZDFRZlhCOXpEd0NVdHZUc1JXTjJ5b3k0?=
 =?utf-8?B?OEdmRDZxdVFlVDZ5dDdTTExQVHQ4Q3FQUWpwbmV4aW85RmRJcTZ2TXl0RHZx?=
 =?utf-8?B?K3RMc0xJV3pVMFIrbzF2YkpWc3pZOTJJR0kyVnF3UjV0L1lSSXczRGZwOUQ0?=
 =?utf-8?B?Vlh6MGp6SzVURHpwS0tTeFlQMi9ESnY2TWZYNU1LajJNcTZuWDNaajA2bE9j?=
 =?utf-8?B?N1FwQW10Y2R6QzVzU0VxZ2RHKzM5b2h3KytnclNEMEc5R0lGYXQ4ZzVsbnly?=
 =?utf-8?B?R21SOG1SRSszeEFRWURhbk9XNGNscis1c1dKRENqRmVCdDc1U09SWmROVGhB?=
 =?utf-8?B?MTJTb0FJZElKVk5mVXVkUUlyK0V6ak42SUd6c09wN1JzZ1BFTC84bFJsTzBG?=
 =?utf-8?B?RUlHcFo5cmNTM3dGRHoyMXM4NGNaL2JkNmVuUUVIWXJXZ3hxT01IcUVUMUsv?=
 =?utf-8?B?VlZmMjFiSXNnYUE4aU1NUjJTRGlwSWVzdUtxWndxMHp2Uk8yMCtHZ24wRzgy?=
 =?utf-8?B?TkY0TjlDZ0g2VS9jL2NWeVNDSmgyTk9Tc011VDdkL0NkempkS3o2ZEREaWRr?=
 =?utf-8?B?Z0VyTW5WU2NJdGc4Z3d1VXNCZkRwWUFZVGpYby9KV0JPR1pORmNDTHpYTVd5?=
 =?utf-8?B?WklOMHpEM2RLd1NqYXZoL0g4QVY3SklTWEUrV0piNEhXR1VTcm1HRTVLVVly?=
 =?utf-8?B?Wm9iMktFMFJ2T2RCcVIyTVFIVjc5OHA4Y0ZCK3NFOWFWa0VQZXNFWHVvRmJm?=
 =?utf-8?B?RWQyU3dYOVBDb3F6QzJBYSs3WC8wTVhHYWdPWmZxTGEwRnA3ZGZxZDRYdHdK?=
 =?utf-8?B?TEdJYWQ0dTdZZjcvUUkxY1NTdWNBY0xjR2FoY1BKRy9jZklrSXNBUFFFWTFO?=
 =?utf-8?B?VUx4d05GUk9GcVhWelJGbGIyN3FsbjI1dnpNMHNtb1FaRWVvMS9GS25YWE9K?=
 =?utf-8?B?aGVvQkYyRmx3MmlpdEpBYWNJWTdXVkp4SEpFNERVTmFYZ0RGSDE0aFl0WVJw?=
 =?utf-8?B?dDkxL0lUV05LL25Db0RYUTV4YytZNldNeXAzRUdiNmdsYmtrNlNjWE45OVh6?=
 =?utf-8?B?NHZZaVBDTERaSERhNjhIZFpHTlJpRlZ3VGxSdSt3bHhSKzlESmxMQ3ZyWHJ0?=
 =?utf-8?B?VDZEWGVFSkpLM0JjMXBoVHRlL2l3UDFjRGc0cVBMRHBCUVpMb0tRYWtBcWZz?=
 =?utf-8?B?bXJER2ZDdVNDZ3o1ZktONkM1TSt4azNxMUQzWG1iV0ozVjhheEowdXBJdys1?=
 =?utf-8?Q?DQl3ug2pS7Ci5M6BCRXh3H1iHBQVt7QD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJtUk1VZTU3ZjZXOVc1aFNqbU9qS1d2VWN6RkpLNGN4bzhwSFhWM2I0bEZU?=
 =?utf-8?B?MVQ2OWlnMDZQOXIyOUU3ZC9rd0tuMStnTVpVR3dOTHFGbnBEZHRBWHFwZnNV?=
 =?utf-8?B?N241TGduRHo1d010czJERWcyT29uWnB2bWQ4bVNpRDN4NGxLVzI5bVpUbXBm?=
 =?utf-8?B?YTdJSkRSN2VJS2M0YVYxNzdjUzdzQ29WSFRnbndEN2NqNWR4RnpmNGdJNU5z?=
 =?utf-8?B?OGVXem5JRUZqekFKWkY5bWRaR1RxcUU1N05HNHdCR1VRUmpYNURRcTJSb0Z1?=
 =?utf-8?B?bjI1WEEyUVdzRnBIa1Jrc2JKSHNVeHI5RExvVi9VTWs4NG9lakVqRVlUS1Rk?=
 =?utf-8?B?cUwvd053dmpKckFmVThScDFWQ1JYd1BFRkFHa2VucFFGTjVFTGc5Q0VncUZa?=
 =?utf-8?B?T0RPVHlHV1ZpaEdDUUYxUFBlRnFheGxsZUxabVNvbG4rUTVwTStNWGNraVR6?=
 =?utf-8?B?bnRkU0dNNlJPTEloTjR5RkRpV2pOa2lwcTF5dVVFY0R3bjlGRy92REZXUVFz?=
 =?utf-8?B?YlQwY0FSamRkTGQzMTAwcTNqQUdiR0FGcmpEY0x2WHdsVDgvVnRlaWhZMU1C?=
 =?utf-8?B?UXo3eGZxWjJEb2MxYUpMVlRtdC8zaENFSHJNTTRUb2lXUjgwWHBwMEprdlMz?=
 =?utf-8?B?dysxb2M1cHlFNkYzcjRJOUVuS1NQUWJVY2VHTEVGcDQvYzI0RXdrcEVtdjVH?=
 =?utf-8?B?SmJHL2hNL0NwNTVZUVY3S3VrNUlsV0ptUm9Td3p1SW5ON3g2akJTT2dmN2N1?=
 =?utf-8?B?RnU0OVVMSFN3RWtERHdndlM5OFpjMGxUZ2xwS3d4UC9NUnFnQ3R0RkRMWWFO?=
 =?utf-8?B?aURzTTRjMTRhN2gzbE40d1pwUDM0Wk9WMHJpcVhadExVc1dxQllCVURYa0M0?=
 =?utf-8?B?Q2ViSkgxekhLZE01MU1TZ1JSUU8wT2w1QmFkR3hXcHZEZVU1OE5BY0NTZDhP?=
 =?utf-8?B?K05oN1JaeTFyL0t5MTUzbmo5eEd1OWZxaDFncEhaWjZFTlFwQ1JXbVhwV0Na?=
 =?utf-8?B?TG1XSVp5YzlxRWxaY1lpaHN0OWhUaGl1bi8zTDJKRnZkS1gyeUx5QUdNZDhX?=
 =?utf-8?B?Y1lxYThRS0tkSU9NQ1owQjROVE1PclozbVlrUFNzQkQ2QjNwa09xWG93c1M4?=
 =?utf-8?B?bHNHTEROZGxySDc2WkZKTVcxb2gvVnM0TVN3T0k2OCtFeGlYcUFUeURyWWNJ?=
 =?utf-8?B?Y0E5MHlVU0l2T2FldlBGT0wyWDJ6Mlkzd3NDQ3ZLTnJBVHlGc3V1eHFOSy9t?=
 =?utf-8?B?YVZpUXgzbDY0RXdBeWZJYXlHcDhsVXU0K3FWZTRndVlUMHNjaEpaZ2JvWmtZ?=
 =?utf-8?B?SzMxZXpxUGFIWHM3aDN0R0VHbXdFckZ6aHFWc2gvZHBhY00vTDZjK0JMYlcz?=
 =?utf-8?B?RTFMamw2eUhwNFJFZG9XVDluSWxFV2czN20yS2lKMlJLR0ljem9FQThMb2ZX?=
 =?utf-8?B?M2NTbWZGVjRxaWFIZEhMaTgzdXU2aFhwbmtUUFdMc1QrdHljR2JDVmNzZ3FT?=
 =?utf-8?B?anpZTGVEUkQ4QU91bHhhY3Z2RHZaUE5PdSszRE12K1hnRDEyUnRXaFNLT0h5?=
 =?utf-8?B?SVNXT2NVMlBkRS8rTzBoZzRsdDdONFlPMGkvNE9qNmVlb1I4K1l0dGZpNWpr?=
 =?utf-8?B?T2JTMkZjbmRBYUQ3Uk5QWjJGeTVSalpCd2g5SlR4elhPRStIL05JMW1STXdU?=
 =?utf-8?B?Z3lOZWlMR24zMG5lb1BhQkRIY3FZeTB1MnROUGFzNUh5UDQzMEtZbWlmN0FC?=
 =?utf-8?B?NEprb0hZTmdueTI5THpNdG1YOGV3aWh2cDR3TVNjRlRYWFNocUVnYmkzb2h4?=
 =?utf-8?B?cHlBblZTaiswV0EzRHp4b09zcnZZdVRQeVVKdTVSbXJkSnpWcm1IdUJ1SnB2?=
 =?utf-8?B?QklpQ0czQkN1Zy94Q0Y4YWFTN29iVnlKR0JiZFpERmw5SWFWYXRHT2paTE1V?=
 =?utf-8?B?OGFLYXEyY0dpZmZvMTdLNzVNb3M3WkkrZ3pkR2ZQTW80QUVIc2ltcDNFdzM4?=
 =?utf-8?B?ZjFNZTdoVW40VUlKelZGM0ZBckVFZW1ZRUs1SE9wZ05GWmNKdEI2aHJMeldS?=
 =?utf-8?B?aGhzZ1NkSGQ2Z01PL3h4bGVyL0JENklOSjA5cE1SNkUyckRFMmRJZlp2eEYr?=
 =?utf-8?B?V0dScTdOSWl2Zm9sR1N3Yy9BcUlkOFRnMTRvTlZOczJwc3ZsNzcxdCtISVJB?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a54273fa-ebf3-47f6-9be8-08ddfc5777da
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:17:56.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzpWUfnDTTYg3JPtma9ZpYY5Iu7FcDb2hLUBCKV490+qALi69honP0odZAe+WgQ0Hb7SDEkz9uqwfU7mtKyDZ2iZZvMaBHnNae0aHzObz/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

--------------IjGXJNo8R3Ko0pSZUI9jGgaW
Content-Type: multipart/mixed; boundary="------------AKssxUPlct7IOqJsq4jaWZ06";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Message-ID: <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com>
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
 <xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
In-Reply-To: <xmqq5xd7jxpq.fsf@gitster.g>

--------------AKssxUPlct7IOqJsq4jaWZ06
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/24/2025 3:24 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Hence, I think the clean-up code of this function this goto ...
>>
>>>  		goto out;
>>
>> ... jumps to would need
>>
>> 	strbuf_release(&ps_match1);
>> 	strbuf_release(&ps_match2);
>>
>> added after that "out:" label?
>>
>> If we run this test with leak sanitizer, wouldn't it find leak in
>> these (I haven't tried it myself---I just am speculating)?
>=20
> Now I did, and my speculations were both correct.  The SANITIZE=3Dleak
> build fails, and with these two releases the test passes.
>=20
> You can squash this in, or I can do so myself if you like, if this
> is the only change that is required.
>=20
>  diff-no-index.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git c/diff-no-index.c w/diff-no-index.c
> index c70f82b805..f320424f05 100644
> --- c/diff-no-index.c
> +++ w/diff-no-index.c
> @@ -436,6 +436,8 @@ int diff_no_index(struct rev_info *revs, const stru=
ct git_hash_algo *algop,
>  	for (i =3D 0; i < ARRAY_SIZE(to_free); i++)
>  		free(to_free[i]);
>  	strbuf_release(&replacement);
> +	strbuf_release(&ps_match1);
> +	strbuf_release(&ps_match2);
>  	if (ps)
>  		clear_pathspec(ps);
>  	return ret;

Please squash this in. I'll fix it if we need a v2 otherwise.

--------------AKssxUPlct7IOqJsq4jaWZ06--

--------------IjGXJNo8R3Ko0pSZUI9jGgaW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNV5QgUDAAAAAAAKCRBqll0+bw8o6H9L
AP99W0Db0sNUFnSQesQLA+aDKAPIq0n+m11HlVLDNL4SOAEA2txcXoakK5wFN70XsfNfKqFO7MD7
kSCxdJR4NwPV0gM=
=8BZL
-----END PGP SIGNATURE-----

--------------IjGXJNo8R3Ko0pSZUI9jGgaW--
