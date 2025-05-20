Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52B255F49
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781264; cv=fail; b=GGjF14gjDozWCkhwp81wgsLi5bsLcuaJUuXJjGo1eIaw6SacyRhnfmvxtJprhYO2wjA1DrKeGB2OlIPuKkyojMgZ7YDbNRfviuDaZRrpcYcdNRSimsIuTKKb88N2RF+zmyiheL0VNAqxASC/ZaM/nzJdHOw66skEBxd7uWpp0wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781264; c=relaxed/simple;
	bh=xFJ8Q8p3iasxoNO84+ZmbZMarXzSYlQGkFb/nXJSuEE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rQJzHoAVzHjQ311FQ0yvQsaT+hKQum2ri8tril0KraBB7Qfdkf5oDz/AUoMcqd1L3UW3ArkaxqeneSNFR/Vey5hVY+peNJWEEVMMpySBOncaHuCJ5nZ0QxwHSNMwt6U1iBAZ8SO9P6vO+s+bqtcumjg55G3JcpjVINrv4fFvrdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqVNj3aE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqVNj3aE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747781263; x=1779317263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xFJ8Q8p3iasxoNO84+ZmbZMarXzSYlQGkFb/nXJSuEE=;
  b=LqVNj3aE3DwxLO7TB6IZpPCNS5Ri3enr4k0ezoEPkrqXZGIzQvsq61Kn
   KG1w6Wp7/5mbzRreJYG9rsRgCnmwG4KC46LnPtiqZx5WM4YNKQM2bdypM
   UTBRJO8sF+SFv1CJ4PQXk/012QnrasXoFTMeL0HNBDbtXsA455/+o8gff
   QSOATmrY1HQWA0XSQkEAB/q0dWXIwOHGaMsjQVgTr9bOVMpSTBlRQQjXv
   jLuWyAr1wJfUnZ5bOWMYq5Kb7oaGWvp86mRXeHHSgPeoyK5ZeWeNrAo2O
   Qe44kd6UdJV8hcgMmJS45uRnaFIyWCDqXAhd+rl+Wk0IxMpInclnreFO9
   w==;
X-CSE-ConnectionGUID: 2C1LEAe4TF6sQ3SB6IaFig==
X-CSE-MsgGUID: PPcqUiNfQDOUhrWtXDQvOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="61135949"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="61135949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:47:41 -0700
X-CSE-ConnectionGUID: uGWrfhOoRz68bM3Q0EiECg==
X-CSE-MsgGUID: +W7m+aTnT3mM9sfih/VBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139702102"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:47:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 15:47:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 15:47:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 15:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7e7j89psVN1TYNVYH8zHfxFKeqlSr8Y1b2Ut+gu0/ETLk4XliG2yQG9SvvUQ4StJab/rs4ZjY1GMv/Towccz6yTTBfuhSBOTMpL4dbY0IxL8+fAivd1+Qdzm8EF1h2n41T/KrIYk2f5YYEfYveDKR7c3nr51rXq+1jNdOB+os+Mybma3ywN1ERb3w+J8RMUYzetpeoYPZmWUny49Gfs6ZT2yxKwC9kKzgpw5dgFSAGc0kZOrcmQtK9jvLHtFiHlE89nal5PRRaRFHOZr4s0b7W6lbfaIOxc0v1db6r8beW1vJju/is/Yav9wOQE06gthYuzUv6M0RjkuUcUz2qf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCKK6PaEXyw5l/P+2AhGvKpTecm/Zzs17a9ACo7zi70=;
 b=cwufv4/33grG4DpH7NPNOrLma0Tn3prEUESKr5OlQv/KQ+4vKOM5yigiuFf9QsyyFaa3GDE+hfEL4LYzgpw2LEcUGzWIt7x7Hon8aawzE3S4EFpTPE5uEFOQ3s/nMz/tQiBSbUfgj4lCLtITnM/zicnuAgPyuCE/gVO2TgiJcmz7ZU9t7OwW9f3RcPO8yfpoK9HYg1TtRg5C17Vbl0XH8UMD9YzsBCKtEE6xIzAmrtIn2M6nFdYAclR2DsbQeWif5uFRZ8DbwuE+6CXkBXs6uoMh7zFCW0GW5J92N4SYy3dR5A/Hx3/tDtf1Wml97hitjgQMRQIoTKLCi8w3REYznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7623.namprd11.prod.outlook.com (2603:10b6:8:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 22:47:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 22:47:37 +0000
Message-ID: <fd82cfe6-0a3b-4f1c-b9a2-91d61ddc9391@intel.com>
Date: Tue, 20 May 2025 15:47:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] diff --no-index: support limiting by pathspec
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
 <20250520000125.2162144-5-jacob.e.keller@intel.com>
 <xmqqy0uri6st.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqy0uri6st.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: f917c1cd-ce23-435b-b894-08dd97f0518b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWhaczJFd0xDM1V6YVYzOGlmMDNobmRjcmtrK1BMMTBkUU9PVzVJV05zK1BG?=
 =?utf-8?B?ZVJyN0tjNy95bVlXVHdtU0tEazRBUFYrZHNuSGQ1WmVMSHJ4aGVqTGc2a0Nx?=
 =?utf-8?B?SXhZZ2dYVHN2STI4KzQ0ZmFmZ2VucXFlbzhXUXlYbjZtekpjc0RHcDAxb1hy?=
 =?utf-8?B?SE0zOGptajVHRGdRNm02TWhqaHhYYUNQcmxmVHhDYll2Q3hLeFgzRktFcW5Z?=
 =?utf-8?B?dXlNT08zait1NHZhNHVmdTRCZUIzaFhrM2NZM0kycVJtZG4wTlp0SHFlaFg2?=
 =?utf-8?B?SWhqalRGMyttN1M3dXZUaVdNS0hhbW1JSElzK205R3NVTWJrWm9rVzVJT2t2?=
 =?utf-8?B?bXNMUitYVmE5RStjNEE4ZEpGZWJoV0RuTVVuamM4SWY4QTRFZ1BDMFZ3TVdy?=
 =?utf-8?B?clY1NXVqZ001Y2lqbTZYM0dVdldydE1SVHI1Y0ZtNUVScitFV0hJQ29pSDVq?=
 =?utf-8?B?Uk40UVlZb1M5SGxPajFFbTlUaDc1dE84dE1wNFFxc1lpUXB3Qlg0UXR1OElo?=
 =?utf-8?B?OFUzQkxtM3RtWEs4MUZHWmVkVzllaFFOWEkyaWNCOXZNMUEySnJHNGo2bXY4?=
 =?utf-8?B?NU5DYlUzelpJMERBd04yRGwvNXBVV01IKzhZUnI4N25PQW9TOEFUZjRONVNE?=
 =?utf-8?B?WlJMU0M5aWRKWnkxN2xGdW4yU2dWZWNmRlZNTVV4YXp1NnkvR0h3amE4Z09j?=
 =?utf-8?B?cWU0cEt3SFNqMi9yVUFGbFhkeFZJWnNYNWxkbHNkbXBTbm1iMXVyU3pUUTJU?=
 =?utf-8?B?ZUVXUllZK2k1cVpZMS9Wa0tjcU9tRldLN2FZWXJDZzhFVjZ6NVc5MXRub2h1?=
 =?utf-8?B?MnZlRmcrTE11UEZJcXR1RXlqRkpnUlIzMlVtS1U5eTRVUVg0SnBtREQ0eHpn?=
 =?utf-8?B?OWJpWkdJdXpiWEVnU0tXSXV4YlN1ZDA5QTNEczhiUXNZQ3AzeUV4eHdibngw?=
 =?utf-8?B?UFgycVF1OWFRWnJ3WnY0cmMvY3ZLb2xLY2VJTVBzQVlsNE90djZlMGttRFJB?=
 =?utf-8?B?ektLZEZweGwzYWR1VUFRWlRGSzFsUWJwTTluR0Niek1YTkFIMW5RK09Eb2Ns?=
 =?utf-8?B?cEd4Yk9OSnFpSWZQL1R4clFKSGl5RGtVNll2c2lQdzBNU0NoSDNFbzNSMUty?=
 =?utf-8?B?REFSUFhJRWdBYVRTMXFnWVFGOE5GWFZXN2hBVVUrRmlXQnNhTjRQbXZOSEQ0?=
 =?utf-8?B?WGZPeFFaSkwzZnJnSC8wNDEzUXY3NmxoSmN5Z2dlQzlxRGc1eU9ldmdRQTRR?=
 =?utf-8?B?MzBIZVJnMWIxWmhVaWtzWEtjOGprU3hYOU5DWnZxdWtnOVUyRi96dXJReEty?=
 =?utf-8?B?RnRybi9JeG1uVTlPajJncFBNU1NCSGlQenBCVG9RYzAvbnFBY0FFMGcrczIr?=
 =?utf-8?B?bEQ2QnF4eXB2ZVdFNkw3RmpnWDdRTkI0aERZcEJjSVM2TTRIOVRWL0pzQnFz?=
 =?utf-8?B?a1JlL0k0Q09JTS81MzNkQUwvcXd1VitWNFJKWFozQkVuRjBDMkMrZTBveExk?=
 =?utf-8?B?aldPTVVmc09Ic01HMlJWRFZYRzY1OG9XT09tSFgzeTVmbDRoMEZEL1NiYzRY?=
 =?utf-8?B?QXlHTlMraWplRWlmMW9xclpjK00wdmFON0VpRFFNWDREZWh2Y202V3ErNzZ5?=
 =?utf-8?B?UTFsYmhYRFhoMXlJU0ZQRUdBYlNvN2JMd0lXQ20wMVFFNmprUFpJT3M0cmUv?=
 =?utf-8?B?ZUM5cFVsczJVclNvL2I3bTg4ZjZTYmtINkFIZlA0TDZlQWVrdmhYNFdBVGhD?=
 =?utf-8?B?ck9YWisrbmtXNStIM3BCYzlZd1REanhjaW5rVWlYQzNTQWFZMFNyWnNkRkU5?=
 =?utf-8?B?cDREU0hsVDBGSGNIWEhUdXJYc1NMT0lGODJUOVpJZGl0ZTlyZk9GbkhmMHJK?=
 =?utf-8?B?ZXFDRWZuZldLbE1mR3U5RENSVHVFdHNoWXFQdnJpYm5Mc3hJamViMTdreU1q?=
 =?utf-8?Q?1d0R8i6IUMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRhalVjQlpUZ0h4S0paamUzRTJBZHZUQVg1TnYzYWtlZmRwa2NMRVpmRU0v?=
 =?utf-8?B?VDVJNFVGbG1qUXFnSnhJTDREYUR5UXd1eFBnclpLRmJoMzNZZ3hZOFRKQ3hh?=
 =?utf-8?B?eklPRjVocGNFbTh2Mi9zVG5SN0tQcCtNay9XZlFqdUVrTTdoSGt5NS85NnE3?=
 =?utf-8?B?ZnY0cW1mVGk3R09JZFc3YnVpVlcyZzRsRU1tVW90SE9LZS82Q3Z2RFZSUlhZ?=
 =?utf-8?B?dHdtT3lWZzdSejkvMkpubXBkNndnaW9mQ2t6aEdQRE1uS0tOYytscjdmRTR3?=
 =?utf-8?B?YXNHakZEWVVjWVpzekRSSkJ2L2NBRG5hZEJtZFEyc09zdFlrVzhqSFkxaFc0?=
 =?utf-8?B?YjZHK0tFZEdiU3hiMlFNZFpWRTFFM1MzTVlMS2N3UEZBeUwzOHJ5c3BXTTRo?=
 =?utf-8?B?d2JveS96dzNmcFhoTWx4R1FzYlFOMkZTZUhjczErMk9TVHZqVkRSbFRvc3Z3?=
 =?utf-8?B?T0JyTlNPdisxUjZMa1Y4ZmlSMGplZWduTmhFVUcxeWZwS3BoWWlncVN2U1JF?=
 =?utf-8?B?eDNYV29oak9hL0Y4ZHhqNkhoSXZMUXo5c05IeHYxdXhKakVBb2hoUDRTWXY2?=
 =?utf-8?B?N0lLa21hNkNvNWRtVWxLLzc4cndKT2pReTF3RlFOZVA5R2hLampYS1FJOElL?=
 =?utf-8?B?eSszeHRDR1VBZVRTSE5GTXFTN2VCbVNLL0d5KzVyNVFMcHNJWGxpeWM3cDg4?=
 =?utf-8?B?Sm1IdzNFK0lDY0VjRnZWOEpQNGpyK1lQWUpOeWlTRkJ0QlVRdXh0aXV1YVR1?=
 =?utf-8?B?VUV0MlhPS3BRWVo5NDVSUmNReTA3c1VOb0hEUEhnMm1GQkszRUlaRUEwVTdz?=
 =?utf-8?B?dzc0VDVlSzFSb0NseSsrVmw3NkpwSVovUzVHNncrbm1kSHg5OVBmNWdhRWp3?=
 =?utf-8?B?aHZNeG9QUDJ1S2N6NGJMSmdrL0ZxdWhoMUNvL3hSUlV0djhBMUhoaEt5UDVF?=
 =?utf-8?B?OWk3T0UrQlJoMXdacGZiOEtwdDA0allqdDFaMjJJdTB4TTNLaEZNaFd2bmlQ?=
 =?utf-8?B?R0VqV2hSRStWcXA4MERvaGtvemlHUmc2QTEvTmxpU2lTRmJTd2RNVHNlaGJZ?=
 =?utf-8?B?TXNURUNsRUQ4ay9MSUtuK0NocjMySWRScjYzc1BOUFhrNXR0OEU0QTM5S3FW?=
 =?utf-8?B?TGFORTVUcGdWNFhmVElhejFKbkViNTJ4UDNveHlacDkzS28wUW1hblB5REVD?=
 =?utf-8?B?Y0ViL1p3MlBIRGRPU2Y5MUovRFR6ZkJsdlJ6WlFsT2FRUnZjeTNSeTVqU25q?=
 =?utf-8?B?QlNuNnBndmpLVUhwSEtIWFA5ODBtMlNHclY5blhKaUkzK29POFRzWTdLa1Fj?=
 =?utf-8?B?Wm04N3ozSkQ0YVJ4dlRrejRsQjI4UHNHaTJJS1RGUkdWNWZmTW0yUlVIUW8x?=
 =?utf-8?B?MjBTV2ZhcDhHaGtmYUVwZ1hDUThpeEVYS0pPSWN0Y2s5NU1VbE1lVWMxSURK?=
 =?utf-8?B?alBwMnB1SGZ3N1c5ZGlHY094WjhUZmZTU2NMWUdMM1crUjZVMHdCLzNHZWpy?=
 =?utf-8?B?eVJxQmZjaXFJSG51dGJjbVBPWTlteDRyS1pBWGFadjhhNkZDcUlGaXl2V0VG?=
 =?utf-8?B?WUtReTJGem1wTGh1NEdCbWM3ZERDTW9SbjRFalVuZFdkY2xLRVBidGMxYWl6?=
 =?utf-8?B?Mm00QWpkdTVUWTBhQ1hLOTJRcG1SaFdjQktzY0Vpck1OYStndjdEcWE5UnJa?=
 =?utf-8?B?OGcvWWE4cmZncG4wWDdEdEI1ZTdBZit0dnpBQ2Y4WWNHd2tvZ0wwZ216MlZI?=
 =?utf-8?B?QktVNno5d2ZLU0dqRm1zbmpzQlBBRUNGbWhJTFAxcnpVQ3Nzb04rNUdmd1d6?=
 =?utf-8?B?NkVmVjBLaHYzZUk0RmEwVmhSbXVyQUZiWjB0WUpLMGJFMmJvMThKNHNlUVhh?=
 =?utf-8?B?aUNnVFRqS083Ykh4OWtTdzVXVTVXUjhuSzhUZE1nRHVhZ09nMXB3WUhuTVZm?=
 =?utf-8?B?NHJ3WEo1SlQrRkZvTysxWGVaVjNCWU1jaXArS0pmb0o0eFFScjBMbkRlLzR3?=
 =?utf-8?B?YXo1WFNvVTBVY3BweTMwN1RjQ0VkMzNzbFVLRkNaaVgrVnNoYWxNZGlzaU1v?=
 =?utf-8?B?UFIxV3BIc2NYZEgyVllFS2Q5QlJTU25mZXZxbFAvSTJwc0RZVGpLVjRMYmJB?=
 =?utf-8?B?bG42Z0dPdTJMUnF1WHVsNlpUM2tkdFpla1J3aXNFTUpveER6UVRISjM5bHhE?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f917c1cd-ce23-435b-b894-08dd97f0518b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 22:47:37.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT/nQKHPDTHYbsKJOwLbeqpRZdsZ+6SxcJPMeqgjPmPslZ/bwVIy2RyiWMxVkSyAEgPb70mhTNsKeUl4REjVEtykhLzbdeJR/JSir++5F5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7623
X-OriginatorOrg: intel.com



On 5/20/2025 9:30 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> The git diff --no-index mode does not support pathspecs, and cannot
>> limit the diff output in this way. Other diff programs such as GNU
>> difftools have options for excluding paths based on a pattern match.
> 
> True.
> 
>> However, using git diff as a diff replacement has several advantages
>> over many popular diff tools, including coloring moved lines, rename
>> detections, and similar.
> 
> I said this when we introduced "--no-index", but back when "git" was
> still young, it would have helped a lot wider developer populations
> if we didn't do "git diff --no-index" and instead donated these
> features to "many popular diff tools".  We however chose to be lazy
> and selfish---those who want to use these features are better off
> installing "git" even if they are not using it for version control,
> only to use it as "better diff".
> 
> People are still welcome to add "coloring moved lines, rename
> detections and similar" to "many popular diff tools", but given that
> "git" has become fairly popular and widely used, it may not matter
> all that much any more that we were lazy and selfish ;-).
> 
>> Teach git diff --no-index how to handle pathspecs to limit the
>> comparisons. This will only be supported if both provided paths are
>> directories.
> 
> Good.  If you are giving only two files, pathspec limiting would not
> make much sense.  If you are giving a file and a directory, lazily
> give only F and D to compare F with D/F, that is essentially giving
> only two files F and D/F, so pathspec limiting would not make much
> sense, either.  pathspec limited comparison would make sense only
> when you are talking about two sets of files.
> 
>> However, if we always passed DO_MATCH_LEADING_PATHSPEC, then we will
>> incorrectly match in certain cases such as matching 'a/c' against
>> ':(glob)**/d'. The match logic will see that a matches the leading part
>> of the **/ and accept this even tho c doesn't match. The trick seems to
>> be setting both DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY when
>> checking directories, but set neither of them when checking files.
> 
> Sounds sensible.
> 
>> Some other gotchas and open questions:
>>
>>  1) pathspecs must all come after the first two path arguments, you
>>     can't re-arrange them to come first. I'm treating them sort of like
>>     the treeish arguments to git diff-tree.
> 
> Exactly.  "git diff" proper is about comparing two sets of files,
> either comparing two tree-ishes "git diff master next", comparing a
> tree-ish and the index "git diff --cached HEAD", comparing a
> tree-ish and the working tree files "git diff HEAD", or comparing
> the index and the working tree files "git diff".  It is a natural
> extension that "git --no-index dirA dirB" compares contents of the
> two directories.  In all of these forms, it is common that the
> comparison can be pathspec limited by giving pathspec elements as
> the command line arguments at the end.
> 
>>  2) The pathspecs are interpreted relative to the provided paths, and
>>     thus will always need to be specified as relative paths, and will be
>>     interpreted as relative to the root of the search for each path
>>     separately.
> 
> Yes, that is not anything new or something we need to point out as
> if it is any different from the "normal" pathspec.
> 
>>  3) negative pathspecs have to be fully qualified from the root, i.e.
>>     ':(exclude)file' will only exclude 'a/file' and not 'a/b/file'
>>     unless you also use '(glob)' or similar. I think this matches the
>>     other pathspec support, but I an not 100% sure.
> 
> I think that is correct "git ls-files :(exclude)po" does not exclude
> git-gui/po, for example.
> 
Sounds like you answered most of my open questions. I guess my remaining
big question to you or others on the list is whether or not the overall
algorithm makes sense, especially in regards to how we handle needing
both DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC, and in using two
separate calls to parse_pathspec, one set for each path.
