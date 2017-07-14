Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8307920357
	for <e@80x24.org>; Fri, 14 Jul 2017 16:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbdGNQLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 12:11:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34778 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbdGNQLh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 12:11:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so11485810pfe.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yH3MEwScPadqqUvOlFEbN4ByvEEMgxdfNasdLofXwNc=;
        b=QJs9IXFYA3lA57uSo96nNhvxV+kOwUb8tC9IXich+RIit3BokSD2THT0b+Xiz92cxL
         rRjVxBshiAbQ5bchp5T/JjlCj+rOOZNH39TtOB+ZWG/zDjRc3rMVUs5ZyMdMWb4XNWnF
         9JjyrLkA3NgS0NP3uSwxw45sMSHWz/RP0aJSa8p8TfjCpqi5i/xd7S7d1Y9azlIQU1gG
         tZYXg+tkicD/FtSbrgS2VU9ZLMY5JPi0BjxLJX/ufFhHlPygk7ILdhtpRqu47FSoSRb9
         s/GYOTaVKBJGMAm2VVtnrPdOk35Rd0E6e4QawBgdOi8BQVPA+cFXxiARBaIsxueOGBLy
         cumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yH3MEwScPadqqUvOlFEbN4ByvEEMgxdfNasdLofXwNc=;
        b=nqcLM8AT06UDwAsSodNyTgKtjGcIMjXikdEm8yapDs1KQ6QZOnngAvY8OP4xszmWKK
         jhjyGAkmXMHduuaiPiKiysaMnz4zz69EDI5mfUGzeB+OMYmp2Ti9VxzWxC04uHi55gcq
         aX3sLma4kb4R9FiBMJDUO3FCv/ZUNIoueyz9ArVbus3T77V1ZaT2RSBbpZ67TOd857M1
         mSuMYbdMN4DKBQaU2TS+eqTJed25e6w7q8xxmW6PHdwb6Z1A5ph/ir/PeMLjEPrQpuvc
         lShsqzoIggNtEom2nBzrnyX+JVhrhxR4PuP99Wq2kIfmU0O9ZQpSToocoPKNEYU3Zj1z
         X7jg==
X-Gm-Message-State: AIVw111I7/t8wvq6L+jVKey5Gfp42jjdnJRLrxToenmev/pivGdIkM40
        OH3TzuJsVVJQOahYFk4=
X-Received: by 10.84.193.129 with SMTP id f1mr16751811pld.158.1500048696109;
        Fri, 14 Jul 2017 09:11:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id b6sm22689052pgn.67.2017.07.14.09.11.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 09:11:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
        <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
        <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
        <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 14 Jul 2017 09:11:33 -0700
In-Reply-To: <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 10 Jul 2017 14:38:31 -0700")
Message-ID: <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Oh, absolutely.
>
> Here is another possible test balloon, that may actually be useful
> as an example.  I think there is a topic in flight that touches this
> array, unfortunately, so I probably would find another one that is
> more stable for a real follow-up patch to the one from Peff.

And here it is.

As to other things that we currently not allow in our codebase that
newer compilers can grok, here is what *I* think.  It is *not* meant
to be an exhaustive "what's new in C99 that is not in C89? what is
the final verdict on each of them?":

 - There were occasional cases where we wished if variable-length
   arrays, flexible array members and variadic macros were available
   in our codebase during the course of this project.  We would
   probably want to add a similar test baloon patch for each of
   them to this series that is currently two-patch long.

 - I prefer to keep decl-after-statement out of our codebase.  I
   view it as a big plus in code-readability to be able to see a
   complete list of variables that will be used in a block upfront
   before starting to read the code that uses them.

 - Corollary to the above, I do not mind to have a variable
   declaration in the initialization clause of a for() statement
   (e.g. "for (int i = 0; i < 4; i++) { ... }"), as the scoping rule
   is very sensible.  Some of our "for()" statements use the value
   of the variable after iteration, for which this new construct
   cannot be used, though.

 - This may be showing I am not just old fashioned but also am
   ignorant, but I do not see much point in using the following in
   our codebase (iow, I am not aware of places in the existing code
   that they can be improved by employing these features):

   . // comments
   . restricted pointers
   . static and type qualifiers in parameter array declarators



-- >8 --
Subject: [PATCH] clean.c: use designated initializer

This is another test balloon to see if we get complaints from people
whose compilers do not support designated initializer for arrays.

The use of the feature is not all that interesting for cases like
the one this patch touches, where the initialized elements of the
array is dense, but it would be nice if we can use the feature to
initialize an array that has elements initialized to interesting
values only sparsely.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 057fc97fe4..858df2c4ee 100644
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
+	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
+	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
+	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
+	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
+	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
+	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
+};
+
 #define MENU_OPTS_SINGLETON		01
 #define MENU_OPTS_IMMEDIATE		02
 #define MENU_OPTS_LIST_ONLY		04
-- 
2.14.0-rc0-148-g5448d1895b

