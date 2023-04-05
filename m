Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A1C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjDESIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjDESIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 14:08:47 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806672AE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1680718112;
  h=message-id:date:to:from:subject:
   content-transfer-encoding:mime-version;
  bh=n6qAsmYsymcYMhj/TK2xziAgpYUGneoVVjyP7HwxJPg=;
  b=iSkNG5LBbf8ATzplWTenWbQUcJO9qUX9RtMeMEKcoQEfuSJ6OsB5ZS6R
   5b7WnQsx7EgfSIArHKQ5QTdORPTJCDmkCS8d6QGdhP/kmuCuR5IKFQhXl
   FmogOg+8unk1AWa79a0u8BHPzvF9hbDJ9asbbW+a6fJuC1rohQwwT3g2T
   E=;
X-IronPort-RemoteIP: 104.47.58.108
X-IronPort-MID: 103250027
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gFsMDqiD37Q5rqQlXpaTJyPzX161GxEKZh0ujC45NGQN5FlHY01je
 htvXGqBOfjeZWL2Ltgjb4WwoR8GusKDzN81HgJlriFmFH8b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWi0N8klgZmP6sT4AeDzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQlDT0WQh6dvtm574ueUrI3h9gOHs7SadZ3VnFIlVk1DN4AaLWaG+DmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEhluG1YLI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6TeXjrKMy2AfMroAVIC8XCXu2j6C+tm6zWMpPE
 28+1CYrlLdnoSRHSfG4BXVUukWssR8Ac8RfHvd86wyXzKfQpQGDCQA5oiVpbdUnsIo6QGIs3
 1rQx9fxX2U34PuSVG6X8aqSoXWqIy8JIGQeZCgCCwwY/93kp4J1hRXKJjp+LJOIYhTOMWmY6
 1i3QOIW3d3/UeZjO32HwG36
IronPort-HdrOrdr: A9a23:qOte26kWFhEZ0wUKH4BksQQ5p3bpDfLW3DAbv31ZSRFFG/Fw9/
 rCoB3U73/JYVcqKRUdcLW7UpVoLkmyyXcY2+cs1NSZLWzbUQmTXeJfBOLZqlWNJ8SXzIVgPM
 xbAspD4bPLbGSTjazBkXSF+9RL+qj6zEh/792usEuETmtRGt9dBx8SMHf9LqXvLjM2fqbQEv
 Cnl6x6jgvlQ1s7ROKhCEIIWuDSzue77q4PMXY9dmcaABDlt0LR1ILH
X-IronPort-AV: E=Sophos;i="5.98,321,1673931600"; 
   d="scan'208";a="103250027"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2023 14:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfu2B1YUQx0S0rAyxc7MjC+qaoQ9RQxq+vXNHPRwCjU91oEMejZ9UGkFIDF0/x+dqzJwGe/GpVzkRjWXxo4pmnnw6duauAVA1I2ZzL6WYDRFNlCjrt33QGb49IWZqTkBTBAcvCZo6x3B20EbKUZ7WHwhRfJfHLcAbZ9O4sfBQSgqQhHVnivEQoUeYlxVBKkqU22MwdEYXVunf3TVZr4u8EI4oQmnuDrx8fmlUcbrSBBfc+BdAKrE5ThmWGbYmjNl4V+RB52JEe5koCxC6O51iAiNCcvn2L+fuJ0LpIU9oph1N6/fAtwJVLwBJgVG4ZSDQKNgn1oYE5UD5EIm+l9teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6qAsmYsymcYMhj/TK2xziAgpYUGneoVVjyP7HwxJPg=;
 b=VVBQCPObd+mWjtZiOVDWvsG/NVL0alpRroC2tKbI+3rlbaWhetR2P2wbY8m7XgMgibThxppWNhaRnDbiop9Cf6sQB74KihI6+O/tECDI7OmkrB+nycBcV1j4FFlxaLNCdWh6dmu1Ykd3ySS24Z59pS6zovAnh2eovJ9UJFFWOxHUCH6bbjyH+pJbu3di5izsntpPM0jEWri99MYddjyyWucRDH5dwHqUiYw1E3cKm/c/8MWU3FOur6s5LYOz75o08+J3DSFRG0xpzQaJP5HGPVTnOWOUeo1KQATyZWS95+GOB3N3dpxF7Npwr/G1URjedBl1fMYap3gkpbP7PpSsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6qAsmYsymcYMhj/TK2xziAgpYUGneoVVjyP7HwxJPg=;
 b=iaDF+l216HJ685liaqQX7JqtUb0JDZSbOen2MwFP67guLFW9qfhMUpenbsUC/Urk0N2oVI5fbti62IJU5H+hItfSvhJO+DsHMVAipzUWNQsiQiYtu/1ea8/vWpeFrsv+e6VtQ5poEDn1Q8bJEgsLrIVlHr791femfnz/h4gbd9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BN9PR03MB6122.namprd03.prod.outlook.com (2603:10b6:408:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:08:01 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:08:01 +0000
Message-ID: <b3c06daf-c059-5dea-7ddd-91149c9828ed@citrix.com>
Date:   Wed, 5 Apr 2023 19:07:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To:     git@vger.kernel.org
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Decoration of "other" refs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BN9PR03MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 308db1f7-65fb-47d1-16bc-08db3600b14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jaS3L2O6DOMAXmUinZcN/xl59FsfcJ3z1sKNh2UDxpw2yuZhCSTnnKfTLxkSLygfplOyFPQn+qG3IAzx/7Nng7HA9O0CEu6tGwxkKdqu1v/y57YteJL5RmW5SeGv4XMgQeyEAFZM8gmffGE+GllfvUsM0u+GKjJXVUX17DQ9ZTa1scHof3oA9WS5/7SvseUDBNgN5sSXQkaAvdNH/3hcf81zrRO8YnG3dzLJvS/U4YDBbXcVjwI6maH9IRNKi3+HmaYJMAi3MTGW9HXwos3hROTRMbRXVXocjDjzaSDjt+nE3md9onEXKlYupD2bbv8Ne0nxx4G/rJbR8DJsDbtNghiVnVAZimYKaU4jHmwc6TxI1OQOeYIb5h5wmnwYdYaWgx/9eUuH3CPATn6eyhfjwLPSM8GkuUZL5560U24XfJ/UAHnYm0+hKVz9A74SvaxwyeRMk/jsjKiduc0xzcT5FpkyZFynzKWf1IrziG2sgCqEIXkNgyfR7HVnw5DfHbH2l8G79yqpLXqvFG2NlHw/i4qJ7+v9cFk+niYkBOQiOj8wta/HVG/1GPrHyTEAl50+PF8ZMhdTw66Ntnf8x0UI7B4G6KBCGjxCmjEO5M1WuVaEDjd2lOMN9Jc+vR4/JoW4k4uBaDbEINJR7unpzmiWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(36756003)(2616005)(38100700002)(86362001)(31696002)(82960400001)(26005)(6506007)(6512007)(186003)(316002)(2906002)(31686004)(66556008)(8676002)(6916009)(66946007)(66476007)(4744005)(8936002)(5660300002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFQWHF1V2JRN3dBbUNrY0ZjL1F4cUMrZHQrdjgza1R2T29KbzRLQnRxMW95?=
 =?utf-8?B?dUc3OFJmTVRRZ0x4dmZQcEtJMWpxTVQrMjkvNXgrZmtBSStzczVnNHI4ZGdL?=
 =?utf-8?B?eWVBOEtMUm1mUmoycHJPRHVYcE15VWhrNngxcjM0MVQzYy9rVjdEcW1pWm9i?=
 =?utf-8?B?NmVpaUJRSGU1Yk9NZDhxUjBhSVF3OWk5TkFEMktBOEZWRzhrT2xleFhCRU5v?=
 =?utf-8?B?VDQ2QmFlVVRoVjNGQjNMTThxU3VLWTRxRHBFVUhLU25YbEhqNlA1Qmdkalls?=
 =?utf-8?B?Q1JsN3NnQkJ6S3RabjUyQlpSWlNzTUhnRlFFbjNlYVNYOXd2VXNuSkJycWdi?=
 =?utf-8?B?NFBOZVNNQWRPcEpnNFE0Q2poRzBmVWhkSmZteFBwYVRjWWJpaFZnRHloak5u?=
 =?utf-8?B?Zzg3TnpMMER2UTJLeERQV0RvQTQwN2FGYU1nNmVxNG5CT29hSUNpZ1ZFZ3Fn?=
 =?utf-8?B?L3NpZVVxOHAxL1pURWZGQ29xbjY3QXpJWDFURm5zdkQxOU1UUTkzQ05waWFG?=
 =?utf-8?B?eVAzeTVHdk9VcDVWeERnQU5mcDJrM3p2NTF6NzBXclo4Y0tnOWpXL2Z3ZzZy?=
 =?utf-8?B?N2V4ZHZNT0FEL1Q2ekcvOFFzeG9RSVJBZk5EancwRmxNU2FsZ283c2ViMGtF?=
 =?utf-8?B?UU02Z3g4ZlI0b0lCRHFEbVQ3K2xQcGdoOTg2S25NNGxzaWQ3b1hScllQaE55?=
 =?utf-8?B?VUNtMGIreDdIS3BiUGlzdFA3R0RvL0RCTUF6eVFKWkpuSHg0cVlmTk1CZHQz?=
 =?utf-8?B?VjAwaytRNUNMd1l1Rm9hK0ZPSnhIa3MxeUs0ZFBJQzduOGRISlEyMmhUUFNm?=
 =?utf-8?B?Zld6aWYyejV4TmdvditFaUxaMTN4bGxReCtsWmdFaEY5TmN2Q0l5NjFUU1hU?=
 =?utf-8?B?Z0hEcWQ0Y05MNkpZU1lqdFlrT01IeSsxUlhjZFI5eU1neW1vN0RycVVzdGRS?=
 =?utf-8?B?VkJITG11a2hjaGFOdUxoZXFPM2ZTUjZlNzVWV1F3Q2FaU2JzNVQxOWZ5TzhS?=
 =?utf-8?B?TlkydlR2YnZ2K1lreTBTd2tZa0lPS2xVamQ2MHk1dDliMFp3aVc2YWQzMUlu?=
 =?utf-8?B?eitjR2EwVldCZEQzcHQ2RzZ1eWNVTEFRVWhUdm1iWDJvcEVSNHhZWEdjbGM5?=
 =?utf-8?B?UDExTnpkMnZETUxucUZEWkRTUGM3NGpkMXVPWUd3QlZPT0FFTktNSER3czRw?=
 =?utf-8?B?azZFQzViYmc4M1ErVFgyRVhVa0dxSGIxdUgyNlhLcVNMMlNDRmZNbXlUZDJr?=
 =?utf-8?B?amZaNGRmUTl5VUROL0hiOFY5Z3VRalo3N0NnTjFkYUtXZjcvY3ZtUWdkOHE2?=
 =?utf-8?B?ZGYzQXRhSTI4OGhNVUx1MklNQ1NNc3kwTVo5SVIrYXhpUTRhMXRTYWhTUjg0?=
 =?utf-8?B?Q1VOQ2pOUEJmSFpEMGxoeEI3QnkzeFpMbzloaVgxbm1HZEJIR2w1bE9tUita?=
 =?utf-8?B?b0FPeGNNZDlqd0xFM0hGcHJPYloxdXBiYmRjby9CMTdjK2w0ejhDaG9HM0x0?=
 =?utf-8?B?dEw5ZGtROGc0cGZqVHNzRFRnYXFQVEZwK05xT29NNmpJQWtwbWNrUXJvaWJp?=
 =?utf-8?B?Sm1BOXUxSnMxWWVDc2RRMUNBaDF1eG9nNTVGVUF0amZWZ0t0N3FVUHk1NzBT?=
 =?utf-8?B?WDZ5M2puRXVoQldOdkd5M2dhMVVzeW0yTlhvRnVDTm44MDBlblNYWXhXTTkv?=
 =?utf-8?B?WDlnNk9xTWdicGRJc2VKdjR6dzgraHBlcWJvSkZ5LytvbmcwQVdIN1U5T295?=
 =?utf-8?B?M0hjUXVSVUl4MmJBaFRDNDBPS3FMNUtXZ1JYaE84dDBjaFRtdmxlU1BoRXF2?=
 =?utf-8?B?S0pJS29tYmp0SEJnTHd4ZCtDRlFIdU9qeHMzR3FPdFk0bm9HOC9Na0hrb3Jl?=
 =?utf-8?B?NXI4SjlQR3pxYnJBY0dVOFdxdHpkcFpyN2x1YTVKOFhwUlV0bXBVK0x5UGJh?=
 =?utf-8?B?TitKTjlqRmRaK2cvR0VEem1ibHBVL2FGQmFIaUxQV0ZZYnpaT0MwYU1NZWNL?=
 =?utf-8?B?eFRFSG1iMjZOUG5LOWlIUUMyd0pvUjhDMy9WNk9meHJvK1luR3BlY2J5Nmtn?=
 =?utf-8?B?VVl3eXROTlFlR1JVMjhDNkE2L2dSMVdacEFOVTU5aG15Wi9FNG94QTYvWmFo?=
 =?utf-8?B?VGIxTGZIZGpUS2lmdmhkZ0hBRUNxai9aVHIyOUpnYjMrRDFzOFg4QTdkZllw?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BMSIlS3TX4jdwgdsMzG0z8i73KxJy3/wZs8954Derb951suxc0VU33plm+AL4vdnoWTGUOl/tmBxSElU6N0sn8e+T0YuzjdlB+0VMwFz/lsqrqiK/cC3uI55XMb8M/oLwZ95H3TzCfaZOPyS7vKxWvPUDzg+TtRN+SjWLdoakG6L2z4YAziWjLQ3jtUa5wWhmULxn5+rW+g1k6007r08xZ/00vMoTdxzMFVdyEqmVVKSCWKgWof2pP6guHTRNxleYmP/wEBut0AkJ+QDXPJr1V/KS663YC89RnxaLCjZCSkE8LpVGi9W/eSyCAkJcyvoDhn1a1Q962obfFAwPht1F4u+khrH8/0f6fEvsb5CfmBT1zZSDkBAkryhLfDttT4/RvY9et3i4j+hFev/kjqSKufuWv2rR/A6zoUrbl0GEQveZEC9/Z934mrvgLmmYq2OYV8VM6ucdHfI6jbIzVZc3DOL5jhAXZiecTggZqJiKtmjeqBovU1eh/l5qgapKJoG33juOGrzcUb7h2LFM495W0pMQ2KBrgvYwnS+fCRkGcSPAANa2E2qJI2jNy95xfm4mUXJybsenqTmoJk2R4yovyDfamMbPIkTmE7bXVyRsFGwbGhcp/9+dz2a0ql6H8HR7uaeXKzdE3bGIPZ9qm5Aw+N2RsTy5LqRGU1M0CQIKFsBC5xlloNCHfgOjZ9u0o4+c69HG4vqVmJPAlZ/INqDW0K5RQsUz6le2sVryM5cfs7hixyGzzfOqsbD0Z6k/eGVd9o8Nzhs+LrZcevvo8sKQA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308db1f7-65fb-47d1-16bc-08db3600b14b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 18:08:00.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNXkWm5hwW3rFWGncRwj7JupZjUHYjV6t9kBOyBtRbR8HJlIkpbNJ1QQvQItAtUy5XWAG1Nux1OJHFHp97k5bLgI2/J7tNAYuYLSPZPuCEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6122
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have been trying to adjust the colours of log decoration, and I think
there's a gap in configurability.

guilt creates refs/patches/$branch/$file.name for each applied patch,
and there appears to be no way to colourise these.

Looking at the source, it appears that in ref_namespace[], the
configuration for the NOTES, PREFETCH and REWRITTEN namespaces also
don't specify a .decoration attribute, so will pick up a value of
DECORATION_NONE.

It's probably not feasible to have configuration for arbitrary refs, but
couldn't DECORATION_NONE turn into DECORATION_OTHER instead, and have an
option which could be customised to something other than white?

Thanks,

~Andrew
