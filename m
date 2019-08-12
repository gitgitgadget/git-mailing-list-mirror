Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39F21F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHLRuv (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 13:50:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33950 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 13:50:51 -0400
Received: by mail-wr1-f47.google.com with SMTP id 31so105374850wrm.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pDQMR5eRwIkgN9wum8hsJSZauCIlRiPJCOxYFX91VIs=;
        b=bpCzFd5+I5i3dp/M04DdFA6Mt6r13Yf4hX1P7hIu8Dw7cVzWuF8JF12iCCGJfVSHmu
         8XwyJqx8K/MGcJjSgOtz2Ymia7KUxD/+I7EvJnWHavjL2JJNjeFueJJkg4MhxdRE5v6j
         YrT4ybXd5hlAPlS8Wcg0fUuuissNm3UpKRe7LQ5/tCGrjlAK4Mds4P+Yk+moHd9VaMvL
         dqPXU8bfGKjbdqND1mpCpJTQ2Al9X2erNgcOl30MuPZ7zyhMMaswYCUIpwYcfPkgsKN6
         c0qWqgaHifUzNQqExK8T6je909cj3PCD0neTOUmREu5NJKdTgWxUbUJIf79QYq2h/ZiQ
         bjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pDQMR5eRwIkgN9wum8hsJSZauCIlRiPJCOxYFX91VIs=;
        b=E6jFbzPwGnVU3tu0ejjDu6JSZdDDrMQcdQb3N4r6oW3d7Oxpd4hgUnJHS659S4Sq3o
         HBgOG8dihMB1cin2x+9GYd12G6+cYWH1mC0jDYIC06kkBuukLOIbJ+xJLg3DkmGUUMyv
         5sc58g2SbZzRDQUCKQGT7y11ZLDIy924AEKTIE2ssGBJg8LjogDGas5Yu0ODNH8sNTqi
         MF48GB6FzL6x3DqNQ/uxRA9s2vlq+j+l8Fmxa6PChYYDhP2pgfkQUFhngBUAZZfNIAEP
         K8jMUyoWBsL4yHT9EDaNjWx+t95jcOLpRRHTV95VYZCz7GtWSUk3mZd0y2M1fxqpoyv8
         8C5w==
X-Gm-Message-State: APjAAAWUlfdI33ZpBDskuhSHK5etKU3EbDxBvgn495FuhvWcGqxF6DV1
        SrWX4FZZLJm0lvsgjpt0ZfZPJoUe
X-Google-Smtp-Source: APXvYqyRWB+ZcgAUUOqUein/4oADjocZuoX+OK0OBZiDpjLtTogZcQ41yY25FZKzu7nUahzys5J8Og==
X-Received: by 2002:adf:f7cd:: with SMTP id a13mr19256858wrq.165.1565632249449;
        Mon, 12 Aug 2019 10:50:49 -0700 (PDT)
Received: from szeder.dev (x4db63f8e.dyn.telefonica.de. [77.182.63.142])
        by smtp.gmail.com with ESMTPSA id r16sm29434512wrc.81.2019.08.12.10.50.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 10:50:48 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:50:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
Message-ID: <20190812175046.GM20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


When running interactive rebase to reword a commit message, I would
expect that the commit whose message I'm rewording is checked out.
This is not quite the case when rewording multiple subsequent commit
messages.

Let's start with four commits, and start an interactive rebase from
the first commit:

  $ git log --oneline
  5835aa1 (HEAD -> master) fourth
  64ecc64 third
  d5fad83 second
  384b86f first
  $ git rebase -i 384b86f

Update the instruction sheet to edit the log messages of two
subsequent commits:

  r d5fad83 second
  r 64ecc64 third
  pick 5835aa1 fourth

Now, after the editor opens up the second commit's log message, start
a new terminal and check where HEAD is pointing to:

  ~/tmp/reword (master|REBASE-i 1/3)$ head -n1 .git/COMMIT_EDITMSG 
  second
  ~/tmp/reword (master|REBASE-i 1/3)$ git log --oneline -1
  d5fad83 (HEAD) second

So far so good.
Save the updated commit message, and after the editor opens up the
third commit's log message, check again where HEAD is pointing to now:

  ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG 
  third
  ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
  c3db735 (HEAD) second - updated

As you can see, HEAD still points to the (now rewritten) second
commit.

It's only HEAD, though: notice the '+' in the git prompt, indicating
that both the worktree and index are dirty.  And indeed, they both
already match the state of the currently reworded, i.e. third, commit:

  ~/tmp/reword (master +|REBASE-i 2/3)$ cat file
  third

This is good, because even though HEAD has not been updated yet, it
already allows users to take a look at the "big picture", i.e. actual
file contents, in case the diff included in the commit message
template doesn't show enough context.

This behavior changed in commit 18633e1a22 (rebase -i: use the
rebase--helper builtin, 2017-02-09); prior to that HEAD pointed to the
third commit while editing its log message.

It's important to reword subsequent commits.  When rewording multiple,
but non subsequent commits (e.g. reword, pick, reword in the
instruction sheet), then HEAD is pointing to the right commits during
both rewords.


