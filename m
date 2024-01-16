Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C922630
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443785; cv=none; b=M5oLnEkm4w1cFvSQDt9NFg6m2/C1O4EqvkKlUo8JVu/S2flZaPnl2D/xuACtKoyDMQOGXx5mAsCWZ3GC2LWjqh7cNEs/iEwGZwd0uMNE28iHYSBXhauJSqRQhmE1VaGqGtRI5HbaeHYsNRJkC911bJjl2hfoKEJ+lO8CbXLbl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443785; c=relaxed/simple;
	bh=sQcpduz2ohlFOzk6n3tf2kNaEc9393Fom1ReZRnwhbQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=YZnnBuPaoU+FuWfUsYDhuqHB3hgPJvQRz43fBPrNV03058YZ64zx5gjGc0/r8GBdaB3xqdpbLZO4zgsKLcZWomNJkht1oNNCxcFi0XdQGsUSWdtFce9frz9r3QkDvW3GmONDbU4eE3nCBS2Frn5dPs/zyNq7TUG8WEmS5lHhTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGfQqsUy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGfQqsUy"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc22d60a466so1076082276.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705443783; x=1706048583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mo28G8pjf3AuSduqksMfja8nNdiMjYsPIiEB6RQoTgQ=;
        b=EGfQqsUyFsUUn6NAdxxVf8Z5bpiv8EAL9PvL/SCOjDvuc8Y3T/YSucW3Q/5jZD1F1f
         W9W+yOJagltbU+6qg14912zOkJckCEwpg2LQoZqnDcOUT6K0Zq1hI5LkFX2+tWeczkQt
         /q6L1u5HRcjgmHxLIRTe7z55OsDCp/07xAtd/YVzBWMxlgLTL6PkIA59uQ8c8UyCzcU9
         UYBXPPkdrarshp6rVvqOHwX/UdnxHclaAGOYRnxkHKqtzfgPIk0T3pUJPFSYcD+puvJZ
         lKL2NGxPue+RtoGJoc30DfnsCT5VxB8zQJ0DwRLuHGSBtWj136gGKWmUWIoZOv34m+2g
         bTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443783; x=1706048583;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mo28G8pjf3AuSduqksMfja8nNdiMjYsPIiEB6RQoTgQ=;
        b=WsXBd5rEXxYTHG47e7kl9hroGg80AgTZe/Ip0FNk16VZFxHJE3MjaZiJ+74O2ESsL2
         O6IOLPtAYZDGSqlyOwYml70F3Mp8fetpkUC6SjaT6aIyTmhxT7Fi3/woX0Qe3wQcHBeB
         XeuJzM2A4yzLT+uZZiOzp5loP+2X/ACYGS2Qux9dXCDwklXUFn5qJ9qzx4AcZXd1MzKV
         fi+7Fw9nbTqYD+z8V82v/YcXMWr7ifkKkrF3lDH7TLn3HudGXfDHsY1jNcPeDakGaVqR
         MckMLVzgNpWRl8urGdskTr4nczm/jlIBwWIPop6ffZHwYle3G2NmD7iSZEU36UblATFO
         kZgw==
X-Gm-Message-State: AOJu0Yz7gs4sPlD2speallSlEBHcQh8zg6p/yNR8TgPR1IHB4lbk6VQ+
	DozLMVX1u0eWAtlSLFmOKZjj/eFIkJgceL7mwVnwF73MllXZvJesaPkm9OJAa7zZHtwf2euz3Pa
	PYovf9WdgocuXF4N/C+9mgsqECFcKTAgMZoNqZnscpmAh41ylkldj7hB43RiyNhI2sPKU4A==
X-Google-Smtp-Source: AGHT+IHSj9GcgaLVm740aS6GhE0GOUYjLzhhrgXIZxTSWtqQpYc4+BNVf9qHvD3XQLNlVKvCxx6X6dAQwwpCfQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
 (user=steadmon job=sendgmr) by 2002:a25:20d7:0:b0:dbe:d5b3:89dc with SMTP id
 g206-20020a2520d7000000b00dbed5b389dcmr2882716ybg.0.1705443783441; Tue, 16
 Jan 2024 14:23:03 -0800 (PST)
Date: Tue, 16 Jan 2024 14:22:57 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <cover.1705443632.git.steadmon@google.com>
Subject: [RFC PATCH 0/4] test-tool: add unit test suite runner
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

For various reasons (see discussion at [1]) we would like an alternative
to `prove` for running test suites (including the unit tests) on
Windows.

This series extends the existing `test-tool run-command testsuite` to
support running unit tests. In addition, it includes some small
cleanups: we move t-basic out of the unit-tests directory, and add a
test wrapper script to allow unit tests and the shell test suite to run
in a single `prove` process.

Some known remaining bits of work:
* We need to filter out cmake *.pdb files when running with `test-tool`.
* We should investigate switching the Windows CI to use `test-tool`
  instead of prove.
* We should determine whether it is confusing or otherwise harmful to
  people's workflow to have the unit tests run in parallel with shell
  tests when using prove as the default test target.

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/


Jeff King (1):
  t/Makefile: run unit tests alongside shell tests

Josh Steadmon (3):
  t0080: turn t-basic unit test into a helper
  test-tool run-command testsuite: support unit tests
  unit tests: add rule for running with test-tool

 Makefile                          | 19 +++++++++++----
 t/Makefile                        | 13 +++++++---
 t/helper/test-run-command.c       | 40 ++++++++++++++++++++++++-------
 t/run-test.sh                     | 13 ++++++++++
 t/t0080-unit-test-output.sh       | 24 +++++++++----------
 t/t0080/.gitignore                |  1 +
 t/{unit-tests => t0080}/t-basic.c |  2 +-
 7 files changed, 83 insertions(+), 29 deletions(-)
 create mode 100755 t/run-test.sh
 create mode 100644 t/t0080/.gitignore
 rename t/{unit-tests => t0080}/t-basic.c (98%)


base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
-- 
2.43.0.381.gb435a96ce8-goog

