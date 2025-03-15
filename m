Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187784C8E
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742000900; cv=none; b=qwclSGsJl2o15Mqo42bnl8taPAivyRcsF2wJn7hue03x24lWplm4SRcMdDEM/FmgkguFsjV5cKF5pjzS0P1kxakeyta1QVBP7boE8IiW01T0Ue2C1h539OsZZ9OqbyMhnr282iNEV0vwmfVItvE8wu5mSj5jz+Lm0pn4I7vW+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742000900; c=relaxed/simple;
	bh=YvGbHSnHUtJ5Rq25VHNgN56mmZZb3N5S1M2oWi3k6Uw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KAnAdYs1OBinVjiFM1CKN2L9b0nX+/n4a8u+aW6YyF1CogEKguPIvwkw2c4A2GeHEeqEAe8ArVjkcweS4fSRTOueyoDGskgQ2b+RNJP3iQv7MfgsLCETMiWYozNwUYohj2NO+J90NRSY2MS4CgOjWwgwAokg3je4RYUX2VvZpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU4gHNeB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU4gHNeB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1381057f8f.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742000896; x=1742605696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFvseNnS6CH+UlvirefYTBn/CL52N9GgF+C4Q7zkeqA=;
        b=MU4gHNeB47LpKAnqlbfinuIap6PYhQr9XncV/xdx77APrSFW9TWPNR1mpMGv9b3Tvq
         JxbBUbmHrDDd8sQ7PKhT2SaMuI2KNw0DiCPqcM8i9iRiPepVOu993KvsFFL1f/hywH7i
         LAVOIWIuyzYOibnPKzZGri8aCEkW7ai5MGc2jNwcVIzVnJuT4NGS03nPbDOnr8SmQA1/
         F9kYUKfeFKdJyw2r4eWbKXyA1vrUcuIcV+SX8FqF3tnvSKl1thKyyV0+F+Dacpl9vesq
         JjO1q3d2Kzl1IsQnjQVv9r9ZOmee66HCfZCJxjbJDE83eUQWccOzcaYMU2sspitdQC+r
         55rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742000896; x=1742605696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFvseNnS6CH+UlvirefYTBn/CL52N9GgF+C4Q7zkeqA=;
        b=bERmok/2JXVAdjJX5E5P4aixbY89XWs4kkb+/DnXP4lKjajYgWSFoYf6MMNRxaoZv9
         Wxpr3ClchpVfzs374BumLQ0NeTc6Ct8L5p5tvtnCa5vvFi2d12EKrgewCOcw3BF2sfZM
         4goxJHtn/pQ3dneO5w1k7LfmOuXU5K0InM9jvvU75D5sxB67C/v4SU2rII8aUfUTN2xF
         +UK2WUB+kVQqZjNeE4JAtjwZj1UGIM5eDB45gB9GqUuZ5LPP8pY+EU/MTP6ZUML6vhOA
         ED6igAveERGTvvBb3OLHXJAIesMN0jIXtAw951hIAggoxOVGGi+zuY9T2Ist0Ljk9RuT
         mIyA==
X-Gm-Message-State: AOJu0YxGqeh/WuJQtiwwTEH365mhurDx6SwSCfCSN/0ptIv838+5JGes
	SJTK9jHd4wNw4wLALqYwdbVf0RnX2fqkE9t8/O/39M8JbeqjwwOvJH5BQQ==
X-Gm-Gg: ASbGncuOh6jgmavqoFfmMmcXXVBIwrEeWratuOvnIgjLKgB3+haIYRImk4W/uTpeE4H
	/WJsNi6kbywl8hm56miJSjiM0cmTJU5dTJH3Nl1L/QSxd3wwPXBLoODLz3ACKEheDemUAYC6k3n
	9tYTbWqIuOuwrTtXimCubgGjP6gNMNQoSFzLxGFXtEBZvyTVt/igbK0rOR5+ju2EBBo05UvWXeQ
	0sQXqqB/2qWY8KXvCcAFbYtrJyAduNN9ibzewsnC/NtN4s+r9ExGHZet2uS0D2Zm+NCgDu+iYp+
	FUCglhdfi+mdbO+6obQotf/AjGRtbjbDuF9lDc4xbtOx/A==
X-Google-Smtp-Source: AGHT+IHeICvjeKsSwLrojPdDF+9GDOW3d6nuaGl1gzo3FPIdzQkOiScwfDtViNc66yuFLylWNUzvaA==
X-Received: by 2002:a5d:598d:0:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-3971d616f56mr6837932f8f.21.1742000895645;
        Fri, 14 Mar 2025 18:08:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ea16csm7079925f8f.82.2025.03.14.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 18:08:14 -0700 (PDT)
Message-Id: <pull.1876.v2.git.1742000894041.gitgitgadget@gmail.com>
In-Reply-To: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
References: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Mar 2025 01:08:13 +0000
Subject: [PATCH v2] diffcore-rename: fix BUG when break detection and --follow
 used together
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
Cc: Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Prior to commit 9db2ac56168e (diffcore-rename: accelerate rename_dst
setup, 2020-12-11), the function add_rename_dst() resulted in quadratic
runtime since each call inserted the new entry into the array in sorted
order.  The reason for the sorted order requirement was so that
locate_rename_dst(), used when break detection is turned on, could find
the appropriate entry in logarithmic time via bisection on string
comparisons.  (It's better to be quadratic in moving pointers than
quadratic in string comparisons, so this made some sense.)  However,
since break detection always sticks the broken pairs adjacent to each
other, that commit decided to simply append entries to rename_dst, and
record the mapping of (filename) -> (index within rename_dst) via a
strintmap.  Doing this relied on the fact that when adding the source of
a broken pair via register_rename_src(), that the next item we'd process
was the other half of the same broken pair and would be added to
rename_dst via add_rename_dst().  This assumption was fine under break
detection alone, but the combination of break detection and
single_follow violated that assumption because of this code:

		else if (options->single_follow &&
			 strcmp(options->single_follow, p->two->path))
			continue; /* not interested */

which would end up skipping calling add_rename_dst() below that point.
Since I knew I was assuming that the dst pair of a break would always be
added right after the src pair of a break, I added a new BUG() directive
as part of that commit later on at time of use that would check my
assumptions held.  That BUG() didn't trip for nearly 4 years...which
sadly meant I had long since forgotten the related details.  Anyway...

When the dst half of a broken pair is skipped like this, it means that
not only could my recorded index be invalid (just past the end of the
array), it could also point to some unrelated dst that just happened to
be the next one added to the array.  So, to fix this, we need to add a
little more safety around the checks for the recorded break_idx.

It turns out that making a testcase to trigger this is quite the
challenge.  I actually added two testscases:
  * One testcase which uses --follow incorrectly (it uses its single
    pathspec to specifying something other than a single filename), and
    which triggers the same bug reported-by Olaf.  This triggers a
    special case within locate_rename_dst() where idx evaluates to 0
    and rename_dst is NULL, meaning that our return value of
    &rename_dst[idx] happens to evaluate to NULL as well.  This
    addressing of an index into a NULL array hints at deeper problems,
    which are raised in the next testcase...
  * A second testcase which when run under valgrind shows that the code
    actually depends upon unintialized memory, in particular the entry
    just after the end of the rename_dst array.

In short, when the two rare options -B and --follow are used together,
fix the accidental find of the wrong dst entry (which would often be
uninitialized memory just past the end of the array, but also could
have just been a dst for an unrelated path if no dst was recorded for
the expected path).  Do so by adding a little more care around checking
the recorded indices in break_idx.

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diffcore-rename: fix BUG when break detection and --follow used together
    
    Bug dates back to Git v2.31.0, and was discovered and reported about
    four years later over at
    https://lore.kernel.org/git/20240920112228.3d1130f5.olaf@aepfle.de/.
    Sadly, took me about half a year to get back to this one...
    
    Changes since v1:
    
     * Added a testcase, and extended the commit message slightly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1876%2Fnewren%2Ffix-break-follow-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1876/newren/fix-break-follow-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1876

Range-diff vs v1:

 1:  e14c1193905 ! 1:  a68e7fe19f7 diffcore-rename: fix BUG when break detection and --follow used together
     @@ Commit message
          be the next one added to the array.  So, to fix this, we need to add a
          little more safety around the checks for the recorded break_idx.
      
     -    It turns out that making a testcase to trigger this is a bit challenging
     -    too.  I added a simple testcase which tickles the necessary area, but
     -    running it normally actually passes for me.  However, running it under
     -    valgrind shows that it is depending upon uninitialized memory.  I
     -    suspect that to get a reliable reproduction case, I might need to have
     -    several more paths involved, but that might make the testcase more
     -    difficult to understand.  So, I instead just embedded a warning within
     -    the testname that the test triggered uninitialized memory use.
     +    It turns out that making a testcase to trigger this is quite the
     +    challenge.  I actually added two testscases:
     +      * One testcase which uses --follow incorrectly (it uses its single
     +        pathspec to specifying something other than a single filename), and
     +        which triggers the same bug reported-by Olaf.  This triggers a
     +        special case within locate_rename_dst() where idx evaluates to 0
     +        and rename_dst is NULL, meaning that our return value of
     +        &rename_dst[idx] happens to evaluate to NULL as well.  This
     +        addressing of an index into a NULL array hints at deeper problems,
     +        which are raised in the next testcase...
     +      * A second testcase which when run under valgrind shows that the code
     +        actually depends upon unintialized memory, in particular the entry
     +        just after the end of the rename_dst array.
      
     -    In short, when these two rare options are used together, fix the
     -    accidental find of the wrong dst entry (which would often be
     -    uninitialized memory just past the end of the array), by adding a little
     -    more care around the recorded indices for break_idx.
     +    In short, when the two rare options -B and --follow are used together,
     +    fix the accidental find of the wrong dst entry (which would often be
     +    uninitialized memory just past the end of the array, but also could
     +    have just been a dst for an unrelated path if no dst was recorded for
     +    the expected path).  Do so by adding a little more care around checking
     +    the recorded indices in break_idx.
      
          Reported-by: Olaf Hering <olaf@aepfle.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ t/t4206-log-follow-harder-copies.sh: test_expect_success 'validate the output.'
       	compare_diff_patch current expected
       '
       
     -+test_expect_success 'log --follow -B does not die or use uninitialized memory' '
     ++test_expect_success 'log --follow -B does not BUG' '
      +	git switch --orphan break_and_follow_are_icky_so_use_both &&
     ++
     ++	test_seq 1 127 >numbers &&
     ++	git add numbers &&
     ++	git commit -m "numbers" &&
     ++
     ++	printf "%s\n" A B C D E F G H I J K L M N O Q R S T U V W X Y Z >pool &&
     ++	echo changed >numbers &&
     ++	git add pool numbers &&
     ++	git commit -m "pool" &&
     ++
     ++	git log -1 -B --raw --follow -- "p*"
     ++'
     ++
     ++test_expect_success 'log --follow -B does not die or use uninitialized memory' '
      +	printf "%s\n" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z >z &&
      +	git add z &&
      +	git commit -m "Initial" &&


 diffcore-rename.c                   |  9 ++++----
 t/t4206-log-follow-harder-copies.sh | 32 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 10bb0321b10..cb4be5be63c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -33,7 +33,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
 {
 	/* Lookup by p->ONE->path */
 	int idx = break_idx ? strintmap_get(break_idx, p->one->path) : -1;
-	return (idx == -1) ? NULL : &rename_dst[idx];
+	return (idx == -1 || idx == rename_dst_nr) ? NULL : &rename_dst[idx];
 }
 
 /*
@@ -1668,9 +1668,10 @@ void diffcore_rename_extended(struct diff_options *options,
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
 				struct diff_rename_dst *dst = locate_rename_dst(p);
-				if (!dst)
-					BUG("tracking failed somehow; failed to find associated dst for broken pair");
-				if (dst->is_rename)
+				if (options->single_follow && dst &&
+				    strcmp(dst->p->two->path, p->two->path))
+					dst = NULL;
+				if (dst && dst->is_rename)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
 			}
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index bcab71c8e84..190c4843211 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -54,4 +54,36 @@ test_expect_success 'validate the output.' '
 	compare_diff_patch current expected
 '
 
+test_expect_success 'log --follow -B does not BUG' '
+	git switch --orphan break_and_follow_are_icky_so_use_both &&
+
+	test_seq 1 127 >numbers &&
+	git add numbers &&
+	git commit -m "numbers" &&
+
+	printf "%s\n" A B C D E F G H I J K L M N O Q R S T U V W X Y Z >pool &&
+	echo changed >numbers &&
+	git add pool numbers &&
+	git commit -m "pool" &&
+
+	git log -1 -B --raw --follow -- "p*"
+'
+
+test_expect_success 'log --follow -B does not die or use uninitialized memory' '
+	printf "%s\n" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z >z &&
+	git add z &&
+	git commit -m "Initial" &&
+
+	test_seq 1 130 >z &&
+	echo lame >somefile &&
+	git add z somefile &&
+	git commit -m "Rewrite z, introduce lame somefile" &&
+
+	echo Content >somefile &&
+	git add somefile &&
+	git commit -m "Rewrite somefile" &&
+
+	git log -B --follow somefile
+'
+
 test_done

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
