Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0B1C32
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219746; cv=fail; b=uWlBL5f53+PyvaHcz2PtoCy39d9nN09DZon6Mb70OEjiXxM7Mg5LJgci7DrXa7ogq2vdATcFwGIDE5VBDD2xPoCUW4YeRpaAT7TI118CT9V6lWl4GmKA2Er9GVr3EAd94dtZBgMXlEUHpmSpLywhEAUN6QHzdkOLOA7BHFgdz/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219746; c=relaxed/simple;
	bh=f2LRoh0AqafM/CKmc0zELjo/imZEReB08pur7P7be/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpU8wJaOKoOkSa4k5SePxnXMeIuvqWBBQuj2fsAVZbCC8wCt17JWltZJ5g4m5KL8VP+WPP8k3tRIg1Vif2iHrrqe73Do6qeaVABYDJqxoxLOCoKhIpmYs6eW2BNmp+c8q9mYSy/S28Qr4ejIYupuU1f0K/CHo9shb+AiNzi2mGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdGL96Qo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdGL96Qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727219745; x=1758755745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f2LRoh0AqafM/CKmc0zELjo/imZEReB08pur7P7be/c=;
  b=IdGL96QooAuNO8gvs8kYuqFrECZEAuIuNmUftHz/EurXr1J4O/Uo6z/n
   JsxOx4Dh93CFPtPRcfu9wolXePX9RJlzG3fqiAHb719V0kpN9LO7gUKOv
   pztFc9MFFCUvbPyZZxY1cqeO1kZkwnIqapoCyOGqNSOqadnJIKBoehi+c
   ZYyag90+rdJJAykEzmb1NmayyX5vAdWb4Y/jlH41T4DmLHRhc/VMwEDc1
   03wvjOrrm8zUEuxugqm05BaaLwnvQ/sIa7MUhuL3ioTkJKmmVkrSxOWjk
   3fKHwbY9tk0VQkzTmCFQOMOGj2I3iWrMcD7qpglrT2v/E83FtIlRxgTPl
   w==;
X-CSE-ConnectionGUID: 1vEBrfymRgeVnHDY8Dj2AA==
X-CSE-MsgGUID: xP3Cl5p7R/eMATKRDoinrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26113678"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26113678"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:15:43 -0700
X-CSE-ConnectionGUID: n6/GaZwlR265O3J4PPlmUw==
X-CSE-MsgGUID: eu74ZOU7Ri6fOzDU6/EPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="75686400"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 16:15:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:15:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:15:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 16:15:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 16:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDCfSwtzkenLPNTZuzi5TSwKQeoJBEO2ssqdLSddTMmmBEm+0nS3KpwwDL/fIfvQDozGPMCU27BmF+YywniCtbswECn0nbJC9VKBHLJTRY5ux4yTuIWp2Feimx0TGSDl3Un9VYG3edUFfr1zs8QnspfJAxcQqwjdSuQc95eZzg76E8ip8qXjvyzC0W2cLnFrUgY/aYv9pIIWRwfzHVVdb5VgMdoyZrYS6t3kEHH/2phH93E8E+A98fc4rBWV9YtlJd42BdK6+PXC2DCdRZaSV2yztScFTvTPpsPtnFZvCs/dS/96BM0P3Z75XPPK+B4TERYHniZ68p4wpK1TgkFmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS3+3EibmmauMDKwvoXAKXhiCPDfHSVDgMdtXi9pAjM=;
 b=OjP9K9cLOk0fprYn7rbBAlj76+u9pei1hDY10qX6CXoUb4ULBHNsvjF3LsTUf2rAyW4KgcELMQ0kbemJkfTi8uwl30c0XxfT1xslGQ65OpNv+52/bDR5AZRb4fdobhrnpeVlIawogNhYKC/4azUh7oOpLbZIfJ0dtlgUqEzYlBeGXqsztsS/htsscT3hfPeVwwMxaZnezzXBhrmVEnJwCoRsFJXmSlRG72y7UW5j4U2gu3DQM+KCn8yHc2Rgbg6Zhwn/o8SljdAfvIKLvXxW6QpPjgQugP/ROohfz3uBDsaISfk/rGQNfRMp28XtQ7mLqIxQwEs3CHAhKEG2aSz7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 23:15:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 23:15:33 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Jacob Keller
	<jacob.keller@gmail.com>
Subject: RE: [PATCH] send-email: document --mailmap and associated
 configuration
Thread-Topic: [PATCH] send-email: document --mailmap and associated
 configuration
Thread-Index: AQHbDgdm0osytukjkES604gl/E3hprJneRdPgAABDK+AABkPQA==
Date: Tue, 24 Sep 2024 23:15:33 +0000
Message-ID: <CO1PR11MB5089016E24E7142587E3478DD6682@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240923222429.4102405-1-jacob.e.keller@intel.com>
	<xmqqr098rap4.fsf@gitster.g> <xmqqmsjwraj3.fsf@gitster.g>
In-Reply-To: <xmqqmsjwraj3.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH7PR11MB7500:EE_
x-ms-office365-filtering-correlation-id: a56d4109-6642-4914-990e-08dcdceeca81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iqkzR2WkdPATfLtRNydeJUj0yTSza82/DGZ0OPICqDBRee41YfWu782trYJA?=
 =?us-ascii?Q?femredM5WOJ4QEvjzCL57s/CIpJgWu90Y2WqGPV3bw8PIrGPzHb6E3LJsA+S?=
 =?us-ascii?Q?EV1H0LR7szEaeb2AYdTng5CKxWIoMG4MMtMeVEW5mOoML2oMNVAzbrXh/Hbq?=
 =?us-ascii?Q?CRVahwWjijTpZAKGMFDc0f4K31Y0lNYJbr/FSdWKtd70rElR6ATFpas2sdQa?=
 =?us-ascii?Q?hlVaBLpG4Q48sceD3ajibVKfgMVDg61SnPkfew02dkcjcswxQm/6fgazZRi3?=
 =?us-ascii?Q?9KrmI75CZu7uPbx14ETRUiJv1YRONp675IcD+1fkIlOUW875UvaaJdk5HPbB?=
 =?us-ascii?Q?Lp68EoMMzzOvoDcB+3YEMBYhWRoN45cw1yjPridlSz8s939clG6UtCbaJjoq?=
 =?us-ascii?Q?IJalCrn2UiQLP5AZEWgagUYG6+3mwwLdZqxMX1UoUzsfm2WY+vmsmMvRfjNc?=
 =?us-ascii?Q?QKB1LXB9l/b8ncnxEhx1HCsFQdILi7abcfuRM7R088sZpC06Xe7H1SxRtz2q?=
 =?us-ascii?Q?ppGM07dBOF2DLUTqm9XMxkPgdgqWmTv1zWv+W40e8qR9ix6zRRuZKfG32p9J?=
 =?us-ascii?Q?z460LdPiJa6tnaKBCxaO63T9DHidez883H+/iLlqRVFqiUrWTMGLtU0bY0gE?=
 =?us-ascii?Q?+WgCKdhVX3Vsu4J0/BYX7xe2cWJKcIKjpLuHOYEX5Y7PLpr3GOexxHoFVFKw?=
 =?us-ascii?Q?j9+DWUuh8s8jH3faCHOVKr7DCg369k/aypshxOidbrG/w1SQPs0ivKCxMDCw?=
 =?us-ascii?Q?T1QpSN/1KD8uh3X+t7GTzu0KFW418GRQphUnG55cts7tDSHwtazJiNSLX9Ts?=
 =?us-ascii?Q?uZfRupLqQ3o/ml6ksIavmt8kGqGMzrLMJ6b6BmhTGwx0W4GwnSwELg8GzRWp?=
 =?us-ascii?Q?VyMEel4keWn/Z4HOf0dTC5h6YGfVnUBhZCAdRO1mVkh9NvaRqZ/84Xk4zbvb?=
 =?us-ascii?Q?GgJ+1qZ1MDTvmSLpFbsHvGg41jB/j2jOjM3lA6E4pbFN1L26PaA2fuzYYVPr?=
 =?us-ascii?Q?ctN90MH+tINnr31VByG8LEo49Y00bLHZApTEjRCPsC+2G/fkkpoosnU07w65?=
 =?us-ascii?Q?6bD3LY8DJMh5DG4a18BZRXnckyB5m0zjXSUu6Qo1k9nS/wd7SGY4drNJQ8HX?=
 =?us-ascii?Q?LxnSfY2iOlRFhaS0Wr1FD9DLq/J2YsWawlmlusLM4ezj6h/N3H0oUxc00vWz?=
 =?us-ascii?Q?EC1tidI2EtJCzuXhkPt6hCwrceIhgrnaZ75t/DFBeo33PVKpmC/jjYQJndZf?=
 =?us-ascii?Q?WBbkYyUNnfLIqdUqBFfZ/QERL5ExxJQIDNQTxPhHuFl1oiCECrrFxiZrGF9F?=
 =?us-ascii?Q?pgFHWBiSefdk6HbA0ELIJrzzeBqzmNwa08hfkdYR1e3QzdEb4J0VZYqztetK?=
 =?us-ascii?Q?qYjlJxeNRr78cQs370atD3IlG7ZLZ0y+E40tWpz8Vtg7BSnK9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gwwxcuHH8TpmeuvnOA18lg+fjaCk5bQRlar5FkhuA/X7o7vbM//3Hzk41ie?=
 =?us-ascii?Q?rsg3dMPyz4l30A4DgTf1Vzc0/DsM6MR+VTx1pCtdBJPlxV+RHB18r6Nn+JI2?=
 =?us-ascii?Q?y2+kilmwkNF/MBjQsGPStNMTThMUi2o74IxQcZAUJLWpz3X55oyZM40+AH4K?=
 =?us-ascii?Q?t/95X8BEbMyvu2ojXhCg5xBr423FrZZx1NN2nrYkJLS3RItSWgb47XG6x0sV?=
 =?us-ascii?Q?B3T05r+Px8+C6Cnp5JHZ2HGZ2JLBnXpz8DzsG//0cyX7LoKiq5XKWz5ntvck?=
 =?us-ascii?Q?jKkn5WtW8l1xOKY+ydCDjZnSRfMa5ZKxeHurx4gop/ZcaSw0bNCWhkYnze5Q?=
 =?us-ascii?Q?ht7z/e0H1Vu+F/Rfde3BP1wITCE8tQMLyCiCGIJJyUZDVM/o5zMCit0u7SQG?=
 =?us-ascii?Q?r9EsLhKCKSRoWQQABLL0qxVJonRbJvgpvPvlBOMkIgqeo5QIagLlAMLKaJtw?=
 =?us-ascii?Q?EYv17sC6XZHMi7cX6f3fqzJxZOgYc0RJVrk0qDJRdU42cKx7NlRAR3u/mCWF?=
 =?us-ascii?Q?+MCzuC6BhjD+jfI8oqHvNApaz9D3isPRD8UBlU+zSyqfVgrWxNMLWjCqgHGS?=
 =?us-ascii?Q?LrAd8CXAW3qYo9EbUNUl3C0wrY56ILj3HXs+ZgY8xdCNUv1gNwehJTyQO7WB?=
 =?us-ascii?Q?Y6JYelVUmWa6Y3QPfUFmvgRHvjDXEofXLjrnX/WC1iLgqP3FX2YLZI9TrStc?=
 =?us-ascii?Q?PAHroSQWIYMA6eMxbON6R9N/+oD3Qw/bIioETO5tevbh8WtE8d7zS8Bvbozi?=
 =?us-ascii?Q?DZOCj8khLFYeI6DKSkOXY5z8I+78kqOckrGfz8OylPSgjFDsiT5+cKvfzuIy?=
 =?us-ascii?Q?aggqwqgvYZQFEAZ4799jKYxA0qrcHxT20MNs60V6ZJJkRPafpcXusLjacMbi?=
 =?us-ascii?Q?8IRdwc74hho0xyhdpXPDO6+68AxOxergXL4D3o6Tbq6o7Inv+MCk+e04CqmT?=
 =?us-ascii?Q?BeCjKHisr3Y36LVhA2YrtWcyspKSfJCPA14KyNeyFfA6B614QtF3s106NG0q?=
 =?us-ascii?Q?kDN3n5GT1quNkl1y96iJ/NcCdOXSDzhg10WVP1UQkM77EgJc1GNBFssv7soC?=
 =?us-ascii?Q?X5sq8+GSGhsvy2ipYc6N5TFMnqmB8L0i4DU7iAEKml0vQIF7ho979waECchj?=
 =?us-ascii?Q?vDCOkTdK70qXR3fHByOwCYILorgrq7vUg02xpXIFyh9c5W03phzo2Q4HF9ey?=
 =?us-ascii?Q?OVlO3W4oPZ8g9rgsqvY5NV6DE+/l47LMiu1O4olX5VgkB7091HL1qsKPPBv1?=
 =?us-ascii?Q?ESNLghqyeHr6yEpsO9S0pRrfqK9HPnQIkpajKLdE7deJKu7Eg6bBDVKySmlF?=
 =?us-ascii?Q?FsZvX8dyNnNgrLsTW4bt9tDMmEIeWsu4ygerDvykYoRiPHXkUiZ1wQ68QZgR?=
 =?us-ascii?Q?Sb4WOfLDolDVBp5IvW4r9mW8dYcgYcorv1Y98tM+wb6Mf4rfr2Nz+J4VDXDc?=
 =?us-ascii?Q?oIwcDuIeLV9DUoXkOjoP9FtfAZ4Un2WzMc0fEARWfSCpvVeNj4GLuMVXOieD?=
 =?us-ascii?Q?aP0S228MBqeGY6SSPBJvM8rj4oD8/zrEoHDTXdzNhrAk0iWcwGFEnvPvGhQY?=
 =?us-ascii?Q?bk1ouHNJhgU5faFVTQx5cHpLgrvabOrHd1AqdUtX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d4109-6642-4914-990e-08dcdceeca81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 23:15:33.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR/Qr3q1gSHlkTnBRaWN7a+gH8veki4rI/UGWViM2JpWhG/kVkQsb9zd4+pSphpdQVXciQXIuBeljKttRqXLKo3tZkye18Wnmx7h4TJqvSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Tuesday, September 24, 2024 2:45 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>
> Subject: Re: [PATCH] send-email: document --mailmap and associated
> configuration
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Jacob Keller <jacob.e.keller@intel.com> writes:
> >
> >> +sendemail.mailmap.blob::
> >> +	Like `sendemail.mailmap.file`, but consider the value as a reference
> >> +	to a blob in the repository. Entries in `sendemail.mailmap.file`
> >> +	take precedence over entries here. See linkgit:git-mailmap[1].
> >
> > No such documentation page git-mailmap[1] exists, hence this breaks
> > "make check-docs".
>=20
> IOW linkgit:git-mailmap[1] -> linkgit:gitmailmap[5] everywhere.  I
> did that while requeuing and reintegrating 'seen' for today's
> pushout, so unless there are other things to be updated, no need to
> resend.
>=20
> Thanks.

Ah, yes. Thanks for fixing!
