Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923C1DE2CF
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112848; cv=fail; b=eQ8qYOVJJHlIHKhlAnJLE1xtYvPFUu9CrwB/Ibyuw+1uWKMNa9TMveVnoowxvqu7WOj4anuSWu69zi9CtGqNMqerTXHbymbj0qukKovUTpiTnWRR+iz4njR+XMuD5p6jAMMph2Ode4wJAWER+KFagZPhNTEZfWrOf6A827HdVlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112848; c=relaxed/simple;
	bh=gvdM4OJWllMxcu/B9qg/GQKe9wp7U+MXNkJEUQJsVwQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHsO0iY2KbOPLFHhU4HQb9q2FlryA1njgHpX4Xzrf2x0aYdT7SvH+kTr4/T65EekHH25xHUbXBjFGGU29XslGliGK3iOsxuZIYNl4olU9h2mJOgQq/zoTyjq6K1XjCTBN7s7qIa/QeWLlYOnj+tQIR8Mmj59UBXgEPJLS/vSQTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMJiHp7I; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMJiHp7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750112847; x=1781648847;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gvdM4OJWllMxcu/B9qg/GQKe9wp7U+MXNkJEUQJsVwQ=;
  b=WMJiHp7IArd23kifm+4C3hM7HjGJKk8Hg7QZVax/CqnRXHPtlK6tjlHf
   ZwFpYz8NY//55sURTxVpcGNge/xvXSOzrjB3aA7iDfhOx721rKhWkcUxw
   4SJ+FP/sRiYcZ1aELa0sk4q+YsvoItRyE38qJqcW6Wl0hJ+xzGDbd02dD
   kHaptw8kHYd7cmjuCguaujqatTFEYp78y/NqPvyM15Zj2y0Y0CwKGB1Si
   r3BwlG6JHEWoTHtB5LX9F8/QhykoOVaZBGKUFTa3M6H5k4WqIaUK4x0Tm
   VK59hqso3RYBZAPu7TbvtfqaPZZOiqOiCWeknCryZoSaLvBS/LwK9xytf
   g==;
X-CSE-ConnectionGUID: EiXLN+27RgOMMmxyMkqYqw==
X-CSE-MsgGUID: 0sS3aGetSHm0XoRDorV0SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51379911"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51379911"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:27:26 -0700
X-CSE-ConnectionGUID: ZEo2eU2VSXaqLt9Bhn+syQ==
X-CSE-MsgGUID: 4csnXSwqTEaE6GDCo8Ob0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148957989"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:27:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:27:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:27:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fac7fK79/u/nOQZQKtpP79gohWiuc3k03V5Nkznk/senZlp8H0urgig6OUkhJou5XceDat1ATcMcuXraR1gviBJt+LHuf0zLJ4ndCMdW8I7JPDXMBCYDInzOInftuOCSkczjANYieUtL7tik7Xx7Ox4jNYuTFaYC8CWHj38EyZWcQwK+84+pKNYa00xPCtIRcsGg2OTuS6JsiEUINv9MsCpvZ5YeMnrnU7O38cVOUtAj1MN58DO6XyaxESdJtx+unKJaRyb7QNY8z1M+6z3a/4j3MbYN/gr2CyCNHnSbsSPsz1whb1bC4yUu99stPG8LQFT8s8EcilW6TOoQC6w38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNV19fqkc80dkpjlUYqdZ0gFNximstgkE08EZ07fRD4=;
 b=bWU7nXe3Njj96lZM/1AXHofNZp450R+4uVvoUNqGt42x5VIMRGdz7XdfAGEQ5Wob8WONAsS9EP3CjW9nU/gyOEhOm5MpA/0ItvAFUV94z6xzE1bIC67TDETTG15Os+GZUZ+c2LM9VGwxD1WDo8gEVcIdlm8gqvPHml/oWhEULVVcf4Zskj6Owu+hXzav+/FLNOYEwqVQahs72W/dFrqqWv/mink/X1gv9iSyLIKGUlCl6rOaRJWhlNAaMpzQa/QJ+FZYz9FE4NeZlM8bPn5ZAI64xlbvvjVWyOE/keqLCWLcX4fOaK65EMi5cZ+AvNjHPI2UKN+P4pm+9LbTRJCETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:27:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:27:06 +0000
Message-ID: <f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com>
Date: Mon, 16 Jun 2025 15:27:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
CC: Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
Content-Language: en-US
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0053623d-2893-48c0-846a-08ddad24ec85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THRsYXo3cEg5aEtLSVh5dDBvRDg5SE1WazFiUWpYTGdqenc1Mk1mY3lQbGM2?=
 =?utf-8?B?UENVdFVLSDcvRmdJcE5qVlV6bGtSYU5ZMzYwRUovZ0tZTUc1Z29zbU1nZVdE?=
 =?utf-8?B?bURaZDliU0dKNUM3bWtyM3NtL3hlcmozZEV1Yk1ZRTJ1alJSRCtubjYwSXZF?=
 =?utf-8?B?TUVxVU14TFhPRnZVeHYzQnhQdTVuNEdwUHpTTjlHK0hzMTBrR2d1dHEwazg1?=
 =?utf-8?B?eFJFT3JBYmYrbldjNVF4UnNjOEdaTmRFYnF0MHpNeEFzY1ZkMnFXbnl3MFNC?=
 =?utf-8?B?WjMxWVBIMEV2SW9qSEs2bHNrdlJwZjlMNDFUUE5qclpJSzJiTThTdjRvaVQ3?=
 =?utf-8?B?bnU0RzhVSkx2YmFYTDhzN0pWTk0vOWcrUittUmZGVzJNQ0w1TE5ySG9OWDFr?=
 =?utf-8?B?YmtMT2M1VmhKbjRzbjJhdlBVMHFRWWRRL1o1YkU1YlNQaEszUUs1YTJFWEdk?=
 =?utf-8?B?YnpzNnh2M2lYdXBxM0JqNitrU0c0TkRuN1VoZDlNMzI4dzl5SkdUcHo0WUtz?=
 =?utf-8?B?TDBFZDNNUVJsNWJ6RDAycmw2eTFXYklQNDNUZUFIR0l1NUs1bHdkVnk0bGJv?=
 =?utf-8?B?WkVyTlByVVJYWkQxMXdXL2JEdVA1MWtFc3JybG5acjRnaGhxOXhIRTd3ck9p?=
 =?utf-8?B?R1BUTVVLSUJSTmtydDZVNmtrR1FxUzk2Rmd6N0hMYlBnTTNpdUd4UGtrQ1pB?=
 =?utf-8?B?N1VOVjRzdUdCOHUrcE1xMFJPUlNuWjRMN3lVS3VtYjZycjNUQUw2NjJOeDNC?=
 =?utf-8?B?Q1pXNkV4TFJPTWFCOElTOVhmcHRZZGNYK2ZIbmI1MDVkNVJxRXdrOGdDNm9s?=
 =?utf-8?B?QWNobXVmYWdEa1hILzg2M3dqc0NNdThxUUMxb21NcFN2QXA0SitCVHhXVmN1?=
 =?utf-8?B?c0FjWWQyUFVRQU9wNDVRa1llMW04UEtFdnc2cmhEZ2JWNkt1VSsxK0ZCN01O?=
 =?utf-8?B?Q09kUVZEaDFzMldLOTN3WGFteml3eXFoQ2lwNW01RGJ4ZkRqUHRnRXMvOWdV?=
 =?utf-8?B?OXQ0RFY3dTBYSXlzNVhzWGJIcGFacE83enR6RWpGTHIzRVp3QlpudTd2cXJW?=
 =?utf-8?B?dVoyZk1YY1lHaGRDZGFNb0lKa3ZjRjRoa1ZlNmVlZlU5Y1BieU9HcXVXTk41?=
 =?utf-8?B?REdqU0xUQlJKUEVvUlpPektZaU8ydDAxcEcrc1UrNllCV2JKN1E0VXlOam1P?=
 =?utf-8?B?Z0NIbm84VGlnenR0OTRTTVV1Wi94OXYzZW1ub05tQUl6VmFUM1lJSUY5WFRW?=
 =?utf-8?B?dzF0akVtVjRMbTlGLy9QcHlXU2l1MTNDbHRqWmRXYWsvZTlhWHBtbTJqOVFv?=
 =?utf-8?B?RjV0MkdtWlFhVUh4TEprbWt4ZWkvN01zWTRMYmtoL2c1dWR3MmVkbWhVY25W?=
 =?utf-8?B?NGgrdnpCU2pRempISkh0SDROUVB3OUg0bkVPNlFzVXQ5WjROZk5sdUhycWpj?=
 =?utf-8?B?SzBJcG0reGFIcTA4Wjl6cjlsNDNMNThpME5NU216SW4xSlcyZmxDWGRlVVZX?=
 =?utf-8?B?UFVjcjkyNW5FeTRpMVB5bVZpQzJ6K0JYc2hJNHhNcG9uT0F3ZWpudFVKQ0RR?=
 =?utf-8?B?WHRSRFhVZ2RpMml0c2JYMlk3bGNaaFVJdzN2djFMaWFHTWI0Z0VZSnlDaUpo?=
 =?utf-8?B?SzBrd2ZGUk14T05Jd2xkRVc0czhoamNGVE9leUlYRThVckYxSDh6ME9EOXlT?=
 =?utf-8?B?aG1ZNjJBSkZPYTAxU1c0WXJiTjF1b3pFOHl3VTd2aDNDWlJRVzVCN1hPN0tE?=
 =?utf-8?B?WFg1SE10SWtsL1B5S3ZyNFNXbndDZVd1a2lLQjB1U045S05aaC9TRGZHMWNy?=
 =?utf-8?B?bjBRdGtoUE4xNHRCNzdoenhXd0dGQmdLbk5Wbyt2dGxZTDdOWU8ySWZNTEd3?=
 =?utf-8?B?OVR2RVJyeVNGaUp1UnNCdHl0cFMwM2Y5Z2RwY09mZUxXNnhLRExHRExKcmY2?=
 =?utf-8?Q?LfA+1cwnOQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tOWHJhbTFYVnNnZEJRRk8zMWgzZUFIMkdib3ZhUFBBZVhMYWJPd0xLcjA1?=
 =?utf-8?B?QVlKSlNhWnUwd1VFZ1lGWU1jT3ZxSVpCdCtIVjlvRDc4WWpodktnV0FlUnhX?=
 =?utf-8?B?WHNKbWwyaS9ob2Q0SlR5TDVMSjdFanNZeGVNc3BteFlBaS9yRUdHL1hLZUFx?=
 =?utf-8?B?Q0QrNW8yck4wdE1tWHEzcUJGcnJSdzZTTUJUZ3gwM0xjSGowSUc0cVpVRU9Q?=
 =?utf-8?B?b0tIWnZVcGdwVENXS2dpeld1OTZPNGFsRnQ1RjNlZks1akFYa1VXT21ZREVn?=
 =?utf-8?B?bzVTcEY3NERmNFg5eXJBbDZUMFV4T0RkQXdBNk03ZjVWYlczQUdiSk9Cck5V?=
 =?utf-8?B?QTd5THhRQXExQWZWSVpJYmx1SHhyMkdrblVaRXB3ZGVJeEt6MUhUdnlqT1ZP?=
 =?utf-8?B?WlUxZVNDNmV6UUQrR2o4c3lhWHRlM0dsUCtsVzNxZHpPZzZTdms4cmlMUXdW?=
 =?utf-8?B?TnJkendTYldhVHZ3TjJOQkdudGpXbUJWY0R0RFZPYXpxOVJCdHNLQldFL0Vx?=
 =?utf-8?B?N3JTWFJqMmxReTc2R3VMMXU1OXpIc3hYMm0xemFHb3BuZUxnV3krRm1QTUpp?=
 =?utf-8?B?UjViRG9Qajk2aTdZRXdQUGRTamhiVE9jaER0bUlWR2ZyUmlKWVNhTVlWclRC?=
 =?utf-8?B?K0tlQ2gySjN3R01Ld0FsMFVlRGowVkFuOTgvdFQ0R0srM1JiVXBscXYzOXAr?=
 =?utf-8?B?SVlLa3lqbUJlZmpVcmREcnhUNjBVR0xScWpjWEFWZkZiQ09JbDJET3BHZURX?=
 =?utf-8?B?Y3ppL3IwV2l0bE84bFpNZERWWWZxd2NyUjFoN0JZMEI5V0FPTEw5TnpnNU04?=
 =?utf-8?B?ajZtMTNaSndBUjl3NkFDQVZmUzVjMjVGUk16VlhwZCt0SnR2cUdiL1lyOU1W?=
 =?utf-8?B?SXJxRm5FMTNyL3JSTzNrcGtKN21URW95WVc0eG1sZHpncmcvd29ORG5ZZHJK?=
 =?utf-8?B?Z1c3UTZ0aW53ZHI2WnlzMXQ5UzV1QnVZR3ZGSUdFcDdhcEhPTDBYcy9iMmVt?=
 =?utf-8?B?bERsc3dpeU5CaUhjQUJoTHhyOHo4MHJHMCtMNHZQK3RvV0lSM1djYXpxM0d5?=
 =?utf-8?B?MVRsSjVLYmphTGl4NXZ3S0h3S0xsTnRCZkE0V2dBZ3VLeGZxNnZieXU4Snpp?=
 =?utf-8?B?NWFMU0VKQnJYcURJTTY5WUpVa0xxUVB2WjFuRWxhRG95VmZDYzU3RUhibzEr?=
 =?utf-8?B?clZQTFpud1p6T04xRVY3UTFraGIzd0M0a2YyWExmTHBmSmk5eWhGUW0yajZJ?=
 =?utf-8?B?ZG1LZXdNV2NrYi90Q3ZzbUV4SHl2S1VhM240SC8rQXFwZFZYUmxWaXF2TXRN?=
 =?utf-8?B?WGZleGh3UHNBWWdzUUZ4VytjVGhnUjd3dnlCNVVwTURTRWZyeW1YTXE3bWJt?=
 =?utf-8?B?Q1RJRWlTTzZnNUl3bkRibkhjN3VKL0dPQ2NxcGkyUzNzVFQzUFVMbTZWTWFX?=
 =?utf-8?B?Nzh6K2QwWHl6dHlhclhSMEd4alVsMVlwTSs4b0F5TFBqWU1tMGwrVzVPTDdn?=
 =?utf-8?B?RkVtQTZHQ0lZLzFwTWZnQWQyV29oV3dubE5HZlc4R3JxczF2QWRIZTg0UUZi?=
 =?utf-8?B?a0tSSkxnbUZUSnppTXpCUGpQb2NET1FWVFByRGZlK1IybVhLZDdxczBpN3M4?=
 =?utf-8?B?WFVGNGduUGRFcVV5aUQ3T0JRV3JIN1VZR2ZHZWdLT2E5NGp4VnNUTXpRZFB4?=
 =?utf-8?B?OXZxbjd0SGpFQ3BUOEhQbkl1R3BYMmxiMnQ0cHhlUEhnYmxZdGtWMmRGanY5?=
 =?utf-8?B?eDJoYmNycFFLS0JSVUhaWXAzc1FJY1hSVm1TcXo1V1dzd0EvWnp4OTR4TVI2?=
 =?utf-8?B?VjVJWVY3VTcwbmtkL05MVTc5b3JVRVdDdU1DVXdUS29remhRQnlOS09BSzEv?=
 =?utf-8?B?MUltcjNlQ3A1bnp6dU1XMHlqaFFKdEdSUTlWWjF1MmhVN1puL3Npb21kYmRj?=
 =?utf-8?B?WjZGOVlmZ3JJMUtjWnhQVU1ETVVZZXlTMU1RRTdPRFlFM2tzeVVsV2VzckZo?=
 =?utf-8?B?OE96dldkVVk4ZmsvOHh3UUw2NGo5Sms0c292N2dCQ2gwTzMxRStobnZHaXZV?=
 =?utf-8?B?K1RUakFINDR5ODZvUnNNdnRtUmdaWldld1h3d0kyN2hvL0pGU3FRRFV4STZk?=
 =?utf-8?B?ZExjZ3JrbmtROW1ZWlF5S2oybGE0bVlHRUI2K2RkK2I4VytMc1lLL3phNFpP?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0053623d-2893-48c0-846a-08ddad24ec85
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:27:06.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZkebC0LTW6cT9t9TWEKm7JGnhU7pO00UR2QZzrPEIvSoKa+lDvJCYpbwtT6hxor5cIVms8fb3rp2cCOk4PyPiJsD3AkDrLl8XnvCSXwDaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com



On 6/10/2025 5:52 PM, Jacob Keller wrote:
> This series improves the git submodule remote lookup logic implemented in
> submodule--helper.
> 
> A few cleanups are done first:
> 
> * The starts_with_dot(_dot)_slash helper functions are moved to dir.h for
>   re-use, as these are used both within submodule--helper.c and
>   submodule-config.c
> 
> * Several remote.c helper functions are refactored to take repository
>   pointers, enabling use with a submodule repository pointer.
> 
> * The branch_release logic is fixed so that it won't dereference
>   branch->merge if it was never setup. This appeared to trigger in some
>   cases if a submodule repository was passed into the read_config()
>   function.
> 
> Next, the submodule--helper.c logic in repo_get_default_remote() is
> refactored to remote.c helper functions. A new repo_default_remote() helper
> function is added which will try to find a default remote. This helper
> first tries to look up the remote from the checked out branch, then falls
> back to the only remote (if there is exactly one remote) before finally
> falling back to "origin".
> 
> This improved logic is a good first step, but won't handle cases where
> there are multiple remotes, and when remotes have been renamed.
> 
> For the final improvement, notice that the parent project already stores
> the URL for the submodule in its .git/config or .gitmodules file. This URL
> is what we use to set the remote in the first place when cloning.
> 
> Add a repo_remote_from_url() helper which will iterate through the remotes
> and find the first remote with that URL. Use this in
> repo_get_default_remote() to first try and find a remote by its URL. If
> unsuccessful, we still keep the original fallback logic, in the off chance
> that the user has changed the URL from within the submodule.
> 
> This method is more robust as it is less likely that the user has manually
> changed the submodule URL within the submodule but not also within the
> .git/config.
> 
> With this change, all commands which need the submodule remote will first
> look up by URL before trying to use the fallback logic, and should now be
> able to find a suitable remote regardless of now they are renamed.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Jacob Keller (6):
>       dir: move starts_with_dot(_dot)_slash to dir.h
>       remote: remove the_repository from some functions
>       remote: check branch->merge before access in branch_release
>       submodule--helper: improve logic for fallback remote name
>       submodule: move get_default_remote_submodule()
>       submodule: look up remotes by URL first
> 
>  dir.h                       |  23 ++++++++++
>  remote.h                    |   3 ++
>  builtin/submodule--helper.c | 101 ++++++++++++++++++++++--------------------
>  remote.c                    | 104 ++++++++++++++++++++++++++++----------------
>  submodule-config.c          |  12 -----
>  t/t7406-submodule-update.sh |  61 ++++++++++++++++++++++++++
>  6 files changed, 207 insertions(+), 97 deletions(-)
> ---
> base-commit: 4c0e625c091d4c648cec7319bafaed3cc81658e5
> change-id: 20250610-jk-submodule-helper-use-url-e55d3c379faf
> 
> Best regards,

Seems like there hasn't been any interest in this series? :(
