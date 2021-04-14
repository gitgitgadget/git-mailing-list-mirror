Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7377DC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367A061164
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 17:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDNRSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:18:14 -0400
Received: from mail-eopbgr640109.outbound.protection.outlook.com ([40.107.64.109]:31712
        "EHLO NAM06-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349715AbhDNRSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 13:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMYY3wxEIHtGwEUJOsBVbObYWeGwoASR46HRS7pxtEEf+eELE77EvfnQXn0KMls454AnOczqX93DakQxjyTeLIn/qXOBGO9UIKEqsHQGdO42v+98+b/L8QSXmbRQpkndfxFCHdtGZR1aRLU+HBxNUq2l1OAqKFYtAQzBT9y1ON06Djy4VD6ypVAwUnxtRwcpn8ltQeO0ZZwdO0kxX1ynAiYIq/NEJ06URqysVYBfp5sKUbMpo/AVNtc+tvEO6mGwtnaGQB3zHQ+JHLIcqPqCXPscJgmfZeRA4u56+RQtUM3Ib4HYPdzbPsIWvfg/w3lhaGItrk4CzRswXk6ss6zk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i1gzIrrGWZ6/xfS0aTgPBWiXcXMlXeIBPWieanHaqE=;
 b=fXEQ0e+XcylsBSVH7DPYv94LCGirJTq9WlLyP4+/8lNesqVmMXk7U/BenMIvjAzJxXQJ4pi3ywg1mmEr6k54AyLUlsYfBm0Cyw2OAI3LJFPZFAELRv4IVxCsCDBQhHzY0n2fjI/NlHf/EojG9KyuEwSeypg7UOr53zuutwoAcqxhv/udAOMWT+g7+t08CZLvZI2ImRFmE5qsH4CWL2NV3EzTJ6TDif8zDYqbORqbWAEV6ghCIJ7TvV0jsPSKHp6A0q0BkgI+56tBQ5x2VY+fJrjN21NuVIlI0wZDmqEICwwHqswiu/PJ+kaaLpbgKDzvJCz0YkBS4TCJsLJICsF0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i1gzIrrGWZ6/xfS0aTgPBWiXcXMlXeIBPWieanHaqE=;
 b=Qu5l7pIFvuOcVJhN7RcrOTRmlXH9DHZW/n3xcm2LeGJxL2CZUlwtiKDlD9FANcpHC7lX3ecGMfLma0pEZx/ELDWyS3JKLp78FwqIVz5cZDiHnnq4aqf2am7XO0QNMA9yRQdwROXrpYnW6y2xknUdoxTocVAMthu5pDyfdm7F2P0=
Received: from DM6PR00MB0682.namprd00.prod.outlook.com (2603:10b6:5:213::24)
 by DM6PR00MB0667.namprd00.prod.outlook.com (2603:10b6:5:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4080.0; Wed, 14 Apr
 2021 17:17:46 +0000
Received: from DM6PR00MB0682.namprd00.prod.outlook.com
 ([fe80::11f6:7865:5561:ce91]) by DM6PR00MB0682.namprd00.prod.outlook.com
 ([fe80::11f6:7865:5561:ce91%7]) with mapi id 15.20.4084.000; Wed, 14 Apr 2021
 17:17:46 +0000
From:   Jason Gore <Jason.Gore@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git clean enumerates ignored directories (since 2.27)
Thread-Topic: Git clean enumerates ignored directories (since 2.27)
Thread-Index: AdcxUgqlSmq2pC0fTZ2/uCXJJ9dNuA==
Date:   Wed, 14 Apr 2021 17:17:46 +0000
Message-ID: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf501e98-9e3d-41f3-9c21-70c34ba5e63e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-14T17:16:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [23.252.49.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35b91b72-692f-4ea5-3fcd-08d8ff6938d6
x-ms-traffictypediagnostic: DM6PR00MB0667:
x-microsoft-antispam-prvs: <DM6PR00MB0667725A817FFDB0139886C9894E9@DM6PR00MB0667.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elok8ZM4245VNO/9ukUaZu7mEYG61xVof2wqTCOJ1DZhOLRFL3/6T6vqUv4lO4aEQ2tx+ELrlDBLcqcfnm1+snZtcj7l5O4uTLr0jtORnWAkDWckb+WpDxARkCr5MwHwcRs+INnwNnNAeUZ4BGk+Gs2zGbq34gnfwSslrLlxfL0fNyJH/PES2YnXnmIzUgDGiK7uqTFEy4ID9ffJAFxHwbRBcrHxkTRf3asKINDNC6yp+v53txcdkQHPiZFsvL7xnVJYbNgMj3hRKDIVvdX6K5tAGupy/M7I/Gb3qGydxuu25VaIvrKX+9qJPBXCVqK/D1EqBc+AeaNSGrVh8NFUim6mbpkDkG/r0Bhl3EZlbSV1IqcH4iX5hk/Dzgjc9kZC0FKV+57sfqPETzMjLGjm6AnAt/Kgq9z7UhxXD2I4Qdf/xc0EAf9suuQ/fisaqGS6xdZr3CM3byHyLrvKAjVjjV+JkguK5W65XpeFTXp7GHY0M4fvs9n/HOKumxRmOtrF1o6sY190fsVhkl39QKf2VH2rOUSDasYArVAwAP1eyEP5Y0YGXMYCBODgRjRqd8YsNHLM9G6RlvLpmLqbG7V/8Lz904MZtc1ZRd0Ne7R9jTpnNU8fwt10O0lrqnACs2uTCJRlVuZXfV35Z5cq+uAdqSaZzEgP3CRsDqaiDyGpKlWh0WTI9OB5YvPI1jNIDpof
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR00MB0682.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(83380400001)(82950400001)(478600001)(186003)(9686003)(26005)(4744005)(82960400001)(86362001)(33656002)(76116006)(8676002)(5660300002)(52536014)(8936002)(64756008)(316002)(10290500003)(6506007)(966005)(66556008)(122000001)(71200400001)(55016002)(6916009)(2906002)(66446008)(66476007)(38100700002)(8990500004)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7juYEbkHANhlxI/f1UoDtNgUTrefrN7Zi32lFPUAA6e4QdT5DheEOg2v1YJF?=
 =?us-ascii?Q?pPdO1NlWO/uvmyAcmU5rbpZIadMyCqogVb7b+iIBJ8d5dQ/7CG46T5nin+st?=
 =?us-ascii?Q?alDf4fnWd5qE9d1NF+CquistujMmQC+Pv7gyIHAZEqWCfTc79Gg528rvTd5M?=
 =?us-ascii?Q?RZhngbYfW3fOJPwJ803Vut/C+02XQ1GXpTuBbGK5LmaHkuFkQPsxDsx2nrXN?=
 =?us-ascii?Q?xs6BNN4uguaquGl0SOQeOuRu1KCMP2ZNU6vGyoQDFJ9NKeHoKzW/y4dTojnj?=
 =?us-ascii?Q?V2bg8hSPbSYWNs+y6IfhCv9TDaaVk4wfMXlOVR5XszhDM4VeXHL6Col1gS4m?=
 =?us-ascii?Q?uDqcPASnmCh/DzjcCPlFhM53/Umh4zNnSViywK1vdJdbou2kzWo3LxwzeavC?=
 =?us-ascii?Q?InLs+sjJ0Nn1uIzpEzZo0C/oOkk179Zrx+bUsQx43MGPuxhsKpDwQ6F65bRV?=
 =?us-ascii?Q?9KQGFmSMBfFYDvp0XjJog6rQSxROYIHfLbN6dv+WEjpFyr/n/S85yDHskk9z?=
 =?us-ascii?Q?lATbvy7R8xUpbUAV83OnKzp0WAE3TUtG1bRUiqhUnLKoecjfJoXzIrXagcjU?=
 =?us-ascii?Q?ob2iMuRSsi1vON7nPUX8lXG8QXFkhhXepufeJ6aqGxcSWQTjeR3cOnBPJQU8?=
 =?us-ascii?Q?A4m3YSOBRdDjRDO5KNtOB+actWRTIbGFL8D8WHq9e/YwCPlXcj8hJpz+ttAu?=
 =?us-ascii?Q?1qB3aid9OnYW/7+hp4wvJ+YjGNuR1HtvPAmoRSvBcekpyUeSk1VzpyAwEZi0?=
 =?us-ascii?Q?FmM6I/h6rGlMJLPUDOXmmPAVWKyeM+4qntinZHUn6IbrQfWfuA3pycF5G2Zl?=
 =?us-ascii?Q?Zjxh0akXnRII7MmqeazPSTxK0hWNt0U1S/4PRTqVevZedvLs+uSnqXzHjAxy?=
 =?us-ascii?Q?ut9K4a4mdHZPiOTxaYEctK2e+gkM3nYOMW3DNGqeiQHVmOxflBbLy6m/6bW2?=
 =?us-ascii?Q?D3iKA+Tg5ZBNcfpxvvAALL+feaJ3awqOOD642+HQqCJd2Fk9gASx4q3+cW1d?=
 =?us-ascii?Q?nH0D5oYThV6jVhJLWXlFgNcrEuPKOnb36YucFPDKRdX1Veq/5mcemsu69FpK?=
 =?us-ascii?Q?PYdbGOA5++srnnaJMnuCM2VwC6TIvyrVvr6hURp5NnSibtecIS02iUyaSfM8?=
 =?us-ascii?Q?6Bc8fcvb+A++5+MrsmQ1yCpT7AXPVvDKtQ74umBrJxHIc7KVRQq2pqgmRtgc?=
 =?us-ascii?Q?bhEqrH/oQkQ5plvakvyoqt+QnckxDaf7AdkfoE133VYFW831slksTUYXSuwc?=
 =?us-ascii?Q?DD0AAow4LJtxC9ab2/fSvvJdIOLyZax3AVrtMp61Q6/MbLNOBMWGJA5p1Dp2?=
 =?us-ascii?Q?rw6aHLq7peSPfb6qmLxFabYJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR00MB0682.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b91b72-692f-4ea5-3fcd-08d8ff6938d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 17:17:46.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIV4Gj0xARBfK84pS0mU1op8r/acDAGwo7jCgsYuu/jzTqHWJacqCJD1Gx2LRJzln5ptnmsTK7J/cWmSg2hG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR00MB0667
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm unsure of whether this issue is Windows-specific but at the very least =
I suspect this is a change of behavior that would affect all platforms.

In July 2020 I reported an issue I initially encountered in 2.27 that still=
 seems to be present in 2.31.1.windows.1: https://github.com/git-for-window=
s/git/issues/2732

Since I haven't seen a response on the issue and it still occurs I decided =
to email this list as well.

Package managers such as PNPM tend to create very long filenames due to sym=
linking. Having git not enumerate these ignored directories is essential to=
 leveraging any sort of clean behavior (both for performance and for warnin=
g output) as we did before version 2.27. Our repo clean functions went from=
 taking a few seconds to over 10 minutes due to this change in behavior.

I've also had repeated problems sending you this email as your email server=
 seems to reject any email with a URL in it (per the github link above.)

Thanks,
Jason
