Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE1C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 12:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933386AbeAXMTO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 07:19:14 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:41657 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeAXMTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 07:19:13 -0500
Received: by mail-it0-f45.google.com with SMTP id b77so4991847itd.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8X5fMiTj3wHleyxMXVzgelTXI0ZYeH98Gvv/NSAGgn4=;
        b=PR+M63TFOtOMLpSoJ3DAQUNPAmC5yCAFpJYsswLb64orj3prOgDfFQMrfLNfVgGXFy
         Z7Jwm33dp2DhftbpGJD5EGu3RTJi7hfSl0Dl00tMOAFqYHRkOy81n4NBgY0kDRkV9ZOS
         kbop+CQy55774Po6/P57KeDQxYU1h7bz77FnE+cqNlHuk2i5psYObClrVu0wrMu4wfrq
         FXVvPAn5oV19LTjy7OinskdSnOXy5cyChINF1XD40jzqJW4dRmxMNr3SfHgVDQTMEFDe
         mG8qRNlPS5hHhwCL1m2/RErGKsNVUgA+ULvhG+DJTrreljLMeRrLWDlBlNjnj7go8A8m
         Y7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8X5fMiTj3wHleyxMXVzgelTXI0ZYeH98Gvv/NSAGgn4=;
        b=IEB7ytm8W14E86b7Z+WkxHx29ZcT+T9q9sUIMSEbpI4ZGoRxAeVOtSJHgj9cVreImd
         cXyWzGWglOwmKadJcJaowxkS8Qd5Ap4dpNnbT9HuAIuWCDPoa3jdj2FPX/dQU14VppPk
         ORy/kYrxHgMOmkYgsKz1L5E8hVg/OmpwGs9n2GlvQtYV0Za31PxUnvzvsaEZkoAJ7K47
         8vZiCFAa/bMiz4KEn+h4taH7XKnpkk0HKoycu9VkIwvE8TKANV5FMlsczRqRjuxW9zkI
         q+fB9mnueEmPxZfeJED4bqnTUq517xhlLhaj9Spz0njKEg2ADwi09IWZi4bYbRuQLBaG
         gGGg==
X-Gm-Message-State: AKwxytehpL5dI22hI9KQpCZ0uBWMfl7FmzHZeLD0PDB7zZiQxDWzm++Q
        BhV1sS0FoqrjGfY3wwgwEhnI2DR340MXnkS8QfkvTw==
X-Google-Smtp-Source: AH8x224XSJx5FPSy2R5PndrVK6lQy6RKBnLs0OGijg16pXcs5eENVcuF4pIV1tBiVkQkDQpMzo407tpD94hOsx9dJic=
X-Received: by 10.36.131.130 with SMTP id d124mr8780984ite.30.1516796352459;
 Wed, 24 Jan 2018 04:19:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.38.140 with HTTP; Wed, 24 Jan 2018 04:19:12 -0800 (PST)
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Wed, 24 Jan 2018 14:19:12 +0200
Message-ID: <CAPUT4mS+p+2n85dB-iWtae+0SDkUoYA5bqtUs+6OaFchjJJeuA@mail.gmail.com>
Subject: [BUG] git pull with pull.rebase and rebase.autoStash is not working
 anymore in 2.16
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like regression in 2.16.
Worked fine before update.
Seems like git stash is not always working.
Any ideas?

$ git --version
git version 2.16.0.windows.2

$ git config pull.rebase
true

$ git config rebase.autoStash
true

$ git status
On branch develop
Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   source_work/xxxxx.cpp

no changes added to commit (use "git add" and/or "git commit -a")

$ git pull
Created autostash: 7ddcdf2ba
HEAD is now at ba14a4c3f some commit
Cannot rebase: You have unstaged changes.
Please commit or stash them.

$ git status
On branch develop
Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

You are currently rebasing.
  (all conflicts fixed: run "git rebase --continue")

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   source_work/xxxxx.cpp

no changes added to commit (use "git add" and/or "git commit -a")

$ git rebase --abort
Applied autostash.

$ git stash
Saved working directory and index state WIP on develop: ba14a4c3f  some commit

$ git status
On branch develop
Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)


        modified:   source_work/xxxxx.cpp

no changes added to commit (use "git add" and/or "git commit -a")

$ git stash
Saved working directory and index state WIP on develop: ba14a4c3f  some commit

$ git status
On branch develop
Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean

-- 
Sincerely,
Dimitriy Ryazantcev
