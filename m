Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F91C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhLAI5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:57:24 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:9091
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242245AbhLAI5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OomDMYq/aZkMjuagenABT+S5QN7gH4gk4AQkzU93vKWjgruQ3k3dcCmHvBrcnNscNDaw85SDBZDLVqmDVQY/rO6Q4FGPBiKlncyaOGmnBaD4j7qQAJzcwa7mZ5Kp/JD7+MFqdJgaj+fG4eNWcXj7mfKFWaZ/7v2MZLykNXARYsTLFkWggSTYKAC+it/kYtS70rLyEy/F3vA/mqrcbgFhmtIucMBkx8FsWgWZo+EQjZoAyu5Ggcj5t4yo8QL6SmgjRkFCzg/h7v2cIA8JAA5S4PPDxvjJPFGXZzniR8khE+tP3fRrL71A7wpE5P9iZN+D33fg9sAzehXbZNI55EC6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGnWNborca4c3SYPr3x5wij+Jt+sgVpU+KRZL2oumdg=;
 b=FgtXJcvuLSDYMegcx97L66bwDgXMnM7PMHInMhvEbRoza9EouS+l3RLEKqiYfjATU9UksdEKCoUsOlgmECnoqrgvYnZvTQ0er+04pPh9eM5y4t0lv0BUY+krCVqI76nFVI7KI4r5dhQKHCNPyu+bwWxkepcW6J9Bglblq/o4xwc16UBVCC1JLiKA33p7/3F/QgTRMfM2eMDsfzgVRqs11mLIMixyRJFFD+z/6dGwO7PlAIbaTIPB6uSoc+SW3CrXvSy/LnwkGZCCRNi+FS18U8mYlKfdQChkQZ8XL1z3l7nRQpTA1MsqN1DQ4YX1YM2EWlK6rHuHOl4bxbPpDnj48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGnWNborca4c3SYPr3x5wij+Jt+sgVpU+KRZL2oumdg=;
 b=czIkyPpsfzLzNPPgpLu3XJ3wfLRXVeI3R4l+OGTsc5wOWW8vxOLUU2u9O2nIcn12IC6731bRii0l2ee9+ppRSIeaZ9QKXuVLe6wPjbiMd+l5bO5C+5WDiUHmyuZ9/C1R6fhMHYU7R//lOAxdxXtSO1YBgMiUA8moASkjo2pJnqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 08:53:58 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:53:58 +0000
Date:   Wed, 1 Dec 2021 09:53:57 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: fs/test-prereq (was: What's cooking in git.git (Nov 2021, #07;
 Mon, 29))
Message-ID: <20211201085357.2ecorbu3rfw5ctaa@fs>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <211130.867dcpcpgh.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211130.867dcpcpgh.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Wed, 1 Dec 2021 08:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae6ca55-6892-47b7-da60-08d9b4a81cfe
X-MS-TrafficTypeDiagnostic: PA4PR10MB4558:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4558A3BB3680D2BBDE9A5570B6689@PA4PR10MB4558.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvkVDyWFAwYzMEUV5263092n3PrmcYRIN9dSDdLh0auZRu5ruZbiju0MwqCjiY51uw9YTpInmaLoINMyeE55cfd1y28XNpnibZu3oodF2a++ohkNhjgkBrFYXEbBgq/XeffvOVT4vVZlbb4P3qL1tVQuONrKTUoatPmzhCfQstpWiMzd3gP4EYlacmYchULOy8m0xWsQZuJOiMzmo/mmm81Z2N5BJszeKQG1QMAI5xMD7rywlPzgg/X1Ds59PvuP+ivx5nzASxrk2Xfyu+p7UAlvTdpgZYhMR89WyXxGC+j88Ly4OcKvCcNorNbnoTziznHP8ZqpC1w/kkcg59ND1J11Dk4Qv8iLUg5PE2LUoS/tj3RL1qw09PhrQD48LrI9TKy1NmNx6nXfwWcD7moyalckVXtTnXSugp98QRVoRsWK8kns/4Ygk1wOy6NApN7IWa8R5x4S4UxoqzB4PnbrmKOo6yAw8qUuIQrWawjKmn1cc5Hqi0Ehc+o6vCJcXXuZtOrasdIh3EzdrW88KWGZFARtkN2TdhlYj+c8W1d/gwrewjS/1EW0tySoOkwTbEMPH4qcrImHcHe1CL8X1Ocxamlm7STn5+pUpn7EK0+32frzEE2Mi2JLYAqlU7Y9v8fwDIEJ+5XSDz7YZFUcbNoJ9Msilh9tcy0Prys+HLGfhPPn1BIRFYeyDCygP/aIkw7NqzO7ZjFoeIyxcmG2q4Xt0Ej0GiD7x34iH9MSx63Cr8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(346002)(396003)(376002)(39840400004)(136003)(9686003)(4001150100001)(2906002)(6916009)(8676002)(316002)(8936002)(53546011)(86362001)(186003)(66476007)(1076003)(4326008)(6496006)(6486002)(5660300002)(4744005)(508600001)(66556008)(66946007)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmM4aTlYWitYZFlyRWgrekdNWEtsZ211QWxpbGpCekUzVkZjcnc2U21XZkxX?=
 =?utf-8?B?b1BoL2VGdDBlakRRTFZqQjNHQVkxcDd0MDV3Z2VBT3drTjFTZGFyR3hLWitQ?=
 =?utf-8?B?eFJFUkVldXlaMFVXNS9hY012YVMvTnBQWE55SmdXMlRLdWJNczltWExlN2VB?=
 =?utf-8?B?MWpZcDFYTElMTm1xUWF2WXVPWkRKVXVqNkZEZ3haT3kvR2tCUW5aamtVQTFr?=
 =?utf-8?B?bjRQNGJibzRjYlRza2F6cW8zaGY3allETmhhRTdkUkJYWXZyRVJKMTFsU0JY?=
 =?utf-8?B?Nm5GL2xpWnprRHgrZjdqcVpLT0pXQWhpM1N4eEJibUJMMERxMlpmYXVIVDNU?=
 =?utf-8?B?MUF0TGdYdzJXL3JteFFMR0V4T25qdlUxYlh1WjVpZjRia1RoK2VrVlFkd1hw?=
 =?utf-8?B?dFU2aGVtcFdFYnlROHdaWjBBd3JwOVYrLy8rOUErZFVNYWJQemxNTGVCNCtB?=
 =?utf-8?B?dEs0VmxiRFRhbXBGRituYmphdk9saVNRNE9KYnA1bUVLWE1xa0RjeTYzRDly?=
 =?utf-8?B?azRpazdiblJQQm5OU3RyQmxLRGNwR0poRUZJRWN0aW1ZUTA3YWdDOVVNUExx?=
 =?utf-8?B?UHFHVS9HaC9KeTlVZFphZUo4czNKczlVVFBQUjFsMHIxb2RhSyt5RDc0Y3pa?=
 =?utf-8?B?d3lMaWo1bytZWGIvRlUzc05BanJYaGdHM1ZsOTIyLzM5anI3Rm1LTVIxTVV1?=
 =?utf-8?B?UUgxenBrS2lNWllGMXpxbUg2RXdWNmQvamFHTnluYnM2UUd0VlNhNXZqZm04?=
 =?utf-8?B?Z29YZ3lwNTgrU2xpYTJNNnNBRnRId21KdXIxajZIUk1DK0dEd3RzQldqaVZo?=
 =?utf-8?B?Vzh3cmFUSThwZHloejlxZDJhRXVrSlppVFFORjcwajFHRnd0cWluQm5VRmVv?=
 =?utf-8?B?U09IaGkwbTlOeXdRVDQ2YXFqN2xzQXZ5WVJrZ2oyNFllUllNRXdEaVNLaHlC?=
 =?utf-8?B?V2gwU2hoT0RPdmtYWXM3NWthSDNuSnZ5UDhpMHpNNkdFNEdqQkhoeThOM1NO?=
 =?utf-8?B?bGtaUWdFbWxCL3VUL0dQQ2JQSFBIZ0IweHkzNHYwdXE5SnNrNU5sZUJJUVJD?=
 =?utf-8?B?MnY5OXJxc05CbTBUTm5tRFlEWkRzTWtFc05TRHZYM1FkTlI0V09pcER6RGgw?=
 =?utf-8?B?QXJKRnllVE5yaUF5ZkFyYUtkWVFsanJPYWFHZXdWMms4dndlQ1g1UmhSLzlz?=
 =?utf-8?B?ZnM5K1pzbUNPMkVNcU5JdHhMNFh3Wmg5ZGhGSFRHTW1JNStFcjlLQ3dCK2lK?=
 =?utf-8?B?ZTZkU0h6TENnUmJ1ZGM0Y0JWdjJteG1hSjluaTl1cDVVcGJkZ0ZraEM1SzNs?=
 =?utf-8?B?Y1ZRaVp0c2FjcU9mYzU5NnpzV1N6eUNGQXpZL3NWSXFQV3RHRVp3WTlUNDc5?=
 =?utf-8?B?RmxRREN3WjBWL0dNQm9zS2Q1TnE4aTFTMXR1dzR4K1dXVTJIL256TURnUmwy?=
 =?utf-8?B?R1dIUmliV3RjMnIzSGxhb0Z0dTZ2dldLblgzd0F2eGFRV01NZ2xrTXhBQkND?=
 =?utf-8?B?OTRwcVFrVHJJMEZ4NDJmUk5kbkw5MUlKcm14RHBvSnhOOXpjY0ROem5Lc1VL?=
 =?utf-8?B?SVpyRTYvZGRZdWkxUzdkRkxCK1JCZ1Y4RnlxUXZxL1VSdm1TTGFZa2s0RDE4?=
 =?utf-8?B?MkdyMHU5UWJMUmk2L0d0bWhkSVRHWG5tazQ1ZFFTeTRnb2NuSGdwaG81T21a?=
 =?utf-8?B?SFdKenJoNDc1UDJhTnlRc0tmbkV4ekFQbW9hSDZML1EyNDQzUWRIUGlrOTVU?=
 =?utf-8?B?YUdDbXJEa3puUUFnamlTb01hSytiZmI4bXp3REhWNkFkcGVyejU1NlhxZFFD?=
 =?utf-8?B?Qml4NEprb2VHTk90YVZmYmZjZ29FTW9MU0d0NzErdXp0S2hsQmxVVDdqUDVR?=
 =?utf-8?B?SlV2LzBySmQvS3RQSXFFWFg1RmdWS05WTGN0dEdqVmx4M1NOV2E2VFVYWVpK?=
 =?utf-8?B?ZnVjV0tOeVh0cEY3UWwyZGVmUm9neHkrR21GQVFYWnB1MThKQkNyaUFCTEl4?=
 =?utf-8?B?RzhJSmtyeE8rZVBBZTBhTytoTWR5Ymh6QkUwWk9xTk96dHpHMXFuenBkKzFy?=
 =?utf-8?B?cWpGVW45ZStSSis1dmRBQ1RCcE15Vk1uRGgyZ3RFVUlBUWFTK2hQdStMN0Fx?=
 =?utf-8?B?RUFjWE5pUjBSY2VBbG5xdkhZSi90Y2R3d1o4NE9JNFlObGw1aVFxQjFFdHBh?=
 =?utf-8?B?U3RlSW8xMVFzcGdncnB2YnBsRWlWUkpwUUhHZjVGa1JGN2N1WVFWZTlLckNy?=
 =?utf-8?B?UzZMWHYyK090MENqMStUSjVHd1FLWVBNODZySktNWmdYdkQzOGJiaGROSGxw?=
 =?utf-8?B?UjFLRDBXS3pYMUQzb29qS05rWkVrd1FTTlNlc0ZhVnFIckMrYUZWR0xwb0V0?=
 =?utf-8?Q?l18RkQpvYcT2eq7o=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae6ca55-6892-47b7-da60-08d9b4a81cfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:53:58.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JltEvr9GhrqvqVJ7amAca08oJHMozVywcKi1xgedUVZ6cLT7BuUqT/7RBGdzZvwxnnsj1lAL2HHTGLQucH5QT7DYjWAl69BKsQGM0Kddho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4558
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.11.2021 22:17, Ævar Arnfjörð Bjarmason wrote:
>
>On Mon, Nov 29 2021, Junio C Hamano wrote:
>
>> * fs/test-prereq (2021-11-20) 3 commits
>>  - test-lib: make BAIL_OUT() work in tests and prereq
>>  - test-lib: introduce required prereq for test runs
>>  - test-lib: show missing prereq summary
>>
>>  The test framework learns to list unsatisfied test prerequisites,
>>  and optionally error out when prerequisites that are expected to be
>>  satisfied are not.
>>
>>  Will merge to 'next'?
>
>My reading of
>https://lore.kernel.org/git/20211130143821.7dz5jj2z2x2q2ytn@fs/ is that
>Fabian's planning to re-roll it.
>
>I replied today to that to clarify some edge cases around TAP.

Yes, thanks for that. I resubmitted a new version with the better comment.

Thanks
