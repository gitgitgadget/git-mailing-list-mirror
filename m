Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65788C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4364D610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhDIBKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhDIBKb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D581C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t18so1554207plr.15
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lzoAv2PYg1zFTeOc2VKgtiK7aJuItGE4oFKiAPWaFSE=;
        b=BTE2J/Z9I85ODfTt9gU1wV+YPZa3JbdN8iEdoEe5P9PKHmOKl57/GRl6vjWU6synVW
         wLIPIg4JpxPmJyGBYh/Ses9E8RjUSp7YKXE8b03nYoaqjWuHkqsh4oaf2aWfoVLde+tC
         42iHHMOReJ0ZBct3NYBq5yHBBzOVH9iDGq+FmGBo7/+E0cVleZ7lcEpXYf1GCFMPsUxb
         1wewCw2ZkV36OlX/KQoyRcIEu+3idEjtTSFQTVnew5t62ubv/bsHgLFxuX6seHtdLCfW
         DiiHaecSyLWHgaYegJQtjZYhYZLZurxv4ZnyWPuaJse8my4xH5BZC6VpI2AqmndBUqU+
         7jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lzoAv2PYg1zFTeOc2VKgtiK7aJuItGE4oFKiAPWaFSE=;
        b=SC1QTysxxki94RZO3OwNzwdG+VEY4RYi8EZ2ih9mj5aPbR7R9k/PN8XE4/7u3uinQb
         Jx+lnFebmqW0sU+eMBTXjKyFszMY+7xhSzwQwRxtXzE8p/PkaJxNbKiVSUoEuLny/U/n
         nHvNCVJPADK+dh7utobFZgDSnJ4v/DXuvFFXxgtvLdANwKXAXQPQDRo4786NzFx6pLtr
         2/1eISUOwhKaEbMy6Gcg2O3K1voKu1GiHb4LPtM41ezQ+tr2IY57ECLD1sKMZQNkuZ9j
         XM/1ZnvQ7oRWKOounKRy08m3elg+8WQI/169eMSksOKamt0qQFc/i2LwFnCJ6DC6Aw9A
         EyOg==
X-Gm-Message-State: AOAM533Tnt4N8872wk4QOdVf0JcxofncK4FH/Rt/2rGNGTPdTIAw3AZK
        TvHJbejSmCxHU3MOtIUE3BG4fNkZbKWZZ8Wn0ckqUoh9t0qK2BVjzyd8D/3FA7sGspAZeYyEwMP
        FyQA7XLuFH1oxHjumaaghhU4j8TCNEQTaakyxIXg7DhOZLQ4NC8mCsVp2eENUGBj0D21WoFjYXL
        d0
X-Google-Smtp-Source: ABdhPJyZ79x656Xx04ahZzRkYGP4CqMPkU4Lup8e0I2IboN1b7k1jTzqaoLyAaims1gKUo3lX/9v1i7Qh//FrB8ud5kD
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e00c:: with SMTP id
 u12mr11187520pjy.133.1617930618578; Thu, 08 Apr 2021 18:10:18 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:10:03 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <a2daa1022c41820b2109d9572069d12684470cb8.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 6/6] send-pack: support push negotiation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git the push.negotiate config variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/push.txt |  7 ++++
 send-pack.c                   | 61 ++++++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh         | 35 ++++++++++++++++++++
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 21b256e0a4..f2667b2689 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -120,3 +120,10 @@ push.useForceIfIncludes::
 	`--force-if-includes` as an option to linkgit:git-push[1]
 	in the command line. Adding `--no-force-if-includes` at the
 	time of push overrides this configuration setting.
+
+push.negotiate::
+	If set to "true", attempt to reduce the size of the packfile
+	sent by rounds of negotiation in which the client and the
+	server attempt to find commits in common. If "false", Git will
+	rely solely on the server's ref advertisement to find commits
+	in common.
diff --git a/send-pack.c b/send-pack.c
index 5f215b13c7..9cb9f71650 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -56,7 +56,9 @@ static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struct send_pack_args *args)
+static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
+			struct oid_array *negotiated,
+			struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -94,8 +96,10 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	 * parameters by writing to the pipe.
 	 */
 	po_in = xfdopen(po.in, "w");
-	for (i = 0; i < extra->nr; i++)
-		feed_object(&extra->oid[i], po_in, 1);
+	for (i = 0; i < advertised->nr; i++)
+		feed_object(&advertised->oid[i], po_in, 1);
+	for (i = 0; i < negotiated->nr; i++)
+		feed_object(&negotiated->oid[i], po_in, 1);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
@@ -409,11 +413,55 @@ static void reject_invalid_nonce(const char *nonce, int len)
 	}
 }
 
+static void get_commons_through_negotiation(const char *url,
+					    const struct ref *remote_refs,
+					    struct oid_array *commons)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+	const struct ref *ref;
+	int len = the_hash_algo->hexsz + 1; /* hash + NL */
+
+	child.git_cmd = 1;
+	child.no_stdin = 1;
+	child.out = -1;
+	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
+	for (ref = remote_refs; ref; ref = ref->next)
+		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
+	strvec_push(&child.args, url);
+
+	if (start_command(&child))
+		die(_("send-pack: unable to fork off fetch subprocess"));
+
+	do {
+		char hex_hash[GIT_MAX_HEXSZ + 1];
+		int read_len = read_in_full(child.out, hex_hash, len);
+		struct object_id oid;
+		const char *end;
+
+		if (!read_len)
+			break;
+		if (read_len != len)
+			die("invalid length read %d", read_len);
+		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
+			die("invalid hash");
+		oid_array_append(commons, &oid);
+	} while (1);
+
+	if (finish_command(&child)) {
+		/*
+		 * The information that push negotiation provides is useful but
+		 * not mandatory.
+		 */
+		warning(_("push negotiation failed; proceeding anyway with push"));
+	}
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
 	      struct oid_array *extra_have)
 {
+	struct oid_array commons = OID_ARRAY_INIT;
 	int in = fd[0];
 	int out = fd[1];
 	struct strbuf req_buf = STRBUF_INIT;
@@ -426,6 +474,7 @@ int send_pack(struct send_pack_args *args,
 	int quiet_supported = 0;
 	int agent_supported = 0;
 	int advertise_sid = 0;
+	int push_negotiate = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
 	int use_push_options = 0;
@@ -437,6 +486,10 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	git_config_get_bool("push.negotiate", &push_negotiate);
+	if (push_negotiate)
+		get_commons_through_negotiation(args->url, remote_refs, &commons);
+
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
@@ -625,7 +678,7 @@ int send_pack(struct send_pack_args *args,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (need_pack_data && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+		if (pack_objects(out, remote_refs, extra_have, &commons, args) < 0) {
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f11742ed59..62fb9074a2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -191,6 +191,41 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 	)
 '
 
+grep_wrote () {
+	object_count=$1
+	file_name=$2
+	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
+}
+
+test_expect_success 'push with negotiation' '
+	# Without negotiation
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	echo now pushing without negotiation &&
+	GIT_TRACE2_EVENT="$(pwd)/event" git push testrepo refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+
+	# Same commands, but with negotiation
+	rm event &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	GIT_TRACE2_EVENT="$(pwd)/event" git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
+test_expect_success 'push with negotiation proceeds anyway even if negotiation fails' '
+	rm event &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+	test_i18ngrep "push negotiation failed" err
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
-- 
2.31.1.295.g9ea45b61b8-goog

