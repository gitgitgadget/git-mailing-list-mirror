Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04E230270
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622294; cv=none; b=mYoGKrLOQ0pDmN6Sp4Jd0At+UX9xFj+XK5S4oB7LKXN10SgKlHkSPw9F0FvjxpHSXjz5kP1IEmL4VPP8sohikC5V4edTzyRfFaEIoEGS11m9Yq/0FPHm4/KYY9HeyJRD9pxWsvQUfKoyl18lO5TJGrZTV3QzurgqO+05yy8hrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622294; c=relaxed/simple;
	bh=/Uf3aHnLbDv42g2MTgkrtC1GGEhQ/Dsgf138tTZHzG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GddIZ86pJU+RixCIRdr7EX7sxE7Uqj9hX+bU6vny+ucThwgMOS0VGNZYHPxKry9yqBhaiXkA7hRyEjEO4JGhzremf2Cnu/887M/RKDP408CuXQfpOhQX5Pcpjq9nu+U4NqXQxO6jpKMcdYbMP9HJ5GZpm/8RXmT7Q6RZOjwpUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAQ6RFRT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAQ6RFRT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3694022f8f.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622290; x=1742227090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3dU7xfOIjfpxs3SqWqvwYL7CEzDmAwL515cgL/3PU=;
        b=WAQ6RFRTEIT9Z7UBVZKt+CN7eY5wV4exfCBVev6KkUha4P54JEjTfAkOf3XQTGoFHk
         Uz1MzFJaTWYOqDuNGT4guN8FAEljPTqJrTiiVBH2w2C5PONTeMG72OFWwiM2RLjHBOQj
         ZuBD/ZVWTauq5iFSKWLdDUTMMaeoBkyaaoUw8XdjNeqwe5Qe0roPIEkivFNysSE5EWpv
         CWHZlG2kNJM46YYRtRcHJNiUB9ly5XzWkOS2S9dYgTls4Z0kQeYrMZEgOdM6ovgSCMzX
         88FL4YfQ8DztsmqOlhTawTciw3zzxCm8NGFwT9ZbsOJ03VnmIdDGeCqGufg+ZLrHpV1q
         6z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622290; x=1742227090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F3dU7xfOIjfpxs3SqWqvwYL7CEzDmAwL515cgL/3PU=;
        b=edr/zFf1SCGwSp7EVTsDRktJLGMtYEd9p1xfSN3c7rBaEg55QG/f0pqMhfLH5CoL1q
         Z/OhxnPpY9iCCTfgqVkG5HvTahnAjUNJ7d4Zvv7YUoJlmtNiVyTJ771nXAe9xUjby2aH
         R2y3Lg9KbeLbEbOtYyO+L7ufi2PU/RDmA4JLP00HuQobpPmPPsmde2OudVQ2Uf+Lwr+d
         bJgSZm93sOITji1+Sg22LmbJhNa31ck0XvUxNWdeBTSC2Pg7iyZnYRFJpSR8mtWLylYy
         2ffU20rOBy9bqBlQTYie6ERgqG/WYGpGgF+cPemwp6ac+Ld4QPTXsRFchPW9JiApMkDb
         WDkw==
X-Gm-Message-State: AOJu0YyrpMn2IMtehiw/CncFIrtaUseV+oltnA+3/LqHZFmxeTfrRjja
	IMZCLpZtLD9pw4ZF39I8vAzo+aqLMxfgSR/35uzxdLGn/olIRpPiQBi13Q==
X-Gm-Gg: ASbGncvmQiPJzpTpNECTBuqn7o695bZ6CWlHPZCcQSQuJJFWUNqvn+heXj/88Rv5b4z
	tfw4TQ6uz9feadmc/9SOzNSQ2sgugMm4xFrTE6SXq03tB7BN4k5Z7EbMgwsC8qpS6pUAo/stQMT
	z9VaPdleJftAyHCtOzllKCcsJqm/yGOs9olWPnvOcfCYXeYEguvpDQN7PPuOL+SkDIrMrR0PUt6
	hXHR00vuo92mVFUh2/4HH//uMRgsMCZq5A5EIKIfm8z0RJJdXtB35QzPlM2jM2BosEfLk8lX1oq
	PRKoMErqsNuteHt4CY3JGWcJs8HymcwTvtLWzb5i0P2BAULzIZ5eGsJvOavkQiQ1HSqRB+P9sBr
	/Ku4BYPOdWSJzw+9tD4JfAlU+2FA=
X-Google-Smtp-Source: AGHT+IHhP+LFnlLUTS9WxQVucxZ0OHQcShxKxtXYldMm5FkkQRmoPZkbwAxQVXl8wdIGY00gptFy1w==
X-Received: by 2002:adf:a31d:0:b0:391:38a5:efa with SMTP id ffacd0b85a97d-39138a51108mr5947978f8f.23.1741622289059;
        Mon, 10 Mar 2025 08:58:09 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/6] fast-export: do not modify memory from get_commit_buffer
Date: Mon, 10 Mar 2025 16:57:45 +0100
Message-ID: <20250310155746.879481-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

fast-export's helper function find_encoding() takes a `const char *`, but
modifies that memory despite the `const`.  Ultimately, this memory came
from get_commit_buffer(), and you're not supposed to modify the memory
that you get from get_commit_buffer().

So, get rid of find_encoding() in favor of commit.h:find_commit_header(),
which gives back a string length, rather than mutating the memory to
insert a '\0' terminator.

Because find_commit_header() detects the "\n\n" string that separates the
headers and the commit message, move the call to be above the
`message = strstr(..., "\n\n")` call.  This helps readability, and allows
for the value of `encoding` to be used for a better value of "..." so that
the same memory doesn't need to be checked twice.  Introduce a
`commit_buffer_cursor` variable to avoid writing an awkward
`encoding ? encoding + encoding_len : committer_end` expression.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 61 +++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2de2adc30e..39d43c2a29 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -510,21 +510,6 @@ static void show_filemodify(struct diff_queue_struct *q,
 	}
 }
 
-static const char *find_encoding(const char *begin, const char *end)
-{
-	const char *needle = "\nencoding ";
-	char *bol, *eol;
-
-	bol = memmem(begin, end ? end - begin : strlen(begin),
-		     needle, strlen(needle));
-	if (!bol)
-		return NULL;
-	bol += strlen(needle);
-	eol = strchrnul(bol, '\n');
-	*eol = '\0';
-	return bol;
-}
-
 static char *anonymize_ref_component(void)
 {
 	static int counter;
@@ -630,9 +615,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  struct string_list *paths_of_changed_objects)
 {
 	int saved_output_format = rev->diffopt.output_format;
-	const char *commit_buffer;
+	const char *commit_buffer, *commit_buffer_cursor;
 	const char *author, *author_end, *committer, *committer_end;
-	const char *encoding, *message;
+	const char *encoding = NULL;
+	size_t encoding_len;
+	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
 	const char *refname;
@@ -641,21 +628,35 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	commit_buffer = repo_get_commit_buffer(the_repository, commit, NULL);
-	author = strstr(commit_buffer, "\nauthor ");
+	commit_buffer_cursor = commit_buffer = repo_get_commit_buffer(the_repository, commit, NULL);
+
+	author = strstr(commit_buffer_cursor, "\nauthor ");
 	if (!author)
 		die("could not find author in commit %s",
 		    oid_to_hex(&commit->object.oid));
 	author++;
-	author_end = strchrnul(author, '\n');
-	committer = strstr(author_end, "\ncommitter ");
+	commit_buffer_cursor = author_end = strchrnul(author, '\n');
+
+	committer = strstr(commit_buffer_cursor, "\ncommitter ");
 	if (!committer)
 		die("could not find committer in commit %s",
 		    oid_to_hex(&commit->object.oid));
 	committer++;
-	committer_end = strchrnul(committer, '\n');
-	message = strstr(committer_end, "\n\n");
-	encoding = find_encoding(committer_end, message);
+	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
+
+	/*
+	 * find_commit_header() gets a `+ 1` because
+	 * commit_buffer_cursor points at the trailing "\n" at the end
+	 * of the previous line, but find_commit_header() wants a
+	 * pointer to the beginning of the next line.
+	 */
+	if (*commit_buffer_cursor == '\n') {
+		encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
+		if (encoding)
+			commit_buffer_cursor = encoding + encoding_len;
+	}
+
+	message = strstr(commit_buffer_cursor, "\n\n");
 	if (message)
 		message += 2;
 
@@ -694,16 +695,20 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (anonymize) {
 		reencoded = anonymize_commit_message();
 	} else if (encoding) {
+		char *buf;
 		switch (reencode_mode) {
 		case REENCODE_YES:
-			reencoded = reencode_string(message, "UTF-8", encoding);
+			buf = xstrfmt("%.*s", (int)encoding_len, encoding);
+			reencoded = reencode_string(message, "UTF-8", buf);
+			free(buf);
 			break;
 		case REENCODE_NO:
 			break;
 		case REENCODE_ABORT:
-			die("Encountered commit-specific encoding %s in commit "
+			die("Encountered commit-specific encoding %.*s in commit "
 			    "%s; use --reencode=[yes|no] to handle it",
-			    encoding, oid_to_hex(&commit->object.oid));
+			    (int)encoding_len, encoding,
+			    oid_to_hex(&commit->object.oid));
 		}
 	}
 	if (!commit->parents)
@@ -715,7 +720,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
 	if (!reencoded && encoding)
-		printf("encoding %s\n", encoding);
+		printf("encoding %.*s\n", (int)encoding_len, encoding);
 	printf("data %u\n%s",
 	       (unsigned)(reencoded
 			  ? strlen(reencoded) : message
-- 
2.49.0.rc1.89.g148d1db992

