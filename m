Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1762023D
	for <e@80x24.org>; Wed,  1 Mar 2017 22:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdCAWOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:14:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36001 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdCAWOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:14:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so3562649wme.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=giDK0U1LDEbgeSLlLpwf2+C4POXkifJYfaZCLac9Ig4=;
        b=Zo17Qr+uHm+jHbh/KHDE4Cc2Wueu5Jco2FmddeCxifmG6W+hySxtjAnFSsEn08AOvx
         UcD9+LpnbTJnHmarY2JNqMUlXCzQHmWFGgbCsKmQRnp0blac6wF8hglaroYNo/mfcejq
         BUqenYP4vmNolr1iWJ6fyX3KXH6ut0XYTalpZdHZOpRzGdR4P8c5xfWDQqmxUeoLB5rO
         DMVB/0K2puF5AK6N6gFYVROA1vaBUsH57xFJsjw2jFtg9+Q5EwUg6+acffDcMSl7CrmN
         306NAr0p3nZV0YgSlBhDaEspGYQKWoXbgR6+JsuyHKrqmII2FAESgaZ7MGwbvQt9/hw5
         IaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=giDK0U1LDEbgeSLlLpwf2+C4POXkifJYfaZCLac9Ig4=;
        b=eLE0hm0HBIHqc6k2ly7Hhz0FFEssPwwUE4KnV3XqPFB0aKc4UmsB8Apr6Vzn2WCxwF
         f0A+fHnzMqGN4Pk0vu7V35wVrO/7iY1fj0IsOihjXaQ3t5TAmIMCbWe2ufAu/lTGtNI+
         GNnwRzkqFhd0zP6bs70uv6GiDvHgvim5VQ9QF10a/I3lxi5xpWMZsrp+K5jhMy5Rc0I9
         hHu0RHH/IMYv2zg5UvnXE0pLbkEkjwQfcvEVokjt9BLtbvZr7GenPNIfW7Y4XsmDicIg
         es9WxyK9k8EmRn41BIHcmAvj9AmgYwdfIiofrYeLI1kYEgANuHEThD6n4o7f3IF3wwDi
         L6kw==
X-Gm-Message-State: AMke39kILM3C05yyX7JvyVKoGNB+LJL2Q7Kq8yc9JddKpULmdcYy4Z/AOZobK+IICeY4jg==
X-Received: by 10.28.111.75 with SMTP id k72mr5168025wmc.39.1488402955710;
        Wed, 01 Mar 2017 13:15:55 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v18sm8136233wrc.41.2017.03.01.13.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 13:15:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] gitweb tests: Skip tests when we don't have Time::HiRes
Date:   Wed,  1 Mar 2017 21:15:40 +0000
Message-Id: <20170301211540.4382-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170301211540.4382-1-avarab@gmail.com>
References: <20170301211540.4382-1-avarab@gmail.com>
In-Reply-To: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
References: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the gitweb tests to skip when we can't load the Time::HiRes
module.

Gitweb needs this module to work. It has been in perl core since v5.8,
which is the oldest version we support. However CentOS (and perhaps
some other distributions) carve it into its own non-core-perl package
that's not installed along with /usr/bin/perl by default. Without this
we'll hard fail the gitweb tests when trying to load the module.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/gitweb-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 59ef15efbd..b7a73874e7 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -114,4 +114,9 @@ perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
 	test_done
 }
 
+perl -mTime::HiRes -e 0  >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, Time::HiRes module not available'
+	test_done
+}
+
 gitweb_init
-- 
2.11.0

