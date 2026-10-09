Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0513B5DED
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558827; cv=none; b=JbdvmNNnUGk/60l6uHFv8FaIyY9lIU3N/F00yl1Uf3JGvAERsx4lPDzXFwMASaNTsN1Db8A/GvOUqQD1vF3pTUAVsEhX/JOsvUhodS1C4v2NMjHMaFtg4SzFI95QowDSWFjMhTJPbzLWJzdpNgipZPEBId+ktvQ2FgMF6Fp3ZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558827; c=relaxed/simple;
	bh=mKxhxSyWv2+GCqCbOoK0OIpzqakpZzNCoCM6gwLWupk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=av4V7aGYcIWiFf5Fru/kHdHTkQ3p84Pu6ZoJ+Ju8WmmsmsXcuR9ZKHQlE0XI13yycXtd+I9P3TsWFdxWAZ6lZi/Y4FVKyWpXzcQ5qnCY1OuLt8rL+tP2aB2kiADhxL2cegbXWwo/i8jFeXbQQFlCNZGDgkigY/cUdZUtOBxYQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltby6gtk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltby6gtk"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6d7e06dbcccso3008781eaf.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558825; x=1792163625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ixnF9oIAduazWco89trgc3EC22IABj3esX75Ju6OJw8=;
        b=ltby6gtkVmbTG7IFQQvg2hrXwH8z4u0Sl3eG7OgVAE+GmXJLJhkmzr+Dsu4ZM8DY/e
         7QY9JipayRUShoDGbaEHjRyYtS412dgfmbb/XSUIpIb5plj32/pmBdDQBIKPy0cSzouT
         K269w9lUDEFeGOvjaaqdbkYcOhinOEsNh/QbXTDrX09WguzE6tRTX6xMwQbwjAPEzT5e
         qAdlym+Mvy4WIJJOurfgE4pSF0tVNbSOMDLj0/fNHMw55zQuli/rHtECvYs/ueQszimi
         LTreCTXrR5fzvGRzD+33nbjMhs7hER3vi3c9s05MCjPJBpHWo1NzPjuRkGmerFw9yzwk
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558825; x=1792163625;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixnF9oIAduazWco89trgc3EC22IABj3esX75Ju6OJw8=;
        b=sPjO4yM7xTGp92N/Gn3dBPIvTNAngNyUi9sJ7PhVd4IdHBhwEvbtFmom8M3U7mgJI+
         RXS9jBaaz4I5ahJUKthvWaI71WILVynnig6N5EmGD4LcQV7GlK9P+Is5zEel1p/gOrOP
         h1Qd7FEhBPbfjXvh5KsmesipC/Vra2UHncmpp6f3bsofB2JdmT4KzEy9WmDJKEZkDrfP
         +kg118RsPXn1gtcnjzbalfWpd9GufGQnW/s8Lvvf/duc8rQ5vrv6FiUk6Re7v8cB3We7
         /FnvOtFN0T6ip8A6ZdPg2TnCzBqHAM1H68sJlRKUiCTeKlVaMx6wZoCgbaUfkADXtMjA
         OVfw==
X-Gm-Message-State: AFuF++lDuUGY+uAX3QyR95S9M8hRCtHhZsppnedokgTOTcgkcaS0fn5f
	/JqkzQ5ItTdur3DZnRgG7BXhAnplO5NchkPNaP/FZLD1Hq9Pq04hkhfJwme+og==
X-Gm-Gg: AYBFou3aQGOOFCPCYgrrybBSq9K1Ad+4IINDcVzjbBOnpwtdStbdgicrCMrN3FSdQhS
	Zrk51TLRotLDGPNzGcfEAzOzQcPQNXCj254NA8A8UHPmk3tBXkeH3w30tSPDWmyu2nLSRQDBPE7
	wOhxxu8ovM9ggcomoj1E2++Fs5y67EvzhJM4K8E9ktItMRvTjP2yepzuI/iuU4BtG4vNxo/Hzyd
	QPTDDBTqmk/TNefR140whx1CJ4uRtGdKm0p5r7+pj5EMBkvPi1IIM8UjHGP4qXXdz/8dLQwY6KV
	N13yWKtFiiNHGpdys9CZD5av5Z9U4cxT0Mu9sMy4iDUScbbzwP9cxf0JwN2sUe0AiF5NKXfqXaE
	gACzcSE4DoOx7DvrJ4gOFvdUaDtz5KxgceT2sputKGyD5jjTnLGn9p5jPFo31+0NGfzWWQT3wfk
	k/b87UsPZt0RSfBaH5IFSeM/Tdz5EGvxjV4n9U4k4wZdwuuNxsiIEVQVB29XW+Gf11BtQ+kis=
X-Received: by 2002:a05:6820:290b:b0:6d8:9568:840a with SMTP id 006d021491bc7-6ef0eec174dmr1688426eaf.46.1791558824650;
        Fri, 09 Oct 2026 08:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.29.27])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef011ecbedsm1823143eaf.8.2026.10.09.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:13:44 -0700 (PDT)
Message-Id: <pull.2249.v3.git.1791558823445.gitgitgadget@gmail.com>
In-Reply-To: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 15:13:43 +0000
Subject: [PATCH v3] status: suggest `git merge --continue`, not `git commit`
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

During a merge conflict, we suggest using --continue to continue the
merge for rebase, revert, and cherry-pick.

Change the `git merge` advice to be consistent. 367ff69428
(merge: add '--continue' option as a synonym for 'git commit', 2016-12-14)
says that `git merge --continue` is intended to be a synonym for
`git commit`, and the `git merge` man page already suggests to use
`git merge --continue`.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    status: suggest git merge --continue, not git commit
    
    Changes in v2:
    
     * Use git show -s --format=reference to format the reference in the
       commit message (thanks to Phillip)
     * change to "conclude the merge" (thanks to Phillip)
    
    Changes in v3:
    
     * Actually format the reference correctly (oops)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2249%2Fjvns%2Fadvice-merge-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2249/jvns/advice-merge-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2249

Range-diff vs v2:

 1:  afc69ffeb8 ! 1:  27678e07a8 status: suggest `git merge --continue`, not `git commit`
     @@ Commit message
          During a merge conflict, we suggest using --continue to continue the
          merge for rebase, revert, and cherry-pick.
      
     -    Change the `git merge` advice to be consistent.
     -    Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
     -    `git merge --continue` is intended to be a synonym for `git commit`,
     -    and the `git merge` man page already suggests to use
     +    Change the `git merge` advice to be consistent. 367ff69428
     +    (merge: add '--continue' option as a synonym for 'git commit', 2016-12-14)
     +    says that `git merge --continue` is intended to be a synonym for
     +    `git commit`, and the `git merge` man page already suggests to use
          `git merge --continue`.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>


 t/t7060-wtstatus.sh    | 8 ++++----
 t/t7512-status-help.sh | 4 ++--
 wt-status.c            | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 942ddbbf0e..a9b435b5e3 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
 	cat >expect <<EOF &&
 On branch side
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -141,7 +141,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 	cat >expected <<\EOF &&
 On branch main
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -174,7 +174,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -198,7 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index aca4b6d332..f2e712ac39 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -31,7 +31,7 @@ test_expect_success 'status when conflicts unresolved' '
 	cat >expected <<\EOF &&
 On branch conflicts
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -53,7 +53,7 @@ test_expect_success 'status when conflicts resolved before commit' '
 	cat >expected <<\EOF &&
 On branch conflicts
 All conflicts fixed but you are still merging.
-  (use "git commit" to conclude merge)
+  (use "git merge --continue" to conclude the merge)
 
 Changes to be committed:
 	modified:   main.txt
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..238bb48643 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints) {
 			status_printf_ln(s, color,
-					 _("  (fix conflicts and run \"git commit\")"));
+					 _("  (fix conflicts and run \"git merge --continue\")"));
 			status_printf_ln(s, color,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
@@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (use \"git commit\" to conclude merge)"));
+				_("  (use \"git merge --continue\" to conclude the merge)"));
 	}
 	wt_longstatus_print_trailer(s);
 }

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
