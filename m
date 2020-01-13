Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4134FC33CB1
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123C4214D8
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl5O2XbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgAMI3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45569 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAMI3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so7514672wrj.12
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=Gl5O2XbDax9cPqzXnO9yXux6pJ8bCHPyw5iVn4HsX2mUpLjro02pGmZQCo46j3Pg7o
         NpqZKvGPK69n2dvLQz8kBw8l0NH01HW5AR5graOzzuvEM2q2JwDVinioyZzoYcXlfhe8
         lac2eRSRM6j4nLkd4HMv1wr+084zKEbPruyLvNUJAbewyWWlZDx7qrhXo9dLQq0wDLxc
         S5MMFvHNEkK5XvZXsD70JldewRsVBrDgsQt07nLyZ1XekJaxTND/rb30lO2Q7vgc+J/A
         062WfrCJJh4Wz81x49LdZi2aMrWMdPzh5y4RwcWqLiMnc1KSFEHknHYeeWUESgKM9+DV
         PHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=YF8nWT2elc4QFMy2B1FxUjoRxKbq2R6rT4kLmo6oAzMM9vuY3yWzMuoHlRPP+vNgud
         HNavLlcoOU7VYjLSdpDneajTaQL7jf0veXymVEFLThvAkhlAfaqAz1L80HParY2WsrIb
         3h+u9/4IrficOzlcuc3NFwZhSbTWYFejtKtD9bOADoX1Twx3N9YYgij9zOJ0k0ZQQq2l
         dqz4CFkr0TiUNGS6L0BRdZcVXl4QZG018GYyb+XtGwoh6jRHczU2eJGPycDN16xkWVSS
         APQIyB4ksPyAaLLj5ho+t45hAwDcUlXGzjdgDhG4nxYhiFlb9D2ngF3OfshW4LwzN8AR
         nI1Q==
X-Gm-Message-State: APjAAAU1LTVegJdLSdspaM8YdenxUORXggL2j/9e5jJ8mSurwp+TE74t
        BXnnf5uTgqFZdvFclYWZ+HOaC+Q3
X-Google-Smtp-Source: APXvYqz3K1uzhffv5hwCbwPdv/LMCDOxIYVAeUldU6FxCrXShyxm7PaKAn1arLmiYURo42d0Sb0/Kg==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr7837047wrf.174.1578904180213;
        Mon, 13 Jan 2020 00:29:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22sm14812628wru.30.2020.01.13.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:39 -0800 (PST)
Message-Id: <c4195969a6d3beb3cb91a608910d6e4f7ee9a4e1.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:31 +0000
Subject: [PATCH v3 10/10] ci: include the built-in `git add -i` in the
 `linux-gcc` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This job runs the test suite twice, once in regular mode, and once with
a whole slew of `GIT_TEST_*` variables set.

Now that the built-in version of `git add --interactive` is
feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
that fray.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..4df54c4efe 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,6 +20,7 @@ linux-gcc)
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
 linux-gcc-4.8)
-- 
gitgitgadget
