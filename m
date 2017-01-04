Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBC52092F
	for <e@80x24.org>; Wed,  4 Jan 2017 01:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762314AbdADBst (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:48:49 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36854 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760371AbdADBsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:48:47 -0500
Received: by mail-pg0-f43.google.com with SMTP id f188so220826571pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 17:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bp9upNLvY5oE0ndn1ud5i8BNHRwNGkGRfUXkK/T1lOY=;
        b=EUaEBkkJzOpn3CFyBEUROBid895ZG6FLFPZOoBWRcsXppjfb2bglgK8QC/gVu3Hkyn
         RpPfg1Y5t55Frv327CSRiV1VqmcJiEQGv3cwtX/Uj5bO5k4MAr1l8CUqy2mehjESelGi
         Z8DhGMxv2/GnoN9QO0be0swvKc5Xc99uRAJKyZdmej3PXy0C2Qu49MgUAxhLSDeEAEKN
         O5piW+0oNqce4j/QuBL4FORfmMHofSn8hLWSUTAgfoqZq+lad0+dXFp1hV3X6lWG8anW
         7gu1/dy0hraeEEvc/dVMdaPiYdKAWeDyYE0EgBwCrDRTYBNzEWQlWJN379iXjhNfzKZG
         0kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bp9upNLvY5oE0ndn1ud5i8BNHRwNGkGRfUXkK/T1lOY=;
        b=WZgHsnFsRuLKulq1RdKigyVwzJnNNmhBEQuGqGO9Pi4dB+bT2b6oGBf7rFKx0VZZhi
         0nA36MoejLgh8S8Az4xBkF9Ob4LelsGi6BUqZLaC06QXCGoBq+izBV8FXyOYPyZMzHu9
         qrWDKtg5NO6vdb7Vs54i184ZYnSso0g2CW3R6pLbT3VfwxBS/HWfMSmRHZBuMzwT5CM6
         n46mVZHXpR6g3w9eq1R5D6MHv/3V2WgAuP8bnRNH/17y/EKUeoDHIUEl7Hz7+r1xbR0Y
         Gids9ayVTqqDd2qCUVASul/yp6zFbq+cJN55HM7cRAgAemwRujrdTDXAtdSrcp5PoefO
         JjJA==
X-Gm-Message-State: AIkVDXKw6vc+4t/wngMcuQSZyLepjcTwsTLcrWrN6Hjn5tljyC42OVbldHPMnMikY5ysNjE6
X-Received: by 10.99.24.92 with SMTP id 28mr2243950pgy.100.1483494526672;
        Tue, 03 Jan 2017 17:48:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:f014:c1c8:7de6:70a4])
        by smtp.gmail.com with ESMTPSA id c15sm142620179pfd.36.2017.01.03.17.48.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 17:48:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/2] pathspec: give better message for submodule related pathspec error
Date:   Tue,  3 Jan 2017 17:48:33 -0800
Message-Id: <20170104014835.22377-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.31.g2cc886f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It MIGHT be a handy hack when writing a test, but let's stop doing
> that insanity.  No sane project does that in real life, doesn't it?

> Create a subdirectory, make it a repository, have a commit there and
> bind that as our own submodule.  That would be a more normal way to
> start your own superproject and its submodule pair if they originate
> together at the same place.

This comes as an extra patch before the actual fix.

The actual fixing patch was reworded borrowing some words from Jeff.

As this makes use of "test_commit -C", it goes on top of sb/submodule-embed-gitdir

Thanks,
Stefan


Stefan Beller (2):
  submodule tests: don't use itself as a submodule
  pathspec: give better message for submodule related pathspec error

 pathspec.c                       | 24 ++++++++++++++++++++++--
 t/lib-submodule-update.sh        |  2 ++
 t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 t/t7001-mv.sh                    |  5 +++--
 t/t7507-commit-verbose.sh        |  4 +++-
 t/t7800-difftool.sh              |  4 +++-
 t/test-lib-functions.sh          | 16 ++++++++++++++++
 7 files changed, 82 insertions(+), 6 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

-- 
2.11.0.rc2.31.g2cc886f

