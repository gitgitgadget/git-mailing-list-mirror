Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BD31F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeGaCJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:21 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:42556 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:21 -0400
Received: by mail-vk0-f74.google.com with SMTP id w73-v6so6096740vkd.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=M99yW43bM1bjZQl1vU/zp8y9iaz17G7lKaODeb7IFtY=;
        b=IfYXza85wOnSIQpzA1DU80FHxatH09wFTqy3kycTIjS75Lca2VT7hStS5G0kJpm4NU
         dwKdBqBqc2PkN+ExS+ItMj0gAtsXtC+TY3J8+JqfxZInbmGp309TDzZfCx2fEKgX+FX/
         NsgAxhPz/cIfyhlEn3/Vv4PgbTHmaIeIQEtiY+klWvSzwfNbULCxJwVltwiVRkHxLx8g
         ItckcCvjKkX8p4bq91f71R7aEri22JntCs//nF1HINFK3WtJajjaMrKJwm+s8E/Lgdmb
         Dc2fr+Hh5qqx0k3H9Y23gXsjZfsoMsSlCj3MXY2WJtOoLm6gwttLh31rvecn/6K6m0vB
         Tkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=M99yW43bM1bjZQl1vU/zp8y9iaz17G7lKaODeb7IFtY=;
        b=oAwC5bDshFyltjCpAAwxAjKKzDI6RcDQrbiNS1mzU+EPlMoFcr1z6TT1223sRqBl/3
         +iv+A56B2kuoL1UWBNvthjG289VXyQmXpw1r2Qt1WB0rutYXE6ZXMMWWwLgG1F07eHSK
         eXIMfH3SVvZDsV3xlxoVfjrJNUcGZH14JW4mMVI8Qlwt8LQl13YJedWv814PrH3KctRx
         kkfRQdY8Ek/JDP8NRlZKnajed3m7ADm1/CqV74KVDS8nDJK25rcbb6ad9RsAyy+dujVu
         wqOEXKkM13mPzqC0v6RJ7qr/EfFFBv/Iit+0AaNzR2o1a0gy608TTtDi+mmiFumx+AQs
         EFZg==
X-Gm-Message-State: AOUpUlFjrZSQq1Zj781YE3KBSw974DLNX4xp2l6XfbM4YLF45PhApxVm
        rnxGn4q3JOnzMSvNVOEbmXIeGJqWm2mC
X-Google-Smtp-Source: AAOMgpcfpewmVcHk7YFr0tG5iYmATLTxmRjn+z7ZA0TxQDx6MiZWo+Xgyo47N16tHA5De5z5AH94M+6ic7mb
MIME-Version: 1.0
X-Received: by 2002:a1f:5f8f:: with SMTP id t137-v6mr9557739vkb.2.1532997109281;
 Mon, 30 Jul 2018 17:31:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:34 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-2-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/8] test_decode_color: understand FAINT and ITALIC
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca09..be8244c47b5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -42,6 +42,8 @@ test_decode_color () {
 		function name(n) {
 			if (n == 0) return "RESET";
 			if (n == 1) return "BOLD";
+			if (n == 2) return "FAINT";
+			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
-- 
2.18.0.132.g195c49a2227

