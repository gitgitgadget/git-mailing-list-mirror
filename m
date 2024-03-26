Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B61FBB
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412276; cv=none; b=fPhtSXxmy3+bQIWeasv9cxvNzlu66AzcyrJs+Zm979Oecw7w2rRCywbLqiCW/m6fRckz2Da2Hf2QpuG0qcLX/jgRtbJG9JXDgP3mrJPc6lIak+Zy89KUvUJO51Gg7z0MIvM2GP35FPdZE78IvjZH4GUDSXmubRlPdfxvfPwRhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412276; c=relaxed/simple;
	bh=KKqsypByYlHqjIkWXyRUDuYWe0khFGW8aEKZeO9gNOw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E4M3lHaLZkXaYk1NYxYkzh/BlGMtb5xl70rq0pqj3+14F5XgJohE7xzbXNGjAABHh9noJoYy4UcOmLg+bxn0pqxBu2quCmb3CIsgz82XEP31SyecXxfqG16yJOxj8V6mfX0UeZjvFowmm7eGH279D3N+Od+iDfMYuQtrlRfaNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfEuHpp4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfEuHpp4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4148e14799eso1049825e9.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711412273; x=1712017073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZJBGgEpKSpH//lSlbkOxw9bPLIlAVK8OgqHAOLkDQM=;
        b=gfEuHpp4HJIb1aO0WW33SWuBPz8Zp8/rmQLiwXsTEVUd+vm3VfSb+e89gXdEHGvDjB
         sdIUSCetEJSYatAHxR1ZntEC6dyP+gSouQPgcazEe6ZunSUcKvyOKcDbt4rYEgogbgm/
         L876O3Dndbk+l/nd9o8Y4wNNGY/xdHJQ45itdeyaNjyj+3XCeHensG5+i3oAsS9OVigg
         wEJdyDaHUDiUe2KzeD6bIIRHGJdU5SJYH+uOb72zlexEaKQT6IP4r4c51XCcUlGCjH8N
         GBZshOU2LyIfd8VUzqw+HRdymAzjT6Pp5oOveIS0vlUEqGZME91dw/hZ7nxyaxBHnvNc
         YDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711412273; x=1712017073;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZJBGgEpKSpH//lSlbkOxw9bPLIlAVK8OgqHAOLkDQM=;
        b=ZcnGt8bcwkaeqn9HHm3ucjZEMsvFNkKN1tXBVJtBHHYoIyolU8Pmw7r7cWtKzHXTRD
         FuvXC41RAOfse5QxBlIfztAsn283oYbKC0/g9aMISCry4XmRv7JWsvpr5jvF9bdZn9ff
         ooCg0ZIvye4hW1FTts/ld/GvrrEyn/8IvFSEZtFSPUBGc3Piz+uw1o05Aq0RZAEcEUIg
         VTvC4rJtOplRlTBoKqrzb0IwaCkbOsCpdSWJNSmcOC51ckfRZ+sJisxQtpJP2Ilf0iG5
         euPnAtDBgyqAhumHl1DZ7AbMoHt/dHcM1RfJH07VrPRKKEI/nEJI7n/tT0gB0xjdx/5O
         TcVQ==
X-Gm-Message-State: AOJu0YwISFmtw0tmquOQVol6aJz0Pw11wtVX4e+B6qS9D5QEAh+INh+8
	vCxmCcHI8auQT6KpTSq168+gnJQNZtff5ZNON5oKkdLY6h2QLGxYcoO68jDv
X-Google-Smtp-Source: AGHT+IEd6aXzJ9egmi30OGNCHpn8dP7olyQjRb7HO8tSLaz+FrIf0Qb9LCHnNluXiyigtkC9qWHLjw==
X-Received: by 2002:a05:600c:5844:b0:413:f034:da6e with SMTP id ka4-20020a05600c584400b00413f034da6emr6209023wmb.38.1711412272698;
        Mon, 25 Mar 2024 17:17:52 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d690f000000b0033e95bf4796sm10666431wru.27.2024.03.25.17.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 17:17:52 -0700 (PDT)
Message-ID: <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
Date: Tue, 26 Mar 2024 01:17:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] add-patch: do not print hunks repeatedly
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Language: en-US
In-Reply-To: <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The interactive-patch is a sequential process where, on each step, we
print one hunk from a patch and then ask the user how to proceed.

There is a possibility of repeating a step, for example if the user
enters a non-applicable option, i.e: "s"

    $ git add -p
    diff --git a/add-patch.c b/add-patch.c
    index 52be1ddb15..8fb75e82e2 100644
    --- a/add-patch.c
    +++ b/add-patch.c
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? s
    Sorry, cannot split this hunk
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

... or an invalid option, i.e: "U"

    $ git add -p
    diff --git a/add-patch.c b/add-patch.c
    index 52be1ddb15..8fb75e82e2 100644
    --- a/add-patch.c
    +++ b/add-patch.c
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
    y - stage this hunk
    n - do not stage this hunk
    q - quit; do not stage this hunk or any of the remaining ones
    a - stage this hunk and all later hunks in the file
    d - do not stage this hunk or any of the later hunks in the file
    j - leave this hunk undecided, see next undecided hunk
    J - leave this hunk undecided, see next hunk
    g - select a hunk to go to
    / - search for a hunk matching the given regex
    e - manually edit the current hunk
    p - print again the current hunk
    ? - print help
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

Printing the chunk again followed by the question can be confusing as
the user has to pay special attention to notice that the same chunk is
being reconsidered.

It can also be problematic if the chunk is longer than one screen height
because the result of the previous iteration is lost off the screen (the
help guide in the previous example).

To avoid such problems, stop printing the chunk if the iteration does
not advance to a different chunk.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 444fd75b2a..54a7d9c01f 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
-	size_t hunk_index = 0;
+	size_t hunk_index = 0, prev_hunk_index = -1;
 	ssize_t i, undecided_previous, undecided_next;
 	struct hunk *hunk;
 	char ch;
@@ -1448,10 +1448,14 @@ static int patch_update_file(struct add_p_state *s,
 
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
-			render_hunk(s, hunk, 0, colored, &s->buf);
-			fputs(s->buf.buf, stdout);
+			if (prev_hunk_index != hunk_index) {
+				render_hunk(s, hunk, 0, colored, &s->buf);
+				fputs(s->buf.buf, stdout);
+				strbuf_reset(&s->buf);
+
+				prev_hunk_index = hunk_index;
+			}
 
-			strbuf_reset(&s->buf);
 			if (undecided_previous >= 0) {
 				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");
@@ -1649,10 +1653,12 @@ static int patch_update_file(struct add_p_state *s,
 			if (!(permitted & ALLOW_SPLIT))
 				err(s, _("Sorry, cannot split this hunk"));
 			else if (!split_hunk(s, file_diff,
-					     hunk - file_diff->hunk))
+					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->s.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
+				prev_hunk_index = -1;
+			}
 		} else if (s->answer.buf[0] == 'e') {
 			if (!(permitted & ALLOW_EDIT))
 				err(s, _("Sorry, cannot edit this hunk"));
@@ -1661,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
 				goto soft_increment;
 			}
 		} else if (s->answer.buf[0] == 'p') {
-			/* nothing special is needed */
+			prev_hunk_index = -1;
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-- 
2.44.0.494.gfaa70abb0d
