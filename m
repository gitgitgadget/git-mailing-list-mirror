Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56558F55
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374609; cv=fail; b=BGpcVmDylFubHY0e4Rs0+aapy9toa41nLBVmjH0Hk3uB7Rks0SL3vCYN0rCUSysXyIsYeuXVSNZhFYuvx/yPdL2UklVLPror/nqtkhASqXRB5fMvj6VLX7XkkbKy6kTDeeaqEVv+jB2BTaHndR4wx9bqhsOo3QT4GC5lGhkLP8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374609; c=relaxed/simple;
	bh=DNv8B822Aq2qZ4AY96j1dd9Bu/ahGXjspmIOQWzTk0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3rBUtALrut1HDbDu5OPRWVOguCdqibdsZerAl9Ku+eV2cXUjqwOTffiIap2LC8oJYOYM1tzmP1PCWO3n9ARs9sl6Cby9YoG2c+4QKpii3OCTrwtJtEzPDZywxb1ksWb2PGzOw+YEqhRzz3atZa8VICt67ZPhTO7dHN/cWFPTe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6HWvyzA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6HWvyzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710374607; x=1741910607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DNv8B822Aq2qZ4AY96j1dd9Bu/ahGXjspmIOQWzTk0M=;
  b=h6HWvyzAvAvGJL6A2l2vI9TRgRXZiaTFz4riDzKOKvceiTaEnF7bTEr+
   1NettVw5Q8T954Fz7T/KB7FnsAsi2AMRlxb2/HOI1UgL0EeIwVSGA4Mkw
   GIKx6T9NbA2Zhqtto2BuoHn8LNzTDPV8yX4VIpfw9Vs6miPMDLa6qDzbG
   2E/GTqDo92DW64ejjuUqzGphYJ1m8oQEeRwCi6YaCaS0gszAGnD/jMz6r
   lmc+aA99aJOI0r9O+9TzrzJXV+8pBMqWuCC+bCgFFcuUj5odOhL3TYUlW
   DqjISfHq9zh74/LXOkabSdFfgcnYram8cf7S6eBxRbbfQFLqQV5s8SOyx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="27646927"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="27646927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 17:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16794707"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 17:03:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 17:03:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 17:03:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 17:03:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 17:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnJORvk2y4oy2qW0fdyFlFSUztPYctBphus7bFE8hrYsON0mjvtq7YuxWVqznQtg3LygLhIt06BDUXEH4Kqmq37F8O+mWFrOBb1g9Bt7693STsUGDms9c4f/nxKd4xH2gAe1SlZ87/PCD5FQRtZpUAUQLHyKRTSXp6XI/8lQ7kjuMsGnM1R2iNXR4n5hkY90Jpi4bQAQLvxjecatW6aU0L0KMvnQCdsV+BfYtFQ2/YoSSxSfrFSq1pCuQDSLOefnutiIXf0CCfL+DiQPksh4Td/1yIMHyaYzjtdTGWA2Jwx57k32z6lTkLKrFnxuPAla/8fN/SL4zj+Wk6rcsEXKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyTCaJSR31KPYiZ7wBVlp35sJMw15O079l1jrxpi5NA=;
 b=WGcVryMtW5ZVg1dqSuwRCMXVZmNgZ7dji/eAkmWNFUTt68DBBL5Br9q2j/JPhf6h4Z6aVPY3JrAHOd9h5htqpp6P7nKxyYYtbSdu7Ko79ZuQWBcMVmqltoUOAq/QKuUn775nJ6mV1ZHgZqMby711O/1lDIh/xTzH+q5lRf7FlB9NSoaRrj1M/ATQHLMQUm+7Ox12OiM/ITBZaVO6IRvm2pdAj5ZMUq2ur6bpaJTuGD4XftVPM2QjG149AGNbCVr5tmvxf848hFQfFZswLMSeJRqr41inYR7Qf8GQBsMN1ze7JUlC0PstKMy+Bch6E5AeWV5uE6IG7RO3PchfG5XTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Thu, 14 Mar
 2024 00:03:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:03:16 +0000
Message-ID: <1cfea792-3a7f-4f2a-b460-223a237de9a3@intel.com>
Date: Wed, 13 Mar 2024 17:03:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailsplit: add option to extract PATCH M/N numbers
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20240313010040.1828970-1-jacob.e.keller@intel.com>
 <xmqqzfv1ao3y.fsf@gitster.g>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqzfv1ao3y.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 24178f70-d0ff-4c1d-952a-08dc43ba2632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIMIW6zl6WZCOoSgYKsp4weQDqPhp7tp2KzTjOFAzsaO1EG7gLT/oM8HlQDFi4eHYHDJYbruiMbj9b1HcCtmrCfz4iTxLs0u11C2mjj2Ny8VAEXR8SBjen3mVsNQEBpySs4BgSw/d/TcBBEM0Vbb5xZOBR8IHF0zc7gYGFRV5/EhN1sVZjTOAPx6c1wS3gzSXuAl/iQ3WFHSWbYmLq7xYvc9Dc9JDj4icSDe7Mn4PxLNxopgG1x4mVbyuwq6edTQFRysbfthPhwtn2rfa5Gt3eSfnlcasHAe55+LfhOBC9xjJVbxgjohkajrB48RuNCdxnxgeAnt8UX42lfz9b39C74ZBDFuN/CeK32PKLfg6tkW3Mn8UN4iINJfAtr94/3zlxQYfL49oUGJub32qFEIfbofxhj2nzOvmHLTecF8swkj6EwYOoPD6zm1U0Iux450+8Blh1QgB5kclskPypeRo8w0O6FGicKgzrBl77FVts9TGvQbOAZoLux/J+PvzdlyLy+vMj8YPAtafPjp5M8feFM84LOo6V5GI5PFF4bBM0ASGSeydTAQeyWVuhCfo6xWVEQvRTluS0JeMdRquCuAvZHb+dSUqT3Joq4RakLBJf5t51UjmHlozzH9s2U8GxlI6jAfwwkbOlVJMrVxKBRxEXG8xqI8s+5mztyTvnPg6ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFDTk03aDZaZnlSZlY5VFNlTFRiRmlRTk5DMVp5bHpzTEdRYWdadjJFK2d1?=
 =?utf-8?B?dEYrbGJkcFRSalErKzhKUHphTEQzSWJjeGZYdVhqaDFwc0xDZzE0ZW9uaU41?=
 =?utf-8?B?am1yMlF5YWRkajVtWW9COS9WSTFhWCtIdExmME8rMnN4QXhLSTl0Q2VnVlBn?=
 =?utf-8?B?RTB1cFNDcUpIV0FJTFlhUkdiYmR6MHMxRXFvTFRLdC9heHdzU1pDOENITUwz?=
 =?utf-8?B?SFpWWk1pT1hkTVltYmhEMWxSQzlYMmJra3lNUHVIQUFyUTYrQ1g1WEIrMzND?=
 =?utf-8?B?Wm1laWNTZGR3S0dTMHJDNDlFelFVVEdYMEJxSUpNZDlqMWxzWVd1aFg5aW93?=
 =?utf-8?B?Qi9yWTQ2Nk9RdkppMlRnYzNTZ2oraVBGQVlIL3hsYnZNYWQ4Z2hTMm8rYjRw?=
 =?utf-8?B?ZkowTEJhVUljUXVUM0lRT2UrY2V2R1NhbTlqOU0rejN2UHhSakFUSmphWmJE?=
 =?utf-8?B?M2YwSHpneEpTcHNHT3hyYVpDWWE3aU9oZ3JaL0ZZTHJTeE9aY2lMTENyK080?=
 =?utf-8?B?MmRxdk53OHVXcTl1YVhHbjdLT0Q3cVB5NHFveGJkaXM4Nll2bnlQV1J5L04x?=
 =?utf-8?B?NjZka0o4Kyt3NnBBYnIyR2xqV1Z4NG9TY0VhM1V5Z3FncUJJM3R5V0x6MDd4?=
 =?utf-8?B?WWNKN3NGVUsxTDZ1cngxdEZFdnJkTXVkVlMrYmFWdUdLMnY5ZTVEZTF1UGtX?=
 =?utf-8?B?eUdCbFV6bEEwdjNkb1JrL1JQVFJsSUJ5cWxhRE9sZVdIOHBLUHFqeFBYTHJr?=
 =?utf-8?B?ZTRhMzY1dXQ3RDdyTy9xN1M5M094MVJMMlB1UERZU29tUGpieWFkWXJaaTdm?=
 =?utf-8?B?dWpSb2t2cU1JL0xKakZGQUdIM2dOZGxRRnc1Wk41NG8xM3hLKzVhYmM2Nm1p?=
 =?utf-8?B?TitOcXl0WGYxZVNPUFNIR3d2bVJZQmh3QUhxcmF3NlRWNFhRYkdBbFE2dDVk?=
 =?utf-8?B?emZYdjNHaVd2cVBFUndkV2xmZUFlUjNZdHYybDZpZm9NMTNvRlh1cnhjdldV?=
 =?utf-8?B?U09OTnRQakZEWDRHU2VUSjVLT3FETmxZaUhtN004aWMrOFlhU2huYnIzTlEr?=
 =?utf-8?B?M1NGT3UxbUtoVDN0TGwzYTF1OC9vcHlsY09CSXl0VjRld1FweUswaVNSRjFx?=
 =?utf-8?B?Q3RudCtiSkxJTTh2MnBweUwrNHR2VkpwTHExS2duUit5NXRwT3JxejA3MUxu?=
 =?utf-8?B?ZE1TVDBqR3RzU0VEcVdFRCtPcGoxOEh0VGpPRWRHZkNhQzZVbTlHa0ttN09L?=
 =?utf-8?B?dFFxb21HOUtQdEU0WEJwb0NZUFBhU2RUWmVqekU4Y1JsaWZ5N1Q4dG1ZZFVL?=
 =?utf-8?B?b0lxV1E5R1hsM0kvelJ1b3cxSXRpMjhpUktFR2RSU3BKQmdHbnN2U3pTZnNF?=
 =?utf-8?B?UlRHU3d4Si9oRjdHZUFqWWdWcUk4bzBHTnlNeVYzRUxicE5rYlhoM1hMcFFU?=
 =?utf-8?B?MzR6SmVBQ0QyekVyVnBCNXZNMXA0d2tGVmhPdlgrUVV3OFJJOGVKa3RsYm5Y?=
 =?utf-8?B?WEhHVnUyMTNWSXc1SlEvQlB5RUZVckhzTlpVVnVtdnBwNGRpaHFHU0RsOGJx?=
 =?utf-8?B?b1AzM2g5TmhIQjcrNmpFaERQV1BxOFZpazFTZDJSSTVUTjMzZHVnQXFESUcy?=
 =?utf-8?B?SVJZbjdqM1Bzb3ZNNkJTNDJuWXdsYVVPOHpVMmg2VEZkNldJamJXbDZJNXNV?=
 =?utf-8?B?dmIyT2NNOHVqbU9DOXcyb1BOQlh6dDFTd1lvdGEyckhJSERTZXhqYjU0bWVG?=
 =?utf-8?B?WWhQOGhMWlhvYzdFeFVNaFVKUUdNaGRaZFNia2NTR0EzemFLNkVXRkU3Y085?=
 =?utf-8?B?d3pxeVdRV2VZZjlSSVFCQnNNSDFVNWExOWpNNVNUYXJ3QjJZTVFnSWtiVUZU?=
 =?utf-8?B?OUU4bFVITFAxY1RIeDFIRE02emZTKzBhNHpscXZFbzg0WGNuMWNrTzE2cVdC?=
 =?utf-8?B?K0xmNnR0WkJrTjlUQ0U4U1BNVFBtUW0xODRHc3E3eFhwLy9kR0xPSTRGL2xZ?=
 =?utf-8?B?eGZlL2IzaWpZdVkvM1dnL0ZjazI0KzVaajl0RVRFNnhMM2JvenVrR0FQZzZY?=
 =?utf-8?B?aEN5L2hwc3BrMEQ4cVpQaXpNekpCUzFJd01UcW9XL29xSDJPNStJeXRlR0pL?=
 =?utf-8?B?anJtZGw0SzFvVTQyT3czWkhCdnZCdU5wUUJFREdnTU1aSDQzNGh1VlBSSjU5?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24178f70-d0ff-4c1d-952a-08dc43ba2632
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:03:16.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0dgxVTxH3YBSnftmy7bYmrPTruMi91kRecdsWApKJi89xqhJpvHYLlimGqLLeK3f1J4+s0VQpSojcCkKMudvBqMBiAKCxYjOen/wSxY4E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com



On 3/13/2024 1:11 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> Its frustrating to download an mbox file and then have to manually re-sort
>> or re-apply patches because it failed to extract things nicely. I don't know
>> if this approach is the best solution, or whether there's something else we
>> could do instead. In theory we probably want something more robust for the
>> M/N extraction over using strchr, memrchr, and whatnot....
>>
>>  builtin/mailsplit.c | 126 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 116 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
>> index 3af9ddb8ae5c..5255f4056e91 100644
>> --- a/builtin/mailsplit.c
>> +++ b/builtin/mailsplit.c
>> @@ -10,7 +10,7 @@
>>  #include "strbuf.h"
>>  
>>  static const char git_mailsplit_usage[] =
>> -"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
>> +"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] [--extract-patch-from-subject] -o<directory> [(<mbox>|<Maildir>)...]";
> 
> "extract patch from subject" is quite a mouthful and more
> importantly, I suspect that it is different from what the option
> does (unless the sender is cramming the log message and the patch on
> a single title line).
> 

Yea, I didn't really have a good suggestion for a name.

> This seems to try parsing the numbers out of the prefixes like
> "[PATCH v2 04/18]" but I wonder if it has to understand four and
> eighteen in such a header.  Doesn't the sending side make sure that
> the patches will be in the right order if you sort the message in
> your MUA by the subject textually?  After all, such a numbering
> convention is to aid humans to read them in order in a mailbox.
> 
> I also wonder if it is enough to run the commit title (before
> stripping out the "[PATCH v4 04/18]" part) through
> format_sanitized_subject() to derive the patch file name.  At the
> receiving end, they have to be prepared to take a non-number with
> your patch anyway, and when things go wrong, peeking the directory
> may become easier.  I dunno.
>

I think this would be useful and a more desirable goal than my yucky
extraction of the patch number.


>> +	if (found) {
>> +		*nr = atoi(m_buf.buf);
>> +		*total = atoi(n_buf.buf);
>> +	} else {
>> +		*nr = 0;
>> +		*total = 0;
>> +	}
> 
> Having said all that, I also wonder if we want to simplify this to
> the other extreme.  When we accept such a 18-patch series that is
> stored in a mailbox file in a wrong order, we do not even care about
> "/18" part of "[PATCH v2 04/18]".  So instead of worrying about
> total at all, how about "--use-patchnum-from-subject" that only uses
> the "04" part of "[PATCH v2 04/18]" as the output filename?  We
> would probably still want to count how many messges we processed and
> as long as we need to parse out "04" out of "04/18", we'd probably
> parse "18" as well, so we can maintain a bitmap to ensure we saw all
> the messages without duplicates, or something.


My main issue was "how to actually parse that". But maybe sanitizing the
subject is good enough.

> 
> The reason why I care is because such a scheme would be easier for
> existing consumers that are prepared to take ...
> 
>> -		char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
> 
> ... only numbers in their filenames, and not ...
> 
>> ...
>> +			name = xstrfmt("%s/%0*d_%0*d_%0*d", dir, nr_prec, total, nr_prec, nr, nr_prec, ++skip);
> 
> ... a string like "04_18".
> 
> Overall, I like the idea of massaging a mailbox that got patches in
> shuffled order to make it usable.  In addition to the "sort the
> shuffled mess" benefit, it would allow us to drop the cover letter
> and pick only the patch messages.  I just am not happy with the
> output "04_18", and the parsing code, as you said, is yucky indeed.

I agree, I didn't really like the output but was having problems
figuring out how to handle that.

> 
> And of course totally outside the Git tools scope, I wonder if this
> is something "formail" should be able to do more naturally.
> 

Well, in my case, I'm downloading the t.mbox.gz from a lore.kernel.org
server, and it just happens to get patches in seemingly random order.
The lore website itself manages this fine, but for some reason the
thread mbox files are not in the patch order. I don't have (direct)
control over those, and its a hassle especially as the mbox has not just
the patches from the original series, but also the entire set of
replies. It would be convenient to also strip out and skip those as well.

While I do get that this is somewhat outside the scope of git tooling,
its a relatively common problem at least for me. I could probably use a
different tool to parse and order the mailbox first... Hm.

FWIW, i couldn't figure out how to get formail to do what I want, but it
looks like I can write a little python program that can sort messages in
a mailbox using the mailbox module. That would be sufficient to resolve
my needs.

Let me look at the way the format_sanitize_subject thing works out. That
might still be worthwhile for when you want to peek into the folder with
git mailsplit.
