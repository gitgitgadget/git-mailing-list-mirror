Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22088C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhLGWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhLGWIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 17:08:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 14:04:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so567431wrd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lA5EwkYliLjjbXyWZ8EaamvFP/ra3sHSOjdgoOd7zA4=;
        b=TZEDLWiW2owjTdg0e6cJiq/Jjrvdd3qRL2XTJm9HKIx79fHAeRDq92sS+ReJ78Al7I
         uCIaaCRqrYv7VCbHBUyqF4fF+nGlEQ6DzSYHMUKZYJae7tfAXoAPyL1+01svGSSkGIvJ
         MOooPxYYn0Xx9jHNb/cu2a31QLOzkmslawVTvCBzgCKu0gFWdd85e6xzzILl3hCbO/p2
         2k9FFOPMnbZIFTEInQIE01kO+GoDT78s3gdM0UE1gzJ9vihQROYUwFPtGBU3hoQVJt31
         WR4uXFQ3xN9gwsWE1L8sOcJKELgR6ODpx8wX2QXTLvwB2ApzWZyQidQCCxhLjL25Tsem
         xNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lA5EwkYliLjjbXyWZ8EaamvFP/ra3sHSOjdgoOd7zA4=;
        b=saxBSRHYQIea+hrLJqDyd6p8NLAIjgNtx1DRzW//Jur4j5xvZbuK4mWStweWMXFHes
         CCeGjKZJTJTwfnfcG7k5gggyywWnwb8ixZWeO8dEUVJfkk1ittVVdnQdEjq+Uf1r8IwS
         ZVtSm/sTzOmZa8wuWmIZPGCXorCNvdID4FIbq65F9QM2DSd7Y/AJ2plaNvgWEzSdNF5J
         T0ybHSt5K/cdbs83uWEnNP8j9USfpEsQ3d9Z0KMdqEi3w5OUdR765zhMRdayofPcmYeh
         JN0L8o9lpMAEuuT/MNVce6lvlUKu0GsuzrnCU0qQBb/zA5Hz+I5V8PIabckeSWKd/H1D
         CGOw==
X-Gm-Message-State: AOAM533oGbi6haxGi6M5ZDdyZfei2k4d5R6pvsij4dcn+Ypr6goxpHm9
        2rZku/hEXkwwpVIccotomcG9BDErYVth9Q==
X-Google-Smtp-Source: ABdhPJxcBGftcRg4L2Yf7Ge2hAzz5eAj0b8rYhzahGzkhJkvy/0jY3HIo5pFl222S497LcjjzpUzjw==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr53559769wri.382.1638914677423;
        Tue, 07 Dec 2021 14:04:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm1451153wri.45.2021.12.07.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:04:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        =?UTF-8?q?Jan=20Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5] pull, fetch: fix segfault in --set-upstream option
Date:   Tue,  7 Dec 2021 23:04:30 +0100
Message-Id: <patch-v5-1.1-69ab40d623b-20211207T215115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <xmqqy24w5eqx.fsf@gitster.g>
References: <xmqqy24w5eqx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --set-upstream option added in
24bc1a12926 (pull, fetch: add --set-upstream option, 2019-08-19) added
in v2.24.0.

The code added there did not do the same checking we do for "git
branch" itself since 8efb8899cfe (branch: segfault fixes and
validation, 2013-02-23), which in turn fixed the same sort of segfault
I'm fixing now in "git branch --set-upstream-to", see
6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).

The warning message I'm adding here is an amalgamation of the error
added for "git branch" in 8efb8899cfe, and the error output
install_branch_config() itself emits, i.e. it trims "refs/heads/" from
the name and says "branch X on remote", not "branch refs/heads/X on
remote".

I think it would make more sense to simply die() here, but in the
other checks for --set-upstream added in 24bc1a12926 we issue a
warning() instead. Let's do the same here for consistency for now.

There was an earlier submitted alternate way of fixing this in [1],
due to that patch breaking threading with the original report at [2] I
didn't notice it before authoring this version. I think the more
detailed warning message here is better, and we should also have tests
for this behavior.

The --no-rebase option to "git pull" is needed as of the recently
merged 7d0daf3f12f (Merge branch 'en/pull-conflicting-options',
2021-08-30).

1. https://lore.kernel.org/git/20210706162238.575988-1-clemens@endorphin.org/
2. https://lore.kernel.org/git/CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com/

Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
Reported-by: Jan Pokorný <poki@fnusa.cz>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> So i'd think that any proposed behavior change there should come
>> independent of a narrow segfault fix, let's fix that, and then change
>> how "fetch --set-upstream-to" works in general.
>
> Sound good.  I won't have time to go hunting for old patch from the
> archive today, though.

In case it help a v5 that's really just a re-send of the v4 at
https://lore.kernel.org/git/patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com/

Range-diff against v4:
1:  0caa9a89a86 = 1:  69ab40d623b pull, fetch: fix segfault in --set-upstream option

 builtin/fetch.c         | 10 ++++++++++
 t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff1..7f3d2fdc9ce 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1638,6 +1638,16 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 		if (source_ref) {
+			if (!branch) {
+				const char *shortname = source_ref->name;
+				skip_prefix(shortname, "refs/heads/", &shortname);
+
+				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
+					  "it does not point to any branch."),
+					shortname, transport->remote->name);
+				goto skip;
+			}
+
 			if (!strcmp(source_ref->name, "HEAD") ||
 			    starts_with(source_ref->name, "refs/heads/"))
 				install_branch_config(0,
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 9c12c0f8c32..48050162c27 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -91,6 +91,17 @@ test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	check_config_missing other2
 '
 
+test_expect_success 'fetch --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git fetch --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 # tests for pull --set-upstream
 
 test_expect_success 'setup bare parent pull' '
@@ -178,4 +189,15 @@ test_expect_success 'pull --set-upstream with valid URL and branch sets branch'
 	check_config_missing other2
 '
 
+test_expect_success 'pull --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git pull --no-rebase --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.34.1.926.g895e15e0c0c

