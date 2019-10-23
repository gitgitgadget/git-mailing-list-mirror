Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95151F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405384AbfJWMrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:47:43 -0400
Received: from mail-eopbgr770073.outbound.protection.outlook.com ([40.107.77.73]:24386
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405381AbfJWMrn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP+8bDEoJbn2lTjUg1ax091SykNCTYDJU2Bwzu4UpclOkg3QTkGV5e9yTHYNIlkvBW/aPLLcHiZUoFXpU1r8n9sWxtI3679WPl9lschRKDjL5BEnB/zZqD66tUSHhSJRdCeh1tTgl521dGnNoxuR0n1ym2vU/Z1pz/i3XKYW87r3imPhji9Jvs+XEpfQNXafuQyJnmwcPP9OnUD9Lma/z9sA7hDzVr2c9Kb7egh6nI5jpBG+w/vcAeargojRlS7WJCaoJgh8yWASA+vWjHVzg1crvhT5tGhcibiq3X90D7Mv9JSU1z4MS3/Oiz5IXcY3x2/yByeZpx/7nDv5aH/Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj0eFsaMA2jjeHmqIL3GqyCnt5/3iYknzS9US50kRos=;
 b=NwScSA3wy7NxHZHR+TSB61PPZf/xVAYAjDjyhTzdbP8ERDMggtbJasfnRZnUfH8PLu0kewe785C+PcddBKbHaDKTey7teFOeRLfw8mRgUPbwzy+t7AAUECIWd2O68DMQsw0hXc0mkp9es5SJ9lKYhu5/z3/N9HTDhjfgHc20Ul8bzm0iTqoyoMqZESlSz0QFEan/f5kNgwvOea/TVOizAb2V326nr+2Lr1EWLCueiQmCRPZneberkFlvEMIjePwA5I+zPVlehGVS6vKUvYbUY8W9P9dpRtEfLzC+73xkLo5CwuGpBQ5F43qTSNIENzVrAfe11IFdoZQjCi3agqpqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj0eFsaMA2jjeHmqIL3GqyCnt5/3iYknzS9US50kRos=;
 b=ZFBm3qX4bKy4Xk0J34/6pVfCV1tIvyoJsJMgnv/dRmWCWmyt0EYdMzhiiJ8vxeIpdQT54/Q30xbuv1QjW1LR9Tz0JZ7eYAYpiR5tBb912quU3ldtsM8LSrEFoaU9mx3OQlBZY3naGK1ry0GqCRSmIieUaOQiX/sv4F6XwT0lneg=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4253.namprd11.prod.outlook.com (52.135.38.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 12:47:39 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 12:47:39 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Denton Liu <liu.denton@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Topic: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Index: AQHViMH8W7ZVg6yI2Uq8GUvXcCiKxKdngKj6gABrcACAAAGBgIAAFmgAgAAPQoCAABtSAA==
Date:   Wed, 23 Oct 2019 12:47:39 +0000
Message-ID: <2928191.nfgCUvMfDQ@pc-42>
References: <2154192.LVDMpRDY2h@pc-42> <2720546.GJdFeal64i@pc-42>
 <20191023110951.GA716725@generichostname>
In-Reply-To: <20191023110951.GA716725@generichostname>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2d1634-88b5-4d37-e1ac-08d757b7301e
x-ms-traffictypediagnostic: MN2PR11MB4253:
x-microsoft-antispam-prvs: <MN2PR11MB4253439E9B93E394C7A19C6C936B0@MN2PR11MB4253.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(64756008)(76116006)(91956017)(66446008)(66556008)(66946007)(14444005)(256004)(486006)(5660300002)(316002)(66476007)(86362001)(3846002)(6916009)(476003)(11346002)(4744005)(446003)(54906003)(7736002)(305945005)(66574012)(81156014)(81166006)(8676002)(6116002)(2906002)(33716001)(99286004)(66066001)(102836004)(229853002)(6246003)(25786009)(6486002)(4326008)(26005)(478600001)(76176011)(186003)(6506007)(71200400001)(14454004)(6436002)(9686003)(6512007)(71190400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4253;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fBs1ae1VdHRXdL0X8z5F60ptrV63VO+DLAsu2bdKYotWRlZ749aZTz1PxG8g5sybm1fxvQPiXFUixPZDWELWqVJzenhB/5M4D4/ycJfcMWFUttokKr2MB+vu3JXbcXWYyb1uDeRyrsU68iN3Z96vZFWgL0bkTAAhNPmoGqmYMZ4TrFOAe3KKamDe3vUjTS0Kjdbi/0Ql01ORxbp3uLzA5goJ/qa4aB4pACtkvd+WnGRODO/oXtt62mTWsqD8rd7E2bPV12i2izvaUnc8wzifxzLrx2RsGbPZJB0pVU/Wkm3kE3k5T0uVJxO6ep/FfwWwUP1VPsMvloHg0+1+zBs3rGK01S04lhX0Hw3roYLFV3bdov3LAVUuMgzV8ao3XcXP7acD0cvA3YE5ECkoclDrM2AE+2zp8kHYNr+hEt/XNn/WvgfrbO5K0KD4loVDuoM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7839E08EF7F8EE4A8FD6384E40C90540@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2d1634-88b5-4d37-e1ac-08d757b7301e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:47:39.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRwsp9OLN4Z2EbgSDoSNghSYE8zouF3d+/qjpjkvGo9MP6cYQgR6whMBZ28OiLuzRyAVz+ph3IqaB2rmRYMcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4253
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 23 October 2019 13:09:51 CEST Denton Liu wrote:
> On Wed, Oct 23, 2019 at 10:15:15AM +0000, Jerome Pouiller wrote:
> > On Wednesday 23 October 2019 10:55:03 CEST Denton Liu wrote:
> > > I am currently have a WIP patchset that will print the location of th=
e
> > > failed patch file (.git/rebase-apply/patch) in the case of a failure =
as
> > > well as the line number. Will this be sufficient for your purposes?
> >
> > It would be a clear improvement (the perfection would be to be able to
> > use mergetool with git-am :) ).
>=20
> You should be able to do that with the --3way (-3) flag.

AFAIK, it only works if index is found in local repository, which is
rarely the case :(

--=20
J=E9r=F4me Pouiller

