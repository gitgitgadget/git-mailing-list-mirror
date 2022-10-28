Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3DECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJ1PYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJ1PYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 11:24:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082A20B133
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bp11so7016317wrb.9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92e1FzzhJkPlU6h42gzTKmmkOH3pwUMU+ytV6p8j7qM=;
        b=cUMEgVg0X4amgb5fhNZhMvRmzo/fGbbG2qejIKVz4dOjUYj+JifATJsuBFdMmNkdzw
         A13G1IzaH3wB21fCRB921tsDITtJkWvTaOg7y1qMuoFRVwNO2K0CoZvYS2frc0Ux044i
         XoqjNbZh+GWMeVe921kSk6N59qrgOnhjc70khVzdfkk04xur2XdhGbKvuW6NmXy4JRtR
         Lj8XdH9SEjbjNNGVHrBfzWZwy/ig/9QZTgF7AwlcmKA1NQN38zAdSvVpz36kxgcWL6ES
         3AcGHpLUb23jOSVFo8JU35QdjYrDGdU5+ts1uuMkGgGx4sy5gfGx3z/4V5YhIrj0KXAB
         s4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92e1FzzhJkPlU6h42gzTKmmkOH3pwUMU+ytV6p8j7qM=;
        b=wFvSs1hZZDeRx8Nkx8NlMb33WSQM41dVFP6LT7uKJr8f9ADBIPWdANeMEX+Eav3MFE
         zTaBzlnubxtBBTqKHXKmSlfgPPvwyih5+4iV+OR2qB2hF6IEFlck0euBhgSCFMkSez26
         vCDcIIySKrC+u2skEqong4/UkQOt5SMmzNgbnCWW9+gJczxVX1ZzcQqapXTaQzOJ92ZU
         9306yLNXkCNLGGm8ECrsv4bV0xM7hztladX++RNtnPgFM0xqcFzWpaoxdgbEPiuehiU6
         o57uirbR3bKN49Ze+mcr3W10M2+Blo7bDbMYk1a21m+YXzoLbHV5rc7hHDplslf+LDp6
         +cPg==
X-Gm-Message-State: ACrzQf3RQISSFCi+6/8ZZRMmmlZ53F9Cv222sGLLj2W3NQRGZbi1G43L
        nUU2x14vfzXroj+IHHwkcXyJc6JtOk4=
X-Google-Smtp-Source: AMsMyM4SQaIUfgL8z5w1bpdteAY25MaN86HrCQPHDyrKc+o6o/ZlIMhHI2Q+lQe0wZ+Iyq88yeXJfA==
X-Received: by 2002:a05:6000:1842:b0:22e:7bbf:c75 with SMTP id c2-20020a056000184200b0022e7bbf0c75mr35463510wri.547.1666970648385;
        Fri, 28 Oct 2022 08:24:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003b3307fb98fsm4298866wmk.24.2022.10.28.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:24:07 -0700 (PDT)
Message-Id: <7a2bef324395ff8aba83564fb33df2e090bde278.1666970645.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
From:   "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 15:24:05 +0000
Subject: [PATCH 2/2] help.c: don't call git_default_config in
 git_unknown_cmd_config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Simon Gerber <gesimu@gmail.com>, Simon Gerber <gesimu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Gerber <gesimu@gmail.com>

Currently, auto correction doesn't work reliably for commands which must
run in a work tree (e.g. `git status`) in Git work trees which are
created from a bare repository.

As far as I'm able to determine, this has been broken since commit
659fef199f (help: use early config when autocorrecting aliases,
2017-06-14), where the call to `git_config()` in `help_unknown_cmd()`
was replaced with a call to `read_early_config()`. From what I can tell,
the actual cause for the unexpected error is that we call
`git_default_config()` in the `git_unknown_cmd_config` callback instead
of simply returning `0` for config entries which we aren't interested
in.

Calling `git_default_config()` in this callback to `read_early_config()`
seems like a bad idea since those calls will initialize a bunch of state
in `environment.c` (among other things `is_bare_repository_cfg`) before
we've properly detected that we're running in a work tree.

All other callbacks provided to `read_early_config()` appear to only
extract their configurations while simply returning `0` for all other
config keys.

This commit changes the `git_unknown_cmd_config` callback to not call
`git_default_config()`. Instead we also simply return `0` for config
keys which we're not interested in.

Signed-off-by: Simon Gerber <gesimu@gmail.com>
---
 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index d04542d8261..ae534ff0bae 100644
--- a/help.c
+++ b/help.c
@@ -563,7 +563,7 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
 
-	return git_default_config(var, value, cb);
+	return 0;
 }
 
 static int levenshtein_compare(const void *p1, const void *p2)
-- 
gitgitgadget
