Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFB51F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755127AbeFNMbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:31:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35450 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755064AbeFNMbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:31:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so11740634wme.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBdjXoVXKTFMHXTF/LB74H3/9kjuIC5ETiI09wrUd8c=;
        b=JVb2WLypBVznGIZhRYEIEQ4TmAYeiwMpinmVc13D/CU/8dL7EhWwSaofoP/zpHc5gV
         PRbgovYd3AjMOprqf6rxedSNW44867EUax5iYL5O7dl1UT1jOQeGCXhbyxLhpZI/MJGk
         dhu7WRDxdh8WK9pZQlGwhO9U1jcc9vD2agNiqEBGDs/LAXyW6Z0IGh4yCulHuymWz+2l
         2V7m26Gvqn0DqoV6OD2D4exfuL9byEAD/+tVselgdAieyU/w6wygDdqtH6McfaBRZGsj
         SXecB32sGWmaO73JxlexHDFhhK6CZn7bzWEyipZh2eZiOsUEKLQzYyP+7L+PPj4+u2QM
         UL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBdjXoVXKTFMHXTF/LB74H3/9kjuIC5ETiI09wrUd8c=;
        b=dmsLHZ8BlgxMyB55pmYNqAdqWK2Q+AZ9IXgXnJsk7jp8A2S82GLpmrh+b0KU2Fs+2f
         Tmu8MZ+tBPGsfnrfkbvp6ZKblestFAQ+1zBsSqJ6WA1uU0FZkvkhGWqJ19fJB55f7lTw
         OTcBABNKJ+XINbMTFMBKCeZdxZVK6YosiF18q643/IzHyaYHJW8rB4/ezJKd5MjlViDU
         cKk63e7DjdNJOQwCTTTDitza6jyGeNqf6LqSboCrtAqOOUqEWre01bAKeDORsRYg5O6L
         L8yOtUHmsrEopcDy4sh+gkBLhVTXTB6M0mhYUj35WylSNC6z6Fb1eXiWS+wNTNmgOzjX
         CTAw==
X-Gm-Message-State: APt69E2ADEspcl4bZ56ru9KsNWybDZ48gOD96Oh74KPuv9eRglTpSPHB
        yncoRL3/wiNruXb4BrvqazadRw==
X-Google-Smtp-Source: ADUXVKIqbBUGc6pP8p82e4NkLJP6PvVre95y9yvAKFl6U3D3cfOap/sqdy3UUK8YOrOPzBXBvsE0Ng==
X-Received: by 2002:a1c:878f:: with SMTP id j137-v6mr1830158wmd.97.1528979480853;
        Thu, 14 Jun 2018 05:31:20 -0700 (PDT)
Received: from localhost.localdomain (x4db06284.dyn.telefonica.de. [77.176.98.132])
        by smtp.gmail.com with ESMTPSA id w67-v6sm6281497wmw.0.2018.06.14.05.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 05:31:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] t5541: avoid empty line when truncating access log
Date:   Thu, 14 Jun 2018 14:31:04 +0200
Message-Id: <20180614123107.11608-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second test of 't5541-http-push-smart.sh', 'no empty path
components' truncates Apache's access log by running

  echo >.../access.log

which doesn't leave an empty file behind, like a proper truncation
would, but a file with a lone newline in it.  Consequently, a later
test checking the log's contents must consider this improper
truncation and include an empty line in the expected content.

There is no need for that newline at all, so drop the 'echo' from the
truncation and adjust the expected content accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

 t/t5541-http-push-smart.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 21340e89c9..c961db814d 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -54,7 +54,7 @@ test_expect_success 'no empty path components' '
 	# service" test which reads the log too.
 	#
 	# We do this before the actual comparison to ensure the log is cleared.
-	echo > "$HTTPD_ROOT_PATH"/access.log &&
+	>"$HTTPD_ROOT_PATH"/access.log &&
 
 	test_cmp exp act
 '
@@ -124,7 +124,6 @@ test_expect_success 'rejected update prints status' '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
 cat >exp <<EOF
-
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-- 
2.18.0.rc0.207.ga6211da864

