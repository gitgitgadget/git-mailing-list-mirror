Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B711F731
	for <e@80x24.org>; Tue,  6 Aug 2019 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfHFIuQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 04:50:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfHFIuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 04:50:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so35002403pgc.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mObtOrKEh4uW0iF9wAc+Sz8RwnjSZyH5/KDRYCybCQI=;
        b=r7dVIxN4pCM5tny8SQFM/Mhxp1no4JgtTJvcTTmZsdE2AWUIamunBHQTYKRTH5DmEk
         afsI+uXJeuxyEexKC1m9Ws2eRle48J/IZdAHlZ5556nAOCBxDtMxVKMqR1/boueyzKSU
         Os6sT6lDtdCEfnLkwpboZw3nGleWkKLAPRiIf+BjV/lfy89gFVjrsTA32U35BLZLt1tw
         mfqYJtfUooCDdQnGyoeFTbtkpydNJy3vtec4DNqXBBjeUa67WTJj+olE+kwA/hB+Rv5q
         VbQYf7GHkkiYg9x9I2ZSFQKSgUHgGonYRsVTJxqTKk4OpU6FoUTNF1yKn0Isk95aeS+j
         HetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mObtOrKEh4uW0iF9wAc+Sz8RwnjSZyH5/KDRYCybCQI=;
        b=V7AwWCPGTaXbALXPOcmQcoSdUO5J1K8OcQZsqvZAfjBJvgq6zS2Y4KN4Go6+ef5tYQ
         LHbvFrT0o3sq6fjtRi6XtIT09tGr+Tk639gKHzPFYq67OBzzm3uqFvvoyvAs6jn0Hd/M
         trL8vi6B7NecKXP1lYFoYLzjr0unBtz6Z40dloVmxbyxSW5CSmojM4v9qhnIao8gpGxB
         jXWCR+h9LrDHpCR2aGBmj6hTpeQ00Uh49nLsmG/k44rmSICy5OEj3nNNSq79COdi1q5a
         T6maJtWB/GthEkwdB+LvJovodz+kXayn8vhUsbAuzbQtbvdPXRqLuDZLLoOHkJMcHWrd
         D78w==
X-Gm-Message-State: APjAAAV4zRdlIGd5FxemdrG+5TlYzrlmLKFmZqSsuVP0u+JePkt6zHO/
        bFYfq8mdRTbPyjm+O9AnmeaCpLT58P0=
X-Google-Smtp-Source: APXvYqxR+F8ROx7o08lsCA54vBnnjAHJzDMmxU75RENfNSiD1ei37l6729LXHsBtdcv2P/LYRd8XTw==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr1992590pgf.353.1565081415526;
        Tue, 06 Aug 2019 01:50:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j5sm75743830pgp.59.2019.08.06.01.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 01:50:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [PATCH 0/3] grep: no leaks (WIP) 
Date:   Tue,  6 Aug 2019 01:50:11 -0700
Message-Id: <20190806085014.47776-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an incomplete reroll for cb/pcre2-chartables-leakfix that attempts
to address the root cause of the problem reported[1] by Dscho with PCRE2
and that is that until now PCRE and NED never worked together.

The first patch is likely correct but since I'd been unable to replicate
the issue I can't be completely sure, if a kind soul with access to a
windows developer environment could give it a try we will know for sure
but FWIW it runs fine and doesn't introduce any failures in our tests

The second patch is obviously incomplete but should address the problem
reported; there are still more things to consider as explained there

The third patch is the original leak patch rebased on top.

Carlo Marcelo Arenas Belón (3):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator
  grep: avoid leak of chartables in PCRE2

 Makefile       |  2 +-
 builtin/grep.c |  1 +
 grep.c         | 46 ++++++++++++++++++++++++++++++++++++++++++----
 grep.h         |  2 ++
 4 files changed, 46 insertions(+), 5 deletions(-)

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com/
-- 
2.23.0.rc1
