Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3479C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhLQJmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 04:42:40 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:62581
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234263AbhLQJmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 04:42:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyG0mQXG9kfKwGgYcWjw6r/rXSTOA9urfMTtmW3nF+S+rNMA+eAK9Qa4lFQAkjjh3H3CqzoNK2EVLUTrQcEbZ0+VzknrQxbKjF8aBmOqZ+CWkJ9JBQ1cZto/9XwWZTSlcQmcySqPOSQvXPSr8Awbgny7yDGucBhWFVWTK/DZf8IJdD1smfQy3sxLXbrQjzq0sM6sj6BSmRQdPEjUnNNUsOljXJ06Pp2OA+TpjfNAQXBRdVhxWzJe+2FEDvppHLKitpematA/NIbw11jM5eD7MZJOxGDlPtT6ATB52VfQl9iSu2XsZbl45EazoVXSQxLW9R2gru9Zc24JbgoycUBdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56KHDVwnx03PklJ4e4bxaII15AgAzwmCGqtWQBZ6nis=;
 b=nZt2NxqhVI8HMdwh0cI37JSoyHc++qbQ8v+nQg19NuzQ0OXsxKZ/B68wJYe73OA2DGHjwaeyzvTkWQMGMgoEjnRfMGfNyQMhYt7b3WQM2Wd/40F0tEmKiQ/knL28nvCwUSIgLty6T8pwt8Fhmc6racE/zDSL3rRFSrvTcEgM9NXCYUgbMnOOvhqqiycUTsEV9ekaGxCHO+0cXnmuVwvBk1/1mBfu8STGOPTt0QF7YAFy6LFAi0UoPnjT05E6M+g7H5dNVpueaYTOojuHjvkUBPe9HawJLvUqWj0U8RfIBbjLw9sc3YmuXdmi5cvOYePCjOzWFb++B99Nw+Ul84H6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56KHDVwnx03PklJ4e4bxaII15AgAzwmCGqtWQBZ6nis=;
 b=eESuqCnAO0zLyC8/aI9u91SH+M0JHyzFXX7lqV3vZa0pg9tF4zJtanZMCl3LOg/TOJLVEfm7OS9qriGDEBKbuVsqaYki2c5IfTT3FLFGDBO0WnKA4DOkvUrS9I3oGPHz9GD/9ALGRQpaiA+blssOSA7xv45qlizyU0xHpysVfrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 09:42:36 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.016; Fri, 17 Dec 2021
 09:42:36 +0000
Date:   Fri, 17 Dec 2021 10:42:35 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Matthias Maier <tamiko-GITVGER@43-1.org>
Cc:     git@vger.kernel.org
Subject: Re: Using principal wildcards in gpg.ssh.allowedSignersFile
Message-ID: <20211217094235.i2fwildp7rcjcgtz@fs>
References: <87zgoziwfo.fsf@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87zgoziwfo.fsf@gentoo.org>
X-ClientProxiedBy: AM5P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554ef780-d497-4c1f-c045-08d9c1418e94
X-MS-TrafficTypeDiagnostic: PR3PR10MB3755:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3755BEBBD78554B10DF8C898B6789@PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzLmDDbbJYDb04CeaPU7+Pkv4XhcY4T2yuPsgQxE4aIH2Y3kVEjCS+O0ibK/cw4Ep1ZI4Lhsi82L8AWji1rYRHEH3GL+ABNhftd5Y/3ipI9UORh2p6BQ0d8fV/Nqr7eDvXdERL/pd1GNFi9wCJSecca6UIRJ7zqhHLv92dcNa0wer6qFRoHrvrNqZl5GNQOgNZGqhNr1XjLrnGWIRpQQE/InCJRl5M/HY5EbtNWbqybhB9M4Y3uK8EYGgWTW3Jrcnu83M0qrfKXXoaJ6sIafNaYHgiGOsdcJtrSHM9jg834YqYewbcrwj53+85PSC2h+YC/kD8M6NmEWa9R+p4VuVVNevapunEbUvusDknloKzceDyFp55CLLghQTHGtkagENbgcJXNF4OapCNHiMXlatOzrD4MJAmBAEUttqLZPADOMJy7XOe/QcZq2/qyUDFhN+i4CYy4T4YpkC/H3UUzsJdUXG3vxb1kCy/rXGcdMoQqNT6EK/Td9wSEmsywRTszdbF+p2BCpkC58dooBQfbJ+H3poovbTU/lWz1j0VDy20zWYHIodGIofZ7FB3v8YCQGUmnXICtF9n7/dyTyQYMtUaK2N0GogCnEuRSB1eV0HUvxFGvCbEv7mNOTPlZA3fapJ/U6tPbsO/NdixmcHXaV7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(346002)(376002)(136003)(366004)(39840400004)(33716001)(508600001)(8676002)(186003)(38100700002)(1076003)(66556008)(6486002)(6512007)(4326008)(6506007)(53546011)(66476007)(9686003)(5660300002)(6916009)(316002)(66946007)(83380400001)(2906002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRkVUN4NVA5OE9rQVYzZEorL3ZvZ2NMMXpBZ0xieGxLV3FCWmdKZ0ZZbkVR?=
 =?utf-8?B?QVduOE5DTWRDTm9qb1R4WUltSUl4aTFwVFpjRHFtU1JJTS9XWjRnc3cwQ2hH?=
 =?utf-8?B?WVA5NEN0ZHJSSGtGSW90WjdZVHZYb3RrRU4wMnBQdWF2SVBjSWhLRVBRSzI4?=
 =?utf-8?B?Q1JHSXZGQmdXRVZmeTJMU0xOdENkY1dFMGxoaW9RTXdzai9ZbVU5bTB0SURx?=
 =?utf-8?B?TE1vWGptY0ZxSVFqVm1ud2h1Z21ZVVpuRHE5cnJMQXRHKzJpN1BYQU5rNndo?=
 =?utf-8?B?eFR4Z3lyNEpGVFFvZmoyQ3VYaFpDVEQ3S3ZIQlRyYmp4YUJGRE9WRkQ3ZjV2?=
 =?utf-8?B?dzFDWTNIWFVVZ2pXQXJyYkJSQ1RRMFRDOXc2T1p6dzFZREpzMlRBcVVmM2ZU?=
 =?utf-8?B?RnlmeEdRekM3NEswczIrVnV0S1BpR1NYQnp5VkhDSjVzaGlIaWpPcUxZOHBT?=
 =?utf-8?B?cDVjOXBHTUpicDFBT3BYblo0VFp4UnVYTjBLUzd6WUVCeEJYQzlPalVuUXF6?=
 =?utf-8?B?QnRiUnBTd05JRzQxVG1QQjlPbmxDNlZ4a3RtbWN0YmJiSStUaG1oT3YvZHUx?=
 =?utf-8?B?RnF2MmlvbG9JdzRZTzNVVzFoTjhPMTFVemdISXRQVGFGVHlNdFIzeEwyVktS?=
 =?utf-8?B?c3VvMDBRb0RDNHdRMFpQYVpqdk5jd2luSEZva05NRUVDcWhaYUUrcGlKb2ZN?=
 =?utf-8?B?T1ArV2Q0a3p1dEpyTkErU25aNVhpZjh4dHhTWjVpOC9LVTZDaVhQcTlMRkVV?=
 =?utf-8?B?NHhVQ0V0bjFYR3FhL3FjMkdNeUYxV0RwVEpCb3FreUZKbEZObGNGbTVhRDY3?=
 =?utf-8?B?LzJ3aWlaUU96ZWNkazhRK25WcmVhb0JST1NBQ214enYvQVdxRG8xQ25ta0dB?=
 =?utf-8?B?NWVUT01Ndm5JSC9jK0RSTkZydnZLRkE1dEUzY2ZxREVleXczeHc0LzN4RHRj?=
 =?utf-8?B?QlF1K1FoalhINVZEZVdZaytya2lZRGJodENidXZUTFprNmhxZHp4QWErandz?=
 =?utf-8?B?S2hiRC9mN1BWUCtIMDJTZVBvdStnYTg3Z0s3WGVCMlR1aUFoU2gyMDlHVlp5?=
 =?utf-8?B?eXNoOGJiU0pNTmttcHBBcVFHQk95Z3hQV1djREd4cTRXZ045eTBuOVMyanhR?=
 =?utf-8?B?aVZ3VlJUbkV1bWJsK1B0NE5YVWFzcy95MTA3MFdUR3BhRW8yWkxjemh0T2dV?=
 =?utf-8?B?MXN3Z0NRK05SeW0zZGpnSjR3OFFybVUzQVZnVWZxQi81QlExTGpWblk1MW1o?=
 =?utf-8?B?VnRrVzBLWWlFY0FMUFV2MXFPQURubGFsMEZYS0kxUmRtUDJ6alpKZ3k3WXJM?=
 =?utf-8?B?ZVhpd2paNDZ1U3NQRTJlai9iQVJNS294UWlBTTNLZmNwU29pUWtKQzRUSmJY?=
 =?utf-8?B?cTk5WGxEOHFRU00wVmwyWGFZTnFlQ0M4NENqdm9nVVAzNk8rNm1WVVdhT1ly?=
 =?utf-8?B?VWVLRUhSWjFQbmdZclllemVHT3hQNkhPWVlpUzJNaUVrRGlVM3ZFUExoamti?=
 =?utf-8?B?T2w2Z3R4RzR4SFRMb2ZUc0J6ZWZDZ2FLRHVSTVA3ZHBaMXRJTW1qcE1LUDRx?=
 =?utf-8?B?bTAvOE1IVEFTSTJveENNTjJ3Y0xubWNoanNPSlBBYVRrMURBUzRJVDFDUHRa?=
 =?utf-8?B?RzFNS1hBa1FpVDFKeTcyMFZBcWRweGI2S0JvNUxYZUlWcHoxbXBNRnQxeEZz?=
 =?utf-8?B?UXpOQ1IyZWNSaUMxRWZLQTcrVzdER2JxcXlpSlM4QVlJM3VreEVZVkx1bzA0?=
 =?utf-8?B?M21ZU25kd1ozVzZzWElqUHUveEU3WGxQMExZcWtJMWNXbVh4Z1FjSFI5cnhv?=
 =?utf-8?B?NW9LWjc1VERYbVFveXJXNkZ4RmdyeUxqY2dqMXJvcE03a25WSFdmOW94OGVE?=
 =?utf-8?B?N25zTHJhd0FqUGJvditVWlVEdTFlYmV0eEJDNGsrdXNpZDhVVEdiSDNGWjA2?=
 =?utf-8?B?a1ZRNjBPb3daNzE3azF2SzRvM05PU1BnVDFVeWI4emdYMXBxc1c2WmozNWd5?=
 =?utf-8?B?VnphVFBGaFYwNWJrWm5QVmc2TUNWemwydHBEeWZwUmRDT1JSY0s2MDVFREdt?=
 =?utf-8?B?MFhZQVE5Q2E3aW8ySE5rNG4xaWx6RUhQTmRtTEVFbkxlK0NkZ3IrQWdNQ0xr?=
 =?utf-8?B?U2lzVDNkdHVDMFFxK2RaV1l5dlVHVTdwczVzZDBzZWFkK3pMa1VtRGtWTHFD?=
 =?utf-8?B?OU5CN3RlRm9ENklrb2xEUnRBaHpwWkl5TEhtcnM5eDRYRkYrU2p0OUdCNnlJ?=
 =?utf-8?B?MlZId1pTMHRmOGxLNzFyeXg2VlhLcTFKQ3lVR2p0bi8wZTBDSnJ3SHJHU05N?=
 =?utf-8?B?cytvVldIREdwYWFTYXNObk9yTUoxWllHWGhiYVk4WldzOExaeVJ2QT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 554ef780-d497-4c1f-c045-08d9c1418e94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 09:42:36.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Di3MjvaepS9WpEEKTGw8Ymy0RuVm/nEtgphynMp6HTNLYaiLcOyLVbbAc/51ddm5N9puW1P079mcHl6IUsVq8BKPBWgnJ2NJCCtwUaItEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3755
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.12.2021 00:20, Matthias Maier wrote:
>Dear all,
>
>I am experimenting with git version 2.34.1 (and OpenSSH 8.8_p1) a bit
>trying to set up a repository with SSH signatures for commits instead of
>pgp. I have also tested the current "git next" branch.
>
>The straight-forward setup (by having an "allowed_signers" file
>naming individual e-mails and pubkeys) works as anticipated.
>
>However, when trying to combine this with an SSH certificate authority
>(which would be the use case I have in mind) I am not able to use an
>e-mail wildcard in the "allowed_signers" file but have to specify full
>e-mails instead. This, unfortunately, defeats a bit the purpose of
>having an SSH certificate authority in the first place...
>

Thanks for your report. I tested the described behaviour and I think this is 
a bug in openssh. find-principals will never match on a CA cert with 
wildcard principals whereas wildcards for non-CA keys work just fine. I've 
emailed the openssh maintainer about it and will prepare a patch.

>Steps to reproduce:
>
>====================
>Set up a minimal CA:
>====================
>
>  $ mkdir /tmp/signing-test
>  $ cd /tmp/signing-test
>
>
>A)  Set up two test pubkeys:
>
>  $ ssh-keygen -t ed25519 -C "ca key" -f id_ca
>  [...]
>  $ ssh-keygen -t ed25519 -C "user key" -f id_user
>  [...]
>
>
>B)  Sign user key creating an SSH certificate:
>  [...]
>
>C)  Create allowed signers file:
>
>  $ (printf '*@43-1.org cert-authority,namespaces="file,git" '; cat id_ca.pub) > allowed_signers
>
>  ! Important: I used a wild card "*@43-1.org" for the principal!
>
>
>D) Test setup:
>
>  $ echo this is some random text > test.txt
>  $ ssh-keygen -Y sign -f id_user-cert.pub -n file test.txt
>  Signing file test.txt
>  Write signature to test.txt.sig
>
>  $ ssh-keygen -Y find-principals -f allowed_signers -n file -s test.txt.sig
>  tamiko@43-1.org

Are you sure the allowed_signers file was exactly what you generated before 
for this command? If I follow your steps this will not produce a principal 
for me with neither openssh-8.8.1, nor master. Can you run this with `-vvv` 
which will show a bit more ssh internal output?
In the openssh code for find-principals wildcard principals are filtered for 
CA certs. I'm not sure why and have asked them about it.

By the way, find-principals will not consider the namespace parameter.
This has another bug in the current master producing a segfault for which 
I've already sent a patch. But this should be unrelated to your issue.

>
>  $ ssh-keygen -Y verify -f allowed_signers -I "tamiko@43-1.org" -n file -s test.txt.sig < test.txt
>  Good "file" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>
>
>=======================
>Set up a git repository
>=======================
>
>E) Set up an empty repository somewhere
>
>  $ cd /tmp
>  $ git init signing-test-repo
>  $ cd signing-test-repo
>
>  and modify .git/config to look like this:
>
>        [core]
>                repositoryformatversion = 0
>                filemode = true
>                bare = false
>                logallrefupdates = true
>        [commit]
>                gpgsign = true
>        [user]
>                signingkey = /tmp/signing-test/id_user-cert.pub
>        [gpg]
>                format = ssh
>        [gpg "ssh"]
>                allowedSignersFile = /tmp/signing-test/allowed_signers
>
>
>F) make a commit
>
>  $ git commit -a --allow-empty -m "my shiny new ssh key signed commit"
>
>  $ git log --show-signature
>  Good "git" signature with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>  /tmp/signing-test/allowed_signers:1: no valid principals found
>  No principal matched.
>  Author: Matthias Maier <tamiko@43-1.org>
>  Date:   Mon Dec 13 23:51:03 2021 -0600

Just FYI: if you add GIT_TRACE=1 to the git commands you can see the 
executed ssh-keygen commands, which can help to see whats going on.

>
>
>G) modify allowd_signers entry to read "tamiko@43-1.org" instead of the wildcard "*@43-1.org":
>
>  $ git log --show-signature
>  Good "git" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
>  Author: Matthias Maier <tamiko@43-1.org>
>  Date:   Mon Dec 13 23:51:03 2021 -0600
