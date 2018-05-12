Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277301F406
	for <e@80x24.org>; Sat, 12 May 2018 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeELVYs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 17:24:48 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37468 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELVYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 17:24:47 -0400
Received: by mail-wm0-f49.google.com with SMTP id l1-v6so8787904wmb.2
        for <git@vger.kernel.org>; Sat, 12 May 2018 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SovKrYuXhY//UA3asWGN4ozchPuSt9kyV2WJKlsqpG8=;
        b=hKTRwbGUAuvqD6D5AFV3ZaJcwk1XlWLOgn/a2ZOrpCsJ2bKVmkMac8OBDx+38jZ1Pf
         KSAJPO9x16C5JRhEeF8WABDpqFx3s48Wm95Khc+lMhEsWRrSiF+Gonb4tdYgdz3vKkF4
         +kD4TFDF+kL+g0coaVCzJVoRPXPzk7sUS6qWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SovKrYuXhY//UA3asWGN4ozchPuSt9kyV2WJKlsqpG8=;
        b=Frrv/wawSo2o7+2dIoqrwjsAjRtncm8t33jxlE3e+8CRjLXQFn+LHQwnDn+SwqYQbh
         9mtMgDi1PPBQxqZlHNi8z2q8O/mi0n/Hmy4Gx9j8MYJ1Zj3w6UVbHt1IjQvVhGEV11QO
         xhCpxMxiBR1u2IWrQGqS/8jc3ZPIXSvPSD2X0ZgfOtEiRpDqXO2r7TGl8x7U4+tAe6Iq
         mfJ29NXMdsvxrhivcAOEpI/QE+9sA6DmwohMlOgdAjFub5xP0FotB0MQ9ZYakZX5pKEA
         B82P+dRsEyo6khbkLnwfzAqcErnxZ6HXWaI+Ay2n+HIYL4wnmE6u2uVQGfXsUsv6BqcI
         t9Yw==
X-Gm-Message-State: ALKqPwcHHQ0O+ux/rVLATJhDhNvzu6J4uQLq/F2z4N69OsLnAadPuzM/
        GvP7xS2nSQNRwZJUe6+ct2cKbbp4
X-Google-Smtp-Source: AB8JxZp18uO4I0y5aF8AACsgdGszOsUcxIz19r5GPQh6nXpv3sitDJJ+pr/jW77YB1W/gxQlxllsOA==
X-Received: by 2002:a1c:e54a:: with SMTP id c71-v6mr1729798wmh.55.1526160286094;
        Sat, 12 May 2018 14:24:46 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id g75-v6sm5076967wmd.15.2018.05.12.14.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 14:24:45 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Junio C Hamano <gitster@pobox.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/1] add git-p4 unshelve command
Date:   Sat, 12 May 2018 22:24:33 +0100
Message-Id: <20180512212434.28012-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another attempt to make a "git p4 unshelve" command.

Unshelving in p4 is a bit like a cross between cherry-pick
and "am", and is very commonly used for review.

This command helps git users who want to try out a shelved
p4 change from some other repo:

e.g.

   $ git p4 unshelve 12345
   unshelved CL12345 into refs/remotes/p4/unshelved/12345
   $ git show refs/remotes/p4/unshelved/12345

I abandoned an earlier attempt because it seemed like there
is no way to get around a rather nasty problem: git-p4
just constructs the commit and passes the file contents to
git-fastimport. But there's no easy way to construct the
*prior* commit, because Perforce doesn't record this
information, and so you can end up with other changes
mixed into the unshelved commit - these are the differences
between your tree and the other tree, for each file that
has been modified.

However, I think the command is sufficiently useful that
it's worth supporting anyway, even with that caveat.

I also tried to use "p4 describe" to get the deltas, but
that's very unsatisfactory: I found myself writing a
second-rate version of git's diff tool to try to make
up for the deficiencies in Perforce's diff tool.

It might be possible to reconstruct the missing base
commit information, but that's a reasonably tricky task.

I have incorporated some of the comments from the earlier
review rounds, in particular:

- no longer adds the [git-p4...] annotation in unshelve
- try to use .format() in place of %
- rename the target branch if it already exists

Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  26 ++++++
 git-p4.py                | 171 ++++++++++++++++++++++++++++++---------
 t/t9832-unshelve.sh      |  99 +++++++++++++++++++++++
 3 files changed, 260 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.17.0.392.gdeb1a6e9b7

