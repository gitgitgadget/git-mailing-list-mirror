Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F333B6ED
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013446; cv=none; b=hTsKEQvg6bywpy3DZHgzLFgUUOAFdeVnTIRuXDwuzK8CWwY16iCJUjRlIWk2resoCqSQzAsIwVQNYSNfM/cIq3JvE/vAxZTHwLC1H2jkeM9IDlW3tsnh8DzF17E0YUfdA/rl99vjdQHBYnIMrkA+jxTE57thY/aaWPblVnbCOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013446; c=relaxed/simple;
	bh=0SBHmrvulXjRpId6VuFu7u6fGR0z9EsppE3JpQfF5jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoY58TLqOvW6mrmXIC1WIrxBarNRHENkxyhOVehkLGYECMuQug/jzU0NpREe/CAomi0q14OWvK522D6R838oFOmSpjCqWQtTEMvh0Mz+dKt7gLunfgT7Ap/VlZTgDTyWg32DcahOP3lfVj5WmUfZEg+S2W8T5AsyMVrzkJAdUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+1KdQYU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+1KdQYU"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so594655b3a.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013445; x=1784618245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlltPJPqa9nOL/8JLLrHt4QxYEuE5aP5Ml2KldsnLts=;
        b=o+1KdQYUMwsYaZyYbIwaQXL30Vuaq8de9cQhI5zc7U0gzRbBtexqOwifC1y5oNANHp
         8c5Vw7VXvmypAqxP7bpLZvmMpQS5aybvstiLrC6FOvehH1l/CcI5KWfqaGrmmbktM1Sc
         sgyARDBo5wf6D6Z6dsMYOTK/B1OZMSsIHmsg/APSmW1lgTd2p1/ooRpHfHqCdVKqr2N6
         TYFLsiBtbi3EVhBgFt22iWu7A/o0pshMMAyLHDYZw8OsLNjChwGRJKOzPL3AZjYpTKkl
         uFQfKcwPOpds8eVIewmW1EjXwlzlIMv9DTOQlVKkVazxDm5k1lzI13Uwj3It5W8z1TJx
         feXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013445; x=1784618245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlltPJPqa9nOL/8JLLrHt4QxYEuE5aP5Ml2KldsnLts=;
        b=WhdytvxUeIGSqyyT3yEZzDvNcJwrRZDa6bZ1VGiolJktifyro2TzfYv3Uuecc0N1HB
         xJ+P/Gm8ymg2IhyxExnEHj2YaQy0ac2S1CdNydVlkqjFNz5HRtvQI4mhxTZw2NlA5W5n
         aLR1ehKsQnQ5ikKxTUm4a7TmM7EyrHW0SxSwSlvUrCMvURVEp8NCKkRW45xwc7/uuB0Y
         rFwNg+nIhT8cJ8czV89g9UpHZ1NMATUXjCEXpBsyAyAXKcPi9Up9jcAClk0t8I2VT+Od
         HUZl+VYD1pUT9HydGgYJzS4BseqQrYW9vDbhJ4WtBodgQya2+IPc3hg7+prllbrow/ni
         K93A==
X-Gm-Message-State: AOJu0Yx2f10WFujbMCVywxWetqSajHmnEN2Bsai93WIUVR5XZpJjs/OO
	JkvbsJRi4N0jBRDopQtjxNyE+ADW4LhnoCla5gWfeQVZm0vKj3jsZS9UMbeuLWu9
X-Gm-Gg: AfdE7cnAdpvhds4XztKaGn97r/oK3RicJADDrOkc0/u9pgnsM0elcmUllpAGMhQDGnc
	EJE4Jmqw7dqadqX2Pgjszw+U3upjlYy/SOxEUH8nAhnceq0/hUjxY7TZ0X59UYUHGe26SrJeZEJ
	nkGMkGYedo9uGTkBYed08bnat5w3McB8wLCdqtiX55P7VGeQ3AjZAPp8Yn0s4PQ3Q1QYJ7HwiY3
	DFLFZppUBTGxGxYPjvIswLz4hOg3cqiAY8YgJLWNqFnu9Rti/1xks7Wuym8R66sN71Px5LQQgE9
	qI5GeSxDTgvT1Kl80hv7WfGLNH1AI+7t8aFK94RBsJCooioukrDdoiKQl+/z17Uy50+6oAhBlLE
	0vphXg8eslvHUs68gjFU1GZ43gN8I1Ah0faIz2grmnguS1FgJt1Ke/fHgea6ATX4bJ/6iybThcf
	iZ2XCexZ0YV0itnAIG90sMlBYA7urKY+FIC0GYo7AT9dmPjeC0kho6B3zG/lQ=
X-Received: by 2002:a05:6a21:9d91:b0:3b3:241f:66c6 with SMTP id adf61e73a8af0-3c1108c1a5fmr11620880637.26.1784013445000;
        Tue, 14 Jul 2026 00:17:25 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm83465759eec.19.2026.07.14.00.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 00:17:24 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 2/2] t1100: move creation of expected output into setup test
Date: Tue, 14 Jul 2026 12:46:33 +0530
Message-ID: <20260714071633.35446-3-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714071633.35446-1-diy2903@gmail.com>
References: <20260713140142.27898-1-diy2903@gmail.com>
 <20260714071633.35446-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "expected" file is created at the top-level of the script, outside
of any test. Code that runs outside of a test is not protected by the
test harness: a failure there is not reported as a test failure and is
easy to miss.

Move the here-doc that creates "expected" into the existing setup test
("test preparation: write empty tree"), using a "<<-" here-doc so its
body can be indented along with the rest of the test.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index fabe5a97cb..b434d1848e 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -14,15 +14,14 @@ Also make sure that command line parser understands the normal
 
 . ./test-lib.sh
 
-cat >expected <<EOF
-tree $EMPTY_TREE
-author Author Name <author@email> 1117148400 +0000
-committer Committer Name <committer@email> 1117150200 +0000
-
-comment text
-EOF
-
 test_expect_success 'test preparation: write empty tree' '
+	cat >expected <<-EOF &&
+	tree $EMPTY_TREE
+	author Author Name <author@email> 1117148400 +0000
+	committer Committer Name <committer@email> 1117150200 +0000
+
+	comment text
+	EOF
 	git write-tree >treeid
 '
 
-- 
2.52.0

