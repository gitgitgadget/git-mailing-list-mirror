Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677791F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeGLT7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:00 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:44162 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeGLT7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:00 -0400
Received: by mail-qk0-f202.google.com with SMTP id w126-v6so24863639qka.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=yNdSSIbPH/W1l4UCKRPHfOR6RaBY7tsyUDTClZs4Sw8=;
        b=SrUFM7dLVJvzvSO/SabGk8OfsQvD4yjwijr+jqlAdOMhttR6uH5NHODgRr5x669ZmG
         dq8aCBwcA7Jq8ZloukOpwmIp9NwPEj6m+0V/mOhH7Q3/oK5IbNfHJTz5M9AfQ7rvucXe
         B+ol4san9MeJ7lfStZ99k82xuCG0y/jQC+dkzxHRS2CEZP9jCzLRd8puJLeDHqFVu/rL
         +DGigQSSMD43oTkbrXdx6ReisbnWHqvVnvQ05Ul8vI+pA8DtyqyeA92wt8UJjJZfUUoN
         rvdZtQ1S1oTW1FVGc7XhqnqXsdY0/UHkNmMqk0dQSmTEERBYZMIJbrWUvA7b/+r6jeNX
         q7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=yNdSSIbPH/W1l4UCKRPHfOR6RaBY7tsyUDTClZs4Sw8=;
        b=Kv3iRzCgjrfYGNtjrBOhYWerHcqLbYTbqx2vN2LO0otgo2NIkFdMwX/UmgAVpr3x5o
         FNHMPGfEIW6JwqH4/tWpUOLQ6bFse1QBoFMQSUaNkZZZ50QQspox4gNkRjvrkJw9dy+0
         p5Edau0FdwwEgp9yJ7M3oluU9Pv0UByaso/DE84BjcPCoqAsarFDg7VzMlRXA0t2OBaI
         ovrqUW237NWLLT/T57XEbEUSkozMvYkcbYHAvVrolY81sJBcDHKm5bKI5bsIASCd0nCr
         G3DVnij75bbUz7aFrkpl0FPVswniPyBiMe4PghtlQGCt5Ws8kme8d9JZ8H3tSDIAnzM0
         cAhA==
X-Gm-Message-State: AOUpUlGZ9OyUIfLS3EyU9N+ctMccbqnnKPFRJ3FZRwzLzgHlnbM7jzWR
        aFKc1/K3bCmbznvX4Xu3NoKhuDPv3ILKrDTatF+jHkRwR/ZqscjtEGrF0oFt+x1frnYwErZ8rCi
        hxj1UocELPV9E8WhIDKRfG41D2CyQTXXZ44KdnBYcfahYREvWU4qIvmLqfSYI
X-Google-Smtp-Source: AAOMgpcLCE3/XkawOJDzUv3reo6jitIc7E0NHJJo3jOR85QweGNmqZZjz2b1+0MvtbEdCyWrxzt6eRvMp65p
MIME-Version: 1.0
X-Received: by 2002:a37:5d03:: with SMTP id r3-v6mr1846499qkb.27.1531424878006;
 Thu, 12 Jul 2018 12:47:58 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:48 -0700
Message-Id: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 0/6] git-submodule.sh: convert part of cmd_update to C
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought about writing it all in one go, but the series got too large,
so let's chew one bite at a time.

Thanks,
Stefan

Stefan Beller (6):
  git-submodule.sh: align error reporting for update mode to use path
  git-submodule.sh: rename unused variables
  builtin/submodule--helper: factor out submodule updating
  builtin/submodule--helper: store update_clone information in a struct
  builtin/submodule--helper: factor out method to update a single
    submodule
  submodule--helper: introduce new update-module-mode helper

 builtin/submodule--helper.c | 152 ++++++++++++++++++++++++++++--------
 git-submodule.sh            |  22 +-----
 2 files changed, 122 insertions(+), 52 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

