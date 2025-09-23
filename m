Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B7281355
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758667729; cv=fail; b=JCSk/IyjeQfmsgkvO5E07qnapD7HYhA0GWvByb/FP9smvlAX59DnxhQLSZDCwgPVCHwsnANK020LpQ9xym6sPWnxla1W9iEdzeNWhUVq3iBAJnaMVU6MLhxpKH2ZRPbPQtriXqGjKDEC1Lxi5IDa4SSmhvUC6IYWeoKoIS/ooRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758667729; c=relaxed/simple;
	bh=DCW5vHRQ1pRq3RAMcz362RGgqcXjIEeYtZOp7wXeXZ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4GfpQC9iUPi8wObUfG+j9ADAEQOhGmROymuHJPtZBqmsMUqNrbT7SqdDYlXwmSYGr0GEHMM43sgRI9hnliNuVNrUlx2RlBowxEnk70gIl8s1nJOKpU9Hvi5kSL0d65POTCD29j/FCinZz8ud+c1d0LGAyXypbrMSKL6pIKMdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvgZsqtB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvgZsqtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758667728; x=1790203728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=DCW5vHRQ1pRq3RAMcz362RGgqcXjIEeYtZOp7wXeXZ8=;
  b=gvgZsqtBCVyzsld0FexR9bUuE5RIFIjVTiXHSr7Rvo/APsOJZ2ExFAxz
   ITBgHfpLWYllvhBkhqPhJb/iLNR52gJNbFisnPJ3iv79KnxQwONLF5ATm
   Jir7afeJ0Wctl6pmTd4v+hEvsJfCxmhOHEvkaHxMZEylsrTW7rIr2rZxV
   lUgXTyAhM80YiVOMQ4mBOo1zKxaVuR40g3Jkd2D8pqPxgl0ARoyC32kUc
   xMy74dOblKULqBqZghUJ49Q1NzzPKAJORZxUWSm59V3XmV7Y3Lffg2kuz
   qUSIi3QnCPRiRsSg3MiUkV277wotcrafnxk7OZso71QEN4d/lnVTjKhc2
   w==;
X-CSE-ConnectionGUID: ERQeYkRmSp66cj5Ks/dK2A==
X-CSE-MsgGUID: BBRDmcjrR4uDNIRMBAkEUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71631606"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="asc'?scan'208";a="71631606"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 15:48:47 -0700
X-CSE-ConnectionGUID: VLlX1mGVQQmhX1K+MjyExQ==
X-CSE-MsgGUID: xggP/eXBT7aALnGsVAsIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="asc'?scan'208";a="176482227"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 15:48:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 15:48:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 15:48:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 15:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGMUtqrTcAFw6upvFMY6JxAPfxRT/WF4+x7MJSIDIJV2nwDgum5hOQEaD6Hqz426sl0npsxz205wkBuBFkeZnqaXhnXzY1eL8jnNf+mQeb0qf34Q1DZnfZ9lbHuUN4E4spx2SjzzPn/lUbTFY2Tzvo9U0bwdawvYuXtKaUCoQlBqrGyXqRUGT1/LuljbCJMy7frRmdGghnYOW7C8gaZve2xUjUQjK4wgIKy+N1Yn2z1vZwP4x4F44ffvuUL0RmhU+GxMZQf2eEUKOzk5MSflum4hYFI48/9+/qe/4tdHMhaWghMwkgj8nn6oOO7VV6gta21++XNPlxmiUxXY8N1kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTn9pV89bb28f9szQFEAPEpL4MKlvpHENrzwExn2VjM=;
 b=GN6Ckc9AS8kSlM++GV26sciAZrGf40oFxqRks+WaKuHHBA/2OA/URdKeqsw0ITg2HRAGV+s+RFGCKb8CyCwzihjBEC4CH6gRRgOnkpJHVtcM2saDAR5gJGG5dIkaKlu5bxYFBpMYpa9PNSxjLM8g6ghgFKdiicKQv1GN60fdVWJR4RtF83jiIZx7OnC3o0JTsYuOtt3DEjpvjLvHKtxQ4VYYnb6iz/KnIDSBYLZnLFljcK1AkDJTQsUEtfVW36kRaU4dVuEbGyMHU3CkGikB5OQLNGzPXl7mPRdDHcOKF2/UeghvP9X7F3Vu9+Fru2MmJnMRlZQW7xwbs/KFqDtslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 22:48:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 22:48:43 +0000
Message-ID: <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
Date: Tue, 23 Sep 2025 15:48:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
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
In-Reply-To: <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0mwp3ZDjxH5RRlKDsax0u1jc"
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf99e13-e007-4655-e0c5-08ddfaf358b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTVPekF1RjdOSWdMb0NFbDQyeFAxbXdlNlhyQkZhWGwxTW9CZWVyZGxtTlZq?=
 =?utf-8?B?bCtQZUl6VnNqMnVqOWV5ek9WeDdpb3hVa2lFbERRNUN3K3piNFBWZ3dnUDdh?=
 =?utf-8?B?YWZsQ3NadnhMbkhnUGhnUlNVNFdUc2Z0Y0R2Tnc3dXh5Zm02TFEvS25RenJW?=
 =?utf-8?B?VG9EYlloa0tBWEJhMk5Nc2tXdmNNQ1hMT1F1d09yVmhsWU54US9mY0pvcUdH?=
 =?utf-8?B?L291Yld1SnlIQ2tQMDMwL3VRTDhRZlF2dzFodGlleUx2WTRSZE5XU0FwUVVT?=
 =?utf-8?B?SWI2L2JSZU9mVXFmelU4ellJWGJta05BRDVlc041c2lmMWMrZnJhSE1DTExw?=
 =?utf-8?B?RjNvVGlmMlNkc3ZKMk9yQnFNdnUzUGlGcXJqb09mRklDQkNYV0d4Q3NkeXpG?=
 =?utf-8?B?MG1hNFpVamduVlhWbEoyalZCWjNMYjBKRGEyZDFKVnR0SS9HV29FWkI3aDdy?=
 =?utf-8?B?N2lCNU1hdlVYZTlMdEswY2lkMkhhSTVIelh4MkJTeHBkNFM2L1ZtQ0VUOEJi?=
 =?utf-8?B?WkxxRko5Wk1kSm9nWmdpcWJSMXlCbnd1SzliZWNrSHhtWnorb2l6STFrQTRo?=
 =?utf-8?B?dXp0VHdnVkt1WU5KYkVkOUJpcmU4cFlmSW5zZzJKVkR2czhaWk5LZXVmbkxY?=
 =?utf-8?B?TkwyVmhCOTk3bk5Wa2oxUE0zWTFFbDUzMm52TnQ5b0pBM0JYL0RWWmZFSHhi?=
 =?utf-8?B?RHFadHB1ZXB1anIra1p2VVZneEFqMmZjTkhwUmM0NjVxVXdCaHZkN01RUHlR?=
 =?utf-8?B?bXBaMnJlSEtCelpqcDdGQmpuK0c4VE51SnF3TzgyY1AvQ0JBOWJuUXdoN25z?=
 =?utf-8?B?UER1Nms1RHdBU0FPQnNGdkVUUTFlZ2lYZlJyOGdtbWdUSjlxTzAzNDkvOHd1?=
 =?utf-8?B?bGVCcXhQdVo4RmxkTUQ4NXlQbzcwQjZ4alVTN202RlBmdVlYT29DQVN5TFhF?=
 =?utf-8?B?aWE1cXV0T1hja0tPRm44YW55TzU2aSsrSlNFbGR3bE1kRVRUMHg5cTVyU2Vk?=
 =?utf-8?B?Mmw2TDBnOHdWL0R2a0NVNEJtVit3cWsvb0xjakNXc29qZzNrZFlDeDFjai9r?=
 =?utf-8?B?SnZvVWk1ZmgrRFQ2N0YwamxQYlVodko0K0pnNHJSK0RianVzdmY5dEozZ1ZV?=
 =?utf-8?B?NFhXS0F1VUozUStWQ1UzR3Q2eHpEVEZlbk5ONG1oNG9iaElubnVHN3BObTZU?=
 =?utf-8?B?ZXZoNm9LZGVBREU4SHBsOGZYN1dxT3NVT1QzaGJDbGI3MXZDcHA3Q2FtY2cy?=
 =?utf-8?B?YXZVTE5FVFRSVUFLRXdGN0s2QmplVEFJVGJQOVFkdjdSUEk1em5pcytZdVJr?=
 =?utf-8?B?dHdtUy9HOUxrLzZ0M3cwL0Y3TDNqOU5aUGViV21vWmIzODMwaFNjb1NzSE1N?=
 =?utf-8?B?V0p2aEVPMG9jT1diN2loVVd6QWczZGprbXNNRkdpZFNUVTBsOEsxMmhyRjVm?=
 =?utf-8?B?STQ1eC9NbENFWURwVnp1cEFBNkhhZU15bXIzblZaZkluWm91dFVjY1ZIVXBw?=
 =?utf-8?B?b2tsNzJOT1Rad2JkKy90TWlBU04rTVRHaWtMR0tuRDBialZweWlTRFJlNkg4?=
 =?utf-8?B?TXlvbGNvZm9hSHNDbmFUbS85Y042bnpFc0tmRlFzYVdJYnJ0N3FvbklFR0s2?=
 =?utf-8?B?eFVjN0U1cWltUzRpd3ltOEpyY25MQTZOcVpDMjlNYUhFNkpzRGRxdTdsdkIz?=
 =?utf-8?B?NzBiR2pxeDMvb29WVkFPTGJXV2N5cFYwdTRRc0xGSkNJeTdMa1lYR1A3NUdo?=
 =?utf-8?B?cG1aNE9uSjRXelFQeWdpc1NvMllpcVg5c1k0S0FuS3VQbXg4cDlzM0d1NTNH?=
 =?utf-8?B?cG5VZzR5MFl2dklWcUJFQ25zcGhhNFNURzhsZ1RaU0M2THgza0dyNkw2bFl1?=
 =?utf-8?B?aGVhQzlTYlZxVzlxeGVaSXo3WkVVWXV4Vi9NeXdobDd0ZFpFM2hudGtDNzhr?=
 =?utf-8?Q?5RMs4crJ04Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5VMk5ja2MweUZSeUJ5VUw2VlY2eS85VjYrWHdrQ3lSWDU5Sk1XWlV5bEdN?=
 =?utf-8?B?d1l2Q0p0T1J3OUo4NnlyN0JjbW5zVm1uOTJrRmpvZHF4MDlBc0hDSXh5TDNE?=
 =?utf-8?B?dWNmeVhOb1lINERaZ1lUZFBSTWF5bjYxaEFUa2tmUEl2UEtTeDJGVnFQbnJC?=
 =?utf-8?B?VHI0N3JWN05lY1lEVm5Wdkdjc0QxZVFWdmVmb3ZQbWVra3R0cHFITHhXTjQx?=
 =?utf-8?B?d1BXeVhJVWJLLzVkSkVIUXRPV0c3NFB0UWYxSWNCN0Y2VWczQktZVHcyOFlF?=
 =?utf-8?B?S2N4Z3JHM2cwR1ZpSG53TUtNK2NuU0c4czRYM280SUlXblNtVGR0ZmFaMHZV?=
 =?utf-8?B?dWpxeWNkUnJsUnppUEdUT0FQNFZOck10aE5yalhpbXYxY05ISjhxU1RqNFB0?=
 =?utf-8?B?bGg5dzZNdkhQMGN1NStPaUNDQnNuaFp1WVB6OW9WbmVtZnFJMWhKMXZQckYx?=
 =?utf-8?B?VHorejJhemZxNDljVjZtSDBUUElUN3F1ZjF0dG8zamI5UFB2SGxsVWV5VHU2?=
 =?utf-8?B?NkwyMmxiY0h4eG5pbWU5NFNyMFNicjVUalJtOFZ2Rm9OWlZUWDB4RFdIclc3?=
 =?utf-8?B?UmpXc3N2d0ZuMFFWTk4ybkE0RUpYSGpkdHhsS3dXM1p5c3QyL3g0bCt6N3Ay?=
 =?utf-8?B?ek5aWiszazFXdWN0VnZIeGNtem1jaDZBdHZFcmJzNnppd1E5YTU0OHVLSjdJ?=
 =?utf-8?B?eWhxUzExUkFGaGYwalJkTHp2T1puNUhFKzl3YXRZRDF5WFdmaDNKT0FwdDVv?=
 =?utf-8?B?TUg0Vmc3TktnUUw0ODNFcS9vZUYra3h5bE9kdWZ2V2NkcHFydk1pTGdSVVpU?=
 =?utf-8?B?clU4a2paaE1RZ3NXYk91NzgzOG9DdU5jQmNucWppUXZoY0dkemJjdXpYSG10?=
 =?utf-8?B?NHNTWlp2T2o5aTgrWnBHWUFjR1dxbXQzMlpOOVFjTjRLVEpBOGY5dWM4aEs0?=
 =?utf-8?B?bmRXVGJRSG9vNnZSSEpscGMvT3V5RnQ5L1VPZHVCU2xFcU9wZmt6cXU0eVl2?=
 =?utf-8?B?b1lUVG55OGlZdnFCZkZKV2RRcEFLSW9YUXJESDZzTm1ZT3NSOG9VT24rdjF4?=
 =?utf-8?B?N1VQaWtPZ2Q3RGVFOU00enpRQStYNEM1RlE0Q01WNys4QUhscitVT2lFSTFZ?=
 =?utf-8?B?VXppYW1EM2xHN0xtR3BBWE9BTWNtbnJBTEMvQkpVMDh2U2JhQW5CQzJSTU1a?=
 =?utf-8?B?VmpmUnlDMVFsbGtvWnJBbEVwNUVUZDNkR3JvczBEa2V5ZHJnOElFaElnd1Qx?=
 =?utf-8?B?TDNiZ2REM0xJdW91S3NkbVZIUWZTaHBhNzdDVXFVRC8xUWFzbktLQmpTVXJP?=
 =?utf-8?B?OEVuZllFRE9sb090T211ai9OOGI5N2JPRVV4TVlqampNa0ZqUjVib0FEMUls?=
 =?utf-8?B?dVQ5ODN5WFAvamVhVm0zYkIyTGlUM3MrU0dMeEc5TGRVZHZMWUVkVHVhV1Zo?=
 =?utf-8?B?VEpab2xnaVQveUJSL1czQjZ3VGZzVjY4MTRjTW84ZEc4QjlUU2toTHduUlZu?=
 =?utf-8?B?c2JtcDU5dWRMcFZSNGg4dlR0bUhHaFlNSG5raU1GcUh2MVVsdzJvcUlGaDVB?=
 =?utf-8?B?dHFwc0Z6T083NG5lRFRSUGYxSlJreGN6dFJHd05wbCsyM2dPaWFzL05rQ1py?=
 =?utf-8?B?c2xONHQ4NFFIcGE4UUQxeUFWQ2hEdW9uWUtIWDVYZy9ZaGdEVkRhekloT0NF?=
 =?utf-8?B?ckZqeHA4OTAzUXdMRUtBTkxlV1ZoaDYyempQODFtem0wUFRPUE1GTmZ2NEN5?=
 =?utf-8?B?Z09xK3g4MnZTQVl3UHBhOGN6NklFcGlnb21lSy9TUzRhZVJENnZwQUVGeVRJ?=
 =?utf-8?B?d1NFU3J6QUJXY1l6ZlhtOG5qSkRVY1d0UlJJQzltaHBHZWRpUGJqelNTeVEx?=
 =?utf-8?B?c1JUVnRmb2hzc3lMNkh5bVlnZyt5NUdBQTBqWFdyNGlCaTFjTlZHcFRkajA5?=
 =?utf-8?B?MFlMSlN0MFFYV21CaHZ2Z0xjQnJubHVpZXVGZmdKY1RONk4vTWhuZ2VuM1JJ?=
 =?utf-8?B?STUrUSt3SXNSY2lUYWs1aVpyZVdJMEViUWpzei9CL0tJd2F2azZrM09VS284?=
 =?utf-8?B?WWpjWVFNd1lQVDFPM3B6bGZDVE9CR2NvZlZFQUEvL3RHQWRYSDZFZWhtMDBF?=
 =?utf-8?B?dlZqWTl2VnIvS0IyeGJQRldodVBlS2Y4bFVWVmZvUnl4enRETXBBY2ptLzlm?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf99e13-e007-4655-e0c5-08ddfaf358b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 22:48:43.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8U4pIQQrLwD+OvY84GtLLhMzMQ1B8SyHEmquZG5tkn9ZHnnXpRCY/qokTK0IkVzZbMla+65k9yRLGOhi6vmI36VvvBDRxRCpF7aexHrvr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

--------------0mwp3ZDjxH5RRlKDsax0u1jc
Content-Type: multipart/mixed; boundary="------------4n8vW5RhwDURcupjFp6NxYyn";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
In-Reply-To: <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------4n8vW5RhwDURcupjFp6NxYyn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/23/2025 7:57 AM, Johannes Schindelin wrote:
> Hi Jacob,
>=20
> I know this is about a patch that you contributed four months ago, and
> the usual feedback required sweeping changes, including this one that w=
as
> introduced in v4:
>=20

Hello,

(Replying from my work address since its easier today than trying to
load my personal email up).

It's been quite some time since I did this so my memory is a bit hazy on
the logic. It took me a while to get things working, and its very likely
I missed corner cases.

> On Wed, 21 May 2025, Jacob Keller wrote:
>=20
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 9739b2b268b9..4aeeb98cfa8f 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -15,20 +15,45 @@
>>  #include "gettext.h"
>>  #include "revision.h"
>>  #include "parse-options.h"
>> +#include "pathspec.h"
>>  #include "string-list.h"
>>  #include "dir.h"
>> =20
>> -static int read_directory_contents(const char *path, struct string_li=
st *list)
>> +static int read_directory_contents(const char *path, struct string_li=
st *list,
>> +				   const struct pathspec *pathspec,
>> +				   int skip)
>>  {
>> +	struct strbuf match =3D STRBUF_INIT;
>> +	int len;
>>  	DIR *dir;
>>  	struct dirent *e;
>> =20
>>  	if (!(dir =3D opendir(path)))
>>  		return error("Could not open directory %s", path);
>> =20
>> -	while ((e =3D readdir_skip_dot_and_dotdot(dir)))
>> -		string_list_insert(list, e->d_name);
>> +	if (pathspec) {
>> +		strbuf_addstr(&match, path);
>> +		strbuf_complete(&match, '/');
>> +		strbuf_remove(&match, 0, skip);
>=20
> Okay, so here the `read_directory_contents()` function learns to
> optionally skip `skip` bytes from the `path` variable, after potentiall=
y
> appending a `/`.
>=20
>>  [...]
>> @@ -337,7 +369,23 @@ int diff_no_index(struct rev_info *revs, const st=
ruct git_hash_algo *algop,
>>  		paths[i] =3D p;
>>  	}
>> =20
>> -	fixup_paths(paths, &replacement);
>> +	if (fixup_paths(paths, &replacement)) {
>> +		parse_pathspec(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
>> +			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
>> +			       NULL, &argv[2]);
>> +		if (pathspec.nr)
>> +			ps =3D &pathspec;
>> +
>> +		skip1 =3D strlen(paths[0]);
>> +		skip1 +=3D paths[0][skip1] =3D=3D '/' ? 0 : 1;
>=20
> Since `skip1` is defined as the length of `path[0]`, I would expect
> `paths[0][skip1]` to always evaluate to NUL, and therefore the `=3D=3D =
'/'`
> condition to always evaluate to `false`. Did I miss anything?
>=20

You're correct that obviously makes no sense.. :D

>> +		skip2 =3D strlen(paths[1]);
>> +		skip2 +=3D paths[1][skip2] =3D=3D '/' ? 0 : 1;
>=20
> Same here, `paths[1][skip2]` should always return `NUL`.
>=20
> This has ramifications where `skip1` and `skip2` are each one larger th=
an
> the length of `paths[0]` and `paths[1]`, respectively, and hence the co=
de
> in `read_directory_contents()` will now try to remove one more than the=

> length of the path, after potentially appending a slash.
>=20
> But what if there is already a slash? The answer is:
>=20
>   $ git diff --no-index -- /tmp/ /tmp/ ':!'
>   fatal: `pos + len' is too far after the end of the buffer
>=20
> This has been reported (with Windows paths, don't let that distract) in=

> https://github.com/git-for-windows/git/issues/5836.
>=20
> I _think_ that what the patch should have done instead was:
>=20
> 	if (skip1 > 0 && paths[0][skip1 - 1] =3D=3D '/')
> 		skip1--;
>=20
> and likewise
>=20
> 	if (skip2 > 0 && paths[1][skip2 - 1] =3D=3D '/')
> 		skip2--;
>=20
> Focusing on the lines' correctness (which I don't think was the primary=

> concern in the review of your patch), that would be what I would sugges=
t.
>=20

Perhaps. I need to dig into this code to see what the whole point was. I
think the idea is that I'm trying to skip past the common prefix?

> However, this makes me wonder whether the logic itself is sound? It is =
not
> immediately obvious to me why the `paths[0]` and `paths[1]` values aren=
't
> matched against the pathspec yet their entirety is seemingly skipped in=

> `read_directory_contents()`?

I recall fiddling a lot to try and get this working. The idea here is
that fixup_paths does some conversions to handle the DWIM logic where a
"diff D F" becomes "diff D/F F". It returns true if both paths are
directories, so we only enter this block when both paths are
directories. (Which is required because we only support pathspec
limiting for directory differences).

We are calculating the skip length which is then passed into the
queue_diff function.

We pass the skip value into the queue_diff function, and this is the
length of the prefix of each path to skip. Essentially, we're skipping
everything from start of the path up to the root of what you pass into
the function.

The queue_diff then descends into each directory, and creates new paths
which are all the files and directories recursively under the target
directory. Each of these needs to have its root skipped (everything the
user supplied) in order to allow path spec matching to work, since we
apply pathspec matches as if you're at the root of the two trees being
diffed.

Crucially, we pass the skip value in to the first call of queue_diff,
but it remains unchanged as we descend further in, so we keep cutting
off only the first part of the path structure as we compare.

You're correct that the logic for calculating this incorrectly, as it
apparently doesn't work right if the paths end in a slash already. I'd
have to dig farther to figure out if this proposed patch is correct. I'm
not certain.

Basically, read_directory_contents is given the path to current
directory + the name of a file under the directory. We convert "path" to
be "dir/", then we remove the prefix of everything that was passed by
the user, so that we only check against parts of the dir path which are
recursively below the original passed directory. But we need to be
careful that we strip out the slash as well as the overall path, so that
we don't end up comparing subdirectories as if they're absolute paths.

Basically, if path does contain a slash, then the strlen alone is
sufficient, but if it doesn't contain a slash, then we need to avoid
adding 1. It happens that we incorrectly checked for this, which results
in us always adding 1, so when a string has a slash we skip too much.

It should be pretty easy to add a test case for this, and I think the
correct check is actually something like:

skip1 =3D strlen(paths[0])
if (!skip1 || paths[0][skip1 - 1] =3D=3D '/')
  skip1++

Basically, we actually want one to be the length of the string plus a
trailing slash. If the string doesn't include a trailing slash, we have
to add 1. If it does include one, we don't add one, since the length
already accounts for the slash. Note that if the string is 0 length,
there's no slash so skip1 should be 1, hence the !skip1 part of the check=
=2E

Let me see if I can hook up a test case and confirm this.
>
> Ciao,
> Johannes


--------------4n8vW5RhwDURcupjFp6NxYyn--

--------------0mwp3ZDjxH5RRlKDsax0u1jc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNMjyQUDAAAAAAAKCRBqll0+bw8o6Mc9
AQC0sq9pn29TcijEkzAsMZxoYT8MGi5fT41eXGN6+sQYAgD/TzZ9MpponIU5IQmXYVb7PSmCcXoe
3v1GL6rkZbkYjAI=
=ePHy
-----END PGP SIGNATURE-----

--------------0mwp3ZDjxH5RRlKDsax0u1jc--
