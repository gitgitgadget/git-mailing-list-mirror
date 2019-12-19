Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D54AC2D0D3
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197162465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+iqvyfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLSSCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38202 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSSCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so5768378edr.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u2KM3f/8WZAxtZqT/DRQkr39gZ3MTVEv3eGxYgK5asY=;
        b=s+iqvyfjNoJ7PvtJjcFqrLpMn0SsRFq2q4NDkRIUQ9vGGMThT/BE0pJfORsngBKZvp
         n/ldhZsuLf395/AXfp8EIXMs09sICXP2eryTzfrxYvnCOeyekhySbqZWaOmnYDAFpalg
         YCykSVWYEHaDIq+ieP+KRPaqO/L64t6fpwt2Cgjo48otP0p5pBg8kwKieFL0OxE/d8Do
         qklMjZRx1kIBebhkXVVpgdzLeWS94aL2VinZmyPMO/7ctiIiBeImefwzC2535Dy7JIRl
         VlXAGZUSKPMzAZcQQjSxEVZk9nah7qrOdSys+BAmFRjRwQ343B3wo0bPUEoVXgPdPXqN
         fnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u2KM3f/8WZAxtZqT/DRQkr39gZ3MTVEv3eGxYgK5asY=;
        b=ESG7yixeZiHdHabBQyCt5qRAedxuBdTyajm3Br1URKpx+uapHQRvCSalqKK4n8D3Hm
         UW/rvb1GzNpqW8P7rhC03O3+MQIqLCnuJczLZd1juKn1QsjImt8fNkm/TlhyegrzMtC+
         gdTYqlSOZV35UV09kep/LzrlriToNuQkkbM0UeaEopPO8Ea9O1Zjpuf759+KdYrJO+zb
         THKmuVfqu8GfC5Mh4UaiK4JnbBH5a70K2Ni93zXkiYDt19kU0jQHreXkoowH/mKRcdDl
         oASaU3lAsK8Sngc9Kke3eYbix0rofuUgSTGL5LIWog+rM5WwiR6iDWGJfW7ALNeHEZD9
         7wKw==
X-Gm-Message-State: APjAAAU3qee6gLcPWZ1kkBRJPN5SyvYgCIo088+ns5o59tZdgugVwL88
        2436Nb+UrPgdIvTe13fe9hvgB1O5
X-Google-Smtp-Source: APXvYqw3/h7pX9Ok1wJdv+pX81nuGznUOpRdcq3r0eqB7jB6MkhvwcopJ3Tw09NZAABAi6B+4rsaZg==
X-Received: by 2002:a05:6402:1496:: with SMTP id e22mr10803348edv.132.1576778521322;
        Thu, 19 Dec 2019 10:02:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm651105ejx.11.2019.12.19.10.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:00 -0800 (PST)
Message-Id: <f0be90601ea019dea0bd647059cf5b2705c7193e.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:41 +0000
Subject: [PATCH v3 04/18] commit: forbid --pathspec-from-file --all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

I forgot this in my previous patch `--pathspec-from-file` for
`git commit` [1]. When both `--pathspec-from-file` and `--all` were
specified, `--all` took precedence and `--pathspec-from-file` was
ignored. Before `--pathspec-from-file` was implemented, this case was
prevented by this check in `parse_and_validate_options()` :

    die(_("paths '%s ...' with -a does not make sense"), argv[0]);

It is unfortunate that these two cases are disconnected. This came as
result of how the code was laid out before my patches, where `pathspec`
is parsed outside of `parse_and_validate_options()`. This branch is
already full of refactoring patches and I did not dare to go for another
one.

Fix by mirroring `die()` for `--pathspec-from-file` as well.

[1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/commit.c                | 3 +++
 t/t7526-commit-pathspec-file.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index e48c1fd90a..aa1332308a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (interactive)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 
+		if (all)
+			die(_("--pathspec-from-file with -a does not make sense"));
+
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index b71c1013e7..bc65125741 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -72,6 +72,9 @@ test_expect_success 'error conditions' '
 	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
 
+	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
+
 	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
-- 
gitgitgadget

