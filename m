Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C5C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 06:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBGGcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 01:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGGcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 01:32:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFE126DD
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 22:32:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so10289152wmb.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 22:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnKXBPrBbCkBrccnksRQQnDEsoDVfFhhJFtNCNbJs+Q=;
        b=ngg8w1TRVjEslCQhnPpTPFOtu43dSF1VFTMlUF0MULmVkR8lbVQV8EstZikF1o55ya
         M//9tjsUWkeDIHYyU0woYvI6NlLUTBt+sQuMdJB4AyaJmuWAfEaCiBsSGKTET4L8hQt1
         qc9COtySUD4LX33OAPppDudePHIMuAcgmPhlfu50lY+78YdnZ69oNqIchARYCDFiaA5q
         cpW68FpjDlhq+iQj0zOal+jx+4HqpxZeOfEpYqiO721vGvynyabnIZ/LYIJevdE1rREh
         zP8Nf9Bl+dorfH8r7BoqD6YDW3YK4k4o0vkmqBfZfGBe8Gub3fWKuYessLOinMEhhpv1
         StgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnKXBPrBbCkBrccnksRQQnDEsoDVfFhhJFtNCNbJs+Q=;
        b=vwW/X0Qj8BoOFcxbTW7zmIyUdItU2ZzH/i7FDF1H8to97xq2fDZ9EQ9Or5sP97MFXY
         98KIRJ5zvz5Lhh56hWOizMgdxUtruwU9LGZniGg+l8mbDhzfD/uD6TeHrG5Lk43LsVwk
         LrIMGhoGZkBRQy4JzFKPW0EhnYSe6kbGQ5TLgiZ4WPRO12n4zPD50heryZ2CLVZf2rn0
         0mHJetyQGBCNiQ6NI78K74Qt/rlaExtCQe4oUKeFeWEymdji/v4mHwZPzk36k2oIZpLu
         5RESyBfatS7C+E/ujF72/d5iWxbUTm7AjQzdWp2+x0RgbRy3gtFTYdtIkj+260i1TLEE
         S2fg==
X-Gm-Message-State: AO0yUKVw9rMKgpxCrZKKIKsZE9XZ/aqGU3MkcRytlbxba7mZqtbFW+TT
        Zfw+xujfsIK49Jb5VYZGJVKegdoRKs4=
X-Google-Smtp-Source: AK7set8YVzsyorvrmMoh5mu5/t8lMoPmaFnzF5RNiZml0OZmbxHARLLQeaFaMWGbe5Z6m/gbGGoWBA==
X-Received: by 2002:a05:600c:706:b0:3dc:58a6:bbe6 with SMTP id i6-20020a05600c070600b003dc58a6bbe6mr2577506wmn.31.1675751528867;
        Mon, 06 Feb 2023 22:32:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c181d00b003db06224953sm12429543wmp.41.2023.02.06.22.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 22:32:08 -0800 (PST)
Message-Id: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com>
In-Reply-To: <pull.1468.git.1674275336636.gitgitgadget@gmail.com>
References: <pull.1468.git.1674275336636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Feb 2023 06:32:07 +0000
Subject: [PATCH v2] name-rev: fix names by dropping taggerdate workaround
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 7550424804 ("name-rev: include taggerdate in considering the best
name", 2016-04-22) introduced the idea of using taggerdate in the
criteria for selecting the best name.  At the time, a certain commit in
linux.git -- namely, aed06b9cfcab -- was being named by name-rev as
    v4.6-rc1~9^2~792
which, while correct, was very suboptimal.  Some investigation found
that tweaking the MERGE_TRAVERSAL_WEIGHT to lower it could give
alternate answers such as
    v3.13-rc7~9^2~14^2~42
or
    v3.13~5^2~4^2~2^2~1^2~42
A manual solution involving looking at tagger dates came up with
    v3.13-rc1~65^2^2~42
which is much nicer.  That workaround was then implemented in name-rev.

Unfortunately, the taggerdate heuristic is causing bugs.  I was pointed
to a case in a private repository where name-rev reports a name of the
form
    v2022.10.02~86
when users expected to see one of the form
    v2022.10.01~2
(I've modified the names and numbers a bit from the real testcase.)  As
you can probably guess, v2022.10.01 was created after v2022.10.02 (by a
few hours), even though it pointed to an older commit.  While the
condition is unusual even in the repository in question, it is not the
only problematic set of tags in that repository.  The taggerdate logic
is causing problems.

Further, it turns out that this taggerdate heuristic isn't even helping
anymore.  Due to the fix to naming logic in 3656f84278 ("name-rev:
prefer shorter names over following merges", 2021-12-04), we get
improved names without the taggerdate heuristic.  For the original
commit of interest in linux.git, a modern git without the taggerdate
heuristic still provides the same optimal answer of interest, namely:
    v3.13-rc1~65^2^2~42

So, the taggerdate is no longer providing benefit, and it is causing
problems.  Simply get rid of it.

However, note that "taggerdate" as a variable is used to store things
besides a taggerdate these days.  Ever since commit ef1e74065c
("name-rev: favor describing with tags and use committer date to
tiebreak", 2017-03-29), this has been used to store committer dates and
there it is used as a fallback tiebreaker (as opposed to a primary
criteria overriding effective distance calculations).  We do not want to
remove that fallback tiebreaker, so not all instances of "taggerdate"
are removed in this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    name-rev: fix names by dropping taggerdate workaround
    
    Changes since v1: Slight tweaks to the commit message
    
    v1 was never picked up or commented on, so this is mostly just a
    resubmission, with a rewording to make it clear this is a bugfix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1468%2Fnewren%2Ffix-name-rev-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1468/newren/fix-name-rev-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1468

Range-diff vs v1:

 1:  78bbfb3286b ! 1:  206726fc954 name-rev: stop including taggerdate in naming of commits
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    name-rev: stop including taggerdate in naming of commits
     +    name-rev: fix names by dropping taggerdate workaround
      
          Commit 7550424804 ("name-rev: include taggerdate in considering the best
          name", 2016-04-22) introduced the idea of using taggerdate in the
          criteria for selecting the best name.  At the time, a certain commit in
          linux.git -- namely, aed06b9cfcab -- was being named by name-rev as
              v4.6-rc1~9^2~792
     -    which, while correct, felt very suboptimal.  Some investigation found
     +    which, while correct, was very suboptimal.  Some investigation found
          that tweaking the MERGE_TRAVERSAL_WEIGHT to lower it could give
          alternate answers such as
              v3.13-rc7~9^2~14^2~42
     @@ Commit message
              v3.13~5^2~4^2~2^2~1^2~42
          A manual solution involving looking at tagger dates came up with
              v3.13-rc1~65^2^2~42
     -    which was then implemented in name-rev.
     +    which is much nicer.  That workaround was then implemented in name-rev.
      
     -    It turns out that this taggerdate heuristic isn't needed due to a
     -    subsequent change to fix the naming logic in 3656f84278 ("name-rev:
     -    prefer shorter names over following merges", 2021-12-04).  Simply
     -    removing the taggerdate heuristic from the calculation nowadays
     -    still causes us to get the optimal answer on that particular commit
     -    of interest in linux.git, namely:
     -        v3.13-rc1~65^2^2~42
     -
     -    Further, the taggerdate heuristic is causing bugs of its own.  I was
     -    pointed to a case in a private repository where name-rev reports a name
     -    of the form
     +    Unfortunately, the taggerdate heuristic is causing bugs.  I was pointed
     +    to a case in a private repository where name-rev reports a name of the
     +    form
              v2022.10.02~86
          when users expected to see one of the form
              v2022.10.01~2
     @@ Commit message
          few hours), even though it pointed to an older commit.  While the
          condition is unusual even in the repository in question, it is not the
          only problematic set of tags in that repository.  The taggerdate logic
     -    was a workaround that is no longer needed, and is now causing suboptimal
     -    results in other cases.
     +    is causing problems.
     +
     +    Further, it turns out that this taggerdate heuristic isn't even helping
     +    anymore.  Due to the fix to naming logic in 3656f84278 ("name-rev:
     +    prefer shorter names over following merges", 2021-12-04), we get
     +    improved names without the taggerdate heuristic.  For the original
     +    commit of interest in linux.git, a modern git without the taggerdate
     +    heuristic still provides the same optimal answer of interest, namely:
     +        v3.13-rc1~65^2^2~42
     +
     +    So, the taggerdate is no longer providing benefit, and it is causing
     +    problems.  Simply get rid of it.
      
     -    As such, remove the taggerdate in the comparison.  However, note that
     -    "taggerdate" is actually also used to store commit dates since
     -    ef1e74065c ("name-rev: favor describing with tags and use committer date
     -    to tiebreak", 2017-03-29), where it is used as a fallback tiebreaker
     -    when distances are equal.  We do not want to remove that fallback
     -    tiebreaker, we are only removing the use of actual taggerdates as a
     -    primary criteria overridding effective distance calculations.
     +    However, note that "taggerdate" as a variable is used to store things
     +    besides a taggerdate these days.  Ever since commit ef1e74065c
     +    ("name-rev: favor describing with tags and use committer date to
     +    tiebreak", 2017-03-29), this has been used to store committer dates and
     +    there it is used as a fallback tiebreaker (as opposed to a primary
     +    criteria overriding effective distance calculations).  We do not want to
     +    remove that fallback tiebreaker, so not all instances of "taggerdate"
     +    are removed in this change.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      


 builtin/name-rev.c  | 4 +---
 t/t6120-describe.sh | 6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..df50abcdeb9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -113,9 +113,7 @@ static int is_better_name(struct rev_name *name,
 	 * based on the older tag, even if it is farther away.
 	 */
 	if (from_tag && name->from_tag)
-		return (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name_distance > new_distance));
+		return name_distance > new_distance;
 
 	/*
 	 * We know that at least one of them is a non-tag at this point.
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9a35e783a75..c9afcef2018 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -657,4 +657,10 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 
 check_describe -C disjoint2 "B-3-gHASH" HEAD
 
+test_expect_success 'setup misleading taggerdates' '
+	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
+'
+
+check_describe newer-tag-older-commit~1 --contains unique-file~2
+
 test_done

base-commit: 221222b278e713054e65cbbbcb2b1ac85483ea89
-- 
gitgitgadget
