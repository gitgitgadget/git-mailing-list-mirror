Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61167C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B9E2054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxPDwBPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbgEMTM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390419AbgEMTMz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:12:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF6C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p17so510170qkp.10
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FpwNzRItuPtBy3J1NlgneXsz+h6kwH/DHziHXtrFeqs=;
        b=qxPDwBPmowrMCZsXSxzBC9NdtCipGXF+AsjTXYtof+UihpKR8I2qexHiXR9tmvwycm
         93vCfysLbbIy0MG0rguhCl/A3uVbEl/1DfgwxqpxkWzRF3U4YhSQSmIRupHBxzTfBOxw
         tdA3oNMc6mh2ejvvtJ0GVLq0PACPv7m4rDjaDcLcrAfNCtRN15Pyam2du6Keu90de0cp
         nyQW3G/YwQ8FCUflnNnCokpBuDia/wR3R2uBAMTVM2k9hL6C7E6Q2Hh5xSl/BD5R+sy/
         xTcZkmqn/HEV+hmK3OcTPdM1y3wJyGfxpNioTvrCexUDKVxzeQoKE83QFKk+0WXe5Hx7
         j+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FpwNzRItuPtBy3J1NlgneXsz+h6kwH/DHziHXtrFeqs=;
        b=ECIHG2acHgPPhm9rJEvxyUJSxgECVEiypoGzxyx57nzI1+ksvxw7prfaNE00nJDNaS
         7MPyywtpP4//CZz7ED7CMY0A9N9rlnLwmI65gybZL+ynYKejdfynLQsnVeLPzLmyaqBn
         nqJugSQMIKxyRtauwsq6741Q3tU/ncuQNcva/10SlfvsO20llFIbNCodkMFsRJYeiX42
         5Jhn3jve/WY9L99HPT+malL6nEHdWxBFfrz5X7rfWjvtA5CrH+2MS6OQmPNMNDPA+1Nl
         6fWWyLvbPoz+frcsAcKQTRejCTSBOb8Z/9oCjqOG1pM/4VmyF9dBbC8QiEBlTMURBbL1
         ZdEQ==
X-Gm-Message-State: AOAM533aScOnMh1O8TNK48ooO2pVF1VVaulSAgOUajTf5eTgTkdygAMm
        awYBdmLn7LM8ywfMTUnsorvZk2FNah1HKpyPJAIcg6k5hRT2iwcmOnpSS2KZFgSVgIG7l9wjG5v
        j3VW/W3GOiUqpxQqI2u+McrILDdnoJ1yA5+7DZ1hjDH6xzQcrt9cyC1/nGnqD4Z61+Y3sOn/2ZY
        51
X-Google-Smtp-Source: ABdhPJyfC+dWNu2uCKRcAS98JTKeEJ4B33PISxSxiiABuWOjGHGfJkbIWA8HAQqkqxUjCjT9U+h0YbRQAxfjQtC6yhM0
X-Received: by 2002:a0c:a619:: with SMTP id s25mr1175920qva.21.1589397174855;
 Wed, 13 May 2020 12:12:54 -0700 (PDT)
Date:   Wed, 13 May 2020 12:12:45 -0700
In-Reply-To: <cover.1589218693.git.jonathantanmy@google.com>
Message-Id: <cover.1589394456.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2 0/3] Safer GIT_CURL_VERBOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        sandals@crustytoothpaste.net, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone. I went ahead with GIT_REDACT_AUTHORIZATION to match
GIT_REDACT_COOKIES, with the default being true (i.e. you need to set it
to "0" to have behavior change).

An alternative is to name it as non-authorization-specific, e.g.
GIT_TRACE_REDACT, as suggested by others. But as far as I can tell, we
currently only redact auth (by default) and cookies (opt-in, since we
need the user to tell us exactly which cookies to redact), so it seems
better to me to have auth redaction be a peer to cookie redaction,
rather than being controlled by a flag that controls everything.

Jonathan Tan (3):
  t5551: test that GIT_TRACE_CURL redacts password
  http: make GIT_TRACE_CURL auth redaction optional
  http, imap-send: stop using CURLOPT_VERBOSE

 Documentation/git.txt        |  8 +++++--
 http.c                       | 19 ++++++++++++---
 http.h                       |  7 ++++++
 imap-send.c                  |  2 +-
 t/t5551-http-fetch-smart.sh  | 46 ++++++++++++++++++++++++++++++++++++
 t/t5581-http-curl-verbose.sh |  2 +-
 trace.c                      | 20 ++++++++++++----
 trace.h                      |  6 +++++
 8 files changed, 99 insertions(+), 11 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  8c70a45b24 http: make GIT_TRACE_CURL auth redaction optional
1:  1df9e9deb7 ! 2:  f5a29e8fa1 http, imap-send: stop using CURLOPT_VERBOSE
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct crede
      	return curl;
     
      ## t/t5551-http-fetch-smart.sh ##
    -@@ t/t5551-http-fetch-smart.sh: test_expect_success 'GIT_TRACE_CURL redacts auth details' '
    - 	grep "Authorization: Basic <redacted>" trace
    +@@ t/t5551-http-fetch-smart.sh: test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_REDACT_A
    + 	grep "Authorization: Basic [0-9a-zA-Z+/]" trace
      '
      
     +test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
-- 
2.26.2.645.ge9eca65c58-goog

