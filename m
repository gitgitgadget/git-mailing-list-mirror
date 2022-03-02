Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiCBGGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiCBGGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:06:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C3B12DB
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:05:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so976068wrg.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 22:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FkJHQdPK9XnynYD/+PxO5WPA3gTX13DNNEl5LBQXQbw=;
        b=aChMX4mofqAuaqsWQ67MgmsrhzoNU1G5FEfbwQpOn6qQ9oe7GlCRRsnv7lrrcmNjYR
         r+19zdpWfJnAMzgeEEYxP4JdWx75cFOZs0oepFI0EsjOWafnSJKHnqU4Y02lJCLJjToA
         UWScr2u/bbhunCD79rkWLrX/WwbqzBwERL8USaEalydqLMOK89FByXLisvqucyQ+du2m
         aUBxHMk7URb//8XbWWlds3dqizNjojo0mtSq8ZW3LLQ98Y3kLfMmavN2A+8FeO2ZLM1t
         vYgf13q/BuL3WBpADwEoPF9knPhRtcOARHQZELy9o3z1aDD+fscDMEtdzHxr1+kQKSKK
         E75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FkJHQdPK9XnynYD/+PxO5WPA3gTX13DNNEl5LBQXQbw=;
        b=JwPmeEtKXyeedHdvVNp8PTQOWXkStPAxSl/nRoynUon4NEld+Kt34lHeaZtr0E/xdO
         Apb9CR1nOPo7+G19RhJ4b5ZAOQwBTlJcUeRAMSjGuC0hcqLnnJT57El64EfFTRBlXbc9
         QsCbaY7FTdRwsO4ZdGL9aZYk4i08scF7AcKDDEOge68uXOMV/p98g1G7jZvx/nGHTZat
         vIJeRhO5WddMpqnwEF5gpnxBQuPYb4EkqefbBPfEGgwzwDyw2QmWDar6wzzhqEvM+Xby
         HFa/l/04BhzZFieR7dA4hLfzD+YJLaZkBaqWJtB7l8D4Zk0lD66xtq5C9K8OoS22wzkY
         87hA==
X-Gm-Message-State: AOAM5330siz5vWNwAOiVFucTvHfEvOkW9sj0AINyd9cU2iK3p7mss8mb
        zvj5ErVzsrEzUi+EGS/y4ts97wXq0BQ=
X-Google-Smtp-Source: ABdhPJwBt+NQwKEask6XGe16VwVpv080qT8LahHgkDEgmQ3moB+yaLjYJznOOiiXDebyj/5QdQkjiw==
X-Received: by 2002:adf:a109:0:b0:1ed:c2bd:8a57 with SMTP id o9-20020adfa109000000b001edc2bd8a57mr21312155wro.612.1646201126073;
        Tue, 01 Mar 2022 22:05:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b0038100c9a593sm6491968wml.45.2022.03.01.22.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:05:25 -0800 (PST)
Message-Id: <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 06:05:22 +0000
Subject: [PATCH v3 0/2] Reduce explicit sleep calls in t7063 untracked cache tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace sleep calls with backdating of filesystem changes, but first fix the
test-tool chmtime functionality to work for directories in Windows.

In this third version, a bug with inaccessible-path-handling that Jeff found
is fixed, and a relative-path-avoiding strategy that had been added in t7073
is simplified out after Junio's comments revealed it was misguided.

Tao Klerks (2):
  t/helper/test-chmtime: update mingw to support chmtime on directories
  t7063: mtime-mangling instead of delays in untracked cache testing

 compat/mingw.c                    | 23 +++++++++++++++++++----
 t/t7063-status-untracked-cache.sh | 21 +++++++++------------
 2 files changed, 28 insertions(+), 16 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1166

Range-diff vs v2:

 1:  7cdef0ad5fb ! 1:  052b3dd9bba t/helper/test-chmtime: update mingw to support chmtime on directories
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
       
      -	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
      +	osfilehandle = CreateFileW(wfilename,
     -+				   0x100 /*FILE_WRITE_ATTRIBUTES*/,
     ++				   FILE_WRITE_ATTRIBUTES,
      +				   0 /*FileShare.None*/,
      +				   NULL,
      +				   OPEN_EXISTING,
     -+				   attrs & FILE_ATTRIBUTE_DIRECTORY ?
     ++				   (attrs != INVALID_FILE_ATTRIBUTES &&
     ++					(attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
      +					FILE_FLAG_BACKUP_SEMANTICS : 0,
      +				   NULL);
      +	if (osfilehandle == INVALID_HANDLE_VALUE) {
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
       		aft = mft;
       	}
      -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
     ++
      +	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
       		errno = EINVAL;
       		rc = -1;
 2:  3e3c9c7faac ! 2:  dceb2857609 t7063: mtime-mangling instead of delays in untracked cache testing
     @@ Commit message
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## t/t7063-status-untracked-cache.sh ##
     -@@ t/t7063-status-untracked-cache.sh: sync_mtime () {
     - 	find . -type d -exec ls -ld {} + >/dev/null
     - }
     - 
     -+chmtime_worktree_root () {
     -+	# chmtime doesnt handle relative paths on windows, so need
     -+	# to "hardcode" a reference to the worktree folder name.
     -+	test-tool -C .. chmtime $1 worktree
     -+}
     -+
     - avoid_racy() {
     - 	sleep 1
     - }
      @@ t/t7063-status-untracked-cache.sh: test_expect_success 'setup' '
       	cd worktree &&
       	mkdir done dtwo dthree &&
       	touch one two three done/one dtwo/two dthree/three &&
      +	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
      +	test-tool chmtime =-300 done dtwo dthree &&
     -+	chmtime_worktree_root =-300 &&
     ++	test-tool chmtime =-300 . &&
       	git add one two done/one &&
       	: >.git/info/exclude &&
       	git update-index --untracked-cache &&
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'create/modify files, som
      -	rm base &&
      +	test-tool chmtime =-180 done/two done/three done/four done/five done &&
      +	# we need to ensure that the root dir is touched (in the past);
     -+	chmtime_worktree_root =-180 &&
     ++	test-tool chmtime =-180 . &&
       	sync_mtime
       '
       

-- 
gitgitgadget
