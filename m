Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A62C10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiLSOzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiLSOzC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:55:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9915813
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:50:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h7so8887197wrs.6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Lz7/AW+eJ9gfNhj9L3DnNxkiVz8TvpH7sk8r6Jlrc=;
        b=lOYkhLdcnAY+CaKT+inKau7Hp1/hj8IEoSzL9x7htQEIis3hqsHBu6/7OIj3tnRCLH
         kgFUnbFNba9Q2wMlcXQEt8okP8N9r0QqEzfNBc1SfACLca5vyY48PmNb4HeVqiNydCLl
         +RiCsUMfeYSakFSzcgaZRldrx3De6sb1lB+9ZJPLa63EVyGexrRx1uD3lfxNhLdltTcT
         cqE2mwIvE3SkRQH+V+9Zuh55GznoIRozbmlXw1O3PoxlVQk6zSj4q+g2rg6apdYbY8ZJ
         opocuOu1Tzm0E1qLz7xYs/XW9VhwiU4ylsTarCGAXMll6uXPAy8AlUK4reESpkIGVWWw
         Iv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3Lz7/AW+eJ9gfNhj9L3DnNxkiVz8TvpH7sk8r6Jlrc=;
        b=qGbuoFnFaFyRllRGrTRvTsS0p3/bnmCdQ2zIcBNNP2NyEV3E0Tf0RRIkqU2vNt2FHf
         tf1UFTdCmt+XvMRp4DHP/Z+/dHGcTR0/Fr/Kleg4Q1k3kr0sDvqdZhhr7bYAPoh4X7IA
         XFEFpnm61gOA3BY6BIwDIAADVVg42NcnGgKGKpHwL2Mf9k3OV2mykGzqr7goTAZDHNld
         m176+Nik5ribzlf5U7oR+O3ld3uHaNXMfhqpQr+v6RHhgEs+558jXdiQg4VCcIJR1Udr
         IcSurAUk4FIunFEBhynacuQSsSf5iWGbaJcG17Mguzu+VZXGfocpFf4Bd4MAyzi6NjDK
         Uelw==
X-Gm-Message-State: ANoB5pkh4dn6/P3+SMGSO1gZTQTO52HKhL+PCRPHmfn6N75hSyp20kr4
        YH3fJutGyFb5cYayFL7IxpCc9z6OtsI=
X-Google-Smtp-Source: AA0mqf63wTqK4WTIOtK8vabvOlFcDFadwbmIyUfRKa4VfQyjXjdWqFHPClAUJ/S2iIg9p9S9lpHRZA==
X-Received: by 2002:adf:ed48:0:b0:242:5ae0:5b49 with SMTP id u8-20020adfed48000000b002425ae05b49mr26719214wro.30.1671461414975;
        Mon, 19 Dec 2022 06:50:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d640d000000b002365730eae8sm10256656wru.55.2022.12.19.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 06:50:14 -0800 (PST)
Message-Id: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 14:50:14 +0000
Subject: [PATCH] ci: only run win+VS build & tests in Git for Windows' fork
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, phillip.wood@dunelm.org.uk, peff@peff.net,
        me@ttaylorr.com, phillip.wood123@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It has been a frequent matter of contention that the win+VS jobs not
only take a long time to run, but are also more easily broken than the
other jobs (because they do not use the same `Makefile`-based builds as
all other jobs), and to make matters worse, these breakages are also
much harder to diagnose and fix than other jobs', especially for
contributors who are happy to stay away from Windows.

The purpose of these win+VS jobs is to maintain the CMake-based build
of Git, with the target audience being Visual Studio users on Windows
who are typically quite unfamiliar with `make` and POSIX shell
scripting, but the benefit of whose expertise we want for the Git
project nevertheless.

The CMake support was introduced for that specific purpose, and already
early on concerns were raised that it would put an undue burden on
contributors to ensure that these jobs pass in CI, when they do not have
access to Windows machines (nor want to have that).

This developer's initial hope was that it would be enough to fix win+VS
failures and provide the changes to be squashed into contributors'
patches, and that it would be worth the benefit of attracting
Windows-based developers' contributions.

Neither of these hopes have panned out.

To lower the frustration, and incidentally benefit from using way less
build minutes, let's just not run the win+VS jobs by default, which
appears to be the consensus of the mail thread leading up to
https://lore.kernel.org/git/xmqqk0311blt.fsf@gitster.g/

Since the Git for Windows project still needs to at least try to attract
more of said Windows-based developers, let's keep the jobs, but disable
them everywhere except in Git for Windows' fork. This will help because
Git for Windows' branch thicket is "continuously rebased" via automation
to the `shears/maint`, `shears/main`, `shears/next` and `shears/seen`
branches at https://github.com/git-for-windows/git. That way, the Git
for Windows project will still be notified early on about potential
breakages, but the Git project won't be burdened with fixing them
anymore, which seems to be the best compromise we can get on this issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Explicitly make CMake-based CI failures the responsibility of "Windows
    folks"
    
    Ævar and I have brain-stormed off-list what would be the best way to
    resolve the mounting frustration with CI failures that are caused by
    needing to mirror Makefile changes into the CMake-based build, a burden
    that the Git project never wanted to bear.
    
    While he still wants to improve the CMake support (which will benefit
    Git for Windows), the main driver of trying to extend CMake support to
    Linux (which does not need it because make works very well there,
    indeed) was said frustration with CI failures.
    
    A much quicker method to reduce that friction to close to nil is to
    simply disable the win+VS jobs, which is what this proposal is about.
    (Almost, at least, we still want to keep those job definitions and run
    them in Git for Windows' fork to ensure that CMake-based builds still
    work.)
    
    A very welcome side effect is to reduce the CI build time again, which
    became alarmingly long as of recent, causing friction on its own.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1445%2Fdscho%2Fonly-run-win%2BVS-in-the-git-for-windows-fork-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1445/dscho/only-run-win+VS-in-the-git-for-windows-fork-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1445

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index e67847a682c..8af3c67f605 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -132,7 +132,7 @@ jobs:
   vs-build:
     name: win+VS build
     needs: ci-config
-    if: needs.ci-config.outputs.enabled == 'yes'
+    if: github.event.repository.owner.login == 'git-for-windows' && needs.ci-config.outputs.enabled == 'yes'
     env:
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"

base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
-- 
gitgitgadget
