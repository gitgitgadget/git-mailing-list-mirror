Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E001C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DCD61B39
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhKOKWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:22:49 -0500
Received: from mail-am6eur05on2047.outbound.protection.outlook.com ([40.107.22.47]:16706
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237582AbhKOKWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 05:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEvAAjegMtt1gPFMHwYOupSQ/vJ2GkkSYuopeGp4VwPtqvrnewFihhIPgzRJvIQyhowtAHYfl77gCkN+xmMDo0VbxMQyiHv87/ebPbMJr0uHg79kE81sLF1EiSwDXnpgReALCbF16b4jOypp9TSXOwxPCNxV/m4wqrMOQnBagJ/MP6Eyn63kebM+cTEx0lYLiRTz5CyToFlErLjIYNJ7IV6n9ChNpAn5VDJhdqiM499otVGDyWrofnvze6qUjUtxTI03EFxi95GkXIDDbJdf5iUzZFnO8zGItdGFFMacbpC3EQ7CAhGIdXvVw9ysOpTeUQjkNFQiS8XtyKFtaTvKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/WT5pN5smN9O37HiOHYWAEAZRO4qmuEeqBnqv7zzMU=;
 b=hX5hB27vGl4qCrpMfyHGeR0+N1j3OpHZDUCGy0tKq4DKjYLz+xN1ACMMv/FjGOOGWkILnv7UUAfX7jXpfZ9KH7Q1vd9katY5sN2iLxd2ngg21nm25LG2hbq1WzBGCbVQeJWRBUm9k3fLby2GDg3DjlcNeSHkc/MEN+MicDF/PwoyDAypn4lglzzih8A+FncAhdNRs7MXoqhd8RoNf3+Ou+Q9wlh++IUGOCjrF/yB+5jnWzZJgQRWkOxKgdZF3Do5hGLJq6Gxl0FYwnnEDujBuTw8nUgBGQas0PACw2Yx+2wz5AIpk3UiXPAjgAfXVg4cLACe4u4giTO+50GFAHysYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/WT5pN5smN9O37HiOHYWAEAZRO4qmuEeqBnqv7zzMU=;
 b=CR8tzb9eIAra2tBRikA/RkUjOomnsfYLbd7sZ3YGD360+O16oo71ABjIBP7DayD7R/XHHhW7AsCsBx+YkhI/Xo6LVX6jN3OWnNuLaZshgD/dX3rrLAOCScx9CIL7uPMEG6j6FxnbQKPGBKRKRF++9GkXru0UC4jEAmIS2OwZDtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.22; Mon, 15 Nov
 2021 10:19:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 10:19:46 +0000
Date:   Mon, 15 Nov 2021 11:19:45 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Danilo <mail@dbrgn.ch>
Cc:     git@vger.kernel.org
Subject: Re: SSH Key Signatures: Feedback
Message-ID: <20211115101945.scikeaptstuy64mi@fs>
References: <30999b1a-70b3-4489-b751-024c26bbbd11@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <30999b1a-70b3-4489-b751-024c26bbbd11@www.fastmail.com>
X-ClientProxiedBy: AM6P195CA0079.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P195CA0079.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 10:19:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ce4950-17d7-4b30-6b6b-08d9a82172c3
X-MS-TrafficTypeDiagnostic: PR3PR10MB3931:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3931CCFBA3B0420190CF7DFEB6989@PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvTtzLC12/YTu1JrYTIRxCKAvKLqNN0YjILGLIxH4CDBjglEAdzVpaHICZ3ODkYcEpqMW8r6gT+rod/+K6Hsvs0HD9cfkcZnSnxHQAR8u5yFEoJiMRLbcWMJTV1FFqY+wGc4DFJGl3ThnvapI7k3Yl2gIAtw6m0CxkyeA/T5YBCSLijz9YBh4owk+LkT9PMeiBt5M8ovFaVHIPGGg03sYc5DVSSHWIVpAgW38uO7KCo/Kyq8lCG2R9nhoiiBnCDRjAjDf7lORlogp+Z01kjAxXBTeZSFL0RfgtqLs/7Hqx+SAEICbZs8DK9JMBJE73qWPji9M/C9ryIX7prIV+kO+m64U7dBIhlK4h2GpMfs0WtO0lNn01DHDnuAhwsiwhyrT3l0naWZuVMBSAM+4vwyfDcm8dgBYQ7LQ0QAD2zIfBvu+7SfGWrc1QrWFVHwdOJY7FIcKsrw24t5cZG6i1FjGmVTckzBzXmNIGwp/Y4jlqAT+MLGS2wRPTyBDmn/2ApmLeTq3NC0HCMLePe1GHe7jI6WYUhBrq+z7BYTdcKEMm2EDtH6qdNx2Fb+nsQA3Vun36+DoqcRr4t9GQ6zYHNRelCvHHVvQy2hDEzfZuYRSQmJpaertBcG4Z9D2Zrqtea7edCyfmsQ11R5+4NgrIDkYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39840400004)(346002)(396003)(136003)(376002)(366004)(33716001)(186003)(4326008)(316002)(86362001)(53546011)(52116002)(5660300002)(38100700002)(6496006)(9686003)(6486002)(1076003)(2906002)(83380400001)(6916009)(508600001)(8936002)(66556008)(8676002)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUh6cmF6eW9oWTUrdmhnS2ZQMHdDVk0yZUQzbmkzZm83OCtLTlY4cFQ3UnFQ?=
 =?utf-8?B?SjI3TW1PNWk5SmNzNmpvd0FPR2JEZFF2WGNROE1tcFFYNlp2VytlSmsvZ1RG?=
 =?utf-8?B?M2MwbCtwOVJHeVhyNW0wbDIxdWpHV2IxVTNhTU1EWWE5bzNMSHNObEhRY0l4?=
 =?utf-8?B?NjhHSEJVbGJFK3kxbFZERjNxZFFDRFhtZnIwSFF3UmR3V2daSzFTQkdhaDh6?=
 =?utf-8?B?TXNhMHFhWVZad2dLQ2ljYUUyRXdwc3ZtSldickFQQ3NkQU93S2FaSks4aGtQ?=
 =?utf-8?B?WnF6RUxlK29NZkxQYUc4NVE4MVYwTVNDR04vUjAxMFFtMFM5UWVwWVFXS1Rq?=
 =?utf-8?B?eHdVNW9yUS8vMlVJZGxua1N4aklDNWFEZ0NXVGpOd1NSQUp4VDQrcElaRXQz?=
 =?utf-8?B?RC9iZnNubEZMQlB5QWQ3T2xHMysvYWM5TU54ZkRhR3diVkw3bjVRbWM2VWFU?=
 =?utf-8?B?eUNjcW9PaGFGdklrWXp2ZzBWL3NoSlFRd3lsZjZ6WU9XdTIrMjNDYlF4alFQ?=
 =?utf-8?B?UUcxZ3Q1bmZrL0tyYnVsMGx6cmtsbWo2M0lpbEtVLytMRTZMdURUalNOYndx?=
 =?utf-8?B?WVlScTFBTkJCQ1NzUGNaZitNQVRsRG4vUlp5ck9EV252UjNMdmJ4Rk1kd3pa?=
 =?utf-8?B?SW5zT0J4aWVTdWhQc2xZeThKWW92OTV5S2RPZkFxMFJlVDhlYnBLTlRUZisw?=
 =?utf-8?B?WVptTUh0T0M5eVFFKzh2YkJtVDZFV1hNbm1mbzFUai9HUzhmWTZLcVhEZFJM?=
 =?utf-8?B?Tm1zVEd1bzJ1UldIcmNYWmxINCtkQVRCZGZkUHY2UWVERDNiazJjZ2Y1QndI?=
 =?utf-8?B?TDl6QWxiTExaT1lHMldHd0hpRGdXT0syV2l3cnJ2NHdXUHUyZUMrang5L2Ns?=
 =?utf-8?B?YmVYbGEwUTFOVitnMVJCMlBCMXlYRk1keFZNZUpEVksrSjFLU2lNTTBXUlZz?=
 =?utf-8?B?QkNjeWM2dlhkSnY5WXBCUHp6REc0bm9aWG0xVFJybWlXMGdlZmI2ZDFSYXhZ?=
 =?utf-8?B?OWQ0RzhHTjJLYjVrRVlMRnpOeXBwSHdZQ1JRYy9pOEtkZnkvaVZRa3Y0K1Fk?=
 =?utf-8?B?WmJNaXc1eC8zUUEvdy96ck9zeFZlVUZMWEpvRWRXWEVuQ3dDNjNmcHdhZS9B?=
 =?utf-8?B?UmRCWFFnSGJpaVBWY08zc2VzYmt5YzQzMU93bWFWVndQckNkMlp4T1IybG1R?=
 =?utf-8?B?TjltemIzaUFLdUhxS2tkajUrbGVYV2cyWVRpUWdaQm9CQ3d4RkkzRStzQXBv?=
 =?utf-8?B?Z295MHVIWEFUNTk3TWlwTFVrbDdiajdXb2ZMK3B2dkxKSi9NNml6MjVtbUJy?=
 =?utf-8?B?RHdjVlBYZzN1M0NJbWluOTY2SFQ5RVcxN1ArVGl4bzVvd0lUQ2gxazVpcnpF?=
 =?utf-8?B?bmgwakRlOVVxWXBoUnJMK001bVJqeGg2NGF5VDRQdTlTdExra3E1d2xiTFU0?=
 =?utf-8?B?cU01b3RFSWF2YWtwL05JRXUwemxqa1NSZ0kyK3JEUnliRTVKOG9TcVB2eHdT?=
 =?utf-8?B?eTZMY2hPV0Zaak95eG4rNGxxYzBNZU80KzhuaXlUaGFMN0RSV0VSSStzQmcz?=
 =?utf-8?B?eWsrSXR2ZHJEWWtDRHlBYnlNZGxIUFhlcHIxdE1rSjk0czFKSDNzcjgyd3ZH?=
 =?utf-8?B?U3k4QmRQZWpZMjBFZWgzTWhIUnRPb1Jlekc5R1d2RVZ6bXF3My9POG1RUmxw?=
 =?utf-8?B?SXR4V3NIRGxJVWtqTGdScjUyc3Y2Y0JyOWRMOGlJMXlDZmY3RnNwVUR1ZDZ2?=
 =?utf-8?B?V1VqMUxiWS9lVTdvZERGTUE5bDFZeE1JNTVZUkNUTEJoY05mZnBHbWNYOGY2?=
 =?utf-8?B?aXM2eW83N3hqNlBnditJUnp1WEhxbkNvUFJUcTlleHNuWVBKUUMyUVNiN1Ew?=
 =?utf-8?B?bURNOUpmNk5Wd3VPQmFLblgvdnB3YVdENHYyV3NZMCtVMENuN0t0Qm5haWNt?=
 =?utf-8?B?a1RYN0pQLys3aVQxM2pDK3JrUi9aRzFBQlNSWGVDelBlMXp3TGRpSm1MZ01V?=
 =?utf-8?B?YVU2c2dKYm1KODRQZFBES3ZGdlcycDZTcGY5M09LWUFMak9kTklHSDJNQXJS?=
 =?utf-8?B?RnJsdlp3bUY2SWRPK0NzOUk1KzNVNVpuWW16a1FCbVFUaldDVUZWUEJiQW5m?=
 =?utf-8?B?TVUrRGVJV3RQK0dBT2VsWjI0WExxdXc2MHp5VjJaUDZyTlVxZnhIdXhjRXBD?=
 =?utf-8?B?bWVhLzRFYW12VVR4L2JlbkVvUjhHOWZhRVFLVGp3SlZSb3RScDZXemVrcHRa?=
 =?utf-8?B?Y2ltLzNON1hST1hIN2xiOGVpN2RVNThnRzMrTjhwTHlSOVR0TUxyZVpyNEdV?=
 =?utf-8?B?R1o0NkwrRzJtSU11eGlPRkpjN21sSGQrbEhnYUZnc1dLc0V2a3YxQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce4950-17d7-4b30-6b6b-08d9a82172c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 10:19:46.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wswi+YuJAxGHRh4USPlK25lYIyi2UrnsteiHv2ktBdUqHd7kXLZnmQ8bCm99VZbyn+iY0WbK609UI284N37gD05IpL3+9boILjHhLjH/4Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3931
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.11.2021 10:52, Danilo wrote:
>Hello, and thanks for your work to support signing git commits/tags with SSH keys!
>
>I tries this feature with git version 2.34.0-rc2. Here's some feedback from my first use:
>
>- To find out how this feature is used, I used "man git commit" and searched for "ssh". However, no result showed up. Maybe the manpage could be expanded to include a mention of other signing methods in the documentation for the "-S" command? For example, something like this:
>
>    2,4c2,5
>    <            GPG-sign commits. The keyid argument is optional and defaults to the
>    <            committer identity; if specified, it must be stuck to the option without a
>    <            space.  --no-gpg-sign is useful to countermand both commit.gpgSign
>    ---
>    >            Sign commits with GPG or another method like SSH (see `gpg.format` config).
>    >            The keyid argument is optional and defaults to the committer identity; if
>    >            specified, it must be stuck to the option without a space.
>    >            --no-gpg-sign is useful to countermand both commit.gpgSign
>
>- When I tried to sign a commit with my SSH key, I got this error message:
>
>    $ git commit -S -m "Release v${VERSION}"
>    error: Load key "/tmp/.git_signing_key_tmpvhKT9L": invalid format?
>
>    fatal: failed to write commit object
>
>This message was very confusing to me, because the SSH key format in "user.signingkey" was correct. In the end it turns out that I had loaded a few SSH keys into the key agent, but not this one. Could this situation be detected, to show a message like "No private key available for signing key X"?
>
>- If `gpg.ssh.allowedSignersFile` is not set, `git log --show-signature` will show a "No signature" error message next to the commit. However, this isn't true, there is a signature but it cannot be verified. Maybe the error message should be updated to reflect this?
>
>- If `gpg.ssh.allowedSignersFile` is set to an empty file, the error message in `git log --show-signature` includes "sig_find_principals: sshsig_find_principal: unexpected internal error^M". First of all, the message seems to include a stray "^M", and it could be updated to show the same output as when the file contains signers, but none of them matches ("No principal matched").
>
>That's it from me, I hope this feedback can be useful!
>Danilo

Hi Danilo,
thank you for your feedback. I will search through the docs and see if I
can make improvements like the one you suggested. Unfortunately the flag
themselves are often named --gpg-sign / commit.gpgSign which we can't
change. We might add a new, more generically named flag & config as an
alias to these in the future.

Regarding the error messages I quite agree with you and had similar
feedback with our internal testers. These error messages (invalid format
& unexpected internal error) originate from ssh-keygen. I already
checked if we can improve these but its not easy since those come from
quite deep within ssh library code :/. I'll see what i can do, but since
this changes ssh-keygen behaviour I'm not sure how well received changes
like this would be.

When you say `gpg.ssh.allowedSigners` is not set is the option not
present? or is it empty? The code should actually trigger
`error(_("gpg.ssh.allowedSignersFile needs to be configured and exist
for ssh signature verification"));` in this case.

Kind regards,
Fabian
