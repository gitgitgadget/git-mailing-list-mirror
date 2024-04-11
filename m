Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC2205E24
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861557; cv=fail; b=pSYkOuzH2+GKCXEdCYzfIyTeJEuuW0Pgr8CruXW9fajQ+SzFhHpYeK3KHZXtpO0bFNAl1RQtvmvIElCBE6FEewngr27AfWt9vCW0n90GhkHcXFq7ILGE5GFKMTZUQdvCPz62QUgPX6xoEiJaJ6xDhsPZTTKhld5e53OVxqRMCMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861557; c=relaxed/simple;
	bh=oKk47KJaPGsJZcHK7WXChbehS1XI+8geyklm0LK7gzA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NF80rFzubNuXOy1uapIChA/lUAWzmNModFbjoo2xH1eSTrUG2iT20yMMeAUczoGocqkWmAbzeEZTNyPI3BbYwpLHKuZPQxdpx6cOLmQFy8BelexNpZotRVWv8jPwOGIfxiXZlaiKCqaOImxO/D3mCwQr7UK2Hi8c/nusGZXYYVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ui8OxTei; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ui8OxTei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712861555; x=1744397555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKk47KJaPGsJZcHK7WXChbehS1XI+8geyklm0LK7gzA=;
  b=Ui8OxTeiI78XMUQZmbq5v5uiknNNNJ4SgfYeJ1hqXzoslmeqn+vpJEkt
   LMaSkeBjiZiq8JOWvgQjUDD72/cZYP0UcmLnEtZLXfdxiTcXMYd9g49e4
   M3Uwx2Sku+Pswr02yf3QVztp3rrDjr0XHnDdgxvqxRBBZBL3vomm8usW8
   BPDZJjVgbt7veWUheb7BB2bHpFFubzai1t3zV4eVdXTXsZ6640v1arIIB
   wuKRyUUXVujBSjxlqIBow+WcpxhoFL/eIWV9CHpfbUkIbHn4Mdtq5WFcX
   RJbWazkoXOgR9/StBRGzaM1UnH07DUOCsUTlNPW1ciNTvD6/KorlK7GYr
   w==;
X-CSE-ConnectionGUID: 3clI2r3rQvW+z+yb26j9TQ==
X-CSE-MsgGUID: YD58cWxjRpWjeAjN+rHNeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8158404"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8158404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 11:52:35 -0700
X-CSE-ConnectionGUID: YYAG4NejQHSXkolARhm5UA==
X-CSE-MsgGUID: qCCDbgZiQQOZIbFR/wPeBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20907108"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 11:52:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:52:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 11:52:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 11:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcQVRrZb5LFdRGHD1B+vJNNkb9bUs5ExLhglO5+ZB8+HXkoKLW5vftVhSB/eCMd5RXfgheCX2K+wPH3JFmgljgYsF9FPyTgSZALnsDHGkKo9k8P3NYm5kpM5rgmRDRNW9nVKuLa31JPPGQSd5YPbjzNeELVgOenyGzp8G7PoHzDl0Khm48uqF5CMb41rX1GQRCpy1wRA3oDBO7AbzxcafgU/rIfm3oqw+Je4KQTJN6yhSs7wj3dMapoGCoA1D3aleY8wr9eIF7GZr8k6cs52eSvvOFoz5/uAoV4+4YyIVQflbs99UbG9MS2YdbUbkl6sy1cX47DCJlh0T5lGu6kxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/TT5XpvARgSrM2gwYqDHc4PCnaHHQAOK7WkvDtzuvw=;
 b=MHLorTMQa+NFZEdAlSKYWcamCNjo37PXrWb8M2SGurI+/zBiNr12ES55yiJ+nzJPSpuNuvlDgL1FcBDON7Mij7qq6I/3H8kpIVqVm7P003T1WI/8nGYwZ4pH8Bl/2LdTcveBAQfkAdtX4k4OF/pHasVnjnUD8KOhvAVKZUImTPwEh+BXhkgMozbz9v8ZbOJ3wRkotD7t0TzH5z90NQG2E3RYthXORwTUk1yeOZkQeonqU0SNhLxqB9XVk01uJBfKXeYvTVhjknSONH8ZQ6NBnvvQ8GBKZ9xcq/nN+hwR1UvTU2SjOAGwb3+m4bmXwlIkdDqjpfdfDld3koAwVPdAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 18:52:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 18:52:25 +0000
Message-ID: <5a25d75c-cc27-49d9-a49d-39f657fd17f4@intel.com>
Date: Thu, 11 Apr 2024 11:52:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in
 filename
To: Junio C Hamano <gitster@pobox.com>, Jacob Keller <jacob.keller@gmail.com>
CC: <git@vger.kernel.org>
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
 <xmqqpluz2tau.fsf@gitster.g>
 <CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
 <xmqqedbcqw84.fsf@gitster.g>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqedbcqw84.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1c9ac3-4134-4917-12f1-08dc5a588764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5tDRZ8LBQjmEjbWCj0htPfkwB24U2RRbvS+ha4o1uNHpe37hUqvbaei63Y4hjDGpkqtZYrvvuphHBaHAhUYJ/Ytcm9sCNknfM+7cGmZVzpaqRMBSTIFUO86G2654uSZrE9QNoi2gM2U6B9tKPxOR+u5DuPgJ4gcF7xVR8ZVxxl+HQqnFXMFZ5zMOBKSRMkzGHT5znUMSx1D0O+Aeq3r49UR8dXggDCeuQmfueaqm3Aq21vvu6so3YrgCh7rJtvI3YRm51PpfaWbjMkdA+7rmN42HnlB0KcIumOspeEtKyMttMEi4Wh2h1MCZgu+llVHHLayMOW7uX+KLvaF67McytYrmcXiBFocfZJEG2xQr87kLyoJ+kA3QPCdaeZzbCjKw+WXXayVVkJ1lVuvEKZUWJoMl33ASvUQyhrwbbaV5zn8zrawTz1avSRT8jk66JPKPmUkzYXlhXQ/EirN2M/awpAn21DjwPWy6OtJqC2oNhJd6WzvJ64jrPFi9Dd/RRZ96gLldZmPSo+9S+DG0o70LwvDbTMRsNkFs0oAS2izy2MH9Ie2LzbdOQgABGEmlJKTBivS6SqtyFv//CP5Tpzad3cLuNLzu6ndDpbZecdLmICwpvlqgpg1k+gxmeCgXJ5HMSGhtlU+BuH1tkGBk0iPDxIOUoeLtQO8WkMztWgvqLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmo5NUphOHVwbXJtc2ZaVVUxa3NtZmNVNjQ4TXBtUVJJRUpMeml3MHRsV3ho?=
 =?utf-8?B?UEo4UkVjQlQzM0lBeitXRnJ6Z2U3ZWJIUEVDc2hsMWQ0VkY2clJGTWoyZVRm?=
 =?utf-8?B?QXRhbzJEUkRlYXcxbzVXY0RibkwwNGtiYXg0REdtN0ZrOVMvdG1BZXBRQVRP?=
 =?utf-8?B?TU1WclQwL1BTZzBscWRYMDRDQ2ZNbXF1RkNYYlpRbHJBMHNibzJFYjRDUExw?=
 =?utf-8?B?bHB0V1JXSjFhMnNta25Oc3RIMENZSExZdjNkbGc1NFNHZTB6ME9xc253QWRS?=
 =?utf-8?B?SWovZzlRZDFmTjdNaEthNkhDQ1haNUFRSnJ3Mk1zc1JnMjQ4cGtxeGxJSVNT?=
 =?utf-8?B?eWdZVENzNGU3bzI3dnhWK1paMGViL1I5NmFqWWJJVFdsbnZXVytVR1ZNMWRs?=
 =?utf-8?B?K1A3QmxDZFNhcGhIUksyNkNFbENuNlh5UkRhY3pXRWEzOW1RU1JhOXJKT1Fa?=
 =?utf-8?B?K3d1b2pKSnhSbTFBK0pCWmNzVXV0VFE1Rkd0Y25YM09jNnJHYTgweEdkbGJ6?=
 =?utf-8?B?ZTBhMi9RYXc2RXA4b0tLYUkyNmxXREkwdlprVFY3Si95UzZoQzlQejAvY0l0?=
 =?utf-8?B?T09MeS9GS3hIeG03Z3hzZjdsd3lKTjRzc1F0M204bTIxL2hSMkJIWllUYUlR?=
 =?utf-8?B?aGVpVExIL2hnTzdCOFl6eGM5emtuelZxdzBmQ21iV1lpdXd2OXNFQXlycTAy?=
 =?utf-8?B?STdhQmE2c0ZGTTJCSTVGNnhsaGQzQ1pvNTBRdXhVUVUwK2VTN2J2Q1ZpR3F2?=
 =?utf-8?B?bHJLQjVxWFUyRFYvRXVKMkViQ0YxYWVXMGs3ampmMzlvZXZTYjBKRlVickZC?=
 =?utf-8?B?TEZodjVmNENzL2NZZnZmRXBmMlZtU2NLUUVIS2FzbVZOQXpDMUNMZUI1djFq?=
 =?utf-8?B?TzZ1ZVF1ZGw1S0V1YXpwR0R6WHlqVGhMTGIrZzhkNVcwQjhjOEd1amFCSDhI?=
 =?utf-8?B?N3F3VEdHbGFkd2hkRE9SeXdjQ2prMVV6NmY4QUhsRjNiOUw5MW1nNlR1RzBn?=
 =?utf-8?B?UFVUdEFDcGJXbC9sTmZXN2NsZDNkb3RmcVhzUlplNGhBTnNnZ0NGUGxxbEJy?=
 =?utf-8?B?MWpiYXBFUnp2ekVkSEQvSU1TYmxCNW9ZZG1QNEM4blRUY01YNG9FaXdkdGht?=
 =?utf-8?B?aExRYTlsSTBoQVE2dGtzZVoxSkdjdzU5aWZWOW9rN01rOVV1blo3bDVxdEFu?=
 =?utf-8?B?UGdNUHd0Z1dONHhJZnRBb2c0T3dseXh6MDkvRExONHpBOTVzakQvU3JObHcz?=
 =?utf-8?B?TVZIUDlhYW5xOXpDMzBNczBzdVorMnE1enFJT1RxN29BSVRVR0VhTVBBU2ZK?=
 =?utf-8?B?MUlveXhlblRkTGNaa3YxTjBQK2xlMXZvTTFRQlAzMHNkMEVVVFJBWDdNQWpi?=
 =?utf-8?B?MG92TGd1NkMvZ3laenZLZnFDMkNKUzdDN2xrZUdGRnhoVFlLWnpWenAza051?=
 =?utf-8?B?bUJhdisxMXgvUkVGdThLa0ZxZ1F2Ym9ETHVxNDNEU1E0NU11OWZsNjYza25U?=
 =?utf-8?B?eXR1Q3V4NGpjRXN2Y3dRaFJXNHRta1ZpZXBVTVFlMFNJT09YZ1lNQUYxaG5k?=
 =?utf-8?B?eTRyeEdiVVZaNXYyVWhLUGFHdkdqbFQ0T0dXcU5OUnZuRXJLUVMxN0FWZngv?=
 =?utf-8?B?LzY2bjBZZngxSEh2aEFPd1ZvYWpIaEdYdmFKdFdUS0VHSm1EYldIbEhnb01r?=
 =?utf-8?B?UnBWUVFJUEJNZm50MVhQUlZLeWtCNHVKVGx5YjhvZmhNbnhOdCs0QWNkOEh3?=
 =?utf-8?B?MlhoRktQVW5pQkVuU0xmdkZoVHF1dDVkdlJYZmZnSGwzTVU1Q2V4THJpQWdk?=
 =?utf-8?B?N1V4U2x5NTFJVmZsYmhtWWY0dFpTSzEydTZBaHhWNUxnNjVkdU9YaDNkZU5H?=
 =?utf-8?B?akdnSW8vdzhaS0o3eGgyOS9lMW9MTVVJODNpYXplQ0dFdWxuVlBIUEV0QVBy?=
 =?utf-8?B?ZjFsaVAvUzljN3dsVG0wWWRObnplSGc1eW80TTVuVk5qOC9CWVlqZEZIRHdG?=
 =?utf-8?B?TmUwS1E0QXlKYmxMQU1ERXNPbEpoRVRyNWlTdWZtSVVPbkZNT1NNTjlKWUlE?=
 =?utf-8?B?L3VzVjFlOEJKS0JQNi9Da29reUxpM2hzSnh2RU9DaDZ1aTFBaHB0dGw4NXBT?=
 =?utf-8?B?UWliTnp2R1ZsbW5xYVdUSEhBWFFlTjRxRjVmdlE4OHJZeVZVdWh5ejBMVUtU?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1c9ac3-4134-4917-12f1-08dc5a588764
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 18:52:25.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiQP5SyV61ntjrUQPAz8xhL4gunjzh1S1BTqbhT7h9oL08A2vS3ps4h+7rEPlxqIgve3kX3AQU9uvan9WX2Xh/+PijvmAO/1YVW9ZJ2wAxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com



On 4/10/2024 10:55 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>>>> I originally wanted to avoid the need for an option, but git-am
>>>> currently depends on the strict sequence number filenames.  It is
>>>> unclear how difficult it would be to refactor git-am to work with
>>>> names that include the extra subject data.
> 
> The change may be a bit involved but depending on where you decide
> to stop, it may not be too bad.
> 
> What is your design goal of this topic?  IOW, what is the maximum
> corrupted ordering of patches in a single mailbox do you want to
> recover from?
> 
> The easiest and cleanest would be if you assume that the messages
> are in scrambled order, but are all from the same series, correctly
> numbered, without anything missing.  A mbox may have 8 patches from
> a 8-patch series, with their subject lines having [1/8] to [8/8]
> without duplicates or droppages, without any other message that does
> not belong to the series.  If that is where you are willing to stop,
> then you can still name the individual messages with just numbers
> (but taken out of the subject line, not the order the input was
> splitted into).  "am" does not have to even know or care what you
> are doing in mailsplit in this case.

This is the main problem I'd like to solve. My original proposal was to
try and do just this, but the logic for extracting the number was bad.
Maybe just directly using the subject-based name and sorting by that
using standard alpha-numeric sort would be sufficient?

> 
> THe next level would be to still assume that you stop at the same
> place (i.e. you do not support patches from multiple series in the
> same mailbox), but use the number-santized-subject format.  This
> would be a bit more involved, but I think all you need to update on
> the "am" side is where the am_run() assigns the message file to the
> local variable "mail".  You know the temporary directory where you
> told "mailsplit" to create these individual messages, so you should
> be able to "opendir/readdir/closedir" and create a list of numbered
> files in the directory very early in "git am".  Knowing msgnum(state)
> at that point in the loop, it should be trivial to change the code
> that currently assumes the 4-th file is named "0004" to check for
> the file whose name begins with "0004-".

Yea, we pretty much just have to get the git-am process to work with the
new names. I can look at using opendir/readdir here instead.
> 
> I personally am not at all interested in doing that myself, because
> I do not see a reasonable way to lift the limitation of allowing a
> mailbox holding patches from only one series, and if we assume that
> a tool (i.e. "am" driving "mailsplit" in the new mode) with such a
> limitation is still useful, the source of such a scrambled mailbox
> must be quite a narrow and common one.  At that point, I suspect
> that fixing the scrambling at that narrow and common source (e.g.
> your "t.mbox.gz from public inbox server that cannot be told to sort
> the messages in any order other than the arrival timestamp") would
> be a much better use of our engineering resource.
> 

Ya I don't care much about multiple series. I care more about making it
handle scrambled series better than it does now. I download series off
of lore.kernel.org (public-inbox based) and those seem to routinely have
series out-of-order. I suspect this is because it bases them on arrival
date and sometimes certain mailers get it out of order when sending.
