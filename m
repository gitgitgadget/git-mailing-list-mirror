Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF462BCF5
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735234609; cv=fail; b=f9bx8BRT81ivJvJ6J7L5SogEWihCJh+600z7ZrzEfae/xyMqhj3QtLMZfcVJduCGJPy5tkwlQN79JB4QnjRaXBXnyCGHd7omIyjGAr7XLZxsKD7psxmEP6IPlhW5yCba5ON+TlX+SOYb+RMpNkwkRcmwe++A1Zi5sAIkdMSfoqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735234609; c=relaxed/simple;
	bh=/bQxPaoF08JSrCml8LcivyADjwlS/LX1jhZHwlT0qEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8WdLG/GMMBT/By4023lBFP12A7TrXxuSeDVggt0lRMRyQp81j+HHnqzGDouKxC6czFHQ880jQQTGdWPoTpG6NncIPlOGre+tVKT5rdnZ5S1HR0KUU6AF1M4oVX5v2qYhDyblznFFb03jBKIr/9fEgp4pL3/rtdGpF/TjOAz2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXCDanil; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXCDanil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735234608; x=1766770608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bQxPaoF08JSrCml8LcivyADjwlS/LX1jhZHwlT0qEs=;
  b=CXCDanilM6QCPCsiB0ZK+KvU27lfW+3hTVhQFwl0gYRn18lh7lyNf5FK
   gbzkFBnlm3IRsYzn/GM6MarWxzVyAclDkIFxKoB2gBz0Yt2AI1WsWCjK4
   /164xjpiuPG2+YzbBpYxYjJVTGZMJ3soOswpKON0sOSrfjrg4LBomeMI4
   2Q93Pr5gURasYuOLsTmiyw5pQLekKFXC7V7oD6bsnGW8Ebek/463uovmt
   94SI0HJ5hx97bDp5L4Ctfq118X6nRunvUhYCLRONrIakCGPogs3pGawrC
   oNxOknFMW8sjxuNkd4t690Esy00U/LaXG+GqYB4fSRWXTxdJIwTqagCeG
   Q==;
X-CSE-ConnectionGUID: GGbvcEB+SWymLDBfZyIxrQ==
X-CSE-MsgGUID: HsAkhGvnRe+wEO2e39QWYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46147865"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="46147865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 09:36:47 -0800
X-CSE-ConnectionGUID: Daf4q+GKQliBVu49hih5Gw==
X-CSE-MsgGUID: tshIXG/+RJ2F9TxOnX0vZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104044645"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2024 09:36:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 26 Dec 2024 09:36:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 26 Dec 2024 09:36:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 26 Dec 2024 09:36:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSPR86KOqFjvVzE+ACqb0/7uY5e1701xBVp09+cNpG6r8OvyQ3lMSk/Twt0T30TK/7A5WHVIra5B7RYd/jtwS/mL5XfCDS+nduKLM50vJMECZeFaDu11iSysCyUkjZ09P3SgJDe184EXymOwM0N0EOV7bbOa6B1LFJjK3G4/lNqutL+d7g6BmOJMbZVpAsNj6GGDNY1/m3D3GxPHjudybTC4h4RYun2KpmhMvWSVY2eegdOjP3CAgE4vJLL2X2gXL5laj2Uk2SvHrYDgIZu8+RBPDwtGnLbfI7eiaXoAsgmpNZiHjlDLCDWh5VjYtDZL+xx526CMMpJqMF8jigu88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bQxPaoF08JSrCml8LcivyADjwlS/LX1jhZHwlT0qEs=;
 b=KmAQOZmVdYiLA95ct9+vq6tXo8X13Qb8k6OB/xxGQ3iRWT9+aI+BnSac3jcWXkhCYZKoS1Wia7kx3MCJh0gO+lLFY043wcUx/u6OWo+q9NZOutXxntbbhxDOAaP/GRYyE1HMqXVGA4M59foVaZIjPrjTlKSEINIB5DD30isf1SbuKIu5naQGqFjuu3EItOfvJZt6brNtDDmmH7Uhs1cp3f7mOs+P+9Nh2AWy5NwDV6PS8Aeht0iPKf7u7D/1v16yautk36jw9IUgyMCIRYGn5gmZd6s6u5x2eG3ARR97kAvoIvaV7iNRPs021voSTbuLShI3QVVt/Li0ayMIbZ3mrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 17:36:34 +0000
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445]) by SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445%7]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 17:36:34 +0000
From: "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "git fetch" fails for a --reference clone after an outer forced
 push
Thread-Topic: "git fetch" fails for a --reference clone after an outer forced
 push
Thread-Index: AdtW8agD8oNkxpxFQYmlXNFV0tRXmwAvI/OAAAMoABA=
Date: Thu, 26 Dec 2024 17:36:34 +0000
Message-ID: <SJ0PR11MB58148000A9DCB33CCFD792A0C60D2@SJ0PR11MB5814.namprd11.prod.outlook.com>
References: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>
 <20241226155251.GA69868@coredump.intra.peff.net>
In-Reply-To: <20241226155251.GA69868@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5814:EE_|DS0PR11MB7804:EE_
x-ms-office365-filtering-correlation-id: 5cfd70cb-acfa-40a6-dbb2-08dd25d3d7b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1N2b1RhaEVWTGJ2cnFKU2dyVDVrVGNVWWZCSllFVEJVaUVoVWdvSXNuMCtS?=
 =?utf-8?B?SmtIY202RExrNzJlME83NFhkNW5FeWV1WlJ3YnA1NEczdURzSkY2aDAvNldj?=
 =?utf-8?B?Tk5pa3NYS0JVNko1SW1LdU9qOGNzTG0xQllQTEI4aWpiei8xTTY1TkN3K093?=
 =?utf-8?B?c3VFZi9kanhNOVhJblBUMTFaeG1uQXlFOGtmTE9RRWZ0QlJYVFF6RVNiSHBo?=
 =?utf-8?B?YWNsL01pSEgwbER6cVREUXRrL0RkQnVvNlJlYjU1dkJjbXI5czZtbVdyRWsx?=
 =?utf-8?B?MG9ONzZ6QnVTWG5MViswMGpsR0VqeWtlQi81NDhPei81LytRdjNuWUh5Z25l?=
 =?utf-8?B?anAyRFY2MVF1bTQ2T0thVG5MUVB5eHdqdVpMMzJpOHlObDY0bjZiVERMSkN0?=
 =?utf-8?B?d3pNQmU5bDNnSkZuTklKbDd0NW5ja3ZwN29reC96SWU3MFlQa0xtaVlXdVha?=
 =?utf-8?B?QnhONkdlMS9JcEMzWVdYMXJyYmJyK21MNjhZdnp2QU14YTc5SnVzUTFjbHN1?=
 =?utf-8?B?N1E0dUN2bkZ5RVlYUWNCa0o2Umo2SzB2TXdMRkpvQXdJczZWOUhycVNKZkc1?=
 =?utf-8?B?M2RWeXRmVTQ2akRvNFNPTGlUeGp2bUlRNUVqUk0wWVl0bFROOGdjSDN0QzVB?=
 =?utf-8?B?YnZNT3dKOWlKTWEzSFRIcVBKblZaaDkzVVFtVjlZVGpHT1FPUktnd1BvR1J2?=
 =?utf-8?B?MWlJTFpyTzNpdlRFQ2U3Wlpiek8xT1JuSGhwRmJQV0V3SEgxM083MXVQSHF0?=
 =?utf-8?B?RnRlZVloVnAxNG4xbFdHZkg3QUd2VmlkeXl0emNsdzE2aFFFZ3p5KyswR29Q?=
 =?utf-8?B?VDBrQkRCMWZZZE9Pb21RTHRTTnp1TVN5VTlmYWh4S0tTcStMNDhYeFU0QUxq?=
 =?utf-8?B?ZUh0TytiTnV1WmtDUmpZQzdtNDJEVTdvRHorWjhFSi9ObTc5QTNWZUhQeHZK?=
 =?utf-8?B?Y29PUytiU3hVTmxuK21kOWNOa3hUSS9lZEpMZUkyUlQzYU5BSVhFUkpIYjlC?=
 =?utf-8?B?bmM4WnVkK2JUbys1dUJENnpmblJxMnRwUmtuVlFtUkdYOFN2NkduV0x0UHpG?=
 =?utf-8?B?OXZ0ZkxHYmxuOUcrNTZERmdZQzhtdWpVZnF3enlQVE9URlNjWVpERjFyRXdz?=
 =?utf-8?B?TElCSFFjejBLUVNIb1djRW9zakVUM1pLQ3h4VXdLc05NMitDZndIcjhoQUVP?=
 =?utf-8?B?R0tRaytWdWtmYkhCUzZmTEhyMVkvNkpueTNRajlNV1FaM0FsUHA4TkYxZ3J2?=
 =?utf-8?B?RmYvNm5oYUtFWEtmNlJjZGxJQzBPYmVEWVdmTUNKV0ZEWER2WWRmTDR5TEIv?=
 =?utf-8?B?R0dYYnFYeEsra2xpZHZLUlBkdm9tZTYwSW9LM1hma0kvR2lUZnVMUWVUUlJV?=
 =?utf-8?B?dTRPdU1SL2NpMk52OTIvc0laamZxck9BdVQzRkM0OVNTQjI0UnVuZVdsdWdW?=
 =?utf-8?B?SXZIMVZlTnJFMjhuN2dURDZjem5zUnZCd3JOVzdrbWVsODdhNWJ0OE1HZG5h?=
 =?utf-8?B?VUhpRk1lVDBQWWFGSWlUUlJkNTQ3WXdiajkxTHpzUGw5OE5ORHZRSWpwZFpR?=
 =?utf-8?B?Y0FSaGZhemdTaHVMcXBmWitjMysrMGlhQ0RmU0dUTUJkVXdFdTU2QWdFWTFZ?=
 =?utf-8?B?S0l1dVBMcXZwa2g5UHp3TFUyVWhJUHFLQUkzdjRoSTJ0RWhXNlZkZk81bVV4?=
 =?utf-8?B?dW9XNmRsWHRFODJTWWNXc1ArZlVYTUNPb1FNWnVaa2xsTmhRZ05NcjdqU09D?=
 =?utf-8?B?NXhXRmZPNmZvMUFwb2xFTEwza1Q2YTRlblF3Mkx4cEt1TVROcWdlZ0VEdEo3?=
 =?utf-8?B?ZkZqZUowVVc3cjdleHdmalQ2ZGZQaURoaTlDRmZZVE1tQVA1WlRLUGdUaEZ3?=
 =?utf-8?B?Um1IeUpaMTJsTjNmbm5UVnZUaFZDSkdxMmorRWltbDZtYWxGMHE3aVJ1NUh4?=
 =?utf-8?Q?iZqqSUEAvrKuBAoKTpfJXNHXTJG/6NVY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5814.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWt0eEorYTdNYkErVzd4c0lxU2tkY2JxdW9YOTE3SzgzNGU3NDlJZ2xtdE5F?=
 =?utf-8?B?R3hhMWozbDgrVENnMmZXUTBiZ21GKy9kM1ZWNVZxbGpuQXFqOUdQekJCYlV3?=
 =?utf-8?B?VlFldnYzcWM1VnhtM0c4MUE4Q1BHamJidmhVOVl5RU15K0JDTGF0M0VQd1c0?=
 =?utf-8?B?ZkUrcEpORklJZGxibnd1YXdCb3lkU2o4Y2ZiejZ4Ykw2aTQyeXpUMEhzR20w?=
 =?utf-8?B?TFo0MjIxVS9jekp5bXVjb0VXSmxJa0YzSFR0SjFhNWFDeDdidUl2Vm1GTUww?=
 =?utf-8?B?cm8za3F5RElaLzR6ZEJGcG9EN2o5NjVXY3lzWGx5cEQ5b2FHQ0RqbVo5aVNY?=
 =?utf-8?B?cXRmL3phdFl6cy80K3JRQ2JCanM2SEVZVW9qQ09RNERjNUNCVTFlMlBLRXZE?=
 =?utf-8?B?UkE4bHMvNTVmNUJNMDkyK0ZMYko2LytESnlkNXphSXh0UWNoZHdLT0VIT1BC?=
 =?utf-8?B?VXlxa204YllGWVpZSWRqODhUeUxSbVRDU2w1RjM1bUY0bGF1NUFwaUx5TFhC?=
 =?utf-8?B?S05WcXAyTENRUExrRDdsNXR4TlpHSXJ4WEtjT0kvYlZXeXEzNXRHTHVqcTZY?=
 =?utf-8?B?RDRhaEFvNEF4alQyN0p3VXEvVkhzOW9HZ0pTMXFaNkpMRjVCcUZlZ21vdTgr?=
 =?utf-8?B?cy9YdXl2UVVtTmdJdm1VQTRIT2pyMWV4ejVwY3IwalN5Qjc0L1l5R20rcW5v?=
 =?utf-8?B?RjVmdldXWkVPVGRpRjM0R3d5d0VhZ2ZhQlpzWFQrWUQzQVpUT0R3dllNL1VT?=
 =?utf-8?B?NUZTTTV1RjlSb2pvOEFzWWFiSTNMZVE4MmVRZzl3UERiL1VkRlByWjV5T0xm?=
 =?utf-8?B?QkgwS1RlZkxTeTV0aDc2UGFSdHdFangzdEZBVVhoYWM3bWZiaU5NcEJMcHVL?=
 =?utf-8?B?bzl0ZGdJWTU5TkZYL1VUSTEreUJJQXo1cDZmemZWbmxVYWx6QUxkb3FNUW9h?=
 =?utf-8?B?WURtQVprR3dLZWNONmNvTitDZG0wZzVmVjB6aE55b2k5Z3Rpd25Vcm9uYmo3?=
 =?utf-8?B?RjRLNFhGbW1lNUVVdXhncEtTeHgzbnRTYVRHTnRadUNxb0JHZkxUUUpQRGdH?=
 =?utf-8?B?ODJDVUk2QW96VXZuYkxDcDZMc1BHcGQ4ckd0bGd2TU5yZFVjdDZGdDFEUWNw?=
 =?utf-8?B?V1ZKSURXR3o5TmtPbmZtTDhrMURLZ0F6SFJRZXd1bDlYdWo5aGp4Sll1UFpz?=
 =?utf-8?B?elUxUGJpbWg3cGtSbi9NNEk5V0VIOWNnWTNzVm90WEVacUJoK3NWdjRySHZH?=
 =?utf-8?B?eFRheTVFa0UySjVIajQ5RDcvTEYxRXJiM2dMakIzWFdiQUk2aTJWbU9WK29R?=
 =?utf-8?B?TFVpZ1dncHIyc0lWUHpjSGpHeE5Lak5tZU9reFFONW1NTEZCS0Q1dk5Obzlw?=
 =?utf-8?B?MWhVV3lCUFRjWllpS2VjSm5qMlptak5tZzcrQzFqRG9XSGNQUzRra2YyMFl6?=
 =?utf-8?B?VmxMckRJcmNxNHh4UFNUeHY0UlcyMEZxTC9pWGM1Mlp5MWRaWU9YV2c4a2M3?=
 =?utf-8?B?RVp3NllNUWhscTlmWlBZNUxrdWZwM0FWSFRTSVpUYVoveFdoNXFBUDRQOVdp?=
 =?utf-8?B?WVlqSkhIRkxINmdUVk14UERMRTJXYUFOYmZFZ2t5YS9HSWVuZjBWUFBBNCsz?=
 =?utf-8?B?RDBiM1M4OGJXYUVyUXpkWTBoU3YrYjZhR3JORjJLbTlmbUR4NTNoZ1krNGpv?=
 =?utf-8?B?MVJmdGRBMFlRTkYxTWxIUkVFMHUyVzBVV2V0dVVBdWl2S3YxaE9ob1hERFZk?=
 =?utf-8?B?S2ZoOHVSWjkxcTZJbUdpNmJUZStOUDUwaXUwNmJOcGxOckxHallJMVhGYUc3?=
 =?utf-8?B?OERscWYwRmNKbzAzWmY1MHJOOUx0OVZkTXJjUzBWek5MT0JRN1pMOUdrblJL?=
 =?utf-8?B?eFZGdmljSk83K3ZOOXdmYzBjbHlGVnJGWUZvR3hNTXVkMi9hZ1FpKzZvcHMx?=
 =?utf-8?B?VUpCeGlmMHF6RmhKQ1NtZUc1VUJQQ2ZEazNLUkp0REx2WmFuSTB3M3VVK3Jn?=
 =?utf-8?B?bUpubjVWM0pmRE8yNDFieUF4UTN3SE51N2JsaWd1KzdmTy84UWR5U05xaG1i?=
 =?utf-8?B?Nllmc3d5ZUE3SEFQMVAxSGwxK0o5ZGlmU1JXZ3FHOUw1QmU0Q3VBMGpvSFF0?=
 =?utf-8?Q?JunK6jbgIJ1/0fTdPssrTFcUU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5814.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfd70cb-acfa-40a6-dbb2-08dd25d3d7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 17:36:34.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om8eT7MmAEx8gsvasOom5chYgsfcwFpOez8MATnsa8+LuakagEQy1Cy4BG0f24PJL2SzZ7jXdrEXPwu8FE0I+3MmKtyKkVE5yFs/TdQZiJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

SGkgSmVmZiwNCg0KVGhhbmsgeW91IGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uIEl0IGV4
cGxhaW5zIHBlcmZlY3RseSB3aHkgc2tpcHBpbmcgdGhlIGdpdC1nYyBmb3IgdGhlIG1pcnJvciBp
biB0aGUgcmVwcm9kdWNlciBmaXhlcyB0aGUgcHJvYmxlbS4NCkJ1dCBvbmUgdGhpbmcgaXMgc3Rp
bGwgY29uZnVzaW5nIGFuZCBpbmNvbnNpc3RlbnQgSU1PIC0gd2h5IHVzaW5nIGxvY2FsIHBhdGgg
Zm9yIGNsb25lIHN0aWxsIHdvcmtzIChldmVuIHdpdGggdGhlIGdpdC1nYyBpbiBib3RoIG1hc3Rl
ciBhbmQgbWlycm9yIHdoaWNoIHJlbW92ZXMgdGhlIG9ic29sZXRlZCBjb21taXQgb2JqZWN0KSB3
aGlsZSBpdCBzaG91bGQgbm90IChiYXNlZCBvbiB5b3VyIGV4cGxhbmF0aW9uIGFuZCB0aGUgImdp
dCBoZWxwIGNsb25lIiBzbmlwcGV0IHlvdSBwcm92aWRlZCkNCkNvdWxkIHlvdSBwbGVhc2UgY2xh
cmlmeT8NCg0KVGhhbmtzLA0KT2xlZy4NCg0KU3RlcHM6DQokIGNhdCBkb2l0DQojIS9iaW4vc2gN
CnNldCAteGUNCnJtIC1yZiB0c3QNCm1rZGlyIHRzdA0KY2QgdHN0DQpta2RpciBtYXN0ZXINCmdp
dCAtQyBtYXN0ZXIgaW5pdCAtLWJhcmUNCmdpdCBjbG9uZSBtYXN0ZXIgbG9jYWwNCnRvdWNoIGxv
Y2FsL2Zvbw0KZ2l0IC1DIGxvY2FsIGFkZCAuDQpnaXQgLUMgbG9jYWwgY29tbWl0IC1tIGluaXQt
Y29tbWl0DQpnaXQgLUMgbG9jYWwgcHVzaA0KZWNobyBmb28gPiBsb2NhbC9mb28NCmdpdCAtQyBs
b2NhbCBjb21taXQgLWEgLW0gZHVtbXktY29tbWl0DQpyZXY9YGdpdCAtQyBsb2NhbCBsb2cgLTEg
LS1mb3JtYXQ9JWhgDQpnaXQgLUMgbG9jYWwgcHVzaCBvcmlnaW4gSEVBRDpyZWZzL2hlYWRzL2R1
bW15DQpnaXQgY2xvbmUgLS1taXJyb3IgZmlsZTovL2Bwd2RgL21hc3RlciBtaXJyb3INCmdpdCBj
bG9uZSAtLXJlZmVyZW5jZSBgcHdkYC9taXJyb3IgYHB3ZGAvbWFzdGVyIGxvY2FsMQ0KZ2l0IC1D
IGxvY2FsMSBsb2cgLS1vbmVsaW5lIG9yaWdpbi9kdW1teQ0KZ2l0IC1DIGxvY2FsIGNvbW1pdCAt
LWFtZW5kIC1tIG5ldy1kdW1teS1jb21taXQNCmdpdCAtQyBsb2NhbCBwdXNoIC1mIG9yaWdpbiBI
RUFEOmR1bW15DQpnaXQgLUMgbG9jYWwgbG9nIC0tb25lbGluZSBvcmlnaW4vZHVtbXkNCmdpdCAt
QyBtaXJyb3IgZmV0Y2gNCmdpdCAtQyBtaXJyb3IgZ2MgLS1wcnVuZT1ub3cNCmdpdCAtQyBtaXJy
b3IgbG9nIC0xIC0tb25lbGluZSAkcmV2IC0tIHx8IGVjaG8gRkFJTA0KZ2l0IC1DIG1hc3RlciBn
YyAtLXBydW5lPW5vdw0KZ2l0IC1DIG1hc3RlciBsb2cgLTEgLS1vbmVsaW5lICRyZXYgLS0gfHwg
ZWNobyBGQUlMDQpnaXQgLUMgbG9jYWwxIGZldGNoDQojZ2l0IC1DIGxvY2FsMSByZW1vdGUgdXBk
YXRlIC0tcHJ1bmUNCmdpdCAtQyBsb2NhbDEgbG9nIC0tb25lbGluZSBvcmlnaW4vZHVtbXkNCg0K
VGFpbCBvZiB0aGUgc2NyaXB0IGV4ZWN1dGlvbiBvdXRwdXQ6DQoNCisgZ2l0IC1DIG1pcnJvciBm
ZXRjaA0KcmVtb3RlOiBFbnVtZXJhdGluZyBvYmplY3RzOiA1LCBkb25lLg0KcmVtb3RlOiBDb3Vu
dGluZyBvYmplY3RzOiAxMDAlICg1LzUpLCBkb25lLg0KcmVtb3RlOiBUb3RhbCAzIChkZWx0YSAw
KSwgcmV1c2VkIDAgKGRlbHRhIDApLCBwYWNrLXJldXNlZCAwDQpVbnBhY2tpbmcgb2JqZWN0czog
MTAwJSAoMy8zKSwgMjMwIGJ5dGVzIHwgMjMwLjAwIEtpQi9zLCBkb25lLg0KRnJvbSBmaWxlOi8v
L3RtcC90c3QvbWFzdGVyDQogKyA2ZTcyZjZhLi4uNTUzZGEyYyBkdW1teSAgICAgIC0+IGR1bW15
ICAoZm9yY2VkIHVwZGF0ZSkNCisgZ2l0IC1DIG1pcnJvciBnYyAtLXBydW5lPW5vdw0KRW51bWVy
YXRpbmcgb2JqZWN0czogNiwgZG9uZS4NCkNvdW50aW5nIG9iamVjdHM6IDEwMCUgKDYvNiksIGRv
bmUuDQpEZWx0YSBjb21wcmVzc2lvbiB1c2luZyB1cCB0byA5NiB0aHJlYWRzDQpDb21wcmVzc2lu
ZyBvYmplY3RzOiAxMDAlICgyLzIpLCBkb25lLg0KV3JpdGluZyBvYmplY3RzOiAxMDAlICg2LzYp
LCBkb25lLg0KQnVpbGRpbmcgYml0bWFwczogMTAwJSAoMi8yKSwgZG9uZS4NClRvdGFsIDYgKGRl
bHRhIDEpLCByZXVzZWQgNCAoZGVsdGEgMCksIHBhY2stcmV1c2VkIDANCisgZ2l0IC1DIG1pcnJv
ciBsb2cgLTEgLS1vbmVsaW5lIDZlNzJmNmEgLS0NCmZhdGFsOiBiYWQgcmV2aXNpb24gJzZlNzJm
NmEnDQorIGVjaG8gRkFJTA0KRkFJTA0KKyBnaXQgLUMgbWFzdGVyIGdjIC0tcHJ1bmU9bm93DQpF
bnVtZXJhdGluZyBvYmplY3RzOiA2LCBkb25lLg0KQ291bnRpbmcgb2JqZWN0czogMTAwJSAoNi82
KSwgZG9uZS4NCkRlbHRhIGNvbXByZXNzaW9uIHVzaW5nIHVwIHRvIDk2IHRocmVhZHMNCkNvbXBy
ZXNzaW5nIG9iamVjdHM6IDEwMCUgKDIvMiksIGRvbmUuDQpXcml0aW5nIG9iamVjdHM6IDEwMCUg
KDYvNiksIGRvbmUuDQpCdWlsZGluZyBiaXRtYXBzOiAxMDAlICgyLzIpLCBkb25lLg0KVG90YWwg
NiAoZGVsdGEgMSksIHJldXNlZCAwIChkZWx0YSAwKSwgcGFjay1yZXVzZWQgMA0KKyBnaXQgLUMg
bWFzdGVyIGxvZyAtMSAtLW9uZWxpbmUgNmU3MmY2YSAtLQ0KZmF0YWw6IGJhZCByZXZpc2lvbiAn
NmU3MmY2YScNCisgZWNobyBGQUlMDQpGQUlMDQorIGdpdCAtQyBsb2NhbDEgZmV0Y2gNCkZyb20g
L3RtcC90c3QvbWFzdGVyDQogKyA2ZTcyZjZhLi4uNTUzZGEyYyBkdW1teSAgICAgIC0+IG9yaWdp
bi9kdW1teSAgKGZvcmNlZCB1cGRhdGUpDQorIGdpdCAtQyBsb2NhbDEgbG9nIC0tb25lbGluZSBv
cmlnaW4vZHVtbXkNCjU1M2RhMmMgKG9yaWdpbi9kdW1teSkgbmV3LWR1bW15LWNvbW1pdA0KZjVl
YWI3ZiAoSEVBRCAtPiBtYXN0ZXIsIG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKSBpbml0LWNv
bW1pdA0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8
cGVmZkBwZWZmLm5ldD4gDQpTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjYsIDIwMjQgNzo1MyBB
TQ0KVG86IE1pcm9jaG5paywgT2xlZyBWIDxvbGVnLnYubWlyb2NobmlrQGludGVsLmNvbT4NCkNj
OiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogImdpdCBmZXRjaCIgZmFpbHMgZm9y
IGEgLS1yZWZlcmVuY2UgY2xvbmUgYWZ0ZXIgYW4gb3V0ZXIgZm9yY2VkIHB1c2gNCg0KT24gV2Vk
LCBEZWMgMjUsIDIwMjQgYXQgMDU6MjM6MTNQTSArMDAwMCwgTWlyb2NobmlrLCBPbGVnIFYgd3Jv
dGU6DQoNCj4gV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMg
dG8gcmVwcm9kdWNlIHlvdXIgDQo+IGlzc3VlKQ0KPiANCj4gJCBjYXQgLi9kb2l0DQo+ICMhL2Jp
bi9zaA0KPiBzZXQgLXhlDQo+IHJtIC1yZiB0c3QNCj4gbWtkaXIgdHN0DQo+IGNkIHRzdA0KPiBt
a2RpciBtYXN0ZXINCj4gZ2l0IC1DIG1hc3RlciBpbml0IC0tYmFyZQ0KPiBnaXQgY2xvbmUgbWFz
dGVyIGxvY2FsDQo+IHRvdWNoIGxvY2FsL2Zvbw0KPiBnaXQgLUMgbG9jYWwgYWRkIC4NCj4gZ2l0
IC1DIGxvY2FsIGNvbW1pdCAtbSBpbml0LWNvbW1pdA0KPiBnaXQgLUMgbG9jYWwgcHVzaA0KPiBl
Y2hvIGZvbyA+IGxvY2FsL2Zvbw0KPiBnaXQgLUMgbG9jYWwgY29tbWl0IC1hIC1tIGR1bW15LWNv
bW1pdCBnaXQgLUMgbG9jYWwgcHVzaCBvcmlnaW4gDQo+IEhFQUQ6cmVmcy9oZWFkcy9kdW1teSBn
aXQgY2xvbmUgLS1taXJyb3IgZmlsZTovL2Bwd2RgL21hc3RlciBtaXJyb3IgDQo+IGdpdCBjbG9u
ZSAtLXJlZmVyZW5jZSBgcHdkYC9taXJyb3IgZmlsZTovL2Bwd2RgL21hc3RlciBsb2NhbDEgZ2l0
IC1DIA0KPiBsb2NhbDEgbG9nIC0tb25lbGluZSBvcmlnaW4vZHVtbXkgZ2l0IC1DIGxvY2FsIGNv
bW1pdCAtLWFtZW5kIC1tIA0KPiBuZXctZHVtbXktY29tbWl0IGdpdCAtQyBsb2NhbCBwdXNoIC1m
IG9yaWdpbiBIRUFEOmR1bW15IGdpdCAtQyBtaXJyb3IgDQo+IGZldGNoIGdpdCAtQyBtaXJyb3Ig
Z2MgLS1wcnVuZT1ub3cgZ2l0IC1DIGxvY2FsMSBmZXRjaCBnaXQgLUMgbG9jYWwxIA0KPiBsb2cg
LS1vbmVsaW5lIG9yaWdpbi9kdW1teQ0KPg0KPiBbLi4uXQ0KPg0KPiBXaGF0IGhhcHBlbmVkIGlu
c3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpDQo+IA0KPiArIGdpdCAtQyBsb2NhbDEgZmV0Y2gNCj4g
ZmF0YWw6IGJhZCBvYmplY3QgcmVmcy9yZW1vdGVzL29yaWdpbi9kdW1teQ0KPiBlcnJvcjogZmls
ZTovLy90bXAvdHN0L21hc3RlciBkaWQgbm90IHNlbmQgYWxsIG5lY2Vzc2FyeSBvYmplY3RzDQoN
ClRoaXMgaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW9yLCBhbmQgd2hhdCB0aGUgd2FybmluZyBpbiAi
Z2l0IGhlbHAgY2xvbmUiDQppcyB0YWxraW5nIGFib3V0Og0KDQogIE5PVEU6IHRoaXMgaXMgYSBw
b3NzaWJseSBkYW5nZXJvdXMgb3BlcmF0aW9uOyBkbyBub3QgdXNlIGl0IHVubGVzcyB5b3UNCiAg
dW5kZXJzdGFuZCB3aGF0IGl0IGRvZXMuIElmIHlvdSBjbG9uZSB5b3VyIHJlcG9zaXRvcnkgdXNp
bmcgdGhpcw0KICBvcHRpb24gYW5kIHRoZW4gZGVsZXRlIGJyYW5jaGVzIChvciB1c2UgYW55IG90
aGVyIEdpdCBjb21tYW5kIHRoYXQNCiAgbWFrZXMgYW55IGV4aXN0aW5nIGNvbW1pdCB1bnJlZmVy
ZW5jZWQpIGluIHRoZSBzb3VyY2UgcmVwb3NpdG9yeSwgc29tZQ0KICBvYmplY3RzIG1heSBiZWNv
bWUgdW5yZWZlcmVuY2VkIChvciBkYW5nbGluZykuIFRoZXNlIG9iamVjdHMgbWF5IGJlDQogIHJl
bW92ZWQgYnkgbm9ybWFsIEdpdCBvcGVyYXRpb25zIChzdWNoIGFzIGdpdCBjb21taXQpIHdoaWNo
DQogIGF1dG9tYXRpY2FsbHkgY2FsbCBnaXQgbWFpbnRlbmFuY2UgcnVuIC0tYXV0by4gKFNlZQ0K
ICBnaXQtbWFpbnRlbmFuY2UoMSkuKSBJZiB0aGVzZSBvYmplY3RzIGFyZSByZW1vdmVkIGFuZCB3
ZXJlIHJlZmVyZW5jZWQNCiAgYnkgdGhlIGNsb25lZCByZXBvc2l0b3J5LCB0aGVuIHRoZSBjbG9u
ZWQgcmVwb3NpdG9yeSB3aWxsIGJlY29tZQ0KICBjb3JydXB0Lg0KDQpZb3VyICJtaXJyb3IiIHJl
cG9zaXRvcnkgaGFzIG5vIGlkZWEgdGhhdCBvdGhlciByZXBvc2l0b3JpZXMgYXJlIGRlcGVuZGlu
ZyBvbiBpdC4gVG8gc2FmZWx5IGRvIGEgImdpdCBnYyIgdGhlcmUsIGl0IHdvdWxkIG5lZWQgdG8g
a25vdyBhbGwgb2YgdGhlIG9iamVjdHMgdGhhdCBhcmUgcmVmZXJlbmNlZCBieSB0aGUgZGVwZW5k
ZW50IHJlcG9zaXRvcmllcywgdG8gY291bnQgdGhlbSBhcyByZWFjaGFibGUuDQoNCk9uZSB3YXkg
dG8gZG8gdGhhdCBpcyBzb21ldGhpbmcgbGlrZToNCg0KICAxLiBFbmFibGUgdGhlICJwcmVjaW91
c09iamVjdHMiIGZsYWcgaW4gdGhlIG1pcnJvciByZXBvLCB0byBwcmV2ZW50DQogICAgIGFjY2lk
ZW50YWwgZGVzdHJ1Y3Rpb24gKGUuZy4sIGZyb20gYXV0by1nYyk6DQoNCiAgICAgICBnaXQgLUMg
bWlycm9yIGNvbmZpZyBjb3JlLnJlcG9zaXRvcnlGb3JtYXRWZXJzaW9uIDENCiAgICAgICBnaXQg
LUMgbWlycm9yIGNvbmZpZyBleHRlbnNpb25zLnByZWNpb3VzT2JqZWN0cyB0cnVlDQoNCiAgMi4g
V2hlbiB5b3UgZG8gd2FudCB0byBydW4gZ2Mgb24gdGhlIG1pcnJvciByZXBvLCBjb2xsZWN0IGFs
bCBvZiB0aGUNCiAgICAgcmVmZXJlbmNlcyBmcm9tIGNoaWxkIHJlcG9zIGZpcnN0Og0KDQogICAg
ICAgIyBjb2xsZWN0IHJlZmVyZW5jZXMgZnJvbSBhbGwgY2hpbGQgcmVwb3M7IHRoZSBkZXN0aW5h
dGlvbg0KICAgICAgICMgZG9lc24ndCByZWFsbHkgbWF0dGVyIGhlcmUsIGFuZCB5b3UgY291bGQg
ZXZlbiBkZWxldGUNCiAgICAgICAjIHJlZnMvY2hpbGQvKiBhZnRlciB0aGUgZ2MgaWYgeW91IHdh
bnQNCiAgICAgICBmb3IgJHJlcG8gaW4gbG9jYWwqOyBkbw0KICAgICAgICAgZ2l0IC1DIG1pcnJv
ciBmZXRjaCAtLXBydW5lIC4uLyRyZXBvIHJlZnMvKjpyZWZzL2NoaWxkLyRyZXBvLyoNCiAgICAg
ICBkb25lDQoNCiAgICAgICAjIG5vdyBnYywgZGlzYWJsaW5nIHByZWNpb3VzT2JqZWN0cyB0ZW1w
b3JhcmlseQ0KICAgICAgIGdpdCAtYyBleHRlbnNpb25zLnByZWNpb3VzT2JqZWN0cz1mYWxzZSBn
YyAtLXBydW5lPW5vdw0KDQpUaGlzIGlzIChyb3VnaGx5KSB3aGF0IGEgc2l0ZSBsaWtlIEdpdEh1
YiBpcyBkb2luZyBvbiB0aGUgYmFja2VuZCB3aXRoIHJlcG9zaXRvcnkgZm9ya3MuIEJ1dCBHaXQg
ZG9lc24ndCBzaGlwIGFueSBzY3JpcHRzIHRvIGhlbHAgd2l0aCBpdCwgYW5kIEkgZG9uJ3Qgb2Zm
aGFuZCBrbm93IG9mIGFueSBwdWJsaWMgb25lcy4gSSBhc3N1bWUgR2l0TGFiIGRvZXMgc29tZXRo
aW5nIHNpbWlsYXIsIGFuZCB0aGVpciBzeXN0ZW0gbWF5IGJlIG9wZW4gc291cmNlLg0KDQpTb21l
IGdvdGNoYXM6DQoNCiAgLSB0aGlzIGlzIG9idmlvdXNseSByYWN5IHdpdGggc2ltdWx0YW5lb3Vz
IHVwZGF0ZXMgdG8gdGhlIGxvY2FsIHJlcG9zDQoNCiAgLSB5b3UnZCBwcm9iYWJseSB3YW50IHRv
IGZldGNoIEhFQUQgYXMgd2VsbCwgdG8gY292ZXIgZGV0YWNoZWQgSEVBRHMNCg0KICAtIGl0IHdv
bid0IGNvdmVyIGJsb2JzL3RyZWVzIHJlZmVyZW5jZWQgYnkgdGhlIGluZGV4IG9mIGVhY2ggY2hp
bGQNCiAgICByZXBvIChidXQgdGhvc2UgYXJlIHByb2JhYmx5IGdvaW5nIHRvIGJlIGxvY2FsIHRv
IHRob3NlIHJlcG9zDQogICAgYW55d2F5KS4NCg0KICAtIGl0IHdvbid0IGNvdmVyIHJlZmxvZ3Mg
aW4gdGhlIGxvY2FsIHJlcG9zIGVpdGhlciAoYnV0IGl0J3Mgbm90IHRoZQ0KICAgIGVuZCBvZiB0
aGUgd29ybGQgaWYgYSByZWZsb2cgZW50cnkgZ29lcyBzdGFsZSkNCg0KQW5vdGhlciwgcGVyaGFw
cyBzaW1wbGVyIGFwcHJvYWNoLCBpcyB0byBqdXN0IG5ldmVyIGV4cGlyZSBvYmplY3RzIGZyb20g
dGhlIG1pcnJvciByZXBvICh3aXRoIHRoZSBvYnZpb3VzIGRvd25zaWRlIGJlaW5nIHRoYXQgeW91
IG1pZ2h0IGNhcnJ5IG9iamVjdHMgZm9yZXZlciB0aGF0IG5vYm9keSBjYXJlcyBhYm91dCkuIFlv
dSBjYW4gc2V0IGdjLnBydW5lRXhwaXJlIHRvIHNvbWV0aGluZyBoaWdoLCBhbmQgdGhlbiBsb29r
IGludG8gZ2MuY3J1ZnRQYWNrcyB0byBzdG9yZSB0aGUgb2xkIG9iamVjdHMgaW4gYSBtb3JlIGVm
ZmljaWVudCBmb3JtLg0KDQpIb3BlIHRoYXQgaGVscHMuDQoNCi1QZWZmDQo=
