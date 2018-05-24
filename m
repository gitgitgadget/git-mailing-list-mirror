Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2D41F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030908AbeEXQZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:37 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030515AbeEXQZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBp8k+FyB9TeociEWRVwWYFEpKvlC1VGzzV0Glk4SyQ=;
 b=IN1rPgcPSyBZc8bxFraMSoFj0wkX3eAUgq7WZuCNtq2rxK6KZpSS7/wki1qvMGWPXKcu80U6R9vNartRFJuc4PsYYRWF6ItakSX1CEpy9qzsnfxgVAzG2UcUZC3DjdboYnKXK/t0yZThlvGXcy3OhDOyIKpTfBsjxvB7C4jaRro=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:24 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
Thread-Topic: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
Thread-Index: AQHT83vQyBBJyv9yoEiy3bFw2WxQ4Q==
Date:   Thu, 24 May 2018 16:25:23 +0000
Message-ID: <20180524162504.158394-1-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:vJJPVPoT4AKZYmlbZV62tFvt0n1bxfLg14mK1o2URFDTMTM8XHUeQ2xkKwb6Es9ElJo4dNrUpPK8k98gRFh2BNiBA9ASLRe7TxcrYOBg5Q0qB5qobFHlZsSu5LbZ7w0/RbBGeNvaGk3/lnNHfM3ReF//GKA5wRR4XP2zy1V3mSUHJ0A2TN95w56v1M6EbzBALA6MgOsO74Bsadg3/VxZqDE0hGhAci3mikspaYelpxctcLHs4R3qFZWi1MujJydD;20:CCiLI1Y7W5V5ubRZKXHO6DCUKkCR3Sfe49gb5OAmsTfgoJT4yreT6WUQdrM+s1J7o1GZ9mRNcC3ogviPM8g2dc0iM4IyhVARC+wwlSjPbuyjR1k5+JckafGBBfVisQSSWANnlx7MqyqOVkL618CrImG5OQQTl4F5bJ0QPGXq7u8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091DDFC2BA7EEA623AE441DA16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(69224002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(575784001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5BkBBLGfGKgPGpMztbkSvckZpa7OoQxj8f4mlqVIhfAclNNSJF3eWE52y04Em/PT4PJl9ZYTFPug6E40gyjw+d9PmLgFcanOZQ2iMDtuvemqCzD9FgHr7/eXGvRpwdWwoh/+yngZ7sLP8K5hw84gFKDRYwvAoekMhzRK0QlwnTF1ZXjdifgEudtf+5xUawDq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: de0aa1a0-5fcf-4d05-9ba9-08d5c192f311
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0aa1a0-5fcf-4d05-9ba9-08d5c192f311
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:23.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the feedback on v2. I've tried to make this round's
review a bit easier by splitting up the commits into smaller pieces.
Also, the test script now has less boilerplate and uses variables and
clear arithmetic to explain which bytes are being modified.

One other change worth mentioning: in "commit-graph: add '--reachable'
option" I put the ref-iteration into a new external
'write_commit_graph_reachable()' method inside commit-graph.c. This
makes the 'gc: automatically write commit-graph files' a simpler change.

Thanks,
-Stolee

Derrick Stolee (20):
  commit-graph: UNLEAK before die()
  commit-graph: fix GRAPH_MIN_SIZE
  commit-graph: parse commit from chosen graph
  commit: force commit to parse from object database
  commit-graph: load a root tree from specific graph
  commit-graph: add 'verify' subcommand
  commit-graph: verify catches corrupt signature
  commit-graph: verify required chunks are present
  commit-graph: verify corrupt OID fanout and lookup
  commit-graph: verify objects exist
  commit-graph: verify root tree OIDs
  commit-graph: verify parent list
  commit-graph: verify generation number
  commit-graph: verify commit date
  commit-graph: test for corrupted octopus edge
  commit-graph: verify contents match checksum
  fsck: verify commit-graph
  commit-graph: add '--reachable' option
  gc: automatically write commit-graph files
  commit-graph: update design document

 Documentation/config.txt                 |   6 +
 Documentation/git-commit-graph.txt       |  14 +-
 Documentation/git-fsck.txt               |   3 +
 Documentation/git-gc.txt                 |   4 +
 Documentation/technical/commit-graph.txt |  22 ---
 builtin/commit-graph.c                   |  59 +++++++-
 builtin/fsck.c                           |  21 +++
 builtin/gc.c                             |   6 +
 commit-graph.c                           | 234 +++++++++++++++++++++++++++=
++--
 commit-graph.h                           |   3 +
 commit.c                                 |   9 +-
 commit.h                                 |   1 +
 t/t5318-commit-graph.sh                  | 196 ++++++++++++++++++++++++++
 13 files changed, 539 insertions(+), 39 deletions(-)


base-commit: 34fdd433396ee0e3ef4de02eb2189f8226eafe4e
--=20
2.16.2.329.gfb62395de6

