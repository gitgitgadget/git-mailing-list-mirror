Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24BC43219
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiAZWLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiAZWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:10:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01222C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:10:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso2075661ybb.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1xwMLSQnNgjwz1rbpnenrAmCfVoXS6/4rimu0F4rFTA=;
        b=OxD7zDRnjaZZBMSLJvHgKWFyR06b3Hihn9rNrEl9QFZXi6zzPFS0lb+scpWrENxlzR
         804vfrGeDdnfAljnQ3CCXDOrqeaqJ3m0usA9tzRIOldGtgLVK/oo3Nh5sRRHExi3xX5r
         YwxOLNqUB3UF4tjYDGnRNmhHsmL5CIdKO0SlLAJ3xZ7++rfpmpfzAsgHAOSOG6EZX/nc
         UDdOiKij1tDkn2Xy/yIf3Kb1D5GuyG9/DKxeFEkuj8mvWV314VTcl+X5HRFcW0tWUjNz
         BWfvfrZrp5PjzhQ5OzdlnSbw7o0UYV2wApuC/dMfDWMtiqQ1bGy5R3/KtSb3+qSr5b82
         C2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1xwMLSQnNgjwz1rbpnenrAmCfVoXS6/4rimu0F4rFTA=;
        b=UiXm10OQ8/L/IQV/FIHbVcjOv/mkOnRlD149AzdBPs3JVN2KItPP00bjoqdT+FLPUI
         9Cjvu+q6Hj7Fw7B4aqk2mbz7RI12+XbJiYO3VSpJwZSQVzihXChBDufZoFzrS9ZUB5yE
         JUpGJIt8Yux/7MAdwaGumKj7kTCAJ6H4Df6BrSGuAbf44rQMar1BBH4+x5wIS2UrQNXE
         Y/d0/qLii5JnezlVyOhKugEHkEWGCPjL0QuMrBkNh9NaYBLvekLD5wJXMZFQB/JKLyr+
         ee5IbpZqYfVqBE5aKeqlbMs0x14mzUgzyKvbyPsfGu8o+Wi5wInTGd+fJ1V78KopCKUN
         /QYQ==
X-Gm-Message-State: AOAM533GlUAMZ8rhtRBcgC+surPUZEfzvYtluTEvpPzvOI7hlzJxr7gn
        qi0fNBaoLrDb/+mt6DZfdRx7UD8Vivyozjf9PmqFXFZxDYcepDdxY2J/FsmGVn42HZtf+jkvP6b
        kJzu4AghUAbav4yyoBzYvVha/d8Vh0+7poTPFldk954H7Zguyo/7kO5rgKpzOcPs=
X-Google-Smtp-Source: ABdhPJz0i3o5H0ZbNcMU2kzQtzZpNiLtL7+fUrJ0ChJ23XEA7ytKmbAOYpHEKCWZYpSM+U3PQa361KkUt51CQA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:ab6e:3315:a6a2:f99f])
 (user=steadmon job=sendgmr) by 2002:a25:ca16:: with SMTP id
 a22mr1683250ybg.334.1643235055820; Wed, 26 Jan 2022 14:10:55 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:10:53 -0800
In-Reply-To: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
Message-Id: <2b5e573c22f226cbdb07d931d470a37bca7ffe2b.1643234866.git.steadmon@google.com>
Mime-Version: 1.0
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2] test-lib: unset trace2 parent envvars
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trace2 subsystem can inherit certain information from parent
processes via environment variables; e.g., the parent command name and
session ID. This allows trace2 to note when a command is the child
process of another Git process, and to adjust various pieces of output
accordingly.

This behavior breaks certain tests that examine trace2 output when the
tests run as a child of another git process, such as in `git rebase -x
"make test"`.

While we could fix this by unsetting the relevant variables in the
affected tests (currently t0210, t0211, t0212, and t6421), this would
leave other tests vulnerable to similar breakage if new test cases are
added which inspect trace2 output.

In t/test-lib.sh, we keep a pattern of permitted GIT_* environment
variables. Variables matching /^GIT_TRACE.*/ are currently allowed via
this pattern. We want to preserve this behavior, because it can be
useful to collect trace output over the entire test suite. Instead of
modifying the allow-pattern, we instead fix this issue by unsetting only
the GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in t/test-lib.sh.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Updated commit message and added code comments to explain why we keep
"TRACE" in the allow pattern.

 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f7a137c7d..faf25ba1b2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -432,7 +432,7 @@ EDITOR=:
 unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
-		TRACE
+		TRACE	# Allow tracing in general, but see unsets below.
 		DEBUG
 		TEST
 		.*_TEST
@@ -449,6 +449,10 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
+# Unset trace environment variables that can interfere with trace output used in
+# certain tests.
+unset GIT_TRACE2_PARENT_NAME
+unset GIT_TRACE2_PARENT_SID
 TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}

base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
-- 
2.35.0.rc0.227.g00780c9af4-goog

