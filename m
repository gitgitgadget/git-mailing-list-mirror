Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9541F424
	for <e@80x24.org>; Wed,  9 May 2018 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756589AbeEIOPl (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:15:41 -0400
Received: from mail-dm3nam03on0100.outbound.protection.outlook.com ([104.47.41.100]:12227
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932857AbeEIOPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3RMZN0Os0amt+GQYAiMWiBSE8woGHY4YcS8NlMIWyqI=;
 b=g9Ya6+MQttiLOwpdLxFFeMDYszvXLEH3/inAfCdBoohYelb/rvNaB93/uA/cyXIl23/Y9BGn07VK3nNmSM2p+KL5merGc3PkxJ4dmvWB7n0M1PrhubBq23hZ5yGq/MWs6o00gO9QPnapTiAfKOVz9ru4JdnDMuRbHKhE7RPve+Q=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Wed, 9 May 2018 14:15:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Wed, 9 May 2018
 14:15:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/1] Fix UX issue with commit-graph.lock
Thread-Topic: [PATCH 0/1] Fix UX issue with commit-graph.lock
Thread-Index: AQHT56A0rdCiZgH4W0qtVQkb0X9cIA==
Date:   Wed, 9 May 2018 14:15:37 +0000
Message-ID: <20180509141523.89896-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:405:1::24) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:uG8U+sOPpjLPiMUwbCGvf55oR1xWmi2PgwKke2ZefG7DAP79hQ4WxXltq1mVfWqbpq3DVeZtA7W2yjSaCBgQXip7DSpMDFJqq68OmzIH4D6h2fOhqNJ7kfZC02XqgtzmwWlC8nNTnszVRqsNAZgvWPZZj0B2Qk9XETv5b46RhcXr4BQUJaFzz4KnTPerBAPQFWwuaI/NKXFaZWZwBXrcbdBtOM29cd9tlaahvNVJhSP3TbrWQuhzE2rCxL+nbl0P;20:kVEP4qrqBeQuhpo/xhRST3+eq2VlhX1k+UF8HvaPqp7cvyEOmJkcXBD59sUOGiOzviO8a70AL/xXEYNfEgpyx7cuEwBzDAK4oXgeh9MskLHVhKtkVU0BW+0Z31OUM9LzL4WGf/oWYOqwT7EI15XNMhZlfEAJ+cgmBdqGd5gTTDQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044EF2813AE263F0D9C0D59A1990@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(6436002)(305945005)(1730700003)(81156014)(4326008)(52116002)(5250100002)(99286004)(8676002)(59450400001)(14454004)(10090500001)(7736002)(6506007)(386003)(2501003)(2906002)(2900100001)(86612001)(81166006)(39060400002)(8656006)(6346003)(107886003)(1076002)(8936002)(3280700002)(6512007)(6916009)(6116002)(53936002)(102836004)(186003)(3660700001)(97736004)(68736007)(10290500003)(5640700003)(22452003)(86362001)(54906003)(36756003)(2351001)(46003)(486006)(5660300001)(478600001)(6486002)(105586002)(476003)(316002)(2616005)(25786009)(106356001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: Iu8VCb2pc5lNOFASP/P7YGdC4UzQ3nPhb59HCn5xRRxgaZ2l4oe0gYI3Xc9z7vbKyCa/Y+MVmTQVZRaxTMcBnfP1ZLNHEb8fkKN034yDhv02H1WNKmssOkFfUEJkAHZd+8/Fqx4TVpTaBCUAWxqH2FwHb/B9rkcSCxEsc5yW8aDSTIDLCal2mMYHUMCrwfA0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 123daf00-479b-4eb2-1d5a-08d5b5b75618
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123daf00-479b-4eb2-1d5a-08d5b5b75618
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 14:15:38.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the lockfile API to avoid multiple Git processes from writing to
the commit-graph file in the .git/objects/info directory. In some cases,
this directory may not exist, so we check for its existence.

The existing code does the following when acquiring the lock:

1. Try to acquire the lock.
2. If it fails, try to create the .git/object/info directory.
3. Try to acquire the lock, failing if necessary.

The problem is that if the lockfile exists, then the mkdir fails, giving
an error that doesn't help the user:

  "fatal: cannot mkdir .git/objects/info: File exists"

While technically this honors the lockfile, it does not help the user.

Instead, do the following:

1. Check for existence of .git/objects/info; create if necessary.
2. Try to acquire the lock, failing if necessary.

The new output looks like:

  fatal: Unable to create '/home/stolee/git/.git/objects/info/commit-graph.=
lock': File exists.

  Another git process seems to be running in this repository, e.g.
  an editor opened by 'git commit'. Please make sure all processes
  are terminated then try again. If it still fails, a git process
  may have crashed in this repository earlier:
  remove the file manually to continue.

This patch is based on ds/generation-numbers

Derrick Stolee (1):
  commit-graph: fix UX issue when .lock file exists

 commit-graph.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)


base-commit: 7547b95b4fbb8591726b1d9381c176cc27fc6aea
--=20
2.17.0.39.g685157f7fb

