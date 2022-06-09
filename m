Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3FFC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiFIIFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiFIIFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 04:05:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F8BC8C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 01:05:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n28so30124202edb.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pIS70QQO3QVVQGPBb3XW/hJB4Oor9FI9eCij65kPXI4=;
        b=Nus+uEnTEogOn4gDeYlQ+BFgQfW2HXQ7TrLDN8PFSddgLmtfTNCj1DtySz6TJ3S/RZ
         SnfO9fnZLhZOkCxntJCT5GooSuBWomCRaqSNRvpS/ESPJmAWkDH2n5jPIBQx2IAK+4N1
         J0BjH9FZkuwV4HaJkR8/4EEDq3LKUatyihC3SDq3vSe0lUxwmchTLYFJPrKIichOLtwB
         j8SYeeO89HBpaGlL3FBoliJe/PX1LsRQ4Ha0ofoy6ODoeSVscCbeLIZPXLe84PjW5yu3
         mDTOqBpPPNJbVUmfwGmvEdX5zbCRQhKBQip7GrRwiYe8c2JryidjSAWR4+lSZTSxVuHM
         UYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pIS70QQO3QVVQGPBb3XW/hJB4Oor9FI9eCij65kPXI4=;
        b=qTBmF7cYqGPGyTHk7e8FW010diLHthNYxchAMKGrxt68VpKYfa3k+hkLJCGlbjGhxb
         if7oHUC97iMM1PVnrmGu+P73M5B/oQVGsZJ/njhFm/4s6eHj9V64ZOVoD4jFDpGnAX/T
         IFzk2G3Ws0w0czmywAngGFrRhWJRSeWLuFMLhFGyl6cwbAGNPGXKWUr3AVis2/ny99ZQ
         g5LB58MhQ8fdHl4+lM3Sfrt/xjqiKZBQgdyU9yc9Na+2q77LflpAIMvJGKG01L/v+waJ
         4g8Stkm9nDWjvWd/NHZRXLI3iNpUb/wWXm34YzxRyBWoGU9LmNNXVuBk4oVmI1JGtiSN
         /SJA==
X-Gm-Message-State: AOAM530H3j6K4f5Js3a+T+sxO9f9i94k81S9kxFabCCsMgHsIkk2ocyp
        4V2iIaSonYqrzDOlzSFQHJ0=
X-Google-Smtp-Source: ABdhPJxx0m4BiGN7qSXEtfoG3nwDU63zTyE9gY4g7TzFPzhFNoXV/6y6W1myFnZwmg8EMPQuBNHVEQ==
X-Received: by 2002:a05:6402:390b:b0:42a:acb3:bb5 with SMTP id fe11-20020a056402390b00b0042aacb30bb5mr42757331edb.236.1654761941207;
        Thu, 09 Jun 2022 01:05:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm13919705edb.13.2022.06.09.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:05:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzDAi-002lVu-3n;
        Thu, 09 Jun 2022 10:05:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: commit-graph overflow generation chicken and egg
Date:   Thu, 09 Jun 2022 09:49:15 +0200
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
Message-ID: <220609.86h74utg6j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Derrick Stolee wrote:

> On 6/8/2022 3:33 PM, Jeff King wrote:
>> [...]
> You've done enough homework to discover exactly what's going on here,
> including talking about the commit that I was going to point out.
>
>> Presumably we _are_ ignoring those chunks, but some other part of the
>> commit-graph file has a dependency on them (and of course we don't have
>> the new GDA2/GDO2 chunks to read in their place). If that's true, then
>> the solution may be a more graceful "we can't use this commit graph"
>> error return rather than the "fatal:" message seen above.
>> 
>> I have a copy of the broken repo state if anybody would care to look at
>> it.
>
> I'd love to see the full binary, but for the sake of sharing on the
> list, could you give the following output?
>
> [...]
>
> But otherwise, I'm stumped. I'd be very interested to see a repro from a
> fresh repository. That is: what situation do we need to be in to write such
> an offset without including the large offset chunk?

It's certainly interesting to see *how* we got to this state, but just
so we're on the same page: I fundimentally don't think it matters to the
*real* bug here.

Which is that at the very least f90fca638e9 (commit-graph: consolidate
fill_commit_graph_info, 2021-01-16) and e8b63005c48 (commit-graph:
implement generation data chunk, 2021-01-16) (CC'd author) have a bad
regression on earlier fixes that read-only operations of the
commit-graph *must not die*. I.e. the "parse" and "verify" paths of the
commit-graph.c code shouldn't call exit(), die() etc.

I.e. the changes I made in 2ac138d568a (commit-graph: fix segfault on
e.g. "git status", 2019-03-25), 61df89c8e55 (commit-graph: don't early
exit(1) on e.g. "git status", 2019-03-25) and 43d35618055 (commit-graph
write: don't die if the existing graph is corrupt, 2019-03-25).

The below patch is a start at fixing some of that, but as noted in the
TODO comments I really wouldn't trust it as-is (and haven't looked
deeply into this).

If you replace your graph with Jeff's corrupt one and run "git status",
"git log" etc. it's still emitting one verbose complaint, but it no
longer does so in loops (at least for these paths, but e.g. "git gc" is
still doing that).

But it does get us to where we can run "git gc", and while complaining
too much along the way will write out a new & valid commit graph at the
end ("[... comments are mine"):
	
	$ git gc
	[...]
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
	[... a lot of the above lines snipped out ...]
	Enumerating objects: 1306881, done.
	Counting objects: 100% (1306881/1306881), done.
	Delta compression using up to 8 threads
	Compressing objects: 100% (262837/262837), done.
	Writing objects: 100% (1306881/1306881), done.
	Selecting bitmap commits: 378069, done.
	Building bitmaps: 100% (380/380), done.
	Total 1306881 (delta 1047925), reused 1293996 (delta 1036311), pack-reused 0
	Removing duplicate objects: 100% (256/256), done.
	commit-graph requires overflow generation data but has none
	commit-graph requires overflow generation data but has none
        [... these 2x warnings came from "git prune" ...]
	Checking connectivity: 10359, done.
	Expanding reachable commits in commit graph: 344133, done.
	commit-graph requires overflow generation data but has none
	Computing commit changed paths Bloom filters: 100% (344133/344133), done.
	Writing out commit graph in 7 passes: 100% (2408931/2408931), done.

If anyone wants to run with it the below hack has my SOB.

diff --git a/commit-graph.c b/commit-graph.c
index 92d45033366..58e238aaa57 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -202,6 +202,20 @@ static struct commit_graph *alloc_commit_graph(void)
 
 extern int read_replace_refs;
 
+static int verify_commit_graph_error;
+
+__attribute__((format (printf, 1, 2)))
+static void graph_report(const char *fmt, ...)
+{
+	va_list ap;
+
+	verify_commit_graph_error = 1;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
 static int commit_graph_compatible(struct repository *r)
 {
 	if (!r->gitdir)
@@ -220,6 +234,9 @@ static int commit_graph_compatible(struct repository *r)
 	if (is_repository_shallow(r))
 		return 0;
 
+	if (verify_commit_graph_error) /* TODO: will be stale? */
+		return 0;
+
 	return 1;
 }
 
@@ -625,6 +642,10 @@ static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
 
+	if (verify_commit_graph_error) /* TODO: will be stale? */
+		return 0;
+
+
 	/*
 	 * Early return if there is no git dir or if the commit graph is
 	 * disabled.
@@ -766,7 +787,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	return &commit_list_insert(c, pptr)->next;
 }
 
-static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
+static int fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
@@ -776,8 +797,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
+	if (pos >= g->num_commits + g->num_commits_in_base) {
+		graph_report(_("invalid commit position. commit-graph is likely corrupt"));
+		return 0;
+	}
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
@@ -793,8 +816,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 
 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
-			if (!g->chunk_generation_data_overflow)
-				die(_("commit-graph requires overflow generation data but has none"));
+			if (!g->chunk_generation_data_overflow) {
+				graph_report(_("commit-graph requires overflow generation data but has none"));
+				return 0;
+			}
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
 			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
@@ -805,6 +830,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 
 	if (g->topo_levels)
 		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
+
+	return 1;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -825,7 +852,8 @@ static int fill_commit_in_graph(struct repository *r,
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	fill_commit_graph_info(item, g, pos);
+	if (!fill_commit_graph_info(item, g, pos))
+		return 0;
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
@@ -946,6 +974,8 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 void load_commit_graph_info(struct repository *r, struct commit *item)
 {
 	uint32_t pos;
+	if (verify_commit_graph_error) /* TODO: will be stale? */
+		return;
 	if (!prepare_commit_graph(r))
 		return;
 	if (find_commit_pos_in_graph(item, r->objects->commit_graph, &pos))
@@ -2444,19 +2474,6 @@ int write_commit_graph(struct object_directory *odb,
 }
 
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
-static int verify_commit_graph_error;
-
-__attribute__((format (printf, 1, 2)))
-static void graph_report(const char *fmt, ...)
-{
-	va_list ap;
-
-	verify_commit_graph_error = 1;
-	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
-	fprintf(stderr, "\n");
-	va_end(ap);
-}
 
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
@@ -2510,9 +2527,11 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(r, g, graph_commit))
+		if (!parse_commit_in_graph_one(r, g, graph_commit)) {
 			graph_report(_("failed to parse commit %s from commit-graph"),
 				     oid_to_hex(&cur_oid));
+			return verify_commit_graph_error;
+		}
 	}
 
 	while (cur_fanout_pos < 256) {


