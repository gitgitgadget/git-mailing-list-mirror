Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EC25D52D
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753535; cv=fail; b=YHZwj/PqaWzFL4tMEJkcE6xLTvFT5tQjdciuKb1rtamdPoIVvUcD+FYdiB3jboDtFVSVbfMt3wfTsunUKJGvY2ZZx5SWuB3sxlpNYQNFWWvQL+1/Lhyj/qKUX6VnPz8cz7l4hd1719ojeqmKJD9DylVp1DYAiBtPC+FETMbHswU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753535; c=relaxed/simple;
	bh=2WKk+bCHFeXjDvNvCTv58sVOPapdQNwYBISL7gkozs8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAh4zO3Dybdu/5OKX9xiungF0kVCCXA+EbD4BnOce0NMprEn5R9gx3fTmGGiZkbmwJ4lm1R6nIfPntp2rlp7AUEMplkuWsEadtEWcWN+lf4jVS6ca/XSmhFXT37fLDtB91uzQTcoqB+M93DqJg7S4wDN9MXzY5Cts1ijxzgbdaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1170WAf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1170WAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744753533; x=1776289533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2WKk+bCHFeXjDvNvCTv58sVOPapdQNwYBISL7gkozs8=;
  b=k1170WAfA190bJ6FBdyg9aNrOySST0tD0vo4uaRIs+xE0QOBFyFWaZZ6
   od7Ho6x9y9Nvm6Yk0hVY9jYqp0olOGO4EQfmogj7JIjKyCYjCgdaCkj8j
   E3k+6NuiLMF6TIQbPEGr7mlAMeg/N8scPLzIGw8yMu0PE0C8W1CAM9DxD
   CXWV18iohI9V9ZG1j9ygFr25D3YJ9VcFdlRfGPRvMED/0zWNnId+acb7Z
   7NOEvG6hIYCe9oI5qVjzaF1duY6q1DIvXEOy3VZ7Pmkhet3u5tP/twl2F
   SaSk9H4bdmq6lHIFGVmYUMZGecL85LOCKw+EWpUj5AfCveML4MijZmBgZ
   g==;
X-CSE-ConnectionGUID: nWX05mnxT/uHtqWZG6utTA==
X-CSE-MsgGUID: kjv1jMR/Tk+TvUfqnWTIvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45418749"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="45418749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:45:31 -0700
X-CSE-ConnectionGUID: EL6i4jOiQ66Klxmw2vHFpA==
X-CSE-MsgGUID: OHx/D79nR6CJO/Sr4FoGzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130782900"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:45:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:45:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:45:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoxhYxcw6DodNj0WFJ2RyFydYDXIS0kg6B+jC0ZlipQct1tmogbMlf6Ohhe5Be6xs34l1t5yi+sm17jOALg0yj68iZWu5fY3gPPpipimtlyFJw4gp67JoGADg5rRCQ0ZJCQNxFMAZfs7CwK9ES7UXf6GF1O3TbZGziT9N6b9ETW1KsaOlHmChr/x18F49rWZjATVrowPUHYQhJUuiAihu+yt14pzOSDB9eTL3YQtaJe1ZQ9uDM1E358SDG8kL7Q6SvDT3xd/cju1SIAg9d+gJpHNv3Mt+0fOulg0UV9rI/cZKAFn92dRbcmCvO8o8iTXGXLH48eNy7PW8tIUf+vr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMarJw2Ddxlro5DxFVWeXsoHGopuYatIp4ptTCYoY6s=;
 b=En1ogCAh3Y4V23fiBI7sckJhDNF+zBWAT4PMLX9s1s+vYHtnBgeJWLeJ9cPz1dIVIcVPQS4bukADUCklPlPZmfnOA1hCTX8o2FdDWitCYEQzej3+xoZCCvheSTbPO9DdK787d8rlnI1aDunwKyMjWCqfDmleRReaxlAaLbg9QTAiEdwzZKaMwFHrEMOx19OB2oPdH0/M0zBiZZ0MzBU/bDVhK+fBk35lDjEY5PYKm1zUxWYGoPGSKKqSV2AwYIQ+okr/kDAq+G76Jkk0PSqZzUWNj3e1EUpDCC4I1YNOVoFxE8HHMRacY12+rgNsMuVZN1ru5cS5T7yI4nM5D1d8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 21:44:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 21:44:54 +0000
Message-ID: <f5f58fef-16d4-4e98-8429-1e10fd9ce07a@intel.com>
Date: Tue, 15 Apr 2025 14:44:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Nico Williams
	<nico@cryptonector.com>
CC: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, "Martin
 von Zweigbergk" <martinvonz@google.com>, Git Mailing List
	<git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, Scott Chacon
	<scott@gitbutler.com>, <remo@buenzli.dev>, "philipmetzger@bluewin.ch"
	<philipmetzger@bluewin.ch>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 47349e65-7750-4224-b59e-08dd7c66c25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW14VERjZnpiVG5IUzgvbWVNYzVmeEtiWHRmVStrcVVxRTJTRTdIaWZiQUZv?=
 =?utf-8?B?UnV6T0xxZXgrUUVBTUF5akNVRlhkUmlyVGRtZG1ISExHV2UyNVp0ZDBTMzMx?=
 =?utf-8?B?NEp3a2NVbEF3Z24zNUMxN2NjTlM0b3cvcFRmNUJnWE9HbXc0N25PQUpBbWhM?=
 =?utf-8?B?MzdvZDlIQkJHRDZYSkM1M3pwa284a2lyblR3SHZFbk5TdmJHSWNLck83d1M0?=
 =?utf-8?B?M1dFVWg5R280bFdkKzIxQlQvbGNYeHJWS2dCZnJsaU44VDAvazExa3JXRWt5?=
 =?utf-8?B?NWlEOWIyZVVxV0lnbHltdkxxT1o4M1B0V3NaOVlQcWdoa3ByNW15U3drUXlq?=
 =?utf-8?B?WjRnSUxYck9yVkNkemVjQ0o0a3FnNmo0amFUZW1lVjdCUEF3MHhETkFqbktr?=
 =?utf-8?B?dUY5YVUzbW1XU1lKeVRhekVvTlhRQUE3MGNkQWdUU0QyeDd2RWdOUllEVW9W?=
 =?utf-8?B?VjNBMlR5Qm9pb2dKeGswSVp6M3hGaHpScklJQjdUZXRSUmkxYVdwVFVCVk80?=
 =?utf-8?B?bjZ1WnRKOUpMeXY4b1lIcHV4cXl1MXU1SVVkOUhIRStMdHg4T2lyMnVUK0Nv?=
 =?utf-8?B?OHA1eDdwL0lJYnlMOWpNdUoxYkJkVGRVYk5XZzlFaDNsYkQyTVJ1N0V5dWNI?=
 =?utf-8?B?c2kzTklYRitlakp3TWtBSXVNZHZmRGE2M01jMEVBbFJ2RzhwUUNGdXlaQWhn?=
 =?utf-8?B?NmhkVjIySVRMa3EvWithQUowUHpHSUhwdUE1cUYzZVdsY0lHSG1HYkQ5S1Rw?=
 =?utf-8?B?TExUNmM5c2N2Q3ZQYjZ4dnlobE1CNzRydndkRklPbjh1WUVnd0tWYnV0WGQ4?=
 =?utf-8?B?VHlqRkdOb2tDTjd4d0wxcWFYNTNzQUo2TkJIbWhYUjByUzBuellodjBlK1Yz?=
 =?utf-8?B?NjRDTXlENnBWT0gzTDBmMmNwOHpTSmVDb2QrTkY3VVIrYTJnbklLclZUNWFk?=
 =?utf-8?B?SW5XNmhUVXNPOVpkNTA0MkxJOExiRmRtYWFHMFBRd3h1YTA1cjdNdVNEQkd0?=
 =?utf-8?B?YmxXTk5kOVBKZERVY2pUeGIzQWhmdkJpQnA4V01jSEVXQWxtbnBXTE5PanUx?=
 =?utf-8?B?NFNwWGRzY3R3bXNiejJubEpReHVKbC9qY3hoeWZMNTczbkpCVmZrT3VjMTk3?=
 =?utf-8?B?UUtGdFBYY0RGdDNnd002Q0R5aXYyS0p1RHc2V0tRUHRPQngvMGpjS21GdVA2?=
 =?utf-8?B?MTlsRzVkOUdwU0x3ZXUxeWZQbnd2dmdDaTRrVENUdzJoelpSTmkyM3UzbUhl?=
 =?utf-8?B?bUFSTTRobEpNVXJKdFhQTHpNMXlGdWlLRVFjQWNWMDV0WW84UWRBRW01dGIv?=
 =?utf-8?B?VHJiUG1rcnJGUHR5VmlVSDVtUHJabVdUVk1TaWUwek1VenZycTRtVzZJc09x?=
 =?utf-8?B?UVU5UG9XMGppdVIrbEpodXBQUlFsMy90aFBlM1hNWHdreDJnVGxzalJXbjN6?=
 =?utf-8?B?Y2NBcG5kMUlieTlaeEgzKzR2QVVYVGxVYU1EOFh4KzA3b0RCU21oZU9JWnhY?=
 =?utf-8?B?ZGx2b1JKODZqaWlMcVFhMGVzZWZTM01Uekc5N1RSRWJhTTVhWENLbkI2QlBO?=
 =?utf-8?B?dWdwaVRtUEoyR0NFcVIrRHlmVnFYMHFrckJTaU9JNmUyRTcvWndmMkpSRjR0?=
 =?utf-8?B?Z2FuaHg3aWJYY20rRzZVck91dUFhZlNjYnhTekJzd0VpSGdQWHh1ekhFZFRv?=
 =?utf-8?B?QUJ2a2ZqYTNDdzcrRWY2Qy9BVWIzWmxYZHY2aEZZcFVFN3FVYzZib3VsQXlu?=
 =?utf-8?B?dkp1blJRS0ZUMUFUc0lMaEQySXdvS2RNTXVRUjI2NkFCTEUxNTU5S1dvZ05Z?=
 =?utf-8?B?TnFzeDZvV0dEK3FuMWVJZ1RmbHRVbVdPWlJhcFhtUjVGM0Y4OFFSQ1c1T0N2?=
 =?utf-8?B?ZEtkZ3JaY2wxeFVCSWZFMU5PU20yUm5YT1FtL3pGRyt0UTMwZkRucGlLM08w?=
 =?utf-8?Q?VxfNLThHvOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pnVEMxR20vWi9Md1NUOFV5Sk96WmE1YnZHL1RwWnNTQzBRS2RPaVY0SFha?=
 =?utf-8?B?d1dKZ2V6RUYwM3k3RTFPSS9TcHBzZ0pKeTNFMW5JdEFTUlhVTjFSNzhsT2c5?=
 =?utf-8?B?R0RTWHViSzJXemRjb0V2Umg4S1dib0tVWGVNWkh4L1lFcnhMSE1nbGxZam5N?=
 =?utf-8?B?TUZwNmtlMFh5cFhGQUZnL0F5QkdXemFhS3piU3M4LzZWOTBnWndYMjBEeVJp?=
 =?utf-8?B?U1FCTkY5Q3NMZTZqYUZSUnlFVGU1N3oveXl3VjRoR0pwRVF6ellUdmJaUEp2?=
 =?utf-8?B?Tlp0RTM3eSs2NDkwRzFPMmVHN0ZjUEkzU3VpMHlLellIVG9OMExLOWp2Zm5E?=
 =?utf-8?B?RVNKMSswbUIvdjljb09aUmI0d21YSWo3UmhJTDlNYTg2Um1SVzZhNGlLc2lL?=
 =?utf-8?B?enpyOFlTNDVlZDR6Z3YzY0dHWUhMZk1TRHN2d1ZJejhLemNINkNjbzZhbUJ0?=
 =?utf-8?B?UXZMUHNxelFQbnJGZGx6blNwNzhxdTVSUjJPNzdXZTROemJ0Y0ZhdTc3Z3dU?=
 =?utf-8?B?czlSbTQrdmVjTnEzdnB1Z0VpKzlCSzNVUXR2WDNReHZ4YVlUZzErMVpwRVBp?=
 =?utf-8?B?c1BhSHFsOEtDUitMRWxkZFg3dUVrM1RNY2tKczdTVHhySzN1RjU2ZmFmNHdU?=
 =?utf-8?B?MnRSRE5BKzVJUUIvUCtTakpmSldaUk9oWVhJcDQ3NEZXYmMrY2pZYlg5enZE?=
 =?utf-8?B?L2VSVmVObGo0TXFYODVuNzR2eUVyOGNWamhxSFgyWEt3dnRCS2UwMXMwNnVN?=
 =?utf-8?B?K0dOVUl6SWRhQS94T1Y1VFp1azM3NGFxMkhMM1JIbmZCdzVFcGVRTW9tdVp5?=
 =?utf-8?B?ZURIZU8reEhucUlEUEFROTIrQkdNb0RKajZvS2ZlZnd3NHFUdVlHZzVWdzRT?=
 =?utf-8?B?UkdzSHNOaEltVFp2YWtwOE5keklnMTB5K1FXMUZBTUdjcVhybFZQM2U4eC8y?=
 =?utf-8?B?Q3MrOG40N2NsTU9OTGs4eHduYTNMQW8wNGt2L2tIbUZ1ZmJpRE1ybUxPSW1a?=
 =?utf-8?B?cmZ6NHl1cVpWNWhORXlCVHBrK0Z1SVVublNlMVV2TmdWNTVVT05FVHdWeFlD?=
 =?utf-8?B?dXlSUnlleHcwSXFQcU95MVhEaitLektqdFFQd3hTbHY5bUJBVEhNb1p1bVJP?=
 =?utf-8?B?OUVjQ1ZyS0NUSThQbEdOZmd6OHFzaE9hVVZUYUVMT3Qxb3JsSldibjVxb3VF?=
 =?utf-8?B?WHJLbmM0V0lGM0JLaXJIYXJkN1hNMXkveHFiT3BHMWNYcWFnUTdmM29GUjhC?=
 =?utf-8?B?TFFyb0E2TjFjS3NaVzFkSGl1TVNqQ2ZkOTFSMEZFNFNuNkZ5WXhpOTdhN0E3?=
 =?utf-8?B?T2NRYm5CS1pOWEJRK1FnMUxpMmRCV2VENmNvVEFEa083eVBlZVJNckFUaFc2?=
 =?utf-8?B?S0t3WWR4SVhocVpyN2VBd0YyZk5NYTdLQTFlTWJoZk9udjJYc01wNWk5clA4?=
 =?utf-8?B?Q1VoUG9MeE5WZ1pLN0x2dEJucy96VlhIeTQrenVYU0IzN0F3RXl1RXpzVWt3?=
 =?utf-8?B?Vks3cU5DdFJ6QzArTnJLcnkycWFWc25TWDlua0NKMVl4WHgyaXYwWDNRMUkv?=
 =?utf-8?B?MlZPQUNnc09hUVNmQTYxdVZKanRXRXRGWGh5dUZGaURFQnBHeGJzZGxtbjNI?=
 =?utf-8?B?Z2N0NENSY0ExaURTWk41YWhEcWlGaElYSzNoLzQ1MjdHbytiR2RBTmhzaHhw?=
 =?utf-8?B?VmFPSWlGMldjRzc1cmwyYVVLWmNrTGc4cmxBbEZ1VHYzekxKZ1lxRXo0M1NI?=
 =?utf-8?B?c21LcWlPbFJwTWpyOWI3T0hNSzhRdVNWNm1Nc1grSFJNdEZXYmYwUGpJM3Vz?=
 =?utf-8?B?dG4rUmgwV2tpUnNKSjlCQmxCNUlZUHR6VzBVaXJOeHBWUHQ5djZ1SWdZeHRy?=
 =?utf-8?B?VGZUS0dZczZ2TzBhRjBGa2QxNjlqdVhVQ2hUbXVINlNBc0IwRDBSQ21QVFRn?=
 =?utf-8?B?U1piRnRFR0FLYkpPS1dHeFhDREo3THNFRW9WZHRRUXZnNm1Ea3lCYUVMVjhD?=
 =?utf-8?B?K0YzYVNBVE1Kbm9JZ3U4SittQTVqQStvZlVaaTM1SW9hUmdMZnVkSFczSVhr?=
 =?utf-8?B?WVR1eWplcEk2NldzWGFiYjl0OTJRZlhzckFQeWZDdnFzTTVGdm44aVlPUkdl?=
 =?utf-8?B?S3p1eU5QVy84OW9Hck1vaXk2ZjBmOEhibEliWXFnOUJCMTN3Zi9tZmNpL0Z1?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47349e65-7750-4224-b59e-08dd7c66c25c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:44:54.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJtHfiIvjUUOxw6k3IPyg7fUR/OA9FhVMuNlL6Ol9Ag/tStryss1zkD9fOKSpvAVAihXXWKtAVDTjxMzkOuJY+2QWm6BDcbpwZlB+REujrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com



On 4/14/2025 12:54 PM, D. Ben Knoble wrote:
> 
> It looks to me, an outsider, like the problem is some combination of
> "I want to track a commit's evolution" and "I want to see related
> commits in review, esp. when it's an identical and already-approved
> commit." But I might be misreading, and clarifying the problem
> statement might help bring us to a better core solution?
> 
> [1]: https://lore.kernel.org/git/xmqqh62tm5fo.fsf@gitster.g/T/#m038be849b9b4020c16c562d810cf77bad91a2c87
> 

To me, it seems like multiple different and independent problems are
being solved with something that is almost but not quite the same in
each of the major projects shown as examples. All of these projects
would benefit from having something built into git... but its a
challenge when they don't have the same semantics and don't quite solve
the same use cases.

It is hard to come up with something that is general enough to cover all
of the uses cases.

> Cheers,
> D. Ben Knoble
> 
> PS This discussion feels somewhat related to the classic GitHub
> problem of not presenting interdiffs/range-diffs: GitHub shows a
> too-flat source diff on force-pushes. Perhaps better web UI tooling
> about interdiff review (which I think is one of the things Gerrit
> does/wants to do?) makes change IDs less necessary, since interdiffs
> help connect evolutions of commits?
> 

I think interdiffs and range-diffs are very helpful. More exposure of
these in the various forges would be good. I suspect that creating an
easy to use web UI for these is a hard problem, especially as there are
a number of corner cases to get right.
