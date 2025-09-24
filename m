Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389228F4
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738229; cv=fail; b=rKY5BDkREYbEOs8fUMNC9RuG3prW1EehI8Cly3w2HjLzDewbTBBmHB+9PROLELq4Rc6OIb2+O/4wwlpjaHdxsnavh+3A6Go2UZtjx9C9iens0Y4pnkHJUCuLs+uBiWwPYeXwgXm+jYTL9qWSQvo7J5Ps52UVS+segW97oTr/1+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738229; c=relaxed/simple;
	bh=abdZLMleIofwZ8rgZuxpkh8eUT55GQfs4pUOCPAA1ds=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnUW24gAbSpCy5oa8ylug90Eqd18V+i9Wx2e4QZ0SHqEdDvy8EJx96FSJ6v61pyAOz3U7leMrDvIOU/4YACxJw+J1hv6FtD6kC9qdIGy9x8rkyEtZKVpQBBwJXaqSOKFfyn4Od0aDIdZQ7IGIZsqfnllqGn/S/M2vVTz0k45ZTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXnv6rrs; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXnv6rrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758738227; x=1790274227;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:mime-version;
  bh=abdZLMleIofwZ8rgZuxpkh8eUT55GQfs4pUOCPAA1ds=;
  b=aXnv6rrsdCgCIRS2RX4y4g2/JD8KfCUuvvWThIyKctXF1UWVCJiu6CUk
   YgSjbrwybPpEoLffFvY6naEuj3h3hUh2zUDT3WDaTB+d38c4hMfqvINT1
   7qq7ehayEbhP4gVPAnBZjV8y8hHAbrZbzuNrAQ0neenVPieqQFhuv72PW
   0FZ5s4dUyOzHHJ6WSP3AD1WPuVoak4EvKG1crWoTgB+Fri6MyHh0iTfy8
   ImD0yKGTjubA6DiWkl0o2HyACDIm6zv3SzewlrpoDN/c26/UUaSL5+BhU
   UAdfxfqZcjTxe7r7Zbw1jQEZ1fzqPMu4jI0k3Np1C5IhdgqBT+i9MvU98
   w==;
X-CSE-ConnectionGUID: fLFygK0/TguEI2Ae/QV98Q==
X-CSE-MsgGUID: OUe0H1u0Tr+pDPUAVqdBPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64883516"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="asc'?scan'208";a="64883516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:23:47 -0700
X-CSE-ConnectionGUID: 97TYgpIcS8qXW04eezBiMw==
X-CSE-MsgGUID: VYTvVZr5RDaKW9pnPwggVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="asc'?scan'208";a="176687471"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:23:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 11:23:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 11:23:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 11:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMCjubFazKQsn+pYy+69riuanlaae2gNslfrmErPuaSn9xlNfwUDNjX4pa4T9AxBsYJLQPE4ojSTXCnRaC58SDtTVULPrF+qYoebOpUCvM/bivSrAll+qhasMYMauXJmB/Jb8my9pXp+/BTaJ76+ONNM+Aiov71cYUzM52+BC8tCXdNqvGUZ6DRzKJFqGWI6xmaWcjXFd2vcOHbcQ1u0S7oXsvIspgtsTM6OawKoIMQa69ziS2GFRJg55/dIl4ntCjRxaIfNuCx8PZvrRvUxPOWfZRcJMZpIQpsiu5QWxV/yGs3FbB59IDz9fXRhyAej39BWScFhohsVMrz9WFTMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abdZLMleIofwZ8rgZuxpkh8eUT55GQfs4pUOCPAA1ds=;
 b=uAt76fr0Zl13LcqwN/8OxNVlMGK3aW0eFYKhvITNjfwgg+R+4+cvDxZszPWZYsDBSNjyZTuq0+cl90l52Z8lDYNcThsS71c4DeDJI+VD8biEXdkkEE4yKJ4VkayyfQKSVMboe0w75wZeg0reUJYoRSkmwqlRmsHEwdiquhyALbeHFK8fS8El9GHdIvKvnH5gOYArsLWoFGTkrKfikL0mlEiIzQ3e/ptlX3OV9ipBq6gBbwkG/BQA4O0xeVhVl6L5YX+rhjsX83nAv/C8jGeC97JMSG9H2MzVr1yM7mVO0Y91RWsDPOVSvwrwY9eaJrGDwiqY5oNtqdkJkDSiNtaRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:23:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 18:23:43 +0000
Message-ID: <c919ef8a-cf37-4ee7-9713-775246bc7243@intel.com>
Date: Wed, 24 Sep 2025 11:23:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
From: Jacob Keller <jacob.e.keller@intel.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
 <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
 <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
 <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
Content-Language: en-US
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------A1VcCUA0F3i9xAhWAHhy8Ns8"
X-ClientProxiedBy: MW2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:907:1::38) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: dd40a309-1e83-4cc0-a6cd-08ddfb977e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1pia25jdGUyMjJlQmhiVE5SaFJkaUE0ejJHUlNsaDVFQUw5N1Z3ZEhnZk9n?=
 =?utf-8?B?ZEZ2YU4yU09BcUR4Q0xIL25BVnVWNzg5bjVZSllBN3l2WFc2eTJwUzRwQnF0?=
 =?utf-8?B?WVIyQ0lUbUZSZUVsOEo4MU13UUNVT0lGc1NxOTVyckp5aDBqRXRrWEVla2lM?=
 =?utf-8?B?clNKVXo1TVdIUEYyTWdRcUluaWkvUUVMSnpPOXRWekczYlY2MUhlL2V5MUV4?=
 =?utf-8?B?UzNGby9FdXYyNGJFT2JJK2ZJL3RxQUpyakpSc3B3c0VaWVhBd243NmJ0U3B1?=
 =?utf-8?B?Nm5ldVh0bXFOZENhODNrdVEzbW14YXRhOHg5d3l0TlBwck80ZGlON1B1eXNm?=
 =?utf-8?B?TTQ4akJLZ1VMNEVIRDc3QlNpU1dUWUIrVWhZMllqUjhJRUVFRnZscU5ibHE0?=
 =?utf-8?B?WWJlL1NJY2JZOGNqNHcvcW4reERqc000LzV3djMrdWtLOCt0YWphMEZmSnFh?=
 =?utf-8?B?d2dMdUxvL3FnU3pUdzh2ejVrQW5PSFZoZDBBRXhJWFYrM0EwM0szMEt5MHdH?=
 =?utf-8?B?OHhKRjFVR0U0dUNxblUyWHJIWWhKMmhRd1NRd2crMWtuRDRqd3NFWWZ2ZEc5?=
 =?utf-8?B?UnIrNWVYTFFtWHpTVE5CRi91YUJkc0FKYlJqbVVFVnNITzViUWhpOVcwM09m?=
 =?utf-8?B?L3k2NTdWSDh4aER3bVRzcWV0bmtsWHZRY2pmbmdvNXV5MDd1ZDE1dlArVmhp?=
 =?utf-8?B?NXk0MTFTVlg4Y21rbU1JRDRVNGhPYkNsMVQ4WUtkditKUDNMemxIalpoRmZl?=
 =?utf-8?B?RHVKdnIyTXBPNklwVk9PQVM4VDJCL0RvTzJ0eG9qWDdrZEcvemxKeS8vNDdv?=
 =?utf-8?B?UE5XVHc5eVdpRm9YK2JYRG0wTjI4Qjd3N3Vqb0dLVUlqQ1RncThnWW9kVkNm?=
 =?utf-8?B?UFdtV3J3cThFOEFCS2VEbjB4RWtIQ2RnVmsyMXBDQ0ZYNjIwZVlqVkorQmp3?=
 =?utf-8?B?clFPWTNoOUswVUp1VkpGSlBzQlFCSVRKZ2RTZzd2VnRXL1dVdnN0QXM0YVp2?=
 =?utf-8?B?UlFLUk53UWpOMEdBNmlsSzdnYnFoTFZZZCswVERnMnl3TmlKSC9VZnJ0RG1H?=
 =?utf-8?B?RjU5R0lWYmZscmlBdS9UNUc4MFlxRGI1RTNaWFhQM3NuK1pQbkFnVEZFcm1l?=
 =?utf-8?B?dXl0aXlQcjkwMjVhdVNnS0RPQ3FVbDc3V21vYU96cGpGaGwyY1V4YnIxV2NG?=
 =?utf-8?B?UkF2VkV4RFBwVm9yNDZnbVZ3L2s3ekx5TDIyanpBMlN0VFNBenNKY05OZW1y?=
 =?utf-8?B?bUhVcitxWEJVUGVPQVovbGxoaDBucm5hc2FxWjFRaGp3enlZRmkwZndWcm9O?=
 =?utf-8?B?Z1RTTGNmb0ttRW9UeUNNYlRHd3dNNTV2Ui9HZks2SGl3Z01lWVV3RFd2R2Y3?=
 =?utf-8?B?Y2J6UDJIMkxxWFpHUjFOcDJuTE16bG1HMEZNL2hidHBqY2pIZDZVMjJJdHhB?=
 =?utf-8?B?clFmRHJmOHJhUkZHNGdnL0ZWN0Y5a01HeGc2L2hIa3dkakxUbU5YTzJhVG1r?=
 =?utf-8?B?VXdwM0ZwUnd3R2U3VEVHbXc2NGZTdGtDZjE4RWYxSUVmL01lYzArVUErMWtD?=
 =?utf-8?B?czB0TGtvbHVwdGNCazVEZzFteDk1UTUxWU5IMkZXTUZSZlVJMnd5cUdQemlx?=
 =?utf-8?B?amhhb0twRnFTVTM0UGtUdVE4Y0FjVnhCOWF6YTZhLzd0cytWUW1uK0VNaU1W?=
 =?utf-8?B?Q3Y4clZrMG1nbzJZMzBPRmlhTXNCdEZydFVJQjV2UDJEOEVhM1hmNHlWeW42?=
 =?utf-8?B?a0lGWmlkTGQ5WlNWTEhDRTY0TGNYTVJnSWQ3ZHdMUDVxMXNvUVZPUFF6VUNH?=
 =?utf-8?B?Q3RuaTcyRGo5LzYxVk5mRTNzY09GMXY2bzlvYUk5SDBxNEF4WUc2S2RsMnY5?=
 =?utf-8?B?VWk0OStKcUp2RVZib0k1dEFheGdpWXVicDJxUTViOE4xT1A3TUIyNmJZZ1pa?=
 =?utf-8?Q?bAyQ4am/Pcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdoQXlPcVpIZFFISytkYjdROU9zam51VVdhZTN1Rm8vMVJ3enlsSnJrVjUz?=
 =?utf-8?B?SHhZWkNSUFVQWEhhZTZQbjI3MS9rOXY3WjRIMFBzVThCN1hhbTloMmVROXh6?=
 =?utf-8?B?MXhicEUvYzE3MllsSUJKa2NkRVRWK2kvaDVnOTBYTlBBeTRVWWhWVXhablcr?=
 =?utf-8?B?SUJiakhzeDFpTVFXWjNndFdmL0Q4MXNwVFFrbEFNakZiZHJod05CU0N3MFFa?=
 =?utf-8?B?UTZpTEdzUWRNY0NCNmg4dWc0N3RDanVoMEM3bTZZd1l5U2tGTmttTUd5ZEd2?=
 =?utf-8?B?VmhXMDNnbDNacjh3Zk1FeW9XS2JnUmNLaUZWKzlvR01Sam9iRnFpV09hK2dx?=
 =?utf-8?B?M2Zab0FHSkgwL1grY2c0UWdHdWFwYzIzKzVGN2t0WllySkZPT2E1Szg5Lzdk?=
 =?utf-8?B?N3pLNjAzcVVJY3hKN3Fya1Zoc0xQVGxlQjkyWElBQnQyaUZsRUNoaDBoQ1FR?=
 =?utf-8?B?ZG1kaml0RXg0SzFNV0Fud0RhMTRQTmQrcFIwQVRuSjZQY1Z6aGZTbHB6YVR3?=
 =?utf-8?B?L1dsRFZlZ2pIejdVbkNOK0swZDZrM3dJSW5IaGZ4WFVUbzc1TTVLR3ovUWVR?=
 =?utf-8?B?bkM3RDdadFR6MW9jOVRlZ3JvNS9DK3dWSjNrZ256RGx4Uk1MUG83bEZXZ2Nt?=
 =?utf-8?B?SEZhZUttSWYrR2hMd1o5ekN5VlBGbHBoMDlaaXJuc3FNeWVPMUVJTk4zUXN2?=
 =?utf-8?B?Uk84dng4VXZLY0sxL3B0aXoxaTh6LzRwaTYrdFZGK2NtMWVTMDNtaTU3RjNC?=
 =?utf-8?B?aUdSL0hGcnpuTkZDL1ZoVzczNDg5bFdCbE9YNG5xZUFjVStsTEpFbVJ4UWVt?=
 =?utf-8?B?STNzMjBRRnY2YW5ldmdoWkRkWmZ0ZnlONERiMUpKZm5JbmhyejBMMDFiWlpp?=
 =?utf-8?B?dm9pMjVQR3gzNnpReXdab2FQU01tQ01FaFVGZ1dXd09DQ1AyeGFFenNzTW9E?=
 =?utf-8?B?VWNFOGZXTWxrbUNwZmZyNU94bVl1VlJNSmZ0d3dSbjdCZ2l1M1BnS2RPQjFh?=
 =?utf-8?B?OTBWcVYyMzZXdHNnWG85OUo1aWNRejlWRS9MdjVUYjZ5d01KR1Z6N2RRUlUr?=
 =?utf-8?B?b0pQaTBjTEhxZTZQc3RCTGYzMXNLdVhLUC84dEJtWTdmNzhETkZzMXp6dHpP?=
 =?utf-8?B?R2xwNVVQMUlXUEJqQkZHd3ZDOHg0NC9xd2xBREhRQ3NocXM5SkxmZGJOdG1W?=
 =?utf-8?B?OXNaMkRKU3I2ZENuNVppVHlRc2YvQ3lDdjh5WXZXOFFuZEFEYUZqZDFzR0xy?=
 =?utf-8?B?dGErV2MyeGRmbERDSzBXUGJ1K1c1MCtzVFlWWmNvQ3VIdmtlYytRVDR2TmdF?=
 =?utf-8?B?cklhZU5JNy9YMWpsT3NhUE1pMzlwc254U2dHcDNsQWoya3Brc1hCZnlReGJq?=
 =?utf-8?B?TVBCdmhBSGNDNjZSa2IydkZBdkFhL2l3U0ZWSmZxTVBYdCsyQzI0bVdoN2w1?=
 =?utf-8?B?S2RiR0NLcjhkYUQ1VFVRMGg3NlY1Ymg2OE5OSGNnQm5saWJDamFJYzUxTTh6?=
 =?utf-8?B?TXpPSWErV1V1RTR0c0N1a1lQWG5FcGcyTFZTN2g2aTBXYkZKWHBBaXZxODZX?=
 =?utf-8?B?WXdjcVZjcUhsUE5LOWpZNzhWQS9TU0dWTkMxMmZ6N3VaVXIzZnkzMnd4Ym9k?=
 =?utf-8?B?Y0hCMXFWK0NrZjJCeGQxL1I3cFo1cXFlNGVuMzJIcStFbThJZjgwTEFzbEFH?=
 =?utf-8?B?MUgyUEdyc3hzTmxkREM4SjJNSi9mSWtGUEJYZFRrclZ4ZDZ1TnJYYWI1Vkp6?=
 =?utf-8?B?SEMrWFVJSHROSFB0MnFFczYxNjZZTk53dXUrRlZJNDdnWW1DVkw5SzhOSnhO?=
 =?utf-8?B?UlVrTHlBWTlwN0N3cE5YdGZEcmlFMERjU1RIMVhncnVsYjNUaEtXTEZBVjVn?=
 =?utf-8?B?K3ArZFRWQXNsc0pQdjMxVDdjdjk4c21rdU5zOUIrTHNYMUFGL3pDMEhOZllU?=
 =?utf-8?B?dnRiSFFGMG1EaVA4a0JDN1p3TWxBTG5zUHRhMTM3UTF6TEdpV2ZpVHF2QzR6?=
 =?utf-8?B?MHdlMVlUVzVMbk8wWnJxK3Q3NEM0K0t6K1VhS2ZMdUhGamN6N2RNUG5hcENI?=
 =?utf-8?B?RFp2NW8wc2M4ckwwWW5EMWRVSjBONS9JcTFTbWdUYVhsVFRET1VSUnVxRXgy?=
 =?utf-8?B?dGowWStyUHdMdlpVRCswcHJZbVJvQU5qaHRrcUxYTW1UWU9udE52THJOMmE4?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd40a309-1e83-4cc0-a6cd-08ddfb977e74
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:23:43.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97Cq8ItZKrWuwf3xBrIKuvzGq7OLpFE9QVpARZva2JN0y+qJa+CAybJToh9ykOjwGwlP0DHImuOwKAdE7WEPimE8Jj1CdlYduLxFN87dYoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com

--------------A1VcCUA0F3i9xAhWAHhy8Ns8
Content-Type: multipart/mixed; boundary="------------OIBuYpu1p0o94xt43CTPxvHw";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <c919ef8a-cf37-4ee7-9713-775246bc7243@intel.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
 <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
 <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
 <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
In-Reply-To: <5da981d0-0a9c-4840-b413-54ec29d349e6@intel.com>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------OIBuYpu1p0o94xt43CTPxvHw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/24/2025 11:19 AM, Jacob Keller wrote:
>=20
>=20
> On 9/24/2025 4:19 AM, Johannes Schindelin wrote:
>> Hi Jacob,
>>
>> On Tue, 23 Sep 2025, Jacob Keller wrote:
>>
>>> On 9/23/2025 7:57 AM, Johannes Schindelin wrote:
>>>
>>>> However, this makes me wonder whether the logic itself is sound? It =
is
>>>> not immediately obvious to me why the `paths[0]` and `paths[1]` valu=
es
>>>> aren't matched against the pathspec yet their entirety is seemingly
>>>> skipped in `read_directory_contents()`?
>>>
>>> I recall fiddling a lot to try and get this working. The idea here is=

>>> that fixup_paths does some conversions to handle the DWIM logic where=
 a
>>> "diff D F" becomes "diff D/F F". It returns true if both paths are
>>> directories, so we only enter this block when both paths are
>>> directories. (Which is required because we only support pathspec
>>> limiting for directory differences).
>>
>> I do wonder, after seeing that `read_directory_contents()` has to
>> (re-)construct a complete `strbuf` in every single invocation whether =
it
>> would make more sense to construct two `strbuf`s in `diff_no_index()` =
and
>> pass those along to `queue_diff()` _instead_ of `skip1`/`skip2`. The
>> `queue_diff()` function would then have to extend these
>> `strbuf`s as it already does with `buffer1`/`buffer2`.
>>

Ah, but I see what you meant better after some more thought. Instead of
bothering with skip1 and skip2 at all, we just generate the sub part of
the path along with buffer1/buffer2, but we start these new pathspec
bits empty, so that we can construct the proper C/D/E path in
read_directory_contents directly without needing to do a skip or memmove
etc.

Makes sense. Good suggestion!

I'll try to work on this today and make a test case to confirm this.

Thanks,
Jake

--------------OIBuYpu1p0o94xt43CTPxvHw--

--------------A1VcCUA0F3i9xAhWAHhy8Ns8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNQ3LgUDAAAAAAAKCRBqll0+bw8o6Ny3
AP0VYhUrTd5jRUT52xSti+JP0G3Lu1d87tV2KojjFXrZVAD+O3mAYSU/MNBKt/qJoigxg579SQvx
ibmYcO91fHITvQk=
=sO6v
-----END PGP SIGNATURE-----

--------------A1VcCUA0F3i9xAhWAHhy8Ns8--
