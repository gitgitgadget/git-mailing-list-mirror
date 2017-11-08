Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA361F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 19:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbdKHTzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 14:55:36 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:47693 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdKHTza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:30 -0500
Received: by mail-io0-f195.google.com with SMTP id h70so7247377ioi.4
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZeN492dz0zOdxifj7/3cmy41cspgV2RR9o2Q2+Qh/8=;
        b=HS84h9ANHd+xatmryD+JJxiJ7YHw2dGUpGq4GeoGE7cEsdMwqSPDu8itm1Kt6PEu/u
         EXgskOxtElmJjQ6LV9xYtSkPVCGwY5sRci1FlZRcay5CA3JSvrb1U3/4gWO056EwG/bY
         SmBnfDmCIsAvT5zPknmu1Aj4jz3uzR+aIcL32xTbnfN/Enck4oIB0/pDwEy2OBg9j1k5
         JdkhJBfeKvWqCbpIkiD5QZvU9lBID2GdexA89RFqW+U/Z5XY43HsGKFzGpkny7pNNz9Q
         dSm20amU1H9QFEDbJ3kl37sb1uTMKJd9B5ugFQih8M7GL1IVJWWFefV8kZLIHTaUPDtC
         2Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZeN492dz0zOdxifj7/3cmy41cspgV2RR9o2Q2+Qh/8=;
        b=rDYFCpPWYLzGN5UJaAOaoFNfUOizU2tD46LqWOFNTrzsrUB7eFYO5c8E3EUQZ4F5DN
         Ark5j1lYpeYyaYy8nM3Nbvnm7t9fqOqBiqGY8h8dVDbmp9EnCgQxhpmjYBXqDdzSQmBa
         OBkrT7HXYzew5hCu54j9PkkD+nUKjX3mzC8wUV44SXas+B4hOFNU+ms2jMi89cZoNi5F
         cBOP4NV+1osgxQrnwwvvn1P9lQMmtLIQffXPcV0jDW4yxcha7+bamQ8cxkfu8B3C1i6B
         KTbCk+wWmd1o/mMJj1BDHnLV674aes4E17yFIQya5c6im6fWd73fbJS/BFJk3n3OdSBS
         pEDA==
X-Gm-Message-State: AJaThX4lsm9hYrbIaPl3rY9/vmGSkJ159sdn5xsk/0axPn8RAQTfSQy8
        SfcHb4KNqkbZPKMPEnq3wSra8x+r1Y8=
X-Google-Smtp-Source: AGs4zMaxvp3brIBeZ601uASrnTQGwDVhe6GES2TGx+lbDsyxwIbKQph+oQdlQamf1Vt2aU2s4rK/BA==
X-Received: by 10.107.104.16 with SMTP id d16mr2080176ioc.128.1510170929416;
        Wed, 08 Nov 2017 11:55:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c178:b390:b6a8:a0e2])
        by smtp.gmail.com with ESMTPSA id h20sm2187304iob.65.2017.11.08.11.55.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 11:55:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] git-status: report reference to superproject
Date:   Wed,  8 Nov 2017 11:55:09 -0800
Message-Id: <20171108195509.7839-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171108195509.7839-1-sbeller@google.com>
References: <20171108195509.7839-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a submodule the position of HEAD in relation to the gitlink pointer
in the superproject may be of interest.

Introduce a config option `status.superprojectInfo` that when enabled
will report the relation between HEAD and the commit pointed to by the
gitlink in the index of the superproject.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 +++++
 builtin/commit.c         |  2 ++
 t/t7519-superproject.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c              | 37 +++++++++++++++++++++++++++++++
 wt-status.h              |  1 +
 5 files changed, 102 insertions(+)
 create mode 100755 t/t7519-superproject.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f0d62753d..7825a1a7be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3097,6 +3097,11 @@ status.submoduleSummary::
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
 
+status.superprojectInfo
+	Defaults to false.
+	This shows the relation of the current HEAD to the commit pointed
+	to be the gitlink entry in the superprojects index.
+
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
diff --git a/builtin/commit.c b/builtin/commit.c
index c38542ee46..f937f6c6cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1286,6 +1286,8 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			s->submodule_summary = -1;
 		return 0;
 	}
+	if (!strcmp(k, "status.superprojectinfo"))
+		s->superproject_info = git_config_bool(k, v);
 	if (!strcmp(k, "status.short")) {
 		if (git_config_bool(k, v))
 			status_deferred_config.status_format = STATUS_FORMAT_SHORT;
diff --git a/t/t7519-superproject.sh b/t/t7519-superproject.sh
new file mode 100755
index 0000000000..ade2379a59
--- /dev/null
+++ b/t/t7519-superproject.sh
@@ -0,0 +1,57 @@
+
+
+test_description='git status for superproject relations'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	test_create_repo sub &&
+	# this whole file tests superproject reporting, so set this config here
+	git -C sub config status.superprojectInfo true
+'
+
+test_expect_success 'repo on initial commit does not mention superproject' '
+	git -C sub status > actual &&
+	test_i18ngrep "No commits yet" actual &&
+	test_i18ngrep -v superproject actual
+'
+
+test_expect_success 'setup submodule' '
+	test_commit -C sub initial &&
+	git submodule add ./sub sub
+'
+
+test_expect_success 'submodule in sync with superproject index' '
+	git -C sub status >actual &&
+	test_i18ngrep "superproject points at HEAD" actual
+'
+
+test_expect_success 'submodule in sync with superproject' '
+	git commit -a -m "superproject adds submodule" &&
+	git -C sub status >actual &&
+	test_i18ngrep "superproject points at HEAD" actual
+'
+
+test_expect_success 'submodule advances two commits' '
+	git -C sub commit --allow-empty -m "test" &&
+	git -C sub commit --allow-empty -m "test2" &&
+	git -C sub status >actual &&
+	test_i18ngrep "superproject is 2 commits behind HEAD" actual
+'
+
+test_expect_success 'submodule behind superproject' '
+	git add sub &&
+	git commit -m "update sub" &&
+	git -C sub reset --hard HEAD^ &&
+	git -C sub status >actual &&
+	test_i18ngrep "superproject is ahead of HEAD by 1 commits" actual
+'
+
+test_expect_success 'submodule and superproject differ' '
+	git -C sub commit --allow-empty -m "test2b" &&
+	git -C sub status >actual &&
+	test_i18ngrep "superproject and HEAD differ by +1, -1 commits" actual
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index bedef256ce..3e8e27a550 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,6 +1027,41 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static void wt_longstatus_print_superproject_relation(struct wt_status *s)
+{
+	struct object_id oid;
+	struct commit *in_gitlink, *head;
+	int head_nr, gitlink_nr;
+
+	if (get_superproject_gitlink(&oid))
+		return;
+
+	in_gitlink = lookup_commit(&oid);
+
+	read_ref("HEAD", &oid);
+	head = lookup_commit(&oid);
+
+	compare_commits(head, in_gitlink, &head_nr, &gitlink_nr);
+
+	if (!head_nr && !gitlink_nr)
+		printf(_("superproject points at HEAD\n"));
+	else if (!head_nr)
+		printf(_("superproject is ahead of HEAD by %d commits %s..%s\n"),
+			 gitlink_nr,
+			 find_unique_abbrev(head->object.oid.hash, DEFAULT_ABBREV),
+			 find_unique_abbrev(in_gitlink->object.oid.hash, DEFAULT_ABBREV));
+	else if (!gitlink_nr)
+		printf(_("superproject is %d commits behind HEAD %s..%s\n"),
+			 head_nr,
+			 find_unique_abbrev(in_gitlink->object.oid.hash, DEFAULT_ABBREV),
+			 find_unique_abbrev(head->object.oid.hash, DEFAULT_ABBREV));
+	else
+		printf(_("superproject and HEAD differ by +%d, -%d commits %s...%s\n"),
+			 gitlink_nr, head_nr,
+			 find_unique_abbrev(head->object.oid.hash, DEFAULT_ABBREV),
+			 find_unique_abbrev(in_gitlink->object.oid.hash, DEFAULT_ABBREV));
+}
+
 static int has_unmerged(struct wt_status *s)
 {
 	int i;
@@ -1593,6 +1628,8 @@ static void wt_longstatus_print(struct wt_status *s)
 		if (!s->is_initial)
 			wt_longstatus_print_tracking(s);
 	}
+	if (!s->is_initial && s->superproject_info)
+		wt_longstatus_print_superproject_relation(s);
 
 	wt_longstatus_print_state(s, &state);
 	free(state.branch);
diff --git a/wt-status.h b/wt-status.h
index 64f4d33ea1..75700980d2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -70,6 +70,7 @@ struct wt_status {
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
+	int superproject_info;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
-- 
2.15.0.128.g40905b34bf.dirty

