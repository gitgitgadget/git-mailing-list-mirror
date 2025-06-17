Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADF2F5316
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203982; cv=fail; b=BKzaTFAj/biL+9a0MCk25+r+FpJo0wHS3Lvr48N4K2walZG/mPpomyvRgDBp0eY78AG4IH6sYvKEcG8IokZwiWuUVZeNJr+wipbnm3W6oLkFUkIvs0ljeWYbxSqkzgHyruHLgEuVXoB8cJ9dMaqTrEmNRB1qoIMHeCgqMZUO6Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203982; c=relaxed/simple;
	bh=i021BKbyAWWzIyfrFqMCyp31u9VQ7k2eUjOE1aHCsTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtWtI4FLEXmkITVApMMnlWvtNaGiXJSKxZCzZaf88bNMU6VYXU68WLxwr5Woqnq7eCXUjXp3ptQKtw8I8U5l5sWz0SPBcjcwf9Vv/BOo3aeIomOIFl5Y0KYDzau11+6OJqxjbcVGTPZbDqV+XGINXn9cy4y7ZfzJRziJ/vKQXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6zHaOa3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6zHaOa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750203979; x=1781739979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i021BKbyAWWzIyfrFqMCyp31u9VQ7k2eUjOE1aHCsTQ=;
  b=X6zHaOa3LmG+6TIKkanFhw1mkgg68NQtteMXPStR4JXmStbEchcmK1Ri
   QVWGiY9FiPcP4g0wJAh4tg39bhjc2NxbgYBHIIlbKyLVbXg5xLzEqAJ6i
   1wEDhrmEBQB/Lckrn/86mRm9rb7gMUlXdGNicMpxX2VDTinc3+vpHVVE5
   O+zi6Hj792G8my2YDKL4rYTikSjpmID3yIsRigopzwTsZp8YMOdKl2bF0
   bbMZ2xjrf0xekQ/TJ4C4E21WjYbxt6doYR7olohyfRHpLYpwWsoy22Sj+
   ocm1NQT9J8hwnW+ILRIWGmmUe6egVTJNsPR6rkQtK4bfNSVaoYa8KkSt4
   w==;
X-CSE-ConnectionGUID: klU6PmA4TpGNZFaN6jg24A==
X-CSE-MsgGUID: w3jYu27HQn6kmPDk0k574A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52317205"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52317205"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:46:17 -0700
X-CSE-ConnectionGUID: mJiVPTTSRbSjczBaacZRrg==
X-CSE-MsgGUID: i+Mvra1GSKaTzn/SRAqXsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149386318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:46:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:46:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 16:46:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 16:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i99IYvi2TvNCMm68TFljHKnQ950FY8hJzv8cOMcrvL4lTejnMnspr+C+aCcDDYO1kwOw0zf56jTr5lW8fRv8bIG6sv86Tjq6FBbX0+LT3kO7Q+NJf+2nCIa70SkEVRpf2qkmaiKkSggMouz6N1vnGnMw9v/g4G4i4xgUhG+fe4RdnEm9AJmK/oKhk/FV+xLzUZzRmAfqKQ/U0XjHOwtUANJ/9yZhpdW/nfddDhbmolNM1osK16FJ3sizW6/HPhOfCCHD3+pVPbipxH/odGNNazPs5Cv7734gm1NYxYfQgzsknAxOI+0/+++c36zK+9sfH5a/DenPDPDiipmuBHUiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aF5ro55as8nBd1NWpiPKcOA9TfAxdl/gWf9jKkMmuA=;
 b=ba6Mt3N1apqKmLbVLCT3xf9lhQHWIiwTBK1+rmDuavKT+QuuS0fdjBPU99jSR+o+9wLWMbPkrW/EGeugDPd6EnRt5Z5jbEXs7WGnPNISW0tImr/E5ukBNbJPPzr6JIHEqUPRYJNKR/XQDGqb0I4exr4xln3dgSqKcSUVWeQla1/DTmOzzbR8GlBN17+1V9PNdyouRxnG/UuJ05mSaRrJmOMQDMoh78dS5Rzven/oK20duBAM/h0zfvsP8vinN60Gb3fAXd6jGPyFm636AYWHDLUYF3Yg6QAL/xEPDo4ykPzFXbC0Cgxxd1fLBOj8YGYEEVbmrx0h7r65eTFQXgKRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 23:46:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 23:46:01 +0000
Message-ID: <c61c0c6f-6d54-466b-9592-e4f3071ff7f0@intel.com>
Date: Tue, 17 Jun 2025 16:45:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and struct
 remote
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>, Lidong Yan
	<yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
 <xmqqcyb2uhth.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqcyb2uhth.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 994de824-34cd-4ad6-2b13-08ddadf91d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3NHek9TVVZFcFhBV09GTjc1bXhidHZ1RHFXSkJ0Yi96WnpDM09jaW0xK0pV?=
 =?utf-8?B?cVZ5c1lkYitKR0o5Mi95T2JWcUNtWUZidkEyanFkU1ZIdXdMUEhaMVZPcGZw?=
 =?utf-8?B?UzlEbW9KWkNrZmxzRDkyK3pNRm8vbW1EbFBVN0d3MUE3ajI3NWdPV3J3dVgr?=
 =?utf-8?B?Ymgxd1JyNFhYZkRXbDU3WWVYYk9DV3g0MitlQUZDTll4SmZ5dlB0MWZid2FX?=
 =?utf-8?B?cWsybE01ZlBPOVFtcnRsVGtCVjR3cTJmS0k0dEdXdHhROG5BbFY5eEtpNk9M?=
 =?utf-8?B?OFVncUFVSVF2RmpLZEozNFF5dFFHWFdtK1BTc3RvN2lFeENYNEJlLzZ3Q0x1?=
 =?utf-8?B?YzJzeUZ4L2ZZcE0wZmVlK3RXcktFT2tRNjVIWVROWmY1SS9DaG9kdURPZStD?=
 =?utf-8?B?Mm1vMUQ2dEp1VXVLOVdtbDhFRzFwZitXSzZxRG0zYWF0ampvOWNteldCUUxr?=
 =?utf-8?B?bU1scHBlRnpydEFXM2JhZVlnejJDQ2dTY1lVN1M0K0M4a0s2OTYvT3lEN2V2?=
 =?utf-8?B?Mnd0ZFRCUjlMMDFUVGx4Y1Q2WjhtVVZHZ0RsazdScFh5T0VGVDV4YVZ3UVhv?=
 =?utf-8?B?SVF6Ym5xK1YvZHdKWXloMHVyN0wwRzg3T3J5SHJyaEgxVVRkakM0ZEEvRXlN?=
 =?utf-8?B?Yi9tVUlSNTdMcm13TklmTkdWNUN4L2VFWVVpRk9rZGZhazd5eGNXVUdJSktT?=
 =?utf-8?B?cWNteHU2eVpOaEViSkNUU2FaVnp4dFZFY01FLzJBNEh2S0s0ZHFxbnZrNnI1?=
 =?utf-8?B?WWtzN2ZQZTgzWVBXd1dINW1PY05mNnI4RktaU1J5ZGhZcWlCa2s3WmQxU0Np?=
 =?utf-8?B?QkpaVHVDZFVNS3BVZWhkdGFsZHkyN2FDdjVUbGc2bkNmRjUxOUpWZnBidGIy?=
 =?utf-8?B?YUJ1dHFBMGg1WVN3UnQrMmpJVmZxY1V2V21XTk5aZVBsZ3hNemVIdjBtTDdr?=
 =?utf-8?B?YktZcG8yaXFrZ3NjMkFQUTk4NElCM1BuSndqZkxjOWE5VmtXKzNwRUVTV3pE?=
 =?utf-8?B?NG1uckJwSVp3MHNaUmllK0toQ2NVYWpMaU1RblJZYm56K1ZOdnp1ZHVsenQv?=
 =?utf-8?B?QXkxQWNXaGgyeWFQcWRlOVJrOUg3K1RDVzI4Z0swR2xPUUFtNUZCTUxBREhK?=
 =?utf-8?B?dTU1cHp1andKeFNqWGh0VFVyRXVQQVJ6OVVFTkdWQmpPNVdUMkJ3anRBVGM0?=
 =?utf-8?B?N0FBRDkxQ2pRUXF5b2gxcWNmdDliVUFyUlNXRG16SFNoeE1JOUxvUDZLUlJ3?=
 =?utf-8?B?U0FNMFB0UWZwT0hJSzZlOFVkeWhQaWlXRlFBUnBoMzB5U1lZUU5zVTdQU3Yx?=
 =?utf-8?B?VzZsN2RWaW9naytlellDTUdHcFVjWXVpRWlxelFqTU04VFN3UTJ0SFN1KzB2?=
 =?utf-8?B?VjlhQjl6VU9HWUJlRHR3bDFNK1RLc3pQdkUrQUV0M3lDTEh4a1ZENmlvK2Vw?=
 =?utf-8?B?enVvOTkzUFdJd0ZXL1VCVGRBWEV6a1BORmdPVm9Lc3FjcEZtWTNIUmlETmkw?=
 =?utf-8?B?WXBwbXJuUTRIbDJhbEovcFU2d0VJVzBGeW5yL0YxSjV6cVZvYUN2bmc5Z05u?=
 =?utf-8?B?SGdmaEF6SWtxVGVjSjFsd3BTQ1N3VXlmQUdJclFsWmVIeXkycVZSWENPczh0?=
 =?utf-8?B?YkJFMEliWWVVS2RVZW5vcml5clB4YmJoeE9lZzI1alplYUt6TmhMRkVQUzNN?=
 =?utf-8?B?MXFkSkhrR1BlcjlGQkZuRTJDOVV4TkVobzB5Rm1nTFFjUVoyZm4zK2ZZQW9N?=
 =?utf-8?B?UEQwYzg5Q0M2VUhsNlVhRHFPd3pZa1FFSzFRRmMxTlc3VHA3U3RJQzZlNjE3?=
 =?utf-8?B?QUlqcFZZemp6MU5uVTBlTEthU2VBQmtDUXpkZVdzTElNM1BZMmtOUVpiVVVm?=
 =?utf-8?B?cGVtQWZwc0NwNFRGSEdzeVU2VVFXVlRhREIyOGZLbC8yVlpiYlRZQWgvVGhC?=
 =?utf-8?Q?ptU82pbXpF4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdNS2NRUXhkMG91ME9acWRRZ1JKakJGY3lCVzE2SHlKRkQzRTZ1NjM5cmVF?=
 =?utf-8?B?dnlJTGJXT09memZCanVpbEdWYndsUEZ2QXg2TlM0cVVwNFNuNGRsSmV5ZEdp?=
 =?utf-8?B?ZzNGYytzcXg1TFg1Q255Qm0xbUhzNnBJSUV4TXRnVzhKa3pXWElvLzg4ZDl0?=
 =?utf-8?B?bktuUWVUcW8zdGphWml1RmpEL3V2bURqN0lNUGtqMnpvcGQvV1JvQTdKaDhq?=
 =?utf-8?B?QnlCcnkvaGE4ZmJzMSsyRGdYQWR6L3YzMmZLcWJwMHpoMHZuelRsaVVlcWVI?=
 =?utf-8?B?UFZsQTRYQWRiRi9QQTZJRFI0amhQVjVXamUydktSSU82S05LME1ZQTk4R0Ix?=
 =?utf-8?B?ODNoRkVNTEloNDhsd3RBUmtWYWVLZTlhSGhENmJ5NHRUL3VZVXV3Q0Naamp5?=
 =?utf-8?B?UklFV2lnb0UvL00rZkdQZWxuaGZjd01XbHFhaDMrQ3JkaHllUUVPU3QySTMr?=
 =?utf-8?B?NVpoSklFSHdNaFpkaXFjTmpDc0lRSEVqb1N1Z2RSVERMcWNtQ0wzN2NOSzJl?=
 =?utf-8?B?SlRrSzEwV1V0bVYwd0txMmliL25RSXlCWlRUNTFZbGhLaXJ4b2lITlZxTWlQ?=
 =?utf-8?B?UjRFSmRjR0dVUnIycFArTjRSSW1ZUXlnWkVrQWM3QWhQYTZYb0hCZWdaWGxG?=
 =?utf-8?B?bFV4SC9ieUNlTmpsUGdpZjRPbTBKMFFHMnl3YThxVS8yYjNTcEVhaXUrSXNk?=
 =?utf-8?B?UXRaRVh6aXM1bTF3cTJ5ZGN4eTBzK3hlOFRTMVBGLzFReStUMDFOdXFaVUZa?=
 =?utf-8?B?bUZGL2tSd1FlRDBZTVB5UGpiSENUa0ZlaTE1VWR0VUlSeXBGQnF2R1pjcEZ2?=
 =?utf-8?B?MTZlYWRBVGsrNjlsYy9oS3k2eGl5VFJ4NGFSaXdBVE1tWE5kMFhUakc3UXhI?=
 =?utf-8?B?Z2NxTkVHR0JhRHFaR1UwRUwwS08wWURBTGVRQU1hWUhIRDVPdUEvZnpaRXkw?=
 =?utf-8?B?cXBkQkJpSVgzMGtRcVJseHZ4ZmNvTTE0akp3MUNjOThRK1NJRjlybzgzZlMy?=
 =?utf-8?B?ZWpWRUdOblJwSm9iakRuVUpPMDdEMDhoWDh4aDVCWmIzdWJ0L0RSTWNXeTZN?=
 =?utf-8?B?ZEV6NHB1MldsNHhNSkwxbjhXRXJwNVhPNGs1am1MMVNKd3V6akkyVjdZSS9K?=
 =?utf-8?B?dnhpMzBuck94NVo1Rlp6dk1NSnVIcWJVbUxTNzlpK1F0dXUvdGlpVFl1RVVZ?=
 =?utf-8?B?YUN2WFpaNzhlcis0ejR5dXkrSW1vRXVWLzJCSVdwRWNsVTkzNzdaRDlKWS91?=
 =?utf-8?B?dHRrbnRVZm5mN2s1NldyVUg0TlhrYTFIRmt0TkxPNS90ZHczYnRSYVd6c2kz?=
 =?utf-8?B?QWkrd0VHSE40SjhIZm9Wb0l0VjZ3N2pHemo5ckdvU2UwTXRyOFFoTlAxNmdN?=
 =?utf-8?B?Z3I2MVZEc3c2YjZBRE9GaC9IV2htaGhibUNqNU9XQUFiRWpXUkFWR21HZSth?=
 =?utf-8?B?YVROUmVCRWFHSExwTEdYODdMWitMcVIrbEp3OVI5UjJVQlZXWXgzajZjTGVr?=
 =?utf-8?B?ZzBhTXVPS2cxbnpYQkNWdHNLc1l2M081N1Y2Sm1uRm1SZXo4aDJ4eUlReEN0?=
 =?utf-8?B?N2RPQjJOenNkM05MRFRtVzF5MWRicS9zOE1VVU0wcmxiMit4dGlMWjJZNlho?=
 =?utf-8?B?dnFCV0pyZlRHRWIwNkZUcmN1akJjQkpIc0gzaEVsZ0tSb1NYSnpjVXYwOHBq?=
 =?utf-8?B?ZjYwY1NzVHpPTlp5ajhpekliWGkrOW9mMUZIK1FiQ0l1WGxiTE41N0tZVWxV?=
 =?utf-8?B?cng3VkFOQWVxSzlKeDBWUjAyWHRQQURxOHBZS2svKzlOaVRlZW01dmJ6UkJV?=
 =?utf-8?B?YVVaV1VGQnF5c2R6dmZyVFJjK0IxU01pd0R5azlOYkFlMlJOcW5FSmVqVHIx?=
 =?utf-8?B?ZnZLVkJxb3FQOTZ3MG1VUDVscFZFazFDSVRLb3JPNC9ZVWl5WTBqaGQrWlRY?=
 =?utf-8?B?ZkkyV09MMWExVUduZWdjZm8rbmhDWnVxUzNNazduUUxKR2k1K2UvTjR2aE5B?=
 =?utf-8?B?Mmo1K0tVTVV6R1dUZ2RzOVV0ZFNkWk56bGRNN1ErSUhVUVNkWkJZTm9GWFps?=
 =?utf-8?B?dVEzUnNuOEVJdjZtYk56NmVQUEhwci9OYVBkY0w5RGNpeDRwQXZNVzlPSVBV?=
 =?utf-8?B?ZFZCcWtWZlV1V3ZpNFRTMmgrWmNXalVxcndnMkYvYmVxNXBKa2lXaXNXOHlP?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 994de824-34cd-4ad6-2b13-08ddadf91d82
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:46:01.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0S9OuXoAIvz8Egc5KMlG0DObt2J4iLmZDb2REjDOs7WrpEoU4+upaMPmnygWh8/h3Epz3HJQnUNg+HghGgdKUGoU6iMUpzxqHMNxp+ccbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
X-OriginatorOrg: intel.com



On 6/17/2025 3:25 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
> 
> where we iterate over branch->merge[] and branch->merge_name[]
> for branch->nr times and each time we check the NULL-ness of these
> two pointers.
> 
> merge_nr is only incremented inside add_merge() when merge_name[]
> array is grown by the same amount.  Do we need to check for the
> NULL-ness of branch->merge_name?
> 
> Near the beginning of set_merge() we allocate branch->merge[] 
> only when branch->merge_nr is non-zero (the assumption seems to be
> that we accumulate in the merge_names[] while reading the config,
> so as long as branch->merge is initialized properly to NULL, it will
> never be NULL if merge_nr is not 0, no?
> 
> Thanks.

Perhaps something like this might be a better solution so that we don't
need to worry about merge being NULL and tracking the difference between
merge_name and merge. Its a bit ugly still with a partially initialized
refspec_item so I am not 100% sure but I think this is overall a bit
better than the current situation:

> diff --git i/remote.h w/remote.h
> index 59033d5d82dd..0ca399e1835b 100644
> --- i/remote.h
> +++ w/remote.h
> @@ -316,8 +316,8 @@ struct branch {
> 
>         char *pushremote_name;
> 
> -       /* An array of the "merge" lines in the configuration. */
> -       char **merge_name;
> +       /* True if set_merge() has been called to finalize the merge array */
> +       int set_merge;
> 
>         /**
>          * An array of the struct refspecs used for the merge lines. That is,
> diff --git i/branch.c w/branch.c
> index 6d01d7d6bdb2..93f5b4e8dd9f 100644
> --- i/branch.c
> +++ w/branch.c
> @@ -230,7 +230,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
>                 return -1;
>         }
> 
> -       if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
> +       if (branch->merge_nr < 1 || !branch->merge || !branch->merge[0] || !branch->merge[0]->src) {
>                 warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
>                         bare_ref);
>                 return -1;
> @@ -238,7 +238,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
> 
>         tracking->remote = branch->remote_name;
>         for (i = 0; i < branch->merge_nr; i++)
> -               string_list_append(tracking->srcs, branch->merge_name[i]);
> +               string_list_append(tracking->srcs, branch->merge[i]->src);
>         return 0;
>  }
> 
> diff --git i/builtin/pull.c w/builtin/pull.c
> index a1ebc6ad3328..f4556ae155ce 100644
> --- i/builtin/pull.c
> +++ w/builtin/pull.c
> @@ -487,7 +487,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>         } else
>                 fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
>                         "from the remote, but no such ref was fetched."),
> -                       *curr_branch->merge_name);
> +                       curr_branch->merge[0]->src);
>         exit(1);
>  }
> 
> diff --git i/remote.c w/remote.c
> index 706c25af0c27..1850e8fa4e42 100644
> --- i/remote.c
> +++ w/remote.c
> @@ -177,9 +177,15 @@ static void remote_clear(struct remote *remote)
> 
>  static void add_merge(struct branch *branch, const char *name)
>  {
> -       ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
> +       struct refspec_item *merge;
> +
> +       ALLOC_GROW(branch->merge, branch->merge_nr + 1,
>                    branch->merge_alloc);
> -       branch->merge_name[branch->merge_nr++] = xstrdup(name);
> +
> +       merge = xcalloc(1, sizeof(*merge));
> +       merge->src = xstrdup(name);
> +
> +       branch->merge[branch->merge_nr++] = merge;
>  }
> 
>  struct branches_hash_key {
> @@ -250,22 +256,23 @@ static struct branch *make_branch(struct remote_state *remote_state,
>         return ret;
>  }
> 
> +static void merge_clear(struct branch *branch)
> +{
> +       for (int i = 0; i < branch->merge_nr; i++) {
> +               refspec_item_clear(branch->merge[i]);
> +               free(branch->merge[i]);
> +       }
> +       free(branch->merge);
> +       branch->merge_nr = 0;
> +}
> +
>  static void branch_release(struct branch *branch)
>  {
>         free((char *)branch->name);
>         free((char *)branch->refname);
>         free(branch->remote_name);
>         free(branch->pushremote_name);
> -       for (int i = 0; i < branch->merge_nr; i++) {
> -               if (branch->merge) {
> -                       refspec_item_clear(branch->merge[i]);
> -                       free(branch->merge[i]);
> -               }
> -               if (branch->merge_name)
> -                       free(branch->merge_name[i]);
> -       }
> -       free(branch->merge);
> -       free(branch->merge_name);
> +       merge_clear(branch);
>  }
> 
>  static struct rewrite *make_rewrite(struct rewrites *r,
> @@ -700,7 +707,7 @@ char *remote_ref_for_branch(struct branch *branch, int for_push)
>         if (branch) {
>                 if (!for_push) {
>                         if (branch->merge_nr) {
> -                               return xstrdup(branch->merge_name[0]);
> +                               return xstrdup(branch->merge[0]->src);
>                         }
>                 } else {
>                         char *dst;
> @@ -1738,32 +1745,30 @@ static void set_merge(struct repository *repo, struct branch *ret)
> 
>         if (!ret)
>                 return; /* no branch */
> -       if (ret->merge)
> +       if (ret->set_merge)
>                 return; /* already run */
>         if (!ret->remote_name || !ret->merge_nr) {
>                 /*
>                  * no merge config; let's make sure we don't confuse callers
>                  * with a non-zero merge_nr but a NULL merge
>                  */
> -               ret->merge_nr = 0;
> +               merge_clear(ret);
>                 return;
>         }
> +       ret->set_merge = 1;
> 
>         remote = remotes_remote_get(repo, ret->remote_name);
> 
> -       CALLOC_ARRAY(ret->merge, ret->merge_nr);
>         for (i = 0; i < ret->merge_nr; i++) {
> -               ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
> -               ret->merge[i]->src = xstrdup(ret->merge_name[i]);
>                 if (!remote_find_tracking(remote, ret->merge[i]) ||
>                     strcmp(ret->remote_name, "."))
>                         continue;
> -               if (repo_dwim_ref(repo, ret->merge_name[i],
> -                                 strlen(ret->merge_name[i]), &oid, &ref,
> +               if (repo_dwim_ref(repo, ret->merge[i]->src,
> +                                 strlen(ret->merge[i]->src), &oid, &ref,
>                                   0) == 1)
>                         ret->merge[i]->dst = ref;
>                 else
> -                       ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
> +                       ret->merge[i]->dst = xstrdup(ret->merge[i]->src);
>         }
>  }
> 


