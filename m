Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B1367
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422552; cv=none; b=skQ4gBI1g43pwzuF9wk2Yl3CoOu61c4RfgnW2Gir3cdnlHfXvi/dqCu8ers6sQmWSxa1ON/T74CVukbSy4ZfTuWvczz6k0Zh619oYkPK3iI605kYoLsC85hCvm67Kh1JWnWwSia4aCCh7gk5RRquj5gTJ5Yl36aw0JHFuSiCggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422552; c=relaxed/simple;
	bh=BbReKulvhq8uN/ZQ1avQPKmh6Q/aGtHvEsmjzeXwATI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rzvEsKltogm0fOzm5D7D1vU5C6M4NVPgqesavJgUUACrkUIznuxOHqQ7v5zBExCk9VvYj8pe3EewQzm/Ktf79ljZlsymTHOLWrG+yzq2h9+P4S9W2J9t1+SNHSVf6R5MmcrK2a7GQMhs/VrHoGDkfJC4X/uAr3p/tCJl+vePBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeVF4pMX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeVF4pMX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso3470101f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422548; x=1755027348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAnMC0SM2p//owzqMb39ELPpovLoNP+zspGS936e4EI=;
        b=XeVF4pMXWUvxDFf3FP2tfbwrYtyGU7WG74d9VZEZIDjeNtLV2wFwvY6C+7+pygTrw0
         0n+jIirg22+VFThOqsB4JktWkLx4J71Ocq68+O/EAfNd151FUBUlxyMjF5dnUHvGNlyX
         nZ94bmArlgWlp+6iCZadaQadCCMeC0ZZs+/SS9KW0m0hrN3oG1uz28of1R0uBQ+ZVkHV
         KSi3yH+5A/KXL4R+yXJ3h85BFryyPdAFFGDws7qdESyJ+kPUSoeX3n0NLo2C+gdrI+1g
         zurd2NDK7pXIhgh5q137WZxYG3S/MqIBSJH4nVFv6EANwhrO+IkVGKnORRlD+KaUMXT3
         PisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422548; x=1755027348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAnMC0SM2p//owzqMb39ELPpovLoNP+zspGS936e4EI=;
        b=JY3nADLB+Q/o8qJQHNI44wVrpgDw//Fc9a3+Wgbh76q9SeNQhG/55UVaY6XXIaBjkX
         Hf9jcoHnRNmEqgLw7eD+3eh+HrjXSYAOXwXw2WI6q1q0upOl4OcVPdMslgmo0yP0Q2OP
         QuVKPLDFT5+F/lAN9K7R6+dEZ8ka9i4UY7+BmoBEpSqPsP17mtHEdnMDLiey/KKQG/AW
         8UvM/HZOVSWLWOHaCba8/3Mr7e7W20cEh1NXdtkSRemL/2LZnqnFw97AyEFXY95HkSPT
         +enI333gdGiMf250ee6Atx7STg/VcBrSOpyfvM+rqUFpN7wpJNsZObDYK72Lw9rj5OEK
         /w4g==
X-Gm-Message-State: AOJu0YxiCIM24B/zYidE5cywmQKWTzvmoJEq4kBQh4Kh48/DV+JG5NxC
	txfPC9///bHAUTC/91mjn1QLlFZvOqHf+YLz+CovKA3/pVHOaabx7rGFSpZA4g==
X-Gm-Gg: ASbGncv+VOaHc9FLoqWNs49WUeWWSjbiI4DLdJUkAhnH9LQ0zYmdwDTidAFrzCialUY
	I+Yxsz22eSsBdL+MqoFA4d14641LohZO0WA4CRdlLCbHU4DlfHneT4mZo88HNei2jdsIZoD9TAh
	4Ge2EmXrgAwuu7L5mzyQF5Pi609XbJJqBMPbXcusrrLGhBhWM54iju+OjXR5KfG7RFWkJT0lFpJ
	N9XB+NVuVld6bWrSDz/MexSm2DubKvuy4Qh9q0PpSfVkkW6rT0w9Ku4aQAPU8XXARdkvQuBG6KS
	5vDaSbgsh4sua2T+MC5+7NvE3JjCtn5lEZLNGiWN1IyEYQbVnbsAvCWDGrHgOXHecOlJ2YhuBfe
	8JByEIG7cXRDwlEC4yAFAdMY=
X-Google-Smtp-Source: AGHT+IEXSfuhl2Xzy/GqChND5lCIfCGJwDLFqxsjZcCwnRmv+X3pwBhNAoruH/YxiNGfpTp91YrzkQ==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:d081:3240 with SMTP id ffacd0b85a97d-3b8f415fb5amr207960f8f.1.1754422548005;
        Tue, 05 Aug 2025 12:35:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af917d20sm108621555e9.2.2025.08.05.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:47 -0700 (PDT)
Message-Id: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:40 +0000
Subject: [PATCH v2 0/6] Fix various rename corner cases
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1; many thanks to Patrick for reviewing v1 in detail:

 * Several commit message cleanups
 * Make the test in patch 3 have a single expectation while documenting that
   a reasonable alternative exists, instead of trying to document that both
   are valid and having the test accept both outcomes
 * Moved a hunk accidentally squashed into patch 4 back to patch 3, and
   adjusted a nearby incorrect comment related to the squashed change
 * Fix style issues (grep -> test_grep, // -> /* */)

Original cover letter:

At GitHub, we've got a real-world repository that has been triggering
failures of the form:

git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.


Digging in, this particular corner case requires multiple things to trigger:
(1) a rename/delete of one file, and (2) a directory rename modifying an
unrelated rename such that this unrelated rename's target becomes the source
of the rename/delete from (1).

Unfortunately, looking around, it's not the only bug in the area. Plus, some
of our testcases in tangential situations were not checked closely enough or
were weird or buggy in various ways. Adding to the challenge was the fact
that the relevant renames optimization was sometimes triggering making
renames look like delete-and-add, and overlooking this meant I sometimes
wasn't triggering what I thought I was triggering.

The combination of challenges sometimes made me think my fixes were breaking
things when sometimes I was just unaware of other bugs. I went in circles a
few times and took a rather non-linear path to finding and fixing these
issues. While I think I've turned it into a nice linear progression of
patches, I might be a bit too deep in the mud and it might not be as linear
or clear as I think. Let me know and I'll try to clarify anything needed.

Elijah Newren (6):
  merge-ort: update comments to modern testfile location
  merge-ort: drop unnecessary temporary in check_for_directory_rename()
  t6423: document two bugs with rename-to-self testcases
  t6423: fix missed staging of file in testcases 12i,12j,12k
  merge-ort: fix incorrect file handling
  merge-ort: fix directory rename on top of source of other
    rename/delete

 merge-ort.c                         |  41 ++-
 t/t6423-merge-rename-directories.sh | 519 +++++++++++++++++++++++++++-
 2 files changed, 533 insertions(+), 27 deletions(-)


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1943%2Fnewren%2Ffix-rename-corner-cases-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1943/newren/fix-rename-corner-cases-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1943

Range-diff vs v1:

 1:  dccc2044305 = 1:  dccc2044305 merge-ort: update comments to modern testfile location
 2:  58df0710efc = 2:  58df0710efc merge-ort: drop unnecessary temporary in check_for_directory_rename()
 3:  bda42aa85cf ! 3:  1ea7bfd3bff t6423: document two bugs with rename-to-self testcases
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12n: Directory rename
       
       		test_must_fail git cherry-pick A^0 >out &&
      -		grep "CONFLICT (file location).*should perhaps be moved" out
     -+		grep "CONFLICT (file location).*should perhaps be moved" out &&
     ++		test_grep "CONFLICT (file location).*should perhaps be moved" out &&
      +
     -+		# Should have 1 entry for hello, and 1 for world
     -+		test_stdout_line_count = 2 git ls-files -s &&
     ++		# Should have 1 entry for hello, and 2 for world
     ++		test_stdout_line_count = 3 git ls-files -s &&
      +		test_stdout_line_count = 1 git ls-files -s hello &&
      +		test_stdout_line_count = 2 git ls-files -s world
      +	)
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12n: Directory rename
      +
      +		git checkout -q B^0 &&
      +
     ++		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
     ++
     ++		# Should have 1 entry for hello, and either 0 or 2 for world
     ++		#
      +		# NOTE: Since merge.directoryRenames=true, there is no path
      +		# conflict for world vs. tools/world; it should end up at
      +		# world.  The fact that world was unmodified on side A, means
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12n: Directory rename
      +		#
      +		# However, rename-to-self-via-directory-rename is a bit more
      +		# challenging.  Relax this test to allow world to be treated
     -+		# as a modify/delete conflict as well.
     -+
     -+		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
     -+
     -+		# Should have 1 entry for hello, and either 0 or 2 for world
     ++		# as a modify/delete conflict as well, meaning it will have
     ++		# two higher order stages, that just so happen to match.
     ++		#
      +		test_stdout_line_count = 1 git ls-files -s hello &&
     -+		test_stdout_line_count != 1 git ls-files -s world &&
     -+		if test_stdout_line_count != 0 git ls-files -s world
     -+		then
     -+			grep "CONFLICT (modify/delete).*world deleted in HEAD" out
     -+		fi
     ++		test_stdout_line_count = 2 git ls-files -s world &&
     ++		test_grep "CONFLICT (modify/delete).*world deleted in HEAD" out
       	)
       '
       
 4:  3b3b258cec5 ! 4:  29b5e00c556 t6423: fix missed staging of file in testcases 12i,12j,12k
     @@ Commit message
          that isn't related to what is being tested and makes the test look more
          complicated than it is.
      
     -    The cover letter for the series associated with the above commit noted
     +    The cover letter for the series associated with the above commit (see
     +    Message-ID: pull.1039.git.git.1624727121.gitgitgadget@gmail.com) noted
          that these testcases triggered two bugs in merge-recursive but only one
          in merge-ort; in merge-recursive these testcases also triggered a
          silent deletion of the file in question when it shouldn't be deleted.
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
       		EOF
       		test_cmp expect actual
       	)
     -@@ t/t6423-merge-rename-directories.sh: test_expect_failure '12n: Directory rename transitively makes rename back to sel
     - 		grep "CONFLICT (file location).*should perhaps be moved" out &&
     - 
     - 		# Should have 1 entry for hello, and 1 for world
     --		test_stdout_line_count = 2 git ls-files -s &&
     -+		test_stdout_line_count = 3 git ls-files -s &&
     - 		test_stdout_line_count = 1 git ls-files -s hello &&
     - 		test_stdout_line_count = 2 git ls-files -s world
     - 	)
 5:  2c7d4e022c5 ! 5:  a8a7535fa5e merge-ort: fix incorrect file handling
     @@ Commit message
          as a rename), then we can trigger silent deletion of the file.
      
          Tweak testcase 12i slightly to make the file in question have more than
     -    one line in it, but which doesn't change how it operates.  Make this
     -    change to otherwise minimize the changes between this testcase and a new
     -    one that we want to add.  Then duplicate the testcase as 12i2, changing
     -    it so that it adds a single line to the file in question when it is
     -    renamed, as a testcase for this bug.
     +    one line in it.  This leaves the testcase intact other than changing the
     +    initial contents of this one file.  The purpose of this tweak is to
     +    minimize the changes between this testcase and a new one that we want to
     +    add.  Then duplicate testcase 12i as 12i2, changing it so that it adds a
     +    single line to the file in question when it is renamed; testcase 12i2
     +    then serves as a testcase for this merge-ort bug that I previously
     +    overlooked.
      
          Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
          assertion in process_renames, 2025-03-06), fixed an issue with
     @@ Commit message
          silently-keep-instead-of-delete bug at the same time in the new testcase
          12n2.
      
     -    Fix to merge-ort to prevent multiple bugs with rename-to-self cases:
     +    In summary, we have the following bugs with rename-to-self cases:
            * silent deletion of file expected to be kept (t6423 testcase 12i2)
            * silent retention of file expected to be removed (t6423 testcase 12n2)
            * wrong number of extries left in the index (t6423 testcase 12n)
      
     +    All of these bugs arise because in a rename-to-self case, when we have a
     +    rename A->B, both A and B name the same file.  The code in
     +    process_renames() assumes A & B are different, and tries to move the
     +    higher order stages and file contents so that they are associated just
     +    with the new path, but the assumptions of A & B being different can
     +    cause A to be deleted when it's not supposed to be or mark B as resolved
     +    and kept in place when it's supposed to be deleted.  Since A & B are
     +    already the same path in the rename-to-self case, simply skip the steps
     +    in process_renames() for such files to fix these bugs.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 6:  0813d42d91f ! 6:  7238c8caf2b merge-ort: fix directory rename on top of source of other rename/delete
     @@ Commit message
          other renames, it might be helpful to use a simpler example with break
          detection first.  And before we get to that it may help to explain
          some more basics of handling renames in the merge algorithm.  So, let
     -    me first backup and provide a quick refresher on on each of
     +    me first backup and provide a quick refresher on each of
      
            * handling renames
            * what break detection would mean, if supported in merging
     @@ Commit message
          == Directory rename detection ==
      
          If one side of history renames directory D/ -> E/, and the other side of
     -    history adds new files to E/, then directory rename detection notices
     +    history adds new files to D/, then directory rename detection notices
          and suggests moving those new files to E/.  A similar thing is done for
          paths renamed into D/, causing them to be transitively renamed into E/.
      
     @@ Commit message
      
          == Testcases 8+ ==
      
     -    Another bonus bug, found via understanding our final solution (and the
     +    Another bonus bug, found via understanding our final solutions (and the
          failure of our first attempted solution)!
      
          Let's tweak testcase 7 a bit:
     @@ merge-ort.c: static char *apply_dir_rename(struct strmap_entry *rename_info,
       	INITIALIZE_CI(ci, mi);
      -	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
      +	return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
     -+	  // See testcases 12n, 12p, 12q for more details on this next condition
     ++	  /* See testcases 12{n,p,q} for more details on this next condition */
      +			 || ((ci->filemask & 0x01) &&
      +			     strcmp(p->one->path, path));
       }

-- 
gitgitgadget
