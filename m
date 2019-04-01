Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26FDB20248
	for <e@80x24.org>; Mon,  1 Apr 2019 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfDAOO3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 10:14:29 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:35727 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAOO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 10:14:28 -0400
Received: by mail-ua1-f53.google.com with SMTP id f88so3118594uaf.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5KnA5rJ4YPx0u6aCB+eq89tZqlSkmOJ20CK6sCbrHr4=;
        b=EgXiXsBlUCFPyqwCGKBtII4FkroCnB1kT/74Yc9aVXrn0A7V3fiZher/wKtXM5oR32
         TENmhT4hym492nSZ6bW0AOOpsolJQUx6ibziRVj7QtNW/zzk8q34nor6OhFilY52aNMV
         40Zn4nL95SDWNgiR99NOMMPKgHyFqZDfM+9c4wjZ9IecLkhyX4Rrur4CACmVTpbo9Puz
         A2tJmrIkpke83lqI6yJgAz3KpcCRdmZBW7Id7S/9kkLZ2YGDSWI3wVtdfNDgZ3V+wnL1
         6IN9UdD96QOmht5N/Prmy+OwFhUkM/mNi8AdPj71C+rtkVYAP+otKFwz5aitpN2Gcn1l
         ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5KnA5rJ4YPx0u6aCB+eq89tZqlSkmOJ20CK6sCbrHr4=;
        b=uEJbg3smxcEq2uut62uS49yI0OBCqj0tghU+96MTSCpvzxLxfE0gqu84C8GiB14BxZ
         0hSF8+Z+UVctfgGm7zhqLcYz2hlVV6T1aHhlsi5/9iAM5QDzjqRq9lZENeMpjMUIB+PE
         M+hwCTHzSpADwb8yBgYjYyGVnkgv0lKqDmH9k+rgQLUT4dk0Fc+NFiho5u825vuk3yMG
         kMYZqsaxIPMSS244bLRJxY8iUs7/jLebISu8e9RI3HFGnqmizzIqsUgV8U/4Jrf0DY0l
         Iamnj6LNq5kRMJNEf7lX1JRIL+NasOn6bdAZluNDdhaXO7gsM/Au60t20GO41gmdinwJ
         tsTQ==
X-Gm-Message-State: APjAAAX/vExE7aTavegoG1y1M+TC9e7FJPkCGT+0kR3025MDwq1jrLLX
        KenmQEgVrUJlL2/Gy1AfzYAo44XPPJmPS0tCuOInjwNa
X-Google-Smtp-Source: APXvYqxyKiNJ57Iu/fDpTm6iyMijanFNcvC34+x8qiq3fSb3bu4l6r8CYHcWZ+IRY3LTaUjhXPZ8jzy7Lg6hixYcNPk=
X-Received: by 2002:a9f:2a8d:: with SMTP id z13mr37326651uai.62.1554128067427;
 Mon, 01 Apr 2019 07:14:27 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Mon, 1 Apr 2019 16:14:16 +0200
Message-ID: <CAODFU0osBF5RCe-gwEJiPOd90nqdnFycmWSEq-2EaLVQMeRpcw@mail.gmail.com>
Subject: GIT_DIR not passed to script if hooksPath is set
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000065664d058578a36e"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000065664d058578a36e
Content-Type: text/plain; charset="UTF-8"

Hello

If git commit executes .git/hooks/post-commit it will pass GIT_DIR env
variable to the script. However, if hooksPath is set in
$HOME/.gitconfig, git commit executes hooksPath/post-commit without
passing GIT_DIR env variable to the script.

Expected behavior: GIT_DIR is passed to hooksPath/post-commit
Actual behavior: GIT_DIR isn't passed to hooksPath/post-commit

Please run the attached shell script in an empty directory to
reproduce this issue. The script is using strace to determine whether
GIT_DIR is passed to the hook script. The script will run "git gui":
the user is expected to simply commit changes from the gui and then
close the gui for the script to finish. The script is exploiting the
fact that (currently) command-line "git commit" and graphical "git
gui" commit are invoking different commit hooks.

Script output:
  - !!! missing GIT_DIR in git-commit.strace
  - execve(".git/hooks/post-commit", [... "GIT_DIR=.git" ...

$ cat ~/.gitconfig
[core]
    hooksPath = /home/atom/dev/git-hooks

git version 2.21.0

Sincerely
Jan

--00000000000065664d058578a36e
Content-Type: application/x-shellscript; name="a.sh"
Content-Disposition: attachment; filename="a.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyfpqkz0>
X-Attachment-Id: f_jtyfpqkz0

IyEvYmluL2Jhc2gKc2V0IC1lCgpncmVwIC1xIGhvb2tzUGF0aCB+Ly5naXRjb25maWcgfHwgeyBl
Y2hvICJtaXNzaW5nIGhvb2tzUGF0aCBpbiAuZ2l0Y29uZmlnIjsgZXhpdCAxOyB9CgpnaXQgaW5p
dAplY2hvICIjIS9iaW4vYmFzaCIgPiAuZ2l0L2hvb2tzL3Bvc3QtY29tbWl0CmNobW9kICt4IC5n
aXQvaG9va3MvcG9zdC1jb21taXQKCmZvcigoaT0wOyBpPDEwOyBpKyspKTsgZG8KCWVjaG8gbGlu
ZTEgPiBmaWxlJGkKZG9uZQpnaXQgYWRkIGZpbGUqCmdpdCBjb21taXQgLW0gImluaXRpYWwgY29t
bWl0IgoKZm9yKChpPTA7IGk8MTA7IGkrKykpOyBkbwoJZWNobyBsaW5lMiA+PiBmaWxlJGkKZG9u
ZQpnaXQgYWRkIGZpbGUqCnN0cmFjZSAtZiAtbyBnaXQtY29tbWl0LnN0cmFjZSAtdiAtLSBnaXQg
Y29tbWl0IC1tICJjb21taXQiCgpmb3IoKGk9MDsgaTwxMDsgaSsrKSk7IGRvCgllY2hvIGxpbmUz
ID4+IGZpbGUkaQpkb25lCmdpdCBhZGQgZmlsZSoKc3RyYWNlIC1mIC1vIGdpdC1ndWkuc3RyYWNl
IC12IC0tIGdpdCBndWkKCmVjaG8KZ3JlcCAtLWNvbG9yIHBvc3QtIGdpdC1jb21taXQuc3RyYWNl
CmVjaG8KZ3JlcCAtLWNvbG9yIHBvc3QtIGdpdC1ndWkuc3RyYWNlCgplY2hvCmdyZXAgcG9zdC0g
Z2l0LWNvbW1pdC5zdHJhY2UgfCBncmVwIC0tY29sb3IgR0lUX0RJUiB8fCBlY2hvICIhISEgbWlz
c2luZyBHSVRfRElSIGluIGdpdC1jb21taXQuc3RyYWNlIgplY2hvCmdyZXAgcG9zdC0gZ2l0LWd1
aS5zdHJhY2UgfCBncmVwIC0tY29sb3IgR0lUX0RJUiB8fCBlY2hvICIhISEgbWlzc2luZyBHSVRf
RElSIGluIGdpdC1ndWkuc3RyYWNlIgo=
--00000000000065664d058578a36e--
