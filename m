Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB801F424
	for <e@80x24.org>; Thu, 26 Apr 2018 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756273AbeDZUwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 16:52:22 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:50816
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754472AbeDZUwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 16:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WuEvZMZOg7/bBEi0DQPcuEbgjsBRdJ8biHOCStYadK4=;
 b=Dfi7sA6Xnx9ORRAF99+wRd/JqNDuk1cdCwBX85wG1zYXXUqezNfoVa45yPU9MZ9ldIE7L98P396Cu6R9pAHgJnuXDayuKU0uISoWbs34gM7nnckKgtLnAJlGt3d4YmJVXv4xKyOxtBvBMVJb/hX9mVLlDxaY+6vxYck+SDkeW5M=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0997.namprd21.prod.outlook.com (52.132.133.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.5; Thu, 26 Apr 2018 20:52:18 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.006; Thu, 26 Apr 2018
 20:52:18 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 0/3] add merge.renames config setting
Thread-Topic: [PATCH v3 0/3] add merge.renames config setting
Thread-Index: AQHT3aB28GAqWz4Zhk2LPLfLEaVPuA==
Date:   Thu, 26 Apr 2018 20:52:18 +0000
Message-ID: <20180426205202.23056-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
In-Reply-To: <20180420133632.17580-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:ymneAYHhn+6B6+fi/UypaJr3KgZpXXtc1RrKnB++tdw0318FGdTGMvi2pRU3VhxMoLf3wfzaua+6vwPMD/jzapQYOsHjLFNzlXclYBHZ0oLckkJR8LqgZPdgpSvnRATQWge2lS9MfY/HVsVIqURPAvXzIlXTnCukLK7Z7HVHlDz7ggQ4DT34zdmYEIbGuG72vD2fIpGGCX3agrz8zEJCTYRExOne8gF50ZqZwG+1KT09bIogVzqquLC43Kfnf/Sp;20:EMdqVlY5F+KwlnZu0UiXIEZjJyyZKdtuIe/tVdOIt1ywwsqefXS36apC7qmD0CHIuGocZev2a572BAIhaik8jKyysKZPGhHZ10DpO0DHuL6vIABS0zyunP4wEFqahW/eH3j52chn1Wl7hpocNjOpNp7ph/Dh4zEY5bXNvLULSdg=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0997CB4AA34D8CDB4E11D016F48E0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(39380400002)(199004)(189003)(107886003)(3846002)(39060400002)(106356001)(6116002)(97736004)(6916009)(81166006)(66066001)(2616005)(14454004)(53936002)(50226002)(6486002)(1730700003)(5640700003)(6306002)(8676002)(6512007)(5250100002)(81156014)(966005)(1076002)(26005)(10090500001)(305945005)(8936002)(10290500003)(105586002)(25786009)(575784001)(4326008)(68736007)(54906003)(2906002)(52116002)(7736002)(86612001)(22452003)(5660300001)(478600001)(102836004)(186003)(72206003)(6436002)(446003)(2351001)(11346002)(386003)(8666007)(8656006)(76176011)(99286004)(486006)(316002)(6506007)(3280700002)(36756003)(3660700001)(59450400001)(2501003)(2900100001)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nztDTyXnW3lvBU/kmJ0/ztW2ElJlNrUlopOoPpRjIF743YmdAOMSjLSz2CufxvqE6jftqjcxMddy6TaY5MkiLoLwDd7GCsReiX4VsBH+kOiAHx3MsLlowqtmFOyqyPudbrRM76IQ0/dm/epg5zwqqjSwgOseBxYaQZJNjGrQn1HTW34LxtFDWqnAilzKhpmA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e7a00063-aec6-428a-084e-08d5abb79898
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a00063-aec6-428a-084e-08d5abb79898
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 20:52:18.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a complete rewrite based on the feedback from earlier patches.

Update the documentation to better indicate command line options that overr=
ide
various config settings related to merge.

Add a new config merge.renames setting to to control the rename detection
behavior of merge.  This setting will default to the value of diff.renames.

Also adds logic so that when rename detection is turned off, the aggressive
flag is passed to read_tree() so that it can auto resolve more cases that w=
ould
have been handled by rename detection.

For the repro that I have been using this drops the merge time from ~1 hour=
 to
~5 minutes and the unmerged entries goes down from ~40,000 to 1.

Helped-by: Kevin Willford <kewillf@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/6a8372d517
Checkout: git fetch https://github.com/benpeart/git merge-options-v3 && git=
 checkout 6a8372d517

### Patches

Ben Peart (3):
  merge: update documentation for {merge,diff}.renameLimit
  merge: Add merge.renames config setting
  merge: pass aggressive when rename detection is turned off

 Documentation/diff-config.txt             |  3 ++-
 Documentation/merge-config.txt            |  9 +++++++-
 Documentation/merge-strategies.txt        |  6 +++--
 diff.c                                    |  2 +-
 diff.h                                    |  2 ++
 merge-recursive.c                         | 27 +++++++++++++++++------
 merge-recursive.h                         |  8 ++++++-
 t/t3034-merge-recursive-rename-options.sh | 18 +++++++++++++++
 8 files changed, 62 insertions(+), 13 deletions(-)


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
--=20
2.17.0.windows.1


