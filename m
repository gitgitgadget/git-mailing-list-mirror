Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FD91F404
	for <e@80x24.org>; Wed, 11 Apr 2018 18:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDKSh5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:37:57 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:63414
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752311AbeDKShz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fG1Q2g36LkiejAu2PG29FHR09LYF/zAsZ5VtLHFY98E=;
 b=ND8UcdmVvkcXUx9gunlf/o5hdKf+vuVhbqqsdbu6UdBZaojKdFUOQk0IHoa35RWJhsIAbKhNgED5zRty0kVu7qj/7VhDPgmq2f1jjftqv3gCK9Ok02xKz36XJcizH2UrRFhZSENbgZpb9VmHPQXrPMgeAYKqD+1Ci53Vt8nP9Dc=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.0; Wed, 11 Apr 2018 18:37:53 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 18:37:53 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 0/3] Extract memory pool logic into reusable component
Thread-Topic: [PATCH v4 0/3] Extract memory pool logic into reusable component
Thread-Index: AQHT0cQzXrV3RyDdXkKxrOL4vNcsMg==
Date:   Wed, 11 Apr 2018 18:37:53 +0000
Message-ID: <20180411183738.113809-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:Hqin4OeGVmk858YkTHLVVe5UGjeNXmVOXETgsqa1nNel6mWOHT3Ca8N4CWzGvWYLu9FW9sQEgvlx25WQcqDOCxzNQNyNfMsSkOr4t+5BHJtpX8eXA4Bevy1n8v40k/RQJW0+BV4KcQeGRYpLDRS7Ko0OgU6G5Qi+69qNwAYNKULqa54LgkEYiM522RGqXiZU8Un1DdJfTRQetdT8buohFe9T6KtLdcVzJ6OlhdI4gphPqL8VXNS/kTqIzA86Uoqn;20:id84Altf6PC855VHgLP9f4KYpM8s5A0Qigi9IHl+XQ2muAHZxyC+FT+ctiwUB+t5ZKrjS7wOiC6L3QxqEKHHWPlNN+0lz/tLsTlc5B+YBJA00usDQrKQv4V5VVmfkbW211W49pfJSHSARvIGq4rS/WYniLpd9HLr6/ihfkrTs00=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0994C1D63AC330B766163BD1CEBD0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(189003)(199004)(8656006)(52116002)(25786009)(54906003)(486006)(102836004)(22452003)(76176011)(68736007)(106356001)(446003)(59450400001)(305945005)(5640700003)(316002)(6506007)(46003)(6116002)(386003)(476003)(5250100002)(6436002)(186003)(86612001)(10090500001)(2501003)(6512007)(53936002)(99286004)(86362001)(7736002)(11346002)(2900100001)(105586002)(10290500003)(2616005)(478600001)(4326008)(2351001)(81156014)(8676002)(1730700003)(81166006)(97736004)(2906002)(36756003)(8936002)(5660300001)(6486002)(6916009)(1076002)(3280700002)(3660700001)(14454004)(107886003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o8N8aAGrOH5OoK7ZGd42/nygHADavkvaHHq3BvNfwlHn2Z7aKgvc8PNxtQTy2s6ThIhbu4Qv8dIZ+8dHrGnmSZsk4xZxdIpprhXNnkHDoVAuHZ7KyAfZuVYgnGpIkkrmbFC8fPKP7iarE259VZidi5l2CdBxrfJ/BxeGLw7/hwxnWyecLhTeVE+0ETd4GNHUpKe/OhfzYC2Zjnvw7gLTTI+aZFR1hYw7M9sYMZ9+91mIW9AiI3zWpuPK3JevphYYlPNEAtdCTOEvEyGx1VbRXOlC/dvUcuWQseBmOGgj3se6DVOoCOADdNjlHpzAOS8Pki1OuTVmWwYtQXnWWr6uv3nEYA2AdfF4rf528vyAKRbV+5PhmnKU2qQXCq1P85uDbpJ/Fui4b+Cw7NZtl8Jie2H8wVy4ka2wvIWXRaCPsO0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7e01092d-74a8-47da-c4ab-08d59fdb55a7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e01092d-74a8-47da-c4ab-08d59fdb55a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:37:53.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you everyone for taking the time review and provide feedback on
this patch series.

Changes from v3:

  - Based patch off of new commit, to resolve merge conflict.

  - Updated log message in 2/3 based on feedback.

  - Squashed patch from Ramsay Jones into 2/3 to fix warning from
    sparse.

  - Updated variable names in 2/3 to reflect updated usage of
    variable.

Jameson Miller (3):
  fast-import: rename mem_pool type to mp_block
  fast-import: introduce mem_pool type
  Move reusable parts of memory pool into its own file

 Makefile      |  1 +
 fast-import.c | 77 +++++++++++++------------------------------------------=
----
 mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    | 34 ++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 61 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

--=20
2.14.3

