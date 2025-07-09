Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65AE55B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103487; cv=fail; b=rCdxh9rlkI7WXZ81+qDqrK6Z9POHpMQRUA68QcsVG6IG4Xt95ujG2Qg+0L/nnu4XVT4gHhkD6+Zwwu+eLUsI81fAWe3YivrIOedjDg2CH9h04CDUEcQrVFm8hghI26qmvUlWkOKst0FgzmfYpwbpj0yJvUM9bM0Sa4Uu8Gbc3Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103487; c=relaxed/simple;
	bh=TAMZX7jsHYqmEG2MlsbGYPeUn0YKpIgf0OoX697rROU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bB4ztImq7hkZMVIwnIrP5p9Sszqqftl61SxphwOaM+TS8jiBVH7LyYFkGEbf6RrBW5iy8HJigYDliVvH2Ue4NpJRgOGJF67dPMdPct3b78EbobDncIqtR6ayt3xzEh48qZjLqRE69s/hNX9qcfCHJWpdpjZxpkkROA1PoodQaFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGOokljT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGOokljT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752103486; x=1783639486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TAMZX7jsHYqmEG2MlsbGYPeUn0YKpIgf0OoX697rROU=;
  b=aGOokljT/VYav9WZ1uCinswlBg+/7UkCT6FxU894gwqd4s41gu4oJMsc
   +QLST02vu/lERfw1kkwwGuDZZ/mL6LyzSZVQTtTL63JlAgA7tde5LmPlN
   4Z3wXJuRk/T4L6b4h5A8jwlyggX+xhsznHMd7xpkJ8N9dpOJ/Ve+94p77
   aORc9RmvZD5R6EAi2Fcitp8/OezTRWoR59MXQarMA/mNrgEY3I4s2No0q
   tmPc4glr29hhHuoYY3nO+d6VdYMV8dC9HNMkk2z13AJfvHppujYOFBb4A
   FX7Ava9jF8ILvrSvDbVGyrow5fd/jgshyEfNe47QEAyKHn83HEpsNwLJp
   g==;
X-CSE-ConnectionGUID: zcREqVW7Sfm7dEh4J/fC8w==
X-CSE-MsgGUID: kW6CbyH3QPm1UzmYIhTXXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54251710"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54251710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 16:24:45 -0700
X-CSE-ConnectionGUID: DSBKy/gNTg6lDwYRwIHEgQ==
X-CSE-MsgGUID: x9HdDxr8TY+yPK1jq0YTaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="155667655"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 16:24:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 16:24:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 16:24:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 16:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6oMDvmdbiXh7sTZLzSX8+72rZ3vDXiJqLC3PgZq6lVX050XP4LMk1a1iS7qIEGi5ySKEAVDJQj0vhwQi9xwLaGQFOHbmci+QXf6mTk3hfn8CeJg6uY2rd2a+CYtNIEgcCKqRB/PWZ8CeuiIYby9IF43gkowQVCcoZu3sdYd5neE3Qva7p7J/n1xi3CIydpbU7I8ySYF0n63Za6H+W2qUSDHEP4E0Z3v0tMfYp5AMxF9qcY3PSmv4PtVzQbsXg3hjjfXOfOdvwRXrVcEkpcM4l9JR53Ja9lUO3eeJDtCcrFS5t0Ie0LiAmNEWiBBbTiN+O2//Dhe4CAOV5tVT0blFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAMZX7jsHYqmEG2MlsbGYPeUn0YKpIgf0OoX697rROU=;
 b=LUbc81e8fol6nDVghaE7LcqiXC6KHWMJd7ai88BfQxPHmIj0h2JDgch64UMObiOik3f6QOCSSXUVec+QpMyLV1Tbam927Pyf+1t9vY/9ZSmbqJoSJRhN28jgcxa/lXcADkFyXvvjceipTsFiP3pXPtER0mtprC48+YaGb2AHXHAV9YW3QqA84VhuvW8m6BkKd2aFoqTQRH2AtOBCcgWcS0Hnzza9q8Qu9wMYSPmJxW9SfXGaotyDPiAmlDMnVSB15vBf5lmYVrCWjkGghs9zBrvPLsTj/3HUPbP5Y4TXmeEKmMYd2YJDM3OG1ac4mxPlE/WEzbE6mThxH0xjJqhiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 23:24:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 23:24:15 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, Jacob Keller <jacob.keller@gmail.com>
Subject: RE: [PATCH] reflog: close leak of reflog expire entry
Thread-Topic: [PATCH] reflog: close leak of reflog expire entry
Thread-Index: AQHb8RtxHcDNvBucCU6kGpSwFcCRhrQqYbUAgAAM9bA=
Date: Wed, 9 Jul 2025 23:24:14 +0000
Message-ID: <CO1PR11MB50898FF5DA67F4F6A474CECFD649A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com>
 <20250709223650.GA2046725@coredump.intra.peff.net>
In-Reply-To: <20250709223650.GA2046725@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MW4PR11MB5774:EE_
x-ms-office365-filtering-correlation-id: 502c6d6f-ec56-4171-0987-08ddbf3fb829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RE1jRHlxMk5yZnQ1QmhFdktSZVNyNHJSWjNodWFoclZrTUY3UmVKaDZkVTR1?=
 =?utf-8?B?Wk04Q0xaemtZa2hhVSs1NUxkcFM4M00xNnNyMVRmK1Vjb09sbzhyU3JUWmsz?=
 =?utf-8?B?T0tETTRQV1lhY1VEVjZCZ0lKN3dmczBtd1NnSW5XZDJybGlJNmUwZytUaEEr?=
 =?utf-8?B?UlRkUWhQL1RlT3E3bnY3VklnYU5KSUVxNVBlck5jTDlJbGJueWcwZHRiNHps?=
 =?utf-8?B?aDBJNXJKQWxQakJzWXg5cjFGQmoydy9XR2VhVmFOd1lHNDhIM0locnhhRkF3?=
 =?utf-8?B?UXZiOVpDYk1nYVFDd2NuZ1YxNVN5YWVNN1N4TVRSUFlHdjlHZkxqSk4rVW52?=
 =?utf-8?B?ZG1xYmIrZXdCSmkzNUxTZS9iOFF1SDRZWTVYeEU4NHdOdVBSYTVBR2JZWDZa?=
 =?utf-8?B?bFVSN2pDYlVSeEM3dzFRSHlMSGQ1NWQyS0d5SjhWbzUzNE9NN2g3ZlBpaURj?=
 =?utf-8?B?NWJ1RVB3b0tETFNXRGlGRFh2cFp3cENUeGVnc2dMRHJqdkcvWUJuTThPOFJs?=
 =?utf-8?B?U3lReHJKR2g2ajk2TGwyQVMwdjgzWWx2SW9IT2s3bkFEbUxxRG44eFdqTVNm?=
 =?utf-8?B?NkJrY1UxSlBlVEpaWVlkT1cwZ2lLU0RiY1lvWFpuQmZqVEJhallUNnlGRUdi?=
 =?utf-8?B?RzVYYnlCVjNseWR5WHR6dmZjZFRQVkhoTTFmMmVJdnZnRzZoa2k5cmhnSE9n?=
 =?utf-8?B?MFFmS2Ftb0cvRGY2V3VndFlCdmVBN3F1TjFjTG0zUGxQbzZhN2s0MU1CVklv?=
 =?utf-8?B?ODRlOFJacXRqWXVVbjhaa3pxV09ON0Z3ZjA1ZXNPZWVHNUNKSWpoaktPRXV6?=
 =?utf-8?B?M3hvdWdZU2V5ci9LUWhFNHYxMWR0MjRFVldiaCtOTE0yblMrN1BoV2V0QUhT?=
 =?utf-8?B?VEduOWVva201K0ZzdEVZdE9GTW10UFpudDNlMTBsbWJ6YXB3alVCMVN5a21P?=
 =?utf-8?B?T3VnUDd0ZGpnMjhBK0tFSytlUzFvb3pQRGNCNDhNakpGWE85Q0FGTThEK2lB?=
 =?utf-8?B?dTNTS09xWWNGVElUS2VLTmtNREpVYUZvRFNXQk9qUGJualYvcFpLOGt5Sms1?=
 =?utf-8?B?cVA2bVZxb1NxRHJDZjFZZ3U3ckhOdGwzTE9zb2g3K0pIRzJjb3ZDNVJQVmtQ?=
 =?utf-8?B?aUxUeGIyV3poeCtXVVlnZ3pLbUNkYk4yQzNVR3FrSHBJa255YVZ6cmJPd2NM?=
 =?utf-8?B?bGl3VUZ1ZnBKT3dqTUd5dHVGbmRnOXFXYWdVMyt4Y3dTUTVNUkhNZ0NNS3lj?=
 =?utf-8?B?SE1sdWRtUkM3NlpWRVJCaHB2YUNSMWJOVzYwS3lFYVdocmpkemxXQW5LbURT?=
 =?utf-8?B?VGtWWVYzbmhhZUhKaG91SSttbGtLMWdvREtWZTdtRXZOVmx5K0hFeExMbjNE?=
 =?utf-8?B?TmNablBTc2ZWQWlMMXBxa25TbVVrUGZ2MkkxNEZFNFBoR0JUMnJGMnB3Y0Qx?=
 =?utf-8?B?c2xaOW1aT0VMVkNPWExlSGRhRTQyeXl6V2J3bUlOVk0wNFJsaDJWYnNOUUhy?=
 =?utf-8?B?UFRLSEUvazdOZmZ1MnYvMlpGYXJDZ0VLWVExcTgwT2ZOMGxxU09UV1YvUEto?=
 =?utf-8?B?Q2hzWDExYmthZDVERnBhVFBRTmJidVlSY1lsdktDc2dSU3NIV1hYTmlPejRv?=
 =?utf-8?B?UGdIZ04yaXUyTjZzZW5PQWRrYkpSU0tXK01hRjJZZVR6elNYUVRxVEF4VHp5?=
 =?utf-8?B?RUVlUGtOQTNONWxRcXZqbmc1czB2ckp4RTlmNnFhSXhwUXdPd2ZoMCthSWw0?=
 =?utf-8?B?SGNSd1JnUUFCVUo1OFRxSTNKOXBuV2hJeW5Eczg0cmNvQlpnRDdHRkpRUW10?=
 =?utf-8?B?aWRzSVZLSGpnWkpaLytTZFJVYzBwZDhjTEg5K3pkVlZDbk5kOHl2Vy9YeUJI?=
 =?utf-8?B?RVUzTDNwa3hBSFdyVGNrZzZZUFFQTlp5cjAxWkdnWDFhL0JlVHNmeDJ5dFFK?=
 =?utf-8?B?MGJpSjZOb0hDWDZJZXRsd25SRm5QcGlRMUpJdkRNaWh6ZTZncmlTdXBkeStV?=
 =?utf-8?B?VE1mT3NIMW9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRKQzJZUlFYb2RkL2NGY1psd2h5Tm5adUdud1k4VC9BS0E1a3RoNWhza2xZ?=
 =?utf-8?B?ZVp4QzBRWDkreWNOTXo1NDJ1VUdkczNRVS81WlQ1dVIvdklwUmNicEduT2N3?=
 =?utf-8?B?UXc2QSszZ2dveERGa3NnSys3cTRUNEgrdm43cGJ3OXlCVTZIb1N5MUhPUHJh?=
 =?utf-8?B?ektwczVwd0NsSXNJZ1prSk1HMkNldEp1T0FPSUxhVmVheUgxVmtkNitNZC9D?=
 =?utf-8?B?TUJrV3d0cWVzemRiQXc2SFFCNXMwU29SOEx3UkhtWnVxdGVlS0pFdG5aSG4x?=
 =?utf-8?B?eS9aY3hDYnFUV01QRGlkbi9qOTJpRGxKY1I5OUJvK0JTdEd4WmNab2tDVVNv?=
 =?utf-8?B?M3pNL1lKWHRIMzFmdjJiaEZDajNRY1JzMUtpbVJrb0RjSkMzYnRuOCtCR3FF?=
 =?utf-8?B?TU5hSURvNzJCd0xIM1JhQ2pvWFVVS0w0dHE3dlB6WjVXWDhEZGpwNHJaNE9Y?=
 =?utf-8?B?Q0ZJSWJMLy9NSHZ1RTZwR0xQOHlUSmxLV21SdVVlOS9iZUJjWGw5RXErazlz?=
 =?utf-8?B?N3AwN25jRmlyZ1lodmVaRHhMdG1sNC9IcUZqYnZxMDFlV0I1bkNpcEpmK0Yw?=
 =?utf-8?B?cWxoemF5MmFyNG84cFNMcDZqOTg2aTVjWExZQ2dDRUVqSytSVFJGTGtYeVVu?=
 =?utf-8?B?ci9yb2dJcG1PZlp0dGtoQnE5Q2dOTUdCV0dCUjdWVHBPSzU1TnhEK1hLdG5J?=
 =?utf-8?B?QThhSzE3K3Vjb1hBZjFsWG02ZVdiNkZoU0taamozMHp1MzZLZG9IdHZUQWtS?=
 =?utf-8?B?QVcvRWJNUXFqbUhyM1RjMy94dmVpOFlSOGo0dHh4dGdNSlRBem9FY1BzVjlB?=
 =?utf-8?B?c0QxeGo2ajRLbUFiOWxmaUVMOVRScFpVd0lSWWJjb0dzb0dPWmx0cEJCYW1p?=
 =?utf-8?B?Y1F4aVFYUHkzWFhUZjdrb2lvZkppR01wS1BtUmZ1a0Z4TUFGTUo4YS9rR1g0?=
 =?utf-8?B?aGh2Z3pTdGNZaHp1Rlp5SlpEQWpZS1Z5UUU4ZXQ1dkQ5bmJXR1Zidlhzbm1z?=
 =?utf-8?B?MlFER2VWS3l4ZUVZUGFFSC9pb2Z0RW5lR056djkrbXBOR2JIaytaNjJMSTlO?=
 =?utf-8?B?V2JWKzR4M2J4RE1hSlVHaTY0RnNpNkJQZnhxWGFvemFBQ2ZxdTZoQ0FWQTdN?=
 =?utf-8?B?Q0VOcFNZY2hSTnBkWlhGTTBXa1RRakVMRUZGV1lmNWxSRkh2WjZ3U0FLUThR?=
 =?utf-8?B?TVJaZjlPY1JzWUdJTFEyUnNkdmVhN01LekNmZHRFRGU3YlJVU3NqM3dqNlI4?=
 =?utf-8?B?dWM1ZnVJb3M2MXRveStvazFIYnVxVk1ORlNIbzFFdFNkWndtYjdUQzNIRGRN?=
 =?utf-8?B?WHlUTW9BelhSRFNvTEhqZ0NNdFZ6R2d6WG5TaTQxeHdkYlZEcERka1FVL0JW?=
 =?utf-8?B?ZWVrZVZQcFRRZkYrWUsvRHFuMTFxZFFSTnd3eG91WnhHMndobnZaYmNNRGR4?=
 =?utf-8?B?bjBDL253dUVWeHhLVUN6dThSamxLdmtYTUhkblprNUQzTlA0UHZJVEtLczVH?=
 =?utf-8?B?T3pGMEovd2pWejhtSDRBWlBrV3M3eEhGY3BCejZRdkROYkQrdzlqdmN2TXZY?=
 =?utf-8?B?cVFQZXVjOGEzajN3ZE14dkFCNmhRWWFrckVURG1ETzZtQjVCRU1xMlIybmhY?=
 =?utf-8?B?UjZZRWxaWFpSZ0pVUWxTNGQ3M05TdGd2cTNhcDNHMFlEVDJlalM2YWxLUzJm?=
 =?utf-8?B?SnRnVEtBU2wrUmwzckV5TjJYQzcrNXJVTk9TUjU5VFdhOTlJYjNOZ0tSaHlI?=
 =?utf-8?B?NmU5UldZQjAvUGk2eEc4Y1dLYkJEQkw5MlI4WUd0UmNRT2NlVFdFbE5lZGxi?=
 =?utf-8?B?SDgzM2c3bzV6YlN2YUZ2K2R2SVFlTEpLSmVoVFJtZTRCZ3lhUEIzVUdZZW9P?=
 =?utf-8?B?NzBCZ1JHb3hLREJFV1ZMQmZYZUFlZ2F0NkEwbGgwaW8wQ01lMkRtd1kxVDVz?=
 =?utf-8?B?YXlscGUzZFIzZTV1WTR0NWJCTmhiaDlYZzhxSE9KdTFmYnZhN0lwZHlCc3Y5?=
 =?utf-8?B?OHhRNU4rUWd2V254WmtIUDg1U3dCaHY5WWtidlRCSTFrSzVpOXdZeEhVeHdp?=
 =?utf-8?B?MzNjM2c2NDlqN0lBWkJ6a2FBMXRhZUNVTVgrbjBoR3FqNVV5V252SjV1NmN3?=
 =?utf-8?B?NEUyaE9RWW1BNURaUWp0Tzh6N2VZM21wYkYwRHVmMnVjMW1IdGM3TXN0TVZs?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502c6d6f-ec56-4171-0987-08ddbf3fb829
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 23:24:14.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiwIqBvUt6asqYuvLf4qEEz7+yrkV0VXEpeBCEBRZbHKkplKfiXBWf+ko7mMyYcBva4nPTnyILVZ3K7glu8RB5t7LOXhi0twGBoV2U6zWDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIDxwZWZm
QHBlZmYubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgOSwgMjAyNSAzOjM3IFBNDQo+IFRv
OiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gQ2M6IGdpdEB2
Z2VyLmtlcm5lbC5vcmc7IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT47IEphY29i
IEtlbGxlcg0KPiA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcmVmbG9nOiBjbG9zZSBsZWFrIG9mIHJlZmxvZyBleHBpcmUgZW50cnkNCj4gDQo+IE9uIFdl
ZCwgSnVsIDA5LCAyMDI1IGF0IDAyOjQ5OjE0UE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90ZToN
Cj4gDQo+ID4gZmluZF9jZmdfZW50KCkgYWxsb2NhdGVzIGEgc3RydWN0IHJlZmxvZ19leHBpcmVf
ZW50cnlfb3B0aW9uIHZpYQ0KPiA+IEZMRVhfQUxMT0NfTUVNIGFuZCByZXR1cm5zIGl0cyBwb2lu
dGVyIHRvIHJlZmxvZ19leHBpcmVfY29uZmlnKCkuIFRoZQ0KPiA+IGZ1bmN0aW9uIGV4aXRzIHdp
dGhvdXQgZnJlZWluZyB0aGUgbWVtb3J5Og0KPiA+DQo+ID4gRGlyZWN0IGxlYWsgb2YgMzkgYnl0
ZShzKSBpbiAxIG9iamVjdChzKSBhbGxvY2F0ZWQgZnJvbToNCj4gPiAgICAgIzAgMHg3ZmY5NzVl
ZTY4ODMgaW4gY2FsbG9jICgvbGliNjQvbGliYXNhbi5zby44KzB4ZTY4ODMpDQo+ID4gICAgICMx
IDB4MDAwMDAxMGVkYWRhIGluIHhjYWxsb2MgLi4vd3JhcHBlci5jOjE1NA0KPiA+ICAgICAjMiAw
eDAwMDAwMGRmMDg5OCBpbiBmaW5kX2NmZ19lbnQgLi4vcmVmbG9nLmM6MjgNCj4gPiAgICAgIzMg
MHgwMDAwMDBkZjA4OTggaW4gcmVmbG9nX2V4cGlyZV9jb25maWcgLi4vcmVmbG9nLmM6NzANCj4g
PiAgICAgIzQgMHgwMDAwMDA5NWM0NTEgaW4gY29uZmlnc2V0X2l0ZXIgLi4vY29uZmlnLmM6MjEx
Ng0KPiA+ICAgICAjNSAweDAwMDAwMDZkMjllNyBpbiBnaXRfY29uZmlnIC4uL2NvbmZpZy5oOjcy
NA0KPiA+ICAgICAjNiAweDAwMDAwMDZkMjllNyBpbiBjbWRfcmVmbG9nX2V4cGlyZSAuLi9idWls
dGluL3JlZmxvZy5jOjIwNQ0KPiA+ICAgICAjNyAweDAwMDAwMDZkNTA0YyBpbiBjbWRfcmVmbG9n
IC4uL2J1aWx0aW4vcmVmbG9nLmM6NDE5DQo+ID4gICAgICM4IDB4MDAwMDAwN2U0MDU0IGluIHJ1
bl9idWlsdGluIC4uL2dpdC5jOjQ4MA0KPiA+ICAgICAjOSAweDAwMDAwMDdlNDA1NCBpbiBoYW5k
bGVfYnVpbHRpbiAuLi9naXQuYzo3NDYNCj4gPiAgICAgIzEwIDB4MDAwMDAwN2U4YTM1IGluIHJ1
bl9hcmd2IC4uL2dpdC5jOjgxMw0KPiA+ICAgICAjMTEgMHgwMDAwMDA3ZThhMzUgaW4gY21kX21h
aW4gLi4vZ2l0LmM6OTUzDQo+ID4gICAgICMxMiAweDAwMDAwMDQ0MWU4ZiBpbiBtYWluIC4uL2Nv
bW1vbi1tYWluLmM6OQ0KPiA+ICAgICAjMTMgMHg3ZmY5NzU0MTE1ZjQgaW4gX19saWJjX3N0YXJ0
X2NhbGxfbWFpbiAoL2xpYjY0L2xpYmMuc28uNisweDM1ZjQpDQo+ID4gICAgICMxNCAweDdmZjk3
NTQxMTZhNyBpbiBfX2xpYmNfc3RhcnRfbWFpbkBAR0xJQkNfMi4zNA0KPiAoL2xpYjY0L2xpYmMu
c28uNisweDM2YTcpDQo+ID4gICAgICMxNSAweDAwMDAwMDQ0NDE4NCBpbiBfc3RhcnQgKC9ob21l
L2pla2VsbGVyL2xpYmV4ZWMvZ2l0LQ0KPiBjb3JlL2dpdCsweDQ0NDE4NCkNCj4gPg0KPiA+IENs
b3NlIHRoaXMgbGVhayBieSBmcmVlaW5nIHRoZSBlbnRyeSBwb2ludGVyIG9uIGV4aXQgb2YgdGhl
DQo+ID4gcmVmbG9nX2V4cGlyZV9jb25maWcoKSBmdW5jdGlvbi4gVGhpcyBmcmVlcyBib3RoIHRo
ZSBlbnRyeSBzdHJ1Y3R1cmUgYW5kDQo+ID4gaXRzIGVtYmVkZGVkIHBhdHRlcm4gYXJyYXkgdGhh
bmtzIHRvIHRoZSB1c2Ugb2YgRkxFWF9BTExPQ19NRU0uDQo+IA0KPiBIbW0sIHRoaXMgY2FuJ3Qg
YmUgcmlnaHQsIGNhbiBpdD8gVGhlIGVuZCBvZiByZWZsb2dfZXhwaXJlX2NvbmZpZygpDQo+IGxv
b2tzIGxpa2UgdGhpczoNCj4gDQo+ICAgICAgICAgZW50ID0gZmluZF9jZmdfZW50KG9wdHMsIHBh
dHRlcm4sIHBhdHRlcm5fbGVuKTsNCj4gICAgICAgICBpZiAoIWVudCkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtMTsNCj4gICAgICAgICBzd2l0Y2ggKHNsb3QpIHsNCj4gICAgICAgICBjYXNl
IFJFRkxPR19FWFBJUkVfVE9UQUw6DQo+ICAgICAgICAgICAgICAgICBlbnQtPmV4cGlyZV90b3Rh
bCA9IGV4cGlyZTsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2UgUkVG
TE9HX0VYUElSRV9VTlJFQUNIOg0KPiAgICAgICAgICAgICAgICAgZW50LT5leHBpcmVfdW5yZWFj
aGFibGUgPSBleHBpcmU7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICB9DQo+
ICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBTbyBpZiB3ZSBmcmVlKGVudCksIHRoZW4gd2hhdCB3
YXMgdGhlIHBvaW50IG9mIHRoZSBmdW5jdGlvbj8gV2UnZCBzZXQNCj4gc29tZSBmaWVsZHMgaW4g
aXQgYW5kIHRoZW4gdGhyb3cgaXQgYXdheT8NCj4gDQo+IEFuZCBpbmRlZWQsIGZpbmRfY2ZnX2Vu
dCgpIHNlZW1zIHRvIGFkZCB0aGUgbmV3bHkgYWxsb2NhdGVkIGVudHJ5IHRvIHRoZQ0KPiBsaXN0
IG9wdC0+ZW50cmllcyBsaXN0LiBTbyBieSBmcmVlaW5nIGhlcmUsIHdlJ3JlIGxlYXZpbmcgYSBk
YW5nbGluZw0KPiBwb2ludGVyIGluIHRoYXQgbGlzdC4NCj4gDQo+IFByb2JhYmx5IHRoYXQgbGlz
dCBuZWVkcyB0byBiZSBjbGVhbmVkIHVwIHdoZW4gY21kX3JlZmxvZ19leHBpcmUoKQ0KPiBmaW5p
c2hlcz8NCj4gDQo+IC1QZWZmDQoNCk9oLiBZZXAsIHlvdSdyZSByaWdodC4gTXkgYnJhaW4gZGlk
bid0IHF1aXRlIHByb2Nlc3Mgd2hhdCB3YXMgZ29pbmcgb24uIFllYSB0aGlzIGRlZmluaXRlbHkg
d29uJ3Qgd29yay4NCg0KVGhhbmtzLA0KSmFrZQ0K
