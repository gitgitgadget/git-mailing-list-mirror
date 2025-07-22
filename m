Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBF19DF62
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225831; cv=fail; b=ScH856LSRmxcEs2N2+1dje4/BwX2mcuq1dfqMYAJdm4PEcAMGDs/02TLnUKqoQV/YPYbLfNgdGGRvv9157zY2Z4da1imR5Lsd7fv67e9GLqC1NflUwxWNTSgB3oEyMW19704jYDKJs1LSyraR8eGraFB+FOWYxGoCubXMsOoLb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225831; c=relaxed/simple;
	bh=Sge+igyPwhTtRugR7XIJAaOdtU1cuMZ35bGfCIdnDyo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QSIom1AGa1BHe7J7LVtEpdcce7bZo/2YfVojfHYDSL++VwGCynAEL6pS5mBBgvM6tUpfJ80I1Ev7Q/nmv+WhL31olpkissdULsRFHSIRK1IOq4sz13ychu6UWvIYFiAZBxmzYqfkMKIwMHS2MT2M9b//VvfWPV4zWXznhRDNbyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQBfEyAL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQBfEyAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753225829; x=1784761829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Sge+igyPwhTtRugR7XIJAaOdtU1cuMZ35bGfCIdnDyo=;
  b=mQBfEyALa/eMa8HRyvoAGZp5EjElKkUNaY4hbRaLLK0LADZdFBuE++fu
   P2Oznu7pPgP0JA7wck67z5lODkI/pjNyictF23iahy8DDvav4D4+GE/Aq
   ZuenxwH64AJPG/trBN70jV5RHJZt/gFOg3NIhDMtbF8qEeGUx/Uo6fLYH
   tj/wiAgJCna2TBWxywkLdpExCDWRa0ji1/5eWjx5qO2A5nZ5rv8MxGyVe
   sT3uBhOLyipuDlwi2N9OMveBLnsPtuiD43mDGb5jFNG7W2YRg+q8SSANQ
   jDNRaOo9qexKZSUhLy50Ysgbsx+ggyS3LB4uZIn2zWXcwVL9KT8wkfANA
   A==;
X-CSE-ConnectionGUID: yqx6QJ4ZRZWgxgIKzgtzLA==
X-CSE-MsgGUID: aYB1r9iBTby73JvuBJab8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55649161"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="55649161"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:10:29 -0700
X-CSE-ConnectionGUID: m2V72xmzQWyJ/LFh3q21tw==
X-CSE-MsgGUID: Fti0jVGORp6tQNuU/OiH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="163535561"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:10:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:10:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 16:10:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTyUdrA6oEpQDS3GPY0bPUeszNf9nE0/lx9ZWuVVRElCOGZNPcTDSf6a/4ykhGEOhYwv95APQPPG7eEe5kTstLo8oa6EpVozST2Re69ITaJDJ1YfFJPasuuPhZfKh8ZxzQBnYASQy6IE2nKvkyCJWn7DOX5AYCcZN1rzrpDeYWDh7k7p8asvKW5rezCIyAfT7TX2V+pr299wwwk3GpXjqUaf27auijRcinlo2VOk/M4zzBDKGC02/YKcOpRgyj6Gv6aLhHKDHvzu7fpeB9VtloDt8m9yyY8DCUdb1DnZZuiaV3InYRPz2XpZmbA9bki7sFaSUA9OcHqLAahxf6UCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKhfZu/+ZV/XV2d3kJUYkcZBB1OLgUyePI6G2eL1LnQ=;
 b=Q3vGIHjFX+YOmHho9ZHRuPdn1Tb7SQg5T1VwhOozFxvFDoHqRoi0ig3fgTxQXpj1NgUppF4jKMcAdw/s+9Ky+Oajn68rbYf/KJYAyaN/DYILpq0nV97CgC0js5xVqE6xpGgrY4VX8eUE/ks+9bylUvGS0LE6JIjrcEJeUG5S4ZOVTp7MHO24Ab2yk422wPKbE8AoSRVh0kJiQQw4M2dmrxolyzXhE/m56+WI+xTDf6FziKpV7xr4b808GWazjo8Mjpss1dRXTmjAAmPvt3S/wImQJkDKXBGsSk6ve8GbFhyXsbxTmUOC7zQlTtJcWSZuyGJN9QSViEO2uh805Pe3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 23:10:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 23:10:25 +0000
Message-ID: <fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com>
Date: Tue, 22 Jul 2025 16:10:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
To: Jeff King <peff@peff.net>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jacob Keller
	<jacob.keller@gmail.com>
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
 <20250722045456.GA824456@coredump.intra.peff.net>
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
In-Reply-To: <20250722045456.GA824456@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------parLdFubnW8vqY7mrIpCOwhs"
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4cadbf-705d-4350-5927-08ddc974f0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c041NWtXVHZYODNFRXFiRGVmQlRwMTlVSW9YT0liU0c2NXA1Uyt1SzcrWXcr?=
 =?utf-8?B?c0ZTSmJuSXZtUnduOEpnaTd4cnRlTXpFUW1Da2NWQWlMU0VwSk9udS95VGZw?=
 =?utf-8?B?UFBBS09xZVpPcFl3Z3VUS0owYmNlRSt4SW1TRHZCcHY4ZnYzMzdjZVJEdUI0?=
 =?utf-8?B?bWFCZEJhSnhIWmtqeEZlMGhrMmFHbVdrTlNGbXVnQWdqcXdMYUdwYzRLZlRm?=
 =?utf-8?B?bHEzMFIxUW9DbGdRZEFobnZGS1F0d1lvOWM0QU5PSUNsRGl2SVBlVUxFNXVG?=
 =?utf-8?B?UjVhY3dFai81RDU0TzdCWlVjTXFNWnVHZC9VckNURUoyL3cvbG1QRXdVZEdU?=
 =?utf-8?B?cGZ0WWJta1drcHBxayttNkQrUFhsMHcyZ2FCUkI5TllFMVBYcmswUzRlaWFm?=
 =?utf-8?B?MmZnbDNBb2d0bkFTYXdlZ3loZ01ROGRSNkhoZWZnTGNiN3JSV2g0TkdjT2tx?=
 =?utf-8?B?dW9aR3QwNVplNVY2cVZ2L1BLako5ckpUZHVuNnV5VmZPLytWZjVaWFUwRXVV?=
 =?utf-8?B?ZytHYXRCelhhRUJST20rdVVHL24vQzlUMUY1YUVkWmQrWVJtK3NBakRXYzlk?=
 =?utf-8?B?bldzM1VoMDRiei9aQlhOeTQrVi8vUFk5Zi9ldWxlck4rWDdGSis1bC9YeGxS?=
 =?utf-8?B?a2ZpVld1d3dId1M0MGxwS0ZkM0wwUmhmMlBIaUNHSWZscENaQVNUYUw0dSs2?=
 =?utf-8?B?N0ZEaHRvaUZVN3BkQzlQVWhaY3lHRDVhbllvMnJtVVh6bmVpK3hDMG1ya1dG?=
 =?utf-8?B?OXNSTyt2YmFRbXF5U3d4bGJnRXJxZXM1U1l2KzNhelhobjBmS1BubG04SUlV?=
 =?utf-8?B?YkUydGNhaWdORFFvMnV5c3R3RG41aUlvdHpUWlE4WjJiYm1abDZxQmRwTFN1?=
 =?utf-8?B?UVZnOG9PeEg5UHJ6RkhaUW5DeTRreEcxaGZxcmQwbGkrajhFT2pkMEZMNDJv?=
 =?utf-8?B?NnBMVng3czJYMzE4Q2IvcWFad0JFOGJkb1MxaHgycWdLdm5LMlNLK3ljKzcw?=
 =?utf-8?B?Ykh2djVPeWdSUllTSjc0WThDKy8xdzJwWHlQRWpkK3paZGpmTm0rL0g2YlY5?=
 =?utf-8?B?MGQyWks1QkFyUnEyTEx4aWlWcmNseGViTGYvN0xiMXMzenJEczFhRUJscmll?=
 =?utf-8?B?TjAyMHNWYjV1UytJMDNKbGhteERhcDdvSmlsbzlvY2MrZHdUekxiWkpkZ1Nu?=
 =?utf-8?B?VStHbTRwS3IwRE5nWk55UGlZSlp6OHJxaXJzNE9VMjhYbUxYRG5mRDloblMr?=
 =?utf-8?B?dGNQUEx1YXFWVGUzb2kxYVk5eVhYUEQvaDFEREd6d1dtSjBYQjBvd2JLd3lL?=
 =?utf-8?B?MkxCOERqOW5qTGVDK2FKd0JyNTJGVk55SXdIaUJqUURpcE5aYlR5dDNpZ1ph?=
 =?utf-8?B?SCtXM0w5TVVUZWFzVzJEMGtDRnJXUTExTkU3YVJWdldyOUU4UFhFTjkycEYy?=
 =?utf-8?B?eFVNTGRudmQxb1JEdVVOeDRhMHByQnJRY2ZFWGduWFlSUkFzQjFiWk0wTTNa?=
 =?utf-8?B?ZGFPcEh0RDdBakp1MXRabW0wUGxFTVFZQkN6YXFYbERYdTR6N3Izc0JCZ21z?=
 =?utf-8?B?VG0rNEhoYU9mUFY0bVlkcFFLU2ZCTzByUGJmOXNhSnVoVTJySE5YaHhjTVNU?=
 =?utf-8?B?NGRnd01ERjVHQmFuUjBKK2VDakRhSSs0ekRVT202enl1eEcwRVd5VGJ6T1U2?=
 =?utf-8?B?K1M1RTdFc1dNYjhkZGlQMEtrdWFGY25hWXRQdjVNZkhlOUs0SjFxejNvTWpn?=
 =?utf-8?B?czhCY0c3VG1hTXVzYnhMNkN6d2JMdWpLcVdadE5kUC9vV3pYYTBGTlEreTBN?=
 =?utf-8?Q?znz+FwabU3P/83Fl04X/lAFYBY4PLhDGwYmFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pFckZ3cjdGTlRKejdvK0JSN1dBZXd5cklpVkRFNVc1VFpxZldUTWV1cWlF?=
 =?utf-8?B?OVhUVjNRMWZMR1F5L25vTFlkNnNBYU5lUXRLc3o5MDN0U3FYU0JpT0JqaVor?=
 =?utf-8?B?emxQS0svRGZ0Rmg4dGMvUVlGRytCU0pEMUVFV2lvYUNxM2d2NmtuZVlERWJa?=
 =?utf-8?B?eEVQT0xtSmQ5UFVGa04rajEwUTZFV2RKMElnenoxL0Y5bjNrejExeVNoanBB?=
 =?utf-8?B?RDNJaWZid0w0MHd4RlNRb3pZVXRoc2xCODEwWHlSOW9za2ZiQ2lBM3ByaW1y?=
 =?utf-8?B?L2tTSFVLcTFtd1ZReGhxUzlvdGJTbDRZbEs0Z1k2Ym9ncTN4WUtCcUt4b0lS?=
 =?utf-8?B?eUpKNFBzMjNhNmlnejcvMGQrb01STW1YemkzSkNkR21yWXNVVUdxMGJieVBj?=
 =?utf-8?B?bGx2Tk1SSnptT09xOVVqTmdWdjVjUTRZYnc0cGdkWHZLVFJ6THkrZjZMUlhy?=
 =?utf-8?B?RkdNWDFLUHBHWU9sS3Bpa2J6dUxJem13bWk5dW9nVWIxRkh2UmxncDlsZ0JU?=
 =?utf-8?B?aGdoMXdWWlhsUnExaUtuWW9JYWYxRkJOVVJmM2FQOVRGdkw3QzcvQzRXbFBU?=
 =?utf-8?B?OVo3a25wNGJ3cTdXK1dWNjMxU1NzRVd2T3dYdE8zazFyNXNvcDZIMEd5WHdP?=
 =?utf-8?B?LytFa3VraVU2cE82ZENvS2dEV1JrMXZWWWdCRHJIZW5DQzZWS0RiN25xVWxP?=
 =?utf-8?B?Y0pVK2IweW5RRVRSWlFCWE9MSFBCTEFreEl4d3EzQlhPb0NNcnA1bTI4dHNh?=
 =?utf-8?B?Tmk2elFuczk3VmZ0cjZKRmxnSlRXRVhxeU1XbnRTdDdaeTNRN1NjdCt1aEVN?=
 =?utf-8?B?dVR2bkpOdlpqeGNUSDlJZWcxOWpaY0xXcmxhR25zbG9WaEo1MUYrc1plSHZv?=
 =?utf-8?B?WU5BZjdjZGhNZ3RYbmtDNml6WUwxVFIyZmFYcWEzaU5UanY4a2hyaVRSbHBO?=
 =?utf-8?B?aUMzRThaeTBuYWI5ckRSV012cmFSNTlFWWZhU3VEQjNBN2hsK045alg5WmFY?=
 =?utf-8?B?aVhCRlFNS2xsdXZ1d2pnVWVpZE5WS0RzUno1R3N1aGpCbTZPL0NnY2NSanRw?=
 =?utf-8?B?TmRSdWJxbTFUU1N1dzZVdE1ieHQwS3ZPS092V3g5eHNnQWJYbnY1cjE4MkNH?=
 =?utf-8?B?bUd0OGYwZUhGaFdaZHd1VlFZM2czUmdEbmtpdXFuSzQzaVU2QUtjY2FxK0hT?=
 =?utf-8?B?cUtMK3hqZFFVdGkyV050RXdrMnFtL0VWL0h6eElMMy9EVDl5azU2TG5jeE5y?=
 =?utf-8?B?a3hGTVhieURMaldKbXk4NGdHQjl1NU96bENpdEJJeGRyZU15RFFtVElWdWlP?=
 =?utf-8?B?UGN4MHVDYzhURmJEV21RaW5kblpCckt0UHBXRnFpSmt2V0ZHVllobmo1OE42?=
 =?utf-8?B?YlZYTHRvRE4vc3h1TFJ6bUZ1ZmErMkg3enl3cHlUYjAxakptN0l1Nm1yM1Zz?=
 =?utf-8?B?cm03VGdrSzREaXdLMWxkOUNabmY1TDU2djFZWC8zNEIzNHJ3c1VlREtTRis3?=
 =?utf-8?B?aGdidXg4YkxpaldUc3MxSXlIVkFWamF3ZHB0WVlFNVUwRC9TSnZHS21mK2RW?=
 =?utf-8?B?TnBZMzdIWUJuVlhSL0NRWHRYSStibDI1b0FGKzF1WGh4Ym5CRHIvOENpZ2tV?=
 =?utf-8?B?WGdNVlh6VWNsS25ZYy9pZ3FwcmMxc2o3SFRVemp3OHprdkhuNU1RZndQM3RF?=
 =?utf-8?B?TTdPdzRoVkJOOFR1Qm1KWG1FZHNrbnUxZFozNThRYitBK2g5WFloMmVPSUZE?=
 =?utf-8?B?VTRZOUF1SUZBaDVTV2Y3dmF4QjlRL2F3by9reTRpQnVHaTFPQk5xQ3psYmJ3?=
 =?utf-8?B?TVNieWRnUlZYem8zRXZYa3RXcnZIV1M0bGNGVFY4VWt5bDZqVEJFYW1jWk4r?=
 =?utf-8?B?ZVo4Y3o3TXlkMlBTUDVKVGttUGs5a2l6cVVybis0dGdyc05Ua0RkbEQzYXlV?=
 =?utf-8?B?SVJhQTVsOFdJazMrT0w1ZzRuTm1MbUYxdzg5RW9qdU5xVjNwbHZHTUVpMlJy?=
 =?utf-8?B?Q2gxcldHQmZIZS8rNEowVjkvYzZwUE1mUEdOQ3VVZnRrbkRYR0xLWVdNQmpY?=
 =?utf-8?B?Z2ZTclNIaDBEcWMyRmIwRUlVa3V6TlB3WDdRWmVxdUVvckM1RGQxd0UwbGsr?=
 =?utf-8?B?UzNZd1FUL21zdUpBaGVVNElUWjUrbUNDYkltNU1KMUoxNFVRcVd5Mk1iODl4?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4cadbf-705d-4350-5927-08ddc974f0f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:10:25.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3es8qjwdUyIoP/8MF6RXJL6eGlh0xfRexpTvCPE0g1fYb7UHKCHWUcKvqPXrN9PGn0a400muEdUuc5hMCiSwucJZ/UEHUxPrsn+7hQJe0Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6482
X-OriginatorOrg: intel.com

--------------parLdFubnW8vqY7mrIpCOwhs
Content-Type: multipart/mixed; boundary="------------asw4NfhMIpd0DmftgwPZdQFb";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Message-ID: <fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
 <20250722045456.GA824456@coredump.intra.peff.net>
In-Reply-To: <20250722045456.GA824456@coredump.intra.peff.net>
Autocrypt-Gossip: addr=jacob.keller@gmail.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 JUphY29iIEtlbGxlciA8amFjb2Iua2VsbGVyQGdtYWlsLmNvbT7ClgQTFgoAPgIbAwULCQgH
 AgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBCBAVKnXM5BWKuxDHmqWXT5vDyjoBQJoXH7qAhkB
 AAoJEGqWXT5vDyjoe8EA/1OU/7mbkVnufmQ/9+04ObhGJmLDNglAT27MGpPikmh2AQDQoVz7
 JRAnpV98jwFnJhADcLlQ5vuo6htfg3Li5CMeC844BGhcfUoSCisGAQQBl1UBBQEBB0Bd/OpW
 HjD2QYkBxl8I2wVkuTjAXprOa4Go3ATCnOFuGgMBCAfCeAQYFgoAIBYhBCBAVKnXM5BWKuxD
 HmqWXT5vDyjoBQJoXH1KAhsMAAoJEGqWXT5vDyjo21EA/jLDwQDagVIjbfu8NHQu90elHEM2
 4HBceGL5rOnCY3g+AQCn9fd8W6u1t0+6/QXX08Oh0RWA4h14JMqHP9kOP0/vBw==

--------------asw4NfhMIpd0DmftgwPZdQFb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 9:54 PM, Jeff King wrote:
> On Mon, Jul 21, 2025 at 04:39:37PM -0700, Jacob Keller wrote:
>=20
>> Changes in v3:
>> - Remove the incorrect call in reflog_expiry_cleanup()
>> - Add a call in reflog_expire_condition()
>> - Link to v2: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-ex=
pire-config-v2-1-f9af934be8c1@gmail.com
>=20
> This looks correct to me except...
>=20
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 845876ff0286..37f543736599 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_confi=
g *cfg UNUSED)
>>  				 count_reflog_entries, &data);
>> =20
>>  	reflog_expiry_cleanup(&data.policy);
>> +	reflog_clear_expire_config(&data.policy);
>>  	return data.count >=3D data.limit;
>>  }
>> =20
>=20
> This needs to pass &data.policy.opts, no?
>=20

You're right... I think I fixed that and forgot to actually commit it
before sending. Ugh.

> I think we might also want this test on top (or I'd be happy to see it
> squashed in). It shows off your fix when built with SANITIZE=3Dleak, an=
d
> also catches the bug that v2 of your patch had.
>=20
> -Peff
>=20

Sounds good. I'll send a v4 which squashes this in.

> -- >8 --
> Subject: [PATCH] t1410: add test of gc.<pattern>.reflogExpire config
>=20
> We have long supported the ability to set reflog expiration config for
> individual, going back to 3cb22b8efe (Per-ref reflog expiry
> configuration, 2008-06-15). But we have never had any tests.
>=20
> Let's add a very basic one that checks that we apply the config
> correctly to a subset of refs (and not elsewhere). This also
> triggers the leaky code fixed by the previous commit.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1410-reflog.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 42b501f163..362e90d7d6 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -320,6 +320,34 @@ test_expect_success 'git reflog expire unknown ref=
erence' '
>  	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}=
" stderr
>  '
> =20
> +test_expect_success 'expire with pattern config' '
> +	# Split refs/heads/ into two roots so we can apply config to each. Ma=
ke
> +	# two branches per root to verify that config is applied correctly
> +	# multiple times.
> +	git branch root1/branch1 &&
> +	git branch root1/branch2 &&
> +	git branch root2/branch1 &&
> +	git branch root2/branch2 &&
> +
> +	test_config "gc.reflogexpire" "never" &&
> +	test_config "gc.refs/heads/root2/*.reflogExpire" "now" &&
> +	git reflog expire \
> +		root1/branch1 root1/branch2 \
> +		root2/branch1 root2/branch2 &&
> +
> +	cat >expect <<-\EOF &&
> +	root1/branch1@{0}
> +	root1/branch2@{0}
> +	EOF
> +	git log -g --branches=3D"root*" --format=3D%gD >actual.raw &&
> +	# The sole reflog entry of each branch points to the same commit, so
> +	# the order in which they are shown is nondeterministic. We just care=

> +	# about the what was expired (and what was not), so sort to get a kno=
wn
> +	# order.
> +	sort <actual.raw >actual.sorted &&
> +	test_cmp expect actual.sorted
> +'
> +
>  test_expect_success 'checkout should not delete log for packed ref' '
>  	test $(git reflog main | wc -l) =3D 4 &&
>  	git branch foo &&


--------------asw4NfhMIpd0DmftgwPZdQFb--

--------------parLdFubnW8vqY7mrIpCOwhs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIAaYAUDAAAAAAAKCRBqll0+bw8o6B97
AQCJvM9eYhH4nvEZeAyjdhmj/IzOPDjI0mnVApszss7IXAD+O3ZF8v3WtQsca1HTbrNyiiA1lTQk
7I2ytEKeFKvCsws=
=+mz9
-----END PGP SIGNATURE-----

--------------parLdFubnW8vqY7mrIpCOwhs--
