Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6871F462
	for <e@80x24.org>; Thu, 20 Jun 2019 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfFTIat (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 04:30:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTIat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 04:30:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so2205785wmm.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKd/YqPeN7ATAHdUkM2sF7BJyhpPp9WGjzAIvMJXDi4=;
        b=FopKdAQkm33nj+xFGdQMPGb7jNfUFioeDxmzw7U3EwkfcPGOJyaN3AlGhJlaMidslD
         cKrvm1weRRkAzSLfbS2xmUOQThRj7auHUVV0LPjjt/qUzB+SIV+ItWPLRvV3saaGxYOy
         8d+safMCQ8zZkxgjxsmTLn1i7XDCWL3O8gFM8hZcKhYe5sS/LQ4+GITUG256kircHqMW
         YO4jVJb6bOmHDhHusE8Poj6YeLQQoQHk7YXcxeEhzCbCqMC6jKw9CD+2ahUsIOy/kgzp
         CbeOUrAFr2xLA2w8bwiDO/B9ThvBdjXwaMQVKQDNOBBryNb04koKD4wel52mmzONSBiN
         Uw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKd/YqPeN7ATAHdUkM2sF7BJyhpPp9WGjzAIvMJXDi4=;
        b=IYDVhmuAID1Kj0jL/PG3W/dAsJlmyzvDsguLA7DMt3nHHCpwwNrF4U2HvMp5yT9wm4
         oMFANHRD47C/rxgFo8u21tjfTcL1ONcb3brh0lFWTZguY7YTnb7koLHq75WH/A6VhIJJ
         Q65mewKh4WnVgugLBMr+V2Ibw2OZGbHYkC5jwdPXeYR18xbM1rKcpWUyOb06eZu3jdFg
         uDigyzurlZGkj9cJnaps73+oLCZ/+0JlbZvhsQonATM4q0tOxqK4SgDo8368L60ItnLl
         jn680to8rXudT0sLhMzrm774jC676S7OJm/WlBV5/NFmOvpyKK2uR9Bk8VNtelFJOV8r
         wsUw==
X-Gm-Message-State: APjAAAWSTyTs03+CmHkfyrHkw/k/owTfupZIiGE65VF5qrnFCG5Dreoe
        aFvpRa+e90gZB9ABUH8rGM7ALrfqZj8=
X-Google-Smtp-Source: APXvYqwwIXQXu6gb0yWpDUteKUqTH8YRKZnpilJKXikVTqk7GprBG8IqIfqSJMKfFWVseXQfMqPWNA==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr1747961wma.151.1561019446689;
        Thu, 20 Jun 2019 01:30:46 -0700 (PDT)
Received: from localhost.localdomain (73.38.126.78.rev.sfr.net. [78.126.38.73])
        by smtp.gmail.com with ESMTPSA id f204sm5578039wme.18.2019.06.20.01.30.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:30:46 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/2] Add OBJECT_INFO_NO_FETCH_IF_MISSING flag
Date:   Thu, 20 Jun 2019 10:30:24 +0200
Message-Id: <20190620083026.14524-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a review[1] of my "many promisor remotes" patch series[2] and in
the following thread, it was suggested that a flag should be passed to
tell oid_object_info_extended() that it should not fetch objects from
promisor remotes if they are missing, instead of using the ugly
fetch_if_missing global.

It looks like the OBJECT_INFO_FOR_PREFETCH flag already exists but
unfortunately conflates 2 separate things.

This patch series introduces OBJECT_INFO_NO_FETCH_IF_MISSING to
disambiguate the different meanings and then uses it instead of
OBJECT_INFO_FOR_PREFETCH where it makes sense.

1: https://public-inbox.org/git/b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com/
2: https://public-inbox.org/git/20190409161116.30256-1-chriscool@tuxfamily.org/

Christian Couder (2):
  object-store: introduce OBJECT_INFO_NO_FETCH_IF_MISSING
  sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING

 object-store.h | 9 +++++++--
 sha1-file.c    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.22.0

