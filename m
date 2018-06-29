Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6C51F516
	for <e@80x24.org>; Fri, 29 Jun 2018 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeF2SDr (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 14:03:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44715 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeF2SDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 14:03:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so9622136wrn.11
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QG27QPFVatBwVkmYXIi5xFWiZqu/wnTn8MMo/jYON7M=;
        b=c5QM5f1A/GWjCGybwHfR+ZMPIUqoCRcpTa+o4MsPV+E7vRdPjAxJIsWViATjShJoTy
         NwGyYPn+onRTC+Xjxabv2XCwpTnmToeSyKGCaXLDz1huL4rliZNGY44JtyZSd84qM108
         k+YAeKBm19R8qhvNCXlOcmu5Q0jBeye+8sA8PY5RsWUy/Q+W8w3Bgzzn11lHYOYzAe+r
         AnR7VTV9TtjHNznhCFTXZnesEeSwswsHo53FugMruoL/f0Wrslxb1J1o9gQBLTMfq2mS
         /IfxAa7ueB/SWwJ2ZJSbodYca3a1nXPGqJzyfTzAiHfsNvHbRjl851dc1XXU46CCvoAb
         Fcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QG27QPFVatBwVkmYXIi5xFWiZqu/wnTn8MMo/jYON7M=;
        b=LAeiLhJN5qSNgny6jFQxqEJdcmcU2xsrWK+I9/3DqwyhOxlFfPZ+ojmed7+wyVf3Hq
         N310h08Ac603UfxHdEImFYAq7+HD4ZKvGDwljhPwb+3aPq7tmWzEPLGqdUkt8j6Zhr/7
         NduLtCRWX9ERbgkl5XupNNTRj6aJVqHRU9UZx1TT/22O9zbf4u33bPS1CHl5fR7VyZfw
         0LZ3mmWIrFHRJwmuo6tbgnECugV2wREgMTQyzZWaH++XTYZ+1NKnHpP9m3SwqIjIWR8Z
         AOXIFivLm62EdlVm+LWVy9uCrKbz0XOcw9MMJoP7ITyG07hFnsF4UIB5pv0k+08A0Ho1
         Zyjg==
X-Gm-Message-State: APt69E0mnY8I6RA+b3JMgkWwD8V3qPoQkX4QsD5K+rPy11BbYQXb7lIX
        IH24LUH+m0HQvfyOhUMk/7DKRc/v
X-Google-Smtp-Source: AAOMgpdyvoAwLMP3prqNN2ah2tOZCv+eQfWA8z3gDEomOf/z1wfSiq7ajts7F0rTGtN/jB7WkK4lNw==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr12898905wri.124.1530295424929;
        Fri, 29 Jun 2018 11:03:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x11-v6sm12378002wrm.78.2018.06.29.11.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:03:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
References: <20180629012222.167426-1-sbeller@google.com>
        <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 29 Jun 2018 11:03:43 -0700
In-Reply-To: <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 29 Jun 2018 10:57:40 -0700")
Message-ID: <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One technique these (not just this) recent efforts seem to be
> forgetting is to introduce "new" names that take a_repo and then
> make the existing one a thin wrapper that calls the new one with
> &the_repo as the argument.

FWIW, here is how I am resolving semantic conflicts that I found so
far while merging this topic to 'pu', which is stored in the
merge-fix/ mechanism so that I can reuse it while rebuilding 'pu'.

-- >8 --
Subject: [PATCH] merge-fix/sb/object-store-lookup

---
 builtin/bisect--helper.c | 2 +-
 builtin/branch-diff.c    | 2 +-
 commit-graph.c           | 4 ++--
 negotiator/default.c     | 3 ++-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fc02f889e6..b27f645744 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -231,7 +231,7 @@ static int bisect_write(const char *state, const char *rev,
 		goto fail;
 	}
 
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	log_commit(fp, "%s", state, commit);
 
 	if (!nolog)
diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 8a16352e3a..b8604e3fec 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -329,7 +329,7 @@ static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 		strbuf_addf(buf, " %d:  %s", j + 1,
 			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
 
-	commit = lookup_commit_reference(oid);
+	commit = lookup_commit_reference(the_repository, oid);
 	if (commit) {
 		const char *commit_buffer = get_commit_buffer(commit, NULL);
 		const char *subject;
diff --git a/commit-graph.c b/commit-graph.c
index e4dee03679..41a0133ff7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -924,7 +924,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			cur_fanout_pos++;
 		}
 
-		graph_commit = lookup_commit(&cur_oid);
+		graph_commit = lookup_commit(r, &cur_oid);
 		if (!parse_commit_in_graph_one(g, graph_commit))
 			graph_report("failed to parse %s from commit-graph",
 				     oid_to_hex(&cur_oid));
@@ -950,7 +950,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
-		graph_commit = lookup_commit(&cur_oid);
+		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, cur_oid.hash, alloc_commit_node(r));
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report("failed to parse %s from object database",
diff --git a/negotiator/default.c b/negotiator/default.c
index 382fc77722..d8c92281bb 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -38,7 +38,8 @@ static void rev_list_push(struct negotiation_state *ns,
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
+	struct object *o = deref_tag(the_repository,
+				     parse_object(the_repository, oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
-- 
2.18.0-129-ge3331758f1



