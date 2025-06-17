Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4B2F0027
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195747; cv=fail; b=PLSsJEu3LaQD7T3+n2GsS/yVyoYyJ6o/WlsI2HScDmIcXclMvJM6UnmfiR5BH/iIwBkXR8PjetBPA3S0mw0wmoO+jUgGpdnwr+SGjscyBVovLk+T9CniJayKbURR+Euoh5WuF7VVnFUnn5J94kRMeciDnCnzJE1nOT3fjU2IUuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195747; c=relaxed/simple;
	bh=ksneHPPL0amd0aILL0qtdxU31X/XF75B4vi5037dSRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jABM9UDL9K8mBw3Xp6r16sXcDh5P4bUZAyxICl3I3V3PfRz6nwIRAEKTOLfzCj9Ylijdgs/+TQoQL1Wv3DUDjAk4qYvWl9qMBFEzP4OwLoPLjaCY4zuSWn4H/xMHOt7fSEn6M3HBkLkr6Os7S3muD3sVczjKcp9WYAPJQoD7+uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZNXyEXk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZNXyEXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195746; x=1781731746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ksneHPPL0amd0aILL0qtdxU31X/XF75B4vi5037dSRk=;
  b=iZNXyEXkz5tly8rdCxjpjzXHJ72ZyvS4PS1EUVCKANF8SYgWiyH2BntT
   ItUn1MVMxaIkv3VkZMu85V0fk3Kv5Bf7D324UjJgJ60QYtEZLwcGTCj8B
   RlAmK//F4oloPdEXTc/sPiZbf1IPwGK5aVwIkzovbwknsCbdd4FDqIwPj
   LDHVnZwo1uw+re/LCLLdVT+v7XDzGTBv9BtXoGQYWDDtT6U6HuJbmOCmW
   IMXJ251ljJBRsLI5Bf/rD4xc7rwQABnfq8QKOzbbXZQZcD/1kym2p0J8r
   d1RCGrq1COSqxyqUlW+EJfXdPEVO9kmvbE4QjzoBjWLE0JwNSr3VVtNmW
   g==;
X-CSE-ConnectionGUID: fViJSBKJQEej7U1Zx403Pg==
X-CSE-MsgGUID: 7BcyNegUTwKIiOi+CkPO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="74928289"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="74928289"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:29:05 -0700
X-CSE-ConnectionGUID: XsseTyI4TpCGrq3ngKSS5g==
X-CSE-MsgGUID: /OzrY0ATReKBj3O++EXPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153832107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:29:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 14:29:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 14:29:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 14:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahfQ20BQYlF492jSzWP9j4WdGLjD+MOARtorL3LJ8T3qOOLe20GztcYxCDB0Kmt4vNZ8+dJyFMSKfYu1LYQjPTg4ltQuXbntUgd5hhsUnKmg2aFcBZgCOzEeUB2m7VCRbq7W9yhlHcXN/fpG4hSXf//CiKXk0OwY1ub9yz+j/AWKLfk98CMqjHvlHdUL7TT5mCZWzMf/HVnS8LS2TyAFP4zu5F6tZ+gUZFxlxkV396fikldhRIEcMTNrzAAuTWy9Jglj3wBJIj3LoiIcu1lveZEM6bS8oO92pP94LcHehV21t5S0lLFs3ElCuHcswQRgmQGSFbpuIj+ByUlkGSGcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjPDxlSI9lXRmCzM/6fE9KrjO836uip2v1shTO+VF84=;
 b=UYod+iz78rVeZEIsppkDjUJxFxee0qgQYh6BMtcnkd5SOl54D+gXiCjA7VHdXfY+leook5pfC+6KesR7cwtIXlfX6jtkLjlL5uLxytDzyo0W5QoH9Sjn3N39CVUffZQnOlYg5gcLsZc32HYBIUHDckfYbrVr0UumJxORhZbY7mCz3E1fv0mA5rR7AzbFRTSFy5NvpTz6+P1RCyHUTQuhQFBscaWTWpJL3ta3WS6l4/7bmQ1Sabag5xkvWIIYoYdb6uBdifjDqPb4OMpP6TBwUsnEpQ0ZbcAnxblWXbNEE+hG4+UGxJ8r5enFGPGFGpDcwML4gvWw51VrLLRyoW0XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 21:28:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:28:47 +0000
Message-ID: <7333eae0-91ec-4aec-a13f-530074f0d7b6@intel.com>
Date: Tue, 17 Jun 2025 14:28:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Patrick
 Steinhardt" <ps@pks.im>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
 <f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com> <xmqqbjqnz4ve.fsf@gitster.g>
 <83af9bc9-7884-4ce8-a343-28dbcded7954@intel.com> <xmqq4iwexv4n.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq4iwexv4n.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c564b-79d9-478a-b34a-08ddade5f1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0VZNzlnZktWT3Fxczh4Vzl0MmZwcWtKR1ZrV1lQaGVHUnc5ODhYRkJ5SmxL?=
 =?utf-8?B?emZxelNvWTNkOFRxREJ5bldMcWNNSDVCYnNGUmxYU2F5V1NsWUFZT1dONEZN?=
 =?utf-8?B?Z2U4aDVQa0k5UHAxVXY2K3BYc0g0OUEwSHRha0N1Q011VEJtQ0daYlhVWERF?=
 =?utf-8?B?Q3QxdzY0dzNtS29JVUprVUUzaWRodFdOd2VhWVAyUkkwSnVTNmZRTGtnb2pF?=
 =?utf-8?B?WmNnVlI1RjN5NWVBaStsYVZRT1dGclI3Z1pxNTdPb0tHb2tlcWpDZ2FUb2Vx?=
 =?utf-8?B?SC9vdGUvNURnWm5UUHZDQWZPYXdhemFoaS8zUVg3anhKWktnWEd2WE92K2Yy?=
 =?utf-8?B?dWNRY1hTTFEyUDZNZ1d4TkZtbzd2dytOTVU5ZUU4eEdjQklybHlDa3piV2Ro?=
 =?utf-8?B?ZkVERFF1M09lNEpzdDlWUWdxOXU3NzZrdXU2NE93Z29SVStGUnJJUVdzRWdU?=
 =?utf-8?B?OWppdUxGdURFRndaNGVwZkQ5N2QwQSs1UEVWZXhzMk9XeWN2QjhabUx1MXN0?=
 =?utf-8?B?ZWd6cXhvdFRUdFp0bGZLQVJyQU4zV1B0SjBUbXhTMFhhdjNWVDVEZm9pcC9F?=
 =?utf-8?B?b2l2VUgyY0N5TmNhQ0tMenMycUc4QUVZVmJCWGtyaTRqOEk2eFNJZUljeXhs?=
 =?utf-8?B?NWEvS2FNVXJZdTFCV1BYbUdaQlhSTmlKYU9jUWczbWhaSlZKNEkra3hGTGps?=
 =?utf-8?B?a0NNNEFPcGlSNCs3TlpIek5USmNxbnFGQVNkQ3FEN0o3azFHbnI0Y0QxcE9R?=
 =?utf-8?B?YmlDV2RPWkxXckxUNFdFTiszVW8rU2RoMEtLeEQzdkkveklGWkRtT3poUUNn?=
 =?utf-8?B?REp0K2drVVVIckFvZVFnU1RkN2ozd2tjNThzQkFJb0lVU2RGcjd4SDNsTTkv?=
 =?utf-8?B?ZkVNdXJqZjk3TkhQeUY1UFVvVURMUU0yTUZtSEhGSHk1TnhLVDhMeHdyMlN5?=
 =?utf-8?B?QkN0djc0aGVlNWp0bmY0cnpMUFBmdWUrUFFJbFE3YmJKSjB2RDdqUnVwSEV5?=
 =?utf-8?B?ZFRnQWxMNDdXbUp0MHhLb2Jqd3d2YnpCYkJkUzJjOUVrTW5vUFZkTEdyUTcy?=
 =?utf-8?B?aEhRSk9RODhGT1BlYVdWUjNkZVpoQVZqeWErOXJNeVBQSmJ1OXpIUTVDY1RK?=
 =?utf-8?B?MWVHUkNoMWkraXlrVUZDNlFWWE8zWlFqOGdNemFTOWkzQnZHOW1ZdVNkd3A1?=
 =?utf-8?B?dEVHSTZ2RjZtUFAxMkZXTnoxbk1wNnlINTQ3MStRWVNHQmR6eWZEQXNyTHM3?=
 =?utf-8?B?eWdhV3NmaGo2SnZ4R1lmQjREMFlkNkR2YzJsSVJSblMveWZpVXowRTgra1dL?=
 =?utf-8?B?Q2lvaThwZWxrd2dmcHZDZ1c2RVBIcEUva0tCRzY2QUk3YU9ac1N3SXpXY3Nj?=
 =?utf-8?B?SVlMRjA2ZmtNZ1JTVEI1WkI5NkhVZEpSaStJNWpFdWxad2UwWi8zaTdnQUhS?=
 =?utf-8?B?dHp3anBRQnR0cnVyeVVMQVBJZUdGU2I4NU8vTzlnSHFjZis3dE9iditrM0Qv?=
 =?utf-8?B?dzdCRU50WVZwR0cxamprMkU4cUprL1lsaDVVOGUvNTllU29VMm9BUUFGTDNH?=
 =?utf-8?B?ZitmYk5vMHN2TDFmeW01R0UxWXRWOVBGQ094a09yeEFzV0FpR0JLbWQzYTFT?=
 =?utf-8?B?T2hSWjRQMW1XbUdndVRtRVprbHQrUDlIM3gwUW9WeTZaKzl0d0VOMUMxYUQ0?=
 =?utf-8?B?QjFMMDUyZHFsZTNlcTBUSWJTdWZzQzFTUEg2bXFwSS9VdjFEbWZ6MXdpZC84?=
 =?utf-8?B?L0FoQTlxdzZrL1RYUEwvU1p3YjZtWENKYjkwU1crc21KQ0pHQVRJTzZoOXlY?=
 =?utf-8?B?WGV0ZHNjcWZwMDVtc1MxWlNzZFUvWGI2TWJOeW9oM2tra0FUTTZyd3NZc3I2?=
 =?utf-8?B?aHNkWEQ5bnh3b0hRWHJDektFY2Q3c0NBSkc3RjVwVCttdTlPWkNMOXAraXIx?=
 =?utf-8?Q?AHIJKFhdjNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1hblh3SFpWUUREVnFjQnZTOE1yclh6cVRJTmVJSnRLZTd6TWhhQjF0cUxv?=
 =?utf-8?B?WC83VlhISzJYY0ZHRTEyRlI0bGxqdUpVbEN3Y1hjSWpYdmJ3U0YybjhGenI2?=
 =?utf-8?B?UCtoZjJYN3FTVnBuKzF0YkFtVEkrTldadlM0NDZ1bTZhTDZLQ1JYMU5KbVN1?=
 =?utf-8?B?Q3B4TFZRNkRzNU0rQy9laUh1QnlLYWxvU2syczJQNEs1WlRoTVBHTnpxeHAx?=
 =?utf-8?B?dTRkM0EwNGxrcFd0dXFsZ1EwTFRNWklmWUkyNDFXOWtmSk1DanNYUTN3Znc4?=
 =?utf-8?B?UXpid1U1cUJtRUpRT2k2alJscC90anpvWHZwelhsYnF5RVJVSzN3S1BmY2VM?=
 =?utf-8?B?dU5aeXFwK3U2UFcrYmk5OWwzQlZEL0JrREFGMU1YRFlldGVDRFo2dG4wc2FM?=
 =?utf-8?B?V1RXRnR5TzRYRDdqdEtXb0wwTHJqWURUd1BOdzZQTS9JUWVIbUtnbnlWUDdH?=
 =?utf-8?B?MjVMOFExWm9uTkdyRWoxQjFGVTZqa3d2eWxmdGxZWk1HQ0JYeEdmU1dSMFY1?=
 =?utf-8?B?Q3AyZjFDVzB3QVZ4aWxIOUJuOXk0K2o1Z0h4MlNVcGtqMGllbWRNeUVQSlho?=
 =?utf-8?B?UzNWZXpsL2hHaUVROGhkZUc2dzNDNWk0TWhwT1EzUVNkUlM1b1RwM3QxNjYx?=
 =?utf-8?B?N0E0OVZZSXdwTVA2eStCMDR4UVUwNjdNQjZoVlBxUE5SeUxGR2pYK3dEeElK?=
 =?utf-8?B?UjFTeFVUVDdDUmg4YmIrUzRyc1REVDJrSkJDT0V3NXl4b0dnVktUNWczTWN3?=
 =?utf-8?B?ZFJFWXJnSDVRK1ZJandyRm1mcS8vdi8wU0xFcmduV3hJVlBZOEI3V21NNjBW?=
 =?utf-8?B?c280Ui93ajVQYnJ6aFNNd2VtVXRnRWNCOXRpYktYT1dyR2NlUktsVlVieFlo?=
 =?utf-8?B?UVpZTE82Z0NKNFgwZ1pqaHorWm1QRzBGb1FzUmxpNWcwUnUyYmVpckFhUVB3?=
 =?utf-8?B?UW4rTzd1ZkZ4V2p3UE9ReW1wYVIrZm9MRGF1enpRbGo2NlBreDdGWSs4RTNC?=
 =?utf-8?B?RkNXNmVCWGgyOSs0VHdla1hmOTNpSnptRlVSbDg4ZklucVIvaUovbWlBSi93?=
 =?utf-8?B?dTkwcG9MU25ac1d1MW4zTDRvQWxuQ0c0SkRodEo4MzJMeWVhL2RWMG5hT0JN?=
 =?utf-8?B?a3RhTVNsRXlYcFVuZnJCS2Y1L1pMckx3SzdyamlpMGt1ZFZpZERWMDZ3bm0y?=
 =?utf-8?B?LzdtUVp0aitjSmpsMHN5dWlzWktvMjhPNjVEemhzdGJ5dFZoM1c2NitSdk1B?=
 =?utf-8?B?cEJmdTd6TUpqcTdxbzhWV0xIbWluQjRyZGhNL0JHaFFVQlVwUUNYVkVQYitJ?=
 =?utf-8?B?VEhWaUMzQVcrckZoQUduZlJRdTE5ZGQwTkpSa2t4Tjd6OW45djdyMXpvckRT?=
 =?utf-8?B?TStHamVUdW9RdWRpSk9ZZTJGWUV5SGRveVpsWHYvVWlJV2hGMWZic1VtNWtE?=
 =?utf-8?B?cm10Q2hDYmFuME5aRDViZFNObUplVnYyWVF6MUJuM1cvRzhPdnUyY0ZvOUtJ?=
 =?utf-8?B?WlpYaU0xM2RoUVBHM1RBdW1uYlRFTlJBejN1Q3p6SzdGUnJaQlJJYzVFUFA5?=
 =?utf-8?B?cWNLU3dha01iT2hCdm9oU3E1aG1OM09nYkxNeFJhMzg0MFVHd2dnQ1VHdVhG?=
 =?utf-8?B?bWVQemlxZ283TjlpUk9ZcWVlYUl4akVyOHpCUnd0L2YrNzNQQzkyaW9TMXgx?=
 =?utf-8?B?K2JhUlFTNlBobGJwYTR5VktSOTJWVWxCRjJGMFE5Y20rc2tSYVY1OUVlRTM0?=
 =?utf-8?B?aitPWjhPMEZGNHlPYnVvT2V1WHJkaGlVK3FtNEp2M2dnQUtraTBIUVBtN2t5?=
 =?utf-8?B?UEdsenhxSXB2RStKQ015dy82VC9wUWNRQ3Nub0JGSGczeU9aZG04REEvODAr?=
 =?utf-8?B?bjFJV1ZWeTRsMXNOU1hyMFZKbEYyTURxekUweVlUanlMM1RwZjkvVzhCSDNH?=
 =?utf-8?B?NnkyRzJIVndBdzVDTXN5MllXcUFaeE5xcXZvYkl3UmNlK2xnQjdzVytremow?=
 =?utf-8?B?WUU0TTJMbk9WMWVOR2I1R2VLcm1zMVhjRDFSNGllZjRvT294TlhISlBldXo1?=
 =?utf-8?B?OWpWakJuUHB1U2RMOXdZRVArYUpGSzRRc00zTWtMb2ZZWG9iZHRmUDNrcmpJ?=
 =?utf-8?B?U2hLTWI3UnU4aHI2dUNieUM5SmdteDBDaWNnWWJTZ0NFWG5LZXRGVXpIcUxo?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c564b-79d9-478a-b34a-08ddade5f1fc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 21:28:47.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iyhbk2PnFYKQsCd4aW9ivFqVyN7yyuymZ5Wq36eEOyAcAWBmhaSgoNKok2USyCdNEuLV8L4Qj9r3M8+GSlFH8a1Z307CGjQu3aWIrRpLUVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
X-OriginatorOrg: intel.com



On 6/17/2025 8:09 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> On 6/16/2025 3:41 PM, Junio C Hamano wrote:
>>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>>
>>>> Seems like there hasn't been any interest in this series? :(
>>>
>>> So far it seems, but we have been in pre-release freeze for a few
>>> weeks combined with slower summer (in northern hemisphere anyway)
>>> season, so it might have just been a bad timing.
>>
>> Oh true. I can resend once release freeze ends :)
> 
> Before doing so, can you run with leaksanitizer?  When merged to
> 'jch', many tests fail and t1013-read-tree-submodule.sh #52 is one
> of them.
> 
> Thanks.
> 
Turns out it seems that SANITIZE=address,undefined,leak doesn't actually
run the leak sanitizer.

I found several gaps in branch_release() and remote_clear() which I've
fixed in v2.
