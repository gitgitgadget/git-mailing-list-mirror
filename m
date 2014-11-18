From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 0/7] ref-transaction-send-pack
Date: Mon, 17 Nov 2014 18:00:33 -0800
Message-ID: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY65-0000pa-EP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbaKRCAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:45 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:39984 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbaKRCAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:44 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so3119708iec.11
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fRzXwcMlfZInPsQPJfSUQwZl5FrsZs3u2dEfZUZD+40=;
        b=isHSaRrrcVe76R8E4Th32mR04W2FLGENUzlIgJcaEEFWiaOiwXvVMRXDyiai6aXwV3
         i+bCUo5T8/VZikvzE29f1nB8DJVIC2asiH+r1BP3TGkNpFvya84dOgB0BB572jmIOLYh
         hmtdfx3kjQOfZFSwqY9J22gUnQwZBTJAB3DrmXLLFhI7hssch2YNyZRpk0Z+pJhNmW+T
         l0Ur8c4q2QqBi/cgNn+w0A02iyhaR1cG5dRK0qf+EEeuF6bmulHC5dMORaWc5iIDiNMR
         KJxJ7Q5PvrMTZztrqmQAtwDg+ilhOWgbMTZkRlhFjrXPHqOYfaOh445gObiBpENizOf/
         Y70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fRzXwcMlfZInPsQPJfSUQwZl5FrsZs3u2dEfZUZD+40=;
        b=YPjsE9WmYvoPRaprihHRoGZpXxmucXa6JZIdeN9DQg3Ok15FfRbdlPN/z2QvyHNdEw
         E06M5hk7/KJ9kxdIriA9iLFTKgcpoM9wcgF4RJy6HKSYu88PUWKvEEgwt0DUD0LZFvCB
         7PxsA6pAyVSZHsQB3qhH2eKbQ5IzpJYf9TMKmKpbVIdVo6XZrRN69AwaQSkdrrnWsr95
         J5OEk+9OB16Shra7MOg64d026lfaW/2AHK54n7ilAZE1xOUAI2sER6JqM5OKbKh7o8W8
         CXbEhDiPmJDxdcgoIw2CEsuWSL7+23K4d0LMll98fKevC7opMVyYsijSG0OA1eMEvGo3
         /wIQ==
X-Gm-Message-State: ALoCoQm02KG+2KTvVDkc8ipf3k82WXmkTlgIubuHaAEFI869/kqDSH195hAH5T1piGjvFbl+9oN2
X-Received: by 10.42.239.208 with SMTP id kx16mr31479240icb.40.1416276043550;
        Mon, 17 Nov 2014 18:00:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id xb4sm6896001igc.11.2014.11.17.18.00.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series has been posted before[1], but is now rebased on the previous
ref-transaction-rename.

It can also be found at github[2] and googlesource[3]

This series finishes the transaction work to provide atomic pushes.
With this series we can now perform atomic pushes to a repository.

Version 2:
- Reordered the capabilities we send so that agent= remains the last
  capability listed.
- Reworded the paragraph for atomic push in git-send-pack.txt
- Dropped the patch for receive.preferatomicpush

Version 3:
- Fix a typo in a commit message.

Version 4:
* As Ronnie announced to change employers soon, he'll have only limited
  time to work on git in the near future. As this is a rather large patch
  series, he is handing this work over to me. That's why I'm sending the
  patches this time.

[1] http://www.spinics.net/lists/git/msg241365.html
[2] https://github.com/stefanbeller/git/tree/ref-transactions-send-pack
[3] https://code-review.googlesource.com/#/q/topic:ref-transaction-sendpack

Thanks,
Stefan

Ronnie Sahlberg (7):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add an --atomic-push command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  push.c: add an --atomic-push argument
  t5543-atomic-push.sh: add basic tests for atomic pushes
  refs.c: add an err argument to create_reflog
  refs.c: add an err argument to create_symref

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  12 ++-
 builtin/branch.c                                  |   7 +-
 builtin/checkout.c                                |  21 +++--
 builtin/clone.c                                   |  15 +++-
 builtin/init-db.c                                 |   8 +-
 builtin/notes.c                                   |   7 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            |  79 +++++++++++++----
 builtin/remote.c                                  |  26 ++++--
 builtin/send-pack.c                               |   6 +-
 builtin/symbolic-ref.c                            |   6 +-
 cache.h                                           |   1 -
 refs.c                                            |  93 ++++++++++----------
 refs.h                                            |   5 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  45 ++++++++--
 send-pack.h                                       |   1 +
 t/t5543-atomic-push.sh                            | 101 ++++++++++++++++++++++
 transport.c                                       |   5 ++
 transport.h                                       |   1 +
 22 files changed, 358 insertions(+), 100 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.0.rc2.5.gf7b9fb2
