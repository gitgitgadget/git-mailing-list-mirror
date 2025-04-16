Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1419DF40
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763106; cv=fail; b=J9/bDEO1/0+3tWebcLCiIwzeBtuyM4fFZhHuPltaUInOWtAXNL22Thn0aBiytil/JNgkso5+uLKCgJ5h8tWdDJCbKlt9PWv5CMok7KvwQTH32cMHq0ZZiMTU/KIiLhDq6v0QOvDQA5pkpPphoXZG+ovjxH+LamMZPkoHUzvl930=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763106; c=relaxed/simple;
	bh=7Utu4o08IRkEB6T2hBso0PS//PxBk9n8pp5pTozwOec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uD+8ETsHprKYx8t08jaOb+VOZ+FGSBNh72cuEHksPUJrG5YGbKJTEUusApM8ZuMdvk+AyWES02US2EKtqEW1wyQmi7UxwqqAONYypd+PxLgc1D738sdsroDwXRkJpJwHIGyl/3NVLBPLSxGnDb3B+SZU0PY0R1mzXtgj2q8H2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fihKEs7S; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fihKEs7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744763104; x=1776299104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Utu4o08IRkEB6T2hBso0PS//PxBk9n8pp5pTozwOec=;
  b=fihKEs7S0oaeIy8mtaV5N25jLT/OGA0jmTaMoyl8nMl/LIASvjIinwpL
   pIwPkQ3sUSdg7BFBOXaN6tPOlMDvIL42FgVlzYxGzY7zo1qrcRwKNHAtR
   sTJOZoNMhZS2cMvv354Bqnd7Nce/DwrWRLhnGcz2BuwzJkbd/XYIbskmK
   LjI9K5z7BPfPAwDUqkRh141IYnnSmcK82hohCqrJn2fP9sedLl95vpITQ
   vS9rJY+ShcS5OVTwf0YPRsv9Si8aAiqUMap3kdI5kb2RwbHojSJGz2ZPs
   MfTGrtwMRzQn4IPIBoJSXEl9VeXSGDLJgTNZ6ILhBcgEDiVuxHt4NdyGP
   g==;
X-CSE-ConnectionGUID: jajze/G5SiiqexzghG50HA==
X-CSE-MsgGUID: TYVePMcOSTO3b649V8PQqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46423844"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46423844"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:25:04 -0700
X-CSE-ConnectionGUID: 2cBiWauKRqi0v7T0mTbj4Q==
X-CSE-MsgGUID: cFVbQuZpRhesd71j6MoYWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="161237151"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:25:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 17:25:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 17:25:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 17:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw350mT7K31SEjerJJ2F4F1YSRF9hqv93okBEwr99s/rMrQAu94aFQ5YMSSBfBbtjCzYiIVUJqybLua3hqeHL5PPdJKriLL6sg70LqcdaUT19J7kkdNRRMP7P7eYEZXbKV3vZ30o+sH5LzA3v3cJiPdiKONO0jVAFFABbLgiVpu2ImBhJWX5ZhGaOVS+vPfCLKaCJ+pwNJ9aosi6+M3V24Nl68yMF8Vh1EXcZ7Hx1eYaRerbP6c65ukYs0zxjG+/8HONOvJIoGryjGQU33NgvAwhuDGhjxDCMuTBmtjTSpjL5A7droDBD1TpfSgqaaKqOBvAOO2KCiGqqGWX7ngCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHg8Sbzm5kKNMXQ4UF32CG6yA5leauwnbTQho/s+iFg=;
 b=oNmMEzhkEQaGC8rYAXN/gW9ov19v3rALjTZnIQMamUYvQbtbirKTlRzSeZNiJfgaV1bAStFd95WvxGws9qWCglwmPL57UfBXmz/ynHqAhZVjoorZsRgQbUWiiV9iat75NbCODOQNTbIDNc7GHZwW8i/Vop1V+vrYS/PI8ib/TJyK/FxWECsogXH615FSeqa1U6vtYmKwBbdu0LJpsg+K8Wh/4NzAYq+auv2abYviVUyn5a6AfqxXC5uoQ2kZML205smLEfgr6gwJM2oeTFW6OSZ0dhdtouKWGErO8sLuuwtdTXod8b9lnX2FwEhuwaFgZKHGuzVaKaLpWZUnx6TmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 00:25:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 00:25:00 +0000
Message-ID: <fac75248-0a32-4c84-b37c-0c72b0b189e6@intel.com>
Date: Tue, 15 Apr 2025 17:24:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Junio C Hamano <gitster@pobox.com>, Martin von Zweigbergk
	<martinvonz@google.com>
CC: Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, <remo@buenzli.dev>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
 <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
 <xmqqwmbuybhg.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqwmbuybhg.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:303:2b::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: ed705520-3f43-4710-672e-08dd7c7d1f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUc0U29tYjB5alRaeFFYZFZLZG51bGFmUTF2OElJR2JhUFV4SUFtV3QvYzh2?=
 =?utf-8?B?UWh3S21mUHFJOUlXbUVGK2hHenF2ZlpUTDZkalI5Vk5oV1paYWp5MVkrd1dm?=
 =?utf-8?B?ZEgxaVNnTkJITldBWkFsNlhDU3JHR1VTMy9ZWC9CVHpXZXp3eElBWnZ6RzV0?=
 =?utf-8?B?TW9pZW5xYUVPVktwUU4zTTl5bGx4MlhLNWpYanVhN0ErZ0d2aGdNeEhRQmpZ?=
 =?utf-8?B?UFc4ZGdOQ3huZ1pObUdJRVJIVFlJRnlIYVJLU2ZtOWJhZzdlblRpRE1tdFRa?=
 =?utf-8?B?TVhaQ2ROektWVEZoYXZYYnNHT01vejZWUEc4WlcyeWtWWkl5R3BVRW55Q3JF?=
 =?utf-8?B?OFhCaDZjRjlpdlE5REdQMVVqUnhjc2NsUldXamdJMWJ4amJwZC9mMzhLZmdT?=
 =?utf-8?B?MHZ1ZE5HTGRSUmJoYmhnRWlrOW1wSDJ6NDVVUnZia01MOFYrOFRvYU90OWow?=
 =?utf-8?B?SUVsaXZzTUpsaVNPK1ZEK0tRaXdwUnIwdnd1clhRMjY0TWRrdEpCK1ZkdXJw?=
 =?utf-8?B?T0Z0WUxKNnhEVFVYYzBBcXJNTlo3Q3N0TnRvbXdIZTdJYTRyYWxscUJGbUU0?=
 =?utf-8?B?MGw1TEU5dmM1akJsQkV0MG90NDlkNEJ2RE5JSG9JZng2L2tBQ08zKytlenh5?=
 =?utf-8?B?Uzc3TkFZZmhKbG1lQTFmU2xrWU1aMzdZengxdzFnWE1wRjdiUWphMlByZG1H?=
 =?utf-8?B?dUo3ZlZOK3RNZEYvOExURGx6ZDhDT0svdjdnc3k2eFc0QmlFbGYxYjVHczBt?=
 =?utf-8?B?NnBya3NXOC9sM1FkSjlwajAwK1Axa0hGclZUWENjZFV4MnhWQ2J6dHh2WGIr?=
 =?utf-8?B?N0lvR3ZFZXk1MmEzZGIvQUdoTmtrY0hHMUw4ZlV4R094bVVpenNVREdpTmQz?=
 =?utf-8?B?YjhXOGpWWjVjeWJKSnVnSHlmSHV1bC8vUzVjS1JhZG1zaHVqM2Q4LzFHYU4w?=
 =?utf-8?B?TjZpd3h0TlpKZXFHVjJGU1FqeUFSaDdHR0tBUDNSbmFYYXQvYldaQkRyRUVi?=
 =?utf-8?B?RkhXRmUzV1YyTDRVZVFYV05vVE05dXJRMlN6bml2N1hxaGxGUGduWVQrTWF6?=
 =?utf-8?B?TktFbTdyRDg5L0ZOWmxKeG85bTlwWXhyc1FKTW9ObHQ3TW9IWDlTNm9EMTZ3?=
 =?utf-8?B?RlNaOWx2ODNoTzRjUE9sQ2V0amhFRy9pbmE3ZjBKY2d6YlI4SnA4UmVWNjUx?=
 =?utf-8?B?Rzlwd0tObkRhanowaDFPekREc1djT1YxRFpDVXhnQjFPalkvSnY5aU5zZmFt?=
 =?utf-8?B?U1p1dVJFQjF4cXZqRkNocktMQ3dURTh3VXN2TlZXUUN0ajlPR3E2emRCdmNI?=
 =?utf-8?B?eFpLcFBRdkZxSFRnejBncTBEUUJnQ2lzcmZGTUdmWXZmakVhY3BUbHJmZnJY?=
 =?utf-8?B?dFo5bk1ENG50V2pzVTFGMDdxZ2xqQTZRZjBkSzlMQ1B5bzcxTmVvcHF6VXBy?=
 =?utf-8?B?MlV6T3RsWU1ob3M2ZVl0SHFsNzhSeGFuZmJQeUxFaWNVaXF6OHdoVXVrU1Fh?=
 =?utf-8?B?WXdKcHFhVG9TSEdqTVVmUmpjRVAxMWF4M2ozK2dMNU51QVVrQ2RoSGUwa25r?=
 =?utf-8?B?MGUxeGwxUVI5Q0t0WmVVQmQvamRQZEFtUDd6czZ4OTRQK0pScUd1MjJQajRF?=
 =?utf-8?B?ZlZGbENVQjdrK2phVDFwOGhwb1hmWkxIVkR4R0htbTZuMHhTRWRKTCtqN21S?=
 =?utf-8?B?MTlFY21uSjIwamlvcUhqMFhuMXRJSDJkcVZ2YXZ1aStLRisyc0tVOUhlS3JC?=
 =?utf-8?B?YU55MlQ2bklNMjh2Y1VJb3M1MGxlb3JyY3hvOGxXOHBOMHIxV2dWbHExSkpF?=
 =?utf-8?B?ZXNYaEkzM3JPTXpUT25lLzFKRFBITS81RWRRZXpjVTYrRWl3M2UyS05TVEdk?=
 =?utf-8?B?ZzU2QUYwTmJyeTFQbWdmY280NzJyMTh2WWppL2hYSGdzdkxGYnBPanU5UmR6?=
 =?utf-8?Q?bqmOQbZv4rE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtqU1Vxc0VXKyt1M1FPSlAvVWdIa2VpNFRUT3BZclBWWElramJIM2pHVCtN?=
 =?utf-8?B?czA5Vkl3aHVoR25zdlVHeHgrc2c5blZiRERCWUNLWEVMZDNOSmFLM3FlK0Ns?=
 =?utf-8?B?VmdBLytTa3NGbENkVTgvQ2tZaE9sdnAwTkx0QmFRME1XQjQ0TEU5NGphTDNO?=
 =?utf-8?B?TnFzS0gzdzVXQWhaVzFjK0VhMjFhTnVaZzArTjZPZ0lmZTFZMU9tdnlUL1c2?=
 =?utf-8?B?UzVsM0NLbHdENDhMeVNQVHF1Z1JtMXJJc0d4eHJzU09rRzhZdnBiL2M3d2pJ?=
 =?utf-8?B?eXRnYTRKbWU1Z1YxT1NveHkwRkFneVE2QldtMUh0enA0OHNpdTZIMy8wK09F?=
 =?utf-8?B?OEtHdktRbTZJUlEyRDdhVkFFMkRKQTdiUWVPZ0dFSXN2WlNtSmQrKzNlSExS?=
 =?utf-8?B?RWZvKzJBcmhZaE1UMzlXdnJYdE8wdU5DWWY5Y2loZWNXNXlEbXhMQ0I1alY1?=
 =?utf-8?B?TVI5Q0tJUnd3cEFNQmVzOXBFTk1vakZQdW1TSjdxbWxSYjdSc1VMMnlCWEZh?=
 =?utf-8?B?NWwrVkVySWdEeUhnQmVQSVBqWTdYU1o1SzBpdnRFaWpRTndVb2gzK1o1UHd2?=
 =?utf-8?B?Yk90ZG00bDVLWG93dTY2VElqNkxHRzdnTktLNVhEMDRhMThoU3F2c1dKUTJC?=
 =?utf-8?B?QWJ5eE1CZCs5UVIvR0k0bzdZNDhTWWRza0orTTNQZHlsNFFadDZYOERoaWVM?=
 =?utf-8?B?aTRWaG9DSlBQMkRIOUkvcmhsUXBTZDNvejJYK1Q5MWU2enBlcFA5SzBkdWZW?=
 =?utf-8?B?ekxJL1g3aVoxTDRNWTJ0a3o4K1luWHpTS1lHb3g1QU5YRWV6QkxVQ21JajZZ?=
 =?utf-8?B?aDV3eEhtQ1k3YXhwOEZadW0wSTd3Z0Q2QkdONnNhaXV4YnRSdmhTRkZxZVh6?=
 =?utf-8?B?TGtJSWhNZzR6MFVYalhNd2djMmp6OUVKR1IvQTZqaVcydEpUMjg5NlY0TTRa?=
 =?utf-8?B?a3QwZGM3NmRtRDBmZy8ya1lJejNzbXd1SCtxSm1OZUFucjlPaEdGT0FXdGZk?=
 =?utf-8?B?VzNJNmlxUGpJeFdydHd0b29jeU5ocFVvUXZ6ZHhvR1ZpbWM3SEVqTlUrYTRv?=
 =?utf-8?B?RWlzS0FpMHpaNGgwKzJjSE5TclRWdWtzelY5OWRRWlpoT2hFbHk2K1JLN0tM?=
 =?utf-8?B?Y3E4eXp0cHk5SVpOc2c5Q0haaUtydVp0eDZ2eUtkNHRNd1NISXpPcE5kU3pH?=
 =?utf-8?B?QXVTRExaVndLeWx2Q2hxbmU1NEhUR21wTEgwVS8zOURURVMyQ3B4NmUydFFY?=
 =?utf-8?B?ZVgvditpSzlOUTM0NndQcjRjRnZLdmVlTWg4RDlnNTVISXJPMEhxYVFaVHJ6?=
 =?utf-8?B?RHFLRUhxZE1qWHZYZ0VFbHVrUFhnYUFpazkvblBHUnI2QUdmMk8waXdJdHdG?=
 =?utf-8?B?b1laOVJ1Q1dxc2M0cW1kek0rNnVaSFVEQXh3K1A3NG03cWhEcUxvSGpYbGEw?=
 =?utf-8?B?QURlVzUvVG1jdXVNcitQV3o2N1dBb2N5SVcwSDZZTVlseGhEMWRDREF0OCtU?=
 =?utf-8?B?MzRZemFGYXZrNUU3NXZCT1ZlLzM4citwRUhGTXMrN2hGamphL3B3VkVwNFZk?=
 =?utf-8?B?R3BoVklMY0J3UktHKzNYRDdTVW9nYzdnd2gyNUZZOVVJRTR0QkJQVmxhMmlu?=
 =?utf-8?B?c1VrT09sdGdiaWZ4MEptYW9odVZqanlLb1BJVTBFZlp5YUI5TmNHSGJoTE1L?=
 =?utf-8?B?aDZ2dE9BYXJwbkdJbmNtT1F2ZEE2RjFoR09WQXlSdm5DL1JEMG9EcFJIbXdj?=
 =?utf-8?B?OVFkU2R6ZC9KcUx1aFhQSGVUV3Fyd0dZMXJUTlFWRGVaUit4K1U3bHBFb2hq?=
 =?utf-8?B?TysvbndxYXBNSVFob2ZUT3hqWU85cG1jTGVtZUhlbE04S0dDRTlQN29jalV0?=
 =?utf-8?B?M29veVEwdSt6bVNHRTVHODRhQnNvMCtRVzdHVS9SWmVESnRQb2hrMlI1Y29u?=
 =?utf-8?B?N1l5YitlUWtacFM4NHMrb1F1eXJxNDYzY0FhRllHQ3djZ0pnU1lDeUI5NnYz?=
 =?utf-8?B?ZWZLbEpTS0RKQjUxNkxxTXlzSjl6UFlZSmgzQ0xaZy93amtId3N1d2MxRTNW?=
 =?utf-8?B?RXlFRXV1NHA1S1hkdXdub3RFQ0FYMmdVeFhvOThkeFRNQ0FsV1psbWZIZUVr?=
 =?utf-8?B?bllNMVVYTy83a0JML0orSGZUSW9ESHdPSHozb0tVMStHY0NwWnhYa2hucU1V?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed705520-3f43-4710-672e-08dd7c7d1f61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 00:25:00.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmCRsGm9+OqtHqWvfZ/MhT9TUWDjGZJS0jgnFHjyCi9lho69NNxwMV8S/HCzjV5nk2b7krgoS3NOeLrnOd/iEKCXQnkTn8Wlz+G2QOl3Sw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com



On 4/8/2025 7:27 AM, Junio C Hamano wrote:
> Martin von Zweigbergk <martinvonz@google.com> writes:
> 
>>> A set of individual commits that share the same "change ID" is,
>>> unlike reflog entries which is an ordered set of tip of topics, not
>>> inherently ordered.  This is inevitable in the distributed world
>>> where many people can simultaneously work on improving a single
>>> "change" in many different ways, but making it difficult if not
>>> impossible to see how things evolved, simply because you first need
>>> to figure out the order of these commits that share the same "change
>>> ID".  Some may be independently evolved from the same ancestor
>>> iteration.  Some may be repeatedly worked on on a single strand of
>>> pearls (much like how development recorded in reflog entries of a
>>> single branch in a single user set-up goes).  I guess you would need
>>> a way to record the predecessor vs successor relationship of various
>>> commits that share the same "change ID", much like commits form DAG
>>> to represent ancestor vs descendant relationship.
>>
>> That is correct. The change ID should be sufficient for handling
>> simple distributed cases involving a single remote but it's not a full
>> replacement for something like Mercurial's Changeset Evolution [1].
> 
> Just a random thought.  We could very easily replace "change ID"
> with a concept of predecessor-successor commits.
> 
> Just like we can represent parents-children NxM transitive relation
> only with 0 or more "parent" commit object headers, we can record
> zero or more "predecessor" trailer in the commit log.
> 
>  (1) a commit with no "predecessor" is like "root commit" in the
>      commit history topology.  It is a brand new change that took
>      inspiration from nobody else and that is not a polished form of
>      any other existing commit.
> 
>  (2) a commit created as a refinement for one or more existing
>      commits record each of them as "predecessor" to it.  Having
>      more than one of them is like a "merge commit" in the commit
>      history topology and represents that two patches were squashed
>      into one.
> 
>  (3) Splitting an originally large change into multiple changes can
>      be represented the same way.  They share the same commit as
>      their "predecessor".  Perhaps you have originally two-commit
>      series, A and B, and split them differently in such a way that
>      C has half of a and D has the rest of A plus B.  In which case,
>      C has A as its predecessor while D has both A and B as its
>      predecessor.
> 
>  (4) Just like we can use auxiliary data structures like bitmaps to
>      figure out reachability without following all the links in the
>      commit history topology, we should be able to learn how a new
>      change was born, and trace how it evolved into newer iteration
>      of the moral equivalent of the change, possibly as a series
>      with mutiple commits, using auxiliary data structure, which
>      would represent predecessor-successor NxM transitive relation
>      in a similar way in a form that is efficient to access.
> 
> Something like this should allow us avoid relying on "change ID"s
> that can collide elsewhere in the world without having a central
> authority to assign them.
> 

This does seem like the most "powerful" form of this, but does lose one
of the "simplicity"-based advantages of change ids.

Of course, you could simply use the root commit ID in most cases and
that would be sufficient, and in cases where its not unique you could
have tooling show more data and allow users to disambiguate.

This approach also likely requires the most "work" to implement on the
git side, vs storing a simpler single-value header.
