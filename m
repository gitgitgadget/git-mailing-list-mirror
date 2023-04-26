Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA3C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjDZUaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:30:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DC184
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682541007; x=1714077007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lpHLNQp+pbwZjudA4eEcUB/JFJGbQ1ySjdjOsa0Yb5E=;
  b=RJyMkCD28D2iiX4RjC2yHh9rG47tkWyFtTZdP8UzfZ5gxqARGom0xKNc
   hXlUNh5YXBr7AorJNgGTCVoE19YMTZTHcg4osN5rn9GUCoF9Hq5hGuzbX
   ZrGdBY+CtvnXjZM4K3q/7ZCxrHOQ+XEGwHWv9p0Ke5jzcUxKKZVSFIWPP
   PsJN7ygEOefMLEkNKYJeesFKC9OaZYvqDOUMHKj2aANTq2xH5cJpF9D11
   ged9YryFN3PeXSlrrcJlZB4opjsWMwGogrzuTpRy9iXi5FQq+3xKZo+qY
   R1Jb3RARq0ABKADSAvizfYfxOVOYO8mRfdTBd9/hgzePyqMG5UwPll7+V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412542262"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="412542262"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 13:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="694079786"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="694079786"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2023 13:30:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 13:30:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 13:30:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 13:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEs1lceZuSOHCspjx009deenuidKn3a39dXGU/2J0NV12Sw8AedyI8aJdOpZ6LjrLlnZjSru9wLT3DiXpFbU8M8QzYGB8hwIvlcK2wD9ppZCOtD7H/H7uMo1u1FS7YwluORiaE7yY8XV/MJUxhNlhyV0mWeTIZPFrWFK8+KcVBXqtUYzglt2xQRoqae+XbSXaa1Q0aRSbqeFL/dg7kPwjbzBUhwinvvGQMdI62wKWWivi7GxJu5s7oNzVwlv4RQ7DAp/Ilr/7VdZYaooi3uNj4gvjcFe5URVDSo5WnWt03DsYtvLaoHCaEqCU48cMJ4uLPjqmIizZwgUfiet/xnjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIp/yNE5xEWmCZeZnmdEqqiyHOXgOWodA8TNV+MMlDU=;
 b=Mt+VeGjKyvRyQL8SYoakw0TwEONX31+BHTIgYp7qw6eAR2cEU5O+OwWu2dyhFG3m9f0xRXT2Oo6gxPrcXRrSHIq5kLPL/fpgnd3aiAxLJI1YRHySHJ2AJTn1nIouEikQerhsqfNkUj9TOUosEZN0nJflbyM4kvVFP+OSPjzbfVG1/xrT1DmtNAnyQdXfe9omNQN3DP365vJqL9KFVvaudXdMvEU+YXuNmkZFh9CXeip+HBHeJY8IeFuQoNV/+6t7gK8X67Q3RF4aL9avcV4S4NWRVNo9UvAgCBn+MP7V+0WUWWnz8Wriobb3JfCsc1zFl45MafX74qF7mMupJZUrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 20:30:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:30:04 +0000
Message-ID: <36378549-be98-1c76-7e4d-15e1a9123f12@intel.com>
Date:   Wed, 26 Apr 2023 13:30:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
CC:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
References: <cover.1681906948.git.ps@pks.im>
 <6446e3db4702d_cd6129452@chronos.notmuch> <ZEekRNuPmObU9Vsq@ncase>
 <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com> <xmqqildis89b.fsf@gitster.g>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqildis89b.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad42fd2-36a9-444b-2d2e-08db46950453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yG2Yv4IWh7ARnjm8fGOhFNNg305N2q8EQcSZdtU7EPhxy4ikIjqG8wM5o1jZctB9Jn3t/R0MRmW4B9AddxMh3UggMfaT7XXWKdcbLdJ30QFWPwOR5mbHbghMXMlbVriQjuodcFtQtcgTPTn9wNHegC9CBf6DhoKzTkY0xO6QBDBm+t+xQB5SttrtZzpaBmtTot5a7iFp/IEN374IGIePJJd/kL8Db8z4JsTGvwbP9YlEO+NcAElksJ+1K2jKydp5QhVOQ4xzquerKcxvPFVtaYw8aGTXZDzrlYX6YmNqgK7Q55/Rx+1SoDWl/JiUWWkZUUJxALwSvx4e3xmmh+7LkV9Keh+hfOjVzFJ1ObLuKL2yLMbTzYeMTXuoHuhlOe4nYFH2knBwAWVZ+4ivzNgbVuXNVRqeII7Xtbulg8DN6J94Xv7PsWDFsojgntwM1DONVXKrtZ3bCkAHhaH0xJzOz2U4vdSdJmebZqtSmEvM6vGqbzjlorgq4yd6aLaAT3kuMOkhpiEXMyOIJTBd3mrcrjwfByh92tf/L2dAz8u1e0ONDVjphRVzJRWo/AvjnuN372sbzQ+OeyQWlXbirTI0C55Y0VVyfRrTMdPWLkz0eXGwUGFghkFItMZHoikN3sTVAfPRWy6heKkNYZLKhJj2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(478600001)(82960400001)(66476007)(316002)(66946007)(6916009)(66556008)(4326008)(2906002)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(186003)(26005)(86362001)(6512007)(6506007)(53546011)(31696002)(31686004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak53ZDFrSEswcHVsTlFReVhTOGU4eGp1S2d6ZVpwYWZjd1pkVERPWndEOXRP?=
 =?utf-8?B?TzgzbThuY2ZrVFRkQWtrSndiNThWRzdtNmFHSytUbkVLaWxoMTZmWGZvVXVB?=
 =?utf-8?B?bUR4dkgxWjJadEsyRHVYYzBpREU4K3dYc0xmbGlPRmFOU1ZybHVOQWFIUnJR?=
 =?utf-8?B?Nmh4ZUlwREZXOFlGRm9QQ1pURHFqRmxHUHM4V25yeTBrY1o2bmZ3MUZKbktG?=
 =?utf-8?B?ZTBTbVpUdSs5V1UxckoveFFPNGxWbG94SU91R1E5a2xISXlPaE9kQ3ZPb0Uv?=
 =?utf-8?B?Z3g2SU5GT05QOVltVTZmNEZOUHlENUlwUVdyMDMrNDBrblgwdGl2aFdnR0Vr?=
 =?utf-8?B?U2U0ZWhOR2hmM29pUGxQS29TcTc5U0Y4WVAwdGZDVmtQbXk1Unk1MEhSRHdw?=
 =?utf-8?B?akZ5N2g2YndVNnFEOWFOeWN3MzlpTHcvOFZ6WWdsbEFETXVWTUdhTW1rZ3NG?=
 =?utf-8?B?eWN2QkxXWlkveTcxbjN0YTF1TWVsTWk4VXJLUUJoeDA0S1NFTHpBMjhIZ3pP?=
 =?utf-8?B?dFFBT1cxNnM1ZkxQRWlJUVhITnRzYmNTVTZSOG1XK2VLZVh3T21OMnRFRTBh?=
 =?utf-8?B?MXMzZDM0MU82UXJzUDVycEpXL1kwWFNOS0N5QlZFWHpRQXZMb0xwcXZ4VWR5?=
 =?utf-8?B?VVp0eGFudnBvc0dGTGFjV0tQMFBmMlk5WmVMbklhUXpDTlF3NE84djlCalhH?=
 =?utf-8?B?Yzk0UFFhVVkrSjUwdlJNUXdqVExMUmtYdXhtZGdib1RTbW1kamw0WmY3cEd1?=
 =?utf-8?B?TlNXbEE1NnpybzR3Wm5ETUIxalVnRjNVV2lTRGl5OS9OQXg2bXpSRkxselh3?=
 =?utf-8?B?YkcxR2hzNWFteWZGYkN3cGV6cXp3bnA3eDB1WjJrMnBWQXo5WGNldTRCaVVW?=
 =?utf-8?B?Zm41bDBnOFVvZVVvN2NpQVhDeUxjSVBqemFhTXhLSzZxSWFUYWs2bDZ4emIr?=
 =?utf-8?B?bjZkKzB6Zm90UkgwdEFjYmxYa3VrZ2l5S1UweUkwV2NhR3JydGhOZGc3Q2to?=
 =?utf-8?B?ZUorZXhjaEpKcmpqSUxpaTBXNFA1ZWRuSkhRRWlJLzdYYjBUOTVzSXY2NlhI?=
 =?utf-8?B?NnNoSXBabXVMdlFYc2xUeS9qWHo2RXBLbm1HV29HazlVdjRhbzFUSEtXV3Z5?=
 =?utf-8?B?a0dydEsxYnR0S2N3OEcvU2k3NE1pa3dHU1pad3FrSy8yKzhEZ3E0UklQMXl4?=
 =?utf-8?B?clFnaHgya2pzUVRlbHhwK3hWcGdIRkhHRUJQbkNWalFPa3BIRUVuVHU0TWxV?=
 =?utf-8?B?OHN1VC93dkxUWGY5UGpYQU96SG9NWkY4anl1R1hHV1ZXYU1US3ptWDc2WEVw?=
 =?utf-8?B?S3M5MkhFZ2xNNGxxRVlwdGxXUUZvczRsa09oQ2M3YnEwMjRSbElvcDB1eHFG?=
 =?utf-8?B?ZVNJbVJuOEhlZ3oxRnpiTWZiT3RRalp6bTd1aFNPZllyWktrTHkydDhrUnUz?=
 =?utf-8?B?d2N2cm9kOWM0dnh0QVkyY1VKTlFkQTBGQTRqa2E5cHVvakdPZVhTczdaN2NY?=
 =?utf-8?B?WFRtTGtqYjRReUVYdzBtQSswd01hVUVVSEVPMThOQld3Qk82UG9FNzY0MEU4?=
 =?utf-8?B?ZThlS2xZWklycWdWMFhMbDBYNnFNa3hxeThSZE9pMWc4UXI3c1JSQlM3R01B?=
 =?utf-8?B?cEs1Z0pFdkRNWjZjTUNlaTFuN3BMZUdwVHlNcjR1ZzZpTStxZ3FqbVVzMCtO?=
 =?utf-8?B?ZmNZOTd3VGNjZGNRSlpWbnlITE9sZjQ5YTNvT015Mmd0SHc0WkJ4R25Uai9U?=
 =?utf-8?B?VnVtcWVVQ2hsZyt6bkt2ell2V0VZSzI4Q0owYXN3RkI4OFFmYi9hN3V5bWVo?=
 =?utf-8?B?emVJMTJ4TFlqVDRENVVsOXRxQ3FGNC9lQSt5RmswYXp4Ui95dUFPVTlTRHNU?=
 =?utf-8?B?cHh5L1VrNEV0Q3NXUlRoUkZET3FsOU5mT3h0WmFNbHNKdEgzaUljNzJVd1Qv?=
 =?utf-8?B?VmYrT0NLNUFuOVorcW4yMU9IV0xFei9rWFg0N3doQWVEYnVya05ueUtRSW5k?=
 =?utf-8?B?UFpWdnpkaFg4UXhlamhDYzRwS3JDdnN5N3VMdlEzZjh6NWJFOVRWZ1RPTXlk?=
 =?utf-8?B?bTI5enN5RlF1aUhMeExTV0JBM20xWm1zWWpwUjRiWG9YbHJMZEJnSGpEQmwy?=
 =?utf-8?B?cmJBbUxVcWhaMmhUVytlTXdTdi9RRlNNSXVxdk5aOVpyQnRmS2cya1M4ZllO?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad42fd2-36a9-444b-2d2e-08db46950453
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:30:04.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+kaq3mRkPG9VxdnE5syzri+rp/exxvDWj6/UXeQmd+wms84tr3Q8CBpbtZRUtc7NXFfUPmjqynqm00VYKUAdlHZ7mgHtbhy/JpSG9hGfRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/2023 1:23 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>>> Yeah, I'd be perfectly happy to rename this to `--format=porcelain`.
>>> I'll wait for the Review Club that discusses this patch set tomorrow and
>>> will send a new version with that change afterwards if nobody disagrees.
>>>
>>> Patrick
>>
>> We had some discussion during review club about this, where the idea of
>> using "--porcelain" came up because many commands use that when
>> switching into a machine readable format.
>>
>> In addition, this format not only changes the output but also moves it
>> from being on stderr to stdout, which is a hint that the intended usage
>> of the command is now a little different.
> 
> A little different from what?  I do not think the answer would be
> "other program's --porcelain mode", as sending them to stdout would
> be one of the things that make the output easier for programs to
> parse, so it does sound like very much in the same spirit as "git
> status --porcelain" where its output format gets tweaked to be more
> machine friendly.

A little different from using git fetch normally where all output is
stderr and is generally "this is what I did" but which was obviously not
intended to be parsed by scripts but instead by the human who ran the
command.

> 
> The output with "--porcelain" option enabled tend to be less human
> friendly and the distinction between Porcelain (for humans) and
> plumbing (for scripts) is reversed in the use of the word there---it
> started as "this is the option for those who write Porcelain
> commands to use", but still it is not a very good name for the
> option.

Yea the option sort of means "to be used by those implementing
porcelain" and its definitely a bit confusing.

> 
> I am perfectly OK if the plan is to uniformly use --output-format
> (or something equally more descriptive) and migrate and deprecate
> the "--porcelain" option away from existing commands.
> 
> Thanks.

That makes sense to me as well.
