Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46500C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADCC613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhE0AM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhE0AM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:12:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B4C061362
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e8-20020a05620a2088b02903a5edeec4d6so2082731qka.11
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PiFe8ZbPARTa1BwN5ccCzizd3frBbn/m1Eorw8fljGc=;
        b=F3g5LVe+B4y4Oh8jfPadohJJg08EoVWB0VxvJ/YUpZw7U+0owhv84Dho6OXOl2WMsJ
         ZaWd0WUjac4cykVJMOm3pUtg7z832dAEdvBFPEa6zKqfZIVM1KOBsFAyKeoECFgi53uY
         5j/RDvuYOxMxZ+rOLDrR9eEOj00GNcC/xFkXZJMEDmP0ghfN1rS3nj3RpBfvWBHWFYIc
         HbXo7B4yswjIVyOP9jIx6eE3/Jh9Dg9Y4QBHwf9IE4M73wpmZkwTyWAayRKZhZm/z1zw
         xOJqTc6GKiX4JDd6E27+BYPZprhqZh3VyLQeLaSr6PYuW878q9mV7X7ljlaUaY0kl+KN
         3dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PiFe8ZbPARTa1BwN5ccCzizd3frBbn/m1Eorw8fljGc=;
        b=BP4TmAPqiApFjMQ8Is4n84I1zPVWaOW8Ph3mQtZTHTFMUocgzxidpB/XYZTCfv+mSP
         WE/JI/aVhspMIiW9+/OGC/wFXFv18/Mr8khNkqGsWduQmHpNMNLEwesaoAR3aV/+Rf0P
         qAR8jSP0V61rEJ7A200nTxKKBAO/YDs7s/jY/X5cP/Kar/0ZeuUyjcz2WDjeRS6bkgP7
         gQK36RcsRSa5U821z7YGHlJHUOSqKIqNtbSqThBOalzgI2na/dX0hxvLd+/ltOIm7c6C
         UKB70Y0/y6/PAc/QBXr4f/uKznqVYIp92BjYH8Wvpt2+xEHx5jp+RMBhWMZ+h5PGQhPF
         G1rA==
X-Gm-Message-State: AOAM530LWQAIIBy8hPrlaCNbNBzaEWN0i3yo0LVBrHI2Ek1qc6Y9vNu1
        g72aFh5NzFZunoQw4K3slAb0XvtpqqUQcDgGpdYL4hibtlDi0xaFxb2Imx+IHMgYAzW7cVlXYhS
        zXiLcON2l151cEMr2t/8kaqSQBI9w+eaRdUCdc4Q1jtMJJZkxHAOJEpsMm48OJUMLmaxwPE3p8w
        ==
X-Google-Smtp-Source: ABdhPJzrtJvXldEtNsLkmF04QQWU2lWzDJog277Fk28U7JGpH9dPpq7FPneCKjhgGIkJqzl4fS9SWkT9AEvXKEWXlLA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:bce:: with SMTP id
 ff14mr1040927qvb.1.1622074210127; Wed, 26 May 2021 17:10:10 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:55 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-37-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 36/37] doc: clarify fsmonitor-watchman specification
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsmonitor-watchman is not specified in the same way that other hooks
are. In fsmonitor.c:query_fsmonitor(), the path stored in
'core_fsmonitor' is executed directly via
run-command.h:capture_command(). 'core_fsmonitor' is set during 'git
update-index' via config.c:git_config_get_fsmonitor(). Neither
builtin/update-index.c, nor config.c, nor fsmonitor.c check  that the
path given is in '.git/hooks'.

None of the existing hook execution code is used by fsmonitor.c to
invoke fsmonitor-watchman, because that executable isn't expected to
reside in '.git/hooks'.

Furthermore, it doesn't make sense to specify the fsmonitor-watchman
hook more than once, and that hook itself may soon be superseded by
native logic to talk to an fsmonitor daemon directly from the Git
executable. (See <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
for more information.)

Therefore, let's correct the user-facing documentation around
fsmonitor-watchman and clarify that it won't be supported by
config-based hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 78cc4e0872..42e66d4e2d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -649,9 +649,12 @@ e-mails.
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
-This hook is invoked when the configuration option `core.fsmonitor` is
-set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
+This hook is invoked when the configuration option `core.fsmonitor` is set to a
+path containing an executable. It *cannot* be specified via the usual
+`hook.fsmonitor-watchman.command` configuration or by providing an executable
+in `.git/hooks/fsmonitor-watchman`. The arguments provided to the hook are
+determined by the value of the `core.fsmonitorHookVersion` configuration
+option.
 
 Version 1 takes two arguments, a version (1) and the time in elapsed
 nanoseconds since midnight, January 1, 1970.
-- 
2.31.1.818.g46aad6cb9e-goog

