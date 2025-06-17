Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551D2E54C9
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202407; cv=fail; b=DD9ld+I6M6ZqPHjEaXWkZf2rKDrR/Yuynt8OX4i1RnGsrlOVywqfIwfp09rt1hdBLMArhlkaYAwL5kRS16qi0e7E9fkZo4XD7ZwBP3UVCv0mXS1ey7uWTcY6vjRFvzVyhfnD1TzYyVdeQR75Mp1I+dsYCCjtLPnlIMJ4iZJ43jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202407; c=relaxed/simple;
	bh=DG3Nh1KY+gbV5dk2R+dqM64b0Nz+aLBpyPmKaHbrj+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kca0qCPwfFkcM52vfLogFdibl6n54LqcQUuEmKn8RVO0dyVnRzc3Ka5VnVWGOXwLWzvn+KqJ4WIhMtXIR362ty7XGxelDC4uDzwUe/Tx9Y+St4P0Wm+GyTb443O7EsTOwr75O259AghE6ro+bbFn/o0tQPf+Xipv7fuAJcaxcVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX7Av7Ot; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX7Av7Ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750202406; x=1781738406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DG3Nh1KY+gbV5dk2R+dqM64b0Nz+aLBpyPmKaHbrj+o=;
  b=UX7Av7OtvFmDkX3bus8B6hhiJYU5WAZIHPKfYPdhefNBk4IB2sicey3w
   bxEWfQJxnDDr4lMi0aBYDAIgC6v4IsgfmftKI4CxzF2rX5sTMNhB+gY2X
   mEopfmy2Ln1g1QaiUyI523ntcgabmyGIzJlv8ILjYsxKSzQuFckx34Yho
   QxxQM8m0e/RsTzbDOKYY6NTCSDIguQK7Npa4ENBwqpBbX1eR0Rsi9uZsh
   qo4s9XmeNAKKtSAeCTJXEQhQvknknZt/O9SeF4wbKloHKLs4eQcx7FZNO
   dsFXnvswJZ+6eQVFCH8PiHDRQYk+8F1T2y08cX2qLqobQ0TjRcvMFHuTi
   w==;
X-CSE-ConnectionGUID: WW1T8oPvQcCyqxxzgjmZpQ==
X-CSE-MsgGUID: t5hezbVITZOommvNgJxxXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52106712"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52106712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:20:05 -0700
X-CSE-ConnectionGUID: TprNnVXRTLyfLFEdzpIU9Q==
X-CSE-MsgGUID: h/xc/xUrTqaJ8I3i/nSmhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="148859063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:20:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:20:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 16:20:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNpBMB67/SjFPOCplhzIl1Be73VRCKCZ9fnXdrgRi+Veu4AN0xd3HLIXOcGa04rG1p2YmiDaDm+37muHn1UgFsOuw5QakULqAyZH9hmT7eBQgzGHuzQDSnTG9K1GirZsIH/GSy4q8bm8y9tKwiakcJ+KpGXzHlWsuLkHWVsVA60uw/jQKut+BDurbUC2hlRdd1XghZ02grb+HowAn8CWrixLQ+p/H8d5rU2f6vhQtfEDxDQIl7D/pUsU6vnZ2l4hAB9Gu3zZsILCC4JsYxFnwA+DWvY/wE0OPDSWGwJUkxG0SdjC0cWv7kXiW8p+lLS6ayfdYMxx8bz9XVGt5x79Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlHvqSSgDEDfwYVbZuFYhdqLRkvOJLFgIBCUC4odwJc=;
 b=DthXbhkzy5g09irRqcFWgWCWFB1b746OBbbMm8Hi+nS23pRErNWsjmyqCp+gI9yAinSz7s2wtIPyfQ7FikYGxoh449z2/Enfch8I9Tg5Jkz9pb1252/o1BZ28O7YUs3uHAKg2zZzD39cLkWvRWKImfLlLFCHskSllCSVrFQHaY/Ki58c7MciD9SrFks2lHxfCNPXR2EbdczAdJzHwrFHLZ6lCnl3fsq20XUqmkCK2n0QC4V+qjV3fRVD9TN3nT+K371tCxLUWm37wi8TihkqISK2J/V4GcW/1ilZ9h8miXmjeU6R3eThLTf0bkAojurHs7HhLCdbYOLN1m2b+YYB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 23:19:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 23:19:55 +0000
Message-ID: <a0fdbc99-f5c5-4399-a82e-0bf37292868d@intel.com>
Date: Tue, 17 Jun 2025 16:19:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] remote: remove the_repository from some functions
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, Lidong Yan
	<yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-3-04cbb003177d@gmail.com>
 <xmqq7c1auguv.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq7c1auguv.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: b0124d83-6840-4e73-7fd7-08ddadf5783a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTR2cG9mNGx5VUFNTjJ5MGUvSnhidUhyOVJMbW5xSjIyQVJPZVNkNlVQRFhp?=
 =?utf-8?B?b0FaeTh0OXhoaFNzUnk1Ymt0anJhMXRYY1EzcWlKSmcrQitSZGUyamVMVWtj?=
 =?utf-8?B?MUtuOHRDNzZpbzBJQlFYakh0Wm9yK1R2YktnYU5rdlFTWjJpT1ppc0lmOGsr?=
 =?utf-8?B?UU80SEV3Y2UwUmlLNEk5QkRvZGFYNXJnSVlMdlFrZ0h1WkR6bVdQOGhTdW9t?=
 =?utf-8?B?ck5DeUp4Rk5hWEg5UEs2MlpURzZCU0JvOUh4RFF1RmgrbVE3YU1ic01vUmhK?=
 =?utf-8?B?cno3TkR3a3FmNmIwWUUxNzY5QUVqTU45bkwyTFhGMlZKWVkzcW9seWt0ajZC?=
 =?utf-8?B?Yk5rbEhtdlE1TThxY0pneU5hbzdDNFY3U1BHb0NWSXo4c1R3QU9Lc2FWVits?=
 =?utf-8?B?Y1Q4UHR1aDdxMlpYQk9wa2hBMjVZQ2pnSHdaQ3FudzZCQ0VhUloxeFdaVVFr?=
 =?utf-8?B?aWJvR2tOTGxnYjlHa2FITXVFUzBCcDNyeFA5bDF1NzRqbFVNeU1XNnpXZXh3?=
 =?utf-8?B?N2k0T1NTa0FRd3lUbmd3THdkNHNzY21uOGZnSWNucloydFdlMEFaaGl2WXJ3?=
 =?utf-8?B?K3hLYU9zOUk3SmFOSmMzTGtkLytiVEtOWXdUNTNMbmxCRDBvbVpGaVExVkRI?=
 =?utf-8?B?eUNTb2JPbmNlNzVRQVFpLys1UlRzYkZ4N1JoMmQzczh1czY2ajZSTSt0QmFZ?=
 =?utf-8?B?OER4bE1pT0liQkdwTjNtUEl4Y3NGWUU1TmVuUjlvR2F4L2pRaTFQUWtrQ0FZ?=
 =?utf-8?B?YmNBdkFub3Y5cGUzb0poT2tmcDJWZ2V3MHpVVDhaVG5PeGRQbElicUdzNCtS?=
 =?utf-8?B?ZG9obDJmc2E4azNpZGFPN2dyZmNseWNuWVlJLzN3andNbm5tQndJT3BWcER3?=
 =?utf-8?B?ME02eDByd0l1eW40MzRBQWw4d012bkFKcGRhWmVhOTI0bVNzaEZjZEhYdnl0?=
 =?utf-8?B?dFZySHFjVnJxNjB5YnF5KzJmSVp6djlGWnM0ekdPb0RzUU9RaWlaKzVjYmxL?=
 =?utf-8?B?NTd3SGY3WnJ3ZnBneXdCRkt6b1dzQWh2L2hoQVZ2SzBOK0dCdXlqcFdwYzZJ?=
 =?utf-8?B?YU5vc1NQcG9OWnF3YmJxN0hWVUZtZFRHZVJqOTljUmx3NTVZaWtJd0F6TTFL?=
 =?utf-8?B?amg4T1JSUDZ0WDVSZE5RNmlqbm52UGFvbThnRHEzWmRmd2JIQ0lnU2NvRzBu?=
 =?utf-8?B?dEFaQ0ZRaElBL3FLRlVRSWRRa04yRGVNUTJTZUxlQStYTXo2VUpVQloyN1NR?=
 =?utf-8?B?OW5EQXRjK1ZqS3BpUVlKNzQrZGRkUmxpdW85bUR3ekt4T0o4R2hIWE0wbnZ6?=
 =?utf-8?B?VHQzbU5OY1RwbnJvcEppSnllMGswYmM3MEwybDNrTGtBUFVGRFR1UTBKWlpJ?=
 =?utf-8?B?Qm5YVWJVclBZZWR1VTZBcCtWMHlEdkpGL2pER1RkT0h2U1k0OHV3NWxFUXJK?=
 =?utf-8?B?Qm9GRWwyTzhqVlFlVGFYSTcxMjRKK3NuYkphZmpld3dSTXREd2NFcXk3TlF4?=
 =?utf-8?B?bCtsQkw3aHZBZjhpOGFDR0hoYjNmMzZQK0pOWkFzZUEvamZRRSt4dkl4aW1w?=
 =?utf-8?B?c0ZaQWJjdFFpWHhoQkJvMzRRTlZMVzBlaHAyNElvaFRsWldaMUt3THhSa290?=
 =?utf-8?B?L2ptZWFTZjd0Sm15TzNHcytFLytFQUI3dkNDL2V3OE05TDBuamJUaHlKd1FV?=
 =?utf-8?B?bmtiZ2JsczlGTWF1eE0zYW9uMGhoVTZiZHlLQS9obWw2aE5tRzFNNmk1WEZO?=
 =?utf-8?B?bG4zcDZhTDMxRHlkUndRWDBWdnpTMGZTYzZsYnFKcnJiVEUvMmhtR0hOK2Rm?=
 =?utf-8?B?eGtlaGtBL0FrTUh4dnVwZFpnaWJFVkxWUk9PQU03UmVrc3gvQVZiZ2c2NFFt?=
 =?utf-8?B?S3U0MWxJR2d4b0xSRmFuYXVxeGd3eld2U2U1RC9Td280dnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlITms2Vk5oYTk5QS9mTnVSQ3ZPMkdoTWFYZndSU29uU2c4YzdXNnV6dExv?=
 =?utf-8?B?blJsQWhMTTdLNXVlbTN0bXNhcVE4YXFML0NKbExWRVZobXhWV3pmOTdPMk9l?=
 =?utf-8?B?OEZVSWJUcGlITHNQYi9TNFJtYWVLR3R6QzZDbjlDV2haMlpZS0VUVVdpSkt5?=
 =?utf-8?B?eUJaa1l6b3VlWUQyenIwaWNld1lGWGZTZEpRMTFSZnVLNjlPaG5zRzR6UldC?=
 =?utf-8?B?NDFPT0Q3NDZtNHFDMTJwTm9BWGJSYmJ4UGtHeENjR3FtVXU5UkIxYXEvN3h3?=
 =?utf-8?B?RCtFSHJoSmpReFc3MWgxU3ZjZm9iRXVEOVZIYS9XdUtCWU9WMVpLbVF5cG5Z?=
 =?utf-8?B?QlJ3RldVb0ZIZzEzR3VSSDNuTXE2TWpUQnhSZ3JVMXBjK2VNcVZDaG9ndFY0?=
 =?utf-8?B?S0pRNitRbkc1cUZDcnBVeWZtaTFKUit3OUl0TGZXY3BaaTRXZVp5bzNkYnp1?=
 =?utf-8?B?b1NzVzJubkNjYjZnQzhLR1l3Z0dhTTBPc0VSc2Vodkd1MzF5RFlYalJBeHo4?=
 =?utf-8?B?NjJoM0dJbzRFL0FWWFdBN1lpN2YweTVMTyt6MkRxa0dodHVoc1BGZDBEOXBU?=
 =?utf-8?B?eXZnSGtkM2RwRFA2VW9zdTdjS2xZTTlKcHd0RFdYUU15RDdRNHByWG5tRjZN?=
 =?utf-8?B?aXF0RHBHRjNYcjMwbUdMQzVhU1IrbjBidjAwRlAwSkpMNmFWMk1VSG96c2JO?=
 =?utf-8?B?VTR1RDdVTUdZZnpjb2Q5TXI0YTh0clU3bGoya0ZCRStZaE1FWVhDSXZHTDE4?=
 =?utf-8?B?eHFJUjJsNkRUd2pXTVdwbFI4WVVTUm9nWnRma2p3V2ZXZHp6RWxtdmhsTG10?=
 =?utf-8?B?UHNKeG42dk16RzVMRHI5T25TSjhidFFPZk1TZFBBaW9TNWMyYjVHUzJDa09G?=
 =?utf-8?B?OCs1OFJlTFFjb2Y5b0dYU09zbHBIWVpvK0ZmcUZ4SFRrb2UxY3VodlFkS1c5?=
 =?utf-8?B?MndyWHNwOGVhL05tVk1rQXpORkJCZExQWG5VTElMUlNRRFpJaXVYOTMwWmVT?=
 =?utf-8?B?ZUp6ckZJSGs5Y2lXcGRFOUxrcmlvNGtnUnpKWkNmU0ttekU5eHp2SUNyU00r?=
 =?utf-8?B?YzNGeC9GOTh3MmJGUm9GMHZvZVhIZWhxQ09aVHczK1YzSUNuWDF3RjJjUGly?=
 =?utf-8?B?b3YzWElNc2dhUWNzWWhLdjBJK04vQ3Q1UXZtRTRxa2FYcWZqQzlpUGljM1Zt?=
 =?utf-8?B?Qm1NWnN5emNLRkRkYjJzT0ttU2NMSi9jVjhKQ0pIMEZHT0JrNUlCSFlPMjYw?=
 =?utf-8?B?d1hJdGttTUcxVTFtSmNZN2JnTW1FSlVaa0crUnAxU3JNMU1PMUtuVS9sTktr?=
 =?utf-8?B?ckVPdTFZdHhyT0J5ZFlFbFprTi9iMEJrdWNkYlMzTHpuNHZYQk1RWlY3TlFv?=
 =?utf-8?B?RzV2eDIxY2hwcW1ER25MU2pYdW9SV2ZEYzhMQllhZDEwOVNqYUJkOVpITEkz?=
 =?utf-8?B?SURWT0ZTcmovNW82OExMMERRcjMvMFZOUnJ4YjR0dCtwOUNRS0VVQ1d4ek9p?=
 =?utf-8?B?ZHF0aVAxZ0p3NW01dGsyTCtNbFdsYUUrWHpvQUpUcXJnTTZzOWo0cnV6dmpP?=
 =?utf-8?B?ZVBrcXZQQVNRbTlVMSsvZHpadGw3Qkd0LzhQTWtDd2hmZGpPQkVkVDJVTVFv?=
 =?utf-8?B?eXBiNTVQeExNVk02TlppVi9OSEF3dkh5M011bER0WDQwSmptcHZLQVVDLzZ1?=
 =?utf-8?B?cHZuRFhyellzdlRYU0RucmRNdW92aFA4MDB6WDdxVndkSndXZmU4TkJRRDh2?=
 =?utf-8?B?eTBnM21yT2JZa1M4Q0x0RjJWSWVWNDQvRzZSbnV2UEluTlhGRVYya0dXS1RJ?=
 =?utf-8?B?cE5ZT0VqZW9tU29DLy95aGlXUzdnWDlSdGt5UGV1TVhwck5jcDF2SHA1VHo5?=
 =?utf-8?B?MERoSTdJRFNMNjVjK2xjMVV4TVJQN2J6QVRQdjZDMElad2tOK05kN2RwTjlv?=
 =?utf-8?B?SVRpVmROdUFFMHcvc0l0QUtDL3VFTmdQc1k4V0pjR0ZhWXBoNVhBUldrVzkv?=
 =?utf-8?B?YUVBYXF0TlUrRitLTzUvT250cTBTcXRPdzZpQUFWNGQvNjlZNmpWQ0t3RXpl?=
 =?utf-8?B?bzVKdjhUbkJtN2JlQzlBRk5WUnFqYisrM3BaUW1jUXR0bFFibGk3eFBzdExs?=
 =?utf-8?B?NzBnR0MvMytWaGlkT2VEZ1ZjamlRbmdGVU1mTkRORmtwNXRYY0RWUDRSQ2dU?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0124d83-6840-4e73-7fd7-08ddadf5783a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:19:55.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8UjWLHtbTpXtkO9jVEbSf+pfHDjNdAOfyDdY4j1HNCFU/rwSnHgqC/dZ8GgXRCMBKj+U7xRqKTiaV/7N980kW59Sw8nrlAxWdFnf8uqpXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com



On 6/17/2025 3:46 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The remotes_remote_get_1 (and its caller, remotes_remote_get, have an
>> implicit dependency on the_repository due to calling
>> read_branches_file() and read_remotes_file(), both of which use
>> the_repository. The branch_get() function calls set_merge() which has an
>> implicit dependency on the_repository as well.
>>
>> Because of this use of the_repository, the helper functions cannot be
>> used in code paths which operate on other repositories. A future
>> refactor of the submodule--helper will want to make use of some of these
>> functions.
>>
>> Refactor to break the dependency by passing struct repository *repo
>> instead of struct remote_state *remote_state in a few places.
>>
>> The public callers and many other helper functions still depend on
>> the_repository. A repo-aware function will be exposed in a following
>> change for git submodule--helper.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>  remote.c | 58 ++++++++++++++++++++++++++++------------------------------
>>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> As exactly one remote_state instance belongs to each repository ever
> since fd3cb050 (remote: move static variables into per-repository
> struct, 2021-11-17) defined the former, and remote_state is not
> shared across repository, passing the repository instance that owns
> a remote_state instance and pick up the .remote_state member out of
> it as needed would give us the right remote_state, and gives us
> access to the repository instance it owns it.
> 
> Makes perfect sense, 

Yep. It looks like most of the use of the repository structure actually
comes from the to-be-removed logic for handling the remotes_from_file
stuff.. but I don't really want to delay these fixes and improvements to
3.0. :(
