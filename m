Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99DC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017A8207DD
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="IIzaQLv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK0UYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:24:17 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35419 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0UYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:24:17 -0500
Received: by mail-pf1-f169.google.com with SMTP id q13so11688386pff.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvwUdwexFgHXvY0W9RAEktn86G+nw24l0yYRZHCCrq4=;
        b=IIzaQLv8wpqdNHvL6XFPsRO0Htas9c1KIICZ4LDHATM5iCwQi3Osc1CRL/hMdl9ULA
         Yf6JeVkk+AFMtEfSwGRCBTDMkOYA/bwrD663/Vh3Ei8JVI/GmrefwW3RmlL3VPVc0bgu
         hZjk+FdAs8HR6krMUfVWx3KOU+41XYiDWgj0va+jx7klzYzFFq7VJipiJNSQ1VUYP4T+
         QixkH7jMRQfhSEOhvqkwH541yJGvmLXSiI54+PIRQMjKBtPmU3mF6kb0UBWSoMf9nt2h
         o+RM+JqgGL6xZfRSnTxSg1LuCvOE+1zd4/7QdJZ0Gchz+MIjHoaBFYQyz/ShpB/QKl8k
         ez4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvwUdwexFgHXvY0W9RAEktn86G+nw24l0yYRZHCCrq4=;
        b=jbIsuh46bEy1pKrWqh3vSBTt5oZLDxjX+VwBqnUDth4u+QzuldRoYo9hJlwnrHrwjn
         iosbMksssLJnZHI4m31RPo5m82mSnkWPnbjgTnoyIPlztqNjGyDuTI7RjySJSTCKTbNI
         IBgPupQPHWoAV7Ok1zLgPM5qy53go8gZKwzgxja8eBm7L7rZEus7X66vW2+E95CYMVPr
         K4S+eXPZDQyDd4oZ+2jK1eSq1BSauuBaMTM38g+nScElmmQxdZDJUO3fx1zQm4MbS5dW
         z+QvTfCglBb7WG3VS+eCDU/503UcunOGOTQyPH1+7SCayVHkMKCkcg6XaHLV5kAQK75K
         WNMw==
X-Gm-Message-State: APjAAAWM/uBRoucV/9UUK+thF120S4LbfTk4lWKZidAUWpAykKGWsHnn
        nG2nSpSOiF31vU02TRyQiskTViynMH+q/g==
X-Google-Smtp-Source: APXvYqzjojugaaGjn1hwwKOD/tf8wIz6888q8hPmzYesCHF27SYYZUXmRO9R+0D/g22qYsJTyGprIA==
X-Received: by 2002:aa7:9f08:: with SMTP id g8mr50212125pfr.59.1574886254828;
        Wed, 27 Nov 2019 12:24:14 -0800 (PST)
Received: from localhost ([182.232.36.174])
        by smtp.gmail.com with ESMTPSA id z30sm6708100pff.131.2019.11.27.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 12:24:14 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] grep: don't return an expression from pcre2_free()
Date:   Wed, 27 Nov 2019 20:24:10 +0000
Message-Id: <20191127202411.4298-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple one-line fix for a bug I ran into when enabling
pedantic builds with DEVELOPER=1 and --with-libpcre.  Previously, the
void function pcre2_free() returned an expression.  This commit changes
that as per section 6.8.6.4 in C99 [1] and C11 [2]:

> A return statement with an expression shall not appear in a function
> whose return type is void.

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
[2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf

Hans Jerry Illikainen (1):
  grep: don't return an expression from pcre2_free()

 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.24.0.156.g00c62833a5
