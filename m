Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58B378D78
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474292; cv=none; b=oWRajPtD+T8zbZABKkWJgT7wYf68rwb+7dd8ybeQzTQ0w5mbc3hkcS9dD1RiGJoCSbtPbyzxuY3gma3kEXExDwghtQb359AqWYu5lixNhgGLkzkWTmdR+3zE9wttHxd+I40Ve7FytsNzU1X1VTaJh07wXcheBrI74fsZdRxY3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474292; c=relaxed/simple;
	bh=jB/u8bxJkoIcP+/WyLomci346rqELlXb+Vx1/80XTsU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pPBLXIHiojZn7bYLe4mZLaTP7h1uLeriQgLyXApshfHysW9guC7piYKmfMIr+vzIwaf29sE54LMPJVrxjpV+wdmXgd+tkmFcdmmV/U4BRggLalU/9XP8L9EGMQ6SK6jSyi8uW4xPVkH7Fp3mAGnM6KGWw/U1n9gIM+9OHPpEu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Mogmk7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Mogmk7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b4000e51fdso82250296d6.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474290; x=1780079090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn3rVoXV53v5GWPH6gU+qjfohIi9VOou4SkzzSlEiLw=;
        b=l3Mogmk7NkGbeYI0PaCnxJpYJ9ZnVNp8uBDuLQszpNVS96ODYE4Pobw6qNRpm95kgs
         7AC/Lrrg+Qy4qw4WKmCS1nzUZGzJvGflAmYYzvxVi8ojpN2THqm71UdPy4GDg2PyfAgT
         JThqFyYG0vaMd6d1XJdAT7sow/Yp6DIgggOFQKqmr7y5SbKXEm1aKYRn/h8E32waKAVU
         S9YG+MtoMjZXYlyG3scO7dfRYW+f/iyFYylxKrnLgI5KYTuAe31jKTk8+1v33Au2IR4Y
         6FcGO9G+QFNqIuALdS/wcKD9N79R6zDNC7NKEMNtiYNwV/8TMHHef4N/GVugpSfA0k7G
         g7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474290; x=1780079090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zn3rVoXV53v5GWPH6gU+qjfohIi9VOou4SkzzSlEiLw=;
        b=UEji3b68iUxyBVSV5fxIDiw2/QGETl80Hx73xbIWGabeVCecSDVbI4VqKGvIOi/LW9
         LuXYcw9z4+D1uufqi+W6B21KTxQVUpkQZGk2hxSvjghqDqYD7PGiFE8hwCg6Qt8IqXSn
         kgjKHJcn58KerQiUaJHYCdygMxysE/Ew0OEyj2VfyoBAdDY4yDKdIMrs/BIL21ZcAyI1
         1RU8tWotrMVY3+dN3yftIryqK85rTx08hyRcTLo8lf5zE/5FnFiN45X4QjFtNKjvMzbW
         02GUORFQUUrnbwP8pHMI0Ko9lWGv64wwOoXSwnUujO2LTXMhABMN0hEp3p5aG0Z42U7/
         5deg==
X-Gm-Message-State: AOJu0Yyh+CCkYf+O1LCt38ydTILZ8VL0cf+PsJfMxoCmhkuzXDxiFAAk
	X0dPE5PU3REHrGiF0intKGjbWBz378ckrTsgT0tSeJHT33uPvOtuCwvEgA3lHGUF
X-Gm-Gg: Acq92OFwv5l0A9Y9K447ksh7+pF+q8/VVbPf371agGg2bK/HVm8ofza9+S7lfT7qz6+
	e0rvu8hAJcGOvkOh0SATFTAO9R4OS5TqFH6P9B5KNhxhMozub4P3O45gvSSynS1buY5/N0t2o6i
	cc3oqG88UrAmu4T9LQGKpq9T2BTNa9MzqyJpej3O08QIITRN8Z60FlZksOuVipKAukw/d2u4ceG
	dv9IDNPztSK2ALQxTlkg+6rbfi/MoW7gk378l6wUU7HPqQVuE2vxsvOfgZipemWFDrKTlX7vcBi
	YBchRkguC+TV+IsYSJ5QsjpHbKN4GLxUf4Uk9LRI4GfoPIPOKGD2XaQaSOQbgxe8yfBibP41JKz
	riWNRy06LwU2qLK/jJkmRHlGQO896MiiQ31OXMJk8+mJSmCyV8IOTRyk2fXqi5fFJTHEj80S0ai
	0WkrsGe/4ytg2BKrcGkBipr7GU1so=
X-Received: by 2002:a05:6214:3d8f:b0:89c:806c:93 with SMTP id 6a1803df08f44-8cc7b675a18mr72429116d6.30.1779474290280;
        Fri, 22 May 2026 11:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ded7a9sm27699206d6.19.2026.05.22.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:49 -0700 (PDT)
Message-Id: <a68676d0de4e941602dbed8840df783b7392ea6a.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:34 +0000
Subject: [PATCH v5 10/13] t6601: tag otherwise-unreachable trees
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The tests in t6601-path-walk.sh demonstrate the behavior of the
path-walk API under different conditions. One thing that I noticed while
updating the behavior of directly-requested objects is that we don't
actually emit tagged trees. This was previously not noticed due to those
tagged trees actually being reachable from commits that we are including
in the path-walk.

Update the test setup to have tree-tag and tree-tag2 point to trees that
are otherwise unreachable.

It is worth noting that this does not meaningfully change any of the
other test cases, demontrating the bug.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t6601-path-walk.sh | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index ac294867a5..92c524d145 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -7,17 +7,15 @@ test_description='direct path-walk API tests'
 test_expect_success 'setup test repository' '
 	git checkout -b base &&
 
-	# Make some objects that will only be reachable
-	# via non-commit tags.
-	mkdir child &&
-	echo file >child/file &&
-	git add child &&
-	git commit -m "will abandon" &&
-	git tag -a -m "tree" tree-tag HEAD^{tree} &&
-	echo file2 >file2 &&
-	git add file2 &&
-	git commit --amend -m "will abandon" &&
-	git tag tree-tag2 HEAD^{tree} &&
+	# Create tree objects that are only reachable via tags,
+	# not from any commit in the history.
+	child_blob_oid=$(echo "child blob content" | git hash-object -t blob -w --stdin) &&
+	child_tree_oid=$(printf "100644 blob %s\tfile\n" "$child_blob_oid" | git mktree) &&
+	tree_tag_oid=$(printf "040000 tree %s\tchild\n" "$child_tree_oid" | git mktree) &&
+	git tag -a -m "tree" tree-tag "$tree_tag_oid" &&
+	file2_blob_oid=$(echo "tagged tree file2" | git hash-object -t blob -w --stdin) &&
+	tree_tag2_oid=$(printf "040000 tree %s\tchild\n100644 blob %s\tfile2\n" "$child_tree_oid" "$file2_blob_oid" | git mktree) &&
+	git tag tree-tag2 "$tree_tag2_oid" &&
 
 	echo blob >file &&
 	blob_oid=$(git hash-object -t blob -w --stdin <file) &&
@@ -26,7 +24,7 @@ test_expect_success 'setup test repository' '
 	blob2_oid=$(git hash-object -t blob -w --stdin <file2) &&
 	git tag blob-tag2 "$blob2_oid" &&
 
-	rm -fr child file file2 &&
+	rm -fr file file2 &&
 
 	mkdir left &&
 	mkdir right &&
@@ -34,7 +32,7 @@ test_expect_success 'setup test repository' '
 	echo b >left/b &&
 	echo c >right/c &&
 	git add . &&
-	git commit --amend -m "first" &&
+	git commit -m "first" &&
 	git tag -m "first" first HEAD &&
 
 	echo d >right/d &&
-- 
gitgitgadget

