Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25CF1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfGOMlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:41:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39941 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfGOMlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:41:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so12481332oie.7
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LeGAz0yRAOiGIYngIHwCQse59qL/ypm7DFPdmVYusTg=;
        b=EbghEL9QZ+zrj9XVeY7l4wcWTUGXgHlEdPNjVVWJYvMJat0iv9js7wFmZzNg7iQ6Hs
         FSBKUE7HT6qxcFXAP91KShrbMNoVnPYusqGE10HmdM54vHcGExZdG6hIsmgLBP2H2L8F
         a1CE6ADk/jRXVckLoQ3Nv+JP673FhFK28cAOrvPSlDK8Wu1RLLSRtP6hNBWdZTu9/On4
         +rmfCAZgNXZOOeZaKR3ksbwxAB8HTi5RhsgSasAVhxWRprs+UxEftnSWLOz/VyGYKdnj
         IjFtvq/N1u5Gl4BrZsnuvwpeC5I93R6C/UDWZ//xfWzSK2WO1ClDf9uQ5TtOWPVABey3
         d7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LeGAz0yRAOiGIYngIHwCQse59qL/ypm7DFPdmVYusTg=;
        b=inqCkqwL5BKR+0VJy4bCPQvuHu/IXoQ9V8iH3rFFGA+yW8ZL7tgY5ic+CrztfWlO8g
         7LSIeLOo0tSR62g3IrgMrwT4Am1XLENU0OgnxZN+B0ObSA/UOgCxSlKf04pntmCyc9O4
         v30lggtsuB9qAsxOjiU/69zKaSBA2BhdvtL2pDOMcWEWc9KQpZZA0Iqupc6a47GXA6fr
         TaUSVF3JeDLbQwPPVv4tbhWKLRmwfFKp0xNQGETn0qHyKdXOdcpSszT3pqV7cYy/ipvC
         mHMwqcZM/SlbQXJYe814yZZ+ib/ek/dVXuZ0r398+O9L5E+0EQvvHvBrlVLNMma937hh
         E5zg==
X-Gm-Message-State: APjAAAVY2TLAkYo/dTKcwjUROeLtL5zZqPU+EAtL/ym9JQDMQd6VkP+3
        pCBMmLAJIkB6sJEkkB8Bu/nRd9Mb
X-Google-Smtp-Source: APXvYqxopquCSR6Cy/VdGxUuAwpIV9DS8eQte8sh8U1ErNFNDKyli5m/Bnq5kkhioIbQzai6OlyWug==
X-Received: by 2002:aca:ac48:: with SMTP id v69mr12573681oie.48.1563194475108;
        Mon, 15 Jul 2019 05:41:15 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5c00:b322:c4d8:3df5])
        by smtp.gmail.com with ESMTPSA id q17sm6085893otf.54.2019.07.15.05.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:41:14 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 3/3] tests: defang pager tests by explicitly disabling the log.mailmap warning
Date:   Mon, 15 Jul 2019 07:41:06 -0500
Message-Id: <20190715124106.12642-4-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124106.12642-1-ariadne@dereferenced.org>
References: <20190715124106.12642-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patch, we added a deprecation warning for the current
log.mailmap setting. This warning only appears when git is attached to
a controlling terminal. Some tests however run under an emulated
terminal, so we need to disable the warning for those tests.

Thanks to Junio for suggesting that we do this in the setup function.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 t/t7006-pager.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 00e09a375c..7976fa7bcc 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -7,6 +7,8 @@ test_description='Test automatic use of a pager.'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
+	: squelch advice messages during the transition &&
+	git config --global log.mailmap false &&
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_unconfig core.pager &&
 
-- 
2.17.1

