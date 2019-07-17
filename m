Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27B81F461
	for <e@80x24.org>; Wed, 17 Jul 2019 18:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGQSug (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 14:50:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61513 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQSug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 14:50:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 303CF76BDB;
        Wed, 17 Jul 2019 14:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qFw+3zUX2Xvwx8j/1VI460lu9HE=; b=PNDTXi
        C0kxNA5cFga8xH1iplzQw31Y7PA9IQ/ZR98ojveqGuZTr9tTUGC9YK5bRhdY1Ib6
        vqz0J44dcng09F0N8rsF3TP+Dz2TA6DSeweSEVDtoA3OAqiFh9B0/4Se7V6mCORZ
        TOHfYFnqBALa4LauRGoH4NGXuoaZVjYFuUPjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vN6v1naYspmb5s1qJ0xMfwiUCy2qGert
        9SYS43jjizF+FXCyz/eacrqGYrqkYhFXP1ET+Fh3buWTfZ/1SObpiPa+kYpfNjpU
        4WMQHUBjjQTQOQDHa7Zq1SWHGAXaxqfmpGlTBeIjbUkMYGZ91fOhFUxH62L4TUAV
        PEtQik85g80=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29E9076BD9;
        Wed, 17 Jul 2019 14:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F06C76BD7;
        Wed, 17 Jul 2019 14:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] clean: show an error message when the path is too long
References: <pull.219.git.gitgitgadget@gmail.com>
        <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
        <a7fee3c7-8fd5-11ef-8b0d-ff8053987b0c@web.de>
        <xmqqftn53g8z.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 17 Jul 2019 11:50:22 -0700
In-Reply-To: <xmqqftn53g8z.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Jul 2019 12:56:44 -0700")
Message-ID: <xmqqsgr4zea9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC56EA28-A8C3-11E9-94E4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The other warnings in that function are issued using warning_errno()
>> (shorter code, consistency is enforced) and messages are marked for
>> translation.  That would be nice to have here as well, no?
>
> Absolutely.  Also, downcase "Could" and perhaps use _() around.


This one is easy enough (not just in the technical sense, but in the
sense that it has little room wasting our time bikeshedding), so
let's tie the loose ends and move on.

I was tempted to fix the proposed log message to excise exaggeration
(I prefer not to see "very", "important", etc.---other things that
is said in the message should be enough to convince readers about
the importance), but didn't.  

What I did do was to not just rephrasing the warning message, but to
give it its own constant and to feed it to warning_errno(), to match
the other warning message.

I also saved one (or perhaps two) fork(s) from the test script ;-)
and added a portability note there.

1:  d93f701a2e ! 1:  b1e100aa6a clean: show an error message when the path is too long
    @@ Metadata
      ## Commit message ##
         clean: show an error message when the path is too long
     
    -    Without an error message when stat() failed, e.g. `git clean` would
    +    Without an error message when lstat() failed, `git clean` would
         abort without an error message, leaving the user quite puzzled.
     
         In particular on Windows, where the default maximum path length is quite
    @@ Commit message
                 https://github.com/git-for-windows/git/issues/521
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    [jc: matched the warning message style to existing ones, fixed test]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/clean.c ##
    +@@ builtin/clean.c: static const char *msg_would_remove = N_("Would remove %s\n");
    + static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
    + static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
    + static const char *msg_warn_remove_failed = N_("failed to remove %s");
    ++static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
    + 
    + enum color_clean {
    + 	CLEAN_COLOR_RESET = 0,
     @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
      		strbuf_setlen(path, len);
      		strbuf_addstr(path, e->d_name);
      		if (lstat(path->buf, &st))
     -			; /* fall thru */
    -+			warning("Could not stat path '%s': %s",
    -+				path->buf, strerror(errno));
    ++			warning_errno(_(msg_warn_lstat_failed), path->buf);
      		else if (S_ISDIR(st.st_mode)) {
      			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
      				ret = 1;
    @@ t/t7300-clean.sh: test_expect_success 'git clean -d skips untracked dirs contain
     +	test_when_finished git config --unset core.longpaths &&
     +	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
     +	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
    -+	touch $a50$a50/test.txt &&
    -+	touch $a50$a50/$a50$a50/$a50$a50/test.txt &&
    ++	: >"$a50$a50/test.txt" 2>"$a50$a50/$a50$a50/$a50$a50/test.txt" &&
    ++	# create a temporary outside the working tree to hide from "git clean"
     +	test_must_fail git clean -xdf 2>.git/err &&
    -+	grep "too long" .git/err
    ++	# grepping for a strerror string is unportable but it is OK here with
    ++	# MINGW prereq
    ++	test_i18ngrep "too long" .git/err
     +'
     +
      test_done



-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] clean: show an error message when the path is too long

Without an error message when lstat() failed, `git clean` would
abort without an error message, leaving the user quite puzzled.

In particular on Windows, where the default maximum path length is quite
small (yet there are ways to circumvent that limit in many cases), it is
very important that users be given an indication why their command
failed because of too long paths when it did.

This test case makes sure that a warning is issued that would have
helped the user who reported this issue:

	https://github.com/git-for-windows/git/issues/521

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[jc: matched the warning message style to existing ones, fixed test]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c  |  3 ++-
 t/t7300-clean.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..d5579da716 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -34,6 +34,7 @@ static const char *msg_would_remove = N_("Would remove %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
+static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -194,7 +195,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			warning_errno(_(msg_warn_lstat_failed), path->buf);
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..bde55b358c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,17 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
+	git config core.longpaths false &&
+	test_when_finished git config --unset core.longpaths &&
+	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
+	: >"$a50$a50/test.txt" 2>"$a50$a50/$a50$a50/$a50$a50/test.txt" &&
+	# create a temporary outside the working tree to hide from "git clean"
+	test_must_fail git clean -xdf 2>.git/err &&
+	# grepping for a strerror string is unportable but it is OK here with
+	# MINGW prereq
+	test_i18ngrep "too long" .git/err
+'
+
 test_done
-- 
2.22.0-653-g37fc7794bc






