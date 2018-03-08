Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359A21F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbeCHMiw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:38:52 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35752 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCHMiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:38:51 -0500
Received: by mail-wr0-f193.google.com with SMTP id l43so5532401wrc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3UGQFhJb4UfWlPEeAROQgFA3d2Vhd5A71mPYTvjmR0=;
        b=kFZjb7p6qvyzTIErGdj5YNb5DE6ADRB6raQDq2z3Bi/uB7lQ0QgBrYi2exQXhE2Plc
         4RZ6vBgzXjecgJm+GL4YLciywwLM2Ro3TVr9eRKkT+EfI/yn+G6IxsoAdyliSmKcMhuw
         CzagjBmVY5V4WThJwjQe2sXR+o6lVJLgEh3JcTUHNKz5lqbzz3G0z0FuW/x03qLoAley
         MfRIDrQEofRvx9wvSKOi8AfBnHqED2Kqa1rUolCog1zrCNnC6iCUWRvKaZrKQjr6O/Og
         gmH/pAnMwWXsAp5/ZqwSRRjFy4tkovK+3wjNfHrA1Na4gF/rABxBPTBgZW5NeUy2ogsh
         SqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3UGQFhJb4UfWlPEeAROQgFA3d2Vhd5A71mPYTvjmR0=;
        b=DJTHnxNDiIeYguxj4JIvCQ8XtZWcSEXn3rvvvhqZT32PZKxYVJI7/sWd8aTmu0WxRK
         +Dk762qL1Wiz+bp/+EA9YYgrET3+m2i17DW+bCIQQPGipTdZDa44asYmQOG3BWFigFxg
         1E7oksIH22lugiByzjBlNpUWNFD8nx1RnVcv/EtQSzI+CfkFmKcXGhBDFZvpahyb7o89
         Sl7Q3bx956/TjvMbFOhKkx2OIIUt1ql944kLF3bvsWPL/iynJ4mqpSw3++7xcBdAWT5t
         S7mxZ0S59m06COICMqdcZNh1qJPH1H06SKA4osDUEqePBVm53+xYatR60bNQd3zlNeag
         02JQ==
X-Gm-Message-State: APf1xPC9ep94mWeGbafwMvUxH12P/6ltP+HpabRtaYZstz7httrnuASZ
        whyENMYRd/Ci3YOdMDA/xlyRiSkB
X-Google-Smtp-Source: AG47ELv/DCAQZfrYNNPjDmy8xb66u1U4AToxZyQhgtH8+l2T53hzSg959Ue28AQp+VIZPvL4g6/iLw==
X-Received: by 10.223.171.88 with SMTP id r24mr22515989wrc.194.1520512730841;
        Thu, 08 Mar 2018 04:38:50 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id l11sm16721809wrg.71.2018.03.08.04.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 04:38:50 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Make cvs tests pass with '-x' tracing and /bin/sh
Date:   Thu,  8 Mar 2018 13:38:42 +0100
Message-Id: <20180308123844.15163-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sat, Feb 24, 2018 at 12:39 AM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > This patch series makes '-x' tracing of tests work reliably even when
> > running them with /bin/sh, and setting TEST_SHELL_PATH=bash will be
> > unnecessary.
> >
> >   make GIT_TEST_OPTS='-x --verbose-log' test
> >
> > passes on my setup and on all Travis CI build jobs (though neither me
> > nor Travis CI run all tests, e.g. CVS).
> 
> I installed 'cvs' and whatnot to run t94* and t96* tests, and sure
> enough, 5 tests in 2 test scripts fail with '-x' tracing and /bin/sh.
> I think I will be able to get around to send v2 during the weekend.

Well, I wasn't able to get around to it, and in the meantime
'sg/test-x' got merged into 'next'.  So here are the updates for those
two test scripts.

The commit message of the first patch is perhaps unnecessary long, but
it's mostly about explaining why the affected test was working
reasonably well despite the rather weird 'test_cmp this that >>out
2>&1' thing.

SZEDER Gábor (2):
  t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
  t9402-git-cvsserver-refs: don't check the stderr of a subshell

 t/t9400-git-cvsserver-server.sh | 15 +++++++++------
 t/t9402-git-cvsserver-refs.sh   |  8 ++++----
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.16.2.603.g180c1428f0

