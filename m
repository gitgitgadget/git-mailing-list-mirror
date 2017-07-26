Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C707C2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbdGZSRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:17:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35762 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdGZSRk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:17:40 -0400
Received: by mail-pg0-f43.google.com with SMTP id v190so87501944pgv.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3J/2kqFV7v5Mw0YoG/y5yW8oxguUMjLfu73Sh62/3dY=;
        b=CsaYi8leCbdtoJG0cZqL3H9iXL7C3y36rqpLpRp3QAYTqoepdBzlYZQxhM6Z+sbEaI
         3Hb0dEqRHA+TkZaGZnuDoegVf3WXONsHYYU92dbpaOIJ45u01m2L92nbeztxblbzCENn
         wDQbnLI+EmiCrB5hwj2cvlmBwsEljLwPIHtNaPKx58HjWYgc/ibFOBGbyhLbVAn6rACc
         LGOMpL8UmoV3Gb+WFr8pQsA5F3PHAG70QF46OanRuo0sbi4HV3cvQ4RoyQ7m1jOiYf7v
         nk+RRkQ4Gx4ysqhf49VXVG7763Wn48xW43CmE7Cx+/1TT2G0ihsLdojG61crVn4bJG9j
         /ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3J/2kqFV7v5Mw0YoG/y5yW8oxguUMjLfu73Sh62/3dY=;
        b=PhcEqcPPaMVJaBPqnkTxjv2s9W0tXGLuyxk50JPMUALKzGqgd/WFuJjgfrAY0EJKbt
         ozPvnkCn0nbsn5RdHBiQvUbfEgAEjBf3mxmUfLEpZPnOdmNRfpuSOIVoPVhzwCFxp8Yf
         ZF4Oe/iZzts3g0lFCVq4fM5Pt0oMOByL0ggrXfA/nZAY3L/8mUSISAa/f5kKaZRQvOPq
         8WD1jssPRZa7H463ENoIlrZql/zQVeYYfBkkcLJ4OlY7g1TBwxwR+yUguVRiiwl4QXUy
         6C/5QtlmnSu5PNuEhTsNwr3kTaXfHBhtKh+Je5iEJ8vIpEc4S08VmHiZv+OCq+slzjWu
         Cu/g==
X-Gm-Message-State: AIVw113u4lFE+GF/N3r7NUjfFSPwtVg/f3mNeI5G8xigzXUWwgn/iE+Y
        i6QG/aPa+3wqlz17YY9VSQ==
X-Received: by 10.99.55.10 with SMTP id e10mr1720364pga.176.1501093059438;
        Wed, 26 Jul 2017 11:17:39 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w24sm6637038pfk.183.2017.07.26.11.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 11:17:38 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: [PATCH for NEXT v3 0/2] sub-process: refactor handshake to common function
Date:   Wed, 26 Jul 2017 11:17:27 -0700
Message-Id: <cover.1501092795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170724213810.29831-1-jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all your comments.

This is now built off "next" to include Lars's changes.

About whether this is too restrictive (for example, as Junio mentions,
this will not allow future capabilities of the form "key=???"), I think
that this can be upgraded later if necessary. For now, both the filter
code and the ODB (and ODB-like) proposals on the mailing list do not
require such a thing, so I have not included that functionality.

Changes from v2:
 - now rebased onto next, to pick up Lars's changes
 - split up into more functions
 - welcome prefix does not include final dash
 - no more gotos in expected cases (or at all)

Jonathan Tan (2):
  Documentation: migrate sub-process docs to header
  sub-process: refactor handshake to common function

 Documentation/technical/api-sub-process.txt |  59 ----------------
 convert.c                                   |  75 ++------------------
 pkt-line.c                                  |  19 -----
 pkt-line.h                                  |   2 -
 sub-process.c                               | 103 ++++++++++++++++++++++++++++
 sub-process.h                               |  51 +++++++++++++-
 t/t0021-conversion.sh                       |   2 +-
 7 files changed, 160 insertions(+), 151 deletions(-)
 delete mode 100644 Documentation/technical/api-sub-process.txt

-- 
2.14.0.rc0.400.g1c36432dff-goog

