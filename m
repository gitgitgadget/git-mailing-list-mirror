Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2A220357
	for <e@80x24.org>; Fri, 14 Jul 2017 19:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbdGNTQz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 15:16:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34665 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdGNTQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 15:16:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so11934326pfe.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ntKD7s8KB0qo5JmYp6z+0YDzd/mOsHuOZjlQsEgs9A=;
        b=R0NrXnd41GsOrUIHIZzJyxKodHz0fV+KA6T1PHXI8Qld5ADgfyN88fLxfqVzoChM5F
         QNpsQHMrc1i3NERSYwhD6H3jve8d52vfDj7z7tEHmenKWV5slbNOTXNnjO7TbuJQc0Vd
         GQ9/Ygd0ItQAAVe8dLYcIeXjEenQVG0WvaycY7X83ikJ6dmeANJ9qOspiaPJSZaOPhh3
         nz4myplFDQBFymhltKeDQVpjJVlIlZuUgdQfKaTjJ+kKfNi2EDOA2f4yIc1JY2igvyIO
         e/EyNNJsqiobLqCsx5vtsG2yfFGqhqeB598EUXgF8uxqoL7fWH5wW5T5oPbmyCEV8QGR
         AdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ntKD7s8KB0qo5JmYp6z+0YDzd/mOsHuOZjlQsEgs9A=;
        b=paqvmtslZPwISoQlJY3eTJXYnlT6dOOFR/LXl5IoLTx+IGCP9El4+CANuI5Ow7PSC1
         7yWBR71MBYljPt8WGeo6dEqoOn1ySrwUx3XSn/LXKhghpXF4BNaQamQA8c0OclSwb5z9
         hYaOV+/H0z5ZGJ8cOqTQQfytX4MNrUMs9LAisBqQWdcYDCaFVQ4e+4/d08TGJJBOa05G
         PLrwTABInhReh6xO1t+rCdlj4G0zNpnQSEYst1kkbwUdMCk9tB/XNJxcMx1SzJcd2gbE
         NPOWvGZN+8N88iEUHH7pJtYdMgdvwkPEXl6/SQN+eLhePIFUBYmVWAHAdrBxsLuc80dg
         zolw==
X-Gm-Message-State: AIVw113trQAJkj2u0bMSygopPG4e4VGeoU7nOGeff7Aqb+lmQI8mU+68
        bW4fEwvtXWb02AipnBc=
X-Received: by 10.84.160.226 with SMTP id v31mr17315096plg.91.1500059813893;
        Fri, 14 Jul 2017 12:16:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id 83sm18478620pfa.113.2017.07.14.12.16.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 12:16:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
        <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
        <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
        <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
        <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
        <20170714173658.2q24oxhatwh5qrqk@sigill.intra.peff.net>
        <xmqqd192rh1t.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 14 Jul 2017 12:16:51 -0700
In-Reply-To: <xmqqd192rh1t.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 14 Jul 2017 11:48:14 -0700")
Message-ID: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Do we need to have a check to detect a buggy compiler that takes the
> syntax but produces an incorrectly initialized array?  I could add a
> test to ensure that HEADER comes out BOLD, etc. (or we may already
> have such a test) and then reorder these lines in this patch, if
> that is the kind of breakage we anticipate.

So here is a lunch-time hack I did to replace the patch I sent
earlier.  I kind of like the ordering of the elements better than
the original, in that it somehow feels more logical, even though I
merely sorted alphabetically ;-).


 builtin/clean.c              | 19 ++++++++++---------
 t/t7301-clean-interactive.sh | 10 ++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 057fc97fe4..e2bb3c69ed 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -33,15 +33,6 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
-static int clean_use_color = -1;
-static char clean_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,	/* PLAIN */
-	GIT_COLOR_BOLD_BLUE,	/* PROMPT */
-	GIT_COLOR_BOLD,		/* HEADER */
-	GIT_COLOR_BOLD_RED,	/* HELP */
-	GIT_COLOR_BOLD_RED,	/* ERROR */
-};
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
 	CLEAN_COLOR_PLAIN = 1,
@@ -51,6 +42,16 @@ enum color_clean {
 	CLEAN_COLOR_ERROR = 5
 };
 
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
+	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
+	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
+	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
+	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
+	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
+};
+
 #define MENU_OPTS_SINGLETON		01
 #define MENU_OPTS_IMMEDIATE		02
 #define MENU_OPTS_LIST_ONLY		04
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 3ae394e934..556e1850e2 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -472,4 +472,14 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 
 '
 
+test_expect_success 'git clean -i paints the header in HEADER color' '
+	>a.out &&
+	echo q |
+	git -c color.ui=always clean -i |
+	test_decode_color |
+	head -n 1 >header &&
+	# not i18ngrep
+	grep "^<BOLD>" header
+'
+
 test_done
