Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49131C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079EE21D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL2UEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:04:38 -0500
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:9172
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgL2UEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:04:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8tF6dbxz8FLEUwUvdaGaqIVinvq/tAa579X9T+HjRvTeeir22te8Di1uf564Z9H5fXoXREBhrQax84W2domHfhD7x3bugP7Q0q37fB4MUnkTv89/IM3DttCo6LhhO/KC8tILaIn+zbVICRtJD1Ye/WVqOjmd0E+y5dQ4l9HOJAH3255/PNi0+2V/yflIYQgK9zo6UvX24dPu7B9sKFgvwUDPx+OesB4BuE0i3HnR4qGzYtEwZA5RuGlqT0qEKLGP1HxnE0iFW9EJUW6Gm+y1eK+1y69SwIw05WyaGG4Sjs4qMIn6fn1r5DZmILkD9dVbrVePnPD9uxGW5mVDJLMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ/xyG7kn/FTZqxEMyE+QayiEVDCv7mFIb51uNeKsfM=;
 b=A59vR/L6dJu8Uj3AqUKPjujS8AecMF/txH/tS4OlJEgEJg57GGMAeqQx3keL0C44ZDMapB+3RLQWvB3eh0WCnuVufiAPOxZcsqW9EQCSnPeGRDEPSuNsOTO8gwKCHzkrz8plEiCPwrdWcGg6wc6j3nwQVXDe2MdX5IX2puCXecaF+SQFGz9f4mhxQpmjv6CvNNYzZpBIbFnmxG06z5ExanIQq2dMfyuGe7NwfL/ygEMH1s4z6bNQ6al9sSQb5mV8yKcWg91y3rHIsq4GrqubKJYeB+FFesAQ9fdbJcSpaR5bCPlU5E3xpl166okx2ajoAxHbt/3fkx8EkosfInUkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ/xyG7kn/FTZqxEMyE+QayiEVDCv7mFIb51uNeKsfM=;
 b=PJ2yywX1ah4i+1y/0Tw4N7wrJA/u5mjv074HcNY2S7PsdaFhmuzdC5TRYlqEqMJANW35TahGDUS7r1DC+BOZNKFs6fxAg3NuF/GV4b1P09HvCwuGsgOWBa6NKHHxWt8jnTPpl61Xip0UN7IfkQrBeLk+rkGhay4+6rZkSGKhDNs=
Received: from (2603:10b6:300:78::18) by
 MWHPR21MB0783.namprd21.prod.outlook.com (2603:10b6:300:77::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.2; Tue, 29 Dec 2020 20:03:55 +0000
Received: from MWHPR21MB0160.namprd21.prod.outlook.com
 ([fe80::9068:882d:ce8:9391]) by MWHPR21MB0160.namprd21.prod.outlook.com
 ([fe80::9068:882d:ce8:9391%9]) with mapi id 15.20.3742.002; Tue, 29 Dec 2020
 20:03:55 +0000
From:   "Christohper Boorman (Protiviti Inc)" <v-cboorman@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Repo in strange state
Thread-Topic: Repo in strange state
Thread-Index: AdbeGOV349olP1gaQGCug1bAdKMO2wABG+Og
Date:   Tue, 29 Dec 2020 20:03:54 +0000
Message-ID: <MWHPR21MB0160BA0EDE4DCDDDA96FC79F8BD89@MWHPR21MB0160.namprd21.prod.outlook.com>
References: <MWHPR21MB0160A79296BD2875F99B5C1B8BD89@MWHPR21MB0160.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0160A79296BD2875F99B5C1B8BD89@MWHPR21MB0160.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=442d70c0-c382-4f80-b91e-6e6eb30d8932;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-29T19:28:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:9780:1650:b1b3:7ffc:c3c1:92e5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea395c57-3925-4490-1abc-08d8ac34dee6
x-ms-traffictypediagnostic: MWHPR21MB0783:
x-microsoft-antispam-prvs: <MWHPR21MB0783D0E9B72ED975EF67BFD08BD89@MWHPR21MB0783.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M87tS+CCzkb61hGaQU1t0md8OMrYBadnhY6OFV5hPx9I2mIVHZ5UZmM8x6F/uzBYtFN+vZ2t8PMeh4mKWTDRGvqm1eZB5WtCDHMsZvMux7sh7XkxOlQ3p1nQwrsCdsIzhxaUe4VFJaYiIsYvfhm30ka+cNblagGEqT6sIrCWIagmJZgaaELrvliHf8nObgCBfzM9YNje1Wv8PPhMoE5l+J4f8BiBVzhKRatsBf7m9eM280NlhoDcXmDHVvjGu1aVVclxZIxi2QWOIL+Ygtl1i85lCjmgwDwO4YEVxpnImikto9G1mTJYlqBOnwrZc6PRQoz9wArPTtwxHd1KmiYQdH9Ff0fDEdrrC2xTyvQwzCVvsEya1JkW1+Qo/fQhgqyNhYL9pxd7J0fbhbKExpIIvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0160.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(82960400001)(2940100002)(316002)(82950400001)(83380400001)(2906002)(8990500004)(9686003)(66446008)(5660300002)(66476007)(478600001)(7696005)(8936002)(186003)(4744005)(10290500003)(71200400001)(66946007)(76116006)(86362001)(3480700007)(52536014)(6916009)(55016002)(64756008)(6506007)(66556008)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?K324koj7UqLOXzjkVvIL6imyUu6PGJXDXl+TbuW7o3nO1dF0SrR2W02FjJ?=
 =?iso-8859-1?Q?4eHrE6rkgytPVRrB4Ic0z+QhCbpF5pdtiSX8RDmu6MGnyneMpNY5wXwRO7?=
 =?iso-8859-1?Q?zzBhImVGu8aiItETCOE8HokZ7FWKrk9xOHDQeCM2DLajtUsEKtIPkJhWKR?=
 =?iso-8859-1?Q?suTrVFZF6AxL65Dhr1tVA1E+k32HIgoOot3OsdQvpe7AMF8T+dp9bL7XJK?=
 =?iso-8859-1?Q?pdRYfT2YlreLZ24kzIDCrtUGtm9Y4I44M1Nd/Y78LrpD+XBacOa+1YWORT?=
 =?iso-8859-1?Q?QCJHz7ACY0esE3YtFVTHN1NzJ1JnbAa7Hc4Xmq0Lnfb/Noip6ZrpJUBaCo?=
 =?iso-8859-1?Q?MmvltrHDwy4B9QavtTgIRGmJuNz11Z6VDeiz204vLpg3iGtHfcUkYjz2OD?=
 =?iso-8859-1?Q?M7vp+x8fpKmhP4DHZyp/VAC9XKIXAvLhKrhQXeP+/WhB1/zM/aZazW+6U6?=
 =?iso-8859-1?Q?klkgrnhKctXkRUE+vxKVUAxeDEP4fYn4UZ8s2xsIYXtHGr872DYjd59bZ+?=
 =?iso-8859-1?Q?H6iwbGnDExn79Jz95uJQHv+89/EvrCCVSP0nfqx88JgYJLI1NABd6QAL3Q?=
 =?iso-8859-1?Q?GTGxjJm4RC170VK/Rkn4eq9ph7ae1Y3zZXWxtNr/ApdbA0em3368Xy5+Gu?=
 =?iso-8859-1?Q?dRGYXEeC5ZQUpEGR9Gyd8drFtvdb5eVsG3+c76VjIZEa8FpE5vFECYEyxR?=
 =?iso-8859-1?Q?HRuQyeEkntB2/28NMuUeYVjloGj99hlyWXByjPwwTEM3LihVU/J1Y/Ro4r?=
 =?iso-8859-1?Q?3eY3pRm3sPnQsGWZB+MhlHshJGwmJoGBOyMvGix6Ua/GjLheGMxIScRxLm?=
 =?iso-8859-1?Q?ZCl780mvFV72wVFVivsMWB8Ect1+yDb5nO0Xk3jb6DVT/fFdFTIxfmKtUb?=
 =?iso-8859-1?Q?4HyUibwRakcCTiRLI/6f5bzwYHFBLcIEsme7O/XkZTLZNiHLQ71C75Fx7E?=
 =?iso-8859-1?Q?9KVrHVUxPYoZH8pkNv7gRJQvTRhSui2Zwsi7t975b4KPmln9B3W4Zfoq2q?=
 =?iso-8859-1?Q?nFDVKwaLMQUXAum44=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea395c57-3925-4490-1abc-08d8ac34dee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 20:03:55.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erui4KN1enJ1JDDUlDJ/VTB8WlOl7LU9/s+Ce2p1ymOTvIaj6WXYO6UYvPEV81cBRUl2iGU1IilWOxcUQ/lSBSrT3/sLpiI3904f6Wp5778=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0783
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I attempted to paste a command into the git bash, but accidentally selected=
 "Select All". The next thing I knew, the bash scrolled like crazy, as it t=
ried to execute dozens of commands. I couldn't get it to stop scrolling, so=
 I closed the bash window.

Now I'm in a strange situation:=20


$ git status
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
=A0 (use "git add <file>..." to include in what will be committed)
=A0=A0=A0=A0=A0=A0=A0 FETCH_HEAD

nothing added to commit but untracked files present (use "git add" to track=
)



I attempted to use git restore FETCH_HEAD, but I got an error (git said it'=
s not a file).

So how do I fix this situation? Any help would be appreciated.


Thanks,

Christopher Boorman
