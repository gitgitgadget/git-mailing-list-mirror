Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA8720248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfDEDhm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so2463230pfi.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OeLIol7el6f6wbhSdS5o9Ipk84ciqkKLdEcoUK+hDNI=;
        b=iownSwHSWE0ac+rSK5GFEoSmKEcwicUCYsWEoPDAgQTEt6ihp6PXbtxmEO5SyonziT
         lR50TPaAI26V497vtAHs0VdNGUIzJ6C50YfkJPscu/ZhKL3LwQqDUZTYOHIF86I8tK6T
         uL8bqaUQ5pK+/5DzTexB2NWHVsCl45LmLLAkbr1vjctD40PAt/u+Nsg+CHLjLE2unQJj
         kpT/kkDRg43NfH8xD287cS53BsPc1fLS5SuYLiUlYLw2qBrRKTcZsmJCuIw6LDQL9UiO
         GH4Gac3uY3TUpoHqPVEJA04FZOrFShevI2KlHOHHcQ3+JSJ0Qx6VfqRXYU5PE1wbyrdh
         UPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OeLIol7el6f6wbhSdS5o9Ipk84ciqkKLdEcoUK+hDNI=;
        b=Qncy4d/e9cw9KHsMb1T/MDrBfw19ihFBnO3t8hQYV9K1/ygc7gCLRNVL9mUEce1l+J
         xyLLeQdsTDz1yYopKNVc7X+qHE8udEzZ7eJtU3QlNFmYFtY1KmfJCO4AvMBsScP/QLGs
         9qlqrF+sJQRcpcPEaTJowo3lBwxwpMJAsSJobID/tvwAtvKLQzoexLCrQXxEAZ5VgG4p
         uSLbcuD693OwnLIjEgAg4Pxi/RbOO15/7eXkjbSZyNy+pCH/L6uK0MqyubJfBYg3YwQc
         jUBaB36vL4fTr2Cg+Vw+FOnZZzQ9Hn9/VRTMJDEA4oqIlYTuW3TyaWAYpDqn7cgt9OBb
         oJUA==
X-Gm-Message-State: APjAAAVt7aVS5qLjiiJ+FoKHQ5ann4w8yT7W/dkuE1nBNV8y/BOhCCEP
        MZvJVeDoPbmDlm91uv7eLPerOzN8BmEETQ==
X-Google-Smtp-Source: APXvYqwl7glbcgm5XLWONp8EsH3XnrZc4H4Bj6pkbC2lYOje+boDVetS3wSuxV1fSQ6UpUrNZdwJ/Q==
X-Received: by 2002:a62:424f:: with SMTP id p76mr9929222pfa.141.1554435461193;
        Thu, 04 Apr 2019 20:37:41 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id v189sm60563218pgd.77.2019.04.04.20.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:40 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:39 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/7] harden unexpected object types checks
Message-ID: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

Peff pointed out to me a couple of weeks ago that we could reproducibly
crash Git when doing the following:

  $ git rev-list --objects <blob> <broken-tree>

Where <blob> is a normal blob, and <broken-tree> is a tree which
contains an entry that refers to <blob> but gives it a type other than
'blob'. (This is described in detail in 2/7 and fixed in 3/7.)

We decided to continue, trying to come up with more tests that exercise
similar object corruption, and the tests
't6102-rev-list-unexpected-objects.sh' are what we came up with.

The series goes as follows:

  1. Prepare ourselves by moving a helper in 't' into
     test-lib-functions.sh so that we can use it in a new location.

  2. Write out a handful of tests that exercises cases similar to the
     above, and mark the ones with bugs as 'test_expect_failure'.

  3. Fix (most) of them in each subsequent commit.

The exception we make for step (3) is that don't provide a complete fix,
only restore behavior to before the commit at which it regressed.

I'll be brief here, since most of the detail is described at length in
the patches themselves. This said, please do ask questions where I
wasn't clear, or could have been clearer. (This series grew larger than
I originally expected it to, so perhaps there is detail that I
accumulated and didn't devote enough time to).

Thanks as always in advance for your review.


Jeff King (3):
  get_commit_tree(): return NULL for broken tree
  rev-list: let traversal die when --missing is not in use
  rev-list: detect broken root trees

Taylor Blau (4):
  t: move 'hex2oct' into test-lib-functions.sh
  t: introduce tests for unexpected object types
  list-objects.c: handle unexpected non-blob entries
  list-objects.c: handle unexpected non-tree entries

 builtin/rev-list.c                     |   4 +-
 commit.c                               |   6 +-
 list-objects.c                         |  13 +++
 t/t1007-hash-object.sh                 |   4 -
 t/t1450-fsck.sh                        |   4 -
 t/t5601-clone.sh                       |   4 -
 t/t6102-rev-list-unexpected-objects.sh | 127 +++++++++++++++++++++++++
 t/test-lib-functions.sh                |   6 ++
 8 files changed, 152 insertions(+), 16 deletions(-)
 create mode 100755 t/t6102-rev-list-unexpected-objects.sh

--
2.21.0.203.g358da99528
