Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BA9C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0CF60F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhHDWR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:17:25 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A921C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:17:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v15-20020a0ccd8f0000b0290335f005a486so2475183qvm.22
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=VjpYAG7GjoamY7o7ndWy2AECTOfrlNkDPRmv9/ybTso=;
        b=jKNH5rmlyHycsKxIDsLkFpqAx/Lbak6/ybQu8R1o2/qL5HBmeb8ffPmGGljYfaMiHB
         Gs9Lo+aCfjwqbzmzbmPXjmLU3bSleMolUNWhfrQrQqehDAcBwdn22CIdX6P0w66pbA6h
         JC5i0pc9OWXkR3HUGqA0RTj8DvxJJAWN0OFa1YFjYjUTGiLDgzJloUgYbit8nLwBOPlE
         A0xNBySztESyODWrq9j7nmlNVPOwBmydP0gQ8Cg+oj5vxeQCd46wvy41lK1LtxA/qoLM
         CcGUv0D9dEfj5fwYs8dNZpfhaj0pA1yUYb3dSVjtUR9LDxpzLWAE67wQOOuNfI5jR8jL
         vt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=VjpYAG7GjoamY7o7ndWy2AECTOfrlNkDPRmv9/ybTso=;
        b=Kl3269ptAPP6qG32DwHQh3Sj/uvfrHuBLF1fG6GnEisRCMq0UJCY3HX38dj5Ct3/Mg
         QYi/Q8ywKdUu25bXx0BhUsY1HgjTxdwLyWhcBXqkMcyNzb9zZeS8CT0yeCuFWIJNhPAg
         ikpRZn4PDwZJBWitQVFTvX0zZyS/DWWJsV/G4DZRlWAFXPTdnVOuJ2QWq7/LkLssrWS0
         8M/jLjmIOo7YFm5Nw1lWEY7vZaIGc3uEP2SjdH7JzSahbd1JQaJFXWwuGS2W+QKxRglm
         N9znn1h8LRlHcn0z/YjqIpWyHRL0NyA+DnGCPBN7sBBqgN2U6Jjdg0uLZ3WAgEz6H+PR
         edUQ==
X-Gm-Message-State: AOAM532tVfrYYBrPIdGeFABBR8vtSkwNSJkRlIp71/tLda93Dq/kMYLX
        nlc34LhnEkbbNQAsx0euqK+nWJEsZId33trNM3r9D4laIFHQtpSBIy/3yWPpEDIG0BOGVL4Km7R
        J+SN1CBs4alkl0HOzh/bxqYQBU25CAByXhXr5C5Pjr9Uc9NIkjcEwGIl1pmIJQBk=
X-Google-Smtp-Source: ABdhPJyPmqB/Fdg3CsQvRmffHUfurn6PRxLpTrPrEuz3mb5II86qSFdfg5MjvmJk6xurzy6beXSrq/ct8kcADA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:9758:1083:3c28:c541])
 (user=steadmon job=sendgmr) by 2002:a05:6214:e4e:: with SMTP id
 o14mr1797933qvc.55.1628115431017; Wed, 04 Aug 2021 15:17:11 -0700 (PDT)
Date:   Wed,  4 Aug 2021 15:17:07 -0700
In-Reply-To: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
Message-Id: <cover.1628115064.git.steadmon@google.com>
Mime-Version: 1.0
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 0/2] log negotiated protocol version.
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds logging of the negotiated wire protocol via trace2 on
both client and server.

Changes in V2:
* adds a format_protocol_version() helper function
* adds tests
* bug fix: actually log on the server side, rather than twice on the
  client
* moves the trace statement closer to the actual version negotiation
  code

Josh Steadmon (2):
  protocol: add protocol version formatting function
  connect, protocol: log negotiated protocol version

 connect.c                             |  3 +++
 protocol.c                            | 17 +++++++++++++++++
 protocol.h                            |  6 ++++++
 t/t5705-session-id-in-capabilities.sh | 12 ++++++++++++
 4 files changed, 38 insertions(+)
-- 
2.32.0.554.ge1b32706d8-goog

