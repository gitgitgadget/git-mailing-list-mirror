Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919A295528
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202527; cv=fail; b=pqnphj4HPwrn/EZqRzXqx7/FDevnwt1m0Psft0UpLuwuwqjq9lWW8hPLflLz8PCndnLil7MpudHDWTk74u6wkg4WOnC5z0imiYH/Df0WT4IGO0Qetn8qr3UItdzzbsme88zLpSKwrFppHirB7DG+xbqSbHsOlU5vkwOO0Q5t7YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202527; c=relaxed/simple;
	bh=9P7Ja+uD/s0a7/d+1c1155cNQXCaok32aXwU5Hg2d4E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zv7KY6XLrOzDBBTHs1GL93eHGluAx9UZZNcDq4+tIlRILJWi2nOWgzzC83GG/gdrxvdY/mg2uexgW+ryfTBf/C/TT7rmOboTAmDfsZOt/cMXUicuvxd+qLOipjJexldRjCHhAOW1uL5ktE+XEV/1qCxDRsHx6Z8T7x1TzPziKDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We+Ui0+P; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We+Ui0+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750202526; x=1781738526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9P7Ja+uD/s0a7/d+1c1155cNQXCaok32aXwU5Hg2d4E=;
  b=We+Ui0+PUqe+90S320LKRjCoB2OjNfoLVtEz7LJ3rGqF93o+1zB/Ck5I
   Bvz4nLPG4RM2FNbhBv2QAID8Nbmqw+8NbrHgm8C+mdiy4TfPziOGS7IWI
   GIqsbUe/mx4RItiRaVDRosQvDOHSZXOmH8x2duYvGynwepZq/MDkG7MSF
   CtYqYs97kQKC0vl7Fa4JmNVqnBcbgiJIHZJ7nJwkq/fl927eTBaASC36A
   9aRhR/8pgy6wbCK9ORC33FLKplzv/vG43Z5kC05ymyi/vImpkLw08dmEP
   At/VJzrMLQlMHNFnp3N14vxSTaOHsRmYwExBA0xqWgI/yxy3D2Y/TFJAI
   A==;
X-CSE-ConnectionGUID: WmMRx+PMRnaiddVSiDqwWQ==
X-CSE-MsgGUID: MZ+Q6X0QQmiSwlSNDJQe3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52381059"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52381059"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:22:05 -0700
X-CSE-ConnectionGUID: ydl8g1abQzyoy+6Bn01vIQ==
X-CSE-MsgGUID: BzyC/WGQTVi5edTER75SYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153897272"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:22:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:22:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 16:22:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKgbS+l+Dnofk592vb0ui4J7njydMyfVRL1rgJiqMD9qET8J0q4JFq0c6WMytwppZAJ0SZ9dtcx8nM/bExR+E0XenSQ+sAy8KWFLoqrVyt5FMyFJV7TamKQstzv1vMzx+zFt0A2aaM489z0HjJ0g2oCu9yJJcUV5ov8s645M1yB+F02oBPSDTprqXkDvjR6zyUJEyBi31VAiziQOzIEBxQn2pr0TA4fYZ0x3+U5MP2ZhTVhPvsxsmlx4KJr5KYTrDBYxJEEq4e+bB59UTYK7k7SqLc3ywVWYZwQD82CehgficrwSzuZYhLJDEeWiwr8BZAX18X8QU0k4J7HuF2MLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Cz8aNqyITE2QAbu6XgxJT9Dnn9Wzk3IgpYHse7/VTQ=;
 b=BaPA6P29xqBLDz3GnafR2scOdRi608A3itnhWb3lSRVJ8EQMFyPHjSack2As1O7mwqWcEtl47/ew7g//aUcODZN222BtwvUuUY7NeGxiLZj7LLqIWhes06KfjXkO2teKJtuMQvFle12G0MhT5UZrkgvJ0IL/lsarCwEyfjNtl8k+HmUDM73KFlMmsBg6v0eMqf0bWB5PpXatT2Je5JScM+Hlq8TLDEN5DQufE89eguzU8a8DeentUVXrHG2DmCY9zmeFlTE26sqJp0IDOB2ybci7X+XjXqh7OnEWyXz0UFmxje4y7d1cH9wePGpf+rEte+iv7Y6yWTvmAYcF30Ga1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 23:21:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 23:21:57 +0000
Message-ID: <5bdecb99-8ac6-4dc4-8070-ddc747ab40b3@intel.com>
Date: Tue, 17 Jun 2025 16:21:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] submodule--helper: improve logic for fallback
 remote name
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, Lidong Yan
	<yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-4-04cbb003177d@gmail.com>
 <xmqqv7out11r.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqv7out11r.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: f801dab7-c1bd-4165-3b53-08ddadf5c0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWlqQm5nVUVnQVo0dzkrRlB5WDBhNkk1Um1CWitoQXp0UDB0RzFaVGZuL0Yz?=
 =?utf-8?B?QWxwMDVTWmtJQURRSVJsNG1SOWtCdDkzTndYV0tiVy9GK1JRTUNSZVJWbTZO?=
 =?utf-8?B?UFp0c0tjVUxiakY0eWJnL1JoL2RkSDE3OS94RkNtclR2Vy8zM3Bwc0FVNU5F?=
 =?utf-8?B?YW1FK3V0NGp5STIvK01qUkowV3R0UVFaY2tTM3lMcThrejlqbHZ1eHg0WEYz?=
 =?utf-8?B?M2Fhbi9BdlZLZ244TWpFUW40NjNyU0ZoQS8rY2ZKbkI1cnNiUmtOQmZaN0xX?=
 =?utf-8?B?cStxTHpTRHlDMVdSaGxxem5EZm9qU3JnaDhhYkxTMFNMeXBaZmtSMDlvSisz?=
 =?utf-8?B?bFh0OEplQklFWm5Jb1VZNUduc2c2U1d2ZktsTnJDd25hQ2duRjJLNnJINVFJ?=
 =?utf-8?B?Zk9VNlZRTmFRcUltYmZ6S3pmQXlxWnJhWXYzV3JxNDBEQ1I1cGNZeElhWFhi?=
 =?utf-8?B?REFiQkQzMWR3Y2JZMUdPZXdpQzRPTWlFeXM1ajJxUFBVYWt3SmlVMzFBZnBn?=
 =?utf-8?B?d2EvRExSb3FqZ3hubUlUNlFPRmNVL2hiWkxrck5VTkVKakhYUGN5cnV6a3ZE?=
 =?utf-8?B?eWVNd1pyUnU2QzRDWCtpM05ETC9QdVpOb1E1aGlkeWhSWGpOL3Roc1JoMmFj?=
 =?utf-8?B?VkpuYzJXTTFqTVlQcXdaSUg4UG9TQ2FhdFVlclhMeHpaeDhBajJSM3ZuTFRV?=
 =?utf-8?B?SnVxLzd6OUZFYWtoeUtsWVNtdVZRRGp0Nk1ORWlrMG5YOG03M2NRbzdtcjNv?=
 =?utf-8?B?YW94SUNkUnBGR0NlLzU3ZlFJUk00YVZBaGg0S3l5VHVMMWp0Q1VldUhHcmRW?=
 =?utf-8?B?UDhsK1IxeW1nQ1ZCcW8vdXVGN29RV0ZBUVRhaVBLcW1GcFZZT2Y0dUtKeS9t?=
 =?utf-8?B?TFJZSHlPM1BEdTRldTlyWmdyWCtpVytsQlNzYzFRZFFycnlTY3pmb2RQODlT?=
 =?utf-8?B?eUVuNDJiZU9pdlFOYjRpcXNFMHRXanMvUmgyS2JDQkkzVGQyMkZldjJRbmla?=
 =?utf-8?B?dXp3YjVXaDRYSFpjZ2JYRWNSVjQxOXpaRVJkV0FZd2M2MGEzczFaMUE1QUdF?=
 =?utf-8?B?eTdFYmV1Z3Mwa2sycUpJbWZBdTc3Wm5UZ0lhK3hDOVpqODA4RGs0eWltdHdq?=
 =?utf-8?B?L2dWWkhsUHR3Sk5pYzFZeTc3OWtkdmJyOXorSnN4WG53OXpxTVlqQ3M0MEpl?=
 =?utf-8?B?ZzVFaDdiMTZNRElyamdCTDNKTE1yVW1ML0VIeGVZNGdNLzNPQmVNaXpRMlJU?=
 =?utf-8?B?SUtmU0VZOVVJMlJuZWVJT1dBWldEc1NQcHF4RGVsRVg5Rkt6YXVKR0RzcDJv?=
 =?utf-8?B?MUhSalhESjNNVFplbmZNeFhYcXFYRFpuMllmWTY2dmxZYStqUnI3NE1Qc21y?=
 =?utf-8?B?VFpBTGZsMG54b2tRNGREM091VlRaSk1qbUxDSy9lYUFWYjczTnJFeXdQeGRu?=
 =?utf-8?B?UWNvRjdENVF3eVowaDdXbHBDblVWQ2xMb0oxeWhtQjFEb1BxWEFLc25YVXJZ?=
 =?utf-8?B?cEVGWVRvMDRCVU9rZmx0ditzSXhVRjFQK2Q3Z3FOQVE3UnBYc24vZHpDN3RE?=
 =?utf-8?B?TjR0RWxsS1YzU3B3MTJ3UzgxaFluSjlScG0zTDR4TUdrSnc2MStyM2xaMUdY?=
 =?utf-8?B?L1NTdUlDN0tzK1UwZG4wZUZxZ3VweFdjeVVSaFFLcWFCcWJaT0FCK3JtQWx1?=
 =?utf-8?B?aEh0NnM1RkZDbzNIaTFCM3FXQmhpT1lnN1F5S2o2eEtSUitmMlZzQ0RXSk04?=
 =?utf-8?B?VS9VcThVRGE5YytHT3dpZjhSL1NuTDZSQVlTTnBMbmhkL1R4VHlvNWEvU29I?=
 =?utf-8?B?Nnp5enc3Vkd2OWRubHJxMkxMQnNqNytuSEswSGxodVMra3JEc1FydFo3SUtw?=
 =?utf-8?B?Zk1oWTlzcHNtaHJUNGhiNmVpUlVCb1FVbEh5NnY5MWJIL3p5cHdwY2ptOHFx?=
 =?utf-8?Q?6BKHsZPsoCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDF2S3dIak41Ky9Ddk82Si9ieHp3VVJWajZSSEFRV1BjU01IOFY5RVZnWTJQ?=
 =?utf-8?B?akNkVmVEL0tjR09OQzB5RUR1NE9SRG5tZEFzWVk0Y2FiVjFLcHZpOEdzaG5C?=
 =?utf-8?B?b016dUFhRExjV2NkK0dBOUh0dU5SamVra2F6b0ljZVpNeHZ6TDFFMkJ2NER3?=
 =?utf-8?B?NnhHQlhXR2VGRGQ2ZlBzOW1ZMm4yZ1UxdlZDYXlLWmRBNkkzWk9nVW5GdDVj?=
 =?utf-8?B?WjhVM0lRaisyU3U0RlVvczJINVlaZE1uV1liK1JzbnZ0OS9QakozaGNZNnlp?=
 =?utf-8?B?Qm9LR3RsRFpoei9OdXhWNmVsa1UwMkFWQ2dzV01paWJTd1I2RzU2L0lNaFg4?=
 =?utf-8?B?N1Fia0NVcW9oSk5VMENNbTI3ZDlRZTBDUklQd3NBMVJkVHYwZS94Wi9ReTV5?=
 =?utf-8?B?L2ZsZkQybE9udVZNaVNKcVlPeG04WTNydUc2aERWNWhFbnQ0NHZsNitpa3hq?=
 =?utf-8?B?ekRKZUVCd0psNHk5Wm50enNUTjlRbTExcHZkZ1RoUDIrKzdhT2RsbTlUN2J6?=
 =?utf-8?B?L1c1WFFFOUZabXFOS3I3VzRHK3ZaYWFSRGJDVmIrRytTeEp2ZnR4WElWZEJE?=
 =?utf-8?B?Zk12T0NMakRBTUNBaUNWYmw0YjBaMTUrNDMyU2FUR3RKNEgvdWtIM2Y5dFo4?=
 =?utf-8?B?OFc3QnlUYjZnKzNmTlFsQlh5SmdhM2d5eUNmbG11dDd3enRoZUZwZTYxT29X?=
 =?utf-8?B?MCtTNXJPd29YbUZxNVdqNk4vdmJ3bzY3L2RrcHBGWWNSQlo0RTdrY0pUQVRu?=
 =?utf-8?B?cVQ3aEswaTZSWlZuNExJcWgwOWJLby9ndEUySlZqTEZxT0FBdDJ2eGkyUlE0?=
 =?utf-8?B?S0RUYTkvc2N2Q1RZRHlOaCsyT2V5VVNmeXZPRmFZcXZSZzg4QzdoVmkvOVRp?=
 =?utf-8?B?RFFuY1Z1TndROUVzOXdFenZleXFmb3ZpSWRMbTFreExZTytsSS94OUZrSmhG?=
 =?utf-8?B?UWFRaW5udzlWeitTM2Nqd3VObVYrQ0ZHbEttN09DcFhHemdKUTdsZEtzOFMr?=
 =?utf-8?B?aDVRNVVQUXBQWWpuZnFvWEc1SkhIUldCYXF5cUtYZ1RURXMvSkIwMkx5RFM0?=
 =?utf-8?B?ZEw2azZ0dXNVOWg1dXQzWVhhRVhqRSs1aXc2ZVRsYk4zWXptVjlFUXY5TGlF?=
 =?utf-8?B?TURGR2paZTZ2STgyRFNhYm41RHV0Rm5zaTNVZkF2QnA4TDZIK1hodXkxb3ly?=
 =?utf-8?B?TWNsL3hMS1VSemFTalB2V2dqRktib2RBcFdyVXBlbVcvaGVZMG40YzBsZmJJ?=
 =?utf-8?B?VUhhVU90TkpXK1REaDNnOHJUelJudVNob1dRMk10a3hhMUhDZmJrS3lkaTZZ?=
 =?utf-8?B?REJLVjlYSHJDM253QWtjSlVyWnp5WFRhN0lXY21ubjZUR3BqL0dOckpZVDVl?=
 =?utf-8?B?K2JtYVFFUkpTWFJuaUdsYm5oTmpxK0xiVjBCbytzSjNqRmZhbU5wR1Q2ZUtD?=
 =?utf-8?B?cGs2NXM5NkVHUEtkK1VLOSs2T2FKbXJJMTArVjN6aVJPemYwN0NBaGpNNVB5?=
 =?utf-8?B?Mjl5VURGa21TaVAwdUtPWXdDSUd5bHZ6LzFxZHljNGYyd0d3YnVTeUFIZXNR?=
 =?utf-8?B?akxQaWxURk9QNGRQeVIrTFJaNUpFMk1ibHhtNkFrTXI0WlAvQmdTZGVuS0lz?=
 =?utf-8?B?emdmMlczUDZvOXo5NjY2SWxnZmh4V2RiajYzOWt5Tzg1UWs1eFlwa05TZlRz?=
 =?utf-8?B?TTFzanZUQ0xwQjFQUTlHTk82QmtlUnBYb2RCT2pzK2d3RExmdWNtaGNFYlNt?=
 =?utf-8?B?TjlXeHFCWGFmUkFpcDFwWWJka053SGNSRmgzaHB6bWdRZ29ZYnhxTUlqa1lh?=
 =?utf-8?B?ZERYeHRBS1Rsb3I5YWlLRE1JUGJxdzI0SkJaNXVGRlZucWtaVXVvV25JZm9R?=
 =?utf-8?B?OVRlWFFJbG0vYmhYMnNzV05JT25ldTNqWVdFUkgrRXpRK21IczRUTVdpcW82?=
 =?utf-8?B?UnloYzVOQUFvbldDb2ZJVGpUbTNZOWdaY2FDQkRzRlZwMGZGaTI1Q1RvbmQ3?=
 =?utf-8?B?Yi81UUUzYUU5d1Q5dEcvRjdYd0ZQcVg2TTZ1UENUYW9YZGgzeGtlL2d6c0JV?=
 =?utf-8?B?dDh4QjhmcmRGZUxrSHlOeWpKVm8wSDd4dnN2ZnpGTDE0Qkt0b2RzV1dKL0VU?=
 =?utf-8?B?d3d4aTh0Sld6WElSbmNYM3ptRS8zOFQ1VWxXTkdsMndoWlJvd0ttU3Vra05l?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f801dab7-c1bd-4165-3b53-08ddadf5c0eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:21:57.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd4icYhkI2tl4zCB6D9Sr3O2/f56TxOSuUf6TgDPXOpofVfBbn1LevHUKFum+lQqZKmwXmN6JcmTvatgClKMeTjOzAbPCZwCdLVEJpAuuGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com



On 6/17/2025 4:12 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The repo_get_default_remote() function in submodule--helper currently
>> tries to figure out the proper remote name to use for a submodule based
>> on a few factors.
>>
>> First, it tries to find the remote for the currently checked out branch.
>> This works if the submodule is configured to checkout to a branch
>> instead of a detached HEAD state.
>>
>> In the detached HEAD state, the code calls back to using "origin", on
> 
> "calls back" -> "falls back".
> 

Yep.

>> the assumption that this is the default remote name. Some users may
>> change this, such as by setting clone.defaultRemoteName, or by changing
>> the remote name manually within the submodule repository.
>>
>> As a first step to improving this situation, refactor to reuse the logic
>> from remotes_remote_for_branch(). This function uses the remote from the
>> branch if it has one. If it doesn't then it checks to see if there is
>> exactly one remote. It uses this remote first before attempting to fall
>> back to "origin".
> 
> Designed wtih good taste.
> 
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714..4aa237033a526fca29cce2926419462179d40ee3 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -41,61 +41,25 @@
>>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>>  				  void *cb_data);
>>  
>> -static int repo_get_default_remote(struct repository *repo, char **default_remote)
>> -{
>> -	char *dest = NULL;
>> -	struct strbuf sb = STRBUF_INIT;
>> -	struct ref_store *store = get_main_ref_store(repo);
>> -	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
>> -						      NULL);
>> -
>> -	if (!refname)
>> -		return die_message(_("No such ref: %s"), "HEAD");
>> -
>> -	/* detached HEAD */
>> -	if (!strcmp(refname, "HEAD")) {
>> -		*default_remote = xstrdup("origin");
>> -		return 0;
>> -	}
>> -
>> -	if (!skip_prefix(refname, "refs/heads/", &refname))
>> -		return die_message(_("Expecting a full ref name, got %s"),
>> -				   refname);
>> -
>> -	strbuf_addf(&sb, "branch.%s.remote", refname);
>> -	if (repo_config_get_string(repo, sb.buf, &dest))
>> -		*default_remote = xstrdup("origin");
>> -	else
>> -		*default_remote = dest;
>> -
>> -	strbuf_release(&sb);
>> -	return 0;
>> -}
> 
> We will lose two callers of this function, so we can safely remove
> it.
> 

Yep, we're removing both callers.

>>  static int get_default_remote_submodule(const char *module_path, char **default_remote)
>>  static char *get_default_remote(void)
> 
> These callers that used to call the removed helper now call
> repo_default_remote() instread.  Good.
> 
> 
>> diff --git a/remote.c b/remote.c
>> index b3a9881a6eacf90bee71d6760858b37d68263502..94b31f4c23057a247a968fc0ebe2e5170e99614d 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1767,20 +1767,35 @@ static void set_merge(struct repository *repo, struct branch *ret)
>>  	}
>>  }
>>  
>> -struct branch *branch_get(const char *name)
>> +static struct branch *repo_branch_get(struct repository *repo, const char *name)
>>  {
>>  	struct branch *ret;
>>  
>> -	read_config(the_repository, 0);
>> +	read_config(repo, 0);
>>  	if (!name || !*name || !strcmp(name, "HEAD"))
>> -		ret = the_repository->remote_state->current_branch;
>> +		ret = repo->remote_state->current_branch;
>>  	else
>> -		ret = make_branch(the_repository->remote_state, name,
>> +		ret = make_branch(repo->remote_state, name,
>>  				  strlen(name));
>> -	set_merge(the_repository, ret);
>> +	set_merge(repo, ret);
>>  	return ret;
>>  }
>>  
>> +struct branch *branch_get(const char *name)
>> +{
>> +	return repo_branch_get(the_repository, name);
>> +}
> 
> Nice to see how the dependency to the_repository is lifted for new
> callers while retaining the same interface for existing ones.
> 

Yea, I figured there's little reason to go poke all the existing callers
right away. Those can be updated if/when they have a repository
parameter passed in.

>> +const char *repo_default_remote(struct repository *repo)
>> +{
>> +	struct branch *branch;
>> +
>> +	read_config(repo, 0);
>> +	branch = repo_branch_get(repo, "HEAD");
>> +
>> +	return remotes_remote_for_branch(repo->remote_state, branch, NULL);
>> +}
> 
> OK.  read_config() is a safe no-op if repo has already been
> initialized, so this would give us what we want.  Nicely done.
> 
> 

Yep, this matches how most of the other remote logic works.

