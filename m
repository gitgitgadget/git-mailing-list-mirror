Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BAC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 12:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiKNM3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 07:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiKNM3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 07:29:44 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C565E5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 04:29:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so27808382ejb.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 04:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5CfucFhKhnABsVZ2CSX5PBHr+LTaKNPEvTQJxH7fFE=;
        b=LvrhXScF+D2GqmF+UfpmbtnMzmsb/sT5Uf7s2VgGId8+Z6IeA2drGE/BemJElNUlSu
         SCGGGUqz0Y13hZI62Jt76lnRGCgrS0T4lbvGfUGuF3wyN0EPSNiLi65LpD9IlzWMyty2
         w+mwm5mDWfsfK/jgshuTZyF97mUT4vsU8XEtgqp4yAz7pP1ka9PFSRa3zvURskGxDEiz
         CFt8odw0Om24w/MPxWeqKdROeQVL9+9FZbJ2+DWgj2YgECPfZYQ63LoWXE/btDcRcvGm
         bBThBfhBoSgU1MLL5X8+YjKvvtVIuqP077+hnEDQgcXNsu9EMH5HbRZAGTQOtIdadhsq
         kATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5CfucFhKhnABsVZ2CSX5PBHr+LTaKNPEvTQJxH7fFE=;
        b=jLDTdh7B7A+uDl06sShtKvuE8YQCn5G7uHFGxFXnqwxLzrmk1dqTdPvj3qxf/+MsJr
         BUhyTqNWKLLnWOE1q8yo12FHU6lr3ssgHUyvpwTNbTGI1eUUqZ5LrexbhNUwczCf+Wej
         FAABQptEKAgmivyJysEKpm+FbwLUjxqtJL4/2541fRqpxV1cm0OYD02ieK2ln5LiIs/5
         axA5Yd1UU3Uv46kNfqmYv7P+JfoZUqUOUqk9ttQfQ+RHbFrQp4ycIxBKyh8cqM3UEmDS
         WHOnlV/h5ibLRsj737Wv+Sm5nC3n7pn4LJWjKGTEoSVFEKY1AMIs2PtIBhRFllIhp/t4
         hMAA==
X-Gm-Message-State: ANoB5plK95cUdWKydC6zKIyxwvMAb/P7z55LXZA8hGDyDLcRrVdW1OOy
        H8j0Z6w1ikv7FW1CBxLuEsg=
X-Google-Smtp-Source: AA0mqf5rzpgZIw7dQtLZqMyJbcPc+8Bh/UXS17IvB6wWSMD4JgTO278vjQHNsKF+2P9RzqWVYYpiHQ==
X-Received: by 2002:a17:906:f208:b0:7ae:2277:9fec with SMTP id gt8-20020a170906f20800b007ae22779fecmr9861608ejb.623.1668428981643;
        Mon, 14 Nov 2022 04:29:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b007adf2e4c6f7sm4121488ejc.195.2022.11.14.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 04:29:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ouYaq-003BRg-2A;
        Mon, 14 Nov 2022 13:29:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Date:   Mon, 14 Nov 2022 12:55:16 +0100
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
Message-ID: <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 12 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is more performant to run `git diff --no-index` than running the
> `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> Windows uses. And a lot more readable.
>
> Note: Earlier attempts at fixing this involved a test helper that avoids
> the overhead of the diff machinery, in favor of implementing a behavior
> that is more in line with what `mingw_test_cmp` does now, but that
> attempt saw a lot of backlash and distractions during review and was
> therefore abandoned.

I don't know if you counted this under "backlash and distractions", or
if you just didn't see it, but I think part of the comments I left on
the v2[1][2] are still applicable.

Namely that before this we've been assuming that GIT_TEST_CMP is a
not-ours binary. I.e. "diff", "cmp" etc. If it is a "that's ours" this
change should be changing e.g. '! test_cmp' to 'test_cmp !', as the
former would now hide segfaults.

Which isn't a theoretical issue b.t.w., e.g. the recent d00113ec347
(t/Makefile: apply chainlint.pl to existing self-tests, 2022-09-01)
will invoke "git diff --no-index", which has some interesting results
(that I've run into) when testing a tree where "git diff" happens to
segfault.

From grepping our tests that doesn't seem to be too hard, certainly a
lot easier than a new "not-quite-diff" test helper.

Additionally: We don't *need* this for an initial implementation, but
having e.g. one of the Ubuntu CI targets run with "git diff --no-index"
would be a nice cherry on top, as:

 * It would show that the "--ignore-cr-at-eol" is only needed for MinGW,
   and is also the reason for why "GIT_TEST_CMP" is still
   unconditionally clobbered there, unlike other platforms. See
   4d715ac05cf (Windows: a test_cmp that is agnostic to random LF <>
   CRLF conversions, 2013-10-26).

 * We do pass this elsewhere, except for the one trivial case which you
   aren't running into on MINGW because it doesn't have SYMLINKS, but
   presumably would if the test were adjusted to use "SYMLINKS_WINDOWS".

 * If we're trusting "git diff --no-index" to run the tests, we could
   also get rid of "GIT_TEST_CMP_USE_COPIED_CONTEXT", whose only reason
   for existing is to support a system "diff" that doesn't understand
   "-u" (squashable diff below)

1. https://lore.kernel.org/git/220907.86v8pzl6jz.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220907.86r10nl63s.gmgdl@evledraar.gmail.com/

diff --git a/Makefile b/Makefile
index 4927379184c..dea6069b5fe 100644
--- a/Makefile
+++ b/Makefile
@@ -1950,10 +1950,6 @@ ifdef OVERRIDE_STRDUP
 	COMPAT_OBJS += compat/strdup.o
 endif
 
-ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
-	export GIT_TEST_CMP_USE_COPIED_CONTEXT
-endif
-
 ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check
 endif
@@ -3008,9 +3004,6 @@ endif
 ifdef GIT_TEST_CMP
 	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@+
 endif
-ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
-	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
-endif
 ifdef GIT_TEST_UTF8_LOCALE
 	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
 endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4fab1c1984c..cd6e9f797b6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1503,12 +1503,7 @@ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
 if test -z "$GIT_TEST_CMP"
 then
-	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
-	then
-		GIT_TEST_CMP="$DIFF -c"
-	else
-		GIT_TEST_CMP="$DIFF -u"
-	fi
+	GIT_TEST_CMP="$DIFF -u"
 fi
 
 GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
