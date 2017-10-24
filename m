Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81273202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdJXAJg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 20:09:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:51180 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdJXAJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 20:09:35 -0400
Received: by mail-io0-f193.google.com with SMTP id 97so22001426iok.7
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLNo/1Eqfl99PdoDuipr/VEt2sm/EtiKREiB0FxG40g=;
        b=s/vKN85RUTRlKL02S3+K7Tvh7tLU2E6lo990kkkIF8cPMfmiwiHGnCr/Amvi/vPN7a
         uGVVty+JPHFdWx2LObJIKnn7UuqZkF8Qldxdb/6u4fJmOyZC6F8EU2/y35nOnoG3xeEP
         wCJFCH2rRDs251C7iX9+EDd+ugvsJfQPakSNdM5GV3m3yfdNdwBEFM1zG/wyrLUqP/4Q
         26+VAOWNGNTU09rYnLhARrdRDkSKu8+k6f1y7UUriYatF1S5UoqWK+o6kvsOqzzEKXYM
         Q7bWtT+gfUUzb0z95JWpK4QfKuM9Bb3/sfo8uOraAw+giCi3SCau2SM16WxQysz45Ex2
         +PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLNo/1Eqfl99PdoDuipr/VEt2sm/EtiKREiB0FxG40g=;
        b=q8XR8A8LV8NFH5bjnYSfm5HtqJA7SlQ/P/ULbf4Ogg5f+fz8rpqLWhEyFxU7etZfPY
         h3G7r4i8My8oTprq6oZunFwEy4XqNOaW3NGv8MdFtfD1SDhd4Lj6ionLF6Zf83rGHfDa
         vmIDt+PU5fIbkADCXvlL7WzozXaDB33D46fhHU/RmSJet0dc2Kv6Qf45ZJrcuvd9/4PQ
         WuyqNltd2SykBUWap5G/ZHUzKeQrcBw80txM26Y82oNBK63OUyMN5djC0wts9wxa/sMn
         di/yBWuBRFjEHLpS0fyaVurRphOUqdk0go0ukpI/8iXJ4aVH1nU3XA/zi/5hBd2j1H1s
         w1eA==
X-Gm-Message-State: AMCzsaUZ7xRGcaxt4Tqr8IjXNCVI/KyjZSNXLbCa1Z/CTPxwpqF6e+R3
        EQX0xxKFnCa6poLZ0L/zpfE+HQ==
X-Google-Smtp-Source: ABhQp+QubPPpnki2N7xlBgbqXURhx6RHtuXDAjzXa8B8HPBfyjs5z7W2PNjn+Bew1IIXEv3yt68wDQ==
X-Received: by 10.107.27.137 with SMTP id b131mr19325271iob.2.1508803774246;
        Mon, 23 Oct 2017 17:09:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6cf3:35ef:8355:1a70])
        by smtp.gmail.com with ESMTPSA id h81sm98971itb.18.2017.10.23.17.09.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Oct 2017 17:09:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, bturner@atlassian.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, wyan@google.com
Subject: [WIP PATCH] diff: add option to ignore whitespaces for move detection only
Date:   Mon, 23 Oct 2017 17:09:31 -0700
Message-Id: <20171024000931.14814-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
References: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 diff.c                     |  10 ++--
 diff.h                     |   1 +
 t/t4015-diff-whitespace.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++-
 
See, only 10 lines of code! (and a few more for tests)

We have run out of space in diff_options.flags,touched_flags.
as we 1<<U31 as the highest bit. We could reuse 1<<9 that is currently
unused (removed in 882749a04f (diff: add --word-diff option that
generalizes --color-words, 2010-04-14)). But that postpones the
real fix for only a short amount of time.

Ideas welcome how to extend the flag space. (We cannot just make it
a long either, as some arcane architecures have 32 bit longs.)

Another TODO: documentation

I plan to trim the CC list for any resend that will be needed.

Thanks,
Stefan
 
 3 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index c4a669ffa8..ddb2018307 100644
--- a/diff.c
+++ b/diff.c
@@ -726,7 +726,8 @@ static int next_byte(const char **cp, const char **endp,
 			return (int)' ';
 		}
 
-		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
+		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE) ||
+		    diffopt->color_moved_ignore_space) {
 			while (*cp < *endp && isspace(**cp))
 				(*cp)++;
 			/*
@@ -751,7 +752,8 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
 	const char *bp = b->es->line, *be = b->es->line + b->es->len;
 
-	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
+	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS) &&
+	    !diffopt->color_moved_ignore_space)
 		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
@@ -774,7 +776,7 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 
 static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
 {
-	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
+	if ((o->xdl_opts & XDF_WHITESPACE_FLAGS) || o->color_moved_ignore_space) {
 		static struct strbuf sb = STRBUF_INIT;
 		const char *ap = es->line, *ae = es->line + es->len;
 		int c;
@@ -4660,6 +4662,8 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
+	else if (!strcmp(arg, "--ignore-all-space-in-move-detection"))
+		options->color_moved_ignore_space = 1;
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
diff --git a/diff.h b/diff.h
index aca150ba2e..6ba3f53bbd 100644
--- a/diff.h
+++ b/diff.h
@@ -196,6 +196,7 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+	int color_moved_ignore_space;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6c9a93b734..d7ee3aabf2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1677,7 +1677,119 @@ test_expect_success 'move detection with submodules' '
 
 	# nor did we mess with it another way
 	git diff --submodule=diff --color | test_decode_color >expect &&
-	test_cmp expect decoded_actual
+	test_cmp expect decoded_actual &&
+	rm -rf bananas &&
+	git submodule deinit bananas
+'
+
+test_expect_success 'move detection only ignores white spaces' '
+	git reset --hard &&
+	q_to_tab <<-\EOF >function.c &&
+	int func()
+	{
+	Qif (foo) {
+	QQ// this part of the function
+	QQ// function will be very long
+	QQ// indeed. We must exceed both
+	QQ// per-line and number of line
+	QQ// minimums
+	QQ;
+	Q}
+	Qbaz();
+	Qbar();
+	Q// more unrelated stuff
+	}
+	EOF
+	git add function.c &&
+	git commit -m "add function.c" &&
+	q_to_tab <<-\EOF >function.c &&
+	int do_foo()
+	{
+	Q// this part of the function
+	Q// function will be very long
+	Q// indeed. We must exceed both
+	Q// per-line and number of line
+	Q// minimums
+	Q;
+	}
+
+	int func()
+	{
+	Qif (foo)
+	QQdo_foo();
+	Qbaz();
+	Qbar();
+	Q// more unrelated stuff
+	}
+	EOF
+
+	# Make sure we get a different diff using -w ("moved function header")
+	git diff --color --color-moved -w |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/function.c b/function.c<RESET>
+	<BOLD>--- a/function.c<RESET>
+	<BOLD>+++ b/function.c<RESET>
+	<CYAN>@@ -1,6 +1,5 @@<RESET>
+	<RED>-int func()<RESET>
+	<GREEN>+<RESET><GREEN>int do_foo()<RESET>
+	 {<RESET>
+	<RED>-	if (foo) {<RESET>
+	 Q// this part of the function<RESET>
+	 Q// function will be very long<RESET>
+	 Q// indeed. We must exceed both<RESET>
+	<CYAN>@@ -8,6 +7,11 @@<RESET> <RESET>int func()<RESET>
+	 Q// minimums<RESET>
+	 Q;<RESET>
+	 }<RESET>
+	<GREEN>+<RESET>
+	<GREEN>+<RESET><GREEN>int func()<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<GREEN>+<RESET>Q<GREEN>if (foo)<RESET>
+	<GREEN>+<RESET>QQ<GREEN>do_foo();<RESET>
+	 Qbaz();<RESET>
+	 Qbar();<RESET>
+	 Q// more unrelated stuff<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	# And now ignoring white space only in the move detection
+	git diff --color --color-moved --ignore-all-space-in-move-detection |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/function.c b/function.c<RESET>
+	<BOLD>--- a/function.c<RESET>
+	<BOLD>+++ b/function.c<RESET>
+	<CYAN>@@ -1,13 +1,17 @@<RESET>
+	<GREEN>+<RESET><GREEN>int do_foo()<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// this part of the function<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// function will be very long<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// indeed. We must exceed both<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// per-line and number of line<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// minimums<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>;<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>}<RESET>
+	<GREEN>+<RESET>
+	 int func()<RESET>
+	 {<RESET>
+	<RED>-Qif (foo) {<RESET>
+	<BOLD;MAGENTA>-QQ// this part of the function<RESET>
+	<BOLD;MAGENTA>-QQ// function will be very long<RESET>
+	<BOLD;MAGENTA>-QQ// indeed. We must exceed both<RESET>
+	<BOLD;MAGENTA>-QQ// per-line and number of line<RESET>
+	<BOLD;MAGENTA>-QQ// minimums<RESET>
+	<BOLD;MAGENTA>-QQ;<RESET>
+	<BOLD;MAGENTA>-Q}<RESET>
+	<GREEN>+<RESET>Q<GREEN>if (foo)<RESET>
+	<GREEN>+<RESET>QQ<GREEN>do_foo();<RESET>
+	 Qbaz();<RESET>
+	 Qbar();<RESET>
+	 Q// more unrelated stuff<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_done
-- 
2.15.0.rc2.6.g953226eb5f

