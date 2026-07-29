Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53F26F47C
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285673; cv=fail; b=OOOxcKcFE7EjrLvVXKaTk6eH2OqTCxgCpwloRGkwUQCowqhPYPhk+GjOF5CxPjtOwVomLvyVqVrFjshTK+Rz88OFKDtH2UFiH7Dqy7ZJKpOrzmyGv2KyC4SnSxcSN7fy4zlfU8tKKUYOT2pgHsJHalUs4tfZ+HsT7vRVgBF1AwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285673; c=relaxed/simple;
	bh=00zlNwuSJ3yHDbKq/JIk/Mkga29esrmwMV2ljRfGfFI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNbtIJ5qQfm4Kvn9KP8tFrhfIbqjXw5sNrtCvns/m9M0tTTw00f8Zgxn37G4O/kM+hzgEGA3fiHBjBt1ZV5QiQraye9gaqZAr47od+o9HxTq8ozbDUN+uBd0qp3QtK3Ftap450hjDHVU4Tmg6A1WSEpPTZXWkUpiF8l7SnVHe0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvVqVfrS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvVqVfrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785285672; x=1816821672;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=00zlNwuSJ3yHDbKq/JIk/Mkga29esrmwMV2ljRfGfFI=;
  b=TvVqVfrSIAlV2aRFwrzaByWBDkjIG6U/MXIh7huN5xSfNeUA8/BTy9tS
   1aARBpySgDo7R5dUZFcBkWPMCmn3g8VUDM44rxkZszmSsw/ZLgqKP3KCR
   FrrUvQbe+f4e/NQUMzoTgR9LBfv+gt7lPuwquxm95NWDMtLF2aaeVb8hu
   129uV2B5UV7dhzj0Wi6YvdXUxiu2fVQw0zVynvAEuMWHx07fJ+FKcbNdj
   0EVE3TMpRvtxDz7b0IHq4oQxSeOauLxs3FKlYgLg3ajQhr2FZIh+QyKSq
   MHp4RCwAnj/UtOkBh6D/+RyNIOMvNaVdiUB6vn4fsTxVrKswMKO19qiHn
   A==;
X-CSE-ConnectionGUID: X3pHu07eSeyvfrO6yuW6VA==
X-CSE-MsgGUID: 4mh6Sv7LTdS8wFPifqkeEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86007017"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="86007017"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 17:41:11 -0700
X-CSE-ConnectionGUID: dtZ2Qr7wSCikzCDDCR8zjA==
X-CSE-MsgGUID: 1LwfnXFqQyOljaszV3EtoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="264142778"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 17:41:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 17:41:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 17:41:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 17:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRUJiqsSptnfsNGC3hVjD2czMyY2fImVz4562jKWyTrhKrnBlXeQ5ACxTbKcmvbheMdTGycOkuPf7J3aohqU0HuCLK1PuCgme/3l9e1/e9hbuJpK0p71oU1yErnTDUQhqCHYHyIPpQ6er1g6x9+07yhO8rYFfGt0uRcg/tlHoY1tfh+KtjKpa5zyJvYnS/sf6JXPKkyPbd3NL0EqKUsF7edJYNoxKgF9V869d8RDNjXzAbRaXh6PMhnyEUetCjud5COcHVptFhBMjnijoHB421uCdNVEgLusMFEX0pNfakeR6IydGwvx/lZ0VcgGvzQIT2SdE1cLGev8nvX/hFL9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00zlNwuSJ3yHDbKq/JIk/Mkga29esrmwMV2ljRfGfFI=;
 b=BVsBchXhBt+UP3GvWoblM9R1ZYPLucj5TTTCuKN6XZCur6AYAA1ZtsmupElm6LV29fIYOYm/jVZ5jrSssGvY9K5daimI5ou9qc0ZzlP7xbfEP+Igji5WlR5tZQEKeJk0sWCKJKhR2EBL2TS3ORnfQTGM2DHMcf62HaS6w3OGUAludkOwGawfmMlJzaNL7jNQUsfkIGGGArEzOydXBwcYhytcSUbEFrgevze5AR2XZo1nNduElLO7VVi0yPURHH57OwLQ51nmTWZMSBvWI1uSp/4d8II2fxTwg2lJ3hPIClKJYVYM/gbEVvF6XPX+TfIyogmBv0RJCxr7/WjvVI/Bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9)
 by DM4PR11MB6333.namprd11.prod.outlook.com (2603:10b6:8:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Wed, 29 Jul 2026 00:41:08 +0000
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd]) by SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 00:41:07 +0000
From: "Knop, Ryszard" <ryszard.knop@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: Re: Clones with fetch.bundleURI slower than standard, full clone?
Thread-Topic: Clones with fetch.bundleURI slower than standard, full clone?
Thread-Index: AQHdHuqxrR0XzP7ynk29cRx0EjbXULaDoLUAgAAHVYA=
Date: Wed, 29 Jul 2026 00:41:07 +0000
Message-ID: <c7a623675de5f209876336f29d9983610a906ddd.camel@intel.com>
References: <008c6f4742d8e20124ed21d191178ce6db29aaa5.camel@intel.com>
	 <amlF-ZepjtCZz1YE@fruit.crustytoothpaste.net>
In-Reply-To: <amlF-ZepjtCZz1YE@fruit.crustytoothpaste.net>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5663:EE_|DM4PR11MB6333:EE_
x-ms-office365-filtering-correlation-id: 5a2dfe5f-c675-4ae2-7a02-08deed0a144e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: qdKJcRdG5hahfPPbSf1sQ2F0SX7QU6LMu9tmZg+KYm4+60vmb0vlapNfjpSAQccz+nXDoULY70jvjRpdbkgM94p2KFuzvOoYp5m/6S8Jb44jwUBe6/ovQgL+dWwivB833T8oNR68rrkrseA/n+sgJZi68zOIM9yjdVMICbBNk3yTKgQm2P9QRtHyKUAiKGwgpZaFLDYtST9j9cBQ6E1hrEflBqqfQpVHh0OJR44/jBEvrxHLkPE14FQ2zgbZ5RpeUpaiWkcHMxMgMdGI8L0vbo6ONEAxDUeUQPVfwe6hHcjAJGDpjFWLQwqJ2Ht/lPjjXcE11l/wZsqnoAQD9Xi75RuYDGBN6XClxSDeqluBItsLq/ADl3YUt0UDLUEYVqh6atTFChruOWld62uz5FXEPtV76LmcWq8yMQgu9pqxaNeJ0UTqmfvhoI4PwpErsSf1Mzb3PJjocJIQ21BVt+cmOIg59FJwmQgY0zNMacIEPucshqO36/XlnVxKv9EwbQZr8ktQTtDcHxYZz7YW8YSvz4uqdPf5Y+5Dk8HXe/3d8q+bFxFGhpGo1Bq3r1gLvhgbrMn88ygJPhoRtdH49YyJUJHnB9OXFJvBWJGsGo7aEn13tYs4vfFwdweqkyveigOnSPa5dIjH5vW6F0MeILovXilArCxRGFTcVIbESczBNNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5663.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zkkxc1dnRmVHYjdzeGt4Vit6MlhXU0pGb0ZpL0ovb3QxT3FQMkdTcnVsZ0ZE?=
 =?utf-8?B?Z3hlL2FyTDc1dUhXcjIzcmJvTnduZFArL3AydG8zS1RRdjd4L2cxTjBJSVh1?=
 =?utf-8?B?WXJjM0JkMG56cHQxVXIrL29BcFZycW0vdFMyaVNSUXZoQ2F5YS9CbEFuUDdn?=
 =?utf-8?B?S3JYdGJLTk9kQ3FVVm9Eb1hGaUgxdHF3V2NySHNIRTUvWlEvODJPRjNlc01X?=
 =?utf-8?B?dFFrSjlXQzVHQkdSRDlQeklNMTU4czE1eHkwM21MRjZDUkpCeHFMR0dVMXlC?=
 =?utf-8?B?enQrSEZtdU0yZzVLajhYbmVqdktQUEdYZ3o4WkprQ3hHVm02Y3BFbmcxbHVE?=
 =?utf-8?B?em9sZTFYc2p0U0RxSlFTOXB5ZDE1L2FKQjM5NkxtSS8zejhET3hZU1VVUTVL?=
 =?utf-8?B?YzM1TEFPRmg0a01BRWI2TDRMckpNK2huR3llbFVqT0VuUy9XT1Z4blNlQ2tK?=
 =?utf-8?B?Z1ptL0dwRTRKWlVFRFdlenExcVBaNnVSTkROdjI5NGhtSGlIeVdZTENzS2RT?=
 =?utf-8?B?VFZLTmpGaTd3RFNXUlJPblJYc0hwNkZHNGozTWNRUVdibnMrbnhya0pPN3kx?=
 =?utf-8?B?cDNOSW9idTVKNERXSkFEVnBIZlJNMXc1My9hUWdtYTQ1dXQrQXRZNG1sbXpI?=
 =?utf-8?B?dkp0KzI4dzlGajUzbXMvUllMYTNESHRWMnpaaVlNb3ViVlozek13S2hMVC84?=
 =?utf-8?B?ejFJL1ZpdHlMRnVNdnZ6ZFVhNzd3NnZJOTBwZ0xhN2hDdEhGMzhNYnpoaGlw?=
 =?utf-8?B?aEZhL2VGR2gxYmxTdWtuSTg3bUwraW9EWnJaTmxiOFRieC92SGIrbkdYVFMx?=
 =?utf-8?B?UElyb1hXemNUYjhQOWErUGxtUHdKKzR6ZEVaQzVPaHZOWUZrb0ZLTjRBbTNs?=
 =?utf-8?B?czdGbzVDVHI5VXJTTWNqNmhmT2puY0FSRDRxOFg2SHFtdnFvLzJDMCtXOTZR?=
 =?utf-8?B?MElUaXNtcGkrK2hVSElETDF2TXJMUEJHUXB2U05VVmFzMjBPQkIvUjFONTY4?=
 =?utf-8?B?MzVKQ2NGWWZNN0VCbHV0cDB6UHg0Q0FIemg2VXlOUWowZ2szZmZYRDZBN0xV?=
 =?utf-8?B?Ry9ZSUxEUHRleTNJZ0V4WTUvTFVZQ2tYZXJ1U2l6Q3dwWVBwWUc1ejFmUjZj?=
 =?utf-8?B?MTB4c1phM3d0Y2RCQXhZT2xERmJtQzc3YUhhRUFkVTh5WUVkaHFqTkZHT2xq?=
 =?utf-8?B?bXN1OTRRMExPcVJuOWZSdkVwY01JTHhCbU9HcGduSDI5ODRrbU1tdmo2dThB?=
 =?utf-8?B?K0I2N0M2bWFEaWlmSWVPRHZFYXhBT2RLRWxvUGlCTENTQkV6Q2pFNHhvbHV0?=
 =?utf-8?B?aDBYK1FXSS9NMkt1Z0dqbE5kcGtUOHdXcU9PNUUwWXFnTmFya0d0dnJXcUlw?=
 =?utf-8?B?Z3BYYnlRa3ZBQWV0RXZJdnhOYXprbStpWUJzbHhXeElyQVFuZi9tT3ZHdTgw?=
 =?utf-8?B?YXlZRmhDaHdSQ093NGZFZVBFdjhWZjJjdHhvQWk0b3FycTRaNHNOaExJYzlE?=
 =?utf-8?B?VGtQNUlRR0ltR2FnRkhidytiU1lWWW1hanR0RzdiV3NKc2k0bzNkKzJHQjlq?=
 =?utf-8?B?WFEyRU9RWlY1SkZUTU8zR2pWeE1helBtNlB5YmorbnJCYWwxQnJRSUM4VWZh?=
 =?utf-8?B?S0h6S3d1ZndvbHRDcWVMNmZuRXA5TXBrRnNscy91dEhDRFdoTGtKMmJYQXdO?=
 =?utf-8?B?V280REZSZlpWOXpFMHZIVjNyN0Q4N0tISUdaU200SCthbkF0UWx6L0thNHFu?=
 =?utf-8?B?T3ZYcDYxU0Fpb0FSNUovUjJtajBhTE1nMzRLTmg3TE5hcFpmT09MREI0K21I?=
 =?utf-8?B?bGt6RnRMM1A1Y3dVUjlENkRCNGlZNlZsVTI0K3ZJbU1NeWE1WTZteFdqc1Zo?=
 =?utf-8?B?NW55MkhOZHlaTEtlNUhocUloOW1rYW9GSGF1ZWVITzVad3JoSVBUN0NvTGFj?=
 =?utf-8?B?dXdPNHQ5L0pybWRrU0V0by9HaGtMeFdBdEFSVXZRbjdpVEt4ODhqK25CYmVJ?=
 =?utf-8?B?SFNHTU5jdndjYVZlTzJsTmMzOStEajFsZFBDT2s4VTM0SkRhRmtoLzQzSmhY?=
 =?utf-8?B?SzNkRWRGTDU1cUJCQjR0U0FTeVpzWFVmWURVRnZYQVl2ZTRWbnRNZ0Yrd3Zj?=
 =?utf-8?B?WWFNVGVVaFk5K2w3VGwwQ1h0Z1cvL0tDcSsxaFRVZTlFUUZFOTVxdnZRQ25C?=
 =?utf-8?B?alN4RGh2VFduT0RtemJ5MHN2TVRrODZKUm9mdjhjRys0eFRWR2g0NnFvT21i?=
 =?utf-8?B?TjFKSm0wWXdoRWhmOE81cnFlU1R0bzZieFFXRG1kWm5YR05NRVQzK0tlNThr?=
 =?utf-8?B?dDN6MEpmRDk4dTBjbHpzenNZcWFnNVNxd2U1V0JtNGMvZmcxa2N3dzcyK2NY?=
 =?utf-8?Q?0CQaTC1pKSEUeFE4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A0BAF5933135D4AAF4F872D9BCBB8B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ajcfkrR7A+hcsESkEg5HUVtiFVhEmpW8GY1HuXDeMdKdX+zEK4E6fMczlQ+iCIpLcpuLpbYw94NNug/jga/pawajxjbYGKwJqXPFbeQaHMZ2FvppxzeOyLnEy/O7HnULI91dwd98xNxA0OFhPFH09KGf8+64EsBm9SfOTQeZepSgUe+N8+g1xCIcG9p2IYuA5yb+hvZh1jsYxtg94paLU5hA3BzcW3a+Gi2cVzHFsYlf3M9Pp4DX7oFFdcxE94M9HJdki1iA+ScRmHtvlBZsWiyeZNAGr9G7kdGHITOio/GxC8IeYS28p49LEh7cYk156v7EnUanFdbb8ImmJBIRYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5663.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2dfe5f-c675-4ae2-7a02-08deed0a144e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 00:41:07.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFKVcaHDk7/FEwZZU2dayNaevSuucRkEfT2Q2+R8MSpHTtwnE1LpuKQYHaydET6G0dM8YUnzbyOUN/q8+xyBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6333
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDAwOjE0ICswMDAwLCBicmlhbiBtLiBjYXJsc29uIHdyb3Rl
Og0KPiBPbiAyMDI2LTA3LTI4IGF0IDIzOjQyOjAzLCBLbm9wLCBSeXN6YXJkIHdyb3RlOg0KPiA+
IEhleSBhbGwsDQo+ID4gDQo+ID4gSSdtIHdvcmtpbmcgb24gYSBMaW51eCBrZXJuZWwtcmVsYXRl
ZCBDSSBzeXN0ZW0gd2hlcmUgd2UgbmVlZCB0bw0KPiA+IHBlcmZvcm0gZnVsbCBjbG9uZXMgb2Yg
dGhlIGtlcm5lbCByZXBvIGluIG1vc3Qgam9icy4gQmVjYXVzZSBvZiBzb21lDQo+ID4gam9icyBp
biB0aGUgcGlwZWxpbmUsIGl0IHVzdWFsbHkgY2Fubm90IGJlIGEgc2hhbGxvdyBjbG9uZSA6KCBT
aW5jZSB0aGUNCj4gPiBrZXJuZWwgcmVwbyBpcyBsYXJnZSBhbmQgc2xvdyB0byBjbG9uZSwgYW5k
IEkgZG9uJ3Qgd2FudCB0byBwdXQgdW5kdWUNCj4gPiBzdHJlc3Mgb24gdGhlIHJlbW90ZSBob3N0
LCBJIHVzZWQgZ2l0IGJ1bmRsZXMsIHdoZXJlIENJIGNsb25lcyB0aGUgcmVwbw0KPiA+IG92ZXIg
YSB3ZWVrZW5kLCBwYWNrYWdlcyB0aGF0IGFzIGEgYnVuZGxlLCB0aGVuIGluIGpvYnMgaXQgZ2V0
cyB1c2VkDQo+ID4gbGlrZSB0aGlzICh3ZWlyZCwgYnV0IHdvcmtzIGZvciA8UkVGPiBiZWluZyBh
IGJyYW5jaCwgdGFnIG9yIGEgc3BlY2lmaWMNCj4gPiBjb21taXQgaGFzaCk6DQo+ID4gDQo+ID4g
Z2l0IGluaXQNCj4gPiBnaXQgcmVtb3RlIGFkZCBvcmlnaW4gPFJFUE8tVVJMPg0KPiA+IGdpdCBj
b25maWcgc2V0IGZldGNoLmJ1bmRsZVVSSSA8QlVORExFLVVSTD4NCj4gPiBnaXQgZmV0Y2ggb3Jp
Z2luIDxSRUY+DQo+ID4gZ2l0IHJlc2V0IC0taGFyZCBGRVRDSF9IRUFEDQo+ID4gDQo+ID4gQ2xv
bmluZyBhIHJlcG8gdGhpcyB3YXkgdGFrZXMgNC01bWlucy4gVW5wYWNraW5nIGEgYnVuZGxlIGFw
cGVhcnMgdG8gYmUNCj4gPiBzdXBlciBzbG93LiBOb3QgZXZlbiBmYXN0ZXIgdGhhbiBqdXN0IHJ1
bm5pbmcgYSBmdWxsLCBub3JtYWwgY2xvbmUgZnJvbQ0KPiA+IHRoZSByZW1vdGUgc2VydmVyLCBh
Y3R1YWxseSAofjMtNG1pbnMgZm9yIGEgc2luZ2xlIGJyYW5jaCkuDQo+IA0KPiBZb3UncmUgY29t
cGFyaW5nIGFwcGxlcyB0byBvcmFuZ2VzIGhlcmUuICBBIGNsb25lIG9mIGEgc2luZ2xlIGJyYW5j
aA0KPiBpbmNsdWRlcyBvbmx5IHRoYXQgbGluZSBvZiBoaXN0b3J5IGFuZCBvbmx5IHRob3NlIG9i
amVjdHMsIGJ1dCB3aGVuIHlvdQ0KPiB1c2UgYSBidW5kbGUgd2l0aCBtdWx0aXBsZSByZWZzLCBH
aXQgaGFzIHRvIGhhbmRsZSBhbGwgb2YgdGhlIG9iamVjdHMgaW4NCj4gdGhlIGJ1bmRsZSdzIGVu
dGlyZSBwYWNrLCBub3QganVzdCB0aGUgcmVmIHlvdSd2ZSBzcGVjaWZpZWQuICBJbiBvcmRlcg0K
PiB0byBjb21wYXJlIGFkZXF1YXRlbHksIHlvdSdkIGhhdmUgdG8gY29tcGFyZSBhIGJ1bmRsZSBj
b250YWluaW5nIG9ubHkNCj4gdGhhdCBvbmUgcmVmIHdpdGggdGhlIHNpbmdsZS1icmFuY2ggY2xv
bmUgb3IgYSByZWd1bGFyIGNsb25lIG9mIHRoZSBmdWxsDQo+IHJlcG9zaXRvcnkgd2l0aCB5b3Vy
IGZ1bGwgYnVuZGxlcy4NCg0KSSB0aG91Z2h0IHRoYXQgZHVlIHRvIGNoYW5nZXMgbWVudGlvbmVk
IGluIHRoaXMgcG9zdCwgR2l0IDIuNTAgYW5kDQpuZXdlciBzaG91bGQganVzdCB0YWtlIGluIGFs
bCB0aGUgYnVuZGxlIGNoYW5nZXMgYW5kIHRoZXJlIHNob3VsZCBub3QNCmJlIG11Y2ggb2YgYSBk
aWZmZXJlbmNlIGR1cmluZyBpbmRleCBwYWNrczoNCg0KaHR0cHM6Ly9ibG9nLmdpdGJ1dGxlci5j
b20vZ29pbmctZG93bi10aGUtcmFiYml0LWhvbGUtb2YtZ2l0cy1uZXctYnVuZGxlLXVyaQ0KDQo+
IA0KPiA+IE9uIG9uZSBvZiB0aGUgYnVpbGQgVk1zLCB3aXRoIEdpdCAyLjUzIChzdG9jayBVYnVu
dHUgMjYuMDQpLCBHSVRfVFJBQ0UNCj4gPiBzdWdnZXN0cyBtb3N0IG9mIHRoZSB0aW1lIGlzIHNw
ZW50IGluIHNvbWUgdmFyaWF0aW9uIG9mIGAvdXNyL2xpYi9naXQtDQo+ID4gY29yZS9naXQgaW5k
ZXgtcGFjayAtLXN0ZGluIC12IC0tZml4LXRoaW4gJy0ta2VlcD1mZXRjaC1wYWNrIDM5NDMwIG9u
DQo+ID4gYnVpbGQtc2VydmVyJyAtLWNoZWNrLXNlbGYtY29udGFpbmVkLWFuZC1jb25uZWN0ZWRg
LCBhbmQgaW5kZWVkIHRoYXQNCj4gPiBwcm9jZXNzIGJ1cm5zIDEwMCUgb2YgaXRzIHNpbmdsZSB0
aHJlYWQgZm9yIG1vc3Qgb2YgdGhhdCB0aW1lLg0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGws
IHRoZSB1bmJ1bmRsaW5nIGNvZGUganVzdCBjYWxscyBpbmRleC1wYWNrLCBzbyBpdA0KPiBzaG91
bGQgaG9ub3VyIHBhY2sudGhyZWFkcy4gIFNldHRpbmcgdGhhdCB2YWx1ZSB0byAwIGNhdXNlcyB0
aGlzIGNvZGUgdG8NCj4gYmUgZXhlY3V0ZWQ6DQo+IA0KPiAJCS8qDQo+IAkJICogRXhwZXJpbWVu
dHMgc2hvdyB0aGF0IGdvaW5nIGFib3ZlIDIwIHRocmVhZHMgZG9lc24ndCBoZWxwLA0KPiAJCSAq
IG5vIG1hdHRlciBob3cgbWFueSBjb3JlcyB5b3UgaGF2ZS4gQmVsb3cgdGhhdCwgd2UgdGVuZCB0
bw0KPiAJCSAqIG1heCBhdCBoYWxmIHRoZSBudW1iZXIgb2Ygb25saW5lX2NwdXMoKSwgcHJlc3Vt
YWJseSBiZWNhdXNlDQo+IAkJICogaGFsZiBvZiB0aG9zZSBhcmUgaHlwZXJ0aHJlYWRzIHJhdGhl
ciB0aGFuIGZ1bGwgY29yZXMuIFdlJ2xsDQo+IAkJICogbmV2ZXIgcmVkdWNlIHRoZSBsZXZlbCBi
ZWxvdyAiMyIsIHRob3VnaCwgdG8gbWF0Y2ggYQ0KPiAJCSAqIGhpc3RvcmljYWwgdmFsdWUgdGhh
dCBub2JvZHkgY29tcGxhaW5lZCBhYm91dC4NCj4gCQkgKi8NCj4gCQlpZiAobnJfdGhyZWFkcyA8
IDQpDQo+IAkJCTsgLyogdG9vIGZldyBjb3JlcyB0byBjb25zaWRlciBjYXBwaW5nICovDQo+IAkJ
ZWxzZSBpZiAobnJfdGhyZWFkcyA8IDYpDQo+IAkJCW5yX3RocmVhZHMgPSAzOyAvKiBoaXN0b3Jp
YyBjYXAgKi8NCj4gCQllbHNlIGlmIChucl90aHJlYWRzIDwgNDApDQo+IAkJCW5yX3RocmVhZHMg
Lz0gMjsNCj4gCQllbHNlDQo+IAkJCW5yX3RocmVhZHMgPSAyMDsgLyogaGFyZCBjYXAgKi8NCj4g
DQo+IFNvIEkgd291bGQgZXhwZWN0IHRoaXMgdG8gbm90IGJlIHNpbmdsZSB0aHJlYWRlZCB1bmxl
c3MgR2l0IHdhcyBjb21waWxlZA0KPiB3aXRob3V0IHB0aHJlYWRzLCBydW4gb24gYSBtYWNoaW5l
IHdpdGggZmV3IGNvcmVzLCBvciBjb25maWd1cmVkIHRvIHVzZQ0KPiBvbmx5IGEgc2luZ2xlIHRo
cmVhZC4gIElmIHlvdSBjYW4gZ2V0IHRocmVhZGluZyB0byB3b3JrIGhlcmUsIEkgZXhwZWN0DQo+
IGl0IHdpbGwgcGVyZm9ybSBiZXR0ZXIsIGFsdGhvdWdoIEkgZG9uJ3QgaGF2ZSBhbnkgZXhwZXJp
ZW5jZSB3aXRoIGJ1bmRsZQ0KPiBVUklzIHNvIEkgY2FuJ3QgcmVhbGx5IHNheSBmb3IgY2VydGFp
bi4NCg0KT2hoaCwgdGhpcyBpcyB3YXkgYmV0dGVyLCB0aGF0IGhhbHZlZCB0aGUgY2hlY2tvdXQg
dGltZS4gVGhhbmsgeW91ISBJdA0Kc2VlbXMgbGlrZSB0aGUgcHJvY2VzcyBzdGlsbCBoYXMgc29t
ZSBzaW5nbGUtdGhyZWFkZWQgc2VjdGlvbnMgZHVyaW5nDQpwYWNraW5nLCBidXQgaXQncyBhIHBy
b2JsZW0gZm9yIGFub3RoZXIgZGF5Lg0KDQo+ID4gSXMgaXQgZXhwZWN0ZWQgdGhhdCBkb2luZyBp
dCB0aGlzIHdheSBpcyBzbyBzbG93PyBUaGUgYWx0ZXJuYXRpdmUgaXMgdG8NCj4gPiBqdXN0IHBh
Y2thZ2UgYW5kIHdvcmsgd2l0aCB0aGUgd2hvbGUgYmFyZSByZXBvLCBidXQgYnVuZGxlcyBhcHBl
YXIgdG8NCj4gPiBiZSBhbiBlbGVnYW50IHdheSBvZiBkZWFsaW5nIHdpdGggZXhhY3RseSB0aGlz
IHNjZW5hcmlvLg0KPiANCj4gVG8gYmUgY2xlYXIsIGl0IGlzIGluc2VjdXJlIHRvIGRvIGFueXRo
aW5nIHdpdGggYW4gdW50cnVzdGVkIHJlcG8gZXhjZXB0DQo+IGNsb25lIG9yIGZldGNoIGZyb20g
aXQsIHNvIHlvdSB3aWxsIGFsbW9zdCBjZXJ0YWlubHkgbm90IHdhbnQgdG8NCj4gZGlzdHJpYnV0
ZSBiYXJlIHJlcG9zLCBzaW5jZSB0aGF0IHdpbGwgZW5jb3VyYWdlIHBlb3BsZSB0byB1c2UgdGhl
bQ0KPiBhcy1pcyAod2hpY2ggaXMgaW5zZWN1cmUpLiAgRXZlbiBpZiB0aGVzZSBhcmUgaW50ZXJu
YWwgdXNlcnMgd2hvIGNhbg0KPiB0cnVzdCB5b3UsIGl0IGVuY291cmFnZXMgYW4gYW50aS1wYXR0
ZXJuIHdoaWNoIGhhcyBzZWN1cml0eSBwcm9ibGVtcyBpbg0KPiB0aGUgZ2VuZXJhbCBjYXNlLg0K
DQpJIGtub3cgaXQncyBub3QgaWRlYWwsIGJ1dCBvdXIgcmVmZXJlbmNlIHJlcG9zIGFyZSB0cnVz
dGVkIGFuZCB0aGUNCmNhY2hlIGZpbGVzIGFyZSB1c2VkIGluIENJIG9ubHksIHNvIGl0IHdvdWxk
IHByb2JhYmx5IGJlIGZpbmUodG0pLiBXaXRoDQp0aGF0IGNvbmZpZyBjaGFuZ2UgYWJvdmUgSSBk
b24ndCBoYXZlIHRvIGZhbGwgYmFjayB0byB0aGlzIHRob3VnaC4NCg0KVGhhbmtzIGFnYWluLCBS
eXN6YXJkDQo=
