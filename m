Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E6C10F26
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C001F20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPjPKWS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDAVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39720 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: by mail-ed1-f53.google.com with SMTP id a43so1576189edf.6
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jtOqW61rQNah2Yj4HB+6xQRh1RpgHLRY6XKdbL2HalM=;
        b=GPjPKWS/y+tiW7UXISlWC5AsYqPCkrlKlOq3iILdHnettQGihzBvSxuQyqswo1endc
         3b/zH0Ok/Q9LGoHhcV4alqMqrpHxyqh7AoJ1bXphOMfeIetBZYNOI8npDUfzwagcq08O
         w57qfg8dSgounUhicYQwcxdS+mwiJ6rP1UyD2HFh5v/SMeyim7vpZfwF6Riol8MAxDgv
         +wBK0riwS3ECf2+Cqd3O2o9JpucfJWPKP2qXrrR4uAVTWdQXgC4m8QKC5d9ZybvkQcB3
         MSze7wZo0uLsNI8JGfNjmD1gYdm8QCUU9RlTR+aoQ6QbvEzC5/bA6+Z4UHG+bhTvTRHZ
         5rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jtOqW61rQNah2Yj4HB+6xQRh1RpgHLRY6XKdbL2HalM=;
        b=iYoBtBW2HODJfBTGBdvf1LoWISGebI8oaX53PUjAWn1YFZiDYFFhyWgV9AvPlM0kha
         zgm9hAprfOF5zmdKNOhEocZL0r1z3ueA5VTpPzmQZtBQjOK1mz7Ll4TWC9Vcx5IY5KGb
         3BN/JKquIh2n7HUFeJjCD00hiFH3n64qbcboj0sOCqkKv7Eo0IqfcJbhT/Gxdl76Kdsz
         U08smsiN3n4llvn/PjcO/G79JHA7HoUyR29802yMBqr2nwejFn3+uACYi15UTTFpE36h
         NNhq5nQcOP9JbDojsH/eWDxfFBdjjVOZI2VZcvhHLSKtmkw7LQWZsliIVxSgY+aGPFHk
         cKCw==
X-Gm-Message-State: AGi0PuY9hJHPd+MEpvVrrVry6SxU2kaXHkPSaFaE+YYoZgwXH8kS1TKP
        rRZuWwqFfixRJh+Aa3zYwZiTbaZN
X-Google-Smtp-Source: APiQypI8hjcOzCuQYYfDhTP6NV7YrKbJ9ZQCp/sglhSZc/njiu/2VB63FBBxl+JgjysXEqYeayrpwg==
X-Received: by 2002:a17:906:28cf:: with SMTP id p15mr36670ejd.202.1585774845795;
        Wed, 01 Apr 2020 14:00:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm738998ejt.24.2020.04.01.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 14:00:45 -0700 (PDT)
Message-Id: <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
In-Reply-To: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 21:00:42 +0000
Subject: [PATCH v2 0/2] commit-graph: fix buggy --expire-time option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is embarassing. I should have noticed this when writing it the first
time, or when integrating the feature into Scalar and VFS for Git. Sorry!

Update in V2:

 * Updated the helptext. Thanks, Taylor!
 * Added a patch for the "test-tool chmtime" in t5319
 * Used an absolute time with "test-tool chmtime" in t5324 instead of "touch
   -m"
 * Added a file that should be kept on the other side of the expire time to
   protect against off-by-one errors and future date errors.

Thanks, -Stolee

Derrick Stolee (2):
  t5319: replace 'touch -m' with 'test-tool chmtime'
  commit-graph: fix buggy --expire-time option

 builtin/commit-graph.c        | 2 +-
 commit-graph.c                | 2 +-
 t/t5319-multi-pack-index.sh   | 8 ++++----
 t/t5324-split-commit-graph.sh | 8 +++++++-
 4 files changed, 13 insertions(+), 7 deletions(-)


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-596%2Fderrickstolee%2Fcommit-graph-expire-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-596/derrickstolee/commit-graph-expire-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/596

Range-diff vs v1:

 -:  ----------- > 1:  24e26ecda63 t5319: replace 'touch -m' with 'test-tool chmtime'
 1:  32c55c0fc21 ! 2:  56a312695fe commit-graph: fix buggy --expire-time option
     @@ Commit message
          Update t5323-split-commit-graph.sh to demonstrate the correct value
          of the --expire-time option by actually creating a crud .graph file
          with mtime earlier than the expire time. Instead of using a super-
     -    early time (1980) we need to use a recent time or else the old
     -    logic actually passes by accident. This test will start passing
     -    again on the old logic in 40 years or so.
     +    early time (1980) we use an explicit, and recent, time. Using
     +    test-tool chmtime to create two files on either end of an exact
     +    second, we create a test that catches this failure no matter the
     +    current time. Using a fixed date is more portable than trying to
     +    format a relative date string into the --expiry-date input.
      
          I noticed this when inspecting some Scalar repos that had an excess
          number of commit-graph files. In Scalar, we were using this second
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
       			N_("maximum ratio between two levels of a split commit-graph")),
       		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
      -			N_("maximum number of commits in a non-base split commit-graph")),
     -+			N_("do not expire files newer than a number of seconds before now")),
     ++			N_("only expire files older than a given date-time")),
       		OPT_END(),
       	};
       
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'test merge stragety constant
       		test_line_count = 2 $graphdir/commit-graph-chain &&
       		test_commit 15 &&
      -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
     -+		touch -m -t 201801010000.00 $graphdir/extra.graph &&
     -+		git commit-graph write --reachable --split --size-multiple=10 --expire-time=2019-01-01 &&
     ++		touch $graphdir/to-delete.graph $graphdir/to-keep.graph &&
     ++		test-tool chmtime =1546362000 $graphdir/to-delete.graph &&
     ++		test-tool chmtime =1546362001 $graphdir/to-keep.graph &&
     ++		git commit-graph write --reachable --split --size-multiple=10 \
     ++			--expire-time="2019-01-01 12:00 -05:00" &&
       		test_line_count = 1 $graphdir/commit-graph-chain &&
     -+		test_path_is_missing $graphdir/extra.graph &&
     ++		test_path_is_missing $graphdir/to-delete.graph &&
     ++		test_path_is_file $graphdir/to-keep.graph &&
       		ls $graphdir/graph-*.graph >graph-files &&
       		test_line_count = 3 graph-files
       	) &&

-- 
gitgitgadget
