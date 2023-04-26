Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CBEC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDZTPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDZTPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:15:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667C612C
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682536514; x=1714072514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0MyApFyNi69I7ZSsiwfR0A3ouE+Ww5iCqO8TSyuS3no=;
  b=FrFn+F85MQQ06ZYRl5b7ZKF4/8K3xk+txLymQwJkncGrgTPY6ionD6SW
   1ZLs0iQx+LrUxUcXg+q0XyD9eHT7ndhLAVykjN93H7yokIla+zdVCKGfa
   BcJPoBEMkRvKjZHJoXq0J6fOZ8GC/Ya0xNs52DNBvBCM8vW9TNJv+REx9
   NgyTfUc3z8GdJTAbP4GkZid/LgJ4s8Uj+F/F1WyuDFx64mz+RUMS3YSy+
   gjRihEi5DS/jvmK3vlKw+U0m/QGi+JujiJADw7GAqqedas50cz8pfRPeQ
   9BbIqSp0dqodhwtFYau7+nY1dYpFsqOOCla3H+F40EcVk6I9Q0LJEuR5s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412523845"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="412523845"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="940360401"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="940360401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2023 12:15:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 12:15:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 12:15:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 12:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4K0jzIVdYQsIoE8ELNyYQVkaAqjvyH3qrsGflL9eqkTG4iUErqWUptiCGRPgmuLNlXnaKSNLuxdnqGKSc5OgXLXBhpT4iN3jrVkAnEuvBb0w2vo+AQs9oN9Qc1alL8oLvMy0CRrMfUBXdmVlZF9rMPQxiu9V0a5fZ0eqddMjJq0/HS87sYwMXlGu8eGn2kYy00LyyrmIg7tMaOB6+XDEcs/vLzopuPEDFWjSEazNbPc/4oZTEHrOQPas0ncV2JvVJ6tFd7WXd5J5fJtgx3RS70qT/guSs5t9/pbb1T4vfTj8parf4z0wVZUsrQ/lK4b35tO96l5D41E+mYj3Kip2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEBY/pOOuXZn/S09ThvvHTM+XuJZRqwvXD9hAiRc9oI=;
 b=oRceZVvhdV/XOPiUiS39L29wrZvIXVtZepcA7N3KkHQn52AzoC9AYl8l4wWWvUxoTNpLRT3paxmLGFhPhdFGGT1vwqCQEx9z6EUjVIX/WBhzXuXWdgSJNNs2nUB0CqnW1EQNJQlVQFSaQ2Nb2UgGbZ3bo+TIvr4EwJ1LloWcHepTOhotQK45lbXAWO9yMABlsW9v4eH3wuhb1cJMbZDlRt5Ae40C4aCKfRSJqoyUHxZmAOAg17lEAnqpx07xpdKVSy+YgpI++tiazw0G8jqSim2EEOjHqIPVHa+7q6UOgOpkWSZrvWhyT9NWuYTX6CT4qgo56uL4myu5F6GQYmaMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:14:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:14:59 +0000
Message-ID: <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com>
Date:   Wed, 26 Apr 2023 12:14:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>
CC:     <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
References: <cover.1681906948.git.ps@pks.im>
 <6446e3db4702d_cd6129452@chronos.notmuch> <ZEekRNuPmObU9Vsq@ncase>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZEekRNuPmObU9Vsq@ncase>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0f427b-e249-4ecb-e17f-08db468a872e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYpIM0jf/kyn9zE0IDfNvUmkm9nPsTKJ14A6nNx2LJQ7kZVD95RRUs7oyDrFxIRhiQ55P+rxoIoFlXsUG3WvN9BrJLZARQEPJYeOy+NjrEeX/YL6v2g8F7JdonMBG5HUkR7cYCahyNMMJ7LpW+gXEFjthuwu9citDRg8H3OQD4bgP7lZoyVDxMq6yKV1rExYl4UhWieNQaHe7LQk+pqRIS6S4XmN01gYP85B2a6ittz0AkeNU0B2KJzX6917EeDt96uoL2Zz3OF6SwPqXj1hDuJSG1coOL1ZF5+DaAeK0FEZ40ipRqhcXlT3R1sNtRsY6kNSO8rvsn8Zq+L3krC631kv9uRXCA+qGas1aUoTIdqXfHmPuio4XwE6ihugojWe9rdn+SdwQjcM6n/0vvSw0aOkZTPga3rRhoOdi4nkcKn5tCtESlUuQwWMNI1k5o/DgPJwyAD1H1b8MpgvfJoTvV5LxABZjvBg8jmqT41Ei0Rqyrzxh/sMG5xMGaxEwARuoQgx49Tg9cXYrdsVNPxuquyQ7DzJidYRoV44OnECf4dUPvHV6HJO6ZnWrZgeUzfFaPbq5CB6DRRBTP5Zb+acTTMxiyk0NtT+TRCJngwvl5dDrjN+n0NF0K3vMpjSvSCO0azlft0x6iki8LL2vuABzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(82960400001)(8936002)(8676002)(31686004)(83380400001)(2906002)(38100700002)(4326008)(316002)(66556008)(66946007)(66476007)(66899021)(31696002)(36756003)(478600001)(86362001)(186003)(110136005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUEvUjNKN3kzemJobys5Q2tLRzg4NHUyYUo1WEdyOVhWdUxPMEtyRUZ6MDFY?=
 =?utf-8?B?M3pKR09UNHV4anY0V3k1dVVQbDRZc0oxVWZKU01lRmFtVXNoNjJDOU9JUU9B?=
 =?utf-8?B?dm5Oc29VcE1ORWJxaEtjZUplZzg3dE1uaW8zcEx3Vy9oZ1hSK2xHNURjdk50?=
 =?utf-8?B?YzNYK2FGTDFldW5UL0wrY3lOQnZoZFZTZXBLZnJZWE9wQWdZMzdYT0c0RUlD?=
 =?utf-8?B?VFYrc2NydUlCOVlTT3orOVEvS25ZQVNkSVh2MmZTa284OFBha0t6Qy92K1BH?=
 =?utf-8?B?bEFqeEp1akYyVmYzcjVCQXhNdmRhYzhFcnpjSWlEWldueCtmN2JtOUhYZUNL?=
 =?utf-8?B?SW5IT0MrVHZBWHpkVDZwb3VVQURuM2hVYmsrOUxobVh0Yy9heVg0eDdSRDI5?=
 =?utf-8?B?dDBzd3Z1Zk5vbzF1anVRWmc3UGdnMmJGVkZvVjBNMUFkS2x2MVJaU0RoLzIx?=
 =?utf-8?B?WnFwUGhYV2dlVi9IY1dMVWNqRURXQmdacGR4V0krbzVPWW5LZGxkR3Z3ZzBC?=
 =?utf-8?B?SkRHcTkwenhabXI2TTNWYjNVdEVYeHVLRDk0TWoyT0sybkd4UDBoWWRQWkNz?=
 =?utf-8?B?Y0RVcnAzSGNvWU5MaGJwMERhbFlFWTZnVDZyVkNWL1FnLzIxTm9hMi9HcllB?=
 =?utf-8?B?bUVpb2tiTWZvMFlmTnQ4SjRrZGI4TiswbnBNU2E4RCt4Z3h3V1pSeWsxZkho?=
 =?utf-8?B?S0ZSQ2VLZXE0SzJNaGVHTkRJeE5vUzhZN1Y5VlMranBJaVlhZUt5TGVxTUdo?=
 =?utf-8?B?STUzZHhDYVMwL3ErZkZ1dXFoL3VpTDVQdmx6UElZUEplWThDQUxMRW43T0Fo?=
 =?utf-8?B?T28wZTdTOE9vL0hzdVVFWHUyTFU0Wm14VUoxc1pEaXRTcHdudnlkb0NOblo3?=
 =?utf-8?B?VzRsQnM5L1N0dk1KSmh1elFvWkovU1ltUXp0c2grRUJpZEU3UFBlUjgvWVhM?=
 =?utf-8?B?K2E3NUI4OEhmWG5SZE1WcXFDUlBvdTI3VVh0ODlZV051WmpzUlpXVnlEajM4?=
 =?utf-8?B?T2hLRFN2NUZkZk0yMklPVm9sb0dWekwrdHhjYk5sQThYaDh4MXRCbjROT0s4?=
 =?utf-8?B?SUFmeVdKTmc5aVY0SUtvLzhuZUJMMGg0WTlzdzlDWkEwMjZQSmsva0xIRjRp?=
 =?utf-8?B?Nmh1dWZqU2tXc0lRUkhRNExQRnhqS2FHcDhpdHFGS09lQUNjSllCd3cycHlk?=
 =?utf-8?B?SDFtSk8wVGJBM0c2aFZsMUJvNE0wa3JUWDFCdFlFbGVGZUNJNDJlbkdaVk5x?=
 =?utf-8?B?ZzVMY1V0TmR1Mlk0M3dkbjJZbG1EY04xaThGajVJYWtqVUFQLzlqekdwRjNF?=
 =?utf-8?B?MlZSWEluakRIY3gyd2ZWUE15Mmg0MzJCY2Zkck9MK0xQbzRYU21Tbi9PbnZY?=
 =?utf-8?B?cXd3SlpXUVBDQlZDeGxsUjdoOCtvT0JUWVJGQlJNRUtOZFJkSEJQTitiODNZ?=
 =?utf-8?B?MUllTDAwR3hzKzhhYTR6S0FtbDJCWVpma3h2U3RJRURxaTNvSHJ1RUdsTXBa?=
 =?utf-8?B?Wlh5enlxNUJ1MElDcm5lN0tJajNubzRlcTFvK1Q0Ty8xS3VoZFdDYjh5Sm5X?=
 =?utf-8?B?OWVwa3AyTUdMakNOQ0kzOURqSmxHT2xnMjE0RnNuMEoycVZoRHd6U0R6WWkz?=
 =?utf-8?B?T090OTB5b2VTSkJCV0hGOW4rSmNUaUNaQXRzSFdhV1FhZU8xYmpsNUdpZnVK?=
 =?utf-8?B?TWtiUVRBK0xuTXIzL08zSFBsbHF1VkFKUE1QQmtBWEwwTHJRaFFXNmptSCtP?=
 =?utf-8?B?STFpV0h2dUtiOFVIMGZsODJXRmV5c3BBRUhJYXBVUFFWaHpWdjQvQ1VXUmc5?=
 =?utf-8?B?VHROUGQ5cU9yMkE5Rlc5b1FqLzA4a3FRNEova1RJR3pyT0hSQ2hHNUFQTzFQ?=
 =?utf-8?B?VXNXa0J3ZlNFZ1FKTmN1QlBJaU85eVlhZ1BNcXFHUEc3L2puWkwwY2FjUXNP?=
 =?utf-8?B?emNRUWJzbUdsK1ZSOVZzcjFJcUVlOUluMTlLZ3hvRThqYk54Q1JhWG1iMGZ0?=
 =?utf-8?B?Q3c5NzUvc2RVZ1JucmdudmVja1hsRFRPYzZKMytxYXhWdEFHTFN2aVBEakw1?=
 =?utf-8?B?L3pLbGlzOVJ2NU84UXc3Ny96elFxTDB1YXI2SkhoRzRFdDQyVVRaNFdTcm83?=
 =?utf-8?B?cDE1b2JXeGxadmVSSTNFcXloNXpsMlFiSlY3QTc5WnZCb0pncVpPUmtnWExp?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0f427b-e249-4ecb-e17f-08db468a872e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:14:59.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZdsHU2om6LWTndC6Lgahbl03s4VrVpsYqSKvdvFtLZPWuiLoAqY8EGDFkUgQW1bDT+JUK3HblRG0yuWvYgthDCuLk6ik16xiCWid/qDHBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/25/2023 2:58 AM, Patrick Steinhardt wrote:
> On Mon, Apr 24, 2023 at 02:17:31PM -0600, Felipe Contreras wrote:
>> Patrick Steinhardt wrote:
>>> Parsing the output of fetches is mostly impossible. It prettifies
>>> reference names that are about to be updated, doesn't print the old and
>>> new object IDs the refs are being updated from and to, and prints all of
>>> that information in nice columns. In short, it is designed to be read by
>>> humans rather than machines.
>>>
>>> This makes it hard to use in a script way though, e.g. to learn about
>>> which references actually have been updated or which have not been
>>> updated. This patch series intends to fix that by introducing a new
>>> machine-parseable interface:
>>>
>>> ```
>>> $ git fetch --output-format=porcelain --no-progress
>>>   fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea1d375ba546b2 refs/remotes/origin/master
>>> * 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074a48776f6b671 refs/remotes/origin/x86-rep-insns
>>> * 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d49a84ecb647e5 refs/tags/v6.3-rc4
>>> * 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73bfa4f38d9637 refs/tags/v6.3-rc5
>>> * 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd4055e15bff5b refs/tags/v6.3-rc6
>>> * 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6dd0b22ee6ec2 refs/tags/v6.3-rc7
>>> ```
>>
>> Makes sense, my only question is what other format could `git fetch` have? I
>> think `--format=porcelain` is clear enough.
> 
> Yeah, I'd be perfectly happy to rename this to `--format=porcelain`.
> I'll wait for the Review Club that discusses this patch set tomorrow and
> will send a new version with that change afterwards if nobody disagrees.
> 
> Patrick

We had some discussion during review club about this, where the idea of
using "--porcelain" came up because many commands use that when
switching into a machine readable format.

In addition, this format not only changes the output but also moves it
from being on stderr to stdout, which is a hint that the intended usage
of the command is now a little different.

I don't have strong opinion here but want to note that "--format" is
often used by commands like log which changes how we structure the
output of git objects.

Obviously using "--porcelain" is a bit weird when dealing with the
pre-existing compact and full outputs, and perhaps --format wouldn't be
confusing.

I didn't find any command which used --output-format today, and all the
uses of --format I saw were for object formatting like git log.

I'm ok with --format, but wanted to note the potential confusion.

git status also uses --porcelain and has a -z option for NUL terminating
instead of newline terminating. We thought -z might be useful to handle
the potential of weird refnames that include characters. No one on the
review could remember what rules were enforced on refnames to confirm if
it was legal to have '\n' in a refname or not.
