Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A377E1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 12:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbfHVMcv (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 08:32:51 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37255 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfHVMcv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 08:32:51 -0400
Received: by mail-ot1-f44.google.com with SMTP id f17so5284991otq.4
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9GXOFpVwvhzjrmLPLLqWhZNLymYqeV2f4WTE1an73JU=;
        b=TBk12A79QUzbXJR3XiAbNkrF4OG7kfx+Aty7cu8uNc85Q7otGYkNvP09EQ5w2X09P/
         hK0nF4V69mqResYF5K7g4ehAHcHDI7bO5vL8orZW6opSVxcpM6yTeZnDysi08+WnTsam
         Yq5VOuIy3YjPghtxVYLgxVfK53L8cE+d421lnuy4bk1/VWHLcK0rtDkwzlGJR1mScwFQ
         sOJcGQFJnqGQX6U37yedXyDHydcAusJM8TFPjYwGNlmzuFoypekJhU4Jo26aUvQMdPKH
         nYBNZGM07kChK/YKUTFcGTmefb2L4RISMtKNJkLfSVa4DP1fbZQOw5ft37vrQ7F+Jt03
         Z2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9GXOFpVwvhzjrmLPLLqWhZNLymYqeV2f4WTE1an73JU=;
        b=Tp8l3kT3ODTNs4rQz7TgyOYxXqMe5C46eXEiDJJ8bNoDTZps9oqxMfmEQhtybXUXXY
         t7O3BwYy2NhMy78mAwWqnguwZrLrp1h1pKpyBCYMFgjMZlBiX2LlipBt6ea0ZsDm7bnZ
         GOfJswgvXPR0awU5PEYTcy3a/UlK2ptxXdbcGm4XNat6VlBQm0SqqrpIjaLlPv/atBU3
         dkrYbIs7X5TlvJYyVNj1hFG/VK7lrlnrz5vYrrKwoiAEDE/89I/pE2yRe7NO+fzXSYS3
         zwJ/c8N25lDcttMW7lRcyL22RxCTj0TdlLqF5lV3G2VATL0CHdKLp7jw3F5sjXr5NVP/
         yb/A==
X-Gm-Message-State: APjAAAW0TUwR1GD8FmbGsZMBKa4hQJXmPqF+ujaCVOk9tU33ZOh6a6Zi
        2tDMnVR3javUcchZVyA1d2D4vRR7Zp3R2JI0x7o1JzRH
X-Google-Smtp-Source: APXvYqxDQOYO6tHvUErcQ5G8GuE0nAAl+H8qR+NT7EwDG3oRF/X5J71xwjxVagcdYqEcKzMcfeZBicRjtxGJ/GJEDWo=
X-Received: by 2002:a9d:7087:: with SMTP id l7mr749334otj.281.1566477169968;
 Thu, 22 Aug 2019 05:32:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Date:   Thu, 22 Aug 2019 14:32:54 +0200
Message-ID: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
Subject: [BUG] You can't have single quote in your username
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note how `git log` discards the ending quote character:
```
root@NBR1710R:~# git init repo
Initialized empty Git repository in /root/repo/.git/
root@NBR1710R:~# cd repo/
root@NBR1710R:~/repo# git config user.name Les Actualite\'
root@NBR1710R:~/repo# cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[user]
        name = Les
root@NBR1710R:~/repo# git config user.name "Les Actualite\'"
root@NBR1710R:~/repo# cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[user]
        name = Les Actualite\\'
root@NBR1710R:~/repo# touch foo
root@NBR1710R:~/repo# git add foo
root@NBR1710R:~/repo# git commit -m 'first'
[master (root-commit) a78e11f] first
 Committer: Les Actualite <root@NBR1710R>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
root@NBR1710R:~/repo# git log
commit a78e11ff0707bd4f1bea195735a7fc8b7ee2b9f8 (HEAD -> master)
Author: Les Actualite <root@NBR1710R>
Date:   Thu Aug 22 14:25:11 2019 +0200

    first
```

I can't test with the development tree right now,
```
root@NBR1710R:~/repo# git --version
git version 2.17.1
```
