Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5336C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0D20787
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGTGTSL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgDBKPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBKPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so1651335pgo.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMSRF469JDZBvNL87F9oWUUdR93snpFvDgxk0L3o3O0=;
        b=pGTGTSL3iPvdYKrfvi3K+7a+OstuHOSLSCpwcqvjzpSosyLcwQqFUM+GgSxE7iwj19
         6UB0V5pSA9RYMiV52FmE3LVzd7iDnQwBUhyOB+GR8SZ+AHSiAQX4Ww8m4mVG0Ri/0Nyt
         e6C0/StYqDx/m0CQl40pHMgpq7luTuXedst/ZlIAw9lv8Sz8Io9D7DvqKp/Nowufu80P
         +gSV/VdwIApt6cS6S15RubSMwWtRtDrTDPhmIQJSZ0cQ+dMOz8kHBQUuiZJPahcmIep5
         IN2ic8LTjQT/DHeFiAZvb1VhN7KXSyh03SEQ9RQ8ikQBgoQodKzF40G+qb9+YUZs9x38
         zm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMSRF469JDZBvNL87F9oWUUdR93snpFvDgxk0L3o3O0=;
        b=RrPeAxgp2Knt7eSNukMep/fyIoqNvkS97ck8bXygWNZD/I8vNZMgIPeIRib3C4KBbV
         Y0o55Awy87PcrOZsw++gPhNfOZ3f3U55MQYMnXkypP9dXRMaGU0zsVqEQ+pknc1nQ7Hk
         z1o7MkiEOpq1hkUkT6+S4o+6wN4eaU6WofBSUTnPHhtIfcajqibEJ9NuSrBRcJ2btiRc
         n96w/7B4XFrEOBNiHivKSyKf6y1pq3R4/diOB+HUAxZHqeYDAVTkl5smKlZff3hE5hYI
         Q6oWKpDqKoqKFVtg0/YhK49zrUhq+mD6WOc7lvwHz+HN/+eMSNw6nDdLzyOPPxr5ugqu
         JGgQ==
X-Gm-Message-State: AGi0Pubtwb5m2Y4/K+xnxCEqUhvd6W1COCRTZbzf6mP7YH6qVRg46oHO
        aCL2p/XYJY0TrnGfwXzs/Y3k13i/
X-Google-Smtp-Source: APiQypKwQZegjSORTWRHURnKWOb8+cgcrH7gyZtaCzTgWVb+0rUt3Xu6QGVAjQ/NiED6he3EgKE9sg==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr2541092pgh.53.1585822546155;
        Thu, 02 Apr 2020 03:15:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Dominic Chen <d.c.ddcc@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] Honour and Document --no-gpg-sign
Date:   Thu,  2 Apr 2020 17:15:29 +0700
Message-Id: <cover.1585821581.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <20200331064456.GA15850@danh.dev>
References: <20200331064456.GA15850@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand `git commit` supports a `--no-gpg-sign` argument, which is
useful incases where e.g. a GPG key is specified in `.gitconfig`,
but is located on a hardware key that may not currently be attached to
the system.

Multiple commands that understand --gpg-sign but haven't understand
--no-gpg-sign, yet.

Also, document more commands that honours --no-gpg-sign

Change since v1:
- FREE_AND_NULL as soon as possible
- update test code for rebase --no-gpg-sign
- revert (--edit which is default in tty) now honours --no-gpg-sign
- cherry-pick --edit now honours --no-gpg-sign
- add more documentation

Đoàn Trần Công Danh (5):
  rebase.c: honour --no-gpg-sign
  cherry-pick/revert: honour --no-gpg-sign in all case
  Documentation: document am --no-gpg-sign
  Documentation: reword commit --no-gpg-sign
  Documentation: document merge option --no-gpg-sign

 Documentation/git-am.txt          |  4 +-
 Documentation/git-cherry-pick.txt |  5 +-
 Documentation/git-commit.txt      |  8 ++-
 Documentation/git-rebase.txt      |  5 +-
 Documentation/git-revert.txt      |  5 +-
 Documentation/merge-options.txt   |  5 +-
 builtin/rebase.c                  |  7 +--
 sequencer.c                       |  2 +
 t/t3435-rebase-gpg-sign.sh        | 71 +++++++++++++++++++++++++
 t/t3514-cherry-pick-revert-gpg.sh | 86 +++++++++++++++++++++++++++++++
 10 files changed, 185 insertions(+), 13 deletions(-)
 create mode 100755 t/t3435-rebase-gpg-sign.sh
 create mode 100755 t/t3514-cherry-pick-revert-gpg.sh

-- 
2.26.0.334.g6536db25bb

