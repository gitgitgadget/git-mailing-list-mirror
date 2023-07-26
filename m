Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495BC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjGZJyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 05:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjGZJx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 05:53:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2090.outbound.protection.outlook.com [40.107.105.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9063C25
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 02:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTMmkKHr8RRIv5Y0cmYusfkbj8K6IKotWiktlgW3TZUERgm+L5NvZeFmj8kotdF1i1mBL4WuZ5E8TpAoH83WjWX1a4UItNvFOKuBtVcCifSZ8fh3sbjkvlORCJHzI5nDs2/m8b5JZrTKAWy/xCA/MarctEzhaMh2vmxf97wv1Tw/oyPiYROda89jd4WopaE3KPMoqWQ4Ahq0rwugpLth2Y/6JRwINTCcpQpTNX1fN2jFiFb5z4/EUQ/Ei5SrOswR7unGWUhDMEFDa9DTr83uFzn0iuLjYU1/UvJuWNzJ8UVMhiUEfEOXdZThnW13CeDtevYdVoJAi+6OyMRGIyn9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LDKrYguQvvF8en2T54cA8rzV09xQWJJ+lAvW7szXhc=;
 b=dOfh05zJKsadHtwXMAibn4hBXVrirkKq2SsVtfRcvhqfrDKXiKAeaGv6iovhYHI1YE93TU0PXl4Xz2PMiYSscXV+qLEnhxJWzTHhUelENx68hJ/fp3hakkvlzCsp0P0QvV+bjjUpuqbYq9PI7c5DhoISPLL1ogR61EUKhQ00QQwFBCuZSS+TE/7HClYahiiOp79/KDLnLy4JQSlI4reMizv613iGQVZbRiw+ND/+tdkSKMxR7f7/MUQVzJ18n+o9Q3JnFmlY8Bu5B+pnM5P/8mo3SUzfqG85qURfc5q3/dndRndH7GBuA7hRsFVdIKjDTQaCZ++Puhe4WsT5e9HwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intellimagic.com; dmarc=pass action=none
 header.from=intellimagic.com; dkim=pass header.d=intellimagic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intellimagic.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LDKrYguQvvF8en2T54cA8rzV09xQWJJ+lAvW7szXhc=;
 b=poGpvJ19Ochh55iwC4TKXs+Onmgb9ErAdFJTNUpJeyG+P9zrb0xuPd5OkTbcWLZYImUPrnAcaiTi9G+8Wgk1dMFlwxzLWAdOEsMtK3pVKsYUs/uzkD6ZgYP2kHO9jODnSCKUFYQVQI0lubCEGJF91bAvy2claLwSTH0GngHjlF4=
Received: from VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:7e::13)
 by DU0PR10MB7285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 09:53:01 +0000
Received: from VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f63:894c:a5f4:9d8]) by VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f63:894c:a5f4:9d8%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:53:01 +0000
From:   Louis Strous <Louis.Strous@intellimagic.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: How to make "git bisect visualize" use gitk on Windows?
Thread-Topic: How to make "git bisect visualize" use gitk on Windows?
Thread-Index: Adm/oXtVY46k1XLjSgWe3oDG3cBB2A==
Date:   Wed, 26 Jul 2023 09:53:01 +0000
Message-ID: <VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intellimagic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR10MB2462:EE_|DU0PR10MB7285:EE_
x-ms-office365-filtering-correlation-id: 3d6cb72f-23d4-4e20-556e-08db8dbe1983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDMhNryza4iejDUvsu7PVpXLZJB1zm1EtCLz5tNHF1Lgx4QqvOUreAeUysLxLShM8s2FrMCh6vtsNF9ypDtxW6rAl8nDN6BHnNqsWFbZ3LJpK6YRJjR+mdCCCJHbvV5wPDwPVSG+livZNoEWqts/ovHRu2evMKFBexSmBQwZhvAGHvxRScP/fJw4N1k10MjMj1v0kaC8YMW2AxWujK8tjVzYNhUxGq+9pZV9GO8bW4/DJu5x9W+UrCGRK6CSWTdlAO9DnQh/TnpKhZw0TJMcZNaXWaNNIhu9EJ35mByCLbLJ8DOE0q9ohBMAekwLvpRIJm/SVfQBSeh0249AN9pIdLpIxJRyxkwhkBi2PisYPC5SduXMH7VFt8jGBOokuerEoJ3H+zKqeGW2RZDqTwCjXmpHvwmaeG9A3eWb8zuI0pGmqgdc1lrpWinbabqsiTydwvwKbOvrTXr4T51Jn2mEWdbDUsuuCiRf/8MSDLZvl5YfqgUy6806rQVlEcAGdMmYc8ihmgCN4zfLwunjmcjcNlThBHYwlK1GPMofW190tqVdFf8C9w7S9i2OJiAzVz4OGGFDUBwszAE/aEn5vfxa/k/pozyzaH7QA7qvZ87EqTHPov5uFxcOqVYDC9PlgJSc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39840400004)(136003)(346002)(451199021)(966005)(9686003)(71200400001)(7696005)(33656002)(186003)(83380400001)(38070700005)(86362001)(15974865002)(38100700002)(122000001)(6506007)(26005)(55016003)(2906002)(66446008)(6916009)(64756008)(66556008)(66476007)(66946007)(76116006)(4744005)(316002)(5660300002)(52536014)(41300700001)(8676002)(8936002)(478600001)(45080400002)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H1X6u9NnV/BE6mkiBo+4p7u33PzOJnRB16E8uumBcw4aBqpamktsqbBI6O?=
 =?iso-8859-1?Q?fuYZi1+aUm2+RS2bG+YJYTpHGSbBhU0t7rbvtyNHVUo1HXEvS4nRXhJBSz?=
 =?iso-8859-1?Q?LUfwofaHrkyf8PW9/gVILk8Rm5hb+t4y2wK188JAEJMDUV6UVfIez8yzjd?=
 =?iso-8859-1?Q?ZD2ebSNoq1u9WCw/ZjUilQneSjocTvRIFvGnGCs+nKR+26DFILokxW2A6s?=
 =?iso-8859-1?Q?l4ct3za2JBEU25T94zXwRwsPlDb/3oR3pI3BRxudLtuPsIbw03Up4NlWCF?=
 =?iso-8859-1?Q?norrkm70e1HmbfglTny3fIpKYpX5Pn3mZhWtDhrLdbBOJxeZP4kPqAzp0U?=
 =?iso-8859-1?Q?ECJP8bQ7UrgjFBadim0UGcA+n0zI47YV3F6EVwlYPPHkErgveosl5fH3vv?=
 =?iso-8859-1?Q?NKEMFsiJ8iW6brsOEltYZdPZrP96z1sSJYAVZnRTJaJvXPjKCCiyZVyCNd?=
 =?iso-8859-1?Q?IFx915cQUOaS3vuXKD77YSiGVkSpiyoE535/3LJWIU4oaaHlY7UMg8oFJ0?=
 =?iso-8859-1?Q?AXIT8k+CH9JpimLbCzhrm8bVq9u98WI81Jv5Y85jsuWFEQxZcd483bisUo?=
 =?iso-8859-1?Q?ysUPCQWQ6wuJ6kB0lG2rwQcbstDTIynuhFynZK09pNMNwcxm273FTzM6i+?=
 =?iso-8859-1?Q?3Vgb14QiSsNMHKBk1qi+Lw/tBvhqjLLb3ovfrtUuFPJ87u8X5P93T+M0yo?=
 =?iso-8859-1?Q?LOKJWdYgzzagLG9efRCRGLa52gbivHBsHrQrnF3ihdZfSlpMnk/MiYtYRw?=
 =?iso-8859-1?Q?TKcFTdLfotyZm3XInAcTiShG8y7WQrwziojPkAEhEJfhHgtnKuzcmKhK6y?=
 =?iso-8859-1?Q?pHTX3Oftq1igwOa+i8C/X2VKyh4sdV4GqGj99eAtt84hpIhh+UrZ/Zt1BN?=
 =?iso-8859-1?Q?E11f4jPVRnn+fAi5un9prsK9wylCdv/TZoxPFKD/DW4e4WaeyMTlcNt4Sq?=
 =?iso-8859-1?Q?rOjbZXHaMttEtyHkVv8/gdXkIDw0r+wjHVlPZOScv4kOUPxQLodXwUuBGL?=
 =?iso-8859-1?Q?sb3cNFa5lLF1u7cVerURkQBbo9uFYV2aFkvFFcYcjrjrMk/WDVD7QTSY2e?=
 =?iso-8859-1?Q?Wx1DzDMOwXVmZ/4VUsOgYbfaR40/t5qOOAkMr4ISKQFHADh85OoWh0sz50?=
 =?iso-8859-1?Q?xPCbFHhtejF0DqVzdU2GDC+US6Kt7cXn8WO11AMO72We/EzG8AMFIZqiZa?=
 =?iso-8859-1?Q?CJzryFhJWCAvHos9dR+dySimIR9Fz47zD02pX6zQe5IqszBrFJvkG1kj3v?=
 =?iso-8859-1?Q?s62c3c5AWJgcjdzgyQ3BeP5/Hmhtk9GRDXLoI8I1sGlJMnNIgBO6DP4HWa?=
 =?iso-8859-1?Q?H5GDDmcmx8Rx+eXqoxdsxrhAR09ADRRhHHtEaqSLmKI9I57HPJqH2hy+wz?=
 =?iso-8859-1?Q?/bGAT7yl3ynZ1/OqAJrjkR6fZxn/O2uIygAr1Cd9iXe86gwSLUwX8nAaPZ?=
 =?iso-8859-1?Q?Z5LzRSwfS8LrglRYakMcuoot/V+jhqmSLYUpMYXiH8Z25kZpU78Zkwt7p5?=
 =?iso-8859-1?Q?bC69Kb5AOFr86DjMCDKpf99BObSlohyiS8adYxsorb/VX543bSSN2PEQB0?=
 =?iso-8859-1?Q?n0IaHqV1j9Tt6Epa2Llom1sLypQyTCG8RfH7UrOpSRxC4GOiE0eCTm5XgG?=
 =?iso-8859-1?Q?sXc45jhPSYVAOrfamdtK3S4H9wBlar5+yFqKRtuM6eBJuoJEzNqneyBQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: intellimagic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6cb72f-23d4-4e20-556e-08db8dbe1983
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 09:53:01.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84e351a8-e0c3-496c-85f6-af5416ac9ef1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eICNBjdYKjEvtNuInaKTMxlytYkUDDioLAR6hAte78m+iive3bbXVgULl6h+wGvasaaRkqwns7vE1drZtbdblpEhqqvBp+CSgo6WFl51ORI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7285
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use git version 2.41.0.windows.3 on Microsoft Windows 11.  I would like t=
o have "git bisect visualize" use gitk instead of git log, but cannot figur=
e out how to do that.  The documentation at https://git-scm.com/docs/git-bi=
sect says that gitk is the default but "If the DISPLAY environment variable=
 is not set, git log is used instead".  I haven't found a description of wh=
at I should set the DISPLAY environment variable to on Windows to get gitk =
to be used.  I've tried setting it to "whatever" and ":0" but then still go=
t git log instead of gitk.  How do I arrange for "git bisect visualize" to =
use gitk on Windows?

Regards,
Louis Strous

IntelliMagic=A0- Availability Intelligence
T: +31 (0)71-579 6000
www.intellimagic.com

