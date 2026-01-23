Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C792DE6FB
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169520; cv=none; b=K2WuFWV96dvhFMSNZNrSZiLVX860noWIoNb/6HqP91q9PgkwLvi707UdtuYEAGplszMetLBmX3yiHyuATJZoznpNaTp7GL9+UGzdpxVlOMmXfbz7k2EnDTPc9S6awqCQwihYQODTAwx9zB/pWrV40lGzT9UwFqjw5Px3kLSH11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169520; c=relaxed/simple;
	bh=sFSZM+QcDIdo/QTZ6uikbjTjtKkQ8WLzKddeHgQjb+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Ior3jzX5X4niTll4i9pcjZ+URvsQDIqZ1elef5C0SlgeWu4TTDdq7C3ksMfa3hvNe1zF8yZa92ig2ev8D9AJ7h68CTabugnl8pDFkA2N5VTl/SJCu5SbOP7BATKDP/Z5QVFuJyrYMKMkbSw0k5w05FmK/6F4foa2YjCAY44Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWAD505M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWAD505M"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so24795195e9.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169517; x=1769774317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUTNtCVa8TQbBKF4sNx+mLFwVFTWoUOlKLT6/qmvdKc=;
        b=OWAD505MMB8W92GOFYSIaJ2qp1HBZSLzpWpIAAKDGiGjtbJPOIu652DBTEXcRJKx7o
         uuAIb5wgPWZkV040/vEPy/9BzptwLLVUZ0u39KrqSS2Tw+aBcMMvtt8v002ZUtL0D1a3
         9ct6TdiHuPBh1YpCz5lzBdsAT4Q2UFbMVnDW7odTybQDCpQnjCK1S401QuopgugH5iGs
         oI014oXUt6X+g7l/ULIm8RuxhJou0wZ7gLvpIDkeqABIAJ+ff5iX2t2GkFVEQt8bKPnm
         t8/mgzWDXEIB0XRaUDxBFyrxcsefb0HwvewZiXdMaYBboFx1sPwBaTi4HAVfd0njYlWd
         +FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169517; x=1769774317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUTNtCVa8TQbBKF4sNx+mLFwVFTWoUOlKLT6/qmvdKc=;
        b=KFJz3iUtbLl0r88c3v02WHYIPiLPORvMi9zqebda07jSQ0fucbqKHJuellLZyOsmKI
         CaAPoD2LmpFNR66PnTlDSbSTgJXYr43eupoLaxigOoaaMMPZnFx1HSmaMGuloRmQIl0n
         Q6pKvFM6/1OsytgtZ6oIts2EjD1EsUyRG2XRI7uAUYleW3xJXQdk8KCyzgbkx54NKcoE
         z2Yd5EES3+e0n2H4XtKC4Laqbnhq2LUMVj6LnO+0rEC48PKBArl1IzgZSPUrT3xlSsgm
         F2s1CbYBVcNl5TzKqJvYH21Q66H3rYp9FEw9rC0b0Eukz/+148NAN5fIhTbZcocJeil3
         +7MQ==
X-Gm-Message-State: AOJu0YwuF72QO2wm485Fs3EFIApI8Lpshxs3O6rctH+O48IinUoJxrRN
	rbWzqg0wD8FnxbzfB9dWgS9YDaiNDuWFpW60b14BGbfhZSzJj+lYrUrC8RnV/rwH
X-Gm-Gg: AZuq6aIBXiut6EOfJ4HGeMIOGxwDv2ZRpA/aHjX5wHyc3Xz9vkhnaMeiyEGJpVKjGp6
	Rf1gvdPb4EuGFZxLh/k2GaxnheECPRoyvWcmTn/VNoAxDDDSw5WeOs6tWHHgbXFrXHd/2787Gv1
	/TwiI5Vopxk/xuZwSDiCsvwuMCNVFMAenH4z3RsC0N+535ykASd9/tQpMv3UnsOrr0A4CweKoRF
	Uhbli5r1Pbep6kIV2KdYbPW1mdPBWrk+KhARnd5T2o762qQdogkOwjB0xj4FVDKCbnkDEArejOn
	imFIMuTxGomDjT8hUiA45omuABx68e49/9XB9YSm3N2x6iT514S7Q977X7NSFuxvgfjowwQj921
	sIEFjrYw0XjKIvSvTaQjYcdwEa/YaPTSRY3k+IsDb/TETAWntJbB2cUEk/x6hc6Ci9KOojC2UpW
	XBbSnZe0jlW8pdQ9Q=
X-Received: by 2002:a05:600c:828f:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4804c94c3cdmr42842245e9.8.1769169516624;
        Fri, 23 Jan 2026 03:58:36 -0800 (PST)
Received: from localhost ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbc0d84sm19788155e9.6.2026.01.23.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:58:35 -0800 (PST)
Date: Fri, 23 Jan 2026 12:58:45 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/1] add-patch: Allow reworking with a file after
 deciding on all its hunks
Message-ID: <e98d8aa20fb4a82b93b9887e38eb8289252b936d.1769164663.git.abrahamadekunle50@gmail.com>
References: <cover.1769164663.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769164663.git.abrahamadekunle50@gmail.com>

After deciding on all hunks in a file, the interactive session
advances automatically to the next file if there is another,
or the process ends.

Allow for reworking with a file by introducing a what_now prompt which
allows for navigating with J/K or advancing to the next file if there is one.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..1ac565b0ab 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1449,7 +1449,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0, use_pager = 0;
+	int colored = !!s->colored.len, quit = 0, use_pager = 0, skip_what_now = 0;
 	enum prompt_mode_type prompt_mode_type;
 
 	/* Empty added files have no hunks */
@@ -1498,12 +1498,61 @@ static int patch_update_file(struct add_p_state *s,
 
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
-		    hunk->use != UNDECIDED_HUNK)
-			break;
+		    hunk->use != UNDECIDED_HUNK && !skip_what_now ) {
+			const char *prompt_whatnow;
+			/* Allow navigation between hunks or go to next file */
 
+			if (s->file_diff_nr > 1)
+				prompt_whatnow = _("What now? [J,K,q,>]? ");
+			else
+				prompt_whatnow = _("What now? [J,K,q]? ");
+			printf("%s %s",
+				s->s.prompt_color,
+				prompt_whatnow);
+			if (*s->s.reset_color_interactive)
+				fputs(s->s.reset_color_interactive, stdout);
+			fflush(stdout);
+			if (read_single_character(s) == EOF) {
+				quit = 1;
+				break;
+			}
+			if (!s->answer.len)
+				continue;
+			if (s->answer.buf[0] == '>' && s->file_diff_nr > 1) {
+				skip_what_now = 0;
+				break;
+			}
+			else if (s->answer.buf[0] == 'K') {
+				if (file_diff->hunk_nr > 1) {
+					hunk_index = dec_mod(hunk_index, file_diff->hunk_nr);
+					skip_what_now = 1;
+				}
+				else
+					err(s, _("No other hunk"));
+				continue;
+			}
+			else if (s->answer.buf[0] == 'J') {
+				if (file_diff->hunk_nr > 1) {
+					hunk_index = inc_mod(hunk_index, file_diff->hunk_nr);
+					skip_what_now = 1;
+				}
+				else
+					err(s, _("No other hunk"));
+				continue;
+			}
+			else if (s->answer.buf[0] == 'q') {
+				skip_what_now = 0;
+				quit = 1;
+				break;
+			}
+			else {
+				err(s, _("All hunks decided (use '?' for help)"));
+				continue;
+			}
+		}
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
-			if (rendered_hunk_index != hunk_index) {
+			if (rendered_hunk_index != hunk_index || skip_what_now == 1) {
 				if (use_pager) {
 					setup_pager(the_repository);
 					sigchain_push(SIGPIPE, SIG_IGN);
@@ -1586,12 +1635,18 @@ static int patch_update_file(struct add_p_state *s,
 		if (ch == 'y') {
 			hunk->use = USE_HUNK;
 soft_increment:
-			hunk_index = undecided_next < 0 ?
-				file_diff->hunk_nr : undecided_next;
+			if (skip_what_now) {
+				hunk_index = inc_mod(hunk_index, file_diff->hunk_nr);
+				skip_what_now = 0;
+			} else
+				hunk_index = undecided_next < 0 ?
+					file_diff->hunk_nr : undecided_next;
 		} else if (ch == 'n') {
 			hunk->use = SKIP_HUNK;
 			goto soft_increment;
 		} else if (ch == 'a') {
+			if (skip_what_now)
+				skip_what_now = 0;
 			if (file_diff->hunk_nr) {
 				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
 					hunk = file_diff->hunk + hunk_index;
@@ -1604,6 +1659,8 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 			}
 		} else if (ch == 'd') {
+			if (skip_what_now)
+				skip_what_now = 0;
 			if (file_diff->hunk_nr) {
 				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
 					hunk = file_diff->hunk + hunk_index;
@@ -1616,6 +1673,8 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = SKIP_HUNK;
 			}
 		} else if (ch == 'q') {
+			if (skip_what_now)
+				skip_what_now = 0;
 			quit = 1;
 			break;
 		} else if (s->answer.buf[0] == 'K') {
-- 
2.39.5 (Apple Git-154)

