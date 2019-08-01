Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C028D1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfHAPxZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:53:25 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39627 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfHAPxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:25 -0400
Received: by mail-wr1-f41.google.com with SMTP id x4so20984151wrt.6
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVm1+jJFoGi87pJgpaoxTbBNmc9/KG4q0coYZj2PHBg=;
        b=s1qHUBzdgyY2hr+wFf8HjalMMZ5PUbgIKvz/PSRkT1+3uR8Nl3KFz8TYAxRikTL8lF
         JcrzZlfYSk9qAGYzY1hfeC7Uc6Rp9tBdPa3nwT8TcuKyrZtjT+C7/YCELgIpAnEIdZOI
         UV1773dDNvrqrpxy4VazJYkkQ2gnmAg3IQ3hMpISs91tLOX+wfDDgl9Pknp//eu9WH+c
         2zgvU2BQFwkFuceQBGZwe1YWC980A6WW9MtdqWrcwiZf2omYmBcBH5MdJuXKFPuqYbP/
         nLTF3sc1MnqrYrLpteQXIZLYYjj8udzv4eeU8k66vTwd4JgXEr9uwppinSXgNWySTvNY
         gNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVm1+jJFoGi87pJgpaoxTbBNmc9/KG4q0coYZj2PHBg=;
        b=dD/LvudEhd8OHDuulV+M25CzexE/5KkPw7kNIItP7yfYdXUJB92lbTUJaaZk/qZUkE
         I1VDpx62UUZV7lUaG0XDSy3uhinDPmqEG5pe9hMmioDIxsdAI2HP+DjtSO1RhDi5UyGC
         by/xDtzmhTBfpHTavD1jHK49RXapqO917ax2j+LC42cBe2PqhPYVLiHyE6E1Czr1vnAt
         5LlpnsMi/1DsXkr2CPPZOgk7T+DkLlyAFlDcYw3x2srRsvuweu4v0mPusIpDXdTmDRRu
         gHldJU1uHYoqJJIGyBKOtA1K7UEvWE4Gd42Oi9P9P9luPZqBnilYh9lrMKzDn92rlxdo
         WqPg==
X-Gm-Message-State: APjAAAW0hURqKYNkhWAvegZQmXQmvBGJ/0Yi+0uXzqY9g3tWWGiIVgiE
        LNUxqpDfat4+JDRgQmITqPI=
X-Google-Smtp-Source: APXvYqyXzMikgbJphz6F9LrsoMOllbA3CfJ0mJ/bg7vVb+D1/A2fBP5WkGbIGc5jXdMHFZE0h/BHRQ==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr53972107wrl.127.1564674803244;
        Thu, 01 Aug 2019 08:53:23 -0700 (PDT)
Received: from localhost.localdomain (x4dbd0ed1.dyn.telefonica.de. [77.189.14.209])
        by smtp.gmail.com with ESMTPSA id g17sm55434473wrm.7.2019.08.01.08.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 08:53:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] tests: run non-httpd-specific tests before sourcing 'lib-httpd.sh'
Date:   Thu,  1 Aug 2019 17:53:06 +0200
Message-Id: <20190801155309.15276-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.926.g602b9a0287
In-Reply-To: <20190730214000.GT20404@szeder.dev>
References: <20190730214000.GT20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hrm...  It looks like there is nothing httpd-specific in this test
> case, at all, so we could run it even if a webserver is not available.
> Moving this test case earlier in the script seems to confirm it, as it
> still succeeds.

It turns out 't5510' is not the only test script that contains
non-httpd-specific tests after sourcing 'lib-httpd.sh', but 't5703'
did so as well.

The first patch is a follow-up to 'sg/t5510-test-i18ngrep-fix'.
The second patch fixes a similar issue from the v2.19 era.
The last one only adds comments to all the other test scripts sourcing
'lib-httpd.sh' to warn against adding non-httpd-specific tests at the
end, in the hope that it won't happen again.

SZEDER Gábor (3):
  t5510-fetch: run non-httpd-specific test before sourcing
    'lib-httpd.sh'
  t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.sh'
  tests: warn against appending non-httpd-specific tests at the end

 t/t0410-partial-clone.sh           |   3 +
 t/t5500-fetch-pack.sh              |   3 +
 t/t5510-fetch.sh                   |  47 +++----
 t/t5537-fetch-shallow.sh           |   3 +
 t/t5545-push-options.sh            |   3 +
 t/t5601-clone.sh                   |   3 +
 t/t5616-partial-clone.sh           |   3 +
 t/t5700-protocol-v1.sh             |   3 +
 t/t5702-protocol-v2.sh             |   3 +
 t/t5703-upload-pack-ref-in-want.sh | 204 +++++++++++++++--------------
 10 files changed, 153 insertions(+), 122 deletions(-)

-- 
2.22.0.926.g602b9a0287

