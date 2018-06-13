Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BA01F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935789AbeFMVjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:31 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:43480 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935384AbeFMVja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:30 -0400
Received: by mail-qt0-f202.google.com with SMTP id j2-v6so2964438qtn.10
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VPaYCEYJ8xZxv82XqcU1atuW3me+ABUQrkEY6IiA+FY=;
        b=mLhJ8TjjN/aB0xHT998+MCKK99UVxzFAirITh8MDbfoB5RJx3t4SYJDEW6bJYm+eQF
         1eVkS/hbczcERscIpH4b5AN90xV4iA04ELVs1Hl4OSGVXGT6QiOm64WKRaXCkUDUnyGk
         aqHRGwpXu62dBM9vm6lN9o4tfhuiqimK9Tk3sy8e2nzhtLB2u8pYW80Xq8JDe2VCgpO1
         1btZbNIwHYBTkG+CraEpnCPb1nXAxzZ0tHXXhzA21gjl6cJALkYul0AlLsu1XJKw3qFR
         +lO5wSkJWCc16isDWlQSDNP7chFmRS6fhEUam1dMnbfxH7zPRqCRvuDPnAgcl4JYuKLE
         pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VPaYCEYJ8xZxv82XqcU1atuW3me+ABUQrkEY6IiA+FY=;
        b=A+ZDS7Vea3Xs/1UV4z5eN/rZLKKG2TbQtd+FCBvHWk9wDbwRz6IN/oWxJanNIuoiJh
         orJ1yAv3Z+qJVHMnpZOk/4WtIAc0mcjLgZzAaUfVaIZuaPS4dI5/ftTOO33eSkH0ZoWW
         tqLMFOy9Uoxxh27tW0Cy1xRUCs3lSCdy2vnJVRBqwk0T/qCasVMrTpN8qqKDF+FquogX
         p4zlZmy/iiMf2oiH2k79VDNbLtVVbIpWybU49YCpNy/KVS9mpxe0lmkPOchCyA3R73EA
         xYho5LyVLqza3URXEuOWFRG0oz2orWqRrwsAxrQmzSRi+0iqGZnkXJ3FKP1VQH7Oc1P4
         mxPw==
X-Gm-Message-State: APt69E2pxAL43LUirNr4aTrrfXRy2WpTBqhgu7ctKryUpI/tMn6d5iTX
        VgVM1A8WA7ym5end9vg+goIcpuRljccTKp53u4W0Eo3jAU3A8zTe8EJV7o8b8l5M/4xzSxJSOzR
        y5lxiFBp/rQaf4LUd2ojFkMVEhxRM/MxAZuklwZdr9fngIq23nFpji3sjsA==
X-Google-Smtp-Source: ADUXVKI2A0XKkW7vAVIrk7aJRVYrLUZpFrpagMdfn0/0zoNEB4URgyZdY2dTQEn0ozhdmGiDCgWWKHO6wtk=
MIME-Version: 1.0
X-Received: by 2002:a0c:d2a2:: with SMTP id q31-v6mr3348373qvh.45.1528925969336;
 Wed, 13 Jun 2018 14:39:29 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:17 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180613213925.10560-1-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
* issuing a want-ref line to a ref which doesn't exist is just ignored.
* fixed some typos 

Brandon Williams (8):
  test-pkt-line: add unpack-sideband subcommand
  upload-pack: implement ref-in-want
  upload-pack: test negotiation with changing repository
  fetch: refactor the population of peer ref OIDs
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in output parameter
  fetch-pack: implement ref-in-want

 Documentation/config.txt                |   7 +
 Documentation/technical/protocol-v2.txt |  29 ++-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 126 +++++++-----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  52 +++--
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  37 ++++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/one-time-sed.sh             |  16 ++
 t/t5703-upload-pack-ref-in-want.sh      | 245 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 +++-
 transport.h                             |   3 +-
 upload-pack.c                           |  64 +++++++
 18 files changed, 568 insertions(+), 77 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.18.0.rc1.242.g61856ae69a-goog

