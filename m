Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F101F403
	for <e@80x24.org>; Wed,  6 Jun 2018 05:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeFFFCZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 01:02:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33038 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeFFFCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 01:02:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so7062126lfy.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 22:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUgHALlb797esrcZJM8QmDfZ3aEBqbkxIm7Hnh5tGNw=;
        b=YCxP7zd/gjy1dY3pNmZTN7Mvu4Ekftyhdd1wyzKgUd1ivQPheeMdsARhbNQ47xM+Mu
         4EOfPWAnSNjbHwObBdVFN8p94D/dmkP6pMEEbmRBEPtnJ/mGBF8Mbrqy/VCIVwBKVx/y
         tp889+KJZseQ3GDvQK2MRu59xUx6BxCXEnWJviVNC+sOiZikVZBurtn126Q814xSswKv
         9nMPpEbOOFtO0J+ejiEoKAmYKW486Xonoepm/M5gbjTFIejk0T842t2qWRdBcIs+pMO1
         TnvHPIeuipwmMk9946NZWwKK0Wn2vYWKq6ZhDZvg6HkyZnqxCvmD5sEwN9090dixmvBc
         5ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUgHALlb797esrcZJM8QmDfZ3aEBqbkxIm7Hnh5tGNw=;
        b=Vn6oAAa/g/M1rcdzh2LlmgWly4NroyKrLt0PjONI+6PFYviPx9RVeAX552lh6HN4eu
         bqxwz0jX9+DhGugDyiOCnU2zErpBx3rUNmV2X0+Gs3OPVLmQNinJKI8nt0yFBSLGhNNf
         2aauGqpXd3+nWe/rCuGTUdFXlZKRvT/97Aw3s3AtCN3QRD7FvvmtD4RWEHWf1Z76mVUl
         WbBC4qWbFkEsinbzTy/+pyNQ9GUdCg/KHPfhrmx1ES5M8PsOFHsK6/X1RXWKGSu1ATzc
         9WNN4TiOfy83UrE/QisRQ8M4AKDI/ZDjBJ10pChwrH3vYcx2UhL2dt6cc31+5g/VynCf
         5VyQ==
X-Gm-Message-State: APt69E04ckgNplFi8XdL2qkPEJzlT7biDsyKQxtcpe0afYJJ/BgTqkbv
        KQugWAe5ngwEyq0GEnic/2s=
X-Google-Smtp-Source: ADUXVKKubrlluCPHMDXpzOR1VXiOuyOhCwtYsSA1lmruOi1GwWlZA7AQ/smJz9hj+VQg9lF4wReSaw==
X-Received: by 2002:a19:7383:: with SMTP id h3-v6mr828298lfk.115.1528261343172;
        Tue, 05 Jun 2018 22:02:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4125798lji.4.2018.06.05.22.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 22:02:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 0/5] Fix "the_index" usage in unpack-trees.c
Date:   Wed,  6 Jun 2018 07:02:02 +0200
Message-Id: <20180606050207.13556-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes an incorrect patch splitting (I should have built one more
time :P) between 3/5 and 4/5. v1's 6/6 is dropped. Brandon suggested a
better way of doing it which may happen later.

Nguyễn Thái Ngọc Duy (5):
  unpack-trees: remove 'extern' on function declaration
  unpack-trees: add a note about path invalidation
  unpack-trees: don't shadow global var the_index
  unpack-tress: convert clear_ce_flags* to avoid the_index
  unpack-trees: avoid the_index in verify_absent()

 unpack-trees.c | 53 ++++++++++++++++++++++++++++++++------------------
 unpack-trees.h |  4 ++--
 2 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

