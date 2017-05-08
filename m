Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD851FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbdEHVd6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:33:58 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36274 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdEHVd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:33:57 -0400
Received: by mail-pg0-f45.google.com with SMTP id 64so17409231pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=suWl94ZKW79SeUwuewJMAoLx55Wf6l/xLhSgPDZQKB4=;
        b=IKpMAZ+pKXBJ5XjoSGRs1v6cZVUEYLn2SVzloAXTcpU5zZOtVrcM2EwdpVWUDfKiii
         k6akj/1RBBr7RBaUOvT2zTnAdWTcTHN7qTrqQl64371HJ238z8Aqq3MiIdmzOwO9AHgp
         oGTEnvtw2g47YCc+UU2v8nPLwjwVuBpOO0lhofXrK7w95ic/aQHd0KAr+Zgk9NDpaaS5
         MKFhg7IGmmcPah1pJe9DGyEUk99wPz7UWtJMyDbbYo3Bf0kB2t0L+AKO0DDKZ9eKMvkb
         LtnT4yOTZL3IUFquoNUNNyF58DuW6+7GRUTp8zSCvJsh9oyO0vUm0zbW4/JHhdERL208
         BPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=suWl94ZKW79SeUwuewJMAoLx55Wf6l/xLhSgPDZQKB4=;
        b=HcetOGumXKMZWGvnXIT48Vnn/DytzidcfhEV7fg2Ma8QcxSpNJdS62GwWipj9AauXY
         69X1eKFLkqdPFoCFDVDuCiSibweVtWCxm3wQmiqu2A7J4fjtiWz6owRmuMVFTLUYKepq
         nXKQ0b2QkCVBLS7MfDP/zy3nLqu8QGGEUcne73EGzLc5eqhxohW/7xiToj+qptc71c1b
         YmjuyiolLv2Xim5+nMjwhi9vvb5hc8niloaMG+20CT8QLhdPH1o31Xn2DnwXHT/gnqNY
         5+OceBUGTD7lMXe54pSykYAd+wKVhVa2vfkrDBAYZK3ama308P4Q4JVGTVbF+GAXEDzy
         6YPQ==
X-Gm-Message-State: AN3rC/5DDybQ7mXLlxQG08gQhj8Jsu3GzHZf7i+WS1oo2bqIMR9izl22
        L/dRB/Owq46wj5fA
X-Received: by 10.99.121.67 with SMTP id u64mr20795845pgc.230.1494279237068;
        Mon, 08 May 2017 14:33:57 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c196sm11229854pga.23.2017.05.08.14.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 May 2017 14:33:56 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, gitster@pobox.com
Subject: [PATCH v2 0/2] Clarify interaction between signed pushes and push options
Date:   Mon,  8 May 2017 14:33:49 -0700
Message-Id: <cover.1494279020.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
 - merged last 2 patches
 - patch 1:
   - updated advertisePushOptions doc to say "False by default"
 - patch 2 (formerly 2-3):
   - reject mismatching push options (similar to how a pre-receive hook
     can reject a push) instead of merely reporting it
   - added test to check failure (in addition to success)
   - modified pack-protocol.txt to describe new behavior

Jonathan Tan (2):
  docs: correct receive.advertisePushOptions default
  receive-pack: verify push options in cert

 Documentation/config.txt                  |  5 ++-
 Documentation/technical/pack-protocol.txt | 32 +++++++++++++++----
 builtin/receive-pack.c                    | 51 +++++++++++++++++++++++++++++--
 t/t5534-push-signed.sh                    | 37 ++++++++++++++++++++++
 4 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.13.0.rc1.294.g07d810a77f-goog

