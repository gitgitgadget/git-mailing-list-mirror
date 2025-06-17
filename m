Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB792E54A8
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186652; cv=fail; b=kykru89ck4Z4H3Lvb9Ys6BXabRlQNtNzJuNsenbfLK5YZurGJLwxrRk0n5ri1h2GQ+YsaQMmPs9bJsu2oUKfRbRQ7iPBpSiT89P5EjWwTm4o7pBlQrX86V+VIJKvzLR/VUUT1/ca704HU10lV+/cTmTtrTgQm161BJJJ3mOsb4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186652; c=relaxed/simple;
	bh=IZElb7sCS1SO/u7SGP90HDW8dTp5zwUWGWhDOIGzue4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzSJJK+1v5bZuJZil/ydiSdUyyoS3sTF4BxlhpwjEWIlda1ozIScPnuynYhGhcY262fSMRkIlkej4J2fVu+WWd8YCcmN+XkRx7aynyuEcy3vXbEyTlK9c1yzuB82QOBEHKEB7ZtKlaE5sr/G+5fV8Xudg20c9/qxFlnLjK1e5ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYYfbiJE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYYfbiJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750186651; x=1781722651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IZElb7sCS1SO/u7SGP90HDW8dTp5zwUWGWhDOIGzue4=;
  b=QYYfbiJEIcfeEpY1bM0xIniKeDMflM8twaWWhaFjxzon+HrOE5KcGwqp
   VxIy9r+B8nB+BsSC1lbwme8FBzmKEq/23+1miuBamGXKwulZRPc1zj/5k
   X9EapQZ/PDM+qCa31xG7BnE8xPJmiIcPQbdiuhy40ibyp5tqrJUmcIUld
   T0f3XswcgRFp62odlU893KTQrdy0YJMjYmWPSbwWgLzI6mEbptW9/xHIC
   sU65H88lYN7Y/qFl1+AS6pZYaRwRm3VC1MewvCnfnEeCC8G/Pnl0QZ0R/
   URZiEpdFkzulf4lpMQQqlpF3z6HfoZHknQ7EKuTQFW3uARK4yH0FzeFQP
   Q==;
X-CSE-ConnectionGUID: ArrKe63/SqmA/GPlwH1MpA==
X-CSE-MsgGUID: x1/MN4F5RdeEx+Yg/ObxhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="62982438"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="62982438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:57:30 -0700
X-CSE-ConnectionGUID: 4T3Ij6ddT2G8gI70z8XXGg==
X-CSE-MsgGUID: 3EJ/9aWuTWamZPkJZLgzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149438778"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:57:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 11:57:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 11:57:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 11:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Iiz2n252LM81v+9lOHa4NHy+GpTg+oTg2Qjopp8fPm5LAupqw1RCYjmHpkNxJreR1s08MmXUjhOb4O/MaxLjdN/6pKdIFmiuuffj1HT1RDgx33BpVXmMdA25bDE3hPUqxXRiJi3oTUlEgj7gbnZMrvRrnRZ7djOW0kiEocwVAJ4jHN9VM9SegiCdBADc7jsWl88VZDRpnnf7npNZ95NNGyy6pL5D2xJ+ZjaS+FEBkWLhj7ysUlfTg+oaFcySfNWbwh0FQibxOEwT5Ikh5t1joh+mwGt/kM8+Jl/zxrTFTvMVlgRWLCHVRDA+YaAZdUs7346CJYest/f7vqf+Jdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+qnSAJm1H1tGz+7ysYpUulv3XZkzT31DgsyfmDCQIs=;
 b=EnoV9icGE2fqI2bum7ccoMkapGeCa8O+j6LOEYOePAsCRCFobkMyqugSYEhGABO3IVW5G6Em77gvtZZEsWoBWn2RvFhi2nKX4RybnDfjQBofnlB4Az0FwJBfXsT6twprez3bFrT8Xgi8LZv7q2VF1NHd3QC1ya8haiFgUw2Ujb8VTQDo/KuGruBbKZdVJiFk5an0iSlq2UcDx3N+IVXCqp+FPuO/UUDOwkWS/WjyNjdpfJwPQSazNzhrMKThSrUWtDJUeg496jnLOPOgfX6FzrWzxjGqveGHcS/ZA7vWJfSOCg1i0A6CkxkvV4alUt2Cs23zZ/rtfS6Ad4Rf3xXlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB9348.namprd11.prod.outlook.com (2603:10b6:208:56b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 18:57:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:57:14 +0000
Message-ID: <4773e9a4-778d-453f-93b0-cf37a660145e@intel.com>
Date: Tue, 17 Jun 2025 11:57:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] submodule--helper: improve logic for fallback remote
 name
To: Lidong Yan <yldhome2d2@gmail.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, "Junio C
 Hamano" <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
 <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
 <90B8957C-9469-4D46-9026-46407AD2EC1B@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <90B8957C-9469-4D46-9026-46407AD2EC1B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 55345ac6-3132-4230-2881-08ddadd0c5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFTLytTK0VRR0J5RjBybWNPYXVHaUV4QkhkSDh6SjZrdW12Y2h3cks5T2lj?=
 =?utf-8?B?S1hUV2RNakY5cWJHaDRPejk3Zkx4bk1iak9EM0FSYVFkQStMUGRSVmhZSWNR?=
 =?utf-8?B?U0ZIOFBvcXdNMXBSWTdzbHppNUtXZFhOWlBkY3M4MlRTcUN1L244WWRTeUor?=
 =?utf-8?B?c1RicGlHeHAxUytwZ1c1TTZCZXRnWTk0ZzM2bFBzdnlSZUVGZHVKYWZQVjhi?=
 =?utf-8?B?dVJxanY4eDlVcWZQamxQWEFmbkNjN0NrOUNBeHJnRDBRUXg3QVd1c3VMR3Nm?=
 =?utf-8?B?VTlEN0Vaakd1S1dqNHNRT2RuZDhkRG8yclIwYTFjeWUxMnhiUlp2bStGRWhZ?=
 =?utf-8?B?SHdzWkFlTEl6alI4UVluYndBQWZ0NG9haWZTaCt1SnQyZFl4ZktaU1hNeVhI?=
 =?utf-8?B?KzRjOWZxMTBUTEpNcmZoZWdmRkZxeXVCT1VuUE93S2U2OWdPaU5ZNVB2eERC?=
 =?utf-8?B?RXFRUEhvZytJUTNDT282REdJaFY3RUdHc0hWT0dITng4VUk3RmRzZjVVSVdq?=
 =?utf-8?B?eEpKRnF4YlRWZ2NMQ3dMc3MzNzkvNzRhdFhTekJyOFcvdHhXWWJzcUwvL0sy?=
 =?utf-8?B?eHRRK0prbmZaZUgrTlk2SzBPcTM3K3E5aEJCVHI3K1FEL0c1c2N3K3RWb0Fk?=
 =?utf-8?B?M1lPS2ovbmwvU2F0ZFh5TS8xMHAwOTJVblBVRmxnYWtqd1JLN1ZWYkxyam1x?=
 =?utf-8?B?RW1uL2srcG4rUllvZEpXREtIWldtVkQrc3pvZ3p5cFpYelVKQm01cVc5OWVT?=
 =?utf-8?B?V2xpMjF3NW8yekY1V3hPdW02K2ZJR2R0VUNFRkFrVktDUElTN1EvcEY2elEv?=
 =?utf-8?B?YXpjRjRjc0JjdWtUcDgrQ0lkcDdlaEhETlF5T3VrUjljczZrcTZDMERuMk1Y?=
 =?utf-8?B?U1lEM1lJcS91T3J1dTU3QnY3MW1sQ05nWlVKUTJldzVmS1h0LzhpMWtCM3Zs?=
 =?utf-8?B?WG9VaXRiQnNMSE1teGNsOTJKN2xQcExESDlrREhGTXBlMXR5a3hxYytnV1pz?=
 =?utf-8?B?VEN5bVdvNDVFWUYxL2h4RXBGaFQ5empVRytGOFEwUVhjYWJTNE94c0ttaW05?=
 =?utf-8?B?NlFzSmhkSFJYbXNzc3VEcVQ5WmMraHJ4dW0xYnByYUJvYkZ0LzNId0dlTmNF?=
 =?utf-8?B?NUswbTF2NEk4dmNRVHovQlowZ3pCSEVFYlNUNlU3ZmRoS0w5d1pIQ2lPbDZo?=
 =?utf-8?B?S0FIV0RpcWZvTXhnTFdDMEFGRTV5eWIzRUlZY0trbzkrb1RMTkdaaDJXRTdj?=
 =?utf-8?B?SmJ1UzBBWXBpbUFHWGh4VW5FN2tOcDI5bFBDaEFlSFdPLzBBZm1WMGttU2VL?=
 =?utf-8?B?Zm14eDV4NTRMNkpZT041emZUa1FDR2srMnBIR2t0SXAyalpmb0did2hvVStX?=
 =?utf-8?B?TU9EUjhkY0lVVmNPME5MOG5acXBqeEJRZ0NqTzlxamxZQi85cERicGxXRWZJ?=
 =?utf-8?B?bTRUdFk1bXQwMDNkUFFUWmdrWnBIQjdXQjdkcFhRM1dVTjJua2tWazIrR2J2?=
 =?utf-8?B?UTQva2ZYa1A4T1BFQyt6YkwvcUoyWXpzaktBRzJSdm9hbHR1RjFpS3NLR09u?=
 =?utf-8?B?MXVCeTd2aG01SlhhWEdiNEQrRkpNU2QwRXlsdXNTaTFiSzBlRFlHQWl2SCtT?=
 =?utf-8?B?T2VDMFBDWnI5cUxWRWEveEhxYjJDOUJCWEJFM2FYdVNHVXdiaWF6NEFhSmRs?=
 =?utf-8?B?TlBYdEZXRC9rczZTY216L201dFNpakJFN09LMjJ4bHdnMHhveFdVWkxFU1Ru?=
 =?utf-8?B?ZHF2ekxjd1Q0MWdhalZEZjgvV3k0WXU1b1pid0lvdXJzMWwzUWYvQTZYbHlQ?=
 =?utf-8?B?MVpHQjZ0ajkxcStTUUdtWWY5QXc5bEtYWmtqYU1aR0d2TXlac0s0YTkzMHM5?=
 =?utf-8?B?ZE4wSkhVdjJURGdYb0N4TEFIVms1WXRWSXVrekdiazIwaWNGRzF3Y3dlekpN?=
 =?utf-8?Q?RFBLSZUPAdM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01neWduWGdLV1F5ck1RNno3TFNKQjkxcDk1T3F1eVBsV2FsQkxJa2FsNGhN?=
 =?utf-8?B?SmZkUld1WVBuMlBpL0NTc2pzeU4ydERiQmJVVEEyRU5zdmJEdHFQWWFIQXdI?=
 =?utf-8?B?MXlTVnRxZ2FmRWV5akl5cElTM0hlb0hxTmc3Rjg5Mi9yNVUyck4wNjZscHFW?=
 =?utf-8?B?ZzJlMFM4RDNhZENqQmY4My8vT255ZzdqZWpJQk51cGdQZDU5UE9VME03dGo0?=
 =?utf-8?B?MnlxZHRib09iQkZGZEs4b0JuK0JlekdabDFUNE5YUzlOUmt6dXRlRlBLUnls?=
 =?utf-8?B?eXdoQTA0ejlLRkVmY2hKYkJIT0RlZ0Y0U3d6K3lPc3NmNTV3SWZnWVFWejV6?=
 =?utf-8?B?VmU1OEQ0Q2FjTHpCVG9BMTJRWjRNcjROQm5JZGZNMDdjV0dJcmoxdnpyRGVr?=
 =?utf-8?B?b2VPQkpFZ2VXNUNhVDgya3ZRQjNrTzJRbXRIdUQ0YUxwTWpCMjg4ekJyMGJ6?=
 =?utf-8?B?UHU2TllmT0x1cmRrbG9kc0ZHNDRJSVR0ZUxjVW5lM2NmQ25kYXpiSWFsT0Zk?=
 =?utf-8?B?UmZmZHY1amh4OE02T2FyMFZKak5adGh1b0JHdkswNkFOSmd6VzJUZHJodWNo?=
 =?utf-8?B?T29zRjZjVzBmQ2x2clkrREtnc1ZGdUx6RVFOUEVjMHB2TnhWWW9DeHJpNkxL?=
 =?utf-8?B?R3NIak1jMWQ0bFFBOTZKZUdqUERQdk1tVnQ1WXJGa2tUZ0ZBc0czdGhpVWFL?=
 =?utf-8?B?eFQxTUg1dHZGWWNRQlhERWcxQ3lFMy9rUlV2eFpmeHhFZTgxVjc0YldoTEZk?=
 =?utf-8?B?SEVvUFNmRGZ5ZklOcDZXN1Jua01kQmhaSk84RjFoZ1c4VGtXWGpjcmZpUWRK?=
 =?utf-8?B?cHVWaE83czBKb1d2OHJTclU1K3EvV0daZXJYSXZtSGVXbTA2TWYvb3A2b0pO?=
 =?utf-8?B?YmRQTU05Yis3ODMvWHM5WjBwcUszbDNOOHF5SnlZTHpvS2lYZ2JCdGYwazBN?=
 =?utf-8?B?Y2Vuc2UxNS9IaDVHcVV3UFMrdFNJdmxoVC93RU9Uc2dlVGVIcy9oSnN3WXhF?=
 =?utf-8?B?c1dmYjVIUEcxVFdIaml1VDBFazZkZk0wM2pOWnY1THVCbmUxd05McnI2U2V2?=
 =?utf-8?B?RUJhYTRuY04zMjRSQkovanpSK09CZjlpcXA5R0E4WlJKSXE4Z2JGLzRzb0RI?=
 =?utf-8?B?TDBOTmpIbHpCVi81ei8wREwyNDZLT3I2OEVnYzArY0tud2tlQ2cwZ3I1K3Uy?=
 =?utf-8?B?SnN5Z3MxVjhrTUlSamNTVUZFc21LSTduRkJCNURuT0E0czdrYTA1S3cvaWJr?=
 =?utf-8?B?NzgzcUVtc3ExcTFKRXpQdnVSS0x1VVBZMzVKNFZwVHpUaWFHajg3SFlUb3Q4?=
 =?utf-8?B?ZTdhTzBUYVNWajg5cnVGUi9EOFIrL3ljUjdSZHVPbms2cDVCeXpvNVdtUVp0?=
 =?utf-8?B?YkVHRExHQ1hQTlZJbzNSMEpHSUJWTG1tYVFSSmpCOUZRY2tOcmhCc1o4bXJ3?=
 =?utf-8?B?WlZqRktxajU2ei83czdqL2c1WmZXdDhWWC9zU25BR2twMXFBTzI4RWxHTUxh?=
 =?utf-8?B?bVh2UFpKMjEzTUdQSlpJb0FCL2swTUtaS0NERC9hR2pWSzZHRXZjbVliZ0hX?=
 =?utf-8?B?Z1NZT083TW4zZFZUWERrSmZteWFrSE1ERjhLaHVJTm93dFBtaTlsWDEwemFF?=
 =?utf-8?B?S2p3cE1nbnJsWDduM2hENUxTQzFVaGZmaUNjQXhmMWs1YXRGUU9lZzIwWVUy?=
 =?utf-8?B?Qms5ZU13Y2NEV1ZlUTVUVjVZRktHK1VodFo0SXdIbFhPR2hoU01GMWR0SXV0?=
 =?utf-8?B?Uitnb3E0N0YwcUtqcjE3TW1IRm9mdElwNm9FbXpJYXRXdWp2THNva1JHWkUy?=
 =?utf-8?B?ck95NHZ6RHdoL0xSMThPRXgzcWlzTXUyRWxQTzV3L01sTC80KzNubnl3azFo?=
 =?utf-8?B?eHBmb0xLTUxPUDAxRFcvcW1mSWJDRjRSZEZTR284QlhsZ2R3dFRYT1NmT0dE?=
 =?utf-8?B?ck8zQjNDcEVTMmxubmlnUEh0Zm5SOVZadFJMcmh1dndBOUZBVHRPZXhxbTNz?=
 =?utf-8?B?RzZUTEtTeEFVZ1plbG50N1hwdVMzaDNBa1g3L3pac0tjQmFvWmhDNGNhU2JU?=
 =?utf-8?B?K2lWNXY3d0VOVnV0dXR6OS95bWw4SE0vM2tveDJCRmJNZ0IxSk40S1ZhTTQ4?=
 =?utf-8?B?akhld25zL2h6R3A2cnc0WG04WW5tb1JRRVRRMmVjQ0ZBRDJMcHMzMjZ6SDBI?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55345ac6-3132-4230-2881-08ddadd0c5c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 18:57:14.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EILNp2IgqHs54YMW5wV7xkRaXDtUdd9ORQGgcVp+QrOqM8jsNrI2MAsoyRLABNMfHMxPUYszFQtqukZZx0+z+0Vib4VgrDwwqcFp2F85tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9348
X-OriginatorOrg: intel.com



On 6/16/2025 7:58 PM, Lidong Yan wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes：
>>
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
>> the assumption that this is the default remote name. Some users may
>> change this, such as by setting clone.defaultRemoteName, or by changing
>> the remote name manually within the submodule repository.
>>
>> As a first step to improving this situation, refactor to reuse the logic
>> from remotes_remote_for_branch(). This function uses the remote from the
>> branch if it has one. If it doesn't then it checks to see if there is
>> exactly one remote. It uses this remote first before attempting to fall
>> back to "origin".
>>
>> To allow using this helper function, introduce a repo_default_remote()
>> helper to remote.c which takes a repository structure. This helper will
>> load the remote configuration and get the "HEAD" branch. Then it will
>> call remotes_remote_for_branch to find the default remote.
> 
> Just a thought: since repo_default_remote() is only used within
> repo_get_default_remote(), and the two have very similar names,
> do you think it might be clearer to inline the former into the latter?
> 
I will try to rename this function, but I think in context it makes
sense to keep a separate function in remote.c which does the generic-ish
stuff while the submodule--helper.c function does the submodule-specific
stuff. This is because the later patches add the URL look up support to
this function.
