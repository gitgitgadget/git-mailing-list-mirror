Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302DD1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfHUWUO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:20:14 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:36613 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbfHUWUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:20:13 -0400
Received: by mail-yb1-f202.google.com with SMTP id d33so2736475yba.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=huIeRK2hnkcqpTrBB3HOk6wGMrQod9gweMsPasKdRY0=;
        b=nTHmXRi+wN+ubuQn3carUPIYcAZPBZKCul+DfP/HSrDDx1+7JhzCAVlHm8vWnF8XQd
         c/CFj+F/1oMEE9hHFJXjTzUC5mf2ZO6tVFcGkcodc76EVM+ljP0Gou76OtneJ1h4L7p3
         ABLtix4aH46gkNKJDDXkgaoZM2WQPOn1yWgHnnSHaEqsUSL0PFO2ajpUhVLDKq1soU0A
         Q50f7SwQxk05Dj0Zrs/rnnSadGM1ek5F+Anq++6rBcFvac3DrN1HYQMh/XHoPLUc/fjE
         rtRdiKy06OIF9wbj5k6Ccnq5lUW5IUKEr1qqKTt51acpBSBjLdSd923ilT7o3LXhZEf/
         NmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=huIeRK2hnkcqpTrBB3HOk6wGMrQod9gweMsPasKdRY0=;
        b=D5yRG369bPaHP9pGsER1M0gzDmbZJToJaZEjWaQTU4x3h6/SqXNJwkQ3ofLUs+/7fV
         Vbx6RKrNrkzkWh4/6sAm+xbuhZ36T7/HsDjg3w2nTYODfK23qgjvr/TzU3qTSScT1TIJ
         50vOTycWj+hlmqnSp5TXc8pIkHF9dyJCM0PkhIgyrYOIHqW34OzT0BXV8Oe+PyOmLl4g
         dKRkN5W86tlzrEY3157mWQ7oKsQy4uF3yBnWVTHd1hlBiFtyicuMvRPUUwhxFFrUjfws
         vdcRI3SUKEZzqJ305m2d6UGUaMIkYqaNLWLg0SNTCTtmJRiPTMMEdkQSzbIiv66S3IuC
         wrzg==
X-Gm-Message-State: APjAAAVoDNFoQbj60XZsGWGVr9bKSqfH+gmdm6zyggOmJ9YQMKBl8zxt
        CDf8Dx2C/QUCmxGvQJdXTlY/kPBLE8UuggX7wPDwPz40QSUnwql8d6FoonxX64dqzjPrUdnStgW
        SSQ+y82RcYEdDn4jWgDFkcJTchOpYKTA6i7R/Z6SHX+zQgAKg9Hy5lFmTcqq3S0foA6A/1VsNUz
        ec
X-Google-Smtp-Source: APXvYqzVixZa3xCmOk0xYGf60V1bcGcm7q35G0+/FmtlanKDPWDILTGYYndrGDVd36Q6j2aUWocPVbnbNDbNSayPCyhO
X-Received: by 2002:a25:26c9:: with SMTP id m192mr13332454ybm.44.1566426013050;
 Wed, 21 Aug 2019 15:20:13 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:20:08 -0700
Message-Id: <cover.1566425828.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 0/2] Skip ls-refs if possible for HTTP
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was discovered by one of my colleagues when using a partial clone.
I thought I had resolved the problem with the commits mentioned in patch
1 (e70a3030e7 and ancestors), but apparently that is not the case (that
only worked for native protocols). So here is a fix for HTTP.

I'm not sure of the value of the test in patch 2, but that test does
fail if I don't update fetch_refs_from_bundle() to first call
get_refs_from_bundle() if it hasn't already been called.

Jonathan Tan (2):
  transport-helper: skip ls-refs if unnecessary
  transport: teach all vtables to allow fetch first

 t/t5607-clone-bundle.sh | 11 +++++++++++
 t/t5702-protocol-v2.sh  | 13 +++++++++++++
 transport-helper.c      | 38 ++++++++++++++++++++++++++++++++------
 transport-internal.h    |  6 ------
 transport.c             | 18 ++++++------------
 5 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

