Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB0F2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbdEQC7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:35 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34031 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbdEQC7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:11 -0400
Received: by mail-pg0-f45.google.com with SMTP id u28so85473621pgn.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KRcSE4JLGBxtEvfmA6UUQyYgBD1inKBQ/lNJQxOuuU=;
        b=MDcyUBMiJ7l+3dvcHKgqIVyYtufYbBUxX44+9v80o1LyuiycFJY8J6E6v2dS7LlyVS
         fGwjotLWkFtoAvcpPgVZIajocDcsz+hn3DFOoAtyfQqdrxLIl9586t+CF3HvYXUWqw4q
         4dbPXIT76wsvSYSGvvoK4HnazH6vGL1Jn1ygytCYL8aJyBDoZPG9YWWgJ7vbIDMScQKI
         JWnQ3JP9pSVTmcAeTTjyYAbQm/ky5Dwh9SpsihdlAXFY4YgYt9eYEBzgMTp1xh0DzitJ
         F6HWHJNONkp4Htu2UhZ+GpVNvUyvPeC9RPfSS0MtxVu35wcJpoAG0wplDLgxlIQnRYb+
         flCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KRcSE4JLGBxtEvfmA6UUQyYgBD1inKBQ/lNJQxOuuU=;
        b=ChckbzEAWcz+dXCIzAc6JetsKyc1GALXxCeXz/9ThNEKA7nwD0/9v+jFvne85oAPVi
         rrbhNv/h1qX6w7Opqvh8Vdr3OQSS4IrMqY1knP5/uOglWxa3hfSH1bUqP3LjkHFJrQ/1
         unuwSPI3elsU1MDLQaCQktIBaYuX/xAEpQNd5ukHpZsp9bldhYm83l4BnEHZtfHqk3Rb
         pZPXQA2pZl0y+UqZKNtQgH/gwCIK2B1NfDDGUnSAT3D3AvoWU7kxTWbbUhBNqy5xOU33
         imbc3e0ZYZxlmThUJBb5Rc7SjYLWEnB90uw2HvYH1zxeFuwomXD42iaof3ANNnYnygVz
         it3A==
X-Gm-Message-State: AODbwcBTxY6a3mZPNBztRQUkTJGHDVEPpcrF9vHWR/kCzypLgFSZVdLm
        v8wSXPVCrRy6Qj/8
X-Received: by 10.84.224.66 with SMTP id a2mr1438679plt.191.1494989950034;
        Tue, 16 May 2017 19:59:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id 15sm665168pfj.59.2017.05.16.19.59.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 05/20] diff.c: emit_line_0 can handle no color setting
Date:   Tue, 16 May 2017 19:58:42 -0700
Message-Id: <20170517025857.32320-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we may pass lines that are not colored to the central
function emit_line_0, so we need to emit the color only when it is
non-NULL.

We could have chosen to pass "" instead of NULL, but that would be more
work.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 73e55b0c10..6c1886d495 100644
--- a/diff.c
+++ b/diff.c
@@ -532,11 +532,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		len--;
 
 	if (len || sign) {
-		fputs(set, file);
+		if (set)
+			fputs(set, file);
 		if (sign)
 			fputc(sign, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
-- 
2.13.0.18.g7d86cc8ba0

