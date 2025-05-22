Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F425A2C1
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950625; cv=fail; b=NkEv2nmAMclJymopm8z7ss60d6oNWn5ZZA0gJv0+OQT9tP/QeSR+tNakryrcAyGcXp7MyklGbWp3dDtVIbfmLCGEvYtuRsH6hQ7Kg84o+jGWSZacDlb8nJU+ilnAb91y5ENIDQAIOU3rzxIxQ8Wje62WRfDJ1eewLEzeBZR8QZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950625; c=relaxed/simple;
	bh=OqPdnukwkSG5EwQE39114ijtZR6F6GHhXiSl5jB2+5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKHh+EMF48j58KfT2efi99fvSdfX1FT8Zexk/tXFMvKJ09YHkK9vucL3YcvU76toTPIR/TytUi6dYEdh/SNLHqoH1oDGXqtCpr7z6FTpcIulbnTgOUNgaKuIk3PzR1RO0CoUAM6JgNHWhKIw2oIXyq8sUPEexFvqOcp1eMtQ6uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuWyUuPE; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuWyUuPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747950623; x=1779486623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OqPdnukwkSG5EwQE39114ijtZR6F6GHhXiSl5jB2+5U=;
  b=MuWyUuPEuvW0yn0nIY8cQe8MNJJ7jX77Hz+h2+BUSK+DXpSVZWeQIKuu
   Qu0sD/oLAibNjgnXrSL8lLMXWB8xuZaoCXAjmDpJlZc8LAYfMdwgIig9Z
   uMkmmDCSiAIxb45WBQtoZpc/F5shWvAbSQrLzjwgq8hzr8X7LjzJTC5He
   UpJwMygqYe807yQEjjUq0fdUawo7f8sVZ+afKf9A9Tm97KrmLIjutX3Js
   tBoBQOFAmCGnuNzLQJxZiQgwisRBCZKk5XqpO07U2Iofs+WHc5ZGfy4cU
   5vxekNQhv0as5QvMlSRnkWr46kmQns+6gsH4d4PpioG0FqxK2f9WbDM7Y
   w==;
X-CSE-ConnectionGUID: QVSjF+mdQvGc8Jauoy4yUA==
X-CSE-MsgGUID: q1PNWMg4SQeJaNAlRArzWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60247387"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60247387"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:50:22 -0700
X-CSE-ConnectionGUID: j4ynI8MCSGGoKhBj6ODiag==
X-CSE-MsgGUID: C26BJtOfT4SvsAmtuOqPDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140845204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:50:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 14:50:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 14:50:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 14:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoLyA4kBgR8o6C0T66ui5X0dKU8jAyVC0QUaZY4w9yHFd6UEXKTAEdI5ATj5tIhchmSNECFoedF5P8hIQe/D+OCFU58E3ous9qx5H2I9CrTqsyxFGgI3EbxkI/sEXLuUa2z0sCt9FTF6H/IMpIHTOqL7igG6yNt6C+z3mCWIPTazihC1+dEOr0T2gQ+bXHx3joG4zfI9KS2zuKh9qUXBeT8c/VXQPQZaHvXZKNsDGFPpeK/towYVN5euFokKnpD5IZTAxBxPs9ywy9HlEY/CicpwE1vvuY9UuRHVxH9M3GCTGDzOpr+WMeFwF3bFoITBvAlW6CnejyV/w/qOtJVECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv6r3nSsqmCq8VCwMzX/goise5maj2igUUdxSIxr7Iw=;
 b=TIl3LsV3WMvsAfZE6et6HnkcNTjqxUZ5jUYAEn0LgaexyXRPXGhfq/g6L7H8wQeso5E3UDqo40ZFSSWH0lgGqaw/NWj3RiY3Ji/mtwStOaRVejwjNudGDrS8W7PFKmU7ME+d99hIidGjFka9jtlcaVvC04WZ+BQ3aa57XDMzEImutWK1Uo9K9qWfjEXAKtio3htrvjFSGcIgbU/7o9WCFkHhe/zi2zBkkmEiIKTKTt40fLqsaAoDn7lncZRQXJ7CqCz9tiLYsJnIgavvgNwvEbD8JDpWloateeBo1qE1VpBGYz2gqjRvGdLjRz0Hp93HIBCa803xtBxdyTuRdtk7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 21:50:05 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%2]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 21:50:05 +0000
Message-ID: <4d0366fa-3584-4d6d-810e-855b9ec23121@intel.com>
Date: Thu, 22 May 2025 14:50:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <xmqqzff42uod.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqzff42uod.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: ea038e0f-8492-4f77-c3e4-08dd997a9ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXZYeDM5a3NlZ2FQNlRxNm42YUlCaDdhUFp4Z04vU3QzTjdrMlFOeVpReVRC?=
 =?utf-8?B?WjdHZk9qRlEraVhVdSthbHVIbUEyUThVa1B6VFFWSHMvNUZxUlBNM1QrWldJ?=
 =?utf-8?B?TXZPVkR6eEFIUW0xb09BU2dsY01RaFpsN2FiM29HUDV4d0JjMUdvaUJrOE1X?=
 =?utf-8?B?emVUamlva3NDVWt0RU5lRjZqd0Rock8yekVaQmdDNmNxcmorNFVySTlnRnY3?=
 =?utf-8?B?akRHOXVpZ093aGs5UkthWlZ6TWdPYkdSWjN0b3liNHFlNThqTGRjQXdiWFVO?=
 =?utf-8?B?OUF2R25OS1dSOWxWdWF4M0FDQnNGOTV1SjZyRzBJR3hpWWljM0tkMVFZOVZZ?=
 =?utf-8?B?KzEyZ2M1S3IxbFlxcURyT1B4SlhnemxkcHdxUlhEckx6MFpaekk2T3RVeXpt?=
 =?utf-8?B?dUZQckVjaDlCYjR3Um5BUEpRc2c3Z21LZEhyRURRK2hTVFNGMXpGMWtzT1Jv?=
 =?utf-8?B?djFrNDJmcGNxelp0TFM4ZElBYVN3WjBOQVprajZJazVKbGdyKzl6cE5pWkFL?=
 =?utf-8?B?SWc4N3BKR3kyYXlqU0ZaTjJUL2VuRHR2c1JGMzdnWW5qUk5TUjlOd1lDSkxr?=
 =?utf-8?B?MGc3MTlHQ1hKR2duWFkvZTJVZzFHMG9hckFsWXRnVVVYVlJ6VktQNm5nY2JH?=
 =?utf-8?B?WENBdGF5dDIzemNVa3ArMGJrekR4akNUWGowWWhTWWJjT1hLRHFuU0RiR1Fl?=
 =?utf-8?B?WTBPdXg4enBEODhWTHFPdVZVQ0M2M3JZSXVKcnIwTkU2bTJPTjNWUDZkVzEw?=
 =?utf-8?B?VDJLNzlycnpZNUxHcE9VQURvM2x2SnFkRU5IV3RUSFN3OVpDdnlwaUNNQTBv?=
 =?utf-8?B?U2swNTZ6MDdZaTJnL2c0aWdiOXFBblVTMGRjcG5jZ3hTM0tPTmtCS3JEZmtH?=
 =?utf-8?B?WFBkZnc5RGg4eDdkQjJwTFI0V0Z6MUg3ZFFqYU1rMzdseHArSklzOGJKSzZH?=
 =?utf-8?B?a243QUdqcDBScHNzYTh5TzFtT3BhTGp0Z1M3WVdDMEsvdkdJMXNUZWdBaDcy?=
 =?utf-8?B?dXByUnZEVkFPRGk4YUFlRzJkZWV2OHZlSStueFJpWkZJK3Q2eWNuODcrU0xx?=
 =?utf-8?B?WEVnTEZ1SUlmdnpnQVpqQThuNjlYaXBGNWlTVTI5dzdmQnFPdHVnY2l2UXpv?=
 =?utf-8?B?RnpKWXZSdFRXUjQyVUlMNUZLSTFHVnB0ejI5UlVaVC9BWDUxRGZEMVJlcnNM?=
 =?utf-8?B?ZTcrZmRBbWM3WFNieU5lRlBqVkdlUURRQ1VmaWkzWHhlcktiYXdEQ2RudkVO?=
 =?utf-8?B?Wk02M3h1Ukw0azJrdzBBeE9GV3NzQ01ZUUlSdUJpRXo1VjhQN1ZJZ0R2ZTQ0?=
 =?utf-8?B?NXdQZlZMamMrNnhxeW9MVTE1Z0dnbXVJdkFHQVJ6Z3pkdzdGQ2hMOVZIZ29D?=
 =?utf-8?B?MVp3bkMranVlZS9QWnd3MWZKbWRndFNqY0VYajlxRFpZZ0xiTUsxUzNzTVFY?=
 =?utf-8?B?dDcyaFUrdzBEQ3RWeHp3QmxIOGNPVTdGRUE3Yk5lN0Foa3AyU2xMNEZUb3ZZ?=
 =?utf-8?B?dEdqbEtFaHdjc0hSVWl1TThEc0pHc2I2ajN3TjZGOUZwYlMxekd5REd0NUhF?=
 =?utf-8?B?MTZaQWV4Qml2Z0xWVHpHRkZJS250YnFVK2EvTVdqVXdmMUhFU2N3dGdpd3E5?=
 =?utf-8?B?ZUxveE1iS0FuVkZ3dmFoR3dTMG0yTUt5dnBEUDI2b0lzY3dCU3BJWEEvTkZF?=
 =?utf-8?B?dThDczU2NUZpYVBPaDYwak5IcUoxaEZwOVJ1cHlEWUxhUXNMdWhUSnRRVXpQ?=
 =?utf-8?B?RGljWEg5cm93djZZZGZPRTNiRUdzT0RHWDR2cGFnMHRNaUgyamR3OHBsc215?=
 =?utf-8?B?VVQ0WXkvNjhYUUpseVdOQ1FEQ1M0U1RHc3VHRzV4K09MYXJYQTNjREJ6S2Z5?=
 =?utf-8?B?MHhzQ3JhenkxQWxsZnlFMFJrb3ZHTjMvbEpjS29WNnJuWDIyd3FGeEpIUm9H?=
 =?utf-8?Q?Z2cf8FTycrw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpGUThhMTdscUgxWUtheDJzcHhoWWRESExXUDhWSm5aTjkxRGhnOFJ4TTB3?=
 =?utf-8?B?T05CWHh1OHdCUE5aU3k2VHVuZDV5bGg4MFIra3M3dFJFYTNJSGVsOUwzMWZF?=
 =?utf-8?B?U1ROekRaKzJkVTlzQkxZZ2JtWit2ZjltOUVsVjVFTTFvbitYZDRFdTl6cmVG?=
 =?utf-8?B?R29Ddks5ZUoraFBTZE5qNHlUY1FmcnljNm9iRGFzM2U0QUtUT3lSc0I5WU12?=
 =?utf-8?B?S3RLN1h3Smg3NXg3WlF1aHJhNGhQQTVYTmtCY3JrZ1E1a09KZXh0SEptSUp5?=
 =?utf-8?B?REthdkJHSXBYQmdMM0xwMWwrZitQTDFYOXd1SXg3Q3VmOGxHbS9mbGVOZ1d6?=
 =?utf-8?B?QTQ1VGFZVUt4QlJTdkErWFJpOUQ0am1nYmlRM3A1akpIRm9FRUJlVENUdy84?=
 =?utf-8?B?TFlML2c3dU84K0JNT3JKb2c4dlo3WnRLS1lKbjg2RXdmKzYxSjNIaWpnZTFR?=
 =?utf-8?B?b0xEQ2pUZXRGS3NUMzJvSkZiQ1BQcGwxQUhyMW5SRFhCb3V5NE1nNmpzK3BN?=
 =?utf-8?B?TGQwN01XOHZ4MGFDaGdGcXRqRVNMcTl1UUIyZ2hZNWJZRXBJeHZ0dndLQ3p5?=
 =?utf-8?B?c1NXc2wvQVI3TmRyTlVQcUNFWUlhYWpJSnFUU1o5NHBvV21WdmFHenJJeUNk?=
 =?utf-8?B?cGt1ZWgxV01MRUxFbnhBZFZNLzFEUGhadTRwQldjdEJXUW82c3pPZktCTWxx?=
 =?utf-8?B?Rm03d3RGeEszb2lCSm5xdWdMN0VVWTBWWW0wbUVUUzJhUmQ0ZHRvdUR6NExj?=
 =?utf-8?B?VTBudUl5WTVYYnhQZ1VJdGRMRXZvL0VWUVcvd3VNOGh3dWh4OGNYblUyQ0lR?=
 =?utf-8?B?Rm5TUWVVVGgvRU5rT2drb2d2MVhZQU44MTY4dy9aV1hiQU9TOC9YTVZxNFdT?=
 =?utf-8?B?Mm5pUExqQlJmM0VlQXo2b1J0QTh6dzZSVS9pN041ZUJuT3RLR2cvaG12akI3?=
 =?utf-8?B?R2cyZGxhcGFsY0M4QVRjendDZ0trR2Q0bVZjVUs2NUZib2k3ZjhZYlhZV003?=
 =?utf-8?B?eXR0RUt0LzFSbTJUcEJDLzI4TmdoVEtJU3FtUXRyU1h6L0VKazZ5UE5NYXgz?=
 =?utf-8?B?ZTM0TVk5SXVFWUN5SWpzUFJrSmZVb0ZDVS9OY3h2R1FZM0Y5WThRei9JVVJo?=
 =?utf-8?B?alVxNUZMWGFQRXRQaUJKUEx0Zk5wVElLTm85YlFvSi9lcm5zSnFsSXYwSmFu?=
 =?utf-8?B?QVpncUZuTFVyRVdTL0h3ZjJleXJZdm5sdHpyNTdrME9UazF6MEhKaWZvTC83?=
 =?utf-8?B?REFqQzdHWnlSVDQra0xyU2VraU9lNEk1ekFFMEpsUkZETmcvQWpsOGpVMENC?=
 =?utf-8?B?UE1qVkZmbEVHU3VaNVdKMTZQSFZqdkxrYi9lNkwxdnB5QjV4U2o4QTBuWWhX?=
 =?utf-8?B?c0lxQjRnVWV5eVBsL2J5SERSYkk0U0Y0MHg1VUliNnNaQjREN3B4U0pyYkdj?=
 =?utf-8?B?NG5Jand3R1crYXRhcHpnYkR5VjJNSHFVVnlSSG5XQy95MTVXVWQ0ZitWVFB5?=
 =?utf-8?B?ZnJmc29qQVVsNngxOE14VDR4WURhMldFbTd3RXhhREhsT2hZQ0NuNGoxbjB1?=
 =?utf-8?B?bU9ZN0tQVHlCUUNNVkZHa3NCRUZxaXl6Slp0U0J2L3g5N0wwanArODQrV0hx?=
 =?utf-8?B?clRERFVOd0NxUHRaamhDZ1pUV3QvSll3TURSSHNwaElKZTc4bFU1V01ab29M?=
 =?utf-8?B?WXJubXBaNWx4U1ZLMGFKWFRKSWVyUzdjUXhrcnRNc2RJRTZCdTE2ODlJcE5G?=
 =?utf-8?B?ODJFeklrWUpvZlQwMTUzTEdrK1NrY1pHZ3BrVFdBa2VWV00wT0RtNFVkRC96?=
 =?utf-8?B?eDhCNSs4aFhSbE4wUzgyU0xueFRWZS9pUERUdzVEYm9SeGlQSTF5NXFxLzds?=
 =?utf-8?B?NlltZWNqenJIcFliSkRKVXJjYW05ajJPNDdIZnFLY24wblR4MHpHVkNJRGs2?=
 =?utf-8?B?NzRnNFBmY1N5L2ZtOEV1L1VyTStNaTNrK0NicHNkMUs1emozRHZ6cU8rRDZy?=
 =?utf-8?B?VXZvUThlbm1KRXNPWGtzK1Q4dmh5bjRuSzVUaDgxUmk4bktXTm1Wc2ZyM21o?=
 =?utf-8?B?aFEwZVphaFg4KzB5c3QrMVY0dDVxdXRxd3dXQW9QVmh4VU1icU1URE5WY3VV?=
 =?utf-8?B?VHlmMThaT0l3K0lOMnIrQUovaEF2VFQwUmc2ZHlkOG4rbXk5WEV6WW1ObU5j?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea038e0f-8492-4f77-c3e4-08dd997a9ce5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:50:05.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mZ8X4xwbsXQnYzbVKlfAwbZ2vULIDLZl9E3jpON7WBRTXnrO1G9jQ5cyQtG9BOZnxnA3i64fC0rvjaknk1/5n/6+8zmDX5TelRfQpMiAHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com



On 5/22/2025 2:37 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> This series adds support for using pathspecs to limit the comparison when
>> using git diff --no-index. This is similar to how you can limit what is
>> included with pathspecs when comparing inside a repository.
>>
>> This version uses only one set of pathspecs and instead uses some logic to
>> skip past the root of each directory tree being scanned. This avoids needing
>> to parse pathspecs multiple times, and is overall a simpler approach.
>> ...
>> I tried a couple of different methods for skipping past the leading portion
>> of a path, including skip_prefix. Ultimately just the index to skip to
>> seemed like the simplest solution. I like that it means we only need a
>> single pathspec array now, and that we no longer have to worry about
>> changing prefix_path_gently.
> 
> 
> Nice.  I kept the previous iteration out of 'seen' primarily because
> it seemed to break the tests (even though it passed standalone).
> Let me see how well we do with this iteration.
> 
> Will queue.  Thanks.

The tests all passed for me on their own, but maybe something is flaky?

My guess would be that the changes to prefix_path_gently which are now
dropped would be the most likely culprit of some sort of intermittent
failure since the rest of the changes are fairly well separated to just
the diff-no-index.c code.

Thanks,
Jake
