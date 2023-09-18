Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1622CD13D8
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjIRUyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891ED8E
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so56412095e9.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070470; x=1695675270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0/nyjxpNnAWvzkcitcBPwkYKLi3tCO3lh3dfGKViFw=;
        b=Uc4HGKx4tqYx3fYnQ+/u5buxyTBUVChZCdCpaEMN6cAQsySrvoF5IpvrbH8R3Whjh0
         DnfR+46tgqItaYZTsU+okVl35bq1A8uhARWYHvCnQ1UKDviu+22FmMtkIkklADH51V4j
         50SMGIAi+Da0K7vniCvmnDq1bIh4cMR9Op7bfqbKBxuaZXsdDlTSzWchS9zPkouj3QZT
         XU6ASFiRTb5oUshWqUpsjggaf9YdADjYuxPSXgWDsqzd3Z9SX7senwWF2SQbL+30J+k2
         gCyPWQpviq2AIqGiKcEcQxYgJb/e+6kEvUXvo0RbiJuO1l6cWTeGAZRm0z4j8opGg0sZ
         TQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070470; x=1695675270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0/nyjxpNnAWvzkcitcBPwkYKLi3tCO3lh3dfGKViFw=;
        b=FRotflbDs446Uv0/Vr3V7j9krsrC8SqJZ6ZBwyms+Xpl3rw+bZrl4TTZmq+J/vkzOG
         giNJMWpeNRXUNH81LZC2s8sKcwWlRuz6XYT70aP0DHIaD27Wi78OL2YB2cCfR7KDUG3B
         ItaM5ppSVdALIq78Vejo2z4/WWc5ERElS81biEizu4n0zXPr6WLddnEt7eAPiZSclIH5
         z11ZTCuq62IabjeDj1f1McRZWZr98eIbCSyksK9N53Oh0Hkbd0iVGICJXn+Ta0I7zL1+
         qnEBhpoKQzfxZg0qwAmQWmDL+quZmUsiLRQX/nrnV5QnofQRiy+SWLAWUKWI91WBqd8s
         mxIA==
X-Gm-Message-State: AOJu0YzSdJOq2q/svJ6gLtkr1c7pC9kWw6fuLXPCj5H9HbcQMlW9/g12
        tA5GTbYVUYvQc4ot2EvFF3fpI5BweWE=
X-Google-Smtp-Source: AGHT+IGQr93FPYv4Y5rQahj6Ue/v+tn3idlq2B0Prr+R3cy+S3pyDWZcxemAc5RqzUbCSqZGW8DS5g==
X-Received: by 2002:a05:600c:229a:b0:3fe:25b3:951d with SMTP id 26-20020a05600c229a00b003fe25b3951dmr8465990wmf.5.1695070469447;
        Mon, 18 Sep 2023 13:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fef3180e7asm16222893wmi.44.2023.09.18.13.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:29 -0700 (PDT)
Message-ID: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:21 +0000
Subject: [PATCH v2 0/7] CMake(Visual C) support for js/doc-unit-tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent patch series that adds proper unit testing to Git requires a
couple of add-on patches to make it work with the CMake build on Windows
(Visual C). This patch series aims to provide that support.

This patch series is based on js/doc-unit-tests.

Changes since v1:

 * The code added to test-lib.c now avoids using a strbuf.
 * The unit tests are now also handled via CTest.
 * While at it, I cleaned up a little in the CTest-related definitions.

Johannes Schindelin (7):
  cmake: also build unit tests
  unit-tests: do not mistake `.pdb` files for being executable
  unit-tests: do show relative file paths
  artifacts-tar: when including `.dll` files, don't forget the
    unit-tests
  cmake: fix typo in variable name
  cmake: use test names instead of full paths
  cmake: handle also unit tests

 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 38 ++++++++++++++++++---
 t/Makefile                          |  2 +-
 t/unit-tests/test-lib.c             | 52 ++++++++++++++++++++++++++---
 4 files changed, 84 insertions(+), 10 deletions(-)


base-commit: 03f9bc407975bba86d1d1807519d76e1693ff66f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1579%2Fdscho%2Fdoc-unit-tests-and-cmake-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1579/dscho/doc-unit-tests-and-cmake-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1579

Range-diff vs v1:

 1:  2cc1c03d851 = 1:  2cc1c03d851 cmake: also build unit tests
 2:  90db3d5d41f = 2:  90db3d5d41f unit-tests: do not mistake `.pdb` files for being executable
 3:  2b4e36c05c9 ! 3:  f0b804129e8 unit-tests: do show relative file paths
     @@ t/unit-tests/test-lib.c: static struct {
      + * Visual C interpolates the absolute Windows path for `__FILE__`,
      + * but we want to see relative paths, as verified by t0080.
      + */
     -+#include "strbuf.h"
      +#include "dir.h"
      +
      +static const char *make_relative(const char *location)
      +{
     -+	static const char *prefix;
     ++	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
      +	static size_t prefix_len;
     -+	static struct strbuf buf = STRBUF_INIT;
      +
     -+	if (!prefix) {
     -+		strbuf_addstr(&buf, __FILE__);
     -+		if (!strbuf_strip_suffix(&buf, "\\t\\unit-tests\\test-lib.c"))
     -+			die("unexpected suffix of '%s'");
     -+		strbuf_complete(&buf, '\\');
     -+		prefix = strbuf_detach(&buf, &prefix_len);
     ++	if (!prefix_len) {
     ++		size_t len = strlen(prefix);
     ++		const char *needle = "\\t\\unit-tests\\test-lib.c";
     ++		size_t needle_len = strlen(needle);
     ++
     ++		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
     ++			die("unexpected suffix of '%s'", prefix);
     ++
     ++		/* let it end in a directory separator */
     ++		prefix_len = len - needle_len + 1;
      +	}
      +
      +	/* Does it not start with the expected prefix? */
      +	if (fspathncmp(location, prefix, prefix_len))
      +		return location;
      +
     -+	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, location + prefix_len);
     -+	convert_slashes(buf.buf);
     ++	strlcpy(buf, location + prefix_len, sizeof(buf));
     ++	/* convert backslashes to forward slashes */
     ++	for (p = buf; *p; p++)
     ++		if (*p == '\\')
     ++			*p = '/';
      +
     -+	return buf.buf;
     ++	return buf;
      +}
      +#endif
      +
 4:  fb03f5aa6e5 = 4:  a70339f57a7 artifacts-tar: when including `.dll` files, don't forget the unit-tests
 -:  ----------- > 5:  75a74571fbe cmake: fix typo in variable name
 -:  ----------- > 6:  41228df1b46 cmake: use test names instead of full paths
 -:  ----------- > 7:  003d44e9f0d cmake: handle also unit tests

-- 
gitgitgadget
