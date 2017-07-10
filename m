Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B37020357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbdGJVig (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:38:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35291 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754420AbdGJVif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:38:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so16104653pfq.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rgqo+BHtmojCyA9YZID3XSh+QoDHON9xeJPU1wEmQiY=;
        b=JG93Rp3UmDJ4S5X9XCmKvNKlN23IZDFzxoAtTy6t55FuFiLqTqldK3tpnxrlPMOfai
         aflGiZwC7HdIK4nouHyah+T10anWQUegUVM4PYJ4FealVtQ6rT9rrG27MEIvtHerpQSG
         2kXkNgTcq5ScbYSQGEWSRJ0iNSJPRwkRHRRejXr6D7y0JOmb1+AW0BlldWViXjhuTl1c
         GhPqtxH3HGuR81G5OlWwv8zACOC9xKmDVCXfjoQV7aoFiGdz10yz3KN0JzdOBikAufaa
         yhzbDH8w9yYLAApaBKuGWq+6KiNKN/PrnFlJKipYDG/p2bYm5igCgugC4lwa7uwMHw4P
         CYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rgqo+BHtmojCyA9YZID3XSh+QoDHON9xeJPU1wEmQiY=;
        b=opUhS3RjD3xl7KpD0VljDKyVH9Lh9PnmH+b7wJ0G4p12T/PjEyltdWLCx+UhqPhFu6
         lkZQ//mOBvDn73ji5ZibJlMW4pwpGv0IF6gUy4BWK2mHa+L1hTkm9dVYTX6tKTMrqkB9
         Vg/jDZj3ESG0PUuEez2BKoXrTrNP1V3ID0vMVtPc8IflbYogP2kpiXimOJrvuUdsRZY/
         HkrimNNELnXdE7SKrA1wGFCRP3titv3vaVQJKgMTdqNb8zcO1rRjaSbV4tyvJJbuUZEt
         Ei6AQR+VUoLpNcqDe56bZ6EFXkdEouj94PjU5GzHdACKZkJ23AMx3AJYzWUxR9V6z/G3
         a7Ng==
X-Gm-Message-State: AIVw110elhLptu8zYGys6P7sidGSIEnnuppmRLvFPEnHkoG19HJ+wlMg
        EReSzibA29B9qQ==
X-Received: by 10.99.0.138 with SMTP id 132mr16944859pga.30.1499722714424;
        Mon, 10 Jul 2017 14:38:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id d18sm35264330pgn.27.2017.07.10.14.38.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:38:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
        <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
        <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
Date:   Mon, 10 Jul 2017 14:38:31 -0700
In-Reply-To: <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org> (Johannes Sixt's
        message of "Mon, 10 Jul 2017 23:11:35 +0200")
Message-ID: <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> I am not sure what negative impact you think the macro-ness would
>> have to the validity of the result from this test balloon.  An old
>> compiler that does not understand designated initializer syntax
>> would fail to compile both the same way, no?
>>
>> 	struct strbuf buf0 = STRBUF_INIT;
>> 	struct strbuf buf1 = { .alloc = 0, .len = 0, .buf = strbuf_slopbuf };
>
> I said it is uninteresting, not that there is a negative impact. There
> is simply nothing gained for strbuf users: They would use STRBUF_INIT
> before and after the change and would not benefit from designated
> initializers.
>
> This change may serve well as a test balloon, but not as an example of
> the sort of changes that we would want to see later (of the kind
> "change FOO_INIT macro to use designated initializers"; they are just
> code churn).

Oh, absolutely.

Here is another possible test balloon, that may actually be useful
as an example.  I think there is a topic in flight that touches this
array, unfortunately, so I probably would find another one that is
more stable for a real follow-up patch to the one from Peff.

 diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 00b4c86698..b3864a2e03 100644
--- a/diff.c
+++ b/diff.c
@@ -47,15 +47,15 @@ static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
 
 static char diff_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,	/* CONTEXT */
-	GIT_COLOR_BOLD,		/* METAINFO */
-	GIT_COLOR_CYAN,		/* FRAGINFO */
-	GIT_COLOR_RED,		/* OLD */
-	GIT_COLOR_GREEN,	/* NEW */
-	GIT_COLOR_YELLOW,	/* COMMIT */
-	GIT_COLOR_BG_RED,	/* WHITESPACE */
-	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	[DIFF_RESET] = GIT_COLOR_RESET,
+	[DIFF_CONTEXT] = GIT_COLOR_NORMAL,
+	[DIFF_METAINFO] = GIT_COLOR_BOLD,
+	[DIFF_FRAGINFO] = GIT_COLOR_CYAN,
+	[DIFF_FILE_OLD] = GIT_COLOR_RED,
+	[DIFF_FILE_NEW] = GIT_COLOR_GREEN,
+	[DIFF_COMMIT] = GIT_COLOR_YELLOW,
+	[DIFF_WHITESPACE] = GIT_COLOR_BG_RED,
+	[DIFF_FUNCINFO] = GIT_COLOR_NORMAL,
 };
 
 static NORETURN void die_want_option(const char *option_name)
