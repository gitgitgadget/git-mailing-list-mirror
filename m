Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259AC1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbdJ3RVr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:21:47 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46724 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbdJ3RVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:45 -0400
Received: by mail-qk0-f193.google.com with SMTP id k123so17105295qke.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CU/vS0xEstdtOf24IvNL+/ebpg+U4j6DnSXyAMrSE0=;
        b=cMon8yWp824pbg8J8O/pq+BPwWLLChHy4Kp4KXccmqGRa2rnheJQie3cuPr1KMqHAL
         fBBAee5L1w7lRmcCsmZQr889KL7OzkqziQerS6b2tMegp+Z96aqZ+05nYPjY6bzJQgIH
         Z7mJU3fYxEJUa0D/unxWdb54xchLPShDYvok53DMGLWXOcJ/O9u/bH9bRTKNHKPC+zw4
         X8oh0yNZpwIcS2q12J4MO1/YJNTeGdYWwDKm/F4+qLeFqEX1WJNgST30uUWqL+30uBGZ
         B1X3joxWmerVTNvyONAfAmCzd7AaRqmMcj7bKz/WmwyJcSiQ0Me7/BaKOfb6jRbZu41Y
         2KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CU/vS0xEstdtOf24IvNL+/ebpg+U4j6DnSXyAMrSE0=;
        b=EftVNq/mWWhTOQnzIbp3HFlDybA0M9FftMhsFyzSqFPl5FPXJ6j5OVTAlIx5lCyUbE
         DpPOgi7/cbhu1EUakZzWENP60RbRty+WDF4dKa9mXV5IE64k0cwJIoFbZE6vUGeFWeDt
         sLCwIGB52ITkf/IlaZf4iw8nlXm6Zhpe9OFHUCx809DcwxVC6BQ1ufEIi05vgZfN6mtF
         aqPWbZeXqMkDgXDcgLP6O1VnfyPw9dmux4/xiylHRt9BclCrCIbUk2ab0aB8CpGr1W3q
         jCZWSyL3ZSgErtC4M2UUi8qDi0uLDgqAKzm8V3Bpg4FoDJKT/XgCn7tBBG9rJZR+Dlap
         d7uw==
X-Gm-Message-State: AMCzsaXqcoj6lcR01bRsc6++Mo7ccwv9RZtf20bkeFlNQpqsNDztGuPK
        +27tSB8W9v0y5eY6uFqZ4Es=
X-Google-Smtp-Source: ABhQp+QdEKCTAVIpQZT9Oyp4I33e5zinhQ/tnQQIErPqe4zUbFL0L1RoKXN7fxkFD37PnUuYSmdq0A==
X-Received: by 10.55.43.227 with SMTP id r96mr15091888qkr.216.1509384105104;
        Mon, 30 Oct 2017 10:21:45 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id n23sm9670119qka.1.2017.10.30.10.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 10:21:44 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v5 0/4] status: add option to show ignored files differently
Date:   Mon, 30 Oct 2017 13:21:36 -0400
Message-Id: <20171030172140.235797-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Previous patch series can be found:
https://public-inbox.org/git/20171023170534.157740-1-jamill@microsoft.com/

Only difference from previous version is to update the commit author
email to match corporate email address.

Jameson Miller (4):
  status: add option to show ignored files differently
  status: report matching ignored and normal untracked
  status: document options to show matching ignored files
  status: test ignored modes

 Documentation/git-status.txt                      |  21 +-
 Documentation/technical/api-directory-listing.txt |  27 ++-
 builtin/commit.c                                  |  31 ++-
 dir.c                                             |  44 +++-
 dir.h                                             |   3 +-
 t/t7521-ignored-mode.sh                           | 233 ++++++++++++++++++++++
 wt-status.c                                       |  11 +-
 wt-status.h                                       |   8 +-
 8 files changed, 360 insertions(+), 18 deletions(-)
 create mode 100755 t/t7521-ignored-mode.sh

-- 
2.13.6

