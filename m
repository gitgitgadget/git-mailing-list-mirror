Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFE01F454
	for <e@80x24.org>; Fri,  1 Nov 2019 00:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfKAAYh (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 20:24:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38780 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfKAAYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 20:24:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id z19so3462226wmk.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/0vwEetg8ZRgbLa2yEIZF4dWUFxTGHXc2B5MuGbT7Ls=;
        b=JGWeX8zxhH6GhlMRSTcFgshG4g5CnmGCDCI4MAya8Lmfrcv3rp+3nfGtGNfN0sQdlr
         czUwHYRWTa3shf3Eo7il+YI/p2B9yhiBrdzOm+w6YId1PVfzSVvnb181POTNLKrmT5iD
         IAqxnHhU6UfSbtIYWzSNI2VAmB1eNPatUs37FRi6StQpTuJ/iH7IAG+Vdhtwu8ktuTgu
         Pqw4SqF3+VBtaa07o3+4j+wE+jDWIzqFtpmF5dv0D6ke69lVAG1eD/+cYxS+AXCXYXRa
         byeG8cM/rISOS9i+7kqPtOihvCYtqvMzq4Sp7S5K4hA+dx3NHDnrgb7zgTK/czqQvGHC
         UN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/0vwEetg8ZRgbLa2yEIZF4dWUFxTGHXc2B5MuGbT7Ls=;
        b=WTrr8GXUyD/CvbTDSgB8MOf3GD6HeI28o/aweKQ1Agcb4UBVjcPUd3pzcbleGACHhB
         2y9T+kxpNZcS0Hs1owPw4gCM7VVWJJii00dQUxzRovRMrk31oSIqRNKGCOZf9rbw/upb
         8psQibYxrBrUzm/VzHe/ajzLx4u0DBRjSevdM8ueCrBEDhP0R7Q1fhwthFEvBlsTFN4Z
         Kgmkb2V2j6OFJHticj2LEA+XCJeuRjs7eNms1qF08c4OnDHL1bVEzMfgaCbtlFDB+i5+
         VkDemEIIqQrkWav7ljxSvpkG3DW7FSJTJdkoyUJUTZiEqgXanYhopgULCreKdWlYfUsy
         oJkA==
X-Gm-Message-State: APjAAAXIWxKChhzGqh4Qd7RQ//x/yHF2XPZS1CeJfVpr5Ckzm0VQ+8Le
        cKM4G2dHlRxXx300NUrB2kCkDbLcDQU=
X-Google-Smtp-Source: APXvYqw77jprPCC7TMYYg1MQ970UA8ot8wZOItlTHuSL2rAzPoHfvccZiywdS42Dg4gC0qMbU0HwUg==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr7991412wmb.127.1572567874742;
        Thu, 31 Oct 2019 17:24:34 -0700 (PDT)
Received: from localhost (host96-200-dynamic.171-212-r.retail.telecomitalia.it. [212.171.200.96])
        by smtp.gmail.com with ESMTPSA id h8sm469907wrc.73.2019.10.31.17.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 17:24:34 -0700 (PDT)
Date:   Fri, 1 Nov 2019 01:24:32 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, gitster@pobox.com
Subject: [PATCH] Segmentation Fault on non-commit --branch clone
Message-ID: <20191101002432.GA49846@carpenter.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed segmentation fault that can be triggered using
$ git clone --branch $object $repository
with object pointing to a non-commit ref (e.g. a blob).

Signed-off-by: Davide Berardi <berardi.dav@gmail.com>

---
 builtin/clone.c         | 26 ++++++++++++++++++++++++++
 refs.h                  |  7 +++++++
 t/t5609-clone-branch.sh | 22 +++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f665b28ccc..0f4a18302c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -704,11 +704,32 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
+static int fallback_on_noncommit(const struct ref *check,
+				 const struct ref *remote,
+				 const char *msg)
+{
+	if (check == NULL)
+		return 1;
+	struct commit *c = lookup_commit_reference_gently(the_repository,
+						   &check->old_oid, 1);
+	if (c == NULL) {
+		/* Fallback HEAD to fallback refs */
+		warning(_("%s is not a valid commit object, HEAD will fallback to %s"),
+			check->name, FALLBACK_REF);
+		update_ref(msg, FALLBACK_REF, &remote->old_oid, NULL,
+			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
+	}
+
+	return c == NULL;
+}
+
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
+		if (fallback_on_noncommit(our, remote, msg) != 0)
+			return;
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
@@ -718,12 +739,17 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
+		if (fallback_on_noncommit(our, remote, msg) != 0)
+			return;
+		/* here commit is valid */
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
+		if (fallback_on_noncommit(remote, remote, msg) != 0)
+			return;
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
diff --git a/refs.h b/refs.h
index 730d05ad91..35ee6eb058 100644
--- a/refs.h
+++ b/refs.h
@@ -497,6 +497,13 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
 
+/*
+ * In case of a remote HEAD pointing to a non-commit update_head
+ * will make HEAD reference fallback to this value, master ref
+ * should be safe.
+ */
+#define FALLBACK_REF "refs/heads/master"
+
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be052..0680cf5a89 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -20,7 +20,13 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
-	 git checkout master) &&
+	 git checkout master &&
+	 # Create dummy objects
+	 _B=$(git rev-list --objects --all | grep -m 1 "^[^ ]\+ [^ ]\+" | \
+	      awk "{print \$1}") &&
+	 echo "${_B}" >> .git/refs/tags/broken-tag &&
+	 echo "${_B}" >> .git/refs/heads/broken-head
+	) &&
 	mkdir empty &&
 	(cd empty && git init)
 '
@@ -67,4 +73,18 @@ test_expect_success 'clone -b not allowed with empty repos' '
 	test_must_fail git clone -b branch empty clone-branch-empty
 '
 
+test_expect_success 'clone -b with broken tag will fallback to master' '
+	git clone -b broken-tag parent clone-broken-tag &&
+	(cd clone-broken-tag &&
+	 check_HEAD master
+	)
+'
+
+test_expect_success 'clone -b with broken head will fallback to master' '
+	git clone -b broken-head parent clone-broken-head &&
+	(cd clone-broken-head &&
+	 check_HEAD master
+	)
+'
+
 test_done
-- 
2.22.0

