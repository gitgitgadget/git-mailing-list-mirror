Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F51DDA24
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971740; cv=fail; b=HJU1SdiC8uSQ0Xhgubpom0rv11GWsvYwh3KpOUXjNTBDROpoF1ZX7CHgWPRtY3K2J4OPx5EZ8RqviGZkZy+mCj0+ZshsOnyYSmehK1xmKjzox2IIJG3Ft7I3PeMDEQauzSKaNa6EoQxExo/RyLEoctp3mzXSRgn2xWA+LU0gjOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971740; c=relaxed/simple;
	bh=/FSTDyf59e0aiHnK08L0+DRAOfOOhYnouKQkLheu9MA=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=toHZZmShkcnXMlJc1YPlDVqstcVBZQ+4K5TTi/pGJ9DCUjz9YTwp081+DS3AwDA+6L2/WaJIeDf5oRgPQDrY9Xvn4QmxUusdmENEcOzoGOe6VEDv9DKVYhwQUUvPJDu1ub69hmfa+BWU3k5e+J2fIYVx6mlrRJVEKkYD8O+okt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDEG0Gal; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDEG0Gal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771971740; x=1803507740;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/FSTDyf59e0aiHnK08L0+DRAOfOOhYnouKQkLheu9MA=;
  b=hDEG0Gal02lPMGJlc2WrHJhbAFIlLMJVGhOPOnGBACzxcUOg/oFkM6Os
   J+1JmPixu4QJf0VONW/kCm8+9Kfltr5JnqcqxxAZyeD7ocWCWLrDkCu5p
   ItZs4KC+CT0YhdAuue0hQ5EqSqHyJ89FzlwUGQB4e8IuhCKtxADnVfAlT
   f7/QFZSaK+xGzBlP8ZinzLlORbLvR35yHAVxA5AhHsiP7PBOrjHqS28B9
   TlZpfbwTN9GwRpAyMaYxJxvWyNxOMnBpymqWnAfI3Nx/XWKVVXeuuVJb3
   6QJQDbsifyX+fXUbsQq00jJpGHOP5sguO9+GncV8k2UqAVAyNwqxSOs/L
   Q==;
X-CSE-ConnectionGUID: fJL2egS3S2Sn6u9I5jV33g==
X-CSE-MsgGUID: JagocXV1TuyBe4fbn9RIow==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83323632"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="83323632"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:22:02 -0800
X-CSE-ConnectionGUID: +yfpC+gWS66Af+mablXQIg==
X-CSE-MsgGUID: OHE4DxOrTaiOCqRvZ6pTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214869155"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:22:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:22:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 14:22:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRYM7dvwPqBXQaiKCHLD2X1J7a/Jzxad3eLC5t/Yrd2nfVUUQRhYuDsO8uGjZjlt+/MctEXyOFzSZlxNmlx416/tRvPkRRNmxDBBQJ0JYlZX1tZQkz2NGnZYtxsyJmb0to5BJBcvcGecsf3Z6yT7QhcTfmhDhu7VTxBRHNCvNB8TGoKny4SOIPj3wcd9hBFG18k5x0PdSSV1QOtJ6R6r1tZuZ71iRZYnTWNU/7vRjSnjBS3NVb80laZOYryx4T5tqSILkDO/4urkEMHCOeuvS6Pr7gK2K3o6ADJ+hXGFCBfle87QYXH3rOKGRJa3WbY/aKJ/6mGywWKRb6QCCK6+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg8RPEfsaOKC5rB39mqlsXCSnVZ0GHOTYSZ0HI6FBSA=;
 b=mMAaO3YDrGUM9RDtcjC51H2XhIeNVSSB5Osnfq5EydI4sKKsYPHnfN94aUiTIduXaRWhhfI5063Fiu71K+q70Bn+VtMSKhFYYDnJLIw3MTKBSclrCvLMRFSfQ/qpme3RU1fkthNc3HaGq0uacJqVpWRjAb7KSlagRNXWYE/lgc1Kc9yY8JiM8GyjrwAHVecyG40P4HCSz4bKJfOfSQQEzS+emxQ1kmfELkaSBAkV4MCgeyD2Z6u4Uw+ZqlBwBOkAKroY6hiUzL+mFbPffNEGQmZVnLbMurcIdo0U7pEDBZ3Oky6QQGemeJYgalc9jzMExfK3jS3ImSyvM7zHSFP1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by DM3PPF7468F7991.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 22:21:56 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:21:56 +0000
Message-ID: <00ce69ee-0f1a-4569-a19b-b426a5e475e4@intel.com>
Date: Tue, 24 Feb 2026 14:21:54 -0800
User-Agent: Mozilla Thunderbird
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 1/4] help: use list_aliases() for alias listing
To: Jonatan Holmgren <jonatan@jontes.page>, <git@vger.kernel.org>
CC: <peff@peff.net>, <gitster@pobox.com>, "D . Ben Knoble"
	<benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-2-jonatan@jontes.page>
Content-Language: en-US
In-Reply-To: <20260218215737.1181147-2-jonatan@jontes.page>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|DM3PPF7468F7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0c5c19-5c06-4c66-dcfe-08de73f31eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWJHQ3RIRHZPYlF1dXVPNmRxbzdBR01zOUMzNklxTnR2aVJuZHFsQWVhakVz?=
 =?utf-8?B?SWFRWUh5WUtvTXhVNEUvZUkzQkdQb0l3UGxMWjJPYmY4c3pPY0JQZ0pReDZ3?=
 =?utf-8?B?bjFwb2JhMnU0NVhGL1ByenExNDVQcU1sSjRiaEIxSmhZSG5FY1Y3SFhjK2NB?=
 =?utf-8?B?ZkNNTHBtRDBYSUhCdE5UTmpNS0ZnVjRTaTlFZXVFb3dPODBtOUk4bVVkS2kw?=
 =?utf-8?B?eUtLWkxXMlZIRmgxOWVDWDNMUGd4Z2YyTWpLZm5NcjNQbnlBL1RHNXpwZUky?=
 =?utf-8?B?UVNYNmZHblIrWFVYVGZkREN4OUFSUUVLaFBJMlArVFFZdTRLOW5iUkZGclFP?=
 =?utf-8?B?WThSamJTck42NFVqVzFheW1sWlFVbC93RVl6TW1RUG5zai9kMWl6akpwZEJL?=
 =?utf-8?B?cUF3V3RrTk1IeVVKU0hKV3BHc2VOSDlMNjVtUzlLOW4xSWtKN2RGSlo0TWpY?=
 =?utf-8?B?N1RXaEU2SDd5K28yTUtTbGZzbnFtUUZCaTQ0Q0pmQ1NTOHAxMGgydlYvcGJQ?=
 =?utf-8?B?QVBVVXFleVRDeWdxcFVXRWRwU1hoaUJZSGlScFVIV08vam1sdlZ4Vnl1bDlp?=
 =?utf-8?B?QjRhT0RqeFVzdFZzcDJkeFBYSW1HQnpVNGoyMUwwK2x4MHEyWCsyK3pOT05p?=
 =?utf-8?B?TW1DRnNuUzczUGFWV3YzMXJxNk5YUGkweDhOU09JcG5zV3NmYndhbVVsSk56?=
 =?utf-8?B?ODJlS3lRc2FOaUtXenk5QTUzYkY0dnZ4K1dQTmlETGVTbTVHcC9BWWZoL0o0?=
 =?utf-8?B?bkNKdEQxLzhwcjEvKytIcnU2REwzZXdCVDJGVnBCSWl5a2U5QnFWMkhRbmRL?=
 =?utf-8?B?eGZOQTFZNDdsWEo5ZmNPbkhjN3pabUlMQ3pCV3NPMitHVTR2M2RxTE4wVm5Y?=
 =?utf-8?B?NXRScWRJOUVXOWplQnhBZis0YWdHM2ZIMks4WEkrbzVTdjA0eUtxOUtLSjVC?=
 =?utf-8?B?QWxJSEFDN0RXVFJ3NnRiWnF4UFJtbm5lUEVyTE1hbmY1Y2JtRk1COFplMysz?=
 =?utf-8?B?QkJOWXdEMU03WkFQc1BWbjRHamdmc21qOFFCL0NLaXVsNExkWDJSeXplRVo1?=
 =?utf-8?B?cUFYajNudXFqeHFRYmNIK1ZpUE5FOWpnU2lSWnAxRFIrT1MzQzZvMGhqZVN2?=
 =?utf-8?B?Ym9KQ21KZzlGTE9QOXFFdDRYSS84OW5KeGwwa0picWR2RXk3RjJPUTIrQWJp?=
 =?utf-8?B?MUxvZlFQSE4wdWMwcldLZzdjdWwvTTNPYjBBZXdldXozaGJPb0NNMkdhQWo1?=
 =?utf-8?B?SWVlZFlNMkZHV21CeFRCM08ySDRVWkNXRXl0dFA0Vkkyd0tTTzJLQmpCVGdZ?=
 =?utf-8?B?QktzbHlpUmUxY2lNN3ZLMFExNEN6UG5VQ3p3WmJ3MklmQ3ZuZkxOeTJUM1Z6?=
 =?utf-8?B?b3czNDFyZ0l5NDlTRlVEYlNNM2dUNURVUlBPMWRTNWFVR0dTQkhKSTBVckx5?=
 =?utf-8?B?eFYrcUcxdkc5ZmFRSEl2dkp2U0RMYkZQWlN5djhGZ3NHeGxoeERXMWVmd0F6?=
 =?utf-8?B?c091enBob3M4VkZwREdkeXNaeThFVENFdFpNMTYzNi9Ja280REtmcmUzMTBT?=
 =?utf-8?B?bW5Yc1Z4RElIZHZKS3hPK0MxUnRQUzhXbGswQTJmb2RwZHFLKzNtTCsvbFJT?=
 =?utf-8?B?ZWphaG43dk11VDRadnlrK3R0bktRa1RNNXZlSzRodCs2aVVuMHBwMThCVVJX?=
 =?utf-8?B?YWRlWlF0bDBDdStHaHBkcmI2b2g2Z1hvaXI5TVMrWktXK0taVG5XNDl6YXlJ?=
 =?utf-8?B?dWNvMVlKblBmMWQxNjNrdVkydGV1QWdldlhTN0FmTlppL1Y1dkFtdHVkVUE0?=
 =?utf-8?B?V3VRQmNqSFUxT2diVFoyYlU5UmExaVhnN1VUTE5FR2JCbUYvTytzZ01YOHpZ?=
 =?utf-8?B?cHRIU1JqN2hHVmQvNVFqVC80bE5hVVBuQmYwMUpjSHRadGYzZWlpcWIwcEpn?=
 =?utf-8?B?Y0s3Yk9mRUxtR0FiQlh5WFFBemlWTXd3MGw3Rjhiek0vZFNFdDB2ZkNhclFs?=
 =?utf-8?B?cmNERHhVZlVOTWhRblpIdjBIR2pEc3UxbHV3Mjg1K3NobTBwMHo4Rk9NUWd0?=
 =?utf-8?B?T0JxT1hONXlqR1EvclpZMWlheGhBQWRndXlJOG8wSlBvL0V4amNJL2FqZ3R6?=
 =?utf-8?Q?AaBM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW0zNUxMbm5BdDh1OGd1bkJqZGxLMEFVNmlQajdrV3JIcVhtWXpnZThudlJu?=
 =?utf-8?B?dHVvNVR6SjhBRXo1YVlYeUNvdmJ4SXA4cUtwcVl0T042OFNOenZMeUxOeDBw?=
 =?utf-8?B?YmdsNHllY1FMclpNcm5tSG96cUFFTjNPbERKdVFWN0g4dkRzTWhJazYwSCtU?=
 =?utf-8?B?eFdGckFPUUFRTlc3SHBHL3IvYUt2QVN2TG9zRHlRaDJTVjF3UVZleDBFYk5i?=
 =?utf-8?B?V3NsVmVWd0krdVhYWDdlNDMxL0NGUklsdUpuWklKa0xLb1VBb2JpS1ZucVdw?=
 =?utf-8?B?OGc0dkhuUkQ5dG9MZU9wVUZqc0pmeTk0Y1RwY0gyWHhjWWVTekpwNDR6cXFl?=
 =?utf-8?B?MnZWUFQydWRLS0lpWWlyaUFCR3JhUnBiR3pCR2pOV0tnU3NLWWdKYVJzZVpy?=
 =?utf-8?B?UGxtNmUxenpFblRKM2ZnUzlkaFRoS1cyT2NiL2RRdlVJWHdtYVhZQVZUTFhF?=
 =?utf-8?B?SC9KWXhBUmZyS2RRUk9zdTBkbmJYcitnM09ybFNudVBNZzZaSUJ6QXRyajFo?=
 =?utf-8?B?UFh0cXoyOC8yUThHd2ZmM3RlQytUZitraFVrTFdRRnlocVRRd2RLNWRuc05O?=
 =?utf-8?B?SWpHN0o5QnNmaURlRjZ3QXBpQU15aktwM3RFaGVjRTltZytuSDZFY21ZTWpS?=
 =?utf-8?B?YnVsWDR3ZFVUVEFRSzFYWTB0aFcrdDVLVVVVMUhhYno2RHJpZUYxL0piTlBl?=
 =?utf-8?B?OEtXS0FKTGRoeVlnZ095bTNEcDhFcm5pME4xRmhONjJoMzBqb1BtK2xmQURi?=
 =?utf-8?B?NWFJZWpzeC83bmJIOHJ1SU9IZGNnd0xyRXQvZCtNbTZVc05LS29COWxVeXBq?=
 =?utf-8?B?c1VibnpOVTEzUmsxREl2U1lQRnNveFc4QUdPMFlWaS81cGdUMHlFVGdvcXhU?=
 =?utf-8?B?ak96a2luS0lzR0ZMYTFCYlVZZlUyWHNYdVVRaHRldTUwRWhVZFluOWRqbXFs?=
 =?utf-8?B?cGdVMjZoajJ0UktOTnBaV0tpbzRsV09VRFlOL2Z5ODdHMFVBckx1dzRYNnZY?=
 =?utf-8?B?Rnl6clpod1pPREUybklCQXZSOTNJWmNuYzRCVlJUSzFOcVEvdklaQTJhYVZE?=
 =?utf-8?B?UHRvY2NZeW5xMlMxc3VWTHNnSjR5ajBQMnd2eEVJckhkeXkvMTZmeWEyQVpU?=
 =?utf-8?B?T3l0Z3I3blEwcGtMYjhTMjA5S09jOHZmaWR2aEV0bUdPUUF1akI3WHQ4eno5?=
 =?utf-8?B?ZnhQNTlQbVp3b0UrSUVRQzhnL3NYN3c1Qy9Qd1RscmcrNUdkRmtnaHZuZk9m?=
 =?utf-8?B?ZFlPcFJwOElpbml1TUxtV2NDYnFJa1FIdlVYLytneG5Ic2tiU0Iyb1h5dmFQ?=
 =?utf-8?B?aW04Zzk3M2lPMHUyZ2ZybEpWQ1FHeXd1TWo5VzNvdWdwbHFuemRTc1hnNGZx?=
 =?utf-8?B?cm5tUnNZbGZTZkVMTGd4M3BobnpGUmVFQVZQdUF6RTgzbmdjclJ4SWloK1Zk?=
 =?utf-8?B?dG1zTEZNRk9waWtjVzkrbTAzcW1ZQXpoSm9PZHZLK0VNTzR3MTJDN0tZV0xw?=
 =?utf-8?B?VVVUWTBYblhweFBNaUpPNVhDTXRpRCtoVExjS3QzSlRZNGpNWjhNY0k0OXJE?=
 =?utf-8?B?b1JWdXJOVXVBekxEdldZdkdCajV3cDdSbVZDT0lwcnNXcnNlMHh6RGlTdEgx?=
 =?utf-8?B?TnI3N2xtUXprWHBYRGQva2VvNXdZM3ZYejBZV3lIL1Evam5RMDdydStnY2NO?=
 =?utf-8?B?cEE3eTgySW9nLzAvQnV3TU5IcWtFTXhZaDBhVzJxOVNaR3dVSGlRNW9xZ2R0?=
 =?utf-8?B?UzVvc2QvVjZZVkRSK2pnWnJIaVo5UktQZXRkaUxnNXhIcVNIdzltVk50czU3?=
 =?utf-8?B?Ly80L3FTSUpKNHh3Mjc2eGQ1R1ltTGRBOTBmSWI3KzlMQTBiVG5CNDZCaDhI?=
 =?utf-8?B?WHJkWURrTlNpT0VBVmphc3AxYTFRT2JGYmp5cDdYZHlZTm5hbzQ5eGFxUmlj?=
 =?utf-8?B?WERCbnloMnUveGxOK3V0aW4rRDB0a0RuMmROVTZ5aXoxK05TcWtTU1d6VFZx?=
 =?utf-8?B?OUhJcWZFUldGVnNIb1NXak1acVgzanZLdWVrNDZEOTJNNWJNMEkvTjFkclFh?=
 =?utf-8?B?QUhoSURweXNMeG5nS2FmOTJGQlRWMFZFdG1VckowV3R0d1JtSDY0S21tZGll?=
 =?utf-8?B?REw4NklxMFZlSnhFNllveUU1TmFKcXdsNTB5enpjUGJkK2JWVkpFdnhsQUdV?=
 =?utf-8?B?bm5QbmR1LzRhUUErbXp6d2MxeE16dmErWjJwaXFuYldOOUZDS1hzNS9wNElH?=
 =?utf-8?B?RXgrWmRGZ0hMa3RIZVI1Tk1hdFZHSDlydDlFMTI5cFlyS1pVNjZFVitqY2FP?=
 =?utf-8?B?OUZkMGNPMXIxTWgvM2FsVW1NaFMxdi9nZnpPcUlxS3BPMmVXcTdtQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0c5c19-5c06-4c66-dcfe-08de73f31eb6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:21:56.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMSG6gd4HP50fAxoKS1vIGlKJEZTOTT7x4LNYgn+EvKgvtbYnf/S7oXgsTbzQhAzGqG+2JVc2viH1yyozw0qmRh2ewH2ND3ny3bVpYlzSHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7468F7991
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


