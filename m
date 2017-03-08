Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF8520135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdCHXdL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:33:11 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34063 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdCHXdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:33:09 -0500
Received: by mail-pf0-f182.google.com with SMTP id v190so20742675pfb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvgHlP5FNuqcWyUDJo+qCnedTzTvRHkW9SIN0xWlHxQ=;
        b=VD4/Eo3dtjt+qziTs9N7khdUZOMdySu+eFf+HQ4dV5VqYrIzWxRgKsoO1R8j0T+Bp2
         Gzjr1TKEVYQL13KOuYaNegkR4EiKgb4LnxkCEJaedvuVX7yYaTDU3RflCTnbh3zpSSOK
         XxC1CPC7P21fuNWoeQNiYKT+wWXFNiQDaiNQ1lDaUFUVKAxqA9SVjb4/K3/6NjJjN1zJ
         XsIzO0IYZ+RzgsTO9opMOBEZwV/iogEjuT38tRBw9gqQHX3kdzwG2F6X4dKJw/EyqW0B
         I1SUCuM3lcmic0RDhZiHgyT9x+eQ9fXVGkxd2mQ5S4ch3M2GWKs9ulbD6ktoSAPUBDmv
         kmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvgHlP5FNuqcWyUDJo+qCnedTzTvRHkW9SIN0xWlHxQ=;
        b=qEBHascKnLVcfZKXRWcw5Jq3txnifl5yuTIWvP9BRk/d0pb91WZWPOYIEJ10BpE+H3
         NJWpjG4mf1lV28w/5ZIPKDeHJ4tTrpy70u+VKhJtdBZp78X+YfBWErMyyBrheROoiBf8
         8/ZGLnY6nx7TYvwlUxV3d3hNo08Dmwa3kxB8WjkBw9cAavmJ2Iw7uyssQ4JzT4vBEmUc
         jX6A/3KV9KYLestmT0XVkqwRQDveKJ2kjxKAEL9oCy4tcKhu40uFrG56SueVwBrhanA2
         nemq5XzVt3wmbbOD4i6L3YBy8gIkKexpPdMADlSsr3LpvAeP5Lo0EPCarzZlGRLRQMxI
         OZxw==
X-Gm-Message-State: AMke39lFtM7mR32CZjbyIHEypgccoofYeSvheeXgXG34+yti8BlrEzo27d67T4NgRN16+Rvv
X-Received: by 10.98.219.3 with SMTP id f3mr10275064pfg.181.1489014469103;
        Wed, 08 Mar 2017 15:07:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:35da:deef:74a3:8cee])
        by smtp.gmail.com with ESMTPSA id v4sm8137584pfb.36.2017.03.08.15.07.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 15:07:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4] rev-parse: add --show-superproject-working-tree
Date:   Wed,  8 Mar 2017 15:07:42 -0800
Message-Id: <20170308230742.5185-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.190.g6e60aba09d.dirty
In-Reply-To: <xmqqmvcv1jz9.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvcv1jz9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some situations it is useful to know if the given repository
is a submodule of another repository.

Add the flag --show-superproject-working-tree to git-rev-parse
to make it easy to find out if there is a superproject. When no
superproject exists, the output will be empty.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> I can accept "it is not an error to ask for the root of the
> superproject's working tree when we do not have any---that is one
> way to ask if we have a superproject or not".  But if that is the
> case, the code can stay the same, but the documentation should say
> so, something like...

 *this patch*
 
* Documentation shamelessly stolen from Junio.

Thanks,
Stefan

 Documentation/git-rev-parse.txt |  6 +++
 builtin/rev-parse.c             |  7 ++++
 submodule.c                     | 82 +++++++++++++++++++++++++++++++++++++++++
 submodule.h                     |  8 ++++
 t/t1500-rev-parse.sh            | 14 +++++++
 5 files changed, 117 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 91c02b8c85..c40c470448 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -261,6 +261,12 @@ print a message to stderr and exit with nonzero status.
 --show-toplevel::
 	Show the absolute path of the top-level directory.
 
+--show-superproject-working-tree
+	Show the absolute path of the root of the superproject's
+	working tree (if exists) that uses the current repository as
+	its submodule.  Outputs nothing if the current repository is
+	not used as a submodule by any project.
+
 --shared-index-path::
 	Show the path to the shared index file in split index mode, or
 	empty if not in split-index mode.
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e08677e559..2549643267 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "split-index.h"
+#include "submodule.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -779,6 +780,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					puts(work_tree);
 				continue;
 			}
+			if (!strcmp(arg, "--show-superproject-working-tree")) {
+				const char *superproject = get_superproject_working_tree();
+				if (superproject)
+					puts(superproject);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
diff --git a/submodule.c b/submodule.c
index 3b98766a6b..bb405653fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1514,3 +1514,85 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		strbuf_release(&sb);
 	}
 }
+
+const char *get_superproject_working_tree(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *one_up = real_path_if_valid("../");
+	const char *cwd = xgetcwd();
+	const char *ret = NULL;
+	const char *subpath;
+	int code;
+	ssize_t len;
+
+	if (!is_inside_work_tree())
+		/*
+		 * FIXME:
+		 * We might have a superproject, but it is harder
+		 * to determine.
+		 */
+		return NULL;
+
+	if (!one_up)
+		return NULL;
+
+	subpath = relative_path(cwd, one_up, &sb);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_pop(&cp.env_array);
+
+	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+			"ls-files", "-z", "--stage", "--full-name", "--",
+			subpath, NULL);
+	strbuf_reset(&sb);
+
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die(_("could not start ls-files in .."));
+
+	len = strbuf_read(&sb, cp.out, PATH_MAX);
+	close(cp.out);
+
+	if (starts_with(sb.buf, "160000")) {
+		int super_sub_len;
+		int cwd_len = strlen(cwd);
+		char *super_sub, *super_wt;
+
+		/*
+		 * There is a superproject having this repo as a submodule.
+		 * The format is <mode> SP <hash> SP <stage> TAB <full name> \0,
+		 * We're only interested in the name after the tab.
+		 */
+		super_sub = strchr(sb.buf, '\t') + 1;
+		super_sub_len = sb.buf + sb.len - super_sub - 1;
+
+		if (super_sub_len > cwd_len ||
+		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
+			die (_("BUG: returned path string doesn't match cwd?"));
+
+		super_wt = xstrdup(cwd);
+		super_wt[cwd_len - super_sub_len] = '\0';
+
+		ret = real_path(super_wt);
+		free(super_wt);
+	}
+	strbuf_release(&sb);
+
+	code = finish_command(&cp);
+
+	if (code == 128)
+		/* '../' is not a git repository */
+		return NULL;
+	if (code == 0 && len == 0)
+		/* There is an unrelated git repository at '../' */
+		return NULL;
+	if (code)
+		die(_("ls-tree returned unexpected return code %d"), code);
+
+	return ret;
+}
diff --git a/submodule.h b/submodule.h
index 05ab674f06..c8a0c9cb29 100644
--- a/submodule.h
+++ b/submodule.h
@@ -93,4 +93,12 @@ extern void prepare_submodule_repo_env(struct argv_array *out);
 extern void absorb_git_dir_into_superproject(const char *prefix,
 					     const char *path,
 					     unsigned flags);
+
+/*
+ * Return the absolute path of the working tree of the superproject, which this
+ * project is a submodule of. If this repository is not a submodule of
+ * another repository, return NULL.
+ */
+extern const char *get_superproject_working_tree(void);
+
 #endif
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 9ed8b8ccba..03d3c7f6d6 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -116,4 +116,18 @@ test_expect_success 'git-path inside sub-dir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'showing the superproject correctly' '
+	git rev-parse --show-superproject-working-tree >out &&
+	test_must_be_empty out &&
+
+	test_create_repo super &&
+	test_commit -C super test_commit &&
+	test_create_repo sub &&
+	test_commit -C sub test_commit &&
+	git -C super submodule add ../sub dir/sub &&
+	echo $(pwd)/super >expect  &&
+	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
2.12.0.190.g6e60aba09d.dirty

