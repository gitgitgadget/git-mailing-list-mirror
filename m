Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4879F1FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCJLwe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 06:52:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37404 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbeCJLwc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 06:52:32 -0500
Received: by mail-wm0-f67.google.com with SMTP id 139so8254326wmn.2
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LsxBrai3zoO6CxXcgUJ/lbtiQQT2LmYlrKxHdwlTHx8=;
        b=S63Z1xc8AV1gaHtANnJH6+enWGOaWwyU7ABI8y88eMZ377b0xzWq6uwVbMxe17AFgK
         bSKprKlQAr2mYeizLQlsICnO/VhjvvuZ3rSH0QdxBdOGEzMNukT5OL0w4e6CurtmCVs1
         cV7xxy+mb/5SDgOqqyYK+T1SR9DQmTqdrJPfPcpJ2Fnf8Y9AQeUkrnPaXTMWziMLj1Gv
         w3m0EuY6dDw8o7L7KSmLfctg3TIl0TaNlYXFZ37b5/A98jB+zyXlaTGL807X0FSFYKZ1
         WtDgMKGGxP2vUS+IA7i6kqi5BNX9LGvJaZtIHsi0da44VKmvUw/RxaP4fK9aYwX8Vw2h
         cf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsxBrai3zoO6CxXcgUJ/lbtiQQT2LmYlrKxHdwlTHx8=;
        b=PsjJ8xKdcJjo5Z4KZDY6DEaDpXcAA4t3iuWIVvHWeht7d9CywO+DgxqyLdMoCpGE5J
         Xwt7IL5vAxUfKFbS7jP4oPSk7ccVHGbM+nwUpvFT3/LQWAkCIcDR5qytG3Nvp2jHLoVn
         ZYPyEOLDKiS9s26xLigKAhQFug8eKW5+5rrSMn6CaSyDvluaG0JFWqa+3CIzFOpFUb04
         YkW4hgIsMSQNr1+nGOcQTUfDPYoSS3Idmml5aeMCki70lgPUcQOL+ZdJxZPsSWZ16+az
         hAxWmrf7QB2idiVbDxQVUiFD7kem9acBLuq9d6adwwQVv5NYT0KdOyWIvLa2sSXbc+Dx
         wIEA==
X-Gm-Message-State: AElRT7EgO5B98AEOX+povRoSHuPMdyWgc9Ct421kCHaDEZ5ryrnhnd0U
        B9GHEpOKl5qGPaK1+ycHFGdcPZ/E
X-Google-Smtp-Source: AG47ELu5DeyON4TlGkVSQIAFRDToZzU8e/XBCz/7ZzN+XA5g9qlktmfNisfVgYXi6YGWO5nlH3A0Mw==
X-Received: by 10.28.92.208 with SMTP id q199mr944786wmb.91.1520682751381;
        Sat, 10 Mar 2018 03:52:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s21sm2802147wra.45.2018.03.10.03.52.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Mar 2018 03:52:30 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] shortlog: do not accept revisions when run outside repo
Date:   Sat, 10 Mar 2018 12:52:12 +0100
Message-Id: <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1520680894.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are outside a repo and have any arguments left after
option-parsing, `setup_revisions()` will try to do its job and
something like this will happen:

$ git shortlog v2.16.0..
BUG: environment.c:183: git environment hasn't been setup
Aborted (core dumped)

The usage is wrong, but we could obviously handle this better. Note that
commit abe549e179 (shortlog: do not require to run from inside a git
repository, 2008-03-14) explicitly enabled `git shortlog` to run from
outside a repo, since we do not need a repo for parsing data from stdin.

Disallow left-over arguments when run from outside a repo. Another
approach would be to disallow them when reading from stdin. However, our
logic is currently the other way round: we check the number of revisions
in order to decide whether we should read from stdin. (So yes, after
this patch, we will still silently ignore stdin for confused usage such
as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
not crash.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t4201-shortlog.sh | 5 +++++
 builtin/shortlog.c  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index da10478f5..78c5645a9 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -127,6 +127,11 @@ test_expect_success !MINGW 'shortlog can read --format=raw output' '
 	test_cmp expect out
 '
 
+test_expect_success 'shortlog from non-git directory refuses revisions' '
+	test_must_fail env GIT_DIR=non-existing git shortlog HEAD 2>out &&
+	test_i18ngrep "no revisions can be given" out
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index dc4af03fc..35e8c1ead 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -293,6 +293,12 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (nongit && argc != 1) {
+		error(_("no revisions can be given when running "
+			"from outside a repository"));
+		usage_with_options(shortlog_usage, options);
+	}
+
 	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
-- 
2.16.2.246.ga4ee44448f

