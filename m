Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5E248F64
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559968; cv=fail; b=De0EdP/vTpNRA7ZW8wl8BglwHn9ZUsVw2w5HG048Ob1zPlSc/1JxNP1zc6gQHdE6LEDX9xq01Jp9c043ab7dSOD4jnjVFE+i/VChRz+pQarn230ehoZntfSemw4S0F6OhiJN3075h+xKelri2LJ+hO0tnthGEP3eIlhqxAkwBSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559968; c=relaxed/simple;
	bh=72+a6zGJbVxgil2f1YGB4ivrAQ1I5C9nD/6u9Cy0Gwc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GzcbZRozxxeleGdr3SOjDHCaGD0E4PPW3rjtOH6pl9WbCgvlCsVrfut6EVc1+dpAw43DfkxIfjz7fpa/BMcxWYjTTdWbUupxnW8c159C4pWe06aHoyogBl1v/fjHWAXImdnrD0EAaRdMxurSh8HaMmQD1/KoQzRnuvtTuGqYPzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoEFnY1A; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoEFnY1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751559967; x=1783095967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=72+a6zGJbVxgil2f1YGB4ivrAQ1I5C9nD/6u9Cy0Gwc=;
  b=NoEFnY1A8ccnB+hj9siSSL84zm8D6hJdnveCjL8cgGOTDIoSwoH7fEnV
   +VdzrzOxbnUUPLKuyDcq4rH6Lw3M8N8mKE76qkY7AUHFySP77aaP9DPH8
   8cqIgyAzkSCy7ZOnvqig1hT2NFAcgEJaKIbYKhfv7Xi0tNBCowhXIvEsP
   Y0CDlaYaVhfSP+N6CZ5zwMHiyWp2ySqh5psYjMEKBNnQy8WbkEOGDx7J0
   1PJrfKM91x0vTTP/SH33Gr4GFczvvhhNUwsShFZRRz7GGwgLKCFn+lrGA
   hjVQM6CiL1JyIVQGfcmYwJMkkaAMJLkHuw0HYGw9uUhwxeLejuEf2kcG3
   w==;
X-CSE-ConnectionGUID: 4NY7Kn8ESheEicsm8zmsgw==
X-CSE-MsgGUID: z8c3NHniTQ6K0nd/qjDZnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64139049"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="asc'?scan'208";a="64139049"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:26:06 -0700
X-CSE-ConnectionGUID: 1RMi1fsTSrCd1oQajFoF/A==
X-CSE-MsgGUID: MLoxk80bSNez+1jJYe3HSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="asc'?scan'208";a="153826303"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:26:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 09:26:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 09:26:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 09:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbpbi8N6us7ILGQHWNAhumu9ue2BxYInPC8zmmCyDKgzm2SRPvrfcW4dzwINlqzI/FLBW2n3PEzewp9zNmLsApDZ5kdt68msnrLy0KM5crGYd5J70zyxCJkw+LBP88DgJIU2CVUTbbka0CoAOEq5w11dVT5CNl5pfIBOkcYRfGw10oo3tlnBL8q1v9KGSdRaU3zl/tCKd3a4OladlDj+7PtEnjFfXt1IJwXcjsLSjBoJ7enOnDV+XRKipB5HZDsnB2vWJtKTyaJOcS/RO76GrqgKbchsTxoB7OHvF05TofmNaC78sW8ctxbWEz2Z37J5O8YrxQYwXvWvl7Jx6Z3rhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1ZyzqJZ+UgViWZ2xJQWuw5HSzYAaSOkUhj5YSwslMk=;
 b=k8nZnvPg6u6qe+kaL1+1HyFn79qEPloSo3Agf3gsjCAZFiXuSMItxB9Tg3GRd9zuk7tnrxepxwk91NkNo7VCBlHqJkwZlm1x1fEKm6NFmoINfM73ZLGqJ+OWJoetmCCHO7KGz0/+VfO1Vuz/Y3SLwRN85NEvXE/cDRXHCiMyNpriXsvb4D6o0B3UJeGqQ4PzozkYaOkSAVgWbf6UiF+tvgY7ZLEWI5yDk6TzgsK830raTxP8pJzLIitTDuaTMLn7fy9Zj5EBXc+EI3YgSkX3uKnfXeS4uzk2XaE2cxyNpk6a8iunf1ZZuTXjED0DOSXJRIm44cG/aHXHGPX3/DesKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 16:26:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 16:26:02 +0000
Message-ID: <72331edd-8e03-4415-ada2-2be8fbee922b@intel.com>
Date: Thu, 3 Jul 2025 09:26:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
 <xmqqzfdnkdx6.fsf@gitster.g>
 <20250703154047.GD1309870@coredump.intra.peff.net>
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
In-Reply-To: <20250703154047.GD1309870@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------w6QO5d10M4tmp4eGzaXsp2i7"
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: a97d5444-3387-49b3-7fdc-08ddba4e4d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzBiZkRmRThWTTVkSFBTaG1sU2NTWG5iSnJZaEpBaFRmMkhVeWFlaVdETm5V?=
 =?utf-8?B?d3ZVNDQ2N09oMEEvd0IyNXZSNnhnVFUvMGo3Y1g1MkhKUHp2VThTQ2E2TWQ3?=
 =?utf-8?B?Q20wUXp4RklZSTZWTHNyQm1TbGI5d3pjbHhaeG9QMC9zZXdoaXVaM0JRaVB5?=
 =?utf-8?B?WjlTYVMwU09GNzVwSjRvMzE4VGw3eXQ2dDhiODB0VjdhUVdJSEFJMFBpb0Ft?=
 =?utf-8?B?cnQ4bFJ3a0hBKzNZbnl6dmhEY2s0QldwMnJxb3R1d2FaL25UNURrVWJVY2ta?=
 =?utf-8?B?bWg4VmdmWVVqMXFLZkFDQ2RZWmN4b0ZBcmpCVXpTaTVLOEVEVGh4QW1MY3hO?=
 =?utf-8?B?Wkx4U1Q5Tkkwcm9vdTJycFZaUzdCVGVIdHhNQjhiUENYVjdObkxlYWFQZDRI?=
 =?utf-8?B?elJaUThQTDZoZmJIRXZpSkg2SllZNGNvazlBYUZXcXZwVEhPS1FRTk5ZN0dS?=
 =?utf-8?B?MkhVZ2Y2NGJuemR0U1UzQk5kdVdLZnovSTVVblpuUEtFL0hYdi9LVmJPcDcx?=
 =?utf-8?B?MXBLZ1Ryd0R3bXQ2Umt6L3J3bVpvc2xoR0tjZUhJeElqbTIyempBSWo1cEZr?=
 =?utf-8?B?S2tFVVRkNm5zUXdyZFNzWFc1TDRvSzU0Nm5xUGNDRnYyaDB6Zjcwd0F3Tkw1?=
 =?utf-8?B?Mk5Yc0RBZ25QT1pyRUdIOHhXS1BxSHBKRENOSnZzSmxJcURNOVlEK0dRVnJW?=
 =?utf-8?B?emxRSUlXbVgrSjBZVUtwSEQvL3dCLzhUZVJVeDJaOTc3Yk1lRVMwdWQwQ3lF?=
 =?utf-8?B?YWQvZTcvbnhYUGIvQ0syWGRDUWM3SVZ4RnB0YXQ4U2FRdVloN3hPTVI1SnNI?=
 =?utf-8?B?Q1dLcjVvbGdIb0o1bDV4WVBiWG9HWTNaV1NEcVd6aUF5RjBETmJFMjJVd1lk?=
 =?utf-8?B?T2dOUGZldHhoNG95ZGZGRndYN3JqNjUzL2hRbTRIMUhhR1FUVEdFbEdBbTBk?=
 =?utf-8?B?ZmxKRGQ0cFAxczJUOTZKRUJWeHM3Y0pzN2R5UXkwY0duZ3ZjYnNJVDJzWU0w?=
 =?utf-8?B?amtoZVk1TjY4RFlmWTZPQk9LbjFoWk5VNCsrdGpuMjNjNkJiZ3JrbzVHY0ZD?=
 =?utf-8?B?ZEcyQjUzdmxqUzVpd3QyTFRneHRYUnBBSUV1NTBoRkdFRlcyaHVZNjlyWVFM?=
 =?utf-8?B?TkpzL1k4M0FOTjltTHFiNldZWTZkQ2lRRGdZT1hnV2M4TURGaE4rZWVNRmR1?=
 =?utf-8?B?dzZudjdqS2dlbXlWMFRmdy9oUW4zaUZrQXVQdVc2Z1AzMmZnUzFrOFZUV204?=
 =?utf-8?B?U0tXcnV1OXUxM2hkSzRxSElCb0ZZby82eE40UmRpbDdVTG9GTVU2d1NZS21o?=
 =?utf-8?B?REd6MnV1VEJLU2wxRHZUUFgrRHBYUm03M0p1dkRjaDlxQU9ReEI3UXI2d29X?=
 =?utf-8?B?Wk9idFltTlA1MjZ1d2tQc0N6N2VIR1VrZTNySUNYQkwrUkJFOTI3Z2ljZEtK?=
 =?utf-8?B?bjZCcmJ5OEVaNW1tdHV1bG1JUW5RVGVjTGRTc0hIbDNoN3ZnN1AvZU1kR0Nu?=
 =?utf-8?B?QXBHVmNJYkUwdnhWMW1wSXY2N294bzZyYy91Tmo0Nm9vam5vd3laTnhJYy95?=
 =?utf-8?B?QlZjYXF4L0VSaHlLQnQ1aEhKa2ozckZyREQyZklWSXlXdHQ2ejY3cVNWSU9r?=
 =?utf-8?B?OEJNNXBMaC82NW52N1V1Q0pjSTRGZE9qTkRBbEp3UkpUbVlHSG5sRTAvb2h4?=
 =?utf-8?B?VUw4aWhUU2p1Z3dBWVNKTjdtYmxCRWlTeG5WUVFuRmg4MmlsdzNEWkYyTnVr?=
 =?utf-8?B?VkxTSlF3VnR1OGFZVjg4TzRabFZ5ZWFUK1E5M0ZIN0pBV0J3bm8xZEZycWdW?=
 =?utf-8?B?MEtWTlE0Rko5SENMb0pGU0ZGT0R0czJYVVJ3TnZtcDFaSzM2amV5U0hEdFFZ?=
 =?utf-8?B?R0hQR3hCL0tJcEl1UTlSVS9RMnlSL0IrcVhFb3hTNnNKQ0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThCeVpWOWdyNnJaS29jWDRKYnpEMlZvN3lydEZjcHFhWm8xU1RJNFlhUSs1?=
 =?utf-8?B?dmFxZzZTMERmRU5LL0I2UFFWS05ldHpPSE1QMGpVUUE3K1pYYW94dXducEIr?=
 =?utf-8?B?V1FMT3dKV1RzRjYvTzc2UitpbENyWVdmUmlqMUcyQzZEanpEdk02bVFRUGdm?=
 =?utf-8?B?NG1NS0pndTFmZk44NGhpVkxYbmlBY0l2ZW04TjA0UUM5M1pqbWtpNWN5MDB2?=
 =?utf-8?B?dmxLbzcxNHMyRHBaYjY1ZEovQmNaMUkzVit3VEUwdFlmTzlzRzZzMXBCYUUy?=
 =?utf-8?B?aE90Mk9CTHljdjBzdVZLTDdIUjdrUnlwaEtPY0RpVzUrZnVsQVlrajYvSFM4?=
 =?utf-8?B?Q0RBOXdMVnBGdG9ianI5c3VRcnVwZVZVdVZ3K3JnWHJVUW9RVkE4THZkU3NY?=
 =?utf-8?B?ZnhuMEE5NHI3bEZweUtvUnY3M3RUOW9mQUVFT1ZvVUFpTVhEM1RTNmZ3Nk0x?=
 =?utf-8?B?eDVsWGprY3htWURkRlpMdlNaOHhTczNqM0t2eURFNXZhZ3dWd216ZnVkUkhG?=
 =?utf-8?B?QStlamp6WXQyNUNrU2NUcTJWTGhkVjlSM0JmZzBiTmRzNzQvT1pkM2hvTG5U?=
 =?utf-8?B?R2RJSzMzVCtSZExEVjBDTm8rRjZ2Q0dVVE15QzQrMVpkNjFUU0pDNEpIYXVI?=
 =?utf-8?B?NUcyaXNGWVNjMlFGOGtnYmh5b2pORXhmSi9aeTFEMjlRc3Ftb0xSekRTSTMy?=
 =?utf-8?B?cTAwTGVjT2VBcm9DMk9uQlFZaWVZYmpReUZLZmp4bm10d2hlQnh1RFFhTEJt?=
 =?utf-8?B?d2sreXFJbmp2dXJaZTdHODRQYlNCQUpwd0F6Y1RvZ2xITnlHc2dXemVxVmd2?=
 =?utf-8?B?NWZjWlBkODV4enNNeWFYZnZMNGIxK3YwcGZNRlRKNlpMaWg2QnBUT2Izc0Vo?=
 =?utf-8?B?WHBScnFSMkpSQThxYTFmSWFTZFBqaldlcHpwOUVoeFdHNjJwa2RmTmw2MGdv?=
 =?utf-8?B?ODRaTUFvVGhsc2JydWlHVTdIaXZSZXZ4N3NweGR6K1lBWTUrWldwWVNWQlJ5?=
 =?utf-8?B?Mm9vRk5zQUlXYk9zSlkya0k1K3pReDVyQnhvbW5wNzl6Q1pESHBVY1VLVWZk?=
 =?utf-8?B?VFJuS3M0aWlFbTE3N252ZFY2TXRoaVBZV0dUYkZ0SUh6aFVSeTlDakh3bCtL?=
 =?utf-8?B?cW9EQ0gxMVFTeGl5V1QyRk5ROUZmTkJDSzFPRExVQWdEL04xNTRKTlNwY0gv?=
 =?utf-8?B?ZisyQzJCdzc0RXNVNnRHRmlDa2cyL003WC9oRVJLMWVuK3dIU1lLV0xlanBt?=
 =?utf-8?B?V0xMNDd0d2FScGpvZDBjVXkvOXNtdDh4TG1ESkd4YXZPVkhORUlKbUhzVGhY?=
 =?utf-8?B?ZldjWUhRQXBkeHBhV1o1SVl0UG9ZNW9GcXVSZUpZbjdNTVBsekM2OFdwSit3?=
 =?utf-8?B?RHpjNy9Pd3NJQmRVeWNFSkROMS93d2tCU0ZWRXlIR1o3U0hUNEFFaUI2Umg5?=
 =?utf-8?B?R3dqYkY5WWtLSEpEbEhsOGhsb2VXM0RiSGJRYUFIY2dTOHBaVnQrYTFnUEs4?=
 =?utf-8?B?RDNpT1NyaDNPMzdHWURndjJxeXNFNTJETnZqWlYzSXdQUkRuaTZyQzRMeVVY?=
 =?utf-8?B?LzJwOFplRFpHbG1talpDZmRSNTBjaHdnWmptZFo0NzZ4ZTdxSUpCR3FPQ0I0?=
 =?utf-8?B?ZFkrZ3dxeUU1cThhK2xMOEVKM3JCSjVVeE1ZNjhxOUh5VXJ4QzVzaXJyaXEr?=
 =?utf-8?B?ZVdKazBHU3BpWFpjMTBsRk1hNDBKYStBYUFmcm1RUnNCcEcyWlB4NmJId2Ru?=
 =?utf-8?B?THJwdndvRC9hajJ6c051YTkwOFEzYi95WG1Dd0RvbU44NGFwZzlwcVBUcGYr?=
 =?utf-8?B?RFQzdHRWNXEyMVg0S0k5WHhkc1lrUVNDTmYwMU51WC9tY09aQmVPQU96THdk?=
 =?utf-8?B?d1A2amhkK0x6NEdmRklZY3lmK2hzZzI1dXI3bFNsdTN0MnVXY2dDTU1iSEhK?=
 =?utf-8?B?WGVrRHdaRlFXTDJlSFI4TUZXcllqdk1Mc1VEWW1mNW1hZEg3UWFzZ1loeVlF?=
 =?utf-8?B?SzJxYnJlZzlUMjBLOFMxbmdvWHFsS3haYWI2ampUVC9IS3BXTGhXZGhSL0tK?=
 =?utf-8?B?RVVlMUhKQjczUks3eXNBOU1nVUd5RWtiTldFM0wyQlZvendRVE1vL0lvV3FZ?=
 =?utf-8?B?djY4dWlXYWpFT3FZd0IzeHZ2c1plbDc4KzNpT1FwZlkzeTV0TmliRG5hMnZv?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d5444-3387-49b3-7fdc-08ddba4e4d94
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 16:26:02.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4Vj5MQ/7Lf2gvxVJCBDFZVD1VIaDlS67VBUtTwkTni7Ti1ZGDo7hy8BDXgKHfme1rpim8006ggjmu9E8VuEXgJc0aAlDk1ehdgYlML0b0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com

--------------w6QO5d10M4tmp4eGzaXsp2i7
Content-Type: multipart/mixed; boundary="------------i35MhPXuODhiRcR1TZvSdt5v";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Message-ID: <72331edd-8e03-4415-ada2-2be8fbee922b@intel.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
 <xmqqzfdnkdx6.fsf@gitster.g>
 <20250703154047.GD1309870@coredump.intra.peff.net>
In-Reply-To: <20250703154047.GD1309870@coredump.intra.peff.net>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------i35MhPXuODhiRcR1TZvSdt5v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/3/2025 8:40 AM, Jeff King wrote:
> On Tue, Jul 01, 2025 at 10:40:21AM -0700, Junio C Hamano wrote:
>=20
>> There is an early exit from the function that would bypass these
>> clean-up.  Perhaps something like this on top?
>>
>>  builtin/send-pack.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git c/builtin/send-pack.c w/builtin/send-pack.c
>> index b28da7ddd7..6ce9f6665a 100644
>> --- c/builtin/send-pack.c
>> +++ w/builtin/send-pack.c
>> @@ -305,9 +305,10 @@ int cmd_send_pack(int argc,
>>  		flags |=3D MATCH_REFS_MIRROR;
>> =20
>>  	/* match them up */
>> -	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
>> -		return -1;
>> -
>> +	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
>> +		ret =3D -1;
>> +		goto cleanup;
>> +	}
>>  	if (!is_empty_cas(&cas))
>>  		apply_push_cas(&cas, remote, remote_refs);
>> =20
>> @@ -340,6 +341,7 @@ int cmd_send_pack(int argc,
>>  		/* stable plumbing output; do not modify or localize */
>>  		fprintf(stderr, "Everything up-to-date\n");
>> =20
>> +cleanup:
>>  	string_list_clear(&push_options, 0);
>>  	free_refs(remote_refs);
>>  	free_refs(local_refs);
>=20
> This made me wonder if the remote_refs out-parameter is valid after
> match_push_refs() returns failure (especially since we do not initializ=
e
> it at the top of the function).
>=20
> I think the answer is "yes"; it is both an in-parameter and an
> out-parameter, and will have been earlier set up via get_remote_heads()=
=2E
> So even on the failure case, match_push_refs() will leave it untouched
> and it is still valid (and needs to be cleaned up).
>=20

This was my assumption too.

--------------i35MhPXuODhiRcR1TZvSdt5v--

--------------w6QO5d10M4tmp4eGzaXsp2i7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGavGQUDAAAAAAAKCRBqll0+bw8o6OEl
AQDaF9onHQxukN1uUj5mauS00g8nhdm2sQg/4bOp24WR/QD/bK63rUXkZbuKZq3PAXR6jXP9288S
2kAhhoXzf/e1wAE=
=s2if
-----END PGP SIGNATURE-----

--------------w6QO5d10M4tmp4eGzaXsp2i7--
