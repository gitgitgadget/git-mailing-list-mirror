Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95C13D539
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162871; cv=fail; b=N87cYVxKzA+ZnhbnHDtz+R8EfsEzGLKT0owc+pxSi88b5YfMKhny7kouJcwFJrKCeA4gFN+mraxdVxmiEb0FM1XNPIsI3Pq456V4PQSEXhu7cmzdV0sAtuLtm6J1yoEhhFsGXfRB2O13MeZwlhpCao1HA/slE2rJSZr1qxxXTrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162871; c=relaxed/simple;
	bh=sJJUsO3JocBPR8VnRtbBsssb11SbFJfVIyds2eAhFbE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbD+wxqXiXoEz6pJBI+UocxQ8Ec1OKxLTTWWNUbS7EP2XBpGr6dDQaMtwGt+L8Rm4154cMunAIWILIdjWe+ho1uVVBg+3HKqKuWvqPKJmRVxKQ11pMiMVFA4iqwD61531nFOK/q049hUNVzhAfO1eiMt37Mhyad2CirqEvum3cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnUR5ePu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnUR5ePu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752162870; x=1783698870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=sJJUsO3JocBPR8VnRtbBsssb11SbFJfVIyds2eAhFbE=;
  b=dnUR5ePu5/BJiCV+5Ohkt8cTjrgeWvTtE2huvqBP6LC8OWySeaJF1nJs
   FzKjEiQ4eGWpHe+I8DPlpnUbf9pYm4cXA5BQCNfT+nV3bgr8056UQXALA
   j3aQhGXJZqWHtHRQm4dMR7+9Dyhf9IBfjSAE96zauIBJVgDlUMAJ9WJvp
   SG8OdZ1J88q61kWJ2jLx65C1Kleya5sMKyrNeLoZae5kmL3GbAHAx+ZY2
   XUuAI0t00zNGBzJwUZP8kHFGwcGCvzMMEvJI33/nu7WJslZx2xMBEOOXM
   wqc0ZmYVFTt4NmIdjKb5yIGuPkSLwnyV7jciUHbFtHEm0oST1Gsjw2tB5
   Q==;
X-CSE-ConnectionGUID: NROQ5WJkTDKsvufYmiYWPA==
X-CSE-MsgGUID: zoXBx7jMSf64NNN5g8lnhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71899080"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="71899080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:54:24 -0700
X-CSE-ConnectionGUID: aJKRZkNtRHCIRmIFKpYSIA==
X-CSE-MsgGUID: vbvK/ij3SheMCBtxj3/ehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="160686209"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:54:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:54:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:54:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmUr0JwqkB0ixLA9AFMiceAipuccgZrJP0KrStT6Q0zaPYn+TsxmFYGgKrZp3Oqb9B3YiRn3PcP+IjGOgMJ3EFx9u9Otj3+St1J5+wgCQgEn/yUfCX0ZiCKmxaw8MDpj5cC4cEf/tKjWJumEUivzH0WMMpzI5ZyAnQuy1sqB8Kd/DVNzNhKss2HSaZPi4EakDO+tb0kni4TB0g0GqLDoIwF1vVKvf0ODq7YF9etWOoRmrOBc+2C8xH6GilBzQBgX5RQAXLyrBy9gMkCU18rC/FZseg/piTEi7ffuH8Vbd9661CIHry8eieMPtUj2ORbnfgE7PHZWfHcywMtc5y0yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMBuYl3MM8bQCjG1VxcxYfw2S6XzGjdeMb89StqDUQo=;
 b=bAdYjh4bU83+Vb3giYSr7A5qBGiYfKLzxvzu0sjUX0lDUIwmrrYZMCCTAgu26pTgFbaUajSyUQkdivzr3GygARsfAyOlrUiBKfoqdevE49T6MdoWmz6Defsmj3yG7UPKClKn5qyrB1JdUA3QRClByPFLSbitLwvE87xK/uL9vxayNLEdYIPVeDClhw4UYh6ecyqE4ejdcq3NeS/gAQeV2CYmgkD+WOVVnDHdnsMkwL5kU1qCtm4OHBuYcbaIgHCucd51LJyDHPH1Ywgh4p5oexrR9r//QtPid/iQZSkGyLHcIrSJ6af9s2oUldkV6hhlgp61C0ARtUJr3uVzdP2Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7995.namprd11.prod.outlook.com (2603:10b6:806:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:54:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:54:02 +0000
Message-ID: <6fa10a33-7434-434a-9ef3-02fbaf21e1e1@intel.com>
Date: Thu, 10 Jul 2025 08:54:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] reflog: close leak of reflog expire entry
To: Jeff King <peff@peff.net>, Lidong Yan <yldhome2d2@gmail.com>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
 <D34FE2DE-EE5B-43F3-A706-1AC133AA72F1@gmail.com>
 <20250710034241.GA2057509@coredump.intra.peff.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250710034241.GA2057509@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------45wlz403h4yj5I0cS8qCS3D7"
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: ee49eb44-da1a-4f18-dbca-08ddbfc9fdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2tDTlREMmRNaytBcVg3K2RVM0NJR0I2QVFtcUVlYktxeXJwSXRMdTJhN01X?=
 =?utf-8?B?enE4SzlITVhhT2VPQmU5bitlQmk0cGZhRElxdHIzTnRBUFppYXU2eitPVy9F?=
 =?utf-8?B?LzY0cUlWNnhZTlFVTzVBbFAxQ1VMY3prdzlJY2RybVJEN3l6bkZpbmRqcnpO?=
 =?utf-8?B?RkJaYmI0VWlnaWlRRnZ4RkJmWjZZTjE5dUo4NysrYXZ5NTVWcjJzeGNwZlNn?=
 =?utf-8?B?aGhRTnJha04xTk00Z3JDdjA1MFMvRWk2cGd5MFArdktLY0hueExObW1tazhw?=
 =?utf-8?B?ZUFYMGdnOG9uM0NZcUxyZjBuZDk2bkNBTk04VXVCajU0SHJnMUhwVWZHM1Va?=
 =?utf-8?B?dW5PM1hIdkZ3d21DOUxKYUdZZzUyUWJQVXBUeSswVm1Od1d0Ulh1S0ltRmNI?=
 =?utf-8?B?a1RscTdUQThnV3p5Y1ZRNVVhQ3pJUVZUNWx1dEd2QkZWSHNxeXlYM01FeHN1?=
 =?utf-8?B?RkNBMEN5WkJDT3dOd0Y4c1FqVUlsWmx6Tmd1Tk0zaVNFNXlSMWZXc3dmL1A4?=
 =?utf-8?B?azFrTHhieERGQWZKYzBiUlJNaVlQd2JRQzlScUNIbFNJY0ovWG9QWDkwcjdh?=
 =?utf-8?B?THVkOGhEejFFMW9HUmtBMVRVR0xhaGZrNTJ6UmUyd1ZQT1lpeG9maWtJNkdl?=
 =?utf-8?B?S3lOZG56ZmRhUXVFMng0RjQvRFF1K2grRTdRMGpFbnJEenlycHVNdTFxOEcx?=
 =?utf-8?B?TndQUGQ4dnhqYmVuRzZwbWJRcUxBRHNRUnQyZWl6M21McGcxVk40Zzh1UEZv?=
 =?utf-8?B?ZWxRY1J1aTNTejNXNHhXRFNEWGVqN0g2a2JrT1N0TFE5azVxWjJ4d2ZTVE40?=
 =?utf-8?B?WlMvOHpqU2VjZnNMWmcxcW1YcEFleFd4c0VEYlBuajlBcmhuU0FXMWVXaW5u?=
 =?utf-8?B?WUNUWnFYOEUwVFdhYWh6bnM3ZWM4TEQvdFpid0VBdFA2QWhDNXRmV2p6dG8z?=
 =?utf-8?B?M0Fya3Q0UDhPL2tiLzExcyt0ekNCaHc5bkY3TUtrS1E1Yjc2YVh2WGZIUjhm?=
 =?utf-8?B?OFBGOGo0RnZCSGdKOTIveXd3OG1ZeFA4OVN3dDB2K2YwdUdsNEhrTG02NWxm?=
 =?utf-8?B?SldDUG9EMmRzTUxTNTZsV3ZRVzZhS1Y5YmlLQ1VoS0JLWFc3NTg1amk3LzBy?=
 =?utf-8?B?ajJ3OW91d21jMHgvSTRGWGdBSm9nb2Y3Nkc0VklhaFEybXNHOG9obm4yaDZY?=
 =?utf-8?B?QTFMUzZPQjhHYXRHTGpMWHBkcHJHblRmbnlVU09EMkRBREV3WU45WWxHV3Ro?=
 =?utf-8?B?QjkwUWVDK2hqUzVQN2lCaHBKaTUyZDdQamhFK3l0REFDaE1uVWxzbDJ1ZVZT?=
 =?utf-8?B?bllOQTJDbEQ2TGU4VlY1SkI4Z20rOHdaV0M3ekNHZmJjNFpuTmZ0cXByQ2JS?=
 =?utf-8?B?dkJQY1Y0WXIrUFByVHMrZy9XUzV0MEhDR2xHMHg3bjdmUFUzZDhnK25LcUZB?=
 =?utf-8?B?TEJSblFNeHZJQjhhNVA3VXlRMjVRdDBFSEJCYUJKektGSjlWMXk3ZmRBRDJQ?=
 =?utf-8?B?SXdpdk1PWVdUYlpIMWo4ZVZMMWxOYzk3c2JYVUZPTVFRUjROcVJtQ1VRMjBO?=
 =?utf-8?B?cHUyV1hLM2FhM0JGNDdMWjg2WmlzTThnT0xlVUxPbjhaZ3RlWmZvdGVFOFlT?=
 =?utf-8?B?djNGOU00ZHpYNzlubENJd25PT3BlK0QvTmk5MGc4RnRvaDd2YW5vOVZwSkVC?=
 =?utf-8?B?QlNiNm9seGE5MXZlZ1RMTXRMU0lvbmZLLy9SUHAvci82MWhmUzhIZDdId1Yv?=
 =?utf-8?B?VlBNVElwTFE5RkpMQitXa3dMSFBHbDdOZEpyQ3hQV2F1Z1NKYUZWclMyUFNj?=
 =?utf-8?Q?obiESovOQZ2SbHV7VKbJK3ZVSlP1py/aL8PeQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZ5dmdMTGhoL25IT2hKUE1SbTV5VU9NU0wveXJxSTU5YkM5N3RBaXJ2OURJ?=
 =?utf-8?B?R2d5WGRIRkZtbnp1cnNoSExsVHFGdzdqT29PRWtuMjEydDU3dnZaVG1FMlF2?=
 =?utf-8?B?bVNtWlZTTFl6VVErcmZERzd6RGlvYldXanBFK0hUYUxaU2phakhzREZRcUZ5?=
 =?utf-8?B?WlJBeHBlbjVQaXFtRitPR0FMWDBGV1RuRHRMRmxveC9EYnQ4K3IyUGhlUjRG?=
 =?utf-8?B?QzZXYSs2a24vdlFhUFdsQXZybTJveThFTWpaak5adW5IbVRiREJmVjBOOGpB?=
 =?utf-8?B?OVYyZHNhM3lDWmJlaFE4YnY2VUlzWHpwcUM2UldpUlZockppSnpaMHVJczJO?=
 =?utf-8?B?ZW5nM09tbGFObGFYVUtnTFpvRXZhNzFYaGpoRk1qakxNL0p2aVR4T1BTQk9w?=
 =?utf-8?B?Y1NRM1F4K2F3OWNsNlpKU3Z6c2Q2RG9lSXg5QTRYd3N3ckE0QzZUVWpKUlox?=
 =?utf-8?B?cWw0aDdLK3ZST05iSTBvTEpBYWhiOU40bmNhQitkSi80ZkFsdVExVW5XZnJx?=
 =?utf-8?B?WXkyZDFrdkVQaUI4VWErQXlQdUh3TDRSRE8vYm1jZVE0b3g2SDlPMkxzV0dH?=
 =?utf-8?B?bTBkSkFkMWZrY3F3YXhZWElEdStOeTJNUURGTzkwWVg2d3NnU0ZiVzgvUWF2?=
 =?utf-8?B?cUp2TkJkRjVtMWUwVkUzRktKNHJkb2taWEx3a2kyZnlzTld3RkVsV2pXUTJm?=
 =?utf-8?B?M05FQlhZV2ZEM00xR2t3dXBMVk9wTDNyeGRiRVF4RFhKWXpoYXhXV1RwZkho?=
 =?utf-8?B?RUZqdkZRaktZSk56VlFLT0xId2t2Y0h5RnZpdEFYZnZKR1VZWGF3UitBaHRr?=
 =?utf-8?B?MTFYYkhNYlZ2dG02Q0k2Z0Q3cGtwV0NKSzhlQkh5L1pSQkJLZEhyeTN0N2Fp?=
 =?utf-8?B?MHY2RzBpcHFtQzIxYUc2SVoyeCt2a0pKT2kyUEpqT3NpM2NmZDBxbW1tNVF4?=
 =?utf-8?B?TStyRUdCeWRkYkVDdUNzdFVxRytoWDZiT21JT1lRQjJZUDFvRDNRWDlQcUZU?=
 =?utf-8?B?Q0NqcnZGYnQyNGxWRExabDhJcDFMR0NUQ0o5d3RIVmpQTXVpL1JWMzJkekY4?=
 =?utf-8?B?WE90M0R0MkNORHNOUGlBdUhCNzFLL04zOHFJTmxkSVdlMGNQTWN2UTBCV2VY?=
 =?utf-8?B?QndmeHJFTkJMdExnZGVLbk1xRVZyeFRIQzZUbkpWdXFpWmlnUDY3T0JJK2ky?=
 =?utf-8?B?MTg1STlZMlcySUNhWjY4czV1WE9xTXd4TDZlSU9IRGhTYmp4aVBSY0NBeFEy?=
 =?utf-8?B?MlB6MGRpMzRUcGZnUWhuR3NFTU9qMnA3am5hODFrcWZJQVZtUitMemVFeXMw?=
 =?utf-8?B?d1Y5OEZYQVFjbkU3aFhqNGFkOFhwWnRhWXRrRWVjM0h2VFFrN21ldGJvY2Jp?=
 =?utf-8?B?bzY3YzRUZjlnRzQ1R2FSUFJScTFEdjRXcmFJOVNsSEhLdFFocmMvRUxpKyto?=
 =?utf-8?B?TGpqcmRjeGt1MXVtN0lGTkd0QjVjN2VqRkFBdEgrUFE3UHd6bUszTzVXbXNn?=
 =?utf-8?B?dWFXbDNDd2JmbmU0Zk5GNHNidkp0OGJ3ZUZFQkNDN3BrSG5zVGVib0k5dDBX?=
 =?utf-8?B?dUV4cHM2SUhIMjUzNWdLMFFZREwwbk5tUUEzTzNZSmtWZUI2anRxU2MrbXJJ?=
 =?utf-8?B?MStxaE9MaE5Xem1uWG5uaUNKVzQrbDhjTnpGQVlndnp4cVVxaVpMdFhzeGhn?=
 =?utf-8?B?T2V2cTVWaVhxbFN6NDEydld3bDg4OGVSVTFMMnd5ZUhCVmFJU2VQbkRab1R5?=
 =?utf-8?B?anFaa1E5THpNalFXSFlrbjVoSi92ZFBrRW93UjgzQU9jZW1VY1p2MWxnSDdY?=
 =?utf-8?B?VlozSVlkbDJUL1p6WGxwSGo1MlhrQ1kvWXBEWVFvcWl2RElUV0EwRGo1eVpG?=
 =?utf-8?B?WUxPUCs0TEZ1QXdyVDdDR3FNMDlVOExJbHgxbFVTajFoQWhsZi9SQ3FyaWhS?=
 =?utf-8?B?eC9aNUQ0eEhkL1M1NmN3cEhkeWdNVmFjd0Evc3FmbWVQb05vVXI2NSt5MHdi?=
 =?utf-8?B?Tmc1dG9NbUd5QUFZSjB1eDFXWWNhZFNCR3J4cmRCV0l4bFhCR1AwQ2kzckEx?=
 =?utf-8?B?TXlzOEhpbm1RWVRLZWNVR2hrS2grY00rT2RMYUNKeHRJejZZckNpOW55RXVR?=
 =?utf-8?B?TkxIK1kyYWdqaTNkTFFEL0tHWVNKU0dxVDh0akxSZDlFdWs0YnF6WkVURzRO?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee49eb44-da1a-4f18-dbca-08ddbfc9fdc9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:54:02.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmmYcbjk7o5HIxNzCc2Lq5EeUTvlNrw1h992Rvl1vj9PKbl2Id9VJ9uIX479cluK8PtUr8u8BGyLxkw3uG57EAjcNic34Szqbzo0PciKcFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7995
X-OriginatorOrg: intel.com

--------------45wlz403h4yj5I0cS8qCS3D7
Content-Type: multipart/mixed; boundary="------------cgeHBecYZQRCSGeIjU23MMRQ";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>, Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <6fa10a33-7434-434a-9ef3-02fbaf21e1e1@intel.com>
Subject: Re: [PATCH v2] reflog: close leak of reflog expire entry
References: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
 <D34FE2DE-EE5B-43F3-A706-1AC133AA72F1@gmail.com>
 <20250710034241.GA2057509@coredump.intra.peff.net>
In-Reply-To: <20250710034241.GA2057509@coredump.intra.peff.net>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------cgeHBecYZQRCSGeIjU23MMRQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/9/2025 8:42 PM, Jeff King wrote:
> On Thu, Jul 10, 2025 at 11:00:38AM +0800, Lidong Yan wrote:
>=20
>> In builtin/reflog.c, we have code like
>>
>> ---
>> 	for (i =3D 0; i < argc; i++) {
>> 		char *ref;
>> 		struct expire_reflog_policy_cb cb =3D { .opts =3D opts };
>>
>> 		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &=
ref)) {
>> 			status |=3D error(_("reflog could not be found: '%s'"), argv[i]);
>> 			continue;
>> 		}
>> 		reflog_expire_options_set_refname(&cb.opts, ref);
>> 		status |=3D refs_reflog_expire(get_main_ref_store(the_repository),
>> 					     ref, flags,
>> 					     reflog_expiry_prepare,
>> 					     should_prune_fn,
>> 					     reflog_expiry_cleanup,
>> 					     &cb);
>> 		free(ref);
>> 	}
>> +      reflog_clear_expire_config(&opts);
>> ---
>>
>> I think allowing reblog_expiry_cleanup() to free all opt->entries migh=
t
>> cause reblog_expire_options_set_refname() to behave incorrectly.
>=20
> Hmm, yeah. We are calling this in a loop, so we'd want the config to
> persist until the loop ends. I didn't test, but I'd guess that:
>=20
>   git -c 'gc.refs/heads/*.reflogExpire=3Dnow' \
>     reflog expire refs/heads/foo refs/heads/bar
>=20
> would apply the config for "foo" but not for "bar". So I think
> reflog_expiry_cleanup() has to just clean up per-traversal data, not th=
e
> config.
>=20
> So the call at the end here looks reasonable, but the call in
> reflog_expiry_cleanup() is wrong. I guess it was trying to cover the
> call in reflog_expire_condition(). That probably just needs a manual:
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 845876ff02..37f5437365 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_config=
 *cfg UNUSED)
>  				 count_reflog_entries, &data);
> =20
>  	reflog_expiry_cleanup(&data.policy);
> +	reflog_clear_expire_config(&data.policy);
>  	return data.count >=3D data.limit;

Ya, you're right. I just thought the reflog_expiry_cleanup would only be
called by this function. It did pass the tests... I'll see if I can add
a test case covering this since its caused a bit more trouble than I
thought it would.

>  }
> =20
>=20
> -Peff


--------------cgeHBecYZQRCSGeIjU23MMRQ--

--------------45wlz403h4yj5I0cS8qCS3D7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG/iGQUDAAAAAAAKCRBqll0+bw8o6I0R
AQDbRrgts9pKR4Vf5Pm5cO2N3uwVA+18hunfJxY1hv2oiQD/RB3WlzrEReuQCF+diA119tdVhswp
1P3J6Vt2aQ51Igc=
=z8Pf
-----END PGP SIGNATURE-----

--------------45wlz403h4yj5I0cS8qCS3D7--
