Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C78C0B
	for <git@vger.kernel.org>; Fri, 23 May 2025 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043525; cv=fail; b=IvwjYw13qBmoJ6uLqJZ0mkWmXvG0SFZjhgwcjaEPCJ4eY9y7JQ7jx34ppja/rKfe4kFj7mFG+PfH6+CNrbboMUKjTVdDdX0vixYitxy/PorMHuZYjwCD/TRQBVkvYJhuOguFvwcGe4H/q4v6rdbJ5o963iaqwkaz2OGPlIpKWJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043525; c=relaxed/simple;
	bh=2UdcIg5rkGnjHze6GnNR2F/TgwFgwsqwPkI7OUySFFU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpCrJns5+vvo/YqhtsvukOR/d0VuSTHAyvrkmX+TW/AZc60fT3Vdmh/pMfIiSNX2x17oaUowoPqmEEC3BTULZzPBK/yCbPqT2FapBxcRQXpcXchIRS6QCOfbcuFTGpDIpmIe5L5LLa4RwOXMgNBTI1jDg7hNa/pjrXGXU4449hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2GnREvv; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2GnREvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748043524; x=1779579524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2UdcIg5rkGnjHze6GnNR2F/TgwFgwsqwPkI7OUySFFU=;
  b=X2GnREvvB1ahWoRYaztDMCo+paoI2Ji+OUfBa+0rvQU+AAir6YoI1myv
   InWfyfeoxe23O5hhynAXg4m94u3CXAq6CQ+rcCl/8RV+ztc+24H2kXbz9
   rSja7B70bC+r3DujqWLkxxC76st21fF9vkGAukGudj7Ik9sQgAVvFvsFd
   lCT34TUY4Xpg9foqEf2dyiB7z5q0pFGefjFH9cz0QBQgZeww+nazX5Gl1
   fyh2GMURCc+i3R7pvSACYjuvmILBFEPKR6SMs1x7n5kjCA0K1Tzi1plOc
   N4s4iHgGBDp0Apa3uEmOJbBr4ndeYgOqcF7TEMi00zdGz2XYyS+4MY/oj
   g==;
X-CSE-ConnectionGUID: H2Y57e3dSZOR+zki5W0Crg==
X-CSE-MsgGUID: BKRaucOYRVqEZRb99pHXnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49225212"
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="49225212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 16:38:43 -0700
X-CSE-ConnectionGUID: ZkUTAOfQSWegeByKIzuqzA==
X-CSE-MsgGUID: Vo8J+3VcTG+CJTLVJvJ8lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="141406308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 16:38:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 16:38:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 16:38:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.41)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 16:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHbmwKhS7QfJn0g7LiEqOvGPWQ50i3UrsRlfcRqo8TuBf/BzhZPxDeQDKEpvXQ8x7xrmC7lDSgzqxB7Ikbo3J/5WdMq1mC1SAh/VZKFva7p8w4BmQ18P+VvHmmcu32oxnKChJZAwOFKpIyzsdfgjxQ0ihCZrxTcl3FXIF7/nJnEq1xcb6PWjpWysQ+pd9ZOOkdJus9Kb4gf+/TTIBzN7Z5dWFadFbVtDGHTaLpJ3hNiKrqRNO83LInUolI8VN/n2B/uSpRAunpuzJAmB8U8h8AUq2cIweC/R0fFSqOfJ7zMi6zJ4U9eFoKQpi9MQGrv1/pTCNz9kjdtgzVAOyOf33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYbms5qvzXq+8CDRoOEf8GtIR7B55zFAjfhk7WApksM=;
 b=zFWpUOE4DbZxrBcpOEhyR3Fld5j/GJv1tTP/itbmwkc1b8jIo/Wpsz6C6FXIWLQr6/GchUE8WpUJzj3o9q0lkHGYMcSzAA885MuiiDkk9U3hezNjrAq+2b9hU6itP8R33DEp/wZZcuOz74czMXCE00hCv8xRfYj4iqOvSaJ57C7sAGXyeM2dY+XZJ8NF+C3VYvtc+fMtAggzGL6VRvzJSU663bFDCwc4qT/BMYzRtkn4iSs4A/0F+IP0F7IZloqeI/rNccHVh+evxSy+XHjzrdfTaewOjUoNOArqZmXnWOCph5ac9Ino2lC4QXwSdd7ZB4doxtQJn2GpemdmJKlCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 23 May
 2025 23:37:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%6]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 23:37:54 +0000
Message-ID: <4dbb0dc7-52ef-4ffe-9215-de94fb448234@intel.com>
Date: Fri, 23 May 2025 16:37:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
To: Aditya Garg <gargaditya08@live.com>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>
References: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8622d3-ae37-4303-2f46-08dd9a52d70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b08rcHNzREZDMkpjMGNuTWFUNU9oWDV5d1pnUGRtTmV1NEpGelVWdGJJMFYx?=
 =?utf-8?B?b2tRb015Nks5R0JIUFlORnVOSk1vK3g4cERwRHFQbzJPNjRmSUp3VTJYcDBr?=
 =?utf-8?B?dk5Rb3lvSy9IU3lFaEN1K3pqY28ycDRKSnNoOGxqR0R3WW1tb3dVWDQxRmpK?=
 =?utf-8?B?SEVTaXk4TGUrYlYydTloWVZQbUpMYVFhazIwVm0vaWpwREdHVnRjOCtNTWtL?=
 =?utf-8?B?V1VpVm9rcFRTWFFmNzhSdjBPNFlRb0VURi9sclJkTDJsdE5TUlpUQnJoc0dZ?=
 =?utf-8?B?VFc1dWhIMkZ5VW9rcXkyYmVGMjY1Vk5RMmdNR3VrbFMyclJuS1p1elNZUzVo?=
 =?utf-8?B?blhwNzBYdSs2QjVyUlRGWEJxSFZENEJHeDh6VzdIWlZxRS9QWmxpZGJLN25B?=
 =?utf-8?B?VEpNQWI2S2ZUTkZLVkFhY01jaFREVEdlTnV2cDhrS1hrbk9PYW1OU3czM2hJ?=
 =?utf-8?B?RGZxajR2ZVFCd2F1eEhGT3FQWUI3TVhVSnBFOGNzS1lZWjR6NHA2YWZ1aWZy?=
 =?utf-8?B?dGlRc213VU9PdTRiTWI2MlhpbTdEQjlNSVZDSDg3NmY0QmdSUDJQOTc4VXV2?=
 =?utf-8?B?UGhJZjMvNE1maTA4a2h4cHRmR0JPRXphTCt1a2E0Wm0wSHM2ZlhleVoxQ09U?=
 =?utf-8?B?cm1Kcm4veWEvTEtQOGZXSlhFbmorZGRPSUtHUDhhci9hWmV4dlV3b01Zc0hE?=
 =?utf-8?B?c2JXYVQvdDl4bzdjUVEwNmNRd2NmVHJHaUdVQkx0Q0JWSFEwZEp6aWVLemx3?=
 =?utf-8?B?cU9PRWdETGtLRFZ4dWhOWGdNNFdOdVBjRXNWVVlzMEZIY1NCdVU5V3ByYnI2?=
 =?utf-8?B?Z0QvRXpqWkJyNW9GWWZHazYrLzY5dWd6dkVuVzBkdktYdVZwZTZHbHFmU0Rv?=
 =?utf-8?B?QUhsa3pkQVg4V1RWdC9hTWZJYjd3dzg0MUFwdTI2UjhVZUFvMmlZMzdhZzlR?=
 =?utf-8?B?UzgybmttcnM1WEZSdTAzSU1lZ2hnV2pBa1B6L1NoNWppYldXSWVNNDFBSXVj?=
 =?utf-8?B?NHdsUW5iSzQ0RDNodUtGcktRNk1KNHBtQUtpcG1xL3BhNy9ocGZ2TnA3cm41?=
 =?utf-8?B?Uk9oSVZteVVQb2RTbTgrL2haTWRhdmZvVTFIMmExYVNpZEYvbWVUdmZqSUlw?=
 =?utf-8?B?RUtURkJScXNPWVhlaXcxeU5tblNxVWpDYWFRKzVwRXRneE1oSk0ySTFnM1Y5?=
 =?utf-8?B?M2pwN3JRaE94eVE5NGp4YlZ1NDJzVTVsVUxwRWtKd3doOUhGM0YzRDYxdUlW?=
 =?utf-8?B?NnlXQ05ZQU1aN2tjSktiNWI2Mzhia0hPQ0tJUjVaa0pVRzZkNCtJY0dvQnp1?=
 =?utf-8?B?Z1J6OURGN0ErSHN6eHZvQjRPS0pISE9OMWJ2L3lnWnVKQW1xNTlhZ1BxN1kv?=
 =?utf-8?B?dVhCdk14S09DRlRESkJsQWpTUUE5MWJXUHpMZFZhV212UHYzZkZTQTl6NTBC?=
 =?utf-8?B?L0laQVlJNlRmMW1PRWI5U3RmSlh4QmkvVUM2eklTWWpkaXZWRWhMTFY5d2ty?=
 =?utf-8?B?V2ZLYTA1bmhvTlhxZ21pTkZQNzJKSEpKc0I1OGFPOFRiZkRjb01penhXdTZl?=
 =?utf-8?B?NUdDVHE0VjNyU0FJc2JlcW9zSmlpNlV0anhwR1hXaDE1TXQ2T3N6SDV5Kzgy?=
 =?utf-8?B?b3ZDSEE2Vlc3SE9ESTZ4ZzZOYks0U1RjQ2hySlpieW1sQ0k2c3JOWXg1eFFn?=
 =?utf-8?B?NUZBSVVGTWl1eWZ3b1dGNnVzVC9IaitoZmIwSjFtMktZUmZ6aG1UZWV2clVG?=
 =?utf-8?B?WER6OHVZUllLU1huSVFTZUo1ZVliT2RDZXNOVVRGU294QTRrNDlCazgxTG1Q?=
 =?utf-8?B?NnA3aFYvdFY4MjVDdnBITi8xUitWVUdHL09IS2NwVXh6RWRYOEo4TWE2cWZH?=
 =?utf-8?B?WU5YWU1tcmRuQWRXeUNCT1N4cmpWbGlmMkdmOXZVcVFGcE9vME9kVkw2RXB3?=
 =?utf-8?Q?Y5YdREr1sxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdhYU9NRU5SdTNuYnJVUXNoeHE1OHZIZ3k4akZlUjV0OFNTUDVaNC9rdkEw?=
 =?utf-8?B?eUpVZjBmWFFSZUdYc2NQb3hweWp6dXZ5SVdvUVJFRDVYazZLQmdRK0cwWlFC?=
 =?utf-8?B?ZHJRbFBIc2pNbTNiWDd4aGVUMFpzS1dXSU1BT1BFTVVEdTBXMGxhUkFiN2RX?=
 =?utf-8?B?OXFxMGxhbGk3bEVxTG1PbGhjbmZUeGJDc1lBbVAxRFpwb1pXOTVWZVUwK01C?=
 =?utf-8?B?WW16YmU5TCswQTVreWFXRWdBbXU4Z092OWN3bkZPMjZlemF4MWNCaDZLZkVq?=
 =?utf-8?B?MURBOUNkL3RjL2ExejJoTitMN0lSSzFFd2lVeHdoWERzbDRCWVN6QUNKbU1i?=
 =?utf-8?B?TjhJYTRYK2JTODV4UzkxWUNvM2ZyTHdhRzhPVnY1WDdDSWplaDN5MklLSk4z?=
 =?utf-8?B?VWxxN3lHa2FBaEtSUDlWNUZnaHNqY2pneXdjUGk5L3JJUGVPL3diaUlhbWxj?=
 =?utf-8?B?NXFXdlhFTEV0YnpkM3dYZEhiam1KTXoxVzU2aHZMdE1wK1JUa01IdzdBaG9U?=
 =?utf-8?B?eTVUVTFVTk5XTFZ5WEV5d3l2c25VdDBEbWVCcHpJQVlocUg5OURrRys3ZUZv?=
 =?utf-8?B?dDBvdExWaUF6a0pBM2ovbUNOdG03N0dZT3FVZmI1cUNGMTVhaGs1a0ltMEpV?=
 =?utf-8?B?UEtmOE91YVNSb1pBSzB0eWR6MzBBY3lrWWFucTdVYy9LZ05nYnBKM1lMTzEv?=
 =?utf-8?B?YytrWFdaeG5LaEt3TUEzWVZhTWdTcm5zVmZqVTF2a2paZkxRaEQ4ZzFrMnRU?=
 =?utf-8?B?eGxrTHp1M2ZIdmFyaTV0a3ZmZHovNWFTREdldDBBZGdEYnBlZnRuODh2emhL?=
 =?utf-8?B?dGpEV0VRN2tjckR0Z1lmdHM0SDBXWjdOWUx2THd0SlhwRGErVmpWSFd2RGIy?=
 =?utf-8?B?RFhUSWJqSkI5REdwcGNCMytwQ0tuZGM3OWhkWHZmRk9nekoraFF4OW9JVU94?=
 =?utf-8?B?djBTbXFyQzVRd1VhNno5VkpMb3pnUVlvdmptTEVEdUo5SmtRNGtVcENHTXlG?=
 =?utf-8?B?MDNlMEJJSmxxTGV3Q29vTkxuZEF3NXo5SWhCQ1I5ODNoUTQwQkVDL0tuRWlz?=
 =?utf-8?B?Z0RZTXM2VnExVVFxaVdaRjZJRkFzOXdqTzBBTDdYOFkxWWlUeENzYUl4TDA3?=
 =?utf-8?B?aERubFlqMGNHemg4VGlkcEY2OG9HMnN0Ujh5ZXFpUitVR3hOdjZhU2FaWE9K?=
 =?utf-8?B?SkR4bUVxbjlsMWJTRG9JWi9rdUtUZGN2TmdvcDNXRTBaejFRaHNHdmNkUHls?=
 =?utf-8?B?dUhPeUdnaWFpYlNMb290NFpmQmh4TXRGaDVKM3Z3L1N6bG1GTzMvQXJSeFRY?=
 =?utf-8?B?WEVDVTZsZEplSys2Y1kvc21FdTFQMkdQSVZWYzc4SlVnZlJVRElRMkFacHZ5?=
 =?utf-8?B?cUE4V051M2Q4TkhBeFZEV0RlaEpsaTVML2dQNGJWYzlZYzBlekxXQXNBWC9K?=
 =?utf-8?B?NUF3YURiaUF3MjFIbFdZZ201L1M1RjREMFVkeTJ0S3VmRERUOEZXMzc2dWs1?=
 =?utf-8?B?TjlISWtpcEFlSmhFWVVQY01KaWtDY2RqNkQ3N0liR2d4Z1ozR0s3NmNHR0py?=
 =?utf-8?B?UmNkRVRUTGE3aU92MGdadUJRbFc4aWhUaHplei9HRXB2V1Jsa1V6Um1xQTYr?=
 =?utf-8?B?YnpaVU5MeG9GSk9QRDdYRXl2ZkJiYlgzMXYvM0t2WVMwQ2VjL3FDQVpBS04z?=
 =?utf-8?B?RUJWOXNoT2daTmlTU3h6YU0vVFROKzBxYnZoWEx4eWdNR0FncGYzTGhPSit3?=
 =?utf-8?B?bzZreFNibXNINVVWcWVvTCswcWN4ak5UVVJvb1dqSG9IUlNCK05kZitDVzhy?=
 =?utf-8?B?ZzNpZ3BVcjQzREJmY3g2VkIzakZSYXJDZUJRWWhvWnlPVjErN0YvL3haNjZK?=
 =?utf-8?B?K043OWRpdHJidGhWam1BWDA4UWhLQ2tYM3lzNGFRVEV1bVowUDMzenJZN3N6?=
 =?utf-8?B?VlIremxVaHV6RVVYbHQ2dDdRdG1IZXVDdUJPQVY5WkFZTTk3WHVNcDhmaXNN?=
 =?utf-8?B?V1hDOUVwdE9wVVpHOGEwR09GL0o2TXlwQW9jUGZQWTViWXVZa2Rpc3pLZ1ow?=
 =?utf-8?B?V1N4M2VCNENhRTd6Sk5rMjFmN1hNVDNmTFZxa2ZHaWdhRy9NZElycTM0b0tJ?=
 =?utf-8?B?OWtINmFPWTN5bkFtQi83Y3hkK2Q1cEdlTEFiU1pxaXV3ZHN2QjI3dHlMOTFR?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8622d3-ae37-4303-2f46-08dd9a52d70d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 23:37:54.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4ec7ll/VOyGODh997QDNbpXg8ej6xlvzWkovOixSF2cDIC9j8g+ZVmA0N3Lz8lXomWBotp3xbMSlbNPiAQS98wgqCYM5tX3Awcj6TSBtx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com



On 5/23/2025 8:36 AM, Aditya Garg wrote:
> There is a bug in send-email that turns off shallow threading if
> some special conditions are there. Those conditions are:
> 
> 1. An --in-reply-to must be specified when sending the patch
> 2. When asked for confirmation before sending the first patch, the
>   user must edit the patch (pressing e and enter).
> 
> If these two conditions are fulfilled, the threading will turn off
> and all subsequent messages will become as replies to the
> Message-ID set in --in-reply-to, rather than becoming replies to
> the first patch.
> 
> The cause of this bug was very simple. There are many conditions
> that determine whether threading should be done or not. The
> relevant ones for this case are:
> 
> 1. --in-reply-to is not defined
> 2. $message_num is 1
> 
> If ANY ONE of these is fulfilled, threading will occur. Now, in
> our case, we have defined an --in-reply-to, so condition 1 is
> not fulfilled, and thus is omitted out. The only condition that
> can enable threading is $message_num being 1. As far as I
> understand, this condition was based on the assumption that the
> first message being send will have $message_num as 1, since in
> case of shallow threads, we just set in-reply-to only for the
> Message-ID of the first patch sent. But, in case we edit a patch,
> its $message_num increases by one, and thus, our second condition
> for threading is also not fulfilled, thus turning off threading.
> 

Why does editing a message change the message_num??? That feels like the
real bug to me..

> Luckily, the script also keeps count of the number of messages
> actually sent using the $num_sent variable. This was implemented
> for people who have set a particular batch size for emails. This
> is a more reliable indicator to track the actual first patch.
> 
> So, whenever the first patch is sent, $num_sent will become 1.
> If we replace the condition to use threading from $message_num
> to $num_sent=1, it will always be fulfilled irrespective of
> whether the user edits the first patch or not, and thus threading
> will turn on.
> 

Just from reading the commit message, this smells like a hack or
workaround to me.

I don't fully understand the logic in place as-is, and I think using
num_sent is a bit of a weird way to resolve this.
