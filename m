Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BB1946C8
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762902; cv=fail; b=U5DWCshVV5WYwjBLTHvBxAWEOkraDCDb5RoK/P+KNyWZKCHHgna92zPZh5Rrv9sIWv6ttOsfrANKxhu9YA5AKLaENX+C0ZeU8bso9IsOPgveUAqyiYbUs6HKCiCzwspjHoNxQEvwkmSIKxxVbMWO3fsj0NVQmXmQTD0CFB/e9wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762902; c=relaxed/simple;
	bh=TQfx8K9P4ZeC5XnPWFpYk6i91hr/8Lhb8mfyPIwVsmg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hMWjB5/00ZJh6eKn1wqF+j1WAf5A8aTuPMBBgbkw5JE+aXS+PreDqutoLGIqFYxgnT4wkF9KaBqnGI7n7FHawKOD+urZSZEmGGvCp0QIa+fyp/UGhIR8auEluqakQKwobXd+fNVHl+Ozrnj/ttMGlZ4dBrqaaQUEOdRfbPb2wQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NA0EmexQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NA0EmexQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744762900; x=1776298900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQfx8K9P4ZeC5XnPWFpYk6i91hr/8Lhb8mfyPIwVsmg=;
  b=NA0EmexQxJS6UqKea6faiIEJ5CKveFz76Qjpk+qBG/5/70T5dNmFB5fv
   9sYMucMNDYdVZ6RcWAFKoWfKXQTYXl1PqRstSmy4Cuk0q5WdCWUMx9qo2
   kZK3fuJ1+n7mhiTXWgYbv4t8+q0YSwkgmFoPHeLdWxWVXarp7etDi77KV
   nW59Wz29MnVU6++Pxnc4RyoS1kmGyPI3UFtA9mhXNGtFOCzcxbMuXGkgB
   AUXJ6m9fPCL/OBOYW0PiCmYtpHXqQl7Vu1U2nWlvMvbuN8GY4Ma+jdJtw
   JmpDI1d4cyIbKNVAavLe8LBqaw8L7hOnUHn8L6kvuz//221p0+6cjM83t
   g==;
X-CSE-ConnectionGUID: nErsOrsHT3eZSQiOIP7nGw==
X-CSE-MsgGUID: +tVV5bHNRRa8v+Zkgvel6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46423630"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46423630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:21:39 -0700
X-CSE-ConnectionGUID: cNJXU24NTLWvFAlbxSXVuQ==
X-CSE-MsgGUID: gge6ExKoTze2EdQFEr/X7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="161236771"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:21:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 17:21:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 17:21:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 17:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIwJuiTn8CSQnpRXqo5sL5qN//RhtRIqg7vLZlXLk4rpQoa4vmx3LqaDn6CyciTwhNuVYMn4HTxNfpmE2kFoyMCAwZPAj5GyPMxyXFVSKKEQAsWz66gzEQGekzFscWfqh50KL42WBY9wCBdkplbytJCXDTpsSaQI3UtJhFvpzR07HBRHas/mty1JOcLxuFYIJlhLE7fxAHCD0ql1R1B0c2XByYykIdyao6Bm+a1yW1E+6SSuM0dS8tc43DMa7g9FxHTlfo1T7Po8jZFhBwxj1pTyHRthi2vpFL4Uw1tIVN6HiLVenqDLVLdaV7G1rpN5uPNnEbS9zN7llSFnL9qv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRdWuQwCVcc/JHbB+hBL890mLvuMJo1WBGckxeVSky4=;
 b=Y6EJ0Wk7O8LEslde82a9iDvTvEv7gHckTB4lAfB15ykoBS3741jVrlHxKBOo22JIGDRJz5ZzFfeCRkfQrhrw0eyNk2tOtYu5qTS+/+iZgTpIAesR9xjgbKyFGMydoFk1Wdx70o1rBBZUqZfqC3hO6YJUpi6mvOTZZtX2Dt5ZKJPbaj+xidL9LOjmaQvEoJzl7bCnuQQOmJEUL3GObQOsIqSZkXctT7qbb21EmbsqECIoG3IBoDd9E94G3D3sTdbSjnCRnnuFuxHzP8Wq+3ngUbK3WyJB7Ls7tmPe821Xijkk+9XaHfobtKlEkMMclV6RW3bTBs6U+ysEp/BWLAQibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 00:21:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 00:21:21 +0000
Message-ID: <12a56142-d786-40d7-8ae9-2ebdc3467e4c@intel.com>
Date: Tue, 15 Apr 2025 17:21:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Remo Senekowitsch <remo@buenzli.dev>, Junio C Hamano <gitster@pobox.com>,
	Theodore Ts'o <tytso@mit.edu>
CC: Nico Williams <nico@cryptonector.com>, Martin von Zweigbergk
	<martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, Edwin Kempin
	<ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
 <20250411154839.GC648081@mit.edu> <xmqqfriemw38.fsf@gitster.g>
 <20250412231318.GG13132@mit.edu> <xmqq8qo2srn5.fsf@gitster.g>
 <D97KGN6TV8F7.1KKO8GYI65W59@buenzli.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <D97KGN6TV8F7.1KKO8GYI65W59@buenzli.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0f6a1a-d2fe-426a-2c9e-08dd7c7c9d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXZOVTBTbnRxbEw1VThFV3ZRMXlSWmhlU3MwbDlKd08wNmFObUlWYmNobEZU?=
 =?utf-8?B?c0hQTXU2Qit1eGZpblVlTVNOSytISHNwSG5PYXFSODZYUHNSMGIwajVRY0VI?=
 =?utf-8?B?WFhJc3hiUm8yQTNxNW01cUFpY3huL0Jna1VUNHRNMVdkbnpCV0RJM1plWlFY?=
 =?utf-8?B?UzAvb1ZXd1JCb1RKUWdlejJRMDhua0R1dGZtcCtqREQwYm1mQUNHWGZYdlht?=
 =?utf-8?B?anZyeXoxT0NWRUY5VCtjY3dhclp4UlZrcVR5MVZnVldhSlVzMHJLYWNTWXpp?=
 =?utf-8?B?K2VUNmQzMTlITStDSXEzQnRzOElhaWRTdzJDVDZ3b2ZSZDVqWWtSakVNWjBX?=
 =?utf-8?B?VHcxLytCdkJJeVo2Ly9qeURsc0FuRVFsaDMwY2NRRGRSbzBzd081aXdsTmtP?=
 =?utf-8?B?bHlDQlZ2cGdnYk5qbUw1WlJRN0I0T2U2R1FTcFpxS1RpUGFLQ3EzSGl6NE9Q?=
 =?utf-8?B?dm1QTk9oRE43RUdLd3JyeG41bkhGc0ZzSXIwM1gzaG9qUVVxQlZCS21CYUhN?=
 =?utf-8?B?OHFabmozbVU3WmlhNU4xMjNlSlZvSkI4N0twWTJPZWpEWWhaeWl1dytDOFoz?=
 =?utf-8?B?eVp2dXYweVlyTnRpYzJwRTVqMnRzMyt6VnZoTSt3Slo0L1dBWlRpbW9HY0ZT?=
 =?utf-8?B?aUlXaWREd3A4ZFhLb010cHdHOVB1cVZRQktMdFNBWkk3VjJ2ekdzUGFPOFlm?=
 =?utf-8?B?akpmeURNZW5VL2dhL3VwNWpvYnplWFhjMDdoYWFET1RxVVdXQVVzSGM2K2pn?=
 =?utf-8?B?WCtaaHAzcjlDTTJuWnBhcDhEem90RUZPNkFsMXpIU2VhNDJidTRObTZJV05Q?=
 =?utf-8?B?TWVPdzdEdEdzM09rSEpkWG1tY1RKcDFOaVpwekhuNHFGQXA2TGhwbXN4M2Jx?=
 =?utf-8?B?c2hoL0VaNWNWZTBJS0dRZGxHZFpNTVBDRWlLWnZ2TTVNL0t6OXl1UzU3Mk12?=
 =?utf-8?B?cXJBMEU3WXNBSUNPUWp2SFh0TmpzZ1pvdm5ZZ3pDTWh4UVBUSGduTGxTQjJV?=
 =?utf-8?B?OVZSWjNDb3RMSmJUK3hSUVhDdFBVZHJRT0FwZnJPdFg4elJ2aytDWVhYOXhx?=
 =?utf-8?B?ZU91KzVwOGltU2xSbENNSk04YWx0WUMzZjFuVXE4QWFEcEgrVk9zUDFFRGdS?=
 =?utf-8?B?UE0xTDZjNVZYdkFCcGU0emZUN2l0N3B5SnlqWmRvN0gwdm04cWhQR3drUFpU?=
 =?utf-8?B?eTNISDRwVHA3V2hLZlo4dXhlVjNreDFZVzdwVlRKbm5rMC9nOTd0U29LQzdy?=
 =?utf-8?B?bk4xU1lMTFdUQzRQZGsvNzJDOFI0d3JmeFpTNjBmUVhGU3RFaTRpbnpPOFRn?=
 =?utf-8?B?ODNRTEppaU9CUzNaNEszNExLYW1WV1ZwM25xd2Q5Z0E5SlNwcWxCMVpDWjJ6?=
 =?utf-8?B?LzZGYVR1YUtqNE1Ua3JhSCtYTElBelNqUXVscjgzVDMzRXNMZmhxcmQyR0dR?=
 =?utf-8?B?QUlSNGJ0dURCTGVSTEhuejF1Q2xxNHpCYmxOL2F1Y0tPam8yT0pGZHVxUEtk?=
 =?utf-8?B?NUZDK1doNFZweW9tU3RQU3ZqaU5FL3B4VjhJZ0N1Q1NQS0FBVkp0bGUvOE1S?=
 =?utf-8?B?UXhCMzVwOG1VdVZaM2FlK3lMd2c4Wk94VzQrM0hCYWdLQzVSbGV5YlpOM3RJ?=
 =?utf-8?B?YWNwWHZENDdoYUt1TEFEM3NuSTNUbUl0TXBXL0p4dWxFMDFoMC9Oa21xOHZI?=
 =?utf-8?B?ZlZlYThOUWpwaGxIQ1BjNUZGelZjNitJeDRvYkRCNm56Y2xqaks5ajZJN0E2?=
 =?utf-8?B?Zk1KcmVjUDk0YWlMbDJwWVJjMlVYVGhmZWd3YmJzdWdJWXNNRGVLcm51NHpX?=
 =?utf-8?B?RXRjaU1UUW5JMUtITDdqTTdBZHAzaHZ5ZS96SUtrVHh0dzdEYWs2SlYyQ3c4?=
 =?utf-8?B?N2dldlBZVzArdEFKZjN5SEQ4ZmtNT2s1SXdMMWhDcVdVOUtCMUQ0MU4rRFh5?=
 =?utf-8?Q?QWA7KglS1fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlSR0hpT0lnOXprWHNqRk4zOVd2V1RNcWV2a3FCQlYraXY2R3M5UHdCdmpH?=
 =?utf-8?B?WGRuMzFKRUozLzNyeGp4WGlhMEFXdWRRRzBzVXRSWTVydnR3UDVlVXpnMzZj?=
 =?utf-8?B?bmR6SnIrYzBvWFA4clpZNkM1N2NidklFZWpjdDRvcCtuWVM3ZEFGR0tUVmFU?=
 =?utf-8?B?ZWt2aEduRXNScUVNMjhxVTJsZnVJVXpNcmRsUWxvckg5amk2dVhKdVVkQWlm?=
 =?utf-8?B?RElwc3FYOHJIVmZjVWl4dmgvVmhhUWtPK3lWbFlDRXpPNEhoRUQ4MllMRGIr?=
 =?utf-8?B?QWR3YitrSlQ1L21WZUoxY005NEZUZHUrcmhsNi9ienB3dmdIaDhmN0NmaXo1?=
 =?utf-8?B?Z2o1YmREbklkNUcrdjNkNVFsazE1anRyR0t0Rm9TaWJ3eHRCK0tYVFJva2My?=
 =?utf-8?B?bE9uVzRUMGdzbUc5TW1Hand1aHBUdGk4aGJNekJ3TXdRM0s2YTZJdU9wd3hP?=
 =?utf-8?B?YmxFVHBoazIxaGJLREsxL3Znd0JUb2ZONEYvZEovK3ptNndQdzZ6c3d1VzNz?=
 =?utf-8?B?YXhiQW5WUzFzRTVjT3FqYlIwcVllcmlHS3FOYU9BeUJUK3ltRXBFajJaKzBs?=
 =?utf-8?B?ZzduNWNOSDRLeTViU283aURsdVFwc1lhdVd0TFBTcU9RTTFoTlFTUHZrcWNC?=
 =?utf-8?B?ekVYRnNjNCsxcG82aWllMWRZY3RZZUtrSHZBbHdUYVhuQnpuWEQ2SGdTUFVl?=
 =?utf-8?B?MG95Rjd4RmZiM3lKTTRWcDEvS3g2ZWF2L0o2eFdNQ2tYd3VVQVV4UENFeEp3?=
 =?utf-8?B?VG1nK1UyVGg0akhyRldWd01jMnNDZlRGQWJLQ2xiMlVYTFhaZ3NrVVZyeFEx?=
 =?utf-8?B?aTlpUmxCcGp2cXFNM1o3d3QzWW9ISEhTb1BSTnlCcGM3UWhZU2FpQzdRUWxy?=
 =?utf-8?B?UjEwSC9oNWR4dXZHZ0Z3SnBIbE5Wd2N1dUVhYzUvem1ZZkxXaTl1QXl2ZEpG?=
 =?utf-8?B?WEZ5S2FJOG95cXg2K3Z0RHJycUhkRklEZkcycGNlc0NNK3dyaTBJdUFQYUFM?=
 =?utf-8?B?QndBRU4rV3Z5THc4bzkvN0szZStEbVpCMmZqa1llVmpEYXpkYlhrK0tyY29m?=
 =?utf-8?B?a29lZkdVM2ZDa2JEVURnUkR6TmhPdVNFa2pWTmFIUzROOVVTTS9tUHBDK1pr?=
 =?utf-8?B?ZVp4ZTFqQWlZdDFGcUxjcnlIK2J4WWRQbldUUmVwOHB3Z0crYUJZb0ZIWFN0?=
 =?utf-8?B?QnhuN0trUGo5RzlYT1hWTXlVSGJQREpvTlZZQ3R6Qjcyb2x1enV2VzBEV1hL?=
 =?utf-8?B?ZCtMR08zWkVGWjZBSGNncUNUMlp4M2JNZFlXb0tZL2NuVUtVNGdpUnhGaHFk?=
 =?utf-8?B?ZE5JOWdROWt4VjlDbHdwZ2FzRGdROFlidnBkNWRrbURmOVpRTVNuVGhIS2ha?=
 =?utf-8?B?akpReHhYZzZpbzhaWGRxdkcwNm50bm5GRk1WeTRRN05PL3FFTUgxQ1Z5RW13?=
 =?utf-8?B?UlJubG5aajFVaFFXNFg4amlWN2dwajErR1kxUWF4Y0xsWkRQbjloY21PUlRB?=
 =?utf-8?B?bFVmTjZGYVBRRGU3b2RVV2U1TmprOFo5dkhNUkg5dVUweUZjVzRWSnFhSDBB?=
 =?utf-8?B?dFN3S3hmbDZKQnBQT3FKUTJ4eERyUXVTRkdSaEovck94dGw1cDNZZEV0eWdE?=
 =?utf-8?B?dUExZGFpU1ErSFVONVpiT0lDeEpteG1XZmRuaVdtVTFJbjhiVXlqQkpNdnp3?=
 =?utf-8?B?TW1iR2dia2xNbTc4S2xPQlNZUzdPZjhGSS93N1pWTFNEQnovOXFIYngwR1pp?=
 =?utf-8?B?a3RvUThPcjhxS3dpWERVdVd5dDBrOFJWL1JwM2RGZXFaZXg0bWtuNVNkZmN5?=
 =?utf-8?B?Yk52UFNoQnlOaTRveXNlNFY5bUxTRlM3UkFhZ0tmL3dlanhaNW9zdkpDKzlV?=
 =?utf-8?B?QzZDczlVdGZodVJnY0pZdHJwRk1maTZqaldiYUZiRlBmcXVrejF0MHZXZVZj?=
 =?utf-8?B?S0lYTXV6UnpHQzM0eFZHdllOS3lYbVlua3JoV3BqZTk2bHZsR0g2QUp6c0Jl?=
 =?utf-8?B?anRCUEN5elhyTXZ2d01qWmRpVXJGY1NxRCtDazVtUUxIaG5lblAxTENHUnhD?=
 =?utf-8?B?bkZrYlVaOGZHc2JRQVlYaU5PVThYRDBwdFc2c0dlVkhHTVovdnl1T2YxNVZP?=
 =?utf-8?B?ZVFxVTJIWFhxRnlMUEZKQzJ2RTd5MXQ2cGVEUjhtM3JVMFZOT0dSQitQQ0xV?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0f6a1a-d2fe-426a-2c9e-08dd7c7c9d25
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 00:21:21.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlUjBgNvBcLp+RV0lwrucj0gki5SHow5vQ9jKCTFQeoVS9+xQ3/a4uXI32dDYN1lVXSxCLrw+Bmp1Inc1R3aEBFNKtBxZvZMllLbKc/xhew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com



On 4/15/2025 3:30 PM, Remo Senekowitsch wrote:
> Doesn't a patch set ID suffer from the same kind of ambiguity the
> change-id supposedly does? Patch sets can be split and merged, a commit
> from one patch set can be cherry-picked into another. What patch set ID
> should such a cherry-picked commit have?
> 
> And I think the argument that a change-id for a singleton patch
> set naturally falls out of the patch set ID can easily be reversed.
> Admittedly, I don't have the most experience with the mailing list
> workflow, but a multi-commit patch set usually comes with a cover
> letter, right? And people like to track their cover letter in a commit?
> IIUC, b4 is designed around that too.
> 
> In that case, the cover letter has its own change-id as any other
> commit, which will naturally remain stable across every version of the
> patch set. It would be non-sensical to squash, split or cherry-pick the
> cover letter commit. Sounds like a great candidate for the patch set ID.
> 

If you commit your cover letter, that would work fine. If you don't
commit your cover letter, you could probably also generate this.

However, the commit itself wouldn't necessary have the patch-id as part
of its metadata so you may not be able to easily look this up without
referring to the external place where you published. Generally cover
letters are commits only for the submitter. Once you submit and it is
applied/merged, the patch-id would vanish unless

> So the patch set ID can just as naturally flow out from the change-id.
> 
> I can see two concrete disadvantages of the patch set ID:
> 
> * It's strictly less powerful. As explained, the change-id can do
>   everything the patch set ID can via the cover letter. But the patch
>   set ID cannot help you track how individual commits within the patch
>   set evolved.

Fair.

> 
> * It's more complicated. While many Git users work with patch sets every
>   day, it's not a concept in Git iself. Git only knows about commits.
>   The patch set ID would introduce a new concept into Git unnecessarily,
>   while the change-id naturally extends the language Git already speaks,
>   that of commits.
> 

Sure. I guess it depends somewhat on what you want to get out of the
change-ids.

If you only care about "how do commits fit together in series", I think
a set of change-ids per commit is not that helpful on its own. You could
likely build the equivalent of patch-id out of it with proper tooling.

However, if patch-id is not sufficient for what most folks interested in
this topic want, then I would agree with you its not the right direction.

> Remo
> 

