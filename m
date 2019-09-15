Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A931F463
	for <e@80x24.org>; Sun, 15 Sep 2019 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfIORHy (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 13:07:54 -0400
Received: from mout.web.de ([212.227.15.4]:45759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfIORHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 13:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568567265;
        bh=eF3/cDrijOgUlN9ac2jfMkauWTYxieBXLqdZeUY71Vk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=rL7hHy4iyCK5/UuCZ8b+1ZmxjPAkPRm8I0s8hpyG01/F8vbRNAReiRNt7dTb0/kAb
         7CaNrWW53AAjLNVkt8JJov/5MixKhKFcWrJT2Wx3TTpin4y5xBoRyqwHMDA4vWnthY
         orrvMm76DOTyO1f3PxfR5U0jhgWYRfTPY/WGa76M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUVrX-1hilda2omB-00RKoT; Sun, 15
 Sep 2019 19:07:45 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-graph: use commit_list_count()
Message-ID: <1d28fb89-6ed6-b70f-762c-b65cffeb6705@web.de>
Date:   Sun, 15 Sep 2019 19:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFR2tIMFZovfNdqt7ht+/e7hSUvEzH9tK1UGB72DSqxSDhbSLEB
 ROcpBaye3fIxuZ9s16/1CBFqYmbk7P+AJlcKrU7yJHrILugnt6poGu96qVDT8wNZb/F6Lxu
 VOkpOMJy6gY/zG5mbeAQQsQY7Fkyx21hN8FhKZ0P2oWdqFLtnC77xUfc0/9FXANgGMa+9Jb
 mPgasMJF4t5PLjirGXK9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3RYK8cUzQQo=:ZQQBNmNroRhI0oeQ65N6LR
 QI4U+8K2nTRoVLDRDpSYVB69NFNkK8E5F51PQ0FuSiS9tIEf3iY9iU2L0BblnW/6+OyP1EpzM
 k6yAh4MeRzEh0ekshERypr0eQH8UkJyvdpsDZbG8kGe6atM4cBELdc/1l9dYXsN2XZvHKJ7vz
 HPa67ykoyB3NdM+lk8Gw2IUYRPfhcCB+qBEBFQCy21xy/m1Y2mdYQyDP681l6Ny7FAa6VB+W8
 chgKF7X6M7xUNUgkIWO9aVDSWksdtUzlc5a1WW+zk8OLJs0Cg0/laWnvH3TzpXf8fP1IkHwt+
 E4tGh3CLSpjZ7cPDriI5GyUf/8GMvLfYmoWaDqt9/gSxcnqy7/HpgKuzMBIqgwGm+B/yYih5/
 ctvNp51qtg+QLEa5ple/9cEcNmPc2CeI2qrk+FqSJGhGbC6Oqc3YcZA9OWCTkjWxbpkDz7uNR
 wkHDwcqVdtLwZfaybkZQbaHpRj+7u4jj579EmizFUNu/xX3hIwrdMWYSmBXLeamkFSejjeZu2
 vkUnJT8VmWDqfLZwB5gQRYRY2RLNKFRdOY9MTcXWwKQU1O40wlZY9Z8YRuKXDz+X4u15dG6FX
 miHhosT7GMyCq9RM/eyq7qUZq47TLqAWYTmT4I1Hs9qFQ/tVliwuk+5rMuDKJREQMvGDLK4Zs
 FV6FpIAu0YxOmPjam6LC2ReaFIDSHxAE4K1jG5hdnCZLnWeND1Y6UXnBPXb0zzaa6UqLzsMGt
 iOoLj9IeDzDBVu07PgYAAPc/wdf+pIaQ4q+vZyv2KdCWjheRVmQcpNoVJLEnnE2jRRTrlsW3j
 JiaeMSNJLNiuu7FLnUXvbMHLyqg/bnHy4775VzFQ732dFb7ITbB5gdRAHmxc0rQEiJTTzA3lf
 f4Y1wGEuFX8HNe1Wh7hgrPwzjMFL5xbpkoByA7h2Dxo2Xec/oRxa6xXReS/r4abpBS6Yrp68X
 JAu+KMYFFuy9M0gSTiJv1kyVhNyvs06LDrHdgmtvaibV3iAt33AiDFCN5Oy62LXiFl5ir5RjB
 TJNNv6V49/T47CkxyNaz0knfo90uE1lGvOuQh3c2wnqrzVuFCM7PTYFIMiOIARboJRvO8NNsN
 dlBAZTm2jar0i5qJY3ocdZBwLuZBulkPtYjRdW1V1bJyU3fxpHkSzpuQZsI5zk1riQ4VRBxJb
 56yLhndUnqL5Ns5emZh8+V96BidvBu0QgenlZBVrNv2EuFetu7OBGJ0aGVryBg+ejsUigGK1z
 JZUYfrnVwnWNI8jO1u6c25mvsCdy0x4jUTmiMeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let commit_list_count() count the number of parents instead of
duplicating it.  Also store the result in an unsigned int, as that's
what the function returns, and the count is never negative.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-graph.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..5b0d6b5adc 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -1279,7 +1279,6 @@ static uint32_t count_distinct_commits(struct write_=
commit_graph_context *ctx)
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	struct commit_list *parent;

 	ctx->num_extra_edges =3D 0;
 	if (ctx->report_progress)
@@ -1287,7 +1286,8 @@ static void copy_oids_to_commits(struct write_commit=
_graph_context *ctx)
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
 	for (i =3D 0; i < ctx->oids.nr; i++) {
-		int num_parents =3D 0;
+		unsigned int num_parents;
+
 		display_progress(ctx->progress, i + 1);
 		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
 			continue;
@@ -1301,10 +1301,7 @@ static void copy_oids_to_commits(struct write_commi=
t_graph_context *ctx)

 		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);

-		for (parent =3D ctx->commits.list[ctx->commits.nr]->parents;
-		     parent; parent =3D parent->next)
-			num_parents++;
-
+		num_parents =3D commit_list_count(ctx->commits.list[ctx->commits.nr]->p=
arents);
 		if (num_parents > 2)
 			ctx->num_extra_edges +=3D num_parents - 1;

@@ -1616,8 +1613,7 @@ static int commit_compare(const void *_a, const void=
 *_b)

 static void sort_and_scan_merged_commits(struct write_commit_graph_contex=
t *ctx)
 {
-	uint32_t i, num_parents;
-	struct commit_list *parent;
+	uint32_t i;

 	if (ctx->report_progress)
 		ctx->progress =3D start_delayed_progress(
@@ -1635,10 +1631,9 @@ static void sort_and_scan_merged_commits(struct wri=
te_commit_graph_context *ctx)
 			die(_("unexpected duplicate commit id %s"),
 			    oid_to_hex(&ctx->commits.list[i]->object.oid));
 		} else {
-			num_parents =3D 0;
-			for (parent =3D ctx->commits.list[i]->parents; parent; parent =3D pare=
nt->next)
-				num_parents++;
+			unsigned int num_parents;

+			num_parents =3D commit_list_count(ctx->commits.list[i]->parents);
 			if (num_parents > 2)
 				ctx->num_extra_edges +=3D num_parents - 1;
 		}
=2D-
2.23.0
