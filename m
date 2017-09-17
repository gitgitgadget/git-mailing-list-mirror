Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD15D20A27
	for <e@80x24.org>; Sun, 17 Sep 2017 05:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbdIQF2S (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 01:28:18 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45119 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdIQF2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 01:28:17 -0400
Received: by mail-pg0-f49.google.com with SMTP id 188so3465395pgb.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=YZDWXfiQivZgnjbVmrHbmFQeXdX6tKv5OV60Oxpf9jU=;
        b=TaaywtOIbiFtvEZeFFLg4UEFVd3Xkr59ziEC/ahgpFh0+wvTVn4/yDYuNj3RDt4cMn
         uEWcJSzQpswAWlhAmEmbVPBlpJAQlUHJMDnkIrAGN3+L/mQRVCrtJa/obBrouRP2LI7M
         piH1DkyKxSo4yRvNz2VhNEUFRSFqlhaZu2phjlMRAYTlL/4r/cIqzANW0oK7WAo/cLqw
         q3TBVyPYdHNCcdohCLqUXRxKVuUjOrV4SkePsujpjUy3FQGnzIuYKx9sT1JyadHhqhdY
         XhFn+zxvQs/cUKutSNJ4Pw9apxLKd/Sn84f9kk2qAw/yezg9U3/7yYCYdBKIrWl6PGI5
         1gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=YZDWXfiQivZgnjbVmrHbmFQeXdX6tKv5OV60Oxpf9jU=;
        b=fAkVvy5REjX7nZAdDjtH2k4qdCDnbC2xqR1NYidF1pulOA087Jx9tpM+pCi1X5sDDq
         89dnbZxcTZ6xEbCPsdYmYW3hjorFBCbM7t4llStW4+OqE4ydTJyIUmOooEw/SThWgVB9
         l6JiKszOtTtD4qPlSLJRCD5oGLLcI7o6dxRH8pXN2kEWzvbl/84Ja980cNbPFHzPlaXl
         dzhrqo3qCZDgHeONsvsIYwo061ajXLL3s0bCIWiUQUw+GfrthH9iup1lT9rsUGckDcqc
         fOB7l5LblDZAClwzAWTirDMzPWSX88nyfiWLsODziDaU2prtl56DeSrTb3nFwtqbVIQp
         TM9Q==
X-Gm-Message-State: AHPjjUiJXAFut5wFvORPnOh48Gm0/knYc9ZFlh6zm/BlsgRaW9fSheLG
        tPvWG9pfegB9HvajCU4=
X-Google-Smtp-Source: ADKCNb73xR5n5ifIYM7e/R5SybCUiliV8Eph4RxL9ISbTVI0XODyt+buaLPhaEOHPV01aQqM+F5yXg==
X-Received: by 10.98.144.142 with SMTP id q14mr24112729pfk.303.1505626097205;
        Sat, 16 Sep 2017 22:28:17 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id 195sm8896208pgg.42.2017.09.16.22.28.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 22:28:16 -0700 (PDT)
Message-ID: <1505626069.9625.6.camel@gmail.com>
Subject: Behaviour of 'git stash show' when a stash has untracked files
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 17 Sep 2017 10:57:49 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some time ago, I stashed a few changes along with untracked files. I
almost forgot it until recently. Then I wanted to see what I change I
had in the stash. So I did a 'git stash show <num>'. It worked fine but
didn't say anything about the untracked files in that stash. That made
me wonder where the untracked files I added went. I then applied the
stash to see that they were still there but weren't listed in show.

I understand that they aren't listed because 'git stash show' is
typically a "diff between the stashed state and its original parent" as
the documentation says but shouldn't there be at least a message that
the stash contains untracked files? Those untracked files are "part of
the stash" and I see no way to get information about their presence
currently.

So, should this behaviour be changed?

-- 
Kaartic
