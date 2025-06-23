Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109A1B0F17
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722397; cv=fail; b=Q8AJ7movBwc+NXVCQ8V/RgdnTkdxug5X96Zr7FDRbbAuXQAYLC4V4If1iCk5/1eBHhr9h+8nL9De0NOz7LpDSVbUvcinNjSTbqaMBP1CTRkDpIKrKy3GyMpPtabfImaLMnLoeJ6b1+Vqs1vulNjbF9vpSapHp1rW1l2uPO2+AYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722397; c=relaxed/simple;
	bh=IjSrvASAcVe6xPKUrD1sVmchYwYauXjQJBTnjiR1M/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BIw2CGGSOWTPK8E44bkScwjxLrGQkmulkP0OLdBh29P4l7chzDjoCnlAKhj1bwtm1ChFMd8ePx7D+qS5fau25+pJ5pFfVPz56jveHtAM/ZacuIj89DQDo9Z9TnFXwlR5MuY5R/xTGqQ8ya0tp86tY7RuPQr44k5ifbHSwQVN9bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl0Z9jnP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl0Z9jnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750722397; x=1782258397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IjSrvASAcVe6xPKUrD1sVmchYwYauXjQJBTnjiR1M/A=;
  b=Dl0Z9jnPhtOicr226Gdn84JQBcR8bRAIjsGLCvOuwJHon6PBf2G5racN
   JkrLXKU5CjYTmseB7l0Ez+gzlHVG0yyCZvUmo933g+gKA2QLr4UkBTnH7
   i0VKpu8VmYeb+tITshnDOQfFmCDiuV1otQ3cfqwyWNfUIRuFmiopk8JrR
   p7fvXPsbe2urd4ys2AINhF3g1WYgcHF2WdAgn4tKF7GkHNNbR11VVmOzj
   ePx3aC9yopsc1nIRJGFGMN1bZuw8w0uJ5ifqJYlTu+6U48X0rntpYWBk8
   wj0a3E8ggIL13yme3pdy5s1n6bIjxbl/FmoiZgpJjjd0PNbYWSS2bQznG
   g==;
X-CSE-ConnectionGUID: u8Fa0t6oTMuIIZA2a6AjFQ==
X-CSE-MsgGUID: JRYsxq+AS+GPFXVAoDr4hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63642302"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="63642302"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:46:35 -0700
X-CSE-ConnectionGUID: /hj2I6VaTpWHTkkMSdCOug==
X-CSE-MsgGUID: WNcgTcWBQxSbxHb3+3OFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151221945"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:46:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:46:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 16:46:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgxaJo5xbJXTotE/bzIQhrEKYWd4mABQKJQdcLj/C2dcEYD59Kb1E+J3rqJunvdUfP3PeEsVNw8yC3mwV0L/2kHMv7rP6LIyuYPWpPLFr72879iqH8RgBBheq8VIQ25BC/JRA5Yoz+WhnuYHJJWoSbwYjDWR987zIJTjWRE8dTzXfY/FrfNf++yFNrBRExVsO+1MJFWEXxMJQcB77OVIpkhboNYcL2jIth3tursCSAIaAc0+hYxDae1X5VeJEDFF47WT7V/cyPQ3GOcguf3eLz/BWVYr4uHqN5WrkKTkZ+sjdVN3iDS2og5TRuspFudj2GUYkaWzwLBR27saZyQwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA5BuTmO9eew26W/jn1xBvqXYHP3xqauiOJI+vPSU+c=;
 b=IlCh4txn+qbMV5UcMR7QpeyYzRyFz+8R4zEtOJe7wloawLzdXqjm7ON62FBVXQ6vjBj8RTS5oMGb04E9crJX2P+WUP24CHHOJJK88xL8EHLrTnI7Lg2DnAg2Z0BxHnVJqN0r6OAjdhhV8DDaOlazthOT+hstevNmogj2OQdtkWu+vDlJjZ6WK5pbILC0WX3LDKzICOMnlhz33FldSds8ifKRwe3maxIJKIOX5H45HVz04iwUXqPzhmKXnAX1b6OGJl6GRShgdCBpLmjQ6RLBz4U6a8Oljl2fDg67Z/OaHw7Iskv+K6Dq/VUCkT4imath2a76z4FGFiA/Uigs/5S12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Mon, 23 Jun
 2025 23:46:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 23:46:17 +0000
Message-ID: <628070ea-8fde-4a67-a05d-8d88858cde95@intel.com>
Date: Mon, 23 Jun 2025 16:46:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
To: Phil Hord <phil.hord@gmail.com>
CC: Jeff King <peff@peff.net>, <git@vger.kernel.org>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <9cc42f04-856b-4967-8668-a47271af061c@intel.com>
 <20250619033746.GA1801319@coredump.intra.peff.net>
 <CABURp0p4d0JPg=-cW1OZdFQJ+vNT_0PDd9Rv3oz6toFGqGv5=g@mail.gmail.com>
 <f11bf463-0005-43d2-b642-ede130d1f44c@intel.com>
 <CABURp0q-1FGmD+PJeSQ=xvyDN6ZYn1O7Fh8i1OojfD2WQCqgcw@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CABURp0q-1FGmD+PJeSQ=xvyDN6ZYn1O7Fh8i1OojfD2WQCqgcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ead80d-df80-4483-0d21-08ddb2b02602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b250S05HQlV4bElrVStvK0liTnl2U3hlWWJmbzdEMElYN1NRMjI2MEJNcjJY?=
 =?utf-8?B?V1VCaU5EcnpwcmxTdTNuTUM2NjNZQkNYb3E4aEhJMlpuSmFrRHZ6bnpXMnV3?=
 =?utf-8?B?empKOTl6eGlsT2tqYjVvcElNRDN3TCtadzdCOTF3SkhqOVllK3o4Y1l5Skp6?=
 =?utf-8?B?SlRtSkFIQUFkT3c5a2pOeFRqOStGZjREVVU4SERjYTU4L1VOMFR1ZVY1cUoy?=
 =?utf-8?B?U0NyaUtoTkg0VlVnSE9ObytIbklNaEpHOTM5NUw3N1VjbnJWNTJ4NHEzc0dq?=
 =?utf-8?B?UThUYXdET29tL3pkSjBYSTJpd2IyL25pRXkvMTF2eXNPRlB1UjdkcWtuNmt6?=
 =?utf-8?B?MWhUZmlWSm4wUmlRZ0l3R1VQcEUxR0MzUGRRcTNjSDQvYytONW5MQ1AwWkhk?=
 =?utf-8?B?dStnZm9GYk9lNk9oN016b3Z0Y2lxQjRRQ0lxSGtXbmc4a3VCc3V2U2ZML0tS?=
 =?utf-8?B?QTNBOXBCWlJNOThFcS92Q2k1L2tGMFZ5R0xpbEZuRFFYdmZxN2JxQkdNZ2tB?=
 =?utf-8?B?eWcvLytQNWJ1OTNxaEVXby8xQmgyUjErK3YwWk1ScWVMN2gxVlpGUjBrWFgv?=
 =?utf-8?B?MU5Ibk4weEx4VTNwTzE0Rm53N1ZldDhyMXBIWjQwd2MxM3kvWGNlbVFUbGll?=
 =?utf-8?B?RDVFcXBCWVJIZXo4MWovV3VsQmlkUTdralhDQWVpcXJhSXM2WXFZZmorMFU2?=
 =?utf-8?B?R1V6UjltbTZHT0FjM1cwK3JBZlc5aUFNSWdXN3E3NEczZWVSbFF3RHd0Wmg3?=
 =?utf-8?B?Zk5peE9MYVBmYVF5WVZvS1FnTzloV2k5bUFBNzFMcEFjdlkwQzhqQUpvR0Zh?=
 =?utf-8?B?RU1RUWtDelN6YncxeXdLSlJJU2FuRDJsRXJ1bGFRSkNZemRDOTdrKzZHeE5p?=
 =?utf-8?B?L0RSOFlKV2RVWTB0YUtLa2xKWFp3K3NGNlhlSkZSRWlJUkxCcTNkaFpxT0Fs?=
 =?utf-8?B?Y29UWUZPQmwrQlBicmNUeVJiL3htbStTTDdCZzZFTVpRZ3FoR1RrUE41VktJ?=
 =?utf-8?B?N2Z4bGtUVms3bUNVODNreFF3cEtUdnpyK0MrY1hEcllWWDdKWVZZaEtiMG9k?=
 =?utf-8?B?NTZKWWRzS1h4MXZmNzVTeWZzYkY2Z0xPM1NLdmdpNHlUd3U3bENpRThlL1VV?=
 =?utf-8?B?b3BnUmdlNGliM0MzQzBsRnNZUmw0V1JsZjhhbHlIYVR0ZFgzWWpUbXhPdkly?=
 =?utf-8?B?QkhRY3RJREZKUUZOZzJlM1ZrWVVMeW83UXhOV29ROWw4bFMwanBpR2xUdm04?=
 =?utf-8?B?V1Z5TmIvQ1htaldPYW1NdzkyUUU0T3RTZ2h3S0ZGSVU1aTgwVEQyRHA3M0RD?=
 =?utf-8?B?R1RrS1lpWDIwOWFpVjRMRzVBL3dsMm5Ra281Y1VqYnpWQ3pERm1yOTBkaTVS?=
 =?utf-8?B?WXMvYkZGNmZxd3NPOUZvY3g3RDc3Nm9FZGNISzIxeEdPUDV2eG9YcFNyNTlq?=
 =?utf-8?B?aHUzSnlQYjRPT2haYXQ0VWRQVWZsdzAzNzZ3SW51TzhuRjNNOS9LRjJiZTV2?=
 =?utf-8?B?anhtQVhXRVlmbzRma2pVbHJlUXNlYWZ3OFVqdFBPMWwxRW12VGEvZWFhL0Iz?=
 =?utf-8?B?YWF6T1lyM0tSSGhac3U1YUFob2N0NjBTUzk3am9Qa0FBdHRTU01BTnZrUCtK?=
 =?utf-8?B?VWJjR0ZxeHF4ZW1wVGx1Y1ltOXRrMGRaZHBmdXI1Tkpna0JxWW1lbE1vaEZn?=
 =?utf-8?B?Mi9rZ3U1NU9xelUrSUlxTlZDWTR1elZOWnNWSEpZWmcwSWZSdVFBa2h1MVQz?=
 =?utf-8?B?MHlkSjAvZTBGV3g4OHR3ZkNDV2QyTmRrSGpRVzBId1pwaklhcUg4WEcxRllM?=
 =?utf-8?B?bWk2d0o1dUxOcWg4WFdsMW5WZnAwMUM0dUFJVDJUb0pFQTB5YnA5MEFPbXN4?=
 =?utf-8?B?OENReFpYbWRoVGk5dENOaXZ6QmR1Y25EZTlYM1hwMG1tWHlVakZzVzJBZFhq?=
 =?utf-8?Q?S1sQ1Ynk/eA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnV2aXpRc1EyYnh2RnhFYUVjR2U5OGU2bEpYZzJqeXVsT0xkS0dFUXU0cEtZ?=
 =?utf-8?B?SEVLaHhFa3ovVzY0M0FOZTZTcS9mNWtDU0ZlZWtlNm81L2hPWGtxbXZ6emZV?=
 =?utf-8?B?SEk0d0x0Vy9ZZXE2bXdrcmRiOHNxTXArOXREdGhTbUt2STk3WkxQNVJVOWY2?=
 =?utf-8?B?UmtyVUo1eHBUN0hoWitQV3cxWHZ1Ukl4TEdvb0ZCcjlkTjJNSTNIVnpyQ3VE?=
 =?utf-8?B?SHJuUjNGekxXQklXRERjcUJyQk1pYzNtbUNzUkxwenByUXZsZEhCNThUNFRa?=
 =?utf-8?B?QmQ2MUZTc2NEcmdWODA2ejdVMHR6ZmU3VEdjVUZTWkI5Umo5Q1dOc25PcTlJ?=
 =?utf-8?B?enhGTkdSdHg5NWdJejBtNlpHYjNlTkdaU0dnNlUxSit3WjlOM1ppUmtLUzZZ?=
 =?utf-8?B?VEpUOTcrTVYvNUFQUUp6b052RFNGOHJSQ3lTMjBUN2tGRWdVaGFVT2xaK0VL?=
 =?utf-8?B?akN4UmxmWTVYV3FQUzlGOEc4ZVowNXdtdTFMZE5aUDF2dDE5WkM5UmczWFRp?=
 =?utf-8?B?WmhCOWpIZFVTY1NyS0xrcjl1V3ROdy9WQjlodnBHMVpFNEdQcUduK1VyL2hX?=
 =?utf-8?B?MW92UW1mN2V1USt5T1RqWlBFalFwZC9ya2NQbTBKeUVCWGV6eFRYMW1sd0xM?=
 =?utf-8?B?T01SeGxSUXhxamREQU5Bd2FjaFdmR1lWSWtFaVJONnYrazRqNUI2R2dlNlRl?=
 =?utf-8?B?cEZkOXZwTGNaemhqNkZNODFDZEtPU2swSnQwblZneG5ZQklGd1lIZitDWlVY?=
 =?utf-8?B?T2w1TVQwRmo0S21XUTFDdzFSUU1sYzAxdGlraWlISGVsMTVFb0lxQjU0bDhy?=
 =?utf-8?B?RGxLamFsd3pWK3Y2clIvbDlGd2xFZnZLSUZwaUN6VUxuT3pmL1RxZHBOSkVm?=
 =?utf-8?B?Qzh3b3NmWi9rUU1seG5zQ1VUQ29sUG44MCtqaG1FaklmWXhQOU5xN0hqV3BO?=
 =?utf-8?B?dHhlZWl4MEpVM0didFZERW53aHVRUmJSK05QRjc0dFRPaW5LeGNvejFzR2gw?=
 =?utf-8?B?MkJHUGtJY0c1MnJCVXRZV1FBYUMrWlpWNHhIYjdGK1lkYkNXc3VmNHZzekNl?=
 =?utf-8?B?a3lobTZ3N2xEc2Ewelh1clhwVXNwbHJXYjRKTGh4Nm82RDFSTjRhZVF5cVFw?=
 =?utf-8?B?YWFtcXVGVEFVS1RIWmNSUlpxMUVQZTVwY2lETDFtTjZkKzEzVkRiNVUrd2Rp?=
 =?utf-8?B?THp2YXhzTnk2YjdFU1o1TU40b3BZMjdGaHZ6NjR1d3Bjeks1VEJMV0g5RHFy?=
 =?utf-8?B?RGVHc1BBeTVHcFM1MTlSK0VtbnpjazdBZFpQSFFlSFF3UnNUUGJnT08zUGRW?=
 =?utf-8?B?dUo5RFgwekRrS0NSQW9SM01sZ3lvWUpMRTVJMEdoV2RZUTV5K0xvcERMS3VH?=
 =?utf-8?B?UjAyTkovN1lrOGNRZG1lbExMRWZuSi9FdDc1ckNrajR5STMvOGR0NTNOUHVs?=
 =?utf-8?B?VzFHYUVCWFNWTUxveHBwMUFCUXh4QWZLZmtKa1NDc1VqbW90bzZvTmY0R3Ju?=
 =?utf-8?B?Nk1abnlmWmQvcjdoLzJuaXNjcE9RZU1IUE10RkwxODEyeFRSSUlEaFc3QzJN?=
 =?utf-8?B?d2JDKzUyZCsvOUxXYVd3VkVXaGVWemMvRjg3N1NtMno1bG9WcGdvRGtBT0JC?=
 =?utf-8?B?Nnc5bVVITG93aDU0WHR4M3pnaFVLZkliYmliSUtGRGVpT3kxRjlJYlZKM1ZT?=
 =?utf-8?B?SVo1anZjQ0x5cjFkNlJqTG1KcXNVRXNRQ3NuU1Jnd0dITlJ1Qk9aNWNPUjN2?=
 =?utf-8?B?dlhOVmFSc05lTFdmVkhaWlJtaDZRZi9KeVhsdTZ0SXBmN1JnRFhLMXFoMzJu?=
 =?utf-8?B?SCtaL2lWbVpiK2gzZmZqZThvcHkzL2VsL1hIS3d4ZDRJME5vUE9CYkU2RDF0?=
 =?utf-8?B?V01xV01QT0orWVdxTjFuajJ1OUdhdG1WT0p4NHJLdTNyNmFYUzRhUU56N1k5?=
 =?utf-8?B?dngxY1QydXlwR00vSlFDdnM2MDVKMFJDWEZtSHo2NUlXNTlSYUxhaEV3L1hS?=
 =?utf-8?B?NzhwbTk5QlZ2Tzc0ajRsZWNXemdsSnl2cjZWYloyYTZhTDlmV0FBa0lPMnJa?=
 =?utf-8?B?TTRKdjU2RW5hcC9RYnNNZ1lMRzJFemJCYU9WS3dodm51dExGSmMrbHpSTGFj?=
 =?utf-8?B?dTd3TzVXdTJJSVBxa3hEdFNBdGYyTkVXMUlzdjZyRFVHRjFZSVBnaStMTW9i?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ead80d-df80-4483-0d21-08ddb2b02602
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 23:46:17.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oINK4NXe/Tj8BsVzAZwiIEkcVOovc90TH9jlyEbCuIzAjLstALkkmTNnutDW+bUDR6CQUxu3riblL5OozOUIBB0758qm7IEDzBcw5w3Sf1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com



On 6/23/2025 4:40 PM, Phil Hord wrote:
> On Mon, Jun 23, 2025 at 4:32 PM Jacob Keller <jacob.e.keller@intel.com>
>> On 6/23/2025 4:11 PM, Phil Hord wrote:
>>> I have a new patch that produces this:
>>>
>>>     + git fetch --prune --dry-run
>>>     From /tmp/repo/.
>>>      - [deleted]                   (none)     -> origin/branches
>>>      - [deleted]                   (none)     -> origin/master
>>>      - [deleted]                   (none)     -> origin/other
>>>        origin/HEAD will become dangling after origin/master is deleted
>>>
>>
>>
>> It is a bit weird that this says "will become dangling after <ref> is
>> deleted" because the deletion already happened.
> 
> That's because I used the `--dry-run` switch.  Sorry for the confusion.
> 
>     + git fetch --prune
>     From /tmp/repo/.
>      - [deleted]                   (none)     -> origin/branches
>      - [deleted]                   (none)     -> origin/master
>      - [deleted]                   (none)     -> origin/other
>        origin/HEAD has become dangling after origin/master was deleted
> 

Aha! That is even better that it properly adjusts the text based on
--dry-run.

I like it.

Regards,
Jake
