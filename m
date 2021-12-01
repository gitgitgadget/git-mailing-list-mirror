Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B90C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbhLAJDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 04:03:05 -0500
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:16897
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348100AbhLAJCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 04:02:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZeZJ7pkuuXf1n7xYHwgymaka6p47++hWVWyrb97uV1YPhZn5FoLfpXUeI9oXYTlRYA9+iPpvUljAt3EN/6KvBWGkYejKZEecpJ97Fi9J/x0ptOgBis+s5HMmus4Gi5pC7dya5DUI1uTl9zgw4EqVf/t1q5gKI6pFsUgiU7ijcVf4aDklsDHAYc2aj21BepeR07+pTG75tRRb7y6JqTEQEL/0awApLTZdpqdpLWRNUs3EGuyUZlDgbz7avtlKA5oFcuc0SUgiPa/Z5DPudb+jzze0xFck5L5Hqg7PJjwvGVT1GqHDb9EsjaxzdPbZJv/fvksx3oaB+WdWxSLUggwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1+526fUtsGdkZCvq4H+r1/YaDvjzi7zAngAiNVzCyQ=;
 b=U7KSl72XvAw8KJE5SBqPp+DughaflQ68w2SDSC7bgfj/RaUlRFfQuEqQyUsksgxI1ldh6lcRKwLAS38gwA0SW8uNfgQfNGbz1z2hMGC0rO1KOQwaN5YWp3NOYAWXGrASrbvHO/RAYGWtBOPYJ62NoHEChfWVBXCgsVIn2cp5pkKT5VSp8N/CaEKa+0eTdLvaX8vuW8SZHzqJetptucs+Qiz62w+ibAKC75L5WlRduyCjYfGVa7KOMM/yNU8HvelBaPWJoc5EgcNkW5zlQ/8R2vAOjwB5J81KvG9WsS5ex5+W2NXOjG0jrfQnYNnpq0RKIft9hXBRyvSoYX3BQJEGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1+526fUtsGdkZCvq4H+r1/YaDvjzi7zAngAiNVzCyQ=;
 b=fw4fgPvBsiYf6bV7dSZtrpeoGEHSDa1c2g3+tJqf5JT74T+FAGEAvf8Ee3n70rdR75KvrBkmbIGlkHRL4+UyPP+pb1NEoiU3PV4Wd5Ud7qYMHwi2A2pYT/g5EWoSEQoW02nefgcano/tDf5NcrrjO/8cJGm/4/pYSzXOlOx0lrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 08:59:13 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:59:13 +0000
Date:   Wed, 1 Dec 2021 09:59:12 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
Message-ID: <20211201085912.gkwmlo5br73aft27@fs>
References: <xmqqzgpm2xrd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0100.eurprd04.prod.outlook.com (2603:10a6:20b:31e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 08:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8c6f24-e19f-4660-c99a-08d9b4a8d8c3
X-MS-TrafficTypeDiagnostic: PR3PR10MB3883:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3883275237C9BAF7BC7FA140B6689@PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfhnYMpBoS5QLbwHi167rdMMzxj45qxK8bhtWFqDusNkyu3sqFDFmYKCKbB0vkfXhfikCFfDSMVWvLP+2bkC4PkQJ2J9/oMZSYDTrlL2OT83sMEeR1YI47uG5jPDGfF5mvysFpwRgfUAy/KkHLl9/pO47ZOjWH+LalX2Hgy3+TzPp9FGk6hRCJE+HdVMsUVMfgWg99ZZwUsG/KkV5ITejWrn6hcXSd9AYUsjRf9uFL0go8xYqJ5xemtdJlsyAeeGZ99aVE2O1A8RoUYlOBXkgedJ6hrMB+jPxqv4dTDHUp3rXewrzlZcFlkLdghKS8MWqJaxbFQYIKmqLekH6YmqbYxLtXVmW49Bg1NwLgPwSTG64H/pCGYMZ4SS74dD8dHdArS2v3OOMCx5qkqIUrvO71v3VweQyjOM57hfLzl1uUJhXWfVEgtnjk7ggoOGBQAAe0wkUWUiZlQSraBVHpy5Zh1cfpDNRfS26BPEtEnEhyZKr9Q3gBhKMnPIeADndhvIefDNgY/QZSZ5DU4BtHcO/hLKDT3K2H7eRwMyyuvSI9JxcLE0+wVN/mSEp8n11GTbk0/qJicoRbH8x8A/xA0Oa13G8j1Hk9MngrpqLsUqyca8bJO/1gEeHK5rU9mvbuCFbz6ql3LPCoKlnDLpLeeAZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(396003)(39840400004)(136003)(346002)(376002)(2906002)(6916009)(508600001)(4001150100001)(66476007)(66556008)(5660300002)(4326008)(316002)(186003)(66946007)(1076003)(38100700002)(83380400001)(8936002)(6486002)(86362001)(33716001)(6496006)(9686003)(8676002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVYQS9pU1RKeTJ3T3BjelhRZUJiOUdIMjV3Yk5uNVdhdlZrWnJvUU5DTTk0?=
 =?utf-8?B?WlNvWjZNYTlVdU1Kd1QzcU4rNzRMdU1KM0dVK2l1Njc2ellLNXBzRjJDYmxZ?=
 =?utf-8?B?SmZPYnBGZzZ4M2dyV0ZxSklnRkpYM0xWR3ZQTVZqaXR2WHpFMEVVblFnMmpM?=
 =?utf-8?B?QnIxbEpwaXdtdVJseDZ1cHFHQW5KNXZLMnloQlB1TTFIczhLOTFBYzdpNURk?=
 =?utf-8?B?YVBOSlpaWmtxVGVJRXBqamFReTJvcWJOREhtcmJCVjZ5RFVWSUNnT29MYWo2?=
 =?utf-8?B?L0cvbllFU21kc3M0OTdObUJKQVUrZ29LS0dKaU5YazJRR0FRQVdZWURxVktz?=
 =?utf-8?B?MmNlNVZZVDZsZGpJNnkzSit5Yi9NZ2FxRWlEMGxyS0tRbXZGUnhxbzRYQXFK?=
 =?utf-8?B?MGtaQmhpdk13WXc2dnpic3AyMmdUTmpQVEZWdjBaQ2ZnZ1hsUTF2R1Fuc0hs?=
 =?utf-8?B?ZTN0bU9yQnluQitNeXFjL21PdTRwdnFKM2VuMGpqQUZmMmEwUlkzMFMyWG43?=
 =?utf-8?B?WDdybzBmZXRUeXZJNklURnJPdnJWckNrRm03YnZEd0lmcjV2NS9VYzF3L1hL?=
 =?utf-8?B?QmVjOTlLOHB4eGR1a2NEQUROYWc1MUlzL1Zmc3k0cm1YazhOK1lDdkZHUFlh?=
 =?utf-8?B?TTdKZkNabFZLZFM1VlM2M1pHVW1ISmtHcDJ4a0FCYlF0YzhCYVRnTGFjTXph?=
 =?utf-8?B?LzNvOWx4Zkw0OGZwbXRyWVI0MHh0cXRON0J3cFh1bWE1Y01Cc2ZtNHBBeHJ3?=
 =?utf-8?B?RE1zM0pmVldBU1RIN0t5M0RJVHdQdVM5YzhWeW5ZUW5TL1FIQmhHS1FTQ3Ix?=
 =?utf-8?B?bUZHZG9EeXpIcnZFcTVvek54Q1Z2RUJZakJ0L3NoK0hyQlNabGVERk1CNTJB?=
 =?utf-8?B?ckNrVndiL0NuTkR3c1MxcERrQ05BeEI2Z2U3dkczRHVta1piVmtKbHV3UHJC?=
 =?utf-8?B?NytNUC9PK1hrV0Z5WEdSQ3NRY3BNRkE5MU1pcUZPV1ZpRGhYd0VGV0ZsRDgz?=
 =?utf-8?B?K0lrVlJ6RlhOSUs3alg3RnFvc3BCenlHY3ZvZTZBdnM1R0NmcWVESG5mUlg2?=
 =?utf-8?B?LzIyZUdjbjl5UnRYaDVjRFFuSzErMFNCdkdoVmxOOHJ4eU5EeUdRaFp2Rm9j?=
 =?utf-8?B?bmZ0eTNPdXBWU3V4d1Zha1hJdlFsbzJVZHYwS21IZ2FWeE83SVIzQWF5d1dT?=
 =?utf-8?B?dmlzQkpyNmJUZGtFVVlEbmRPVWx4YiswVkhyZjZHanRmTDl3WFFtRzErTm9s?=
 =?utf-8?B?WUN0YU83Zy9uZWpydjhKa2RUYWUwbWRlWFFCYlUxSE84SEhnaDZPUzVRT2Z0?=
 =?utf-8?B?OWc5OUI3OVc4RERYSFdWM1FWblZ4YXJrWmxYZHFIZzJJUmIxazFPaXpRMGwx?=
 =?utf-8?B?Z3F0a3I0aHRKUE9lNmo1SHN6VkV0aGxoSUhHeTlZbHZyRjEwOUVxZXNyZEFm?=
 =?utf-8?B?WG1rSVM3MFY2ZWFnOVRVMStsY1NLdjhQdXZoQWYzL3lBRzlTc01sUU5BVG5Q?=
 =?utf-8?B?a3VoNkdTR0hEYTV2bm5xbW5WMzFWaEc2TFFWVThVZ01PVEdoa0NpcWt5dHNR?=
 =?utf-8?B?V3FzeVlVcUliWEVZVW1iMGVCSXBadW11Z3YrY05XaVcrdVVtSDlvcUszWU5p?=
 =?utf-8?B?VTYvQWpMdWdpUjFndnBieGhSWGgyRHJCNUtGOFB6VzhrZGN1K1dHR0txN1lE?=
 =?utf-8?B?MzdrbDVsa2k5OU5TVlBReDBNcVRtdTMrR0JhcHd2MjlwZmtzN0RuU1J0VU45?=
 =?utf-8?B?dkRnNTEvSGtlK0IyL2xRSXpqY2d1QTlhTWNVMk8yTlJVbmdsRUxLUWtOd2pC?=
 =?utf-8?B?Z0g3cFNSMDliYXdaMG9HRStGSERyeWdLSmxSdEl0Q1lod0doWXNBbDVrZjN3?=
 =?utf-8?B?RWE2UTBvdnE2d3YxRUdKTnpyVUtmS2hDMG5Jd1AvdXEyQk1MVmp2Q3VuSy9L?=
 =?utf-8?B?TjVhWStmVTdBdm1ObjdXWG1TRDMrSUVIZFhBMUYvSU1zUGl6eW90YUpqUWJp?=
 =?utf-8?B?aFU2QlhWVGd0Y2ExY2FzeEowb09YaGNVNXdLY291YURvSjc1UVczOE5tZzZF?=
 =?utf-8?B?R0dtTkVISFZvaFBSYWtmdWNoOU5mVTUyQndZMS9rYlJMSk01OHFtc3NnSEtk?=
 =?utf-8?B?ZmlITFJqUTZSMEhMQ0xEa1k5dTZia0hYSStOUDgySXhUK0o5Uk9lZTM4ZGd4?=
 =?utf-8?B?ZDFRNWpFSlhBRFBjWThxandKYWtINDB0STdSNDU4WU9HaFpKZkF0MVRqZXQ2?=
 =?utf-8?B?eXBxcnNEczdQUlVGNE1QMEdEdkdRanlYV21OT3g0RHU5bWpTVFVBdEdkbE53?=
 =?utf-8?B?dU80OEZ3SjA1UXhEbHVNSmxRTnlrcnQ0Um0wK08vb2tLRUJrNnR1bnIwcS9E?=
 =?utf-8?Q?InnqhX9AKszqgF3I=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8c6f24-e19f-4660-c99a-08d9b4a8d8c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:59:13.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOswR47bbKCuN+/CUyw4GeFlYjw/mbX5+nqxkS/XmWkyprItYynIyESPkFQ1RavlxjGesYjjVADe9wWNOgZEV1kALVO7YfIyM8Pk/fqPrPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3883
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.11.2021 18:16, Junio C Hamano wrote:
>
> * fs/ssh-signing-other-keytypes (2021-11-19) 2 commits
> - ssh signing: make sign/amend test more resilient
> - ssh signing: support non ssh-* keytypes
>

I will send a rebased version of this one on top of
fs/ssh-signing-key-lifetime. Otherwise those two will result in a
(simple) merge conflict in the test prereqs.

>
> * fs/ssh-signing-key-lifetime (2021-11-18) 10 commits
> - ssh signing: verify ssh-keygen in test prereq
> - ssh signing: make fmt-merge-msg consider key lifetime
> - ssh signing: make verify-tag consider key lifetime
> - ssh signing: make git log verify key lifetime
> - ssh signing: make verify-commit consider key lifetime
> - ssh signing: add key lifetime test prereqs
> - ssh signing: use sigc struct to pass payload
> - Merge branch 'ad/ssh-signing-testfix' into fs/ssh-signing-key-lifetime
> - Merge branch 'fs/ssh-signing-fix' into fs/ssh-signing-key-lifetime
> - Merge branch 'fs/ssh-signing' into fs/ssh-signing-key-lifetime
>
> Extend the signing of objects with SSH keys and learn to pay
> attention to the key validity time range when verifying.
>
> Will merge to 'next'?
>

I just resubmitted a new version which cleans up the prereq setup.

Thanks
