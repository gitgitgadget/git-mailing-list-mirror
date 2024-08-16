Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF11474BF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851763; cv=fail; b=LgzHS7B1UUYccq3b3ZNkGHj+FZEZ0J2zIC3MBJlTaciY+j5/NZ7SRlBOQyRzG8QVqpxpqYSuwzV4NRCaNo7eN/XbDEdepDo19HZt/fIRY8usNc67yeLqBNBLceQpf1xt5GF/JnnEE8JwZQ2To9qJ+jHvRcOzLHONgdL6HZAhcMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851763; c=relaxed/simple;
	bh=Qnh/c9I7F57+oqHc255UYX7NToysOsLkegSThFkKSBw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+2lG0BNc+5AKn2A5KG9O+uxk20ZHu7c0tss2HuHldUe3BTbIvNo0xuJQW5UMpVTCP8aj6u6m9bk7CowAHoaNqWy5MeDaMyg3W17MVOUgXGwJHODxz41nb5wftX1aeCcWVhaUdXbF2nC+yNThAV9k07AV5eZVEYEWowh9UyG+ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqgQrRKj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqgQrRKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723851761; x=1755387761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qnh/c9I7F57+oqHc255UYX7NToysOsLkegSThFkKSBw=;
  b=FqgQrRKjFYO7kaGsZ6M30dw3iVcxD5yKzA+3qE5XEVC/8BWAOxONdRKB
   tNgp8bb9vB1jou11GVcoxIv+wmxnJ2ovcdDmp9GnSwW+nIlTSkKPom3An
   9X0g/022UG6ZfxRsMx+EI0a4PJkXi72RV08phPcvraOL3t3iBKl/Na+N1
   CQnDfOi7kzGr4WrHfjslz7OkA1wJ6n8Atic8NygXBZNg0omcq9TBbL6mq
   z2Sm/Jc26HKDhuPTZ5fvWc1erYWn4w3weWKzKhN7SBOijqjfeFQX0fF9p
   0uITKNweIKWC3iWkp6R0MHTK3rqEUPUPp72eNF3WhlATdwvqcIGLqTPEH
   w==;
X-CSE-ConnectionGUID: feggXzHISlWzO6J6S4bJtA==
X-CSE-MsgGUID: oAFCb9aWTqOejtlDxA2MBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22039034"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22039034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:42:40 -0700
X-CSE-ConnectionGUID: FymRcT7CQl+NFWt0YXpctQ==
X-CSE-MsgGUID: PVXFE53IQn2vyHl4FcAvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64207966"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 16:42:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:42:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:42:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 16:42:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 16:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCSGRtJlViD/JJOQy0rwbGmKGJ6RN4vQT9PCtrekDT+lOkMahYJBm/YWFdofnFajdUYmF0c3HKHmqnA3G1gzbL1WoD1XjwQK/GoyjRX6nb10bDgnXClx/kq+BOeXWYo5hViRYg9NvWmfLber+uUAXG5Uka58zt2i2xVh397C16w6xgfgRRDu8FX5jytcYDLO+wAMu39/nQUMHnB13VhaOtL29MW2Pn6ssNoYSQHK/FBuwr3Ig4XevdkRhYpHQEMEa5uEHE/EpC8kKN2d5qh1XcNSXNFp5YylxTyLH2+mH6Y1trQmLgEzbHjqNZnnBfJOz2POUZrG5rY0zaZyXcvlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiL6V/Vxeo7p4WDs3zp0v5vw2WLyjhpePwcyZsyXcVo=;
 b=KoQe88MjwcV0RXELZSaE4ddj6z6kp0k1c2il4bl6MYUlLzNS7qUMOjZxSUyfPJzd/v1ZBhF3qd321t3kM6LMf77j8eepbqVL11MsdogfJd3zNV5x4kJjH3LkKTz0HtlNsdH1IElJUSbEPyoRsoMcou5h1vSj0N3RQfrYZaxP54DLmoH4xmDJOrPkSqMSd8Xv55wyUHnFiVwQtleY8u4rgv7VXLdYZ7fZlbS2uzLHoPVkJUfkMQGKVNAGTcNhvV3RVPlr72A3EuHaD/zTUX/Zb0w4djoD6y4RTXoeAoEJiA5lkPfMVUPvIPRnDj5QH2cFdwJAfb4A5X/FFYTgZy1/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 23:42:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 23:42:33 +0000
Message-ID: <cf58f786-06b0-4ad3-a6fd-f593af639c98@intel.com>
Date: Fri, 16 Aug 2024 16:42:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] check-mailmap: add --no-brackets mode
To: Eric Sunshine <sunshine@sunshineco.com>
CC: Josh Steadmon <steadmon@google.com>, <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
 <20240816-jk-send-email-mailmap-support-v1-1-68ca5b4a6078@gmail.com>
 <CAPig+cSN-KU-TQ5UBR9KfxjmQ4zzjL-Y-anxDe9FaeqsV=1Xww@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAPig+cSN-KU-TQ5UBR9KfxjmQ4zzjL-Y-anxDe9FaeqsV=1Xww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ac6988-9aa9-43ac-20db-08dcbe4d1a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGMvUFdHS2pxdHA1T0xoWWxkK1ZMKy9SK1gzYmZVRy9ZQXkrUlU1Y2FJYUJa?=
 =?utf-8?B?bTdVNkRuVHArVzhkbXorTlJ5MzllaUxxbVJBMHZTZlkwWXI1SGo0V1BlekQ4?=
 =?utf-8?B?elFyMldGMVBqVUwyYi93UjZPY0IwMG1neU5DamhoNDFwMUJpclJ6ZHNlb2N3?=
 =?utf-8?B?M0dnNnNGMjZZZUk2cElQVjNSU3d0cWZyVXNIWkhGVTdPNkZtbFZHTUwxcGNC?=
 =?utf-8?B?Z2QydHBhNTloN3p0REMyWWxkL3RWSy95VE9XbkFWWU9DME1WTXhYbXZMWWhr?=
 =?utf-8?B?MHBFSFY1OE9PbFFRMTMxczlaVGt4M0Z6ek5mcldFTWdFT09EMHpRM3FDVGdL?=
 =?utf-8?B?MWVhUyt5WjdtUDM0dEVLTktreDBOWG0wYzBxTDgzZ0NaRlM0anRrMy81RldF?=
 =?utf-8?B?S1BNdVJxZnV0MnFwK1h0VzRFVWY0YzBmNGprL09YQzhuRmtJNFowVXNjZ2lj?=
 =?utf-8?B?dDFjQnVsTi9TdlA1SVZFbkdmbUN4OXM5bU1oN3NRbkVDZitEenN3T3pCNUY2?=
 =?utf-8?B?RmJlRVFldEQ1dldOMTlQTXR3aUJSaU1iWWJMd1FoQ3VuaEN4a05pTmt5Qjhq?=
 =?utf-8?B?THFMTHdZMXZ3Rktjcjd2NFdZR0RieXVrYnVSenFpMXMyYmtoejB2SzBwZTVQ?=
 =?utf-8?B?R1gxemhVVW9qNEVFK1B5aDVyY2c0R285TDJQY3RBcHkzUmV5RjRiUFlCbWxH?=
 =?utf-8?B?OEZFd1dEc1JEMzdmdHFVZVlFZVd2b1lwcUdGLzBZUXRjUCtCRDNVaUpLWFFJ?=
 =?utf-8?B?QmFMZWE1YWRidWJwbkJuWk1BU1RYSWZzdk5HNWlVUkpuOWFsNGF4NEVHOFZF?=
 =?utf-8?B?cFJOMXV4RHZvaVlneVhDbXhXWEZvSzFmbzAwdE5Kd0gyUDdQTktKUmhPdE4v?=
 =?utf-8?B?bUZZRUl6bk9jaWxaYXRxUjJUZjJPUElTRGFraVFDV0l6dDNJNncrTkZYdjN2?=
 =?utf-8?B?dFEwOHdxTUQ0ZmcvcUZ4QnFEVi92MmJCSjVxalNTclREY1NPRHBGdWlGSytl?=
 =?utf-8?B?K1ByZ2NCVXBFc2c1ZDNWbG9ZdDZsOXI5WTRiSW9XZjN6VDB2cWZGd0NmSnI3?=
 =?utf-8?B?R2FMeUZadDBqV0U0cGxEY1lSbm0xeDRZU3RZL2FvSDlFanZVb0hDd1FBTTlZ?=
 =?utf-8?B?aEdnTU1OQWtWRWxvS1lDTzRHbXJKWHhTZE94UFppUitXaHAvMSs0SU1QM09j?=
 =?utf-8?B?dDZXYm5LazE2cXZvRjdMOXc1Qk1wMVppdFdLU0ZOa3J5blc3ZFBVWHdKZ3Nl?=
 =?utf-8?B?Mis1Q20rVC9tMjNjM3VzeHUyeUNPZWlzeDRzWk9oUEFNL0NVZ1JtN29BdXNP?=
 =?utf-8?B?OXV5QzlGV2tyTG1pSVBwcHlUZzV1bTdKVmloalBqYUVNWjZHQ294M2RUcUxi?=
 =?utf-8?B?aG4rM2tXYm9SeVdZTFd4dEdnLzBFcUh3MVBXMXJuTzZzQkdaeDVsRkNVNkJE?=
 =?utf-8?B?em9ITHdHTVNaRWJ2bUM4aWl1a2ZOOHJEaGVmazlpSExUYnhuWElTQmhzNllE?=
 =?utf-8?B?UFFPN1lYY2IxcVFCYW1uV0t4cTJyOWFvekkzM2x4ZTEvOXlTeHJDZ2V3Umti?=
 =?utf-8?B?YWRNSlpFOWw1UVJDWlJNMVp2RllsK0lVRVVkV1BVYlNSSDg1NFNxdG5lV3pZ?=
 =?utf-8?B?N1JyZkdaeVhSVmdWVkVhR2c5Z0tmSjJtcXhxV3JTc21kdDNlVERXWXBWYUNO?=
 =?utf-8?B?UjdVYTBKeWtXZGhTbDVlck5SUyswcWdEdC9mZkpKSUdSa2hBKzd4RWh2eHgr?=
 =?utf-8?B?QTZ5dEtwQmhFajVwcFZYSGFibzdKcHFvQ1B6djVpV3ZvUGpWWUpPUzhzUmtx?=
 =?utf-8?B?aWx5ZGF5NUg0NjgyUS9Sdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZzZUN1d2htUDZZK2VCcUh1c0dVUWEwSVNjNHJRUEtMTllKNzhXZ2MyamRE?=
 =?utf-8?B?S2luZTY5V0luRjRhUWF1L0pwS2pzTkI3aGFPYmtWVlovT3RUMkhMUkoreEY5?=
 =?utf-8?B?UE4xN1JsRFM2VHc4MERNMUpjZWtXN08xU3F1MEg0Rlo1SmlCcnZKb1lnelZZ?=
 =?utf-8?B?TUt2SkNrMkdJWlRhNkRqZnRNMFVsaXdsTzZZRWg4WjlTdkszSm5CclNVbndh?=
 =?utf-8?B?MDgrOFExTmdMUFl0M25ndWVkN1Z3elBUa3NPM3YycktkQksxeFJDbHNpcDFu?=
 =?utf-8?B?NUhWVXYzQTU4bEpQSk10ckpEU1lmUHZCVlhhRjhWZjJpYUxPTVRIcGU2azRV?=
 =?utf-8?B?ZStsZ04rNUR4cnlEbytQOGhxeU9ZZ0l3bDh0VjNiNStMV29ERERpeDNzOXJ5?=
 =?utf-8?B?Szlmc1Y2c1c4Snkrd29PUjBEa1Q3RkRFV1B1OXdsWHpkVzM1YVZ2SEZGaVdj?=
 =?utf-8?B?NHV6ekRMbWpCeVkraUpBakdTQ0I0ZGo3WUl5T0VhK1pqRm0rTDhWZnBTeHRK?=
 =?utf-8?B?d29aNGEvK21NS3dIQnlZRkVGeTVPQzZRa1VJa0kxZzBRSjI5Y0Z3UzcwbTNK?=
 =?utf-8?B?cW5JSjhTOGg1ak5xOHVHZC9wckFZaDZkT1haMkpPVnpyRlR5VWNpY3Y2Smcr?=
 =?utf-8?B?WkZnVEExSjk1cWgzTE1TWG8weUw1ejFIcnJZLzZKeGxXb1E5b29lRmViZE8z?=
 =?utf-8?B?VFI4RzhnZ2lDTlcvMytaOHM3ZStVQUFHM04zQUxLMWRqaWhkd3BHNWdiQ0Ry?=
 =?utf-8?B?c0h3RDhaRkJaU05DWTFnZjBHak1ubDRQZzhVTXp2ei84bmNxWnd2aGFmWEZp?=
 =?utf-8?B?Y0xYb0tuK29XdWpxOUZwREJTREllVjJtZlhRTnJoYThhckpxY05wUENrdW5o?=
 =?utf-8?B?bnJ1bTNURnVrWGNmQTBGT255NkVrTnlERDdaODc1NWV5OGV4L3dlN2xEMlBB?=
 =?utf-8?B?bzZDZUo5aGx3eHoxazJKbUs3QXR6WjgrS3NhV0xzZGdmV3dCaGFnODZPMjBE?=
 =?utf-8?B?Z1U5WUZnc1hHc000cHVkTSs0VnpBRmVWUlZvMVdzUFlna2k0TWJYYXdSMkJU?=
 =?utf-8?B?VTFXamRBNHJUcnFOWXZ5d2xaWVZhSE9aOW9ZYU1oYzVXbnVIOVZHdkFDYXh0?=
 =?utf-8?B?WjVLdjNxVndQTXkwenRnUy9oQUo5UWFJbmVJbjNyRXBOUzhrYWRnaHNBZWVO?=
 =?utf-8?B?ajZsVzVTeDFWQjZOLzNTbFVpZTNLNU9oRDlXV2Rnay9iVjFqbjN6WGR1OFlJ?=
 =?utf-8?B?aTAycHUxR1pPdXpEUEhoYkpJVyswcmRRZVZIcHdQTFk5TWY5cTFZMTRYbi9Z?=
 =?utf-8?B?VCtvbHJ3RWxOYW9GcUc5dG8zSCtYWlFaV3p0K0paVUdORGxwdXZOekFTcGhr?=
 =?utf-8?B?RmVTQ3hneEQxM3BRUTZPeWtOVXNnQ0hWYXFMMU5WaDNvVW10cmMxWURpTTNl?=
 =?utf-8?B?Wk95YmZ2endld2ZqT2Y4c3BuUC9rMjYxWkRDZ1I4QXlaTFJVY2NnRlZiZko5?=
 =?utf-8?B?R25XeVAwamtpTzMwNU5ZRVBXdktMQUx5YnM0YTRnZW5MU05wYlkxOGdIam5I?=
 =?utf-8?B?WVdqUlNJQVhlTENKa2MwUUgrUnJmRzhySHdsNDROenVicWdLSTY4THdiTitR?=
 =?utf-8?B?ZG9BbW92aXoyVUdjVjVJdUFyL09QNnNZOFZxQzVOTDhSNWMwQWsxSEN2THFx?=
 =?utf-8?B?czJVZUJ0MDVIT09NdnJ4cVE2UmxNcG05VDVnbWh4U2FTUC95NzdoOTN2Skxq?=
 =?utf-8?B?ck9NWkxvYVBUL29EU2hBZHRrdHhVNTFlWmV3ZGhtVEJET3dMR2ZxMUxndzRS?=
 =?utf-8?B?K0JOTUVhNHZ5UUhlaTV3TDJ5WjBZUkVmblNXNzNyOWp5VEU1c3U3VTRxNXdz?=
 =?utf-8?B?Z0J2NnhMVXMrR1l3R2wxSUtrcStkeWtqRnFwWjhOZkNmKzFvSjFIUG1hV2NF?=
 =?utf-8?B?L0Q2ME94dmlQeWc5akJPL2JQYURYckRvRUswZ1dESGx4cE9uMlp6QkFGckR1?=
 =?utf-8?B?b0ZYS1RTM2w5ZC8yUTQveUFiZktPbzFzbnBCZ1dvMnNsdllnaU9TMmMyWUVu?=
 =?utf-8?B?ZEVyVmtqYnpOQmJFOWtIVlFWbE5wTHJ3RG5xQm4vdUJDaUoxSU9LZkE5VGtj?=
 =?utf-8?Q?fDj6kjp015yws+OnVClvRwril?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ac6988-9aa9-43ac-20db-08dcbe4d1a0e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:42:33.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOwASxKzf6yepkOzEa/rWcTOG6j1mKzzWk7OIRhHWDsOxHBIrRDPLSf8RB1WV5QNc5a99dqlDzoZ7JORSwHfIk4lMT+hWp9gF3new1+Jszo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com



On 8/16/2024 4:22 PM, Eric Sunshine wrote:
> On Fri, Aug 16, 2024 at 7:06 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> The git check-mailmap command can be used to convert identities to their
>> canonical real name and email address. Currently, if a simple email
>> address is provided without surrounding angle brackets, git
>> check-mailmap will fail:
>>
>>   $ git check-mailmap test@example.com
>>   fatal: unable to parse contact: test@example.com
>>
>> This is generally fine since identifies are expected to be of the form
> 
> s/identifies/identities/
> 
>> "name <email@domain>". However, requiring brackets around simple email
>> addresses can make it difficult to support mailmap operation in other
>> environments where angle brackets may be missing.
>>
>> Specifically, attempting to support the mailmap within git send-email is
>> tricky, since angle brackets are not always provided for addresses.
>>
>> Teach check-mailmap a new '--no-brackets' mode. In this mode, any
>> contact line which cannot be interpreted by split_ident_line is treated
>> as a simple address without a name. In addition, when any contact does
>> not have a name, output the mail address without the angle brackets.
>> Note that angle brackets are accepted if they are present, however the
>> output will strip them.
> 
> What is not explained by the commit message is why we need this new
> option as opposed to merely making git-check-mailmap accept such
> addresses by default. Are there difficulties or downsides to making
> this the default behavior? Do other things break if this new behavior
> becomes the default as opposed to being an explicit opt-in?
> 

Mostly I did it this way out of conservative caution to avoid breaking
existing users. It could be that nothing breaks and loosening the
restriction on what we pass it would be sufficient.

>> This mode will be useful for git send-email in a following feature
>> implementation to enable mapping any email addresses to their canonical
>> value.
> 
> I'm a bit skeptical about how this new flag also changes the output
> format to suppress the angle brackets. It seems like that's something
> the caller could do easily enough if desired. For instance:
> 
>     $addr =~ s/^<(.*)>$/\1/;
> 
> Or, is there some deeper reason for doing this?
> 

For one, the documentation of git check-mailmap specifies that it passes
other values through "as-is", but this mode would convert
"user@example.com" to "<user@example.com>"

I suppose thats not a big deal, and it was more a matter of not wanting
to bother the caller to force it to strip any brackets if it didn't want
them. I think its probably fine to require that.

>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
