Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C2C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6864A208C4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc0a7HKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBJAbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53337 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgBJAbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so8000326wmh.3
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EpCF2mbXa1o231UCUM901GtSSBdi0hN4zgCKA6px8vs=;
        b=Sc0a7HKz8SvP/5iVejMqLinwuBilpi4BC3IvT2wWr99a+NNcEZJipxlf9+BHG0SNzi
         AQC1E6TF/afQ/WEIhrl6fmdLcAEMEeUU8MJPy8/96mnWx6zfXDO+w1lBA3eykNj05UvC
         c7hNovh2aMBblA3KKloDa6xzNqqlmZIh5Wwj0aC8pCT8BEpT1p+nv7g8sVUk3HUpIbmx
         o7Z9lGBZscvWAj2QsGkWTYgIcl5GirC8rHTHnqM82kIImC6H/2PfoqSZiJFnKaFY51vz
         9Zt6XL00E76Wdl80fKG80+BOKByA3RAUi3sfzkALbiVtGx0yxG37ha6sFRsN3AhWbd4D
         eWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EpCF2mbXa1o231UCUM901GtSSBdi0hN4zgCKA6px8vs=;
        b=L/fW7em1dIXAqSM4PXDj5FnZYtnS0FNh5fDNm/ktMbOsLLo3eL2HCAk99XJaHuFHMv
         8s0YUqajHPGu6e49E/m0+h7fte0Oh7BKHbyc9KLkh4bHZPCLrtUWVwmbVJsAkSHCYF6B
         kt5+DEGYqZ9SPvUvdVltqlEgVb8/EvqlQnozB5Ng1zudKj4Ls93sd3Z34kzOZKFvf+IV
         LQV4p/lzIqmW0f8ZaemOuVhX+X7Vpft6eAThDvU+uoIW1ga67Erasf+y1HqQLvrWUTPX
         k86CjDJJy7HMos7l36ttZewssOSJgXWxRTDRQMNjLnwDZNt0b/4i62oybsUWB6sdbeda
         ERfw==
X-Gm-Message-State: APjAAAXo17N/lXAatTHT4ZTrO5DzKjfIsOECFBnrvsjI1oiHOnlTz3TD
        cr53xvR27woHsrZL07A4rSRlTTIW
X-Google-Smtp-Source: APXvYqxCdxhf5b7jH1CPBDo8ew/jyFv2cSP1uu/8boluz1eGmSReDWhq9c0VAAyO3IZipCCi3yVNPw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr11364542wme.37.1581294667047;
        Sun, 09 Feb 2020 16:31:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm12927193wmh.21.2020.02.09.16.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:06 -0800 (PST)
Message-Id: <f61985375c5096b863dc99ef613d864bfd010d96.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:56 +0000
Subject: [PATCH v7 07/10] config: preserve scope in do_git_config_sequence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

do_git_config_sequence operated under the assumption that it was correct
to set current_parsing_scope to CONFIG_SCOPE_UNKNOWN as part of the
cleanup it does after it finishes execution.  This is incorrect, as it
blows away the current_parsing_scope if do_git_config_sequence is called
recursively.  As such situations are rare (git config running with the
'--blob' option is one example) this has yet to cause a problem, but the
upcoming '--show-scope' option will experience issues in that case, lets
teach do_git_config_sequence to preserve the current_parsing_scope from
before it started execution.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index fe1e44a43a..0e2c693e78 100644
--- a/config.c
+++ b/config.c
@@ -1702,6 +1702,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
+	enum config_scope prev_parsing_scope = current_parsing_scope;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -1741,7 +1742,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
-	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
+	current_parsing_scope = prev_parsing_scope;
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
-- 
gitgitgadget

