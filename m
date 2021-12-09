Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BCC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhLISPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:15:38 -0500
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:3508
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237501AbhLISPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:15:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hboSklvwOYAkjjdvFpsce5iezyXyGlQmnKbgflCIhzlgehfnKcPJN2HfvcsBY1KZ8Vpufs+3Sy4qmW6Qd6JtvnebDujGNYLSgD6ahWVduK1W9HPR3+QY9g6cQHvzR584sF7vg4f8MpOJlJvykCaEm9gBE+4pisN4EBofFHgcmaiwqOAFNAJKfFcOOgPeOJ7pg0051OeSo7ZZYLFR4cn2Lfs92396WT4HxJNw5mdvmTC340rmghNuyp0HTHq91dC4Zw5kSW/K0OACB4ufI6YxkcOejkMdx9/dmQ9qMovPAK9//qOd9N2j2QnPGDyNaauaNyMsm0fcrC0r8ETZFh6iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ6LBD0iwdnC8v+1YKVGC/cqekyd91BzevsvuyLVTOE=;
 b=XZqplPgjMMJysIuvqcyBrvVyQioLayVsQ7Mm+470hhgpotz15tJulXxSvD/kl92g7JoSpAgRT/vRu+PHNwjoLFA4Ejc4qJK+UOdXHy487N9hoEUrz7T6FHwK9fiXO8AVLoo1i4m9KwWaTAaAguFPkMg3sGDpb4Fv94VThQ0bcF6I2dk0QQ9EB1I7dxWAGW3QEspiHI6DX+lcHydpXxGil29xlH7LkA/oGAEMFT8igC4eERyKGUbuSSP5bTi5MCIyCOqutvsBMtk1uzobFRGYaEwXDiVgYNTsRFoJfBeU6900y39uvWRlS+qLuMZfRcxZBMZmBYYqsB1lvSsVjNK4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ6LBD0iwdnC8v+1YKVGC/cqekyd91BzevsvuyLVTOE=;
 b=feAAQUNIyuzys3hyjWD4Y5Tu/zofEpft4oLlUkH10lPONghO71QcNYFyjTGno8fbvxOPefEtTCASnDJVMFBlweiYJoppBWVAgpYQzDbGI/HW2O7nfck6EoW0xG59NWF5WEDGXOwt9snQkxJecpnLvx2ipG+aTVK/+kZFlu5gsU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 18:11:59 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 18:11:59 +0000
Date:   Thu, 9 Dec 2021 19:11:58 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Naomi Elstein <naomi.els@omerkatz.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug - SSH commit signing
Message-ID: <20211209181158.le2jsvpon4zbj2xn@fs>
References: <CANCdVxBSeR=CnEBxS341tbs_hVRB=Hwmyc4eM=zbREm+Zz8BSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CANCdVxBSeR=CnEBxS341tbs_hVRB=Hwmyc4eM=zbREm+Zz8BSA@mail.gmail.com>
X-ClientProxiedBy: AM6PR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::47) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6PR01CA0070.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 18:11:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 235e03cb-5036-4d7f-64c4-08d9bb3f649f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3770:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB37708F7F74125ECDC2173C7EB6709@PR3PR10MB3770.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDahTAEetJTBLWUEVTdlPly++MbsXTsx4Ur3VWB970HZt/uW+3L1KmO09y+fBHLw6NFdZnwhs+e3xLdNxeY8AKzSbRB9opRuQAcUDe2vjFU5vCVpapAF37i+X+7RUiI/8DrceWWbyT5iw6dxCjIsBrflyHt7YDpTwlmZNhFeGWHGpoe3Yfms4NbHJ+zwG0RYloftOuQ9wPy5527YwAWg34VaR4ehXZExpt9xQlqgfqOZ/UMrHtl46bjYboY0ZR9xm4ydp5o1Cer3oYa7yfIMvyB5m8wDyC9oEszgU4HGdf13XhEgfXZTEUNfOu/i14wPPY52zCz+lV1rUsnIXB2HM5ZlS84FrsFU//59L0SWCiooBBGLEVkN+I/Unolus4/kor0wAt3CAblD76hyIKAUdPRyPz2FFdwk5myn/M+FwtvZ0761rXSzCQCbvRUGR68zTBno9C64ELO0Wl17S175BH0ruNHodC2cf00nnDBln8gH//q0QZ0aHiEhEYStot6rk37pPL/Ox6ZG3xIuHFfa5dMaGXp9rxoPK6ghiZMmew26dhIeMILZtT8mCO2lN6K1hV7xXScmblrzA9LIXkYyk4QA7YCJG7z6ih1BAcA7Mk34tEAXQCBJHSxot21gRyweLTY6BLRTzHNytPmpZSeYfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(376002)(346002)(39840400004)(136003)(86362001)(1076003)(8676002)(83380400001)(38100700002)(186003)(8936002)(66556008)(508600001)(6486002)(6496006)(4744005)(4326008)(2906002)(316002)(33716001)(53546011)(6916009)(66946007)(9686003)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpEQkVWMFlrak5JT2JNMTNxSlR0MnJwRGpMdWs1b1ZoRkN0S0VLSFRxbC9Z?=
 =?utf-8?B?RGlUYVJQV0ZFbVZsM2IrTmM2VTMwZmk1OGJiRW9WWUxFU1RUQW0reDRHaWlC?=
 =?utf-8?B?WklXMGFFSGV0cmpwQVc1WDRQc09RV2NoejB5NTNXa1JsVnZnK3FHUlRlckN1?=
 =?utf-8?B?NWVjWHZRODBwQjNmQWVISjdvTGcxR1M4a0NLUEY1dUx2YlhlQWNWM1ZKSFR0?=
 =?utf-8?B?eW9vMlNMcjhrM2g1K2xHOUphaFJtZzRBODBSMk1WTS9mbGw0Rkk1SE1ZUFc1?=
 =?utf-8?B?OC9TV0x4ejdjdnNrelpiRmdkRlpvdktSbDV3K3lZMGJRM0FpVUdESWlFek9q?=
 =?utf-8?B?OUdXdk9obWpWY3dkc1R0N1p5aGZiallzR3pOanhSdHZpNlRYN3h1ZjBmNXlN?=
 =?utf-8?B?STZsWFpUbldlUDNYWGRIMXB1MXJJOUNHTWhSNmVpUWwvaTNGcGtsTXI2QzFQ?=
 =?utf-8?B?NUxOMm5tTW1jaHdRcHVOM3QwMlAyaDV1VGRnd3MvVjNIdlZSb3EzeHdPVW5P?=
 =?utf-8?B?cTU5WGw2QjJJQjhDSUIyQm9UdFRLR240MGdRcGZvSE1BZGFlV1ZUZHBhUGdI?=
 =?utf-8?B?RkhFOFFCenVMNEVnanp2aEM4MmFhSHJ4bHM5SXRxRXRub255MWtiQi9semxj?=
 =?utf-8?B?QUJlM1Z4RVFtWEw5REpPbEJnVmZpSWxmbGNvWTJyejVqSjgzOTRsaXczSFlW?=
 =?utf-8?B?SC9IYWZhZ3VRQkFUbEdwUUdvNFRrMnF3NGdqczJDb29wRnA0K2ZQcFB3R2E2?=
 =?utf-8?B?Ly9JbEhyZk9OUnNXSlRXcXg3a1R5WDZpaXRDb2xRM3hVYnlrQm5Nem1abFBT?=
 =?utf-8?B?RmNqNU9QQVkyQzdFcHdWQ2VWMEhjdlJzaWR0S29MV2pLYzNpWkhEUWQ3SXRX?=
 =?utf-8?B?UDZZcnBxTTlNVXZTVXdvaFBlYTNJTys0SVZUT2JTYzRtYlpLWG5DTERPRmJO?=
 =?utf-8?B?eEk3NXpsb29XcFhpWHkxZXAybkN0ZjlXQ3BBanJ1QzhEdGR5bnl5VWFVRk5K?=
 =?utf-8?B?VVRHS1BLSE0wT2dPSTBobmxaODBxeHNXcGNNSU9LUmlSbUlsdnQyaUhLSkhI?=
 =?utf-8?B?ak50VUp4NTFjcnpTZmFYalNqdlM3NGtqdU5aZHBjOHlvZXBaRjNSVi9hcEFY?=
 =?utf-8?B?Q2xRb3BWOWR2TDBYWjFXUGQ1bmMrWStIT3U1K0VFdW4zVjVHcC9sZHltVVBB?=
 =?utf-8?B?aUUxWUlDZklsOGxLM1RjUTFYL0JPdlZ1dFZmZi9RSWpjbVZ0VUZKYVNkdjNn?=
 =?utf-8?B?RElabENXYlNkeEVRUFJrVExWZldTS3c4S0xKZVNDVEZBZGt4TGlYdis3blBz?=
 =?utf-8?B?WEN1cVpsektmRXFvUmU4bFFVdlorR3MvWDhuM3R0bTg3WUFvc055TXhnS2VB?=
 =?utf-8?B?YXBWWVVnOTNlTXVhOE9IaEVwd1NBcitVQVNQTUxJTHpWOTFUT28wdUVWTDMv?=
 =?utf-8?B?VEcyQVZlWHhGakFxdU0vN01jN3hVS2NtNHhRVStxSUhISlI0bHNuMDlvT2Fp?=
 =?utf-8?B?Nm9oTE1VdmxUQzBEMERJVEZiUmYzdGNSZ3dNd3dQWEtUWmNDcUZQOFNmbXZt?=
 =?utf-8?B?VkJSQVNJekUrd0VqNThTbkVpSVUvWXU3MTF3NDRJRHRwS0VOZHdHYmRVZUxh?=
 =?utf-8?B?TVFJdy9lMEd6N1EwVlNLZERSbmxUTk9sTEw3R25KT1RvcExodTBQbDE1VFZh?=
 =?utf-8?B?VE4weXZPMDZxYmFydER4SGp3UmxqT3dSUE9ITlZzRWNFc2RmMEVWemMyU1NX?=
 =?utf-8?B?cTM2L2tZUDYyT2F2Q0VLYUJBRTJnaEtocUpzZ3J2T1JzQzJhcEh5RmVURU93?=
 =?utf-8?B?Mzlsby9BakFyTVNpNmVhZFVoUW90elVMMUxSUEV3UFBZd0JKZktKSmw4aVVY?=
 =?utf-8?B?WkI3MUdNdzFDaWdLUEp6Y2EyWTByUG9WaTFNSFFTeWNqaVdPQ1hMdDBiMzlj?=
 =?utf-8?B?ak0yT0RMVm9EUS9rNzBxellkcTFCZVBqMm5CR3N4NGpwUFpXS0FtUGI4aTB6?=
 =?utf-8?B?TklwOEluVzdRNW9hamZuVXdUSkoyOElBbmRBSFQ3Lzk2dkJ2ZktNY3Z2VCt2?=
 =?utf-8?B?eFVlckJTSTFaY0o5OUVUbGliUXFoRHpCS2RRYWJzMzhTZ3dlRzR6WlRzQ01C?=
 =?utf-8?B?T0lPSXRldyt4NGttWmlXUnBoc29kQnpQaVZTNEwxbVFsZnVOS0ZBeE1KcTVN?=
 =?utf-8?B?NnRyVm5Tbk9uUk9OUmprKzk0d3pJYVR2VVh6Y0kybjNydzRxSzNhSFFGNHho?=
 =?utf-8?B?bGc3VE1XQzlqNCthM1hwRkV6aUZ1QWhmUzhucnBTVjJOTCtWSWJRVE0xUUQz?=
 =?utf-8?B?TGM2T2VIeHUvVHVuWEM1V1EwYkNCUk5PMmNITU9kZENFODZ0aC9NdENWL2tK?=
 =?utf-8?Q?Nsgtnu9MQlquKl60=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 235e03cb-5036-4d7f-64c4-08d9bb3f649f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 18:11:59.6730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTr2W9IqfKem93fgh1k3cSCrhAGN130C85HLgqhuaZ3f5JXKF6OxIrF65Dk9oRUi7rkiz2ckp+YBuMi+HCmaKlPbnqwxxA5tUpvyDWc+bS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3770
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 19:54, Naomi Elstein wrote:
>For some reason we can't sign commits using an SSH key because the
>public key is not found.
>This may be a configuration problem on our part or a bug in Git's new feature.

Hi Naomi,
a bit more information would be helpful.
  - What was your git command and the actual result?
  - Which version of git and openssh are you using?
  - What did you configure for user.signingKey and any other gpg.* config 
    values.

If you run "git bugreport" you will get a template for a bug report that 
includes most of this and other useful information. I'd encourage you to use 
it to report bugs to git.

-
Fabian
