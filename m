Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C9C20D34
	for <e@80x24.org>; Wed, 14 Jun 2017 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdFNSYl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:24:41 -0400
Received: from mout.web.de ([212.227.17.11]:52571 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbdFNSYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:24:40 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGign-1dY50R0vHl-00DXEy; Wed, 14
 Jun 2017 20:24:30 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
Date:   Wed, 14 Jun 2017 20:24:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:nFsunlk1nG2jcFOJ+LEb3cAOC82Z4eRImPI1s2YSmCeKdI6oGp/
 m79mjUNz/mj2kf+b+nGu4+/qGdE02ENvanIFkawY07rScLwHM/z+LGFXHzRr6bh27d7EkIX
 BvyJte50dy1mcSuAEEfe22I9Js7yZ/NRMFghu9vUG7s9fw6emt4CZ8mblq37PN17gr7VIA3
 W6FEGlw9ZxV+M9I73/U3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:asBLSZAqhO4=:6c96LXs9CRqEqta4Ib5o7c
 Og189fvvBHzzhA4+IxNndin9EDY6o863yPD/m1wj5jWwaJsHs7prsjuonQwItL2wD74b/SE28
 7zdZZTcuQKxXVFhj77YiJQw0kGC9laMtJKj4SwoVqcTK8QSRkVYJHGIpiTBUsXyTm7nRgS0qM
 9pW2gSOkSLzJZI2vxOyIqI4zlMK4DRkGFqeU1WMZAvyPTGq1t30OKrC1454TFLpCI7mC6QRVG
 9J03AIpUF4J3DqpdfbX6zU7n6aydWHvYUpTx7WzZUHWZqxv49+G8ferbCiGRemGbK1hd2SDUo
 b0ydMKb6wqp/t+g/B9GbLYG+gTq/11mXfNGpGKj7x5IZXYuVr3WHyRS/1MFT3y59O9nymxUl4
 IAPjkz/ftTKuJ5cnsMeyYQ5zP07X+j8X4zrXyB76tiQsIFSYgVkLMV1NJ/odGn0TAiol4Vj2y
 nnyJThTvTGeEinxUJq6sjxcOg+3ymUanTT5zRzoJkVO51+rMYXBbkiP+xWyorJEt27y1NGc0V
 qqt1te292Zwl+P3v4AGR6tUImDmJz27sa6y9bMSEJUVQYfRVdNrZuqqOmCI1H4FJdwgSpmXDT
 9Wsg5TYGQ5RhffzIVZxsHMWxZA7szFy8EJySLukwvW+2UOUnYXHvfaC5Q636vUA1XSEhIrS0R
 huPazXCVxS2zMnnmFC1/gxfVJdN6FGwpfk5YA90Kd25NY/WGTKAc4LnXAcJeCjV+0/iyc7zSh
 3He5FQ0cZe+SNS35wuG49BfGJBsK45djnY2XivQIfXk7f49/6LqwGFcXUi0uiGP3vIa1SNkQR
 U+uhl07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.2017 um 23:20 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> The difference is about the same as the one between:
>>
>> 	$ time git log --format="" >/dev/null
>>
>> 	real    0m0.463s
>> 	user    0m0.448s
>> 	sys     0m0.012s
>>
>> and:
>>
>> 	$ time git log --format="%h" >/dev/null
>>
>> 	real    0m1.062s
>> 	user    0m0.636s
>> 	sys     0m0.416s
>>
>> With caching duplicates are basically free and without it short
>> hashes have to be looked up again.  Other placeholders may reduce
>> the relative slowdown, depending on how expensive they are.
> 
> I think the real question is how likely people use more than one
> occurrence of the same thing in their custom format, and how deeply
> they care that --format='%h %h' costs more than --format='%h'.  The
> cost won't of course be double (because the main traversal costs
> without any output), but it would be rather unreasonable to expect
> that --format='%h %h %h %h %h' to cost the same as --format='%h';
> after all, Git is doing more for them ;-)

The answer to the first half is obviously "very likely" -- otherwise
this bug wouldn't have been found, right? :)

Regarding the question of how bad a 50% slowdown for a second %h
would be: No idea.  If ran interactively it may not even be noticeable
because the user can read the first few lines in less while the rest
is prepared in the background.  We don't have a perf test for formats
with duplicate short hashes, so we don't promise anything, right? :)

René

-- >8 --
Subject: [PATCH] pretty: recalculate duplicate short hashes

b9c6232138 (--format=pretty: avoid calculating expensive expansions
twice) optimized adding short hashes multiple times by using the
fact that the output strbuf was only ever simply appended to and
copying the added string from the previous run.  That prerequisite
is no longer given; we now have modfiers like %< and %+ that can
cause the cache to lose track of the correct offsets.  Remove it.

Reported-by: Michael Giuffrida <michaelpg@chromium.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
I'm sending this out in the hope that there might be a simple way
to fix it after all, like Gábor's patch does for %+.  %< and %>
seem to be the only other problematic modifiers for now -- I'm
actually surprised that %w seems to be OK.

 pretty.c | 32 --------------------------------
 strbuf.c |  7 -------
 strbuf.h |  6 ------
 3 files changed, 45 deletions(-)

diff --git a/pretty.c b/pretty.c
index 09701bd2ff..cc099dfdd1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -783,29 +783,9 @@ struct format_commit_context {
 	size_t body_off;
 
 	/* The following ones are relative to the result struct strbuf. */
-	struct chunk abbrev_commit_hash;
-	struct chunk abbrev_tree_hash;
-	struct chunk abbrev_parent_hashes;
 	size_t wrap_start;
 };
 
-static int add_again(struct strbuf *sb, struct chunk *chunk)
-{
-	if (chunk->len) {
-		strbuf_adddup(sb, chunk->off, chunk->len);
-		return 1;
-	}
-
-	/*
-	 * We haven't seen this chunk before.  Our caller is surely
-	 * going to add it the hard way now.  Remember the most likely
-	 * start of the to-be-added chunk: the current end of the
-	 * struct strbuf.
-	 */
-	chunk->off = sb->len;
-	return 0;
-}
-
 static void parse_commit_header(struct format_commit_context *context)
 {
 	const char *msg = context->message;
@@ -1147,24 +1127,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	case 'h':		/* abbreviated commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-		if (add_again(sb, &c->abbrev_commit_hash)) {
-			strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
-			return 1;
-		}
 		strbuf_add_unique_abbrev(sb, commit->object.oid.hash,
 					 c->pretty_ctx->abbrev);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
-		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		if (add_again(sb, &c->abbrev_tree_hash))
-			return 1;
 		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
 					 c->pretty_ctx->abbrev);
-		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
@@ -1174,16 +1146,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 		return 1;
 	case 'p':		/* abbreviated parent hashes */
-		if (add_again(sb, &c->abbrev_parent_hashes))
-			return 1;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_add_unique_abbrev(sb, p->item->object.oid.hash,
 						 c->pretty_ctx->abbrev);
 		}
-		c->abbrev_parent_hashes.len = sb->len -
-		                              c->abbrev_parent_hashes.off;
 		return 1;
 	case 'm':		/* left/right/bottom */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
diff --git a/strbuf.c b/strbuf.c
index 00457940cf..9103bc75e4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -204,13 +204,6 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 	strbuf_setlen(sb, sb->len + sb2->len);
 }
 
-void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
-{
-	strbuf_grow(sb, len);
-	memcpy(sb->buf + sb->len, sb->buf + pos, len);
-	strbuf_setlen(sb, sb->len + len);
-}
-
 void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
 	strbuf_grow(sb, n);
diff --git a/strbuf.h b/strbuf.h
index 80047b1bb7..d785258649 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -264,12 +264,6 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
 extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
 /**
- * Copy part of the buffer from a given position till a given length to the
- * end of the buffer.
- */
-extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
-
-/**
  * This function can be used to expand a format string containing
  * placeholders. To that end, it parses the string and calls the specified
  * function for every percent sign found.
-- 
2.13.0

