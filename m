Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B7C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215EF206D6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OP2vvOcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgEKRnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgEKRnP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 13:43:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D1BC061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c89so10393867qva.2
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M3hYHtHzpl/3zjcaTjTw7TtwRfOuMh+4yR4PN+5B22M=;
        b=OP2vvOczx9mV2cRJHLbMiwsvmZgw0KLWLwNOxU1YRg4RL6ebvPvE1ldxnyyWxktnH5
         jYTwqo75pkzpCMAekjcXcap9wHWRkAn+2TC5JHI3Kv0T2OySpxZAIBF0jJlHwDVdxtbF
         LnDRqscdv6UN5gxslZ03zgpqhoGm5EcXezMr6FvguUbi99M8Eii764QZDPLTgxrt1ZOq
         u3pT+YceDaP4dACnp9kTqh3XhlvbBDZN5suJfElZcYLM9LIPUVlRnsJZ+RquqKuWDddj
         ggzowXwQA33bKCBotXTXRWo9cbWb2MnBsfLLheIYTDOdy5Y4dtT6MQb4j6Rs41eei6uO
         9DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M3hYHtHzpl/3zjcaTjTw7TtwRfOuMh+4yR4PN+5B22M=;
        b=J/HNSVzXo+/ouuHSkpwFjwfuXprcvfWHxMw6whbrplYRw5p8jSbHo6dsl14f28B9zS
         nKhQOksFrBwwGB8AusajqRE1nvx1zHU3ApMLpPjNKe23oAgOZofj2zeTNGQMscP0vm/Q
         r5G5P8lHgOmXIVugywV03IcYOdZ5GAzTBfMIlMV98ZcgBRRfGUyjo1TlN6zkDVNMQES5
         ercKxLuw1Hm+tHFeeNR7BRBlnm24PT0B26oYM36BkeIAREIpu4XRU1veHpLYMoMGQnBV
         COyI94mPDMZkGk7TdZTGqlv2E0NN45R87CmQG9MIQXyeVbl1ZqzYJs1Vyz0mReQU89Ax
         LPYA==
X-Gm-Message-State: AGi0PuaUDAAUmqv2V1lQOMuDBqrKsChKrf4dQlROq5BP9N3vuFk7hu5Z
        0knKkgj1szJoa5NXPGApifwaPwgDXiiH+VJfSaKucuMW6VpYeIM9wjNTf8SeWYIkvpdip1YuQTY
        A5lHZB3SvyCJ/UJVM640NXGowxYkWxyJ376neUTKXKKDj4n++lAu4P8IwYMrds2pFxgEC8wSa0r
        0P
X-Google-Smtp-Source: APiQypIDdTD+Ys2HDEZ1irsXm1yVHjgWwcX097N3S6bDkigjCAXDg5G1hL9WY9J/HIcu/Dnxkc+2MDHm/423cxUgOaEr
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr6865630qvw.221.1589218993150;
 Mon, 11 May 2020 10:43:13 -0700 (PDT)
Date:   Mon, 11 May 2020 10:43:08 -0700
Message-Id: <cover.1589218693.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 0/2] Safer GIT_CURL_VERBOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are patches that unify GIT_CURL_VERBOSE and GIT_TRACE_CURL. This
helps avoid GIT_CURL_VERBOSE being a source of confusion, especially
with the presence of GIT_REDACT_COOKIES. The motivation is further
explained in the commit message of patch 2.

I noticed some commits that refer to GIT_CURL_VERBOSE as deprecated
(see what 930b67ebd7 ("Merge branch 'ep/use-git-trace-curl-in-tests'",
2016-09-12) merged in), although it seems that they are just referring
to the fact that GIT_TRACE_CURL has more features than GIT_CURL_VERBOSE
and should be preferred (74c682d3c6 ("http.c: implement the
GIT_TRACE_CURL environment variable", 2016-05-24)). I haven't made any
references to deprecating anything in any of the commit messages, but
deprecating GIT_CURL_VERBOSE (so that we have only one way of doing
things) seems good to me - but this is a matter for another patch, I
think.

Jonathan Tan (2):
  t5551: test that GIT_TRACE_CURL redacts password
  http, imap-send: stop using CURLOPT_VERBOSE

 Documentation/git.txt        |  2 --
 http.c                       |  8 +++++++-
 http.h                       |  7 +++++++
 imap-send.c                  |  2 +-
 t/t5551-http-fetch-smart.sh  | 36 ++++++++++++++++++++++++++++++++++++
 t/t5581-http-curl-verbose.sh |  2 +-
 trace.c                      | 20 ++++++++++++++++----
 trace.h                      |  6 ++++++
 8 files changed, 74 insertions(+), 9 deletions(-)

-- 
2.26.2.645.ge9eca65c58-goog

