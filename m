Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0C1885B8
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407294; cv=none; b=mvtkaSYFSYQoqwMxcUKPcCQFi0Qx/WzEvZH4ePrN0VBgWd0xvl0Is7Zzx59CY9OeIQdmpgXHMqFulE5HxIeaJQvc+B8BETpgR0FvtRNDY9nUjQCm2AfvnlWKoJan1JZM4rOweFLrfrFIxLgfvCgRqa6rVv2N+l2/O10LctD3Nwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407294; c=relaxed/simple;
	bh=6OMdrepwjPxUEk3/zNn8RFPSlad9No9Z0ISR4Ic51Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDuq3AzNhN97DlfDDwE8hXnbHK44F3/rU+cZp4BxzRWGEJ6Ur9/qM4lrYjf+Y3kozI+GM9TkM2JI9KUD8b156AWQhmcjI2Dz89kdtixOAbHR9ibLXViq00IDnxnqmHtMicQIC03xKyW3hTTRJ1xLL54XrkNeX4YK3lE61k9fpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGHU6eWE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGHU6eWE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43998deed24so42673095e9.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407290; x=1741012090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ioiaz2miZBMCGjkMW32fo9Ji+huLQbe65DiQ8ielns=;
        b=TGHU6eWE2/RwiGYZUX/95gMRNqqJx92+scG+0+L8kGitbkrBgS4kqfVH7GcObKM1wI
         CcegeCLKgoEgQz3zp5bz65vL5nr55aiPoRhnmUrvCFxb7QlTzDUhjX01Wb53QYYXFVSC
         iKaI5IRqOjsH0/tVYfpE4dHGW5H++2G4DmL5oHgsC1IzkyZOXpVwDlCnQv/QoE1SjuuL
         NlcBzPu4j+ZbOJXDzyfyDl24+LEzEju8rzzVF7iyVhf0j/sLE9Tz87xgeXjmu7hUaF53
         l95zqKR/KSLYKRxKPb0EMetaOLUD3/JC5RRSN9owli7+LfTybBlbfl0ZP21nkbHX7b/F
         wV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407290; x=1741012090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ioiaz2miZBMCGjkMW32fo9Ji+huLQbe65DiQ8ielns=;
        b=biN39ZmJt82fHwkmGzAmNvmELADmtuekvvI2gPszqK/u3Ie9LVQssJd4WdMQ8vJklt
         44MpXk6YopkJY2bo7SRhdOH85HwDceIsYzU38TLrYyaPd2l2EPTCp/jaresH7KthxJZ1
         w5drPcn5GW+Le0dRQOmPRrdBItqqdOX7c0V87YZTDZIjrsS4RaZbbCzCG34A9kHu6Nxe
         6sS1lNEeklMAbZM/cqqXy5SA0N1C8wAEMVfX1F6tPAqg15zJPHIzS2B6m5YCVUck4ho3
         wBEP+PBbBT4BOTjWLOCq2Cz0c1NBRKpE0VyeYE/38FLXKE0BhJ17gicAy2w/1GIgypta
         b0vA==
X-Gm-Message-State: AOJu0YzOWzhwNCpbKl4JVY3e2dnDdEDX2val+/7S2YwXBO3CwwElhjm8
	EPhGP9XF3aGJtBwXY6Gfb8pehpmFmL0fxYZ7DUu4842ypKHm5kh9PbUSFQ==
X-Gm-Gg: ASbGncucXqyuTQPWAXwN1UjWSZs4fu6CxFKiCecfKZxsND4gd/N5FiQsX6TmF2qqxAF
	HidEObykrT3lhMVmH4FT95IYL266KCiTP2+88h54c7uHnl/h6Wt6Bdlhr2tyBuFeNgCl4OQb8Tq
	qMOSReYrba3Di/KfpHmQ9BRuhGmHybYTJoma9N4O+YtNLjz0szBlg58hYkV36agN8AGuGxPP6pj
	U1vgXu5B680z0vsAwHf17KpkFWCaZgBrXrQWprOdrmzjLyVz+Q/5zfoeypD359Zub3RjMqLPK29
	AlWPzIiqBKfQsg5KQ7G2+j7PDrz3n3sCYWPYTKkJebYfQsXXa7N7RV+WtHiH
X-Google-Smtp-Source: AGHT+IEwtDq4Hfutbk3QpOPN8He2s3HdZNQNbo8MZKogJv2GCNUuq/Xtpu7fxmvljNZSjhgwp4bqww==
X-Received: by 2002:a05:6000:1541:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f70825febmr10479557f8f.42.1740407289785;
        Mon, 24 Feb 2025 06:28:09 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:08 -0800 (PST)
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
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/6] fast-export: do not modify memory from get_commit_buffer
Date: Mon, 24 Feb 2025 15:27:43 +0100
Message-ID: <20250224142744.279643-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
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
2.48.1.401.g48e0d4203c

