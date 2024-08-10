Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941E14287
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249772; cv=fail; b=c8MNk3WPpKVNfAJ0XT29ISUU8/WH5pvrwlrnFF90+h+dqwyYZbgabHXkscQuYkeFwXRLLGR3YcOI0zK559e7tsmNKHQ3mxhbkhOl4kNaoKVux6Ths1/vo0aXPCroL1Mej2bEKJEOoXVi//nIH9g54SkwmgCuvPl81UB+pi0CGSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249772; c=relaxed/simple;
	bh=J7+NWKwDmp26ni5gKlwuAdQcdfbn4laJz0XcphCReWU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plZMxbfuFJbPJrFE8+jhn7TEP9HLCj4zRDSbNfKPUBUx/b1lBOiE2y6gn1XhDAM1KaAMRlAsktJmeIdKBZm5Uuqnk+nuUCYStFR7wzwdjt09DRjE2HLVohq4ZcYby6TP515qNxYFMEFf5xWcNCB+/6xcGvTBmq3sx66bTjGj/G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJgVvIi0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJgVvIi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723249771; x=1754785771;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J7+NWKwDmp26ni5gKlwuAdQcdfbn4laJz0XcphCReWU=;
  b=EJgVvIi0U35v3A6b73dCsmakeRdG0xCLg+NL+LNWjFJ5YL1Tvo2baZjn
   u32QphEqzFf5LhpAUl6JKQE7aN4U918AoCLaA6khCFfV4PmM6OZNgvtYl
   65JeP7F/N4olXW4iSLSxnpHNF3Ig5KEcTSkQR3pyajpMjXslD+vz/wYAy
   KsWRSgHwbJDAHDzod61WIf7zFxhCp+pBdGdPHoE8vldPC06VY8OGCexHW
   BstxSoNH+UaBvz+zWNlUZwE8Xk6S99UcuL9k1hliJb5InyRfTtdecLTnB
   ebkf3a9Diyx6CWHSaB+jLs2ZV1EQ46/vq9pcAxU9sQZMGCo2oW7+842P9
   A==;
X-CSE-ConnectionGUID: pvE92Mc2QLiZgdZeyhE03A==
X-CSE-MsgGUID: xD3t6j00QTaRcmfs4+z2SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21610117"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21610117"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 17:29:28 -0700
X-CSE-ConnectionGUID: UYlCe1yiRgqny5i1v56Rlw==
X-CSE-MsgGUID: kzT8QLyBQMS786FuteOMOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57607792"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 17:29:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 17:29:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 17:29:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 17:29:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 17:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXDBcjLLPPJjjFQdpfl3GKIvXI6T3Shywy/jJ5oOsBKCUKwchv6j3ksK3hrOSEmxXG2xshAmUM8rwgf/Jk3fwjV6LzgF02rQLENQh7Lm2nnLMqGxsFs8IciWFztd5Z7DBh2edeI8FNgVVS8/T/2s8jtKXT4Xk7uKTs3qzbHYV/KptKEHdbvgSL/FwYOfz0Fgk+nLM4lOSCDi0EudVGWgTE7429bZJfI/DZV8/Y6Ua5sJgu+/bzLOt8zDiLJbuCOuFCGSCxe6piY8pZg2e+wBKi+P+z+L+MzufUcRiOZucGqaHIHpGOBb9VsNju8LABy/pbV+uLSMh2DWUzbw5gz55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg4O4VnOapfPiSC6LVp2wyXT1afG2Sx0Qnp7sTYz0sY=;
 b=dCCbby39Fdnt5sKlPJkBA3HcmAgjsFbTjaZlb6gRIvCwuf/d7pQn4oSkZo0QqRM+LvTe4LSeRPD77iIvZ9nQpHybc45d6m+IDYH4YSO0Tgw/hfRaBBy+0WlFPg+NwzthzKkPkiKp3jl9qNYqLKrt0Wd9EBXPXQsMUdCfYXs8qRO+ftkEdKJUiyzhzVeukpwfg3nsV33R7JGz42qkh8BZcna4h91ethUNvQcXP6J8OD9VAKZlYV2zopDnfbT9wQ0DWubIwGS32ddjsmRphQKpMwNfF43SEEePN+PZf3jI94m5aVc1fgHYOr6sKP1UcKTj9S9M47azMmv/jSwMa/e2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Sat, 10 Aug
 2024 00:29:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Sat, 10 Aug 2024
 00:29:23 +0000
Message-ID: <7f6d556c-c1fe-4a6f-be6f-106f2e0bca48@intel.com>
Date: Fri, 9 Aug 2024 17:29:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to translate
 aliases
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Konstantin
 Ryabitsev" <konstantin@linuxfoundation.org>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
 <20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
 <xmqqttfufzkj.fsf@gitster.g> <328fb497-d16e-4af1-a816-7b4aeb531504@intel.com>
 <xmqq7ccpcx9e.fsf@gitster.g> <5ad39a07-a2d4-45d2-9b5d-0180cb903801@intel.com>
 <xmqqplqhbe4o.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqplqhbe4o.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8de4f8-d2e0-4981-8be8-08dcb8d37c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXNvN2FTMEZPTkJQL0dZdlVvTFEzWFF4ZXdFZ05WeGQ3SjRhRzlkK1ljR3Fr?=
 =?utf-8?B?V093M2tNT2FjKzl4OVR6THFuL3BJako0djNaOWRlcWRjOXVTMUlOQ1VReDdq?=
 =?utf-8?B?bVdvLzY3bVdGL0h2aWs5MGJPVnlNM01icVNWRzNlcEFRcGpvMkN1VmZPSlh6?=
 =?utf-8?B?cTU0M2xrczdSZGdOV3FwR3M2R1dTRkVZd1UxRlc1VWhnZzE5NFl0VkJReGNK?=
 =?utf-8?B?Qk9pOU8zT2xxcVBSK3dxV1FKQzJDL0w3RCtDOEhIK3V2NTRBMG9vVFJTL21r?=
 =?utf-8?B?bHJsTm9MTHBPV0NuZkUxbHlVMlZxNXQrRWtrSlBtMDcyK2NEaER5MEJPUkQx?=
 =?utf-8?B?Q00zREdyVGxYY0dIWGlMNVZhVUpZL1hjMmtmamlwd08rRElFUHpLbW9CQ2x0?=
 =?utf-8?B?T1VxWG5HeHBlRDBKb1N4UFNLVnNIZm1SK3dvV21CZUkvdWlUcGl5MU03SThS?=
 =?utf-8?B?L3QrWUw0VjJtbjZwWmk5aUd0T0FHYWlFWkFHSzAxNENTTDkvY3F1d1ZjNUYy?=
 =?utf-8?B?VmlqSFlUeU9uOGtVZVZuNW9lUHdiZXRieHJ4Rk9PQ2lSdnlrb20wT3VsUzJv?=
 =?utf-8?B?bStuRjFYcFZ6aFdyRWR1ZklDOTljMjBDU2NHRmhDRXYycnhLa0tEeHRpMUpy?=
 =?utf-8?B?ZzAycEcrZU9yUWhwdTA5UEp6VHFvM2hxR3pXVmp5Q3dOSFFETUhkLy9HNHF5?=
 =?utf-8?B?VDhmRWZzT0NpemQvcW1IOHhuSWtsTG53Y3dtb3dmSmkxdjF2WW5IYlp4cFZl?=
 =?utf-8?B?Mm95cXFMNUxkWm1rNkpDTk4reU83dXlIYmpxL2VVV3dNcEkwZndnOVZrYitX?=
 =?utf-8?B?SnpkWVpLZGtjRnExR1FZdlFZdThxQUp3QUpkY2c1Q2lTN0VoZ3ZDVE9WT252?=
 =?utf-8?B?VEd5S2w2SGpzT1N5aDliZ3hoa3JZK1RDWllRVzV0MnhtbW1sSEVYZmdDcERt?=
 =?utf-8?B?SGNYV2hCQTZ2RWlHWW9ZNVlFM0N5dnJ6cVJtVDdnK3pwUzJLaC9qZEZ3U212?=
 =?utf-8?B?ankzaXNyVDRsdWlpUHVoWlUzV3ZWbHJNSUgxR2xKUGFkNmhCRXNGYTdoZ3Jl?=
 =?utf-8?B?V0RlU3k3eHgzRjJCYjcxYjBQY28wTzZSU3VOTXphQytpV3htajlMajN4K1ZW?=
 =?utf-8?B?RXBsUEJ4Z2szREd5TzB5MDVXUEVWLzhiSUx0Q2ZSNHRGK2Vpb2trVzNqOUZr?=
 =?utf-8?B?NGQ4TUt0bENyYWpxdk1vYVBuNlhCZnVoRGY1NzcwWTNnWTVJQlJwbFFiMGQr?=
 =?utf-8?B?RzdiTjdmQXJveGRhY240Rlp3SXpGbTZONzRWeEgrU2I4ZnY4NlpJNzQvQUd0?=
 =?utf-8?B?MzJuUWoxQXpESmd6R21Db3EvaE1zdlZZR2I4Vnl6ci9WRjFSY1RhcnBQaHhI?=
 =?utf-8?B?cG9ENmtpRGZaVWpGK0x3SUJ5YytaSExUMTBPeGswWDdKNTY2WE9tcmtweS90?=
 =?utf-8?B?N2QyUW9aOHJ6OWF3dnZIbGdzQi9tVE53ZUF0MitiRTdpRXhvWityemRhUzJt?=
 =?utf-8?B?UEFMbG1zL1JYaVdVMXVNR3pITDJMNHJpc2wwdjF2Ykk1V1FBeWJpcFI4cE9T?=
 =?utf-8?B?bG11Vkdqck9PUy81c0pjWERLeVNRbUtqRUJnVUJjYWZVb0pQU3ltdjgvYlRN?=
 =?utf-8?B?bVE2OFNaWDhhQmxpYTlkeTg4UEdHbUFEUlFzZjZwSTFJRjA3Q1owdVNvck9T?=
 =?utf-8?B?aDNJb05pYkdwVlF4WVVKNlFWZEsybGl0ZFk3MFQ0RlpiUVlwMTdkTVZqb1dE?=
 =?utf-8?B?blUxUEdvRWZYY0VRWFd2TGwwMmZWTXF4eStPWGUxVUQyazBUR2piWXRSRkJI?=
 =?utf-8?B?c2JjMjIyaEZJeFdDVlRydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9KSVZ4TFp0S3I4Z0hmcEFFalpqVHNTYXpQcEtRaWZQWkFWR1kxRk9GcHNX?=
 =?utf-8?B?eFBqM2hGWmF1RUszMnlaMDByVUVIendyaHZPaXRMN0ZvTVZ0bFdoT3lZNXFF?=
 =?utf-8?B?NXdWbWM4Y0JHMCt1cmFpZzBXb3hDdjFhQ1JiWWszR3UzWnlTZGJiVHJUVnda?=
 =?utf-8?B?Zk9wSk44WVdtRTR2bDdheHoybkpDWEZROGNpRlEzK0pMZG9GRVoxamc2eXlB?=
 =?utf-8?B?bTBheXFIZjhuak5pMHo5VHlwZ0hWL1BOR1NobXVjeUJ0VVplOE94Yjh2MmNr?=
 =?utf-8?B?Zi8zcldwYU5zUHVxSlRoYVppWXRLV1FObjJQbG5QVytMT1R4WGhTUFVnckJF?=
 =?utf-8?B?ZktRQ3I3TG9NdUZFUm1sY09vNm5UR2RqT2trTTZpazJ5UFYxbW95b1Q4dTBT?=
 =?utf-8?B?KzFHM0IwS25XU2JIQkEvZ29WVXNDMzhDeitFRDJqdXdvcmN3RG11Q0d3U2xj?=
 =?utf-8?B?cVl3azZncDZ6TW1xRHRtM0RFbW9qZnFHOTc4dVFjYndJRGJLNHdqSTB6dWI4?=
 =?utf-8?B?Z2RaZHFaZHhWeFpJOVJsSGlvUWJSNWovMitnUHM0MXQwdlNhaitMZVNTRTlB?=
 =?utf-8?B?VHl3NVBDcFVDT0dFTFd4UW9YSWFscGlMak81WjRnQ0QwRHNPZ1MrbjllZDE2?=
 =?utf-8?B?YTgzc3FTdkV5R3UwdzRqUXB5Z2wyRG40ZXEvVTJETUVhR3M2dVhmU3pYR0l0?=
 =?utf-8?B?eXB1TUpGN0E2anNBbWNXSEdmVXkxcjZhcXdkaEoyWXNFb01wQWJLazFKMEF1?=
 =?utf-8?B?cVZQamRWVFJtQytGVjBPcVNsdXQvRG8rN1RRRmJpNXk0RFhNY2hrOGsrbXMy?=
 =?utf-8?B?dEJvMThyUUw3WHpOZ3RPMStTc2p6bUQ1QXRPMW83ZkRDT21vK0hHZWp5anJV?=
 =?utf-8?B?ZTE3bS9WSnBoSHIvT3NQM05rU1dLdzkzTUE5amE3UlBqMDNaVHEySUhnRXdC?=
 =?utf-8?B?NXc1Y2cwZGdWQUlmcXp1NWszUUpPNDhjRm1uaEV2ZGhOOVFvNndYUlE2cERm?=
 =?utf-8?B?L3pzMTZZSE5wN0hnR1hEZG9oRUFLQzNpRGxWOEZRRjRyRWd0ZHpVa0V0bTls?=
 =?utf-8?B?aVNLWkVtNDkzWGFMNnN4Wk4xdWJKTTJkY0VrRUZTNWF6Ui9OcW04Sll3ZHdK?=
 =?utf-8?B?NWNGUGtwanRCTUVTd01nRzV6WUFIOS9YMmFnMVBGT0R5UmlSTlU5RkxXWThC?=
 =?utf-8?B?VFUzNzFYUWthV1JGQzlRYS9NWkM0SkFlMmkxZFZEK3Vodml6RmNvcHRJQjFv?=
 =?utf-8?B?ZDlDRm5tVitZR0phK3ZQQkRUZTh2K293NDY1VlNIUjdWc094c3ppNU1IQStZ?=
 =?utf-8?B?akdWUWk4bDIxWlo2TnFKVFpIcld4N0hKbGtkUzBITTZiZERhbENXMFIvcSs0?=
 =?utf-8?B?M2pZbHBkMXpZUjVjL0pZNTRza1pKSnRMamN2bmcrYTNaM3Z6V1RDQzBwKysr?=
 =?utf-8?B?TjRpK0tNOC94ZGZmVG1LeHRiOE5tMUpJNGxXVTVUK25icmNyVjJFeWdmQnpJ?=
 =?utf-8?B?YUNYTXUyT1dGSWlwc0t4MFJDZnpYS0lnUERCdENLdXFLVXpSZkhPLytwQ1Nq?=
 =?utf-8?B?emlmWlhBVWFmRGMxazRENk5hWXBJb2VmaXI1QldFSHBuZjJIR3pNMTVRNXVW?=
 =?utf-8?B?WTJXMFBHWnpjMG1RR3FlQ0JZWUdFOVJRdndMRFVTY2dsZk9NcVhNcWE2cHcz?=
 =?utf-8?B?blV5TzA5Z1BHSnV0Qm1uSlZ3RW12cjhxbjZNRkdzK3h4cFVLWjAzRDgrejZh?=
 =?utf-8?B?VjJsbEhoTTFwMDFMaUpzVXpGcTNVZHcwYm9VckIzTW5OVzUyb1p4MXNSYldt?=
 =?utf-8?B?aDdDTnRMd0g5aktVSVRFU1ZkaDN3NzlsQ1M1RDBrQlVBZmxQczFzNGd0VHZZ?=
 =?utf-8?B?WStEMEY0eTFzaWdPMkg2dDNsWk5JRzRrSVlxQWlMQXpWNWlFdWtuVDVaR0th?=
 =?utf-8?B?V2pHcjZYa2c0ZlhpcjNmM1QyTGZORDBzZWZ6bk1oVFVRVG80UXBOUmJGak1U?=
 =?utf-8?B?VTF1NDM3UTZYSmdCSjI1cGZkVGpETTRuQ1dtV1lCRm9uMnhsbGpvK3B6MndX?=
 =?utf-8?B?eEo1Yy9BcTBhQ29yaFBzdzR5RUx1WFRqbUpISyt1c0dKVFJ2NXZKYUNhUFNE?=
 =?utf-8?Q?GL/5tIARTLt3rFr9/Ilbw3QEB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8de4f8-d2e0-4981-8be8-08dcb8d37c05
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 00:29:23.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhB3Nt/aB0HNQFnKVQWkmqTXNj0YvdjP0H4BNT3vuBFZ2W3UIUVtXMS80OluhKY7zW2Tsda4sClbkbR16xibb9HR/kpXP8oUOQZFplskGPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968
X-OriginatorOrg: intel.com



On 8/9/2024 2:05 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> We could try to implement scanning for options ourselves, but I wouldn't
>> want to break things like "--" to make it treat potential option-looking
>> fields as aliases...
> 
> The appoach --dump-aliases takes is already broken with respect to
> options that take or do not take an argument, if you really want to
> scan, understand, and skip irrelevant options anyway, no?  The
> separate, trimmed down %dump_aliases_options map cannot help you to
> tell from the command line "git cmd --translate --foo bar" if
> skipping just "--foo" gives you the alias-to-be-expanded "bar", or
> "--foo" takes an argument that is "bar" and there is no alias left.
> 

The approach --dump-aliases takes is that *any* other command line
argument besides --dump-aliases will cause git send-email to exit with
an error. They are not interpreted.

The approach I had --translate-aliases take is that all other command
line arguments are treated as aliases, regardless of whether they are
possibly options, and no other options are parsed at all.

It is intended that --dump-aliases, --translate-aliases, and the regular
mode of operation are mutually exclusive.

I am leaning towards possibly making --translate-aliases take the
aliases to translate on stdin instead of using arguments at all. This
would make it function more like --dump-aliases w.r.t. command line
arguments. This is probably a lot simpler. I think I will implement it
this way for v2.

Alternatively, we could extract the logic for handling the aliases into
a separate script with its own git command, but I think it currently
relies heavily on some perl code that would be hard to translate to C.

