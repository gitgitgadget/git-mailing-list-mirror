Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63712C433E6
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275B064D9D
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBNKGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:06:31 -0500
Received: from mout.web.de ([212.227.15.3]:60953 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhBNKG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 05:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613297074;
        bh=jSDtz4LpS0GsTbXcowaOOZnTvQCqwRc9ZeGNXZ0JNyA=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=CgWZ3pwOR+lo4L7x5NpM//OJ/M7FGjDPDmp196+9T3XfNOv4bG77r7YI4ZOY9DtF9
         ntu4/OIcahd1Y53RaYmc0IlfG3rKU6eEkXuw/ZuHvFzxKpvY5IgWj3/GABXfNDmHkX
         mS6XlOBaC2dh5AQy4VoYfa6+xC5LNtWNls1xnpVk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MISsx-1lAxYL2lp9-004Ayi; Sun, 14 Feb 2021 11:04:34 +0100
Subject: [PATCH 1/2] pretty: add %(describe)
To:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Date:   Sun, 14 Feb 2021 11:04:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmgqdnREfec3ihSBz2ZLze7qZi+Ep05Vz/tlIJBXSm/4Z6uPdTd
 gkGGP54zfJpTKa98mRvNXUZY62tF6e8AbUsFSosD7BduASlgJGunY6sLRjg+KFtpSEssOro
 WEkBrRC7yC2O0bbyMbhjIDjhwIPcCYIOrrMEaxtiV2M54bn9PZhBNw0Efw5HFcoVHjNx1gA
 3mleG0mQ0Ga4EPqwkyfLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wM3WEKpqHPs=:ZV8hPb7Bq3BWcp44vNKJ/o
 XGM+WT/XWbVMKekixNUv47DePRg+GUvT5PTXxeqlTiA8jZWKOaAWGDdSdSVzTilTxAyRXtVDD
 DcS4r8pOwKygrcZc4XJt4la37lwKUW9F9RrwGG5aDCOSCE7T4dIMOmCHlUuQ+tQpJI8wCbSQc
 WrdiUa/B9xXegwYlTo/BocPGpEJ8No1hX249DU43EJlKEGWuB47xbKvzb1aTrMRTssbOXNWzU
 uG1SCfqUfw7mKgb+UUDmdq6hm/rz/k0e2aCATLUlYdA19vKaeTFtV9mTKDoRHM6SxCWBJg69W
 pxpRqLNrRyuzO2HPyIqCwjxIRkKjDgBITWDbuMpvcvjTaokItumZL0T/G9NSWlcORLsSYwa7Q
 6DqF8KM1HkHKA9/yU3C05y3ICSd1tj0xXiKZj3+WueX4QuH43MrCWq/2GxkoaGO3j6sO2bFjR
 /aqIt0vKJd86bHaTUVPCZd/T3wnxFrHqiAng05DmUHkEjfNTY9k4O2OTu26GST6LYT0RtAKEb
 oUPutdGex+Wa2HRw+Hp5pWKNDcixQbcxQwMwHGW3rk3ilJraNV+B6UyiIsjA7WVvZ/hru3V/o
 UQdxxFgFWF999gFqvu8GdGYJWp8TWXt0grltZw0zEV7bGulQ9djFXYIEs+9Czsl3NqhPv1nPV
 4Q0p/OxDRNrZ2guPnra+Z9CAnxyT2fdWPz3/4F3B2zi66YhWLgr0GeplGkHB/4ODsayQ12Ktz
 NzHX1vxhZPHBYuKzlZ+HxUjaQGz4z5+cYG6Wkv4bue+Jjqk6sDt3ikpnICiqZNO5Pkz45Bh5x
 7OZ23a/8BTOWmBJwWK20ZhxXYHaZ4o9Z7f6qKllzSZp4z3Q1lDOjoH9c7+YFwsDv5dicEg3QA
 O1on0lnYFtVcCDivZPIw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a format placeholder for describe output.  Implement it by actually
calling git describe, which is simple and guarantees correctness.  It's
intended to be used with $Format:...$ in files with the attribute
export-subst and git archive.  It can also be used with git log etc.,
even though that's going to be slow due to the fork for each commit.

Suggested-by: Eli Schwartz <eschwartz@archlinux.org>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/pretty-formats.txt |  2 ++
 pretty.c                         | 17 +++++++++++++++++
 t/t4205-log-pretty-formats.sh    | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-forma=
ts.txt
index 6b59e28d44..bb8c05bc21 100644
=2D-- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -208,6 +208,8 @@ The placeholders are:
 '%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
+'%(describe)':: human-readable name, like linkgit:git-describe[1];
+		empty string for undescribable commits
 '%S':: ref name given on the command line by which the commit was reached
        (like `git log --source`), only works with `git log`
 '%e':: encoding
diff --git a/pretty.c b/pretty.c
index b4ff3f602f..a0c427fb61 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -12,6 +12,7 @@
 #include "reflog-walk.h"
 #include "gpg-interface.h"
 #include "trailer.h"
+#include "run-command.h"

 static char *user_format;
 static struct cmt_fmt_map {
@@ -1214,6 +1215,22 @@ static size_t format_commit_one(struct strbuf *sb, =
/* in UTF-8 */
 		return parse_padding_placeholder(placeholder, c);
 	}

+	if (skip_prefix(placeholder, "(describe)", &arg)) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+		struct strbuf out =3D STRBUF_INIT;
+		struct strbuf err =3D STRBUF_INIT;
+
+		cmd.git_cmd =3D 1;
+		strvec_push(&cmd.args, "describe");
+		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
+		pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
+		strbuf_rtrim(&out);
+		strbuf_addbuf(sb, &out);
+		strbuf_release(&out);
+		strbuf_release(&err);
+		return arg - placeholder;
+	}
+
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(the_repository, &commit->object.oid);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 749bc1431a..5a44fa447d 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -962,4 +962,14 @@ test_expect_success 'log --pretty=3Dreference is colo=
red appropriately' '
 	test_cmp expect actual
 '

+test_expect_success '%(describe) vs git describe' '
+	git log --format=3D"%H" | while read hash
+	do
+		echo "$hash $(git describe $hash)"
+	done >expect &&
+	git log --format=3D"%H %(describe)" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
 test_done
=2D-
2.30.1
