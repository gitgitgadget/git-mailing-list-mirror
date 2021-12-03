Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F4C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383206AbhLCVTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383184AbhLCVTh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268BC061354
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u17so1017679wrt.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E1LqB2ItbJrSpS1f5tW0UwcDQSSnyHdQE50whFsxMpQ=;
        b=n7G7uVR6HbhFa/sx5b92uhpdDPUwN4bWvNzEiOmnCoCB6K9T7IH/YMYmQw5+SZsc9Q
         0+8GqVKKRquxJzfGx3FDeOxRM27K1BMSz0beXbFD50V4/WlXVyV0GjMmjDrSAuxQL6ex
         ALqip5NgM4xVa2KC+IqlOdal5vF/Wdfsb8ZZBiNxc7VeEx69FQcZifvZQtTBdw6bEL3m
         IMwJeZLhFkCHiQvYZctXYDJ6lUmhK7VBvoCPTdAxE5g5d76C0eRDHTXQ0+F46Z1qsXFu
         2zhfd8HhBKreHpzVxcggo7I2pt05c/ueF5ezxZLvetNUnbQjrN5xTVEPrx1T5+OH8ecU
         D1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E1LqB2ItbJrSpS1f5tW0UwcDQSSnyHdQE50whFsxMpQ=;
        b=hgrdF7+e6VeYbdebQVrzzfkgOYm5Sl6aF3Qy5OUZoatdLAoz9mdugoa0vwC64IEWzd
         hHtfm1JSL5a3+zFeASfQ8uchLZiDteisJb9W3TtnUc7stJVJg7f30uZlSdouCjGyspQX
         ShP0TiPwf+oL9ayslMY4HhBN0AgUABZgiFiV5+AjC+ggC9d6E/L9yoaar9AfdtGVMSOC
         /bZfxdkA73zdfOb6Ye4xd1JeNdovaYbXh5AgvaIZOxaoBFkS7sTRP5uSOTfgEYBDrnIY
         0jFCkT0nn+/YJI/HLBldxC41UVqaiP0Pp2s1Yh1k3i0q13WmufatNB5xNh8wI917Rle7
         WBKQ==
X-Gm-Message-State: AOAM533tN8BXuGq9vuno3j0yZ7LEFVTqWX/H4sTIWhRt4clC7x9l5AeD
        t9MH+8PPgN95BypeF4ED+5WAZfVQoKc=
X-Google-Smtp-Source: ABdhPJxLE43rHLl/fU9N1PEKAfuJMFXwqL0k4PgQP0X62mQ1gRk+fSrbye7U2T+XmaLwvWhddYF6iw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr24442049wrw.621.1638566170975;
        Fri, 03 Dec 2021 13:16:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm6254243wma.17.2021.12.03.13.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:10 -0800 (PST)
Message-Id: <219a4158b6a0f14e8cfc5b74108282968a2d8ed6.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:01 +0000
Subject: [PATCH v5 3/7] test-read-cache: set up repo after git directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Move repo setup to occur after git directory is set up. This will protect
against test failures in the upcoming change to BUG in
prepare_repo_settings if no git directory exists.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/helper/test-read-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b52c174acc7..0d9f08931a1 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -39,8 +39,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int table = 0, expand = 0;
 
 	initialize_the_repository();
-	prepare_repo_settings(r);
-	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
@@ -56,6 +54,9 @@ int cmd__read_cache(int argc, const char **argv)
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(r);
+	r->settings.command_requires_full_index = 0;
+
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
 
-- 
gitgitgadget

