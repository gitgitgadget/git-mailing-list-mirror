Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F669C47097
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2917F613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFCGfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:35:10 -0400
Received: from mail-eopbgr1290129.outbound.protection.outlook.com ([40.107.129.129]:55104
        "EHLO KOR01-SL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229667AbhFCGfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 02:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKwxp4FVuMa2DRrB6ZKpFvFPSrm4iZIH/Y92JBfSPSIXBRUuFtVHbKQuyJxNJGjwPU2l2mk6ykorKGfrEd2Gu2FXTIRx8Vz9N3GRCJYr8uHydqb3I+xd62gpQ4jJOx2EWcAb+q8wrdAkfBYixJemWAT68cTPl0R6yPAQUwdL4KHmqtSdhCef2Xhpn5SnkHLzdqpjwOzJz5OVDBkp0sALUbUA5sgOnEKEDvoMWZm59ThScFZU6SNjHcOxU8YOrAWyw9a4vetMk7a+51lMcjz/uH+4OfmnLAt1Od17L76H3jvHhLpER4P/RswZ/AZfotl2yuma3GDIjntkX78f0QviOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz62C65OEt80Kc1abzHxbkE39+sMpbpQ6/CPjStUdMo=;
 b=g0dAgySEgXMFb2Fl9X0CmNF/oT/L9wUYBB1JqhZtlnRhPpMtDxuiYKavMZaoc7PzcrENTf3z81LQLJY8DNHvL7xd2Ak+FLoHy95M0Kp3JnIgWP4P5Xkc7nzQyPwZ74OYSR7fKiEwClQBC9HMW7YzOfdu99K+SECAGE6Ay/RkBtBrnRD8dPEPz813DxwArmmmHyEOQVo/oD0GhiW8FGPM/CJQ2wnzw2MP0xS0xETK1OJs+BJLrIx0JpU4zvOc8oCPJQ5t4K+9ok6T29vL9Xz7wVdXRQSJ4SKlW1gybefeQs4iHiReo3kJbXcC2osIz63/OiK8bHCPD6mWbRW5xBjyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digitalmatter.com; dmarc=pass action=none
 header.from=digitalmatter.com; dkim=pass header.d=digitalmatter.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digitalmatter.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz62C65OEt80Kc1abzHxbkE39+sMpbpQ6/CPjStUdMo=;
 b=c3d+IgbpK5M9DuHVHhlFtdJ0aXiRfQgzWMZAEqL3Uk6UjrUe2oqAl04XYiNV7Kelj78RrqpjDNZz0LHGp9zESB0RTAVf4/UeVbuC8Thj1scBVFm8OctGXvTxVRZHkRz95yIO2V5bdMWIwSQuRl9C+Zc9VTesN0/k6NVSrsD7G98=
Received: from SL2PR03MB3964.apcprd03.prod.outlook.com (2603:1096:100:4f::19)
 by SL2PR03MB4332.apcprd03.prod.outlook.com (2603:1096:100:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9; Thu, 3 Jun
 2021 06:33:21 +0000
Received: from SL2PR03MB3964.apcprd03.prod.outlook.com
 ([fe80::6984:4b64:7662:958b]) by SL2PR03MB3964.apcprd03.prod.outlook.com
 ([fe80::6984:4b64:7662:958b%3]) with mapi id 15.20.4195.017; Thu, 3 Jun 2021
 06:33:21 +0000
From:   James Limbouris <james@digitalmatter.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Submodule update setting not respected by git pull
Thread-Topic: Submodule update setting not respected by git pull
Thread-Index: AddYPlA3Nh92rVEbRcOGJXu+Q+YJEg==
Date:   Thu, 3 Jun 2021 06:33:21 +0000
Message-ID: <SL2PR03MB39644447B726A8C024259AA2A43C9@SL2PR03MB3964.apcprd03.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=digitalmatter.com;
x-originating-ip: [49.255.82.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aab7f9b9-317b-461a-dc58-08d926597b75
x-ms-traffictypediagnostic: SL2PR03MB4332:
x-microsoft-antispam-prvs: <SL2PR03MB4332C6B28DBEB04F49D38290A43C9@SL2PR03MB4332.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZId03n5k18ziaP3PVTkHM/dCBdRgtWH4a7rXtRFrrsitrbGb342h6/68YZ5OcmTINXbF1+5x2IDu2scqVR5R22oO/+oAesUfaDYxy9uQWoqkNFW0qFIHhSX6MgksQItuQ1TxmYLcRCV3ejyyru7iEvKZGg2WOWsc1TYHlo+YFagofugudhCbcpwtdBQfN8CzNQTVSr9Tk3cNcXrGZedHSiHhwPDkzSxrdZW6oiR/x9B/gR+pngUFIftRKTfZNpORVPgCt980iLzBGw9JPkqE5ffGZJWkNeB/WUutXu5RdVTw2UmS/jndraLCfyAj7bAHUWu0NTFf0FoVMsXuUhDB+v28wdjrR+lcNukQMzhzT+9/1m/QX53WyQkFw6IxE96p/uRXP/vOJzO0ReY/Acv9sATpIPpNRd2bAlmQRSsCVp7N78E0sDr/ILuyh6pG6RWTu6eqWb4STpN02cJnnDzWZvyZxwiYB1HLBPPAhn5jle51lC87DkjV9gHILqYku6jN5qvrr2MSGebMt+yOnr2RxG7tOyVlu4xDW7aEOJ9fMIlhqDNdrMUrWoc0o8744aiHmrvB8Pc8K8WXan0oMfSYG0aGpeX97LqVXriTE1DdqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB3964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(52536014)(66946007)(66446008)(55016002)(66476007)(64756008)(66556008)(86362001)(33656002)(15650500001)(9686003)(71200400001)(6916009)(76116006)(122000001)(2906002)(5660300002)(478600001)(6506007)(26005)(38100700002)(316002)(7696005)(83380400001)(186003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zWBrugCH1Blk+MF7IJpGZZ4BD046xWEK1vlt+hMfS9HnKNmBKJyvKBsgmAFf?=
 =?us-ascii?Q?Oz1JrMgnXRZ7ABQ8c8vC9n34LBQcd56CvZbB5hAIdmK966Jt+JjBRsGOxqxa?=
 =?us-ascii?Q?hnp+HFIM6oX5A5hiDmtSQdEMbbmhzU+M3Ae+YoAID5PC6qd6S3yRq0KpFx+e?=
 =?us-ascii?Q?7bQRl+UDz3Vb90NNkHYaPdPdkZtGMwlpDVbrjidqO4jsZZAhMCmNNYklhKsr?=
 =?us-ascii?Q?xvSAOplY85NDtWKpUMwbpI4EH7itqapzLIkuX+oUQPvd1WhbkONE8xLJZCze?=
 =?us-ascii?Q?XJItPx7GYSbHprxk27c7IqlsMoSkOcFdZYP0FQ9N60ARF9/vIR6Usj0rh7dq?=
 =?us-ascii?Q?jaRH0jAN5unNOx1tMVCqDGNCxfvUZAjw+9PfNJku0yv3cq69Aq3uy5GJKXpO?=
 =?us-ascii?Q?kkgCNR8jqcIFt8Uv/mWZcgG/vKbsVVMBm6AVOmI/Yj8H41Jx7Z3CsOXtJ268?=
 =?us-ascii?Q?B8jUX3OVP/4vC7R2QeIjvAxAnYm1hyI4xTMeGYwdL7z/tbKXl+UuyfA04Oe6?=
 =?us-ascii?Q?Q7m+iQfa6iAI1BSJAfLq1zBzgF+RB+mD4KzTgW3JwMnd+8wfubDnvTQ1xvHd?=
 =?us-ascii?Q?cSIp8U0ILJVrf+1x1IVBjBTpc8m73vINfKeopMgooQ0nlWn/JENDkX2SymSU?=
 =?us-ascii?Q?4svFsZuo5BKYQZub3ntRrqGvyhjoeLyDtQvMwa3OwKKYkob94b+OV7aeYGEc?=
 =?us-ascii?Q?bPwdYloBof4U9kSOs7Y4MCrOylXXhQx0DyqXgRiO9A3W7i8BdOqiMPeiiWQx?=
 =?us-ascii?Q?JC0w1z6Q1Mg9i/uVlUZXXUyzVVOBKoF2DfChZAxkVCbBUSszZGVpNhkexied?=
 =?us-ascii?Q?HYyEtIUDYZEvbr9Ibz8aXIEHaWr94d78ZcCTR9IflblGrGC/y0dIkrng3ltA?=
 =?us-ascii?Q?Fr0zjpzN5gU4630qrx2ElXbCW/TOeiFVHxQrv3u9owCgdxYb4sTRcdEfX+Xo?=
 =?us-ascii?Q?3CKJwO6Yw0RSdL0uAlcKAux5N27JNQ5h9ah0ax9rg5mVwupNp8+RHpmvg1zy?=
 =?us-ascii?Q?6EaiTubZfOd4mAIoV6LXe8cImpYQTLbHZBAM3Dp22154XTMQYkDSx0485yex?=
 =?us-ascii?Q?AQ58A+/cgmbQNHpaAWgFbqfUkQtG93iVcsXNABIYLKASyAtaLX+4+QPUis4d?=
 =?us-ascii?Q?3KO3lXWsLUWQq1fHlge7QdI28GUM+JMEYUfVOs78c3aaLNxnOi8iUq794KJo?=
 =?us-ascii?Q?Lq92C9zB/WqQMTMIe7k3vmI8hd1Dv8o3Z+SjtkaOUY6bylRE3wvDPBD9QLhO?=
 =?us-ascii?Q?SbGDr6lGwiCWQb6U4RWfQ+hJ5QjP6+GK++LOedS3bjJ1sRQ/dxbDFnvKHrqv?=
 =?us-ascii?Q?iJ9SF/ytcj2MKE4L2rxZrQcE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: digitalmatter.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB3964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab7f9b9-317b-461a-dc58-08d926597b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 06:33:21.4312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2cca29a-53d7-4b73-8112-76c4d41fcecb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fXrCJveC3rcBc4BTLlC7Gv8+W10qiTLONCSGbpMO2Px0EO2WTNiV3pxttCmijUmEYxEts/P3NCLkQGUVLWGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4332
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

I've been wanting to use the git submodules feature for many years, but hav=
e always been put off by the ease with which you could lose work in the pas=
t. Much progress has now been made, and with the '[submodule] recurse =3D t=
rue' setting and the 'update =3D merge' setting, it's starting to look much=
 safer.

The only remaining sharp edge seems to be the 'git pull' command. It doesn'=
t seem to respect the 'update =3D merge' setting, and will overwrite a subm=
odule version in your working copy with the submodule version from your rem=
ote, instead of merging or rebasing. I'm not sure if this is by design, or =
it's a bug? But it seems like a bug, since 'git pull' is respectful of unco=
mmitted changes in the submodule, and also won't overwrite the submodule ve=
rsion if it has been staged in the containing project.

Git version: 2.31.1.windows.1
Steps to reproduce:

1. Add a submodule to your project, with the 'update =3D merge' setting, an=
d default recursion to on:

[submodule "modules/mylibrary"]
	active =3D true
	url =3D <. . .>
	update =3D merge
[submodule]
	recurse =3D true

2. Cd into the submodule, checkout master, and add a new commit
3. Cd back into the enclosing project
4. 'git submodule update --init --recursive --remote' will correctly leave =
your submodule pointing at the new commit
5. 'git pull --rebase' will correctly leave your submodule pointing at the =
new commit
6. But 'git pull' will replace your submodule with a detached head, ignorin=
g the 'update =3D merge' setting

This will then lead to lost work when you fail to notice, and commit the re=
verted submodule version in the enclosing project.

Am I wrong to want 'git pull' to use the 'update =3D merge' setting - is th=
is a feature?

Regards,
James Limbouris

