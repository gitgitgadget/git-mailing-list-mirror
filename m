Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767021F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeINTwP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:52:15 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51842
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeINTwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7hBSNURokrKNQ9/Q3rv6ecPICA3DK7VcGkshOJmLOY=;
 b=Kpp/2ue2R0ehFTX5AK3LmhigdCVN+7MpR+Z+6+OqpZ7sGG9CfEgcbHHX7mdXpB0p2LPfzRvDrrLUu/60BCq+P20bX3c0TBHn7ztqdmZ9OnaPK6psSpBcAJ8y4tUQzL9QtnxPQcFjdzdeNCB5oTI6PG5CpY1GSG0qKxYzVwQQCTs=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Fri, 14 Sep 2018 14:37:24 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 14:37:24 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 0/4] Cleanup pass on special test setups
Thread-Topic: [PATCH v1 0/4] Cleanup pass on special test setups
Thread-Index: AQHUTDhzBSgd38rRQ02L8+0LgVRgEQ==
Date:   Fri, 14 Sep 2018 14:37:24 +0000
Message-ID: <20180914143708.63024-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:903:129::23) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:Y+oNsF2zikfiopVLyd06mRCQUqp3nfpbM8AQi7VkEr+2wGawIa+5WR42dvuyjiHvG5gomcjMWTJV5/lLWFLqutMCXgLhUEp3svsz0U7N6X5iMXoYtTq2jp8j9/I2R3bOtSPDp4i7G2rL20oMH45wCQR3WNAF+yTxibA3MRCsKMSh9xW/GLQEvJH4ymHTgP6J6AgiQ+n1q3z4nwg7PVdQgpMGz9RcqjZa7nmulMKq/Ol18NmBhdRql4tHh1gMs6gIFJqwszKpSOrZhNebrDA9knTuzf14rio5NApWt7dY2I9SLtPKSrKGi5YvxM0oKZKoNCEAQncWFkAencnQaf9rPECIwXBDzp5MaPaeyD9ZRN9dbyNDeWReNptEQHKNdxWBT/g9Rf3Ht8OyUPJZv4rdYUTJPwk7GCuRKOY5kP4++bUZ+fWHuyd9pq/crCOxmtI4OKsUzjABOzWdSMjqSZ0a5g==;5:ANQ3rr/d4AMMaJSeORcOWZSlZ2yDPwB48aMTGl6/mRqMt78bbL4YuBkMcVgIO3H6fuA8AR+LVlfJXofYPM1/cznK0X6ttsOefDEkP5nxdqftX7DLgxbrCqJH6pK4qeTVueyx+U3VFRuW/DexS1STjwNUl4YoOAIkK2sZmZ8WqII=;7:6JdlScGBR5YZB985F7eFYuNcAKfwBjWJFs0Po/k1X3mYcOhITEDhOCiFU5SI4lov79YrZZajm8G+/0sMnmOxeWoGW0amge3nnGL7BfaPQluZ8jg5Sx8Ps4QGg0EvTuX8sFyACRciip75rLnBm897wCBmUc7a5wupi0h6FH6/ty9mPKcZvxLHCIA3I1DehG/azC+dUGPo23oWBagr1Tm40okJ2IDtm64WCg25RnpQAIzIZGASgka8u2izz7BeIF95
x-ms-office365-filtering-correlation-id: a1a71553-7c30-4767-6d7f-08d61a4f9631
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972F6FC8E54AD6FC5064527F4190@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(486006)(6346003)(3846002)(386003)(22452003)(6506007)(6436002)(26005)(186003)(53936002)(2900100001)(2616005)(5640700003)(5250100002)(6116002)(476003)(14454004)(316002)(25786009)(54906003)(6486002)(10090500001)(36756003)(2501003)(99286004)(1076002)(6512007)(6306002)(102836004)(97736004)(14444005)(52116002)(68736007)(66066001)(2351001)(106356001)(39060400002)(256004)(50226002)(8936002)(10290500003)(81166006)(81156014)(1730700003)(8676002)(107886003)(966005)(5660300001)(72206003)(478600001)(305945005)(6916009)(7736002)(2906002)(86612001)(575784001)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: 3im2Nump35FJBCOWPVK+claSj341KTgfgwhVjDnw972Qa37HXMuMW6wHVpVQ8UoQsNA7/TuAWdyDtbXH+ZeISvKYh7u9YK7Zdu1v4Yp06gV0aV7dl0NwdeyTxEBNohzFHcHUdqx0vOk13ilsLG9jXbRTgm07OnMBVmnHjOcnx7v9yfbI4LBVUkj/1ouBv6y2nzSL7VSKsLgl9kbez35MEexVOBPDsxkJ/YzWoLh36miIeJBtLqcfJTsgpNA7iaREFg87PJgZcFywRqWS/NHvppp6MfRF0MX6GdNCyt3df7quBxQGAkQYhYxF6mo5m54yC/tBsa/TRbbJ9VGffl7f6kUV4kb6PfHSGYyCrOe7fQo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a71553-7c30-4767-6d7f-08d61a4f9631
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 14:37:24.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As documented in t/README, the whole test suite can be run to test some
special features that cannot be easily covered by a few specific test cases=
.

Not all of these that exist in the code have been named consistantly and
documented in r/README which leads to a discoverability problem.  Update
several of these variables to follow the same naming pattern and document
them properly.

To facilitate transitioning from the old names to the new names, add logic
in t/test-lib.sh to give an error when the old variable is set to let peopl=
e
know they need to update their environment to use the new variable. If the
new variable is also set, just give a warning so they can eventually remove
the old variable.

Base Ref: v2.19.0
Web-Diff: https://github.com/benpeart/git/commit/eff73d737e
Checkout: git fetch https://github.com/benpeart/git git-test-cleanup-v1 && =
git checkout eff73d737e

Ben Peart (4):
  correct typo/spelling error in t/README
  fsmonitor: update GIT_TEST_FSMONITOR support
  read-cache: update TEST_GIT_INDEX_VERSION support
  preload-index: update GIT_FORCE_PRELOAD_TEST support

 Makefile                    |  6 +++---
 config.c                    |  2 +-
 preload-index.c             |  3 ++-
 t/README                    | 13 ++++++++++++-
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  6 +++---
 t/test-lib.sh               | 37 +++++++++++++++++++++++++++++++++++--
 7 files changed, 57 insertions(+), 12 deletions(-)


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1


