Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD65220357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbdGJV4g (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34129 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbdGJV4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:35 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21so12303316lfk.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQb84UPg+MYAwcAUsev02cjof9IfdyyGnu/byr40qKs=;
        b=b/RxL2E524n57D5yQSRN0F0iH8atXEn4iuK3z0ikQi6saWoe4H5leGZumAmrUzxUUe
         NdVx/g5XQeTNDCc+269jx9Dw7J4HeLDkByLnzrrPOX0gIaZ/06rRt+XIQbnCHUpx7FQ9
         Ov2e1QWrICg9uso0Mrc7vDkpSwrJqRIlya67Zk7Re71iTVYX/mQnGpg1eIDiywt4nvo/
         llfNvCy9atthLBzbK04yszaHrO6/72Gu6AjOu4qQ/xNTcOqLnty6+nJ1DnVcHrMo8rGG
         btCnZPVCLZeaJwb5PZ5WH+cM/VNTLfraBh6YFw0I2pCkunq9EnRa848GieTenYxyj44n
         tfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQb84UPg+MYAwcAUsev02cjof9IfdyyGnu/byr40qKs=;
        b=kRJ/xBOur6rDCpfMWWCEq+yjTFq7UfPmmcVhSDBPvc+ytMdgXjHOcSrKWE61oWkWl7
         za8Lfn140v/CyNaDc6qznPqiSyFPEU8ti0ZJZd9POjiZXyN0GGQp4e/QweITdoQBcCHl
         pWtohFisDBmxfC+brlRDnyE6vkTejnJ6u1su3yjvLaHDuJlPeIxJAc/zfhdUC1R0cMlx
         SWaeyntoNSztBWPnfkwOG0P+CPlYuWCpOlVJZePDA8yp4rNiydPjoAGlVDf4PYDxDIl3
         49e75CpOMB7b9lwyJNlchgKDcwlnDcnZhyAP58jvMuAIbiCe/CzXkLWa5jLZiqbWzZlT
         2xzQ==
X-Gm-Message-State: AIVw110u4ivlnWOw8pFtwi5vGcguEOEgsXZP0klFugHpvmRTv99T4t9d
        HOZKeEOWyW49cWznQ+k=
X-Received: by 10.25.167.144 with SMTP id q138mr1701297lfe.62.1499723793061;
        Mon, 10 Jul 2017 14:56:33 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 6/7] tag: make git tag -l consider new config `pager.tag.list`
Date:   Mon, 10 Jul 2017 23:55:19 +0200
Message-Id: <27ca13ea5b520d492f96ea319ae47d6f4b431e94.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal. A
user who makes use of `git tag -a` and `git tag -l` will probably choose
not to configure `pager.tag` or to set it to "no", so that `git tag -a`
will actually work, at the cost of not getting the pager with `git tag
-l`.

Introduce `pager.tag.list`. Teach git tag to prefer it over `pager.tag`
when running with -l. Update the documentation and add tests. Update an
existing test to use `pager.tag.list` instead of `pager.tag` together
with `git tag -l` since the former is arguably more relevant.

Do not introduce an "else" where we call setup_auto_pager(), although we
could have. Omitting it might keep someone who later implements even
more fine-grained configurations from building a correspondingly
complicated decision tree which carefully ensures that
setup_auto_pager() is called precisely once. A greedy approach such as
the one taken here works just fine.

Noticed-by: Anatoly Borodin <anatoly.borodin@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  4 ++++
 builtin/tag.c             |  2 ++
 t/t7006-pager.sh          | 16 +++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1eb15afa1..6ad5811a2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -101,6 +101,10 @@ patterns may be given; if any of them matches, the tag is shown.
 This option is implicitly supplied if any other list-like option such
 as `--contains` is provided. See the documentation for each of those
 options for details.
++
+When determining whether to use a pager, `pager.tag.list` is considered
+before `pager.tag`.
+See linkgit:git-config[1].
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
diff --git a/builtin/tag.c b/builtin/tag.c
index e0f129872..e96ef7d70 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -446,6 +446,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (cmdmode == 'l')
+		setup_auto_pager("tag.list", 0);
 	setup_auto_pager("tag", 0);
 
 	if (keyid) {
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 43cce3694..ed34c6734 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -146,9 +146,15 @@ test_expect_success TTY 'git tag -l respects pager.tag' '
 	test -e paginated.out
 '
 
+test_expect_success TTY 'git tag -l respects pager.tag.list' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag=false -c pager.tag.list tag -l &&
+	test -e paginated.out
+'
+
 test_expect_success TTY 'git tag -l respects --no-pager' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag --no-pager tag -l &&
+	test_terminal git -c pager.tag.list --no-pager tag -l &&
 	! test -e paginated.out
 '
 
@@ -166,6 +172,14 @@ test_expect_success TTY 'git tag -a respects pager.tag' '
 	test -e paginated.out
 '
 
+test_expect_success TTY 'git tag -a ignores pager.tag.list' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag -c pager.tag.list=false \
+		tag -am message newtag &&
+	test -e paginated.out
+'
+
 test_expect_success TTY 'git tag -a respects --paginate' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
-- 
2.13.2.653.gfb5159d

