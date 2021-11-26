Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33356C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhKZRmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:42:21 -0500
Received: from mail-oln040092068068.outbound.protection.outlook.com ([40.92.68.68]:12800
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231775AbhKZRkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 12:40:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3/6qryK460BeLDxpdUKktfiv1DnsLa5NkjeR6HUi9OJJsDZoP/RXvBWJEi4lc2K2raT8rAK2amSTGIAmhwWwxag3841S7FzuA4e0vTOVW8x5nvRDiCC9fEorDMDaGfrY3OZJH4N062CgJrd4YqFDLJES75quGW6pGd1Y4mIaHXgHpgh2P0GUea2mSS5XXJrdJopluFbGmrCgU+ZfKPHpgtvMUAeHEaiY7l+v2RMImmAzO87/AKwOVUc9Sja5NwwEFEmMAKo1z+AsiXmFfwHgBNLKTuMPyzYBTMnJolu5nbZTW4/4cSduhJ29RY04MaD/9/4WSMlaMtoCbwlo4JTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWDpCU/IbH2oJtv/3T0dVyVoepwZvphDhI7VYd+GCYc=;
 b=QvBQVyDR28BgDSh8w+nEnprQHPdqqpzu+bj7luOW3sI+atJwRQ6LSCq51Qt1qlUurDRezfSjzJq/MxCFlHatLbYy/kshBh74CShUXVGME5ows8eHldriyMy0OFUKH2aoP9FWTGQGKy7wwkwH7z/oqLBHh6TLKSYvtEUt5t4zjsAMG2C1AmMe0dXw/LZLHm9NbffnxoOW4cfMC1peR6nA/U7SzPQKsAAgt4jRjZPVie2Q6HrHo50EMqhY1yWWy34qw4YFFaWB9tC8TxDXfzdVRaMsONHvIRmE+RBGUHD+oYu4aXpZkXDBkBQgB+FUIHiqga7SYCuLy6SPy9P8cdBVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB6225.eurprd04.prod.outlook.com (2603:10a6:208:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 17:37:06 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::2d2f:78e3:4b3d:8cc4]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::2d2f:78e3:4b3d:8cc4%3]) with mapi id 15.20.4734.022; Fri, 26 Nov 2021
 17:37:06 +0000
Date:   Fri, 26 Nov 2021 18:37:04 +0100 (CET)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
In-Reply-To: <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
Message-ID: <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com> <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com> <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN:  [DWNJTRBdgn/FrhqKraVSQdWaf2+sBkS1kcfEZiclBaOp9lq1+j+SookdTrIaGYc0]
X-ClientProxiedBy: AM6P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::15) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <37b13c26-13c-2c9e-5cfd-b574b0ca66be@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from p200300d3bf0f730028527554ee46ec16.dip0.t-ipconnect.de (2003:d3:bf0f:7300:2852:7554:ee46:ec16) by AM6P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 17:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acc608b-1bfd-4d6a-0852-08d9b1035d1f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6225:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub4fkAA5yMDIVS1GkQmfAILFeFILa3KMCRkGiHMSPp3VbQykRGxs2R3ou/F8s3gmK/QVni6WrBpr3I3DAi5ldVZiZm9WKbgdkKPZt891JOW0jkGgmLxAo6UTDfXLfxEf4SInPoBvL9GKRs8OGTBN1NS/SsBfDC1Lx6FPwmeWr+cWuyCSPOn08Mb92hpGBKOXII7LXi/szrB84Z6RWzyvLBuktVR7LPKnlBPofwViARNUKr4/KbKc+4Dc9YtvqVVhcB1IlaAJrvvsk0eKHHypRKqTkeUoteBcQeXwKIw7e7eTxcq1ZIieF/TesMW6FBvArOaDJDjy3crdjSvdagEq/jRsJHqdwNP6uUuSmNXdSNp/m/4gJApHVX5X50aUlm28ppWtihXlKUTWax2HMg3kB4MfqnFAAmd/Sd8N3rjHsMHi24mz2VAYUmwExoo2G0O6AicLy87EW9vcFmSKEqIOF3tpX1jZqlhTMcJ2pkY3+V9LKfjhdTYVAw831lqyWPblrtMqQLYrPzbziBWa6lZl0fwlBldsNdWnpsjFu5ToPhUz+OsQirSdvnsb6c2n/fZf0ASk24U1eRsdu34vd4+Iwg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnIsq79YgEtzv9hJQ7Ak/Tj/e6BaCtDTKOsXwLQHkJRfGH5c9bEq5TRjxivp?=
 =?us-ascii?Q?M2COOh255xtCr2dIJ2KQxw9Sj9/y87927SBdA7I85fSu47LLJRLV2jwawGLz?=
 =?us-ascii?Q?TLR1mrlFwzxAs/dQNYrYqAXFwhVnPemC3OMVKad+0BIIKZFI+povQg302FYo?=
 =?us-ascii?Q?bajS+j/ujnQXPTRIOO4WPrq8Coq1oNRtH8CLm+2EW4AYguFYDapk/fe0B3t6?=
 =?us-ascii?Q?Zsc140QU4fws5lzNkmDngFEBzQFp3JxVh+Eiksvj5faAnA8YcZSkYftV6yxZ?=
 =?us-ascii?Q?WfCyVe/lr6a9Y5tDcdeq8oWxrfbWmwjeuUfjibM67ZE03+smD9cAumuqejNP?=
 =?us-ascii?Q?4qodnTRj5LyisceR4/94wbJF72K4z7TT2WhH3xE+05o+vRRlxpzz7Eav72cn?=
 =?us-ascii?Q?mz/zw2V5slhDp67c11SgxNsEA941f/d+n/8mmYYuuiaSWX1Kde5q406lYB5N?=
 =?us-ascii?Q?lbedP53CuXzE0c/+/jDEUlaBJ054nIBLNktf8h532EcgykvaKfHLxzD8MLIy?=
 =?us-ascii?Q?F/1nNLKoTiocrt/mQXAgZ5i0ZCaVbfZx/nYIT/V6jMQQb9a6NgFp55+GregQ?=
 =?us-ascii?Q?zzoYuSrnyoe4DEN3jsO1oxlOZ1tQ5vYV/gWo3BFkbHaAd4LwJREpyOH4bLrH?=
 =?us-ascii?Q?swn8SBiydkXomsPdfmqgq4e2XtrgZBFhEqlnoyElny9SuNReTEokhK9qL0Ge?=
 =?us-ascii?Q?25ZzCgyf7DqUDF61Ia3wjuX3pj2pL683qhDmGan643eJYTa2kaIhXLiSJBFj?=
 =?us-ascii?Q?uWyyrd5ZDmC/eL0dg/ilw+p2SHLB6pwtVNXUDYw6P4OmREAWJ+PjWQaEaEwp?=
 =?us-ascii?Q?0W74LBG7/2f8ZFPiF7l+ggJWboibvJTBLnh3mRy5eJo1E7ivUNom49GjMCJH?=
 =?us-ascii?Q?d46Luh8Wc+1vv2TFOzrTrmTzX7ERE3LYBdQx+v+wBX4KYGR9WwT3vL2+mBRF?=
 =?us-ascii?Q?mqJPB4caMVMQ/M3XhuGhWWy28PCFRgfIohzLGGpHxBtB/xEUVu2/5OHIivIa?=
 =?us-ascii?Q?xEx7KJ2dkzZeTc4jk2sv8i+AQA=3D=3D?=
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-adf9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acc608b-1bfd-4d6a-0852-08d9b1035d1f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 17:37:05.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6225
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, 26 Nov 2021, Johannes Schindelin wrote:

> Hi,
>

[...]

> One thing I had not thought of earlier: do we really want to do this in
> every fork of git/git? I know for a fact that microsoft/git has a very
> different workflow upon pushing a tag.
>
> So maybe we need something like this, too:
>
>   create-gh-release:
> +    if: github.repository == 'git/git'
>     name: Create a new release or update an existing release in the GitHub repository

I think you're right. This would have unidesirable side effects if it ran 
in forks.

>
> Ciao,
> Dscho
>

Best regards

Matthias
