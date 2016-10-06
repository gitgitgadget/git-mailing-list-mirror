Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D59420986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966650AbcJFJMO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:12:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33550 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966129AbcJFJMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:12:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id p138so2487343wmb.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+QQAhvKPn2ubCXDTh+NU7IRnys8o6UK0GsEx1etx+c=;
        b=dDI5UwyyA0H2EEBnaW3OeBBkwXxF/AcS0ZthyD9BS6rk6gE+ToUfJYJNG6S5+mwnEe
         4PUX7/cnofmWq1YHodzoQ/8LdVVTbM4n+yZdnD0GYcevnnJi70W9jP5Mffo8WEcSizkc
         Kp+pnGFUJ+VDG5QU7lVM3yDWbkw6Fu9XQ0B8VpPKMTDoylvgr6nDKj+b2byQdMro0oN3
         NwknKkAIvaLrmupds0uFuDMoe6PndTPTnpuuQUZ4vV4MBx2CQuWXGhAoD4m93Qhihe7s
         Jc1OVP4PLlr8bHVDgWH5jFvLlRKWSm5EjNQoJQtxnXlHZa8L7/CwOpKOIqBQmL+fiu/3
         UXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+QQAhvKPn2ubCXDTh+NU7IRnys8o6UK0GsEx1etx+c=;
        b=bHoz/Hpi9xJbS1leIOw2OY8yN1CzWO1hErFvne4nZYHwseFq52kccD4+QEPoqWpukd
         x9iPBXhSQ2Nw87F5d2IK54+Yh51mdJgKCjyElmnkGoQ7BJpqGmAmInpvREdT6zMuS17f
         Eu4+7xevheBknmOX/bOHPfpOGxuLMckwMwKUeakOL8e1mHAiZZ7eNvVchonUhbBvT+eb
         qr2yH4imGqFji7BN3el2k0hrYwT9sHdPC2UublxwhgqPBWSmiIvUVqru4Z3nZNmuxleq
         eaeIN4KYYU+54V+uctRwsWf7fJQORh0uPHXAXJn8LOD3UYYXjrFGt+fSwNamcD5hj9g2
         8c7g==
X-Gm-Message-State: AA6/9Rly135y9DX9PYPWTynhSqVhKV8tUcuLsX2UklRpIN7BgFZ2TuHPYstTbAm0bNutGA==
X-Received: by 10.28.30.149 with SMTP id e143mr12304318wme.109.1475745130868;
        Thu, 06 Oct 2016 02:12:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 137sm34169946wmi.16.2016.10.06.02.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:11:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] gitweb: Be smarter about linking to SHA1s in log messages
Date:   Thu,  6 Oct 2016 09:11:32 +0000
Message-Id: <20161006091135.29590-1-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of patches I sent on September 21st starting at
<20160921114428.28664-1-avarab@gmail.com>. Jakub Narębski had a lot of
feedback for that series (thanks!). Which as far as I can tell I've
incorporated entirely in this re-roll.

Ævar Arnfjörð Bjarmason (3):
  gitweb: Fix a typo in a comment
  gitweb: Link to 7-char+ SHA1s, not only 8-char+
  gitweb: Link to "git describe"'d commits in log messages

 gitweb/gitweb.perl | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.9.3

