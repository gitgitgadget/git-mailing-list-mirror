Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7964620958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934545AbdCWNHB (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:07:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33512 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934526AbdCWNG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so16476745wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LI2eu4nYkAEeAG5cyiyjkq8r1NkJLjZbIZF/2mkABE=;
        b=J86ybnF5wdvVRgeGynEQkFIWaHRpzIawwm0aBfs7kx1XM5/AjbBH1ik2lLO5PF4pO8
         +3Vk2LCcGddo5484lCks8AAtR76OROdtlK9EERvgFEjzWJcF4EI2LuA/HvUK5b3c7tMW
         avjvwh1GgUmystL8XJqpwOdsIan+UklfjNdkfXdD/6jB3v2/sNcfMMKDGq6MmWJER10f
         fPpchF78axxeOY7is2nlKWzXV3x84GOC19VpJlDnQs8Nzhh+hV9kiMByDLGO3fNB93HJ
         cK0zP7l/Hqdv9u2DKIpCv5iaUisD8DyBwPqvP2D5PC0PzGy6RERb+ra5rsDNmFAfGCOP
         FyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LI2eu4nYkAEeAG5cyiyjkq8r1NkJLjZbIZF/2mkABE=;
        b=YrN8wNQMBWY5ptPkC1+MtWUjEF5FKN1ExNKePPPUzRUq6ldaqcoQYXyWZ4an9Rw8nk
         54ZlAr08yA3zCcpYZpiyxxS+sU/KSPTFmwyGSqtYXyrq5cak56fqENXPv/7vhdPqCuTO
         0SqrnMrWMSfVKLhYzPbaAxp9NojbHhyunAKwBgD35zpooEioNyef7IeMgnDvTDSZinJh
         caygfU9/JDelo3AY+dajTBZ/DpwBQHxpEKX2HotAjbHSePx4YHnn3DA04i5/H44xGub5
         MGAWaKQ/ByTSBxgmD8Qm/w1dCPPWj9LJB4vRTWMjbYDeuH19cJAQ+Bj4FdybwEHYG3ae
         5UBA==
X-Gm-Message-State: AFeK/H1oY8FCC6Tpw7f/UKjQgrjjFEGIutdDTqYZfUX7b9E+4lB4xki24xD9ogGMFwD1iw==
X-Received: by 10.28.170.67 with SMTP id t64mr12742514wme.18.1490274411374;
        Thu, 23 Mar 2017 06:06:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/16] tag: implicitly supply --list given another list-like option
Date:   Thu, 23 Mar 2017 13:05:25 +0000
Message-Id: <20170323130529.11361-13-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "tag" command to implicitly turn on its --list mode when
provided with a list-like option such as --contains, --points-at etc.

This is for consistency with how "branch" works. When "branch" is
given a list-like option, such as --contains, it implicitly provides
--list. Before this change "tag" would error out on those sorts of
invocations. I.e. while both of these worked for "branch":

    git branch --contains v2.8.0 <pattern>
    git branch --list --contains v2.8.0 <pattern>

Only the latter form worked for "tag":

    git tag --contains v2.8.0 '*rc*'
    git tag --list --contains v2.8.0 '*rc*'

Now "tag", like "branch", will implicitly supply --list when a
list-like option is provided, and no other conflicting non-list
options (such as -d) are present on the command-line.

Spelunking through the history via:

    git log --reverse -p -G'only allowed with' -- '*builtin*tag*c'

Reveals that there was no good reason for not allowing this in the
first place. The --contains option added in 32c35cfb1e ("git-tag: Add
--contains option", 2009-01-26) made this an error. All the other
subsequent list-like options that were added copied its pattern of
making this usage an error.

The only tests that break as a result of this change are tests that
were explicitly checking that this "branch-like" usage wasn't
permitted. Change those failing tests to check that this invocation
mode is permitted, add extra tests for the list-like options we
weren't testing, and tests to ensure that e.g. we don't toggle the
list mode in the presence of other conflicting non-list options.

With this change errors messages such as "--contains option is only
allowed with -l" don't make sense anymore, since options like
--contain turn on -l. Instead we error out when list-like options such
as --contain are used in conjunction with conflicting options such as
-d or -v.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 17 +++++++++------
 builtin/tag.c             | 18 ++++++++++------
 t/t7004-tag.sh            | 55 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 2640c6955c..491dba065c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -82,10 +82,11 @@ OPTIONS
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
-	are printed when using -l.
-	The default is not to print any annotation lines.
-	If no number is given to `-n`, only the first line is printed.
-	If the tag is not annotated, the commit message is displayed instead.
+	are printed when using -l. Implies `--list`.
++
+The default is not to print any annotation lines.
+If no number is given to `-n`, only the first line is printed.
+If the tag is not annotated, the commit message is displayed instead.
 
 -l::
 --list::
@@ -96,6 +97,10 @@ OPTIONS
 Running "git tag" without arguments also lists all tags. The pattern
 is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
 patterns may be given; if any of them matches, the tag is shown.
++
+This option is implicitly supplied if any other list-like option such
+as `--contains` is provided. See the documentation for each of those
+options for details.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
@@ -124,7 +129,7 @@ This option is only applicable when listing tags without annotation lines.
 
 --contains [<commit>]::
 	Only list tags which contain the specified commit (HEAD if not
-	specified).
+	specified). Implies `--list`.
 
 --merged [<commit>]::
 	Only list tags whose commits are reachable from the specified
@@ -135,7 +140,7 @@ This option is only applicable when listing tags without annotation lines.
 	commit (`HEAD` if not specified), incompatible with `--merged`.
 
 --points-at <object>::
-	Only list tags of the given object.
+	Only list tags of the given object. Implies `--list`.
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..3c686961db 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -454,8 +454,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
 
-	if (argc == 0 && !cmdmode)
-		cmdmode = 'l';
+	if (!cmdmode) {
+		if (argc == 0)
+			cmdmode = 'l';
+		else if (filter.with_commit ||
+			 filter.points_at.nr || filter.merge_commit ||
+			 filter.lines != -1)
+			cmdmode = 'l';
+	}
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -485,13 +491,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		return ret;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed with -l."));
+		die(_("-n option is only allowed in list mode"));
 	if (filter.with_commit)
-		die(_("--contains option is only allowed with -l."));
+		die(_("--contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed with -l."));
+		die(_("--points-at option is only allowed in list mode"));
 	if (filter.merge_commit)
-		die(_("--merged and --no-merged option are only allowed with -l"));
+		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
 	if (cmdmode == 'v') {
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 75681b2cad..5823de16aa 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -643,6 +643,11 @@ test_expect_success \
 	git tag -n0 -l tag-one-line >actual &&
 	test_cmp expect actual &&
 
+	git tag -n0 | grep "^tag-one-line" >actual &&
+	test_cmp expect actual &&
+	git tag -n0 tag-one-line >actual &&
+	test_cmp expect actual &&
+
 	echo "tag-one-line    A msg" >expect &&
 	git tag -n1 -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
@@ -656,6 +661,17 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
+	>expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual &&
+
+	git tag -m "A msg" 100 &&
+	echo "100             A msg" >expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
@@ -1476,6 +1492,11 @@ test_expect_success 'checking that initial commit is in all tags' "
 	test_cmp expected actual
 "
 
+test_expect_success 'checking that --contains can be used in non-list mode' '
+	git tag --contains $hash1 v* >actual &&
+	test_cmp expected actual
+'
+
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
@@ -1496,7 +1517,6 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -l -v &&
 	test_must_fail git tag -l -d &&
 	test_must_fail git tag -l -v -d &&
-	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
@@ -1505,10 +1525,25 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag --contains tag-blob
 '
 
+for option in --contains --merged --no-merged --points-at
+do
+	test_expect_success "mixing incompatible modes with $option is forbidden" "
+		test_must_fail git tag -d $option HEAD &&
+		test_must_fail git tag -d $option HEAD some-tag &&
+		test_must_fail git tag -v $option HEAD
+	"
+	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
+		git tag -n $option HEAD HEAD &&
+		git tag $option HEAD HEAD
+	"
+done
+
 # check points-at
 
-test_expect_success '--points-at cannot be used in non-list mode' '
-	test_must_fail git tag --points-at=v4.0 foo
+test_expect_success '--points-at can be used in non-list mode' '
+	echo v4.0 >expect &&
+	git tag --points-at=v4.0 "v*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--points-at finds lightweight tags' '
@@ -1785,8 +1820,13 @@ test_expect_success 'setup --merged test tags' '
 	git tag mergetest-3 HEAD
 '
 
-test_expect_success '--merged cannot be used in non-list mode' '
-	test_must_fail git tag --merged=mergetest-2 foo
+test_expect_success '--merged can be used in non-list mode' '
+	cat >expect <<-\EOF &&
+	mergetest-1
+	mergetest-2
+	EOF
+	git tag --merged=mergetest-2 "mergetest*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--merged is incompatible with --no-merged' '
@@ -1810,6 +1850,11 @@ test_expect_success '--no-merged show unmerged tags' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-merged can be used in non-list mode' '
+	git tag --no-merged=mergetest-2 mergetest-* >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ambiguous branch/tags not marked' '
 	git tag ambiguous &&
 	git branch ambiguous &&
-- 
2.11.0

