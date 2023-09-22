Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740DFCD4F49
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjIVKmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIVKmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DDAF
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so21455485e9.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379326; x=1695984126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NjM9o4x8ap6OlbGrsX91dYbci1hAS+OOx7KoHFZCpc=;
        b=jwKdvEV/1A90UCkrH9Mc+bb+PEz9TimTaDng2kzpbmYWjvZL8f3McajOrQmUWtI6dT
         5+QbhPTnwO6356OplhlxGXBsDrAJer7Z+Q9eBMIxdlYv2Ej+CD82Kdh/YG5ZIY3nB1Ay
         sxZvXtpa6LcLuHUMUrdPSi+nkVvLJWCpW66cnb6AS/kHroTe7WimD0okqpIAS5jZOBlB
         809jAAKclnhzm79x8XNSczLaYripClcrL/sWSsy1YQIBzsHrw9YTb6qtJLn1MzwAWwT9
         13ezbN03BCTPao887xm9YqYV+WrmUe7IHEmWdaLnsGX3dFNTzm0KOQMFVRe352iGsks6
         m1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379326; x=1695984126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NjM9o4x8ap6OlbGrsX91dYbci1hAS+OOx7KoHFZCpc=;
        b=ZSTpLxytPVl7X4x7atR9+7ZjlIEpRXHAHuYNYVMhWVnEZLIOeNy+Q9SsVQWYMrhsMs
         5+ESeypUlpCDCk3adlUc39tojjLvf8m9j1UUBZ9mAz2I8xm08t4Uxu+cxo9elJI8A58Q
         FjtDUNmm9Z6z+8yisbK9qwTAPvhGi3twS/XrUPM2GCT+A4EjC/dWLDMW9aPAZ6zQmFR7
         A529YuAmkNEzjnbauVfPa4dOahiOXRQmixKOH2/wXRiOu3uMY1gK6cdjwReTXvWhP+i7
         MFlw/p68rJ/nS6Shk0ce7RREbCNqYkkzI774SedgPI4SvAf4iGK5LMTGSNIiWtZzHile
         OrHA==
X-Gm-Message-State: AOJu0Yy4zRb5KjVcdlLmpss+y3Uf0yuNIn3DlVaXHBgdJTCZk+YbxjFA
        Oh3JTQ8pxJ2FYtFCvobk/9oziAC9DNk=
X-Google-Smtp-Source: AGHT+IHtRnGONvkozqWZmLZXEhvBBMUMaz6h8iPhLEPeqDbEL3KPxu4GbvGEPsxgxqei8qZT6et5Hg==
X-Received: by 2002:a05:600c:a0a:b0:405:36d7:4579 with SMTP id z10-20020a05600c0a0a00b0040536d74579mr3349633wmp.28.1695379326139;
        Fri, 22 Sep 2023 03:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b003fc16ee2864sm2734398wmb.48.2023.09.22.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:05 -0700 (PDT)
Message-ID: <8420a76eba3eba3afdc7747af6d609ad8dbd8cb6.1695379323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:41:59 +0000
Subject: [PATCH 2/6] coverity: cache the Coverity Build Tool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It would add a 1GB+ download for every run, better cache it.

This is inspired by the GitHub Action `vapier/coverity-scan-action`,
however, it uses the finer-grained `restore`/`save` method to be able to
cache the Coverity Build Tool even if an unrelated step in the GitHub
workflow fails later on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 24408f6282c..e8d0be52702 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -29,16 +29,41 @@ jobs:
         env:
           runs_on_pool: ubuntu-latest
 
+      # The Coverity site says the tool is usually updated twice yearly, so the
+      # MD5 of download can be used to determine whether there's been an update.
+      - name: get the Coverity Build Tool hash
+        id: lookup
+        run: |
+          MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
+                   --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
+          echo "hash=$MD5" >>$GITHUB_OUTPUT
+
+      # Try to cache the tool to avoid downloading 1GB+ on every run.
+      # A cache miss will add ~30s to create, but a cache hit will save minutes.
+      - name: restore the Coverity Build Tool
+        id: cache
+        uses: actions/cache/restore@v3
+        with:
+          path: ${{ runner.temp }}/cov-analysis
+          key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: download the Coverity Build Tool (${{ env.COVERITY_LANGUAGE }} / ${{ env.COVERITY_PLATFORM}})
+        if: steps.cache.outputs.cache-hit != 'true'
         run: |
           curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
             --no-progress-meter \
             --output $RUNNER_TEMP/cov-analysis.tgz \
             --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"
       - name: extract the Coverity Build Tool
+        if: steps.cache.outputs.cache-hit != 'true'
         run: |
           mkdir $RUNNER_TEMP/cov-analysis &&
           tar -xzf $RUNNER_TEMP/cov-analysis.tgz --strip 1 -C $RUNNER_TEMP/cov-analysis
+      - name: cache the Coverity Build Tool
+        if: steps.cache.outputs.cache-hit != 'true'
+        uses: actions/cache/save@v3
+        with:
+          path: ${{ runner.temp }}/cov-analysis
+          key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: build with cov-build
         run: |
           export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
-- 
gitgitgadget

