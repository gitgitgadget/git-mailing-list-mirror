Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EF71F51C
	for <e@80x24.org>; Sun, 27 May 2018 06:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeE0Gvk (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 02:51:40 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:38343 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeE0Gvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 02:51:40 -0400
Received: by mail-ua0-f180.google.com with SMTP id y8-v6so6005242ual.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/T12mdbvm8SIOJlmMeb7g/TWefyoNcbhtBUBCiuSDOY=;
        b=fpfOCefrmlaDxW+Dxigeu4e8+NJwZ1UXm8PaZGwIgyzz3/pCOWjOBUTVdaBkHKFOjF
         DA32ZCUYM9BpTygreGA+WJX6X6g92yx9MwvSUWIkcAlelo3ZcfY5B7ycstlV3Nfepj/b
         38qDEsyFUn5xH82zqDdA+Q6cQpsK4qUJl4disJb3r/2HvyebuWLQziS5YUcWeYCuwpMl
         UTrL24xA4isgifwNPMuzfTPkUdrIg79fzTsXB8xIeuzA7rYcM8tEokHFhWAt7nV4+Eyx
         gR7AUHjmz1x91sIonaYO32G06iC47SvO4WKXRH8NrtXH5HbplqrCIPbtRk6d43SMjQxS
         H5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/T12mdbvm8SIOJlmMeb7g/TWefyoNcbhtBUBCiuSDOY=;
        b=jRxHu7/xfAV7l9XuX6oT/rd32JOc34dKfMAieWip79dyJ9tJieWb/WKz37j+2+jkQp
         NjJzEtUElidXo4ZXkRome0gqTb5OFm+myPVrqiZcXVRDsL2rrDt0mk4sxDPbuT9L8DGj
         PSKNuEn5dA8Lr3x3GfcOkrNqk0xS0U4EIkMRdcUgD6/8FdigNALqm3xjHRhozaP0xPYM
         8vyONA1Sf9T1XjMV9aG6gIAD3GuIptBJfexoe9nGw5MSV/JAl7I9U7jgb0wRnqx9SoX3
         CtMbmi+BBa/qE/KVrbBTPpF6V13GjsX7LKpxYJlUrLZQHtCxyG9oeFAz7hTWLQN9KmT/
         f/yA==
X-Gm-Message-State: ALKqPwfFkeacGb4ihUhph5BmexY0lr0ri5VpWJUeeCAd6zXP2P0+0NC8
        bPMVWdDSrEwAr8bxgiIhTe457QFmXiBnPUeMcf1j5w==
X-Google-Smtp-Source: ADUXVKL2NpXUoAt3RoOdBpuXlddpsnnhKwPhfxTIS0bJeLrASvkZByr8XBzb0n5Edwz9O9jbpJXWb6e5LK5c6O9dSMw=
X-Received: by 2002:ab0:195f:: with SMTP id u31-v6mr5496594uag.123.1527403899132;
 Sat, 26 May 2018 23:51:39 -0700 (PDT)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 27 May 2018 09:51:27 +0300
Message-ID: <CAGHpTBLGmApTGsjeP2d93CWH=OWBXmbPdRrGxaobFRcSjUiuYw@mail.gmail.com>
Subject: [PATCH] git-rebase--interactive: fix copy-paste mistake
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

exec argument is a command, not a commit.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
  git-rebase--interactive.sh | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cbf44f8648..85a72b933e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -160,7 +160,7 @@ r, reword <commit> = use commit, but edit the commit
message
  e, edit <commit> = use commit, but stop for amending
  s, squash <commit> = use commit, but meld into previous commit
  f, fixup <commit> = like \"squash\", but discard this commit's log message
-x, exec <commit> = run command (the rest of the line) using shell
+x, exec <command> = run command (the rest of the line) using shell
  d, drop <commit> = remove commit
  l, label <label> = label current HEAD with a name
  t, reset <label> = reset HEAD to a label
-- 
2.17.0.windows.1
