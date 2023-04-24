Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F3C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjDXTo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjDXToy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:44:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F5B8C
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682365492; x=1713901492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=itw7AShdhk/w1ZSk3t9P/rHdC0XRSUUr7gpzW66v5WA=;
  b=fXHuFaopmlLXzrvla9upstn7MGGis8CBRmk+okOD2D8zlZw8DmvhyN4E
   5g+5FnGmJ1amif0oI8lMMfDB0DJQvkpYlPFWbH1j70O13GnvHePZd+3xb
   tJYcXUmpP+wSlxvUNi2Dvvh1JCR4I8rSU91PhWMiiQAIeJCxEVwFD6yVb
   eA8kJ4u8sNifVLS7mpkLOCh5Am4IfuxvlRm/VBeKWzeLfVltJvvHXg89P
   aBwlb3eIzecJuPg004JAypchWdTnvJcpuWoXDbkkVJAXHRxWtYJRzThxu
   AIHlkMX8KanSoQ1+KvC1XkJc4XReSY3EfQemfSsAkrOqv26Z2a0bwaBEi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409481965"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="409481965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725817421"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="725817421"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 12:44:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 12:44:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 12:44:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 12:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2kKmf2Naxc8411n28+MDk1a5DJQDELO4siG57cBbcZGz32Ca7Ktl5+hS+mEYiDYSWD1JZuAkXQ0zWHg7/HN0HY2k7HaaNn1R/k/cwMnC3lvJbKAAsDj6kMtJH6H/tEJJ+4vcfovJVYm5uXsV663NoQ0Xst9jPd1mIEg2w/lq/dwtrGOzn0rzHZCavRKhXRLqKcBiC7YYVBBtbBNJTXfDFzTWEj/h/tOudP0n0VQ0VdYf1D+26m7ZEAD7MdVbgk9IPaKRQXpZO+2IVR+ImgD4Mohx5cnEFLf0DSxQzGKzAALVAHylp5Do6RyI9bBuPAWScpTlQs+Ms1TKD5HeYfHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cSHe3vNj/inxOi6zJu3WzRWFxG9lxto6nB58Dv+X6I=;
 b=d8FhznyvrLrZ/oNu6GJL2IciAuj2VrGuTlrsgQ9+hzWZycWki3iTREue1d60mJI/i7XRIVX2gInOXJ+3W+j1X7jpS4FMwG5nzOl0rFox6o2kiLlFrFyoB0CjXA0NKwD7aPORFlZs/Ln2W4T2lplE2JE2QpWFjJtcm7OBifQz9RQ6nELqXyzRKXVlBnJKVBYJQkSCQdFKIpR0ob+wjVkG9lNp4fmmTbsGzt6/KK6rA1i8x5GRXAGnUDPQ273mCxSRey34Rh4NAjhvMZG05m0kG3KOdBwSQv65NECpp7uHr3qXn92+l19kDCe55ZwpffFY57KLrOiE19lecvaEai1YAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:44:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 19:44:49 +0000
Message-ID: <26c4306d-f0f1-a2a6-55a5-6bb10c77cc0f@intel.com>
Date:   Mon, 24 Apr 2023 12:44:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Proposal: tell git a file has been renamed
Content-Language: en-US
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Jeremy Morton <admin@game-point.net>
CC:     Chris Torek <chris.torek@gmail.com>, <git@vger.kernel.org>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
 <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
 <6446d78fbbe82_cd61294e5@chronos.notmuch>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6446d78fbbe82_cd61294e5@chronos.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd4ce15-526f-4609-54ef-08db44fc5d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP1syXUhc/MxZGlJK94mq5VokFfm1LRqemUkfaK95Wpio5ISUPX3+6Owc1Jn9lGcVX/vUIaxyJApSpjnPYXQDMuO5ek3Ey071wQ3flI64k/D7HSEmFodJ0fXQnfpkTYFrCsFudB9ji2PKJIJ1c0RbeHEEE9beOuxveq7Mfk/06XqQd1Sko8mM+cP1UfNKsHpxlWROmNR17hpGe1QxQDTWa0rkx3RC5uSJN63Lcc2T8o7eYRVuvF7lHruRWkxZ+aNQi6lR1Zljd26kiDRq+SATdxy9YuqUdRj9ct6gb2r37j1EPD8GDDGsof3N+JxAXYhecaxOSfKllfy/AeIdVAhzuIGVSMGWJDxkX/Og7l4y+AssRlIqqlJE6hS7P+lNUoanU/bFYYzvEtCq0Fa37g8wyLq+9XFZHeGCcUY1dlNAwHj2MZOaSMwHuaynE8/3AXROhwXDp5SINv6nn7D1mVRxwRIhDroSwXMheWLaaHuROoZJZWnCSiKHVsfzS5HmUrrBfhXL0qPBly1fa3mjDALFMs8wsRvoQrOprX+auj6T8uOwymhi3JXi+TGBtbAXNsYydfzfE1JLd2U5tYXtwYKvjqLWaOSBLeYGmqBYubEN6XeN+6TlgPX2sHA5/D4XDNcXuEw59Kx62ZF5BKvyZ7I0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(186003)(82960400001)(38100700002)(66946007)(478600001)(31696002)(86362001)(66556008)(66476007)(31686004)(8676002)(8936002)(110136005)(5660300002)(6486002)(66899021)(2906002)(41300700001)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2pqRkJONllaWW1uRzB0cXU1QjQ0YUZPM01qR1REc2lOUy9MR2ViQ25TcVZP?=
 =?utf-8?B?bGdaTHFDOGpteGZseG03QmFyYWtTTWZ0cGhWd3o1bDNhclZna0ZWQUN1RGRk?=
 =?utf-8?B?WHNmZUhycEt4UWJBMDJSWmppNUYyQnRrWVpOMldham1HUWREYVAzOUI4QkFI?=
 =?utf-8?B?N1Y2R2VzWlBZWVVlSllDdGxxT1dJVFpHRjN5NGZaYUFoOGordUN1VVlCZksw?=
 =?utf-8?B?R0RzZ2JoWlRFdlRJVFNNQkNHMW9rUDg4OWhQVG9oRG85REpVS0dQbzVUcWFw?=
 =?utf-8?B?V0tXYVAzbk1VV3drNnk4aE1zMTFNMVZtTHFpQXZpY3FPd1NmVGdyM0pEVmNk?=
 =?utf-8?B?RTkyZ004b1p0c2l4MWw1ZU9qTHhPRTlMMkhJazFxMnJRVTJmS0ZLcHNyRHpH?=
 =?utf-8?B?Yy9TMi9iOTVnSnI3NS9jbW5UTHE3NGNuUFZDOE1LVVFRTjc2cUVkWTc5NDMy?=
 =?utf-8?B?TzJmMi91TWJhZmQ4dDZBWEZGelRNREhneTJBTUYveHk2K01JUDJaUWJ5R2lY?=
 =?utf-8?B?bGd2TnQzdmdvdzg5Uy8yRWtDYXUwYmtVYkNZd0lpeEtYcjFSUDFCK0NXS3BU?=
 =?utf-8?B?Zkp0WWNCbC8vQUFqc3pvcm9Zazgrek94OEdmQnA1MzV1M1RyRzk5L2pOOU00?=
 =?utf-8?B?eXJuTENwS21jUXZwSVU3Uzk5aXRsWnd4Z0lCWEZmTWFLeDQ3eVMzR0Q5V0pa?=
 =?utf-8?B?VVF5MmpKdjlzdU53R3lzaVRKZFV3N3ZETXhIcVU0K2hHNXJhUVBpUEVxOXFk?=
 =?utf-8?B?WmN4QkllUnNqS05mNTlWbHVBM1N2Z0c3MXVUNklMQW83ZlA5MklJZ1huUllP?=
 =?utf-8?B?VWRGUEdiY1laS2w4SHpVRnB5ZjRlQTFMSFVRcjRCSUxtNzEzL1BaTW5HV1k3?=
 =?utf-8?B?VVg1ZTBDUlEzWmhVSjJNYWZrU3l1bFA5SjgzYVg0ZGZLRUVJWS9FcGZYMXJl?=
 =?utf-8?B?SHRRSHk0dHlLN3k0eVVOUHUzYmJvdkxzY0NFZjFEVTZQMDdGL0laMVpUdytE?=
 =?utf-8?B?NEFDT0dlQjRWZzc1MjlaOVNGUE9VZ2tFTFBnMWpOeURsQzBobmttVjlQV3pp?=
 =?utf-8?B?THdsYzhOemdFZEtrcHBsUlFtRFNjUzBxanV1ckQwTjUvNjFPVFhwYm1SK2xV?=
 =?utf-8?B?bW1ndDFXWWMzNzVYeXlYTTB4UVdsMXgyQU5zdVdtbCtkRVVPSW93dkVqQlRE?=
 =?utf-8?B?b0NtTnMrbHliVVpHZG1HZ3dhRmRNaE1VU2xlbjZOZUs3MEcrY04zZjNKdzVp?=
 =?utf-8?B?Wkl0dFMvYU81S25KQ3pYa0QycWI5UmZxWUtwMjdaTHp5WWVJbFMrWjdKZk1r?=
 =?utf-8?B?d3RVNVoycnR5Rmc1Y3UrRDUrK2cwKzVYbTJnMzc1bnBaR08wWDlCblJub05M?=
 =?utf-8?B?V0FqV3BPL2tGLzVHRThJZG8vbDNTdHZrUFRRVWdkbDJ6TU5vK0thamJxTVM1?=
 =?utf-8?B?QmtRYmlBZHMyeHRhMG1ZUDRSdWFnUDJZb0xSRnQ2RGc0NnlaaG5rTGNsY3Q1?=
 =?utf-8?B?Y0hOcmVRY1BKQTAranFFUnhWQnRBem1OQlVaVHE1V3pxd2dnZUtKWWM4amF5?=
 =?utf-8?B?S1hCUzhYMnRpbTlhZTIycEUwNHc1c1ZwTWc4ZGtUK21aOHNENU93ZFZhYjlj?=
 =?utf-8?B?WmpKTldOc3djUlpXSHJpdEVSTEJNbjFVR29FT1lRSm9xL3pCeUliak5CNlNV?=
 =?utf-8?B?WlAwMUh5U1U0WWlvWDdZYUhaemxRYlJTWHNMQVRLd0RzcTJWN0FCZHYybFcz?=
 =?utf-8?B?SDZGelRRRG9xWXNVaWwzZ3prYjEwMkZzdURqQUJGSW5EWUlKWEdUZnNYMXZw?=
 =?utf-8?B?dlJVUWdwU2dsMEdCamYxYXBqcnQxY0xITzM1NkZySDQxSlp1RmR5RGw3RnMr?=
 =?utf-8?B?MVIzQlZZcVpEV1JYemxtRWFVRGppN01uUmc0ZmhIMXJiNkJUYytKVmVRR096?=
 =?utf-8?B?cmRPM3U3M3hPZ2J3RWxtQkYvTEI0UGFlZ2RKdTBKcHhpekt6TEVsTUd2RzVo?=
 =?utf-8?B?QVJ4V1RvZERzb0dTWndtSEhqL3BGK00ycVozSEJnL3dOcUdLZEtJWi9BazNH?=
 =?utf-8?B?WW50VVFRQlRaQllZUjJsUE1vK3BIR0FsWHJnc3RBaG8reUFrMEpjSlZQeFdG?=
 =?utf-8?B?WXRRU1hNWW1HVWtxVXBVRTcyYnlqczlUNktyTm9oaUVxTWJ1elVSVW9abTc4?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4ce15-526f-4609-54ef-08db44fc5d8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:44:49.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7l1M+cZ70NsEBzy9lZ2clx1Emw3UO3GUzriYqqXL338CIX7ZGEq5I55XCyRGb5WB6Ns50K5LysnIIGNTVHGYyFBPNd0kLVdeqrV+Plqibw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2023 12:25 PM, Felipe Contreras wrote:
> Erik Cervin Edin wrote:
>> On Mon, Apr 24, 2023 at 1:17 PM Jeremy Morton <admin@game-point.net> wrote:
>>>
>>> There's no getting away from the fact that this adds a lot of (IMHO
>>> unnecessary) work if you've already done a rename that git can't
>>> detect and have both that and a bunch of other changes sitting in the
>>> index.  What feels like it would be a natural resolution in these
>>> cases, though, is a "no, this remove/add is actually a rename" command.
>>
>> It can definitely be both arduous and non-obvious how to deal with this.
>>
>> The problem is that such a command cannot exist atm. because renames
>> don't exist, they are only interpreted. So the only way to achieve
>> this is to revert enough of the contents staged to the index such that
>> the rename is detected. The only way to do that in a foolproof manner
>> is reverting all the staged changes except the path so that the moved
>> file in the index is identical to the old file in HEAD.
> 
> I agree recording renames explicitely might be a good addition to git, but the
> real question is how are they going to be stored in the object storage.
> 
> My guess is that it can be added in the commit object after "committer", just
> add a "renames" field with all the renames, or one "rename" field per rename.
> It would be backwards compatible because any field can be added this way.
> 
> How to generate these fields is a separate issue: first things first.
> 

The other end of the solution space is to try to find ways to make the
rename detection logic more accurate. We wouldn't need to store such a
rename if the detection gave the correct answer in the first place.

You can already kind of do this by modifying the similarity values when
searching for renames: the -M option takes a percentage for how similar
files need to be in order for it to be a rename. The default is 50%,
meaning that the files have to stay at least 50% the same in order to be
considered a rename.

One potential in the case for renames which also must change class
names, etc could be a mechanism to say "treat it as a rename if the
content is the same after performing this replacement", where you could
specify what string is being replaced in the rename somehow.

This could easily be done for reviewing a previous change, but
specifically how to *store* this expression so you don't need to
remember such values in the future is a bigger challenge.
