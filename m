Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E171F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIRCEY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:04:24 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38158 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRCEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:04:24 -0400
Received: by mail-wm1-f47.google.com with SMTP id t25-v6so90062wmi.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mnwDmQQPCHYs8uTamYn5QRLHgXIlXvooUvoR81eofKs=;
        b=FnL8dGwgPlo8413owVYyZRW6MuaUduQYRriFUfHYXtWQpW7WpUxBrWm6QKJUYHgGN9
         PMr8XrC3beuNVwqMOoVxCnKvpPUHUwjfxZ6juyQaLsMz+96rkJX09Oz1asz1zyJ1dI5e
         x86T2DSFQ3N5Au/fuVkMaJLBl91T/qtX00+C0tr9h9FuY/r15ZHCHJujYSkuTcepkk6O
         JQt4RMc4bJt3PBD1KGUVHZ9Qdfxs7k7SbYbNsDpN8/csG3nh5ug53JF/Y7JguEB9sxUS
         5P/k1VCGIWz55+SgH6l34xJNPoayBcL+FuxR9dL5TPwS9vIAxcTSQuFuCT4v8N80ZhZ3
         wQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mnwDmQQPCHYs8uTamYn5QRLHgXIlXvooUvoR81eofKs=;
        b=WW9vId4AQp2iMrepu94iUbLaypD0+Zltgv4wAkzzkMAfPXePe0vMjduTOh7DRCDgrK
         7evYX8odx+fShKiTRC41069CoKOQZnqcrlUuZPoQ524DL4LPvxyCDKJbA/aYDqaYSNF1
         hKE04dR5LXKiRdPCvoTVJaWEEg5OiK/OW89fwwa3/FDcMtYTdI92uG8wI8Hv9f1uNGgS
         mgU2KX0743sW6nRNPYhj69JbG3Iq4Po52B51AaoQ5EtFXzOE2E3DmEqqbpHgUR4Ec0/M
         cdhxuZC6iNgXKuT3r9kvBEtwvZgUy16MTQoDhVm49oYiK9aZHTN4DsQ47JYbpfFvVjCH
         Txzw==
X-Gm-Message-State: APzg51BrFIlHo+YpM3DHNjc67xQ+f5EEV+oYrMnqWlNMb8/3DvAEaSZu
        uQ8cfeDbIumenQgf7ZCyJYdHzkmXfBTzflk7hQmq37f4
X-Google-Smtp-Source: ANB0Vdb9vBDnA3OtHD8VQ0/t9rwD+XtIA+w113u4Vly+0AefKtef9StVzS9QyooZfXXWz3zHjS4EUpggtLdT23OPPbE=
X-Received: by 2002:a1c:a745:: with SMTP id q66-v6mr13027575wme.49.1537216526804;
 Mon, 17 Sep 2018 13:35:26 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Matrosov <mikhail.matrosov@gmail.com>
Date:   Mon, 17 Sep 2018 23:35:19 +0300
Message-ID: <CADhDkKwHp0dR7PPLV6UZDmSO9ERW7Opym3FSD64XXTg-QK65bw@mail.gmail.com>
Subject: git pull --rebase=preserve is always rebasing something, even on
 up-to-date branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please try the following:

mmatrosov@Mikhail-PC:~/test$ git init --bare server
Initialized empty Git repository in /home/mmatrosov/test/server/
mmatrosov@Mikhail-PC:~/test$ git clone server local
Cloning into 'local'...
warning: You appear to have cloned an empty repository.
done.
mmatrosov@Mikhail-PC:~/test$ cd local
mmatrosov@Mikhail-PC:~/test/local$ echo a > a && git add . && git commit -m A
[master (root-commit) a34c21f] A
 1 file changed, 1 insertion(+)
 create mode 100644 a
mmatrosov@Mikhail-PC:~/test/local$ git push
Counting objects: 3, done.
Writing objects: 100% (3/3), 205 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /home/mmatrosov/test/server
 * [new branch]      master -> master
mmatrosov@Mikhail-PC:~/test/local$ git pull
Already up-to-date.
mmatrosov@Mikhail-PC:~/test/local$ git pull --rebase=preserve
Rebasing (1/1)
Successfully rebased and updated refs/heads/master.

As you can see, running bare "git pull" just tells me everything is up
to date. However, running "git pull --rebase=preserve" triggers
rebasing of something. It wont be a problem if it didn't take
significant time (especially on Windows). Why this rebase happens? It
is completely redundant and slows down the pull operation. Looks like
a bug to me.

Note that it is important to me, because I want to set "git config
--global pull.rebase preserve". But because of this issue, pulling on
an up-to-date repository takes a lot of time. Which is very
frustrating.

Tested with:
* git version 2.19.0.windows.1 in Windows 10 Version 1803
* git version 2.7.4 in Ubuntu 16.04.3 LTS (inside WSL)

-----
Best regards, Mikhail Matrosov
