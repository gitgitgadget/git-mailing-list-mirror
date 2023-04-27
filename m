Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4DC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 19:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbjD0Tte (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbjD0Ttd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 15:49:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CD26BE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624971; x=1714160971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sqzROhc9jNZw6wHotPtTjdWyqWOpJ/t8FOJ2B12q418=;
  b=HZp5maMkwo7MhU5ucdPO/GCzCpeG2TDbCuMj7RJ8YNmhNDqnys/n9cLR
   HxvDKZPhcZMAEpKvx3m8e1IeIf1P+3ecFXdM/fbCOxX5nB7cLm6aGVhCp
   VGHPuK+0/twKqGqJVfHe4eMBeQYvMYUMiqOC6e5MC+3R9KUBjhyCG3RRl
   uRIKXT0rr4AWBGHQ/RQ+wMQCmiZF8/PmOazHj3Xn6zjBeaOlEQVpd3Dw4
   rRJWonskn0X8H3dDy5+gowPelBjLBK1zcxebshJa2d1/ZrQ1vnkKn7RC/
   HALCz0fUM0T+aXR9QOajU6f7plY4vkunn285jPHrXLu7xt6R8NEa/XSvt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412910758"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412910758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="806088428"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="806088428"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 27 Apr 2023 12:49:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:49:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:49:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4HphfwlYFeQ2i9+5XaCXJDKfomD9O3nj31QT+RONWpCcCzBr7TtNwxpUbNjztqM7z32snV3EJW56enJD2Xe6MxkliZj1uFwoNmhQtYbzDkDMq1KnrsUxEs0PhoslAbb+vO7AEu1BWFEUxSqRpwWmdFYgdNiZQgDTlCGkTZgCLaZZyEnveg88Pc9ZMd7QfHsPVIrzczig5IqIkkh0h+MqhmGil/PAd84clLXG+qqTRhyEZY93qtSyJrujxlAjdLFH2+IZWj1iH/iy7b/sd/DmnqedAhD7PRnmc9N1PRVwuuGmN1dsC9/pS2gEADbNAmf2YjjU61xXwEuOwpSDIh0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDWo0WHUaCEd/Arljg8xKJO5aEEDkSvV5h0vPrORON4=;
 b=VL92PXDoNtZJTd5PaUApf7520CI3b0tg8l0HJ8r4Ez3AH1Nw4yuNuxtddt4POPX4xk0xarTgDmMl/cG8j5fk3bAYyQEVn8bKIXsCZ3FI58sZN6mtZKC4U0/l2F55e6EuSv19B5wmnlv2FhE+s/h8HLw4INKfYCekb8etCoyFJnLg5n7z3GQIEmt44vIygb4DLUUN1L2/SlWtOddeO2cm5pIHmWL4nsPLKaJ0Xe+yLp8V5ueAUX4gR9xzWrcngDh/msPHFbIjUKfz8kTqMvmpWgfMBeiaC+OyimPJjgrcwLfPTQmK448qmGjq8QCE4qMDgdKcfn33WfxbAOMo6oTgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 19:49:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:49:28 +0000
Message-ID: <09fe302a-6d80-4a95-85f8-a9a9f4d655ee@intel.com>
Date:   Thu, 27 Apr 2023 12:49:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im>
 <d1fb6eeae76bc550030475e40868b90a2ca6ce8c.1682593865.git.ps@pks.im>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d1fb6eeae76bc550030475e40868b90a2ca6ce8c.1682593865.git.ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6934579a-ade9-475a-ea81-08db47588332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZY/upTCJP2PbZ6KPQMc2En3gPJeOnVo0x9Uzcgjo9KqpRusTeJdOnsnVWFXNxZ07H7Vn/8SsRnyFSzRE5vgMLgMBu2cFKJwIDs9CuWs8OUKbBBNOdaQzTSrHPg4AFg8mCDeaSmOJQnLyiVNTIPX+vBnexcNFnT8fW4AcH5+9xcCIho94POR3yx3ic9nz8hubhIKeUJpZr/Mfd2kp+EsyyTz0wLcK0MQDQkDCdyPZw7wz6OgmsCdxnTbLK8UEM2qGXpG5Z97WBaJpsMCcKfgNsetmHw98Q6W9On61R51HAp8MNntmIrzmfMLfQc1+0ThNYzQamFzImuQAyzYm2TX5nrMq6UCO3JncSQGhdQjgDXFNPFELA2NmiqHKt0DetJF9miEFbQ75Ub7Ivvld0TH/7AEmtwCo+neJcwFDz/j+I4p7quEAgfQ/Tv0u3si8uslWJiAkSEKVHSPYnzs/am7wmR5EulG/0tFs/Xhw5ADbfOvPTd/z6Kda8QMXfHfQc+kmqZ6MRjlBoxs7yIanxIB3eP3jpXX0spCP45+B7UAJQBov6gop4qFCAd96D24/CjmLUB5FThce2hmTgITyREVF55Zcs0A9UQMMD6ip/hxRAyNkNYMBLyJ8yUwHdLH0TEz/+ZB6s8zYFktFXT+eCyC4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(31686004)(66556008)(66946007)(4326008)(41300700001)(2616005)(186003)(6506007)(26005)(53546011)(6512007)(83380400001)(66476007)(478600001)(6486002)(82960400001)(38100700002)(54906003)(86362001)(31696002)(8676002)(36756003)(316002)(2906002)(4744005)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkF6bVFwelNnbTVJOFdWbU8xVkNrNE8vOEdTcXdlRDhUamVIUUg3bm1xeTlX?=
 =?utf-8?B?bGdYajluUmlpekNrQVljUi94WnUzWGdZSHBqV05ySEtMMGlHdFJrZys5bThI?=
 =?utf-8?B?eTBmSUd1MDFVc0VBR21waDFrQkRZcExMc29YNGhQbmVqN1VoQ1pZNVNPNU1R?=
 =?utf-8?B?ZUpEektGTmIvWHRuOGdRUmtWL0ZmREJTU3JoUkVuZ3ltV1RnL2RxajVWUVli?=
 =?utf-8?B?NTlET1RnbFkxdmRMZmpQcUZ1dWFYcTBFb0laN3YzWHFvZlRyUlkvMnMxSW5Y?=
 =?utf-8?B?dGdzZXU2ck9iZU9jM0FsNEdyTGN4Y0FKQXZUQUFXRFAvQ2gxNU85SjZTNDdW?=
 =?utf-8?B?SnpZb3MxUUtUaHN0enVaQTYrUGJGNThTL0FGL1g4c24ybUFLaFN5Z013bXNr?=
 =?utf-8?B?ZlZ5Q2FCOThFQ1B5S1VRc0s5QUhqK2ZTbzhOdXdWdkRKN1c1c1pvMUgwWVdo?=
 =?utf-8?B?MFFha3RhK1lUQWxTb0lsb3IwdkpWdkYrOGEwTlR0cGlYT2FvYW9MU1Yxb2FF?=
 =?utf-8?B?aGJCMjFrOGtWWW9lbmN6YlM5dTltMHVualFURkhGOFNXTWswRDB1dmh3M25S?=
 =?utf-8?B?TmVvTzZNSjFBZlpxKytPZUhtTGpBanI1RGJRdnBlK2t6QkxHejk2MFl0Yi9y?=
 =?utf-8?B?MFU0RE9mTGM5QUl1L0srQ1BUU0lNdlNza2ZJWEs5TDBwT0FEWDJYMEFLK0Zw?=
 =?utf-8?B?SFRUSkZhM2Y2Mm5SWkxXcHFYYTdEdVRMWXFKT1ZjMkd4SS9qKy9PS1hDaU9i?=
 =?utf-8?B?MElyNjYxYUJIR2grM3RLNEpuS0FWamFJWGZLSGp4M3U3NFc0T3BZUkdtNmJm?=
 =?utf-8?B?ZklibE84OXArL0NaVkV4ZktLaVZ5Y09jNnE4ZXVIZFpyM2lTWU1DRDBGcVZ0?=
 =?utf-8?B?ZlhBMTFuWnRkc3hTbzVRU0xOZnNXK3hHQmg3RWJ5QXp1em01MTNlVFZvTk5o?=
 =?utf-8?B?RktTSmozZ3NTZm1WdG5nbFo3ZDJFaXBybEFrNk5SMkQwbGdlREJGNEQybVVR?=
 =?utf-8?B?clZmNUNIYXRWWkRraUpTUFl4cmZxcWZKcjVzczJPb1RTUkludUlBTzBuSUdn?=
 =?utf-8?B?T2dVZUlpNWEzcHkwbWlLNGU1bFZiZS91YmRaQ3oxWG5kdEZpVTQ2QnR0czlD?=
 =?utf-8?B?encyY0w2M1lOZFE2NCs5UGtrOElTS29ucFMwVGpLdDU3Z0VGWHlRWXhGSW45?=
 =?utf-8?B?WVJRYkdxWW5pZWtzc1RTWUFUcWx2MWJRQTZJL1BwTkJ2TXZnUnYyU0FQUzZE?=
 =?utf-8?B?N2Q3M1poZWgyZ3JIeEY4WndrdEpzK3ZCTkFHYjNiZDE0akdwSzJiT3dUcDhV?=
 =?utf-8?B?dkt4c0hPYzhkWTFDNit4N3crOU5CWDNwRHlQR0xqQ2ZvaE1kUHdhMmhGaDJm?=
 =?utf-8?B?aCtnL1RieXgzZ0paTnBNa3dzSXV5M0NrZStadit4NEJwc1JqejFyZHhDbDAv?=
 =?utf-8?B?SktSTXJVZWJ1dFFqd1ZHOGprOGZCbXhrYjkxOUJ2d2dOS29vMkh5NWdJWmhq?=
 =?utf-8?B?RFFzbU05UDdlVkNQaUU0N0tYZ1dDYTUybVlPbzB6QTdhNHlIU2pSa0hFeUdR?=
 =?utf-8?B?T0lWWE5Sbk50WWd1VkV1TmVYY3VMQlgrbTJEa2hITjVLTWFqSHJGZURiVC9P?=
 =?utf-8?B?Y0ZZR0h6Tk5DSVVYbzM3bWt6V1hSWTB2QXB5UXlCWEVZd2NJQUpQMHY2REdy?=
 =?utf-8?B?R1ZlR1hYRWxEVVpYMWZTZXFUVERiNmFPdndpNU80c1lmSThjcFhDVE1BNzVO?=
 =?utf-8?B?cGJPcXpabi9vM2JTSkl4OHRtYmhiOUFPZFJLNERReGE2aUlOMEQrZmZiTjZV?=
 =?utf-8?B?cjM1SVRQWDB0aVhVak5TTlh1WE9Qb3JINlVmb1dObFdGcWFaN0xON1RFbk14?=
 =?utf-8?B?MGlxdTdWSDN3RmRselkwcG03elpBU1lxTFhQTmVQQml2TnU0Y0tjMWI2YTJD?=
 =?utf-8?B?NTlFYlhOUHdyM0l4TGJ4M0hvV2Z3OE1rQ2JTeWdBTDFiVG9HdkxYRDg4aTU2?=
 =?utf-8?B?bkFUWHpIOTFUd3k1RjVYU1VQbkxwZDIxdEZBR1NrMTVndzlqeTBONW8rb1Zh?=
 =?utf-8?B?L3Y1dWF5L1I3RXAzMXFYUEVNMUJwWkNncjNiejkwMXd3UFZmR3ozemZ4eVFu?=
 =?utf-8?B?VTdoVU5NcjhqNG83RGQ0L3JBZm0yUkk0T3J2MWZVbmRUVWpHVldKdmRzZm80?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6934579a-ade9-475a-ea81-08db47588332
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:49:28.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ErRkT8ABYgCOpW6dg0wWKH6BAqAkhWpbzFiqIHJwgbDHgBD7RjWQzswb2DkB9E4/9NbocC7X8HwdsZuUmuyUgYsWYAIfLm19k14Ta3ZGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/2023 4:13 AM, Patrick Steinhardt wrote:
> index 0e45c27007..b9dcdade63 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -54,6 +54,31 @@ test_expect_success 'fetch compact output' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'fetch output with HEAD and --dry-run' '
> +	test_when_finished "rm -rf head" &&

The test name could drop the --dry-run mention since this now tests both
variants.


Everything else looks good on this patch. The new commit message is much
better to me now!
