From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] Rerolling sb/submodule-parallel-fetch for the time after 2.7
Date: Mon, 14 Dec 2015 11:37:10 -0800
Message-ID: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YwA-0003B1-MP
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbbLNTh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:29 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34508 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbLNTh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:27 -0500
Received: by pacwq6 with SMTP id wq6so108449922pac.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xFpTAyBI45k/n41Cnq0wPLmO+92jums62svxUGA/gjk=;
        b=Zh5IN7ZpOpJ09ZLJMkyX7YskkNgxRwL5rVQW2JBBifVVfi5Ar9nFtxSAxkRlUvY1PM
         lYwUziioc4RawOly8eNwbkYbVSi8FqeWlpDiINt+SLGMf7Z+kDUUWCXA+phCcam6lI/w
         kveYS/x5EQtFpKd3I13AXLqEH4OSKilkPanq6spURmmdM5sEkWeuM+nF+tG8RwrJyRho
         QsmilSzyOYa201C58Cwi2b3KuWzh6KapX1PXYzfYw4Mh4GucGjeFw4cTkdTOqU3xgEFu
         ZCpsZNmbXdMw+BDS+5ls6lSJA7kdsC9Gl35FZb3UkXN86bmicIj/5+tW4Q4Lu42aCfRX
         jyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xFpTAyBI45k/n41Cnq0wPLmO+92jums62svxUGA/gjk=;
        b=jJ4nKggYs8fKjgQdvRVEBuTeb97Px9Po8HfU7VDbJSMnH+wBg/fqs/ERw9y423Oc4J
         p0QmTvd2zo5KQbe4cVfanSGfFGLj4/wWxVlVpGerW1K55lAG7y7XCkXxzjYQVRMjGvgV
         /kTo/+CM4+duTiCQonQvxm237LWdUBlUdtYpZKVIDp3fLNB7tRrHPzEC9wysFj2zDTbw
         BVHXWpFZdpZUPMKRxb4wod+THaK646yW5aPiKWtJO1x+lSJValFQQQ1vKhE4pd18e9Tf
         brerUdEr/kI95tkMKEqTGMi+Aas70ueO12yBwDA00C0kLBKCO2l7WiJAlJQ6jbF73CGE
         VWoA==
X-Gm-Message-State: ALoCoQlDkRMriuL1+Cn/oNHI7AFIGbPwcM1WzxyQCaYMGqBQJuYG5pVcv4ZbseUrMS01IZ8D1OBZ3TdUaSAnf/ip/9w0RSpc+A==
X-Received: by 10.66.122.72 with SMTP id lq8mr48314506pab.1.1450121847340;
        Mon, 14 Dec 2015 11:37:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id r5sm44101745pfi.73.2015.12.14.11.37.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:26 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282388>

I am sending out a new version for replacing sb/submodule-parallel-fetch for
the time after the 2.7 release.

The content are 
 * all patches as in the branch sb/submodule-parallel-fetch
 * inlcuding the fixups as suggested by Hannes, 
 * write a message to the debug log for better testing and debugging purposes
  (a patch cherry picked from the series which is supposed to build on top of this)

The patches themselves were rebased such that there are no fixup commits
any more, but we get things right the first time.

The commit message of "run-command: add an asynchronous parallel child processor"
has slightly been updated to mention the fact that we don't want to use waitpid(-1)
but rather use the assumption of child's stderr living as long as the child itself.

Thanks,
Stefan


Jonathan Nieder (1):
  submodule.c: write "Fetching submodule <foo>" to stderr

Stefan Beller (7):
  xread: poll on non blocking fds
  xread_nonblock: add functionality to read from fds without blocking
  strbuf: add strbuf_read_once to read without blocking
  sigchain: add command to pop all common signals
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 git-compat-util.h               |   1 +
 run-command.c                   | 335 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  80 ++++++++++
 sigchain.c                      |   9 ++
 sigchain.h                      |   1 +
 strbuf.c                        |  11 ++
 strbuf.h                        |   8 +
 submodule.c                     | 141 +++++++++++------
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  53 +++++++
 t/t5526-fetch-submodules.sh     |  71 ++++++---
 test-run-command.c              |  55 ++++++-
 wrapper.c                       |  35 ++++-
 16 files changed, 747 insertions(+), 74 deletions(-)

-- 
2.6.4.443.ge094245.dirty
