Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B891F406
	for <e@80x24.org>; Tue, 19 Dec 2017 18:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdLSSCk (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 13:02:40 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36886 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdLSSCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 13:02:35 -0500
Received: by mail-io0-f196.google.com with SMTP id d16so14506323iob.4
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6/QUsX1uiw2XUi0sEvaTAjcG+F04aKT+N7l6XI5W0s=;
        b=a5yOaeSV/JP8M0VRDBcmF54UxQpLLGbwFOTUSyB0eJbSYOOEkgoYup+zQTBvEo+fRi
         s5j5QrUmaowU1gDBzCGginfCFTnIrftHfCHOzc91EPaX+QEr1uzhiAjd66ZCxTr2kk6q
         yK6Suy1KSTVBclbXWWvM7vBt35q5DjI9zpsfUUMZzBFh0L0kzYJRkErWatzprOYr8pw+
         n0CkSEdvl1UD6XtMdOixTr+QT3dJ21icPor9ph3LSr25Tu6AMP/Vl3kjFZetU5Pknshl
         46zs/7nTaRH+HbX7xmJ1W/0n2jGYE2qxWPsIBrnKihJm0Iw4z+qc4L5YPZQB/iQyl8wJ
         y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O6/QUsX1uiw2XUi0sEvaTAjcG+F04aKT+N7l6XI5W0s=;
        b=C+KiuxQn3vAAuczOIQdDerj+0DL5YfGDfKfuV1K3PzX9hElI/AJ4bD2ZPoOKV2Ufla
         KW/q4K2yKwnAY0W2qkiiafqZ8kv8NuJ+0jvoJZ/RYAEmxyH7neWSaDLZC7azEp+mJVlj
         +sD66OcJDMxw+WCGjw94DIpkgPiDQwDBXojopewj0qozm54sdEOSQ/7k0SDvdSC87LmO
         AVuWmkq4SJx52fji+vfxIEGbZ8YE9jyU8KZRLmZThGesbwgIOSAH0OenhRrauFbJuanj
         azoBlZokZPhmIe/04ntcA2zANjDNcOjpMJMlXGM0eaAWTAoVlxVtktaluaRpbxzJ6JJU
         EadA==
X-Gm-Message-State: AKGB3mKjxDzLqotvlyWslRSKah1S89KXdLgahvW4iTxsUQI1cypP5yTt
        L0HWffqo75OCPZZkT6OdhjZ6uw==
X-Google-Smtp-Source: ACJfBouFiKKSe3zrxfaRmXnIMWLxtyTG9MMtZgOt8OprfVb+tmvkr3xCcFMVxBpTxBuoX8UMzndYeQ==
X-Received: by 10.107.132.75 with SMTP id g72mr1779726iod.46.1513706554021;
        Tue, 19 Dec 2017 10:02:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x85sm7194212ioi.57.2017.12.19.10.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 10:02:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     arurke@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Re: Bug with "git submodule update" + subrepo with differing path/name?
Date:   Tue, 19 Dec 2017 10:02:30 -0800
Message-Id: <20171219180230.254881-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried reproducing the issue (based on the `next` branch, not 2.15,
but I do not recall any changes in the submodule area lately), and
could not come up with a reproduction recipe, but here is what I got so
far, maybe you can take it from here (i.e. either make the test case
more like your environment such that it fails, or rather bisect git
to tell us the offending commit) ?

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 6f083c4d68..d957305c38 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -978,4 +978,20 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+test_expect_success 'git submodule update works with submodules with name/path difference' '
+	test_create_repo super6 &&
+	(
+		cd super6 &&
+		git submodule add ../submodule sub1 &&
+		git submodule add --name testingname ../submodule sub2 &&
+		git commit -m initial &&
+		git -C sub1 checkout HEAD^ &&
+		git -C sub2 checkout HEAD^ &&
+
+		git submodule update >actual &&
+		grep sub1 actual &&
+		grep sub2 actual
+	)
+'
+
 test_done
-- 
2.15.1.620.gb9897f4670-goog

