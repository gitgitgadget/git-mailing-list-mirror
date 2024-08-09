Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414B34CDE
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230762; cv=fail; b=fHYqV9e4uGeUwfSx5ICaZp1Yb69cEuDq101lrhr/nLUbuvbQcfLJUIhhUXV8C2+B+YrF1xXCmdAuRr9j2UWs7WLg0D6LpH6jzVG999horwubPrcQ7M+EXvhqCne2upz7xb95aMZzg/KLYg8QoKRDLfV1AHouQjR1ZlLLdkHxQxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230762; c=relaxed/simple;
	bh=yyga3fbaFAhkytNg+A5AotmebLIgWTGw/5V9GaqfTOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmoSS6PvPGndPtjMC257xHbTLRoPGDr1k0+5XJzUjSQHskjIKohHb+K9jcu7E11+YF0TYP1aqZUtqbRH0XjBISwet83V7ChCky9hU2WHDdX9knLTSPcJ+dXlKcvy4QIup03E9q+AF1XxjUWALWJKxSpviovKI9MNpdtGdA720Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeqPVPuB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeqPVPuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723230760; x=1754766760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yyga3fbaFAhkytNg+A5AotmebLIgWTGw/5V9GaqfTOw=;
  b=TeqPVPuB1LShxWn+9m1pw/lG5TvkD90YPerLjJLNn8GVQwuz4WxsgJJy
   4tbLzsAz+ws+ZFMISEpXCqi00LCnQK11zmROY2uGJ+GaCRxW7xfkdcsX+
   VNyK163zQOkldKPom6k+TxD/rispnYAgzwpkxhOaqtmOiCZUL3qzuY9J1
   eGksiJ7IR+R7jeuxKOu50IWSgxFltI8jZT2ahnQiIoT/uG8zBYJ+/Ok5w
   ZwmV6bXBpaIcHF3kZzX0T9OL3DdkrCYPiPA93KqdplfGEyCofG9za4fGq
   5xG0CB6eqT+Im7YscrownnKm7n2Mv/9yOjANPPf8QJc/lIRc3ZMsPYDW3
   A==;
X-CSE-ConnectionGUID: 7ubqR0kdTPendz9qAs80cA==
X-CSE-MsgGUID: WVGXihQMTtWMZXF3wqwKMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="46822957"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="46822957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:12:39 -0700
X-CSE-ConnectionGUID: aZh7yv2qQuGvi7FXC/mJ0g==
X-CSE-MsgGUID: UvfkuaxOTY2e6FA4cd2bVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="80880943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:12:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:12:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:12:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:12:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:12:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyAm39rJ4Iou6cwcjO9O/e08R3hqEk5XvRgfjNIuAEOfQIKyy8g7raLh+KehOBB9u3A7ksBz8paAm9EuvnJGybLGrniKSHffkQtnap1uO6J0jEG/gVqKp45K24BDa0sFU5GBfi+WHjbLLyH9jPbW/72IjIwA66ksye4JxaVZl9Xs3/jvIbsXlKIxwPxB2ATGJ0KS0lM8BvwAtV8ddHsrEqd+ruYaiOUfU3fmvEe908vIBk4FKQi8PyqNhqVFY6ppmQKEPWB3v0zcpIpZqSbN+JmmjWB0n82jXyQM8KuDDkLNn7KDFfZZIX2q/YDtg2bTfpPMcDX4bwJYAqKzDo3Xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzzY+rvkg8VS2xGMDyYoB/kz2WQa3grk+Y/JuwtuATY=;
 b=UCmqMImgel/EIdfKj/TuL5kZasQDPqfch+pCYcEQ2Vbh0rVSGSBUBbRv+1Rxziyxnk1HdGGgjyCZDPH7uRj5HtGb8OJUfGbwClpLxkTGuDnaqYR0r4Ua9YHd6T/JzdTSEopl4r8V0Hoz6A/91eiC8QnaTSFpNnaMtUFgSGw/C1wKGodqm39r5s7ktE/vZbdViAhxpgDhkEtix7WgAxDkq6ryaXxlQJBD6jC2RuM1p78mMDJSRnhvH7gkpdqtl+sfjZ0a7SL13XiggsoYPcF/xjBFAFzj8nkE9Rps6SyF8WU284leMV8qtyGaNqyq7hCfrdEA6IxP6HpwOJqxifWkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 19:12:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Fri, 9 Aug 2024
 19:12:36 +0000
Message-ID: <328fb497-d16e-4af1-a816-7b4aeb531504@intel.com>
Date: Fri, 9 Aug 2024 12:12:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to translate
 aliases
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Konstantin
 Ryabitsev" <konstantin@linuxfoundation.org>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
 <20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
 <xmqqttfufzkj.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqttfufzkj.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:303:8c::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: bcabe7e1-0d88-4a1b-49d7-08dcb8a73a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlllRS84dHE5VVpyV05FcVBwQWJWejl0T3BTUmZuTFQzSHIySmJJbXlzK3FT?=
 =?utf-8?B?TEczL2R1dVAxVUllNmEvbkplMldocGw1dTBmQTJXbTFteTBYZjNyU3BsR2dx?=
 =?utf-8?B?V01JcVI5UVNDT3U5akVzNmhqRVlGYS9DRE1oSW8xYyt4TTR3d0FXTjZVWDRS?=
 =?utf-8?B?LzZIYXloTE5HN0ZkQU8xclVZYjdtS0dXTDc5ZE8ya0NEQ2x2ME9SYUMyRE5R?=
 =?utf-8?B?MHB2Rk9PUTZQekUzdGR6b001YlFyaWNyU1VIcFdMZm5DaVQ2UnVIMzZTZndy?=
 =?utf-8?B?bDZCMlZqbk4wWEcxc2lvL1AzZlJVZk1mVjduTGZOK09JRG1zZ0ZsbmJ2cHZm?=
 =?utf-8?B?TUZFbXVNTUxtRWxRdTBRNzlsL2Ntazh0dVo1QVNqN0RIS2pGZlZTVER3SG9a?=
 =?utf-8?B?Z1UxUFNzU3ZrSnpXRGxleDlZMnZtanBJQzNCVXMzSVp2SHFDTXJYTVR2ekt6?=
 =?utf-8?B?bFd1S2Y2UXY3Qk5lSER1M0UxcGFJeFJVem14b0RUK1laVElZNi9jYzJTVFNI?=
 =?utf-8?B?QllTWTF3b0U5dFlsT1JYQUNDRm1iVVBoa1RiNmV0dVo0cXNlVzZOZDk1bmdI?=
 =?utf-8?B?RzZLYVNKMTNtaDFCMkREMHF0OW8vVFhNVlQrRzhHTExxVG02UXNjTkFiQ21o?=
 =?utf-8?B?NnZrSTZWVWhSVk5HZUEyckpRYitwdjhOTUZSNHpuVlp0QitPNFAxOWhldTJZ?=
 =?utf-8?B?cHNLZkVDY3JDWnRFOFJ0bU5zKzVibnhYNU1RbEdBRVZRNUg1ZjZmeXRRYk0v?=
 =?utf-8?B?MmwrcHJnZXF3eGlIajg5ZDQ4VCtQbXVXdERNbnRPMnVYWkIwckdWbDZ3bVUw?=
 =?utf-8?B?V2dTSEtneDcxOTdIQjg1Zkc3SHNQU1poTmtRMVM3NW9UajNaTkxSb01ONWJD?=
 =?utf-8?B?aFozZ3dWYU9HRlZjSG9qVzJnYlkxWkoyRDdzc3B2OFFPLzN0c0hSam1jdDZN?=
 =?utf-8?B?RmlLTzlHdlhTSUJnc2E1bENlTWJPQmYybUJ5bGRNRmduRUxPLzZSUSt6S3Nq?=
 =?utf-8?B?ME9ZZjZTeFd5aUNiMWsyeXNoTkY5ZzREK1M4aGp0ZmJ0Nm9DdUZoSExnMmFo?=
 =?utf-8?B?QjFybHFjY1orTWxCbUVJbjQ5NXBLUVpIVjhxRko3TEdJY2t0TTV0eHJTbzVp?=
 =?utf-8?B?M1BsVE1oWGsyRXlrKy9mK25NTlAyU1VNQVNYNjM0VHlWUWwwaVY5TWNJNC9D?=
 =?utf-8?B?NjhPeUQvaXB5VHhQQ2s5d256dTNvZkM3S01ZYjhsQUFLWlRNNkQvc2RJK0pF?=
 =?utf-8?B?ZDdHa1V3WTVVMHBEQWwwb1pZU0Q4cmJZR1ZjUHM3SHFtTXhVQTlwMkR3Sy8r?=
 =?utf-8?B?NWdZU2hYRytIN0tjZHQ2eGl4eURpUU5ZcGxua1ltSGVOSk1TYlF3Rk43UENq?=
 =?utf-8?B?N0k5K3lrRmowOUlnOVV5ZU0vSjNVaFA4WDkwa052ekFRZVJ2RVozNUtqOElZ?=
 =?utf-8?B?VjY0cHB0bVVld1ZpZWZQN3RFenJ5WHdxLzhvRmhUS2NDcHBwbmRLUDFYREZx?=
 =?utf-8?B?T1VNNDRBY21aUjZQanNwOEw4TW5MQ0lKZmJMVEV2Y3hENUdrTWFEZjdJWVVH?=
 =?utf-8?B?aWJpR2hidVlQYjhWTVp4TzRHM0l0YXNCdUw5OWc1WWl4OEIrZDJKSEoxMGh4?=
 =?utf-8?B?SGkyU2o5OW1xRWRjNGw5QVJ1c05Ia0ErdVlLY0hBWFk0MjBuZFpFTVlCd2hM?=
 =?utf-8?B?R2llZytXbTIyMzVFSXowUkFIV3l6QUhGR0dzMEFpbG1QK1ZzaFJCYi9yNkgz?=
 =?utf-8?B?L0IrcHYyMDBMMjRtcDMzcHFIUjQzcWpMY0hRcVZjTi9DcWlNN2dmTjhsS2VS?=
 =?utf-8?B?NDZvT1JoeU40YUdUbnZIQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dTdGxDekRSZk5nM3JvMUhlSXoxZXV2eEZPb21XdVUwaE4waFZGZmwzWWNp?=
 =?utf-8?B?N1JHT3lKYTZlM0k4UGlPbTdrUlZrVUp6OFIyQWtwTHNVNm9mSWx5TFdrK244?=
 =?utf-8?B?di93NG03c21iMjBvRHpIMEhwUjFXTlpRNmV1dDdGV1p2UldOZ1R6VHFEVXhF?=
 =?utf-8?B?K3d5WXIzRTQ0V09MZlVSbDBoM2c4cnZvTjM5elRhdnhUVGZDQnNTbkdXRTNy?=
 =?utf-8?B?SHRsUDRrSGwrUCs3ZmpoYmJGU01OY21rRFBaaUM0TzBPeXptRUtYbTFWdnZZ?=
 =?utf-8?B?NUhFcVd1MDdyblBYOCtaR1IxQmphUHpMRUdQS1d4TzFTSTNnTk1ncWtiYmZ5?=
 =?utf-8?B?NmU5Y0lWalU3NWtnc28rd1NHVmVSK05ON0JTS3RFQjJBM3VuS0t6U0JYS1Vt?=
 =?utf-8?B?QlQ1ZkVVaEF2YWk1UmhhYWRvRlZHb3VkQlg4NEJ6cXhjbXNzaXZDTGFGMlRn?=
 =?utf-8?B?cm40Rzd6UmhjdVBGN3M5MUFnc25QL1R6b2p5aTZBZjRGU1cwbjEzeE5VS0ZU?=
 =?utf-8?B?clNXYVorNmpLdWxjSnF1eGJMT2hRS3pRYW0zNmVDMEp3QXUzdjZ4Z0RxREFP?=
 =?utf-8?B?eklxYjZHVVNhZFAxYjZ4ai9yYnI4ZjgzU2NmZkVxSmx5d1EzZTR0QnhoUGgr?=
 =?utf-8?B?OFRNR2xhYnFkQkhYdVFBeHlhRzJkcGs5a3NpQ29FV0ExUUpxSk4rQzIvbm9U?=
 =?utf-8?B?MjQzdHVYYnpxTFQ1WXpVcjAxQkwzTkJ1bFpVQjE0Q1F2ZXFKS21FUjJ2amsz?=
 =?utf-8?B?Nkc5M3lGNGZJdzEzNlBUdm1OWHU4T2xWOUVYeGRWTTMxVnpKRDFDTkJuc0JX?=
 =?utf-8?B?WkJ2dDhTQ0E3cUwwMVN6aWloSU5HSWY0NFBZZmMyQkMzSUJyN3BKWGlGSUN0?=
 =?utf-8?B?aDBPbEZQamlneHgvZUxNdnl4TTl5VUE0U3EwR25jNC9EeXNtbXRuK0lsdllE?=
 =?utf-8?B?VEVVZ0QybUlleStMUkowOWtubHRkS0JPdFJ2K2tRNVo5SHc5dGxvNVZuQlI1?=
 =?utf-8?B?MTZkUDVFNlJ5YUhhVWFQeTk3cWZjRm9FMG55cGxwZkhKVjFlcnJ6aGFnQUlJ?=
 =?utf-8?B?OEJIeVBqa3d0M2tyd3dIV0ZuZW9FRzAxbHR4dXRaZ1d0UGh2UFpPUW5XeEor?=
 =?utf-8?B?Uk9ESVh3WkU0anlya25WTC9rNTd4RGk2cmlodFFXbXoxajNGRU8zbVhHRTU0?=
 =?utf-8?B?Y2NmQThSTTdTQXZZZUFkK0Y4VDBUdFg5TXVnSThUcGI0alNhWTk1NUEwdVJH?=
 =?utf-8?B?UFZMcitMZGdOV0JNRm9tRkx0bUtWdzhIU0huZzhQWU80QlJMYlFKZmVzWGlM?=
 =?utf-8?B?Z01WQStXVmtYYUVGd0FIakNZeUhPWG54Z2R2bkhZSXpjSWFLRDcyamtaYUdF?=
 =?utf-8?B?K3U2YlhtSGRocTUyYnVCOFNLMXpqWDE5RXEvc2tkaEdQV00zdHl3OU1jTUJo?=
 =?utf-8?B?OUM5MHVlTGk1MnVRQnltS1luUUR3UVAzRHdMdWxoT1RCYWY3U2paZ0llanVr?=
 =?utf-8?B?U0d6WG5VL3RJSGplT0NESCt6dXBwR3RTaGJsQWt0V082cWVwWndIUkxnbklU?=
 =?utf-8?B?ZTVBeWFpN1hOMnR4S0svZklRd3dSN2hSOEJqdEFmaVhFcW1HOENDem1nSC9z?=
 =?utf-8?B?MmVkU1A2YVVxNzErU29TNU9sRHVNdVowSlhoUTIrWUdvM1VxQVFoYWxXM1RU?=
 =?utf-8?B?cUh6WVhwRE5BOUdNMFpyam1LQkRjQUEwRmlQYXF2M3JKWHVVdHBHZmdMYXVs?=
 =?utf-8?B?bG9RbElXZnFXRmRaU2VJdStZc2djMzFuUTZ5UnRqazJ1ODNPMUdkcjNvYlda?=
 =?utf-8?B?T0tpMEVyY3NydG9ZQ0gwTVpxSXNzWGVaclNXNFQ0aG5kRm9qT1RMc3hjK1V5?=
 =?utf-8?B?RGg1WW1aODh5WFY3eGRLWnhtcEl4Mkh6eTZGZFloOU9scFNiUE5ZcnYwRXJW?=
 =?utf-8?B?ckVZemh2U3JRQmM2WCtIcXhQUHZyV1RURy9rbTlIZ3NqYmllOExML1ZsN053?=
 =?utf-8?B?aHJqeXVIUWZLR2g5WXVGbHVJK0JxU1hZTU5ZdSthMEZ3NEE4TU9zY2FSSEVq?=
 =?utf-8?B?YnVSalVUc3liM215RHdQU3puN0xBZHBDbnBJWTNGWkZ1MUZoMi9YR1g3R3lH?=
 =?utf-8?Q?fQuoKmVivihlOOpHzkTaIwyU4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcabe7e1-0d88-4a1b-49d7-08dcb8a73a65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:12:35.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYuB9uetXFD7dXctgtLChlHvqAhV1ewAVMMJ29QDcEMkZmQzGiZr67BQL5oaZvrzWq+H8FHDdqGW7vdk8h42YhlyFb+p6f+0p1sowkhqn6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com



On 8/8/2024 2:57 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Add a new "--translate-aliases" option to git send-email which allows
> 
> If you add a thing, it by definition is new, isn't it?
> 

Sure.

>> Instead, skip calling GetOptions a second time of --translate-aliases is
> 
> "of"???  "if" perhaps?
>

Yep, a typo.


>> set. This has the effect that known options will instead be translated
>> as aliases instead of producing a warning, but this seems like the best
>> trade off of the available options.
> 
> Hmph, I do not quite get why you need such a hack (to be honest, I
> do not quite understand why dump-aliases needs a similar hack,
> either, even though I do understand why identity thing needs a
> special caseing).
> 


The problem is that we have pass_through set in the
GetOpt::Long::Configure. This is necessary because we want to pass the
options we don't understand into git format-patch.

But --dump-aliases and --translate-aliases both do not want to work with
any other option. If we put these into the main get options, then the
options will be interpreted normally and we then have to specially check
every single option to make sure nothing else was provided.

Dump aliases handled this by checking @ARGV and immediately bailing if
there were anything remaining after the call to parsing its inner
options. This works but does not work for --translate-aliases because it
needs to treat all the remaining arguments as aliases.

> After GetOptions() returns, usuall we process everything remaining
> on the command line as files that contain messages, right?  But
> before that happens (i.e. anywhere before the while () loop that
> processes elements in @ARGV), you can check if your new option was
> given, and if so you can map contents of @ARGV using %aliases and
> exit, and you are done, no?  Bonus point if you make sure that no
> other options were given, but perhaps there are some strange folks
> who want to use "--to=fu" as an e-mail alias, so instead of
> complaining that "--translate" does not mix with any other options
> when "git send-email --translate --to=fu" was run, giving alias
> translation for "--to=fu" may be a better behaviour for those users
> anyway ;-).
> 

I don't think thats right. We want both --dump-aliases and
--translate-aliases to reject "--to" ideally.

I didn't come up with the best way to handle that yet, as currently:

 $ git send-email --translate-aliases --to unknown-alias
 --to
 unknown-alias

I did try turning off option pass_through for the first round of get
options, but that also seems to not work properly. I can investigate
that route and see if I can get it to behave properly. I think we could
drop some special casing.

Essentially, we want to avoid parsing any other options entirely,
because they aren't compatible with --dump-aliases or --translate-aliases.
