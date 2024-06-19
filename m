Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55080C
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766026; cv=none; b=VtOPgWqLdIy1ZigWUU3hEJQZkfAlGCw+Vp8HCrwvdIJa1ALqRPsdJoyWnZLDd2XoFtTav0H6GaAb9AC2NIybraF6knvnJibM3OVStOqQb9c741Yi2guCY0GJ1ohsk1JrPd77Vd0utup9ymiKE/cJJpGkNbQgv3l1rDAn0SV+eQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766026; c=relaxed/simple;
	bh=xtlwh+vCcmdlvdkNPq0N2HG62s5S41bhMya01O+4ODE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OUzIpfBhNFF/QaksEeP4GZeBmpiCz6bmJ2nx8sGXtik+d19UP3SyzfFyLxbBDImeDXnhYb1z0Eho4lG3BfA6ZDUAr3DudazWMSPLNuOYbMZoaESTDInfE6jvU0SYDgH0LcQVKmrXgUtThDZ2mwZAbrd0/8M2cf8bL6Suu6Bzz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwh/Q3Ru; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwh/Q3Ru"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc335e49aso6813723e87.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766022; x=1719370822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvJL36iw5RcAfaLRW9TwuitWXMkuaN3hD5muxbvPtqo=;
        b=kwh/Q3RufZvk01L6oEzOg66o8DOY1S7etwmjW1YUSYFE0Hk7m4LdIDVXonoEBiTsaQ
         TIqgPFWEpBfnBSRTpGxC56flQkpfLdZFrhQuwXRi5nSYBrjwEyOtdFL4mmhjLcSrGpVQ
         At2QhGx2fsOKTT+CpN1VRM/EwzrawgMqVq7HGXMkONSSLajafOEoN2+w1Yy1oRu/t5Bw
         LW1l+SvSsocpT+KZdLEEd0ublulMqDBDNXd3Bn9bClnH+RXyfmceCffv97hITXqjg81S
         Xm4lsJzx/mi/Rur7OTcYPvndzsxtOCSmmgLkTa+mP+AkvQIKDAS8mxEn3GHcFoIO3hZh
         qmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766022; x=1719370822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvJL36iw5RcAfaLRW9TwuitWXMkuaN3hD5muxbvPtqo=;
        b=sXtVFn+6BWob1Nvwfp82h380NmutkYNbxRSxkWMnJP4R7f8hh3HyUBQFHBoFJcfkyI
         yOpcRCod3wbl6awfCjXHr/1G1mdzd1rkFdfTx5OUHI7tWeBv+Gn/cv3GbGiDAyAtdQka
         BkCI8PTtZAuSLC89EjNQuRgCIQHY4cddqyr/3skU+YcPDeOMCHkpvBUSKiN8Y5ei63JT
         32h756pQM0HELVJm82lW15FtMvjBVyPoQJXdauNqDAc1X+y/NJHAu5SmL/ZNdDTDunSR
         Y2jMPO/OGhYlKb0HTIwJsXiP6Dt7TzVoTWfGnk8UNjgl6HleV3x3Ps09yOyoXwghkxNn
         7okw==
X-Gm-Message-State: AOJu0YzZ7OawgwJOWpzfQiaBpXefW2ZQmJxLNuea/HzkQhKd0x30Jd56
	8D6AMc5l3aelVByrWMIXc/I02Ve8kvDEJPOuGiwW4N0pgXHuW+wqpyCN0A==
X-Google-Smtp-Source: AGHT+IE0B3lKrKRr/3pseIK7kM4i4QIlP5oJtYesswhSO9sq6U1jT6pK0v7a5ea0hTHv3ZuebBKX3Q==
X-Received: by 2002:a05:6512:3da7:b0:52c:6d10:3ae4 with SMTP id 2adb3069b0e04-52ccaa59529mr882375e87.2.1718766021669;
        Tue, 18 Jun 2024 20:00:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm171201365e9.22.2024.06.18.20.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:21 -0700 (PDT)
Message-Id: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:12 +0000
Subject: [PATCH v2 0/7] Fix and improve some error codepaths in merge-ort
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * Remove the conditional outside of move_opt_priv_to_result_priv() for
   patches 1 & 2
 * Fix the consistency issues in patch 6 (refer to updated enum value in
   comment, use consistent prefix on error messages)
 * Fix typo in patch 2
 * Fix incorrect claim in commit message of patch 2 and provide more detail
   about which merges we are interested in checking for a very specific exit
   code.

This series started as a just a fix for the abort hit in merge-ort when
custom merge drivers error out (see
https://lore.kernel.org/git/75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com/).
However, while working on that, I found a few other issues around error
codepaths in merge-ort. So this series:

 * Patches 1-2: fix the reported abort problem
 * Patches 3-4: make code in handle_content_merges() easier to handle when
   we hit errors
 * Patch 5: fix a misleading comment
 * Patches 6-7: make error handling (immediate print vs. letting callers get
   the error information) more consistent

The last two patches change the behavior slightly for error codepaths, and
there's a question about whether we should show only the error messages that
caused an early termination of the merge, or if we should also show any
conflict messages for other paths that were handled before we hit the early
termination. These patches made a decision but feel free to take those last
two patches as more of an RFC.

Elijah Newren (7):
  merge-ort: extract handling of priv member into reusable function
  merge-ort: maintain expected invariant for priv member
  merge-ort: fix type of local 'clean' var in handle_content_merge()
  merge-ort: clearer propagation of failure-to-function from
    merge_submodule
  merge-ort: loosen commented requirements
  merge-ort: upon merge abort, only show messages causing the abort
  merge-ort: convert more error() cases to path_msg()

 merge-ort.c           | 168 +++++++++++++++++++++++++++++++-----------
 t/t6406-merge-attr.sh |  42 ++++++++++-
 2 files changed, 164 insertions(+), 46 deletions(-)


base-commit: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1748%2Fnewren%2Ffix-error-cases-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1748/newren/fix-error-cases-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1748

Range-diff vs v1:

 1:  d4ba1fccd91 ! 1:  5c50c0b3aad merge-ort: extract handling of priv member into reusable function
     @@ merge-ort.c: static void merge_check_renames_reusable(struct merge_result *resul
      +	 * to move it.
      +	 */
      +	assert(opt->priv && !result->priv);
     -+	if (!opt->priv->call_depth) {
     -+		result->priv = opt->priv;
     -+		result->_properly_initialized = RESULT_INITIALIZED;
     -+		opt->priv = NULL;
     -+	}
     ++	result->priv = opt->priv;
     ++	result->_properly_initialized = RESULT_INITIALIZED;
     ++	opt->priv = NULL;
      +}
      +
       /*
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
      -		result->_properly_initialized = RESULT_INITIALIZED;
      -		opt->priv = NULL;
      -	}
     -+	move_opt_priv_to_result_priv(opt, result);
     ++	if (!opt->priv->call_depth)
     ++		move_opt_priv_to_result_priv(opt, result);
       }
       
       /*
 2:  17c97301baa ! 2:  d1adec6d105 merge-ort: maintain expected invariant for priv member
     @@ Commit message
          Both merge_switch_to_result() and merge_finalize() expect
             opt->priv == NULL && result->priv != NULL
          which is supposed to be set up by our move_opt_priv_to_result_priv()
     -    function.  However, two codepath dealing with error cases did not
     +    function.  However, two codepaths dealing with error cases did not
          execute this necessary logic, which could result in assertion failures
          (or, if assertions were compiled out, could result in segfaults).  Fix
          the oversight and add a test that would have caught one of these
          problems.
      
          While at it, also tighten an existing test for a non-recursive merge
     -    to verify that it fails correctly, i.e. with the expected exit code
     -    rather than with an assertion failure.
     +    to verify that it fails with appropriate status.  Most merge tests in
     +    the testsuite check either for success or conflicts; those testing for
     +    neither are rare and it is good to ensure they support the invariant
     +    assumed by builtin/merge.c in this comment:
     +        /*
     +         * The backend exits with 1 when conflicts are
     +         * left to be resolved, with 2 when it does not
     +         * handle the given merge at all.
     +         */
     +    So, explicitly check for the exit status of 2 in these cases.
      
          Reported-by: Matt Cree <matt.cree@gearset.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     -@@ merge-ort.c: static void move_opt_priv_to_result_priv(struct merge_options *opt,
     - 	 * to move it.
     - 	 */
     - 	assert(opt->priv && !result->priv);
     --	if (!opt->priv->call_depth) {
     -+	if (!opt->priv->call_depth || result->clean < 0) {
     - 		result->priv = opt->priv;
     - 		result->_properly_initialized = RESULT_INITIALIZED;
     - 		opt->priv = NULL;
      @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *opt,
       		    oid_to_hex(&side1->object.oid),
       		    oid_to_hex(&side2->object.oid));
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
       		return;
       	}
       	trace2_region_leave("merge", "collect_merge_info", opt->repo);
     +@@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *opt,
     + 		/* existence of conflicted entries implies unclean */
     + 		result->clean &= strmap_empty(&opt->priv->conflicted);
     + 	}
     +-	if (!opt->priv->call_depth)
     ++	if (!opt->priv->call_depth || result->clean < 0)
     + 		move_opt_priv_to_result_priv(opt, result);
     + }
     + 
      
       ## t/t6406-merge-attr.sh ##
      @@ t/t6406-merge-attr.sh: test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 3:  23bb3386114 = 3:  034b91db1d2 merge-ort: fix type of local 'clean' var in handle_content_merge()
 4:  2789c58cd3f = 4:  2813a15b48b merge-ort: clearer propagation of failure-to-function from merge_submodule
 5:  975fbddf305 = 5:  750acae4dba merge-ort: loosen commented requirements
 6:  71391b18c1a ! 6:  6756956d0c7 merge-ort: upon merge abort, only show messages causing the abort
     @@ merge-ort.c: enum conflict_and_info_types {
      +
      +	/*
      +	 * Something is seriously wrong; cannot even perform merge;
     -+	 * Keep this group _last_ other than NB_CONFLICT_TYPES
     ++	 * Keep this group _last_ other than NB_TOTAL_TYPES
      +	 */
      +	ERROR_SUBMODULE_CORRUPT,
       
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      -		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
      +		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
       			 path, NULL, NULL, NULL,
     - 			 _("Failed to merge submodule %s "
     +-			 _("Failed to merge submodule %s "
     ++			 _("error: failed to merge submodule %s "
       			   "(repository corrupt)"),
     + 			 path);
     + 		ret = -1;
      @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
       	}
       	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
 7:  32ae44b6260 ! 7:  500433edf49 merge-ort: convert more error() cases to path_msg()
     @@ Commit message
      
       ## merge-ort.c ##
      @@ merge-ort.c: enum conflict_and_info_types {
     - 	 * Keep this group _last_ other than NB_CONFLICT_TYPES
     + 	 * Keep this group _last_ other than NB_TOTAL_TYPES
       	 */
       	ERROR_SUBMODULE_CORRUPT,
      +	ERROR_THREEWAY_CONTENT_MERGE_FAILED,

-- 
gitgitgadget
