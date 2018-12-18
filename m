Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D011F405
	for <e@80x24.org>; Tue, 18 Dec 2018 07:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLRHZp (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 02:25:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40180 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRHZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 02:25:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so13262727lji.7
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWj9ffpsgwOp4arjCm+MOgzu3ONFicZUHCof+LZoSB8=;
        b=MdeRez2DNKHmLNXUpUQhgyVspILNhIg3eXgYcOzwPkb5Z7ipatqOHScN/SRo+Xs6zA
         7nY8dNvwYRdouZLSUMoxTFQawHG62xsAsDo6w0pgYWBajTDeDZ0w+n+yR0+qvNEbLEoj
         OafYC3g5oM9J0SwiaVnxHnDgTZMjuS4QTZhBga3OthIK3Qfzvf1ks/TF7wx7t9+s8Fyp
         BcAgVTW+DcUtMOwhg1OG8ta/G8T4J2pvr79cejj20VGPARIhClil7EJwkUuVaF/tbOua
         quTTWHOCwLBn6lVt+zu99UdRNe5jROhFdNczznk23kmxGk2cUf+yZaxmfd+8veEn6a69
         2C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWj9ffpsgwOp4arjCm+MOgzu3ONFicZUHCof+LZoSB8=;
        b=WNgj8I4fK0yDlxl1yK7KIYGcNcijIDtKu5KDqQiBWi+gReGqZOcXKc/SEKte/G06bj
         V/Tf80BlJk3+tdqgqzGA1TKrT9+u4aTYl1Bm42Yfgk0lsKShgM71ymUIj6gbCB+FW0FQ
         41UTjptP3Y6MKokh0S2z/nBh8Hy7dK7ss6iYG1kY/t1WkGibXlMl0Whu22NqWyyDuELJ
         w0PFc/0EHsKwMdQ5pK39FlHlibpv4J/X6veIUDDpecqWT0WkUeVznrOiS6dnEI4Wn6rD
         ey5RDvdM7wp7pQy5jM2gjMWhd2dmAl5xgi9E4VAyWJV/k/SAIDMyBxlnHjzsWQVZXOy9
         MC6g==
X-Gm-Message-State: AA+aEWZNEvPXPiJjWTovW9yjXqJvXRLSGvKcuCHkTAZnWR4Wyqye7QZv
        6/VFJGaH82JwXMRMwox4iKQwJlG6
X-Google-Smtp-Source: AFSGD/Wqf46qNkWKXtcV8h2mcIuNoDH4epcSoLNtOoU08cKJvCt6E3TEuopne3plTDQwjReJEpYOzg==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr8990330ljb.153.1545117942895;
        Mon, 17 Dec 2018 23:25:42 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f11sm3142441lfi.12.2018.12.17.23.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:25:41 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/3] setup: add `clear_repository_format()`
Date:   Tue, 18 Dec 2018 08:25:25 +0100
Message-Id: <20181218072528.3870492-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 3 adds `clear_repository_format()` to plug a few memory leaks
related to `struct repository_format`. In preparation for that, patch 2
tightens up some code which uses a possibly-undefined value from the
struct. Patch 1 drops a return value that no-one has ever used.

Cc-ing Peff, who introduced `struct repository_format`, and brian, who
introduced its `hash_algo` field (see patch 2).

Martin Ågren (3):
  setup: drop return value from `read_repository_format()`
  setup: do not use invalid `repository_format`
  setup: add `clear_repository_format()`

 cache.h      | 13 +++++++++----
 repository.c |  1 +
 setup.c      | 19 ++++++++++++++++---
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.20.1

