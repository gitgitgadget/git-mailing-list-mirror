Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E81AC4320E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB8D610A6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHRSLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:11:48 -0400
Received: from mail-am6eur05olkn2028.outbound.protection.outlook.com ([40.92.91.28]:61984
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229522AbhHRSLo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhqvxV14pgvhN1NyHy7wwCqsOG1+cy+y2SeSvx0W8SbwjY8Ye0a+YbIs3koQAaPuUi0p4S5BeFpgnWEb5WjNnkLcXotVQy/q7JMx/Zixd25SgLTL6PRdRI/3+74iSvbIFzblhS1pX4pyPlXor+82jYm23BPD0+miQN5XAaMpXmXDIXf42Qydg2/5bHWM17LIhUFVOL7kbOJRvbCRAcTYzv1HphlrFJUZv29EJm/I7k5aR0RxH02XJnkqajwhKJvn/imAKx69EybRmBrZ/EZaBfgCev/3iX6/hpMN38NVpSdW1nLK+ZsYbzDeg4d0PeY2K+GbIJpboesp6cRUpG02JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q6cLISQMYe/n/mnhScZ56qmnOjOtoafzJK2mN0XXQ4=;
 b=DiLKZiKmed50DcKlJw8nfgIDvEXSpDzb10M+IRODWkNLI0HkMdJR4suBrXs8FkypSBTuNg/SCAVwN7l5Jo1rsiJ35eUxG2JdpQpGUOjf7WCs+4RMQnfOJRDYuvyxPfy96eJ8I5mcj183zcw0UYex5RSazOgCXVZk4Bzdcp6iwVDhZjTjONaLt5QtIaP0KSpG+tVZzfK+6xvcpHaevK8IaeoOpaKwTFuPPh5sxzWZDGdn3xgWRrIGXoUP2Ys3GzyakENsX00+aQ5lrAiI1bvljGINvFAHUV5edlzrqiXKr6e0mwKgh9ddxDFl3XjeraM1YkxU4A9zzb/zNXzQjeVKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR05FT010.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::52) by
 VI1EUR05HT191.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::322)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 18:11:06 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 (2a01:111:e400:fc12::4e) by VI1EUR05FT010.mail.protection.outlook.com
 (2a01:111:e400:fc12::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 18:11:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:594BC99E3BCDACC1D8C912834CF1571C3DB7DD39C7D5A0D99AD96DD3E154ADF4;UpperCasedChecksum:8FB80C01F89B6F1856404710FB03945C38D59A3A666875E6B926C94DB039D6F4;SizeAsReceived:7522;Count:45
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::501b:b90:d003:6a6a]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::501b:b90:d003:6a6a%6]) with mapi id 15.20.4436.019; Wed, 18 Aug 2021
 18:11:06 +0000
Date:   Wed, 18 Aug 2021 20:11:06 +0200 (CEST)
From:   mha1993@live.de
To:     yan ke <yanke131415@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <dscho@gmx.de>
Subject: Re: gitk translate msg files not installed correctly
In-Reply-To: <CAJosSJ5FZGp6PtUVgq2o7+vxV5jeO=i+nJiXJE5V6wRX-NVfDg@mail.gmail.com>
Message-ID: <AM0PR04MB6019F70DD022BE2E8FDADC4BA5FF9@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <CAJosSJ5FZGp6PtUVgq2o7+vxV5jeO=i+nJiXJE5V6wRX-NVfDg@mail.gmail.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-TMN:  [ICLjI9LjteUk0vjtdD3DSnAlqQ0WFhfjzcbPvDiGR3+n/dWYoYpA2LqGs94yY9hG]
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <624e56bf-a12-856a-f248-5f97c5b2ed@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from x1c3-2.fritz.box (2003:d3:bf17:4900:35c2:b5df:8716:499d) by AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 18:11:06 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6f25bde0-5b6b-4f6d-898d-08d962738c5c
X-MS-TrafficTypeDiagnostic: VI1EUR05HT191:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNhtkXx/uKqe6zEHwdZ4yzHmcTqARQiNLSZNGjFqxD5mUkfE6MMQOv1+B+d4fnOmo7cI5dMbRMRIA1q2m470DgHOq+KgD10g6u19WKxaxxdsSvzfnB2spbzRnFjyKdvkOEa3pV2sbWYoklSecqI+5nsWduEDo+ed4w4a74cFl0E3ULbiAr79jbXs44xDYFe/Hte0jTHOdQQvx2OgHmEEzQpjmlXinnl+ktQcRnuPDWBJMIwkwpNZEridZ5XxPKCrw9ucibY4qT1hzXUOOnDS4bNFby3GD9WCTxqcfWcq4GiU2CmhMKkPEkf1jz+zZMTyMs7M6fPyczEj2QgAZCkH5hlbGs6nXOetGmzAzYaBkktsfsgVRxtYYTA4/wWX+U1AeBsYghcD74DwGv5+FnnxLqI5DZcnwoEtoz+DG/wouo64qgnsPCzi2TqdscVlx2TULm/peH/zY2poI+gvQzhoqjyoT7v6HPGGRB87X+7eu+E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E1McPhQLBbitPs0nR+X3QR4/vSsK+idUlsIs0ZrjdfC92wp1XVhJ5oKIKzxLmRHhOn3E6eS9ZSKp4jLlSNctgMGncvOFpaMy8y262Cq+8ML2mFbshNDTdsCPk5o60PAvwyKMhte5cx8OcxkxQU3NKy+PWHDiNulPy40Eh5uSPKkW6EFfJb9PxHJD/PPjew2vYUUZJw5b6sNKoDWN3JY0HQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f25bde0-5b6b-4f6d-898d-08d962738c5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 18:11:06.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT191
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Aug 2021, yan ke wrote:

> Hi all,
> I found a problem with the gitk translation msg file in windows, the
> details are below:
> 1. The default gitk msg dir in windows is
> [git_install_dir]\mingw64\share\gitk\lib\msgs, but the install process
> does not install gitk msgs, no that dir exists
> 2. I use innoextract to unpack the git windows install
> file(Git-2.33.0-64-bit.exe ), and I find that the gitk translate msg
> files are not in the package ,is this correct?
>

Yes, Git for Windows intentionally doesn't ship l10n files [1]. There have 
been a few requests for installers with l10n in 2015 [2][3][4][5][6] and 
2016 [7][8], but not much ever happened there. The Git for Windows installer
can be built with l10n [9], but that doesn't seem to currently include the
files for gitk or git-gui.

[1] https://github.com/git-for-windows/build-extra/commit/ed79a9d8206cea8055e5226af068db700e0d6fc8
[2] https://github.com/git-for-windows/git/issues/378
[3] https://github.com/git-for-windows/git/issues/386
[4] https://github.com/git-for-windows/git/issues/403
[5] https://github.com/git-for-windows/git/issues/496
[6] https://github.com/git-for-windows/git/issues/584
[7] https://github.com/git-for-windows/git/issues/648
[8] https://github.com/git-for-windows/git/issues/724
[9] https://github.com/git-for-windows/build-extra/commit/f54833da8b71fc6f55e120881c891cd7ae5f530d

> So I think the gitk translation in windows does not work correctly, or
> something i find is wrong?
>
