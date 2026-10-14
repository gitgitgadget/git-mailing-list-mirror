Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126163E024B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998708; cv=none; b=Cd50QC2wbFG7DcQe9Mzj1ecz/YdZ+lr71SlhcAdrkrkZDD4KZi6AJyfM3J1ynLZWYmzFwS7wZKS6uowwONqtLDdG6GaRL+Y9QVFponXofoBggUTBg9pMNcv1WIS7WMGF4JbiMdw/puHHc1Tn++ePr6rUBdY0TxJhCipB42jeBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998708; c=relaxed/simple;
	bh=NcQa0pXlPGN/yrxYIcIPL4416s/PKYggwFIDqZ12ZEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jr8zS/rEqJBRgUgjeQMK+ydC9OoSTbSJOieVCowa6RuXTQZy/D+6u72u2dt0j/VPmYtp1x+KVFlXtQk66kIsdZZGYG2EjRqNvy3ysC1EDd/2MbaZIO0MzodxT/ivdCybl05qT47+GpPVggvVu6SVwDZEsaECiOJJfXInR4V9hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2ecZvBp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ecZvBp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b042c0759so3297312f8f.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791998705; x=1792603505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ExqWh9eWv6TicI092moE7SX2IVhbVL/RSB62YgyrWFs=;
        b=k2ecZvBpfGXXjNpXXba3Vj6p4eFcaM2QKDyF7231JtsN/FXpDOyDJlYCbCSODrktF6
         xV+3ZjCwRLGcR5Y76SE7tvTBuacY6yz5yaCf2TDCtIv/1XU0FQDEvOPN/e66Jda3Ffz3
         kclXd8RqFLPq48z7sJ3cM+EskelyD9Q6cZR0+cWCO9qEQZpr1zZlRG4w3jW8pc4fRIeh
         8Kn0Gw1BK84PDv9EAq3Iog/I3H1htdrbzb5D+giZCF5Sz7Ob/EB9VknCf3Xj0v5R8ZwF
         y8RbAdNG1DVEk8spkbl4tDmvRWC8Kgul5toNrXmsoAX2H9Sal5qjFJizLJUB5nPgqRrd
         9gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791998705; x=1792603505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExqWh9eWv6TicI092moE7SX2IVhbVL/RSB62YgyrWFs=;
        b=HIK8UUmUR0cTqMcxEulwBZg2VeuPBOL/GyIv1wRekiSI3+Sg78oG8sFf0/AXkUZah0
         Ln+pw9XfhTGWhnRaG1qCHkgzRNzKwtsO7J/3pLttWDqeGAOxO6hCKPH2TCUrQhEojX5C
         zpXEe/PFIgwL5SMMMWOPxol3rZIJlzrcpvJNqwtqYH7DmPDqVYZ8hC+GrwCrmvsdWeJ4
         w+UiVMT70uRncGeIn0bVaKS1Q+fpblmZ7qIJzdwTZhWm0HXBGWXmC0KJdOD7+wstY0mj
         EwvdptTXNtHovks3DUS92UgqaoFvECiaW32BV0KI1xgEbtJSXRVd4Sarq/P3KHmwppDk
         vw3g==
X-Gm-Message-State: AFq9FYIxbeMBXc+ooBPL79boNNTD+tgnMDOLQcOWP0pVnzJrm8Utt33/
	j/7tRM4YmyNEDF1Ysl7dN09ua7iMNozcY4bGV18oD3+vSx18T8DHNo7vZdUWVHhJruQ=
X-Gm-Gg: AYBFou39Yy+AQgUQKqkRRqCGofJCgqhDBgbGnIAt9q6RTlae7TG5YvLuHBWWxzQxakZ
	yPA2oLyZ6oCHDSG6OuIuxtGm99tzvIBS1XL9idTdKDNUuE/2FIN0svz82Y6JbOadFXRz4tBGHr0
	Ei6eeb03EP4sFBJRQzxoi+hDLBrvZ9708c+4yVLmdSaVOZQR7Tug0k9sEnVFxFWbYeAlGpqhR3i
	e1ZhuFsfrq8/pfyWNr0kNbCXE/CqmM+8XMgSb1iVkZUUdqWIrDEPBM5Oo6SQ3v5dLWyZA7+AOX3
	NAfhBc7T+L6h7UJXdCImWP/NOS9FLmJM2W0XSaHc5VbMNS+gywEnu3NQgxvTQ+dwZPvtDmlh3vy
	TGWUQsGqglA66Jbk4J/vVQUnjmZ90J+7DmV6YrfQgRtJzJY906zgzLMAvzEZhDLxL5fophE0HNq
	vtBNGEQKkyXI12+1N+/KkhaMCJmsSvW+MHmizB+iJZDyMJHvsuo978++U0LA0Su789mSfCoz+z+
	MAXpEHSzlKyX8cPkdNlqNqQPaq3yn8auYHrkmJGIUblklufMusqOV4R
X-Received: by 2002:a05:6000:4a14:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48dbaadb081mr31235053f8f.18.1791998704979;
        Wed, 14 Oct 2026 10:25:04 -0700 (PDT)
Received: from u.ad.analog.com (dynamic-078-054-209-001.78.54.pool.telefonica.de. [78.54.209.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm13658916f8f.47.2026.10.14.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:25:04 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] pretty: fix lost indent after newline in %w()
Date: Wed, 14 Oct 2026 18:23:33 +0100
Message-ID: <20261014172333.2224123-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When strbuf_add_wrapped_text() meets a newline followed by a
non-alphanumeric character, it treats it as a hard line break and jumps
to the new_line label. That code was written for the case where a line
gets too long. It moves past the space where the line was broken by
setting the next line's start to 'space + isspace(*space)'.

After a hard line break, 'space' already points to the first character
of the next line. If that character is whitespace, it was wrongly
skipped, so the line lost one column of indentation. For example,

  git log --format="%w(11) This is%n  the %s%n  commit."

printed " the ..." and " commit." rather than "  the ..." and
"  commit.".

Fix this by skipping the space only in the line-too-long case. In the
double-newline case, skip the second newline explicitly, because that
case relied on the old skipping.

Add a test for this, and update the expected output of the "magical
wrapping directives" test in t4205. There, %+d emits a newline followed
by " (tag: ...)", and that leading space is no longer lost. With a wrap
width of 1, the space now causes an extra line break.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 t/t4202-log.sh                | 6 ++++++
 t/t4205-log-pretty-formats.sh | 2 +-
 utf8.c                        | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 06552a6271..5895780e8f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -94,6 +94,12 @@ test_expect_success 'format %w(,1,2)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format %w(11)' '
+
+	git log -2 --format="%w(11) This is%n  the %s%n  commit." > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 $(git rev-parse --short :/sixth  ) sixth
 $(git rev-parse --short :/fifth  ) fifth
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..0733f22d58 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1139,7 +1139,7 @@ test_expect_success 'log --pretty with invalid padding format' '
 test_expect_success 'log --pretty with magical wrapping directives' '
 	commit_id=$(git commit-tree HEAD^{tree} -m "describe me") &&
 	git tag describe-me $commit_id &&
-	printf "\n(tag:\ndescribe-me)%%+w(2)" >expect &&
+	printf "\n\n(tag:\ndescribe-me)%%+w(2)" >expect &&
 	git log -1 --pretty="format:%w(1)%+d%+w(2)" $commit_id >actual &&
 	test_cmp expect actual
 '
diff --git a/utf8.c b/utf8.c
index 96460cc414..bb55bf357f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -322,6 +322,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 					space++;
 					if (*space == '\n') {
 						strbuf_addch(buf, '\n');
+						space++;
 						goto new_line;
 					}
 					else if (!isalnum(*space))
@@ -333,9 +334,10 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 				text++;
 			}
 			else {
+				space += isspace(*space);
 new_line:
 				strbuf_addch(buf, '\n');
-				text = bol = space + isspace(*space);
+				text = bol = space;
 				space = NULL;
 				w = indent = indent2;
 			}
-- 
2.56.0

