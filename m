Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9795EC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiKRTri (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiKRTrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 14:47:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3825DEBC
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:47:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s12so8565049edd.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lRZU6PWoecsaTBna8JJ1kT8KzujRo/SD4OzZ4b568hE=;
        b=S7Bla8Gv/6UtSvL2SsQgzV+vKqkFzF2xiKuxbsyz/G4MJwKa/aH31vTdNiV/PJTA6t
         U/HQe/tMoIsM2OX5RqCT6aXpY1AjMsl3FvF8UP10ZozeMNdTwSOiveG0E+9tEe3L3Iq4
         Tg/CMaxEJjadLehJsQL1tDz4AWZ4+It6m7pFKK0InaIA0XswiuX92CGaCYJxlFHLngP5
         MRbFE6keZ0jl5RTcYAOY2Q2eiwmX4y90iOBMtFXQwm0BR1/utiPIf7x4MNPZVpep9q5q
         yRbdNQtkdlcVbyRc6JGsCNCR8IwuaGBTVkMY7WmDLGq3VQD1X3wFFOYPlY8jypLrPmqX
         cBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRZU6PWoecsaTBna8JJ1kT8KzujRo/SD4OzZ4b568hE=;
        b=URVwyX3X3Q7Dk5NT+v9hRzL3NC4/O/JiF+5s8iHyCjTKTZWe+QymrAKAd5CrP42sXn
         udaXrWiyY9Nzr/lzOfVetzVBsAV/Fmb55vhCw/NRIVmRPYegkyIK4Mq7QJ5uSFMKP91n
         egpkbB0uohB1LuqY9YfIrww0kPAFC7U2FgjSdFKzAK6Y+OIYECwvwjpIuMdAW6EZMPfe
         NHf2xXNvlUg0eNNBsNimmaANz2uPsVFtnEyWfFZ8gwuqUY0u+L7nJHpNBAwc3r9F9fr0
         8HCs5dQLxKaZpqVZXdDrtIC9Az48xhRCt97fJd7fKiAmAtJOYjCOQPers+U3HMWJmdUH
         pymA==
X-Gm-Message-State: ANoB5pkX6OVJZVNpwLslNr/54URxW+WJHN90eze2I6/gpclB6MbacWYI
        rBiEu8sft8HJcqHCRY4OVsV/jylsDbI8d341Qh4uC3AdInU=
X-Google-Smtp-Source: AA0mqf6b7/gIuq3+Z6seU3BJRM0gTjpHgNiTM88Qzs5hUflZFZJkurYm8yM0HnjQqAA8WnqOPUzu76LwEiQukSMvCjg=
X-Received: by 2002:aa7:cb96:0:b0:461:bacd:c85d with SMTP id
 r22-20020aa7cb96000000b00461bacdc85dmr7193461edt.278.1668800846992; Fri, 18
 Nov 2022 11:47:26 -0800 (PST)
MIME-Version: 1.0
From:   Sergey Ivanov <icegood1980@gmail.com>
Date:   Fri, 18 Nov 2022 21:47:16 +0200
Message-ID: <CAJCbrz5+LC9g34x0E_2HAezFNaMGW7ECSA9iXpHgnAHGoQNzHA@mail.gmail.com>
Subject: bug report: add/delete instead of rename
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened?

hard rename of files and directories via 'git mv' . git status before
commit for some related files:

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)

new file:   sepolicy/private/file.te
renamed:    sepolicy/components/icl_infotainment.te ->
sepolicy/private/icl_infotainment.te
renamed:    sepolicy/common/hal_icl_infotainment.te ->
sepolicy/public/icl_infotainment.te
renamed:    sepolicy/common/file.te -> sepolicy/public/file.te

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
modified:   sepolicy/private/icl_infotainment.te
modified:   sepolicy/public/file.te

What did you expect to happen?

All related nodes are renamed during commit

What happened instead? (Actual behavior)

delete mode 100644 sepolicy/common/file.te
delete mode 100644 sepolicy/components/icl_infotainment.te
create mode 100644 sepolicy/private/icl_infotainment.te
create mode 100644 sepolicy/private/file.te
create mode 100644 sepolicy/public/file.te
rename sepolicy/{common/hal_icl_infotainment.te =>
public/icl_infotainment.te} (90%)

What's different between what you expected and what actually happened?

Instead of renaming 2 more pairs of create/delete formed.
It makes harder to see changes on gitlab UI after push.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.0-23-generic #24-Ubuntu SMP PREEMPT_DYNAMIC Fri Oct
14 15:39:57 UTC 2022 x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show


-- 
Kind regards,
Sergey Ivanov
