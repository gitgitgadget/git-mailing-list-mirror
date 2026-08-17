Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AF3C277B
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954900; cv=none; b=DHTNCLZKlzSczFu/B7ATH4J7oKg2nH5hpPvp8pc9wp6/N598ZF4Pa1E3Mv20lum/XgZaJJPvmn7jRRT0dTMCKX1dsxunZ6aaJitegLoSjuo+Fy/st2DoqUBy/vZnZ49jwGoALm1PucK7NREZFNVKAxdYyN+YO4THIctpSQhNgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954900; c=relaxed/simple;
	bh=KMM8yJTEhOsnbm54Q/45ossXEjTo9gT4ZjXjcdNEIQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C39LtkpwWgX+LWd5BHYpoFeHH3PZbNtdnMDeMmZlahH/6Kth6u+rS/YrN9PQK7VFLNZNR0lpuBSkASXr6TU3IYl6FS8+OQ89a1cShxUtc+wgnQbzxasxLd3Cq+7+cJSzf7MLvNTws0df2nPXr8UVoZKswUb/X0ukOpTral4wW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2Qq3mEP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Qq3mEP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2272693a12.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954899; x=1787559699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKaTCDHrS2j/pwT6XStGIFO3LnxpIbZvm9w2yATj1JI=;
        b=D2Qq3mEPm5qRS8XqQ/7LIbpmLFB8B0jYKeqocUeIwKtuxHxxbQcP4MkFd3jImrD2Ht
         XekbszZAKLI1Mc2CwPWkZzotW8hoPEOKHReJ4c6mfcOxpP7yHD43M4KIH/uOjs9Op3af
         nxdHI8kIEKgM3rUdpG3VWWuV+YdTIcjQCjDfGPwGv3SKvqgawZMtIZn8NcPK2qH/AOQZ
         YDaI9+b28jVkdRcgUaqi/ncpRF0rjzoX/g4MnvmlJNWiJNR5S1j3m2MlIPMDZSN5Qz7B
         NfshilYXpYwvdnZVdSMuG9/JrC8wJM1OS5ZYBKh436Pk/lYzGbBsWBPH1BfNCZ37D6vQ
         sEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954899; x=1787559699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKaTCDHrS2j/pwT6XStGIFO3LnxpIbZvm9w2yATj1JI=;
        b=p4SKiLBrzbolMtXpbNpT7/2WyqCQJVLqPK6Ba1a10w96KzCFwgudO37n2yDBHywO/2
         tW14AZ0DVZpd6RdnXiktT8E1VUTaEHi0UWr6CmSa98tnbHXbK0VAnTujpbECu6pzQeHZ
         8bGoR5e0bUcFk0oh9cAdKK8SQwv6m9EU8frRdlyHN4eSxhzTH+8TzXtP1G1qkezgS7At
         TWykSeOtucSyl1prDjJLFtq9mLOxE3emGqI2rlc1Gnw8THTfxTBfsu3fIDkkO5lwDJK/
         24tEvI1wqA76xlP5EFdowGDEs7DQhJ6F1+PzGPhFFyT3uakuOmNxTKDQExo1RUwN7a5u
         DrfQ==
X-Gm-Message-State: AOJu0YxlwouqHPzQb/YsC6Ad0F1HS7FtJuHnZEYNInlZE0682vx5R3Hi
	ggAhpCCy2xAjPpB9JYyzsEm+VcdpcGMpBErgeZIJduCxvEoNPdx35tayAFeloMcF
X-Gm-Gg: AR+sD13NiKm7ArPh349lkhZ2P9nPFsmhLEs/4UEXqvae8oNen4vbCCusBdd9RLSt7lk
	LjIa9dt9v25XD1wRs7VMVierYzMh5CeMLi++KfZ4Z4ZREdFEedh3nfXT+NmUSP7acbJZ+3W7K+v
	Jvf6aCNDDyfunU40R2rjyv2J947XMvdrg+Ub8+UFF+ttY+Z45h4AqqQjPd22N1QBqnkgpiX0XFe
	VXfkaCUwFcZsg7344Nk/j2n8EaZGBW462jAc5sidYZ2S7hSuptXri4tx73w1cR0XfUz4IUqoT/3
	7j26rCqm9rNjkp6CqUD8C4+RwJL49BxyJOyaUQve5QBuMk6odc9TyWVx6qfP7dA68SzdKHMEpxj
	JTRvHtJPaoZILvvH+TjmWppVFCUYgLVf6TserS1rFWV90hvap1UG2KMHBn1p1rcQrpcXI/9WOY1
	uT3kL6rXDwsq5gCmQbczKU6t/S3eZoX/VniS/Z4Ei4d36bQbbNMge4H1qOLi33tfNVb0yAWVLOX
	yeS74dTryWr/Q==
X-Received: by 2002:a05:6a20:94c8:b0:3c3:a9ad:a747 with SMTP id adf61e73a8af0-3cc71ddaabdmr22136523637.26.1786954898566;
        Mon, 17 Aug 2026 01:21:38 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14153043d24sm3486649c88.3.2026.08.17.01.21.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 01:21:38 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	l.s.r@web.de,
	Johannes.Schindelin@gmx.de,
	ps@pks.im,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v3] object-name: avoid use-after-free in get_oid_with_context_1()
Date: Mon, 17 Aug 2026 13:51:27 +0530
Message-ID: <20260817082127.81132-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anltEAohp3F9Jbx5@pks.im>
References: <anltEAohp3F9Jbx5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a ":<path>" argument names a relative path, resolve_relative_path()
returns a newly allocated string and "cp" is pointed at it:

	new_path = resolve_relative_path(repo, cp);
	if (!new_path) {
		namelen = namelen - (cp - name);
	} else {
		cp = new_path;
		namelen = strlen(cp);
	}

From there on "cp" and "new_path" name the same allocation. Later the
memory location that "new_path" points to is freed.

	free(new_path);
	if (reject_tree_in_index(repo, only_to_die, ce, stage, prefix, cp))

But here the reject_tree_in_index() passes "cp" to
diagnose_invalid_index_path(), which calls strlen() on it, looks it up
in the index, and formats it into its messages, allocating as it goes.
All of this reads memory that has already been freed.

Collapse the two exits into one to ensure a single free() that happens
after the last use.

Three things have to coincide to reach this:

1. The path has to be relative, or nothing is allocated and "cp"
still points into the argument.

2. The entry found has to be a sparse
directory, which needs a sparse index.

3. The argument has to get past the check in die_verify_filename() that
skips a leading ':' followed by a non-alphanumeric, so ":0:./dir/"
arrives here where ":./dir/" does not.

Add a test to t1092 that covers the combination. It fails under
SANITIZE=address without the change to object-name.c.

This was reported in [1], and the shape used here was suggested in
review [2], but that series was not rerolled and the fix never landed.

[1] https://lore.kernel.org/git/cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqy1xxw7rc.fsf@gitster.g/

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Original-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
Changes since v2: apply Patrick's suggestion to assign
reject_tree_in_index()'s return value directly, since it only
returns 0 or -1, which is exactly what this function needs to return
too. No change to the test. This reduces redundancy.

The three conditions make this awkward to reach by hand, so here is the
recipe:

	git init sparse && cd sparse &&
	mkdir folder1 folder2 &&
	echo a >folder1/a && echo b >folder2/b &&
	git add -A && git commit -m init &&
	git sparse-checkout init --cone --sparse-index &&
	git sparse-checkout set folder1 &&
	git show :0:./folder2/

Without the change below, no sanitizer is needed to see it. On 2.52.0
the buffer has already been reused by the time the message is formatted,
so the path printed is whatever now sits in that memory, and it differs
from run to run:

	fatal: path '' does not exist (neither on disk nor in the index)
	fatal: path 'M-6?:xM-@M-:M-L??X' does not exist (neither on disk nor in the index)
	fatal: path '?M-*JM-^M->M-YM-tn?H' does not exist (neither on disk nor in the index)

Still without the change, built with SANITIZE=address, the same command
reports

	ERROR: AddressSanitizer: heap-use-after-free
	READ of size 3 at 0x607000002a20
	    #1 diagnose_invalid_index_path object-name.c:1653
	    #2 get_oid_with_context_1      object-name.c:1807
	    #3 maybe_die_on_misspelt_object_name
	    #4 die_verify_filename         setup.c:216
	    #6 setup_revisions             revision.c:3103
	    #8 cmd_show                    log.c:694
	freed by thread T0 here:
	    #1 get_oid_with_context_1      object-name.c:1806
	previously allocated by thread T0 here:
	    #5 prefix_path                 setup.c:149
	    #6 get_oid_with_context_1      object-name.c:1784

With the change, the message reads "folder2/" every time and the
sanitizer stays quiet.

"git diff" and "git rev-parse" reach it the same way, and so does "../"
from a subdirectory.

Re-verified against the current tree: the t1092 test still fails
without the object-name.c change and passes with it, under
SANITIZE=address.
 object-name.c                            | 14 ++++++++------
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 83efba0ba6..026ff8c6dd 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1803,13 +1803,15 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				int ret = reject_tree_in_index(repo, only_to_die, ce,
+							       stage, prefix, cp);
+
+				if (!ret) {
+					oidcpy(oid, &ce->oid);
+					oc->mode = ce->ce_mode;
+				}
 				free(new_path);
-				if (reject_tree_in_index(repo, only_to_die, ce,
-							 stage, prefix, cp))
-					return -1;
-				oidcpy(oid, &ce->oid);
-				oc->mode = ce->ce_mode;
-				return 0;
+				return ret;
 			}
 			pos++;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 446c1776cb..05b54062b3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1405,6 +1405,17 @@ do
 	"
 done
 
+test_expect_success 'relative path to a sparse directory' '
+	init_repos &&
+
+	# A ":<stage>:<path>" argument whose path is relative is resolved
+	# into a heap-allocated buffer, and a sparse directory found at that
+	# path is reported through it.  Cover that combination, so that the
+	# reporting does not read the buffer after it has been released.
+	test_sparse_match test_must_fail git show :0:./folder1/ &&
+	test_sparse_match test_must_fail git rev-parse :0:./folder1/
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
2.52.0

