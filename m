Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92F3B27C6
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785282129; cv=fail; b=sHQA7XRoBZtnkuBn5neDBxWls2o7jlDUYZAdV1fpRbra2nCualBHD+UmfADA9g4RzQ3BVubXOaMum3CLepPMj7xNCy27kxujr+7+IQPQlaxidcfBqhnRdRx/t4Y37D2X6141y0/JQm+z3boBRtIFdKjeo/eaAkjSYA41VnE7SiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785282129; c=relaxed/simple;
	bh=WBG2bZrYx1JmKbxh4ZQAtzMH/v3TW0BD4K7gyjn+i4g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tCG2CLbAmQ9JaF539az0aVV8kfats4jjYcXLYlAHuedWzZHCc0Q5HZwJDYApvlVrZvnw/eepgQzXj61pJh/+A8KqNAX/1fp/2RpIDHGpF8eoe2VWMDll5nq9MMIKHo6hN6hoCdB6DGHsjtiE6qfR3ukC6FE3UTBmA+vMUSmZv98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ory4M7ma; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ory4M7ma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785282129; x=1816818129;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=WBG2bZrYx1JmKbxh4ZQAtzMH/v3TW0BD4K7gyjn+i4g=;
  b=Ory4M7maiYy3Yxk6slvhxGZ6aLTP2VPRyNmbwuDo2fIbVYnmgXGU9y73
   ZgBRXFGQX5wa/ny8zmpZEsM/B77+bWkeSB7P8mtCLIl7LYuls7os+ipyL
   FAUVHf5tvDi/3bgCINgWnb6YtOjopDS1kjEbd2CQIxHUCIBFFkMnpz6QQ
   qilYEoJAyezvgxT7B4e977wutmUsFX4yd42Yq7bKNxuIEjGlwLy2WmuoL
   WJR2lYNHCDS2wZJ8YdQ36QUzAB5xuhNc9EfKWS1+3ZmIqlHb6KReW0f6N
   1kso3dRXUTdK2HD7/GKneDhQBgO4AbMY2HKotk1/CsSUHglpRALKAVz7E
   w==;
X-CSE-ConnectionGUID: 0NDS9wJ7QZ+cR/w6RKtunA==
X-CSE-MsgGUID: A74IhqfERoe/l/2YW+ZDZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85896167"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85896167"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 16:42:08 -0700
X-CSE-ConnectionGUID: DjL+33hsSoeAFhhSkbxjGw==
X-CSE-MsgGUID: kgWlE/SBT+GbgdAaZaBmmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="264129187"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 16:42:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 16:42:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 16:42:07 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 16:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icQhn1PJvZ+9EN3g+OraaveTSJafNiNsj+3cRN3nIPPrMIwF8PqW5nwVPsW6OuCX4SbdFRfw/tY9kQTPAoO77qlbdbaz1jDuvA2arH7msuWZzTIfdmT7bIjsufqXWu4kFbOq04XWQrOiDDgoFi1oD18YPW4Mpcx+HCW7FY9r7Fd0MYQkOv86Ww/o3K6twEIcwrd/rEbR7utLL5hE220N/Ic9MIvV+F+vpgAa3qf01jdKZyFw1hOImTL2BGNxJdqWBgh775iUzEDfuJR3vNajNYatsfx+8Y7F78gpvPvzPhAn3+d6dtaH9BwtreZWLteEF67m4khYhIEh3I0bd4t+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBG2bZrYx1JmKbxh4ZQAtzMH/v3TW0BD4K7gyjn+i4g=;
 b=SP55y4ECJybEstzjNozwsVh9mIC7qQn4dT0NY/yLyAlxnQUN1JiLj1brspM3z+wqanDDdJmiGIxecPr8TDSVpM4cE+dCk/mw5hp6x2VMWo32KQHO6txAZDV8qv94Sf5khwRizVc9isXcLlTXnJPKFnVXaGuKkpTmoKFYAJAmqNwc47HSle0yz6r9HwBuT2KNvbpZw+8gyx4Kdlru9oQXXJq80ZMUJUSSm5TFYz9Ev3HJiOoTQYqROTwJWzX+qMf3L2kRc4Goqs0T8XsljDFgn404zyIp00Soy9Uo52HLsVrruE9PPauX28aoawY2qwgOgUFDPb2ubZ9h0UzvpT4PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 23:42:04 +0000
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd]) by SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 23:42:03 +0000
From: "Knop, Ryszard" <ryszard.knop@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Clones with fetch.bundleURI slower than standard, full clone?
Thread-Topic: Clones with fetch.bundleURI slower than standard, full clone?
Thread-Index: AQHdHuqxrR0XzP7ynk29cRx0EjbXUA==
Date: Tue, 28 Jul 2026 23:42:03 +0000
Message-ID: <008c6f4742d8e20124ed21d191178ce6db29aaa5.camel@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5663:EE_|IA1PR11MB6396:EE_
x-ms-office365-filtering-correlation-id: be615ada-7b9e-4abc-feab-08deed01d3ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: F+BtXwz9Nd+1wQt53h5WzKJism5z0OgbEm72K3JuRLT7/PqOWbb2oe+/CMC45nbVCf4V0sKTxU4Bpzn8Sf0Ycu3BYs/KTmGgwtQ3C8nAWXMgzbNJSCNgWPRWj8Hcd+LKHzkBnzlJTwQO3MYYbUS8+UleGdBCGOHDofZfzK5vgXp+GkP1JLwf9pGoL7LBGxItfnXVQMT7edC+xjJnjCH0Rx64jPli9OTp+3z0bUJ0a8UC4doRlygYzzFppjqFqoWgxH/C+EjwQmRbjaztwKx9M2hRUPPusONrhFK4S1OPvWP59UcZqCqwRzNRytnAByKz+esPNJS6cvGb5CoSYcWoX0HnZsQR+1j24AAqgwO9XJ4l4qr/5CJqAl2oH2LfYjJQd5cs0mzOitrpLZMm+YKC4oAICTRuKMps4rFPbfs3qZVv+4MdYxhRxBWmZvfVGB10h7ne1jyH3mwsCBWqde1VoKHyGW9My40BzkA2vBk32zXF5QPaLB3fLuo6ujk0fV9HoE37+N1kRFOkXJ3i5lfL7MVot6xRXh84qlny+jIiDb2xd5BWq2X88RaovH4O7WBglyVIHwMhlVqXjNVg7AMyZ8dwTjgTc0t92pIMTz3LPncTODgEc3QFnP0fisRkUKpYnnr7QeaAtkrW8blm3x/e3Tm74BVwLARa3QHT8uweJkUndeGe4iPO0hB+mMg0K7B9/+Ir8CGS7uskABrpSOVE0SS1vfRPNnhddWTx33OX1XE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5663.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUM5Zkg4WlBWM0JZenM0Y2lUYnVpZlpYdzZXNlMvSG00cFRNcUlFRjNIZmJh?=
 =?utf-8?B?NmhUM3k1ZDdsQnNua1dwc2QxSHE3dW00dllKZUU3bi9Tc3lON21nWWphakdG?=
 =?utf-8?B?cUl3Szcrd1FCZGo4U0JNbmRvazdBVVovSTFMMmtZVHI0VndObFRYcFVRSTNz?=
 =?utf-8?B?WDh6OWxlT1VKcGozRE9uZVVWVnNONVJ4NzYycWJwY1Y4RzVzQXgzYmVFbW55?=
 =?utf-8?B?RWEvZUU4WDFRUzJZWXpSQzNTNWw5akozTVNnbzVIZWo1M1o0Ymg4Nld0VmhZ?=
 =?utf-8?B?djBwNjhONHJtelc2QmkvV0xuUUdiNlo1enNxOWM5WUhsNWJscHFYUUNTU1g3?=
 =?utf-8?B?Sml2YTVjUllzYUVWSDNtOFF2Qk1CU2pndTIwSk1JQVJoVUxzZzRqOG50OW84?=
 =?utf-8?B?a1VWOHhYbGNoczZNOHZRVVIrU2E3bitBc2pFSFI2bGZHMkVCV0lXZlhra1hL?=
 =?utf-8?B?Qkp1OUFLQlh0L1J6R3YyVVVHa2MvcEN5bHlyeUFCaVlrdWJYd01ZUUZoRWxB?=
 =?utf-8?B?bCsyM21PV0pJTjkvcmVVb00wZnh2UXViMWNFQTZhR3p0WlVpOFBudkFtRkRj?=
 =?utf-8?B?OTVmek41Q3hPUUJCTG0wdmZESnNrcHhpcUF1TWVHR201a0FSUjFtUTdqSUl4?=
 =?utf-8?B?WkJhSDBhdnlWOTNzLzI4TVpyem8rYVNqTEZTMnNERjYzcXdMTkV0Y2tLMXBD?=
 =?utf-8?B?TVRMSkh5OVhOekxsQ1F3VFVnckdPcVBBMVR2M2tQQzBoRnFva1JTODlrMElx?=
 =?utf-8?B?M3k1NHpGN20vekw5eHpwTEJxZFlLNGh6LzdyRzQ0MWtXY3R6ZDVSWGhmK2pB?=
 =?utf-8?B?U0RoWFhxZHc1T2tNWnU2NXpCbU1TMytrdE1LVW5XZDVTTGtLMFUydnYzcWgz?=
 =?utf-8?B?Q1Q5cWJTOWt3RnJOeHpMekJ1amluWUVoTkRuTzFrRURxVDhNU2Jqc1BOaUNl?=
 =?utf-8?B?VTJRSzQ4WXZLZy9RWS9CNVhObFkyY2NoQkJNOEE0OGdubHBNaG5WUjhCZXdn?=
 =?utf-8?B?aW1kMGZnM05HclRsdGx4OVhRTjhCbnNEN1R0RUZIdE91TlF5cUYyQlRoWWh4?=
 =?utf-8?B?Q2Y4d0MzZGFpa01rWm1pcHZiRUZBSjF3OFZyUDdVaVI4SElEeDZKcWZScVpZ?=
 =?utf-8?B?eGJSSXlHSjkzSFFlQ3VTRVM1WWZMeklZMjRIV0h4WDgyK2sweS94ZmZ4bmhj?=
 =?utf-8?B?MTN0WnVyNThrT2JCbzFwWU8vRXo5TlhhcTR5NUZoais5Q2ZoTG1kL3dZODVl?=
 =?utf-8?B?MHlxYk5aLy9NaktnMzZ0RnNtMi94WDVKQzJqSHJVNHN5MnpxenhYWExaNVJE?=
 =?utf-8?B?dk1xRkd6a0tUYnREMFlIdnRkVGRRUENKbEdPcnhJK1BGSHpPMVE0a3dWb3ln?=
 =?utf-8?B?U3ZoZkNUUytNcjlwdHV5Ni9ia0tvK1oveVRJblB3NEpoOVF1VzEyai9uR05U?=
 =?utf-8?B?VGxBRi9raTVVQ3ZQUTN4UFZsbEM4anloRzdZOHgzM3M3bkVzNnJFajVMVSs0?=
 =?utf-8?B?Q2xWSm1SNUJHV2d0UE13NTN6R1NMVmhhVm5zZ255T2JGdUd3UlI5ektieDlN?=
 =?utf-8?B?Yzl3SDNxbUJlTXFEUzN5WGJLYStDSHE3ZVZiWUVpK0YycU9tTTRySjFaTldl?=
 =?utf-8?B?RGthMHYzK0l4RDd0TmIveDFkbU5FNmh5WHFhZGdlYWxKRjZKZXJmYVRZWnNv?=
 =?utf-8?B?bU9vOFlLZlV5ZkNXdlJnOW9WM3IrSnhtOFZJZVp5TmQxVy9wRTlTMVdtL2Jj?=
 =?utf-8?B?YjljVnNHbkpLMVVaTCszRE15a29BcU5sRldiOFFvZ0tkL2lzemdZbm02ZStn?=
 =?utf-8?B?bUhKNXFHc3JHbjdhc1hjMVNhVDVybTY3TVFwRFVBR2crV3ZVcitsUFBPQ1Ay?=
 =?utf-8?B?TWRQeWc2V2o4ZUdVRGIyTmxRUkhBeGZqOVg3S2dSczQvNEJjdUpQdVBmT0Zn?=
 =?utf-8?B?bVpjOXVaRGR6T0VQcnYwYm5CaFhvcG5aWWZzOUFtM3ptTGRNOEhuQjlmMi96?=
 =?utf-8?B?azVyZ1U1aExhMWVxQm9xNXVZVkQvbStIQjh4TG5wNXVVYnVMU3Q1SGtlRXk3?=
 =?utf-8?B?RUNpSTBTbWxBNnVyM2g1bGdrZEEvS0JyTjZXK1hmM2VXWGRmSW12UUtlcXdr?=
 =?utf-8?B?aEFlaGVib1NVRHRTckFtK0ZiOUJ0TUJRWS94eW1xeGxOa2ZvUEYwNXo4Zk0y?=
 =?utf-8?B?WlBjWlFpd0lGZ2VWcVpOVms0VWJRMjNVVTdRZ2NtZDR6c0ZiLy9GUWpYRTZ5?=
 =?utf-8?B?djFZZ3pSbXdVK1BVNXVkNWU2VVV2YkpDOHJzZ3VtR1hPOEtXVUY0RHY4dTZn?=
 =?utf-8?B?VmtlSXZQWWgrQjJpVlEzWjhWaHlTczJuN3ZUaXFvODBhYTZOa3B1bktoSDNa?=
 =?utf-8?Q?E9iSewOjNUNVYDOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A2F21AC70DD244A886D4F47D639E738@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P8nhHmp+j8xMSX3mJRY9MSc7zI6sBrfzrleVlSX4esrilbXjjsegtio0je+eZMAyl9efosD0TlWwI2ToxdoI8QfOP0WBwpx3K42Nortov2Zr/AnoheSTzUchvys3xDTbS1fL7UA7xMBUeIQb7BCgVju4Ks6vPNfl/o7ZvrTf38fGM76zUoB4FfQvKhrAyQlG5lCDk6E74U15DNyHHUQE59JiuCETtw6Ml8PZPVaEpa9aSXtRtwnEeG7BVvw0rxR3qJlDrg3tB6qLeJcFTJpJ/V0eqjUIBZ7UhYv52mFh0bvAL1Wvi9zQvSk0twwdH4eXRegdIvq9lROP/kHYZoYrQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5663.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be615ada-7b9e-4abc-feab-08deed01d3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 23:42:03.5618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUaVf8RHNk/Ez+OwAdheSNlqWWPOAp5jV0f7zL0Rukmh8a/aCQF/8f9tqjPGno+58WX5IBhy1+3gzZ/p0d2jZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com

SGV5IGFsbCwNCg0KSSdtIHdvcmtpbmcgb24gYSBMaW51eCBrZXJuZWwtcmVsYXRlZCBDSSBzeXN0
ZW0gd2hlcmUgd2UgbmVlZCB0bw0KcGVyZm9ybSBmdWxsIGNsb25lcyBvZiB0aGUga2VybmVsIHJl
cG8gaW4gbW9zdCBqb2JzLiBCZWNhdXNlIG9mIHNvbWUNCmpvYnMgaW4gdGhlIHBpcGVsaW5lLCBp
dCB1c3VhbGx5IGNhbm5vdCBiZSBhIHNoYWxsb3cgY2xvbmUgOiggU2luY2UgdGhlDQprZXJuZWwg
cmVwbyBpcyBsYXJnZSBhbmQgc2xvdyB0byBjbG9uZSwgYW5kIEkgZG9uJ3Qgd2FudCB0byBwdXQg
dW5kdWUNCnN0cmVzcyBvbiB0aGUgcmVtb3RlIGhvc3QsIEkgdXNlZCBnaXQgYnVuZGxlcywgd2hl
cmUgQ0kgY2xvbmVzIHRoZSByZXBvDQpvdmVyIGEgd2Vla2VuZCwgcGFja2FnZXMgdGhhdCBhcyBh
IGJ1bmRsZSwgdGhlbiBpbiBqb2JzIGl0IGdldHMgdXNlZA0KbGlrZSB0aGlzICh3ZWlyZCwgYnV0
IHdvcmtzIGZvciA8UkVGPiBiZWluZyBhIGJyYW5jaCwgdGFnIG9yIGEgc3BlY2lmaWMNCmNvbW1p
dCBoYXNoKToNCg0KZ2l0IGluaXQNCmdpdCByZW1vdGUgYWRkIG9yaWdpbiA8UkVQTy1VUkw+DQpn
aXQgY29uZmlnIHNldCBmZXRjaC5idW5kbGVVUkkgPEJVTkRMRS1VUkw+DQpnaXQgZmV0Y2ggb3Jp
Z2luIDxSRUY+DQpnaXQgcmVzZXQgLS1oYXJkIEZFVENIX0hFQUQNCg0KQ2xvbmluZyBhIHJlcG8g
dGhpcyB3YXkgdGFrZXMgNC01bWlucy4gVW5wYWNraW5nIGEgYnVuZGxlIGFwcGVhcnMgdG8gYmUN
CnN1cGVyIHNsb3cuIE5vdCBldmVuIGZhc3RlciB0aGFuIGp1c3QgcnVubmluZyBhIGZ1bGwsIG5v
cm1hbCBjbG9uZSBmcm9tDQp0aGUgcmVtb3RlIHNlcnZlciwgYWN0dWFsbHkgKH4zLTRtaW5zIGZv
ciBhIHNpbmdsZSBicmFuY2gpLg0KDQpPbiBvbmUgb2YgdGhlIGJ1aWxkIFZNcywgd2l0aCBHaXQg
Mi41MyAoc3RvY2sgVWJ1bnR1IDI2LjA0KSwgR0lUX1RSQUNFDQpzdWdnZXN0cyBtb3N0IG9mIHRo
ZSB0aW1lIGlzIHNwZW50IGluIHNvbWUgdmFyaWF0aW9uIG9mIGAvdXNyL2xpYi9naXQtDQpjb3Jl
L2dpdCBpbmRleC1wYWNrIC0tc3RkaW4gLXYgLS1maXgtdGhpbiAnLS1rZWVwPWZldGNoLXBhY2sg
Mzk0MzAgb24NCmJ1aWxkLXNlcnZlcicgLS1jaGVjay1zZWxmLWNvbnRhaW5lZC1hbmQtY29ubmVj
dGVkYCwgYW5kIGluZGVlZCB0aGF0DQpwcm9jZXNzIGJ1cm5zIDEwMCUgb2YgaXRzIHNpbmdsZSB0
aHJlYWQgZm9yIG1vc3Qgb2YgdGhhdCB0aW1lLg0KDQpJcyBpdCBleHBlY3RlZCB0aGF0IGRvaW5n
IGl0IHRoaXMgd2F5IGlzIHNvIHNsb3c/IFRoZSBhbHRlcm5hdGl2ZSBpcyB0bw0KanVzdCBwYWNr
YWdlIGFuZCB3b3JrIHdpdGggdGhlIHdob2xlIGJhcmUgcmVwbywgYnV0IGJ1bmRsZXMgYXBwZWFy
IHRvDQpiZSBhbiBlbGVnYW50IHdheSBvZiBkZWFsaW5nIHdpdGggZXhhY3RseSB0aGlzIHNjZW5h
cmlvLg0KDQpUaGFua3MsIFJ5c3phcmQNCg==
