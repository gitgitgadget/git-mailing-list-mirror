Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2EBC2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8BD2073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnGruxW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgAYAj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33793 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbgAYAj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so4206083wrr.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+zGFmT02WKTaOlOHBwO8LFt91fGeUDeV4OLIf4x7bns=;
        b=jnGruxW+x9RNSnGvKatz0z/LR92XSSOgNu/lKLV8lmvbRRLGTBOwTt80kMLcSmOv4O
         yKhFIn+ypKhTA0PClHgIN+mXwFxfQYsc6yV2jLt98bvfHPkG6COalEyRDu8KadKHOXiu
         aJ53+IFYGgZ796ahZPI1fUPSAkD9RMaFWgR+dPKx3nVP4GFgPmaDX5F8a/NrVzbI6NGs
         /4DIxvLxfv6DeJ80GcUULLVU/QtDxitko/Ld6kTazZYUESIrd9Urhgs1JZVIlDqiacXf
         AW+BMyZLp6mgBE15XrNtjJrkS1PoMWAO9eVqSqr5rq8wlDMnx0te/zjNw1quGoTWVPnn
         6fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+zGFmT02WKTaOlOHBwO8LFt91fGeUDeV4OLIf4x7bns=;
        b=ja4j65p8itRItwVRbK+lJzDNGmGglW85ETAZeT3IJYDYoIgLZaqIBgmx2333DwV3mj
         Moy6qg+Y+i7g/+k34NBwyaHUl/mKkrLkf0OxoUeUFILKCIvob9T/6n3wBCaQPx6nFQRn
         bT/eVCDFPPDZcoM4LoKOrE9eJj9tsTcM8o0FTNLwGFmuuM+JSNAbkeK6xrVsAtp4IMnc
         N5Z6st5B69oxHCxaoCw8ZxGXj/pCFtM1O+At0vdlgQXk79LLdRtE+AmxRm1DpRF6e+57
         M+0NlizBJUbrzjEa+MXMfQxHA7Rq5VG0E6UXZGaP30E6xZwD5kMTU8KDcJbxkWGFziHd
         8tDA==
X-Gm-Message-State: APjAAAX9qKdVIFzUdRySE4Fn8nfUX/V+MRJdWY62QRiwoUJciT4eeCkG
        6nw/HV4jRsiNsM8haQmkjzG58P4c
X-Google-Smtp-Source: APXvYqzLSO2eoNhKgntuntvJluLRtY2YdIuhtHxlomnVy6KFzKd4JyZ82TNsvqm1VTTes1GjniguuQ==
X-Received: by 2002:adf:e591:: with SMTP id l17mr7354262wrm.139.1579912766033;
        Fri, 24 Jan 2020 16:39:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm9563922wmm.0.2020.01.24.16.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 16:39:25 -0800 (PST)
Message-Id: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Jan 2020 00:39:18 +0000
Subject: [PATCH v5 0/6] config: allow user to know scope of config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was originally a pull request to the git-for-windows repository
[https://github.com/git-for-windows/git/pull/2399]. It adds a new option
--show-scope which would allow a user to see what scope a given
configuration value has (sytem, local, global, etc.).

changes since v3:

 * Cleaned up t1300
 * Expanded test coverage for t1300 to not rely as much on !MINGW by using a
   simpler filename for most tests
 * config_scope_name is now exposed in config.h
 * cleaned up commit messages for clarity/content (again)

Matthew Rogers (6):
  config: fix typo in variable name
  t1300: fix over-indented HERE-DOCs
  t1300: create custom config file without special characters
  config: split repo scope to local and worktree
  config: clarify meaning of command line scoping
  config: add '--show-scope' to print the scope of a config value

 Documentation/git-config.txt |  15 ++-
 builtin/config.c             |  46 +++++--
 config.c                     |  35 ++++-
 config.h                     |  20 +--
 remote.c                     |   3 +-
 submodule-config.c           |   4 +-
 t/helper/test-config.c       |  17 +--
 t/t1300-config.sh            | 240 ++++++++++++++++++++++-------------
 t/t1308-config-set.sh        |   4 +-
 upload-pack.c                |   3 +-
 10 files changed, 248 insertions(+), 139 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v4:

 1:  f5a81a4d25 = 1:  f5a81a4d25 config: fix typo in variable name
 2:  1b42f85399 = 2:  1b42f85399 t1300: fix over-indented HERE-DOCs
 3:  9d19794dfd = 3:  9d19794dfd t1300: create custom config file without special characters
 4:  9f160e281a = 4:  9f160e281a config: split repo scope to local and worktree
 5:  7f00f8559d = 5:  7f00f8559d config: clarify meaning of command line scoping
 6:  5549db7e39 = 6:  2e979d9fa5 config: add '--show-scope' to print the scope of a config value

-- 
gitgitgadget
