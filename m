Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7881FADF
	for <e@80x24.org>; Tue,  1 May 2018 22:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEAWW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 18:22:29 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33136 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeEAWW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 18:22:28 -0400
Received: by mail-pf0-f171.google.com with SMTP id f20so1262865pfn.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SdJf5Q/fq29PK6x5v+Z/wk6hcDpn8oLwp/DCE/OuI9o=;
        b=Pk/YQ3v/qCd9n4qN1blfV27yL1G9kvL3RGcO2jyFtrx0aWlahqxQ0XVGkyUY8QieYO
         /VzcPvg2C9pGmJcJcI4ryNQVPeWvz3PFMRKvtaaFq3dwWnSEgxwPESfHKVu0+cVbpkVf
         Ncgndfr0i/SCwwvMsZLK9MzVw9Lk665GgEkYRffjk667xabAb1UbIp3zUArruNzC/1CA
         J+74bFxP1kqRBC15G1YZ8z3cqpT19EvWwdVF6RRmzOF8LUGmrzkfbfzgXF5nD76VjGAk
         EhszuW3f/QU8TkjPztc1kaNPO/J1PUDbeD60r6467kxRUvKhM4RZaOoWsDCd9r0zZ2eZ
         yHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SdJf5Q/fq29PK6x5v+Z/wk6hcDpn8oLwp/DCE/OuI9o=;
        b=tbASP/iKV8Tp7BwageqwCMjC7D04B7zV1La5WV530vCmAUpYzJXQHD+HXiIlYzgruk
         N8CyJ+Ju+Hzb3zMEAnUyHQYuklwZzp3sGMAxaT4wTa6wC+tXKg7iOsR209LTXRA0mUYt
         fIlWkkjmyIaUvk0MzGQuZQ4QW3btRNaEL8U1K/b/Q9SHr7O8dsBwA+5RNgZqskDLEwLp
         yQcbqrZ0LRVyaHZuWlCBc6veTod0eRPo+xFpSARJU77eBdOCQFC0MZ/gTM6yO/pcPlik
         7AaLcU0nsFsstFXSVTenqEZ6iSRIrtNQgwoQhuI5VcagRJlrfoRkeJ9YpNAjqDw3LM1x
         mGPw==
X-Gm-Message-State: ALQs6tBcZ79ZnbaaL+FB9KxZoRUc14na20hm3vcRFnXRkpZPMmUqXG58
        4s6/HCjm9g+PQ7LwTVK0lAN1r0+K9To=
X-Google-Smtp-Source: AB8JxZrw8qnb+diWsKlpMERYTmGHZvNiDPPTsY8HlouwDkbiHfHifrJMAFgK6s51k/OT+8wItGNzUQ==
X-Received: by 2002:a63:7e4e:: with SMTP id o14-v6mr14036016pgn.18.1525213347592;
        Tue, 01 May 2018 15:22:27 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u72-v6sm17192975pgb.16.2018.05.01.15.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 15:22:26 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/2] Supporting partial clones in protocol v2
Date:   Tue,  1 May 2018 15:22:19 -0700
Message-Id: <cover.1525213052.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set is built on "next". (I had to build it on "next" because
bw/protocol-v2 is built on v2.16, which does not have support for
partial clones.)

Partial clones and protocol v2 were built independently, so here is a
patch to support partial clones in protocol v2.

One thing I am a little unhappy about is the fact that the upload-pack
config has to be read in multiple places, but perhaps there is no choice
about that.

Jonathan Tan (2):
  upload-pack: fix error message typo
  {fetch,upload}-pack: support filter in protocol v2

 Documentation/technical/protocol-v2.txt |  9 +++
 fetch-pack.c                            | 23 +++++-
 t/t5701-git-serve.sh                    | 15 ++++
 t/t5702-protocol-v2.sh                  | 97 +++++++++++++++++++++++++
 upload-pack.c                           | 14 +++-
 5 files changed, 151 insertions(+), 7 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

