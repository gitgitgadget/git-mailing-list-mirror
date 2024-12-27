Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B0433D9
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735326579; cv=fail; b=iUo8zneaSf/V+yIsIyXKRgLDzGgmF8RC5x2Ln5tJ3bf1eZhTlC1z9K7n8hGkP0c7yDbwkX8UEysIewzu3vu3YcZCz6TPC0f44PqqQpENK2KsYgMhec47APk8pUjXqltQU6ELD4WsFZzThzb1cJLuSicet0gdrWpGkwImpv9G5Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735326579; c=relaxed/simple;
	bh=T8YZ7MmHuwmkqC3ko8u9pMsKWArkuQRP1cw6KddGOYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWIOyh3fyubEnN+v6LFolRzowIe3H8ZpGR0WFI+5DfDlcqbH5zPo9AkOnYNdXPCOKkG8Z0Gcxc+QEuYq+hrzLC4nBkICf6ZYYZPVODShurNtrczq+6+lHX7Zfs4P8H4emdQK2qk8vUrY46f5Z63ZvYRjKK547jNtNQU7DPHtG78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPMsPb6O; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPMsPb6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735326578; x=1766862578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T8YZ7MmHuwmkqC3ko8u9pMsKWArkuQRP1cw6KddGOYE=;
  b=ZPMsPb6OoS3lZthHFJaunpPR+hrlGeuXJeQCt8veziVEb65GYkDFYzBc
   ovBRdk+nhqdyzZD5zMvqa7IZ5FVyPikM1Tsta/fCcfN1FAcnUjTIjxQyy
   eihAxzForkcvHprtHtIfOkxo50bcmGtxRmTUKdbg9o/oaRY4asv5C8zvl
   Z4qft5YyIsINubJxbvNpYnUAjYQfcqzpcofzldJ5olqroZsWR2GHz/w82
   lJ9m5Pghw1eVJ2qGIHEDkgAsKx8sA/+KZE821IkpiyXrJrmStW1s46cPx
   0buvPifibAkBFWoikCC5O76fkeZRQWFgR7nlEnTZ0ZqqRr3oA6OhUsVBG
   g==;
X-CSE-ConnectionGUID: sXRgdQsDT8uNJYOAvpBGNw==
X-CSE-MsgGUID: R/pWtxqVS7+bSsso7jl/hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="61102674"
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="61102674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 11:09:37 -0800
X-CSE-ConnectionGUID: 8xsEdR7qQDuIt70ySHhfrg==
X-CSE-MsgGUID: W9nv6XgyRvisL0L5CdkL3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104840228"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2024 11:09:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 27 Dec 2024 11:09:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 27 Dec 2024 11:09:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 27 Dec 2024 11:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcb8VIvUSTdxpBWPL8SPdzJpnk82V0kEcgWN3dzZ3+Q+oRSVkjKVsTNzTztHEyYeMcmK2/oexc6oib0siWgcBFH5mQSqA1tYMe1h95VR3I+fpt+eDzahai/+pHiMebANUn+HU4ocFdrB2rNtWTI2TVpF46Oi0wSeMPfDeGOSsysV8eYc2kD+18PjOlR4c8MVkewSgf/8ZJWcHIa3GvcYWY6FUAJ4c8aeSkXS3+XZhSxF8I0C6eK1Ca92w9ypjwMZjZzxduOk9ZdERfq1S4Me1v/uNgJQj0xQJABfW5hv31HW7HnJjP3wy9nWkzgPqsmYqr7OIkTvJp8+cuojPqTPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8YZ7MmHuwmkqC3ko8u9pMsKWArkuQRP1cw6KddGOYE=;
 b=NPriOjpgmLIks+2tqf86TQoIvozXdDs55A2tkgrxPd+w8+xZov3E0UZpb9+832+M5R1NlSnkmLiv1dEaLXwolgdRqzeBkFXskUmY9ZIKIKffYkNm0e7of5sR9mwhaHhkx0kcyJYv66EB0z842E6WASkHGo3t+UKP828po+JgFqK7j29l7jWlHaVVw3mW3iFRaNK8VpaFtBQxPl5+Ehfz16MFWJOkUDud5PYRrFUp3bCuir1QMQG2IeFwih8PU8DU8YsztkRP3xY9jT3AVOO9cJSPXI4vcHlzzrYUG/v8ctu+VHt6MbX75fCckXNBP35c4qb9PGd38aAWPCm03InbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 19:09:30 +0000
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445]) by SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445%7]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 19:09:30 +0000
From: "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "git fetch" fails for a --reference clone after an outer forced
 push
Thread-Topic: "git fetch" fails for a --reference clone after an outer forced
 push
Thread-Index: AdtW8agD8oNkxpxFQYmlXNFV0tRXmwAvI/OAAAMoABAAFnGIgAAfiWwQ
Date: Fri, 27 Dec 2024 19:09:29 +0000
Message-ID: <SJ0PR11MB581453EE2F26A8AAA4D68158C60E2@SJ0PR11MB5814.namprd11.prod.outlook.com>
References: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>
 <20241226155251.GA69868@coredump.intra.peff.net>
 <SJ0PR11MB58148000A9DCB33CCFD792A0C60D2@SJ0PR11MB5814.namprd11.prod.outlook.com>
 <20241227040551.GA86251@coredump.intra.peff.net>
In-Reply-To: <20241227040551.GA86251@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5814:EE_|IA0PR11MB7933:EE_
x-ms-office365-filtering-correlation-id: 51c06ac6-67f2-46b0-5d29-08dd26a9fd77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MmlnZTNlSjZXZVhJUHNwTm5YTTVDSWpiN3N6Y0hoUXlCYXcyRkF6aC9ueVFj?=
 =?utf-8?B?aDJNVHRneXh5bXYvZjlMaXN4azl3WXgwR082R1l3ZkJPMGxCazh6NXViTXV4?=
 =?utf-8?B?cW1mYWxiSzROTi9jMGkvb0tFdExESmVWOXhUdEZOWEVQSHl4L1Qrbm5aV2ts?=
 =?utf-8?B?dk9wSDM5SVFWcmxRL0c0Y0ZidTkzc0w2azVBOHAydENDR0JoOUFzNmR3cmVJ?=
 =?utf-8?B?ZzZIL0FSUU9mbHBJNkdzREVoZHVxU3hEVzdDZmY4WFo5T0drSU5pOVA2dnJs?=
 =?utf-8?B?U2xTcW81OGlNM1FPVEc1dDQ5cnQwb1BpRmxJU3JwM1NhUFMyOFNIRTZoYjFu?=
 =?utf-8?B?UDZwbFdYbHk4WEhDcUNLZ2lqWHdhejh3ZDZpYVgwL0dvRGZwb0hvc1FobGpt?=
 =?utf-8?B?YUp5TzBTc0MzajhQTitOb3A2YVkwQW43NkZEM012VjhtOW1EZDlSbEZlTDVk?=
 =?utf-8?B?SzBUTFB4VXhoQ2xBekRGRTJjRDlXVEZGTHJkZ0FyMnJDL21CYjhTRDlXb2Zk?=
 =?utf-8?B?SUEzUWdlMi9TWWhQRG5sSVpBanFaNVc1d0RrSmhBYytHYTFoN0NsdWZCVThy?=
 =?utf-8?B?cllpQjVqNWNtTFNKZWVudUVMcGlJTkhlamZwYm9oa1k0clNmOVRVdVRzbU85?=
 =?utf-8?B?bWdDRjIwVmpUbGs4RXNKbWFNVWVMUFZKT3ZON2UvRSt1MExraWdUeEU4UXRk?=
 =?utf-8?B?MGVRekhLREhlVUxzMWJIbGREYUl5Z3VVYXNmc3NuemxzK1NsZCtXcmtrNWJy?=
 =?utf-8?B?amNoOTFQbFZpWGdyd3V3bjA3SDB3YnBTY2VTWkNpOGpjYjExNE9JcE4yNWZm?=
 =?utf-8?B?VWFiaTdnT2VORTR0My9KMXRsRDJYY3MzT1ZEQll3bVFuVE9CUXY1c3R0N3J5?=
 =?utf-8?B?UUdGcDQ1dnk4M3dHb3NPUXNLOEFyMyt5UWRCRFdrOExRS2NoS1lsRE5rMlBH?=
 =?utf-8?B?V1cvRkxBQkhmMzR6NWE0NktBdUpPVUNyeVliWTBhMXozVnREUy80M3FxM1N6?=
 =?utf-8?B?RGZ0bk5TVE1YQ0RiZTRLcGFkTVZSUk9HK1F3bk9FZ1F6UjlsRGVtbEdzaDJF?=
 =?utf-8?B?NTF2aHdGMkNIYVJZbGkzZjRUaTIzK0ZsVWM3UklNSkdLUW04OGpnQUhvZ0Iz?=
 =?utf-8?B?MmFTVHJpNnVzbjNLQyt1N1dJSVdUUStmREVzbDgydFJkWHprd1NJYWc2TzNC?=
 =?utf-8?B?QkxxS3FNZ3YyQ0xib1pRYzZVOFplV21aSzBiV0dYZ0VEbXpSRjlYYTVRVnoy?=
 =?utf-8?B?ZDlRb3VocjVCOXQ1VWZ6NG5rMmRLMzB1dFR4Si9rTEIrV0luN2F2eDhIUVNj?=
 =?utf-8?B?Y04zaGF1c0ZwMTl2R09VM1FubFlXK1AyWCt1SUR4SktWYUo0bzZMRU9wNkdp?=
 =?utf-8?B?TC9NNnFLWXc2MkZJYTBta3J3dC9yM2V0OUFrUENjSVE3S2ZGRnhlc2JiK0Ix?=
 =?utf-8?B?b3BydVR2TXB2R2xLOVNoOCtKU2FVQzl6cGdKbjdWVldpVFZicGpMTEJIS0ZU?=
 =?utf-8?B?WlpJM1FuYXA4NmNpc3lrR01zK01PbmxYQmhoeTRqL29yODAvdVY5SzFoejZU?=
 =?utf-8?B?UXNiZnhtbWxBckwyV2NDQWpscGlEL2c5ZURaUmpaNUNtQjI1RTFTdXIyenhU?=
 =?utf-8?B?NU1ncExCTmV4ZktsdFpKODNNQnFTVzZMT21DcHczNHhZVUVEbERGNFg3cWxJ?=
 =?utf-8?B?U3VFVU5WS0ZKSnNScnVHVEJPUGRWSUg2NWVEd2RRcWk3cUZJNWhNV0RvYldW?=
 =?utf-8?B?SnllUVN0eUNBVGRNeGNNV2dWNm9sUWtJSzYyZExLb2ZsaXdLQWtYb3BoelhP?=
 =?utf-8?B?QUdTVzJCeE9vSlMxMnlmTVdlc0YzY0ViRGNWNzB1SWhNSUdRRGJSTXlvMkl6?=
 =?utf-8?B?YW8xZjlSRjliTkhBczkxMFhJRzJiWXlqaUQrNnMrbE1NR0FiWUdLUmdmZW5B?=
 =?utf-8?Q?NDx/Q+F7eAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5814.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjRlaDVWNmszSDQ4NjUxcmtlMEFpcm4vUFhjQWVHekJpVFV0UnArZ0E5Z29Y?=
 =?utf-8?B?T3AvQmR1UEVDL1RIVWhnaW15dGlzMGN1YUNHaWU5dWllVEtyRmNMV2NqOVNF?=
 =?utf-8?B?bVRjWmN3Qkp1d1EyaGVSRDBlTUNTZFNvVVV3VFZtdmJCT21SZnJoMTZHTFda?=
 =?utf-8?B?Yzh5WVQ5UjJpbkNic2dpZTNWZjgyWGMzS0orRDhsVERubFJpNlk5NHBNNnV4?=
 =?utf-8?B?OUFmM0tiaFhBZVVPVHVvajdjMzhBNVJnL1VyR25wWkl4UXRrcTNZU3VFTnN1?=
 =?utf-8?B?MzJlV2k2dFhQaXJROVFkRTQxcVF2eW44N0hpaCtXZmhtc21iY0gvTUk0TmE3?=
 =?utf-8?B?Zkx2c3dsdzhlK3pMeDFCeDRzOXBISkpDcU5YSVZ5Uk5BR0VCRFpVdXViRGpD?=
 =?utf-8?B?Slg2R2RQVmF5OFB5bndtV2t6cGdpV2lVVnhZM3RIUHlOeTdYalhBdGlCcGFP?=
 =?utf-8?B?L2NSRnR1d3lZL1J5bGhPWVo0WE02bnlrL2pQWG9MU2lKa2xVUHBoNDZPc3N2?=
 =?utf-8?B?OEVYMTR3VU9XK0VkeVh0STlIQ2VHakt0YkFnODdiWmpETzY2ZGNUUGtRZWNB?=
 =?utf-8?B?Z2tLS2dMY1c3dUhoR1ZTNWIrMk51MkJ1a2d4WU9rbW1xVGpXQjkwUHBqQ0V6?=
 =?utf-8?B?TXF0dVZ6U2ZWMWxVRW90M0ZYTXBHdFUzRHYzUHFjRjRtQVM1NDdBS3BPUXFq?=
 =?utf-8?B?UVppUWVIZWplNVpXQ00vNEdSMmZhdUVVWnJndDhBS01oMkNsSnZ5L3Fma2E0?=
 =?utf-8?B?dVg4ZEpBVUpJY3Z2ei8xdlR3VWwyaVpBQTBMWlFnME5QN3RsbmFaQnR5aWFl?=
 =?utf-8?B?SmFLdXh6bU1qTXRhOHN3aGFnV1FBSnVONW05MkdkRVVvRTMvcklvdHdyeG8w?=
 =?utf-8?B?UlBDRDJYcTYxaURnd3R2QVloVDkwWnI3M1I2NE0yZHpFM3lsVCt4OTJsdWhO?=
 =?utf-8?B?b2w1ZjFIanFkaGZLbzl4REZ3cE5oVU5IalAwMTZKQnkzeGpHVXJiQUx5SDNu?=
 =?utf-8?B?U3Z2MWpHdFNLWVVIeEcrWTRzcll4bDh3Tkc4QXhOTWxSZThzeGYzS0crallt?=
 =?utf-8?B?Qyt0VnlrRWdlSGNCaHB3REVFSStnRjRPWU5uclY3c3VZVkFhS2ZvZzJaSDRh?=
 =?utf-8?B?cm9Xam5mTnorSnJMdmordGNJaHVGb1Z5WFpZQ3VkbXRsMkNJYytwckxDQU9s?=
 =?utf-8?B?WWE3L1pJUTUvOEgwdW9EVDk3UVljZzJMaEZZaEg2d3oveThQQmNmRWVrYlFz?=
 =?utf-8?B?bC9JeFVZVzJvQ0d6S3pTczB4NUZJM2crUU5GZXdGYUxXMzFCUm91WVpDRTFQ?=
 =?utf-8?B?ZVNoTE5IbjQzMVRzZERraUZ6TDhqT2E2RmE5dmdzRDBnNUtacmM1cU5NSzJZ?=
 =?utf-8?B?eW1yT1pXSnY5QVdPRmg3WkxqZTBtNGJTQ0QrQnhJaTRveFppL1V2RHA0bU51?=
 =?utf-8?B?aTdiNUZnQlJmQlN2NmpIaHJaY2dDNnlRR2laR2I0QWJUYkk4WVlDWmswazF0?=
 =?utf-8?B?NTgrOFZBVWxzbENjdmxqU0xxVTN2QTEzT0c0SC9jMjFaWS9rYXZPL21hMjE3?=
 =?utf-8?B?eDZqTnJzWEx1V2tOM0c1bjkySTZXT3pFSWFHWG85bVlqbVFNcVZEUU9FMllB?=
 =?utf-8?B?aDVlbnp6VE5UWExycUp0cGFiR2RrODVrSlVReUFua2hSSmdKbnUvdHQvYkdU?=
 =?utf-8?B?WXo2UVQ4Q2xFMUFmOGZjTlFERXc1a3RxTzN1ZmtSL2FMZ0tndzc0REVqRDZh?=
 =?utf-8?B?c09reG5qS0x0d1ZmUTVtREVKbEhRRjZXMm9RczBVcWFrVWNPckViL0tkVjV6?=
 =?utf-8?B?dGRGaElEQm5JSDZTU2dwSmRxU0xGd3ZmL1VNK25IQ1gyNnRvUjI0R3F1Nmlx?=
 =?utf-8?B?QytUejM2eG9TNXF2dnJqQk5GMDh0ZUpWanZKZ0VnZE5XQmhjRHZaQkNHS2pw?=
 =?utf-8?B?dFp2ZXZhbE12Y2ZWU1UvRHF5WnI5Q0pIdXM0TkdqMGUzYkdybXUzbjE0WXMv?=
 =?utf-8?B?dmI5SzN4NXpEeTdFbUg4K0ZUTWwrczNGc2N0YWxZV244OUVscVhaL3pILysw?=
 =?utf-8?B?Q2ZjUXMxM1lWWExMLzZ2MmlKZXpZY1dLNjN5WHZGNXJWYUJReWtQZ2pFcVQ3?=
 =?utf-8?Q?MvUG3/elYKuvmpqvR3wqKf8I0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c06ac6-67f2-46b0-5d29-08dd26a9fd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 19:09:29.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UtEoEOeFif1F7M9l7eKGkqm6zRdbnpa80yneqBCOve2fxjBucKQxzt3wtIh7y7vBJTgzIG4UJSf9Z1M0xyiWZbYOheJteMDWVkAvUamsHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

VGhhbmtzIQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5nIDxw
ZWZmQHBlZmYubmV0PiANClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyNiwgMjAyNCA4OjA2IFBN
DQpUbzogTWlyb2NobmlrLCBPbGVnIFYgPG9sZWcudi5taXJvY2huaWtAaW50ZWwuY29tPg0KQ2M6
IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiAiZ2l0IGZldGNoIiBmYWlscyBmb3Ig
YSAtLXJlZmVyZW5jZSBjbG9uZSBhZnRlciBhbiBvdXRlciBmb3JjZWQgcHVzaA0KDQpPbiBUaHUs
IERlYyAyNiwgMjAyNCBhdCAwNTozNjozNFBNICswMDAwLCBNaXJvY2huaWssIE9sZWcgViB3cm90
ZToNCg0KPiBCdXQgb25lIHRoaW5nIGlzIHN0aWxsIGNvbmZ1c2luZyBhbmQgaW5jb25zaXN0ZW50
IElNTyAtIHdoeSB1c2luZyANCj4gbG9jYWwgcGF0aCBmb3IgY2xvbmUgc3RpbGwgd29ya3MgKGV2
ZW4gd2l0aCB0aGUgZ2l0LWdjIGluIGJvdGggbWFzdGVyIA0KPiBhbmQgbWlycm9yIHdoaWNoIHJl
bW92ZXMgdGhlIG9ic29sZXRlZCBjb21taXQgb2JqZWN0KSB3aGlsZSBpdCBzaG91bGQgDQo+IG5v
dCAoYmFzZWQgb24geW91ciBleHBsYW5hdGlvbiBhbmQgdGhlICJnaXQgaGVscCBjbG9uZSIgc25p
cHBldCB5b3UNCj4gcHJvdmlkZWQpDQo+IENvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeT8NCg0KV2hl
biBjbG9uZSBpcyBnaXZlbiBhIHJlZ3VsYXIgcGF0aCAoYW5kIG5vdCBhIGZpbGU6Ly8gdXJsKSwg
dGhlICItLWxvY2FsIiBtb2RlIG9wdGltaXphdGlvbnMgYXJlIHVzZWQgYnkgZGVmYXVsdC4gQW5k
IGluIHRoYXQgbW9kZSwgYWxsIG9mIHRoZSBvYmplY3RzIGZyb20gdGhlIHNvdXJjZSByZXBvIGFy
ZSBhY3R1YWxseSBoYXJkLWxpbmtlZCBpbnRvIHRoZSBjbG9uZWQgcmVwby4gV2Ugc3RpbGwgc2V0
IHVwIGEgcG9pbnRlciB0byB0aGUgLS1yZWZlcmVuY2UgcmVwb3NpdG9yeSwgYnV0IG5vbmUgb2Yg
aXRzIG9iamVjdHMgd2lsbCBiZSB1c2VkIGltbWVkaWF0ZWx5IChzaW5jZSB3ZSBzaG91bGQgaGF2
ZSBldmVyeXRoaW5nIHdlIG5lZWQgYnkgaGFyZC1saW5raW5nIHRoZSBzb3VyY2UgcmVwbykuDQoN
ClNvIGhlcmU6DQoNCj4gZ2l0IGNsb25lIC0tcmVmZXJlbmNlIGBwd2RgL21pcnJvciBgcHdkYC9t
YXN0ZXIgbG9jYWwxDQoNCi4uLnRoZXJlIHdpbGwgYmUgaGFyZC1saW5rcyBmcm9tIGxvY2FsMSB0
byB0aGUgcGFja3MgaW4gbWFzdGVyLiBTbyBldmVuIGlmICJtaXJyb3IiIGdldHMgcmlkIG9mIHRo
b3NlIG9iamVjdHMsIHRoZXJlIHdpbGwgc3RpbGwgYmUgY29waWVzIGluIGxvY2FsMS4NCg0KSSB0
aGluayBpZiB5b3Ugd2VyZSB0byByZXBhY2sgbG9jYWwxLCBpdCB3b3VsZCBkcm9wIHRob3NlIGR1
cGxpY2F0ZSBvYmplY3RzIChiZWNhdXNlIGl0IHBhc3NlcyAiLWwiIHRvICJnaXQtcmVwYWNrIiB1
bmRlciB0aGUgaG9vZCkuIEFuZCB0aGVuIHlvdSdkIHN0aWxsIGJlIHN1YmplY3QgdG8gdGhlIHNh
bWUgcHJvYmxlbXMgaWYgIm1pcnJvciIgYWxzbyBnZXRzIHJpZCBvZiBpdHMgY29waWVzLg0KDQot
UGVmZg0K
