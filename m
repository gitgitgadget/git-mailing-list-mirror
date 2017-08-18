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
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D3F208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdHRSdU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:33:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38525 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdHRSdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:33:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id y15so6721513lfd.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFdI+gKWlLw2bk7tHc/lssY6eVckL9h1LB978l5uXyg=;
        b=epkEmNIt5jvgWABHtdUdqo/QIFYqHs8mxRMuxaDYYhq91boUiRijMwRLnKmdlbHd45
         vBoTsFvE5TmFBO5z2r/StplZmnB/EzuV8d/LQmBczb+5BTjtCkcP+GcOdfh5icEyHL+D
         1Krrw9UWVocJ+2TfTt9Ie/4vTyEhp9KzFY/iU27/79emukPMRFIUkgXZkAwVZV9V/Mwq
         QJmuxDFrr0FsGvTKC14dOX8Y1tUfpu49HWGUi8GIt1E5d42T/9qLFJ5/8us0nIbLjZkA
         TetBVdsNqO26y+Gk3n8rNtQFUBTjJg1mmpscy0VlRNLvZpLbd9Jcbh02FI70xU1+5kNG
         t4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rFdI+gKWlLw2bk7tHc/lssY6eVckL9h1LB978l5uXyg=;
        b=WrUU1dIZfhr50Ste8j4K9RCBZkO1VGHcsJUE8+Ha2lL+mSg0lQt4ivldOsq1MH8Bol
         PTVm8VkWsQbxavNt9KnuA5QQIITPCjyQIwaotMoo8Fo6kAF2HqctSfOGi9MFV+KXQOxi
         ghVKlWbpxDPLp++mvRfZ0g1QhrfqCXZ/VKllDBVzA9AIIaOewUnpoiZsqiI8N9RradbE
         DpkhtGx4z5jX+IeoS3CvTBHBB7GIoN0qaz2/NEgw7QK/ZwI/LnEno59BaBTsMFUdaFr4
         4z/cwCqdFOYbXKFsPA5Ig5r75oo/VpNsWR5bdhBDjA3kOPp0E+khIkkUpYMuAZw6jc5v
         2Exg==
X-Gm-Message-State: AHYfb5gLyUT3BaWijNFwAWdqFj4Ey+U0xKKCRP+9umiroDqb+txEwIX7
        W1oTR0CI3Nm3pE/Xl7c=
X-Received: by 10.25.171.18 with SMTP id u18mr4003706lfe.21.1503081197474;
        Fri, 18 Aug 2017 11:33:17 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r82sm813568lfd.45.2017.08.18.11.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 11:33:16 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v4 0/4] Modernize read_graft_line implementation
Date:   Fri, 18 Aug 2017 20:33:10 +0200
Message-Id: <cover.1503079879.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

- Commit replacing raw buffer does not store temporary pointer to
  strbuf internals any more.

- Commit message of patch 4 explains all alternative approaches
  considered so far.

- Patch 4 uses two-phases to parse graft line, without code repetition.

I have my reservations about patch 4 from readability standpoint
(it's not immediately clear why parsing code can skip freeing of graft
in phase 2), but this implementation seems to address every issue raised
in review so far. If you'll prefer me to go back to impementation
from v3, I have it prepared ;)


Patryk Obara (4):
  sha1_file: fix definition of null_sha1
  commit: replace the raw buffer with strbuf in read_graft_line
  commit: allocate array using object_id size
  commit: rewrite read_graft_line

 builtin/blame.c |  2 +-
 commit.c        | 45 +++++++++++++++++++++++++--------------------
 commit.h        |  2 +-
 sha1_file.c     |  2 +-
 4 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.9.5

