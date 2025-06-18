Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8E27E064
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288513; cv=fail; b=VLgVOC/bAfVJ9hcrMr5l3lKHXaqz8U1dUDoHNWP8d34QgxM0yWJjCPW59XR6oIxB66G078CEJ2rHIJFCOn7ZHP8FlNJNqF+bjrhS8RLm3McV3KeltvmGqWQuT6pehfEFtyvPiEjvh6kZnuirRdpyiykCqXaZ6AoamuImxUEErLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288513; c=relaxed/simple;
	bh=iQJs365aot0/gxWqEWmdFeURNCErE5k//feZR25ew9o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJOyVIsb7dAEFCTLSpIq0HV8+yEkki2FkbwNxRghLYIbmeZxpzUrCNYzXoPhvz9EUSOCqVOZNRzrtKNIYFI0l6d0ElO1bxcMsqw7+rV71KR/l8ud40ogGiUJhHbnXzjT38pPaHlsMz73RzpLz/99PsTORekcFErMpJ9lmSWp0YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmNhJCR6; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmNhJCR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288512; x=1781824512;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iQJs365aot0/gxWqEWmdFeURNCErE5k//feZR25ew9o=;
  b=HmNhJCR6z1WNW3NfFMdaiSIyqFPIh/WHy3qwp/bqKmROGuaOjcY02VFt
   /+nUSqxD1RPBz7bMk13GwN+GbFoF/4ba1723epmu65swyX/fAcvVlXyFJ
   pNKw8+kKz+yZE0Bg8WynApXNrBchfiBr62QbIfiE69q7ZF7770pwor26E
   UqGGUyfATyYyC65jMPPteVMoO3szSk3Y4TMAeQyc934PqsZz+7t5WP7/p
   T60rxVl7U1qPUDr/y7TTwvPMQ6E38iE1bnvZoSrC27/I0EJcZiYtxzKbU
   um9uEN1io/MH7oZJCFdQNGa5aQvlsDUBFigDIaRwGHZL4fR9s13Hz2gJW
   Q==;
X-CSE-ConnectionGUID: FeVF82/MSFmnaxytNXc0cg==
X-CSE-MsgGUID: Xk1YdAt1RIaBbkXKAZU6FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52451030"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52451030"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:15:11 -0700
X-CSE-ConnectionGUID: LR5kUtouRruzDMhl+aXKuA==
X-CSE-MsgGUID: pfRkL2wzTDWI5j3Xi5Q8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181258232"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:15:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:15:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 16:15:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovmXmR/8C11jz4pghBPG56UUutt+YgbVl51bhCxsPHp+zC50E+XplBTUhqtVp5pdM7WzB1NPdKZ1joTIgnjmmInS9IMnVwqEQLg98GwOM2BUkWlxl8IebiLmdJydl5d1GMGEvPIk1JTcChOEgexcNJQzN7myaSW/qALKvMp+LJT15GQIQsW0dPtXo7P7ehCzHT6Tkuo0Iml0vbsOHHSysq6OqOLBx7kw0E8ReL2o5qsX20bWYFCAduqQUDxlC35qvAxk3ed1fRe2FWs/q3rx/G3NhC+yobQOtTJrOAh8ofRqKl5vjED9S1fn0pAZb81guMwMRW1IBg6RdhTps1Gyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXV9gHI/3bv/w8b7lfWBZ22mm4B6PpHGlqWB5jv6nn0=;
 b=rtfIQF/38hXjr5jmEpRITcz9p/+64kU/D4H6058iEs/Rn+lvri2czZygC2WeGsA/sHwWtU2SW+6SghFNHjPXmWm0eFd1c3EOY03EMSqD8FnETHv1uqpkuOrwBM5cbEX3iiWPiLEZNsy3+puOaQLSvpzFTlni2jqtFGNZh8pukVguz7sKAyLBQPTtUAyvCsgvxkXa5lQPvfdxCxP8O6AhwZ7LyyJny/vVJq+Dk5FLH1t6ljR9DfDFR14x6dXzO9Fr4e9oAm0szOp9PL/hZiypRJIQr9g/J/RANpseD676vKgEnBm22ALBS/9ISVa138Fec/TB/I19Sh72Vd8HlsKNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 23:15:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 23:15:05 +0000
Message-ID: <9cc42f04-856b-4967-8668-a47271af061c@intel.com>
Date: Wed, 18 Jun 2025 16:15:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
To: Phil Hord <phil.hord@gmail.com>, <git@vger.kernel.org>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250618211024.2332525-1-phil.hord@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: 46031b1a-81d8-4fca-9538-08ddaebdf5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REZVc2V5RThqT2J6dHJaM0VHWk9uaVgwVkxaOWpBNy9VK2lWMGdMelpiNStz?=
 =?utf-8?B?QXJyQ1VibjJoODBSaUx0MFhqZlh0YUlSbzRpaWlwMCt2aVh2aEFIWWhTMXA1?=
 =?utf-8?B?MmErMFIxK0tTaVV1K0RmM0lBTnR1dzVPa05KOW9maUd4S0JuZjRHc2p6aEd3?=
 =?utf-8?B?UnVDbW9PSWp3UW9nYmVqeHBzVWhwVnl4ckc3eE1KTTFIblp0amVWTnFuMWFU?=
 =?utf-8?B?M3VieUx3ZmpLTFZWTXJ3VmY4YUhJaS95ZDd4UmczdndnQW9LTXJPYU1mZFpL?=
 =?utf-8?B?WGR2VmdUNmZYUUNoWS9ibXprWldkWnlCUnBrdFZNTVdyVnp1NFR1UXc5UGZO?=
 =?utf-8?B?aWcrNk1kSlIwNG9UZnlsQkdrVzhNNTF2NzhidWpiU0EwcGV3Qi81U3VCNVpk?=
 =?utf-8?B?clRpbGlHRm5yWW1kVlhnM1NIdmJFUkllVGlpLzNZd0prZmZ0aTAwK0gvVGM2?=
 =?utf-8?B?UTk5REdPMGZiM1hiTW1wOGE5Vll3Y2w1SmcyajRKZ1g2Tm9nQy9XbFF1T0dF?=
 =?utf-8?B?MmE3dEpoRHcrdEhFQnlOOXo1bktHU2lBdStMYjN3eFZrblJKVUNIalVOa1V3?=
 =?utf-8?B?ektjNHREdEtGL0d4OW9PTndYQnBHdXdQdkJRcC9jL1A4OEoxR2NqWUxnNFNH?=
 =?utf-8?B?aVVoVkxTbEZWZFR2OTNZeVAzVFR3YklJVnBBY3ZPVWR5cEZhSVN4VjZmSWxt?=
 =?utf-8?B?WWpFVGFtWUFkMThERW42OFhEbnYyK2dKVXIrWENKWjk5anVjWHp6UXhpTUtt?=
 =?utf-8?B?amMxSlRmeUxCbWcxUFUxY203YjhOM0FyMDRScDl2bDgrSWxxYThyMG93NVlJ?=
 =?utf-8?B?ODRuS1Bwem8zZlR6RGxobEwrNHNKUVd0OVdiTXpITmppTmVFMlZ6Y1N2WlRt?=
 =?utf-8?B?eHZCY3hDQXRzREFoa1d6YjlzZGFFRWRVbjNLdDB6WGhWQW9tVG9IQzN1cm9z?=
 =?utf-8?B?UlVrV2dqMVVTa0pERkhPZzJHS1FJMjBDTXZsVkVTQjVTeGVnRlEyZ2VycXZh?=
 =?utf-8?B?WDg3dkZ5bDlKRGlkbFJMV3U0bnZDYkcwYWhTeWdpSFkzOURycElNVUJWazBR?=
 =?utf-8?B?WVpGWUtCQndpRy80S1BBdG1SREVVZXRYUE8vOUJCMW9ER2piSFRpYXZMTkJo?=
 =?utf-8?B?M291dm5taFFMYVRhUkNMeUVDbkZmL3JBcmlFTVYvWTJtbWhjK21GODBJVWlv?=
 =?utf-8?B?SGxqVlozODhvRjRGQ1lmVncvQnB1eHhOQjVBWVpvZzBCWGpwcGU1dnhNTUpT?=
 =?utf-8?B?dEY0NG5kL0dERXRYb1RrM3I2NllrWVRnR1pWL0JjVFl3d0o4MjRsSTFEWFlw?=
 =?utf-8?B?ZjVZQmJhSVlsak9Qdy9jZGI3VnRlbExOMGtlUGJ6bURFQ0d1VThxSlV3eEdK?=
 =?utf-8?B?QndqeXVpNnMzT0prVFF5QnZSLzV1R21RVDZta0pYRlR4MFpoSDlHdVZrdVVa?=
 =?utf-8?B?OENlYzFZK1BWRFRjeCt4V0R4L3ZEdTJSMDVBUEtmQ1J3NmJPRytJa01kdGFI?=
 =?utf-8?B?NWk0R2p0TlNvOUQ5cFR6Z3pmamZvZTJWaE1QMzZ2NGJpN2NiZ1plYzU1VGJR?=
 =?utf-8?B?ZllwMGtzbXM0MW16T3NvSXo0V1lKakV0d09HYTU2RDlSU203UUpNelpyME00?=
 =?utf-8?B?dUtCWlo2MkYxUmhGTkkyYm1pUGl4NmE1M3F2RDl2aXE5R295dUJoaWtPVkpU?=
 =?utf-8?B?dTdwOGFBdUhXWVJzcjI5TjdZWFVpS2ltbW1lWjVpL2JWaFQ1UUl1eHFKMFZt?=
 =?utf-8?B?L2gwRi9EMjkySmFrZ3ZMQWdCSFRQWEV0TXdVWnVoWERPRmIyMUVocmVuVDFU?=
 =?utf-8?B?b2lkcHJrUUc2blZHVWJJQ1E3VkVMdjFMTkc4SjgzSWRDUzdCUitJVHB0NFp2?=
 =?utf-8?B?ODhTclpBZ3pwQzJvTFdUMk9KSWJxNGV5eWF3VGNPTEpqODdUYmZIR2V3Z1cy?=
 =?utf-8?Q?QTak+79Nqpk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJlUWJaYWkrUkt5b0V1WTNvTnZjYVNGaGxEc3FsWG4rczd6a2FOaTlGQmFW?=
 =?utf-8?B?akVaVjBZOHNXcCtNcVdzVXdCSmVkVVA0R2lqdjBYdEJnK3dXL25Gc08zQkNJ?=
 =?utf-8?B?a1ZibU90b3QyVlYxYmdvbkRrdUdsdGlvWWZBUVlHdE9ia0NIVXkwQVBuY3do?=
 =?utf-8?B?U011TGtrbi9RL042YlNOcFdSdjIyUnBQZ25MaGVMb1U3VmJING1RV3VrMEM1?=
 =?utf-8?B?b2tuL2ZFaHVmU0pkV3R0cHVCb0NDWStWWVJ3RGhOazk5VjcrZ1ZxaVJGZTcr?=
 =?utf-8?B?UmhkN2RIeGlta3ZyL1UrVnZRQ2JFTCtYWVFyUVc2dVZPL3E1cDBScldCNXNX?=
 =?utf-8?B?RWRjakgwWURYT1dld3graC9rM0JicG5EVXhoVU52VjVsSnYvNGZlQ3NLZnNY?=
 =?utf-8?B?VXBvMXhoR2k5ckRKOEZidDZybVZlVmRPb3Q2WlkxRU91QWViN292WGxTeEpq?=
 =?utf-8?B?RmszSlMrSjFNUzNRNjR1UCsvT2dWMmVGK0kwdnNOWnJNRzBVSVBpM0h6aWdG?=
 =?utf-8?B?WVdVRzFaV2hEM1REQncxQ3ZHa2tpOGZXRVdkNHFPbk84Tkd5K25OZ2FtcmQr?=
 =?utf-8?B?SHNpR3BhZnlDRDZoMGZVemk4bi92YjU0U0dvbm9UZHZGWDJ5ZVdXVmkwanZP?=
 =?utf-8?B?VE9NK1ZzMFFMYktMOGxzdng1cFBsREZ0Q0d2a05HUDQvdEpxdFVRN0k5b2Va?=
 =?utf-8?B?d1hCeWxrTXgrSDlxWmhxVTRkKzVoUHdjaHpmWTJFVHlWNzhsTFZMY0dpUVoz?=
 =?utf-8?B?WmNBcmpDTklueXRYbkR0YXBYVmFnaXRlKzlBVGxzbkVrMm5sOENsR2hjZUNi?=
 =?utf-8?B?b2xaR2IrS3Ixd2lvNzd5K09BTFJVTktRSXFZVXNlc3RDam96b0VQY2ZKYmZq?=
 =?utf-8?B?azd3SkUyK09lT09uTDRFNFRJSmJJSUtLSkUyRWlqNS85SGlRQU1yakU0a0hl?=
 =?utf-8?B?dVhLenFVbi8yNFFIa2hnRXhKRGN3S3g0eW5mOVlhMkMySXo4U2Z2YVloNXVo?=
 =?utf-8?B?Qi95Y0NlSnFyNk51cUY2eUlFMytxUmdWL1JELzB5V09pSHlaQ1FJcGpyZk5P?=
 =?utf-8?B?YlA3M014RDdSZTIrY3kwdHlsU3BDNVBpSUJCajlHcWhKak5ITzZEaEduNFh3?=
 =?utf-8?B?MmtWenM3Q3BqY2ZkQVY3MXJuWXdFQ0NidzMrR3dFTUxqVzEyMzNWVC80N0hQ?=
 =?utf-8?B?eHFhZFd4YTZja1h4R3lBdWhFWkJ1M2ErVnhORmdqdnRTNGJoL1Q1SVVvRkJa?=
 =?utf-8?B?ZmR3dTFSNlh0TDdvcmJQMXdRTmc1UmRZZ0dJbzFOeDlKekpXZHljSU9JbkF3?=
 =?utf-8?B?NUZLbXQ1YUl3MGJzVEhxWmpJcGpkZmMwN3VBLzY0Tk40d0NwMU9IWXF2UUpE?=
 =?utf-8?B?TW5BQlRPS0dWR0lTTmp5VG9iY1JWc2l5TzVFelNuQU5ObHNjT1I5UkEvZEhv?=
 =?utf-8?B?NnFtS2FxS1ZOL2o5SHJFV2JxczJ5MktJUUo3U1pYcVZERFdPZ3VSVlQ1aDZq?=
 =?utf-8?B?NWNHbnAyTXFVejBoRkdocFM3c1VnMExmMjdudXhydnc2a0E2WkpVZzFWRDAv?=
 =?utf-8?B?eVdTam9xdXlqclNuYjE1NTgyVkVnU3dnb0ZFVjlRa0I2SG9lYkhvR0JLL3Ez?=
 =?utf-8?B?WWpFdlNQbUFsWUZ0blIxYXIwVzNJYyt2VDNqVlFmMWtkTVBnTFQwZHNsTGlD?=
 =?utf-8?B?OU1oU2ZvTGd4Qk9ybkJyVWd4WklhVDY0TERBb2dYRjJnTFlwQnA3cUsvSmw2?=
 =?utf-8?B?S2tadlNsZEVXV2pLYWJhUCtIRUVINEp3UHlUa2kzRzRaVXhROHRqU2Y3eFFa?=
 =?utf-8?B?RHp1RzJ1MWl3SmRBQ0E0L2duMW5PZk5VUU9vSms0b1JNVFVDV3VmS1dBVUJZ?=
 =?utf-8?B?eGp2c1ZBb2hWOHlGU3N5U0NpWXhzK3lTSVN6Vi9pbzhLMWR0T2Z5UG1YYUpq?=
 =?utf-8?B?TW5jMHgvQlFJbDdFNXpiTXNzcmN6eHJtRGk4RVplaGFhYWtocTNBbkoybndG?=
 =?utf-8?B?Q2dtYk1zdHFldHdBSjdjSlBHNEQ0ZUJveXpHU1RDWC9Jb0I0UTlsVHJUZHRm?=
 =?utf-8?B?L2V6aWYvL1pKSStOWTFXeVdtS3h6QjlqZndiK2JSa2hveUNqRVB1YkNNbkpH?=
 =?utf-8?B?RVdZcWxPSkVRYU9tT1M4VzNtbk1yMDlEcVh4Rk5xZ3NTNi9pdU83MVVxRmtm?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46031b1a-81d8-4fca-9538-08ddaebdf5f7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 23:15:05.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRKRz8dNg1ESEBeB33j9Re2+4CkdiofM6+ZSdOuzeHWWUp0DbaTVccz52WSBKc/1zzebWZHAtq3JzmGa5g4hpebD4GR/eYYEnEvGXzcphd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com



On 6/18/2025 2:08 PM, Phil Hord wrote:
> My patch fixes this for fetch, but it affects the command's output order.
> Currently the results look like this:
> 
>      - [deleted]     (none) -> origin/bar
>        (origin/bar has become dangling)
>      - [deleted]     (none) -> origin/baz
>      - [deleted]     (none) -> origin/foo
>        (origin/foo has become dangling)
>      - [deleted]     (none) -> origin/frotz
> 
> After my change, the order will change so the danglers are reported at the end.
> 
>      - [deleted]     (none) -> origin/bar
>      - [deleted]     (none) -> origin/baz
>      - [deleted]     (none) -> origin/foo
>      - [deleted]     (none) -> origin/frotz
>        (origin/bar has become dangling)
>        (origin/foo has become dangling)

Personally, I like the later output. I have no idea why anyone would be
specifically scripting something that depends on the ordering being such
that dangling messages are printed immediately.
