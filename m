Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BAD1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfAHHZU (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 02:25:20 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51003 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 02:25:20 -0500
Received: by mail-wm1-f54.google.com with SMTP id n190so3082317wmd.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 23:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=jjD3jiad7o055rsUajT/1ixD0kL9sRdKD9XSIfjfNu8=;
        b=P5aXfAqpw0tHeqhhsJ2ww/U23VyrMeafJUpvsPM5B4BvsEyQ56TAXJIWxr16qE88W4
         gFR9E9ONGGkMu49HB0n4d1TCPcCQ0LAiY6WpEdDX/WLmqbjHZZfkcAO9wcN22PSjMa6U
         O7g7DyL8OA3OZ5xILUFiJ7NXArJrDnp5NoAL4yGao7vjidEQP957k+asIMP3F2TnSgkt
         WbxXdHIKZBZ/hj7D5cjRI8VVxgvcwj0zeJLOoj66P/rF814uhhI7nS2U2pWJASoUASdA
         3eB92ExMfbCcWQj68vqsPw5TtkGpXl90nc3kXAYExEAMLBl5jTwSjUUkgbtcKugtDAIA
         f4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jjD3jiad7o055rsUajT/1ixD0kL9sRdKD9XSIfjfNu8=;
        b=oaz6L0aILteGjbDPtBLh4r8REJTEBv/Vx0sIbwX6pyigRcMh9vCi0ECIg5LAc6SUII
         J7DXyinzCqzPiNkDleTeCaB1l/XsWPqt+tX+u0bJ+IV0ujrSMcGMWEUtbjZ291ya31il
         EaCfuwYm+vAJzsvbZFRhsD9zRGY7wU4Wfz4yxlkTEfWrDeswlukW2vndh8n1bubDQU7x
         lFwbl+WFX9AKC0bNAIzf7z3cCU+X54ProqiGHYGlza7+NnucLcV8iX0SzbGkyCaeAKsa
         McX+XhE/L8jPFxg1/7E7PvDMZlh26H2cXa9QFDMzmD+/Torl8N8lJk2UDa4NRiN/ry6i
         +Gsw==
X-Gm-Message-State: AJcUukcBSJLGB/OG0AD6LibORDCP1yVHzuUfBYNYY2nM9aTOTlMBo1K8
        5fZuU7lT8W3QLkenZifCqsdSjqDBbFm6EAvsV5dhnLnSoVM=
X-Google-Smtp-Source: ALg8bN5B24MD7rM32VbpmRJ1HV0k7q6VHqHu9dY3PHot/5lGSSpFT/d2R/6ZwBdrg4cdIXkMrV5ybE8eAgK9ulOgn9M=
X-Received: by 2002:a1c:8484:: with SMTP id g126mr830205wmd.117.1546932317834;
 Mon, 07 Jan 2019 23:25:17 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 7 Jan 2019 23:25:21 -0800
Message-ID: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
Subject: `git reset` for delete + intent-to-add doesn't reset
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

```
git --version
rm -rf t
git init t
cd t
touch a
git add a
git commit -m "add a"
git rm a
touch a
git add --intent-to-add a
git status --short
git reset -- a
git status --short
```

(the git version below is compiled from
ecbdaf0899161c067986e9d9d564586d4b045d62)

```
$ bash -x t.sh
+ git --version
git version 2.20.GIT
+ rm -rf t
+ git init t
Initialized empty Git repository in /tmp/t/t/.git/
+ cd t
+ touch a
+ git add a
+ git commit -m 'add a'
[master (root-commit) 95a1815] add a
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
+ git rm a
rm 'a'
+ touch a
+ git add --intent-to-add a
+ git status --short
DA a
+ git reset -- a
Unstaged changes after reset:
A    a
+ git status --short
DA a
```

Even `git reset --intent-to-add -- a` or `git checkout -- a` don't
seem to clear the `intent-to-add` state

How do I reset the intent-to-add status in this case?

Anthony
