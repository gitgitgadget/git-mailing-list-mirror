Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F2B20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeLNKQB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:16:01 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38440 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbeLNKP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:59 -0500
Received: by mail-oi1-f176.google.com with SMTP id a77so4144262oii.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nmIEyVmsRumPkS1JyQ8aB/i+Y173NcWyJSR7ofDj8mw=;
        b=Rnugm0hFNdhOS4PMNBV6ngD4doSGXHAwyKn+/UQZBZ5aDd/Gx86nEQjON0NziqPbKz
         LcJNsAqGl27XocnlX011s1sR4Tm7iA891W0nZ81nNQJyGeWw20+iiH0ucQrL1Rz6gWMj
         BHHwlFTFKsUdYqP+ByfjPHIIIuCwgjzfTnBFx6HRwBtk+C1HBC+ggZgFXmEnQo/+0rdM
         yR3wh92L4VkNqh3D329H7MBSB2rroQHqETdMBSvATp/bwyCwJEep2sGjpwacdmn55/N5
         OJLOEMTHc8RsskMP9ULVJPRplfxZHcLOHbIBsblRIKGA08ce8ZmRgQldmgcEB+9ZAJx2
         ULog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nmIEyVmsRumPkS1JyQ8aB/i+Y173NcWyJSR7ofDj8mw=;
        b=pRvqQLH8buOoTHYGP6GbqDaSQm1wPCdZCq9sq09LQGVui0gfVoQi7m4aI3P97C/38X
         qa/K2lnoJ56zWIgiS7tsRavh+cdl1ZlabgNS90UTVWCbqOgUJ1xW1sq2ZsRes7leNqIi
         cLn6MrZv8HrozD7Xzuq69cP84ab0owPx7QK8f25qliAOiJ7QuwaQYPhu9tILP/07SDaj
         tj0CRipqSllq+n2bi3TDXnG6oAO8AI+4N7SrZzjpFMGYaIMXSmFpriTtwbYTgUXM5LwG
         GulwWm7YpFwpVbZmSk2dGDaKC0Hyxcpa6pDx1WFY11+viiQQuJcaonRkPeiOQV32/9nC
         xJLA==
X-Gm-Message-State: AA+aEWZsmYE7l0/xIXaF1tX56+kul3wuDWNvCdQgJ+N8I++9juv7B7tg
        gZ5KHWD/brmUBtUkCHUr2bKdNudrXYmdGZjS7pRwFA==
X-Google-Smtp-Source: AFSGD/WC9Tw2gxw10dNM10chL4GTT9vi1TZtAmDBkrvslgXtbhbM6bNPmSGNVorcpWuSCusaHTmPyrRJeaRaHpbbesM=
X-Received: by 2002:aca:c382:: with SMTP id t124mr1468956oif.220.1544782558168;
 Fri, 14 Dec 2018 02:15:58 -0800 (PST)
MIME-Version: 1.0
From:   Christian Halstrick <christian.halstrick@gmail.com>
Date:   Fri, 14 Dec 2018 11:15:47 +0100
Message-ID: <CAENte7hRCk+3E+C4LYOjTzQKdqE1wN1=HX7YkR72H+HD-=mj5g@mail.gmail.com>
Subject: git-apply working on an index with smudged entries
To:     Git <git@vger.kernel.org>
Cc:     thomas.wolf@paranor.ch
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see that when I call "git apply --3way ..." on an index which was
previously created
by JGit and which contains smudged entries the command fails with
message "error: foo.txt:
does not match index". If I do a "git status" afterwards and then the
same "git apply --3way ..." it
succeeds. Looks like "git status" corrected the index in a way so "git
apply" can accept it.

Question:
- is this because the index which jgit created is so corrupt that only
special commands
like "git status" can repair it?
- or is "git apply" not trying hard enough to consume a index with
smudged entries

Here is the trace of a script from Thomas which shows the effect:

> git --version
git version 2.19.1
> jgit --version
jgit version 5.2.0-SNAPSHOT
> git init
Initialized empty Git repository in /Users/d032780/tmp/a/.git/
> echo "foo" > foo.txt
> git add foo.txt
> git commit -m "Initial commit"
[master (root-commit) ff6c56c] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 foo.txt
> echo "bar" >> foo.txt
> git add foo.txt
> git commit -m "Second commit"
[master 2191919] Second commit
 1 file changed, 1 insertion(+)
> echo "baz" >> foo.txt
> git add foo.txt
> git commit -m "Third commit"
[master d863c4a] Third commit
 1 file changed, 1 insertion(+)
> git diff HEAD^1..HEAD foo.txt > ../foo.patch
> jgit reset --hard HEAD~
> git apply --3way ../foo.patch
error: foo.txt: does not match index
> git ls-files -sv --debug
H 100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 0 foo.txt
  ctime: 0:0
  mtime: 1544782273:0
  dev: 0 ino: 0
  uid: 0 gid: 0
  size: 0 flags: 0
> git status
On branch master
Untracked files:
...
> git ls-files -sv --debug
H 100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 0 foo.txt
  ctime: 1544782273:797529188
  mtime: 1544782273:796936707
  dev: 16777220 ino: 64184423
  uid: 503 gid: 20
  size: 8 flags: 0
> git apply --3way ../foo.patch
> cat foo.txt
foo
bar
baz
>
