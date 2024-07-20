Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFD1E502
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491328; cv=none; b=a5PDXoC7yOnmbfsMWThuPtC+OfKAh8QrIyzjCIEuAoKbvGBIJy0xqg5TRhBKanP5a4tvyiLQ6qmTF8omFD5G557g9AVTOHhCH7IJL747WdVsw38f3IAGiP2YhNPWxpRsnhTE46wnaMzFIsFs6/3Su1hi6vyfRDV6b+8BGykdLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491328; c=relaxed/simple;
	bh=3Zbb5H+IUJVXRB7jU1K2M78y/HH5BfOY4pasOivDnjo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MtF4g2/L41GZa3Xj5SLxbktQvP/knP52WDvq2k2tPKHzXtQ2jDtbX3MQV253SwNE2Qj3bcgIb48kVqi3e+HUPdYOpUqOdPPTI5IZy3fTUX6olYlzcDTTctjKUs+Pfdh3uePjJt14nRZhizy/v5J4DREvJ0aF6LAkuZX3eHA4ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me8f82Zq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me8f82Zq"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so36535901fa.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721491325; x=1722096125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTpePuwPS09EDc+EhZPO7bdloD+hfzdeJPMlvWdxeyU=;
        b=me8f82Zqn8YK3R7ZnPFVh8smmHKEghRDu8e5kVw7xXNmhTk0+KIp+05R5kfrMnDCL7
         O6+NtTdpjZJ3H3DfJKEGNWEeywTLLNLmHMVaz1wXObCi/e2HZtHFhHIjaVcCzetvArdb
         28Ni08LhOC2RR004h25l5rpBSjVmuKBc3Hp+IM5URFR5CwSD6FtKMfZYvCRMAONajZ65
         tqgLAc+T/KTNSMJVBOys2aXVxITx5fMJjgHqAwlael6/WE+cpkSrs+eI3Knm1spfi6bC
         LiILmVjm67tERqiU5cqxHRjmfCQY4Nme+UYwfktsvG7e23quiu3RX2TGgiKygwr9g21h
         +C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721491325; x=1722096125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTpePuwPS09EDc+EhZPO7bdloD+hfzdeJPMlvWdxeyU=;
        b=XMMfDYBRmbFFL7zyIdev669eQGLMsSMeGY0aO4pTxv5SkaLUi9qT3eC68f6BcmrTDz
         4sho2/2eHc76DCRI/QK+W8cpxqi8g//dqPS7wnMfkluEm5EGS1kb5v1KIgZfjPwgqL2Q
         Ox0lCE7A6+nMpnXZb2+p2z+22S02o5Ab1CuM+ZqnKHsh+aJ3YANKsBBUhECBhMROSNEx
         YUfXYFQMj9vN/e0vNJCJmU98C0NkcbDnRLP46W+WhOGSwNzwJRUreNitzCblk90KecxW
         k/G/FcW/OpGrp40Yjy63XLpZry+URkraNoewYWZK/7bRP2udHuSvDkJiOctTQe2pYVAi
         0WdA==
X-Gm-Message-State: AOJu0Yzz04d52llt2tsGvhOTuXWNE1H9ErUWL+P3a+BP5WFZ7IhfjJen
	jfoJ7A2W9iynh/odhhQ1OUT88uKMhuWKpPFp/WmyTSFd8xPGQXhz4aJnNQ==
X-Google-Smtp-Source: AGHT+IHA7jds5/144Z5jRvHeVM6jeNz9A/BPqykgjwJD0lO7v7PKPkwfohYUmMVTq7owj67jWSWizQ==
X-Received: by 2002:a2e:8ec9:0:b0:2ef:2658:98f2 with SMTP id 38308e7fff4ca-2ef265899ebmr4787801fa.33.1721491324614;
        Sat, 20 Jul 2024 09:02:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b763sm89204965e9.10.2024.07.20.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 09:02:03 -0700 (PDT)
Message-Id: <34d8fd44a97efd5a36003823f7db853291a2543c.1721491320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>
References: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
	<pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 16:01:59 +0000
Subject: [PATCH v2 1/2] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "add -p" parses diffs, it looks for context lines starting with a
single space. But when diff.suppressBlankEmpty is in effect, an empty
context line will omit the space, giving us a true empty line. This
confuses the parser, which is unable to split based on such a line.

It's tempting to say that we should just make sure that we generate a
diff without that option.  However, although we do not parse hunks that
the user has manually edited with parse_diff() we do allow the user
to split such hunks. As POSIX calls the decision of whether to print the
space here "implementation-defined" we need to handle edited hunks where
empty context lines omit the space.

So let's handle both cases: a context line either starts with a space or
consists of a totally empty line by normalizing the first character to a
space when we parse them. Normalizing the first character rather than
changing the code to check for a space or newline will hopefully future
proof against introducing similar bugs if the code is changed.

Reported-by: Ilya Tumaykin <itumaykin@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                | 19 +++++++++++++------
 t/t3701-add-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index d8ea05ff108..8feb719483f 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -400,6 +400,12 @@ static void complete_file(char marker, struct hunk *hunk)
 		hunk->splittable_into++;
 }
 
+/* Empty context lines may omit the leading ' ' */
+static int normalize_marker(const char *p)
+{
+	return p[0] == '\n' || (p[0] == '\r' && p[1] == '\n') ? ' ' : p[0];
+}
+
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
@@ -485,6 +491,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
 		const char *deleted = NULL, *mode_change = NULL;
+		char ch = normalize_marker(p);
 
 		if (!eol)
 			eol = pend;
@@ -532,7 +539,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			 * Start counting into how many hunks this one can be
 			 * split
 			 */
-			marker = *p;
+			marker = ch;
 		} else if (hunk == &file_diff->head &&
 			   starts_with(p, "new file")) {
 			file_diff->added = 1;
@@ -586,10 +593,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);
 
-		if ((marker == '-' || marker == '+') && *p == ' ')
+		if ((marker == '-' || marker == '+') && ch == ' ')
 			hunk->splittable_into++;
-		if (marker && *p != '\\')
-			marker = *p;
+		if (marker && ch != '\\')
+			marker = ch;
 
 		p = eol == pend ? pend : eol + 1;
 		hunk->end = p - plain->buf;
@@ -813,7 +820,7 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
 					    (int)(hunk->end - hunk->start),
 					    plain + hunk->start);
 
-				if (plain[overlap_end] != ' ')
+				if (normalize_marker(&plain[overlap_end]) != ' ')
 					return error(_("expected context line "
 						       "#%d in\n%.*s"),
 						     (int)(j + 1),
@@ -953,7 +960,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 	context_line_count = 0;
 
 	while (splittable_into > 1) {
-		ch = s->plain.buf[current];
+		ch = normalize_marker(&s->plain.buf[current]);
 
 		if (!ch)
 			BUG("buffer overrun while splitting hunks");
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac16..9a48933cecf 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1164,4 +1164,23 @@ test_expect_success 'reset -p with unmerged files' '
 	test_must_be_empty staged
 '
 
+test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
+	test_config diff.suppressBlankEmpty true &&
+	write_script fake-editor.sh <<-\EOF &&
+	tr F G <"$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+
+	test_write_lines a b "" c d  "" e f "" >file &&
+	git add file &&
+	test_write_lines A b "" c D  "" e F "" >file &&
+	(
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+		test_write_lines s n y e q | git add -p file
+	) &&
+	git cat-file blob :file >actual &&
+	test_write_lines a b "" c D "" e G "" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

