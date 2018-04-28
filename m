Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F151F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeD1Wo3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:52023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeD1Wo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:28 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MW8PN-1esu2o3nJp-00XMlp; Sun, 29 Apr 2018 00:44:24 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 02/12] commit: Let the callback of for_each_mergetag return on error
Date:   Sun, 29 Apr 2018 00:44:17 +0200
Message-Id: <97428f56890413d16f1487309972c446b61f784f.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:eS3tAf5tQhXRo/3MuOz6ocysZidmE8Bs3FaeirtALYl9sCrdsE8
 AfbYnpitZToIpAODlwZzmrFwQR0Ir7XKX88Jmj6/wQ628wz2mgxrWutIu1FxAMQYkQI+SeS
 OL/L+nqPNT/55gkUbltIw3ehAoR5B9+Q9Rr67/n67Oe0f0YHtDM9JLhM9a57Le4ptIL+uwB
 3JxnIGvDY/dqnRSXyXMZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WoDTZQq8xB0=:t7W1ewNVLHXBJUYp9FOvMT
 n6DB0VCXAi3Ve+LAGPSG1FIAxGADxEdRTuIR/lwmk6opNjSO/gJyR6n2UnMclbodkLsVc/P47
 a0vH/1+QIgL9CEnzm3We4oqvN0ZOKX18UBnF/mMG0lhnoiHfL3/9F6362/0/EqXdly/+B+/F9
 MNFAj6HvvVSvKPiU/jx6/WzDuQvBItTUIa5/jmAW2qDobfCv44+g2vWGz7nga/LwJqCvTGBwa
 0sUoCMTZ7DTtRVklSJrRsjdYMxTzluu/2DcrocxxSdSI5nY6htx7Z9JlkcaDgMf1jkx0iMROL
 73GH9fj32a+H5iE7aGg0ce4XBbwNZ4aNV0d9sW1Yms7CQoRZIspLwObwCkFUxTviN+4X9GslQ
 qWMc25vf2fUjwkPc0klfEIqM84t7P5kAnHHSEDPXVo+eDfN5tU+i0tc9iUofHqAxMF1CmcJQw
 6NQ3hulhrvnf/PatjSJyUL+eSdPL6exVl6etzuarmvCNubnCN829WvrVfl4kfTEBKiCPmTBCO
 Lk3CqY7q5JGzSb96W0i35oFqBcCi8u95QamyQ1BuHTTrMSbgRtFFk1faMXmdNMqcUHGNlgCfS
 3gkh3ohLMVAHjpzaBnCCFMn9zD50exHlSTUGtOIqi9LZ2yYhn+WKef8b33SakyOLBbMp7wVva
 06HHBr8PH72jh3S63huofnxD2cmzBN9BPQ5Lk+A8Gac7pms+IVH1H3AskyNLPOru9WVaKgUct
 DfNoXBotSOC9c5SzGaYZ7UcCICBu3GzrxzDyP1ksBwD61wl9YKvBGlXxCFIZpHF+79Hl5t8HU
 9ryWYvu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch to be filed under the keyword "libification".

There is one subtle change in behavior here, where a `git log` that has
been asked to show the mergetags would now stop reporting the mergetags
upon the first failure, whereas previously, it would have continued to the
next mergetag, if any.

In practice, that change should not matter, as it is 1) uncommon to
perform octopus merges using multiple tags as merge heads, and 2) when the
user asks to be shown those tags, they really should be there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c |  8 ++++----
 commit.c          |  8 +++++---
 commit.h          |  4 ++--
 log-tree.c        | 13 +++++++------
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 935647be6bd..245d3f4164e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -345,7 +345,7 @@ struct check_mergetag_data {
 	const char **argv;
 };
 
-static void check_one_mergetag(struct commit *commit,
+static int check_one_mergetag(struct commit *commit,
 			       struct commit_extra_header *extra,
 			       void *data)
 {
@@ -368,20 +368,20 @@ static void check_one_mergetag(struct commit *commit,
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
-			return; /* found */
+			return 0; /* found */
 	}
 
 	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
 	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
 }
 
-static void check_mergetags(struct commit *commit, int argc, const char **argv)
+static int check_mergetags(struct commit *commit, int argc, const char **argv)
 {
 	struct check_mergetag_data mergetag_data;
 
 	mergetag_data.argc = argc;
 	mergetag_data.argv = argv;
-	for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
+	return for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
 }
 
 static int create_graft(int argc, const char **argv, int force)
diff --git a/commit.c b/commit.c
index ca474a7c112..2952ec987c5 100644
--- a/commit.c
+++ b/commit.c
@@ -1288,17 +1288,19 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	return extra;
 }
 
-void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
+int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
 {
 	struct commit_extra_header *extra, *to_free;
+	int res = 0;
 
 	to_free = read_commit_extra_headers(commit, NULL);
-	for (extra = to_free; extra; extra = extra->next) {
+	for (extra = to_free; !res && extra; extra = extra->next) {
 		if (strcmp(extra->key, "mergetag"))
 			continue; /* not a merge tag */
-		fn(commit, extra, data);
+		res = fn(commit, extra, data);
 	}
 	free_commit_extra_headers(to_free);
+	return res;
 }
 
 static inline int standard_header_field(const char *field, size_t len)
diff --git a/commit.h b/commit.h
index 0fb8271665c..9000895ad91 100644
--- a/commit.h
+++ b/commit.h
@@ -291,10 +291,10 @@ extern const char *find_commit_header(const char *msg, const char *key,
 /* Find the end of the log message, the right place for a new trailer. */
 extern int ignore_non_trailer(const char *buf, size_t len);
 
-typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
+typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
 
-extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
+extern int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
 
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf244..f3a51a6e726 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -488,9 +488,9 @@ static int is_common_merge(const struct commit *commit)
 		&& !commit->parents->next->next);
 }
 
-static void show_one_mergetag(struct commit *commit,
-			      struct commit_extra_header *extra,
-			      void *data)
+static int show_one_mergetag(struct commit *commit,
+			     struct commit_extra_header *extra,
+			     void *data)
 {
 	struct rev_info *opt = (struct rev_info *)data;
 	struct object_id oid;
@@ -502,7 +502,7 @@ static void show_one_mergetag(struct commit *commit,
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
 	tag = lookup_tag(&oid);
 	if (!tag)
-		return; /* error message already given */
+		return -1; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
@@ -536,11 +536,12 @@ static void show_one_mergetag(struct commit *commit,
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
+	return 0;
 }
 
-static void show_mergetag(struct rev_info *opt, struct commit *commit)
+static int show_mergetag(struct rev_info *opt, struct commit *commit)
 {
-	for_each_mergetag(show_one_mergetag, commit, opt);
+	return for_each_mergetag(show_one_mergetag, commit, opt);
 }
 
 void show_log(struct rev_info *opt)
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


