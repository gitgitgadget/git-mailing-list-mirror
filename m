Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04051F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJVKSJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:18:09 -0400
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:7104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731769AbfJVKSG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAqUMaJVoUZIGkGqNSoJmdYVkX26LHoBV9D4Txrr++YzY9b56xggH5eOGSDDQw1zim58aq51H3CmAj5c9tHPn6Sy/+d2EdMLpT4npBKVawO9XV1nmQISuXNwX3eoTg3UgW+BEaqc7lTTcdAfYIk5fWU1B8dsI+pblAbLTubybT404aISf5MQ/f+37t0wcVyVn+L1xxUsv3AUFLGlroV6AaScwytmxwwo+iORSZUXXKSPZWL/+vRyI8deuu17/rPGfAWtSgp+a9tc5dR4jziVWRKZGDwSMn9bx7DChcOPJNdUQpkSBBtTWL4ruubPu1h8dh3K5Wxxm2nPJcUfOMz+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMXsW2433j5Gxh8Tiiah6xIGiAFekjzspTIfgQ3b+a8=;
 b=D8d3FiwHEEFaUuT0+nwImaER4tXLvX+U+842BjaF1G+JgrCnKjAWOrX8SHi2rNV9XfGgOsEy6vgfd6rygHZjuQvV6txlxSbw+y0+GHPhUNJGALPcRwpRBXOEMwqKlTsh9M2YE5rb1Ys/LZa81qi3uyVMNqKu9qg+UfJqoDUqUPwkq4yhCSluZnBuwdxHegKl3cjsaOp4nl/ZyZiHKGdjHeZ9d1v6Qpo5ziNcC9EMoG0jBX/MmqL7ezMcI1lID0gv/IQozhIPJ4XW1bcT6W+NxghwGJK8YDwe+a1sFYLF3Pleh3MGw7V4Ve+y1Qcke5LtL4QdXa8ztAAJ8LTvYfGM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMXsW2433j5Gxh8Tiiah6xIGiAFekjzspTIfgQ3b+a8=;
 b=pLxU86EHEUonoIuqbnCwHEb8JfLbo+xwJKAy76+4+pQutlGVr0BLjI/R+5PxH5g9xOLM5K/5yHoRU3ZdY/8qOJ8ZCTaLsqR+qwi49miRWNZzEeQiogNx9su03Nn/xSWP5Iaxr0obphdC3ngNjbNVIJL4Bm9/B6OKQlrk8ZTkPXo=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 10:18:03 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 10:18:03 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Topic: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Index: AQHViMH8W7ZVg6yI2Uq8GUvXcCiKxA==
Date:   Tue, 22 Oct 2019 10:18:03 +0000
Message-ID: <2154192.LVDMpRDY2h@pc-42>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637341b7-74f1-491d-8c41-08d756d91fa0
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-microsoft-antispam-prvs: <MN2PR11MB371145FC98D395FF66F9BD0793680@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(376002)(346002)(39850400004)(396003)(189003)(199004)(53754006)(4744005)(6116002)(25786009)(6436002)(186003)(2351001)(5640700003)(8676002)(6486002)(81166006)(1730700003)(33716001)(9686003)(2906002)(5660300002)(6512007)(26005)(71190400001)(66476007)(64756008)(66556008)(316002)(66946007)(66446008)(71200400001)(81156014)(66066001)(486006)(86362001)(478600001)(8936002)(476003)(256004)(14454004)(6916009)(91956017)(76116006)(2501003)(7736002)(102836004)(3846002)(6506007)(99286004)(305945005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PmyUhiTiIwnrJOTkz7aXD7LBixpInvIY5GaC716JGMf/5G6fAzFZo/VtblQM2CB/vPuBgsoLN7fOTuHHiReLQ4fvimN+hFxGbRhVGAovagtwi/CbB2Vwg0Ddvkj3vD1Q6g9C3ZBpypkA2RcwTw6KAE8jFP0qK6AoNwBrCSrwbLedRQ8+tkXDEFQObV+wVcs4mdegcB0sjG816mWyT5B+1hFIJj7fHJB4djrQtb9q+tgxWlJ7BzuErMZpNu0j6HSY6autpUwlCm++udSr0wYToCvUi03rucarAMtRmOxfvZIpz7pjj0ajgsebpDlwZdYmInLlt7be7BsPJjR5eetYifwr5QvekATymjQZxWRNaWXlPrGx+82OW6fkpJI9Zzsp8aVdrFdHWFa1ydmh31lWHlP+yuCXRdYe13av5Z0LU6A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C0726B4D6A505540BDF4925F5D72A244@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637341b7-74f1-491d-8c41-08d756d91fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 10:18:03.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Tufz2KZSMijkPQh7ZB7VXcFyJFsNCjo8j9+1z7niWXOfolkT+G8DFHhQxphgFcp/ylsP+axQjFgrtjoxFFdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I try to use "git am" to apply a patch sent using "git send-email". This
patch does not apply properly. I try to use "git am --show-current-patch"
to understand the problem. However, since original mail is encoded in quote=
d-
printable, data returned by --show-current-patch is not a valid patch.

I expected that --show-current-patch would return decoded version of origin=
al=20
mail or something that looks like the output of "git format-patch" or at le=
ast=20
a valid patch. Thus, it could be processed with "git apply" or "patch".

Currently I run "git mailinfo" manually to get the patch, but it is not ver=
y=20
handy.

(I use git version 2.20.1 from Debian buster)

Thank you,

--=20
J=E9r=F4me Pouiller

