Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FB02023D
	for <e@80x24.org>; Tue, 23 May 2017 03:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936012AbdEWDBp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:01:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34091 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933583AbdEWDBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:01:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so24132151pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+JLBiJYSXC1tO5EIbNjl3M9lTVQBx965YgFqMr5z4yc=;
        b=p6a+goYRNhAqorozUfCRoJUv64EuaSfhRY6F4Gs5iPAQ+Cels48rtFVRLBL6mbVXAv
         MjufYyIxpV771jKV45rshPZb712KhpEk9698DpftvgjVb6xrVjtaTR6pQo/YRTZlx1zG
         PxETU7RRqR7KLLH6XdTB9KCuxjrust19TiquqnhawEPt+BG4iQYJYU8SK+p8qxDHHpj2
         IxkSpWfg6+VNBJTHiNkZqOlo3jR9pouAd/x9RGC1uSzq5VB7+bjjgLrkEeDwZWbp3UFd
         q5+AGEmja4I41V9FQb9PbZdYUhMrYdiC7nXlqbS1uxnHnUF6ouXoyV5cOxNPjRCMfDzC
         IYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+JLBiJYSXC1tO5EIbNjl3M9lTVQBx965YgFqMr5z4yc=;
        b=BoC3hn9ieKyhs3n3xZ7ZEdmkdbMkbCaoQnSFirEwz/vRe4BytKcigyGAergM2xFILL
         5wGB/LrE740g7TFg2QK5vFyhoqw5FjJOZgiuJv5KFC4CE7F+gQB5Y7rgGx97xurb82v6
         Z5cFRYv+tAtleZSly13nin31snghvhvkym48GeMqM6b5KY7eNbWJbZfEPoUfCfpHqmcQ
         Ye3rdcq+4kW0L7FpPs7PoCircXJq0PJzdvYFCJrj3TV2tAgBgaCPlXfB/3BJ1uEd6ViV
         YiAiMwCeO8u7kHzQEkDgoVIk//7kZfNeBYJz+gwFVb3ULUIQzk+PhEQXs28UEWCkS5kG
         CbrA==
X-Gm-Message-State: AODbwcB4YKq4bbkJToT7beDYXpYRdLH+6xGwRCEB5goygaPnWYY7obkX
        BKf20OPe1kehcZ1jOHs=
X-Received: by 10.84.176.131 with SMTP id v3mr32852581plb.138.1495508503075;
        Mon, 22 May 2017 20:01:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id 202sm28321679pge.12.2017.05.22.20.01.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:01:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     DOAN Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        animi.vulpis@gmail.com, j6t@kdbg.org,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
        <20170521134209.25659-1-congdanhqx@gmail.com>
        <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
        <20170522201212.uuas26n6npdebsxg@sigill.intra.peff.net>
        <xmqq37bwnxg4.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 May 2017 12:01:41 +0900
In-Reply-To: <xmqq37bwnxg4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 23 May 2017 11:01:15 +0900")
Message-ID: <xmqqy3tomg2y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I suspect that's more work because we'd need to refactor pretty.c a bit
>> to make the right functionality available. But the end result would be
>> much more maintainable.
>
> I actually think the entire codeflow of "find positions and length
> of threeparts" using find_subpos() and then "copy the length bytes
> starting position for C_{SUB,BODY,SIG,LINES,...}" must be rethought,
> if the behavior of pretty.c::pretty_print_commit() is to be matched.
> With the current code, %(contents:body) and other atoms that are
> handled in ref-filter.c::grab_sub_body_contents() keep trailing
> whitespaces on their lines with the current code that copies length
> bytes starting the position using xmemdupz().  There need to be some
> code that loses these trailing whiltespaces in the copied result.
>
> While I do not claim that refactoring and reusing code from pretty.c
> is the only viable way forward, it is clear to me that a patch that
> updates find_subpos() and changes nothing else falls short X-<.

I wonder if this would be a viable alternative (this is just a
smoking-break hack without an attempt to think through corner
cases---for example we need to make sure we work sensibly when
the object does not have _any_ body past the header, but I do not
think the original works well in that case, either).

 ref-filter.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970d..10f8fe15f5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -949,13 +949,7 @@ static void find_subpos(const char *buf, unsigned long sz,
 			const char **sig, unsigned long *siglen)
 {
 	const char *eol;
-	/* skip past header until we hit empty line */
-	while (*buf && *buf != '\n') {
-		eol = strchrnul(buf, '\n');
-		if (*eol)
-			eol++;
-		buf = eol;
-	}
+
 	/* skip any empty lines */
 	while (*buf == '\n')
 		buf++;
@@ -1011,10 +1005,11 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *rawbuf, unsigned long sz)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
+	struct strbuf buf = STRBUF_INIT;
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -1030,11 +1025,18 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
-		if (!subpos)
-			find_subpos(buf, sz,
+		if (!subpos) {
+			char *eoh = memmem(rawbuf, sz, "\n\n", 2);
+			eoh += 2;
+			sz -= eoh - (char *)rawbuf;
+			rawbuf = eoh;
+			strbuf_add(&buf, rawbuf, sz);
+			strbuf_stripspace(&buf, 0);
+			find_subpos(buf.buf, sz,
 				    &subpos, &sublen,
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
+		}
 
 		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
@@ -1060,8 +1062,9 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 					info.trailer_end - info.trailer_start);
 			trailer_info_release(&info);
 		} else if (atom->u.contents.option == C_BARE)
-			v->s = xstrdup(subpos);
+			v->s = xmemdupz(rawbuf, sz);
 	}
+	strbuf_release(&buf);
 }
 
 /*
