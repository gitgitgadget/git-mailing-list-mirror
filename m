Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbhLJQq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 11:46:27 -0500
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:42601
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231180AbhLJQq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 11:46:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH4ceMXwvYKzKD/+inBVxz256u8q93pn52XZbR3oXn6nVucVuiUeh/i02dpAvX7UAPrZ/1bedpo9fYrRm+leZvNY7EmRDmwpyTZ7ZUMZFE3VeWTOCUYftlgNXNP+LTtd9/eLYSeUlwBHLdrmzEWhi7GLGrK2e5WQdktzoicLggCpHqRp7i6eo9bBgDkR0zDhBdiy/vpByDmUNbaSWB2JoFtsgRyCxA6s21fV0kYQz6DM+ck8EsXLw1AspyEWcBbap16uON6XbYG7EqLHLpDGPWQr8b1mq38HBtA9iDIhnfJ/9pKWhRWyF9GIV81pyPoRl0rVKr9vskaLoVR8Q00zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEVTSPD/3iR/uMciG+u7631fnk/8ert+uS4QuoNkaD4=;
 b=cFRo004nyeH9r9FAiGRYXPpI2rWx0C8pFkrX0yJYJQwA2dB1JYqBmqQgHZUiALXcmhLsVfqQwECU37N+sPDgOJxEzqY2O51Ncp03OlyDYJ6VGzpRf7n7nOeq0bNVoPVsTAw4ZS7DZKHq26VOnBYWJQjyv1aCTL6UnBFa2TOEmp5suVzioq3PIQmJqAUok9p8L+a56ArgjF6H6iTI+RzD2wt4+QqkFJWhSgOes9oc2AK+2NUiyocmToUOpnJhXVSEG+mi6aixJ1qkAwP6Ic9Mf9bgffR3ta9bI3WFpGmTHhO5uRaqdVJ6QP93N5Y+17APzVxPcfKOuAkB9ldWaFW/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEVTSPD/3iR/uMciG+u7631fnk/8ert+uS4QuoNkaD4=;
 b=jPtDIyXU3iW1EWjHbYvg+l9MIle7yiT6Zx3uuAcfbBrN1JWKZXJL5JyYe7P5d0p8+ilVEbG+lxGcTeYNvv8EwZ+XDvY7kxQyCxQoq+gR9RCtgynOoLwsCmH+EERgWzgJ+uIqoBb5qhFifNCwOcSp+Ss2M50VvQdfjIfecbQrlYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 16:42:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 10 Dec 2021
 16:42:50 +0000
Date:   Fri, 10 Dec 2021 17:42:49 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jose Wielandt <jose.wielandt@timining.com>,
        git <git@vger.kernel.org>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
Message-ID: <20211210164249.bahhe5ogjjhz4lxo@fs>
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
 <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AM6PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 16:42:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebf31376-4414-4c77-60da-08d9bbfc1a4e
X-MS-TrafficTypeDiagnostic: PR3PR10MB3755:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB375584E1FD1D82DEE30CDA96B6719@PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4mhDs3/LLSkbWHiER7X+mfQU0OkxmZQNQYF3O2KyQv+sL1quWFPVMNhqr+hW6HIjO7QxZy5yabPStalGnF/Cbn7eK7DOivzqeaEKl0Y3WJR9zWNvQIvsB3b6ZGuCHR7W7maiaaJf/sWVVFDhd+CDC6lxYKyo5+Vnj4ml2QjgmDC0zhx1NoLZYWqYlCF3t+9zWOdI3YuvXi8hcrklCrMeha/sNPhWn1Gh+OX7jdPMn7DJILCsugxacEzIGwPj8ntaEvaW9SbmOkFOo0CFwEteIFdR3+OKBP9DBpqA0JJCTNxPrIlf+Bzdd9bHn/msMEAMY8g2mSx4M6XMHMckP+GRR0xnJ9zdp+9GN3kCgV55bOlx31Tk8DQsFXZdmAnzbqKsoTHjiK5rwRCvqRTUOVfblB1qo+gqrjgOtF1yqyyCKmUcI2XKz9ZlSgWUX42xM1yK1vgMQf2OlgMuxYtMT1C/quOki4YhQQrrWzbFxAtZR0lQJVWsn+SIpfsA7yiaEGmGAwdoeC1siOZKDAZsXh4uoQ0CLaPy2T02xQMy8GJIe8vnRZ/t0qZt4t7ccjObSMC5sBUVkoDOUCpU6oW7Q0h3Z/iZxYZZE/susNACpNXi4NFxAVdiQwsaOQuxwIE9sblNTiyX25H+CWM6jLUVuFj/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(376002)(366004)(39840400004)(346002)(136003)(38100700002)(33716001)(5660300002)(2906002)(83380400001)(316002)(508600001)(8936002)(66946007)(9686003)(6916009)(6486002)(186003)(8676002)(86362001)(53546011)(6496006)(66556008)(66476007)(54906003)(66574015)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpDUXUrVVZqbGJreE9nT2NEK3RTUExjRlhybzJyYncxaFNZWjBsTzJaVlBw?=
 =?utf-8?B?UHNpZGNGeCtrWXpDSGU4YjR6czNPUjV5aURrdk1RUSt6cmc3NFlveTJYd3ht?=
 =?utf-8?B?NkEzL3VjUmNNKzNoT0M3dEVvN0xwaDVjMjNjNUt1UStYc25jdlkwZmk3MTNO?=
 =?utf-8?B?QnRxMi9BRG4xZ1VtQllMSjZpTU1haXJUTXlVbTRYeER5SjB1VW9pdjBxRXpL?=
 =?utf-8?B?Zm52bnIyelFJQ241bUJCOEpvZlEwK1h1L0Zya0lpcTNuUHRzaXZQcWFlT01U?=
 =?utf-8?B?VEFZUlExZE8xakpSTE9LTlpON1JzbmEwR3REblk4RURoKzJ0Y0RRVXhhYUFG?=
 =?utf-8?B?VDY2RHNDNzdaNUhOTU1hTG4wN1FVZ0ltclk3dGtPVDdFM1JqTmswVzFhSXZw?=
 =?utf-8?B?QzB4WWxGU0E1MThEWVYzbVJ2OGhZWDMwTWhDOTlRcjdjME9ndGZuT3J4SGVV?=
 =?utf-8?B?djJqWmM0SkkrOXdYSmtwQ2c3aU9XV3gzcG5aVkp3M0FjRkhvU0JreXZ6NXh2?=
 =?utf-8?B?cWFRNTRFR2tEVERET2dRR0FqL1VsRGFIbVJ6cHRQU0UxNWhUQTVCZk1IQVBP?=
 =?utf-8?B?cUhYRmdZbjFEZlBNNlJKQ1BRN2QvYm9rMVQ0aUZpUzVEYnpGU2F6SlZaQmhC?=
 =?utf-8?B?LzkzbHV3d3FyZEViRGxTa3h1V1d4NFVLZmcyUGFMd0Z4YTBNUUFjb1ArYjY5?=
 =?utf-8?B?STNEMUVqVFYyQkh3WEgrR1g0SmwxU0VBck5nTGpNYzhpaEFleEwxMFRweTlw?=
 =?utf-8?B?QjVHdFJZb3plMUNhV2YwZ1FZV0liSTZtQ1hjc0x2Z3RNU0lsK3FheTF0dVVi?=
 =?utf-8?B?U1hKZW9DbGtUUzEzako4ckIxbG5BbEFkVTMwNnUyT0NIR3NNOWNoNngzNW91?=
 =?utf-8?B?QkM3c3krcTRIUkNmWW05OTUxOHY1UjJ2YVpzcnU3U1FicytYZ0RFZEI0U3J4?=
 =?utf-8?B?bUVPOGdiN1lTUmFWbENGbkpOVTlzWDhGTWY4WjhURXhOT05reHpOMVJXb3hD?=
 =?utf-8?B?dDg2TnlBSmpQVy81RVNoQ3MyYnMzVVNIU0JLbVpScmZ5Zm00T2p5QmlqelUz?=
 =?utf-8?B?d0JKWlhhcXFkTXZSd01LaldaT3RYMTFONEJ2YmRmNEdjSHVrOFJMK0FTZ3dl?=
 =?utf-8?B?UXhqZnFNcDFFNHFEZTJnb1hMTVV2ZkRCQUc2NFJzeU5HNkxFS1U0Y3lIVlBV?=
 =?utf-8?B?a2VvK0pBb2RyaC95M3BDZ2llbnhrbGFJVlc2N01LaGFUUmQzY00yM3BCSzgx?=
 =?utf-8?B?Y2hkV1NQQk8zU1ZhS3BwRWJNZkZEZkM0UlZrZ0ppc1duK2VBL3d1SG8wQm8w?=
 =?utf-8?B?aTVBRzlLeUVDOCt2Qk5VWjlsNjdSQnZ3eFNYZlJ2SHBCcTV2VzgrazRMSlhn?=
 =?utf-8?B?Z0dobEk3ZUZ0RWFCd2c5ODVwVWV1ZS9mRHhpUjAvRTF2RmlSdHBxMGo5N0ZT?=
 =?utf-8?B?bEZ6ejdwRHFMbm40V2c1YVFDcFV6MHI2UUJoSXQveXBvNnJtb3k5MDY2SDhv?=
 =?utf-8?B?ZU1SbFVSa0E0dEI4YVRHZ0k0UktranJzRTEzcnptSTFUYUJ1QWZmb09UaE5J?=
 =?utf-8?B?OGxxMVNBOWhVbWZmNTJoc3RSNzlDMnJjL2Rra0NuelQvTUhWWXJIeG5sVExB?=
 =?utf-8?B?S05RT05LalZGNit5ZHRXOHE4RG44bmFLeGRBVnpxb1JrMWJ3QXVWTXFwREVC?=
 =?utf-8?B?S0FRa3FIalhBMmVVUk8vV01qWUx0eHdoV2hSY1Y0VjR4TUU3OEZMTjVDRFYv?=
 =?utf-8?B?S1JsN1RORjNCcTFqY1BhMUE3S1B6bGFDeU1yRDBIVlFHTC9pRFhUeVRQcTVK?=
 =?utf-8?B?cGZBUVJ3UktRSE5MbVc1UThHaStDdm84L2xQWlc1RjBQczFzSHlISW5VUVNt?=
 =?utf-8?B?OHB2dnBvQkptYVQ1SHhITnhDTXYyem5Remp5KzhoRlF1ZVpoOHBJY1EyNlZ2?=
 =?utf-8?B?MWlZc05tQ2J0bWRhNmZHSEtsc0xUcVM1R3V6VmpRVE9wMFVOWWxCajBmVjRS?=
 =?utf-8?B?d0NuOVdURi9QQ0tvcTRsQzByRklDS3RJRUdnWk1HTmdDam9XTmZnVlluRG8v?=
 =?utf-8?B?QjZPRDZzVDZJNWNkRDl1aTltUmF5TUsvVkdNWGVseEpwVzd2OVFOK0tnWkdY?=
 =?utf-8?B?cWc0dFpMVVc4TUtwY1BtRjF6V0dXenQwNTR3c1ZyaUUrY2lkTFUyMTRENm5P?=
 =?utf-8?B?enVvakthZjJncFJrUDUrMDJ2L2hHOTNMOStFZGhqMGMvamlLRHkzeUt4OTBi?=
 =?utf-8?B?aXpRWDh5UERSSzBITjN3dnNib3VKQ3ZtMEdjYVcyb1BvUUxUY3NTb3FQTVdE?=
 =?utf-8?B?c2FqYXIyNUdNaTFCSkoxSGxDaTg4R0hpS1NESXQwZ1ZrblBTOTRVZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf31376-4414-4c77-60da-08d9bbfc1a4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:42:49.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ/PKpsdZQq/VFTEFhRw4OlC52F/hV82zm2zerzqAJXXlkK5LjPr0DLJzhBoAHe4TxjOnaWQ7IK0mJGMjCqW5PQjMtWO5rFAJGbU8XI4Boo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3755
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.12.2021 17:32, Ævar Arnfjörð Bjarmason wrote:
>
>On Fri, Dec 10 2021, Jose Wielandt wrote:
>
>> Hi community,
>>
>> At my work we've been struggling a lot with not realizing that our new
>> branch creation actually failed, ending up with a push directly to
>> develop. What are those cases?
>>
>> $ git checkout -b feature/solve p-eq-np
>> fatal: Cannot update paths and switch to branch 'feature/solve' at the
>> same time.
>>
>> What's my proposal?
>>
>> $ git checkout -b feature/solve p-eq-np
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> FATAL: CANNOT UPDATE PATHS AND SWITCH TO BRANCH 'feature/solve' AT THE SAME TIME
>>
>>                  YOU STILL IN THE SAME BRANCH ! ! ! !
>>
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> ***(but in bright RED)***
>>
>>
>> Another case!
>>
>> $ git branch feature/solve p-eq-np
>> fatal: Not a valid object name: 'p-eq-np'.
>>
>> I'll let that one to your imagination but please, make it appear in
>> red so we can easily (visually) realize that something went wrong.
>>
>>
>> This has been the third time in a month we accidentally pushed changes
>> to develop bc we didn't realize that the command failed.
>
>I think if we'd improve the output we'd probably add some "advice"
>output, i.e. "hint:" lines, not ALL CAPS.
>

Adding some color for die/error/warning() in general if we detect a tty 
might not a bad thing. I have encountered similar situations where an error 
gets lost in between `git log` output.
