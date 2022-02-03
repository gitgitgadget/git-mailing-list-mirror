Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6FDC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbiBCMlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 07:41:09 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:44867
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230213AbiBCMlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 07:41:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMuFmbpDU5BpJfugrffQZsrscpxe+ni4GhBf8NFsEK7ZtKwHjUhc8QWre6XePp5K7Fr+g6zRBxhr0uDclFThQCqWGg0R2py+mOqpWq5vr+2wOY8eeSaUoFaSKAY0yGGN64LJ+4sgeYuvn2PMkryWf+WT4VYO2CmIYr+pm2P4GQsale7uSY63+XmY1lOWZ+10quOFaEmaMjYqU6sz+adyh4iYjlW0eCCbLGe2IKfIthjq+qJC63j7n9fx9Fk17uReUviQzirYZBek7bmbT2iD4j76vbtZbdYmja1OizpId/s5rvaTBvKnwMAxRLjaa0Nc4qxht81dAdKb3Lv6boFSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW9cXk68uDKCOxeHOu1peW0bBSLbPEzCs6Mb87jU3Yg=;
 b=ns/qUaLWMRHFBVEX2rk5q5j2Zg8DzAqQxBf3nFSYurX0lq0fybMOWtF5fS3clMwma6llFU3Qu6kCmw+0qYmYVsltNYL+Xv52Ec0RnIBf/wK3mSMB9BE2Q1nlEhJ9l/VVXUnP4O3vtVhtD/BWkvQ1jBXyxK6lUZ78mf7tb4rmskfnFBljQA4guseEBe3bFKxkpagqxw7x6Y0W6sZVViyKoxv+ecgjqjqkes2Cz63nEhZ8a2KIv502gF2e0SKQRY/cb7AHZIRfvf5JctM+Df99nXtai4QiFBRrTgiEWjbgFDmPrjKubXhcMVUw7qElJF3wBktHzENaG01r2LlrOgKg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW9cXk68uDKCOxeHOu1peW0bBSLbPEzCs6Mb87jU3Yg=;
 b=Q5+5JnooL0XUzXPPCRfAOShquV3iisKN1GRWF9uj98bu90eKozM/rjbk3JLk0S6TEVXh8/PM4QumAQYHbE0qPOqTTUT9M2MTuJuP/sHaGDrB+QIt+FYEsNWfaxB73nwSZBnBWeAJ7htXBQJRDojlKnEjakQOVNh8tD7t0qD/gwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AM6PR10MB2053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:37::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 12:41:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%7]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 12:41:05 +0000
Date:   Thu, 3 Feb 2022 13:41:04 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Matthias Maier <tamiko-GITVGER@43-1.org>
Cc:     git@vger.kernel.org
Subject: Re: Using principal wildcards in gpg.ssh.allowedSignersFile
Message-ID: <20220203124104.77ioij3jqqqyoc54@fs>
References: <87zgoziwfo.fsf@gentoo.org>
 <20211217094235.i2fwildp7rcjcgtz@fs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211217094235.i2fwildp7rcjcgtz@fs>
X-ClientProxiedBy: AS9PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::21) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056b7a7b-490f-40a3-43bd-08d9e71271ac
X-MS-TrafficTypeDiagnostic: AM6PR10MB2053:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB2053A7AD8332EC0A650B6EA0B6289@AM6PR10MB2053.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfUpdNpNGICpi+PDcs5RrFt1YqViCXxRdRmVtUY5D8BqEDgzLGaBwcy8IhnzsFQBV0oYNJ9hmD8molCQsitM+yCfjueOc43wXF+Fsb41MoRjHdTQYL6I1hduHDLnuvoZxE8zcAlwQJBafYY3mKTSOkVGczoaw5o1iuroCVhgqcDflRKrRzc0JKnDRAisF5SONMIbgpo6IRUE4jdKdhM1SZRRe/bJeuU9Q0pJ9rJz7fQaxide4TsegM+CmkGX8eraQf/tGYPY3vVCfMzW5Kkm09xvUFNxJNHK1Ch6YuHEzCK5DErObu2Lqt4XcUxRKj28P+O+oDLlqB4Yvy0VIPXdOHPV5FPU6gH0OJyulPN++j71YhkffPmzLxNqyFFDzpajyFV3Nl6tFEeqGXcvny93ZnYYxhsLQrkmnMf00chU6Q9XDzf3Ilj+BWsspJl5KQKcAGRQPVB6kN0JdEkpk0eaFF9+abL31XFWdu+Pmok3oraA/HLEF+Up1fNvoYPBJRkuF1Ww0Ps+3jfKq/g6I2FwlJ96Az7EVsmX5nz9dszpwK+BpiWjSy5cHFUrf1nVCBSvAQPKoFUiKmr88xOrJ+thSdfiWcW5zR/ep6HE9TBa8wxe5jHzDF5DVqqH+3ZWo68gJkU2QRAhI9A+7rEcHByhyMjnMx8UMZWLs4VYlqustz3kESNATQkpBSsfVqzOJLws6PeIG11R2w2HDAja6xweX58zItCDrbsQeIWhZJkSWZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(396003)(376002)(346002)(39840400004)(366004)(136003)(9686003)(6512007)(6506007)(5660300002)(8676002)(66556008)(8936002)(2906002)(66476007)(66946007)(4326008)(53546011)(508600001)(86362001)(966005)(316002)(186003)(33716001)(83380400001)(6486002)(38100700002)(6916009)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklFbkZrWDhpV1hhUHNvaXVhOVlzbDdkQ1ZVWFlDaHduY0p1RnVFNGp2RXNi?=
 =?utf-8?B?cWVDdVlkdE01bWtRdFVFelJZQ2Y4ZlJOWm9sMFg0aHA3QkIyQ3FLYU84SUZK?=
 =?utf-8?B?RUY1WWk2SGlxS1ZYWGY4Y2tvbVc4dHZqMHVvbzIvUytLV1RpQkxnVzRvSG9s?=
 =?utf-8?B?clBQdlg2Y2t6enFJZDRzR0JaSVhOQkNMbGFsZTFvYmlvaVAzRnJyMUM3Rm8w?=
 =?utf-8?B?TkQyS283K0FOU3NybFg4WmZFOEUxYU5HOVBDRVlEaW5ITWtWaFlMdFRPMVo1?=
 =?utf-8?B?dDdPWHhVelczQjNqNWtuNGcyMGF2d0pxWXJ0UnBoRGFpTVFqSm1qMVpHdlV2?=
 =?utf-8?B?QlpQM1Q1aUpibE90OUpDSXd5VklRWHFOMW15T0swN1hkQ0xMdWZqb1ZzRys4?=
 =?utf-8?B?b1M2Z0tpM3NQaDJNY1cxUmdaSGd0ZXloa3dLK2NJaHNrdkpjR01Yek5vZEhl?=
 =?utf-8?B?MGIvb3k0L0tNQ2ZYYUY5WUlLS2FEZytCNnRQdE54czNVekdLOWN3MGpVK3pU?=
 =?utf-8?B?QkhiSWZmSFhnUC9Ka0M5RzkzMHBrYlFBNTVjeVNJN2hFUkVMdEs0bnVDNjdv?=
 =?utf-8?B?SklEaDJ2U3RrQjNxaTR5aHRlMThjUGdibU40SW02clM3dG9GM1l5NzdMMWVH?=
 =?utf-8?B?VklBcUZJcjNTRWZLSTVwamhPbE9ZTys4TUswN0FXZkdqZFhKT1h4a2pMVzg0?=
 =?utf-8?B?dG9CYTdXVnpmYjdSVXdSZjl0RVlJaHl3Lzd0MXpEblRoekxEeFA5RmZXUjIr?=
 =?utf-8?B?UEV2RUFNVGozNWFWK3VGc3pDK3hCcTBDK01McFk1NmdUZFlCREtWbkprRnhQ?=
 =?utf-8?B?K3E2N0VMQnhaZXVMcnZ4RTY3aFJjWjNuTUdnbVVueXhOb2dUVDRmSVZ4UG1T?=
 =?utf-8?B?SEZmdzlLN01taUtzRk13cERFT3Z5dnNpRGU2SElZZk4vQTFIMk9VVXNjMWRZ?=
 =?utf-8?B?SWdzdzg3QkZzb2p0QnJxNW9heFhCY1ZhTXJRb1k0bFUxRFdIQS90ZHBKWE9H?=
 =?utf-8?B?UUo0NktReFFndjZFU29WTE03VTFFSm4rY3J6NERaN0JZV3BMelh3VmNEdW5n?=
 =?utf-8?B?Um9VY0lYQ0ZLWWVmaWd1S0lkd2d6UTkydHVYbW1NUVZBRzlidTBEbWRYa29O?=
 =?utf-8?B?Yy9ndDFVNk4zcDJIWk5FeWttd1RHNzd6WVY2ckhHUnB6T0ZWcFdxUzVPd3Q0?=
 =?utf-8?B?MCtuTkhTWmtxZ3JKVzJ3N0dJRERxZGhNS0hCRVFldkNCUFJKVGJEL01xZGVi?=
 =?utf-8?B?b3BsTDFLeGJlSmk0eS8xUmJGeVZiN0hMRC9FQ0tOOVBBbDlyRVdWdSs4TXJJ?=
 =?utf-8?B?WWM5aFZ4TStNZ3M4MW91VjFGcW4wZVNzMFVac2ErdzJ3ZEZWVXR3Y08za3Mz?=
 =?utf-8?B?cGpTVjNpVmpSckZTUHpKRW1xbktFdjFSVFFOTHRXZWMvRVFtYWZJUFdneXUz?=
 =?utf-8?B?RG9qVis2QjFEc2hmT0dhSDk2UTc5cXc4dis3anZ3b3dNekFqN1k2RDJVZ0p1?=
 =?utf-8?B?Ny9sejhuRERvT1lKWFdFNFlhT3hnZllzNVBzRW9RSzBhUVVjSWNTK1JWMzMr?=
 =?utf-8?B?czNweTRWN2FuQ3BDWU1NU241cVp6cHZlWGw0d0NZQURLSThoY21YOGxxbnNn?=
 =?utf-8?B?NEdMVjVKWUt0ZXlzcHBNOHZIMm9mMnhNN2xwTnYzd1JKTGhRVTVXVnhKc2d6?=
 =?utf-8?B?cTRYODNWNEhwRVFjUXVTZk5CZDZONHFaRVRGZXdreUhKSXhwTWMvaFArSHZ3?=
 =?utf-8?B?bTY2T0ZzS2NMbGpFYUpIZmVZRmhrSEM2OGQ2OE5EaWxxUzJ0akc0dk5LS3FC?=
 =?utf-8?B?OGtlY0RTN3BoWUI5OVBMaHdvMitkVEEwM0hia0RPdE5GUDdhTzFRTnRxRDRT?=
 =?utf-8?B?S2xreDRUenBxblRmR1BHSXNnbzI3MHB2bXNWV0Z0ZTJkaEdXR01UclZ2bHNB?=
 =?utf-8?B?SUhUa0NtRjM4ZW13MWdWdWtMdjVHQU93NXgrYXF1TkNYNW9oNHozcWY1L2h3?=
 =?utf-8?B?UU44ZWVqODZERE1Eam94TzJqM3hYOUdvVWhHNURGNlUrNkF2TG5YMXdXUXJK?=
 =?utf-8?B?RjAydVZjY2gza2JWR1BsbzA4RVk0dGtqQ3ZXNElnNjR5R1k5c3krZXl0M0x4?=
 =?utf-8?B?bXovOGZha0RTRUlEc25OdUtEbkFhTWlWZi9lY25CVFdZL3NyT1ZzRmQ0aEhI?=
 =?utf-8?B?Mlo1Tzl5cFNCckFkWEZ0Q1RiaHlmK3dzUVpLV1VmN1ArbGFaU2RsVDJSQVoy?=
 =?utf-8?Q?iEk84soQ6t7BMohlUh7akYIy9lTfU6C9cwp4lFAH4E=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 056b7a7b-490f-40a3-43bd-08d9e71271ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 12:41:05.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lekEk+AATYoWQLTUju7If9d5i5QMx87pRrpH5Dm4fE3AycvJdJFqoTkTrz98d4VarUMwF81yWg0+w9rOh3K7lO2Ka9Ijz9O1Cz+1eZa4Ndk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2053
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.12.2021 10:42, Fabian Stelzer wrote:
>On 17.12.2021 00:20, Matthias Maier wrote:
>>Dear all,
>>
>>I am experimenting with git version 2.34.1 (and OpenSSH 8.8_p1) a bit
>>trying to set up a repository with SSH signatures for commits instead of
>>pgp. I have also tested the current "git next" branch.
>>
>>The straight-forward setup (by having an "allowed_signers" file
>>naming individual e-mails and pubkeys) works as anticipated.
>>
>>However, when trying to combine this with an SSH certificate authority
>>(which would be the use case I have in mind) I am not able to use an
>>e-mail wildcard in the "allowed_signers" file but have to specify full
>>e-mails instead. This, unfortunately, defeats a bit the purpose of
>>having an SSH certificate authority in the first place...
>>
>
>Thanks for your report. I tested the described behaviour and I think 
>this is a bug in openssh. find-principals will never match on a CA 
>cert with wildcard principals whereas wildcards for non-CA keys work 
>just fine. I've emailed the openssh maintainer about it and will 
>prepare a patch.

Just for reference to the git list:
This issue was fixed with 
https://github.com/openssh/openssh-portable/commit/15b7199a1fd37eff4c695e09d573f3db9f4274b7
which should be in the next openssh release.

>>Steps to reproduce:
>>
>>====================
>>Set up a minimal CA:
>>====================
>>
>> $ mkdir /tmp/signing-test
>> $ cd /tmp/signing-test
>>
>>
>>A)  Set up two test pubkeys:
>>
>> $ ssh-keygen -t ed25519 -C "ca key" -f id_ca
>> [...]
>> $ ssh-keygen -t ed25519 -C "user key" -f id_user
>> [...]
>>
>>
>>B)  Sign user key creating an SSH certificate:
>> [...]
>>
>>C)  Create allowed signers file:
>>
>> $ (printf '*@43-1.org cert-authority,namespaces="file,git" '; cat id_ca.pub) > allowed_signers
>>
>> ! Important: I used a wild card "*@43-1.org" for the principal!
>>
>>
>>D) Test setup:
>>
>> $ echo this is some random text > test.txt
>> $ ssh-keygen -Y sign -f id_user-cert.pub -n file test.txt
>> Signing file test.txt
>> Write signature to test.txt.sig
>>
>> $ ssh-keygen -Y find-principals -f allowed_signers -n file -s test.txt.sig
>> tamiko@43-1.org
>
>Are you sure the allowed_signers file was exactly what you generated 
>before for this command? If I follow your steps this will not produce 
>a principal for me with neither openssh-8.8.1, nor master. Can you run 
>this with `-vvv` which will show a bit more ssh internal output?
>In the openssh code for find-principals wildcard principals are 
>filtered for CA certs. I'm not sure why and have asked them about it.
>
>By the way, find-principals will not consider the namespace parameter.
>This has another bug in the current master producing a segfault for 
>which I've already sent a patch. But this should be unrelated to your 
>issue.
>
>>
>> $ ssh-keygen -Y verify -f allowed_signers -I "tamiko@43-1.org" -n file -s test.txt.sig < test.txt
>> Good "file" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>>
>>
>>=======================
>>Set up a git repository
>>=======================
>>
>>E) Set up an empty repository somewhere
>>
>> $ cd /tmp
>> $ git init signing-test-repo
>> $ cd signing-test-repo
>>
>> and modify .git/config to look like this:
>>
>>       [core]
>>               repositoryformatversion = 0
>>               filemode = true
>>               bare = false
>>               logallrefupdates = true
>>       [commit]
>>               gpgsign = true
>>       [user]
>>               signingkey = /tmp/signing-test/id_user-cert.pub
>>       [gpg]
>>               format = ssh
>>       [gpg "ssh"]
>>               allowedSignersFile = /tmp/signing-test/allowed_signers
>>
>>
>>F) make a commit
>>
>> $ git commit -a --allow-empty -m "my shiny new ssh key signed commit"
>>
>> $ git log --show-signature
>> Good "git" signature with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>> /tmp/signing-test/allowed_signers:1: no valid principals found
>> No principal matched.
>> Author: Matthias Maier <tamiko@43-1.org>
>> Date:   Mon Dec 13 23:51:03 2021 -0600
>
>Just FYI: if you add GIT_TRACE=1 to the git commands you can see the 
>executed ssh-keygen commands, which can help to see whats going on.
>
>>
>>
>>G) modify allowd_signers entry to read "tamiko@43-1.org" instead of the wildcard "*@43-1.org":
>>
>> $ git log --show-signature
>> Good "git" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>> Author: Matthias Maier <tamiko@43-1.org>
>> Date:   Mon Dec 13 23:51:03 2021 -0600
