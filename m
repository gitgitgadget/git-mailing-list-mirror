Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67027CB35
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999921; cv=none; b=nlXNabPn3JPkCnwUCm6i0ASoRTLNoy92FWcJwgqJWZ9CUyDyiv6CWjuMRhlzllqnFVubRZhWHpXkIvhr8WQTz4yK3ZRDvL3BzENmYmPzpV1rVMF9TdTLDG08ALrNQwjPtcEGSVb0DkAs5krpz8cL9W24JcNkv8O0kuGozNBVquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999921; c=relaxed/simple;
	bh=jmyMjzsw9oasknBTJD2O7N0OhypbSYtiZC+dnOzXXd0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LvHFS5TUWaf42gvASElFcy9/rOOtYwVkvcLBd/vHyhcJjHxHPSInBApjyZ3bByPlXMX7HLv7IEb1QMwxnwZvDFU6TZnQpvT5PClVgfK5zBXtczma6J41thWz/lYZecZwzOafA1Uo2arHooti/RDYuGp5UI/L0I/aHeRDEtJVuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaboDHdM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaboDHdM"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso40286336d6.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999918; x=1781604718; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpAWBVH7zXL4043mX79unE32e8e9lJDecfyCANukAlg=;
        b=oaboDHdMCqt7tL2gl2JLMkrWfkFAdEof5Rqe5qdRl69mkiRcPdWcROuaeiyVS0uPWZ
         TVnQV2v4PnqWqKCMdxtYYz/Prz+IlJcfi/N2UntxZBuadWQHVECzf147Bp201Ho4lE3H
         Enq/z/Mw+prfZGbtwwqcfR3oBmP7HJqphTUmCmwwoB6gDR6Mhh4dpbG68KRvvyc8oz55
         6J7Mg7HRQDdjMCCZDurHHDFMqRNdoRfzY0vr345xS2m/IOx+pR7yvOtoaS/uSOZ2MDdf
         JDid79/Mp0VrDEfysglUxw36pLMT8FBr5J1aKdKGnYX4l8dUkydP1qQ77V50rtcWhD/A
         kExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999918; x=1781604718;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpAWBVH7zXL4043mX79unE32e8e9lJDecfyCANukAlg=;
        b=D/Ih4A/BJIYq4q36wQOhAK2fZPL6TIVahx7DJcez3q6fYZPsAoq71qd+5qi229N54P
         P05PUqMO3Gzhc2C12/ygrhSM94L/Xg3ue+bi/cTaA8qi0EKqww4cGrDtrO5bbHCyupEF
         fgYbLRtMoeLHldodNuA6tp+j+5yqqkJTFTVvRzKqKSOGHKJl2fzmXMi/rtCKAG8TBivG
         d1j1ud7X9T9zlA1VcwxfOZcx3Epc9vCKbZeg9iPk9bYYnVpLJ68cusOvEToQ5V71e5WI
         iJP/mqMyX/17dOtkANJTiUaOI30B1iNcsgoK4Kw94CEcTBiWW8MUTSCIT60hDX8kSa2p
         IDnQ==
X-Gm-Message-State: AOJu0Yx9YtQgV6xDabjI18We1VKWqJPq+tqMTRnYUWydjtvftzi3tnUk
	cz4vYaw9d0uH6aUXtI6Pl2+maFNnmISMFpgICmCRG6CYqIOx26YsFJq7oRdNTBve
X-Gm-Gg: Acq92OEpN0BLkpDjSsC1uegku+E1GtDUlpN2T7fhlXoHV2ddppgYlJqKSiW3MgfPK8A
	6pscweJlG2Vhi5Xen5rqKIWSH0ko3uScrkj8iPDRdE1OBaKGgmWGmC69ADe8+5XMkv1vGYYkx9k
	ddKa4mOYudHneDGPwZ9AZcGCOmUKxa+MM6eU4d4ZNGcxHCFt6eHU/8YEwMNNfrkY8OPQ3NbsIdc
	5kG4ZR1ZmP8jcodoCZmuWixH9GgOC1OBU3DLNeoDq1bkqFll3Na2mPY6i9b9LCuTkLZxAn5I1Du
	uMhIthmDqWK4+rItc6u3EMmTlCVmL78A6YJHSTSJN/41BnhMxrZ7j2wk6SZn1dKA3XnK1d0osDO
	t3unAfLMqwqa5R6R2GEmtP0ddNAVe+RowG5aW4HZ+Z16ndmxKzJmi8kBsiMPNayoAoydWZgkVic
	eFO7ISynlRMNQ395NNWUYMjSUHQRDB6U3fdVzvQj3F0k3u
X-Received: by 2002:a05:6214:246:b0:8b2:13cd:ad38 with SMTP id 6a1803df08f44-8cee5fb6e1emr227451176d6.11.1780999918322;
        Tue, 09 Jun 2026 03:11:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053210sm195587956d6.26.2026.06.09.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:11:57 -0700 (PDT)
Message-Id: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:51 +0000
Subject: [PATCH v14 0/6] branch: prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * Fixed a git branch -d -r regression (broke t5404/t5505/t5514): the
   remotes path set a local force but not the DELETE_BRANCH_FORCE bit that
   check_branch_commit() reads, so it wrongly ran the merge check.
 * Made flags the single source of truth in delete_branches() so the bit and
   the derived locals can't disagree.
 * Works locally, but GitHub CI has problems that are there for other
   branches too, hopefully not related
   (https://github.com/git/git/pull/2285).

Harald Nordgren (6):
  branch: add --forked filter for --list mode
  branch: let delete_branches warn instead of error on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --prune-merged <branch>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --dry-run for --prune-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  41 +++-
 builtin/branch.c                 | 186 +++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 367 +++++++++++++++++++++++++++++++
 6 files changed, 653 insertions(+), 28 deletions(-)


base-commit: 600fe743028cbfb640855f659e9851522214bc0b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v14
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v13:

 1:  ccd07cff25 = 1:  7383872f4b branch: add --forked filter for --list mode
 2:  a7672713f6 ! 2:  7ef9502e01 branch: let delete_branches warn instead of error on bulk refusal
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       	int i;
       	int ret = 0;
       	int remote_branch = 0;
     -+	int force = flags & DELETE_BRANCH_FORCE;
     -+	int quiet = flags & DELETE_BRANCH_QUIET;
     ++	int force, quiet;
       	struct strbuf bname = STRBUF_INIT;
       	enum interpret_branch_kind allowed_interpret;
       	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 		remote_branch = 1;
     + 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
     + 
     +-		force = 1;
     ++		flags |= DELETE_BRANCH_FORCE;
     + 		break;
     + 	case FILTER_REFS_BRANCHES:
     + 		fmt = "refs/heads/%s";
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 	}
     + 	branch_name_pos = strcspn(fmt, "%");
     + 
     ++	force = flags & DELETE_BRANCH_FORCE;
     ++	quiet = flags & DELETE_BRANCH_QUIET;
     ++
     + 	if (!force)
     + 		head_rev = lookup_commit_reference(the_repository, &head_oid);
       
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
       		char *target = NULL;
 3:  5ee7643d3a ! 3:  259113e304 branch: prepare delete_branches for a bulk caller
     @@ builtin/branch.c: enum delete_branch_flags {
       
       static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 	int i;
     + 	int ret = 0;
       	int remote_branch = 0;
     - 	int force = flags & DELETE_BRANCH_FORCE;
     - 	int quiet = flags & DELETE_BRANCH_QUIET;
     -+	int dry_run = flags & DELETE_BRANCH_DRY_RUN;
     -+	int no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
     +-	int force, quiet;
     ++	int force, quiet, dry_run, no_head_fallback;
       	struct strbuf bname = STRBUF_INIT;
       	enum interpret_branch_kind allowed_interpret;
       	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	}
     - 	branch_name_pos = strcspn(fmt, "%");
     + 
     + 	force = flags & DELETE_BRANCH_FORCE;
     + 	quiet = flags & DELETE_BRANCH_QUIET;
     ++	dry_run = flags & DELETE_BRANCH_DRY_RUN;
     ++	no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
       
      -	if (!force)
      +	if (!force && !no_head_fallback)
 4:  5f913c445c = 4:  9924373da0 branch: add --prune-merged <branch>
 5:  8e9a735ffe = 5:  d691d5051b branch: add branch.<name>.pruneMerged opt-out
 6:  511de4788e = 6:  ede8c61729 branch: add --dry-run for --prune-merged

-- 
gitgitgadget
