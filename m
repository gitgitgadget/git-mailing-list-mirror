Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6811F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeBGRAA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:00:00 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35478 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754392AbeBGQ77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 11:59:59 -0500
Received: by mail-qk0-f194.google.com with SMTP id 69so1969028qkz.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 08:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a7ckIlsPT5sAPPNdKKVAVcRagGFUdqmwbvaMcDoTbcE=;
        b=muUzHfrjTu5g28+o2LhVI65u+rp4L+Hq3YfHSoC+itf/Yquz81sAxlSidqwRt0hXUf
         e4AEcGecFdVSibeu7zcmuHJephtc398zWdDvjqvdeku8LPplOPajLtuir2nHZJz8xGjd
         OA/jhSmxTqSDBXyBZ0W7S1kql+9jixgUDU6d9FH+lkBwRWm94543DgHCaVupUlKrAlaT
         AFd7SyXQT1M511JsdUgZd4m+PFzch/I6h/DFgKJPWHb+1Mk5p9Qz+9UWuCe20ytWciMr
         2NJ+XhvLXfbMyIucTCoSCEuRVCB8AwsB7nvt7o/gpeAqtea4DFil5tY4+GUS3fXACCXW
         MOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7ckIlsPT5sAPPNdKKVAVcRagGFUdqmwbvaMcDoTbcE=;
        b=MFk0RwlQgzkKgVfPz1nEUHyi525QftXMb9awDz+4pLsSrCGyrn2ha6yuVcDm+weP35
         O//oUrk+N+Xj2P3TVxJRH7LNfl8v0LocvI/tLhS3fgAVwM3cPTwv9RtybGOJmG5dqQ+9
         w6i9QtJnlQGfyeD/bqrOhNLzsbkbsSabkXtWtduYFxXoTmXkC0El6yZ630vnUJM2OAeF
         2wxjLxY0IjM3bu5KZfrK4qcex0aOAT1yaSWpPJN9t9QON3Uvl4MctwVnoNk8rr7wU6b+
         Fu749L/cEFabDx6Bfauo2BmsALPTPtIwzBKKOuVZQXOT0l0NngUcVznpp9Lrji2Fm80G
         xaWw==
X-Gm-Message-State: APf1xPAQyf/DXFoGhF08B/m49QPltTJY24FX4P0C9BLIgprQ4iGWkA9k
        bKxltuv9UBKIDTtsox3mzYKRdQCd
X-Google-Smtp-Source: AH8x224GuFMQllZ3ny7cMlioJjafEWyjJIYwhP7TJMBskBBSR3XBXVZ7VV4XWeODVk5u6EsflexOkQ==
X-Received: by 10.55.79.68 with SMTP id d65mr10081657qkb.153.1518022797961;
        Wed, 07 Feb 2018 08:59:57 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q2sm1384160qta.47.2018.02.07.08.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 08:59:57 -0800 (PST)
Subject: Re: [PATCH v2] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
References: <20180204093823.3671-1-pclouds@gmail.com>
 <20180207092141.4312-1-pclouds@gmail.com>
 <20180207092141.4312-2-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
Date:   Wed, 7 Feb 2018 11:59:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207092141.4312-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/7/2018 4:21 AM, Nguyễn Thái Ngọc Duy wrote:
> read_directory() code ignores all paths named ".git" even if it's not
> a valid git repository. See treat_path() for details. Since ".git" is
> basically invisible to read_directory(), when we are asked to
> invalidate a path that contains ".git", we can safely ignore it
> because the slow path would not consider it anyway.
> 
> This helps when fsmonitor is used and we have a real ".git" repo at
> worktree top. Occasionally .git/index will be updated and if the
> fsmonitor hook does not filter it, untracked cache is asked to
> invalidate the path ".git/index".
> 
> Without this patch, we invalidate the root directory unncessarily,
> which:
> 
> - makes read_directory() fall back to slow path for root directory
>    (slower)
> 
> - makes the index dirty (because UNTR extension is updated). Depending
>    on the index size, writing it down could also be slow.
> 

Thank you again, this patch makes much more sense to me.

> A note about the new "safe_path" knob. Since this new check could be
> relatively expensive, avoid it when we know it's not needed. If the
> path comes from the index, it can't contain ".git". If it does
> contain, we may be screwed up at many more levels, not just this one.
> 

I do have a simplifying suggestion to make.  I noticed that other uses 
of verify_path() check when the potentially erroneous path is passed in 
and then all the underlying code can assume it is valid.  I think that 
makes sense here as well and it makes for a smaller patch.


> diff --git a/fsmonitor.h b/fsmonitor.h
> index cd3cc0ccf2..65f3743636 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -65,7 +65,7 @@ static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cac
>   {
>   	if (core_fsmonitor) {
>   		ce->ce_flags &= ~CE_FSMONITOR_VALID;
> -		untracked_cache_invalidate_path(istate, ce->name);
> +		untracked_cache_invalidate_path(istate, ce->name, 1);

This test isn't needed because we're pulling the name right out of the 
cache entry so it doesn't need to be verified.

Here is a modified version of your patch for consideration:

================

read_directory() code ignores all paths named ".git" even if it's not
a valid git repository. See treat_path() for details. Since ".git" is
basically invisible to read_directory(), when we are asked to
invalidate a path that contains ".git", we can safely ignore it
because the slow path would not consider it anyway.

This helps when fsmonitor is used and we have a real ".git" repo at
worktree top. Occasionally .git/index will be updated and if the
fsmonitor hook does not filter it, untracked cache is asked to
invalidate the path ".git/index".

Without this patch, we invalidate the root directory unnecessarily,
which:

- makes read_directory() fall back to slow path for root directory
   (slower)

- makes the index dirty (because UNTR extension is updated). Depending
   on the index size, writing it down could also be slow.

Noticed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
     Base Ref: master
     Web-Diff: https://github.com/benpeart/git/commit/218a577618
     Checkout: git fetch https://github.com/benpeart/git verify_path-v1 
&& git checkout 218a577618

  dir.c                       |  2 +-
  fsmonitor.c                 |  6 +++++-
  t/t7519-status-fsmonitor.sh | 39 +++++++++++++++++++++++++++++++++++++++
  3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..d431da46f5 100644
--- a/dir.c
+++ b/dir.c
@@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct 
dir_struct *dir,
  	if (!de)
  		return treat_path_fast(dir, untracked, cdir, istate, path,
  				       baselen, pathspec);
-	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
+	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
  		return path_none;
  	strbuf_setlen(path, baselen);
  	strbuf_addstr(path, de->d_name);
diff --git a/fsmonitor.c b/fsmonitor.c
index 0af7c4edba..019576f306 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -118,8 +118,12 @@ static int query_fsmonitor(int version, uint64_t 
last_update, struct strbuf *que

  static void fsmonitor_refresh_callback(struct index_state *istate, 
const char *name)
  {
-	int pos = index_name_pos(istate, name, strlen(name));
+	int pos;

+	if (!verify_path(name))
+		return;
+
+	pos = index_name_pos(istate, name, strlen(name));
  	if (pos >= 0) {
  		struct cache_entry *ce = istate->cache[pos];
  		ce->ce_flags &= ~CE_FSMONITOR_VALID;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index eb2d13bbcf..756beb0d8e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -314,4 +314,43 @@ test_expect_success 'splitting the index results in 
the same state' '
  	test_cmp expect actual
  '

+test_expect_success UNTRACKED_CACHE 'ignore .git changes when 
invalidating UNTR' '
+	test_create_repo dot-git &&
+	(
+		cd dot-git &&
+		mkdir -p .git/hooks &&
+		: >tracked &&
+		: >modified &&
+		mkdir dir1 &&
+		: >dir1/tracked &&
+		: >dir1/modified &&
+		mkdir dir2 &&
+		: >dir2/tracked &&
+		: >dir2/modified &&
+		write_integration_script &&
+		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		git update-index --untracked-cache &&
+		git update-index --fsmonitor &&
+		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-before" \
+		git status &&
+		test-dump-untracked-cache >../before
+	) &&
+	cat >>dot-git/.git/hooks/fsmonitor-test <<-\EOF &&
+	printf ".git\0"
+	printf ".git/index\0"
+	printf "dir1/.git\0"
+	printf "dir1/.git/index\0"
+	EOF
+	(
+		cd dot-git &&
+		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-after" \
+		git status &&
+		test-dump-untracked-cache >../after
+	) &&
+	grep "directory invalidation" trace-before >>before &&
+	grep "directory invalidation" trace-after >>after &&
+	# UNTR extension unchanged, dir invalidation count unchanged
+	test_cmp before after
+'
+
  test_done

base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.15.0.windows.1

