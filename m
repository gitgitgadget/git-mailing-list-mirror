Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975703803CC
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530911; cv=fail; b=jv97v8QYs/IGJaKBwcuIZMiiT+WYJD3ItGYawlVwhYdNcdxHoC+MyFO8m/E9NmE+OOLZ/gRKX5tmJcyn5xxbHA4atSaG9iTmkJXumpnnaG50RQpwxBP0YuBopx32w4N+7bsQtuWVtcsAnDkOQ3xVHPPZR5nmreEhSX/fiw8ik+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530911; c=relaxed/simple;
	bh=HxffiIIybGWfMymZIlmo+8WpyKyoSMTBnluCa1gAyNQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DMc47mp0uOHRDLukBntcLTWDXUWRbc2ZNtRnVRyFEaF7x0PL0Ia9dOc36NsGfXBH1izoWv38jMdv6C41M1hbDUoCxNw3pxJp21lingdppjVvwIeWta7l9lCf2VdEfiuXED1/lkXMnJe0DvLnSbZlaBuqtj0T3GaFUtt2HKLmapA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kM64yFY1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kM64yFY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778530909; x=1810066909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HxffiIIybGWfMymZIlmo+8WpyKyoSMTBnluCa1gAyNQ=;
  b=kM64yFY1yfsicM79GCZH99NkAZHkqP63xSZ5hHrsElOgfofLim1aGRrr
   EPW/wnwQxLNH/lKSlpPxsmnoWSps3RfPjR6BDaAuZS4HkLADdldzDKjQ7
   TA7I2m5s+gg0EitFhm8pNys906K33CJ/NkJ6VXvz3p8pFLCgHyrkrjjuE
   1VhBnq7gzC/ETUAYXZ7W8M6mgJHCLt5S+nlyeoyDW6NykwCsvzLcpW/hS
   ILBP19MLD8l/Dtys+2I8zsI6UUvCLi66IxW+mFArpMSov2+Azau9hkKxx
   QyTGhbY66fWlb/kr5WZ0Cbo76XDpUtJy+tIgJwNozJo3J6f7SuPsX2lAa
   A==;
X-CSE-ConnectionGUID: h5aMKrxYS/26LSc5yzq0/A==
X-CSE-MsgGUID: E6/hPscOQ2ubLnrK5Un0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79378015"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79378015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 13:21:48 -0700
X-CSE-ConnectionGUID: phtQt/hbSdyV13eWn1JtdQ==
X-CSE-MsgGUID: lhDGJsfeSCa9d43yNYTqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234889852"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 13:21:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 13:21:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 13:21:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 13:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehNHBd+hoB+O+us5dTd50NzAbcGt1Telum8WXgMYrCZi7zO4qFZz1d6pSYl0Y9e35lBgxTfsPI66g3Gm9TxpjvyNcbgAOfEGokR5vU3SLJKBu5BqpHx7jx8j6bTLVQ2el5BVPPpB+gAPziWWWAzcQShtJD4hrAZ2TmmjY7rwpULGW8T9Jx4Zpf/Yn3vmTR5ztCePHoYGE4siFJytN6tKVLm7S2FtDi4hiJXem+rJ6srMhODbq4NydNo849OMWnasnSHIA6TeoIVT7jqoOB/zELajPqOU984RRQUsOPEjpH+B7G+sad/xk+8a/KYzOZ+xQO+gm8Yjv/kQd/Wy6VsUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeUi7aH5i8VZKv7pco0WO+o4aixLc4wCMYJN/mJlF3c=;
 b=OWeFP/PCWxiO/uhGBkLxLpKHOmu3qrHjLmhgOVGRequ9DgLcQi0Wm8ab9lAvg/kXB0Juede/cWPZ5DxAhapYZllbmjp1IkVWRveOiVcGUD5cTDChglrMWuFMUulxKjSrb+Bm48wI+E1Z1QIKlpG0zKem79CvUNtUvKCN0MCHiL4zzp00kFg56bXwW1NoFvn09Od6M1dYRCBG1h37A0Hm8jbSE4wUqspp6tcdPag8rYx78gY2secxBasI3oYBpNrbradeSozHqEANNjB5MG9SXiX43N5IAfbm7CDor8paW2D/sh3c+IlbwgXqcNV+kdE8Vi4t28fSOqIDIu8E2HWOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:41 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:41 +0000
Message-ID: <590781db-7c19-4aa8-8497-e16e5eb5eba1@intel.com>
Date: Mon, 11 May 2026 13:21:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
To: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
CC: jean-christophe manciot <actionmystique@gmail.com>, Patrick Steinhardt
	<ps@pks.im>, <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <20260511200112.GA22912@coredump.intra.peff.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260511200112.GA22912@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|SJ1PR11MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: c7928ecb-0cc5-4f2f-790a-08deaf9ae926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 0yX+g+geffdQUrKbLg1/lKj22jrzZvA3/vNYldadPM/s2lhOfl9JSdJlgPNVIvASjFpSIO/ZrqNE+mgE58SI8cNu1WqgvmAtoq/jWbCbhd9ZSutQJRNLmNZ1NIfCnOon48mPl9ZRR+Cu2y6ADGKL3DKFxBQta7r0DhRBfcONMspMwW50jp7nLdnHBmDXp4aV4gvNnZe+IlIMN3ABrpKO/F0vLbGSmPOjwtPKlSQcGVoBxIdVTaZ95xbSy2KV+1YGgr9eQcIHQOD5QELo3pocsUiWY7bNpjwbsPxJpIu1zcZ7p766voASpfR0bOAM5kqKLmAA0BumNyGL8+2BhQSFBwa/w+20JGpVEffnyrvmKxkRmGwNMzMP0R9SKBzUnpIgOqRCZYmWqc3pF331AhM0WK3GZeIHq/UrNRCYoC6p6DyGWExVylA38YF4hZul0FtTOenmZVD6Mrmr+QRmaLzuZz1Dbnob+1tD1Q7MLlSa+AAIaJ68dnzlFUOd+vw6bWkgyCBxhE5YVud2XzrUpTa3PSrF37op302mFPpHNc1m4Vi6Ccq6pgSG1B9dUPed79ZDfCwRMf7ncXxU33Izk4oyKEBkq7yYB4jD+E71UbOILkLlHe1Jc63lMqXzwIhf5iuZXvyVS7klNc/NP2vnqEmR/C0HqhIVEeY4txQ2MXqtx/uRKDHQO++LJCpuKYtLfdiw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNwd1pWblFWU0hsN3c4cVNySGY2MUo1eFd2Z2tBUGFZRXN1d05ZSWpQcC94?=
 =?utf-8?B?WVNGR3JqQ21xQkNOUUEzaU8weU9wOUU3R2ZCRFJDbm9Vc0JqM0NNMC9zUkto?=
 =?utf-8?B?UlhHY21yNDdVayt2T0dFSU5BRmhoaXBVdVMxaFNZQU9XYVVtdk5IcEkzMlk1?=
 =?utf-8?B?YTA1QmE5ajA5a2xYR1poNEMvYk5YUzlURUptYjQ4dnltV0tTaUI2RUkxSGxL?=
 =?utf-8?B?UlVkb0lRdTJ2TVlQdHFFNmxVeGVFdXpwYTIrSG9tU1lENmRic2RqTGI2VG9Y?=
 =?utf-8?B?STdwcWhJMVlsOUlTMS9tMHdGS3UrV3VzcDI5cjQyUnVtQm9QY2ZRMFdUZHRq?=
 =?utf-8?B?c2k3WkxQU1owSkhpeXQzTGdjb2ZmWjF1dWJveTZvU05ZVEZLb0lXaDNRSjN6?=
 =?utf-8?B?RVp2L0NVZ1VkSXF1RjJYZDhIb2RidXk2NnJmQ0FnL3ZLbHo4elRDRzhXenNT?=
 =?utf-8?B?d2FRS2F1dVNhbGd4MHVUZVMzcWJvcy9rampSWkEwbzUrOTM5UFJzTHk1Y1dM?=
 =?utf-8?B?Sm4rR0NvSm5RZ3plSjlCc3VRZHQycENtN0ErclM0WUFha0VTMnI5RWpITnNQ?=
 =?utf-8?B?VzRTN213L1M5dHFwa3A2WnpkUkcvQUtXQUF0NmNBSUl4dVdtNmpPR1QwS2tJ?=
 =?utf-8?B?SHB6U3JycWlnMEx0NlQwbzQwYTZ5UzE2TGs1VENGRjA3Q2R6V0pqeHQybGUz?=
 =?utf-8?B?eHdJaEhTNlpXK3ZFS0o0bmw0RkY2VXEwZ2QxMXhLZTVXZ1RyY1p4bjVROW1S?=
 =?utf-8?B?eTlIZDdEZFNvaWRJT0RDa1pPTHEySldDbVJaZEdsQXVGTTVpbG1HWDBPNk5X?=
 =?utf-8?B?KzBtb0hIOENJcFV4ZmIzdXY3Z0J2QU1YTW95d3hDU3pYQzkwZ3YyYVRESjJ1?=
 =?utf-8?B?UlMwL1dVQjJhLzBHbVNHVnliTjd4S0kyd3dpaGJCVXBVYmt5WEZBa2ZiNU5F?=
 =?utf-8?B?NEhTY2VlN01YSFdESU5xLzdMQXgxOVRxeHp5Mmtnb0RCc0wwKzY4dVFJckJD?=
 =?utf-8?B?dlc3UTY3TnN2K2VwdndncTdQRW9RV2owQWV4QmcwWWN4TkEwYlAzaXJkWFZT?=
 =?utf-8?B?STRzdTRESzRub25LdG9mUVFneXpKeGFQUDQ5eHAxVFVOQXd0aGFHTEJEeUlR?=
 =?utf-8?B?eUVvb0pJT2JacGNyNTQ2REptd3VVS2lFSi9QU1FkUi9FVXFEVHV1Z0FZNnVp?=
 =?utf-8?B?RXp6c3JsYzYzamt0NXp2b3o5U1NqWG1iS0ExcThmZnYvbXhYTElDRjJVcnhj?=
 =?utf-8?B?NDRrN3hRWEdvZ2lONzMxZER0VW5obDkxRnpadjJGcXVIQVJUN0FWVS9jMkRs?=
 =?utf-8?B?OHpiZHQzU2d4SC8yWjQ2MkVRQzIyL08zZ0NBV1Z3ZEN0aFZRdU1LYkh5dHZn?=
 =?utf-8?B?ZmNvNmxxSUNKZkREYzJVK0hHVi9FRHNQeHUvV0xTRzQxMXk4clFNUkxQb1Vl?=
 =?utf-8?B?ZnZGbTM1QVhqdkZndE1OS3hEZnRQNUw1SUZxYS9yQjhMZjVlVllmTXJCKy9v?=
 =?utf-8?B?TjZkYzMwdTRpT3J3K1RzNklYMHhBdkw4Zy92dTlHMDV1OVNkRTR4a1k4SHdt?=
 =?utf-8?B?M0NUTWxCZUZuRFRQcUp5ZHR6Z0JDSS9BU0w1U2U4S3JpMTZLMjU2a0o2aHpD?=
 =?utf-8?B?OEdiRGJYSVhLUVc2QURsZ0RXK2hQbHJlYVhSZXNBZ1I0bVV3emF5VTZhTEhl?=
 =?utf-8?B?UkJVbmExcEVoY1ZwS0RVeEZVWGdpMWFaTGwrZjJLRWVoSGZYcDNBTDJwRDBR?=
 =?utf-8?B?SzZRWGc4WkNZcXg0MHdFbjBoT0dpQ0d4Vlh1YjZqNVRuYUc1cGNYTGQ3Vjdv?=
 =?utf-8?B?b0V0Zm9GdDZtODk1T2lHb24wOElyTVIyd3dQS2d6eUw2WWJzN2k1Nm9NTGcy?=
 =?utf-8?B?Yk53ZGhtSVlDa0RqRnRwY2ZaNG5DVzJIdFIyK3pxampPUENOOGsyQ2hidk9Y?=
 =?utf-8?B?S3lFT1NyZ1BXQWZ1TG5HTjNWVnM3azc4Q1dmQUU2cVBqdWpQamVteGsvQTFS?=
 =?utf-8?B?bGlocy92emIzWERGcnBoTkdPanAzUEFBWnE3d3c3aHBvNktzVHBRb0psNmEy?=
 =?utf-8?B?UDE3akxGRU9JTTVBK1lZcy92N0FSOGtYQmNqblNXOGcrMkVOZW94R2NIUHZW?=
 =?utf-8?B?VkxKQVNGa2lDc0VLcVhHb1U3M3BEUmxlWlVUcXZuK2tjeVJqR1Zsdk9qNC9Y?=
 =?utf-8?B?QTQ4Z1Z2eE4yQzh6UmRPZXVaTzYvTEd6dlUxSWtsa2Vxd0JOcnZQL2hVYVdG?=
 =?utf-8?B?OWJFL2QyanQyMGJablFqNHJlK2E3QlFEd1NuNzFKZHhrUlNhTGRMRHZmMHBQ?=
 =?utf-8?B?eGFlZDlCdmtUa1Z1L201L0xNQ1pFc3MyZ3pYcFN4ZVpXMmdSSnpMUT09?=
X-Exchange-RoutingPolicyChecked: MJQv91wKLlCfog8P6YI1PYeCQQ2bJ+SEKjz/6khd4t3pmwA9OSHCK2kBQ3vLyRtTNdm6jI7j+FyAJ+9VC5NYOX3gAb3lndUg3OUYgbN7zGuWuu1ABelt0Nw2QFn8jmT3ycchtnhZL/6HhBa5Al4TWgGZcUMJomXyXmR5vKsAy8HhB140xpM9HaGbGvQcT5VaciwoBByhjlaanZhBaejqXVyhGvlFMG1LZyqQpE7L94P75ouoF9gl0YiHch0Kz0wVRNGdzFOEKQQf7f8c9I7vpJRJqsaty9tC7hawWCXY6QS858n5mmh4RkuqSkDxpK4u3NSqO4a5LIOSmTyNHzLxZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7928ecb-0cc5-4f2f-790a-08deaf9ae926
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:41.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqCAJcaIkiQ4MAVtoG8DC0YQboW1nQhxVsMN7ezIKXlnrzAR5LWL3dYGdQzIYjPHzwEzDEOilPhA5S9/T0EGD8jn9DwM5uVo3ORODV6OsmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com

On 5/11/2026 1:01 PM, Jeff King wrote:
> On Sat, May 09, 2026 at 05:52:29PM -0400, Taylor Blau wrote:
> 
>> Dropping and re-acquiring the lock is possible, but it's racy since
>> there is a gap during the critical window while we fork(). I believe
>> that the only airtight way to do this is to update the owner field of
>> the tempfiles we want to pass down during daemonization.
> 
> It's racy in the sense that we might not get the lock back, but I don't
> think that's _wrong_ exactly. We just care that some instance runs the
> second half eventually.
> 
> It is technically vulnerable to starvation, if processes keep taking the
> lock, doing the foreground jobs, and then losing the race to take it a
> second time. But besides the fact that you'd eventually win by chance,
> unless you have an infinite supply of processes coming along to run the
> foreground half, the final invocation will run the background tasks.
> 
> I agree it feels pretty hacky. It is, however, how "git gc" seems to
> work (notice that it does a manual delete_tempfile() on the lock right
> before daemonizing).
> 
>> (As an aside, do we want to do that for all tempfiles? It might be nice
>> to have a "->reassign_on_fork" flag or something on the tempfile struct
>> in case there are instances where the parent wants to retain ownership
>> of the tempfile after fork()-ing, but I can't think of any off the top
>> of my head. If we do introduce such a field, it should probably default
>> to "true" to avoid any foot-guns.)
> 
> I think the answer is yes, we want it for all tempfiles. Because it is
> not a property of the individual tempfiles, but rather of the caller who
> is forking. The point of that owner field is so that when we spawn
> children, we don't end up with duplicate or unexpected cleanups.
> 
> But daemonize() is not about spawning a child or otherwise splitting the
> process into two. There is still a single contiguous flow of execution,
> and the fact that we switch pids and call exit() is an implementation
> detail. So we would still want to remain the "owner" of any cleanup.
> 
> And that is true for any other atexit() handlers besides the tempfile
> ones, too. If we called run_processes_parallel(), and then while that
> child was running we called daemonize(), we'd not want to kill the child
> then, but our atexit handler would do so! But we don't tend to leave
> processes running while doing stuff like daemonize(), which is why we
> never bothered to implement an owner field there in the first place.
> 
>>> Ultimately fixing the lock bug will solve that. Though if doing so is
>>> too complicated for a quick maint release, I'm tempted to say we should
>>> consider reverting 452b12c2e0 for a potential v2.54.1 (as there were a
>>> few other regression fixes so far, I assume we'll have one soon-ish).
>>
>> I think something like the following (untested) would do the trick:
> 
> Yeah, that's what I was envisioning. Note that there's a small race
> here:
> 
>> +	switch ((pid = fork())) {
>>  		case 0:
>> +			reassign_tempfile_ownership(ppid, getpid());
>>  			break;
>>  		case -1:
>>  			die_errno(_("fork failed"));
>>  		default:
>> +			reassign_tempfile_ownership(ppid, pid);
>>  			exit(0);
>>  	}
> 
> The parent is giving up ownership and the child is taking it. So there
> may be a moment where both claim ownership, or a moment where the parent
> has relinquished but the child has not yet taken. We're not going to
> call exit() in the middle there, but a signal could kill us.
> 
> And then either:
> 
>   - If both claim ownership, it's mostly OK, because they'll both try to
>     unlink() which is idempotent-ish. Though there is a bad sequence
>     where we delete somebody _else's_ lock, like:
> 
>        1. Parent forks, but has not yet reassigned.
> 
>        2. Child calls reassign to take ownership. Now both have
> 	  ownership.
> 
>        3. Signal kills both parent and child, so they enter cleanup
> 	  code.
> 
>        4. One of them (let's say the parent) deletes the lockfile.
> 
>        5. Some other unrelated process (let's call it "git other") takes
> 	  the lock.
> 
>        6. The child deletes the lockfile.
> 
>     And at that point "git other" thinks it holds the lock, but it
>     doesn't. It's quite an unlikely sequence in practice, though, I'd
>     think.
> 
>   - If neither claims ownership and a signal kills both, then nobody
>     cleans up the lock and it is left in place. This is annoying, but
>     also something that can happen occasionally anyway (kill -9, etc).
> 
> I don't have an easy suggestion for making it more atomic, though. You
> could choose one or the other direction using some synchronization
> between the two (e.g., child reassigns only after parent signals over a
> pipe that it has relinquished), but it's all kind of ugly.
> 
Ya, that seems really ugly. My first thought was some way to disable
signals temporarily, but I am guessing that either has no good way to do
it or would introduce even more issues. Plus there is always kill -9...

> So it may be reasonable to just shrug and assume it's unlikely enough
> not to worry about.
> 
> -Peff
> 

Yea, I agree that this might qualify as unlikely enough to not worry.

