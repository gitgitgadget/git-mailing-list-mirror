Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EFA1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfJ1TXH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 15:23:07 -0400
Received: from mail-eopbgr700096.outbound.protection.outlook.com ([40.107.70.96]:9185
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728941AbfJ1TXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 15:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7/bd6HUn/+qSTrHyLTvGbsbmtTcOw7qAGT/GnMobXkqwG8CvSK23LLrMG2zQzz0xoGy6sfr/HP+0Q6up1+AacMbxB3U40k7SQipIZB4/byy91n+vG1TLlBd4kkoF7n/wlEflIVXbvRpLaJYSIvdViySzdsGu9WX+GQyfdwCCQMwBG1iMcdyMxDisy6LFT1mVLyxz4KBaK2L/4nZHCMVkXjo6h1YlPrLcn2Dn5jMHU7CLWYjUbhPp5UtqTM+Rk32NB5qmVu9bVDh+fKbU76fVp5kyu/IeN+5DmDhSL9hOb5JOhs5RdOCv5BsvNRSbg9uGUFQHGPhrYW22P69+ij7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4lSAhBE7J25cUDAbzbS9rpJ5zg14uLcU002TPf0KA=;
 b=BheqKTqFLZyMvi8+2rk4YwdEYWT1OO+u3jMndl1m1mU44nH9+zmW4gGQHjsMmZ1Rcn3r+Swy7McFKNRsclW/r/CtScoxvQcaHvhzKUstc5YCoHUiX0m7NUY7sd36nPCROPYaOaqbYzFUBtTLUZflPWECap6c4GYspJ21sgme8NqSAebUWYdZl7sPntSaz74HBdEcuVPkSQUkbJP9WrZi6Lk7IqSR7Bhu5PaMj2vMqxXpcQXq1mrTn6qtgOk5cA6XBeYbAKhxpK/b90w+s3O/kaGI65UNeUnR4gvUdelqmZmlmoR/jXyB35yI3AktTW8qefGNaib0qBMaKRpSIkXW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4lSAhBE7J25cUDAbzbS9rpJ5zg14uLcU002TPf0KA=;
 b=Y+OryCBx9df+hMN2sVMAbxHiMHLUkCort4NepP0QQktjSaHsFZpnLpNBCWFVSBNBaC/oIBcvRdgzYTnTGhfrlyCTHh9VgXz0HYOmgVBoZDzpxH2v0yEaNpXgVFVwmoAmm6s1J0ghcovV3EgRi4HCAED6+1/YLLzaNwDbbveG+wY=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0628.namprd21.prod.outlook.com (10.175.131.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.8; Mon, 28 Oct 2019 19:23:04 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e%10]) with mapi id 15.20.2408.016; Mon, 28 Oct
 2019 19:23:04 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Utsav Shah <utsav@dropbox.com>, Junio C Hamano <gitster@pobox.com>
CC:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: RE: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
Thread-Topic: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
Thread-Index: AQHVi0gsgNXmyMqj80SNyhNb6SenPKdva2/ugAAy9QCAAJf9AA==
Date:   Mon, 28 Oct 2019 19:23:04 +0000
Message-ID: <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
 <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
In-Reply-To: <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b6bfd46-e016-410f-ede3-08d75bdc415e
x-ms-traffictypediagnostic: BN6PR21MB0628:
x-microsoft-antispam-prvs: <BN6PR21MB0628C20E29BF1AA62D3D883191660@BN6PR21MB0628.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39860400002)(376002)(396003)(54094003)(199004)(189003)(53546011)(478600001)(10090500001)(22452003)(14454004)(2906002)(5660300002)(446003)(64756008)(11346002)(66556008)(66946007)(6506007)(66446008)(66476007)(66066001)(229853002)(316002)(476003)(76116006)(8990500004)(9686003)(486006)(71200400001)(71190400001)(55016002)(6246003)(256004)(25786009)(4326008)(10290500003)(6116002)(3846002)(110136005)(54906003)(6436002)(86362001)(76176011)(99286004)(186003)(26005)(102836004)(8676002)(33656002)(7696005)(8936002)(81166006)(7736002)(74316002)(305945005)(52536014)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0628;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkaE3ML2JSdQga9SVIt8uIfnp9P6hrPOKfA1XDkHJv8WbimfAx3ew1uEOp2MN459GC6L/ALxJzq1688tBHXyBS7mY6WqMJtskkXNb/vd9r1SQE1p7UE3hcip9f71FD9YLzObgvI4eIzYdGKzxjPRoOFT67CG+enRWMmIe2FFR+w61cdRsmub2ByvcuZUp/S90fy13iGlCVc0HGplo7L5Ag4KqkJZuCJJlwneonbiRGuVY0rUz73tK+2fnVlTNB+aIXxcxakCOLodWG5U9fauWW8u6guruO+gEQDaMqqWAPsKpblhAMCd2468Ddp/CY1LnSfYpyyCFG1kXuSKC6tJB++kw6HiTGcJnwy27lkCxl9eXUthzP3xwNyVGj+fmuLLVy9LvhjTNghyL1Pa1wkFbR9tl4/tPXx5/GpjNTL+nKOWQI2MKmDwfjwssAuavQk4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6bfd46-e016-410f-ede3-08d75bdc415e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 19:23:04.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 047lK1RxlQ4JTHfTVITQ50QYjAcFlE5LdCP5ZOu/zslmZU6zxLSWGz/9X+K2wHV65+BWeqRflX5tDVMzPemLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0628
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, October 28, 2019 12:40 AM Utsav Shah <utsav@dropbox.com>=20
wrote:

> > I wonder if !ce_uptodate(old) should say "this one is up to date and
> > not modified" when CE_FSMONITOR_VALID bit is set.  Are there other
> > codepaths that use ce_uptodate(ce) to decide to do X without paying
> > attention to CE_FSMONITOR_VALID bit?  If there are, are they buggy in
> > the same way as you found this instance, or do they have legitimate
> > reason why they only check ce_uptodate(ce) and ignore fsmonitor?
> >
>=20
> Yes, there are other code paths as well. After reading the code some more=
, it
> seems like there's no legitimate need to ignore fsmonitor.
>=20
> > If there isn't, would it make sense to get rid of CE_FSMONITOR_VALID
> > bit and have fsmonitor directly set CE_UPTODATE bit instead?  That
> > would make this fix unnecessary and fix other codepaths that check
> > only ce_uptodate() without checking fsmonitor.
> >
>=20

I would need to go back and see if there was some reasoning why the
new flag was added but using CE_UPTODATE makes sense especially when
most calls to ce_mark_uptodate is followed directly by a call to
mark_fsmonitor_valid.  There is a little more going on in the
mark_fsmonitor_X than just setting the bit though and the invalid
calls are not matched with code to clear the CE_UPTODATE flag.

The change to use CE_UPTODATE would have
more extensive effects and like you said we would need to make sure it
would not cause correctness issues in some corner case.

Did you run all the git tests with GIT_TEST_FSMONITOR set to
t/t7519/fsmonitor-all?  This will run the tests with fsmonitor on.  I was
getting multiple failures with this change and fsmonitor on.

I added the refresh_fsmonitor call to the tweak_fsmonitor after
using the bitmap to set the dirty entries.  This fixed most of the test =20
failures but there are still some failures that I haven't tracked down the
reason for.

I will do some more digging and testing to see what other pitfalls there
might be with this change.

Thanks,
Kevin
