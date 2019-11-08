Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F8A1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 22:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfKHWun (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 17:50:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35427 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 17:50:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so4822837plp.2
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 14:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q8D6SXNcC8dvMd95RzeyrmIEeT5Y0DwJwYYSRylu2z0=;
        b=lZfFZjw1Gmulyeu2gHDCVDF87ygQ0BZA5FhpzqaMwUp311bRbjvdZ+71hkChp4AVs1
         IW1IrhIj0J+DYoYs0LxAqq6CwDBuQ5K+OvYai3o0CkIVmj2InZT50C4iId1OJTg3qIn/
         5ZQGb3vJRcrlRYeJx7NKyJXmLZnn42xV1iU2yl/dgA8hQoX8WsH9If4hKyqcDm8LKArL
         UfVo8azpmAyfh58yEjCMnQFzEia6i7ONQq/OJU/rjUi6yrsMfu1RgPh60i7TaX1DJHC/
         Vuy+WK+RcwKDwkZsRG7aj22497kGOVBbQ0jQag7VMjlWs/Y05wT7YgmvYXUjlFwSXEhD
         fwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q8D6SXNcC8dvMd95RzeyrmIEeT5Y0DwJwYYSRylu2z0=;
        b=p0uvfEnzPY0tymcTamHoUZf9J6rAxJqPeGRGzfOK0OfD0BP+cSr1Ne+NmNUYUPZlQ7
         XaB8ki0tMO1EM1//VDhzxyfLf1WjYCLOkCU2y81FjWckZyO8Ig/QMDl8xOZDYlpQ29H8
         nf2KjY3PtsDG5dbU4/ifOpMFyKBBKcbwk29zns1nyI/ACkn8QAhRjKi6bAi2n42etmm0
         p2cUoavlH+gRT7RwZRQa3GivgTaXX6OfNAFzoeztfJz2/lQ00dmFDuSHFjLppJnyxUnF
         p5NcaiLvkLEKP4A5wPqXwTG1QlbCAY+tDKBDAjywbE7tusjVnI2jMONnjwGXsDngIvkT
         c6bQ==
X-Gm-Message-State: APjAAAU3DSEDvqpyNLH7Oqkc2aCpvcQt6PVvcTkkNQzBtzqNEoBbOPQJ
        Apr0qvl9/517mfbupcmIi780rP2Js2c=
X-Google-Smtp-Source: APXvYqzw2eyIkSF3dRSo4F1BpdKTV39i2b7344m9Gnaj7yHMdU379VE6IvKLqGpAGx9vP8L6103rUQ==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr8435299plk.49.1573253440015;
        Fri, 08 Nov 2019 14:50:40 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i13sm6785111pfo.39.2019.11.08.14.50.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 14:50:39 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:50:35 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: Change behavior of git add --patch on newly added file?
Message-ID: <20191108225035.GA60198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Should 'git add -p <newly-added-file>' do the same thing as 'git add -N
<newly-added-file && git add -p <newly-added-file>'?

To demonstrate:
  git init .
  printf "%s\n" {1..10} >newfile
  git add -p newfile

This outputs "No changes." 'git status' shows that 'newfile' is
untracked.

However, since I want each of my commits to be atomic, I want only lines
1-5 in my first commit. (Or more realistically, maybe I only want
function stubs.)

I *can* do:
  git add -N newfile
  git add -p newfile

But, why doesn't 'git add -p' just do that on its own? At the very
least, "No changes" is a pretty cryptic output - there ARE changes,
right here in my workspace! (I think it means "there isn't a 'newfile' in
the index, so we can't say whether there is a difference between
'newfile' in the index and 'newfile' in your working tree".)

And if I reason to myself, "I can only add --patch a file which is
tracked, so I need to track this file first" and go skimming through the
documentation for "git add", -N doesn't jump out very much:

  -N, --intent-to-add   record only the fact that the path will be added later

or,

  -N, --intent-to-add
      Record only the fact that the path will be added later. An entry for the path is placed in
      the index with no content. This is useful for, among other things, showing the unstaged
      content of such files with git diff and committing them with git commit -a.

Considering that other parts of the add documentation talk about
tracked or untracked files, I personally miss the upshot that we are
tracking a file which was previously untracked with '-N'. (My gut
guess is that while many Git users are familiar with "tracked" or
"untracked" but less Git users are familiar with what it means to "place
in the index".)

Interestingly, in the whole-file deletion case, I *do* get interactive
support....kind of.

  rm trackedfile
  git add -p trackedfile

  diff --git a/trackedfile b/trackedfile
  index f00c965..0000000
  --- a/trackedfile
  +++ /dev/null
  deleted file mode 100644
  @@ -1,10 +0,0 @@
  -1
  -2
  -3
  -4
  -5
  -6
  -7
  -8
  -9
  -10
  (1/1) Stage deletion [y,n,q,a,d,?]? e
  Sorry, cannot edit this hunk


Is there a reason that git add -p can't do whole-file support this way?
While I'm less sure about what I'd like to see for copied files, I do
feel like there's a strong argument for patch adding new or deleted
files.

 - Emily
