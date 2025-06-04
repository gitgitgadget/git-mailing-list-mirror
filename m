Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438F1F463B
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057531; cv=fail; b=uiThvRIKnQ6JuZGrVr4xfSSZ0itsLUqwpY2+fSXUV7ty/pjDLdVWLQO2PhvP6EDss1aOMXTnzGzCft3vViumVyMD9Jom9Men5dhEGE2WeR1M6q+vMAlaoUg4pAmfcoC1Il8cGkcgYNs6/nnRGS6TmueA5vdovHZ8Waz/dvvWsGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057531; c=relaxed/simple;
	bh=Sq/kICwE3GxV2XgWFPlgFK6RSVwa5pJZWGq86MogE5A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWLut2lVpRc+hc/NWoLO7UWxXrW2JJt0x062JqLvWzUCFZX7gIsL4Y7aeHJ4/bsmUqEFhHNvc0YpddZPbOqmpyyLTMeHjnBsbg83dl4ohZ5Fo+msGEuu1uc/0fjK57ACOKCshpjw5+uL1pHAWL5MdrHcie6u0g1xWJjbVLyjFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsyVs07o; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsyVs07o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749057530; x=1780593530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq/kICwE3GxV2XgWFPlgFK6RSVwa5pJZWGq86MogE5A=;
  b=ZsyVs07oyjJlSheKvwlxYLUL0dMm2CQi7ADw9DQizBTrmJOTdLkp0Lhc
   l8mnHOrP2ZYIf9TdaVSEPN8OvMlRs25xxnloYHbv78KQIeGBxYM1DeiWR
   8+5CHC3kqZGaal5pSoF7kfpEcr3aO4VADtMrfvbtY5MZy9+sXbdDpqCRN
   Ur9lOC/k1UTOJ1cazCfGPA7CElmqO3OeVftmb/0Rub4k3XcDSlDa3Qwuk
   CwjWbka6CDx2xroC9j3+H/qvDc7dJwi49e4NPMyAT9qa4ghL8QychBXPQ
   zAhHEPA7Zy78F1QfZhYk049I5yXjqiOxOrQh3BaYE+rX0NW7RopmGGyfP
   A==;
X-CSE-ConnectionGUID: rpgyxRaLSFqCruiDDx16sQ==
X-CSE-MsgGUID: jztv5SeTShCce5T7uice1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51020253"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51020253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:18:49 -0700
X-CSE-ConnectionGUID: V6oVcJotTsKbF4LTer6vOQ==
X-CSE-MsgGUID: zt7LwHviQgS7DNsAT16yJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145595523"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:18:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 10:18:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 10:18:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.81)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 10:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsVR6dGAfzSe+G2OaDIEgO4pgKaXQLhn1kMk98bAO+ntKyVVN+9jDff14E4RTtrRKb+Dfj50mUNtxCsqtqqA/0ZFildVd1kGTkAs8nTrH0ht1psq3H2qzxv3aEJTSNLDEBq024r4apiL5HaS2RZwAiz/hApV9lwbGbinlHTG62qgFm4zvsxpJaA7GcXhnWUKB2Cjd4lfVhDqynqIF7965ecqg5bjuSjkeOq1pOQNRyNz9JbgIzVGDPnCXNc6LKnFZUMUc01FIkGwV1cKLa8+uqxSJxQIFQ86sKMa1ZL6pNctzIfFMQ+z3z5zZ3YFbYxDIvK/bBsr53A8cqYwKqievQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW5WQKrHZYgsab3RCjImu7hVNTSZyYJayMYomvMxcXE=;
 b=ExnxvSM6FqbI7BumcfsXKfJ/yLEnJ7bif252tZug1TGNlQxjVQyatYJ8kS/shscOMf6SRFbU/BIV6o3e2dyeeCwdjt7b2lfixI7JNDnUjCLHcTt93KgWzTcNmhg+Jacn48rSu1yxmyVWAJgqIxtQt3RX7zJyJ7N3m1DyKfnuYHCZPsyICs7EZKixETYnTqwe0nkrIHgUqBxYjs8Mvpa6yj4hBMFQQirRSNyqvu4TrBT4mgvXwLE3OTeImKeBujVUFsF63HhWe78PvIRNr6DEF7X0xKDGe8vcwi3ICkVwEOY4mwdf1hEPyITazniJEH9HNvFRVe+o97EZEmpLDs78aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA4PR11MB9396.namprd11.prod.outlook.com (2603:10b6:208:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 17:18:46 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 17:18:46 +0000
Message-ID: <48c2af0f-348a-4443-a8b7-74ea4b666bff@intel.com>
Date: Wed, 4 Jun 2025 10:18:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: issue with git submodules and a clone.defaultRemoteName different
 than origin?
To: Junio C Hamano <gitster@pobox.com>
CC: Git Mailing List <git@vger.kernel.org>
References: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
 <xmqq1ps0gzo5.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqq1ps0gzo5.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA4PR11MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c54900-b8ad-4eb6-ab40-08dda38bdce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXFtVmZWdnFVbGdoUUpOT1dXQ3lRSTVBd3lXMUprRFgwVzBvNVRTaHR1RnNZ?=
 =?utf-8?B?UXZuQ29wNjN2ekpWSW5QZkZ2SHF4YmtFVmY3eTJscEVxTmJSS1hJb2o2UGxo?=
 =?utf-8?B?RzBXQmdwenQzUW5YN3MzUmZ1bmFpNmYzS3hRTksyejYvanE3Q3VvMUNYeHRa?=
 =?utf-8?B?Z0t5SFhFeXdhVnZaV2VwMFlmQzJkZzgvZkEyREgza2p6K294Y3ExMUl0T2lV?=
 =?utf-8?B?QUlITlhYQ2JMYytwZnFBb0RQbnpDZWFTNjlwMjloOSsrSnYzVW15TXB4V0tY?=
 =?utf-8?B?WVhrL05TTiswaWduVWRYaEFMenltYTFhMnJ2ZnhuSDFXNTR2TGg5S2N4VDNw?=
 =?utf-8?B?WFBEUTY4WklZb0xrYmFjM3l5VjRqdjJvWHhlNk1lUkZPQ0lmSVl5MXdCTUFQ?=
 =?utf-8?B?cXlDM2NnUzY0akIwVFp4MXhyREE2aTRKL0RDZ09UdndMME5UckFSQkhQSUVS?=
 =?utf-8?B?UWR2ZzZKVGVKMEJUalRxV1Q2OEw3NVVMRVBicDE0NlJRaG1mQ24yNk9PNUQw?=
 =?utf-8?B?MkpQMHp1Rmh1UjNtSm8vaEtxSkJFekhycElUMzh4bUMreDVWRDVNZHJiWnZN?=
 =?utf-8?B?WFhmZSsrejUvOXcrdkRMNE1Cc1IvMEMyeHBUOVdTdklrVDBuT2JrOXJnTjl4?=
 =?utf-8?B?cHhTMVJIMjE4MFJXK3JBS1l1YUZDSndBUElXN00wUFVlakRRUUdQOERUaDJD?=
 =?utf-8?B?NWlGaTNWR1FLUmdaSmVzVmZiOVB2RFJ2U2R6M2tXTGZ4QXdBWlNmRGoyZm5W?=
 =?utf-8?B?UU52TDJSemRnTWdIcUZlcTFSVFpFQllEbUQ3TngvcmVzdDBKVTN6UGZySmZh?=
 =?utf-8?B?cXFTV1UyaHp0cGUvR0NXbytrTUFwTFZOMklSdUwrNzVKajA3L3VtaGJteDBW?=
 =?utf-8?B?WHBwU2pvWVRWWWlrbFFjbmxNTUdEOWZMbllnaHYveTlJbkJKcThmenJsbHQy?=
 =?utf-8?B?REZ6d1BnN05UNE00WTFjUE1CVStXVDhUTFJ0NERMVU5aaFR5WXJBcDdIbHlY?=
 =?utf-8?B?bnczYnlaUmMxOWUzOHdvVzZ0c1J5cy9qZTF0WlNRd0xabW53MzFGbnV6Wkg2?=
 =?utf-8?B?Y1V5a2pVdEpBT0FLdDJmaVAvdE9qZlNzRWlIY2FZNks1clYzNzk0TDFIS2pH?=
 =?utf-8?B?ZW8zZ3FqWEJjLzVkL3BPNEUwZzRPQjZKMEFmUGtnQjBGeE9ZRWxlYTVUc0Nw?=
 =?utf-8?B?Ym0yVDM4NzJZZGFUK1BVY3JIbklIait6OHA2dVYwcG9kQm82TEhOcGVhSkhJ?=
 =?utf-8?B?eVB3WHNpNnV1Rk5CNmQ0VGpYallUZXNqa0NTV1AvcnQxODlzNGltNUdpUDF1?=
 =?utf-8?B?OHV5c1JqK0VMdWZuaHdKVU5KZ3ZyUE42WWdLWjAzV2EzbGtMNUdMdXNDbk9u?=
 =?utf-8?B?Q2kvRnB6a3lmWUorei9sbTY5SmlrLzZ1RDE0NHZyQzNSZ1JWOThqQWc2ejJw?=
 =?utf-8?B?dW1GcSt1eXVDTGpBdzZJbjRUOTZSdTY3SGl3c05valN3UVRxNlhtaENzOVVt?=
 =?utf-8?B?MHZPZnJJQ0x1MEREeXNUdlo4eWI0clE5dVpvZWJWQVhGVk9QbGJMckFDb0x3?=
 =?utf-8?B?RTllbEVKUnNuU1F0cmpIQVpya09lVDFwQmp3RE45cmI5c1g2a01PWnhTNzVQ?=
 =?utf-8?B?aUZoeE04NllEbEhITkFyekU3ZmVHbzJ2MTh4MmNSU1dTQ2hFVG5Hbk90dVJO?=
 =?utf-8?B?R21VQU5YMWpPVXJLTEFhUFVVdHpRZmFySkZWcGtmb3BLclFjUk5jODBXb2Fa?=
 =?utf-8?B?U3dWMW5sVmlUVy9KWWo5OGJmNkFlTHJNQXFPQ2FNZHNReGpZcHBsZUwxMVJP?=
 =?utf-8?B?VmhWZ3RsU1djQ3I4SHlmaEJ5MVhGVStNZ3ozVGFTVjY0MFdqZXVEK2RnamRU?=
 =?utf-8?B?YjNYVG1saldhNGVOSkZNYjF4L1A5b2hoYUxkc0JsTG9uOGFGWUNwaVFOc0xR?=
 =?utf-8?Q?m8urdixrxug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxCZmQ4bGROc1FWWDdqVmRKVDRFSlpBMGdVM2pXUE1BSUk1b0ErN05oczBR?=
 =?utf-8?B?UXFhbDg5TGs1UHNSdUR0cjlSV1FmVjBMSU9xVHdwQlRFMUlRSy9uSVQzd1pD?=
 =?utf-8?B?MElIUHRod3FnMWlVWFhFYTdoeGpLQ1ZYNWJxajU5MjlURjVtS2tQczUvd0RG?=
 =?utf-8?B?ZllCWTFZMTdZU3NKc3VvS1E0dHFuZUtsblliemRrV09OWHBOanluN2YxamlQ?=
 =?utf-8?B?RjVUOHh6TS84TVEvNUx1d2p6V2JEbnlMalFtMkFSYUlrekZVZ3dRQk5zU0F2?=
 =?utf-8?B?YmhWYTlJM1FnbmkvZnpadTlFSlRlWnpHUmVEeVhYU2xFSWMrQzlENDB2bTI5?=
 =?utf-8?B?eUpsN09OOUNoVS9PY3pWcEkwT1pERmdYNFFyUHAxOFQ2c1oxSFVROHlDMUVU?=
 =?utf-8?B?aDU4TitmdWgvYnR1SzV5b01lUUtmRFo5RDBTa01aeGE3eEpuaThnS1V6bEU3?=
 =?utf-8?B?ekxRdml3Tytmc3pTTVRYS21vcUlRcGtkd0wrTCtNMzdnTHh2QnJRZFJLYm12?=
 =?utf-8?B?Q0djQ2lHN0pOWlZUS2RjZXd2aTlidy9DVXVtTUx3ZWswQTlFYy8xSTBzS2Nt?=
 =?utf-8?B?em1POUlsUFV2QkJ3VGZjMVJBTGp4cHZPU0pEQ2Q4RGpzVmxsc1FDcmFXK1M4?=
 =?utf-8?B?cXlMbDluSmhrUGpTblNBMjRLT2pEZ3RFMi9iYWlOYVFpd2RFbSttTlk4eXZa?=
 =?utf-8?B?VU9lSy9SZXpCck1jTjRrd0xtWUJZR3NDTnpHQzRoQzgwSmZSUWVWS3VtMUhG?=
 =?utf-8?B?bVZoTjh3VzVNb0E1K0xCZkNENjBvTXVHYnY1MGwxWUM5Wm15a29UeHB1MWc5?=
 =?utf-8?B?UnAxQWZUQ2RPNU9PQlZzS2t3YlExdkZPNll4blZHTHFBOVVTeHhXQkhiZ3BX?=
 =?utf-8?B?QjI2YVJsNmJ3N2pmcms0eC9IdlpBVU1EWmFIeCtOdEpSQnpISTVLRklPOVd5?=
 =?utf-8?B?Mk02Z0NRRWhjZ3F4NDAraUJacHh6MGJjcXJZU2FqajhPSWxyOXMzU1BVL09R?=
 =?utf-8?B?aTdjbUM3WWNqSm5PVUxFK2JQaTUxSVdtVXVwNzRZYzZjVXFjWUJReUlTZ3BQ?=
 =?utf-8?B?S1NLR2Y4UnZrYUZEMi9JelZLeWNaZTVEeFhiejRrWlowQUFIVzRIYkJwS0hX?=
 =?utf-8?B?NWFvQ2E0WkhIYmtGaUxETTJjSmMrNWxVMUJZbmZZMmR6WUJmS25uUXFUdFZX?=
 =?utf-8?B?ZDJvY2UxNDAxaXNFWEJnZ0s1NVZ3aS85eTJmVUxEaGdQMlh6ZkNSTnJvQXZZ?=
 =?utf-8?B?MHFhZUN4VjkwZmd1WERnd3NaTjhOczAxeDdjem5XcGIrdXJlN1BvRFFLUG1v?=
 =?utf-8?B?NTltTjlsRHFwVjIzTjlqeVIxTmdOUUNzbU9PVk5MbWpCMmFuL2wvNUdNM2Ix?=
 =?utf-8?B?dnJJMTZxUkh1VnoxVWZXRzZLMmhvM3lHb2xkNCtwUVJHRjJ3OXJBSHJRay9J?=
 =?utf-8?B?aU9Cb0I5YzNtK0lYdHZCYmFMbHN4cFBJNHBVTzRRbEZQODlWR2d1VUJ1ZVQ5?=
 =?utf-8?B?YkFEMU1ndFQrNHNSSDJsWmpmZkdSUkdCUnJoMFFuSnNHcktxSzAyaHNMb1BN?=
 =?utf-8?B?aGZDNU1lMmVkbjcwa0N5YXB6cTFNemRlWlpSYlh3WXNWUnhjd0RDMno2dTY3?=
 =?utf-8?B?Q3J3MTB1SGxMVU50TVZuUUt6TU9kWlQzK0U5QzJNSjk3UW1KQUJqTFpJd21B?=
 =?utf-8?B?SkVtWnNVbXVoaWlIWm1hd3llbXN1RDNicDVYaXJPU211aTFSZXJRS2lQWlVu?=
 =?utf-8?B?SHIzdkRMVGtBckJVUkNIYWtoZEY1RVB6eEFkSUc0NC9VUlI3YlgzRk1sdGo0?=
 =?utf-8?B?eGpWcURidm1DTkkzVVVzN0xmYWxnUy9aODRZdkd2ZW1TVUEwdzVidnp4Y3NO?=
 =?utf-8?B?OTAyVUxkUDk5QWhwRU5lL2E0aHdDMCtnRVBWcWZOWHFiNUt5eFFGSElCNWxt?=
 =?utf-8?B?NEoxZ0JtdVFOWk9LWXZadWcvVjRsMnN6di9XN0hyVGdLOWFjWE55NzRHS1lk?=
 =?utf-8?B?Y3Bsc2MyZnhhcmJkN3lGUHRReEw1WXhaeldRa2ZHR2pqWTFCWnpISGFUbGJS?=
 =?utf-8?B?Z2pjd2ZVRGIzSHlLcWJyWEVESUlmbjh4UytyVWpHTEYwV3BwMG5oWnU3ZkNN?=
 =?utf-8?B?cVc0YWwwTWdybnIxZFNkQVFwZ1ptNklvQ3FwWHhkT1RkUFI1TDhLYnFrUUcy?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c54900-b8ad-4eb6-ab40-08dda38bdce4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 17:18:45.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj/nmeTN7Dqzzl41E5pilTZDjpHOWdVNym0k9cKaZDC9o9w1zATGyAHTM55aH1uJ7RCEGXeLmlln13WdS7IU2SVR+Tkb+fPo/IqoZK8IFok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9396
X-OriginatorOrg: intel.com



On 6/3/2025 4:42 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>>> fatal: 'origin' does not appear to be a git repository
>>> fatal: Could not read from remote repository.
>>>  ...
>> This appears to be due to the builtin/submodule--helper hard coding
>> "origin" in "repo_get_default_remote".
>>
>> I am unsure what the best way to fix this is. I could have the function
>> read the clone.defaultRemoteName, or I could have it check if there is
>> only one remote then use that.. or maybe add a new submodule remote name
>> option?
> 
> Is it is the nickname of the default remote that corresponds to
> 'origin' in other/most peoples' set-up you are using for your
> submodules that is causing you?  And because you have
> clone.defaultRemoteName configured either in the superproject's
> .git/config or your personal ~/.gitconfig, when you activate
> submodules, the "git clone" used to populate your submodule
> directory from elsewhere would use that custom name?
> 

In short: I set clone.defaultRemoteName in my .gitconfig to "upstream"
because that fits more naturally for most of my repositories at work.

Because of this, when a submodule is initialized, it is cloned with a
remote named "upstream" instead of "origin". (Either its cloned this
way, or I later renamed it to this as in some cases)

By default "git submodule update" checks out submodules to a detached
HEAD state.

When git is trying to find the default remote for a submodule, it will
be in this detached HEAD state, so the fallback to "origin" fails
because origin isn't a valid remote on my setup.

> What I am trying to figure out by thinking aloud is if there a place
> where that custom name name is recorded anywhere in the submodule
> repository (or superproject, but I somehow doubt it).
> 

There isn't, other than the fact that there is a remote with that name
but not one named "origin".

We could possibly add a config option which we could have the
superproject set when cloning to specify which remote is the one marked
in the parents .gitmodules?

Alternatively, we could have the parent record the remote name in its
.gitmodules.. but that seems a bit odd since a user could later rename
that remote.

> The clone.defaultRemoteName configuration variable can be overriden
> from the command line of "git clone", and even if the process to
> activate a submodule does not let you pass the "--origin", you could
> have updated your clone.defaultRemoteName, so the current value of
> the configuration variable is pretty much useless.  
> 

My idea was that its better to fall back to this as a default because
its an indication that the default is not "origin".

> Your "if there is only a single remote" would probably be a better
> way.  The only reason you are having trouble, if I am reading the
> repo_get_default_remote(), is because you are on a detached HEAD.
> Do we know where that HEAD was detached from, perhaps from the
> reflog?  If we are on a concrete branch, there already is a logic to
> figure out what branch from what remote it integrates with, and that
> would give you the most reliable answer.


It comes from the way git submodule update checks out the requested
commit in a detached HEAD state.

> 
>> Thoughts on what the best solution is here?
>>
>> I'm thinking the following:
>>
>> 1) check if there is only one remote, then use that
>> 2) check clone.defaultRemoteName and use that otherwise
>> 3) fall back to origin otherwise?
> 
> I'd insert 1.5 to figure out where your detached HEAD came from and
> use that as if you are on that branch.  That is the source of the
> problem, right?
> 

The issue is that the detached HEAD comes from the submodule update, and
may not actually be on any local branch. The parent project likely knows
based on its git modules, and we could actually maybe just look up the
remote based on its URL actually...

>> Perhaps we could insert a step 0 where we add a config option which will
>> have submodule clones use the given remote name + use that as the
>> default when in detached head state?
> 
> Going forward, it would of course be the most reliable if we wrote a
> distinct configuration variable in submodule repository when we
> activate it, i.e. when "git submodule update --init" clones, it can
> record the nickname that was used, so that none of the 1-3) above
> methods have to be used to guess what the name is.
> 

Yea, this is a good idea.

> Or, perhaps we can update "git submodule update --init" so that when
> it clones, it ignores clone.defaultRemoteName configuration, so that
> this codepath always can rely on the name being 'origin'.  If you
> are always accessing the submodule through the toplevel superproject,
> the name used in the submodule does not make a difference, no?
> 

True, but I often need to make PRs for projects from a submodule, and in
that case the github CLI likes to rename origin as "upstream" and make
"origin" be my fork. (Though I personally use "upstream" for the
upstream project and "fork" for the fork.) In both case, origin no
longer exists.

However, I had another thought while reading this:

the parent project already has a URL in its config. What if we updated
the logic to just directly use that URL instead of using a remote name?
Or at the very least, we try to pick a remote based on the URL.
