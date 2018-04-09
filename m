Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC861F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbeDIUmU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55936 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeDIUmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:17 -0400
Received: by mail-it0-f66.google.com with SMTP id 142-v6so12892812itl.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCCUEmOto+NjRg7gGzGA0g8BysG5rRdQwZU0/cAITY0=;
        b=oNtitu0co3Ee4A6PY10HyE4VWmwC7ssQVtivoxclGR5BM+D2j/Dx26B18MITjgCgqW
         LjpRbmxvyI1SOYBWcUtLWsHqQFqsKo0kheCef0aePlRxtIVNyEt+f0SUWNPRxkaW/8P+
         5TyOflK8CJLsbxyDdCGR0e33JIkf3aSJ5wZ+TM0zCZVjqVjyjr+fQuGV3tTWWTI7QIlm
         ovcKUcSdRQOtiWyG5yYc2Rw96h4MNWihOunuWujzOmYGCEBoHaoTEo5TPz4Pherj+jGB
         i0aSTqvoPTVts+8/s1ATQ7Dn+mv5Eq2JUtiQnFyyu6/IazagQKqvlDR5eAo4sRZ0GNxl
         moFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCCUEmOto+NjRg7gGzGA0g8BysG5rRdQwZU0/cAITY0=;
        b=lfdnmGwB6GsarrjCSFtsIBh6MVp6XNYWD+xL+cP2urWLptJAzF19SYNfnKVm0FrfEU
         zL0SeC3k+Sc1xeUX0Dkk+LS19wznUUp26xpG0QSH7d3yhRRtZl+ke8LOcAxbiC2t2nlx
         igYjLbmARpZgou9bm+XMgInycGwIun9NduJeAPhv+zgfH/2w1KbhN7uHwtckcOnVEXz8
         Su4mIj3G+aIeuX7/3TKsNQbNN72jIkYn58owblomctLhhCQ78dGxFc2lvZuOUd+1S5J/
         6vu5D5dpPmalSPyj2BMgN4l9H0hfGTRj0mD+ouURQN1n6pggWO2y3TtOlW6P6LLYO6BW
         sQTA==
X-Gm-Message-State: ALQs6tD6N8OHIORButHTvDAG7iPAepTDzYLliZG15lMTOoMVA1WXhOh7
        nVmOiVI4d95vbg0vYqK1FnLLGdni
X-Google-Smtp-Source: AIpwx4+tP+HmehMtgkoUa3o/WyCXtnOF8m+bLSeS9GKMgpnTWeS2YDFYRS+ZXxeHIGrotA3jgp6Q2w==
X-Received: by 2002:a24:dd82:: with SMTP id t124-v6mr1667431itf.2.1523306535999;
        Mon, 09 Apr 2018 13:42:15 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:14 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 3/8] gpg-interface: use size_t for signature buffer size
Date:   Mon,  9 Apr 2018 14:41:24 -0600
Message-Id: <20180409204129.43537-4-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Even though our object sizes (from which these buffers would
come) are typically "unsigned long", this is something we'd
like to eventually fix (since it's only 32-bits even on
64-bit Windows). It makes more sense to use size_t when
taking an in-memory buffer.
---
 gpg-interface.c | 2 +-
 gpg-interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 08de0daa41..ac852ad4b9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -101,7 +101,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-size_t parse_signature(const char *buf, unsigned long size)
+size_t parse_signature(const char *buf, size_t size)
 {
 	char *eol;
 	size_t len = 0;
diff --git a/gpg-interface.h b/gpg-interface.h
index 2c40a9175f..a5e6517ae6 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -31,7 +31,7 @@ void signature_check_clear(struct signature_check *sigc);
  * offset where the embedded detached signature begins, or the end of
  * the data when there is no such signature.
  */
-size_t parse_signature(const char *buf, unsigned long size);
+size_t parse_signature(const char *buf, size_t size);
 
 void parse_gpg_output(struct signature_check *);
 
-- 
2.15.1 (Apple Git-101)

