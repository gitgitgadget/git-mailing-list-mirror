Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F16B20450
	for <e@80x24.org>; Sun,  5 Nov 2017 11:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdKEL6q (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 06:58:46 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53393 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdKEL6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 06:58:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so9119608wmf.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDz9ytt5nJco4Q9A39BVzrpR4V/tQZJ5vP3u8gr4HB4=;
        b=upjIVo6QG4VJXB+mf/ELdQtXfJgoJFAzYt1hjQRtHFZYKxvTPMgGBHoe2Quy1+IKcq
         oNHXCvXLHu9XP9+K0UqmAnEWfNdXODG4WaTv4+GvqiRIKk3OkTBwntJOtYH74haNQX3+
         BbNCCltyASCB9cJxtRpi1QlHPJo+45bDji2uwzRNz3urlgYi59GiG9pruuXy7AQg15Yh
         N4r4jv934J6dGTbCD7e5ED1HT93k7UOco0OAcuf0SazxIlFNfdEKUUeuv9+XDtg3LUtZ
         Gi4xSdVeHgsOIJZvFh85riDZwdgvxu9O9/T33Qxm29nPosg7GnS10w4qTz31nhpPYJRW
         BIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDz9ytt5nJco4Q9A39BVzrpR4V/tQZJ5vP3u8gr4HB4=;
        b=Houg3k7fRnL0nmP1VAgDe768Qm1xwIj05coz0Xng138DjHusbFbJ3bEb2kKLg6QUUW
         JlqSTToQ64RSEPWx0YI1cI4lRZacRXKmYQy7sj/X5y1OuaBL9EBfcK2x9wShYvAlFgrA
         MIl46PDbEtHOQYnImlZEOVp4q9BUaytfDLPgwyTaJ4Jr88DBxQWYgkJdUpmUF4hQnRn3
         fyr72dI+vKXg9gBFj1vXc1Wo7bPRQIzQr5xVExbeRgEPfEdqjo/gXTphywid42kZnri+
         5HaQ1XvG9RcvavtrF1v/bcqfJeSRo90QvAUVmOnfhRqYWxztoKiFfOln7Y2/xZhCJQfs
         YCCA==
X-Gm-Message-State: AJaThX5L9nqv0ISPDky2eGemZzk0FStbfJZumW1L3nRFEUaWryS5AkAD
        EGEWX5bfSISIZjZGnS0o3Yw=
X-Google-Smtp-Source: ABhQp+R9AyhjS9e8fZCgGLQCBc4Q8dzdDdg3/jMWgKnAkh8Qz7YmOmDJyBcHmIpahf08N1QAAEvOjg==
X-Received: by 10.28.153.3 with SMTP id b3mr3527377wme.60.1509883122542;
        Sun, 05 Nov 2017 03:58:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u18sm14391450wrg.94.2017.11.05.03.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 03:58:41 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/4] pager: introduce `pager.*.command` and `.enable`
Date:   Sun,  5 Nov 2017 12:58:21 +0100
Message-Id: <a49ddb791a5a716a340660a57d01138d5aff84ce.1509879269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509879269.git.martin.agren@gmail.com>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net> <cover.1509879269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`pager.foo` conflates two concepts: how and whether `git foo` should
page. In particular, it can not be used to change *how* to page without
possibly also affecting *whether*.

Teach Git about two new config items, `pager.foo.command` and
`pager.foo.enable`.

Make this interact sanely with the existing `pager.foo`. For example,
make sure that `pager.foo=false` does not cause us to forget about a
command already configured through `pager.foo.command`, so that the
given pager command can be "re-activated" using
`pager.foo[.enable]=true`.

Where Documentation/ refers to `pager.tag`, write "the `pager.tag[.*]`
configuration options". In config.txt, `pager.blame` is mentioned more
as an example and it describes precisely the situation where one will
want to use the old mechanism, so leave that instance unchanged.

For symmetry with how `--paginate` disrespects any pager that might have
been configured with `pager.foo`, do the same for `pager.foo.command`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config.txt  | 17 +++++++++++
 Documentation/git-tag.txt |  3 +-
 Documentation/git.txt     |  2 +-
 t/t7006-pager.sh          | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 pager.c                   |  5 ++++
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6ad..72558cc74 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2460,6 +2460,23 @@ pager.<cmd>::
 	or `--no-pager` is specified on the command line, it takes
 	precedence over this option.  To disable pagination for all
 	commands, set `core.pager` or `GIT_PAGER` to `cat`.
++
+This is a less flexible alternative to `pager.<cmd>.command` and
+`pager.<cmd>.enable`. Using it with a boolean does the same as using
+`pager.<cmd>.enable`. Using it with a command does the same as using
+`pager.<cmd>.command` and `pager.<cmd>.enable=true`.
+
+pager.<cmd>.command::
+	Specifies the pager to use for the subcommand.
+	Whether the pager should be used is configured using
+	`pager.<cmd>.enable` or `pager.<cmd>=<boolean>`.
+
+pager.<cmd>.enable::
+	A boolean which turns on or off pagination of the output of a
+	particular Git subcommand when writing to a tty. If `--paginate`
+	or `--no-pager` is specified on the command line, it takes
+	precedence over this option.  To disable pagination for all
+	commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 956fc019f..9f9f33409 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -210,7 +210,8 @@ it in the repository configuration as follows:
     signingKey = <gpg-keyid>
 -------------------------------------
 
-`pager.tag` is only respected when listing tags, i.e., when `-l` is
+The `pager.tag[.*]` configuration options are only
+respected when listing tags, i.e., when `-l` is
 used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7a1d629ca..0a2eff7a6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -99,7 +99,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 -p::
 --paginate::
 	Pipe all output into 'less' (or if set, $PAGER) if standard
-	output is a terminal.  This overrides the `pager.<cmd>`
+	output is a terminal.  This overrides the `pager.<cmd>[.*]`
 	configuration options (see the "Configuration Mechanism" section
 	below).
 
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e890b2f64..6966627dd 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -588,4 +588,77 @@ test_expect_success 'command with underscores does not complain' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup' '
+	sane_unset PAGER GIT_PAGER GIT_PAGER_IN_USE &&
+	test_unconfig core.pager &&
+
+	git rev-list HEAD >rev-list &&
+	sed "s/^/foo:/" rev-list >expect &&
+
+	PAGER="cat >paginated.out" &&
+	export PAGER &&
+
+	test_unconfig pager.log &&
+	test_unconfig pager.rev-list
+'
+
+test_expect_success TTY 'configuration with .enable works' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.log.enable=false log &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY '--paginate overrides .enable+.command' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.log.command=bad -c pager.log.enable=false \
+			  --paginate log &&
+	test -e paginated.out
+'
+
+test_expect_success TTY '--no-pager overrides .enable' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.rev-list.enable --no-pager rev-list HEAD &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY '.enable discards non-boolean' '
+	test_must_fail git -c pager.log.enable=bad log
+'
+
+test_expect_success TTY 'configuration remembers .command as .enable flips' '
+	>actual &&
+	test_terminal git -c pager.rev-list.command="sed s/^/foo:/ >actual" \
+			  -c pager.rev-list.enable=false \
+			  -c pager.rev-list.enable \
+			  rev-list HEAD &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'configuration remembers old-style command as .enable flips' '
+	>actual &&
+	test_terminal git -c pager.rev-list="sed s/^/foo:/ >actual" \
+			  -c pager.rev-list.enable=false \
+			  -c pager.rev-list.enable \
+			  rev-list HEAD &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'old-style config can override .enable' '
+	>actual &&
+	test_terminal git -c pager.rev-list.command="sed s/^/foo:/ >actual" \
+			  -c pager.rev-list.enable=false \
+			  -c pager.rev-list \
+			  rev-list HEAD &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'old style config can override .command+.enable' '
+	>actual &&
+	test_terminal git -c pager.rev-list.command=bad \
+			  -c pager.rev-list.enable=false \
+			  -c pager.rev-list="sed s/^/foo:/ >actual" \
+			  rev-list HEAD &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/pager.c b/pager.c
index 8968f26f1..c8a6a01d8 100644
--- a/pager.c
+++ b/pager.c
@@ -206,6 +206,11 @@ static int pager_command_config(const char *var, const char *value, void *vdata)
 			free(data->value);
 			data->value = xstrdup(value);
 		}
+	} else if (!strcmp(remainder, ".command")) {
+		free(data->value);
+		data->value = xstrdup(value);
+	} else if (!strcmp(remainder, ".enable")) {
+		data->want = git_config_bool(var, value);
 	}
 
 	return 0;
-- 
2.15.0.415.gac1375d7e

