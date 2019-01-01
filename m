Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4291F770
	for <e@80x24.org>; Tue,  1 Jan 2019 14:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfAAOFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 09:05:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39241 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAOFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 09:05:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so14120307pfc.6
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpy2usj6+F3KsXXzL4b7MussvYAxOCG6S2taAyefrks=;
        b=Wz8HrEGoqDJozOfGAx3tbjj8LqIrrm0d2Bbs3VtESHzyzaHwxmjP9TSaPeIzCWDR61
         L46BjfRAYq9aG/SU6JOlTtDmwCHS3qsrPzjy9mWvzHJTxyNKUdfvthTN9FDFmNE7xl+x
         XsksJn6/Mp5M+AU4bZqhk5syycVAu5LxhY7wUXxMqKhikxLGyYKYWzmYMlE/flRXZhzn
         sbjm/ILMlZKXidGsjAYGarMzT2IaosG2SVOY5qikzcF65xqwBr3Xoe2sMmwlSJAe5hq/
         OYKMb5tXTKrnyNEbr7N5cEGRn2kRw3zRR06X3jdFyNmVw4BYVtaifrRE7CEWIJZkKSXi
         TuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wpy2usj6+F3KsXXzL4b7MussvYAxOCG6S2taAyefrks=;
        b=HsQQy1K5BKMdmwyr1flUc7nfbmnUk851tmlwS0AqyH8zS216K4MgVGBaJY4a3WeZ+C
         8nkKYr5y9G/9q5nq6OSkuSPZuWHAEZz+qJp1t/MuC84Uarg5QiMNdc++iauE0zSruRJm
         J2JXY3SEqvlYcMmLenBx8XyeFr5+wusXMSkhNymNBR3xTqw6zjtJpmNXVO8Q4wBkho1z
         ivgaXTtFAFGbAuCgfnjAUmemQTDyTBb84+nkB4tlCFx/NfYbrlK0tA9RNBxb7yHzYBo5
         y2F6aKHCtxE43X6pAiHn2eCg2NeHG2WvcUmVajGu/sjRmUtliTIwh9f9Wt2AUYrwaRra
         5G3Q==
X-Gm-Message-State: AA+aEWYJxPRbummG22en9W2VHMUmz3oNy9HbeGnNUcKAd/p7Z/A8BfPw
        G6XogKi9eaFba3nJsshk0Ijr5xah
X-Google-Smtp-Source: AFSGD/Xxz0iulRchNTF3OawlFkIQrRpQ6hGjw+Jo0DkKMr9cTkpM/VNdyqSrBMZgCqSnDy3KzObwHA==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr41228733pfg.222.1546351552423;
        Tue, 01 Jan 2019 06:05:52 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id o13sm75551257pfk.57.2019.01.01.06.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 06:05:51 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/2] completion: handle paths with spaces correctly
Date:   Tue,  1 Jan 2019 23:05:07 +0900
Message-Id: <20190101140509.1857-1-yousbe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181230053125.55896-1-yousbe@gmail.com>
References: <20181230053125.55896-1-yousbe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found more issues with completion for git show ref:path, so here I add one
more patch.

Chayoung You (2):
  zsh: complete unquoted paths with spaces correctly
  completion: treat results of git ls-tree as file paths

 contrib/completion/git-completion.bash | 35 +++++++++++---------------
 contrib/completion/git-completion.zsh  |  4 +--
 t/t9902-completion.sh                  | 10 ++++----
 3 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.17.1

