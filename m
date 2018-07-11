Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D751F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeGKNBI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:01:08 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45923 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKNBI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:01:08 -0400
Received: by mail-ed1-f50.google.com with SMTP id i20-v6so6121716eds.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIpWupVtCD1kMHimMO2LkbTgGWIKBeyB/MXNSSGkwN4=;
        b=VBqZWVZuIXoHAgwg2T5kMbPncjOu6qJEVBtwss+8yJXs1v02ER+8AkMU0SAVEaPC4B
         3NIBmxZnQ803lpOCIr6Ayc6V2s03DAHxp6Kz0xVCAEx0BqdvRj+5KQxPSdHFq29eBftv
         PIEvWl+bIqXz8gAyFa3XXQ8WrdwtypguljpRioGGQpLuhTWPKbqu+8b+rVZM4sZEYUSI
         6RS1iC+MyV5Inj4TJEERKB6NdKnojkXCIP05wuYsEWS4C8FDl3H4oVv23v36428O6t82
         WeUIR6l1fT6w5En3I37lN6OBKdNyZxEiR3GXYflGObxMeasLdfB4TmF2NyNYOrJcwFFe
         ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIpWupVtCD1kMHimMO2LkbTgGWIKBeyB/MXNSSGkwN4=;
        b=YObs3Q+JtqyFZaSWvo/ty2Wvc5jv4pZiC0cQjt8//9FrQx/fW+WvgOLe+p6DZNcB0c
         xXTQ5U6vqlJDU2WTSpF9rCcWLus1Q17gQIvcj7hq7ICHKmpDw48k/cMoSMUAJWhcZIHD
         XSDAMRPgpGRBwkGZriwOfgLAsfg25ErxYl7zwGSIpy5xgWvf09jRfm+TWBShLFflURx9
         TzTAoUK5pYkQJUe5QsAzz04cQD5sg0gCPulyHXNjoFmAqOiHBtFI95pWxbb1i43ZriIv
         uE8U41xOKWrTIfWaNDPhWgiHcB/TyYp0DJL90bxp4mG0qrVjkneG8Q5PiQ6t4eOnJYQu
         K2GA==
X-Gm-Message-State: APt69E1zARf8Uh2alk1pnsYb0dLtNxWTTjoxxUOz2z1lboprVfzAHeFt
        QEMmCADbExlnftJSk1dBn+M=
X-Google-Smtp-Source: AAOMgpfway/wHi3ThE2ij1WY9u9VNNlYWtwt4d5BCjFZWGG3ahmTNltVTJB9xzFUkIpej55t1sYNaw==
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr2466112edc.296.1531313814381;
        Wed, 11 Jul 2018 05:56:54 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id h1-v6sm768050edr.86.2018.07.11.05.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 05:56:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/3] Fix occasional test failures in http tests
Date:   Wed, 11 Jul 2018 14:56:44 +0200
Message-Id: <20180711125647.16512-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't5561-http-backend.sh' is prone to occasional failures; luckily it's
not 'git-http-backend's fault, but the test script is a bit racy.  I
won't go into the details here, patch 3/3's commit message discusses
it at length.

v1 is here; it haven't been picked up by Junio:

  https://public-inbox.org/git/20180614123107.11608-1-szeder.dev@gmail.com/T/#u

The first two patches are identical to those in v1, and the last patch
implements a different and simpler fix than in v1, following Peff's
suggestion.  The third patch was dropped, because it's not necessary for
this simpler fix.


SZEDER Gábor (3):
  t5541: avoid empty line when truncating access log
  t/lib-httpd: add the strip_access_log() helper function
  t/lib-httpd: avoid occasional failures when checking access.log

 t/lib-httpd.sh              | 21 +++++++++++++++++++++
 t/t5541-http-push-smart.sh  | 24 +++++-------------------
 t/t5551-http-fetch-smart.sh |  8 +-------
 t/t5561-http-backend.sh     |  8 +-------
 4 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.18.0.273.g57f1ecce9c

