Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42071F404
	for <e@80x24.org>; Tue, 28 Aug 2018 11:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeH1Pku (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 11:40:50 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com ([40.107.3.135]:56246
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeH1Pku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 11:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hexagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4gXHyXDl/MoKyumdZADDIDO7lOlzaBQvXv4JUKvV78=;
 b=hOqdaqVg1xu89kjszGbT2t+WdFjH0/IkKaZtBd/F/lP2wcW3zp6eiRJRGbO3bL4uUP/nun/voZ6fkVkQ85zC1BOriHmmhr4L7Q9xOB6dSrggC0PgpM+m1gpZ1b0NACYKu69vGUNhRIkMswSBJmZXanTj9Sy/RltAHWNwLIrTzQY=
Received: from AM6PR06MB4231.eurprd06.prod.outlook.com (20.177.39.215) by
 AM6PR06MB4151.eurprd06.prod.outlook.com (20.177.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 11:49:30 +0000
Received: from AM6PR06MB4231.eurprd06.prod.outlook.com
 ([fe80::9840:96db:e41d:6eda]) by AM6PR06MB4231.eurprd06.prod.outlook.com
 ([fe80::9840:96db:e41d:6eda%4]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 11:49:30 +0000
From:   ROZAR Fabien <fabien.rozar@hexagon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Customize the sort of "git diff --stat" output
Thread-Topic: Customize the sort of "git diff --stat" output
Thread-Index: AdQ+xSF/DoqrBDpNQV2TmE2sbR6VUQ==
Date:   Tue, 28 Aug 2018 11:49:30 +0000
Message-ID: <AM6PR06MB423154FFB65DD801EF0CE8519A0A0@AM6PR06MB4231.eurprd06.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabien.rozar@hexagon.com; 
x-originating-ip: [89.251.62.86]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR06MB4151;6:aTy+l/gUj+D29XEYIsCNvwIHPpwz7MUFGFrxgI8hd+/AIglvN5oc5+pc6fCgGWDKVDoTya8E8FxcnX+e6nmJiM75saYzen9mbh3d4/DXx3PBZ5bShG5AoqLRFXIeBq56+/Xs0Hbn00f+kFcrs2Sz6qm1Z0iX0I6rXr0OGdxfRRE6Szj0mx6TvU+06+H15vs0gj3nEZTDJHFh6FFsqiHSO+m+VPBnoEM/1gBeJkKT/c22CJ3LkFrUbYy4JcBVoTcEEHwhZSDzsBlkPKhSVrrxNYjq/1IhPIxE2zvKqv3tvwxDZTXhMlnKbQUm4J2YwVDLoyGyamHg9U9ik36+Zoyy0cCnDfvE9zkFNU+d1xUB/jqxbfijQ7r3UjII7VAdiFYflzHVfnvywFLlnEz1Zg13UCdgBS9ZvN/LHTavmvrIrYEOJYwjN1Q1sXwWpd8ombHElHjXw1Vm3HN9tegquYRyag==;5:4fXjKTaWKwnLOAKLR3iIHUyB/IMKWd5dsMtE22Bjdr7nc0GGw3iVXucJJ20Ib8fQae+Kyj9vceW22x/dmPCzwVLWReFcIn+ECrSsD/fp+ddK4/DkhkrEWJBXKKN2v2z0Ae3Gt4MRN+Qeh1kCeGpDME91HW85qaTnb3heMvc/wi4=;7:2zf5wTMeD28hhLabJlbSGJY8F1/ioxNjfUfkNp59/JJRV6wEhB42CAuDBCiZdXrP9uFYfNAbkXVhri6cK1Vhz7V6UrM8BtxNyp3gCttz5xGjOe9ZpRYocmtkRya7zTLiep5KytP1lQKLuxvVoo1QHk5xu/ve+/LSxj9q5ekmuQZCz8PLSJh8PHriTee2o3QT6Bnz153eCGdrQtJEjJZnq/s/Da/pVAa6kFE8LQcvXhCGbGnU/DqSA36M82o8pADz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d544261-ea47-4035-9e74-08d60cdc509a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR06MB4151;
x-ms-traffictypediagnostic: AM6PR06MB4151:
x-microsoft-antispam-prvs: <AM6PR06MB4151A80C41BE6EDEA04315709A0A0@AM6PR06MB4151.eurprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR06MB4151;BCL:0;PCL:0;RULEID:;SRVR:AM6PR06MB4151;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(25786009)(14444005)(99286004)(256004)(7736002)(14454004)(2900100001)(486006)(7696005)(8936002)(5250100002)(106356001)(186003)(305945005)(105586002)(86362001)(2351001)(316002)(2501003)(81166006)(1730700003)(81156014)(6436002)(6916009)(6116002)(33656002)(102836004)(8676002)(26005)(97736004)(3846002)(2906002)(478600001)(66066001)(74316002)(9686003)(68736007)(53936002)(476003)(6506007)(5640700003)(55016002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR06MB4151;H:AM6PR06MB4231.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hexagon.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jkz3SAgeE8fHWp3Cr1v82/H28UVPyJ5H+PMy0H/z+wWys/r+ZqqST8Eqq7CkYupoqTnDytqRQV+cfmNOTc7vIN5DC9Eoz5PCIQKYQbRn1tSHoqsVUt12GU532II07l6Xj+sbKwjPuUSKDZZdmZ24K80uvaMqDjDPS2R3KQAEGeUGVxcHUfYSRKfFSBNXMYoGpQMDxoDU6eKnjfGYwzIeLDDr1xneKU5HGLHt1jv06VlaiVO/Fp/yX43rim7oimmX4Aul2cZY3KhxhwDZtHfwy6JRusVwxMHT5bhBbpPakdnDQ3syOWCmoVu9ggk1Ab5Msx60NfkZRuPq+nx+xJtOrFv73kFykKbhYHAqBP+hpTY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hexagon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d544261-ea47-4035-9e74-08d60cdc509a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 11:49:30.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4151
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I was looking for the possibility of sorting the output of the command "git=
 diff --stat" by the number of modifications. Currently, the output of this=
 command show the modified files by alphabetic order.
I didn't find a "builtin" option which allows to sort the files by number o=
f modifications.

It is possible to do it with a "| sort <good_option>" but you may lose the =
coloration and it's not desirable.
If this option already exist, please send me a link to it and I apologize b=
y advance.

Fabien ROZAR
