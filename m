Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4701F731
	for <e@80x24.org>; Thu,  8 Aug 2019 16:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbfHHQo6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:44:58 -0400
Received: from mail-eopbgr130109.outbound.protection.outlook.com ([40.107.13.109]:31374
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbfHHQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghaOijopnLCSlzGIam0rNS0TeXJ7TvHFkELst3c5i059FZ7dtyjb5f/S2OMZJ6LmfYfea2Pzy82QisOHk28rJVTot968JgUcUrmU4KMt+kMknPLnRwwgqJNr8+TGDRKl7b8uLaqDaKEess3HO+VRhT7IvgtCjLBQLJKMbYXoDl7X0REGq82D4MnDNCcHanwS6W2nv/TJ8Eh+jUtpbUIiJVxHKwp0ttS02B/OaD2/x5AbGG8poqzzYaIcTePXZnPG1/tEhUnKAPN10t4T/PJWUd++tbBFnZh3D1rN+LagEIwfshoyzFswISq4KOgvOX4sye68D7duPQ6EdEaOHHOZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8T/c2HC4rHbOvRbaL0E7aylqO1BAhnd4ipuMQ1NjJw=;
 b=FNWzQoOrhb077hTX3jQicgoJLchcYLRi9KGnm6AuUHeWwVqS2nRdah3A8BQLWuKZXt/4P+2rr7UaSXjEVF0MRRNgFMaKLhgV5kwzop0ldfkXXBs+LZsmxRTiXk6EWnr8i+tKYh4Ypf0+iR06hbFDEG9kyiR25VswtlaCZfNe0TFWOgVg9nGO7QVD/qnmlDfPq4pv1/UCVWCz6eN1SPjkmOcKLvDisttTlUAruGUwzBVFbyqaYbicDex8G1PtR3ysOXtRKQpCvBYxTOmsR1TbCP80p1Zjka46SpzNq5KwniqFYPMgt33UUiBWhoZGorH84LPUIMWXLk32Lk3rPPRHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8T/c2HC4rHbOvRbaL0E7aylqO1BAhnd4ipuMQ1NjJw=;
 b=MoLmgQxeCyp/pR+rljqubJn9pYsRYqUYCWPILs6wScym6VlnjHsIKXg3xFL6oTKjUIAsh2eg7y+VSlkX0X41bUUQC2f0m/h8ltx8tHGZkfC8HNTUul6qgNfbR/dm+0+s8iDHhkrj/7J7WBRbTqGcNWRlQlas7SnAuBs/1YMHTuc=
Received: from DB7PR83MB0268.EURPRD83.prod.outlook.com (20.176.229.151) by
 DB7PR83MB0266.EURPRD83.prod.outlook.com (20.176.229.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.6; Thu, 8 Aug 2019 16:44:52 +0000
Received: from DB7PR83MB0268.EURPRD83.prod.outlook.com
 ([fe80::59bd:6fb0:f5b5:8660]) by DB7PR83MB0268.EURPRD83.prod.outlook.com
 ([fe80::59bd:6fb0:f5b5:8660%11]) with mapi id 15.20.2178.006; Thu, 8 Aug 2019
 16:44:52 +0000
From:   Christopher Ertl <Christopher.Ertl@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Windows absolute drive path detection incomplete
Thread-Topic: Windows absolute drive path detection incomplete
Thread-Index: AdVOCE3sFLO7Bl4STuW8/kok91nF0A==
Date:   Thu, 8 Aug 2019 16:44:52 +0000
Message-ID: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=chertl@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-08T16:44:50.9068155Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87963833-ca20-4a33-b25b-6084a27ea766;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christopher.Ertl@microsoft.com; 
x-originating-ip: [2a01:110:8012:1010:c81d:3559:42d3:548a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1c997d-0ac3-438a-e042-08d71c1fbc2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR83MB0266;
x-ms-traffictypediagnostic: DB7PR83MB0266:
x-microsoft-antispam-prvs: <DB7PR83MB0266FBFE63C7CDF12BE863F997D70@DB7PR83MB0266.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(14454004)(102836004)(74316002)(66446008)(6506007)(81156014)(66476007)(186003)(5660300002)(305945005)(52536014)(10090500001)(33656002)(8676002)(2906002)(7736002)(8990500004)(1730700003)(478600001)(66556008)(966005)(6916009)(64756008)(81166006)(71200400001)(6116002)(25786009)(71190400001)(10290500003)(9686003)(66946007)(22452003)(316002)(6306002)(14444005)(8936002)(53936002)(2351001)(256004)(6436002)(476003)(7696005)(55016002)(5640700003)(76116006)(86362001)(2501003)(99286004)(486006)(46003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR83MB0266;H:DB7PR83MB0268.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S/VL8K1X3mlXihDbS7prFuCgmOWFPPHW7Qsnr2b8HLeOKLP9LV4p7OJ69k2Wxqm4qGbYoR0YbbYebdP3QfdxBEPC30l2ROUA7iHyRoUcpinVPmqaVqGGZvw13JdscmAOANrFYss7SOamLH4bd3nDUEHVB3bwpQlh/Xg1Vk9OFqmHrniZs0beHt98POqW0HmU6PGGK0DllYbE2U7Wes1B1+hzaq3q3KgW3ZUnn067Z2NWRuM0J+f8FLQuXNOWAOTEmsxwbiGHeLQrEUWY8Pl5nHY404blIh9YypeKoC1p9BsCI+xiIMothSWXwOjFLPZEwteKOYM3mM9rHchf1zzCG04jdhSaMW1kfu/Of8dhZdB+7DofNsIsBepYXkuIs+tgM3GbCORA/eNPyZ/orRzaktdsvVr7Pm79A7GR12Nq7Os=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1c997d-0ac3-438a-e042-08d71c1fbc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 16:44:52.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apbKs4phQceejNUzCoAHPZzpZiJ+9BBxlOm3rjQotrATP78nkLTCIWEaiPsdQyjwMfs+W4pYqQJ/zyuuc4iU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR83MB0266
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to report a problem with path validation for Windows, and propose =
a fix.

Function `verify_path` first calls `has_dos_drive_prefix` in order to preve=
nt absolute drive paths like "C:\xxx". The logic for that is implemented as=
 follows:

#define has_dos_drive_prefix(path) \
	(isalpha(*(path)) && (path)[1] =3D=3D ':' ? 2 : 0)


The problem is that Windows will still interpret a path like this as an abs=
olute drive path even if the first character isn't alpha, and so it should =
still be rejected.

In fact, it's actually possible to create drives like that which bypass thi=
s filter on Windows (as Administrator), even if it's not an officially supp=
orted feature:

>subst 1: C:\Users\x\Desktop

>dir 1:
...

 Directory of 1:\

08/06/2019  06:19 PM    <DIR>          .
08/06/2019  06:19 PM    <DIR>          ..
...


With a drive like this present, a malicious server can write to wherever th=
at drive points when you perform a git clone (to test this, just create a g=
it repository containing :1/file):

>git clone http://x/pathtest
Cloning into 'pathtest'...


>dir pathtest
...
 Directory of pathtest

08/08/2019  04:49 PM    <DIR>          .
08/08/2019  04:49 PM    <DIR>          ..
               0 File(s)              0 bytes


>dir C:\Users\x\Desktop
...
 Directory of C:\Users\x\Desktop

08/08/2019  04:49 PM                 9 file


If the drive doesn't exist, the clone will fail anyway:

>dir 1:
The system cannot find the path specified.

>git clone http://x/pathtest
Cloning into 'pathtest'...
fatal: cannot create directory at '1:': No such file or directory
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'


So I'm proposing to remove the check for the drive letter being alpha in `h=
as_dos_drive_prefix` macro:

#define has_dos_drive_prefix(path) \
	( (path)[1] =3D=3D ':' ? 2 : 0)


As well as being a security patch for RCE under very unlikely circumstance,=
 this patch is also a micro performance boost!

Thanks,

Christopher Ertl | MSRC Vulnerabilities & Mitigations | Microsoft Limited=
=A0
Microsoft Limited (company number 01624297) is a company registered in Engl=
and and Wales whose registered office is at Microsoft Campus, Thames Valley=
 Park, Reading. RG6 1WG

