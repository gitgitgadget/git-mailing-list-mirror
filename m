Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C390253357
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753170; cv=fail; b=FYGHdN7U7tSimBuNAj0wfvJhPTj8IB9n+oIWI6myOPMC9TsUwzqF7TuA04/bp0OdDtkuell9NpGX8b+6uZITk+DC0gjpiXKVm4uWhuMDI0VZYj0hNHaUZbKCYvGflXfiFTZah8XdoIAoXyBYc81KkmOv5Ur7AOlknQzvlwgOiXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753170; c=relaxed/simple;
	bh=qM+BteZ9FXN1k4sseI+f3SZNNCtB00p7Q4RBmPjcwsQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WXwUiq267hTcH18j6jWvaeW2+XcS/hih+h/PqErg/bYgC9LZgHNiCjQH6L7GkRRr3ObwFAQ89SJcFu1fHyU3fXiNYNl7q5xD8zZPoptZIR+mct6Jn527TkVUVGNCFgDM5iLKZMtr5UvX3cDS5rUTVmJ0Fvkr6mcDcoXgD4yew9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjAbQo2r; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjAbQo2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744753169; x=1776289169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qM+BteZ9FXN1k4sseI+f3SZNNCtB00p7Q4RBmPjcwsQ=;
  b=jjAbQo2r9wua7862UusIauriHcd8n0XP85awq//SrTTPDJRh9/JFtSXm
   2jy1NJP178aOXaVoRCHFPBPM+53e1nWroBg/wJqNaeAhBcqonmiYjjF7Y
   d3BAJo5NmvwvbwVbPB60a2vIY0s3S7a6GR1OPYLfO1PLOib5bkesBRO1g
   PZlKOYh021wQW6/CnoJeoGg9Qeb6X6XQ4ePbajoCLQRlW1AQRl2J8hvmB
   oPJBExV4ZdaDvnaEKyaYeTKHZnc45I8SaZsF0kRR3/1m7ck7b0wL7bXLe
   Pwktq7X9Cs9TvlFWotNHdYy/atDnZaJJvkD/WpgjlkSQf9i+Ata2OHz7B
   A==;
X-CSE-ConnectionGUID: IXdgiZuZRIShGru8Vbc5bg==
X-CSE-MsgGUID: DwsVcRleS6adOi3Q85569Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46162837"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46162837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:39:28 -0700
X-CSE-ConnectionGUID: iepL9ERBTuaytT+gM+VarQ==
X-CSE-MsgGUID: Eu0TjWgkQLWb1j6vTMHA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130554430"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:39:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:39:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:39:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwVUndS1qkXCjq3TwbbhXF8/yDFMB2ENKVDvnym9ZimIxvNS6tAcSQaVzwuUK0jsO1JXd8OLxN/UEbW7Q3eYjPlj6QrkNJicNYOtJQCmKn1PIX3fUKT+C80iMnf7bSpOvJ6NSfDNnaI6Uc+BoHfe70bOTwenReYDqeQdylY8fMC3WD68qvSwPTfcqUd2/htDjXWZFxL6IGrHR5aBn54jQBBOiOqruL1EnPgrMFDAvU+FCEvtyxkOdD+H+SzUISjN/PxaW6ZbB+i3YEs7UMLHnn3U4jnpRVElmSXtklnFycNyDQOja1JW6eJFVWSWo27CFrSRT3qelfYMFlkwmRlNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX9z9onX6MmASa86vZMw5kYnJ/nH7GaDJ2U73ODAkJI=;
 b=jWGnaM22m6bkBwBbdAbNBUTZidaXaT1AoKQZPOhnOUBZ7hlM5FxZFj+sg1sYleb8tZNZY/RG3AmzfnUQyi2UAeb5Ko7e6VK/KI1uExR5ZFVei0/oDmUbgV5GqB8ZBdnNZhI29bCn5IVJRjTAwRrHjybKYPgSz8oLeUbEhGGNwVQTwwFvq5/VYzJwtmMx4CfHep7Bp36Pvq/0fMMP1WlmTa3sLUpJ6KFO4etWHqRLXe5w7j7KoVeqXHi2q+qCeB7Ra2EuYNQ0vej83+aEYIBq8bfqf0TMmUEnB5t1awcpHj+XJfvB+DkGIMd6yLtESMRT4XMlIQlhMlSir5SGHgsQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 21:38:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 21:38:55 +0000
Message-ID: <acadf677-502b-4c55-8c7c-4d0929d55603@intel.com>
Date: Tue, 15 Apr 2025 14:38:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
CC: Nico Williams <nico@cryptonector.com>, Martin von Zweigbergk
	<martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, Edwin Kempin
	<ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, <remo@buenzli.dev>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
 <20250411154839.GC648081@mit.edu> <xmqqfriemw38.fsf@gitster.g>
 <20250412231318.GG13132@mit.edu>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250412231318.GG13132@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: a168d3e9-a288-4755-45bb-08dd7c65ec45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0NvbTI1anNvNlh3MzZELzc2U3p0SFBQWmRYenQxZVJHb0NJc2RiU0pkT0dq?=
 =?utf-8?B?Wk9FZ0FIclZUcU9lSjVkRDJRTjVXcDVPdTRkLzZSSE94OHpxeTRQc3VWSXc1?=
 =?utf-8?B?ZjJkT1Nva2psWUNYS1R3RkhBUFlPaXNpaXNKVEFUL1hGblVzc2tkY3l2SXBv?=
 =?utf-8?B?ek93YTM4YlJmZ0FmSEdwWXMweHpnV2hOUFlpc0x0a29NNmlRbE9UY2U0MENZ?=
 =?utf-8?B?bnNvLzdVQmRjbkd4cDJGNi9EekNJKzhsRERGWlQ1M3poMDJVeThRVEtYdFBh?=
 =?utf-8?B?bGdWTThHUWFzSW5hbVRCYUNxZ1RoeW1Gb1M4WmQrdlpuN1p4bFJWSXZhSkV4?=
 =?utf-8?B?OFBYRW1XMTBFdFdrQUs5aGxnRXBBUkJLdGxIYjk1eW1DbytWdzZPRjdqTC80?=
 =?utf-8?B?YzJZdFNucjhnVlBINTY3blBVcDJ3WDc2SVFwdk4xMzR5VFBIOHlLT1N2c3Ju?=
 =?utf-8?B?VUFMVGl6NmhzUVJ3YWtldnFxMXpLTXd5QUxpdTNndWtvbUxlWDR2VWtlSHB5?=
 =?utf-8?B?b2Y5K3VaSG96VU1taTY1aEhPbmJrbkY0aVk4Q1ArbVpRZ1gxRmt2bEduVEFX?=
 =?utf-8?B?SFpLekx5SHpkU1VrQ2RheWV5UEtFa2R1QjMvbmxFWnlFRE44VmRZWlBzdUdu?=
 =?utf-8?B?S2crcnJkTlVaejlTSmZ0clJmakRwTnZkc0kzM3hmZnhDbnFxQVA5Y3lvR2xt?=
 =?utf-8?B?YzE1TFBnTVV4QklBalE0K0lET08xZ0d3ajNrdjlDaFZ1UExGMmRtdWdVYXFk?=
 =?utf-8?B?M1pXMXc3Sm9Yb01zTXptbjlQVG1rdzRGS3VnSDgvZTFyNmh0Y25ReVB0cGRO?=
 =?utf-8?B?QSs0Ny94dmJueHhiMGRGb1A2TnV3M0NpNENGRDdjZDRuR0swSEFaYXEzQUVW?=
 =?utf-8?B?WHFON0NQa1ZMdWlKUmpuTW96d2V2cWptK0RHRlVBZXVqN2EwWG56Qk5vNm9s?=
 =?utf-8?B?OTF5OUpVbUN6WCtTeFdKczk2WFMzTG9QL0RwOHhIcUlOYTFMUkkrZFQ3bWcv?=
 =?utf-8?B?aXRldDU1WndNdU1jTFpuUDIvVVNyMlAxZHorc0EzaHhUNnN5NEY3YkgvSUpr?=
 =?utf-8?B?VmJiZThxbGdRcXRUSzNYNW93a2w1bFVVU0lENTgyTmJpbVJpclhxZ1psSmVj?=
 =?utf-8?B?OVNhVTZyem1jaWRQY2pjd1VUK0pHTVl1UmRES0pCWUVTcThLZWhNWVhicGhn?=
 =?utf-8?B?QURFVWFueXYzSlRxWXBId1ErRG9adm5LS09qN3Y5SEwzQkZsNThWZTJFMis5?=
 =?utf-8?B?OGE0eDFqR0NxUEZpYUVPWGt2cVh3QVVJUElrVmU3Q3pnY1lScFZGR3JmYVJO?=
 =?utf-8?B?bkpjLzlaN2VWQUIxODA3N204MnovWTZQMjdaVzVZdkQydU82N1JQdUxXdUpw?=
 =?utf-8?B?dUYrWUJUV3J4dHhjUWVoSDVMdGUrVUp5THNEcStadWNONGdoWmRNc2d1QUta?=
 =?utf-8?B?NVNWYndtU0xKOGRjNGZQMG0vc3VWWkwwOTVQSnEvQWcrekF5cEo0ZXRmeG9E?=
 =?utf-8?B?N1l1cCs1TzlDYTJ1aGd4M29VM3lLUjRIdGNUN0xqWkU5YXlLd1NuckhrbW1u?=
 =?utf-8?B?T3ZLdFJtMndEd3MvTXBncURtbGhsd015Q2p2d3NwM0Z4c2dTeUFlNEloUUho?=
 =?utf-8?B?VVBnR0ROS2Z5YTVYc200bk4vcjl2aW5OSUovekJrd1ZSM0tUeUR4bTF1NmZv?=
 =?utf-8?B?Mi8wWUc3SFA3T1RnYmhEVjF2OGl6eU9ZTmh1Q0U2RENxYjB3T3pBbVp1SEdq?=
 =?utf-8?B?LzdFRkgwbElyVWVLZ2xQMTdKeW9BblkvZnBuRCtDdU9tNHFLTGU4UDlpa0pw?=
 =?utf-8?B?NnpCRXpmZXlnWStXZWdIN2lvckp6eEMrTVNqQ1dLZnZXdVNnWmNwdENWRzZo?=
 =?utf-8?B?NXQzYWhYeGdkc2RnUHlGalNQOHZkK1huRUZId3I4Sjh2R3M4bm91SzZ5RU4y?=
 =?utf-8?Q?JfyfB7/Go0g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzY4UjBydCtVdnhtTE5IdnR5VmozZ2FFeUZSSHA2RnkyMzE0bmVEMkJvNFJ4?=
 =?utf-8?B?ZGFjQVp2OG5rTU9FbG93dGZ4RVdYTFp2UGVNbHd1V255dFJPWG5UR3o2WTJK?=
 =?utf-8?B?bVJtL1o3VGNPR2YzcFJ5aHFHcklpWE5PMXhSbWd3QUVYMk5WMTV4aHllSFZu?=
 =?utf-8?B?UWJGWURkUkgwSnIxMHdOeitqM2NGU3VlRDVrKzJ5Rkp3VGJJR01ZLzBEQmQ0?=
 =?utf-8?B?SzFaaUlMRlc0eUttUDdaY01LQVRlMnZwaFBNekNaNWJoN0tNT2txYStSTXlM?=
 =?utf-8?B?RTdHcXFETDNRbUlxNW9FZFZnL2NOaFQ4VDdScHhxekswK0cwTGplVUdUbGh1?=
 =?utf-8?B?aXRMOFJ1WjMyUVlMWG9vcnQ4MWVKVWpuc25qSDVvbkRsb2VEdFJOWmt4K0ow?=
 =?utf-8?B?c0tIOG5hRzhvWks4MXc4MWNFWjREWE9mM2V4MUJJL1IzSk9SOGZzK1VBN2g2?=
 =?utf-8?B?YUJjajRZOFdxaVVacC8rSDlIemoyNG1XSjUvbEZqTFdZWDFONzZWZjIraHlJ?=
 =?utf-8?B?Z0R2SytDMldFY2trNk02TmZGNklBOVNTeTFmSWQ2REE5aFhkS2hUMVlrZ3pu?=
 =?utf-8?B?YnJ5dkpSUWxqaE84bFJBV1FtUi9INGFhY2F4QXZqbHhRUzFzU2tFajJhU0xh?=
 =?utf-8?B?STNrMit4c1REemFlNlhLdXVWWHlOTmdnY2VTQlAzSG9aL3Y4YW5lUUxvb1Rz?=
 =?utf-8?B?ZlFnREZ0OTljM0tONzJlKzdvZnJmM2x4QVF2cXNoWE9oTlZ2cVpNN0g2SWF6?=
 =?utf-8?B?OGVUK2dNRlpZaWN3SGFJWkhCRG5EOFNUK2dvVUtRSkZ4K1lmMTlkQXg5SUdh?=
 =?utf-8?B?ZmwybzlLWnp4SiswWC9BVVI0QURONlBxeEtpVGZrRGF1S1pzdnN3YndPY2Nn?=
 =?utf-8?B?dEZ2K3l6VFFHQWRJNlJJR0RKS2JiQXJNY0d2UVdvaE9pK0l5VitnR2tTdmlV?=
 =?utf-8?B?RzN1R0lMbUROTjhIaG92T1BKV1E3dmluTkdOTTlCNVZlRllPVE0zUUpxVC9x?=
 =?utf-8?B?emRNb2VwUHZpQzRIMXl3dUVLM0hIR3dybStoZGoxY3g2MnJRS1FIcTNhWlpw?=
 =?utf-8?B?aGV5WXVqeGo3YW92bEpCcEh4bUphNXJvWU5ldTJ1UVZnY1JGTXZyQ21Rc3Mr?=
 =?utf-8?B?VWxyNTMvcUZiUGkrbG5KVFd2dDdKRWNpQlo1eEVwUExLMit4bVRLVTdvc24y?=
 =?utf-8?B?dkdocHd0NG5lWXFmd1JudmwwVVBLdzhEbXRmbnZObXMwTStWTWIyVHFFeE16?=
 =?utf-8?B?TXp6NTFWTEZ4WXhiRXdwYW5PUlhmUjRkcUxIS2V3cnRKN3NENmxuU2paVG1o?=
 =?utf-8?B?YytaUHlXKzI2U25MSG42VDViZ1k1STBTYmVYdGsyVjg2dFgvQ1FPZG02bmly?=
 =?utf-8?B?QmNJN09GRTVxVTJhUVBtWkxaTjlEVG8rNDB2M0x5RHE2ZEVIbXhJV3ZXeGYz?=
 =?utf-8?B?elIxVlQ0SldwRFFiMlRsVWFxS0VTTXdyeGZDVVg2WkRPcjh3eStmR0xXL2dS?=
 =?utf-8?B?TjBKOFVEWXpvMEd2NW9HYTZsNWlQMWhaU2FnR2JRUUs1R1NLbURqZWFSY3ND?=
 =?utf-8?B?ZHBISXZKN0JEZFdQME4reU1JV0VaeVJPY28wRXVPOHd5NjMxM2xMY1ZSNmph?=
 =?utf-8?B?dDlLMTBjTGVqYWlZRFFrcFYvbktFZjJoZ1gwcm5IODdsL2Nsb29iNnBSemFm?=
 =?utf-8?B?NDhxd0pkNDlsc3ZDTGw2NnhTd3JxQ3laZ0hsNmNYRlNDRTFNc3k5QUxxN3VW?=
 =?utf-8?B?U3lLSmRabW1CeW5NQ0ZiQUVxcDlsaktXZ3U5SEJqRUw5VHNjMnpBNjlLSjl4?=
 =?utf-8?B?TWFwT25DMzc2QzYvZkpnUUpmaHl5THRNVlQ2eXduUE5WUnA0OXlOUzlKaHN6?=
 =?utf-8?B?cVV1MDl0cDNCNEN5Mmt2bURYL092KzFLT0hBaVk2WktFUGY5OXFXWTNDQ2lD?=
 =?utf-8?B?MGJ4R0REWnV6cldPb3gwR2Z5bVovcXd6b0Mva0ZReVB0Ui9YaEpaaU8vM08z?=
 =?utf-8?B?OElNOFp6NFVjaWl6aDNybzBudVk4Z2o0aFlIbWx5Z1V0S3RxVUJZaFRTRHpH?=
 =?utf-8?B?Z3p2Nk9wWjVvRWNuU3gvZ2hBVWpVVXdJSTNod0FpR1NKd1Z3R0V1V01XWWU2?=
 =?utf-8?B?ZndrYXhxYWtyUUZVcTNNb1lNeVlGdXpmMlU1K25PcWZpVVRFd0NPSWorZk5z?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a168d3e9-a288-4755-45bb-08dd7c65ec45
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:38:55.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0gnMjlCFxQXwBgc3jKA/6SpZbOrvLFbTDyafxbuOdRlDbjY/WhFaa7vg7dTA/u6WFOl5yVwRWvDLfC66O418E4dtc4lKrBfVusRXw8lJMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com



On 4/12/2025 4:13 PM, Theodore Ts'o wrote:
> On Fri, Apr 11, 2025 at 10:44:43AM -0700, Junio C Hamano wrote:
>>
>> The submitting contributor must make a conscious arrangement to give
>> a "patch set ID" shared among the messages in a single iteration,
>> and everybody who are responding must make sure they do not add the
>> same ID to the messages they throw at the thread in response.  Those
>> who use format-patch and send-email can do that with convention and
>> automation and there is no reason to rely on In-Reply-To: header
>> (which may confuse the automated recipient of manually created
>> follow-up messages).
> 
> So it all depends on how the patch set ID is implemented.  Here's one
> way that I had in mind.  The reason why I like like this over the
> Change-ID approach is that the semantics can be very clearly defined,
> and the only thing we rely on is the user saying "this new commit is
> part of patch series which I'm putting together". 
> 


I've been catching up on this thread, trying to get a sense of the
discussion. I like the notion of this patch-id. I think dealing with
patch series as a single entity with one patch-id is nice.

In my experiences with gerrit, a patch series being treated as
individual reviews with their own  change-ids usually discouraged doing
things in series and especially discouraged splitting a patch into two
after a review started. I prefer being able to collate the series
together, so a patch-id is useful.

Having the singleton change-id semantics naturally emerge is nice.

One thing I really liked from previous in the thread was the "reverse
hex" where they suggested encoding a change-id uses letters from the end
of the alphabet. I really like that it was immediately unambiguous when
you see a change-id value vs seeing a commit-id. Obviously there are
lots of other ways to encode this and I think the thread has discussed
numerous options.

> By default when creating a new commit, the field is empty (in which
> case the patch set ID is presumed to be the same as the commit ID), or
> if the user gives a command-line flag say, "git commit --series"
> which indicates that it is part of a patch series in which case the
> patch set ID of the commit is set to the patch set ID of the current
> commit (i.e., eventully, its parent commit).
> 

> Whenever the commit is amended or rebased or cherry picked, if the
> patch series ID is NULL, then it is set to the original commit ID.
> Otherwise, the existing patch set ID is preserved.

Ok, so it starts null, but as soon as you rebase/amend/etc the commit
then its set. This is how the change-id semantics fall out for singleton
commits.

> 
> The patch set ID will be output by git format-patch (perhaps as "Patch
> Series ID: sha has" immediately after the --- line.  And if it is
> present, "git am" will import that patch series ID into git commit
> which creates when it sucks in the e-mail.
> 
> The net affect of this is that for new versions of git which implement
> the Patch Set ID, all new commits are treated as patch series of
> length 1, unless a subsequent commit is created using "git commit
> --series".  And the Patch Set ID will be preserved across
> cherry-picks, rebase operations, and git send-email/git apply-message
> operations.

I think its likely for tooling to emerge to retroactively convert a
branch into a "series" with the same patch-id after the fact once a
series is formed.

> 
> So if someone replies to an existing e-mail thread with a new commit,
> git format-patch will give it a different patch set ID, so we can
> distinguish it from an amended  copy of a patch in the patch series.
> 
> It also means that singleton commits, the patch ID effectively acts
> much like the tranditonal Change-ID.  For multi-commit patch series,
> all of the commits will have the same patch set ID.
> 
>        	   	   	     	      - Ted
> 

