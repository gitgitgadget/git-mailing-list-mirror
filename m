Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E902098B
	for <e@80x24.org>; Mon, 17 Oct 2016 00:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755626AbcJQAZ6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 20:25:58 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33110 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754769AbcJQAZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 20:25:56 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so8578258pac.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzpA2JzcMj0jEpJXzyosCecer0R/8wO3z1VIXzMeufg=;
        b=mNuEHTEWOoucvl4e5VfLjqr/AiAoFqgtKzLm13t6Hpy32t3ll7UjGbf95zmV4q0ieF
         AV/D8oiApmnUP4SZeKJ/wsd9OtPnCnpysFxRSfEVVxBN6VrYguNTBvO2OHTXWNGy3ajr
         8S5xQV19fD8NhNmWqLaiQJDMzTuU8feCeLRrpzl4NH04NELBR8X8rr2ptG3voDP/6Oyl
         JP8xjl7ZC5RrwrQRqlQJSm40KURbvb5hK9iISM6wKPnDdS4J3GZjXTtSrWHN1rATLzZR
         GxdG9U6tzI5t2U2CHS5C5xN6Yp3SifdqlZd9XVC2F/AuLRxOKJ5CKqDTaT1+JiGllSFp
         80mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzpA2JzcMj0jEpJXzyosCecer0R/8wO3z1VIXzMeufg=;
        b=MU9jXXBUUIF0MPyUqtsPvv9JW8M7VLauU/70DrFQgJqyUeOri8twYOrD9U8sFwo/6q
         EmoUYsiweiXZuUIXgP3JuLOltrOfhdWJOxgZVp4WKOnpFpook5w72DN2VFm+f7mK0wy5
         prtdCSqke7q3DEfttUlxHP8W4u5Utw6D3FjQ1QriMA8X8Q5eEp8G67EOAACYyLDkwSvI
         GrWxleetOio7qkv15lu5CtF4zDeHpmqdTGql9lUDYHW1FTxwPj17bFYEGh97MbuFWEkn
         RmygUEY7GW6SmxsaHxH7oxMe5KKiS3T36OacFV5G+ja6fN0aLB9dKGcv7RuPWaHpClnT
         nNMw==
X-Gm-Message-State: AA6/9RkQK9pudfJ64BzhqaxsWmX0mZg4ETUJijYTo6pLybVBAth+zexQxT64ABXFxUpDeQ==
X-Received: by 10.66.166.103 with SMTP id zf7mr28940908pab.178.1476663956143;
        Sun, 16 Oct 2016 17:25:56 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id 3sm42882343pfo.31.2016.10.16.17.25.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 17:25:55 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     tboegi@web.de, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
Date:   Sun, 16 Oct 2016 17:25:48 -0700
Message-Id: <20161017002550.88782-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Apple removed the OpenSSL header files in macOS and therefore Git does
not build out of the box on macOS anymore. See previous discussion with
Torsten here: http://public-inbox.org/git/565B3036.8000604@web.de/

This mini series makes Git build out of the box on macOS, again, and
disables the HTTPD tests on macOS TravisCI as they don't work anymore
with the new macOS TravisCI default image:
https://blog.travis-ci.com/2016-10-04-osx-73-default-image-live/

Thanks,
Lars


Lars Schneider (2):
  config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS >10.11
  travis-ci: disable GIT_TEST_HTTPD for macOS

 .travis.yml      | 3 ++-
 config.mak.uname | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.10.0

