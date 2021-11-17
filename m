Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CCC43219
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A7863222
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbhKQOXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbhKQOW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F60C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2240721wme.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uLWWlghNT753Rcq+QFeAaezw69rdNihpNbSkEQ0YgSo=;
        b=QOGiULk6QziP6QhSvwI8ia3WJlAP8d/WTFm3JrvpBkRwE/MTkpThAArbK9h6rj9wM1
         lt2oBTm+J7ujmtAqCl1VeWoRucUJ7J+Gu7gp3d7+Fq7bYzw2EsjlHveeV779REtXrlzg
         ewPewfwsNqI+vJ/VEsi7Ohwp9FCuohDKTyl9kVZS62d/pw8zDk9ZEb9FE8nd+AEkRfnF
         6FDfy8g94phDxIWZBY7rt6f/z1XeA7IXMOpKE7gm1VwyDrwVGBja752h6gAb6GduQOYI
         eDLxQ33zm3MUIgpLK7BcbdzExNzXPsWk+3lSQ89WVRcQ0jUMt2ICW/VCcGoa3EjDVzI+
         w8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uLWWlghNT753Rcq+QFeAaezw69rdNihpNbSkEQ0YgSo=;
        b=Mmh/2ReT9WVXgTXvWHXSYG7UngCc4zZCH45/No6mhVkSoQ4rh6vTQ3scll9ggUAlwm
         u5FiylNjhMT2ozd9HWBN/stBQKG7z82SQgZPzSBttPxs3AAdBPBgU6Uu8YmQWqlxS7p7
         GwiCw0Cw7zMxD/JZ/QSVzgBuidKfI3SEYznlw0awWiUor1h5eRPMwHlVXozJalCSQkpZ
         sl8UMy66HGF7mZc7jx8rkG/+dzpoKqINYUFySk5Xx8QXjwsMO9SuZb5Xg6OmprNK1SY5
         QRuD7D9aBx4JSLhPx+cbIn+voGw07uZgca84dSnf1evMH9/18GD2rtSz8bJGh2mW7jCS
         2JPA==
X-Gm-Message-State: AOAM530jxXXsg1EHBslKfwFHn/PgSHdWRiu9zlQOG6NMaAiz1gzckRnf
        k1Ss/1EBSVgJ+hkXJwLXrFMPRU4wW5U=
X-Google-Smtp-Source: ABdhPJxkE7qNMRJW8K89evBZSukrvJUjfF8OuL3dUVcsadGqO1EJiiJmh39NKCq7zEQbruSAGq03gQ==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr80011509wmc.169.1637158776554;
        Wed, 17 Nov 2021 06:19:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm29100wra.5.2021.11.17.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:36 -0800 (PST)
Message-Id: <5e077bf892b5fadb46bcf7c31cc2a4c6cf6b6200.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:14 +0000
Subject: [PATCH v7 09/17] scalar: let 'unregister' handle a deleted enlistment
 directory gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a user deleted an enlistment manually, let's be generous and
_still_ unregister it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 46 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 15 +++++++++++
 2 files changed, 61 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index bab0271c37d..097d3bd478b 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -269,6 +269,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int remove_deleted_enlistment(struct strbuf *path)
+{
+	int res = 0;
+	strbuf_realpath_forgiving(path, path->buf, 1);
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "scalar.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "maintenance.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	return res;
+}
+
 static int cmd_unregister(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -282,6 +300,34 @@ static int cmd_unregister(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
+	/*
+	 * Be forgiving when the enlistment or worktree does not even exist any
+	 * longer; This can be the case if a user deleted the worktree by
+	 * mistake and _still_ wants to unregister the thing.
+	 */
+	if (argc == 1) {
+		struct strbuf src_path = STRBUF_INIT, workdir_path = STRBUF_INIT;
+
+		strbuf_addf(&src_path, "%s/src/.git", argv[0]);
+		strbuf_addf(&workdir_path, "%s/.git", argv[0]);
+		if (!is_directory(src_path.buf) && !is_directory(workdir_path.buf)) {
+			/* remove possible matching registrations */
+			int res = -1;
+
+			strbuf_strip_suffix(&src_path, "/.git");
+			res = remove_deleted_enlistment(&src_path) && res;
+
+			strbuf_strip_suffix(&workdir_path, "/.git");
+			res = remove_deleted_enlistment(&workdir_path) && res;
+
+			strbuf_release(&src_path);
+			strbuf_release(&workdir_path);
+			return res;
+		}
+		strbuf_release(&src_path);
+		strbuf_release(&workdir_path);
+	}
+
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
 	return unregister_dir();
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 16f2b72b126..ef0e8d680d5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -14,4 +14,19 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success 'scalar unregister' '
+	git init vanish/src &&
+	scalar register vanish/src &&
+	git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	grep -F "$(pwd)/vanish/src" scalar.repos &&
+	rm -rf vanish/src/.git &&
+	scalar unregister vanish &&
+	test_must_fail git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	! grep -F "$(pwd)/vanish/src" scalar.repos
+'
+
 test_done
-- 
gitgitgadget

