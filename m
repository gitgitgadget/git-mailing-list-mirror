Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A3620899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdHTUJi (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35058 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753191AbdHTUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id h89so2450360lfi.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=SyJcP8P2ot8wuo44hMW8q6Xia/W9YA7WLhlA3xF3XAY=;
        b=llhy76POR4fT7arStmE79GgOILaJWT44Z3+/1rI27lTN/JOlTPTHpy8rJ5TrasWaGv
         BVzYXAzTFAwBxtoolKi2jMsMXBdGSm5VqcdgoFLKOXv6ezl9K5eZgJLc4zUFTVD5gdVQ
         wm4dUV/qOlm4FoqU+dk8cwo2Awj3jo3DY2eX4JT2mUbAhSReqLYLTSwKI076YVtOJNq9
         IjjN/K/BJxX6QU4UyjYBNEEXZTuVPv/U4DhcjjlCSoyj/k7NI/P+mx2wiv9dYdfmhoz5
         HtpnTALv/vIadaD4l/0xpJSvdrXKCMrwjK9e3oO0Ur1jfMoiuyXDYl2+rS4G9GJKmgzh
         8PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=SyJcP8P2ot8wuo44hMW8q6Xia/W9YA7WLhlA3xF3XAY=;
        b=XeU1IJgMNhwqSorgsAvNagmJ/jy8KcwpvhkjKRbGV3uttD1cIi6qdqMzDeA2CVd0W0
         +2lNjp69ylg+GZj4CuvGKo+dVs+IZMoiiHdL9YyeEbDVjn/N6KOq/IaM1XisYiGzmGY9
         k1FwLu5ZFyMZiWPzzh/Hco1Hev4CkAWcHhGMNFMLzXgQlbe201xkZsoC0HG+gNmAhC/e
         a1votfmzUSWomJfLyVgZcJkFv3+XCPi2osEUYgFlG7NKU4vU//WjRZ9lhYb4t/nwX8pi
         HFMidADYVME3QAjmGCW8WMv5ZwM0drSlKDiaynBCi9wFy917M69r+fDsxEDu9dXHvxSl
         /cBw==
X-Gm-Message-State: AHYfb5jZDVn0/q+SRps5WaluspjV9AWguUrJkIZbvH6je2+3/iMKzwel
        cB1Z6x4tNI1UHjE7HmY=
X-Received: by 10.25.15.207 with SMTP id 76mr14551lfp.7.1503259775970;
        Sun, 20 Aug 2017 13:09:35 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:34 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/6] Convert hash-object to struct object_id
Date:   Sun, 20 Aug 2017 22:09:25 +0200
Message-Id: <cover.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enabled conversion of few functions in sha1_file, which
had almost all callers converted already.

I hope I'm not stepping on anyone's toes with this patch series.
If I do - is there some email thread or document in which I can
coordinate with other developers, regarding which code regions
are being converted to struct object_id next?

I focused on this builtin in particular because it's probably
the smallest functionality, that can be converted to different
hashing algorithm, at least partly.

Patryk Obara (6):
  builtin/hash-object: convert to struct object_id
  read-cache: convert to struct object_id
  sha1_file: convert index_path to struct object_id
  sha1_file: convert index_fd to struct object_id
  sha1_file: convert hash_sha1_file_literally to struct object_id
  sha1_file: convert index_stream to struct object_id

 builtin/difftool.c     |  2 +-
 builtin/hash-object.c  | 12 ++++++------
 builtin/replace.c      |  2 +-
 builtin/update-index.c |  2 +-
 cache.h                |  6 +++---
 diff.c                 |  2 +-
 notes-merge.c          |  2 +-
 read-cache.c           |  8 ++++----
 sha1_file.c            | 34 +++++++++++++++++-----------------
 9 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.9.5

