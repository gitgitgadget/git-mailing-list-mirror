Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194F1E1308
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402201; cv=fail; b=J81i9FBlsjE7kFLCXrLjwyM4P3+dXh0dXwTAZbDx3wwzW2pQUGU6dfSFifJJmXcL4ldXlw/nsL8bZlfWJtaXI9f9cK9CxiBmu5vmBiIDthIxTjMQu2qjiP4HAmN2Vej5KyV6lWlbL96/HwtG2M/xboCuXJtJiGUIZz4CA49J1RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402201; c=relaxed/simple;
	bh=hKxb2vaj1vFZaoblBQ2HDDDkrmwPCsQxE0p+Nh34BO0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nbq2UC6MQA1S6kyYX35MbyryTBANyEBarwy0Bz6EpS1gZhypIwez/Sh0jTx+oO8uZcnuJgy8CDALeVcn8XSF4NASDDXS//6eHrAcppd07m/5v8GyFlHNoL92nOifj7E/e73adp8GW2m5LNQ+Xi6ajOUgRjCyZwsKwlXfmvOUbS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1/iBow6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1/iBow6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751402199; x=1782938199;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=hKxb2vaj1vFZaoblBQ2HDDDkrmwPCsQxE0p+Nh34BO0=;
  b=c1/iBow6ATe+Q/ET4iKLt9EdPoD+03FKt4gKDa4gWtp89QNBKS8qMFXI
   8acbQ+gJfuRLW3xd14u1mQwQJF3N1IZl0B4thazyecVPLwxXLiZYKSzk3
   /+L4gIXKiTQMYDh2gFrIJuUFosZh1mlE755yK0H9omNbVnHXoP7IibmdA
   D6pxurCVLPZmEtEOBCZDRhgnUD/4YW9avydakDJbnxWvUNtvxlFX2oiSE
   Qq5V0m1GsGELLUKHXxgsg3C9NEUtMQxoLc00An5JSg93juZyyI8DUijw3
   fCicLbL42XvTQ583fsv3ZFaPdhZNLGSOCkxl+l1z2dX//289mYDE2L3Mi
   A==;
X-CSE-ConnectionGUID: WTjBrHo9T/K/msYDP7wCew==
X-CSE-MsgGUID: L0wK5+b6RO2igRRVOyw75g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57493866"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="asc'?scan'208";a="57493866"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:36:39 -0700
X-CSE-ConnectionGUID: +BmNMsxOTkmH4bLNE067fw==
X-CSE-MsgGUID: K81Oo6IhTZ2IJvzJPPF8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="asc'?scan'208";a="154413201"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:36:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:36:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 13:36:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfY7RBdsHSjY1Ic/Fv7XInfAwf+k0iENLAK+k0Sne+0pUdCo5oi5TE5tc9mws+NyEyjgm2oojylO4Efu9r5f2u/09JQ3axbaVxUacxG71eSuUYT1lkbLCpLtBLSDa/LzrefsSvzYZd7CfDSJxNOkXbr6wRUNV0CYYZevZR7iV/4broMn1sjyO1pDbYcPUJOmTQMXz/HmD149zlYS7tQAo7vtdNDgipvnoQyjJ1MjU1+MRtzINhrvdLScuc+xYs01d0ohYYMbkxkGO999B1yBz2IZ0sgfuJDrCciMu3e7qaSy5Q91febyTnlwL9JukGMsp/Jc7gCAI38bqMAq5xcwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFkz9ZGjHQPPlKwCuAsuO2sT7uT9jyTqmVBRhYSXaDk=;
 b=En2JBCDaeEGquiEzGRnwRXOGr2nFGX1yFfntE0vPbXJiBir1glaIlKXoobyBTGuBj9Gf4YRTx2stezRfnGUO0A352j5EkZt39JaxjjrvazgJHvOdQPC6MSk4mjm/1oyahTQ9YluU6dlFJKUqAKcm7VatbWhIu0cUDsGQKQOAH+o+p9K2ugIvjFldbCSL6nJ2lYjH9E3iUp7pz1OGgreWSMRMVn45XB+VsskZEva9opRGgY0EOmoMFCpA9euEMn1LDpF5Q8qhhDYyA4n9XYv3kQToBVaCiPHlBWpSrXkr4zVTsUru3RDiicHCHJyQvx0xDzImZ0bfLiVdECYYXLyWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 1 Jul
 2025 20:36:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 20:36:31 +0000
Message-ID: <753b6548-9b7c-411a-ab39-adbf769f83bd@intel.com>
Date: Tue, 1 Jul 2025 13:36:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
 <xmqqzfdnkdx6.fsf@gitster.g>
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
In-Reply-To: <xmqqzfdnkdx6.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------m14d2WnyJtp8ZovfVkm0iZy5"
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3140a9-9338-4d85-70c5-08ddb8def65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0pnVVVnZWlKUjNaWW9hM3dJMEoxM0JwZ1BGSUFKYnJFMnoyL2cxbjlmY2x3?=
 =?utf-8?B?L2w1Z2U3aVl0SjBNaCtiM0M0STZIdU40b2U4Zy9HNytVZExQTitiZnZIZ2hO?=
 =?utf-8?B?Vit4bVd1SXFEUy8wQkNFS0xleHFQcUZXNmcrZUwvZW5CSENzbmhSczR5bVJG?=
 =?utf-8?B?M3kvcUxUUndNRmVVT3o0ZWsxTGNYb1lVMUlKMzFlV203QnR6eVdjejJvS3NN?=
 =?utf-8?B?R0ZtZnRhUEFXUWR3RnplM0NGZFlEbG01NDI0QUhDVWIyZnJHZzlWUjZJMzRS?=
 =?utf-8?B?cm85Smh0c2Y5Q3V2aGRrWlBiNllKaGltaU01M3piMi9NV08rRmJTVW5raFZt?=
 =?utf-8?B?d2ZFWVU2cVdMTjZUTDg3aGNSRzZhQ2t0ZC9kR2xuY2hhckhVRWY2RW91d25B?=
 =?utf-8?B?VmFNWlVwZkZqS29EU2Z1NWlES0dKV09hcWZjTzkrTGM4Um5WZjdnWjlGRGMr?=
 =?utf-8?B?WnlYdVc5Y2xpNldhQ0hkSzFJMzJjUE9iTlZQeUYwQ1A5SUY4OU1KKy9IREZ6?=
 =?utf-8?B?MVZULzM2VndOWEhTYWh5TUJxUGxMM3REeDhWdnFmQXpjSUsyVFZpNk5XK2pO?=
 =?utf-8?B?V21mWjBZNVZ1bjd4T1NoUmpIaTJEWUpuMjVVeEMvQjd1dGFhNkFmc0oyQTcv?=
 =?utf-8?B?cVcvK25aVFBpRi9CbXdjdUp0dmV4SVhtR0UyZEFSaVJ4Z1E0SC9DZjlwbXdz?=
 =?utf-8?B?cmFiZGZncHQxWXpDanZHNGlKdnhqVnZCblRxTTk4OS83QnQrYjVVOWlURmQ1?=
 =?utf-8?B?SnhEK201RWNXck9nTExuNVEycllsdzJWU2JGMGwyclVNS3lNQUV3WHZTaFly?=
 =?utf-8?B?QWs0RU9SSU1xVHZUQmszUUJ4NjFrVm1qdXdvZlBMOHRHbTFwV2pIV0c4K2xG?=
 =?utf-8?B?ZzF4aHN0T3E2dUxoSU9nOWZiSlJIS29Gc054d1lnUjJ4cldTQzBZbUViMEZq?=
 =?utf-8?B?cXprYWx0SnN1c2tnRkVnVXB3N1dyaXNMRlFEbGtvY1Nwd0VPbzljQVBQZjYw?=
 =?utf-8?B?WXR6Ny9rbXp4a2dlWEJmS0lOU2t5NSsrVkpvbTRZQSt4QU5vVEZidWNIL2RJ?=
 =?utf-8?B?WlR5a2NzNm1mUFFTRlppZkROalVwdElWOTZKSmp1SjZuSGhaWDlubmlzeGVY?=
 =?utf-8?B?VjFxS3ZSSm8zTzE3eGRMNzYzYzJuQmRWUmVxN0hOZlNpWjkxR01yK2F5QzZi?=
 =?utf-8?B?MXRldE1IcGthaTVZQzdDaE1ENWJ5T3IvVlptR0tsaTNKY3V0YlcrQnJ6bkhM?=
 =?utf-8?B?cU5lWG9NS2FRUG8yTVFKYnplMGtVYnlJL2xxZHF1ZklGaDVRdUVVRlVYTHBE?=
 =?utf-8?B?dGRXR2FZbEtSL0VIeWFBQmROWlg5ckptS0s5WjNWVnIydms1MytLL2ZvdFdD?=
 =?utf-8?B?WGFmem0zazF4SHRnNUlyM3BKekpkZEVaa21WOHk3S1d4VzdFNStxMFRvTVNj?=
 =?utf-8?B?RUI2aUV5MFdpQWlMZm9MT2ZwekpTRmVlYXBkS1JlSUlua0RTalpHcHpzSWVX?=
 =?utf-8?B?NjMzV0pMa2k4RGRYVkZjM2p2WUkxc1FodXZIWlFjbFNxZFpxRkVnck1xQXl4?=
 =?utf-8?B?M0NoK3FBRDIvWWFabjI5UVpjV2MwS2tnVWREWXNRZHhvU3lnM1N0eDFQMDdI?=
 =?utf-8?B?SEVoRnlNQ2lpcG9FNGZ2TjdmaHd1VE1ZcUtGTVg2cDBtMlZYOGpWMFVwSXps?=
 =?utf-8?B?Y1ZwWk5QMHFVR2xZVkdieXlKL0ZOR0NoY05YSTJFOUpCdkhBdWVBZzhMQXNV?=
 =?utf-8?B?eXh6VVZhd1BZSTFHVVBqckhFYnU3Z1A0TnYyWWJ4bVdYZHJWVGN4UnJvbU5v?=
 =?utf-8?B?akQxSzgrMGVSSm1ZVlFUdXFkWnk4ZjJNVXlVWjlxdVBYMnF5cGFHVGZFYVJV?=
 =?utf-8?B?Y1JDSmpZTk42bjVmSy9uMlNXVEUyZDdtOVJFVFVYelNIdVB1KzRWd3VEM3M2?=
 =?utf-8?Q?z1A1wQ36Y4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9mdC9TNGo2N25MbWpIeFllaWpEcEF6U0FTTjlZUWIyTWl4bzFBcnMxM0hh?=
 =?utf-8?B?VVhEVm1yWUVQeldYcjJWV3BJM2FXMzE2cWczSW5NdThSNTIzSmhIUkMxSzZJ?=
 =?utf-8?B?OUVPM0FBeE1kM0VRYlJNQm4vYmZvd0R5WnBOVnlwNG9Wam13c0VmdEttY3BO?=
 =?utf-8?B?U2RnNGYxUXZxL1hOOGk0Ni9ZNmdtYkJNSzFOQUxXTDdhRjB2NjZiYnRTeUMw?=
 =?utf-8?B?LytMYUdNT2dHc0RpUThaY0w4UDkxMVovVmtpeDlKZWlnODdjMEdtT0xMU0po?=
 =?utf-8?B?blM2WXd4ZVdCZDZuY1luN0YrUXo1cjVkVXlwa2VkRkZ2TFdjSU9SSElKaWN6?=
 =?utf-8?B?QkNkbU5va1pJemhyczdsZlFDaUVWVUJLdXl5YWdOOGVvUzBQdFZZczcvV29P?=
 =?utf-8?B?UkFKdmh3NEpKMlBkdE1IRE5VVXVlRjcxTy9IazdERHh5ejdpcVFkWmpjM3dX?=
 =?utf-8?B?SDJydngrRjRUemdSaFBFdG1kS1hzR1VNUndzNlRIeFZ2SlM5bFY3U0hOZ1hi?=
 =?utf-8?B?WkdIU3B0SThKTUJCdThvMDc4K0xjVDZSY0R0QWdVQWFCK2x3dnZCaFVRVG9V?=
 =?utf-8?B?Y2IwZ0xDZnFJS20zZUxLMmdid3BzUW5oSVg3SVY1TWdKOWNZcmsxL1JGaEs4?=
 =?utf-8?B?VDZJa2x3SlJUNVQ3ZTdPWVlhelZ2S01yWXNoWVc2WDhBWTRvUm5OS0ZTVVN2?=
 =?utf-8?B?b2loUVpjd3QyRDJSczIrQ3doNHVPUmZxY0Jpemhqc0R3UHNHLzZ3RExPOHdh?=
 =?utf-8?B?MngwUlJSVnZrRVRrYkRaaVFjaUE1alFzZGUvSTFvcTBTNWd4ekE3NDFBdHo5?=
 =?utf-8?B?VTdPcmtFL1BqdnlpWXc3QWhVRzM2bWx6SFFHclVZN09xV2gxMjMxTlp2aHR3?=
 =?utf-8?B?ZlErd3JTbG9PZjJLcE9IeVBUUVdDREtwTStvQ25aNHhnTTBjVFg3a2NNalQ4?=
 =?utf-8?B?L3VQdk5nNnM4YTBGVnY4VVIvdndDMG4rVmd3UTFCTi9qbjV5Q2xLemltN1FY?=
 =?utf-8?B?OFI5RjlqekM2ZnVSUkhKNnBQY1A5WDZ0ajlNKzdEeE5nV0cvMzN3a1h0QXFm?=
 =?utf-8?B?TitWN1ZhUlZSeTQrQ2hZSXc4K1EwdllSRXJ6dDNGUkhQYWtTZTFVM3E0bHJa?=
 =?utf-8?B?dEZESTlDb3RyL2JzVHRFRlMrMkN2UjIzRURRSnRna3l4QjIrRVJBYm82Zktx?=
 =?utf-8?B?ek9GVkFNb1JJV0l0UWtTWnhUSk5ScWR3b0RiZ0dZeVMzYitXc1kzTk5MYjlK?=
 =?utf-8?B?RUZUK1RaT2dlV3o5RVJaWW5ndnM0UFZ3Z2ZaUmZ1OXJ6RkN4eC9TNkpaR2RI?=
 =?utf-8?B?UTk4YmYvS1k3VjloT2wreVJKb0xVdkFPd3VQZmZFTjF3SGd2NjB0dnkrdjBp?=
 =?utf-8?B?RHVEeWZJNm5CYVZqRDFMdjdUWnJkSEF5WDdxWmozeHVwLzlWK3NNaDU1c2pa?=
 =?utf-8?B?NUZWbkF3VzMzK21laENhaTNqYklabTlCWGpiaWtiT2hNd3Y1R25TbG0ycnNU?=
 =?utf-8?B?MHYreWt4R0lGYUxWWEZwVXIxR0w2cm40VzVzRWpLdDVUUUJsaWpRZXpxR1li?=
 =?utf-8?B?a0MzRjRmMVVkVTU4U0Y2dVNnNEM4cklZSEE3MzVIaVU4bWJPa2t0NTNtMzYy?=
 =?utf-8?B?R3B0am4rdHI4bkJLdUFaa1JCMUxmY2N5bzU2TzFJVHNuTWg1V2YrdkxjU3FI?=
 =?utf-8?B?V2xDbHNaRGlVK2tUZFFwaFVpUDdnV1RRMWVzVjJoTWJRVmJWVEV2WE9JUnht?=
 =?utf-8?B?cWpSdzFseGN6bFFDL09oSjQ5RlFtUWg4ek56UTNmMXdvbHdlbzBpYUc1ZWZj?=
 =?utf-8?B?K21KYmxSV2M2TGNzcFBYaG1vWFVUUkdvVFRUdENZT0twUWg4Z0hFakJDbnkw?=
 =?utf-8?B?d0ZrNkdkUkNaMnZ0U25kL0dWc1oyOXRoR3htZTBwSmhxSnhwZHRManlGNTgv?=
 =?utf-8?B?ejdYUWoyNkl2QnVwb0xKUXAxZ0Z5RWUxNDFlR2JVSDRiUW5qcUREUjAxRDRs?=
 =?utf-8?B?V1IzSndFMUFpZzBHQVR5N05nRXE0UWtVMi9iR0VxdUpxMEhoSDZqeXhIaS84?=
 =?utf-8?B?UzlKTFl2a2NXN1I0eU9oOHJnaElDR1ljQ0U4TnJ5T0Vwc3piTWZwQkVKWnlm?=
 =?utf-8?B?VkYyT2R2MER1K2J2L0hmVUFBNjdWUzZqbmFBbXY1NGFPZHk5b3JIeURiU2Zt?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3140a9-9338-4d85-70c5-08ddb8def65f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:36:31.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rijxDG698TgHD5KFz82cePPMPN2YwH+m5HVOYS0MQdCv5ms0SaSC3NfDcC42Gg1Wzc8qmJ1rjgkyEg+tM9XwpaYKPlm8rkMmsc+lWMbL1mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com

--------------m14d2WnyJtp8ZovfVkm0iZy5
Content-Type: multipart/mixed; boundary="------------0ZBAoqw7ebyZsBOzHVUp7eoc";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Message-ID: <753b6548-9b7c-411a-ab39-adbf769f83bd@intel.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
 <xmqqzfdnkdx6.fsf@gitster.g>
In-Reply-To: <xmqqzfdnkdx6.fsf@gitster.g>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------0ZBAoqw7ebyZsBOzHVUp7eoc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/1/2025 10:40 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
>> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
>> index c6e0e9d05186..61486e378cab 100644
>> --- a/builtin/send-pack.c
>> +++ b/builtin/send-pack.c
>> @@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
>>  	free_refs(remote_refs);
>>  	free_refs(local_refs);
>>  	refspec_clear(&rs);
>> +	oid_array_clear(&extra_have);
>>  	oid_array_clear(&shallow);
>>  	clear_cas_option(&cas);
>>  	return ret;
>=20
> There is an early exit from the function that would bypass these
> clean-up.  Perhaps something like this on top?
>=20
>  builtin/send-pack.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git c/builtin/send-pack.c w/builtin/send-pack.c
> index b28da7ddd7..6ce9f6665a 100644
> --- c/builtin/send-pack.c
> +++ w/builtin/send-pack.c
> @@ -305,9 +305,10 @@ int cmd_send_pack(int argc,
>  		flags |=3D MATCH_REFS_MIRROR;
> =20
>  	/* match them up */
> -	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
> -		return -1;
> -
> +	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
> +		ret =3D -1;
> +		goto cleanup;
> +	}
>  	if (!is_empty_cas(&cas))
>  		apply_push_cas(&cas, remote, remote_refs);
> =20
> @@ -340,6 +341,7 @@ int cmd_send_pack(int argc,
>  		/* stable plumbing output; do not modify or localize */
>  		fprintf(stderr, "Everything up-to-date\n");
> =20
> +cleanup:
>  	string_list_clear(&push_options, 0);
>  	free_refs(remote_refs);
>  	free_refs(local_refs);

This addition looks good to me.

Thanks,
Jake

--------------0ZBAoqw7ebyZsBOzHVUp7eoc--

--------------m14d2WnyJtp8ZovfVkm0iZy5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGRGzQUDAAAAAAAKCRBqll0+bw8o6NmY
AQD29CaJIfIr5+dPPEx1QYgpPTew/gx0vCJmdTDBX/KmjAD+OK5FMEbWbcxHVmv+D4fCrrAbm89r
suEvqB+cAhFDzwE=
=Cikw
-----END PGP SIGNATURE-----

--------------m14d2WnyJtp8ZovfVkm0iZy5--
