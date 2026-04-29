Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADFC26D4C3
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459029; cv=none; b=peOwTq4bRWEW+dFy5IHfiwTML+tBwqjmUcN8MjjAI9aiFKCA+DfFdKixwDpZb4GGy0bqkzntDma8eXPaGyOzDUnnkvLflHcK/gznciopMmpgBYQCgdCsED7B9cvb2GM/e5ATXePkh8HHTkrI/Wj3AQcYDLFGDgRPhIlY8rQnUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459029; c=relaxed/simple;
	bh=8lT57voDOyljFa4Cb2HJf5sCa2Ec2R8v9CENYhB8VW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkUq3LD0NxwzPV00eDivVq+TEXNpd1E30AH/8sAefnyAXrV7IRlexxbTiAt2p3QP9V8V0kEZHjvJGmW38srQnX5bEbritdZertL4DIm+FESsQgOWYwAs9xgDQdtdR//7zEKyeJtxYlABxBiVSQCPMKAUHman8j9f34Absk494KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0UspWvH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0UspWvH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe62837baso7149088f8f.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 03:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777459026; x=1778063826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yekHkE2IXASaBgGSbH0OgVCSRk/3NSVFps4uKNyWkz4=;
        b=l0UspWvHBhW9L+M8i/U2BIrDJdK9ifnDyOjPxKwmiRRqX8KvOoqPOxO9l0TmN8PGUB
         PPO59cGRIxRPga6ev0TZaA/YhlokuT0r+mH5ra+BUauJ3mQBSF+a2wcJ5r1ZPd4PvCYi
         V8/LzcI0R5ggSlGgT93fVzgC8k/BH1yjB5MEpdjiYjHCUFPVISy8WTSXi9EvEbbqULh1
         eCSYPqmRI8+xaY8gaumwpzDoYwaa1azFCCGjvEKGrReZbgji6f1KKDIXP5o9sg8dptMh
         uDWKV8UplD2RmEyM2DcYA4zVe3vtGomZ7tPeSPSsBbtP3eKAIQY3JcbnqS2wGc/y4DqS
         VXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459026; x=1778063826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yekHkE2IXASaBgGSbH0OgVCSRk/3NSVFps4uKNyWkz4=;
        b=gt7ii51OFQyG7fEkfVrrVQPBdFU/y2meTrwUz1ouuC7QLryjGQRif1yRCDxhmI4klk
         e6hrxAeTvVIro0C0C9MU7epD+2kX7FFDpYtJviQBQ77kk9BncPnMLxHBnF04VOuZKyNB
         si7YjLA/LJATiRFkzaRroZIj7KP8y/n/HUFrK115WVfBtuaPdcLx2uLRp55CEM0TBvAj
         jz8m9fNMC20gXFLMGasLUadTviFBYyM+Yf2VWvCvSHx2ERXArgRusEvkxAMoRH67fLDa
         Z2e1+pEpOx84XfgJf5KawRjX571sEBDTtDiLI6UdxxR7bDMedp8lMTn5GcyELNfW30fo
         St9Q==
X-Gm-Message-State: AOJu0Yxy0IMt0eySjsxVvWcAsjeGIFniF75DjougtYw3mBmPs8LLM/QS
	S/ki8bGSITwOB8D1AsSd6zzeFI6K/SiJpqyrJZQAqCHquRxC5EotxfDQDe9sXh67
X-Gm-Gg: AeBDieum56Q5XsJRXOWTp4RXaww8gK75nY7OGqVVHP30anCNXTuXvxEzXX8Ogu2GR2P
	JXlsjHvEShTEvKBhBtJMTT8yxh0S9sO/7p4j3R+kiLRrgcVlT3FTYKEt0qRztj2zk8KoKoooQ8D
	h4XzkQNlOc6UC4t4YwwiSnrbKNWt5rb5tQTs49WpY/LaFXOC39rrTuRLzNfJ4AAkAO7j1n6GL0O
	u/3GgJMRbOtC7rRqpOhkNOM0ScwFuc0pkdbMjjFviJEzZN9eJx0wc13j2BnCMN0EYwaABRCefYy
	NSkOlk0uEN3iOiQn7wFkPDeAV4mmN3iCLte7FM/u2bLAa2CNdZlcuJqkISICPRzRZeuw7/JpLEf
	zkK/eCNc5vyMEL+zjwzxs5cUJbWyoMeV6SvTP7ga9TrUidRIC0l1vfmlqa8GWe+a28T2BUukIJ3
	u26jNYdkpLQvTY96ATSMKLclKm0OZg2OtKbVFA2jzXtAbfZWATEoisZiaMsXBc8pBvsbw/w063w
	uYR1RssrQqLdVtg1r/kJ52TIPqPzPw=
X-Received: by 2002:a05:6000:1acd:b0:43d:7883:87ce with SMTP id ffacd0b85a97d-44649ba19a9mr13319658f8f.34.1777459025457;
        Wed, 29 Apr 2026 03:37:05 -0700 (PDT)
Received: from alibaba.. ([154.68.200.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216675sm4967112f8f.11.2026.04.29.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:37:04 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com,
	Zakariyah Ali <zakariyahali100@gmail.com>
Subject: [PATCH v6] t2000: consolidate second scenario into a single test block
Date: Wed, 29 Apr 2026 11:36:06 +0100
Message-ID: <20260429103607.406339-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407034446.409175-1-zakariyahali100@gmail.com>
References: <20260407034446.409175-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second test scenario in t2000 consists of several fragmented
test_expect_success blocks that handle data setup, tree writes,
execution of git-checkout-index, and final state validation.

Consolidate these nine separate blocks into a single self-contained
test block. This follows the modern Git testing standard where setup,
execution, and validation of a single logical scenario are kept
together.

As a result of this consolidation, the show_files() helper and its
associated test_debug calls are no longer used and have been removed.
This also removes a dependency on the non-portable 'find -ls' command.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
I'm sorry for replying very late; it was because of some commitments I had to attend to which I've been able to settle.

Changes since v5:
- Consolidate segmented test blocks in the second scenario into a single unit.
- Remove unused show_files debug function and tree3 variable.
- Ensure file setup is inside test_expect_success blocks.

 t/t2000-conflict-when-checking-files-out.sh | 65 +++------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index af199d8191..7b61370549 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -23,17 +23,6 @@ test_description='git conflicts when checking files out test.'
 
 . ./test-lib.sh
 
-show_files() {
-	# show filesystem files, just [-dl] for type and name
-	find path? -ls |
-	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
-	# what's in the cache, just mode and name
-	git ls-files --stage |
-	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
-	# what's in the tree, just mode and name.
-	git ls-tree -r "$1" |
-	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
-}
 
 test_expect_success 'prepare files path0 and path1/file1' '
 	date >path0 &&
@@ -83,59 +72,21 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 # path path3 is occupied by a non-directory.  With "-f" it should remove
 # the symlink path3 and create directory path3 and file path3/file1.
 
-test_expect_success 'prepare path2/file0 and index' '
+test_expect_success 'checkout-index -f resolves symlink conflict on leading path' '
 	mkdir path2 &&
 	date >path2/file0 &&
-	git update-index --add path2/file0
-'
-
-test_expect_success 'write tree with path2/file0' '
-	tree1=$(git write-tree)
-'
-
-test_debug 'show_files $tree1'
-
-test_expect_success 'prepare path3/file1 and index' '
+	git update-index --add path2/file0 &&
+	tree1=$(git write-tree) &&
 	mkdir path3 &&
 	date >path3/file1 &&
-	git update-index --add path3/file1
-'
-
-test_expect_success 'write tree with path3/file1' '
-	tree2=$(git write-tree)
-'
-
-test_debug 'show_files $tree2'
-
-test_expect_success 'read previously written tree and checkout.' '
+	git update-index --add path3/file1 &&
+	tree2=$(git write-tree) &&
 	rm -fr path3 &&
 	git read-tree -m $tree1 &&
-	git checkout-index -f -a
-'
-
-test_debug 'show_files $tree1'
-
-test_expect_success 'add a symlink' '
-	test_ln_s_add path2 path3
-'
-
-test_expect_success 'write tree with symlink path3' '
-	tree3=$(git write-tree)
-'
-
-test_debug 'show_files $tree3'
-
-# Morten says "Got that?" here.
-# Test begins.
-
-test_expect_success 'read previously written tree and checkout.' '
+	git checkout-index -f -a &&
+	test_ln_s_add path2 path3 &&
 	git read-tree $tree2 &&
-	git checkout-index -f -a
-'
-
-test_debug 'show_files $tree2'
-
-test_expect_success 'checking out conflicting path with -f' '
+	git checkout-index -f -a &&
 	test_path_is_dir_not_symlink path2 &&
 	test_path_is_dir_not_symlink path3 &&
 	test_path_is_file_not_symlink path2/file0 &&
-- 
2.43.0

