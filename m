Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F9A1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfE2JLe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:11:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46174 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JLe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:11:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so979299pgr.13
        for <git@vger.kernel.org>; Wed, 29 May 2019 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuqttM0T8MfV2wTbbPFhnQTuyohnpencg4SHXzoWl5o=;
        b=L33o1LOpquT4QGhx2bdgJevFsDdfjwFfeux3ao+YUOUpXeHk4x2U8mTi/R4dY1XCAl
         QhxOK2r79pWW8CgYb1WgEt0iQ4NbqaK9fBYmHxxn8NiJ8+sxXaX9GCzj+eb5laddWk/Z
         RxeIvWU7E382AtQACaF+6uxaLs4jqFe9uO7NA9P1W7uiVy+vx0IKlaiOV6k9kPgKO9XM
         /VyyinpRxybq9bvGce/qObIlozzzfnJCjD3vCObOn0Nyrt8pBScgrtRnA0gkJZFHoLe9
         YhEy9MlPuMT0U5UB5H4ncdBS6N7AZ/MQRscrMtqhq/rfYnSmLidKrJ4Uf+NLajFI3hNQ
         P1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuqttM0T8MfV2wTbbPFhnQTuyohnpencg4SHXzoWl5o=;
        b=CqqwCgA3JNSVgKrlG10/buTE2hDRx1lhaSH8UZ+2EDfS9qrZg2/Y7PWsSfyThIRcIs
         j/mWeQEWgxz1OdSDwMKhJRl1265/0mSUNVVtgPNYwrblimAGRgL4wMrWL5FiAc9SA9WK
         1oeVj/oym8Y4/YzKCpk+2Vzb1fF+GuyEbOp1QB+DbZvvg2odKyJCtexUxmn3hNfwZ5+A
         7CVKErUoANkqt2XgYVd1bMvuU5SSmIHlWJCq+NdGGviEVYTK25yOJYXg1npC/UTtWPt1
         QG30pZ4e96h+LK4T7D9k5s5qavlI4DFb/epgzKK9A8xeI3k41idVn/mMY203DSbm97va
         S0WQ==
X-Gm-Message-State: APjAAAU3NdnKDD1dUbC7582Nx7dF7+1ieF/EXYIt06fMnkU0e+FW6r3Q
        e8880Me8V/d4haJ6nlHVJu8=
X-Google-Smtp-Source: APXvYqz1hA7GsDW4NEGo1n5RfBbel/CVelIvHV+lRikfBywjoDSKPhNcN6h9sYN+bLXwOc4EUv6D/g==
X-Received: by 2002:a63:a08:: with SMTP id 8mr136805144pgk.46.1559121093738;
        Wed, 29 May 2019 02:11:33 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id t15sm6099494pjb.6.2019.05.29.02.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:11:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 29 May 2019 16:11:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com, tmz@pobox.com
Subject: [PATCH v2 1/3] diff-parseopt: correct variable types that are used by parseopt
Date:   Wed, 29 May 2019 16:11:14 +0700
Message-Id: <20190529091116.21898-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190529091116.21898-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190529091116.21898-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most number-related OPT_ macros store the value in an 'int'
variable. Many of the variables in 'struct diff_options' have a
different type, but during the conversion to using parse_options() I
failed to notice and correct.

The problem was reported on s360x which is a big-endian
architechture. The variable to store '-w' option in this case is
xdl_opts, 'long' type, 8 bytes. But since parse_options() assumes
'int' (4 bytes), it will store bits in the wrong part of xdl_opts. The
problem was found on little-endian platforms because parse_options()
will accidentally store at the right part of xdl_opts.

There aren't much to say about the type change (except that 'int' for
xdl_opts should still be big enough, since Windows' long is the same
size as 'int' and nobody has complained so far). Some safety checks may
be implemented in the future to prevent class of bugs.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index b20cbcc091..d5e44baa96 100644
--- a/diff.h
+++ b/diff.h
@@ -169,7 +169,7 @@ struct diff_options {
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
-	long xdl_opts;
+	int xdl_opts;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
-- 
2.22.0.rc0.322.g2b0371e29a

