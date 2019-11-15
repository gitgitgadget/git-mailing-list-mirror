Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F176B1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKOBBg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:36 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36179 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKOBBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:35 -0500
Received: by mail-pl1-f182.google.com with SMTP id d7so3492802pls.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKGS2OrEcED1RzyPy3C6YamwGH2Inz95+8BYXXiBZVM=;
        b=thfDisuupJPFtkcbClcf18dA7c3TtKNgvaXdYSTwS7n/AbtCoYmryZ9pCwRPAGg5MX
         FQwNT56xC2neBK1Z3tukGqhg31+sPxEpX+ny4mF5bXzcXo/Tda/sKCnk3MYVCQFXSfzJ
         A/2wyN3BetgBqyBa1UJRK9KeVU2VKn2vCCJ/nrNg5ZJ9LuEf66InIHLx42Y1evh/kLSh
         89rIp/ww4BQr4EUk3TujJuXKoh37EozzYRwbiFyeYYayh39hKRlMnycDsXoucktJjjQn
         zZWIsuBhGQTGNQ/hE3gQslH9ovrO54YcZxDWoxO9jVJYJWbDxUppm6Lfglacaza6VG6o
         qSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKGS2OrEcED1RzyPy3C6YamwGH2Inz95+8BYXXiBZVM=;
        b=HlIug6JHdN6P3Pcmj6IF1q/2Z5uUN7+NFmOXGTgMRGTZlmV/YDvKCUNtNaGc+YvxZ4
         MujsN/YoC/BX8exjItVNwmAu4EWaLIM2FAEtUM+UKgSap9JN+nIxMDRb5/gHk1ihJwLD
         Ph7G+w6ZEgk828ymC+Z2oxASKmSTCMGiAOOr2fTfMT15mO/GuqrWKnyZmz/Q+1gscEVA
         zocBtvaE/dc+jkAHNBuVHfM94ZMp24T/LTn9iZW+BUcORSSRN1cpb6JBw+bPWdLBFobN
         S9Cit7wDBYEjdNshjYxMiuoV1zQ3wo/yxwT/P46B/YVd5HHuSz9ffM3SN8IhsFMiVUOp
         /cFw==
X-Gm-Message-State: APjAAAXDC1twmL5F8EqYAw4gvgSo7Rm8/igifM6VzxSWN7K4LVW2GsjN
        DlaUNUWSum8xWT8CVBlqwQK8w5oS
X-Google-Smtp-Source: APXvYqw8/SA0gvqBzmqboASf6rMFt3j3hVhX3ZAkZ3RuQgvgj1fj4Rsw775DYO7t4qUg5qXYgVjhdg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr14454156pjv.57.1573779694605;
        Thu, 14 Nov 2019 17:01:34 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 12sm8529447pfv.92.2019.11.14.17.01.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:34 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 27/27] t: run tests with `set -o pipefail` on Bash
Message-ID: <bc3f226edf284d96dc7fff15c188ecfbc32162d6.1573779466.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current convention is to ensure that git commands are not placed in
the upstream of a pipe. If they are, they could fail in an undetectable
manner since a pipe's return code is the last command in the pipe.
However, many old tests are still written with git commands in the
upstream of a pipe.

In the spirit of catching these failures, run tests with
`set -o pipefail` if the underlying shell is Bash. This way, we can
catch failures of Git commands that may occur even in the middle of a
pipeline.

In the future, more shells that support `set -o pipefail` may have it
enabled but let's start small for now.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/README      |  4 ++++
 t/test-lib.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/t/README b/t/README
index 60d5b77bcc..ba96b6d113 100644
--- a/t/README
+++ b/t/README
@@ -415,6 +415,10 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
 the default when running tests), errors out when an abbreviated option
 is used.
 
+GIT_TEST_PIPEFAIL=<boolean>, when true, run 'set -o pipefail' to catch
+failures in commands that aren't the last in a pipe. Defaults to true on
+Bash and false otherwise.
+
 Naming Tests
 ------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46c4440843..c0c43dfce9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -64,6 +64,18 @@ then
 	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
 fi
 
+# Use set -o pipefail on platforms that support it
+GIT_TEST_PIPEFAIL_DEFAULT=false
+# TODO: detect more platforms that support `set -o pipefail`
+if test -n "$BASH_VERSION"
+then
+	GIT_TEST_PIPEFAIL_DEFAULT=true
+fi
+if git env--helper --type=bool --default="$GIT_TEST_PIPEFAIL_DEFAULT" --exit-code GIT_TEST_PIPEFAIL
+then
+	set -o pipefail
+fi
+
 ################################################################
 # It appears that people try to run tests without building...
 "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
-- 
2.24.0.399.gf8350c9437

