Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C3C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B8560EE5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbhIMQSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:18:24 -0400
Received: from mail-oln040092065069.outbound.protection.outlook.com ([40.92.65.69]:5131
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbhIMQSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 12:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJDAXSsAJ4wkkmK4ZOMmPqIZoqJfvArGUt3g20e2+DgcAF4usEQSAxGc5/GxdLrl2ixZZci8WQXCrOftPCteW2x/ZjvQTGDosB+10kUoLdWvAdlYdfzaCsMY9CGgPfF4GX2Mf+7BiVPXAJTr54MRNKMgPHHRgc7I8Xj18IQ4xFhljGeXN5U1Kc+OIlc2SQUF0FeJjTaogvXICSDOOIwr21lcMod6zYoqiMNbzHcl7umIv/RxvR+0hMyOHoAROKWKe8BnMlOBFlYlzstnV7UCJ7xZvNxpIyT0rHhdQDynLcTVK1QOMrYTdU/MrjVSV7l51IquBYp0ey6BfP/Rfk86QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9NNfREhny+uSuVV6GHNE/PpO3kR1CvMeieDQsqFHfrk=;
 b=Z9FtDbebnA1GxRqp9/hjzq0RMx0VkVMmb08lJh71KVF8uquaWBSMink3ZYLGY91yYikR9bPX2t2hSqaJFIOoIiuYzVz2W/zxZV4NjqPumvbR3nMDGOipSYW7YO6yv3DhtwqGjwYZ2bj8Uqq5b6KB7jWC1ZRUmhgJNJAlYaAIM4Y3489w2tulY9BXNw69wDT473Hs7q2TkDh/a7C/wOXN+TcIuzJUrVvot6N7OIMftcs0p4oK/etYxiJwBs01Ma1RxvTXUn3Wpjki/Aku9WQB8Ze56tTte0htMjXFcPN4xeTv7Cou4/n0aJwVN3kltCQQNAIfk4UCDz+ae332Tx99nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 16:17:04 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::88f1:d597:1caa:2a31]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::88f1:d597:1caa:2a31%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 16:17:04 +0000
Date:   Mon, 13 Sep 2021 18:17:01 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH 1/2] help: make sure local html page exists before calling
 external processes
In-Reply-To: <CAPig+cS=fhE1Dm1ESps8SME9XO2+RPJ7LGtquuZQ5XPFB1uk3Q@mail.gmail.com>
Message-ID: <AM0PR04MB6019F785D38C7F8B4F66BC08A5D99@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com> <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com> <CAPig+cS=fhE1Dm1ESps8SME9XO2+RPJ7LGtquuZQ5XPFB1uk3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [ZfYNzDBDr0sop9mKj+Qi6iNlh305mSW2fJ2PaVZsN8XdbWriAyBq4a0f4RejzvNQ]
X-ClientProxiedBy: PR3PR09CA0021.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::26) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <99729ed7-5d18-bcc9-968d-cc68fbbdd5e@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from p200300d3bf2b1700454aa355d13d3d86.dip0.t-ipconnect.de (2003:d3:bf2b:1700:454a:a355:d13d:3d86) by PR3PR09CA0021.eurprd09.prod.outlook.com (2603:10a6:102:b7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 16:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6317dada-248f-4f34-04af-08d976d1ecae
X-MS-TrafficTypeDiagnostic: AM0PR04MB6819:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hNDJeqlyphrT2PS+BxmD405WRTISwAoN6IUAPSqhafuba9FHR4XHl/cryNKPgWaDln8rnswg0Qd92DjVGo7ISvRHePat6Aw/qDxij7S1JMs+ogQU+rxmf6J6t11kK0rn2G1epFdN9T8R5bXVpxVZzDCufwhjuPgcjyUZtKUkNHxORJHshXE/O4TZ8bpBCI9l6vDweHIGJgYTRiTECO/hf/q5R1zCT96Ot/vZhVTyLzBzqP2je+K3+e4EQut/fgTgruVf52wXsrnm6qAhhp0Cbsfy6uODGrXSP3KIVsJJLY4rmqqdKeBdWDT/9N7jG3dUbLgiFkUE+FjI+mKWtkyP819DOMr5f8MXPVRIc0IRn27eIlzLJFjL4LogLEFvpEDo/eFmsB4FIe2s0NPH03Ixb5yywFKCS48D3oEqdznc0gLbU+uONRPwRhsE3Jgc8J3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AEV9QctyflQJVZ78wSaO7wXcaO+cyKI57oC7h8LhdjRo1w01Sx2CfmV4dOXGwiVeGYtUk4bdHeDa0WLQS+oh9+cezItUKUihKWuzpKt1g6FO5oEJ0I5SLhbxr1bT7qx1sy9B70HBDdRXHSv3JNmkJbhGz4+MeQRfBBIp6+QxqWVndxBq04ReSWIYAr/A3e1cq6Qxpj6Vg2kFAbr6S27VdA==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-adf9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6317dada-248f-4f34-04af-08d976d1ecae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:17:04.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, 13 Sep 2021, Eric Sunshine wrote:

> On Mon, Sep 13, 2021 at 7:07 AM Matthias Aßhauer via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> We already check that git.html exists, regardless of the page the user wants
>> to open. Additionally checking wether the requested page exists gives us a
>
> s/wether/whether/
>
>> smoother user experience when it doesn't.
>
>> When calling a git command and there is an error, most users reasonably expect
>> git to produce an error message on the standard error stream, but in this case
>> we pass the filepath to git web--browse wich passes it on to a browser (or a
>
> s/wich/which/
>
>> helper programm like xdg-open or start that should in turn open a browser)
>
> s/programm/program/
>
>> without any error and many GUI based browsers or helpers won't output such a
>> message onto the standard error stream.
>>
>> Especialy the helper programs tend to show the corresponding error message in
>
> s/Especialy/Especially/
>
>> a message box and wait for user input before exiting. This leaves users in
>> interactive console sessions without an error message in their console,
>> without a console prompt and without the help page they expected.
>>
>> The performance cost of the additional stat should be negliggible compared to
>
> s/negliggible/negligible/
>
>> the two or more pocesses that we spawn after the checks.
>
> s/pocesses/processes/
>
>> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
>

Thank you for pointing out this embarrassing amount of typos.
I've fixed them for the next version.

Best regards

Matthias
