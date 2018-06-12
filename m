Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4E51F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFLR0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:26:39 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:34341 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeFLR0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:26:38 -0400
Received: by mail-yb0-f201.google.com with SMTP id f13-v6so22057542ybg.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=FGayR2Jz1DXnGzCWUeffOqSLVCxlt5ByArXPwK2mU+o=;
        b=ah5uqCsZ0yNf6j4mZJoRXVQ+wWxvQFXjuSk/G1KMBLQ6+LlxYTcDP3C5oMb9RZReIV
         vAeM74hEmPjN3i/BSUn51eGavnpS89q+E9C6fx3wYHjvha8DaJqBBfDjIXYFU9juP2fH
         +CW5lwt2oRqoI5nbaBYyJyg8+NkhmBmnsX0QDhYqFGTAQsWTNAab+pQha2kHLxkRiCIV
         kOuVyCK155saNgirVtMtp1mCxwPmxb+bmqQ25M0d9IQVn+eNIAYWolnTb6C78sooRjjM
         n8QbpspqLX8A8cvBnNtzlWNUuqGsgLZWbut0JWFdCdOURMQm8jRdoDgLhvyZBNFOf0rX
         zmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=FGayR2Jz1DXnGzCWUeffOqSLVCxlt5ByArXPwK2mU+o=;
        b=h1z+X9+im5egRLSsJCkPi+XSARFiVRfOauGsdPJzZh3tbI3oR4oHDXSmJwuzyZ2ZC9
         QVCO8qQCG7LkRQZ1FoLkbZMdj8LtBZetdj9UJb4sNSPnc2TW/gvvdcogkgn9Oo/KoYv1
         v+BCYqP/RNmR1kiJPxZktnzU+baNQMBYmV3ApdmNP0/nA0qFTULIgD6RUcuLwDndfmXm
         26ywt+qB2CyUEhyKPDAI3kOtpWJfgFw7Y5WUFcSnKUUOENEYjy3qgoHnLUKApwVqIhXO
         IUloGyV+n+LfXHrTYuF+CLtGKL1aTikaJpGlzFJe1QGB7eH5OK4SVKOHJPn5sdUPlBie
         3bUw==
X-Gm-Message-State: APt69E1gm2WGpDWRyr6A9Lt4dG1BX1j7a2LVeLRErde9OPp16Ayd4qKh
        2Br+hQ7TuL4YQV702BRbgGLbGCxv9lxYRqcc4geo7m8vr1ylNvXISg+8WUrFgHbBQw9JP2TrCmV
        pOyeq6aCBQ7kZDw4FgNHZ6FYhPfLpHv1GE3ELeIBYt02baxycSZ/SeHb/KRQoadIi679YUDLQVw
        ==
X-Google-Smtp-Source: ADUXVKIhO5cveYYvDR47WeXUWgeEUDvzEKbqASob22C9mOOhaXaseGeoCMH7mVGJ/IHX0LxBhJsnQ0aXu01z8AMbitg=
MIME-Version: 1.0
X-Received: by 2002:a25:d902:: with SMTP id q2-v6mr415883ybg.2.1528824397815;
 Tue, 12 Jun 2018 10:26:37 -0700 (PDT)
Date:   Tue, 12 Jun 2018 10:26:23 -0700
Message-Id: <20180612172623.165420-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH] builtin/send-pack: populate the default configs
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/send-pack didn't call git_default_config, and because of this
git push --signed didn't respect the username and email in gitconfig in
the HTTP transport.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4923b1058..42fd8d1a3 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -121,7 +121,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 			}
 		}
 	}
-	return 0;
+	return git_default_config(k, v, cb);
 }
 
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
-- 
2.18.0.rc1.242.g61856ae69a-goog

