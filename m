Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0D169AD2
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080365; cv=none; b=gFasjyMl5RpiywwU501berPKnB/yMI6KXs43c4KtYml9BGjT4Wr2slf09MPBZ3O+zndOVxEXfoyAMNGQ9I3h97dgErF8pL8wxmxSakscMslg49myGnpLX3nDJ7qAMLuIQRfgNasq2zmLYwzY5JRZUn/sDxR2cWheZifqO5T6PNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080365; c=relaxed/simple;
	bh=x6qJVOUeFufzrfDVaDve2SxSP6ciQ4Cuv31Ee6fWbhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A17e7LXA1MwmnloAtUIDNd7SRyYPfzDmggBqSwDiObENEAKW9ETnC9wzGqEUNiBX/m6ft2N5H1RXBGTfpykADY5s6GyNitoyQQPV/09LJm8l591Ke2CZ1lu0jJakq3gczr87v/gX0kQT/I6x4Cm20yr+gPCWWb36O8TI7ts4P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3rYntxq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3rYntxq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so4545305e9.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785080361; x=1785685161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qy+UB67/67pxX7D3iZRJHgc03cF7fLLFKBuGyoA+Pxc=;
        b=p3rYntxqKEhmw+pnWZE/zlgzwGiPnqjiJZ2DtlU+XQvp8kw+1lIiDZ+UrTaGbR9MVX
         aPYITHfeosjAFDP7k/+rSSYaQtuxuMLSSDXWTgb1bu97soGku3RuklyLDp3io2YYKhny
         uql//BONB36N2FORAWQCxnaiyqqI9PeSy05zoIserNfS4pGSv+pGH2fCy33svGnkRXbQ
         I4eSdCph3o+bf93TF2i+z1kblPDjsIz7Ifivf+uGCnegitXmrTqcauNUYYlIVVhaK2EZ
         flfNyixD6jJxi9JcOBP4x/zNbIYwhbpeA8tkJPu1Rk9WNbNKfygHjptz/dBWKrT7pqQ9
         3TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785080361; x=1785685161;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qy+UB67/67pxX7D3iZRJHgc03cF7fLLFKBuGyoA+Pxc=;
        b=f739MaO/QjXj8aBboN2leSLgk+Ai6E0tvEBnuVX2hF+xkaQzx0agGtDbmeyTTuIdWj
         w98K0Y2DbBAchZiFdjbtfKkfw4ZT27ySNVhwfS7NIpfQ2Oh5HsQmkD5uY8+xVJqHhL4u
         PfuM9bRgn7aLv4e3/sVGs7VRWks/IRdzhlHQjBV5ELxalfEJUmwl+XL+gN7lev5VqDU5
         hZ5W69asSUk/Uyhxg8Xgjoq4yQIUz2CCXHB+l0ztB7ak3sK+ZyZs36MH9onaZqmwNyL/
         M0UcALP79vwZGqN+raCFYF+/JYWaySKoMcLjShoE+85NPm+Pbz0ifkbtYi73c3THivQP
         jbIw==
X-Gm-Message-State: AOJu0Yxdvk4QOkTAG7nDg6dnGKjoLAojkjKcKJOUQeMOcRLDxfQvfLFW
	c4joV7UcSRf1/Nzu/1MCg+IfVdN6Z3yDF59ea4hXkVLuju22ZIn2dXYyitraNg==
X-Gm-Gg: AR+sD12Q1DRHxgZ+OvVfP0+zutI0Fj88++FqFJwh+nyzdHSabWVkQko4N+QBgn/mQaM
	dZD1+djEXaarFKKhbXUI/W+VRv1BRkru4dMo/SZdtHkUPmVz5kECCwGFP9bEhMDhD7dbQdqkjtU
	grrAaJ80gC4SYV/lpv0LWXMOCwcGkoaQYuRcH+b/zDHjuclacHcKjp30Ff0ei4sgtzY/jN8KRxt
	qTq0vDSYgx+zaiQTQTpD1MIfC5LU94nIv83Y9aopiX0RjlccJsUkyZr4uC0JVWQcFrxZeAxo6iY
	eyWQimVX2VndMWRnNWCGKcSX7N1WPbtG1mFA4PEnAtCSZL0suxwhqbVDVyo3KaCRciNTFerMSyo
	U7/wHv6jk+MD5mzC2/Zz2RsSjALHEpfACV9cEkQ+ydzKP7WwWqWa3gKHQjOiRextQ7uijZKfPz4
	gvnXRdV2x7n4F8j5L2
X-Received: by 2002:a05:600c:3b9b:b0:495:6400:ab62 with SMTP id 5b1f17b1804b1-496b56ff2b9mr69719345e9.20.1785080361387;
        Sun, 26 Jul 2026 08:39:21 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f2639csm144035805e9.10.2026.07.26.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:39:20 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] rebase -i: fix counting of fixups after rebase --skip
Date: Sun, 26 Jul 2026 16:38:59 +0100
Message-ID: <f95668512a8ec6f7e81fcb761e883877df87deee.1785080337.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785080337.git.phillip.wood@dunelm.org.uk>
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk> <cover.1785080337.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the sequencer processes a chain of "fixup" and "squash" commands
it keeps a list of the commands that have been executed. If there are
conflicts, then the list is saved when the rebase stops for the user to
resolve them. When the rebase resumes, the list is loaded and is used
to initialize the count of how many "fixup" and "squash" commands have
been processed; if a command has been skipped with "git rebase --skip",
then the last command needs to be popped off the end of the list.

To count the number of commands, commit_staged_changes() uses the
number of newlines in the file plus one. This is due to the slightly
unusual way the list is constructed - instead of appending a newline
when a command is added, a newline is inserted before the command
if the current count is greater than zero. Therefore, when we pop a
skipped command off the list, we should also remove the newline that
precedes it. Otherwise, when a new command is added, a blank line
will be left before it, which will contribute to the fixup count the
next time the file is read. Unfortunately, the preceding newline is
not removed, leading to an incorrect count. Fix this by removing the
newline that appears before the skipped command.

In addition to fixing the code that removes a skipped command from the
list, the code that reads the list is fixed to skip blank lines. We
have had reports of users starting a rebase with one version of
git and continuing it with another. Often this happens because the
version of git bundled with an IDE or TUI differs from the one used
at the command line. By fixing both the reading and writing ends of
the problem we ensure the count is correct when an older version of
git reads the fixup file written by a newer version and vice versa.

Triggering the incorrect count requires the user to skip two "fixup" or
"squash" commands before the final command in the chain. An existing
test is extended to prevent future regressions. The consequence of
miscounting is not serious: we just print the wrong count in the
header of the commit message template.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 11 ++++++++++-
 t/t3418-rebase-continue.sh | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1355a99a092..4640ee9b7f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3281,7 +3281,13 @@ static int read_populate_opts(struct replay_opts *opts)
 			const char *p = ctx->current_fixups.buf;
 			ctx->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
-				ctx->current_fixup_count++;
+				/*
+				 * Older versions of git accidentally
+				 * inserted blank lines when a fixup
+				 * was skipped.
+				 */
+				if (p[1] && p[1] != '\n')
+					ctx->current_fixup_count++;
 				p++;
 			}
 		}
@@ -5353,6 +5359,9 @@ static int commit_staged_changes(struct repository *r,
 			if (!len)
 				BUG("Incorrect current_fixups:\n%s", p);
 			while (len && p[len - 1] != '\n')
+				len--;
+			/* Remove trailing newline */
+			if (len)
 				len--;
 			strbuf_setlen(&ctx->current_fixups, len);
 			if (write_message(p, len, rebase_path_current_fixups(),
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 03e0714864c..cb5c3a1cb5b 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -134,6 +134,7 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	EOF
 
 	: skip and continue &&
+	test_config commit.status false &&
 	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 
@@ -145,7 +146,8 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 
 	: now, let us ensure that "squash" is handled correctly &&
 	git reset --hard wants-fixup-3 &&
-	test_must_fail env FAKE_LINES="1 squash 2 squash 1 squash 3 squash 1" \
+	test_must_fail env \
+		FAKE_LINES="1 squash 2 squash 1 squash 3 squash 1 squash 4 squash 1" \
 		git rebase -i HEAD~4 &&
 
 	: the second squash failed, but there are two more in the chain &&
@@ -171,19 +173,45 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	fixup 2
 	EOF
 
+	(test_set_editor "$PWD/copy-editor.sh" &&
+	 test_must_fail git rebase --skip) &&
+	: not the final squash, no need to edit the commit message &&
+	test_path_is_missing .git/copy.txt &&
+
+	: The first, third and fifth squashes succeeded, therefore: &&
+	cat >expect <<-\EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	wants-fixup
+
+	# This is the commit message #2:
+
+	fixup 1
+
+	# This is the commit message #3:
+
+	fixup 2
+
+	# This is the commit message #4:
+
+	fixup 3
+	EOF
+	test_commit_message HEAD expect &&
+
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 	test_commit_message HEAD <<-\EOF &&
 	wants-fixup
 
 	fixup 1
 
 	fixup 2
+
+	fixup 3
 	EOF
 
 	: Final squash failed, but there was still a squash &&
-	head -n1 .git/copy.txt >first-line &&
-	test_grep "# This is a combination of 3 commits" first-line &&
-	test_grep "# This is the commit message #3:" .git/copy.txt
+	test_cmp expect .git/copy.txt
 '
 
 test_expect_success 'setup rerere database' '
-- 
2.54.0.200.gfd8d68259e3

