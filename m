Received: from smarthost4.atos.net (smtppost.atos.net [193.56.114.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF83EBF1F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=193.56.114.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895278; cv=fail; b=AtrvDJV0MqUmKyz4r6kcb4qy4WUlCXElYPunOjOoYjem9yMF73TMOxHmkVQdpY2eic5XaPQs2ZKm9mDw77RhiwEyWxQADIrsXNpP0n4lJLkpXT5ku8rDRkuvLSNVxLMp2mEbV9qleYZ6i+wHA4WOuzyKLdDDHFBdGpUysrGlRCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895278; c=relaxed/simple;
	bh=ViKtwe6ddyTBXh69lXoifcesXdtTp21E9t9Wv4q/bE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EH/1nQX0f8Jr2eegv/FbG2aJ5e9+cN0c2l/xdfvW1l4zXWG1Hbr0CuBV20gDyZt3ikWDnDwoEBVBk9QZXvWrJhh4ROqxXhdwefOZNQC0Je1qFa/IjO/ENbbn8GBp+dz1cRhqobUMdY4Bq1UHz12X0QDBi24fWXZ2WLRXInkRolg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.net; spf=pass smtp.mailfrom=atos.net; dkim=pass (2048-bit key) header.d=atos.net header.i=@atos.net header.b=Q8r3O4NJ; arc=fail smtp.client-ip=193.56.114.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atos.net header.i=@atos.net header.b="Q8r3O4NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail2022;
  t=1770895274; x=1802431274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ViKtwe6ddyTBXh69lXoifcesXdtTp21E9t9Wv4q/bE8=;
  b=Q8r3O4NJ2bELAUPGicSNBTIREX5gftsAlHjzYcNozfGO62hLuxeo3RGz
   YNEWzwpxNxCBs7DVhb2YIbXcsqsVPmL9rPOCwYU47b5NflXRp++kQnkp4
   Avus6tFVuV8xYb5nzwHabRW5hM/HIAOCTOjd7Gbf35cBgv4p3kvtT3NDZ
   V1YmzIAoY8uuroAF/slnTjYEh+fOQDtkzoXl61cYP/KWyNbuqh+fIXo8+
   PsfCelXONyh5BoPrIf6WqAn6AsHfSgd3MnUjxJ1IqxR3Ko458kk/CgAvz
   20p6hgnEq9vku/8joWxvJVVzDXRh68JHF4+EyUea18y0vabLf7LYMZnyy
   Q==;
X-CSE-ConnectionGUID: cIPEIcAMT/ecufcKzA1FZQ==
X-CSE-MsgGUID: hZjVgX5PQb6kMAOc1pD1bQ==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; 
   d="scan'208";a="825777972"
X-MGA-submission: =?us-ascii?q?MDEcoORuxN0zIaHHfB0HDAYTjUb5OdR8Iu0En5?=
 =?us-ascii?q?YBQWmXSDARKjX+bIQnJuRS6W+Pc/Orv1JYo/LDgP4LPsMbrcdBwzbqL/?=
 =?us-ascii?q?nyRgAaXOvW4KXf33l7/LVi0ABGaivTwtheqD/y9Tv1/2shXXm8K4Uj80?=
 =?us-ascii?q?x6?=
Received: from mail-gv1pr07cu00105.outbound.protection.outlook.com (HELO GV1PR07CU001.outbound.protection.outlook.com) ([40.93.214.101])
  by smarthost4.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Feb 2026 12:16:03 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvRVYx/R+dvdrrFdFdPqyb+rnpMCy9hBh7HiJx7aEQiBJ1BaztUGypzV+UXrMDOdhj4jBlKsUPhkyX9+wmp7oBfjAF4NS8dnKocjDNBvi5OzbK0e2+DFEPEvq0GRUUEKmAEjERn7qYbNrnYL5VBQcWzKg+rEAzfONWHks4kJ0Bj693s80VwsyGDQDHy8pmBiczsibfznAdP7yOooNzqDV/gSdI17g76EpClX3DnnaAHkuWYj3KMdB6h4uB3+wlypaSLfyNAnd614dV+zoNVmrnfTiQPyNk65o6Zd1iQNj/xC9z7L95BzQAhL7qESnzfmO5BsrFPvPxgw/wLF9ZH7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViKtwe6ddyTBXh69lXoifcesXdtTp21E9t9Wv4q/bE8=;
 b=cFK31DSyhEideXEze1wkd+qodlvwKHf4KXPDfgfD5qa26e35x83ukI9j9jB4Zxlg34OKVgMQPn/aWwrjcAb1EOrtWhjzzZ1baJQrHfXJQGBdTYr1sKRvxn6v4DtEXAJPcgJFl+RbLr48b0ACi+YHxEZnEFk+NOOLphYYDfpNFblxXbarbZH7XTDL2AiZarIwQeH+8AVV8KkHARyiVknfk1HASiVm9FmrSF7am31PxbSKwQ7Hx/seIKD6gDN93pA8Yi4KsVmtn1QRV8B0evc0gWmUkNC0QglPe8Rx1bAy4Gz7ludpE+//8Qgv8HbwHh+OogJWI06mFte96RjnUk04Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from GV2PPF54105D074.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5d1) by AM7PR02MB6193.eurprd02.prod.outlook.com
 (2603:10a6:20b:18f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 11:16:01 +0000
Received: from GV2PPF54105D074.eurprd02.prod.outlook.com
 ([fe80::148f:e667:81a0:f674]) by GV2PPF54105D074.eurprd02.prod.outlook.com
 ([fe80::148f:e667:81a0:f674%5]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 11:16:00 +0000
From: Richard Kerry <richard.kerry@atos.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "peff@peff.net" <peff@peff.net>, Jonatan Holmgren <jonatan@jontes.page>,
	"gitster@pobox.com" <gitster@pobox.com>, "D . Ben Knoble"
	<benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: RE: [PATCH v4 3/3] alias: support non-alphanumeric names via
 subsection syntax
Thread-Topic: [PATCH v4 3/3] alias: support non-alphanumeric names via
 subsection syntax
Thread-Index: AQHcm5wRBEpLsUnOkEqKz7JCFWG7x7V+6B/w
Date: Thu, 12 Feb 2026 11:16:00 +0000
Message-ID:
 <GV2PPF54105D07420C30078862ADC8F64109C60A@GV2PPF54105D074.eurprd02.prod.outlook.com>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
 <20260211211810.278806-4-jonatan@jontes.page>
In-Reply-To: <20260211211810.278806-4-jonatan@jontes.page>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=62eb1116-6e0e-483f-ba23-b70418fa8f42;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-02-12T11:06:43Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PPF54105D074:EE_|AM7PR02MB6193:EE_
x-ms-office365-filtering-correlation-id: 98d6f579-dc3e-4522-62fb-08de6a281a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2xIZ3dqS1hKd2JrZG1lZWNXejB4eHBmM2tZMmVaRGxob0lMY0xnOHE1cWJF?=
 =?utf-8?B?dmFITGJCNWpWWkRkQ0NXZ2J2RlZMaGNkVGI1ZWxyRnNIUWRRT0pKRER2MExl?=
 =?utf-8?B?S2d4OXNQM05aa04yK3FvTGJzWGRoMm1QdWM1UFE5ODJ4Mk1GVHRoNGI4MHJt?=
 =?utf-8?B?RDR6UlNBUlpwMHVSdzIxUGdnY3phemxJVGc0N3JpUlJOWTBpSzVGakJTMS9G?=
 =?utf-8?B?T2JPdVZhaWYzYnIrRWU4dFJjNi9NbXBhZVNSc0N6bjVnV0xueEJqVXowMk5O?=
 =?utf-8?B?Y1RZSzIyekZsOFF3OU93UEpFajFVL0Q3L1NTd01vTEMzQ0xUR3lVOCtnMkR0?=
 =?utf-8?B?dm50c2ZoelA0VTBocmthTHFFSHYxK1VrNnFSQWliYThmZGwwRlRPa3RIWFht?=
 =?utf-8?B?VXl1ZFRUQ0RlMlY1RmlTblZ1SWp2czlUd29uV3U3aDlKNlRnVVRkREpVMnJG?=
 =?utf-8?B?U2x4ZFNNWGhkY2s5YmpDd3JzWHFxdGo3S0hKM1M3UTYzaDNKaHBOUGtCeDdO?=
 =?utf-8?B?b0ttYW1kK3pYNTk1S1hFRE5SbWFXcmk3VVh2YlM1b3RUV2pFWW0vNUpCZWQv?=
 =?utf-8?B?U1VuOVQ4aVM3ejVCRnluTHNyempFR3NTajB4NStkTHVCb05aR0FiTUpiN3Fs?=
 =?utf-8?B?TU5nbkxOSFZSU1BQK0JsVGlXVm1rTTRPeFFJS0hNUXhYZlF3N3lBTXMwc1RJ?=
 =?utf-8?B?dGRTbkdHU3djSVBKWHZuWExDUFlJV0JRQTd5em1vaXI2U0NoV0NERDREYS85?=
 =?utf-8?B?alpoQWNVUndFMXNiOTdkTUMxQ1E2MllUb1Ezc05rWUdlVENTU0JmZDVOZy9R?=
 =?utf-8?B?YU44cEp0U2FERlZWK1U4M1QyeVlmNCtEMXpYN0dramFkK2V6b29xTVFuVEZP?=
 =?utf-8?B?R0dkT01rYmJlRGxxMFU5OTFIenRxMitQVmhLNEVlMDhURVM3ejZGNE9wbDdL?=
 =?utf-8?B?SHRHZXBicEh0NWRZd2M5dnFXa3pDNExjcWE5S3JYRzNNODYzRlFERTNuTCtN?=
 =?utf-8?B?eUxYUDlMMHNLYWRWRzVwVWY3RnNzYmROOEM5Ym0vVlQ0T2pmYnV6OU5VRWI1?=
 =?utf-8?B?RDc1aStldm5FODRWdXdQUjJZNmZmcitvQlN5NHFwTWpuVHRxM1BYRnZ5eUdS?=
 =?utf-8?B?SEkvTWd1QWZUYXRkL2VmcU9wb0dIbWFCd0l4N0kxVVdBNU1xYTFPc2tHK3Zy?=
 =?utf-8?B?TWRSNEZVeUZpQXk5YzN2amlOOGo1MTFOcFVDRnNnL00vRW1NZjJGbGdleGJo?=
 =?utf-8?B?TW1xZjZUazI4Vy9NMEJ2VHVxQkdxNW50S0Zva25zb1dnSW1uR3lKcXc3Yy9l?=
 =?utf-8?B?RmZnMmswc0xsTGRWTDc2Q0dsR1JiWCtWaDMram55VEk2RVBUMW1vRStXNDBE?=
 =?utf-8?B?MGZzSko3VlZYSFU4VnVwUUtPUElhTG5TRTNlbkl2Z2lyN0luS3IwREt1WUFk?=
 =?utf-8?B?N3VObmZ2akNPbDV4ZDF1VXhwK2NwSkVmaDg2OHB5Tml2ZzhOYW5YazdTMnc2?=
 =?utf-8?B?WTdsYVdkNlVabzBacUdDTnlQdXljb1dRdmVvVTJGQk9Zek5sNnh5YisvcHo1?=
 =?utf-8?B?ODNRaENZSWx4bmh4cWR3TWd4cjZCTTc1THlSU1lyWGozazIySU5DbURkS2lW?=
 =?utf-8?B?bC8rQlpSQTVEa3lEcmM2dmJkWENMT0dXVFBFelJpaXkwdXJuK1pvS0wySzNo?=
 =?utf-8?B?S0ZWZko2RmRSOFRTR1RCenErcjhQb0s5ZGRUVTVLWld0RW1saUNVVmhQRFE5?=
 =?utf-8?B?b3FacXBEdWluczJ6T0kzRW9qZVNDSlNvcDdaQktGeklwZ3ZKbEtlbkpqUEcy?=
 =?utf-8?B?TmJRR056TmVTaTlhd3RyajZjUUVPc3FEVXB4aFk1STEwcE5MNTNBdlBTd0NB?=
 =?utf-8?B?Vk5lMTVkTDBaQzJPRW1HNTdBQjhXSExSVFlxWnJQRUcrNU9kcVR2VGp4Ykdv?=
 =?utf-8?B?VG5PWHFNMkxOUG9MQStpMW5OWVE4RzZUUGl2cDA5NnpXR1lsdDRMZHhhaG5k?=
 =?utf-8?B?YlNpL1lsbDNhTmZoUTMwa0FqQ05QQ092cWJ2ZHZybno5TGR0dEE1RENlT25R?=
 =?utf-8?B?MGNkTEdDci9iWSt6V3o5NGlrc3RuRXU3aE1mU1E4WjhjaXFOQ1UyZUZVQkVs?=
 =?utf-8?B?d2RQZmR6YUVobWxZdk4xRHdNbTNYU2FDcjRqcSt1eml0RW9pY3NzcDZYdThm?=
 =?utf-8?Q?ZvnE3corZIadk0uCLlLn6JI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPF54105D074.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnhVZkR1SHlJR2xyaGtKVVlLWE4vaktIb3Zmc3pRREFSSUNDTXVRK2JyMVZI?=
 =?utf-8?B?L3htMDJoZjhpUkc1T0tJbnJWeWNNZjg1TGNIMjJUNnNoL2YzL2RDVTdaTkc5?=
 =?utf-8?B?VEUvMExLTnMvZXFqR0hVSVpEVlBzR2tVejVGTUdYeFEwSnRKYXpDVHkvUE5k?=
 =?utf-8?B?cndwMUpYUm13a0RFRVV6aVFLZ2FUZUU0aEsrbmlsa3VBL0N5WFIvVjRjOWVr?=
 =?utf-8?B?REY2Uk9meGppeHlwdnhKTi9NRFRsT0FUQVZqVkRVa2JZQXJ3TkFrb2lJREYy?=
 =?utf-8?B?SFBwajR0UWVJSE03VWJoR0dGR2JxU1JseGlDQWw4dWMzSmZSM3NmZXBNenIy?=
 =?utf-8?B?ZnBFdDM2RDVIR3ZWeFY3bVorc2tlMG91dENTYWdpbjFGTk5TOFlsQ0lxcWkr?=
 =?utf-8?B?Tkc4R0RXYWdTU0x5dXhSWmcrVjN1NnFBYnRxaGFQazlzSUdjUjV1emtsRGw1?=
 =?utf-8?B?ajFvazRqNGNxb2YrUkphUHF0OG5LdDAzL0xFbk41N0VTMHM1Qzlzd3U0VHY2?=
 =?utf-8?B?alg2RjhYcE85ajJKNTh3YkFPelZvWm1XcW43Nk8wVkMvRVVrSVhZQ3J6U0RJ?=
 =?utf-8?B?OUNudFYwcHdnbURKa1kzaEJXZXZlSC9CcGRQbWJodE15bW9KakVkN0QwY3JQ?=
 =?utf-8?B?UFovUzlTcjdxUTgxeGRqanFWV0N6NCtEMzZqRTc3cjI0QlpraHJNa1kyeEJh?=
 =?utf-8?B?MWwxSWlYQVl4c2FVd1Zkd25BeHF1TDhRbmJjbHNnMGwrTC9oYmxYQ09yaVUz?=
 =?utf-8?B?Ti8zSmZxSU5iam9ra2RUaExXbFhOSmFNWlNJcTFuVGxrSEdWRFFVd1N5WE9l?=
 =?utf-8?B?RHRUMlMyenhLSURGY3dkdXM3QjkwczE2U0g1NklPYWN1RFhtTGNkdk1pZjNl?=
 =?utf-8?B?VUo5MUF6ckJuSGU0SmRzRUIvZEdlaGhRaEV4UWVEQVYzaVZhVENoa1RkMUxn?=
 =?utf-8?B?dW1SQ0x3VmJEVGhwdE1qVFhUTmt4NVN4NEt4QU5ZRUIwb1gxTXFJSlM5azRz?=
 =?utf-8?B?b3JNY2gyOFEvb1RJanVsY2w3K1EvM0FpZlVHM01pMXcwMUZma3o0NmdzK3RY?=
 =?utf-8?B?QU5iZHBmTTJ5WXEwZWhxQVBGSnNyMU1JakxySVhoUzM5czQvZVJ3RTRUUXpC?=
 =?utf-8?B?NXlxeVJreFZwZHpMekh4amlRZyt6UnlZVENtSUhlWVkvdTJqcUs0TkZsSjcv?=
 =?utf-8?B?K3AyeUJKNjg5UDJvaHp4RmMrMlpNNi9YcWd3KzhtWlYxYVM0Rkl0WExSNFEw?=
 =?utf-8?B?bE5qUmEwbTBONlQvZVh1MGRXdDVWUWlQa3ZrS09pZnRtNUlEZnJhNDhKeS9W?=
 =?utf-8?B?cEJBRHlqU0hDanRmN3JCK3M5MUswc09KWTNJcUE1a21RZWw3Ty96RG9OdFFN?=
 =?utf-8?B?MlY4OXV6MmgzRWJhWnVuQUVZalJ4N211SG9MYUdiYWJYZW9DTEFmNzg5ZStI?=
 =?utf-8?B?d01VRUFWQWVRRGphTnA3VkZ5QWl5aFlkV1ZvSllVWTVUdmc1cTV1dEwyc28w?=
 =?utf-8?B?TmdGcUpwdkkyS2txTWlXekZMSllVK2xxWU9lT1BzNk9GZENuc3ptY1g3MDJn?=
 =?utf-8?B?M1VNdE5tdzZNeXZPZDZkMGpFbHVhSklNU3MwV3RDRDlmRWZPcjJTWmV4Y3Nk?=
 =?utf-8?B?aDdEVHFtbEZMcTF6K3c0elVJS3hWdm1Qb3ljVDY5OUFsUUt0RzFacWh3TjBR?=
 =?utf-8?B?dXZ0UFA2bFduMTYxNEVkS05wa09CRzNmbzRsUUp3YkptV0l3WTF4ekZjMm1r?=
 =?utf-8?B?WEVyWk5tVXhtRHkvYkdyY0pIK1FhUlp6Y1VtN0JVak1tYnhrSFFFQVRIRXhS?=
 =?utf-8?B?NFlMM3U2NE9zZW1xc2VqK1hMSG93azE1K2VXUHB2OTdmR2pQMlBkZFBLVkdx?=
 =?utf-8?B?MXNubSs2dEttWHdidG5xYWs5dWJZdXAyNGFROTJxWTl2N3UyWjlydzhnU0hl?=
 =?utf-8?B?L2l4T0xaTU5Ea1BsSzc2b0IrQlBzclZQUHhHTjNaTkRYQnZ0N080S3dONWlm?=
 =?utf-8?B?c3dHODhFUzVRNEw4anh5Q1Y4cXIrWUM0NGZyZXF5UkhiZFBVUGJSK0dyZGZF?=
 =?utf-8?B?MFRXOVVvd0w3QU5sL3ZOZG1kWGxIOGt3czVzMS81NVNFUzBBVm9kZ3RLNSs3?=
 =?utf-8?B?ZVNFY3Viam91aHFhV29Jd2Z2eUZ5MTdFOGFMVitqSGs3Z2FrZzhYZURNaktm?=
 =?utf-8?B?T1lkNmFaVU5KOWovcnZGMHpwUjVWeVlrc0VPOXRkUThtdjRRRzJCVXVTTCt2?=
 =?utf-8?B?QnBaaEQxREJGRlZnSGFPN2I2R2hqc0MySmg1M05nSUNZMXQ1VHliZVRMS012?=
 =?utf-8?B?V0IrMFVvTWErU1g0WG12SWkzTXFiaGVmQ3RGZHBIUVlIT2ZZQzV5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gdjWSnTnTf+aHJtVTWNBlDDEQkJsjzvnlWjlhZZIxxEnRGfUNl0Qbat3UE2pTVOWBryLcqJOWQceCMoRyrV+D+qdYIv93TeRSIed1qpU+35wwh98GwwcrO0tL4qZb4BXC3ZPiVqNnCRz6sN2uVhXbZUTXXVeDd7KpItRTZDJg6vGj7datoTdt+dp3CqzrzzCfOZ+eVCS4P2VCfj6DPW7/UM0m/ZQ6bSCzDhIlgiFUNG1P4htRX3vjG7A3PRje3mSvcQGuFeifWwvYWIRMbFsBvVd/RCr8wzEmklCBIr93OaRfRe4g1llmpgEo31ygXh8ErL6nbT487+8JyEXGM3ThmJ7d7adz2o5mkDo8cp+H8skKWZ/LHRY2vQl0Kso7iUPZsKz1edar09hufTOle7R+xtjG20LTo7qKP41r9mFLYqIYAbNyh9RgU9j+E1buu56RsCnvF54S/3qrJTcKmiKNTzJyxt6YlOvCcGQWPYLgXbA+/RnkSBcJsKpN89cXTwfCNGKu03FzbTpwU/kPvlqzAVAOUyDBRh7uFk6KTML3UkX1CfaPymC2FBVXJSeZWxLWK3jhyQt28EFyxFB+dZYb9Q6zEm6NNED+Q5IeaAZLK6q3z2MatFCnSVT/Yvli3Ieg+Yc1iXrjZCE3z4BhdO1D4Zkzhvsb91phbVQDKnaawy48l9+iQM48guIoEFHsKKV
X-OriginatorOrg: atos.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF54105D074.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6f579-dc3e-4522-62fb-08de6a281a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 11:16:00.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5l/C4DJYUb5DtmRXAdsXuR5xqGFxC36mNNEWcFjptBrIjUjQlH20jbZ7i3UwaAOeQR3I0/Cv3i1bvr2BcWEmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6193

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGFuIEhvbG1ncmVuIDxq
b25hdGFuQGpvbnRlcy5wYWdlPg0KPiBTZW50OiAxMSBGZWJydWFyeSAyMDI2IDIxOjE4DQo+IA0K
PiBHaXQgYWxpYXMgbmFtZXMgYXJlIGxpbWl0ZWQgdG8gQVNDSUkgYWxwaGFudW1lcmljIGNoYXJh
Y3RlcnMgYW5kIGRhc2hlcyBiZWNhdXNlDQo+IGFsaWFzZXMgYXJlIGltcGxlbWVudGVkIGFzIGNv
bmZpZyB2YXJpYWJsZSBuYW1lcy4NCj4gVGhpcyBwcmV2ZW50cyBub24tRW5nbGlzaCBzcGVha2Vy
cyBmcm9tIGNyZWF0aW5nIGFsaWFzZXMgaW4gdGhlaXIgbmF0aXZlIGxhbmd1YWdlcy4NCg0KSSB0
aGluayB0aGF0IGlzIG92ZXJseSBzcGVjaWZpYyBhcyBhIHVzZSBjYXNlIGFuZCBzaG91bGQgcHJv
YmFibHkgYmUgbW9yZSBsaWtlOg0KDQpUaGlzIHByZXZlbnRzIGFsaWFzZXMgYmVpbmcgY3JlYXRl
ZCBpbiBsYW5ndWFnZXMgdXNpbmcgY2hhcmFjdGVycyBvdXRzaWRlIHRoYXQgcmFuZ2UuDQoNCjEu
ICBJdCBpc24ndCBzcGVjaWZpYyB0byBub24tRW5nbGlzaCBzcGVha2VycyAtIGFzIGFuIEVuZ2xp
c2ggc3BlYWtlciBJIG1heSB3aXNoIHRvIGNyZWF0ZSBhbiBhbGlhcyBpbiBhIGZvcmVpZ24gbGFu
Z3VhZ2UgcmVxdWlyaW5nIGNoYXJhY3RlcnMgb3V0c2lkZSB0aGF0IHJhbmdlLg0KMi4gIFRoZXJl
IGFyZSBvdGhlciBsYW5ndWFnZXMgd2hpY2ggY2FuIGJlIGV4cHJlc3NlZCBlbnRpcmVseSB1c2lu
ZyBjaGFyYWN0ZXJzIGluIHRoaXMgcmFuZ2UsIHNvIHRoZWlyIHNwZWFrZXJzIGFyZSBub3QgaW5j
b252ZW5pZW5jZWQgYnkgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gKEkgYmVsaWV2ZSBEdXRj
aCBpcyBvbmUgc3VjaCBsYW5ndWFnZSkuDQoNClJlZ2FyZHMsDQpSaWNoYXJkLg0KDQoNCg==
