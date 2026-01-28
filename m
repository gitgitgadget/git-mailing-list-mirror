Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5830BBBC
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616459; cv=none; b=LyNdpfJY+RSrr2Cqhj9r6KH+vHXaW1RjBr5c7hIr/tq7tLw8KcbrCAqhuPWguBmi9jMiAPAYSI0X/xx5/NnYdHdbBMup5hu8gzS7k2/6AJNxcxa/9rGJLbSfGxYIao7A5zY65/2NCaG0lyC+9iUHWZV2J0MpXBWckeuM8Sgi7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616459; c=relaxed/simple;
	bh=FZAmOyz2aKqQ21x/VmeuRp2YHd71JwDdDd6j25GAhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKAvj+ECfUtu7O21AgT2ssA7mfM48MiAHxWY07DIcBTYcTPMNCSYiogAm5SlNNIKc8dDl1g4ZN1fbZKw50nmPtoMMEuweIEgpETFhWUg9sFlv4k4e+TJVU2bWl/Nxew+G+TLdzWVHgzlLfQfh5kIvylnW8Joj/KZ2/R25QNfVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcmZbK79; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcmZbK79"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f39693db5so559943b3a.2
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769616456; x=1770221256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUplcW6J8kivkKekRPFyGKca6WRIx7SvSvDyG/5zztA=;
        b=AcmZbK79VWfS29oggPp/giAfVjF08WcZEMANWsEQrJmOBhX5G6/KiDq8D6CfCyDxgI
         8cfml6U3QWxTfr1kf5ez2SRB+cmaZRYyr2dJDaHJQzzMeT7gPOqrpuKtxjn5xrpVvM9z
         60A68LvRg7FwxPfUMuIzCZpT2hG7Vso0VNuz0dI9d4ZmCkHtyTRS7FxZwLVIMQtEgGHx
         Xq4VwAtGsW5hOFbJLuVNyVxVud2yIn6QxB/+jYtlefjuloz7B10VXcd8+PQmJTYEe2kA
         Zd4Ig04vnCpgl16oKBcYiRZs3xuL/DrLoubnj2uDeX3CUS4Cyo66L383DNayVbNUk61Q
         DBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616456; x=1770221256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUplcW6J8kivkKekRPFyGKca6WRIx7SvSvDyG/5zztA=;
        b=jpoKB9GSDN5goXG6ETRqtlsm/VcRz3Yfg58TpxoE8kxUvpAzBjN43TiagB7aF+qnqe
         gcPaTrt3uMMS80RIBmyl51VmcGuRYK2SKGiL0qj/fi05Mm1RdI45uWqf4S2ExjERZiw8
         369R1avBYxQQ2dTF8jF3+V1NlhZuTTVHQVpQxRC6jRzERj8eBjzsEuUzyCAeek/ncryU
         vS8JUF9B86PQJKxzOdjUhdA8/RTOHevuLLepzr5tljmsaPyazoR5qi1ZnBLexiSbp3WM
         yXcHAwJl5IYMSPXU6J2IQFdK33F/D886fEcyIL5ajXYPDDKhQ0BZ4oYsr7qVQCr9qDAC
         oQaQ==
X-Gm-Message-State: AOJu0Yye51XKBA/yDBMQulEPIWaw0z42MKGLoCg9fo1hIl/OCi4np1MT
	0if6IQByV/ehxiFpJOcMmcSj3jsetC+4fsVs5fJUA9myljkiPpsJlFgGU7Ss15JD
X-Gm-Gg: AZuq6aLoJh4N7Sl0pdEcm9qPz3lZndtV0NagY5Yh70DHm/WsfYuMqIWQ6EZ+az6HsnS
	W4U9e38ty4QjwLk87M9gtjUAczYQMWLhhe+p2TdXoC2LkkRB9yvNBG3+9gu2so/dbQ9JivUxywV
	p7LDoKGkDKedG9ouSR/7sgYB3HlR21UpOUBUAZ5jT27X2EPbH0hLVDHGYs1UmjbmUncmrAldLvf
	IWEBYmtvR4YDYBDOUQ2G7KCNW+H7cHguQD2klgL5RPYqbD94g8L7WbxSzce1/vlDPkk74nkJCRs
	Q4XaK5mkYIR2CD+nl23CrG9+3SQMlzd+B844VTP7BBYrSbxF4AE7tUcogCYHPaERwI7fTOlOmpF
	rTZnZWXzA1eiBGo/9snDRvTBtZKm/KHFQ6Z8U3vFoKlWh9tfp4ItWW8FNqyMDdLeWqBmp+Nz9Gf
	gjxCiuXYxJO1NelQMN5BxH22NKAVQ=
X-Received: by 2002:a05:6a00:39a9:b0:81f:4546:cdff with SMTP id d2e1a72fcca58-8238fa3cb25mr352285b3a.3.1769616455946;
        Wed, 28 Jan 2026 08:07:35 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c2261esm2925736b3a.52.2026.01.28.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:07:35 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] t/perf/p3400: speed up setup using fast-import
Date: Thu, 29 Jan 2026 00:07:17 +0800
Message-ID: <20260128160717.611391-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126165618.596944-1-a3205153416@gmail.com>
References: <20260126165618.596944-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup phase in 't/perf/p3400-rebase.sh' generates 100 commits to
simulate a noisy history. It currently uses a shell loop that invokes
'git add', 'git commit', 'test_seq', and 'sort' in each iteration.
This incurs significant overhead due to repeated process spawning.

Optimize the setup by using 'git fast-import' to generate the commit
history in a single stream. Additionally, pre-compute the forward and
reversed file contents to avoid repetitive execution of 'seq' and 'sort'.

To ensure the test measures rebase performance against a consistent
object layout (rather than the suboptimal pack/loose objects created
by the raw import), perform a full repack (`git repack -a -d`) at the
end of the setup.

This reduces the setup time significantly while maintaining the validity
of the subsequent performance tests.

Performance enhancement:
          Real         Rebase
  Before: 29.045s      13.34s
  After:  22.231s      12.78s

Measured on Lenovo Yoga 2020, Ubuntu 24.04.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---

Changes since v1:
- Added 'git repack -a -d' at the end of the setup phase.
- This fixes a performance regression observed in the subsequent rebase
  test, ensuring the object layout is normalized before testing.
- Updated setup timing in the commit message to reflect the repack overhead.

 t/perf/p3400-rebase.sh | 54 +++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index e6b0277729..9f4251aed6 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -9,25 +9,47 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -B base &&
 	git checkout -B to-rebase &&
 	git checkout -B upstream &&
-	for i in $(test_seq 100)
-	do
-		# simulate huge diffs
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i unrelated-file$i &&
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 | sort -nr >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i-reverse unrelated-file$i ||
-		return 1
-	done &&
+
+	test_seq 1000 >content_fwd &&
+	test_seq 1000 | sort -nr >content_rev &&
+
+	(
+		for i in $(test_seq 100)
+		do
+			echo "commit refs/heads/upstream" &&
+			echo "committer WGYDY <author@mock.com> $i +0000" &&
+			echo "data <<EOF" &&
+			echo "commit$i" &&
+			echo "EOF" &&
+			
+			if test "$i" = 1; then
+				echo "from refs/heads/upstream^0"
+			fi &&
+
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_fwd &&
+			echo "EOF" &&
+
+			echo "commit refs/heads/upstream" &&
+			echo "committer WGYDY <author@mock.com> $i +0000" &&
+			echo "data <<EOF" &&
+			echo "commit$i-reversed" &&
+			echo "EOF" &&
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_rev &&
+			echo "EOF" || return 1
+		done
+	) | git fast-import &&
+
+	git repack -a -d &&
+	git checkout -f upstream &&
 	git checkout to-rebase &&
 	test_commit our-patch interesting-file
 '
-
 test_perf 'rebase on top of a lot of unrelated changes' '
 	git rebase --onto upstream HEAD^ &&
 	git rebase --onto base HEAD^
-- 
2.43.0

