Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A087B1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeDBQH4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 12:07:56 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:47058 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeDBQHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 12:07:55 -0400
Received: by mail-qt0-f179.google.com with SMTP id h4so15993874qtn.13
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GsDdWJR7RLnY9tkU5LqAcrwLtotaRAQxOvySlxBbWmg=;
        b=MuzU/Q6QSs8T05BhmCkf2/jhjNXPezTZNIelV1c12uCLxBdYpQKEJmNVRLlN7S2lBk
         bC9cjKZxWTyp5lcTrkT9PHD3I/zWbdRUNDi0uuAo/+9PqXS4H8NfFZg0+d28few2+1sI
         tFWGm2VqyX3lt884cVODfDcqema7ylUPgrpsi5y2M8nevklW9rKfQT7HOadTRrEsBf2L
         87ZcBhUXGzEbIk2cDSUjdDCyvUuUbkbby9mH+I8j87uO8BSID912t05ylBfYK038ndJt
         Ec1nVJBuonC4+vLyMjfkeSJlUturxUlZc3vntkxkMsD7S4DsEp2mvN4XyXv2uz9GeyI1
         ZFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GsDdWJR7RLnY9tkU5LqAcrwLtotaRAQxOvySlxBbWmg=;
        b=ufBaLothAPxZtApgFvryKy8qajBWj/WYVEwKFMDEI8knjnC1bk7MkMiFTxKNESsLDI
         RetikI6hGmKhRh/Ah93ntfpMhc12/Zda8366+3FOYAhZbjBcyRVTqdTkXDNoHv8Ce5ga
         Ggqd9vw/oF/EPt38UF8p7GWM33dD+mieJ5045MliS8TyJAX4mt/pPjJHrK7NhkahM/Mw
         PKj9QFqrsn9IqXlOQJgsAuqTBUejTuGr0rLmVpsK5J44ihUS25U3Ep4VFCEl0hCdJuh3
         Xv42YTN6fqKv39lPhADCIrmM4Nd9AGl7LW5IjBDDTkO7HJ2rwKV6MNcq+Hev5l0OCQZh
         0+tg==
X-Gm-Message-State: ALQs6tCr9W8DJcueGMpfTaZhH/uX+0/eAWm1aP5PJl9JwEgSNER7eoUy
        Jpk54r69YqONDub2/MvCt7qTBui2mwPVeGTKUlydeA==
X-Google-Smtp-Source: AIpwx4+TYNI+J+7yiB9A9KbGlq+q3LWJXHNZXbVNvV81hn1STNu1aE/DBg4Piihwi5P9F6wDTtFuhiCwGf/C2KjhB+E=
X-Received: by 10.237.61.184 with SMTP id i53mr14334814qtf.293.1522685274347;
 Mon, 02 Apr 2018 09:07:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.54.34 with HTTP; Mon, 2 Apr 2018 09:07:13 -0700 (PDT)
From:   Hosam Aly Mahmoud <hosamaly6@gmail.com>
Date:   Mon, 2 Apr 2018 17:07:13 +0100
Message-ID: <CAJA-u1okS1GO8+mHGbz23cs0CRt7wQAPHHsnvmZnZe4ZOf2VqQ@mail.gmail.com>
Subject: git stash push -u deletes untracked files
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using Git 2.16.3 on MacOS 10.13.3, running `git stash push
--include-untracked` deletes the untracked files specified in its
arguments and creates an empty stash commit.

In the example below, I create a repository with a single file and a
single commit. Then I create two untracked files and push one of them
to the stash. Although I get an error, an empty stash commit is
generated and the specified file is deleted.

```
$ git init . && touch README && git commit -m "README"
$ touch my-file my-other-file
$ git status
On branch master
Untracked files:
my-file
my-other-file

nothing added to commit but untracked files present
$ git stash push -u my-file
Saved working directory and index state WIP on master: e89afc6 README
fatal: pathspec 'my-file' did not match any files
error: unrecognized input
$ git status
On branch master
Untracked files:
my-other-file

nothing added to commit but untracked files present
$ git stash list
stash@{0}: WIP on master: e89afc6 README
$ git stash show
$
$ ls
README        my-other-file
```

I tested this using git built from the latest commit on master at the
time of writing (c2a499e6c31ed613a606ffdeb5bb74ab41e9a586) and got the
same results. Could you please check it out?


Thank you,

Hosam Aly
