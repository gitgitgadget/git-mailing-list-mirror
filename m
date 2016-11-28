Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4294D1FF76
	for <e@80x24.org>; Mon, 28 Nov 2016 09:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbcK1Jnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:43:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36070 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbcK1Jnr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:43:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so12688631pgx.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frv7JRhLEMhu6Xyw2KZgVVcoO2Ij88cDPPoUakiSZtM=;
        b=UdLX2Hom62a7fauhm1J8BSCRo6GC0UF4m2PDF1BkhBYCoYrHFsUW+rHvA/kqs40ece
         CQJV2cdEpupSGq3E+LXNdklUcUHm7kPFGr8tAeFAwCnIgpXnsfyLH7PthetayHlxCmSu
         IgEr2cV2KpexgqMsRGQxhUSjfUWQtuxEsWNc+fMMllR+Z8Ya7TnxbhkjXrfkpTeqdtV2
         Nx6/W2CBPye9YVaQOCLl0/mKV3WdD5gsvdXqYNNTx+UQ5r/zpGp4hbMWwgKzIixqwtp7
         VV8Rf6sfs1PkteJoAyK0miVE59slhNiMjCZdW2M4hPMtRDpJRd4EARKwbv5TNNRJ9wSs
         WyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frv7JRhLEMhu6Xyw2KZgVVcoO2Ij88cDPPoUakiSZtM=;
        b=bvnUoD7D8k6i6QG2MOERg2ZySJ5tojqXRIg80ISL49tz4S60eipC6EF+dInfKAb+XI
         2Qel967xCtkrhN+xY/r9ld+bf2TBd42H39USJ9RfI0u3B5sAi9fNfgu+EDYR120LIiwt
         XUisvUo+9j6F9LZMTZYk1sT1FyDOjmoHtzdI+6V5AHLBirEvXqvYnWEvCbvphp68vn3y
         GJfLApukieiCF5VkyIltxYZXE7GEmx8P8ffW4srZic6DkX6yyjBeasBlAYmFcEjofT9t
         ucQ6c9kJMFhzlrxYpXyd8uxGVmf6kAXnh9YLrgu424SrEmlKGhnW3GSgvCf6/ANdLWDS
         qcjg==
X-Gm-Message-State: AKaTC01g09wS+6gy0r9Qu8zdT9epI9bnuvGIW6SrAFt/m0NP43fGlxNJag/Xdi/MpYDL3w==
X-Received: by 10.98.159.67 with SMTP id g64mr20405283pfe.93.1480326226923;
        Mon, 28 Nov 2016 01:43:46 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id r74sm85737542pfl.79.2016.11.28.01.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:43:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:43:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/11] git worktree (re)move
Date:   Mon, 28 Nov 2016 16:43:08 +0700
Message-Id: <20161128094319.16176-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 contains some style fix and adapts to the new get_worktrees() api
from nd/worktree-list-fixup (which means it can't be built without
that series).

Nguyễn Thái Ngọc Duy (11):
  copy.c: import copy_file() from busybox
  copy.c: delete unused code in copy_file()
  copy.c: convert bb_(p)error_msg to error(_errno)
  copy.c: style fix
  copy.c: convert copy_file() to copy_dir_recursively()
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command

 Documentation/git-worktree.txt         |  28 ++-
 builtin/worktree.c                     | 181 ++++++++++++++++
 cache.h                                |   1 +
 contrib/completion/git-completion.bash |   5 +-
 copy.c                                 | 369 +++++++++++++++++++++++++++++++++
 t/t2028-worktree-move.sh               |  56 +++++
 worktree.c                             |  84 ++++++++
 worktree.h                             |  11 +
 8 files changed, 724 insertions(+), 11 deletions(-)

-- 
2.8.2.524.g6ff3d78

