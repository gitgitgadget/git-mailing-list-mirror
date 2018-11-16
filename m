Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79B31F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeKPVQG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:46870 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv2gYs1n; Fri, 16 Nov 2018 11:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366252;
        bh=yNZJMy8YQsI+1MjppGn2zDziOGBe/QZVqw4wZ6sqDOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ISLrJaGLiEW9rk1RFhmX/aeMkie/NCHzKHrYX5XwG5OT+wxz/XNdq4BYbqfcmY5wC
         /kvoVp4AAB8GaDgMh2zZG86w1eMWzggYbe5mmagyKi2Yqik+IEKpLGgY+kHhssgEbg
         GizWvS+AxRMN+A0npM8mr3OKH6y0NXoNAiICyGPo=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=5MXlXvTEBRVB2WefFkQA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 0/9] diff --color-moved-ws fixes and enhancment
Date:   Fri, 16 Nov 2018 11:03:47 +0000
Message-Id: <20181116110356.12311-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDJ2jOP58NfrWOVBX5WwVa/pobMfdu79AZuqUoQ3c2OKFde4jZAoDkhW7vD4Kptpu0TCSAMxJoimtRBhdnii8FSIhJx+VAJPYLHQzwVxvlMi2JDkwhfr
 bR85y/ptol+HQ3k+3/xUNs2OuPfPg+Tc58LvaiqLRicwQlYoqGR7ogu/bE5d/O00fam3SsElgoVpvbKFLmX57iQ+G3rHsk9uOJxNvJt7kEzmLEHg8S2ydnMm
 ZL2z+UDanJpg5g/MYgZ66g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When trying out the new --color-moved-ws=allow-indentation-change I
was disappointed to discover it did not work if the indentation
contains a mix of spaces and tabs. This series reworks it so that it
does.

Since the rfc this series has grown a few fixes at the beginning. The
implementation has been reworked, the last two patches correspond to a
heavily reworked version the last patch of the rfc version, all the
other patches are new.

Phillip Wood (9):
  diff: document --no-color-moved
  diff: use whitespace consistently
  diff: allow --no-color-moved-ws
  diff --color-moved-ws: demonstrate false positives
  diff --color-moved-ws: fix false positives
  diff --color-moved=zebra: be stricter with color alternation
  diff --color-moved-ws: optimize allow-indentation-change
  diff --color-moved-ws: modify allow-indentation-change
  diff --color-moved-ws: handle blank lines

 Documentation/diff-options.txt |  15 ++-
 diff.c                         | 219 +++++++++++++++++++++------------
 t/t4015-diff-whitespace.sh     |  99 ++++++++++++++-
 3 files changed, 251 insertions(+), 82 deletions(-)

-- 
2.19.1

