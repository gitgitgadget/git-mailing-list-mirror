Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8BF215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeEAMrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:07 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:50394
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755252AbeEAMrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CJ32A/qp8DR7ZwEuy47McfPUUmvpRa6aSz7AV+nUekA=;
 b=lxMliq0qrw8ixYemL1dcqTT9SOE0Pr6aeY6e4J40EOUssHsXi8fU75I3GcfxPPt7Zhync12EiPgvi4vwFu3oUERzK1Hx58IF/oTsOr1SQyPpQNHa/6mlFsXDGlqmVmA3XbG0OizP6o4nd2LPB+5TOtjuBVKNzIDWye8fqVwKYyQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:03 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 00/11] Compute and consume generation numbers
Thread-Topic: [PATCH v5 00/11] Compute and consume generation numbers
Thread-Index: AQHT4UqAGwcTYited0G1WVlBs+WHEA==
Date:   Tue, 1 May 2018 12:47:03 +0000
Message-ID: <20180501124652.155781-1-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:MkKKMxV9XgFIBuiQbA6rhjocajMC1xjjAAUPBP7ZCya7s97Ml56L8133xg8wyMuTD2X6Br63yGRyBUdMcNgked925eBVkSpEqtG8GA00ls59oyQU0GPb/x8O4zXj8vGvR/oGS8FvmUh3n0mfvaxubik/7Xphc8/ekxLJIt8/m2Wo/8W1q896vohYY8sXPAp8oTA+6CXMqrqmTRSqAG2gbxFGiZqQOnRpnXNkSxeXNB+xoZsXWnggPdrZF5caqZfR;20:ntWoZUF290qSHciQuj4MG2ML1dEJkmITc57lrPKp7U9XRiU4HibqRXs/6ANTGxRU9P6zZR5wgVf7dVMQB5LImv39TLpdGfHqf015l6KFbCpSWpIKe/5vWpqyVG2mNsCuYZQmcE/c/YEg1pk1bZj8ZD4bCVrUpHcKsQZlBDnZSoQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB09774E6CA7A15958939D4771A1810@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(102836004)(53936002)(6506007)(386003)(59450400001)(99286004)(2900100001)(54906003)(5640700003)(3280700002)(3660700001)(2906002)(6512007)(6486002)(25786009)(39060400002)(4326008)(107886003)(86612001)(6436002)(6346003)(8656006)(36756003)(52116002)(76176011)(105586002)(106356001)(5660300001)(6916009)(5250100002)(2501003)(97736004)(7736002)(68736007)(8676002)(81166006)(81156014)(10290500003)(8936002)(478600001)(86362001)(486006)(10090500001)(6116002)(476003)(2351001)(1730700003)(186003)(1076002)(305945005)(446003)(22452003)(46003)(2616005)(316002)(11346002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: V/VMcWYuR0YTXyTIUn/YPzc+MKlMBpzTRus2ClufBRJHBm/HcVib0d7+LIeeTJgWm2mDt7mEGjliFk4qlMY7ASAzheVAlDFwDM6bvGVvyGaHEUlqR2gbfloX6D1otAHJAn3VxSCjE55P+vXAW1M6I1UmOVHQfatiD+qbba3WNKrCxaaM9+1rfNhbS1IS3Q/6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ee96f4c5-9b21-476b-c4ed-08d5af61a330
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee96f4c5-9b21-476b-c4ed-08d5af61a330
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:03.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the changes from v4 are cosmetic, but there is one new commit:

	commit: use generation number in remove_redundant()

Other changes are non-functional, but do clarify things.

Inter-diff from v4:

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index d9f2713efa..e1a883eb46 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -125,9 +125,10 @@ Future Work
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
   priority queue with one ordered by generation number. The following
-  operation is an important candidate:
+  operations are important candidates:

     - 'log --topo-order'
+    - 'tag --merged'

 - Currently, parse_commit_gently() requires filling in the root tree
   object for a commit. This passes through lookup_tree() and consequently
diff --git a/commit-graph.c b/commit-graph.c
index aebd242def..a8c337dd77 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -248,6 +248,7 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 static void fill_commit_graph_info(struct commit *item, struct commit_grap=
h *g, uint32_t pos)
 {
        const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH_D=
ATA_WIDTH * pos;
+       item->graph_pos =3D pos;
        item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
 }

@@ -454,8 +455,7 @@ static void write_graph_chunk_data(struct hashfile *f, =
int hash_len,
                else
                        packedDate[0] =3D 0;

-               if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY)
-                       packedDate[0] |=3D htonl((*list)->generation << 2);
+               packedDate[0] |=3D htonl((*list)->generation << 2);

                packedDate[1] =3D htonl((*list)->date);
                hashwrite(f, packedDate, 8);
@@ -589,18 +589,17 @@ static void close_reachable(struct packed_oid_list *o=
ids)
        }
 }

-static void compute_generation_numbers(struct commit** commits,
-                                      int nr_commits)
+static void compute_generation_numbers(struct packed_commit_list* commits)
 {
        int i;
        struct commit_list *list =3D NULL;

-       for (i =3D 0; i < nr_commits; i++) {
-               if (commits[i]->generation !=3D GENERATION_NUMBER_INFINITY =
&&
-                   commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
+       for (i =3D 0; i < commits->nr; i++) {
+               if (commits->list[i]->generation !=3D GENERATION_NUMBER_INF=
INITY &&
+                   commits->list[i]->generation !=3D GENERATION_NUMBER_ZER=
O)
                        continue;

-               commit_list_insert(commits[i], &list);
+               commit_list_insert(commits->list[i], &list);
                while (list) {
                        struct commit *current =3D list->item;
                        struct commit_list *parent;
@@ -621,10 +620,10 @@ static void compute_generation_numbers(struct commit*=
* commits,
                        if (all_parents_computed) {
                                current->generation =3D max_generation + 1;
                                pop_commit(&list);
-                       }

-                       if (current->generation > GENERATION_NUMBER_MAX)
-                               current->generation =3D GENERATION_NUMBER_M=
AX;
+                               if (current->generation > GENERATION_NUMBER=
_MAX)
+                                       current->generation =3D GENERATION_=
NUMBER_MAX;
+                       }
                }
        }
 }
@@ -752,7 +751,7 @@ void write_commit_graph(const char *obj_dir,
        if (commits.nr >=3D GRAPH_PARENT_MISSING)
                die(_("too many commits to write graph"));

-       compute_generation_numbers(commits.list, commits.nr);
+       compute_generation_numbers(&commits);

        graph_name =3D get_commit_graph_filename(obj_dir);
        fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
diff --git a/commit.c b/commit.c
index e2e16ea1a7..5064db4e61 100644
--- a/commit.c
+++ b/commit.c
@@ -835,7 +835,9 @@ static struct commit_list *paint_down_to_common(struct =
commit *one, int n,
                int flags;

                if (commit->generation > last_gen)
-                       BUG("bad generation skip");
+                       BUG("bad generation skip %8x > %8x at %s",
+                           commit->generation, last_gen,
+                           oid_to_hex(&commit->object.oid));
                last_gen =3D commit->generation;

                if (commit->generation < min_generation)
@@ -947,6 +949,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
                parse_commit(array[i]);
        for (i =3D 0; i < cnt; i++) {
                struct commit_list *common;
+               uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;

                if (redundant[i])
                        continue;
@@ -955,8 +958,12 @@ static int remove_redundant(struct commit **array, int=
 cnt)
                                continue;
                        filled_index[filled] =3D j;
                        work[filled++] =3D array[j];
+
+                       if (array[j]->generation < min_generation)
+                               min_generation =3D array[j]->generation;
                }
-               common =3D paint_down_to_common(array[i], filled, work, 0);
+               common =3D paint_down_to_common(array[i], filled, work,
+                                             min_generation);
                if (array[i]->object.flags & PARENT2)
                        redundant[i] =3D 1;
                for (j =3D 0; j < filled; j++)
@@ -1073,7 +1080,7 @@ int in_merge_bases_many(struct commit *commit, int nr=
_reference, struct commit *
        for (i =3D 0; i < nr_reference; i++) {
                if (parse_commit(reference[i]))
                        return ret;
-               if (min_generation > reference[i]->generation)
+               if (reference[i]->generation < min_generation)
                        min_generation =3D reference[i]->generation;
        }


-- >8 --

Derrick Stolee (11):
  ref-filter: fix outdated comment on in_commit_list
  commit: add generation number to struct commmit
  commit-graph: compute generation numbers
  commit: use generations in paint_down_to_common()
  commit-graph: always load commit-graph information
  ref-filter: use generation number for --contains
  commit: use generation numbers for in_merge_bases()
  commit: add short-circuit to paint_down_to_common()
  commit: use generation number in remove_redundant()
  merge: check config before loading commits
  commit-graph.txt: update design document

 Documentation/technical/commit-graph.txt | 30 ++++++--
 alloc.c                                  |  1 +
 builtin/merge.c                          |  7 +-
 commit-graph.c                           | 91 ++++++++++++++++++++----
 commit-graph.h                           |  8 +++
 commit.c                                 | 61 +++++++++++++---
 commit.h                                 |  7 +-
 object.c                                 |  2 +-
 ref-filter.c                             | 26 +++++--
 sha1_file.c                              |  2 +-
 t/t5318-commit-graph.sh                  |  9 +++
 11 files changed, 204 insertions(+), 40 deletions(-)


base-commit: 7b8a21dba1bce44d64bd86427d3d92437adc4707
--=20
2.17.0.39.g685157f7fb

