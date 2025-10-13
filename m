Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520F21CC55
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397292; cv=fail; b=FW+z2+ql8BOOWObqhf7wmEwjDo01yFcnRCEZOAbCqW6cZ7AJLQBbXR1QQPZ22rzr07v2dcTnoYRbBi8F+jIlMzj7r7R5TtAYlP9vPmEWVJ4ABPqs6IoQSJfi598zp0eQ0uQn3KZZxJCYMrVotqsiy06E+tvA/kWgNrhyBAsGO9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397292; c=relaxed/simple;
	bh=YC3ysUYx8FT8lu0ieRaSeANVR4/FKUNAX6PbYuJF5fQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8cSgp3+mrvQavgbJ1WwJKyFTCwgWqoLAsUHbMBPPqj0rLfHVYqmprMAt7/y6jVACZMikOLpS440zaEINbSi44ngAfnHMpWkAai2wHCuzdiXf+kA6lkuiDJ6Wiz7wLROuUkJaSZM0msyLe6H0Z6TfLDPqs0mm5iTamv9jd3BJzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcZIzvcr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcZIzvcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760397291; x=1791933291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=YC3ysUYx8FT8lu0ieRaSeANVR4/FKUNAX6PbYuJF5fQ=;
  b=bcZIzvcrBPbUWiYKE4reib/o8qP4ISbA5aTz32fvte00PSflL9OkVinV
   0S/Eozu1m8Z1IySDL7nObP9J/d3gdU6NLKS9JJ3A/AoY+LnlR29HQhaix
   t8Oqq6QexEzXxjXVSyolPfoflcQaSQC1Xr1gM/mCgbdT2D6weDeT3gGKZ
   oMX29x0XeQoeAzgoyoaQ9zDmH30ijPjgGq2mM/MzFGSuM4XyqYn6cUPaQ
   LtU1/I2T1F6mt5wgkTMgGSOPUzv5BWcgt860Y2XQNzA+wmV+u3LSna8+v
   KSAar7Hq8i7UIQtnX0yakunvb7KVABWqqt6rsfhpnI01aiamM/f+EPy5c
   w==;
X-CSE-ConnectionGUID: PLTkrqiFQt+gCz0AK1xQrA==
X-CSE-MsgGUID: puwocBeKTgiPj6PTeQ4jEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="65169592"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="65169592"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:14:49 -0700
X-CSE-ConnectionGUID: XkogsNQSQma0SUK+wCW44A==
X-CSE-MsgGUID: N8ABHxK4Tpqv8bRUUSES0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="181680127"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:14:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:14:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 16:14:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0iD2v+h+dDczXqsP15MHERYiPr3yqVHCR0mEOpsf3midHs3quaRFziD9rVPEOUDbxWCG4rXr87aSXIGhTqYYtDtVGukRUCUGh7zgakA1s0fKXXAXKh6+fspo9bcZmSubcnzLVeCRYrcQ5k74yi1EGFcLMzMaan4cOAN8FgjI4dxBzzfypkiCBtwO2IQkeTudH51Sm9SJi6EYyzonS9PQO/V8NVGyuZQhMab3AjXZskS+4LPs4JENSclLWI8RQeG1DAZzXqJECOlFlxmMxOZnzd1PifDoTGQ3GrugIiXPu3b7bgSeHfRp3cawDk2jq5bY2+G2TUJzmD0JAes2lIQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ttb3IdFuLB2XxdS8dXzH+j+5Kih1lybnEb+lwCa1zFY=;
 b=Y0IWNyFbdL0+RXdfJTM9u9usne2r3uRPCzedfduwoib8vFCrYZg0w7WDZxVQtztfm/06nlSEEXU9riBkIjil8+KQDmC4jrmua5ZCCTeSuFrz6vVKDlz4qol53U/YaxiaFJQmJ05Gz3MBbMZh1VPDDdpiFtp8M++S/F8BExTNa+uz1mnwNrG/DssN9NUr+a0IUAOMTif01mH+TYBGN4z1BO46R5s3LJIpMimWaRmtzvuj7Ze97ThHh5P1Hi8RxvAGEaCMIa8WorODaydeGONfO7j6pPIsq6Ojs+I8IaA8XcDSmR3gmnxSoKIU4V8AxSnUqgzeppCwns0VDC8WttFPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 23:14:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:14:46 +0000
Message-ID: <0cc105dd-717a-49d1-96ca-e884e7d9f157@intel.com>
Date: Mon, 13 Oct 2025 16:14:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
To: Junio C Hamano <gitster@pobox.com>
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
 <xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
 <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com> <xmqqjz12ag5j.fsf@gitster.g>
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
In-Reply-To: <xmqqjz12ag5j.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Y8Z0tiwJCKRGRatyIIrS26VA"
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f03bbc0-3733-4b8a-c3d2-08de0aae4ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1hhMFRGWSsvUEJ6OXdLbVlZV3poblJwemF4SndwaWpqSHN5djl6K2FyZVNy?=
 =?utf-8?B?Y24xU1NBL00vMFZCaHNrYzVpWm1GOFB5MjcwU0d4TWN0Vmc1TzdIMTZBSG9Z?=
 =?utf-8?B?NDc0RFFuWnRhYWU1TEh5b2Y2NGpqQVQ1TlZVMEgwV3owNkx5M2VyUWl1R0V2?=
 =?utf-8?B?S2t4d28wM210SER2dzdhQlZnTFV5Q2dQSWFXR09qbit3YTJYWi8yUTREZ0JU?=
 =?utf-8?B?Q1YzbEsxeGVBN0M0UHh6QnQ5NnBDa2U5d1hSaTRvNmRYZS8vLytucW1CcUhK?=
 =?utf-8?B?TjlCUzc3NzV3ZjF1TWd0UGVNOGFwZ29lMHJQeHI2YjZnaThsMDIxUmRlTFNU?=
 =?utf-8?B?MTB4Y1FXZWpjUWFUd3UzMzJ4RDZYU3FCeEExQlhmY3pDRktmZ292dlJHV1Vh?=
 =?utf-8?B?eTVYaTA1YjBYaFR6Kzd5cU9yVUt4VS9XakxPNFR4bWw5UG02MFRqYVRMZjBx?=
 =?utf-8?B?MnZqUVl2UEFxanhNODRIdndZa2JWZFVxbzRhU0hPSWE5aWFQVW55R0hud0Fm?=
 =?utf-8?B?Z2x2VkJrM0Q5MjFJb2FXb1dUMzFadkdwVk1rRVFxemZxZjM5RVVwNHE5c0ND?=
 =?utf-8?B?R0RpdmcxYk5ZbVlDdnRKOVIyWkU3c0NseURObHpSdUlrUFJGTjBnNVlrTXMx?=
 =?utf-8?B?ZU02QkJGaTJLTVQ5VENtb0Y2TU9XNUo4ZWN0UGovOXBXSXpmVGhYdmIvS1pK?=
 =?utf-8?B?ZHNmeVZJNzFrTkJtdUhSSkdDMGh4SHlscEx3KzRGaDVwTzF6b3NjN2dMOEN2?=
 =?utf-8?B?a09VakpXcVgrY0ZWQnhJM0xXK1BVZFdHeEhXREk0TkIyNmN1TEpLVTFzL2Y2?=
 =?utf-8?B?MDFHbW01bXIzSjYyYTRCUSsrNHNKaGVkbTR0VnV0M1RXWU0rUGZjSzBWYUM2?=
 =?utf-8?B?ZUNlVys1ekRiVTVtYzNYUjlhUENjZWgzYi9VUHZhR0lZRExveVRZT0N4YXJm?=
 =?utf-8?B?bUtKcWZYZTduS2toVW9nYkdWSWVaQkdwdW5WM0NnNi9hdDlCZEQ5SlRnTGhD?=
 =?utf-8?B?aUtPWGNNeDFFVEpyUFRiUWhoNW04d1A4K3hhL1M0ZWdVMWZCakxBVzU5OFIx?=
 =?utf-8?B?K3ExOFJ4R2tGWnV3TGMraUtZeDlKSThja21oZ3k0L1ZvYkNTMXZUSERYV09R?=
 =?utf-8?B?MWlRc2gybUdyM2wwQ1Nac1ZVTmd5TXJIUDNMU1NScHpTaXZWQ09Dcmd1V29n?=
 =?utf-8?B?R213aFFLcUN2b3BOSVUxL0ZabzFtRThaOGloaW1PZUdSSXV4YXBSL0xnRlc1?=
 =?utf-8?B?cUtkY0FvUGRKTGk3Z2pkTUdpUDVLVHJYNkJoMUtQd0V2OVNZVjQ5b3AxdC91?=
 =?utf-8?B?Zm9YbDFoK1FRQ0FrUWlNN0FtaHMwcHE4clBmQXFCZEpseVhOM0hteXFlUlRK?=
 =?utf-8?B?TEIyVUMvWUxNRCtLelNjcEVFdWo4K0hKa1JwdlduaFhRaHlTQTdSQmtQTURx?=
 =?utf-8?B?WS9jTVh4YStIN3RuMVBmNkRkMGdOR0M3VzlVTEZPaXcrdFZUdlI4WVZDWXdQ?=
 =?utf-8?B?WDZwbDg1b3lTOHFKWjEyaHljVVZNd0pwcUNSdFlEVEEzYXNubW05UW8xM0c0?=
 =?utf-8?B?YnpvY2dxQzl0MmxudTltVUp6VXB1ZnBhTzUrbXdsNnhwUXFVMUdOL1NJSjV4?=
 =?utf-8?B?OFhOQ1RIUHdiUWtMaktIVUNSU3NTUzU4ZjkyVUx6T0F5VFppVlh3YzRWVUFj?=
 =?utf-8?B?d1dFT1JZMThFOS9OaXdEb3VFSHJjZ1lHRy9FS2YzamJSbjJsLzNLQUVjNzZE?=
 =?utf-8?B?SUhqd3pCYVZuZnhHWHI2MDQxUXdBTnhXTEtjZGtLL0tDaEp3RlZIcHFmYlpZ?=
 =?utf-8?B?RHNvVy92VmVUMUg5bjZ1R05DQ0ZKMEh5czk4VDFJNGoxc21vdHJZa2FRTFhv?=
 =?utf-8?B?aG8yUlBwdHBNbExQSUpmSjBqMlBtRFh5UFhIb3lmOGlYOElzejRCNXFIV21i?=
 =?utf-8?Q?+EaPLKIdGDQ7QGdgFMAmOWbN/MTkIfmw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZzc1ZDMWw1KzJUcFEzd2JVZWFZU1V4b0dGOHhKZE5JMGs0N0JqbU1UVjFP?=
 =?utf-8?B?L29YMEszNUtBTEl6NjBITG5WZW0xNm00MW1NanRnSm5naEpKOTNnS1oyYWRJ?=
 =?utf-8?B?dGd0WlpmUkQwUmdENmkySTB4aGNyOXVoWEttbGczdXo3bmpLcU5Menl0cklp?=
 =?utf-8?B?U1UvYThhOElqQlFtbzZxcUdSaHFDYVhJTHAycU1WVU82YXZjZ1pnWUFGTGNm?=
 =?utf-8?B?aVB5elAvYmU0N0FQS3RyQ0lCUEdsL0UraFl4bUE3WnJzdE5FcUtJOXc3NUlW?=
 =?utf-8?B?WU0wa3A1aE5nOG1GckgyVTI3WW1uRy9rMEQ4UzJOVjVmRURGTUx2SVJSNDhh?=
 =?utf-8?B?OHVyRWl6ZmVxK29NR3lBRjdzVHZrRDhnQWw1TE5IYWNQSGNqVGlLMWJtSjVy?=
 =?utf-8?B?cFhxekFoZ0NhU0tYTHZOUmlEcnAyaFFxY0VTRDNIcWlvd3M1SG03YituckU2?=
 =?utf-8?B?aEFnRmVGMWlOQWJxdHVMZlc0dHI3N1JvK3F1bjRhTi8zdS9HUUFjbFQ2bzZp?=
 =?utf-8?B?am5TS3dRSnpHdzVETE1oMFNSQ3BPWEJGUG54TzNzNWpKMnFGUTR2SGFzN0Fp?=
 =?utf-8?B?akdaSVJENW1ja1VQdHFxQU1kVTUzNDRzb2ZLbDVIL3RiSXVWeC9CSnBpRUdS?=
 =?utf-8?B?K0tEMXhiYlA5TmNUL3pYc3E4ejVraERyUHhsRUR4dDhvdFFJaTdGYWNna1Yv?=
 =?utf-8?B?UHpwTmRxVXRnbVJjbTdoWlBrcU9WNzRnMzlaMDVhZ2d5aGhaRUs0ck14NDJK?=
 =?utf-8?B?STNIQWx4c1VxbTgvMnVodFZPV1I1REpyRklONUZxYWZnWFdTUEFmbEcvMjlr?=
 =?utf-8?B?a1g4YklRSjFmM1BGSmNaM01KdmhLYTBtRjloamNTR3Mwck8wV2w5WUpVdloy?=
 =?utf-8?B?UmhnVGhwUFErK3pnQzczdWg1QVZRazU0dDk4d040VVVPK0NtNU1CTVAyOWRt?=
 =?utf-8?B?VFVWV2U5dVJYRWtnZ2RQUjJFcnpNdEJvN1NkRXNkMS9kcDJrek1oZjdNUDFP?=
 =?utf-8?B?dHhTcXlrY05weElGcXNId1BhRFdLNml5cHFMKzhxbXkxcS9Qa0ZoUVcrbWIy?=
 =?utf-8?B?ZFdMaXVTSCtzOGtCWU1kYkl4Rk1uQ2xLSnBjNFgvNnNLQlYvMHJBM2ZTN3J2?=
 =?utf-8?B?MERwem9zTDQ3dzM0Z3FTampneWpEaWJBVHRoemxpSHJvSlNVUGYrU1FJVUo4?=
 =?utf-8?B?QTJualllR3QzQjE1Q1JVVkhkckxRUm5JV1BFbGJUMXVyZmprM2tXa3pYK0No?=
 =?utf-8?B?eVljU1cwTmZXUms3NzZidHFTdU11S0grRWpzMGtnWmNiYklkOXVMcExpUzJx?=
 =?utf-8?B?SytzdDNUemJRQ0JtbGYyV0JJSFd3SWFXRDdJZDVKMTRWL2lRbS91M3lKRTFM?=
 =?utf-8?B?UG1CZHVzcTlzRURseU1iQitYMVVKQVB0SXJydHkzdEl6L2ljUU1YTHU3VVRo?=
 =?utf-8?B?NE11RWN3QjlxZTMvZk43L0syUXl0bklLcjBNN3lrSVNsdk91MkdhQVlyY1Ri?=
 =?utf-8?B?RE5Ca2duM01TZ3ROenFxb0hGbVIzTGF2b3JQdnhQVzVnYXZlN29jSkh3eEFR?=
 =?utf-8?B?WjZrMmRLQm8yLzVHY2YvSWd6UzYwL041ZWNGYi9YcFVNN2t3Q2NVZ2k4U0Nn?=
 =?utf-8?B?T1ZWZldKTC9zdFh6QXBjZXZTVzRXZDVRK2NEQjRqN2IrVldudGowMVVwdVdF?=
 =?utf-8?B?cTl2eHNaTnl4cGVVZFhSTHEydVFXMVVkeEdScFljME43MEJueitnMG9aWlhh?=
 =?utf-8?B?THk0UjJzRThGY2xHa2FFckpUY2h4dVhYRStqcC90YmxjRjFSSzcyYm5DeEpl?=
 =?utf-8?B?ZWlsSDlJMTBqVkxMNlU0eUdWMmNSd3psQXdkZ0QvK1AwOFYxQnhudlAyOHRQ?=
 =?utf-8?B?L1NmYW9SblQrYm9RK0lIcncrY3NDcGJ2VUdscldMbTZYYzFVTDNEaEVBa1Mw?=
 =?utf-8?B?MVlJQ1orK25ibjNHczlHdFpuVkE4MHdZdy9MY3cybXlCakNxQTh5Ykh6Z1Na?=
 =?utf-8?B?cC8rLzFlQy82cnZ2cmNtcjY4ZThMYU9PUldIK1haaHIzcjVPZWlCYi9KYU5r?=
 =?utf-8?B?YTNaaFRUK2pOcnhjMDFiMUd1QmswWjFMNkFYQzNpOEoyb0ozaFRWazVSWlJP?=
 =?utf-8?B?azZ0eFphSFRWTGQ5bjE1cHd0aVkwWXhJNE00b1RoSlNEMnRZQmx6WUlzV0k3?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f03bbc0-3733-4b8a-c3d2-08de0aae4ceb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:14:46.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDv9s4Fw0yAjOaK/OD3OxXt5MJG6UcZ2Xx3K5pgFMZEc6mhXcp3qMLGof7BvjzAbqGXdDMGuMRiwcMQ84EEOi0mvRHt1oxJZ0PIyNGz32wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

--------------Y8Z0tiwJCKRGRatyIIrS26VA
Content-Type: multipart/mixed; boundary="------------wspSrsqssLcakoXE8Wo2aXTP";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Message-ID: <0cc105dd-717a-49d1-96ca-e884e7d9f157@intel.com>
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
 <xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
 <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com> <xmqqjz12ag5j.fsf@gitster.g>
In-Reply-To: <xmqqjz12ag5j.fsf@gitster.g>

--------------wspSrsqssLcakoXE8Wo2aXTP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/10/2025 9:13 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
>>> You can squash this in, or I can do so myself if you like, if this
>>> is the only change that is required.
>>>
>>>  diff-no-index.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git c/diff-no-index.c w/diff-no-index.c
>>> index c70f82b805..f320424f05 100644
>>> --- c/diff-no-index.c
>>> +++ w/diff-no-index.c
>>> @@ -436,6 +436,8 @@ int diff_no_index(struct rev_info *revs, const st=
ruct git_hash_algo *algop,
>>>  	for (i =3D 0; i < ARRAY_SIZE(to_free); i++)
>>>  		free(to_free[i]);
>>>  	strbuf_release(&replacement);
>>> +	strbuf_release(&ps_match1);
>>> +	strbuf_release(&ps_match2);
>>>  	if (ps)
>>>  		clear_pathspec(ps);
>>>  	return ret;
>>
>> Please squash this in. I'll fix it if we need a v2 otherwise.
>=20
> Since this exchange things have gone quiet, so shall we declare
> victory and merge it down to 'next' and then eventually to 'master'?
>=20
> Thanks.

That would be my preference. I haven't seen any other reports or
comments about this since the v1 besides the missing strbuf release.

Thanks,
Jake

--------------wspSrsqssLcakoXE8Wo2aXTP--

--------------Y8Z0tiwJCKRGRatyIIrS26VA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO2H5QUDAAAAAAAKCRBqll0+bw8o6Cgn
AQDNdbJU3SJwhOL5lDTL1qqYgf6PXM1W+xxcr1XgOlSRwAEAl1qQLmAVTQ2RRB/beP8OITpU2z7s
3uypUEepRAvX0g0=
=lOL4
-----END PGP SIGNATURE-----

--------------Y8Z0tiwJCKRGRatyIIrS26VA--
