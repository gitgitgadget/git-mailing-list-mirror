Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8766C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCTUDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCTUC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:02:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A726856
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h11so7074411ild.11
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342559;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Og3gaZcdPtTYDFZ8hC5Lv8yrk8uKJBLd0YPgQ2uQes=;
        b=oREeiDGMR77JtV6KbhaUoPnE1uKrRAOAUpcDPqzv9bVJS3wAUvdbDwoPJf5D6p6clQ
         d102vWAsGPRs9esoaXfQomuVXWzk1qVUkmUoLmiUADDbjrYJFK6KGklx1Y9BBWYPedmv
         nb4s2iN/HEBBDJB38zMQfuc1FeVWam36A7NoJ57daf8g0LIgBKswcLIYW8V4axbkcthN
         XS7Y4t6VgDKuEjas6LgEOJeKQcSfqNrAO7Fryqr63m2EczdZju7DorXVJtiMImgKQ2s6
         HIwGEgc54Wl6PC+d1E0QepdXgsuhpnqq4PljzQctX8MI+YgxEdhh5e2XtiHVun8c9ZPU
         qkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342559;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Og3gaZcdPtTYDFZ8hC5Lv8yrk8uKJBLd0YPgQ2uQes=;
        b=XBg6utBYbNwmuvtifa1NgpmQPar1v2joo3/ahnMr66kKElOScaxqOba7RDPNhpears
         X8G+c9dUpgHKSJAryzZgqtso1kf2iW0rU/gilTwTD0kwvnwh7it+5nTKeb+EgoLDoVUy
         KavRwWO0vRScAzx2L5n9m+IGk5zomqmu9Xt6H7k4z0u4fPcXQzKzBX6lo8r6B8Y/qhaS
         z1JYGQf9QknNinAxAS4qatdFk6G9kst6s1Ifl1lleHHHg+LOzu+ER9vEc37wJA2cWfJV
         JLwQ644BY4fiFum9jT/y3mko6srNM4hmP5DU677feTyWN5gQPdYWAzCqAH0KSPZIoSXj
         qstQ==
X-Gm-Message-State: AO0yUKWAJqlUP9vS1jrqWyTkls3SRKNPjrbw0Q+5EEK7XSVcdGC/GjIT
        Lvz5xbmHu6KAUbEQHLZOWAUids/Ks3KfQ+42GQ0l6A==
X-Google-Smtp-Source: AK7set9nnB7JGleMni61MGC9+6piuPiK+9fsrhlzPtjkY6QgCjMOiCOhoHgZwyIiNNJxc0Z4pn1N+g==
X-Received: by 2002:a05:6e02:687:b0:315:4449:cb50 with SMTP id o7-20020a056e02068700b003154449cb50mr548062ils.16.1679342558906;
        Mon, 20 Mar 2023 13:02:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u8-20020a926008000000b003179d4bd50asm2995948ilb.75.2023.03.20.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:38 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 0/6] pack-bitmap: miscellaneous mmap read hardening
Message-ID: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series has a few minor refactorings and hardenings I noticed
while reading the pack-bitmap.c code recently.

The series is structured as follows:

  - The first three are cleanups to the read_be32() and read_u8()
    functions that could be taken on their own.

  - The last three replace manually reading from `bitmap_git->map` and
    adjusting `bitmap_git->map_pos` accordingly with a new
    `bitmap_index_seek()` wrapper that accomplishes the same with
    additional bounds- and overflow-checking.

Thanks in advance for your review.

Taylor Blau (6):
  pack-bitmap.c: hide bitmap internals in `read_u8()`
  pack-bitmap.c: hide bitmap internals in `read_be32()`
  pack-bitmap.c: drop unnecessary 'inline's
  pack-bitmap.c: factor out manual `map_pos` manipulation
  pack-bitmap.c: use `bitmap_index_seek()` where possible
  pack-bitmap.c: factor out `bitmap_index_seek_commit()`

 pack-bitmap.c | 84 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 25 deletions(-)

-- 
2.40.0.77.gd564125b3f
