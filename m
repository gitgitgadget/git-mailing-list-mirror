Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30471F453
	for <e@80x24.org>; Fri,  2 Nov 2018 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKCGcF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 02:32:05 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:44356 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCGcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 02:32:05 -0400
Received: by mail-io1-f73.google.com with SMTP id u5-v6so2891588iol.11
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kz2RU0WLcT0mjNpbLXr2Fp1UtywwaCTS2sUOIdunYRQ=;
        b=M71qrdwUVaTVT+BaLc1b/QsjjVphXtKQSFHMRZZIGppyLhUntWRrnkk4ZX2Ryy3SqX
         PsKgbyFzw5p4NjCCWMO2nyeY1kIGM9zXtwL/pRv65yH5OtA+YaXZst8mPSJxShoXibxv
         CgboiU4Ro8BiRGZmTwQ76IIcEcBO0be9dCF8KjCDZ2y1JiU1vTmKQKSVw6Zv0K1PjbCu
         jKcaT7D08oq2MYHc6jtJyQtMRUHyIpbMgkRmSz4cbqfd7BJqRLY/Fi7IQRIfaOXzAnd/
         BL45V6Gs/xK46CnWb+rkqRcYmeEBO4tkzX8BTqgiwaU3NDe3XtAkUt3fAuQPt16bGi3n
         Up/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kz2RU0WLcT0mjNpbLXr2Fp1UtywwaCTS2sUOIdunYRQ=;
        b=ITnwsf3nkK2jx4TyRKwuNe4biH5u49cFMd0ogvOKoK1y64nCPGUlme99rISnzm5YVQ
         Qmz01vPzf2jwUkB6tq81iqxj6TR8vXbgNkZMfX+UmsijZb7eF3vjfXGP1Rj8e5RVnXnb
         fhC8+dw5uO+lIiZydOdxeRup4efQsGNlBsSTRSP3yyJOjnd+Whm+zzBMh/PDMseVeUT5
         nT2DuEayxSXjBx+WSjo0P7NmZxZzZf1edrS+5aVdBrcAcCNolriMUf89GEIFeC05x52Z
         Nh+P/F+s5tM8yQKvNXc3jnCvef4TwOVvoQg1N2oHo26XixvEONzqvyIlQL9T1AIHExDL
         d8Zw==
X-Gm-Message-State: AGRZ1gK5IwMwZfgKCFE1R67FBc/yN3GlR4ESOvRK2q1dHO0Q9uUMymQp
        EpuYsBe2VQJTUQQsqzrgXgsg6sdrE9ZW5E7f21y8B+qsoR1zPB5uj0f2SbQDm+NUL7tqV+QhWvp
        HYzzWED7HN23hmj7Unl4YWxN/EzJ9eIXdPMVEIPBsRsys7Sq1t+x47Fwo+IdO
X-Google-Smtp-Source: AJdET5elEg9KD7fe2Mo40b7cSuJYp/16kdo2k2O1EZ7nqwM/FcbRZdT+em2RjHRKuQQ6gVFp+f/szpjRD7GT
X-Received: by 2002:a24:3a13:: with SMTP id m19-v6mr246427itm.18.1541193799640;
 Fri, 02 Nov 2018 14:23:19 -0700 (PDT)
Date:   Fri,  2 Nov 2018 14:23:16 -0700
Message-Id: <20181102212316.208433-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] diff: differentiate error handling in parse_color_moved_ws
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we check command line options more strictly and allow configuration
variables to be parsed more leniently, we need take different actions
based on whether an unknown value is given on the command line or in the
config.

Move the die() call out of parse_color_moved_ws into the parsing
of command line options. As the function returns a bit field, change
its signature to return an unsigned instead of an int; add a new bit
to signal errors. Once the error is signaled, we discard the other
bits, such that it doesn't matter if the error bit overlaps with any
other bit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a fresh attempt to cleanup the sloppy part that was mentioned
in https://public-inbox.org/git/xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com/

Another thing to follow up is to have color-moved-ws imply color-moved.

Thanks,
Stefan


 diff.c | 21 ++++++++++++++-------
 diff.h |  3 ++-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 8647db3d30..f21f8b0332 100644
--- a/diff.c
+++ b/diff.c
@@ -291,7 +291,7 @@ static int parse_color_moved(const char *arg)
 		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed-zebra', 'plain'"));
 }
 
-static int parse_color_moved_ws(const char *arg)
+static unsigned parse_color_moved_ws(const char *arg)
 {
 	int ret = 0;
 	struct string_list l = STRING_LIST_INIT_DUP;
@@ -312,15 +312,19 @@ static int parse_color_moved_ws(const char *arg)
 			ret |= XDF_IGNORE_WHITESPACE;
 		else if (!strcmp(sb.buf, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
-		else
+		else {
+			ret |= COLOR_MOVED_WS_ERROR;
 			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
+		}
 
 		strbuf_release(&sb);
 	}
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
-	    (ret & XDF_WHITESPACE_FLAGS))
-		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+	    (ret & XDF_WHITESPACE_FLAGS)) {
+		error(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+		ret |= COLOR_MOVED_WS_ERROR;
+	}
 
 	string_list_clear(&l, 0);
 
@@ -341,8 +345,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.colormovedws")) {
-		int cm = parse_color_moved_ws(value);
-		if (cm < 0)
+		unsigned cm = parse_color_moved_ws(value);
+		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		diff_color_moved_ws_default = cm;
 		return 0;
@@ -5035,7 +5039,10 @@ int diff_opt_parse(struct diff_options *options,
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
 	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
-		options->color_moved_ws_handling = parse_color_moved_ws(arg);
+		unsigned cm = parse_color_moved_ws(arg);
+		if (cm & COLOR_MOVED_WS_ERROR)
+			die("bad --color-moved-ws argument: %s", arg);
+		options->color_moved_ws_handling = cm;
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
diff --git a/diff.h b/diff.h
index ce5e8a8183..9e8061ca29 100644
--- a/diff.h
+++ b/diff.h
@@ -225,7 +225,8 @@ struct diff_options {
 
 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
 	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
-	int color_moved_ws_handling;
+	#define COLOR_MOVED_WS_ERROR (1<<0)
+	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
 };
-- 
2.19.1.930.g4563a0d9d0-goog

