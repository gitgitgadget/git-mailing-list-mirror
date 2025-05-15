Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850041F5827
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340690; cv=fail; b=qDxev5j594LzPACELmSUIi++frVcUsJey0OurlQRT/C3d0p83Cw1HD4SEtnRR1BfcRIoEgguPQKl8lWO+OQVjYv8+pIFd44STyh5Sxctr/9njpWg76Z62spp8qAeTS7R60ntsWR1Y6RWm8Sc13q5OGzbeveiPFlkTgQ/7KJlhZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340690; c=relaxed/simple;
	bh=fEHWBct16hqxgPi9pyiZmD/XtqS6rRadTYLpwjcfXQc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaopGX+kLoehE7kbCzKAXnn5gmhiCg9gGtFufy6oGzbEqPA9zUHhW0C/dqH1KwLx52WRUxUKZMzse2PutQJkdMTroaOmBQzl/YpG7hJ5xIYZxkJvF87/BZVbtyTbDkhJ9sPQyUU9zb1N5ksMLl1VLGqLikZSaAnce1tc0xPNJTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUXIXTC6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUXIXTC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747340689; x=1778876689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fEHWBct16hqxgPi9pyiZmD/XtqS6rRadTYLpwjcfXQc=;
  b=NUXIXTC6zO4wC89mcPYesXXbAjfWOdITddE/jStqdxhGX0ZEwJlSNmsl
   G3XKi8Rqfv/cJYSv55/s0yGJliHCWhEL8M51sj8JTgDDnsH8f3n4mATXL
   z2/0hq3Z+p/B9TvQPH5eLSuWiVPvLqOGO8dNz+57ePcnZG9YrBZLQwI+G
   rdgxw59EcxhwypCyw0il59opWMQMBszo7i/VM6/tNbkXqncHEzCuqV9i/
   5qknQhD92DIvqA3k4cyBDvbO61QMGkEE4EJdx7TvEZ3PyJJ+IhyPHMtLC
   GKz/RiMHDjPZpY8hpDHofChTmbwNTyaPKVdMLY1N1NlbxL7TvDnAGO9jZ
   Q==;
X-CSE-ConnectionGUID: Nn13VeP8TK236s6bW7aGkQ==
X-CSE-MsgGUID: JW+Psc7NRHS1X43TtNYucg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="74700528"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="74700528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:24:48 -0700
X-CSE-ConnectionGUID: WesnnyLhRvm+Pz79drU0Vg==
X-CSE-MsgGUID: z+QoSMmmT56PD39XW9/cHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="138376920"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:24:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 13:24:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 13:24:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 13:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfLhVhw39thFyQ8+BPVKn0ZOuB2nBPLcWhV2i3487WfUDjUI3e7SvwC/G/ChPZxaoiWMWHfSFvNrGkDpLDwaaIrTxwPbslHLn1nprow60e2wbVtWszVcjpRU0QoE4WTna43LI4PIOtUo94+NBCFI+X0nOcHCQuuBkun0so34yw2zaemz4L0S5verw2WS7GREYvTbXwsHXoaaOkwQMEUo6sPyVqD3yFoqppXeMYTX31RacYFt411rnfZCO4H92mMJUy/Lo04jGQ2Nj2WPGVSH8mOSMbXd/fKkogoNLC755IDchBeyfZcRCtweoJTbTS1Iuh4bfiX5/dkPkaseOhw9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tu8IF0FJXMObMnQDmP8TAt5PHxCTfqV3gZtUUfzK/k=;
 b=do+17K81D25f8wimOul27fUAs/ybhXqlif9sYuaiquIFoxBxRkHHs817P8qYoaJR7WJ7UN5E1Ive8S77lE27Mhk7Mf9PIJ6w9Db7LQ2EgXCcw3IxR/REjdp/0QHRdi9qZXCDTH3cKQvweq2rhcFS5JQ6hwiniG0QVaGoQv4NX0RYXb/Gd40L94cFSiPLx/tBcdtjfpiA9vkPiPFZZJobd3VRsklU39Aty6inGDwh3rUKnNYb6wZ6AVmvJ9Ri6GvQRPZ/Re3EhbA5RijkMD3J7z4cgmStra3b0hFylj0xQYtUzCHqm1Kh3JA5Tc9K/5f1pC66b4z78u6S6JVu/xLUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 15 May
 2025 20:24:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 20:24:45 +0000
Message-ID: <b7fda1fb-3d4e-4115-bca5-63f2e7829ee6@intel.com>
Date: Thu, 15 May 2025 13:24:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] diff --no-index: teach option to exclude files by
 pattern
To: Junio C Hamano <gitster@pobox.com>, Jacob Keller <jacob.keller@gmail.com>
CC: <git@vger.kernel.org>
References: <20250514204014.3106177-1-jacob.e.keller@intel.com>
 <xmqqzffe7vbh.fsf@gitster.g>
 <CA+P7+xqg3S0q=n3nrTUJJuYicooDm83Q32AkpzRt1u7rH3n3Pw@mail.gmail.com>
 <xmqqtt5lzqxh.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqtt5lzqxh.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbf0810-2180-49f2-46b1-08dd93ee87ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmFTOENidDd0SFZrRXpzc2FWMTdoZjJ2QzFZelFuZXFueURoNGYyUTEzQUNS?=
 =?utf-8?B?ZGx5c0hrd3ViU3Jzb0V1OHJtVWExVG9qWnlpL2V5amRuY2I2c2hKT1VSUXFx?=
 =?utf-8?B?YWJlYnhmZkFaTlVOSHlUWHdRakxBTTZ2N3pTbHlYWTFtUXU1VzE1SlFsSFE4?=
 =?utf-8?B?WStGQWFCMHI0NU1iY2ZJdlZvZUhEMXRRL2plOXlnZEloNHdRMm4wK1VWVHk5?=
 =?utf-8?B?UjZ6U2hBdktvZEIwTHA5VFFWMXZGYVB5Y0Q3Tlp0TUZNdzVFWmc3TytXRk1L?=
 =?utf-8?B?OTkySVRwVURuQk1RR3dvWnZ6Sk12V2ttcnMvako5QUwzNGFCMytCNVNtdnZ2?=
 =?utf-8?B?a1hsV1BjVUVwS3dvdDV3WmU3SU92U1FBaWVtSTZleTM3UEdTRjNKcGdRRlk0?=
 =?utf-8?B?aXVEbS9leU5qaWRQNGQycHA0NU1FU1pHbDRTWnRBM1c3QVVKb0ZQUWVTT01u?=
 =?utf-8?B?UWtGZWFIK0ZwSlU0QjVySHRqcjlFc1VPZGU2WnA3VS8rSSt1TG5LQ3ZzUXVt?=
 =?utf-8?B?RnFDaFVwYUxTZ1duZXArWjhGbnJLUmNncStOVmtyVGRIbVBRdjQ3NUlwS2cz?=
 =?utf-8?B?NzNPOEVQYURFTWFaQjdKaVUxNEJjcExtUEFndEQ1ZjM0Q3VmVllqREY5K3BY?=
 =?utf-8?B?RENJSWVZRk0wN2lUNXpIQkQvcy9WeG9uY1hRa2NhR0c0MytQQlZBSDhKcEJJ?=
 =?utf-8?B?cGRqbCtobHFFYWxMYnZSTmhEOStGNjNuZ0k0dE5JK0Uwczljbmc1QUNpekNU?=
 =?utf-8?B?dCs4T21heUowRnE5N081Y2R6NHR4cGpiSnp1R2h2T1d0UzdhQ1Z4VFVSTjEr?=
 =?utf-8?B?S1JPNlZnT1lVeitMOEFrSnJNTjFNTDdMR0V3Sm0yTDVncEd1TWVyUmtsT3Nk?=
 =?utf-8?B?dlA4ZzlCc0Q2Mjc4NWhkTHBNdUxBN0VDWTRTdUlRVzFHY1FRRDR5UHlNTE4y?=
 =?utf-8?B?cVZ2YW80Wm11dDhNZ05OQm4vMG1IVTJGcXNDU3Y4RHZoMncxK1hPUUx1K3hV?=
 =?utf-8?B?MEs2UnNabVhqc0tla1VTaHRqeHh3R2hXZUNXR01lZG02WXJ5d2pZTjBEOTJG?=
 =?utf-8?B?bFl0eSt6OVRIVDlTTXZBVVhQOEFTTzZyUTRRSHlqYXVNQXZUWFk2aGxFZVc2?=
 =?utf-8?B?QnZlN3h3cUlORlo2L2syeDBnRXBOUjE5aEV1V3NhRHVZWkh4Q1hiVWcwZWZM?=
 =?utf-8?B?ZlY5NFhrRm5XZmZRZjhFY2hVdlRLU3NvVU9lamJJSyt5YVdrYlU1c0VxWE1I?=
 =?utf-8?B?Z000T2duQVl4R3hWdGJNQmk2aHhQbm1qcGk0b0dxNElYRUY0UVl3MGtDM0ow?=
 =?utf-8?B?L08xTmpKZ2ptL0xXc3pvbXBLRGFkSUZQSEk4Z0UrTHY1U1I2TmdpdnIwRERn?=
 =?utf-8?B?SUw2dXBtZWVIQWg3OXVqWkUrQWFGcituUmRPdWNIK1g2dXMrTnBaUytQOE9G?=
 =?utf-8?B?M3ZsZmtkVkdEanM0aWdQelFSL2ZwWGsvMk1sa282QnRKUTV3UHdnTEN2blhB?=
 =?utf-8?B?ZTljMmJzTW9COVVhUGFWL0RsajVkUmhtSWhjRnhaVitVdmtjc210NG9uejNU?=
 =?utf-8?B?L25IY3U2bUJGeXRhZmFkQ2FUSy9DNnJjM1JTanN6eW5iay9kUVRyVVphSmpt?=
 =?utf-8?B?UVM3dnlDYzV3dVJGdUt1ZnIyQjdFZ3hXTmQyaVUvTk1ncFRIaUsyRGxSc3hH?=
 =?utf-8?B?aWZVYlVXNzJJYWJ5QWZTSk9COGRBS0p5amxWZDRYVzF5NElHT2FHVUVGSFZ1?=
 =?utf-8?B?NGR4Y2Y2QnVPTUNJUDM1Kzh2RVN6WmJwYWx5MDkrU3BaOE5uZ3ZMMWJGNVJW?=
 =?utf-8?B?TXhTc0I1NHBBZGs2SFlQNkF1Lzh2eHl1S2EwM21WSDUyRjdHcTl4YjlZT1dx?=
 =?utf-8?B?NjhuWGJFRWIyUXR6bTB4YUlCeG14cU94ZVBFajBWNWJBYUdnVmhVcC9NZzls?=
 =?utf-8?Q?dLgSXmNIX3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhkR1dkS0FvUFR4ZnEwYnRWU2FHbXg4cllJMHJuN25aTTR0dXQ5cE1VUEtG?=
 =?utf-8?B?UmJlVlEyZm0xelIzNnVJbUtBMGJFQkxFSmFmcEtOU2xXOTN0R1BDbHlrdTRI?=
 =?utf-8?B?TTFZQmNVNHcrMHJUZ0Nyc2ZTN2NLYjJqYzhjbyszSTVTcXFJejVHODNRRTNh?=
 =?utf-8?B?azRQaWgvQnhDT2FRWUwvbnhERStQWTU5VitYZWdyZkp4cGxZYjAyQUhFZ1dz?=
 =?utf-8?B?TVJxUitHdkJQSGRleCt5TFpJTzNVZGsxQno0L3MwTEdMTFBFN1lsSURjbTl1?=
 =?utf-8?B?ay80Tk5KMEtDT0RreERuRnVzOVNBRkpaR1ZhT0JxSXN1eEVVbVBsbExJS2FX?=
 =?utf-8?B?dkdEMXNKQmJORjVmcjcxNFB2aW5LLzhiMVAxWGc3RlBERjRSN1BBRUYyRUVn?=
 =?utf-8?B?NVR5VGY4YytGcDI2TVR6NGdHcmJRczhMeFA0UFJSeWh6R0Z4VGd5aVZrZjdG?=
 =?utf-8?B?d3BlVTJCbEhURy9UMkZhRWVQc3BYV3ZuL2R5M3NrOVZGZjREQ21iZkpxdUxm?=
 =?utf-8?B?SWd3dEsxSjlwakNjcjhVMUFOTk5ldGhTeUpKcjZjUU1xdUFEeU5CMU44TmZ5?=
 =?utf-8?B?QTJydUFrajJRUmE2WHk4Z3d6cFJ5aU1pWFQzMXRpZjVYdjlBZm9pUmkxRXN5?=
 =?utf-8?B?NW9ZdmpOcEFVdzJTQTIxQXVhOVhZM01KMkNINUFETEt4bm14YkZZeU5ZQmlX?=
 =?utf-8?B?cHJZaVlyeG1lUE4wa2xtR09KZ290NkowcDdHTlo2eVZ5T2lYZVh6RERVN1dI?=
 =?utf-8?B?dllNTE1ZUzhCK0sxbis5MDdvam5YcjdEYzBlQTlIanFHWjNEZFRBUXVrWVpG?=
 =?utf-8?B?UmYrM0k0YWlpSU8wOU9DNDRmV082dTFrTVJMeURyUENZYnU2aWV4aHRqbFpw?=
 =?utf-8?B?VWNBUjZJSHhnU1VtMmdVYlFGZ21XZWtXRThZcTJpT25lTnVQd3RXUjg4VGNZ?=
 =?utf-8?B?bFA3Q0VTdDRPTmtSNWJLQUdSSHEySThYK2lRdGtnUW9WcmQ2ODVYZ2Fxdzgr?=
 =?utf-8?B?eTVuSjhNN1BNa2VWUHhjK1U3U29sZXBSelpUQUlkZXpONnljN3F0emlyZmZq?=
 =?utf-8?B?T1FPSnpuUE1PcU9JdVZxdkthdnhuWEZycmgweG8rUVhrYVpER3oxaXRKbXpS?=
 =?utf-8?B?QWV4d1AxOWUvalNWazk0b2pqVmJCOTVoTkFDRmgyT0ExUWRkazRST3l5SDBy?=
 =?utf-8?B?UG5YZVJiMEtVV3RIU00wSW4xQXd5TFNlakczbkh2Z1puVjVtSkYzUUE1eEt3?=
 =?utf-8?B?dzl3dzRJOXhybCtrb0FRUThTRmZQV1BIZTdOcHB0NE5TUWVTUjI3Z1NldENr?=
 =?utf-8?B?b2dDL3F0SVRucmNRbjZQcmRrcHd3T1NrQ2RlaWNtTzBYWkN4WHR1amhxOVpQ?=
 =?utf-8?B?YXF1RnVPY1hxQ2ZadDIyOEpLU2Uyd0plL1czMHRXaGRNOE5sWE0raTV2aU9I?=
 =?utf-8?B?S25EeURub3BGd09ZSnhGSFhtSEN1dVU5b3JRclZZOTBWMFJPczBWWlFuckJ4?=
 =?utf-8?B?OVNoTmc1WkJBODBJQ1RsR1hLWWFwSmJZTFNnenFYenVaYkNaNVMvTDhIOGhk?=
 =?utf-8?B?ZENRcGRIR01WekRUVGtPbFZ2R25DK3VBRmRUdlZDdjdKMGxKNlNTLysyamhr?=
 =?utf-8?B?ZmFhUlRRTm50am5ZWkpybVJiMGV0YUxLcU5KeUkyUU1qbzlHZjdvcDRvOG41?=
 =?utf-8?B?NVU3QzVhOTJEcWcxZUN1Qi9Pd25vMVFqOHl2bkQ0a0Qvczc1aFdMQnM1NTN0?=
 =?utf-8?B?UjFHMjk0TE0yTWNCdTVuOXp3K3FyMHcyWXpPaWFkWUNvMXF3MmNaUlU3OERC?=
 =?utf-8?B?M3NaSHVYMis4aXh2RlEzdVBLeExYRjFjb1Q0QmdQdnhrNzFyOEdNRTE5WEVj?=
 =?utf-8?B?SUVUZ2IwRE51bDVZOEdBSmNQdE9nOTNlc25MT2dkcnFpLzhTQm1QTGtkSHdQ?=
 =?utf-8?B?SDdnRXZRQjNLVnpsNXdZY2RtWjZiQ1JmaXZ5R0JXZlBuOS9hM1hQS0taRGZX?=
 =?utf-8?B?QUI2NEZrUm0xTWNkenA1T2hCTHJRcjFWcG02a0xXNEdaMVQrS1EzSnVwSVJC?=
 =?utf-8?B?WGNLNElFK2F6NkpzNGYxNTJWQlNveURzY2hXK3hTaThSYVYwZlB3QzZmc01D?=
 =?utf-8?B?eFdiOXJqRDNaVDdoeVNBYTFGTCs4eW9kMVgrSzd2M1cwV2R0OVdNNGF2UFpj?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbf0810-2180-49f2-46b1-08dd93ee87ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 20:24:44.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsAu5JeJOiNhfl8tQKyRaHyI8FE6m8KLDsiaCWmd1tAfj+kuOYQLcn9TEJquVMIDD+nnp33eKeihIVvi3KIvx95gB+ohTLOavyTOf0LTAEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com



On 5/15/2025 11:09 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> I guess the one weirdness is that pathspecs must come after the first
>> 2 arguments, since we need to find 2 paths first. But this matches the
>> way that treeish must come first in git diff-tree -r takes treeish and
>> then pathspecs, and you can't re-order them arbitrarily either.
>>
>> Does this sound like a reasonable extension to the existing 2 argument
>> form of git diff --no-index?
> 
> Absolutely.
> 
> Or you could even use "--" convention in the examples you would
> write in the documentation, even though you may not absolutely need
> it for the purpose of parsing the command line, to highlight the
> fact that two things to be compared is given and then with an
> optional pathspec after the two things, e.g.,
> 
>  $ git diff --no-index git-1.6.0 git-2.43.0 -- Documentation/
> 
> or something silly like that.
> 

Yea, I'll do that once I get a version with doc. I sent a v2 that works
ok, but I think I need some feedback before I fully polish it, since
there are a couple of hacks to get things working.

Thanks for the feedback!
