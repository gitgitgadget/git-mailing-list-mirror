Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946211F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdF2WWe (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF2WWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so4977787wmj.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHwDzzNS+Nh2F2y5TUYlbR7BjcdldI/bXgQljxUD1G8=;
        b=lMYolZE9HBKSJA+dzTw3bsWkBqlz7DxkXtUhCn+emFxvJcKfYfv+HmzjYmPPAKVDmP
         8+8AU6Q6L7rn8/FzuwSVjBKF9F27fFkA5EDUR5bXv7w94d76EbTvcENaZNJHMT0ZdP7a
         BJC063FE7Z2WikIxdvBAhsZ8eXYcVXVyQUbVD392txzaQyTLATqSyiEEwCoGarGu9RcX
         yXgg1sKnhhweVvhK9qp1cI6+eSYrfddmh0HV9za/cheNI4g1AXrwiwmAw38xVWbIWXtn
         b3Ie1n4zA/XKehjscJdzSvMzYri2h7zEpaQa6ABGE4ecz0eU1nQyjg1jyiXCL0UQVTzn
         qEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHwDzzNS+Nh2F2y5TUYlbR7BjcdldI/bXgQljxUD1G8=;
        b=hNq0i6wE5xuco1xkY/yEJM+AAzRtZ77LC0wnOdPuKs+x/fsqO75wkFrF2JPwDAiPVZ
         njBIsPILEj+TFalSU/eGYgvdrzGjCFGTt1YhrImLDBFx5WDR0X0lhzPCVqgHpG00r3j2
         JZS2oxSXA0wiR0/YI4n14ZwmzLIEnGsNItBoe+7UtsN6PzEmi30rOLdNLNkX6gHha+6r
         5P5gh6ZY/aB+KA8TnLJ/bWU2AQqc0Vp3b5/cb2WQYxDUCVXw0SxV68lrAzt0d3Zyl2sd
         jVJSJZaHsK49XAw0RA+n/L1G5YVKrzJFgSUSjof6NPc+oL+ZmHZZxvxA2GLb41d/AAe2
         s/0w==
X-Gm-Message-State: AKS2vOw2Xf2KCCB1Fwf14vO+LoTM1BCd8CVZlwW9vtLF62bXHgcxP85t
        FcT9RZlJe7pJgV2dULQ=
X-Received: by 10.80.208.2 with SMTP id j2mr3139379edf.115.1498774952065;
        Thu, 29 Jun 2017 15:22:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] grep: remove redundant code & reflags from API
Date:   Thu, 29 Jun 2017 22:22:16 +0000
Message-Id: <20170629222222.4694-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses comments from Stefan Beller (thanks!). I looked into it and
the REG_NEWLINE flag was redundant in 1/2 cases, see 6/6 for the
removal of that.

I looked into refactoring 5/6 as noted in 87zicqirrg.fsf@gmail.com,
but for the reasons now explained in the last paragraph of 5/6 decided
not to and to keep it as it was.

Ævar Arnfjörð Bjarmason (6):
  grep: remove redundant double assignment to 0
  grep: adjust a redundant grep pattern type assignment
  grep: remove redundant "fixed" field re-assignment to 0
  grep: remove redundant and verbose re-assignments to 0
  grep: remove regflags from the public grep_opt API
  grep: remove redundant REG_NEWLINE when compiling fixed regex

 builtin/grep.c |  2 --
 grep.c         | 62 +++++++++++++++++++++++++++++++++-------------------------
 grep.h         |  1 -
 revision.c     |  2 --
 4 files changed, 35 insertions(+), 32 deletions(-)

-- 
2.13.1.611.g7e3b11ae1

