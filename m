Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B95B20281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763778AbdEWTb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:31:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36775 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759850AbdEWTb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:31:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so24069320qka.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jh1X6iuxE5e3rNH6+utb0z1Tl3ZgMwv3F4/tCCZrgWw=;
        b=ikJ737ZrgvZPzRzbCzughidwR10CY7q+fWtwZAdYoJiAPP5ztxPIQnRVu5D4Ibw89j
         zk/JFkzJdXEFvAoBuv6hls0SrGz8U/9SKw3S7GkikWJq19+EERrkobUc7Tk2tdJkB4Ef
         xcaNVGM4LTp/cHWiWiQSxMKRNQjxFeATodxjZpaaQl65qtD5PoCLxx/ouQtRc2K9xErl
         0RthpgrUn3DoBZ6xRNMQwT5V8FrhQbzaKxw1wb4IP3qkYvqtZA+ZGV7HY0IX4gfmS6Pg
         xIHv8yBFoTAvWVdOZ1sAmk71EDwlOCmM0KUvVBNZfILyUuGRaA6cuPvy3mtnlfgMG+4+
         3Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jh1X6iuxE5e3rNH6+utb0z1Tl3ZgMwv3F4/tCCZrgWw=;
        b=QHh/GGhPKYu74x9HAz7t5UKrIm8NKRSAua5tYvglshF/Kb7Qq49D//268pvzXzwV+b
         w0U8lltvICacr7hHDrv51BtNdeMPxIBg0fzKf4uqIoMQq00CtrB3vLMrmBI35PyNqS2c
         oZNlA+kqq6KW+4a+UvUxx1GQZn3eXlzVeXpuKxba/QtHvQCoPNWODt7kRMtNVBS0aheG
         udGxd6ubCP4QiCTY98gEGdICC4ciduRGOW8zN1pjE0MiKRVkXasxwJfaE3WwjC7AIfkL
         7fPkh5HHU3vQE4NODi5CD2lIxeebTo4bwIWOwjpuGEpelYWWFMOrwZSNUg+/AMt2mzPj
         S1lg==
X-Gm-Message-State: AODbwcD29E4vyAYO7kswHzNweB0A42yOeCIHzxaDwfq9pT2ooes7/DtH
        wcrb4MoKUcTivQ==
X-Received: by 10.55.99.87 with SMTP id x84mr25749259qkb.86.1495567916982;
        Tue, 23 May 2017 12:31:56 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:31:56 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 0/6] Fix clean -d and status --ignored
Date:   Tue, 23 May 2017 06:09:31 -0400
Message-Id: <20170523100937.8752-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Messed up on 6/6 in v5, forgot to include changes from earlier versions (karma
for not running tests before I send-email'd the patch series).

Samuel Lijin (6):
  t7300: clean -d should skip dirs with ignored files
  t7061: status --ignored should search untracked dirs
  dir: recurse into untracked dirs for ignored files
  dir: hide untracked contents of untracked dirs
  dir: expose cmp_name() and check_contains()
  clean: teach clean -d to preserve ignored paths

 Documentation/technical/api-directory-listing.txt |  6 ++++
 builtin/clean.c                                   | 42 ++++++++++++++++++++++
 dir.c                                             | 43 ++++++++++++++++++++---
 dir.h                                             |  6 +++-
 t/t7061-wtstatus-ignore.sh                        |  1 +
 t/t7300-clean.sh                                  | 16 +++++++++
 6 files changed, 109 insertions(+), 5 deletions(-)

-- 
2.13.0

