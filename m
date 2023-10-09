Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51FE95A8D
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 23:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbjJIXfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIXfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 19:35:12 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A79D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 16:35:10 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S4Fkg1zbGz9scl;
        Tue, 10 Oct 2023 01:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1696894507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1JK0Ugeb6HeYqkjnzk0LlNG0xg2xIhVAqxNKN0f/gB0=;
        b=RCp61qPRjrq5Ew8tUZXLlgnWDj3+I2kdx3qJT5UxwXy0gVpn6Ok7sIG7Gu32a/1vC12KSF
        rQRQsbl5qsU9SuS0+bLvb2CofOIDaNq20AEB2AF1X3a7JpUOMJWfkvz1q3kSNhitdgqZxM
        YaohUZciNLq/W4wIcG3wYb3rZpkjSbL3UZrg2j/0A47rk0dfa1S7dsOSMSd6NMMJZNJKOG
        hJwNQuWMdBH3CGIVVhm1PMq3pfCU+8LYTflnfaRpRb1+VccFPFVSFUxYgsQliAXuEzqT2z
        /ozPdotlNQ+ZjxUUlffNS3KsXvCRoeja+IGpVTjY6isAYJj7MGuxjLk7hciA9A==
From:   Hugo Sales <hugo@hsal.es>
To:     git@vger.kernel.org
Cc:     Hugo Sales <hugo@hsal.es>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
Date:   Tue, 10 Oct 2023 00:34:55 +0100
Message-ID: <20231009233458.1371351-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow passing a new `-p'/`--parents' option to `git-mv' making it so
missing directories in the given target path get created if they don't
exist. This allows running `git mv -p foo bar/quux/' to first create
the `bar/' and `bar/quux/' directories if they don't exist, and then
move `foo' to `bar/quux/foo'.

This is inspired by `mkdir -p foo/bar/quux/' which will create the
`foo/', `foo/bar/', and `foo/bar/quux/' directories if they don't
exist.

Hugo Sales (3):
  mv: Add -p option to create parent directories
  mv: Add tests for new -p flag
  mv: Add documentation for new `-p' flag

 Documentation/git-mv.txt | 12 ++++--
 builtin/mv.c             | 27 +++++++++-----
 t/t7009-mv-parents.sh    | 79 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 13 deletions(-)
 create mode 100755 t/t7009-mv-parents.sh


base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
-- 
2.42.0

