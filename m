Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8E51F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeGQMlc (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:41:32 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44472 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbeGQMjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:07 -0400
Received: by mail-wr1-f53.google.com with SMTP id r16-v6so997138wrt.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=n5xiyMcQqEsoTY1QgNF6u2YYISi3Unft/23k7Uztufk=;
        b=ONOPO5ocD/p1CgLQjzN4NrN0bqDrN0X2zSwSKLSOiQ40vALyRtVT/CnrKeHrhvsDgS
         emo0Gdhyw8SJFmWM9VlBHdX5jU62ZDUQRhNDpoygN/ZC0HsfrroyfCsg6rrgFdAZh5Ah
         kjGbw5ScPt9kaVImsgaNk6SsAZKjA6IBpE7jQ3BAJOdOJCRX1oqXj6/Rd9hZTk2WvB5l
         9XJSFOxC9qI4rM47rF5NW4jNLJotuNJI2aRpxtxLKmeksi7y8BTH9HV+ctfWcEKzVYvs
         qFy4kO4BS7OnS3F5E42Wuas1OfPRTeLUCsHOe00G+GC6g7YDyuLLIxLhL5JzD6P8jk+h
         jZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=n5xiyMcQqEsoTY1QgNF6u2YYISi3Unft/23k7Uztufk=;
        b=ejuPgrIRs6ZjPLvV7/UEufzmqGyQpO1lwgXuY+De9psQGqI36hMHLY3JJsvmJKSZfi
         +bmVee2N6s0mlkY617sr9OXEIhR+riwOq3Xpwf5DDdiQDy5jHZAa4VLkCZSzdghn8XyB
         mxVta+WrDuYbsQHAK9NarIzzKCDqf7HVT+tC+IXJu35ZJ6FQ/hRtvQfsuHcBZDKPoLqu
         1MBwbBP7IX8UopdiOCUwiYUD386ynHsv6pfvfKynDA08NUuslggGWI/Rq4607xa+puCl
         pOgpn18qzZdNo7Ph7qcho3Xfs+8g7DgTAmqw9o2MZGHNh3QCrTyC6PZnxoynI9aE2fic
         IgLg==
X-Gm-Message-State: AOUpUlGV5zWkVGovsip2L/eY9rFZj+mcMu2dZwMyimWv+zYZAH24g0X6
        h8SnYj7er47bJvjNJee9iAVErw==
X-Google-Smtp-Source: AAOMgpcUaNm0ti530NZYLpzNDzYR9UnAnreRZvXxf2T7Fn4k2SVNUStnVXC3V3IwZ7w+hmo3ppv46Q==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr1187022wra.19.1531829205781;
        Tue, 17 Jul 2018 05:06:45 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:45 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/6] Add gentle alternative for `get_oid()`
Date:   Tue, 17 Jul 2018 15:06:30 +0300
Message-Id: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment, `get_oid()` might call `die()` in some cases. To
prevent that from happening, this patches introduces a new flag
called `GET_OID_GENTLY` and a new function `get_oid_gently()`,
which passes the mentioned flag further to `get_oid_with_context()`.

The call graph of `get_oid()` is pretty complex and I hope I covered
all the cases where `exit()` might be called. Although I believe this
series of patches will not introduce any regression and work as
intended, I think that is better to mark it with [RFC].

This patch would be useful for converting `git stash` to C. At the
moment, `git stash` spawns a child process to avoid `get_oid()` to
die. If this series turns out to be good enough to be accepted, do
I need to wait until it gets merged in `master` to use it in the
other project mentioned before?

Thanks,
Paul

Paul-Sebastian Ungureanu (6):
  sha1-name: Add `GET_OID_GENTLY` flag
  tree-walk: Add three new gentle helpers
  refs.c: Teach `read_ref_at()` to accept `GET_OID_GENTLY` flag
  sha1-name: Teach `get_oid_basic()` to be gentle
  sha1-name: Teach `get_oid_with_context[_1]()` to be gentle
  sha1-name: Add gentle alternative for `get_oid()`

 cache.h     |   2 +
 refs.c      |   2 +
 sha1-name.c | 127 +++++++++++++++++++++++++++++++++++++++++-----------
 tree-walk.c | 108 +++++++++++++++++++++++++++++++++++++-------
 tree-walk.h |   3 +-
 5 files changed, 199 insertions(+), 43 deletions(-)

-- 
2.18.0.rc2.184.ga79db55c2.dirty

