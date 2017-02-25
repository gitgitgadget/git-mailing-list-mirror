Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3144D2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdBYHY5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:24:57 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33321 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdBYHY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:24:57 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so5903122pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6MzYVMf+r32Cq95UDkQvCTq9r4YuJH4aIhHQeG1fLCQ=;
        b=NPRCLwSZ3fCo8kTY4qd/kb97q5SfQXm5r0LGYFvtFH4VBZo6A18ozOYMWFXbuBso7X
         JZFsW1NrYCKHqPXmNwRhCWcrFvfX/z2FRVORZUP2/cT8bH8tq4+vwIWy8mDnokPRV0dr
         hmOg1nHmpfzNLWBeyDGpOf1pmg/eJ9CXuR3RAMIxuQcVXSFxOFMNpTDY6qNXZqjfStCD
         cTncGrcZf3dR19E0OKav2n2/GRn30VmAL98h+pFdajwAVTEULQztiA+k9zBvdDZlTk4b
         Lg33cN807IrevoDVMLZxFWOEJSQ14RYkkn8GqyEEry6iNg6AJCijLWWEWjqKAu8NP7cw
         s+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6MzYVMf+r32Cq95UDkQvCTq9r4YuJH4aIhHQeG1fLCQ=;
        b=LgUySI+CzOD9y1997STvgiEyFcrbwacRV9uDq4LKqSwyI4QrzCXyChtIVOJZFnw5HC
         m04r0j9eSAVWJjzW3L4jIP61S5WNWTOlVeXyzoH5yDOpgwE6gZRUj9kfTQl4p5GVg62X
         twepvTrPEd/iuwsFnmvEhKG7Iokd24SiWHBDGoZugKtQeKMtwpCNCJQmfrxaVU8VeDgm
         AcvPLjJ5FdUU8LaORGg5JqMguSxJS6Cuy9B6BE6W+E20FUGBTOwOx92w2hlq1QOAAdkx
         jfROS9kseR9Y1LL08fwy25Jw/2l3hvWgcHEJhLzpqyeMuA3LH2878AgAye/FqqLh13AZ
         K5mA==
X-Gm-Message-State: AMke39lfH+5vPRO7qx4ehCqO34IhYV5BfgTqVS13sVwYOboUUQAkvGDEBCz5PDOti4YJxw==
X-Received: by 10.84.248.11 with SMTP id p11mr9447972pll.72.1488007496197;
        Fri, 24 Feb 2017 23:24:56 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id 73sm18654359pfh.56.2017.02.24.23.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:24:55 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 0/6 v5] allow "-" as a shorthand for "previous branch"
Date:   Sat, 25 Feb 2017 07:24:41 +0000
Message-Id: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An updated version of the patch [1]. Discussion here[1] has been taken into
account. The test for "-@{yesterday}" is there inside the log-shorthand test,
it is commented out for now.

I have removed the redundant pieces of code in merge.c and revert.c as mentioned
by Matthieu in [2]. As analysed by Junio[3], the same type of code inside
checkout.c and worktree.c can not be removed because the appropriate functions
inside revision.c are not called in their codepaths.

Thanks for your review of the previous versions, Junio and Matthieu!

[1]: 1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com
[2]: vpqbmu768on.fsf@anie.imag.fr
[3]: xmqq1sv1euob.fsf@gitster.mtv.corp.google.com

Siddharth Kannan (6):
  revision.c: do not update argv with unknown option
  revision.c: swap if/else blocks
  revision.c: args starting with "-" might be a revision
  sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
  merge.c: delegate handling of "-" shorthand to revision.c:get_sha1
  revert.c: delegate handling of "-" shorthand to setup_revisions

 builtin/merge.c                   |   2 -
 builtin/revert.c                  |   2 -
 revision.c                        |  15 +++---
 sha1_name.c                       |   5 ++
 t/t3035-merge-hyphen-shorthand.sh |  33 ++++++++++++
 t/t3514-revert-shorthand.sh       |  25 +++++++++
 t/t4214-log-shorthand.sh          | 106 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 178 insertions(+), 10 deletions(-)
 create mode 100755 t/t3035-merge-hyphen-shorthand.sh
 create mode 100755 t/t3514-revert-shorthand.sh
 create mode 100755 t/t4214-log-shorthand.sh

-- 
2.1.4

