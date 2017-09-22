Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE8420A26
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdIVXfM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37040 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so1321406wrf.4
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQGMNfCaLsOZgXyqkPzF7qysO+6Wq8jkdv76v4o8j4w=;
        b=ccqv1H6d8tkRPj38WPqnFH1bngZbh94oqXQSZXJKlc6oEqv7/5q7038Ugt5X+680Rc
         bHcobpz79lAkrC1JQSR8CFJBZeWRRRxhCkmtVSnAw7jLYJTTqQ6vh3ZVok5ETuDnI+zy
         kRrl7vCaElZ2gtuIMwIj/lU1tA4z37/BOcXDrv02NRre0DR6W0H9U4rZkdvO5zkekCS2
         Dm+WwDUw+pxnVXoNtk/qRkY4+XfYWYxSgClzsdW99EvkLnFzBxxHSlBGdJ5pVqLDzwcj
         P82fPXVkuN6HtMsqJiI1wVkrn5PzhSU/8sTypL3064vdzkxgNW0Jkqin/Vu9JI9uL8IQ
         H1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQGMNfCaLsOZgXyqkPzF7qysO+6Wq8jkdv76v4o8j4w=;
        b=WQXVT8tlCzaGnz3xfqU/9mYIlWeTVwkvvUCWepM7RuZ55YxTo6OzTuw+tywdMVRhMq
         dL1Q8Hdxt5kc1BrFSaNNrk01dibJTsMNuqDv84+XMys8jVjjv4twHsKABESAO3H/7ruF
         3ET9JcyXgsWN9K7M7KQ9PUdVnTd7IkbOVIi11hQYxM483EpY2D/HN5lbhKItmSvivEhu
         AIV4ldNgSEWGUTvCwouwQzAx2R/4X50N79u8h4DIt6XEu7Cb2FcUEdC+TlxD/3uzwWv8
         11W0xepAhdn37FwWM1tFFXzOnsi4JxokRZg2d0lOpzZ+/MWmZnLqRMMgGev39cX7r7k5
         v7zA==
X-Gm-Message-State: AHPjjUhgq89b20HsWdf4CggVBInnqcCCHoQg2VHqHOksmF5xNwB2ViFi
        g714zL8JmOQNcVFF/lIJpWqDzg==
X-Google-Smtp-Source: AOwi7QCj0Jw8T658GOlxX5D3apQu/FKOeetd7fjYmCQ1fZ6ZlmGD0XjyO2B4nZUoKIQh7PxhST0yqA==
X-Received: by 10.223.159.11 with SMTP id l11mr505295wrf.148.1506123309204;
        Fri, 22 Sep 2017 16:35:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
Date:   Sat, 23 Sep 2017 01:34:48 +0200
Message-Id: <cover.1506120291.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 September 2017 at 22:02, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 20, 2017 at 09:47:24PM +0200, Martin Ågren wrote:
>
>> Instead of conditionally freeing `rev.pending.objects`, just call
>> `object_array_clear()` on `rev.pending`. This means we don't poke as
>> much into the implementation, which is already a good thing, but also
>> that we free the individual entries as well, thereby fixing a
>> memory-leak.
>
> Looks good. A similar bug was the exact reason for adding the function
> in 46be82312. I did a grep for 'free.*\.objects' to see if there were
> other cases.
>
> There are some hits. E.g., the one in orphaned_commit_warning(). It does
> something funny with setting revs.leak_pending. But I _think_ after the
> whole thing is done and we call free(refs.objects), that probably ought
> to be an object_array_clear().

Looking into this, I found various classes of leaks and oddities. I
ended up replacing this patch with four patches.

Since Junio collected my "independent" patches into ma/leakplugs, this
is a re-roll of that whole topic. I got the first two patches from
Junio's tree. The only difference there is "builtin/" at the very start
of the first commit message.

The third patch handles the places where we use `leak_pending`. The
fourth addresses the rest of what your grep found and includes the
original patch from this thread. While working on those, I felt that
some callers fiddle a bit too much with the internals of `object_array`.
One pattern leaks, another only looks like it. That resulted in the last
two patches.

Since ma/plugleaks is branched off maint, I did the same with this
series. It applies on master and next and has a minor conflict on pu
(`handle_commit()` got a new argument).

Martin

Martin Ågren (6):
  builtin/commit: fix memory leak in `prepare_index()`
  commit: fix memory leak in `reduce_heads()`
  leak_pending: use `object_array_clear()`, not `free()`
  object_array: use `object_array_clear()`, not `free()`
  object_array: add and use `object_array_pop()`
  pack-bitmap[-write]: use `object_array_clear()`, don't leak

 bisect.c              |  3 ++-
 builtin/checkout.c    |  9 ++++++++-
 builtin/commit.c      | 15 ++++++++++-----
 builtin/fast-export.c |  3 +--
 builtin/fsck.c        |  7 +------
 builtin/reflog.c      |  6 +++---
 bundle.c              |  9 ++++++++-
 commit.c              |  1 +
 diff-lib.c            |  3 +--
 object.c              | 13 +++++++++++++
 object.h              |  7 +++++++
 pack-bitmap-write.c   |  4 +---
 pack-bitmap.c         | 10 +++-------
 revision.h            | 11 +++++++++++
 shallow.c             |  2 +-
 submodule.c           |  4 ++--
 upload-pack.c         |  2 +-
 17 files changed, 74 insertions(+), 35 deletions(-)

-- 
2.14.1.727.g9ddaf86

