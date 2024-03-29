Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA627748F
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684743; cv=none; b=cHdENGy/qj2b3CHtJ7icEjZLOOcyoeOgTkp/5i7HJCIkPYo21dAbmFHooo/rJxtd5VrzZuqqgQcXA8+EGcLw0GWomvSD7ym2sebyW1PRso4CW8Zi7fipl2FEWHrnTAKkil0DUiFXOBNBxiikeQ8kflQHSY1SZRUc8wZ87vg/nJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684743; c=relaxed/simple;
	bh=87T/n+HuktV/V17H7K0d0e+o+Wb/TgJbW4OMS+bbHnk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GqfmkKcIhfiugIDprjhW/mPqFHtVAi3Jrkk6gvByVGttQhQ8hSqF+aji/UG+b6khJlFhNbSIiPD65N3KBZ+i6SKFoC5+EBOpUgmsVj6zvoC3co+hN16XUDIkhLxrBfk08zgs3hnCqgcBnG4zvi505mZpmJ04pFVUoipwq4S5ZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTvtfeh/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTvtfeh/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41550858cabso327715e9.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711684740; x=1712289540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0FflCLRzyAZz1t+vEl7fRafZN7UwFL9DdQAWhC0wUM=;
        b=TTvtfeh//Xw0gy2fxqdyIaouiqVe0Mf+euXdG3LBnJKenpR3un7eDgvGOg9VoXtDH4
         4Cd2oN+GoQXrxhE56wXa3Ru8fIK3d5O+pVdhwGadmqBdx68H27n6KbKA5XroiONPNb2r
         9nojX5F9NM/2w/qCDYou5dwTkuG8/6VQOJqmf70fIjaucE7+Krole5FJV+TSfy6yTf3h
         WcyOeQP1vZ7UTCBAom8tdFXmAqzBxcOlPsB7lsNEE+JMMW3nLC6zeqZv6lVjzZDQAKXR
         kRXcPJ05erA0l/ErxJOmgqS9oz2aQUwU4WN/y3R9+tZ+ViCfc+C5+bezXszKMVGEQ00r
         0ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684740; x=1712289540;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0FflCLRzyAZz1t+vEl7fRafZN7UwFL9DdQAWhC0wUM=;
        b=pZWr243YJQ9EbifzV9WhBXFHvOX2WkqhWpKWia55EcAFN1gAMsTBhsTd2RybLabkEQ
         JMolxovr/8jUicxI5lH21Q/Nmd7w0WPjv90WftOd6n0lbviEkX7JJI4X2Wlb4ukgNeG/
         GbXpeqd28cSpa08/1i6Xgaa/h9fKZbUnIGznnwGOD/zFGbx+3dlXDpf2j7Z8qO5RW26H
         QVCfaF/OntC4FRAPKWjVz9+UQSrSbRtOGedEOjTQm/Isp2EKJjKaRXNTjSOS11H+GYBt
         PnzBbMDz1HJ+vEdZg768ZXGKYJ2VQGljjVNVlb0vwS8RF2qpGx6stN1Mhwpyr+buO/HH
         KdjQ==
X-Gm-Message-State: AOJu0Yw2kld+VT4Vsrq3Veu18SaEAdSa5k+4BA2u0w6HMVM7M9BIv0gt
	Ep/akVLigAeJLofl9bmx+zGTr3pkp8n/5HkYgrGRvcISO/W9hW0uGr98Pbim
X-Google-Smtp-Source: AGHT+IE68Cg0DZgZE1Lko8m770xMQ5SEsjLkgklNqsZbODuIy3dJhvwtOsMN/UUXUDcvbxBi0FKDfg==
X-Received: by 2002:a05:600c:3c8c:b0:414:6c72:8df with SMTP id bg12-20020a05600c3c8c00b004146c7208dfmr773387wmb.38.1711684740203;
        Thu, 28 Mar 2024 20:59:00 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0041543b57ca2sm4141267wmq.21.2024.03.28.20.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:58:59 -0700 (PDT)
Message-ID: <1f737f82-9bc5-43b4-b78b-bf1b4393efc8@gmail.com>
Date: Fri, 29 Mar 2024 04:58:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
 <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
In-Reply-To: <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
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
 add-patch.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index b5d3a3f0cc..5f11692911 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1395,7 +1395,7 @@ static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
 	size_t hunk_index = 0;
-	ssize_t i, undecided_previous, undecided_next;
+	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1448,10 +1448,15 @@ static int patch_update_file(struct add_p_state *s,
 
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
-			render_hunk(s, hunk, 0, colored, &s->buf);
-			fputs(s->buf.buf, stdout);
+			if (rendered_hunk_index != hunk_index) {
+				render_hunk(s, hunk, 0, colored, &s->buf);
+				fputs(s->buf.buf, stdout);
+
+				rendered_hunk_index = hunk_index;
+			}
 
 			strbuf_reset(&s->buf);
+
 			if (undecided_previous >= 0) {
 				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");
@@ -1646,13 +1651,15 @@ static int patch_update_file(struct add_p_state *s,
 			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
-			if (!(permitted & ALLOW_SPLIT))
+			if (!(permitted & ALLOW_SPLIT)) {
 				err(s, _("Sorry, cannot split this hunk"));
-			else if (!split_hunk(s, file_diff,
-					     hunk - file_diff->hunk))
+			} else if (!split_hunk(s, file_diff,
+					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->s.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
+				rendered_hunk_index = -1;
+			}
 		} else if (s->answer.buf[0] == 'e') {
 			if (!(permitted & ALLOW_EDIT))
 				err(s, _("Sorry, cannot edit this hunk"));
@@ -1661,7 +1668,7 @@ static int patch_update_file(struct add_p_state *s,
 				goto soft_increment;
 			}
 		} else if (s->answer.buf[0] == 'p') {
-			/* nothing special is needed */
+			rendered_hunk_index = -1;
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-- 
2.44.0.370.ge17b8d70f1
