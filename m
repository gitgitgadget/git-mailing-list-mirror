Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7B41F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeCORdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:01 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:42635 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeCORc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:57 -0400
Received: by mail-vk0-f73.google.com with SMTP id j9so4745016vke.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pFPOgahYYmTpR0zYbEtapinckxWZTE+QUb6F4N5+RDs=;
        b=MfDj/x0pFCHujWDJ2d6s1Ia41IM2VG+3ou8af6nIQK5QdJCNE6+YWcUIoMSqHJwUW/
         of63ezyKWkJq9UYi96ZOrajYKaO1xxNSqqfewr9yiQ4Qm9/vCW6c8wUH0hrLmNM61/Nv
         73RhAkSl55SDqxO8XGOFNvJM47niwFIE9GwMleV5bY6184tbECrhi/4F7sC8uJVItyOu
         3bmM6rM2bQZYXIwlytr84TYJlD88qS0GWcRtHxsdXoCVbUMW+Oby4lJoczE/W2xyEWNq
         okeDI7Q12WBW69BOAg6KvMoyJDEDgiqEtakHsJkDSdHBjr0pG5RJ85ENPWHCLMPIMq8p
         vE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pFPOgahYYmTpR0zYbEtapinckxWZTE+QUb6F4N5+RDs=;
        b=Ao1ncskoP4L4EeeVV0mmjpWcoP0eUmPKFLUEBX5drSnc9Ow9NL8yd173dOhIpGDFmi
         G1NT/BUG8+Lo5rncH3kHhhUhc9tkO0fgKXcuNFOK8Ja6pML8voSoVW1qKwmDjthmWlK8
         vqKx2D5+g8UBPSroWZg82txNLfKKDbc4hsRiNQ/BBOwHznUiEO8sQ7sR8DHcbc9ldtqh
         alC1Gocqpem/Ywk4Wa8vuo32G094DEAG0HLA0EwGFELXpd/zaas+r/blK7cEYRPuhsEt
         HYwRf7+n6b2u3xECm8EtIYKN5RCk4Cdveg/FdxIoR7DZuw6pf99LpZx/kr06HISpnYCx
         CpDg==
X-Gm-Message-State: AElRT7EOmF2UYAMsgch27M8yqiMsD+0xc0ZiaVA/bCFoetsCy9pkV2QX
        CE5/t/P4aAuMPfOpDyv0dG1+xWMcHK6C9WhSfmP+U3Em/PqrfeSsQ68vVUJbVYCjEV2Huz2BTNH
        iVTpcDTIMSTHpyAy33g6TMqQl4xdVGmyto66LzeGpZihcfehJFjk62OqSWA==
X-Google-Smtp-Source: AG47ELsqhY+yK8TvOc0sb/yGTglHxSmDfEpKhvNkyKi/ImGesO6YSmxP0GCHf4lrEz3cm3J5N+5QCeGuYrk=
MIME-Version: 1.0
X-Received: by 10.176.36.72 with SMTP id g8mr4005367uan.45.1521135176797; Thu,
 15 Mar 2018 10:32:56 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:36 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-30-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 29/35] remote-curl: create copy of the service name
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make a copy of the service name being requested instead of relying on
the buffer pointed to by the passed in 'const char *' to remain
unchanged.

Currently, all service names are string constants, but a subsequent
patch will introduce service names from external sources.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index dae8a4a48d..4086aa733b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -165,7 +165,7 @@ static int set_option(const char *name, const char *value)
 }
 
 struct discovery {
-	const char *service;
+	char *service;
 	char *buf_alloc;
 	char *buf;
 	size_t len;
@@ -257,6 +257,7 @@ static void free_discovery(struct discovery *d)
 		free(d->shallow.oid);
 		free(d->buf_alloc);
 		free_refs(d->refs);
+		free(d->service);
 		free(d);
 	}
 }
@@ -343,7 +344,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		warning(_("redirecting to %s"), url.buf);
 
 	last= xcalloc(1, sizeof(*last_discovery));
-	last->service = service;
+	last->service = xstrdup(service);
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-- 
2.16.2.804.g6dcf76e118-goog

