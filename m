Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117D11F404
	for <e@80x24.org>; Fri, 13 Apr 2018 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeDMMWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 08:22:45 -0400
Received: from mail-by2nam03on0134.outbound.protection.outlook.com ([104.47.42.134]:42048
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754210AbeDMMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 08:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ex0V87GB+sCtRRCoig/YDFHpPldHpC7V5zaXBGSTC/0=;
 b=KFs6GQY4iJ5a155b2vnPTcW+LF8/0R1KhfM0xfj1BjdGTEy2Saxl665JAFFM70MXciE5Sv9YA8342feZrUN5TSYBJaDoviZ42bUmVL2daYalDqd7hy0QayFab9/U1xjT5egZ6ThOI3+O+PIGvCqr4q2msoQhmPJtRjO2gb4qUUk=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1078.namprd21.prod.outlook.com (52.132.130.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 13 Apr 2018 12:22:42 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.008; Fri, 13 Apr 2018
 12:22:42 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Topic: [PATCH v3 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Index: AQHT0yIebFblcarW00KOfG1ztnYzSQ==
Date:   Fri, 13 Apr 2018 12:22:42 +0000
Message-ID: <20180413122218.1756-1-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
In-Reply-To: <20180410210408.13788-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0083.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::43) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1078;7:DiQFfsO2jRbOeI8dOvdXdDiku2TYcIAgxVLcpBDTFoWTiyqfPW4PrPtlQUw9RZqzq8nMS1+4nvQsBup9gqLa9amYhUnoe8Ly5o/RrSYLnLW6JjY0q20nSRs6iX78t6MyeRZEsM8tSbaGj4rNgwXHpf1dvFU+NbvuYFP5Y+5dFMUCo+BUjsCNWPj6QbCSekYI4RXjiLvRZNK8+xZMzr6pnSGW41nQ0BnredMyhSHHs2WJeWDqj3WDTPalIgin0HaW;20:vOjkTFQr5vqTuH8aQv+zt/K+BJQ2+89s9318dYAEPQK8cxmeqRvoDSMe9ss8Qmx1G56ygIEUQdd4+4bMiINg/R0jNR6srQW1VVtpEttj64ZNpygd9z9JiWj6uv6vNs8K9egfDVHL7Z78CdYUHIidDifCO1cRce8Kvp072MVohQU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1078;
x-ms-traffictypediagnostic: DM5PR2101MB1078:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1078F7C65E25ACAB135D14DEF4B30@DM5PR2101MB1078.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501343)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1078;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1078;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(39380400002)(376002)(199004)(189003)(7736002)(8676002)(81156014)(1076002)(305945005)(3846002)(86612001)(25786009)(39060400002)(4326008)(6116002)(575784001)(81166006)(2501003)(3280700002)(2906002)(106356001)(3660700001)(5250100002)(5660300001)(97736004)(68736007)(2900100001)(105586002)(66066001)(36756003)(8656006)(966005)(107886003)(50226002)(8936002)(6436002)(8666007)(6486002)(6512007)(6306002)(53936002)(316002)(22452003)(10090500001)(14454004)(72206003)(478600001)(486006)(54906003)(186003)(386003)(6506007)(2616005)(52116002)(476003)(26005)(446003)(10290500003)(102836004)(99286004)(76176011)(110136005)(11346002)(22906009)(43043002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1078;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 41915a16-2f2c-435c-b0ea-08d5a13940ab
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41915a16-2f2c-435c-b0ea-08d5a13940ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 12:22:42.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1078
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only minor changes from V2:=20

Switched to using get_dtype() instead of DTYPE() for platform independence.
Cleaned up reverting of fsmonitor code in the untracked cache.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/709470f33f
Checkout: git fetch https://github.com/benpeart/git fsexcludes-v3 && git ch=
eckout 709470f33f



### Patches

Ben Peart (2):
  fsexcludes: add a programmatic way to exclude files from git's working
    directory traversal logic
  fsmonitor: switch to use new fsexcludes logic and remove unused
    untracked cache based logic

 Makefile                    |   1 +
 dir.c                       |  47 +++++---
 dir.h                       |   2 -
 fsexcludes.c                | 211 ++++++++++++++++++++++++++++++++++++
 fsexcludes.h                |  29 +++++
 fsmonitor.c                 |  21 +---
 fsmonitor.h                 |  10 +-
 t/t7519-status-fsmonitor.sh |  14 +--
 8 files changed, 279 insertions(+), 56 deletions(-)
 create mode 100644 fsexcludes.c
 create mode 100644 fsexcludes.h


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
--=20
2.17.0.windows.1


