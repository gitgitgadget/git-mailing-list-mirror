Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DABE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDAN5a (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 09:57:30 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:34198 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfDAN5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 09:57:30 -0400
Received: by mail-ua1-f43.google.com with SMTP id c6so3098935uan.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DJSlER9cFsUlC6iKxG+jxRSBfDmfBWDqiHagB2IhsCM=;
        b=JmA28Y6X2LPRh2UFGpaqfg0AWWRNmqcemPvrEk0B+ERRWksEZSQJcWXd/KEDJBeBej
         NbGLab3VH7ln4LEuHnY8KZt+x6Mkq5fVF8iIC44B36kvqvedtWCtf7wUwUqx7wX1Ic4T
         oIOkr6LnHDuiQXaEiQDRoB6nCgcBIPXXBXa6yLStAuzaEW/Cro1DrUGp49FyhzRWDrOV
         JLgiXxjSc+FSXvwSbehmKWd1Ihw/rT3EDlRtS5yZErwfjyWVko4NYb77Rkn9Ve/WKtIR
         njIlOmYsbi6UCUhtBlz0sDh75aF2LZ58rrLBPFR4Hrcex3yxIpjWGT1rNlo3Zo2EylBo
         RkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DJSlER9cFsUlC6iKxG+jxRSBfDmfBWDqiHagB2IhsCM=;
        b=E7IbiNo1fwy+8yHSsd0PyaPj5a83aYmWQjVsH0Oo/6r2IKG8RjL6a3VKpn4pQCUEb/
         2P/K2BH5UMpWiHGhcjA4kKLIywlLy5AJAgY+d+wBx13py341ZgSC6LgBrNaBP6zvMRgQ
         10uWqcSQikGZPH6a7P+siLIqqDNu4+voLeTR7VcGVsTwTEDr/36xlfMt67KZ1odxeeaP
         bixMAzikRs1M5QKumSbWMNv6BZPeZ+/rkjnDrfXQCn+kFsVCt+MIDHv2Hy/rfbKpkrWc
         ox4Zl9eWHKTu2ucd9kJ6so7JEQQmCPdh3ORmW4JO+Uit/Y3f/JU+nDkbBwawLvTEi482
         gi6g==
X-Gm-Message-State: APjAAAUdKALDkRpvf55ftmGooQNuCbC95jOV496BFsQQ8az6x7roO96u
        9ld2jhdLNKNy1hGWyJNi89bDLoOEKHLzmqZOFtrkHTlg
X-Google-Smtp-Source: APXvYqwPYY+leDbIQu6z4D8SZj7EN0kFUZ0sooPuBN32sp3NWZ89R7Y0p93RJxBTW5RncsWMJJFhRoOy5qjyjy6WZUU=
X-Received: by 2002:a9f:2c8b:: with SMTP id w11mr35361328uaj.17.1554127048901;
 Mon, 01 Apr 2019 06:57:28 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Mon, 1 Apr 2019 15:57:17 +0200
Message-ID: <CAODFU0rSSeLReFKci_p3kjJwxD65R21syDTHoKcqWJ0wbF8jZQ@mail.gmail.com>
Subject: git-gui: executed hooks are different from command-line git if
 hooksPath is set
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000afb0f30585786622"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000afb0f30585786622
Content-Type: text/plain; charset="UTF-8"

Hello

Command-line "git commit" and graphical "git gui" commit are invoking
different hooks if hooksPath is set in $HOME/.gitconfig.

Namely, in my case command-line "git commit" runs
"/home/atom/dev/git-hooks/post-commit" - while "git gui" commit runs
".git/hooks/post-commit".

Please run the attached shell script in an empty directory to
reproduce this issue. The script is using strace to determine which
hook is being executed. The script will run "git gui": the user is
expected to simply commit changes from the gui and then close the gui
for the script to finish.

Script output:
  command-line: access("/home/atom/dev/git-hooks/post-commit", X_OK)
  gui: access(".git/hooks/post-commit", X_OK)

$ cat ~/.gitconfig
[core]
    hooksPath = /home/atom/dev/git-hooks

git version 2.21.0

Sincerely
Jan

--000000000000afb0f30585786622
Content-Type: application/x-shellscript; name="a.sh"
Content-Disposition: attachment; filename="a.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyeudv00>
X-Attachment-Id: f_jtyeudv00

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
--000000000000afb0f30585786622--
