Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF82F5474
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496512; cv=pass; b=dvG+8hfNowMl0vAkd8L1rS56Nt+Ah/OfftKiE961dph6cmNQdQVEsRAQ5GyDwL5tnjP28xHMv6UofhP6yFaT+k3xjCnK1oNvVmF2IIC4wsV6S4Rc86Qn486R+VeQwtpSvNSPRSZjpn7g9vyvNjWnclgiZKW76wt8XCGIX7y1iU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496512; c=relaxed/simple;
	bh=vc1WXsay3Ut+aTsoMeD4/rRZjsGaLYFKg9rA0CnciJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llVwZx9LTB4SNji+MS+x/UINYDTVV0vV70FPv7mMDUq61p9F3eBrSRogH83/5m9PSQAP/6dzusc4KirdZ3PJhJ17mQPBME0QbOH7vqbyD5way/dz9Z1BylJmXPPRHMQbnKeh3Lh2IwuPfL1rXiF3zFdqg2YU9K7qYMJlGt5LPHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GP1rzaMB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GP1rzaMB"
ARC-Seal: i=1; a=rsa-sha256; t=1766496501; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=afLsFm5OmZ4zilS3QPPVE3o9VGXJlr045AN591vfic66v5GWxtEuqJHqmlB5kxtkDj2Ja1YdrUcotboZFwsqQI3CM8UPW/okxHT4ucGwMFEVC1Jc9W8JLJc2mrX0wzI/dBMpfu4vi2T4wrrwraK9Yvboe7/gOaH9hxeZTH5feR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766496501; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O76tEy+w2kbTW+3GDomgqXD4zBGiRSwdQZP6SPubwi0=; 
	b=fjjk4auKk6R5fWgPtbGvI9HTwCHNMq5VmigSqUQSIvASw9ceFy0YOJjUyAS49yaNlE6mopBSN6UIowbgHYSHgndyuH7w9H/L1/Z1iTNBXwBFp+lgFfTizo0/R7Uv3c71QSVJVK/x1lPYyLOoOi0lS6O0pwOsHocaBWu26RnIDgo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766496501;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O76tEy+w2kbTW+3GDomgqXD4zBGiRSwdQZP6SPubwi0=;
	b=GP1rzaMBak7UOAeXt1aObqV38KzO2XvYk5sLky+3EQUzN0nmssderfGsIvdUlSvA
	uTwVHreYgdI5vOs5Il2OITsv0kELHP9OQnXkBpUjkkJr5TnOXFZIOHlp6fzsapaaQ3/
	tcCYvG2ntf62p25O43LzhPsomBOXVPXyfUPuLdIU=
Received: by mx.zohomail.com with SMTPS id 1766496499755882.7131347277146;
	Tue, 23 Dec 2025 05:28:19 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH] ws: add new tab-between-non-ws check
Date: Tue, 23 Dec 2025 15:27:56 +0200
Message-ID: <20251223132756.604036-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a new check to detect HT in the middle of sentences that
should have been a SP, as suggested by Junio in
https://public-inbox.org/git/xmqqy0mwsedz.fsf@gitster.g/

The check is a bit complex because we want to detect places where
a SP was intended and the naive before/after character check can
issue false positives in cases like "a\tb".

The new check is enabled for Documentation/**/*.adoc, where these
kinds of mistakes were seen in practice.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
This is based on the latest master branch.
Pushed to GitHub: https://github.com/10ne1/git/tree/dev/aratiu/whitespace-new-test-v1
CI run: https://github.com/10ne1/git/actions/runs/20457905508
---
 .gitattributes             |  2 +-
 t/t4015-diff-whitespace.sh | 56 ++++++++++++++++++++++++++++++++++++++
 ws.c                       | 32 ++++++++++++++++++++++
 ws.h                       |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 700743c3f5..d3c40a038b 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -7,7 +7,7 @@
 *.py text eol=lf diff=python
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.adoc text eol=lf whitespace=trail,space,incomplete
+/Documentation/**/*.adoc text eol=lf whitespace=trail,space,incomplete,tab-between-non-ws
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3c8eb02e4f..afe95f5209 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2440,4 +2440,60 @@ test_expect_success 'combine --ignore-blank-lines with --function-context 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
+	git config core.whitespace "-tab-between-non-ws" &&
+	printf "1234567\tb" >x &&
+	git add x &&
+	git diff --cached --check
+'
+
+test_expect_success 'check tab between non-whitespace at tab stop (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "1234567\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check
+'
+
+test_expect_success 'check tab between non-whitespace not at tab stop (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "a\tb" >x &&
+	git add x &&
+	git diff --cached --check
+'
+
+test_expect_success 'check tab between non-whitespace with tabwidth=4 (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=4" &&
+	printf "123\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check
+'
+
+test_expect_success 'check tab between non-whitespace with tabwidth=4 (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=4" &&
+	printf "1234\tb" >x &&
+	git add x &&
+	git diff --cached --check
+'
+
+test_expect_success 'check multiple tabs with one error (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "a\t1234567\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check
+'
+
+test_expect_success 'check tab at beginning of line (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "\ta" >x &&
+	git add x &&
+	git diff --cached --check
+'
+
+test_expect_success 'check tab at end of line(tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,-trailing-space,tabwidth=8" &&
+	printf "a\t" >x &&
+	git add x &&
+	git diff --cached --check
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 6cc2466c0c..fcd81250ad 100644
--- a/ws.c
+++ b/ws.c
@@ -26,6 +26,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "tab-between-non-ws", WS_TAB_BETWEEN_NON_WS, 0 },
 	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
 };
 
@@ -140,6 +141,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "tab in indent");
 	}
+	if (ws & WS_TAB_BETWEEN_NON_WS) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "tab between non-whitespace characters");
+	}
 	if (ws & WS_INCOMPLETE_LINE) {
 		if (err.len)
 			strbuf_addstr(&err, ", ");
@@ -228,6 +234,32 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		written = i;
 	}
 
+	if (ws_rule & WS_TAB_BETWEEN_NON_WS) {
+		/*
+		 * A tab surrounded by non-whitespace characters is a typo candidate
+		 * (a space might have been intended). This checks for a tab that
+		 * would be expanded to a single space, which is when it appears at
+		 * a column that is one less than a multiple of the tabwidth.
+		 */
+		int col = 0;
+		int tabwidth = ws_tab_width(ws_rule);
+
+		if (!tabwidth)
+			BUG("a known tabwidth is required by WS_TAB_BETWEEN_NON_WS");
+
+		for (i = 0; i < len; i++) {
+			if (line[i] == '\t') {
+				if (i > 0 && i < len - 1 &&
+				    !isspace(line[i - 1]) && !isspace(line[i + 1]) &&
+				    (col % tabwidth) == (tabwidth - 1))
+					result |= WS_TAB_BETWEEN_NON_WS;
+				col += tabwidth - (col % tabwidth);
+			} else {
+				col++;
+			}
+		}
+	}
+
 	if (stream) {
 		/*
 		 * Now the rest of the line starts at "written".
diff --git a/ws.h b/ws.h
index 06d5cb73f8..35475fd320 100644
--- a/ws.h
+++ b/ws.h
@@ -16,6 +16,7 @@ struct strbuf;
 #define WS_BLANK_AT_EOF         (1<<10)
 #define WS_TAB_IN_INDENT        (1<<11)
 #define WS_INCOMPLETE_LINE      (1<<12)
+#define WS_TAB_BETWEEN_NON_WS   (1<<13)
 
 #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-- 
2.51.2

