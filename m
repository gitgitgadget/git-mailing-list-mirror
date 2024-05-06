Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FF15B11C
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025468; cv=none; b=IeMPs+6aFWZnCQSi9g2P20GwCcg88yYGYNnwN002zB0cLXVOCftHFI4Fbg1pg8XOXwEQsacR8sIerHjX6lTuXPNCkkJ2Y6X46OOiE7n9APL+4ZPVY1sWCgPgFYw14hHFasiBjeDnXKBKbwNs/0iimMZ2d2CoUYG32xyBf1VAJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025468; c=relaxed/simple;
	bh=eQNBRzpwi9Q80F5M2qevhCm5xqKSdviDYAvMTxBeg9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJ1Fwr3Tpj9DH0aVwxiOWUmV2GCNbX34HA9SpGQ3t8dXdyFZKf0lZ7KCzUH69o3ns+uLNUoJiNPiYPiDgEE3zptd3h0YuD1uQQYLIdE/i20gDE0bN6ylOqQJAtCCuzL6LTNbH9RJYhy8AR9saIHXldjPQ25EemP5LNLkaoDegt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNLDa21M; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNLDa21M"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de603db5d6aso5294138276.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025466; x=1715630266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbAr47xneUW6J1uzpOQp3hKuBIpPm/xQmnkQPf/MfVY=;
        b=lNLDa21MLNsZkiPpvTUc/zpDuKs1rXyqhYgQ/Ygkfai/01fJS6te7NrStCVZD1QtqA
         WEO3qgfhOZTNTb5GgI5lBeU2FKArcwWSfXseatdjZVfLnJDKFWIfas8C71zQWgPnqVhi
         zaBM9pQyKvqihuxMEWRHbA0D+G0sOttBwIrHs6uSgoyaM6tXZwSkm4j1NL672To28RpR
         WLqJvs9lSwjKFMY9dFEVdLT9AoZvsLJP7lYNHsNk42S4difksAQs+EWe7uEP9EwrNClF
         rjAEdWKHp2+6JJbMDY1uWh55CSnsLcb8Ja+AVC1FOO1H48QP3xkegQ3toWIB2ZrefyqV
         9W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025466; x=1715630266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbAr47xneUW6J1uzpOQp3hKuBIpPm/xQmnkQPf/MfVY=;
        b=vQC3GKqfxXJYoPuXjqRUQ3fpTu8Gm/01raqa5XUoXYZgFSjlUsenlZ0PT5KVNklbLu
         KIOhYZtb+11UnlPc+AnNIeD1hYn1T5vesYjO5JQZsTWhviFIoDPVj1UwUPB0QidLzYAt
         QOQlQSedJkbDHe4y4NvOBTgqlRZeXXzZ8esttrdvRlt9VwS/DV8D9kKpFPEXXbPmUP9Q
         O0QIaRB+F0seM5JG00kAjojbFBwrYKVIZhR7Ypimh6k+fGeZKdJuBeIXbsbxrnKvq2d4
         3OssjR+jL6mq8MbcIYUtqpv0iJ1muuIE0bXpyzK0usgWpozxTqzut4osMKYhXfV9KWK1
         6Osw==
X-Gm-Message-State: AOJu0YwbNWhOxnoCnbwbvwbe/e2XkDQZA+zzLr6FHebBHDibc4fUDQrU
	VzhLPX+AM14JKXywZC9xM4lgQAsIA2Bphw69g1QMPD0LPdyMkZtUz1yeWosscoXHzE23SwNGi7a
	zUPAPS4ahE7v0HuQVmSVW163mC90LL0RwyOfoe++zRYYVAl8IPKkD1U2J+ZytTDOWCvMmafyMbd
	R94pQH96i2AeGN1BKCSSPi+eVXsuJsjjLl1adHmps=
X-Google-Smtp-Source: AGHT+IGOMOWvkUac69NLnnkJj54d0L6f+bBC+OSyhxEpIWCiIp7Q1JKDqxmOMN1dtEZT+w+WkSic7lHGQsswYw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a05:6902:c05:b0:de5:2694:45ba with SMTP
 id fs5-20020a0569020c0500b00de5269445bamr3791232ybb.0.1715025466162; Mon, 06
 May 2024 12:57:46 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:34 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <abc9a7afe8c1ab92bfbd2b9eea672bdd9ff3c107.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 4/7] test-tool run-command testsuite: support unit tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Teach the testsuite runner in `test-tool run-command testsuite` how to
run unit tests: if TEST_SHELL_PATH is not set, run the programs directly
from CWD, rather than defaulting to "sh" as an interpreter.

With this change, you can now use test-tool to run the unit tests:
$ make
$ cd t/unit-tests/bin
$ ../../helper/test-tool run-command testsuite

This should be helpful on Windows to allow running tests without
requiring Perl (for `prove`), as discussed in [1] and [2].

This again breaks backwards compatibility, as it is now required to set
TEST_SHELL_PATH properly for executing shell scripts, but again, as
noted in [2], there are no longer any such invocations in our codebase.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/helper/test-run-command.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index e6bd792274..61eb1175fe 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -158,6 +158,8 @@ static int testsuite(int argc, const char **argv)
 		.task_finished = test_finished,
 		.data = &suite,
 	};
+	struct strbuf progpath = STRBUF_INIT;
+	size_t path_prefix_len;
 
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -165,9 +167,13 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs <= 0)
 		max_jobs = online_cpus();
 
+	/*
+	 * If we run without a shell, execute the programs directly from CWD.
+	 */
 	suite.shell_path = getenv("TEST_SHELL_PATH");
 	if (!suite.shell_path)
-		suite.shell_path = "sh";
+		strbuf_addstr(&progpath, "./");
+	path_prefix_len = progpath.len;
 
 	dir = opendir(".");
 	if (!dir)
@@ -180,13 +186,17 @@ static int testsuite(int argc, const char **argv)
 
 		/* No pattern: match all */
 		if (!argc) {
-			string_list_append(&suite.tests, p);
+			strbuf_setlen(&progpath, path_prefix_len);
+			strbuf_addstr(&progpath, p);
+			string_list_append(&suite.tests, progpath.buf);
 			continue;
 		}
 
 		for (i = 0; i < argc; i++)
 			if (!wildmatch(argv[i], p, 0)) {
-				string_list_append(&suite.tests, p);
+				strbuf_setlen(&progpath, path_prefix_len);
+				strbuf_addstr(&progpath, p);
+				string_list_append(&suite.tests, progpath.buf);
 				break;
 			}
 	}
@@ -213,6 +223,7 @@ static int testsuite(int argc, const char **argv)
 
 	string_list_clear(&suite.tests, 0);
 	string_list_clear(&suite.failed, 0);
+	strbuf_release(&progpath);
 
 	return ret;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

