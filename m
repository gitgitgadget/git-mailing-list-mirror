Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C5242925
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226577; cv=fail; b=ScsMGA9WI7Elijwv6qGL8R6dqiKQd/Cvsk/CI3203iRSmJtqNL36JaQvWhbJWv7PbeiahthWJviWC2n4KO305vsJwjMcEfisAci7iOYzho0uKZvNYjYgsL5NNMSUdMM34F3y6YdwgRBStFwOADSvdFxUS9jY004o3r07RgnH5Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226577; c=relaxed/simple;
	bh=7hqppLDjBlAK9xjzfyuOn78qvD3v2Cg3iElTe+viny0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6Kk8MqBoDfuxzSeLuyqFMS2F95EQmzYPJ9K3sOWFQM30JfLp7jOJCPFdKvuPoELcXWDfh8JrEBw7AK1E8zjEoDbST+xWgTA+ZpxtLUofZBlQdIfInDJc6Ek1Uil4d+jy5d9ejqvtC58zJk2Mnut/lMQp1B4l+gwXkFmtcbSk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0L+qNT7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0L+qNT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753226576; x=1784762576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=7hqppLDjBlAK9xjzfyuOn78qvD3v2Cg3iElTe+viny0=;
  b=k0L+qNT7gVLwB36Sd9L/EcChDBQuxT6AB3TdvOPrlWV9sx8NAnePR9yw
   FZ+YHoyUmVZDBKH8zMxI3+lzMDFSZAn9O/QE3hIwA9gciYGLCKxAW5E9p
   Q+wYnayUTq23orU9SgI2ldLUjeILE2eZYT34bJVNK8ik1R90OxNl8fu8C
   GDa78T/i9eEK9vL0S2d5sFhtSV6l4ut9fcI6udYdujkUbOvzlP7eoyZPb
   B4lsiEdXGus1B105joqGmeagXYYuMwQz/gMGC1o1k4jYQ8trcAV3CndZm
   pwtW9qP149z2nrzOTadjjQptCqOxCtJ800vvgfaWvKSTBcIuIo41kQHll
   Q==;
X-CSE-ConnectionGUID: cjDHpZdfShCz9WOF2aO6Hg==
X-CSE-MsgGUID: PveD2jX4TKmcVRoY+Os/9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55650310"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="55650310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:22:56 -0700
X-CSE-ConnectionGUID: SfhONaa7Q3qMwNM+1zJc/w==
X-CSE-MsgGUID: 22PMkH3qSpyz03C6xAYmLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="159316714"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:22:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:22:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 16:22:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oljDsbQk/nRgpXdDa6tK1IYE0zTwrbWV4zExsPUvxXFAVGRpvA1v7Xad3s1oye4E4/xbJ+ozyF3uNjDr67bIyjvpo+2YOY0d8tKfQYnq+TU5zZtRNyinuUv5/K+/5cf1qirVRsT7Ee3XPl/ug+I0q4cRbCVJLKu22okYmUCuN75og1eq+GhYhrLBZK1yjKNHTzzaB/WvtQH/1bTQvEfUxHkKdP8R5l0jH/6rw/+GNBadu8EK7JCTcUen7kVziwebvOtPkQTVgl10Pt+CluUH8vV6HBK2pmuqnyW0BZ33EUXA/vuqN0QHljUgVyaOMYeDMfiWH25icQcEVE0fevzINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hqppLDjBlAK9xjzfyuOn78qvD3v2Cg3iElTe+viny0=;
 b=uR5VZL8xRkkhEJiZWcnsRqlpWkq3xDar3oPQOCM8EXWZmhzOcNuLSErcCF2A6bwNxiX4c34tuS6RwrK3jQ1XlngMDrs4pe8D0uGcGED9bxtlbW14NQ35TSManiypo61hRELa6gPXtPFfJEldsWELBMISLyxmvRcPk2Zjsx2Kj8AcVoMM1EezmJpAl7O+voTkg8Jv2r9HgyvNB6tGpy8X+ACyNnpnFb7iMgTV6gyeAfW1bOMdKdr0NUa/tUOCMdrXXbwmBFxXA9u/DyKAzbdeU0aXfapm/xrCc9nqfp4/YUz/N4gt3eLnNvPG/mX5npFzNW0OvZ3KRe8YtNiHiMhZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 23:22:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 23:22:36 +0000
Message-ID: <72f13c54-d5c7-4366-bba2-b641d9e2b0c7@intel.com>
Date: Tue, 22 Jul 2025 16:22:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
To: Junio C Hamano <gitster@pobox.com>
CC: Jeff King <peff@peff.net>, <git@vger.kernel.org>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
 <20250722045456.GA824456@coredump.intra.peff.net>
 <fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com> <xmqq5xfjrew1.fsf@gitster.g>
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
In-Reply-To: <xmqq5xfjrew1.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------YJmvhmE02X7eGY6zsJlk5P0u"
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2ccfc6-4539-46d2-52b2-08ddc976a4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0l0NVFidmVPQWhRUlBNMGNQWmpoTFNnd056MXZUOWtHQ2ZnaVdCVjZrWUtD?=
 =?utf-8?B?M2lialdwd3BNVGVIbjQ2b0pxOUkzNm4vTFI2T1ozQWFPb29FRXlJVU5xVlFC?=
 =?utf-8?B?a01ab0tUc0Z2L0FOZjY3bDIwTnBxeFF3ZmJFWXgrZVpZUWEwOHFEV08zYjJJ?=
 =?utf-8?B?MWNRSDRBc0xZOStCdjI1QlRxd2RHcnZHRDlKZ3lzQlg3dmE1QTdBY282cjhX?=
 =?utf-8?B?ZFNaQ3ZNVnZiNGtIUkJpU3BnYURvd2daU3BvTW1RZjIwTDArdzA3Ynl2OHlD?=
 =?utf-8?B?c042OUM5bnhvNWFCb2NUYkd4Z0JOYnJ5ODFqR1MyNVJMN1JCc0tJbkwzdHB1?=
 =?utf-8?B?UVQ0aC93MGQzVDRyYTc3YUQzVytiTU1IMDljd1R5QWZlSzRTRzR6OWxQbXVq?=
 =?utf-8?B?MjM4YXBwVUljdXdoYy9qcW91c21MOVduRGRtZTlKRlR6NnZEek1LeXhSZGRP?=
 =?utf-8?B?c1hFdEIxby9pRWRIb2hUS3ZBQWVWeThwNjBlOFJKckhGOUQ5VXJ1R2pmbXBl?=
 =?utf-8?B?azhlanVLeWdHOUdpdDdQRk90NUpQdEFUV3Q0Z3F2MnBoRk9JTUVvcjZMeDlx?=
 =?utf-8?B?QWRnMCtkQlJzaHhVSUFJNEdFMFZxb2RnTWtjYjk1YzJHYmRya2hWeTNvOXZB?=
 =?utf-8?B?YmpUYWNYaCtya1pMUmYwVDJqRU1nU1R6Tlh3bE10eTFLSzVXL25JNTNCZ2lN?=
 =?utf-8?B?eVJ6MFJqMStJbEloR0szSzZTNzhMMURLM0hFRy9jZFZZd3NXMGxic243eWtD?=
 =?utf-8?B?WHBRZ2U5SUFxbnBmK2F0MU93RlU4WkNvYzBtSW8yTUxaMi9PNVViN3o5dnFB?=
 =?utf-8?B?VVpTbGFIUU9FYUw2UCtkTDFaQkVYWFlWVUQwdGFhcU9xdWtzYmZ3OXNTOXU1?=
 =?utf-8?B?N2hJTHNQM0hWR2NWL2ZoV3JYMHN6S044dy83YUhpY1RVa2VpTm1Va2JFNC8w?=
 =?utf-8?B?SzlZWXBYdEw4VGcxczluZk1McUtMd205OUVyWW5sMzdiWEpsWm1iSDZLS21M?=
 =?utf-8?B?bndUQ3l0NFlSNTF5cHRLM25neUVmaW1zTHJ2VzZvWFd3OVRVazdyREdtY1Zm?=
 =?utf-8?B?dWVtektqVW1vZ21POU9SK0tNaTZiNXg3RG84OFo1THBkeW1MU1NOUGI5NGhj?=
 =?utf-8?B?dXVnSnUzOFQ5bWNSaHh6UW1TbWtqSk0wTDY1NkJvTEcwSUlUdXM3OVlqY1U5?=
 =?utf-8?B?WFpBVHlwblZjVXliK2tnQnAvcUJ5OFVFZ0ZiMlFaazRXSGc1emh2bmFhQjIv?=
 =?utf-8?B?bExIRDVnOGNMcnZrdGxVMllKeGVkYjFpVDhubHJUV3pyeUxNRlZsUjNnMG5B?=
 =?utf-8?B?NmNFMkZ5dk5SR2grM1J6TWc3bEpnU0o5ek5kT2xOUHp5VXh2a0ZyOCs5ZExB?=
 =?utf-8?B?T2ZUTDNBbWwwQ2xqTHBpbllpb1pYeWZTQUZvY054ZDlCMGIxaGplQjRwVEdB?=
 =?utf-8?B?QkhPRXEwc29SM3FOMllSN2Z0UGl3d0paTkh0eHJVMGdOejZsaHlUYnJKeE1Y?=
 =?utf-8?B?RUFIcUZ6a0cwUmlQL1NUTE5TTjRBUHJHMmtkRWswZ0ZKSnFhZW9xcFVOMXFR?=
 =?utf-8?B?YkloSjJ5UmM1N0tzcmxxcG93UysvUlBPb2Y4SzFqL2ZqMjlJWkRIdU1adHJT?=
 =?utf-8?B?dllVMUlYeUlkRmo5dDBBZ0hJNjhteFhvYitJYmsySmVrYS9iYSsxendUUkFz?=
 =?utf-8?B?SG9OQ2xqaUUxbkN2Mk1JdG9ITDIxZ1FjSWkxRDBybUVQdFgveHBueXV0Uldl?=
 =?utf-8?B?MGVwTDlnUWVEOFl2blNad1dxR2xQRWU0aXZoQ0lJNEJBc29iMnJGUzNiWVB3?=
 =?utf-8?B?STJhVUc2QmVWQTdyS21GallodURWb3loMXJkVTBFZDdEWktwV1FucHpmVGRj?=
 =?utf-8?B?MzFjWDBpanJ4QTJONEFsRzBpZzZFK1FENFZqNkpNOVlmMEdMbW1taUVmMk5m?=
 =?utf-8?Q?Q0OkcnNVpoc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0I0TjM0ZjhNdEVQbVlBZlBqbnhwNm8zVEFjeHQ5Z0F2YnEyVWFCc3NYSGxm?=
 =?utf-8?B?N0pHVFI2Q3FLcDNpY1NlVGY4c0tyTFhQQTJ3QlNnbmZld2JHL0VLZ3pxSWxJ?=
 =?utf-8?B?N2NVWnpLRjV1U2dsbGh4LzRVSUtFWjA5SFhQcmdqWVExdk10NzZ0bkVjcjhp?=
 =?utf-8?B?MWZVeTZLN1dkVjU5Q2sreitza1BZeEpSU2FPZXcvSW9jaWZMVmdnUmhKQWNH?=
 =?utf-8?B?RHBhQkhGeVpxRFlGRVFFbS90TXJBWTUvNUlDWU16c0xxOWlQWGJtejcxbnhF?=
 =?utf-8?B?RDNlTDNTdC9uN1dPSWs1cCtxUmNnRjhNUHNmeHhoNTNJcWZ5bmVFMzk1TEU5?=
 =?utf-8?B?ZDE2UUdtWUN2eG9OWjhSVTRGSzdoTFFoL3V5Ri9idHlDMnIzWGVjY0loVGc2?=
 =?utf-8?B?TzNTeXdFMjgwSG9sc2hvRHV6eGEyRVV1bDBuUWVldVkzWlJ2eXJDekNhZk1C?=
 =?utf-8?B?cHQrNXJFQ0FpQ21ISDRLUVc0RG5US2JkQ2I2RjQ4YkZSTzJ6MGFraUVSREVr?=
 =?utf-8?B?OGkyYUZhY3hBR0ljOHkwNXlNNjBTb0dLWEpBV3NXMVhYcjZsaE12S2Zsck5s?=
 =?utf-8?B?ajA1RFBBTHN1WWZGKzBLTmZkZkwxaGtQOWxhQkVtV1R6SmVoNGpNMFp6WTVj?=
 =?utf-8?B?WGs4QUpITHNCZWU5ZVN4THpLK2JMMmFneXFiMTFsQWd1dlBxcUQ2RVM1QVA2?=
 =?utf-8?B?VkUrdHltaGYzMFRpd2FXclk3ZDUrektsS3FRODJVeGg2ZENWc3crZ1A0YVVu?=
 =?utf-8?B?Sk1vZXVldUhSRUQ3S2ZCNzVlaG5GVTRYQWZuQmd0SVZyTUs3SnQ3ZzYrc2N4?=
 =?utf-8?B?SjIyOFIvaXlTbStOOFlKd21FUFpvYnRNV3dJVEpManV4b1kxVzdyQStrdlNJ?=
 =?utf-8?B?NFRKN0VabFBEbWo2ZnFUZVAxK3BSNldPdzJqR0pIMmxHZE1MLzcxeGMzQkEz?=
 =?utf-8?B?WmZhL3R0a05nSFdFTGFjMVQ5Zm52bGU5NUVxS1RhSkFLRyswV3dUTXdsRVIz?=
 =?utf-8?B?cUliS1VSd09WaFlTNzg0SUM5ZnMxK05IS3hEaDVUQ1FLVHBwb0dFMTFrcWdl?=
 =?utf-8?B?dmtTNVpBYzhYQ3hRUmIzT25zR0VJZHFWd0loRjZ0QWVFWEgza0tZL1BkaWpO?=
 =?utf-8?B?VDJqM2xzTzJSMHJtUjVYcTFQY3lhY1llMm5DdnJjTVRsb3NlQXM1c2dia3lN?=
 =?utf-8?B?czZsbjNWL0VOWUJ0a2hJQTFYNWZBVEF5TnRYbXBHZUEzSGM4UE42R051a1Ra?=
 =?utf-8?B?Mm1uYmlmKzRvQk1YcjYxdjNDZTJVMVVlMExBTHYyenZ0Q2NQZ09jV1FJK3dE?=
 =?utf-8?B?UC9YQkIwbEVCY2ZYZTNIZWhyalpzTVNCTXZpYUtxZG0vYkcvcEs0L0tqMlFo?=
 =?utf-8?B?TVg3eHJiVXo1VmFIL0ZMZ0NCZFpYdFFTRVBvQk4ya0h4bFZkam5kTi9EZkY3?=
 =?utf-8?B?Ui9reFNmOHpjRVBteExhU3JzNUNWNTdoUHB3aDM4bnp2R0llNGJDTUE1czM3?=
 =?utf-8?B?b21GeHVySTBjSzd5SjFJai9EQTBiZWNmdkhQeG5PSnhFMGZQa3grcmpFNVZM?=
 =?utf-8?B?cTQ2NjV2ZTR2bkwzNnplbTE1MEV4M0NYRXFaeEx4R2pEYnZhUnNMSlZpaGV1?=
 =?utf-8?B?c2lnR0NNQUhLdnFlV0tHc0dBKzl0bWJ3MnRDODZQOUNpY3JqaWtybldhSlp0?=
 =?utf-8?B?eU1oc2RJRURWSE1mbjhyYjd2U2NORGd6M2tnbUdybFNpUUovUnFqb0UzT2gw?=
 =?utf-8?B?N3RLZTZiRFRhWE5Na1lKMzAvTDBsNDcxS2lRQnFIWjNuNFVURlI4TENMakZK?=
 =?utf-8?B?T3BNS0ZXMDJPaFV5THU3MDYyMWkwTm0xWTRibTdwUlIza2h5TWRBT0NjanQw?=
 =?utf-8?B?eHBSYnFwdCtlV05hMVZuc2x2V2V1MlpCU0M3dkF4aTRqdDNja1pPYUdBSGlW?=
 =?utf-8?B?TGtnZ1VjeDB5S2o2U3ZNUndETmNnU1hhYXFpMlRsQTg4SXF1a3NUUEVnbS9W?=
 =?utf-8?B?cVdKRTdJaHJzZytQWHIrOHZVRkR0NUtSbXhaaGlFbmQxaTZJTlNzdEVRUUJD?=
 =?utf-8?B?eTZCeVFuTzdwRTc4eWViYzNDTlA5clNNSWJtY1pKUFAyQ2YxYmloSDJJVzE1?=
 =?utf-8?B?OUliYUVxR2lYS2svNFpXaUMxMHQzeWtrZjNzSVZTMnZaek0rRzVsc0dZODNB?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2ccfc6-4539-46d2-52b2-08ddc976a4e9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:22:36.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYK8g+HJrkGksJRMus/IdxEhN1VECyyQBgfB25/G/TGpM+0lbF8GReRCVWP4zRc9uDlzc6PSmb0e/kFeF/DCL2YYs9YL8iUgnkNP0yAqbj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com

--------------YJmvhmE02X7eGY6zsJlk5P0u
Content-Type: multipart/mixed; boundary="------------9Np9Ggk8tB0FVHJn9v0HlrYm";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <72f13c54-d5c7-4366-bba2-b641d9e2b0c7@intel.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
 <20250722045456.GA824456@coredump.intra.peff.net>
 <fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com> <xmqq5xfjrew1.fsf@gitster.g>
In-Reply-To: <xmqq5xfjrew1.fsf@gitster.g>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------9Np9Ggk8tB0FVHJn9v0HlrYm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/22/2025 4:21 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
>>> This needs to pass &data.policy.opts, no?
>>>
>>
>> You're right... I think I fixed that and forgot to actually commit it
>> before sending. Ugh.
>>
>>> I think we might also want this test on top (or I'd be happy to see i=
t
>>> squashed in). It shows off your fix when built with SANITIZE=3Dleak, =
and
>>> also catches the bug that v2 of your patch had.
>>>
>>> -Peff
>>>
>>
>> Sounds good. I'll send a v4 which squashes this in.
>=20
> OK, or you can tell me to squash what I queued on the
> jk/unleak-reflog-expire-entry topic that ends at 7c091149 (fixup!
> reflog: close leak of reflog expire entry, 2025-07-22) down into a
> single patch (or two to keep Peff's test saparate).
>=20
> Thanks.

I am about to send a v4 that squashes Peff's work in and adds a
Co-developed-by tag. I think that makes the most sense.

--------------9Np9Ggk8tB0FVHJn9v0HlrYm--

--------------YJmvhmE02X7eGY6zsJlk5P0u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIAdOwUDAAAAAAAKCRBqll0+bw8o6MLl
AQDoGN8dqkepAmbaEuJ4ZuduL4viptW3XvbK+5VhBpwVBgEA21uhPcUoOlq+5+XUBFiZExlHk36n
elNFKRFl/sdlBw0=
=fnAp
-----END PGP SIGNATURE-----

--------------YJmvhmE02X7eGY6zsJlk5P0u--
