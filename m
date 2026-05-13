Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7183B19B1
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707157; cv=none; b=V+t2WQRgjWXAH4hDDu9waLMZSz2wHrERUFErGxMswuEejAnmMBezJMeDvlhDbxXwOAXbk/hFTBUV8mpJHSdX4FDbSe14VSbuJ1XUTAhiovUcHyEkvwTmCZThdYUKDie3EEDLOt9IS+U0yzMTFXqgbKjo+zq422gvgDmGoEhPlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707157; c=relaxed/simple;
	bh=jB/u8bxJkoIcP+/WyLomci346rqELlXb+Vx1/80XTsU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sQbcdHscEovFjQmpe/9lBzlLSTPOiX4BRNLg8VRedfn6AjKWM6Yl8gxDED2/MYR+rnP4/lQiWBJ2h64Sq3fYwh0K3iHBdEs5BZYHV4M4yLsn6qe3pEVRpwlvCU8g02nCMcjIsgtSMu+0UDszwC32kgJaZIBiWWayGeCUjl6wras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mywQfK+h; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mywQfK+h"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1332772f6b3so5690060c88.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707154; x=1779311954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn3rVoXV53v5GWPH6gU+qjfohIi9VOou4SkzzSlEiLw=;
        b=mywQfK+hH6uirXDLg1euQ6iqh7lFm6ghIPKgx8Sb+c3cSLHJqyqHOnvUwfxT4Derot
         /YrLOhTuxCcsaGNaUaC2+ZmNQK/iRLGM7bh4sR4LQU5cgTgiUGLuPNYfuh7paHz6Cc8p
         7l/sPhyXJGqC30ff/4Jjn7cUkhkgRDe30OUPjkFM+L0pZlVPMh1AnlShyhxHkvmhY3xF
         aozMO9UqBpgm+3Kmr7K0P2cZZ/qzxkuWCmwkYEu6n2NKWmLgWIO8H7EEC2yfg4ElIwxg
         u9RjGGf87GT2vgqWy6Nw48rKVT7wAD8++p2KYwAP7Wzt3es96doL4X0omwkyCMCTFZ/G
         lnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707154; x=1779311954;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zn3rVoXV53v5GWPH6gU+qjfohIi9VOou4SkzzSlEiLw=;
        b=l8HGvloh+6tHDYdwDqv+SKpmlOsMFl/nPj8CZ2IGeA/br/BVv4WYTCyg8etjsm4Wd3
         YWkBux5s/PcAVDTofjE+Qc3KpgmHnfMtG2I+N9s8l9wX4cDhLmkRWnlsFGHWxdJMUbUU
         jULbd1FI8JU2xQGBOhiA3FEzf9F+YaFiL5bvESG99QtDh4tSP97gtXmQ8HkxPP7beV6w
         GgaYhkXsKtYyRhXw8hJMISMOUt6IpRXgbuKoZ1ApILu7K0dIkwTw5izJrWxmBnOiQciD
         Qxzg/ocOUFZchSMe4Fsp3mUxVQh5805aReg+ZP4hXGQxhQiPkEaa+qEH6uwv6+FL1Nyb
         aREQ==
X-Gm-Message-State: AOJu0YzOWsU9c7Mdlj4XTX4hpP8YO3MmqLG23GW8xHmu3lAjVduUqS0z
	jfs68FxkWmRDZpmO55UbzTF0+1LxnLw0AE0ir8EjOfIenGEetcYIau0PBZ17a0zg
X-Gm-Gg: Acq92OH08FhvGxPfH6hWXa+RhBKbRKZvFteQO6v7PKfDD9UgIumBPHR+E7esD4a4Av5
	aTp//Ypr1IPg3Pwftiyb0EbIFQwQooyHlVnkjsUDL1YskmGcRa0EDq8wA4j0oz/yis8BK0bTdww
	rThlbDDpP5hcdL6FfBTYiRDM/a8pQoCmTLDj/sIewEMNWY3KsqYeRAMGuqA1Zfovh3RwiFN404/
	LqzHqi2fbuJeOdnCrKa6B/+8WBTSz0ixLqd5HcvMLmMevo0c9o8JpWt7NO21QSKmwNl3tP3uk4i
	vG4dqB8I9Z3JG3ZZkpOEQ9CuczYxiNdOMKB9JKkgwK/YnvogCGQBJl1y+TeKJ7kvT4O/iy7Ft2g
	MSxk0TeDWZ9zhzylP5WCRK5hsSTFADglAEFnF/FyUiH7rNLyR0rQeH79oi6sDEe+nkCSVatJN5X
	eguVXLmPOs8ekOxeyjflGLhwqlZg==
X-Received: by 2002:a05:7022:43a8:b0:128:cf5c:535a with SMTP id a92af1059eb24-1343677c776mr2749123c88.11.1778707154346;
        Wed, 13 May 2026 14:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm1111030c88.3.2026.05.13.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:13 -0700 (PDT)
Message-Id: <0b1eed07907270668713df5094c2198f6b2e600f.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:52 +0000
Subject: [PATCH v4 10/13] t6601: tag otherwise-unreachable trees
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

